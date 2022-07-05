Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8B77566270
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 06:35:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229488AbiGEEes (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 00:34:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbiGEEen (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 00:34:43 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 169EF13CF5
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jul 2022 21:34:42 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id l6so9991314plg.11
        for <linux-kernel@vger.kernel.org>; Mon, 04 Jul 2022 21:34:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=tmakuE4H8rZY3d6iU39dHrEeioyPOU2VRNgXbaFPqgw=;
        b=u7aod0CrQMXqVD1ebu7kjSt/WcQQQkg7j6oHslRmkt+QTw/T612mRYZc8qxkE8om3O
         EQM+h21JvLKnCzpiIq4xgwUXzQLpQJOdCt1694l5ZM1mQPkjlLZ33DO+Dp91Uof0icTc
         2eCH31nP6U7iVCED/tU23T/actjjYFmw5UZLP7t0DKiBKU/nAR7cp0MXJlqAa8wI742A
         EQR0aX38sVjulvZcqY4l2O71LHN3k6M9c36toeseQylQoLjWGDZYqtxqvh3+p0Tozz/N
         XPHPZJPQNycYMom8jxQv3xsFNeAKZLSk+yfh0F9BKr8UZwwsSvArNI8r2sZRhz3icFzn
         3CaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=tmakuE4H8rZY3d6iU39dHrEeioyPOU2VRNgXbaFPqgw=;
        b=2jCGYzgAIjHUAi5tjXKYdiQP09cqYYpVCHuMjOgp7lRmfwXioj3hMWX6prr/5fmWRh
         xKSqfR52r6PImkd/eBomL9oVrVhJon3Ef5vr434KKyX8ouAuyf+5dizMiQqozxTKjUm5
         m7Z0K9oCjiyqk9c1mAYz9bCLLHhtv2IwvI5ONk0QsN6HHoRnIwoutc1mEaB6iCr0kGNS
         3bE1t3672dxbg/KFyCLTAorr4pThLn9fKYS2hQLinZ2SQW0RyOYYR3o5fdfx71xN4eBW
         IoR0Yooq7zsRyjTea8Xl4oH3CmfyPv84ua43ZEFj5PT4M5J7lBtClenXb2ihsdupWh9a
         /SAw==
X-Gm-Message-State: AJIora9VbrFu+Rf0btxDNgKll0fLIT/WgIWJ8jDl5kxmkEhdh4fcD7L9
        DxTMecViwzDcq2XsXTw04R5pcQ==
X-Google-Smtp-Source: AGRyM1sRTY3jhmXML4zUAHI23oIyvbgNG1ONSMMqox+hipkmWXEtiTEid5mCOhRsoVVHI5UrE7Q83A==
X-Received: by 2002:a17:90b:4a4f:b0:1ef:90fb:35a5 with SMTP id lb15-20020a17090b4a4f00b001ef90fb35a5mr5846805pjb.161.1656995682324;
        Mon, 04 Jul 2022 21:34:42 -0700 (PDT)
Received: from localhost ([122.171.18.80])
        by smtp.gmail.com with ESMTPSA id p26-20020a056a0026da00b005251e2b53acsm21651540pfw.116.2022.07.04.21.34.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Jul 2022 21:34:41 -0700 (PDT)
Date:   Tue, 5 Jul 2022 10:04:39 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Steven Price <steven.price@arm.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Qiang Yu <yuq825@gmail.com>, Rob Herring <robh@kernel.org>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>,
        Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        dri-devel@lists.freedesktop.org, lima@lists.freedesktop.org,
        linux-tegra@vger.kernel.org
Subject: Re: [PATCH V3 02/20] OPP: Make dev_pm_opp_set_regulators() accept
 NULL terminated list
Message-ID: <20220705043439.xlrxusxrhwjupiyt@vireshk-i7>
References: <cover.1656935522.git.viresh.kumar@linaro.org>
 <9730e011004b7526e79c6f409f5147fb235b414a.1656935522.git.viresh.kumar@linaro.org>
 <48d865e8-6c0d-99c0-a43b-89793d5c3f85@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <48d865e8-6c0d-99c0-a43b-89793d5c3f85@arm.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04-07-22, 15:35, Steven Price wrote:
> I have to say the 'new improved' list ending with NULL approach doesn't
> work out so well for Panfrost. We already have to have a separate
> 'num_supplies' variable for devm_regulator_bulk_get() /
> regulator_bulk_{en,dis}able(), so the keeping everything in sync
> argument is lost here.
> 
> I would suggest added the NULL on the end of the lists in panfrost_drv.c
> but then it would break the use of ARRAY_SIZE() to automagically keep
> the length correct...

Actually we can still make it work.

> For now the approach isn't too bad because Panfrost doesn't yet support
> enabling devfreq with more than one supply. But that array isn't going
> to work so nicely when that restriction is removed.
> 
> The only sane way I can see of handling this in Panfrost would be
> replicating the loop to count the supplies in the Panfrost code which
> would allow dropping num_supplies from struct panfrost_compatible and
> then supply_names in the same struct could be NULL terminated ready for
> devm_pm_opp_set_regulators().

Or doing this, which will simplify both the cases.

diff --git a/drivers/gpu/drm/panfrost/panfrost_drv.c b/drivers/gpu/drm/panfrost/panfrost_drv.c
index 7fcbc2a5b6cd..b3b55565b8ef 100644
--- a/drivers/gpu/drm/panfrost/panfrost_drv.c
+++ b/drivers/gpu/drm/panfrost/panfrost_drv.c
@@ -625,24 +625,29 @@ static int panfrost_remove(struct platform_device *pdev)
        return 0;
 }
 
-static const char * const default_supplies[] = { "mali" };
+/*
+ * The OPP core wants the supply names to be NULL terminated, but we need the
+ * correct num_supplies value for regulator core. Hence, we NULL terminate here
+ * and then initialize num_supplies with ARRAY_SIZE - 1.
+ */
+static const char * const default_supplies[] = { "mali", NULL };
 static const struct panfrost_compatible default_data = {
-       .num_supplies = ARRAY_SIZE(default_supplies),
+       .num_supplies = ARRAY_SIZE(default_supplies) - 1,
        .supply_names = default_supplies,
        .num_pm_domains = 1, /* optional */
        .pm_domain_names = NULL,
 };
 
 static const struct panfrost_compatible amlogic_data = {
-       .num_supplies = ARRAY_SIZE(default_supplies),
+       .num_supplies = ARRAY_SIZE(default_supplies) - 1,
        .supply_names = default_supplies,
        .vendor_quirk = panfrost_gpu_amlogic_quirk,
 };
 
-static const char * const mediatek_mt8183_supplies[] = { "mali", "sram" };
+static const char * const mediatek_mt8183_supplies[] = { "mali", "sram", NULL };
 static const char * const mediatek_mt8183_pm_domains[] = { "core0", "core1", "core2" };
 static const struct panfrost_compatible mediatek_mt8183_data = {
-       .num_supplies = ARRAY_SIZE(mediatek_mt8183_supplies),
+       .num_supplies = ARRAY_SIZE(mediatek_mt8183_supplies) - 1,
        .supply_names = mediatek_mt8183_supplies,
        .num_pm_domains = ARRAY_SIZE(mediatek_mt8183_pm_domains),
        .pm_domain_names = mediatek_mt8183_pm_domains,

-- 
viresh
