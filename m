Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 206614C026D
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 20:52:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235324AbiBVTwc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 14:52:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235318AbiBVTwa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 14:52:30 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 70EFAC4860
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 11:52:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1645559523;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=yqAxAt97qCJLV5CPBezCxx4lwmzLsldJjCu+hXm/y4A=;
        b=M3qHcW7moXKNJtqbD3Qad/ZriyxAxcgNjPKZTP+aTlTZs7wdbL4zTFnsx57oz+Eh7HEFWS
        GEyny0C++dRX86iEOWDzFemh5qbk93Gjfo8uiX5WMyH3N0ttHgrvdbEsCqytUtaQaWtKEf
        wtMigGDH2ZkjbibLlqJCH9xrgOwDWaI=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-111-VYUl152cPmiVGGaBZQPx8g-1; Tue, 22 Feb 2022 14:52:02 -0500
X-MC-Unique: VYUl152cPmiVGGaBZQPx8g-1
Received: by mail-qv1-f72.google.com with SMTP id e9-20020a0cf749000000b0042bf697ff6bso904444qvo.5
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 11:52:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yqAxAt97qCJLV5CPBezCxx4lwmzLsldJjCu+hXm/y4A=;
        b=pg28qK+Ew7xMCuCk+qSC1QLFKrkj0Fja27jjmhdSZbkoi4YEorU5jSZyL4+QZxA9cK
         w1iyXH6ICQmoWAI3XpzDE7cLu8VRrLwDE/7XAg0jJXV5+cYrN3rAPK6sAYGev3TyGxde
         nW0NuNpHBwbuSZTka/0XWLDaEz6hmKa3c4IUg+5MfL+KsKcvxqt1cyk6pJkkPUYATsvU
         JWIW7BgFuL+CYdvlL8H5hJFVr6oHt52Yo38/wiEa+dlhvulXeJPI6tdOkYxHccayOa06
         uhF6cw5FhnGF8a1eJECeqOojznn/58cRilO8nAGyVrFIxBbLpbjv7A/GtE30ynz8Fk6X
         /gEQ==
X-Gm-Message-State: AOAM532Tp+sbFc8utpwV/z7RszmSQU0EkY2Qo58+9BT1Oct7WBe/lNYm
        KYZe58MeEhcp2I5gMmnsGqH00J+IzFRa5x1AkgxMJw9RV22oFb8hjxpNIrRkxTZRHA0okHIU3pw
        uIx4eoYry2/LsHHRmKpf8fX9u
X-Received: by 2002:ac8:5ccc:0:b0:2de:2c05:a4d5 with SMTP id s12-20020ac85ccc000000b002de2c05a4d5mr9869918qta.77.1645559521575;
        Tue, 22 Feb 2022 11:52:01 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxm0K5Nq0kkz2hfcMU9ijcXpKdvSZAutJr5ctmWgXao4fnPEQuBInwgg1GxR/g6ikbJVmux0g==
X-Received: by 2002:ac8:5ccc:0:b0:2de:2c05:a4d5 with SMTP id s12-20020ac85ccc000000b002de2c05a4d5mr9869904qta.77.1645559521315;
        Tue, 22 Feb 2022 11:52:01 -0800 (PST)
Received: from localhost.localdomain.com (024-205-208-113.res.spectrum.com. [24.205.208.113])
        by smtp.gmail.com with ESMTPSA id x7sm364155qta.75.2022.02.22.11.51.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Feb 2022 11:52:00 -0800 (PST)
From:   trix@redhat.com
To:     mturquette@baylibre.com, sboyd@kernel.org,
        nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
        claudiu.beznea@microchip.com, jesper.nilsson@axis.com,
        lars.persson@axis.com, rjui@broadcom.com, sbranden@broadcom.com,
        f.fainelli@gmail.com, narmstrong@baylibre.com,
        jbrunet@baylibre.com, khilman@baylibre.com,
        martin.blumenstingl@googlemail.com, dinguyen@kernel.org
Cc:     bcm-kernel-feedback-list@broadcom.com, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@axis.com, linux-amlogic@lists.infradead.org,
        Tom Rix <trix@redhat.com>
Subject: [PATCH] clk: cleanup comments
Date:   Tue, 22 Feb 2022 11:51:53 -0800
Message-Id: <20220222195153.3817625-1-trix@redhat.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Rix <trix@redhat.com>

For spdx
Space instead of tab before spdx tag

Removed repeated works
the, to, two

Replacements
much much to a much
'to to' to 'to do'
aready to already
Comunications to Communications
freqency to frequency

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/clk/at91/sckc.c              | 2 +-
 drivers/clk/axis/clk-artpec6.c       | 2 +-
 drivers/clk/bcm/clk-iproc.h          | 2 +-
 drivers/clk/bcm/clk-kona-setup.c     | 2 +-
 drivers/clk/clk-fractional-divider.c | 2 +-
 drivers/clk/clk-si5341.c             | 2 +-
 drivers/clk/meson/meson8b.c          | 2 +-
 drivers/clk/mmp/pwr-island.c         | 2 +-
 drivers/clk/socfpga/clk-gate-s10.c   | 2 +-
 9 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/clk/at91/sckc.c b/drivers/clk/at91/sckc.c
index 2d65770d8665..fdc9b669f8a7 100644
--- a/drivers/clk/at91/sckc.c
+++ b/drivers/clk/at91/sckc.c
@@ -535,7 +535,7 @@ static int clk_sama5d4_slow_osc_prepare(struct clk_hw *hw)
 
 	/*
 	 * Assume that if it has already been selected (for example by the
-	 * bootloader), enough time has aready passed.
+	 * bootloader), enough time has already passed.
 	 */
 	if ((readl(osc->sckcr) & osc->bits->cr_oscsel)) {
 		osc->prepared = true;
diff --git a/drivers/clk/axis/clk-artpec6.c b/drivers/clk/axis/clk-artpec6.c
index f95959ff85ac..a3f349d4624d 100644
--- a/drivers/clk/axis/clk-artpec6.c
+++ b/drivers/clk/axis/clk-artpec6.c
@@ -2,7 +2,7 @@
 /*
  * ARTPEC-6 clock initialization
  *
- * Copyright 2015-2016 Axis Comunications AB.
+ * Copyright 2015-2016 Axis Communications AB.
  */
 
 #include <linux/clk-provider.h>
diff --git a/drivers/clk/bcm/clk-iproc.h b/drivers/clk/bcm/clk-iproc.h
index a48ddd3e0b28..d7e5b94bed45 100644
--- a/drivers/clk/bcm/clk-iproc.h
+++ b/drivers/clk/bcm/clk-iproc.h
@@ -89,7 +89,7 @@
  * Parameters for VCO frequency configuration
  *
  * VCO frequency =
- * ((ndiv_int + ndiv_frac / 2^20) * (ref freqeuncy  / pdiv)
+ * ((ndiv_int + ndiv_frac / 2^20) * (ref frequency  / pdiv)
  */
 struct iproc_pll_vco_param {
 	unsigned long rate;
diff --git a/drivers/clk/bcm/clk-kona-setup.c b/drivers/clk/bcm/clk-kona-setup.c
index e65eeef9cbaf..5dd65164c8b1 100644
--- a/drivers/clk/bcm/clk-kona-setup.c
+++ b/drivers/clk/bcm/clk-kona-setup.c
@@ -510,7 +510,7 @@ static bool kona_clk_valid(struct kona_clk *bcm_clk)
  * placeholders for non-supported clocks.  Keep track of the
  * position of each clock name in the original array.
  *
- * Allocates an array of pointers to to hold the names of all
+ * Allocates an array of pointers to hold the names of all
  * non-null entries in the original array, and returns a pointer to
  * that array in *names.  This will be used for registering the
  * clock with the common clock code.  On successful return,
diff --git a/drivers/clk/clk-fractional-divider.c b/drivers/clk/clk-fractional-divider.c
index 4274540327ce..8efa5142ff8c 100644
--- a/drivers/clk/clk-fractional-divider.c
+++ b/drivers/clk/clk-fractional-divider.c
@@ -34,7 +34,7 @@
  * and assume that the IP, that needs m and n, has also its own
  * prescaler, which is capable to divide by 2^scale. In this way
  * we get the denominator to satisfy the desired range (2) and
- * at the same time much much better result of m and n than simple
+ * at the same time a much better result of m and n than simple
  * saturated values.
  */
 
diff --git a/drivers/clk/clk-si5341.c b/drivers/clk/clk-si5341.c
index 071f5a1c8a1c..41851f41b682 100644
--- a/drivers/clk/clk-si5341.c
+++ b/drivers/clk/clk-si5341.c
@@ -655,7 +655,7 @@ static unsigned long si5341_synth_clk_recalc_rate(struct clk_hw *hw,
 	f = synth->data->freq_vco;
 	f *= n_den >> 4;
 
-	/* Now we need to to 64-bit division: f/n_num */
+	/* Now we need to do 64-bit division: f/n_num */
 	/* And compensate for the 4 bits we dropped */
 	f = div64_u64(f, (n_num >> 4));
 
diff --git a/drivers/clk/meson/meson8b.c b/drivers/clk/meson/meson8b.c
index cd0f5bae24d4..8f3b7a94a667 100644
--- a/drivers/clk/meson/meson8b.c
+++ b/drivers/clk/meson/meson8b.c
@@ -2232,7 +2232,7 @@ static struct clk_regmap meson8b_vpu_1 = {
 };
 
 /*
- * The VPU clock has two two identical clock trees (vpu_0 and vpu_1)
+ * The VPU clock has two identical clock trees (vpu_0 and vpu_1)
  * muxed by a glitch-free switch on Meson8b and Meson8m2. The CCF can
  * actually manage this glitch-free mux because it does top-to-bottom
  * updates the each clock tree and switches to the "inactive" one when
diff --git a/drivers/clk/mmp/pwr-island.c b/drivers/clk/mmp/pwr-island.c
index ab57c0e995c1..edaa2433a472 100644
--- a/drivers/clk/mmp/pwr-island.c
+++ b/drivers/clk/mmp/pwr-island.c
@@ -76,7 +76,7 @@ static int mmp_pm_domain_power_off(struct generic_pm_domain *genpd)
 	if (pm_domain->lock)
 		spin_lock_irqsave(pm_domain->lock, flags);
 
-	/* Turn off and isolate the the power island. */
+	/* Turn off and isolate the power island. */
 	val = readl(pm_domain->reg);
 	val &= ~pm_domain->power_on;
 	val &= ~0x100;
diff --git a/drivers/clk/socfpga/clk-gate-s10.c b/drivers/clk/socfpga/clk-gate-s10.c
index 32567795765f..3930d922efb4 100644
--- a/drivers/clk/socfpga/clk-gate-s10.c
+++ b/drivers/clk/socfpga/clk-gate-s10.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier:	GPL-2.0
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright (C) 2017, Intel Corporation
  */
-- 
2.26.3

