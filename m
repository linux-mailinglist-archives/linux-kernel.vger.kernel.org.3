Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FA1357B017
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 06:49:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237713AbiGTEsY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 00:48:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229806AbiGTEsW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 00:48:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 858945B784
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 21:48:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 19AC9615C4
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 04:48:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B596C341CA;
        Wed, 20 Jul 2022 04:48:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658292500;
        bh=5vzhpGX8fmWno6rwOq92v8lgd6QxkChZzesTFn3cSAQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dVTL8rtZlwaL5hXg64mWYqMCc2Dl7FGJr4n5NKXU21JjDkgYP5vEhxouK5VTw7fLo
         12i7UoSJci71UN51psBrIfdrbuZTB5k1G4NwE6Xb3yGiSWKyZUYnjUrnAF6kj1V8C9
         EOwTURjypj1s6Tx4m1XxkuyCZGwVOaCSZot9YUi+MIIUaAB6oyyjtO3oxVqfGvY0sI
         fBpo5p9I/1Ez4kaHIPjaFO/9oN+1W8jvCNM5e2KkemjhTETyuPWEdEJn4tuzPNnOPJ
         VXn50bTqnmG4tj+phXW44Ik/AIQ5+xUj+BghLy9aufU40CHZoDxQ6Kq1LeFI5lxt7r
         85sXK5is7gatg==
From:   Tzung-Bi Shih <tzungbi@kernel.org>
To:     bleung@chromium.org, groeck@chromium.org
Cc:     chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org,
        tzungbi@kernel.org
Subject: [PATCH 1/2] platform/chrome: merge Kunit utils and test cases
Date:   Wed, 20 Jul 2022 04:47:53 +0000
Message-Id: <20220720044754.4026295-2-tzungbi@kernel.org>
X-Mailer: git-send-email 2.37.0.170.g444d1eabd0-goog
In-Reply-To: <20220720044754.4026295-1-tzungbi@kernel.org>
References: <20220720044754.4026295-1-tzungbi@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Merge CROS_KUNIT and CROS_EC_PROTO_KUNIT_TEST so that when they're built
as modules cros_kunit_util doesn't need to export the symbols.

Signed-off-by: Tzung-Bi Shih <tzungbi@kernel.org>
---
 drivers/platform/chrome/Kconfig           | 10 ++--------
 drivers/platform/chrome/Makefile          |  5 +++--
 drivers/platform/chrome/cros_kunit_util.c | 14 --------------
 3 files changed, 5 insertions(+), 24 deletions(-)

diff --git a/drivers/platform/chrome/Kconfig b/drivers/platform/chrome/Kconfig
index cae859f0bc06..c45fb376d653 100644
--- a/drivers/platform/chrome/Kconfig
+++ b/drivers/platform/chrome/Kconfig
@@ -269,17 +269,11 @@ source "drivers/platform/chrome/wilco_ec/Kconfig"
 
 # Kunit test cases
 config CROS_KUNIT
-	tristate
-	help
-	  ChromeOS Kunit.
-
-config CROS_EC_PROTO_KUNIT_TEST
-	tristate "Kunit tests for ChromeOS EC protocol" if !KUNIT_ALL_TESTS
+	tristate "Kunit tests for ChromeOS" if !KUNIT_ALL_TESTS
 	depends on KUNIT && CROS_EC
 	default KUNIT_ALL_TESTS
 	select CROS_EC_PROTO
-	select CROS_KUNIT
 	help
-	  Kunit tests for the ChromeOS Embedded Controller protocol.
+	  ChromeOS Kunit tests.
 
 endif # CHROMEOS_PLATFORMS
diff --git a/drivers/platform/chrome/Makefile b/drivers/platform/chrome/Makefile
index a06bc56d12a8..f7e74a845afc 100644
--- a/drivers/platform/chrome/Makefile
+++ b/drivers/platform/chrome/Makefile
@@ -32,5 +32,6 @@ obj-$(CONFIG_CROS_USBPD_NOTIFY)		+= cros_usbpd_notify.o
 obj-$(CONFIG_WILCO_EC)			+= wilco_ec/
 
 # Kunit test cases
-obj-$(CONFIG_CROS_KUNIT)		+= cros_kunit_util.o
-obj-$(CONFIG_CROS_EC_PROTO_KUNIT_TEST)	+= cros_ec_proto_test.o
+obj-$(CONFIG_CROS_KUNIT)		+= cros_kunit.o
+cros_kunit-objs				:= cros_kunit_util.o
+cros_kunit-objs				+= cros_ec_proto_test.o
diff --git a/drivers/platform/chrome/cros_kunit_util.c b/drivers/platform/chrome/cros_kunit_util.c
index d37c334b416d..090927d43035 100644
--- a/drivers/platform/chrome/cros_kunit_util.c
+++ b/drivers/platform/chrome/cros_kunit_util.c
@@ -14,11 +14,8 @@
 #include "cros_kunit_util.h"
 
 int cros_kunit_ec_xfer_mock_default_ret;
-EXPORT_SYMBOL_GPL(cros_kunit_ec_xfer_mock_default_ret);
 int cros_kunit_ec_cmd_xfer_mock_called;
-EXPORT_SYMBOL_GPL(cros_kunit_ec_cmd_xfer_mock_called);
 int cros_kunit_ec_pkt_xfer_mock_called;
-EXPORT_SYMBOL_GPL(cros_kunit_ec_pkt_xfer_mock_called);
 
 static struct list_head cros_kunit_ec_xfer_mock_in;
 static struct list_head cros_kunit_ec_xfer_mock_out;
@@ -48,27 +45,23 @@ int cros_kunit_ec_xfer_mock(struct cros_ec_device *ec_dev, struct cros_ec_comman
 
 	return mock->ret;
 }
-EXPORT_SYMBOL_GPL(cros_kunit_ec_xfer_mock);
 
 int cros_kunit_ec_cmd_xfer_mock(struct cros_ec_device *ec_dev, struct cros_ec_command *msg)
 {
 	++cros_kunit_ec_cmd_xfer_mock_called;
 	return cros_kunit_ec_xfer_mock(ec_dev, msg);
 }
-EXPORT_SYMBOL_GPL(cros_kunit_ec_cmd_xfer_mock);
 
 int cros_kunit_ec_pkt_xfer_mock(struct cros_ec_device *ec_dev, struct cros_ec_command *msg)
 {
 	++cros_kunit_ec_pkt_xfer_mock_called;
 	return cros_kunit_ec_xfer_mock(ec_dev, msg);
 }
-EXPORT_SYMBOL_GPL(cros_kunit_ec_pkt_xfer_mock);
 
 struct ec_xfer_mock *cros_kunit_ec_xfer_mock_add(struct kunit *test, size_t size)
 {
 	return cros_kunit_ec_xfer_mock_addx(test, size, EC_RES_SUCCESS, size);
 }
-EXPORT_SYMBOL_GPL(cros_kunit_ec_xfer_mock_add);
 
 struct ec_xfer_mock *cros_kunit_ec_xfer_mock_addx(struct kunit *test,
 						  int ret, int result, size_t size)
@@ -91,7 +84,6 @@ struct ec_xfer_mock *cros_kunit_ec_xfer_mock_addx(struct kunit *test,
 
 	return mock;
 }
-EXPORT_SYMBOL_GPL(cros_kunit_ec_xfer_mock_addx);
 
 struct ec_xfer_mock *cros_kunit_ec_xfer_mock_next(void)
 {
@@ -103,14 +95,10 @@ struct ec_xfer_mock *cros_kunit_ec_xfer_mock_next(void)
 
 	return mock;
 }
-EXPORT_SYMBOL_GPL(cros_kunit_ec_xfer_mock_next);
 
 int cros_kunit_readmem_mock_offset;
-EXPORT_SYMBOL_GPL(cros_kunit_readmem_mock_offset);
 u8 *cros_kunit_readmem_mock_data;
-EXPORT_SYMBOL_GPL(cros_kunit_readmem_mock_data);
 int cros_kunit_readmem_mock_ret;
-EXPORT_SYMBOL_GPL(cros_kunit_readmem_mock_ret);
 
 int cros_kunit_readmem_mock(struct cros_ec_device *ec_dev, unsigned int offset,
 			    unsigned int bytes, void *dest)
@@ -121,7 +109,6 @@ int cros_kunit_readmem_mock(struct cros_ec_device *ec_dev, unsigned int offset,
 
 	return cros_kunit_readmem_mock_ret;
 }
-EXPORT_SYMBOL_GPL(cros_kunit_readmem_mock);
 
 void cros_kunit_mock_reset(void)
 {
@@ -135,6 +122,5 @@ void cros_kunit_mock_reset(void)
 	cros_kunit_readmem_mock_data = NULL;
 	cros_kunit_readmem_mock_ret = 0;
 }
-EXPORT_SYMBOL_GPL(cros_kunit_mock_reset);
 
 MODULE_LICENSE("GPL");
-- 
2.37.0.170.g444d1eabd0-goog

