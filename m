Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD06A5401EA
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 16:58:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343694AbiFGO55 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 10:57:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343596AbiFGO5I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 10:57:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1439880D3
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 07:57:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4F398615EF
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 14:57:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1783C341C0;
        Tue,  7 Jun 2022 14:57:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654613826;
        bh=RsRt4zJOLLD5770xdMq4lbIpy/paj4pkR+wTq7ZZzyg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ko5q1akSvj+aWFqut/4sW6bflXgU17PdO9xNwY9LwX7y7waIWV1AMcZtrCGUDRDEe
         dNI8xKg2zYYfg9KoYMjl2j0pmO4/pdEHYLc4hM3h9bm40cxx/sRLw1TJyPsd55GX/v
         zpRIjrMNT2Lu8PQG0Osp5WVFVdNaQW7GkL39LATns8GrM8gAt5aAAtShJIFHoE+dyz
         UzR803ohflf2t5Qn85Sd2gwL2PuHAnCyNPZ1WTs2CcD/o6lMD79e9Z3soKG0CYTpi1
         AL0L+wt5Sq5jqTF9Tb3STmJnJyW/lhJRRDqAURPj0yQr7gsFDAdB9oBe68WSRlSoaT
         q2rllYEEeg+iQ==
From:   Tzung-Bi Shih <tzungbi@kernel.org>
To:     bleung@chromium.org, groeck@chromium.org
Cc:     chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org,
        tzungbi@kernel.org
Subject: [PATCH v2 12/15] platform/chrome: use krealloc() for `din` and `dout`
Date:   Tue,  7 Jun 2022 14:56:36 +0000
Message-Id: <20220607145639.2362750-13-tzungbi@kernel.org>
X-Mailer: git-send-email 2.36.1.255.ge46751e96f-goog
In-Reply-To: <20220607145639.2362750-1-tzungbi@kernel.org>
References: <20220607145639.2362750-1-tzungbi@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use krealloc() to re-allocate `din` and `dout`.  Don't use devm variant
because the two buffers could be re-allocated multiple times during
runtime.  Their life cycles aren't quite aligned to the device's.

Free the memory in cros_ec_unregister() if any.

No need to free memory if krealloc() fails.  They will be freed
eventually in either of the following:
- Error handling path in cros_ec_register().
- In cros_ec_unregister().
- Next krealloc() in cros_ec_query_all().

Signed-off-by: Tzung-Bi Shih <tzungbi@kernel.org>
---
Changes from v1:
- Don't use devm.
- Free in cros_ec_unregister().

 drivers/platform/chrome/cros_ec.c            |  4 +++
 drivers/platform/chrome/cros_ec_proto.c      | 29 +++++++-------------
 drivers/platform/chrome/cros_ec_proto_test.c |  3 +-
 3 files changed, 15 insertions(+), 21 deletions(-)

diff --git a/drivers/platform/chrome/cros_ec.c b/drivers/platform/chrome/cros_ec.c
index 29d3b544dafb..fb8cb8a73295 100644
--- a/drivers/platform/chrome/cros_ec.c
+++ b/drivers/platform/chrome/cros_ec.c
@@ -285,6 +285,8 @@ int cros_ec_register(struct cros_ec_device *ec_dev)
 exit:
 	platform_device_unregister(ec_dev->ec);
 	platform_device_unregister(ec_dev->pd);
+	kfree(ec_dev->din);
+	kfree(ec_dev->dout);
 	return err;
 }
 EXPORT_SYMBOL(cros_ec_register);
@@ -302,6 +304,8 @@ void cros_ec_unregister(struct cros_ec_device *ec_dev)
 	if (ec_dev->pd)
 		platform_device_unregister(ec_dev->pd);
 	platform_device_unregister(ec_dev->ec);
+	kfree(ec_dev->din);
+	kfree(ec_dev->dout);
 }
 EXPORT_SYMBOL(cros_ec_unregister);
 
diff --git a/drivers/platform/chrome/cros_ec_proto.c b/drivers/platform/chrome/cros_ec_proto.c
index 473654f50bca..de6bc457e496 100644
--- a/drivers/platform/chrome/cros_ec_proto.c
+++ b/drivers/platform/chrome/cros_ec_proto.c
@@ -469,9 +469,9 @@ static int cros_ec_get_host_command_version_mask(struct cros_ec_device *ec_dev,
  */
 int cros_ec_query_all(struct cros_ec_device *ec_dev)
 {
-	struct device *dev = ec_dev->dev;
 	u32 ver_mask = 0;
 	int ret;
+	u8 *din, *dout;
 
 	/* First try sending with proto v3. */
 	if (!cros_ec_get_proto_info(ec_dev, CROS_EC_DEV_EC_INDEX)) {
@@ -492,21 +492,15 @@ int cros_ec_query_all(struct cros_ec_device *ec_dev)
 		}
 	}
 
-	devm_kfree(dev, ec_dev->din);
-	devm_kfree(dev, ec_dev->dout);
-
-	ec_dev->din = devm_kzalloc(dev, ec_dev->din_size, GFP_KERNEL);
-	if (!ec_dev->din) {
-		ret = -ENOMEM;
-		goto exit;
-	}
+	din = krealloc(ec_dev->din, ec_dev->din_size, GFP_KERNEL);
+	if (!din)
+		return -ENOMEM;
+	ec_dev->din = din;
 
-	ec_dev->dout = devm_kzalloc(dev, ec_dev->dout_size, GFP_KERNEL);
-	if (!ec_dev->dout) {
-		devm_kfree(dev, ec_dev->din);
-		ret = -ENOMEM;
-		goto exit;
-	}
+	dout = krealloc(ec_dev->dout, ec_dev->dout_size, GFP_KERNEL);
+	if (!dout)
+		return -ENOMEM;
+	ec_dev->dout = dout;
 
 	/* Probe if MKBP event is supported */
 	ret = cros_ec_get_host_command_version_mask(ec_dev,
@@ -555,10 +549,7 @@ int cros_ec_query_all(struct cros_ec_device *ec_dev)
 				"failed to retrieve wake mask: %d\n", ret);
 	}
 
-	ret = 0;
-
-exit:
-	return ret;
+	return 0;
 }
 EXPORT_SYMBOL(cros_ec_query_all);
 
diff --git a/drivers/platform/chrome/cros_ec_proto_test.c b/drivers/platform/chrome/cros_ec_proto_test.c
index 730248be42a7..27b81a5a9880 100644
--- a/drivers/platform/chrome/cros_ec_proto_test.c
+++ b/drivers/platform/chrome/cros_ec_proto_test.c
@@ -180,8 +180,7 @@ static void cros_ec_proto_test_query_all_pretest(struct kunit *test)
 
 	/*
 	 * cros_ec_query_all() will free din and dout and allocate them again to fit the usage by
-	 * calling devm_kfree() and devm_kzalloc().  Set them to NULL as they aren't managed by
-	 * ec_dev->dev.
+	 * calling krealloc().  Set them to NULL as they aren't allocated by kalloc().
 	 */
 	ec_dev->din = NULL;
 	ec_dev->dout = NULL;
-- 
2.36.1.255.ge46751e96f-goog

