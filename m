Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B170574A31
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 12:12:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238155AbiGNKMb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 06:12:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238154AbiGNKM3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 06:12:29 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5AFF5006B
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 03:12:28 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id j3so1432122pfb.6
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 03:12:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ingics-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0E33zPMISUjZjMbg4zmucxqueJJj1HicVLRlB46GvXI=;
        b=7Kq0F9BBD4gyUtsYQL7BoRRmlqulxuknl1kQK/3c2ekXaKtF17FqiVucOLnCgyZEYw
         uIFqJnQ2dOCOJUuMZ+eWO8Av6IG1/uoTEkEatx4lpRhI558pS5o15X2XVfFVMwVYiZi5
         ePWQSZfpIT8Six3E+1ON9n9OjjNeYcQa9+fTf6kBe9yXyHlUJidWPY4AyYM1UAH8YdAz
         JeVFDPD6N6stJzXJ55OF5aXYkTewDls/MSulVYeGArmprc7ZFmF5DUykWUaAKyq/GaZc
         /5ZuT9BKzubJ5klPw0rnITilCqZ9xwoS5/khuUMsPa8MRaHs1RrHCvj4OAm54vrHf3XN
         bv2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0E33zPMISUjZjMbg4zmucxqueJJj1HicVLRlB46GvXI=;
        b=JazfXZqMWqzJEtt4/tLnRj6fHwY27UIZzKGpqswS0PB/Dl10BDNuAvCoDeRJ9HUkmi
         5FHkXldH0z3CBMhXwVCamcVPL60T367crQuoRB8k3vAkBy0hMIaYZR/e7GcxetpNNyhJ
         TqRdtIuHR3shMHE4kGV0qr3vL5mycYfy6l64GN+nTFdxcAzsRT1lBGZHT+NuFfSnuxTf
         ltckDZ3lVK7Sld+766LBK8LlpPPpzbN9QHX/ffW7rcwptFPiPu30UTGn81EqvR9deELB
         8XV2Ch1rz/UFuHDTG2Ni5U9JCFnZJaD+nxHfteaZ1zbuDKv9aXrErBv/YyxEiT4q7i63
         lGZg==
X-Gm-Message-State: AJIora9I4zNtPJ2MvlS0AY6pt63LTPUPGdPvjFnjFwYKivOwt5rlSgTX
        tEnWMH6GQwYFDT0yW4r7Zz8axw==
X-Google-Smtp-Source: AGRyM1t493CzN7Wakthopl1qPSg5I2Vg9L1jV9ITONw8lxkxq+1kw4s/v6thkfJHbIwP3vTFLADc4A==
X-Received: by 2002:a63:389:0:b0:415:dde9:4507 with SMTP id 131-20020a630389000000b00415dde94507mr7210580pgd.117.1657793548263;
        Thu, 14 Jul 2022 03:12:28 -0700 (PDT)
Received: from alpha.. (122-117-179-2.hinet-ip.hinet.net. [122.117.179.2])
        by smtp.googlemail.com with ESMTPSA id a28-20020aa795bc000000b00528c8ed356dsm1269764pfk.96.2022.07.14.03.12.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jul 2022 03:12:27 -0700 (PDT)
From:   Axel Lin <axel.lin@ingics.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Patrick Rudolph <patrick.rudolph@9elements.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Axel Lin <axel.lin@ingics.com>
Subject: [PATCH] regulator: max597x: Don't return uninitialized variable in .probe
Date:   Thu, 14 Jul 2022 18:12:12 +0800
Message-Id: <20220714101212.502824-1-axel.lin@ingics.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the code checking and returning uninitialized variable.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/regulator/max597x-regulator.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/regulator/max597x-regulator.c b/drivers/regulator/max597x-regulator.c
index 5e09aa4213be..03c6027682d8 100644
--- a/drivers/regulator/max597x-regulator.c
+++ b/drivers/regulator/max597x-regulator.c
@@ -453,9 +453,6 @@ static int max597x_regulator_probe(struct platform_device *pdev)
 		data->num_switches = num_switches;
 		data->regmap = max597x->regmap;
 
-		if (ret < 0)
-			return ret;
-
 		ret = max597x_adc_range(data->regmap, i, &max597x->irng[i], &max597x->mon_rng[i]);
 		if (ret < 0)
 			return ret;
-- 
2.34.1

