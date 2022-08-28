Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CAFC5A3D73
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Aug 2022 14:02:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229802AbiH1MCR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Aug 2022 08:02:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbiH1MCO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Aug 2022 08:02:14 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C65A1BE84
        for <linux-kernel@vger.kernel.org>; Sun, 28 Aug 2022 05:02:14 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id x26so5752248pfo.8
        for <linux-kernel@vger.kernel.org>; Sun, 28 Aug 2022 05:02:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ingics-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=HOCvrbple+YuNZd/S4rMMduFVtLG71idSpBlVt7r9vY=;
        b=zSIjoxP95WGxvA+vbKWSqWfq6JDfFszxDmK98KkVx5ZS82pjiY/QLEPw02EJ9kJiKE
         Vt+dPsytZ31FcRUJyJN5YpLESG0B5L1ZjwEkk0tv/CJY2su11U7YWnZDZ3CJ0UBQ0V51
         k0C+2SjVoZHtiafdAWjyYgz/m/qQ2JLuHk4qA/lRpcwodwx/aGXF3vmK2cQyBpHGdRRH
         qJf+68uDSjRZH870dRhySmC0mKx6z3B2fc2OIzCUr0C9O9US37xxcanUNmM7/XgvGM5U
         cNFqdmLZRaITTtVZgokMsCOPQdcExHXVwgjYp2x4WQexyFRX5LA9++fiIvGTgcbmsWFI
         +/rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=HOCvrbple+YuNZd/S4rMMduFVtLG71idSpBlVt7r9vY=;
        b=oYGhFaZSdfou7SHU/vzJnM1EFq8erLXHexyj4+/tAXvqCjHW9B6xmt5DGrfNYlSycB
         z/+6TeyVYs3waJPFseXquFyJyyxeFULTwh4fk3+haRu6Oz2MPhebxw9d+nmTM297FR+S
         5u8Cd8/2+IUa7r6OW8O+dqZfosVE1g41W4v9eCxcPiUYfEjEK1BBaFoZoL2m4dNEB6zX
         mcFQAI8focRIIoI+ihUbGD7OgauJAr2ziOynUS47pkZeW80+73rhkAcN1UwliEXW2v+a
         hwh9M4XT7D/EF11YCdBGZDlj/y+FdqcxHAbniSdcvY3fyOnOfGCAnEqdHiVgA7GMJSdZ
         vrzg==
X-Gm-Message-State: ACgBeo1NaohR03KxSvRBvxHXvSfKL0QimJUQOb8fXiJjtOB/LhwueT57
        3xLXpxBE1DgSxdi8pv0utTWBhQ==
X-Google-Smtp-Source: AA6agR5a8ePgGNEsMI23oLqE808FFM+vAaq+c1VnwN5yLsrdZugqZtIBdAFEbDSslXYLRs67J+7s6w==
X-Received: by 2002:aa7:8882:0:b0:52f:1ead:2c21 with SMTP id z2-20020aa78882000000b0052f1ead2c21mr12150261pfe.15.1661688133592;
        Sun, 28 Aug 2022 05:02:13 -0700 (PDT)
Received: from alpha.. (122-117-179-2.hinet-ip.hinet.net. [122.117.179.2])
        by smtp.googlemail.com with ESMTPSA id n15-20020aa7984f000000b0053645475a6dsm5148157pfq.66.2022.08.28.05.02.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Aug 2022 05:02:12 -0700 (PDT)
From:   Axel Lin <axel.lin@ingics.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Jerome Neanne <jneanne@baylibre.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Tony Lindgren <tony@atomide.com>, linux-kernel@vger.kernel.org,
        Axel Lin <axel.lin@ingics.com>
Subject: [RFT] [PATCH] regulator: tps65219: Fix .bypass_val_on setting
Date:   Sun, 28 Aug 2022 20:01:53 +0800
Message-Id: <20220828120153.1512508-1-axel.lin@ingics.com>
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

The .bypass_val_on setting does not match the .bypass_mask setting, so the
.bypass_mask bit will never get set.  Fix it by removing .bypass_val_on
setting, the regulator_set_bypass_regmap and regulator_get_bypass_regmap
helpers will use rdev->desc->bypass_mask as val_on if the val_on is 0.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
Hi Jerome,
I don't have this h/w to test, please help to review and test the patch.

thanks,
Axel
 drivers/regulator/tps65219-regulator.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/regulator/tps65219-regulator.c b/drivers/regulator/tps65219-regulator.c
index ab16e6665625..7054d8805dd4 100644
--- a/drivers/regulator/tps65219-regulator.c
+++ b/drivers/regulator/tps65219-regulator.c
@@ -117,7 +117,6 @@ struct tps65219_regulator_irq_data {
 		.fixed_uV		= _fuv,				\
 		.bypass_reg		= _vr,				\
 		.bypass_mask		= _bpm,				\
-		.bypass_val_on		= 1,				\
 	}								\
 
 static const struct linear_range bucks_ranges[] = {
-- 
2.34.1

