Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08EC258F3BE
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 23:14:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232388AbiHJVOc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 17:14:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230514AbiHJVOb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 17:14:31 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 388B97D7BA
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 14:14:30 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id z6so15493312lfu.9
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 14:14:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=KstM2C1nqWzbgiq4lXjESSIV1F+sGBJqXZBKfIDDeII=;
        b=mJ2qrO5MX6fYku8PgLw5AnOtIoBprrurL+nSadvPZ/nI6zBSOd74G8iKYlHjlxhSGK
         USn07FxYrgyBuEIA+f2Mxh4Oa/e+iiBOCs19euWtk22Fu/Z9qw8oaRo30nQiHAkryS6Y
         OkGFpD8kk5juBZ0pa8b2rWt/+dgD8gCXmdnRvQK+0MF8N9K8OaD4UraP7imW+XgEtrf+
         eVDcIqCbW5EuGYwj2bh4+gx/7LwAiCviv4k3pi6iA8Z/WIOSMsyBb/O9EBsYHE7ukUS8
         xokR0vi2c3FQE9t2Udn3bU0+uZ3i4ejbYLZGKdMm/LrvNqJ66BM5i1pvxlXY91KPTSBE
         Nynw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=KstM2C1nqWzbgiq4lXjESSIV1F+sGBJqXZBKfIDDeII=;
        b=VMHHaIYN2az5FZvPOxAwi5Omc1AflGzeMdZA2XjlpA1Vw6Z7N4x2/gznLGxlzOVem8
         xXD4TYvgZKcLDBIyVjqunjKme/CHw6RaCkKkACy+1xo0V6+PIB/dxTVUQdnuCgAToRW1
         0wVLMAEh1kSeYgPEhU1q5on3KffinisOUsSLzgDN/e2Rpn/hlKSJ4G3m22iN4n6PXrqG
         i4Lw+vwebSZibAU+CrDB/d2sAWetZYltItXsTFlGTR4GOHTA7aeRn481/Oo+3/fvSFwu
         WWaULnOXZFBfVUmDr44VfPktq7DCxIOyAKXkAw999PYWdhdv6bA8YKu4VJQyF5P5n+JZ
         RJCw==
X-Gm-Message-State: ACgBeo1QhYpkPRpssSFx10Bykn7ejKuIvfkkey1KChDVdsUCUB8maH7C
        3/0gpYFWRDAlKMaOEX4CaEQNzyHN0z5hEkO7O8NggQ==
X-Google-Smtp-Source: AA6agR7XAy8+dRFXr1tYRU78D2cRU1qIJone22+JuKdzodOZmAEH3tkfVSaACFucoUikH/AMCJJ0BTbB6CoPorjLq5E=
X-Received: by 2002:ac2:4f03:0:b0:48a:6061:bd8e with SMTP id
 k3-20020ac24f03000000b0048a6061bd8emr11290623lfr.647.1660166068361; Wed, 10
 Aug 2022 14:14:28 -0700 (PDT)
MIME-Version: 1.0
References: <20220810010809.2024482-1-nathan@kernel.org>
In-Reply-To: <20220810010809.2024482-1-nathan@kernel.org>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 10 Aug 2022 14:14:16 -0700
Message-ID: <CAKwvOdmZvB_=JTeLg08uMFhEMpWga4FJey50QHjzCv_jMVpwkg@mail.gmail.com>
Subject: Re: [PATCH] ASoC: mchp-spdiftx: Fix clang -Wbitfield-constant-conversion
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     Codrin Ciubotariu <codrin.ciubotariu@microchip.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Tom Rix <trix@redhat.com>, alsa-devel@alsa-project.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 9, 2022 at 6:08 PM Nathan Chancellor <nathan@kernel.org> wrote:
>
> A recent change in clang strengthened its -Wbitfield-constant-conversion
> to warn when 1 is assigned to a 1-bit signed integer bitfield, as it can
> only be 0 or -1, not 1:
>
>   sound/soc/atmel/mchp-spdiftx.c:505:20: error: implicit truncation from 'int' to bit-field changes value from 1 to -1 [-Werror,-Wbitfield-constant-conversion]
>           dev->gclk_enabled = 1;
>                             ^ ~
>   1 error generated.
>
> The actual value of the field is never checked, just that it is not
> zero, so there is not a real bug here. However, it is simple enough to
> silence the warning by making the bitfield unsigned, which matches the
> mchp-spdifrx driver.
>
> Fixes: 06ca24e98e6b ("ASoC: mchp-spdiftx: add driver for S/PDIF TX Controller")
> Link: https://github.com/ClangBuiltLinux/linux/issues/1686
> Link: https://github.com/llvm/llvm-project/commit/82afc9b169a67e8b8a1862fb9c41a2cd974d6691
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>

Ah yes, my favorite, signed one bit integers...thanks for the patch.
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

grepping for `gclk_enabled`, we see three drivers with similar
duplication (single bit bitfields):

sound/soc/atmel/mchp-spdifrx.c
241: unsigned int gclk_enabled:1;

sound/soc/atmel/mchp-pdmc.c
118: u8 gclk_enabled:1;

sound/soc/atmel/mchp-spdiftx.c
200: int gclk_enabled:1;

> ---
>  sound/soc/atmel/mchp-spdiftx.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/sound/soc/atmel/mchp-spdiftx.c b/sound/soc/atmel/mchp-spdiftx.c
> index 4850a177803d..ab2d7a791f39 100644
> --- a/sound/soc/atmel/mchp-spdiftx.c
> +++ b/sound/soc/atmel/mchp-spdiftx.c
> @@ -196,7 +196,7 @@ struct mchp_spdiftx_dev {
>         struct clk                              *pclk;
>         struct clk                              *gclk;
>         unsigned int                            fmt;
> -       int                                     gclk_enabled:1;
> +       unsigned int                            gclk_enabled:1;
>  };
>
>  static inline int mchp_spdiftx_is_running(struct mchp_spdiftx_dev *dev)
>
> base-commit: 15205c2829ca2cbb5ece5ceaafe1171a8470e62b
> --
> 2.37.1
>


-- 
Thanks,
~Nick Desaulniers
