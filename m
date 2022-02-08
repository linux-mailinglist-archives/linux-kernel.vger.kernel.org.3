Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFFB14AE23B
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 20:29:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386062AbiBHT3G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 14:29:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1386040AbiBHT3A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 14:29:00 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C142DC0612C0
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 11:28:59 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8A79BB81D41
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 19:28:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 804CAC340ED;
        Tue,  8 Feb 2022 19:28:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644348537;
        bh=+I0LZST9yYyXmAF3ot9pXLbyITDJi3AToihw/g6lgDI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AXz7VwgQ6hsVZWecCV8UeNubsSBQ3MyrR5rsrw628oJNZ/ZmQ1nG0Kuns+mHJPROk
         jKEzNwn+YjX0/1yBDVGWKRVZ5PS/JhqznHYPqpla223sU4ehUli/W1zFR9O09oAIJD
         ntjrfJKol008JQV7qbUgF6CBxKkTrnDUKPjRvnUqQ46AWfyoFpLEcN7PqUS2qvyVeF
         zhaZLa84X1z9i23eIlg4awMRMwk1ZPGY40yrYQRVeFm81sHwHL3thQfDAQcmW5PYJ6
         +nVpy5QcYMzUPelcj4hkh6Mla3yA8/sm3qJK/77BSXkkTJ9RymJZGb+iF8OMRbpIvp
         04yGAcNQGriAQ==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Tomer Tayar <ttayar@habana.ai>
Subject: [PATCH 2/4] habanalabs: enable stop-on-error debugfs setting per ASIC
Date:   Tue,  8 Feb 2022 21:28:48 +0200
Message-Id: <20220208192850.3526511-2-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220208192850.3526511-1-ogabbay@kernel.org>
References: <20220208192850.3526511-1-ogabbay@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tomer Tayar <ttayar@habana.ai>

On Goya and Gaudi, the stop-on-error configuration can be set via
debugfs. However, in future devices, this configuration will always be
enabled.
Modify the debugfs node to be allowed only for ASICs that support this
dynamic configuration.

Signed-off-by: Tomer Tayar <ttayar@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 Documentation/ABI/testing/debugfs-driver-habanalabs | 1 +
 drivers/misc/habanalabs/common/debugfs.c            | 6 ++++++
 drivers/misc/habanalabs/common/habanalabs.h         | 2 ++
 drivers/misc/habanalabs/gaudi/gaudi.c               | 2 ++
 drivers/misc/habanalabs/goya/goya.c                 | 2 ++
 5 files changed, 13 insertions(+)

diff --git a/Documentation/ABI/testing/debugfs-driver-habanalabs b/Documentation/ABI/testing/debugfs-driver-habanalabs
index 783001a574b3..bcf6915987e4 100644
--- a/Documentation/ABI/testing/debugfs-driver-habanalabs
+++ b/Documentation/ABI/testing/debugfs-driver-habanalabs
@@ -222,6 +222,7 @@ KernelVersion:  5.6
 Contact:        ogabbay@kernel.org
 Description:    Sets the stop-on_error option for the device engines. Value of
                 "0" is for disable, otherwise enable.
+                Relevant only for GOYA and GAUDI.
 
 What:           /sys/kernel/debug/habanalabs/hl<n>/timeout_locked
 Date:           Sep 2021
diff --git a/drivers/misc/habanalabs/common/debugfs.c b/drivers/misc/habanalabs/common/debugfs.c
index e3ee5f45d20c..9f0aaf0ef43b 100644
--- a/drivers/misc/habanalabs/common/debugfs.c
+++ b/drivers/misc/habanalabs/common/debugfs.c
@@ -1071,6 +1071,9 @@ static ssize_t hl_stop_on_err_read(struct file *f, char __user *buf,
 	char tmp_buf[200];
 	ssize_t rc;
 
+	if (!hdev->asic_prop.configurable_stop_on_err)
+		return -EOPNOTSUPP;
+
 	if (*ppos)
 		return 0;
 
@@ -1089,6 +1092,9 @@ static ssize_t hl_stop_on_err_write(struct file *f, const char __user *buf,
 	u32 value;
 	ssize_t rc;
 
+	if (!hdev->asic_prop.configurable_stop_on_err)
+		return -EOPNOTSUPP;
+
 	if (hdev->reset_info.in_reset) {
 		dev_warn_ratelimited(hdev->dev,
 				"Can't change stop on error during reset\n");
diff --git a/drivers/misc/habanalabs/common/habanalabs.h b/drivers/misc/habanalabs/common/habanalabs.h
index b06e2b0812b6..93116fe71ef6 100644
--- a/drivers/misc/habanalabs/common/habanalabs.h
+++ b/drivers/misc/habanalabs/common/habanalabs.h
@@ -561,6 +561,7 @@ struct hl_hints_range {
  *                              use-case of doing soft-reset in training (due
  *                              to the fact that training runs on multiple
  *                              devices)
+ * @configurable_stop_on_err: is stop-on-error option configurable via debugfs.
  */
 struct asic_fixed_properties {
 	struct hw_queue_properties	*hw_queues_props;
@@ -644,6 +645,7 @@ struct asic_fixed_properties {
 	u8				use_get_power_for_reset_history;
 	u8				supports_soft_reset;
 	u8				allow_inference_soft_reset;
+	u8				configurable_stop_on_err;
 };
 
 /**
diff --git a/drivers/misc/habanalabs/gaudi/gaudi.c b/drivers/misc/habanalabs/gaudi/gaudi.c
index f2242aa3baa2..61aa6dce6dde 100644
--- a/drivers/misc/habanalabs/gaudi/gaudi.c
+++ b/drivers/misc/habanalabs/gaudi/gaudi.c
@@ -669,6 +669,8 @@ static int gaudi_set_fixed_properties(struct hl_device *hdev)
 
 	prop->use_get_power_for_reset_history = true;
 
+	prop->configurable_stop_on_err = true;
+
 	return 0;
 }
 
diff --git a/drivers/misc/habanalabs/goya/goya.c b/drivers/misc/habanalabs/goya/goya.c
index 3785fb33260d..c8143b6616af 100644
--- a/drivers/misc/habanalabs/goya/goya.c
+++ b/drivers/misc/habanalabs/goya/goya.c
@@ -483,6 +483,8 @@ int goya_set_fixed_properties(struct hl_device *hdev)
 
 	prop->use_get_power_for_reset_history = true;
 
+	prop->configurable_stop_on_err = true;
+
 	return 0;
 }
 
-- 
2.25.1

