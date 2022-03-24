Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F5844E6AAD
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 23:31:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355384AbiCXWbG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 18:31:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244871AbiCXWbD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 18:31:03 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8FDA5520C
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 15:29:30 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id y10so1697078pfa.7
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 15:29:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QZfJuqEqjtuhgufAokgjq3Hu5bdQ5OI0v07gbdQ+pcA=;
        b=dGsFyZaDwBZLwstBdZL4i8VbFpk3YsInDuwrU14tpkYzUE04Sqh2Kuxs9bZyxdPxFU
         NXnn9NwgXbLdFWbPDtgk5gCjiOLG6ZpDzEj/GopS35pKQnFkEn2ujqBgvo2nTfEoUjZP
         8koJ7Mi058j4eV54vVkhwDzZ/L6GrDWuVP+p0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QZfJuqEqjtuhgufAokgjq3Hu5bdQ5OI0v07gbdQ+pcA=;
        b=izoTY+uLocFEI5Bd/rYYybOWOiLhSAEG7ztJt2AXQX2LOp3dolg52s8hp2xgh2BDJV
         zhdeAwAChwZujtA/AGLyp2mxi+0JMlOA+43pGKMCTKcwtUZ075woWJFKydxhcWV3ffFw
         thtQa0jKlQCBJ8tI0pCOhUzT8QoQrUb2/YI2EE/VWAMJR0ny63XF2vXtwRuKoVpUGXpb
         uIFwP768ASTNVbwAs9EBl3P/qfQpvyQdxES99Q5ULdG1hrCDTe9RAIQ+ApVcpa/k1cmm
         MsLc4QSQYSdJWCfT1rGWXnymvnDs7K5e09yacQ8UoHMs1kK35V8luhHZZfMsPPHa5wnf
         6R8Q==
X-Gm-Message-State: AOAM530MlnU+Z/fvGc7oHw8cWHl0aGuoHZH50YUYcxS7QmQUCtNsQ6yw
        TubGNbzYfgZwN3Dwkx47XfJbTg==
X-Google-Smtp-Source: ABdhPJwUxUKuQiIkAbsA4XQIwgBLxZ5hvb4xxSWNFsQ6XcIPQ4wDPANIYdUcunDGus+rTknwsrqDQQ==
X-Received: by 2002:aa7:88d2:0:b0:4f7:78d4:de98 with SMTP id k18-20020aa788d2000000b004f778d4de98mr6850253pff.25.1648160970348;
        Thu, 24 Mar 2022 15:29:30 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:201:8832:9ce1:9692:fe4])
        by smtp.gmail.com with ESMTPSA id g15-20020a056a000b8f00b004fa9dbf27desm4801124pfj.55.2022.03.24.15.29.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Mar 2022 15:29:29 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        Gwendal Grignou <gwendal@chromium.org>
Subject: [PATCH v2] iio:proximity:sx9324: Fix hardware gain read/write
Date:   Thu, 24 Mar 2022 15:29:28 -0700
Message-Id: <20220324222928.874522-1-swboyd@chromium.org>
X-Mailer: git-send-email 2.35.1.1021.g381101b075-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are four possible gain values according to 'sx9324_gain_vals[]':

	1, 2, 4, and 8

The values are off by one when writing and reading the register. The
bits should be set according to this equation:

	ilog2(<gain>) + 1

so that a gain of 8 is 0x3 in the register field and a gain of 4 is 0x2
in the register field, etc. Note that a gain of 0 is reserved per the
datasheet. The default gain (SX9324_REG_PROX_CTRL0_GAIN_1) is also
wrong. It should be 0x1 << 3, i.e. 0x8, not 0x80 which is setting the
reserved bit 7.

Fix this all up to properly handle the hardware gain and return errors
for invalid settings.

Fixes: 4c18a890dff8 ("iio:proximity:sx9324: Add SX9324 support")
Cc: Gwendal Grignou <gwendal@chromium.org>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---

Changes from v1 (https://lore.kernel.org/r/)20220318204808.3404542-1-swboyd@chromium.org:
 * Reject invalid settings
 * Fix default value
 * More commit text details

 drivers/iio/proximity/sx9324.c | 26 +++++++++++++++++++++-----
 1 file changed, 21 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/proximity/sx9324.c b/drivers/iio/proximity/sx9324.c
index 0d9bbbb50cb4..6e90917e3e36 100644
--- a/drivers/iio/proximity/sx9324.c
+++ b/drivers/iio/proximity/sx9324.c
@@ -76,7 +76,10 @@
 
 #define SX9324_REG_PROX_CTRL0		0x30
 #define SX9324_REG_PROX_CTRL0_GAIN_MASK	GENMASK(5, 3)
-#define SX9324_REG_PROX_CTRL0_GAIN_1		0x80
+#define SX9324_REG_PROX_CTRL0_GAIN_SHIFT	3
+#define SX9324_REG_PROX_CTRL0_GAIN_RSVD		0x0
+#define SX9324_REG_PROX_CTRL0_GAIN_1		0x1
+#define SX9324_REG_PROX_CTRL0_GAIN_8		0x4
 #define SX9324_REG_PROX_CTRL0_RAWFILT_MASK	GENMASK(2, 0)
 #define SX9324_REG_PROX_CTRL0_RAWFILT_1P50	0x01
 #define SX9324_REG_PROX_CTRL1		0x31
@@ -379,7 +382,14 @@ static int sx9324_read_gain(struct sx_common_data *data,
 	if (ret)
 		return ret;
 
-	*val = 1 << FIELD_GET(SX9324_REG_PROX_CTRL0_GAIN_MASK, regval);
+	regval = FIELD_GET(SX9324_REG_PROX_CTRL0_GAIN_MASK, regval);
+	if (regval)
+		regval--;
+	else if (regval == SX9324_REG_PROX_CTRL0_GAIN_RSVD ||
+		 regval > SX9324_REG_PROX_CTRL0_GAIN_8)
+		return -EINVAL;
+
+	*val = 1 << regval;
 
 	return IIO_VAL_INT;
 }
@@ -725,8 +735,12 @@ static int sx9324_write_gain(struct sx_common_data *data,
 	unsigned int gain, reg;
 	int ret;
 
-	gain = ilog2(val);
 	reg = SX9324_REG_PROX_CTRL0 + chan->channel / 2;
+
+	gain = ilog2(val) + 1;
+	if (val <= 0 || gain > SX9324_REG_PROX_CTRL0_GAIN_8)
+		return -EINVAL;
+
 	gain = FIELD_PREP(SX9324_REG_PROX_CTRL0_GAIN_MASK, gain);
 
 	mutex_lock(&data->mutex);
@@ -784,9 +798,11 @@ static const struct sx_common_reg_default sx9324_default_regs[] = {
 	{ SX9324_REG_AFE_CTRL8, SX9324_REG_AFE_CTRL8_RESFILTN_4KOHM },
 	{ SX9324_REG_AFE_CTRL9, SX9324_REG_AFE_CTRL9_AGAIN_1 },
 
-	{ SX9324_REG_PROX_CTRL0, SX9324_REG_PROX_CTRL0_GAIN_1 |
+	{ SX9324_REG_PROX_CTRL0,
+		SX9324_REG_PROX_CTRL0_GAIN_1 << SX9324_REG_PROX_CTRL0_GAIN_SHIFT |
 		SX9324_REG_PROX_CTRL0_RAWFILT_1P50 },
-	{ SX9324_REG_PROX_CTRL1, SX9324_REG_PROX_CTRL0_GAIN_1 |
+	{ SX9324_REG_PROX_CTRL1,
+		SX9324_REG_PROX_CTRL0_GAIN_1 << SX9324_REG_PROX_CTRL0_GAIN_SHIFT |
 		SX9324_REG_PROX_CTRL0_RAWFILT_1P50 },
 	{ SX9324_REG_PROX_CTRL2, SX9324_REG_PROX_CTRL2_AVGNEG_THRESH_16K },
 	{ SX9324_REG_PROX_CTRL3, SX9324_REG_PROX_CTRL3_AVGDEB_2SAMPLES |

base-commit: a8ee3b32f5da6c77a5ccc0e42c2250d61ba54fe0
-- 
https://chromeos.dev

