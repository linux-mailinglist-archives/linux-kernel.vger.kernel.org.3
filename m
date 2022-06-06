Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25D0353E63E
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 19:06:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239606AbiFFOMh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 10:12:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239623AbiFFOMJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 10:12:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7EFB1178
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 07:12:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EAB0961376
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 14:12:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70288C341C4;
        Mon,  6 Jun 2022 14:12:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654524727;
        bh=IDJd2ngMfd4ziS/HQIuZWqAxD2Z0NWrPdYp/crTIQBI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Tnck8GKIA4z72tw7EOxg2TJ9dtdwIWJEU6+HnqP9ucMo1TS8yNF84quIk2hiSNEVy
         8M7yaBeMySkSmJcn8vEoglnoIXe5SJbbVBp+Vl1iDgG4q/bZO/igKqD+d3TxP7+pXi
         V9FnMKqlOtQ3l1IAUhQWeXQVsnQ4Dqejvv4p73k6UF6zzY0fA/7CCJNcvnuQxQo1rE
         LRt8rAhPXietqhyRYLI5j4Tl26RlqJ6D6qk6VUOsXbDV5s0OnVV6IUWoSm4v1RnLhV
         8ecX8vTQkuTAuOCHsVWI/BR+zCG0pOASJ8HhZ5eo1SlEye4+O6QL1XZJMimx4qw+iL
         8DA74tJjeM9qw==
From:   Tzung-Bi Shih <tzungbi@kernel.org>
To:     bleung@chromium.org, groeck@chromium.org
Cc:     chrome-platform@lists.linux.dev, tzungbi@kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 09/13] platform/chrome: cros_ec_proto: use devm_krealloc()
Date:   Mon,  6 Jun 2022 14:10:47 +0000
Message-Id: <20220606141051.285823-10-tzungbi@kernel.org>
X-Mailer: git-send-email 2.36.1.255.ge46751e96f-goog
In-Reply-To: <20220606141051.285823-1-tzungbi@kernel.org>
References: <20220606141051.285823-1-tzungbi@kernel.org>
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

Use devm_krealloc() to re-allocate `din` and `dout`.

Also remove the unneeded devm_kfree() in error handling path as they are
device managed memory.

Signed-off-by: Tzung-Bi Shih <tzungbi@kernel.org>
---
 drivers/platform/chrome/cros_ec_proto.c      | 25 ++++++--------------
 drivers/platform/chrome/cros_ec_proto_test.c |  3 +--
 2 files changed, 8 insertions(+), 20 deletions(-)

diff --git a/drivers/platform/chrome/cros_ec_proto.c b/drivers/platform/chrome/cros_ec_proto.c
index abb30a685567..5f4414f05d66 100644
--- a/drivers/platform/chrome/cros_ec_proto.c
+++ b/drivers/platform/chrome/cros_ec_proto.c
@@ -479,21 +479,13 @@ int cros_ec_query_all(struct cros_ec_device *ec_dev)
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
+	ec_dev->din = devm_krealloc(dev, ec_dev->din, ec_dev->din_size, GFP_KERNEL | __GFP_ZERO);
+	if (!ec_dev->din)
+		return -ENOMEM;
 
-	ec_dev->dout = devm_kzalloc(dev, ec_dev->dout_size, GFP_KERNEL);
-	if (!ec_dev->dout) {
-		devm_kfree(dev, ec_dev->din);
-		ret = -ENOMEM;
-		goto exit;
-	}
+	ec_dev->dout = devm_krealloc(dev, ec_dev->dout, ec_dev->dout_size, GFP_KERNEL | __GFP_ZERO);
+	if (!ec_dev->dout)
+		return -ENOMEM;
 
 	/* Probe if MKBP event is supported */
 	ret = cros_ec_get_host_command_version_mask(ec_dev,
@@ -542,10 +534,7 @@ int cros_ec_query_all(struct cros_ec_device *ec_dev)
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
index 79150bf511fb..22f9322787f4 100644
--- a/drivers/platform/chrome/cros_ec_proto_test.c
+++ b/drivers/platform/chrome/cros_ec_proto_test.c
@@ -180,8 +180,7 @@ static void cros_ec_proto_test_query_all_pretest(struct kunit *test)
 
 	/*
 	 * cros_ec_query_all() will free din and dout and allocate them again to fit the usage by
-	 * calling devm_kfree() and devm_kzalloc().  Set them to NULL as they aren't managed by
-	 * ec_dev->dev.
+	 * calling devm_krealloc().  Set them to NULL as they aren't managed by ec_dev->dev.
 	 */
 	ec_dev->din = NULL;
 	ec_dev->dout = NULL;
-- 
2.36.1.255.ge46751e96f-goog

