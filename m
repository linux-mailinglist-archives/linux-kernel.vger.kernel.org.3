Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 135DA4D803E
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 11:54:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238728AbiCNKz5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 06:55:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238724AbiCNKzz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 06:55:55 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50F442AC50
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 03:54:44 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id g17so26342450lfh.2
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 03:54:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vRzVdmii+d1cRN7UUZvjKYaaOk5b0ubFZRbbFk1xnRM=;
        b=WOfWrWmy0naPgZhVqDU9oBsnW9w/GajwOvDdBr8tdiTSrCzoO5S0M0dPAbIpU5oBbv
         gBHGP5e1shXAYGvRzTab6g/ag4v8nCkOCkvvZ6Sq4xt2XOQaXfDNLPoxIpEwwcit3adK
         jGSwFUAgxuwohakllItBGBYEkY8j/FrPnFfNH1aPtyJ6rqIjWbNI5fVFAFgB4NHVB1ca
         9QiMkrr8EygobsrU0AKovYRFPhNOA1MIBLD2B2GA5dRlEULv8ccSnM3sK71+mpizNyLs
         +pJK7eTiM9aO6Rr2H9mMduAZIV/M5vYhcle29fwiIJYA+XXmsr9Dw4dOTzlIedNXNCJd
         99ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vRzVdmii+d1cRN7UUZvjKYaaOk5b0ubFZRbbFk1xnRM=;
        b=dJQR0fB+4Kw162I6MipHiYowaVeBUt0hEvlmrlDKNJ22YAUQ3TikjIKrJ1875fE2QJ
         ddgam4nR9iHk4MJigEKocqjaj4UjsBQrVD5duNPzU7AMXCdH0Xl/DXgxPrf+i1edoUP4
         dpelSAt5SXiSvv71UwOapja/ymZSiu2pTB4kRy8xFLN/Qjq9p27qTbkvyfJq9GfGFj0D
         fZQcTwxHNWnWfNZlKhS5iT/nw5tJS2URKkcKwUGLTJHB0K7skuW9p3I74krCyPo6c1KP
         YqPS85swDUaT0V79LWDR6wTEpxlM6+VN2KJYg4JxvxhaAGA5D5PeMKK04BQ9raZSzmf2
         tsfg==
X-Gm-Message-State: AOAM531tcqggJLuk6rV0kOo/A6MXLv5OyLxfgRYYV5JLCQM/Uxn7f/ch
        cp+NAkvTgz63b8olqlUBg4Ts3bIOZB9QNwrAMtdH9Q==
X-Google-Smtp-Source: ABdhPJxIJjYE9r/4kFXslwW+YzFmI5aeSDCVRy6PflGXevF8einmHE4Hrsb5JyQbb3vGO2YaaTn+GEbuLpxxph0yCCU=
X-Received: by 2002:ac2:4e98:0:b0:448:3039:d170 with SMTP id
 o24-20020ac24e98000000b004483039d170mr13956278lfr.233.1647255282348; Mon, 14
 Mar 2022 03:54:42 -0700 (PDT)
MIME-Version: 1.0
References: <20220303164522.129583-1-ulf.hansson@linaro.org>
In-Reply-To: <20220303164522.129583-1-ulf.hansson@linaro.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 14 Mar 2022 11:54:06 +0100
Message-ID: <CAPDyKFod3LdfRRgVfdASqgSBAXqJnGkdKMM9qKnAYcfUQptF_g@mail.gmail.com>
Subject: Re: [PATCH] mmc: core: Improve fallback to speed modes if eMMC HS200 fails
To:     Heiner Kallweit <hkallweit1@gmail.com>
Cc:     linux-mmc@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Yann Gautier <yann.gautier@foss.st.com>,
        linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 3 Mar 2022 at 17:45, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> In the error path of mmc_select_hs200() we are trying our best to restore
> the card/host into a valid state. This makes sense, especially if we
> encounter a simple switch error (-EBADMSG). However, rather than then
> continue with using the legacy speed mode, let's try the other better speed
> modes first. Additionally, let's update the card->mmc_avail_type to avoid
> us from trying a broken HS200 mode again.
>
> In an Amlogic S905W based TV box where the switch to HS200 mode fails for
> the eMMC, this allows us to use the eMMC in DDR mode in favor of the legacy
> mode, which greatly improves the performance.
>
> Suggested-by: Heiner Kallweit <hkallweit1@gmail.com>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>

Heiner, does this solve your problems? Can you perhaps run some tests
at your side to see how it works for you?

Kind regards
Uffe

> ---
>  drivers/mmc/core/mmc.c | 16 +++++++++++++---
>  1 file changed, 13 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
> index 141f851c9f58..6e7db45cb8e0 100644
> --- a/drivers/mmc/core/mmc.c
> +++ b/drivers/mmc/core/mmc.c
> @@ -1518,13 +1518,23 @@ static int mmc_select_timing(struct mmc_card *card)
>         if (!mmc_can_ext_csd(card))
>                 goto bus_speed;
>
> -       if (card->mmc_avail_type & EXT_CSD_CARD_TYPE_HS400ES)
> +       if (card->mmc_avail_type & EXT_CSD_CARD_TYPE_HS400ES) {
>                 err = mmc_select_hs400es(card);
> -       else if (card->mmc_avail_type & EXT_CSD_CARD_TYPE_HS200)
> +               goto out;
> +       }
> +
> +       if (card->mmc_avail_type & EXT_CSD_CARD_TYPE_HS200) {
>                 err = mmc_select_hs200(card);
> -       else if (card->mmc_avail_type & EXT_CSD_CARD_TYPE_HS)
> +               if (err == -EBADMSG)
> +                       card->mmc_avail_type &= ~EXT_CSD_CARD_TYPE_HS200;
> +               else
> +                       goto out;
> +       }
> +
> +       if (card->mmc_avail_type & EXT_CSD_CARD_TYPE_HS)
>                 err = mmc_select_hs(card);
>
> +out:
>         if (err && err != -EBADMSG)
>                 return err;
>
> --
> 2.25.1
>
