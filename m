Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D583E4D709D
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Mar 2022 20:50:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232533AbiCLTv5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Mar 2022 14:51:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229908AbiCLTv4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Mar 2022 14:51:56 -0500
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E384673DF;
        Sat, 12 Mar 2022 11:50:41 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id n19so20597445lfh.8;
        Sat, 12 Mar 2022 11:50:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=1xX6m7maqJLmZyW32NaxaiPZ6O1tqNAYkIzpjmsF0pc=;
        b=mEdLC06RPfSimrlPnyEi8F6/dnUwF03x4mlJeXaB3HvVJSRdTAFFPvz1uOGf4p/iJn
         MNRFyuyNaFMZrLbyWShFqnyP8OX3r1p4LNM5Sy2yn1o77Z+g9XB9F6XEi0mt8p2RUxkx
         VP+Q8G16+Gn5DSU/LaXXwua7bZZ5T1k4hJWxRsX6ctB35psDihocwnJyUkAhoNmGI0we
         4evuu4m8fYUxncUxm5/MEdMo+kEFxNmKL9Ii/gVvES8YmbAkpwDuCYtsxjIXM01nGxqH
         2BNd0948eri3pen151EMR6djSkXb+MEXmo3Fy7/c+wwk6msUAOR1iJCZjhkpvQ1dH0Vs
         Gu2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=1xX6m7maqJLmZyW32NaxaiPZ6O1tqNAYkIzpjmsF0pc=;
        b=4AuTfqVppg1aELvjkAciIHwEUj9Q0m8+rN68x0fB4UEhfoUdwD4mirHlj1haFEatLx
         z1eLS+n+eHx8O/X3Uw/k8a68SvkIy8iHtV2znWBgMolaMZuVTMZt0uwWJG1XmONIAN4s
         51Z5y5SP608/j9iIt/gzaK1eN4wxBwajqlG2nu32gF0WR6CJlS9hFmEoJGf4f/ex8Azs
         me2YL+6Xt8dnDyDzOWjOwclLvP7OmqIwuCtDZdckwoFrHJ/82302ewbSR+Wtr6bPMIMH
         YNxezYN7I/mObOfYzlDsOufFxtVGZEkG9kjHodRv1mDKw0rnSsoMGEhxSSCtu08Gxmob
         CM7w==
X-Gm-Message-State: AOAM531IVNSRhVGCwb4wIn/aimy13XC8+O4ePbhpLxBZ7LXDLBFev+bX
        klM77I6cCtAY76vtbMmTNqI=
X-Google-Smtp-Source: ABdhPJwQrfzNAkNevM1aTBhIdkJxxGjA0G/4a8DKixMDa24Qj1wyzaJLb952CvIJwltnsxGiDKhUAg==
X-Received: by 2002:a05:6512:1105:b0:448:8f4e:d5d0 with SMTP id l5-20020a056512110500b004488f4ed5d0mr317084lfg.182.1647114639435;
        Sat, 12 Mar 2022 11:50:39 -0800 (PST)
Received: from [192.168.1.11] ([94.103.229.107])
        by smtp.gmail.com with ESMTPSA id p12-20020a056512138c00b0044833f1cd85sm2342644lfa.62.2022.03.12.11.50.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 12 Mar 2022 11:50:38 -0800 (PST)
Message-ID: <11fa30cb-9b56-ab8c-1352-279052945432@gmail.com>
Date:   Sat, 12 Mar 2022 22:50:37 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH] media: stkwebcam: move stk_camera_read_reg() scratch
 buffer to struct stk_camera
Content-Language: en-US
To:     trix@redhat.com, mchehab@kernel.org, hverkuil-cisco@xs4all.nl,
        cai.huoqing@linux.dev, xose.vazquez@gmail.com
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220312173049.1410977-1-trix@redhat.com>
From:   Pavel Skripkin <paskripkin@gmail.com>
In-Reply-To: <20220312173049.1410977-1-trix@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Trix,

On 3/12/22 20:30, trix@redhat.com wrote:
> From: Tom Rix <trix@redhat.com>
> 
> In stk_camera_read_reg() a single byte buffer is alloc-ed and
> freed on every function call.  Since the size is known,
> move the buffer to the struct stk_camera where it will be alloc-ed
> and freed once.
> 
> Signed-off-by: Tom Rix <trix@redhat.com>
> ---
>   drivers/media/usb/stkwebcam/stk-webcam.c | 11 ++---------
>   drivers/media/usb/stkwebcam/stk-webcam.h |  2 ++
>   2 files changed, 4 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/media/usb/stkwebcam/stk-webcam.c b/drivers/media/usb/stkwebcam/stk-webcam.c
> index 5b822214ccc5c..787edb3d47c23 100644
> --- a/drivers/media/usb/stkwebcam/stk-webcam.c
> +++ b/drivers/media/usb/stkwebcam/stk-webcam.c
> @@ -150,25 +150,18 @@ int stk_camera_write_reg(struct stk_camera *dev, u16 index, u8 value)
>   int stk_camera_read_reg(struct stk_camera *dev, u16 index, u8 *value)
>   {
>   	struct usb_device *udev = dev->udev;
> -	unsigned char *buf;
>   	int ret;
>   
> -	buf = kmalloc(sizeof(u8), GFP_KERNEL);
> -	if (!buf)
> -		return -ENOMEM;
> -
>   	ret = usb_control_msg(udev, usb_rcvctrlpipe(udev, 0),
>   			0x00,
>   			USB_DIR_IN | USB_TYPE_VENDOR | USB_RECIP_DEVICE,
>   			0x00,
>   			index,
> -			buf,
> +			&dev->read_reg_scratch,
>   			sizeof(u8),
>   			500);


Wouldn't it be better to move to modern USB API like usb_control_msg_recv()?

This API does not require buffer to be allocated via kmalloc(), so you 
will be able to use value directly.




With regards,
Pavel Skripkin
