Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B15C52EF5A
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 17:38:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350927AbiETPio (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 11:38:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350914AbiETPif (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 11:38:35 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50C459D065
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 08:38:31 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id o12-20020a1c4d0c000000b00393fbe2973dso7006862wmh.2
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 08:38:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=TruT4yP/IHfoBAPFqMeOajFvg64Ll1wtLuhAHSQOFUw=;
        b=baUhuljZbwT6dq55Q5DjftLm7uBZoDRY77RVV24wEi0ULaHmuIKEjRzk1Wgu7gOPrR
         Z8NiPOMX5+Moyv/a0GjCkNqUrKgRVDVU6jnStmTqUoA+pQnx9IXNvRxeRC0MzcCdF9jx
         fFljZLckMr/3Mtx511k0FeC4hIATmBROKme2WHNyycxccHfnaCKjKWHwgT0JUVeIOk4z
         fnrASmUzHJ+0TXuinGFpenZN8hMuvjZQ+dsWYbObHPzX9Wq35/CyPuPha3z0xwHVgOyL
         +WpPewvIcGBTUVka+YHokTORsIr/VOEYeWcdot3+RQ77I9bRguuoKPuEtMpdT8KI4ODW
         0isA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=TruT4yP/IHfoBAPFqMeOajFvg64Ll1wtLuhAHSQOFUw=;
        b=Jo7vuH7dHtl+tRKums6kICx9BhPiBU1UlqPtg9g7hG3IzZI6r5g+D1phVNNyCGY1oK
         7zwfSFKTjsJ08bsrPxvyb4ebMuj5VpI6Y9NrLmxb9v8RnzG+Rj/0RW4bsuO6mxPfTpKH
         OvhPAsNwHEgreXy+gSHNVWxt2mMAxeFaIpFqKXSXP9FtLG3X114XHvWF65UyVPk2v9KU
         7lat/AsLzSKF5ghiyVBFHTRCUJDKG/Xb9a64Vk7KW5m0Qa/eI0GL8oPxCDTNH1Qah8gm
         vdIiA8TjNUHRt3yClgYXfQU5uMr+XNW89HsNr8IMDrjJfV0g8vHn9SYXfYOa058Ii2D6
         YNxw==
X-Gm-Message-State: AOAM533KSIkuqpG8YZocSpMDtc16JGE76OEkq9elU1jDV+jQQFzVLMDI
        Gsx0GailljZXbow893VXbulqDg==
X-Google-Smtp-Source: ABdhPJxafD+YBsse6nty71kaQksxTaFOykMVQUpcVH6/gwR3/Hl7XdJzIBXayCDMq5Sc86yZmypl3Q==
X-Received: by 2002:a05:600c:354c:b0:394:586f:694f with SMTP id i12-20020a05600c354c00b00394586f694fmr8717762wmq.159.1653061109803;
        Fri, 20 May 2022 08:38:29 -0700 (PDT)
Received: from localhost ([2a01:cb19:85e6:1900:41e3:1219:c56c:30b8])
        by smtp.gmail.com with ESMTPSA id ay13-20020a05600c1e0d00b003944821105esm2276938wmb.2.2022.05.20.08.38.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 May 2022 08:38:29 -0700 (PDT)
From:   Mattijs Korpershoek <mkorpershoek@baylibre.com>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        dmitry.torokhov@gmail.com
Cc:     matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
        linux-input@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/5] Input: mtk-pmic-keys - Use regmap_{set,clear}_bits
 where possible
In-Reply-To: <20220520125132.229191-3-angelogioacchino.delregno@collabora.com>
References: <20220520125132.229191-1-angelogioacchino.delregno@collabora.com>
 <20220520125132.229191-3-angelogioacchino.delregno@collabora.com>
Date:   Fri, 20 May 2022 17:38:28 +0200
Message-ID: <875ym0kydn.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On ven., mai 20, 2022 at 14:51, AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com> wrote:

> Instead of always using regmap_update_bits(), let's go for the shorter
> regmap_set_bits() and regmap_clear_bits() where possible.
>
> No functional change.
>
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
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
>  		break;
>  	default:
>  		break;
> -- 
> 2.35.1
