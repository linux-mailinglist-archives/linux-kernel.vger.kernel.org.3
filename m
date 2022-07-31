Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A92D1585E86
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Jul 2022 12:51:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236487AbiGaKvE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Jul 2022 06:51:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234690AbiGaKuu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Jul 2022 06:50:50 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C02FF11820
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jul 2022 03:50:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id A97F2CE0E54
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jul 2022 10:50:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23808C433D6;
        Sun, 31 Jul 2022 10:50:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659264645;
        bh=VtEsSiV656Ya2AG7KrEC96VqMVryBOdbrqBclir5X1Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aTzVNqIBIN8J+XRM1oyb8SToi0SJLDS7Epl7wKvVRMxWxXoRx4Xn1ubhT1Cxfn4mk
         R/nGPwO2tqFEcegWZm8U2fsYZkx5RHZbzJhE1+Cb8a5teBQye5n/9xyq24hkfwow1r
         fkaCquJ/Lrl1y1IQjvXXsnaCjDaArXxmw/wEWRwVHvD57rpQD07CwQqhgQFSVWnkPn
         T0vAWnNt7Z4u3Au3Xo9WysjNDOqUZWdxtZ9msa2inq9yLTIhK0zbQnSxSRsO/ELROU
         4nPftr404T2ZxZDEv26olRAaE0ZF40Nz9XAUlSpRqtFcQsm6yoWNKNIY8LNz+nglqE
         D18nQUNXMUo1g==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Tal Cohen <talcohen@habana.ai>
Subject: [PATCH 3/8] habanalabs: fix command submission sanity check
Date:   Sun, 31 Jul 2022 13:50:32 +0300
Message-Id: <20220731105037.545106-3-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220731105037.545106-1-ogabbay@kernel.org>
References: <20220731105037.545106-1-ogabbay@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tal Cohen <talcohen@habana.ai>

When a CS is submitted, the ioctl handler checks the CS
flags and performs a sanity check, according to its value.
As new CS flags are added, the sanity check needs to be updated
according to the new flags.

Signed-off-by: Tal Cohen <talcohen@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 .../misc/habanalabs/common/command_submission.c    | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/misc/habanalabs/common/command_submission.c b/drivers/misc/habanalabs/common/command_submission.c
index 90a4574cbe2d..304e4f3b0e7e 100644
--- a/drivers/misc/habanalabs/common/command_submission.c
+++ b/drivers/misc/habanalabs/common/command_submission.c
@@ -12,7 +12,9 @@
 #include <linux/slab.h>
 
 #define HL_CS_FLAGS_TYPE_MASK	(HL_CS_FLAGS_SIGNAL | HL_CS_FLAGS_WAIT | \
-					HL_CS_FLAGS_COLLECTIVE_WAIT)
+			HL_CS_FLAGS_COLLECTIVE_WAIT | HL_CS_FLAGS_RESERVE_SIGNALS_ONLY | \
+			HL_CS_FLAGS_UNRESERVE_SIGNALS_ONLY)
+
 
 #define MAX_TS_ITER_NUM 10
 
@@ -1253,6 +1255,7 @@ static int hl_cs_sanity_checks(struct hl_fpriv *hpriv, union hl_cs_args *args)
 	u32 cs_type_flags, num_chunks;
 	enum hl_device_status status;
 	enum hl_cs_type cs_type;
+	bool is_sync_stream;
 
 	if (!hl_device_operational(hdev, &status)) {
 		return -EBUSY;
@@ -1276,9 +1279,10 @@ static int hl_cs_sanity_checks(struct hl_fpriv *hpriv, union hl_cs_args *args)
 	cs_type = hl_cs_get_cs_type(cs_type_flags);
 	num_chunks = args->in.num_chunks_execute;
 
-	if (unlikely((cs_type == CS_TYPE_SIGNAL || cs_type == CS_TYPE_WAIT ||
-			cs_type == CS_TYPE_COLLECTIVE_WAIT) &&
-			!hdev->supports_sync_stream)) {
+	is_sync_stream = (cs_type == CS_TYPE_SIGNAL || cs_type == CS_TYPE_WAIT ||
+			cs_type == CS_TYPE_COLLECTIVE_WAIT);
+
+	if (unlikely(is_sync_stream && !hdev->supports_sync_stream)) {
 		dev_err(hdev->dev, "Sync stream CS is not supported\n");
 		return -EINVAL;
 	}
@@ -1288,7 +1292,7 @@ static int hl_cs_sanity_checks(struct hl_fpriv *hpriv, union hl_cs_args *args)
 			dev_err(hdev->dev, "Got execute CS with 0 chunks, context %d\n", ctx->asid);
 			return -EINVAL;
 		}
-	} else if (num_chunks != 1) {
+	} else if (is_sync_stream && num_chunks != 1) {
 		dev_err(hdev->dev,
 			"Sync stream CS mandates one chunk only, context %d\n",
 			ctx->asid);
-- 
2.25.1

