Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 439364F470D
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 01:27:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241810AbiDEU5y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 16:57:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1458158AbiDERLc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 13:11:32 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8FD210FC9;
        Tue,  5 Apr 2022 10:09:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649178574; x=1680714574;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=8FLDvBJ8TPT/3p6/EmiWMYN4z3XTwsiEyt2sJI3V2fI=;
  b=Lzy0JYR86o+X4VigqAaVWXVJDQJyiMgoghpPm8W3MDy9/poV918bG09L
   /TyU+hb2GDklmj7fBpNG8/0nHP/OGvvtmihZ1evfWwwLg9T5hoVyTx5Nn
   eGiFf2kwwlhaQKU70Mbt0rHV2lQEyq83CUXrPwbufqYjPT3YJ6CIoJzdY
   IWsz82DuLhgZ7NKtn1/KJGvvzjuuzkMYj6FlDzbr3JdUFXbDBqBTgfZiU
   Zd2BolqpLjLFsYxpL+NvfcxVaNOO9bWO5Yvn5OKlQYFFL6ZzFPDvnxpcT
   j62nJHYJE9tH3TuNzpdNIyILFpsr/nx8ITOkLduOWweK0t8Y8VEkC97Zl
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10308"; a="260983259"
X-IronPort-AV: E=Sophos;i="5.90,236,1643702400"; 
   d="scan'208";a="260983259"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2022 10:08:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,236,1643702400"; 
   d="scan'208";a="505361177"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga003.jf.intel.com with ESMTP; 05 Apr 2022 10:08:05 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 16FFA32E; Tue,  5 Apr 2022 20:02:54 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andy@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH v1 1/1] pinctrl: alderlake: Fix register offsets for ADL-N variant
Date:   Tue,  5 Apr 2022 20:02:51 +0300
Message-Id: <20220405170251.72154-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It appears that almost traditionally the N variants have deviations
in the register offsets in comparison to S one. This is the case
for Intel Alder Lake as well. Fix register offsets for ADL-N variant.

Fixes: 114b610b9048 ("pinctrl: alderlake: Add Intel Alder Lake-N pin controller support")
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/pinctrl/intel/pinctrl-alderlake.c | 60 +++++++++++++++--------
 1 file changed, 40 insertions(+), 20 deletions(-)

diff --git a/drivers/pinctrl/intel/pinctrl-alderlake.c b/drivers/pinctrl/intel/pinctrl-alderlake.c
index 32ba50efbceb..62dbd1e67513 100644
--- a/drivers/pinctrl/intel/pinctrl-alderlake.c
+++ b/drivers/pinctrl/intel/pinctrl-alderlake.c
@@ -14,11 +14,17 @@
 
 #include "pinctrl-intel.h"
 
-#define ADL_PAD_OWN	0x0a0
-#define ADL_PADCFGLOCK	0x110
-#define ADL_HOSTSW_OWN	0x150
-#define ADL_GPI_IS	0x200
-#define ADL_GPI_IE	0x220
+#define ADL_N_PAD_OWN		0x020
+#define ADL_N_PADCFGLOCK	0x080
+#define ADL_N_HOSTSW_OWN	0x0b0
+#define ADL_N_GPI_IS		0x100
+#define ADL_N_GPI_IE		0x120
+
+#define ADL_S_PAD_OWN		0x0a0
+#define ADL_S_PADCFGLOCK	0x110
+#define ADL_S_HOSTSW_OWN	0x150
+#define ADL_S_GPI_IS		0x200
+#define ADL_S_GPI_IE		0x220
 
 #define ADL_GPP(r, s, e, g)				\
 	{						\
@@ -28,14 +34,28 @@
 		.gpio_base = (g),			\
 	}
 
-#define ADL_COMMUNITY(b, s, e, g)			\
+#define ADL_N_COMMUNITY(b, s, e, g)			\
+	{						\
+		.barno = (b),				\
+		.padown_offset = ADL_N_PAD_OWN,		\
+		.padcfglock_offset = ADL_N_PADCFGLOCK,	\
+		.hostown_offset = ADL_N_HOSTSW_OWN,	\
+		.is_offset = ADL_N_GPI_IS,		\
+		.ie_offset = ADL_N_GPI_IE,		\
+		.pin_base = (s),			\
+		.npins = ((e) - (s) + 1),		\
+		.gpps = (g),				\
+		.ngpps = ARRAY_SIZE(g),			\
+	}
+
+#define ADL_S_COMMUNITY(b, s, e, g)			\
 	{						\
 		.barno = (b),				\
-		.padown_offset = ADL_PAD_OWN,		\
-		.padcfglock_offset = ADL_PADCFGLOCK,	\
-		.hostown_offset = ADL_HOSTSW_OWN,	\
-		.is_offset = ADL_GPI_IS,		\
-		.ie_offset = ADL_GPI_IE,		\
+		.padown_offset = ADL_S_PAD_OWN,		\
+		.padcfglock_offset = ADL_S_PADCFGLOCK,	\
+		.hostown_offset = ADL_S_HOSTSW_OWN,	\
+		.is_offset = ADL_S_GPI_IS,		\
+		.ie_offset = ADL_S_GPI_IE,		\
 		.pin_base = (s),			\
 		.npins = ((e) - (s) + 1),		\
 		.gpps = (g),				\
@@ -342,10 +362,10 @@ static const struct intel_padgroup adln_community5_gpps[] = {
 };
 
 static const struct intel_community adln_communities[] = {
-	ADL_COMMUNITY(0, 0, 66, adln_community0_gpps),
-	ADL_COMMUNITY(1, 67, 168, adln_community1_gpps),
-	ADL_COMMUNITY(2, 169, 248, adln_community4_gpps),
-	ADL_COMMUNITY(3, 249, 256, adln_community5_gpps),
+	ADL_N_COMMUNITY(0, 0, 66, adln_community0_gpps),
+	ADL_N_COMMUNITY(1, 67, 168, adln_community1_gpps),
+	ADL_N_COMMUNITY(2, 169, 248, adln_community4_gpps),
+	ADL_N_COMMUNITY(3, 249, 256, adln_community5_gpps),
 };
 
 static const struct intel_pinctrl_soc_data adln_soc_data = {
@@ -713,11 +733,11 @@ static const struct intel_padgroup adls_community5_gpps[] = {
 };
 
 static const struct intel_community adls_communities[] = {
-	ADL_COMMUNITY(0, 0, 94, adls_community0_gpps),
-	ADL_COMMUNITY(1, 95, 150, adls_community1_gpps),
-	ADL_COMMUNITY(2, 151, 199, adls_community3_gpps),
-	ADL_COMMUNITY(3, 200, 269, adls_community4_gpps),
-	ADL_COMMUNITY(4, 270, 303, adls_community5_gpps),
+	ADL_S_COMMUNITY(0, 0, 94, adls_community0_gpps),
+	ADL_S_COMMUNITY(1, 95, 150, adls_community1_gpps),
+	ADL_S_COMMUNITY(2, 151, 199, adls_community3_gpps),
+	ADL_S_COMMUNITY(3, 200, 269, adls_community4_gpps),
+	ADL_S_COMMUNITY(4, 270, 303, adls_community5_gpps),
 };
 
 static const struct intel_pinctrl_soc_data adls_soc_data = {
-- 
2.35.1

