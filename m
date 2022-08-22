Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1862859BE6E
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 13:27:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234119AbiHVL1f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 07:27:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233777AbiHVL1d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 07:27:33 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1D2732EF7
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 04:27:31 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id gi31so14011845ejc.5
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 04:27:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc;
        bh=t3OYeX7kWxlsPaW3fbNLmb2bg7Gc/NegkzT2tgCob5U=;
        b=IuYlNN7SMdin+fNrslQw9uMzHff4olPykrSZXrZGD2lyoXboUGdqK71s3THD/kGhv4
         Q4PwwSmvsP1aUvLy5m+V+tdRx5HuxVf/P/L468MXXSV3ZgTh7tMIryEWHMgIU2hWvLjE
         tqEiE7syPpGT2ElVdBedG1m+FH7TieZi8KsJw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc;
        bh=t3OYeX7kWxlsPaW3fbNLmb2bg7Gc/NegkzT2tgCob5U=;
        b=RmchcjlYDspcWmYOdrd5QZvCDuTSq4lx5unH2GhQCIq5MAVZx+Gb3QdzE6wH1uOU1y
         N3nxUCH2FfLcZZpZmGj4xpn5tNh5kvvrDIm4NbG4GULm0Ak20JAvuOwMFvoRm01KtBNu
         EKXXt6ynfLb9iQjZvqmliYmaIFtvSOx1QyeIIvu+rhZe5wkSlmxDJjHdS5IELA/T94QY
         xEDdWl6GhEnICMoi6i9f08rEb5ZKv8AiMBulMS0LApZT3JejmDjwSJ79AljoLqpXgd/B
         665npcMc5vHhH4zUV7NnYr8dJxWK8Bs8ztrq0ijVmyorBgVeUq+ok/cEEafyjuIVpsSA
         iOQA==
X-Gm-Message-State: ACgBeo1UIVVzIZrTzt50cpa8nrccJMx0qHuWCIOad7WQWWTuPCYiCyWm
        c26IFgv87rAUmVLGQJog+L91YFqbLEmj1g==
X-Google-Smtp-Source: AA6agR47AZPI0oG6oH6DjrbsU2xLyLra67PGg4dCfjgefS7qv/wrFke1pdhd0WlIhUw1rZI56DhIdA==
X-Received: by 2002:a17:907:c0d:b0:730:a85d:8300 with SMTP id ga13-20020a1709070c0d00b00730a85d8300mr12327942ejc.558.1661167650400;
        Mon, 22 Aug 2022 04:27:30 -0700 (PDT)
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com. [209.85.208.42])
        by smtp.gmail.com with ESMTPSA id n2-20020a05640204c200b00445b822005dsm8122628edw.6.2022.08.22.04.27.29
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Aug 2022 04:27:29 -0700 (PDT)
Received: by mail-ed1-f42.google.com with SMTP id z20so13395894edb.9
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 04:27:29 -0700 (PDT)
X-Received: by 2002:a05:6402:3585:b0:446:9d7b:2e38 with SMTP id
 y5-20020a056402358500b004469d7b2e38mr5664787edc.248.1661167649019; Mon, 22
 Aug 2022 04:27:29 -0700 (PDT)
MIME-Version: 1.0
References: <20220808134106.70100-1-ribalda@chromium.org>
In-Reply-To: <20220808134106.70100-1-ribalda@chromium.org>
From:   Ricardo Ribalda <ribalda@chromium.org>
Date:   Mon, 22 Aug 2022 13:27:18 +0200
X-Gmail-Original-Message-ID: <CANiDSCtyWTUn2qOpFLR=694_GFKfmj-TfMNE-8n2zwm=6mGr9A@mail.gmail.com>
Message-ID: <CANiDSCtyWTUn2qOpFLR=694_GFKfmj-TfMNE-8n2zwm=6mGr9A@mail.gmail.com>
Subject: Re: [PATCH] media: uvcvideo: Fix InterfaceProtocol for Quanta camera
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

Friendly ping on text-mode with the correct account ;)

Regards!

On Mon, 8 Aug 2022 at 15:41, Ricardo Ribalda <ribalda@chromium.org> wrote:
>
> The device is using a different InterfaceProtocol than the one set in
> the original quirk.
>
> Fixes: 95f03d973478 ("media: uvcvideo: Limit power line control for Quanta cameras")
> Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> ---
>
> This was fixed on the last version of the patchset. Unfortunately I did
> checked that it was the version merged :(.
>
> It is too late to land it in this version?
>
>
>  drivers/media/usb/uvc/uvc_driver.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/media/usb/uvc/uvc_driver.c b/drivers/media/usb/uvc/uvc_driver.c
> index 9c05776f11d1..6556158a8888 100644
> --- a/drivers/media/usb/uvc/uvc_driver.c
> +++ b/drivers/media/usb/uvc/uvc_driver.c
> @@ -2740,7 +2740,7 @@ static const struct usb_device_id uvc_ids[] = {
>           .idProduct            = 0x4034,
>           .bInterfaceClass      = USB_CLASS_VIDEO,
>           .bInterfaceSubClass   = 1,
> -         .bInterfaceProtocol   = 0,
> +         .bInterfaceProtocol   = 1,
>           .driver_info          = (kernel_ulong_t)&uvc_ctrl_power_line_limited },
>         /* LogiLink Wireless Webcam */
>         { .match_flags          = USB_DEVICE_ID_MATCH_DEVICE
> --
> 2.37.1.559.g78731f0fdb-goog
>


-- 
Ricardo Ribalda
