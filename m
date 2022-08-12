Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F07845910BF
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 14:26:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238525AbiHLM0G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Aug 2022 08:26:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238445AbiHLMZr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 08:25:47 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 679446B15F
        for <linux-kernel@vger.kernel.org>; Fri, 12 Aug 2022 05:25:45 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id r4so1128514edi.8
        for <linux-kernel@vger.kernel.org>; Fri, 12 Aug 2022 05:25:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=hoPdeb8OdFXqd1Rv3siD9/ni79oI0Ebkx5U/fkexjYo=;
        b=VXLIxL00R6mE0dHpqUOlVOQPOSrutRURGF0ISBuM1gReVDR8t0x0QpoQkyTy3zJpcw
         1rlXK7sLtVtIT+IwtH3MPhJa8sED+U4aIeIGsM80W8/Sm408vLj9OGnj8J2FcfNDHCEJ
         gssjkuUYt5loxmQloVx8PA1tVU7kVCueLPai4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=hoPdeb8OdFXqd1Rv3siD9/ni79oI0Ebkx5U/fkexjYo=;
        b=Tu1g5g3ZFuDMWlSLkzyu+UxevUYlsFq2vIo2gAdeC+EZtmsaQuDE6itG99t5uNrHdB
         SA4eYR7/hrzNUZ5ECj9MquYKblcSJ3p71HiMRe9pX+Sv470KlyRHiiqNYEgh5lo0Ndah
         P/Ikx1vjdHJIxkvvjnqpvQrqealSemzw747uKRUAJsjkpnkO3ccnTQJANAbSv4oe4N2W
         ydEPO/BMH2inwYMTfTlQZQPahjdEUXHaFqJPQeyUVqEm/wE4uEEfxLoIn3tilKpOnMjh
         iClLRH7rHe8NTK6LxZ44RnNHo1fFo7v2pzktWfomOdJf9U4yjc8+QJMbsrZTqYV7KsL7
         s3/A==
X-Gm-Message-State: ACgBeo3eAEE1wB/DYG/zAR1i3obxz94fFPwdMBvl4sbPgIb1ZXzh2fAz
        CDWniGRwd/mUM9InpvOjT9c4P6Ovsf4MoQ==
X-Google-Smtp-Source: AA6agR68jktJbOTFyVnXcN1LUGUp4uxCQxgM6Km7cX5wS9L3XBvkG3onitbvHAqtxxb2Ff3wuiDCYQ==
X-Received: by 2002:a05:6402:3552:b0:43d:a634:3997 with SMTP id f18-20020a056402355200b0043da6343997mr3322591edd.389.1660307143922;
        Fri, 12 Aug 2022 05:25:43 -0700 (PDT)
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com. [209.85.218.45])
        by smtp.gmail.com with ESMTPSA id e8-20020a170906080800b007309d640484sm738182ejd.91.2022.08.12.05.25.42
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Aug 2022 05:25:42 -0700 (PDT)
Received: by mail-ej1-f45.google.com with SMTP id kb8so1766846ejc.4
        for <linux-kernel@vger.kernel.org>; Fri, 12 Aug 2022 05:25:42 -0700 (PDT)
X-Received: by 2002:a17:906:9f2a:b0:730:bc30:da30 with SMTP id
 fy42-20020a1709069f2a00b00730bc30da30mr2556056ejc.763.1660307142238; Fri, 12
 Aug 2022 05:25:42 -0700 (PDT)
MIME-Version: 1.0
References: <20220812121202.1971-1-huanglei@kylinos.cn>
In-Reply-To: <20220812121202.1971-1-huanglei@kylinos.cn>
From:   Ricardo Ribalda <ribalda@chromium.org>
Date:   Fri, 12 Aug 2022 14:25:31 +0200
X-Gmail-Original-Message-ID: <CANiDSCu_RMx6mA54uUxsbF+oLw9PsWhrSR4U-dHASqPwnwB-3Q@mail.gmail.com>
Message-ID: <CANiDSCu_RMx6mA54uUxsbF+oLw9PsWhrSR4U-dHASqPwnwB-3Q@mail.gmail.com>
Subject: Re: [PATCH] media: uvcvideo: limit power line control for Sonix Technology
To:     huanglei <huanglei@kylinos.cn>
Cc:     laurent.pinchart@ideasonboard.com, mchehab@kernel.org,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi huanglei

Thanks for your patch

Don't you have to add a field:

.driver_info = (kernel_ulong_t)&uvc_ctrl_power_line_limited },

to your quirk?


Regards!

On Fri, 12 Aug 2022 at 14:16, huanglei <huanglei@kylinos.cn> wrote:
>
> The device does not implement the power line control correctly. Add a
> corresponding control mapping override.
>
> Bus 003 Device 003: ID 3277:0072 Sonix Technology Co., Ltd. USB 2.0 Camera
> Device Descriptor:
>   bLength                18
>   bDescriptorType         1
>   bcdUSB               2.00
>   bDeviceClass          239 Miscellaneous Device
>   bDeviceSubClass         2
>   bDeviceProtocol         1 Interface Association
>   bMaxPacketSize0        64
>   idVendor           0x3277
>   idProduct          0x0072
>   bcdDevice            1.00
>   iManufacturer           2 Sonix Technology Co., Ltd.
>   iProduct                1 USB 2.0 Camera
>   iSerial                 3 REV0001
>   bNumConfigurations      1
>
> Signed-off-by: huanglei <huanglei@kylinos.cn>
> ---
>  drivers/media/usb/uvc/uvc_driver.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/drivers/media/usb/uvc/uvc_driver.c b/drivers/media/usb/uvc/uvc_driver.c
> index 9c05776f11d1..48f4d755a584 100644
> --- a/drivers/media/usb/uvc/uvc_driver.c
> +++ b/drivers/media/usb/uvc/uvc_driver.c
> @@ -3282,6 +3282,14 @@ static const struct usb_device_id uvc_ids[] = {
>           .bInterfaceSubClass   = 1,
>           .bInterfaceProtocol   = 0,
>           .driver_info          = UVC_INFO_META(V4L2_META_FMT_D4XX) },
> +       /* Sonix Technology USB 2.0 Camera */
> +       { .match_flags          = USB_DEVICE_ID_MATCH_DEVICE
> +                               | USB_DEVICE_ID_MATCH_INT_INFO,
> +         .idVendor             = 0x3277,
> +         .idProduct            = 0x0072,
> +         .bInterfaceClass      = USB_CLASS_VENDOR_SPEC,
> +         .bInterfaceSubClass   = 1,
> +         .bInterfaceProtocol   = 0 },
>         /* Generic USB Video Class */
>         { USB_INTERFACE_INFO(USB_CLASS_VIDEO, 1, UVC_PC_PROTOCOL_UNDEFINED) },
>         { USB_INTERFACE_INFO(USB_CLASS_VIDEO, 1, UVC_PC_PROTOCOL_15) },
> --
> 2.17.1
>
>
> No virus found
>                 Checked by Hillstone Network AntiVirus



-- 
Ricardo Ribalda
