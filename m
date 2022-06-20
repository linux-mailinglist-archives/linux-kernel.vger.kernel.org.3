Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CE8E5517A5
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 13:45:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241995AbiFTLou (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 07:44:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241058AbiFTLop (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 07:44:45 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3ECFD65C3;
        Mon, 20 Jun 2022 04:44:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655725483; x=1687261483;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=UecaHSuSKGghZGkQQEAI1GlxWKlMWFNNnHK+VeNcMgo=;
  b=IP/N/EjLJhF/UwejOMVYQEWjgW4vcqfw6SVovH1Iwv/ZchMyYxolvzL6
   QQYiW6hEr33HzkkE6a/HPLxsAVUYben8uYg1yEFC7jro0gk4UEeifyQXR
   sbFaauQlX3xHvsS4wLikGqd8+K4fBp5TPWjyaWP+KCL+iZGLBGNgSZU65
   aQTM5JliMS2kl72KpUsP9/KWKiI942KB5J01O9nOOWaElUcKLT6hAjC7h
   ilR4gn137SQki7MWf4ZO9aSoUjCTzX9t3nZr/Q0BffXqvtp5biP2OQIAy
   Z4BT2BAzjPw8FqRfBfy53cggzrvLsWoHjNdjM57DNP9pTLEWOMabR5Lca
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10380"; a="341555852"
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; 
   d="scan'208";a="341555852"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2022 04:44:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; 
   d="scan'208";a="676503093"
Received: from black.fi.intel.com ([10.237.72.28])
  by FMSMGA003.fm.intel.com with ESMTP; 20 Jun 2022 04:44:40 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id B99A214F; Mon, 20 Jun 2022 14:44:45 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andy@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH v1 1/7] pinctrl: intel: Embed struct pingroup into struct intel_pingroup
Date:   Mon, 20 Jun 2022 14:44:33 +0300
Message-Id: <20220620114439.31491-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a new member to the struct intel_pingroup to cover generic
pin control group parameters. The idea is to convert all users
(one-by-one) to it and drop old members later on.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/pinctrl/intel/pinctrl-intel.h | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/pinctrl/intel/pinctrl-intel.h b/drivers/pinctrl/intel/pinctrl-intel.h
index 710341bb67cc..69ff0598263c 100644
--- a/drivers/pinctrl/intel/pinctrl-intel.h
+++ b/drivers/pinctrl/intel/pinctrl-intel.h
@@ -27,14 +27,15 @@ struct device;
  * @name: Name of the groups
  * @pins: All pins in this group
  * @npins: Number of pins in this groups
- * @mode: Native mode in which the group is muxed out @pins. Used if @modes
- *        is %NULL.
+ * @grp: Generic data of the pin group (name and pins)
+ * @mode: Native mode in which the group is muxed out @pins. Used if @modes is %NULL.
  * @modes: If not %NULL this will hold mode for each pin in @pins
  */
 struct intel_pingroup {
 	const char *name;
 	const unsigned int *pins;
 	size_t npins;
+	struct pingroup grp;
 	unsigned short mode;
 	const unsigned int *modes;
 };
@@ -156,15 +157,14 @@ struct intel_community {
  *     a single integer or an array of integers in which case mode is per
  *     pin.
  */
-#define PIN_GROUP(n, p, m)					\
-	{							\
+#define PIN_GROUP(n, p, m)								\
+	{										\
 		.name = (n),					\
 		.pins = (p),					\
 		.npins = ARRAY_SIZE((p)),			\
-		.mode = __builtin_choose_expr(			\
-			__builtin_constant_p((m)), (m), 0),	\
-		.modes = __builtin_choose_expr(			\
-			__builtin_constant_p((m)), NULL, (m)),	\
+		.grp = PINCTRL_PINGROUP((n), (p), ARRAY_SIZE((p))),			\
+		.mode = __builtin_choose_expr(__builtin_constant_p((m)), (m), 0),	\
+		.modes = __builtin_choose_expr(__builtin_constant_p((m)), NULL, (m)),	\
 	}
 
 #define FUNCTION(n, g)				\
-- 
2.35.1

