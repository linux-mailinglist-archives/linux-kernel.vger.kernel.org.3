Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1079C4F8261
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 17:04:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344411AbiDGPFz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 11:05:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344404AbiDGPFx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 11:05:53 -0400
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com [IPv6:2607:f8b0:4864:20::112f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD21A1903EB
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 08:03:52 -0700 (PDT)
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-2eafabbc80aso64435207b3.11
        for <linux-kernel@vger.kernel.org>; Thu, 07 Apr 2022 08:03:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GIG8eITub5ogM33DPsV6tmuNTcczx7G73Grseyf/5Co=;
        b=FLez84DFS+Q/p+XWcJvWc5GDQ8rqVivTZkQ3ETtGZvt5iSXcjOUnfpFnZGkIn8J8la
         fpfOqEkZWpSguThsYcB/LPft8jiUEHkRl8IA9cCrZohWHVbzz6UMHKSv57KNbuYb1iU2
         NttKMVjOlcrh2prhKLcJXNkPWyvA3Mo6nPrB1p1d0kZH5ZSnF1RdisGm8OVXX9NtWQUk
         Ilc6Z6BRZQxE1QTiDh8vC4FQ94pgmcwkCZYb6wjMfSEcVjnOrc4og98vY5xx8dQK+mmQ
         lVblTImyXA+3XMOte8xoeQdQOUWrUmpNxZtd2s+NTRb/fMxochIYuOVlewgLGPFP4A2U
         aRPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GIG8eITub5ogM33DPsV6tmuNTcczx7G73Grseyf/5Co=;
        b=MW8gbxF2p24vljh7vPPvgOD4Hp4grh/9ECmSdGhDj989UAQDCYf1DclmfngNAOwfp7
         POiRdIK0Y084PwaRE8r4utLwR4AV1jErdL0Qr56z2WYb/WJN9KKLIBkMN2eAbEweXikO
         oAzRLhoLPOCI2P+fRShseaNa4I+xf54bF5flOXFMJsoRvgf87tPAtlhSAFfnv689Vr2f
         nRhzTmB7PIIELPDLFlHKgNEf+La6b7iDVr0nzCSZV5zzmKxCYm1RxwyanCPRLumM6nJB
         SdizGGzbrcECP5SePveXTzS6LEEK/KjeO9iyICBQNeCrJf7+i/hkOwwGC1au4jOVnMus
         l2bg==
X-Gm-Message-State: AOAM531B+AdvUz7XgaX6dXLH1J8qVtdyBh/gvGLo69xRTioAvPxdh74I
        xVofrWQyWTemFij4N28PNalekonEBHQwFdmvc/6eTF/q627KT35L
X-Google-Smtp-Source: ABdhPJxeUEHVfts2fspg79ZAgfj8jTrrFsDIHIROyfSbclEZlOXiXVBpwsf+uE8fRplGdoUuYMdlKiNL5J3M1gT6jjg=
X-Received: by 2002:a81:18d7:0:b0:2eb:553e:f3ee with SMTP id
 206-20020a8118d7000000b002eb553ef3eemr11732195ywy.393.1649343831843; Thu, 07
 Apr 2022 08:03:51 -0700 (PDT)
MIME-Version: 1.0
References: <20220407094313.2880-1-srinivas.kandagatla@linaro.org>
In-Reply-To: <20220407094313.2880-1-srinivas.kandagatla@linaro.org>
From:   Amit Pundir <amit.pundir@linaro.org>
Date:   Thu, 7 Apr 2022 20:33:15 +0530
Message-ID: <CAMi1Hd3v3KPVP15KLriDWsQFOuToee5F7JVDpMNrY-nnnXCnYQ@mail.gmail.com>
Subject: Re: [PATCH] ASoC: codecs: wcd934x: do not switch off SIDO Buck when
 codec is in use
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     broonie@kernel.org, lgirdwood@gmail.com, perex@perex.cz,
        tiwai@suse.com, pierre-louis.bossart@linux.intel.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 7 Apr 2022 at 15:13, Srinivas Kandagatla
<srinivas.kandagatla@linaro.org> wrote:
>
> SIDO(Single-Inductor Dual-Ouput) Buck powers up both analog and digital
> circuits along with internal memory, powering off this is the last thing
> that codec should do when going to very low power.
>
> Current code was powering off this Buck if there are no users of sysclk,
> which is not correct. Powering off this buck will result in no register access.
> This code path was never tested until recently after adding pm support
> in SoundWire controller. Fix this by removing the buck poweroff when the
> codec is active and also the code that is not used.
>
> Without this patch all the read/write transactions will never complete and
> results in SLIMBus Errors like:
>
> qcom,slim-ngd qcom,slim-ngd.1: Tx:MT:0x0, MC:0x60, LA:0xcf failed:-110
> wcd934x-codec wcd934x-codec.1.auto: ASoC: error at soc_component_read_no_lock
>         on wcd934x-codec.1.auto for register: [0x00000d05] -110
> qcom,slim-ngd-ctrl 171c0000.slim: Error Interrupt received 0x82000000
>

Thanks Srinivas. It fixes the above regression I see on DB845c and
Xiaomi Pocophone F1 running AOSP with v5.18-rc1.

Tested-by: Amit Pundir <amit.pundir@linaro.org>

> Reported-by: Amit Pundir <amit.pundir@linaro.org>
> Fixes: a61f3b4f476e ("ASoC: wcd934x: add support to wcd9340/wcd9341 codec")
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> ---
>  sound/soc/codecs/wcd934x.c | 26 +-------------------------
>  1 file changed, 1 insertion(+), 25 deletions(-)
>
> diff --git a/sound/soc/codecs/wcd934x.c b/sound/soc/codecs/wcd934x.c
> index 1e75e93cf28f..6298ebe96e94 100644
> --- a/sound/soc/codecs/wcd934x.c
> +++ b/sound/soc/codecs/wcd934x.c
> @@ -1274,29 +1274,7 @@ static int wcd934x_set_sido_input_src(struct wcd934x_codec *wcd, int sido_src)
>         if (sido_src == wcd->sido_input_src)
>                 return 0;
>
> -       if (sido_src == SIDO_SOURCE_INTERNAL) {
> -               regmap_update_bits(wcd->regmap, WCD934X_ANA_BUCK_CTL,
> -                                  WCD934X_ANA_BUCK_HI_ACCU_EN_MASK, 0);
> -               usleep_range(100, 110);
> -               regmap_update_bits(wcd->regmap, WCD934X_ANA_BUCK_CTL,
> -                                  WCD934X_ANA_BUCK_HI_ACCU_PRE_ENX_MASK, 0x0);
> -               usleep_range(100, 110);
> -               regmap_update_bits(wcd->regmap, WCD934X_ANA_RCO,
> -                                  WCD934X_ANA_RCO_BG_EN_MASK, 0);
> -               usleep_range(100, 110);
> -               regmap_update_bits(wcd->regmap, WCD934X_ANA_BUCK_CTL,
> -                                  WCD934X_ANA_BUCK_PRE_EN1_MASK,
> -                                  WCD934X_ANA_BUCK_PRE_EN1_ENABLE);
> -               usleep_range(100, 110);
> -               regmap_update_bits(wcd->regmap, WCD934X_ANA_BUCK_CTL,
> -                                  WCD934X_ANA_BUCK_PRE_EN2_MASK,
> -                                  WCD934X_ANA_BUCK_PRE_EN2_ENABLE);
> -               usleep_range(100, 110);
> -               regmap_update_bits(wcd->regmap, WCD934X_ANA_BUCK_CTL,
> -                                  WCD934X_ANA_BUCK_HI_ACCU_EN_MASK,
> -                                  WCD934X_ANA_BUCK_HI_ACCU_ENABLE);
> -               usleep_range(100, 110);
> -       } else if (sido_src == SIDO_SOURCE_RCO_BG) {
> +       if (sido_src == SIDO_SOURCE_RCO_BG) {
>                 regmap_update_bits(wcd->regmap, WCD934X_ANA_RCO,
>                                    WCD934X_ANA_RCO_BG_EN_MASK,
>                                    WCD934X_ANA_RCO_BG_ENABLE);
> @@ -1382,8 +1360,6 @@ static int wcd934x_disable_ana_bias_and_syclk(struct wcd934x_codec *wcd)
>         regmap_update_bits(wcd->regmap, WCD934X_CLK_SYS_MCLK_PRG,
>                            WCD934X_EXT_CLK_BUF_EN_MASK |
>                            WCD934X_MCLK_EN_MASK, 0x0);
> -       wcd934x_set_sido_input_src(wcd, SIDO_SOURCE_INTERNAL);
> -
>         regmap_update_bits(wcd->regmap, WCD934X_ANA_BIAS,
>                            WCD934X_ANA_BIAS_EN_MASK, 0);
>         regmap_update_bits(wcd->regmap, WCD934X_ANA_BIAS,
> --
> 2.21.0
>
