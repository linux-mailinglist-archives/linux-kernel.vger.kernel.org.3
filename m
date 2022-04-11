Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A62124FC10A
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 17:38:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243721AbiDKPkn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 11:40:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240237AbiDKPkk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 11:40:40 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9808D3A706;
        Mon, 11 Apr 2022 08:38:26 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id x3so2281167wmj.5;
        Mon, 11 Apr 2022 08:38:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TmspQXL8ssUng8+s6ocBtiiA4+mDrC4wVOVkbmyv+jc=;
        b=CIiuQVHA6iL5XR/Dt2fESMXoo6Yb1wuc1DIuHgWEvLGJHYC0z4DcWHcHwLtnLvtMvZ
         V7mg6ctge3MQY3saddAJ44l7kii5s7bYvzxSvqJ7UnyUfON8PfIoMgSCHpJyaLA63SyR
         UZzKhIAtAfwYC0UdiZwVomHq2VEo2XvXsl9/H67ug1BGq1RS0hwdE7P/EzatPCP+7LEE
         JaZ8lALrjMact0xO8EMTc4L+nE5LWRCA9f57JCzD5yl8dal6t5Sm8yyMSPfSBWN0tXun
         uaiaJlmGR7FB+mrbCnpcsdZguJbG9mGxQqP5h8/xmrKJtQA6r6Wa89K4lVjnv/4GPlU/
         3v/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TmspQXL8ssUng8+s6ocBtiiA4+mDrC4wVOVkbmyv+jc=;
        b=EA32RtFWJSSwsPCVbB7+raZQCAPs9j05jmzfZBKrD/9BiXz8Q57gd6rNyjL0x/FnT0
         L+G+5Lf6tQReeyUmsl7zYk6kMixHQvqLv/DE1TUJBBD2iMoGM/v8MwJOVsx2bzQxF3rX
         4tkL5ifzSIFYWlOlQM6WM/177jRAV9SkuV3Q6G6NCbnz04kMuCZHkFJpek2ufIv2fiZY
         zumYGQPryKFAatyE5/n21Ev5SaOtuShS3UkYMDVLRnZQZdiN6k8Vv4wjQHhuzofr7uVC
         rppuNfMV8FpivgnHXBs6Uo4EucwTQLPJVU8vPYmXfw7i2oVLr6IbEnRb+rff/MTby5jv
         KT1Q==
X-Gm-Message-State: AOAM532/T32hAbBIq6YYwOCEdrl4gs3fT5HpTmMjnAJh/TiFz8T4wsTZ
        CzlqqhwjZG+6Y20XXPJnhy4=
X-Google-Smtp-Source: ABdhPJzWoncL/AiKibYMqJhjJTiMNRn07rs4GeeqsXGT8DIiJ+Eq0UE1a+s/h30NfVGfgmLSUP9Ijw==
X-Received: by 2002:a05:600c:4f0f:b0:38c:c8f5:73e7 with SMTP id l15-20020a05600c4f0f00b0038cc8f573e7mr29193223wmq.201.1649691505211;
        Mon, 11 Apr 2022 08:38:25 -0700 (PDT)
Received: from kista.localnet (cpe-86-58-32-107.static.triera.net. [86.58.32.107])
        by smtp.gmail.com with ESMTPSA id a18-20020a05600c349200b0038ca453a887sm18336226wmq.19.2022.04.11.08.38.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Apr 2022 08:38:24 -0700 (PDT)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     Chen-Yu Tsai <wens@csie.org>, Maxime Ripard <mripard@kernel.org>,
        Samuel Holland <samuel@sholland.org>
Cc:     Samuel Holland <samuel@sholland.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@lists.linux.dev
Subject: Re: [PATCH 04/10] drm/sun4i: Allow building the driver on RISC-V
Date:   Mon, 11 Apr 2022 17:38:23 +0200
Message-ID: <10060227.nUPlyArG6x@kista>
In-Reply-To: <20220411043423.37333-5-samuel@sholland.org>
References: <20220411043423.37333-1-samuel@sholland.org> <20220411043423.37333-5-samuel@sholland.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dne ponedeljek, 11. april 2022 ob 06:34:16 CEST je Samuel Holland napisal(a):
> Allwinner D1 is a RISC-V SoC which contains a DE 2.0 engine. Let's
> remove the dependency on a specific CPU architecture, so the driver can
> be built wherever ARCH_SUNXI is selected.
> 
> Signed-off-by: Samuel Holland <samuel@sholland.org>

Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej

> ---
> 
>  drivers/gpu/drm/sun4i/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/sun4i/Kconfig b/drivers/gpu/drm/sun4i/Kconfig
> index befc5a80222d..3a43c436c74a 100644
> --- a/drivers/gpu/drm/sun4i/Kconfig
> +++ b/drivers/gpu/drm/sun4i/Kconfig
> @@ -1,7 +1,7 @@
>  # SPDX-License-Identifier: GPL-2.0-only
>  config DRM_SUN4I
>  	tristate "DRM Support for Allwinner A10 Display Engine"
> -	depends on DRM && (ARM || ARM64) && COMMON_CLK
> +	depends on DRM && COMMON_CLK
>  	depends on ARCH_SUNXI || COMPILE_TEST
>  	select DRM_GEM_CMA_HELPER
>  	select DRM_KMS_HELPER
> -- 
> 2.35.1
> 
> 


