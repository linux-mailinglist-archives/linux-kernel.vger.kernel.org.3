Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CF604E679C
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 18:17:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352198AbiCXRTG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 13:19:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240788AbiCXRTE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 13:19:04 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BD5BB188E
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 10:17:32 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id r13so10527447ejd.5
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 10:17:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=x4vfCnzIPjyv57wSD3+oAjA+7hchoEnWIl5SY06Hv1o=;
        b=TFrPGx7n7uuJ9Ro2Mt6d3S5dk7HGfrXrptj+qZiNhrwZBrvEmM6e3wX2NxV4uJhyEU
         VwHUWpNMYACv8cJYGsCR4818P/h2PLLFw9iUCR7FUjyFDwWoxff9gPTC7AaQaJjeCQRn
         Zfzn+NGVqBluAy3ip8I6dCYjajGtxWh5nXZnQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=x4vfCnzIPjyv57wSD3+oAjA+7hchoEnWIl5SY06Hv1o=;
        b=MX3LGXNzaICIj/RXSBIsm+5aPdibtyMCqHbpqIxyD79y/o9ymgEr1kVfalp1ICABrw
         D5kdWVZjHcz5cyoa53THTdNeBiZfpeO2LEkehhvp8M74fh4/uY6fhBj82tHaWOOw0wOI
         jAtg6rKE8MmNt0SYcKNiawI3oVeF5tOAzXOOmxysVUkUn3Sux8EIZezEAh1tMaqNDn4S
         JCHz5MpaUUbU9btDtmwAAytfpG1hXMoxq7qRgbVgNffDQHsMxZ6P/cTRB9RFVvsxzcAu
         b7Cch36mJlNDyl2gv2fOkePwbPXEdEwM/bejUPqw8tpwyvt5n6Fgmw/7fcW+hQcBa+RZ
         JLYQ==
X-Gm-Message-State: AOAM531YyvGopYaCdiJ771oFxR6Y8Te87q2+XWNXobBm7bk+hoVcJ1tj
        7di84UFqf63C3Q1M89oR9ejAo6xJg6CrZQ==
X-Google-Smtp-Source: ABdhPJwL+8Jnwo0an+cC5Gyj+FCylxS1mYTahRHKgZ0+1Ir53j2gk9yPa9b7cn/rJL8Ioqi0pgLdBQ==
X-Received: by 2002:a17:906:36ce:b0:6d6:e540:ed65 with SMTP id b14-20020a17090636ce00b006d6e540ed65mr6845975ejc.330.1648142250722;
        Thu, 24 Mar 2022 10:17:30 -0700 (PDT)
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com. [209.85.218.46])
        by smtp.gmail.com with ESMTPSA id b15-20020a50cccf000000b0040f74c6abedsm1642412edj.77.2022.03.24.10.17.29
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Mar 2022 10:17:30 -0700 (PDT)
Received: by mail-ej1-f46.google.com with SMTP id p15so10521162ejc.7
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 10:17:29 -0700 (PDT)
X-Received: by 2002:a17:906:58d2:b0:6da:b635:fbf3 with SMTP id
 e18-20020a17090658d200b006dab635fbf3mr6658187ejs.40.1648142249489; Thu, 24
 Mar 2022 10:17:29 -0700 (PDT)
MIME-Version: 1.0
References: <20220324081718.41091-1-hbh25y@gmail.com>
In-Reply-To: <20220324081718.41091-1-hbh25y@gmail.com>
From:   Ricardo Ribalda <ribalda@chromium.org>
Date:   Thu, 24 Mar 2022 18:17:18 +0100
X-Gmail-Original-Message-ID: <CANiDSCvqQqOZ=uigeSz7ihe-y5XDLCRYD9+ZRULDE21td5rvEQ@mail.gmail.com>
Message-ID: <CANiDSCvqQqOZ=uigeSz7ihe-y5XDLCRYD9+ZRULDE21td5rvEQ@mail.gmail.com>
Subject: Re: [PATCH] media: uvc_v4l2: fix possible memory leak in uvc_ioctl_ctrl_map
To:     Hangyu Hua <hbh25y@gmail.com>
Cc:     laurent.pinchart@ideasonboard.com, mchehab@kernel.org,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Isnt it a dupe of:
https://patchwork.linuxtv.org/project/linux-media/patch/20211008120914.69175-1-ribalda@chromium.org/
?

On Thu, 24 Mar 2022 at 18:13, Hangyu Hua <hbh25y@gmail.com> wrote:
>
> map->name needs to be freed when uvc_ioctl_ctrl_map fails.
>
> Signed-off-by: Hangyu Hua <hbh25y@gmail.com>
> ---
>  drivers/media/usb/uvc/uvc_v4l2.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/media/usb/uvc/uvc_v4l2.c b/drivers/media/usb/uvc/uvc_v4l2.c
> index 711556d13d03..e46a2f3b06cb 100644
> --- a/drivers/media/usb/uvc/uvc_v4l2.c
> +++ b/drivers/media/usb/uvc/uvc_v4l2.c
> @@ -93,6 +93,7 @@ static int uvc_ioctl_ctrl_map(struct uvc_video_chain *chain,
>
>         kfree(map->menu_info);
>  free_map:
> +       kfree(map->name);
>         kfree(map);
>
>         return ret;
> --
> 2.25.1
>


-- 
Ricardo Ribalda
