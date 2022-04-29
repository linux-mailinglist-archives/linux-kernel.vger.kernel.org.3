Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79C52514332
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 09:23:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352276AbiD2H0B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 03:26:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352678AbiD2HZt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 03:25:49 -0400
Received: from smtp1.axis.com (smtp1.axis.com [195.60.68.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF0A168FB5
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 00:22:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1651216952;
  x=1682752952;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=7J4fzaWh0d6fTRP5dc/pVVKgUYWsClzeJDEOLLjUR0E=;
  b=FecxOkCZORhwMKKtp9rAFnizpNMG+G3BwEHVvmAAb5ycmeOm+sA0/zF4
   1jEZYxxAhdX/REYutXKGkDHsUQskE7RX7kFz/cROFufGUjLl4mgDMDXI5
   ova2kAUSDCzd4pihUrbGrcak29b8mv1RKtDwKGk1ajbhVQJi2ocv418Vd
   aRMuSo1x87heeibnTHAEEQfXKlduRKmql8HdAxZJFAaziIePGXUn0JDwo
   9vlNZMM1DG2fY1RmQNn5iLP0sEpg09P5NlTkpL6UoZwwDDwpUBRvNUuW5
   HbewNsygRdSLpa9t+z4NOTi05E0sDN2EpCmGQv9jlBGKCKNyfCc9zQ4FE
   Q==;
From:   Rickard Andersson <rickaran@axis.com>
To:     <lgirdwood@gmail.com>, <broonie@kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <rickaran@axis.com>, <rickard314.andersson@gmail.com>,
        <perdo@axis.com>
Subject: [PATCH v2 5/5] regulator: pca9450: Enable DVS control via PMIC_STBY_REQ
Date:   Fri, 29 Apr 2022 09:22:11 +0200
Message-ID: <20220429072211.24957-5-rickaran@axis.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220429072211.24957-1-rickaran@axis.com>
References: <20220429072211.24957-1-rickaran@axis.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.0.5.60]
X-ClientProxiedBy: se-mail01w.axis.com (10.20.40.7) To se-mail03w.axis.com
 (10.20.40.9)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rickard x Andersson <rickaran@axis.com>

When DVS is enabled via the devicetree properties
"nxp,dvs-run-voltage" and "nxp,dvs-standby-voltage" then
also the bit that enables DVS control via PMIC_STBY_REQ pin
should be set.

Signed-off-by: Rickard x Andersson <rickaran@axis.com>
---
 drivers/regulator/pca9450-regulator.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/regulator/pca9450-regulator.c b/drivers/regulator/pca9450-regulator.c
index 4a3ae73c600c..14b7d3376516 100644
--- a/drivers/regulator/pca9450-regulator.c
+++ b/drivers/regulator/pca9450-regulator.c
@@ -174,6 +174,14 @@ static int buck_set_dvs(const struct regulator_desc *desc,
 		}
 	}
 
+	if (ret == 0) {
+		struct pca9450_regulator_desc *regulator = container_of(desc,
+					struct pca9450_regulator_desc, desc);
+
+		/* Enable DVS control through PMIC_STBY_REQ for this BUCK */
+		ret = regmap_update_bits(regmap, regulator->desc.enable_reg,
+					 BUCK1_DVS_CTRL, BUCK1_DVS_CTRL);
+	}
 	return ret;
 }
 
-- 
2.20.1

