Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06859569E7A
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 11:21:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235180AbiGGJUv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 05:20:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230222AbiGGJUt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 05:20:49 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C10A932EC7
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jul 2022 02:20:47 -0700 (PDT)
Received: from dude02.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::28])
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1o9Ngi-0006DF-SW; Thu, 07 Jul 2022 11:20:44 +0200
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     Julia Lawall <Julia.Lawall@inria.fr>,
        Nicolas Palix <nicolas.palix@imag.fr>
Cc:     linux-kernel@vger.kernel.org, cocci@inria.fr,
        Philipp Zabel <p.zabel@pengutronix.de>
Subject: [PATCH] coccinelle: api: explicitly request exclusive reset controls
Date:   Thu,  7 Jul 2022 11:20:30 +0200
Message-Id: <20220707092030.3319988-1-p.zabel@pengutronix.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:1101:1d::28
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Match deprecated reset_control_get API calls and replace them with the
corresponding _exclusive variants with the reset-exclusive.cocci rule,
to hopefully advance the API transition started with commit a53e35db70d1
("reset: Ensure drivers are explicit when requesting reset lines").

Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
---
 scripts/coccinelle/api/reset-exclusive.cocci | 49 ++++++++++++++++++++
 1 file changed, 49 insertions(+)
 create mode 100644 scripts/coccinelle/api/reset-exclusive.cocci

diff --git a/scripts/coccinelle/api/reset-exclusive.cocci b/scripts/coccinelle/api/reset-exclusive.cocci
new file mode 100644
index 000000000000..c5d6938ca542
--- /dev/null
+++ b/scripts/coccinelle/api/reset-exclusive.cocci
@@ -0,0 +1,49 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/// Explicitly request exclusive reset controls. The implicitly exclusive reset
+/// control request functions are deprecated.
+///
+// Confidence: High
+// Copyright: (C) 2022 Philipp Zabel.
+// Comments:
+// Options: --no-includes --include-headers
+// Keywords: reset_control_get
+
+virtual patch
+virtual report
+
+@depends on patch@
+expression x;
+@@
+
+ x =
+(
+-devm_reset_control_get
++devm_reset_control_get_exclusive
+|
+-devm_reset_control_get_optional
++devm_reset_control_get_optional_exclusive
+|
+-of_reset_control_get
++of_reset_control_get_exclusive
+|
+-of_reset_control_get_by_index
++of_reset_control_get_exclusive_by_index
+|
+-devm_reset_control_get_by_index
++devm_reset_control_get_exclusive_by_index
+)
+ (...)
+
+@r depends on !patch exists@
+expression x;
+position p;
+@@
+
+*x = \(devm_reset_control_get@p\|devm_reset_control_get_optional@p\|of_reset_control_get@p\|of_rset_control_get_by_index@p\|devm_reset_control_get_by_index@p\)(...)
+
+@script:python depends on report@
+p << r.p;
+@@
+
+msg = "ERROR: explicitly request exclusive reset controls with reset_control_get_exclusive() and variants"
+coccilib.report.print_report(p[0], msg)
-- 
2.30.2

