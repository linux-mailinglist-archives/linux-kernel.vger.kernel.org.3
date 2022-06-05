Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DC7753DB46
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Jun 2022 12:35:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351015AbiFEKdn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Jun 2022 06:33:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245661AbiFEKd3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jun 2022 06:33:29 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A7F0205FB
        for <linux-kernel@vger.kernel.org>; Sun,  5 Jun 2022 03:33:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0D568B80B83
        for <linux-kernel@vger.kernel.org>; Sun,  5 Jun 2022 10:33:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05C96C3411C;
        Sun,  5 Jun 2022 10:33:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654425205;
        bh=E67nVJSgms7lKGXIFX2+nf8+3sJRF3vxUDwXV7sv7uM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SRLJr4zitDLeiTE+UbJWmg2euQfduENkpbjiJ8m82a/Crkva8ewq4sXJF6yFqyjz7
         NJ7xrDYupgam2ShI/imwP84YnLQLecxilZXxPpMTXKHkXUFncwTZeqZADh/yhkN5aj
         BEJzGEXkXlWeWjc4cRgILYp3KLqmIIWew3T5pTdUGSeT5SNlKsQA4WCzwxtawYAIlH
         bEfD+pHTU+b/lf5rp+N+6dnywfz0L7oxxZiIdyIAMK7TqqxBo2oX0Upn4wc0YX5ZO0
         35eOd0qNgGpAix3RsoV3cf7RsrWJ8ybheUtEZy5nE/cadVjrImnlbi8fhA8Q0AVwLf
         hn9HzMbTK+Vaw==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Tal Cohen <talcohen@habana.ai>
Subject: [PATCH 4/7] habanalabs: change the write flag name of error info structs
Date:   Sun,  5 Jun 2022 13:33:13 +0300
Message-Id: <20220605103316.3414541-4-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220605103316.3414541-1-ogabbay@kernel.org>
References: <20220605103316.3414541-1-ogabbay@kernel.org>
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

From: Tal Cohen <talcohen@habana.ai>

positive flags naming will make more clear code while adding
more 'error info' structures

Signed-off-by: Tal Cohen <talcohen@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/common/command_submission.c |  4 ++--
 drivers/misc/habanalabs/common/habanalabs.h         | 12 ++++++------
 drivers/misc/habanalabs/common/habanalabs_drv.c     |  4 ++--
 drivers/misc/habanalabs/gaudi/gaudi.c               |  4 ++--
 4 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/misc/habanalabs/common/command_submission.c b/drivers/misc/habanalabs/common/command_submission.c
index fb30b7de4aab..22109be06139 100644
--- a/drivers/misc/habanalabs/common/command_submission.c
+++ b/drivers/misc/habanalabs/common/command_submission.c
@@ -735,8 +735,8 @@ static void cs_timedout(struct work_struct *work)
 	hdev = cs->ctx->hdev;
 
 	/* Save only the first CS timeout parameters */
-	rc = atomic_cmpxchg(&hdev->last_error.cs_timeout.write_disable, 0, 1);
-	if (!rc) {
+	rc = atomic_cmpxchg(&hdev->last_error.cs_timeout.write_enable, 1, 0);
+	if (rc) {
 		hdev->last_error.cs_timeout.timestamp = ktime_get();
 		hdev->last_error.cs_timeout.seq = cs->sequence;
 	}
diff --git a/drivers/misc/habanalabs/common/habanalabs.h b/drivers/misc/habanalabs/common/habanalabs.h
index b0b0f3f89865..7a46f36518fe 100644
--- a/drivers/misc/habanalabs/common/habanalabs.h
+++ b/drivers/misc/habanalabs/common/habanalabs.h
@@ -2570,21 +2570,21 @@ struct hl_clk_throttle {
 /**
  * struct cs_timeout_info - info of last CS timeout occurred.
  * @timestamp: CS timeout timestamp.
- * @write_disable: if set writing to CS parameters in the structure is disabled so,
- *                 the first (root cause) CS timeout will not be overwritten.
+ * @write_enable: if set writing to CS parameters in the structure is enabled. otherwise - disabled,
+ *                so the first (root cause) CS timeout will not be overwritten.
  * @seq: CS timeout sequence number.
  */
 struct cs_timeout_info {
 	ktime_t		timestamp;
-	atomic_t	write_disable;
+	atomic_t	write_enable;
 	u64		seq;
 };
 
 /**
  * struct razwi_info - info about last razwi error occurred.
  * @timestamp: razwi timestamp.
- * @write_disable: if set writing to razwi parameters in the structure is disabled so the
- *                 first (root cause) razwi will not be overwritten.
+ * @write_enable: if set writing to razwi parameters in the structure is enabled.
+ *                otherwise - disabled, so the first (root cause) razwi will not be overwritten.
  * @addr: address that caused razwi.
  * @engine_id_1: engine id of the razwi initiator, if it was initiated by engine that does
  *               not have engine id it will be set to U16_MAX.
@@ -2596,7 +2596,7 @@ struct cs_timeout_info {
  */
 struct razwi_info {
 	ktime_t		timestamp;
-	atomic_t	write_disable;
+	atomic_t	write_enable;
 	u64		addr;
 	u16		engine_id_1;
 	u16		engine_id_2;
diff --git a/drivers/misc/habanalabs/common/habanalabs_drv.c b/drivers/misc/habanalabs/common/habanalabs_drv.c
index 37edb69a7255..e182637c2d93 100644
--- a/drivers/misc/habanalabs/common/habanalabs_drv.c
+++ b/drivers/misc/habanalabs/common/habanalabs_drv.c
@@ -195,8 +195,8 @@ int hl_device_open(struct inode *inode, struct file *filp)
 
 	hl_debugfs_add_file(hpriv);
 
-	atomic_set(&hdev->last_error.cs_timeout.write_disable, 0);
-	atomic_set(&hdev->last_error.razwi.write_disable, 0);
+	atomic_set(&hdev->last_error.cs_timeout.write_enable, 1);
+	atomic_set(&hdev->last_error.razwi.write_enable, 1);
 
 	hdev->open_counter++;
 	hdev->last_successful_open_jif = jiffies;
diff --git a/drivers/misc/habanalabs/gaudi/gaudi.c b/drivers/misc/habanalabs/gaudi/gaudi.c
index 4db5f6ef96f1..c16c0f9fe202 100644
--- a/drivers/misc/habanalabs/gaudi/gaudi.c
+++ b/drivers/misc/habanalabs/gaudi/gaudi.c
@@ -7410,8 +7410,8 @@ static void gaudi_print_irq_info(struct hl_device *hdev, u16 event_type,
 		gaudi_print_and_get_mmu_error_info(hdev, &razwi_addr, &razwi_type);
 
 		/* In case it's the first razwi, save its parameters*/
-		rc = atomic_cmpxchg(&hdev->last_error.razwi.write_disable, 0, 1);
-		if (!rc) {
+		rc = atomic_cmpxchg(&hdev->last_error.razwi.write_enable, 1, 0);
+		if (rc) {
 			hdev->last_error.razwi.timestamp = ktime_get();
 			hdev->last_error.razwi.addr = razwi_addr;
 			hdev->last_error.razwi.engine_id_1 = engine_id_1;
-- 
2.25.1

