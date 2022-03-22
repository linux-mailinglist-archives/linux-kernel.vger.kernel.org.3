Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A3544E3E9F
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 13:40:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234967AbiCVMlz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 08:41:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234950AbiCVMlu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 08:41:50 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6978B8595E
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 05:40:22 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id t1so21505537edc.3
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 05:40:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tk8Q45bHdMaMc+x2KQVChxZKg3UtMeERg8aZSfVpGWs=;
        b=n+Jdd22Bgq7ATlyt//him6vooPJEpd4htrk1OZIwiw2JVaiKk8V+WCwXRW7V5V4z65
         tpbzrqzXeyog8R4QOUDX/k0uxiqfGqZTtcFUftxcKTov0IMAQ2slOgLGqfZUl/QHFjLf
         MqZNnGCarzMQnxd6s5HmAZoFnxcI8z7fB1kKw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tk8Q45bHdMaMc+x2KQVChxZKg3UtMeERg8aZSfVpGWs=;
        b=DgNnW47SeYNCPkZyW5deIP/G+tzTA+Uz7nWWpfCzlfgIqVpvOBQCblVEk7CmWumukX
         E03Hc5SBj09rSjeOJncH7diQ5vZK5DStTmd8nwFaEExUq8i8QcRwSYKbPIUL0iEBAvge
         DJvE5OtufJz/2ZHD/CCCdtBpjbRr5liahvjut/HgXkJsPNdns9pEUb6pY8Xlh8WADpKy
         hGzuW8/YG3p4MyCetXDvJfhhvGHZbTjGsljNkQae/IJsR7iyhi+vQxe6UP5bsqeAQE1m
         gslngutmDCZPx40f4175+thJyvQJ6GFn4IJP9GfDsnXHgeGJApVxZstfIzJQ7e4Dd0TO
         9PbQ==
X-Gm-Message-State: AOAM533y4ngHhgr0IK3Rg615QLKaNj1sMf8Sx9Sc4ZlPCfPxdYAmtsUP
        5EaliLb2iBZj3cJ09Da2KnbXlVjM1Upn2w==
X-Google-Smtp-Source: ABdhPJyTaeW4+6Yz82cNbOgfN7dNhVdzaLnDn0MeAzoGvU082qZvbAL6BBqNtOKtmMKUtYBbUgs7Og==
X-Received: by 2002:a05:6402:1112:b0:413:3d99:f2d7 with SMTP id u18-20020a056402111200b004133d99f2d7mr28484155edv.23.1647952820765;
        Tue, 22 Mar 2022 05:40:20 -0700 (PDT)
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com. [209.85.218.50])
        by smtp.gmail.com with ESMTPSA id r14-20020a05640251ce00b004186b7c1268sm9510291edd.50.2022.03.22.05.40.19
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Mar 2022 05:40:19 -0700 (PDT)
Received: by mail-ej1-f50.google.com with SMTP id a8so35897326ejc.8
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 05:40:19 -0700 (PDT)
X-Received: by 2002:a17:906:dc81:b0:6df:87eb:8340 with SMTP id
 cs1-20020a170906dc8100b006df87eb8340mr25709118ejc.435.1647952819044; Tue, 22
 Mar 2022 05:40:19 -0700 (PDT)
MIME-Version: 1.0
References: <20220319102222.3079-1-xiam0nd.tong@gmail.com>
In-Reply-To: <20220319102222.3079-1-xiam0nd.tong@gmail.com>
From:   Ricardo Ribalda <ribalda@chromium.org>
Date:   Tue, 22 Mar 2022 13:40:07 +0100
X-Gmail-Original-Message-ID: <CANiDSCugwwNc8HjqNX2Mp8GdFN0s=jgPkT_2d4kiVygp=XZa4w@mail.gmail.com>
Message-ID: <CANiDSCugwwNc8HjqNX2Mp8GdFN0s=jgPkT_2d4kiVygp=XZa4w@mail.gmail.com>
Subject: Re: [PATCH] uvc: fix missing check to determine if element is found
 in list
To:     Xiaomeng Tong <xiam0nd.tong@gmail.com>
Cc:     laurent.pinchart@ideasonboard.com, mchehab@kernel.org,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Xiaomeng

Thanks for the patch. Maybe it would be better to just make a function
to find the ITERM entity with a given id?

Regards!

On Mon, 21 Mar 2022 at 16:33, Xiaomeng Tong <xiam0nd.tong@gmail.com> wrote:
>
> The list iterator will point to a bogus position containing HEAD if
> the list is empty or the element is not found in list. This case
> should be checked before any use of the iterator, otherwise it will
> lead to a invalid memory access. The missing check here is before
> "pin = iterm->id;", just add check here to fix the security bug.
>
> In addition, the list iterator value will *always* be set and non-NULL
> by list_for_each_entry(), so it is incorrect to assume that the iterator
> value will be NULL if the element is not found in list, considering
> the (mis)use here: "if (iterm == NULL".
>
> Use a new value 'it' as the list iterator, while use the old value
> 'iterm' as a dedicated pointer to point to the found element, which
> 1. can fix this bug, due to 'iterm' is NULL only if it's not found.
> 2. do not need to change all the uses of 'iterm' after the loop.
> 3. can also limit the scope of the list iterator 'it' *only inside*
>    the traversal loop by simply declaring 'it' inside the loop in the
>    future, as usage of the iterator outside of the list_for_each_entry
>    is considered harmful. https://lkml.org/lkml/2022/2/17/1032
>
> Fixes: d5e90b7a6cd1c ("[media] uvcvideo: Move to video_ioctl2")
> Signed-off-by: Xiaomeng Tong <xiam0nd.tong@gmail.com>
> ---
>  drivers/media/usb/uvc/uvc_v4l2.c | 20 +++++++++++++-------
>  1 file changed, 13 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/media/usb/uvc/uvc_v4l2.c b/drivers/media/usb/uvc/uvc_v4l2.c
> index 711556d13d03..e7cdc01ad277 100644
> --- a/drivers/media/usb/uvc/uvc_v4l2.c
> +++ b/drivers/media/usb/uvc/uvc_v4l2.c
> @@ -871,6 +871,7 @@ static int uvc_ioctl_enum_input(struct file *file, void *fh,
>         struct uvc_video_chain *chain = handle->chain;
>         const struct uvc_entity *selector = chain->selector;
>         struct uvc_entity *iterm = NULL;
> +       struct uvc_entity *it;
>         u32 index = input->index;
>         int pin = 0;
>
> @@ -878,22 +879,27 @@ static int uvc_ioctl_enum_input(struct file *file, void *fh,
>             (chain->dev->quirks & UVC_QUIRK_IGNORE_SELECTOR_UNIT)) {
>                 if (index != 0)
>                         return -EINVAL;
> -               list_for_each_entry(iterm, &chain->entities, chain) {
> -                       if (UVC_ENTITY_IS_ITERM(iterm))
> +               list_for_each_entry(it, &chain->entities, chain) {
> +                       if (UVC_ENTITY_IS_ITERM(it)) {
> +                               iterm = it;
>                                 break;
> +                       }
>                 }
> -               pin = iterm->id;
> +               if (iterm)
> +                       pin = iterm->id;
>         } else if (index < selector->bNrInPins) {
>                 pin = selector->baSourceID[index];
> -               list_for_each_entry(iterm, &chain->entities, chain) {
> -                       if (!UVC_ENTITY_IS_ITERM(iterm))
> +               list_for_each_entry(it, &chain->entities, chain) {
> +                       if (!UVC_ENTITY_IS_ITERM(it))
>                                 continue;
> -                       if (iterm->id == pin)
> +                       if (it->id == pin) {
> +                               iterm = it;
>                                 break;
> +                       }
>                 }
>         }
>
> -       if (iterm == NULL || iterm->id != pin)
> +       if (iterm == NULL)
>                 return -EINVAL;
>
>         memset(input, 0, sizeof(*input));
> --
> 2.17.1
>


-- 
Ricardo Ribalda
