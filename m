Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1A434B9EA0
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 12:32:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239768AbiBQLcp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 06:32:45 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:55176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234361AbiBQLcn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 06:32:43 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55D53139CC2;
        Thu, 17 Feb 2022 03:32:27 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8F1D4B82174;
        Thu, 17 Feb 2022 11:32:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9B4FC340E8;
        Thu, 17 Feb 2022 11:32:23 +0000 (UTC)
Message-ID: <6908801a-75ac-8845-dd0e-33cd59ceb42e@xs4all.nl>
Date:   Thu, 17 Feb 2022 12:32:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH] media: stm32-dcmi: create video dev once sensor is binded
Content-Language: en-US
To:     Alain Volmat <alain.volmat@foss.st.com>,
        hugues.fruchet@foss.st.com, mchehab@kernel.org
Cc:     mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
        linux-media@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20220127111802.976275-1-alain.volmat@foss.st.com>
From:   Hans Verkuil <hverkuil@xs4all.nl>
In-Reply-To: <20220127111802.976275-1-alain.volmat@foss.st.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alain,

Some comments below:

On 27/01/2022 12:18, Alain Volmat wrote:
> In case of an error during the initialization of the sensor,
> the video device is still available since created at the
> probe of the dcmi driver. Moreover the device wouldn't
> be released even when removing the module since the release
> is performed as part of the notifier unbind callback
> (not called if no sensor is properly initialized).
> 
> This patch move the video device creation with the v4l2 notifier
> complete handler in order to avoid having a video device created when
> an error happen during the pipe (dcmi - sensor) initialization.
> 
> This also makes the video device creation symmetric with the
> release which is already done within the notifier unbind handler.
> 
> Signed-off-by: Alain Volmat <alain.volmat@foss.st.com>
> ---
> v1: this patch is the replacement patch of a previous attempt [1]
> to move the register within the bound callback.
> 
> [1] https://lore.kernel.org/linux-media/31ca9ccc-77d4-4368-1024-db70e8e1e7f2@xs4all.nl/
>  drivers/media/platform/stm32/stm32-dcmi.c | 69 ++++++++++++-----------
>  1 file changed, 35 insertions(+), 34 deletions(-)
> 
> diff --git a/drivers/media/platform/stm32/stm32-dcmi.c b/drivers/media/platform/stm32/stm32-dcmi.c
> index e1b17c05229c..80d0fbeabb4f 100644
> --- a/drivers/media/platform/stm32/stm32-dcmi.c
> +++ b/drivers/media/platform/stm32/stm32-dcmi.c
> @@ -134,6 +134,7 @@ struct stm32_dcmi {
>  	struct video_device		*vdev;
>  	struct v4l2_async_notifier	notifier;
>  	struct v4l2_subdev		*source;
> +	struct v4l2_subdev		*remote;
>  	struct v4l2_format		fmt;
>  	struct v4l2_rect		crop;
>  	bool				do_crop;
> @@ -579,9 +580,9 @@ static void dcmi_buf_queue(struct vb2_buffer *vb)
>  	spin_unlock_irq(&dcmi->irqlock);
>  }
>  
> -static struct media_entity *dcmi_find_source(struct stm32_dcmi *dcmi)
> +static struct media_entity *dcmi_find_source(struct v4l2_subdev *subdev)
>  {
> -	struct media_entity *entity = &dcmi->vdev->entity;
> +	struct media_entity *entity = &subdev->entity;
>  	struct media_pad *pad;
>  
>  	/* Walk searching for entity having no sink */
> @@ -1721,6 +1722,7 @@ static int dcmi_framesizes_init(struct stm32_dcmi *dcmi)
>  static int dcmi_graph_notify_complete(struct v4l2_async_notifier *notifier)
>  {
>  	struct stm32_dcmi *dcmi = notifier_to_dcmi(notifier);
> +	int src_pad;
>  	int ret;
>  
>  	/*
> @@ -1728,7 +1730,7 @@ static int dcmi_graph_notify_complete(struct v4l2_async_notifier *notifier)
>  	 * we search for the source subdevice
>  	 * in order to expose it through V4L2 interface
>  	 */
> -	dcmi->source = media_entity_to_v4l2_subdev(dcmi_find_source(dcmi));
> +	dcmi->source = media_entity_to_v4l2_subdev(dcmi_find_source(dcmi->remote));
>  	if (!dcmi->source) {
>  		dev_err(dcmi->dev, "Source subdevice not found\n");
>  		return -ENODEV;
> @@ -1768,6 +1770,34 @@ static int dcmi_graph_notify_complete(struct v4l2_async_notifier *notifier)
>  		return ret;
>  	}
>  
> +	ret = video_register_device(dcmi->vdev, VFL_TYPE_VIDEO, -1);
> +	if (ret) {
> +		dev_err(dcmi->dev, "Failed to register video device\n");
> +		return ret;
> +	}

This is the right place, but it's not quite sufficient. You also need to allocate
the vdev here. I.e. move the whole allocation/initialization of vdev from probe()
to here.

If the vdev is allocated in probe(), and the subdev is never bound, then vdev is
never freed in the current code.

Regards,

	Hans

> +
> +	dev_dbg(dcmi->dev, "Device registered as %s\n",
> +		video_device_node_name(dcmi->vdev));
> +
> +	/*
> +	 * Link remote sub-device to DCMI, it could be
> +	 * a parallel camera sensor or a bridge
> +	 */
> +	src_pad = media_entity_get_fwnode_pad(&dcmi->remote->entity,
> +					      dcmi->remote->fwnode,
> +					      MEDIA_PAD_FL_SOURCE);
> +
> +	ret = media_create_pad_link(&dcmi->remote->entity, src_pad,
> +				    &dcmi->vdev->entity, 0,
> +				    MEDIA_LNK_FL_IMMUTABLE |
> +				    MEDIA_LNK_FL_ENABLED);
> +	if (ret)
> +		dev_err(dcmi->dev, "Failed to create media pad link with subdev \"%s\"\n",
> +			dcmi->remote->name);
> +	else
> +		dev_dbg(dcmi->dev, "DCMI is now linked to \"%s\"\n",
> +			dcmi->remote->name);
> +
>  	return 0;
>  }
>  
> @@ -1788,31 +1818,11 @@ static int dcmi_graph_notify_bound(struct v4l2_async_notifier *notifier,
>  				   struct v4l2_async_subdev *asd)
>  {
>  	struct stm32_dcmi *dcmi = notifier_to_dcmi(notifier);
> -	unsigned int ret;
> -	int src_pad;
>  
>  	dev_dbg(dcmi->dev, "Subdev \"%s\" bound\n", subdev->name);
> +	dcmi->remote = subdev;
>  
> -	/*
> -	 * Link this sub-device to DCMI, it could be
> -	 * a parallel camera sensor or a bridge
> -	 */
> -	src_pad = media_entity_get_fwnode_pad(&subdev->entity,
> -					      subdev->fwnode,
> -					      MEDIA_PAD_FL_SOURCE);
> -
> -	ret = media_create_pad_link(&subdev->entity, src_pad,
> -				    &dcmi->vdev->entity, 0,
> -				    MEDIA_LNK_FL_IMMUTABLE |
> -				    MEDIA_LNK_FL_ENABLED);
> -	if (ret)
> -		dev_err(dcmi->dev, "Failed to create media pad link with subdev \"%s\"\n",
> -			subdev->name);
> -	else
> -		dev_dbg(dcmi->dev, "DCMI is now linked to \"%s\"\n",
> -			subdev->name);
> -
> -	return ret;
> +	return 0;
>  }
>  
>  static const struct v4l2_async_notifier_operations dcmi_graph_notify_ops = {
> @@ -2008,15 +2018,6 @@ static int dcmi_probe(struct platform_device *pdev)
>  	}
>  	dcmi->vdev->entity.flags |= MEDIA_ENT_FL_DEFAULT;
>  
> -	ret = video_register_device(dcmi->vdev, VFL_TYPE_VIDEO, -1);
> -	if (ret) {
> -		dev_err(dcmi->dev, "Failed to register video device\n");
> -		goto err_media_entity_cleanup;
> -	}
> -
> -	dev_dbg(dcmi->dev, "Device registered as %s\n",
> -		video_device_node_name(dcmi->vdev));
> -
>  	/* Buffer queue */
>  	q->type = V4L2_BUF_TYPE_VIDEO_CAPTURE;
>  	q->io_modes = VB2_MMAP | VB2_READ | VB2_DMABUF;

