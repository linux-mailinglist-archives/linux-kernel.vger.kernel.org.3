Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C90F513633
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 16:04:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347984AbiD1OFu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 10:05:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233943AbiD1OF3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 10:05:29 -0400
Received: from smtp1.axis.com (smtp1.axis.com [195.60.68.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52305AC90F
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 07:02:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1651154533;
  x=1682690533;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=7J4fzaWh0d6fTRP5dc/pVVKgUYWsClzeJDEOLLjUR0E=;
  b=GpIhQnZvDeFVXSGXXak3LxohwlYcEqSiN1/UgL8Oe4Ysjh8HyYcpxnU3
   83PuaIEMD0hurNnEt6iFhRrnTl003nsit6lZgyUaXDvjqshtVG5P0QErJ
   23CtR8QLjMPxhj1T9Y0jjhUxCjnJt2r8sGAabBvXwJTGqNCoMHbL/eFm9
   AJZrgwvoAN7YXAqWxIdRFuaf0jmpOWcV7ULP4IcuB4WvMEKKEs8OABx7G
   LTIeK9cw4gY+UpRZzlDxRRqVADwSY5mA5GkixNcTN1QqmHTRqHrMI8DSM
   ljJQNe1CLLCF5OIsVOd6d9VJ5u5FChU9P85qBIJSPHvusCOBtsje2C0uk
   w==;
From:   Rickard Andersson <rickaran@axis.com>
To:     <broonie@kernel.org>, <lgirdwood@gmail.com>,
        <linux-kernel@vger.kernel.org>, <yibin.gong@nxp.com>
CC:     <rickaran@axis.com>, <rickard314.andersson@gmail.com>,
        <perdo@axis.com>
Subject: [PATCH 5/5] regulator: pca9450: Enable DVS control via PMIC_STBY_REQ
Date:   Thu, 28 Apr 2022 16:01:39 +0200
Message-ID: <20220428140139.7349-5-rickaran@axis.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220428140139.7349-1-rickaran@axis.com>
References: <20220428140139.7349-1-rickaran@axis.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.0.5.60]
X-ClientProxiedBy: se-mail06w.axis.com (10.20.40.12) To se-mail03w.axis.com
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

