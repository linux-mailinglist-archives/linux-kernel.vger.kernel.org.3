Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98363511098
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 07:39:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357895AbiD0FmC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 01:42:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232148AbiD0FmB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 01:42:01 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 080F514DE8F;
        Tue, 26 Apr 2022 22:38:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BE456B824E6;
        Wed, 27 Apr 2022 05:38:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39A00C385A9;
        Wed, 27 Apr 2022 05:38:47 +0000 (UTC)
Message-ID: <8cab70e2-cd3f-da75-9e6a-1d63e33e6e24@xs4all.nl>
Date:   Wed, 27 Apr 2022 07:38:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] media: stkwebcam: move stk_camera_read_reg() scratch
 buffer to struct stk_camera
Content-Language: en-US
To:     trix@redhat.com, mchehab@kernel.org, cai.huoqing@linux.dev,
        paskripkin@gmail.com, xose.vazquez@gmail.com
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220312173049.1410977-1-trix@redhat.com>
From:   Hans Verkuil <hverkuil-cisco@xs4all.nl>
In-Reply-To: <20220312173049.1410977-1-trix@redhat.com>
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

Hi Tom,

On 12/03/2022 18:30, trix@redhat.com wrote:
> From: Tom Rix <trix@redhat.com>
> 
> In stk_camera_read_reg() a single byte buffer is alloc-ed and
> freed on every function call.  Since the size is known,
> move the buffer to the struct stk_camera where it will be alloc-ed
> and freed once.

I read the replies to this patch, but I am not certain if you still want
this patch to be merged, or will make a v2. I have no problem applying this
patch as-is, but I just want to have confirmation that there won't be a v2.

Regards,

	Hans

> 
> Signed-off-by: Tom Rix <trix@redhat.com>
> ---
>  drivers/media/usb/stkwebcam/stk-webcam.c | 11 ++---------
>  drivers/media/usb/stkwebcam/stk-webcam.h |  2 ++
>  2 files changed, 4 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/media/usb/stkwebcam/stk-webcam.c b/drivers/media/usb/stkwebcam/stk-webcam.c
> index 5b822214ccc5c..787edb3d47c23 100644
> --- a/drivers/media/usb/stkwebcam/stk-webcam.c
> +++ b/drivers/media/usb/stkwebcam/stk-webcam.c
> @@ -150,25 +150,18 @@ int stk_camera_write_reg(struct stk_camera *dev, u16 index, u8 value)
>  int stk_camera_read_reg(struct stk_camera *dev, u16 index, u8 *value)
>  {
>  	struct usb_device *udev = dev->udev;
> -	unsigned char *buf;
>  	int ret;
>  
> -	buf = kmalloc(sizeof(u8), GFP_KERNEL);
> -	if (!buf)
> -		return -ENOMEM;
> -
>  	ret = usb_control_msg(udev, usb_rcvctrlpipe(udev, 0),
>  			0x00,
>  			USB_DIR_IN | USB_TYPE_VENDOR | USB_RECIP_DEVICE,
>  			0x00,
>  			index,
> -			buf,
> +			&dev->read_reg_scratch,
>  			sizeof(u8),
>  			500);
>  	if (ret >= 0)
> -		*value = *buf;
> -
> -	kfree(buf);
> +		*value = dev->read_reg_scratch;
>  
>  	if (ret < 0)
>  		return ret;
> diff --git a/drivers/media/usb/stkwebcam/stk-webcam.h b/drivers/media/usb/stkwebcam/stk-webcam.h
> index 14519e5308b18..136decffe9ced 100644
> --- a/drivers/media/usb/stkwebcam/stk-webcam.h
> +++ b/drivers/media/usb/stkwebcam/stk-webcam.h
> @@ -105,6 +105,8 @@ struct stk_camera {
>  	struct list_head sio_avail;
>  	struct list_head sio_full;
>  	unsigned sequence;
> +
> +	u8 read_reg_scratch;
>  };
>  
>  #define vdev_to_camera(d) container_of(d, struct stk_camera, vdev)

