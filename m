Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFFBD53087F
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 06:52:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349319AbiEWEvj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 00:51:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229835AbiEWEvf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 00:51:35 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EED96363;
        Sun, 22 May 2022 21:51:34 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id nr2-20020a17090b240200b001df2b1bfc40so16400233pjb.5;
        Sun, 22 May 2022 21:51:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=BreetYWTsmmdO6stIJQjRnOxhkNpGdp8Cj6UELkhpv4=;
        b=mSQk8IugJIT7TxFSLEZqXH1qMjQIQJpOChkViXRA3SMMoV2ROU1Yu67p5Q+lSKHWmd
         zpkB5dbftFup58N2KEW5d7aztZZ/tsK27DJkK5lcyTSPqSlXSGO5dMnQWLofueCLzShv
         dLoRqx1fHjfm+L02szCFwiHn5J0akL8qJ5sxlIjptagQ1g1SafyDgN0iWXrXmkiSbynt
         bJd9vrca0j7djr8LfqiQeGExkzNRqYTWnuUFHgwWkn44xVKzYVhopKIsXnBXtqRr9kY8
         vcb72rzHRZDGKOyP7k4ebHbuejPeAYr27A9jiSuv4VSXu6xeBgXZNQ0Cw+fcVvHjkGoM
         i9Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=BreetYWTsmmdO6stIJQjRnOxhkNpGdp8Cj6UELkhpv4=;
        b=x3w+yPuvtTmFWW6z4Sd/md3HmCu6UyH25Y71Cty2NQqVQlbvh1liZfTIvj3/EvQS0K
         r5zxasxptYkctM4oYY/zpy0lSaAcTi/M2nmWXHulwseqPQSsonT5kjNohBpWDvd7D+F2
         wH2OFCGFWNfVV6J9sSfjcQQj3zvCogmo7BhbX4U+qrPUaFdjGj1yPhEQAijDpqfphbr0
         6NHYC1jsM4goJZABnzhweUEQTJgGoVWWsYHu5mKiPe/44sH4Q8u5nJzunb8Ke+XI2Z7d
         IIvAXrZvKQofHY6nAAu8GPEelZxIbMeD/TgrxlYwHPaF7MDdMXHhyVQXKnM7Nj6wfUaU
         cR0A==
X-Gm-Message-State: AOAM531js8Unz5k4z5dDqm5V55OpCV6dwFAYApr09SrOzXo7LcSrzaDX
        esjtFJqUAffQDf5zURkl3kU=
X-Google-Smtp-Source: ABdhPJwJ5SsDwYlXSr639JsqEyRvwH/SthXrMRADPBYVm16UnhX26NYYNJT45SYhWvFudnV3aMZc/Q==
X-Received: by 2002:a17:90b:38c1:b0:1e0:16da:86e with SMTP id nn1-20020a17090b38c100b001e016da086emr11344584pjb.149.1653281493378;
        Sun, 22 May 2022 21:51:33 -0700 (PDT)
Received: from google.com ([2620:15c:202:201:d84e:5dcd:9d68:ebbf])
        by smtp.gmail.com with ESMTPSA id jh22-20020a170903329600b0015e8d4eb285sm3950442plb.207.2022.05.22.21.51.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 May 2022 21:51:32 -0700 (PDT)
Date:   Sun, 22 May 2022 21:51:29 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     matthias.bgg@gmail.com, mkorpershoek@baylibre.com,
        linux-input@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/5] Input: mtk-pmic-keys - Use regmap_{set,clear}_bits
 where possible
Message-ID: <YosS0ZvAovyl8cF5@google.com>
References: <20220520125132.229191-1-angelogioacchino.delregno@collabora.com>
 <20220520125132.229191-3-angelogioacchino.delregno@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220520125132.229191-3-angelogioacchino.delregno@collabora.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 20, 2022 at 02:51:29PM +0200, AngeloGioacchino Del Regno wrote:
> Instead of always using regmap_update_bits(), let's go for the shorter
> regmap_set_bits() and regmap_clear_bits() where possible.
> 
> No functional change.
> 
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---
>  drivers/input/keyboard/mtk-pmic-keys.c | 24 ++++++------------------
>  1 file changed, 6 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/input/keyboard/mtk-pmic-keys.c b/drivers/input/keyboard/mtk-pmic-keys.c
> index 8e4fa7cd16e6..83d0b90cc8cb 100644
> --- a/drivers/input/keyboard/mtk-pmic-keys.c
> +++ b/drivers/input/keyboard/mtk-pmic-keys.c
> @@ -157,28 +157,16 @@ static void mtk_pmic_keys_lp_reset_setup(struct mtk_pmic_keys *keys,
>  
>  	switch (long_press_mode) {
>  	case LP_ONEKEY:
> -		regmap_update_bits(keys->regmap, pmic_rst_reg,
> -				   MTK_PMIC_PWRKEY_RST,
> -				   MTK_PMIC_PWRKEY_RST);
> -		regmap_update_bits(keys->regmap, pmic_rst_reg,
> -				   MTK_PMIC_HOMEKEY_RST,
> -				   0);
> +		regmap_set_bits(keys->regmap, pmic_rst_reg, MTK_PMIC_PWRKEY_RST);
> +		regmap_clear_bits(keys->regmap, pmic_rst_reg, MTK_PMIC_HOMEKEY_RST);

Why not combine this into a single update instead? I.e. assuming

#define MTK_PMIC_KEY_RST_MASK GENMASK(6, 5)

		regmap_update_bits(keys->regmap, pmic_rst_reg,
				   MTK_PMIC_KEY_RST_MASK,
				   MTK_PMIC_PWRKEY_RST);

>  		break;
>  	case LP_TWOKEY:
> -		regmap_update_bits(keys->regmap, pmic_rst_reg,
> -				   MTK_PMIC_PWRKEY_RST,
> -				   MTK_PMIC_PWRKEY_RST);
> -		regmap_update_bits(keys->regmap, pmic_rst_reg,
> -				   MTK_PMIC_HOMEKEY_RST,
> -				   MTK_PMIC_HOMEKEY_RST);
> +		regmap_set_bits(keys->regmap, pmic_rst_reg, MTK_PMIC_PWRKEY_RST);
> +		regmap_set_bits(keys->regmap, pmic_rst_reg, MTK_PMIC_HOMEKEY_RST);

		regmap_update_bits(keys->regmap, pmic_rst_reg,
				   MTK_PMIC_KEY_RST_MASK,
				   MTK_PMIC_PWRKEY_RST | MTK_PMIC_HOMEKEY_RST);

>  		break;
>  	case LP_DISABLE:
> -		regmap_update_bits(keys->regmap, pmic_rst_reg,
> -				   MTK_PMIC_PWRKEY_RST,
> -				   0);
> -		regmap_update_bits(keys->regmap, pmic_rst_reg,
> -				   MTK_PMIC_HOMEKEY_RST,
> -				   0);
> +		regmap_clear_bits(keys->regmap, pmic_rst_reg, MTK_PMIC_PWRKEY_RST);
> +		regmap_clear_bits(keys->regmap, pmic_rst_reg, MTK_PMIC_HOMEKEY_RST);

		regmap_update_bits(keys->regmap, pmic_rst_reg,
				   MTK_PMIC_KEY_RST_MASKi, 0);

>  		break;
>  	default:
>  		break;
> -- 
> 2.35.1
> 

Thanks.

-- 
Dmitry
