Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E77246B831
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 10:57:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234519AbhLGKAl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 05:00:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbhLGKAk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 05:00:40 -0500
Received: from lb2-smtp-cloud8.xs4all.net (lb2-smtp-cloud8.xs4all.net [IPv6:2001:888:0:108::2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93FB1C061574;
        Tue,  7 Dec 2021 01:57:10 -0800 (PST)
Received: from cust-b5b5937f ([IPv6:fc0c:c16d:66b8:757f:c639:739b:9d66:799d])
        by smtp-cloud8.xs4all.net with ESMTPA
        id uXDdmxxFqQyExuXDgm6NZz; Tue, 07 Dec 2021 10:57:08 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xs4all.nl; s=s2;
        t=1638871028; bh=oMp3b/u+mcsIZZGPY7rdaArm/tWPTEgWdM8+02wVEhQ=;
        h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type:From:
         Subject;
        b=oh3jSpv2rx85pLF7kXEixx/MS44+XC+l6MmdYH+r8x+5a6mVOzoREZ0pPXf3YtzGy
         42Q7TQO4WFbVQOTCehL1H3Gj7nQ2wAEZXQBkX5wSYHz03TUVfkU6DwuNtgmqT5Zoe7
         e+BxlBvfSFPFG4qa+T+SfA2rjWbSq57ueHNcHr+O5KaCoVdrp04w85gi01kSdFnuzi
         syjwVw5oc//AaAPZPGKEp3NccR+EU6GqSZth4NyQKTZaYgFWw1I4uGzrhddIUMONr5
         +Ma0Zu/5r/y2BfYcPawRl6DDNVhYscZxn7AcQgYqAOREy7APxy8ZbPbXP6aiR7kdcZ
         1Xyg3/cF1q/sQ==
Message-ID: <a1c9639e-c6e1-b05a-e24c-f02ddad167ca@xs4all.nl>
Date:   Tue, 7 Dec 2021 10:57:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.3.2
Subject: Re: [PATCH v2 4/4] media: uvcvideo: Set unique entity name based in
 type
Content-Language: en-US
To:     Ricardo Ribalda <ribalda@chromium.org>,
        Nicolas Dufresne <nicolas@ndufresne.ca>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        tfiga@chromium.org
References: <20211207003840.1212374-1-ribalda@chromium.org>
 <20211207003840.1212374-5-ribalda@chromium.org>
From:   Hans Verkuil <hverkuil-cisco@xs4all.nl>
In-Reply-To: <20211207003840.1212374-5-ribalda@chromium.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfFuFWGvd/+AsLMM8L9y1F6NlOOoDZ0g5MFtX87zw6GL4lipE2CFW/H4l6I0YqlQjPMruR23DsBL4bbwtyxJXywyRBsUiZL8I72bOJbep3ib/GdnXNVym
 4Gf7MuFn5WwZ3LLAqRpxqHtOX8yVfxu6TR7n3Gt8btM2Ht7yG20d0a2eFT94NiKqasjKgwjbX3MSVeZsyR5O3oG70HxpWb4h2fml5qpdNYnarqv2RHRiDCKu
 meO5biOhLRJYU+jLo0f5/Hixcod0B30HDbpsjWB5SFBnG8QsLXjVfb/ikZ8ufrlpomByhQYhf2PdJEx3uV0VOAgU0umG3+N1ymySJBtsaiZ8SaudbIbG6Igw
 QRBdHA0Mfn5sAk7h+DjCNLSQdjzFLcLkEpFF7aFBBE8fgCfq++jLYcFFz9dvAqoH9UDe8HKxxsV7pyn/IqKfjARSybKi78HdYeG5YolS58NITrc2mp8=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/12/2021 01:38, Ricardo Ribalda wrote:
> All the entities must have a unique name. We can have a descriptive and
> unique name by appending the function to their terminal link.
> 
> This is even resilient to multi chain devices.
> 
> Fixes v4l2-compliance:
> Media Controller ioctls:
>      fail: v4l2-test-media.cpp(205): v2_entity_names_set.find(key) != v2_entity_names_set.end()
>    test MEDIA_IOC_G_TOPOLOGY: FAIL
>      fail: v4l2-test-media.cpp(394): num_data_links != num_links
>    test MEDIA_IOC_ENUM_ENTITIES/LINKS: FAIL
> 
> Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>

Reviewed-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>

Thanks!

	Hans

> ---
>  drivers/media/usb/uvc/uvc_driver.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/drivers/media/usb/uvc/uvc_driver.c b/drivers/media/usb/uvc/uvc_driver.c
> index 058d28a0344b..8efbde981480 100644
> --- a/drivers/media/usb/uvc/uvc_driver.c
> +++ b/drivers/media/usb/uvc/uvc_driver.c
> @@ -2193,6 +2193,7 @@ int uvc_register_video_device(struct uvc_device *dev,
>  			      const struct v4l2_file_operations *fops,
>  			      const struct v4l2_ioctl_ops *ioctl_ops)
>  {
> +	const char __maybe_unused *name;
>  	int ret;
>  
>  	/* Initialize the video buffers queue. */
> @@ -2221,17 +2222,29 @@ int uvc_register_video_device(struct uvc_device *dev,
>  	case V4L2_BUF_TYPE_VIDEO_CAPTURE:
>  	default:
>  		vdev->device_caps = V4L2_CAP_VIDEO_CAPTURE | V4L2_CAP_STREAMING;
> +		name = "Video Capture";
>  		break;
>  	case V4L2_BUF_TYPE_VIDEO_OUTPUT:
>  		vdev->device_caps = V4L2_CAP_VIDEO_OUTPUT | V4L2_CAP_STREAMING;
> +		name = "Video Output";
>  		break;
>  	case V4L2_BUF_TYPE_META_CAPTURE:
>  		vdev->device_caps = V4L2_CAP_META_CAPTURE | V4L2_CAP_STREAMING;
> +		name = "Metadata";
>  		break;
>  	}
>  
> +	/*
> +	 * Many userspace applications identify the device with vdev->name, so
> +	 * we cannot change its name for its function.
> +	 */
>  	strscpy(vdev->name, dev->name, sizeof(vdev->name));
>  
> +#if defined(CONFIG_MEDIA_CONTROLLER)
> +	vdev->entity.name = devm_kasprintf(&stream->intf->dev, GFP_KERNEL,
> +				"%s %u", name, stream->header.bTerminalLink);
> +#endif
> +
>  	/*
>  	 * Set the driver data before calling video_register_device, otherwise
>  	 * the file open() handler might race us.
> 

