Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 410AF51114D
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 08:38:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358197AbiD0GlX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 02:41:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229945AbiD0GlW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 02:41:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D13CB10FF12;
        Tue, 26 Apr 2022 23:38:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5C97E618F6;
        Wed, 27 Apr 2022 06:38:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94C6EC385A7;
        Wed, 27 Apr 2022 06:38:08 +0000 (UTC)
Message-ID: <3cdf47f5-ad38-44ca-1720-d70a96432045@xs4all.nl>
Date:   Wed, 27 Apr 2022 08:38:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] media: amphion: ensure the buffer count is not less than
 min_buffer
Content-Language: en-US
To:     Ming Qian <ming.qian@nxp.com>, mchehab@kernel.org,
        shawnguo@kernel.org
Cc:     robh+dt@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, aisheng.dong@nxp.com,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20220322082859.9834-1-ming.qian@nxp.com>
From:   Hans Verkuil <hverkuil-cisco@xs4all.nl>
In-Reply-To: <20220322082859.9834-1-ming.qian@nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.5 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ming Qian,

On 22/03/2022 09:28, Ming Qian wrote:
> the output buffer count should >= min_buffer_out
> the capture buffer count should >= min_buffer_cap
> 
> Signed-off-by: Ming Qian <ming.qian@nxp.com>
> ---
>  drivers/media/platform/amphion/vpu_v4l2.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/media/platform/amphion/vpu_v4l2.c b/drivers/media/platform/amphion/vpu_v4l2.c
> index cbf3315605a9..72a0544f4da3 100644
> --- a/drivers/media/platform/amphion/vpu_v4l2.c
> +++ b/drivers/media/platform/amphion/vpu_v4l2.c
> @@ -355,6 +355,10 @@ static int vpu_vb2_queue_setup(struct vb2_queue *vq,
>  		return 0;
>  	}
>  
> +	if (V4L2_TYPE_IS_OUTPUT(vq->type))
> +		*buf_count = max_t(unsigned int, *buf_count, inst->min_buffer_out);
> +	else
> +		*buf_count = max_t(unsigned int, *buf_count, inst->min_buffer_cap);

I noticed that min_buffer_out/cap is set to 2, but min_buffers_needed
is set to 1. Wouldn't it make more sense to set min_buffers_needed to
2 as well?

If you do that, then the vb2 core will already take care of ensuring that
the buf_count is adjusted.

If you *do* have to do this manually, then you need to place the whole
if-else under 'if (!*num_planes) {', otherwise it will mess up the
VIDIOC_CREATE_BUFS ioctl. See the queue_setup in include/media/videobuf2-core.h
documentation for the sordid details.

Regards,

	Hans

>  	*plane_count = cur_fmt->num_planes;
>  	for (i = 0; i < cur_fmt->num_planes; i++)
>  		psize[i] = cur_fmt->sizeimage[i];

