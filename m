Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D586585E8A
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Jul 2022 12:51:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236677AbiGaKvH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Jul 2022 06:51:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232065AbiGaKuv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Jul 2022 06:50:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BBA411820
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jul 2022 03:50:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BCB7160B3D
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jul 2022 10:50:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87FCAC433C1
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jul 2022 10:50:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659264650;
        bh=pROq9rEzNTOI1fzW6NoVSP+vx6+vZTNKn/lRRqVRxgA=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=FnTXZbRacWQ4+KSG+v5QdlnsbS8TfdfrAof3aogUgVW+XACFbfEpnF92ea3csdfRw
         LuQeGDVgu3WmdPM0URGn7e445szl9BUSyKG8MxtnYafbrRaiT+nNjmezVfl1prblwL
         9PsORsEfIZUJpBxws9Um9XdE3GAdR2Z3G9lw/rxEOgBlAG7wQHTjKtmKOhlHOObT3i
         mQH0PvZmKcC1r/L4BAIaW+Ax9A6CgOvBF50c0QXRRF0uFXJn5bo4pn35dIIbcxny70
         C/DoPKeuBYBepYZZDVp+B5EPQj9mcbmpRpWuyl84J7iMqqCC+SVme5vLz4P2c7sMZV
         qF9Q34U0cOMSw==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Subject: [PATCH 7/8] habanalabs/uapi: move defines to better place inside file
Date:   Sun, 31 Jul 2022 13:50:36 +0300
Message-Id: <20220731105037.545106-7-ogabbay@kernel.org>
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

Cosmetic change to move the eventfd events defines to a better
location in the file, closer to other INFO IOCTL defines.

Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 include/uapi/misc/habanalabs.h | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/include/uapi/misc/habanalabs.h b/include/uapi/misc/habanalabs.h
index 83ca6f40f4ba..0da8894ab94a 100644
--- a/include/uapi/misc/habanalabs.h
+++ b/include/uapi/misc/habanalabs.h
@@ -707,6 +707,21 @@ enum hl_server_type {
 	HL_SERVER_GAUDI2_HLS2 = 5
 };
 
+/*
+ * Notifier event values - for the notification mechanism and the HL_INFO_GET_EVENTS command
+ *
+ * HL_NOTIFIER_EVENT_TPC_ASSERT		- Indicates TPC assert event
+ * HL_NOTIFIER_EVENT_UNDEFINED_OPCODE	- Indicates undefined operation code
+ * HL_NOTIFIER_EVENT_DEVICE_RESET	- Indicates device requires a reset
+ * HL_NOTIFIER_EVENT_CS_TIMEOUT		- Indicates CS timeout error
+ * HL_NOTIFIER_EVENT_DEVICE_UNAVAILABLE	- Indicates device is unavailable
+ */
+#define HL_NOTIFIER_EVENT_TPC_ASSERT		(1ULL << 0)
+#define HL_NOTIFIER_EVENT_UNDEFINED_OPCODE	(1ULL << 1)
+#define HL_NOTIFIER_EVENT_DEVICE_RESET		(1ULL << 2)
+#define HL_NOTIFIER_EVENT_CS_TIMEOUT		(1ULL << 3)
+#define HL_NOTIFIER_EVENT_DEVICE_UNAVAILABLE	(1ULL << 4)
+
 /* Opcode for management ioctl
  *
  * HW_IP_INFO            - Receive information about different IP blocks in the
@@ -1883,21 +1898,6 @@ struct hl_debug_args {
 	__u32 ctx_id;
 };
 
-/*
- * Notifier event values - for the notification mechanism and the HL_INFO_GET_EVENTS command
- *
- * HL_NOTIFIER_EVENT_TPC_ASSERT		- Indicates TPC assert event
- * HL_NOTIFIER_EVENT_UNDEFINED_OPCODE	- Indicates undefined operation code
- * HL_NOTIFIER_EVENT_DEVICE_RESET	- Indicates device requires a reset
- * HL_NOTIFIER_EVENT_CS_TIMEOUT		- Indicates CS timeout error
- * HL_NOTIFIER_EVENT_DEVICE_UNAVAILABLE	- Indicates device is unavailable
- */
-#define HL_NOTIFIER_EVENT_TPC_ASSERT		(1ULL << 0)
-#define HL_NOTIFIER_EVENT_UNDEFINED_OPCODE	(1ULL << 1)
-#define HL_NOTIFIER_EVENT_DEVICE_RESET		(1ULL << 2)
-#define HL_NOTIFIER_EVENT_CS_TIMEOUT		(1ULL << 3)
-#define HL_NOTIFIER_EVENT_DEVICE_UNAVAILABLE	(1ULL << 4)
-
 /*
  * Various information operations such as:
  * - H/W IP information
-- 
2.25.1

