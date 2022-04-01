Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 001044EED05
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 14:21:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345839AbiDAMW1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Apr 2022 08:22:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345820AbiDAMWT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 08:22:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84271278546
        for <linux-kernel@vger.kernel.org>; Fri,  1 Apr 2022 05:20:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1F70461766
        for <linux-kernel@vger.kernel.org>; Fri,  1 Apr 2022 12:20:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE622C340EC
        for <linux-kernel@vger.kernel.org>; Fri,  1 Apr 2022 12:20:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648815629;
        bh=bv4ai29WIvi/ELGyR4yjSriIpSdWNprpTDF3XEOVCp8=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=dI2B5VPxbg4U1m8Sa5adTMLDAyOvqyOK1deMeWe035676cpxjL6tdXlfrLIziT7zM
         FaAYBmnPYHOPCvkD9EwlUPrnOdErSBB+brGZYw6kwHKuTXS80Xw9SaPOzX4G8EmG91
         AbSvkI+G18r0u06vV4WNHphRRByFaBFLjvnhOixRgqdf2swvYpD+CGgK8pOnWcIFGG
         l55D2JPCPmgeYBlndWmIub/4FZVH2KCi8qX8MkJhuMMpFZgzLqSBmlsbW4FgMTHCRj
         Th4k0xcG1z8v3SsmjUrWonMM/abNMiPbzZcLDP6dL8/U6lxMdrCC+A4XYPAPiY4bZc
         eMtIOEwLxsJCw==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Subject: [PATCH 6/7] habanalabs: remove redundant info print
Date:   Fri,  1 Apr 2022 15:20:16 +0300
Message-Id: <20220401122017.116205-6-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220401122017.116205-1-ogabbay@kernel.org>
References: <20220401122017.116205-1-ogabbay@kernel.org>
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

Halting compute engines is a print that doesn't add us any information
because it is always done in the reset process and not used elsewhere.

Even if it was, we don't use prints to mark functions we passed
through.

Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/gaudi/gaudi.c | 3 ---
 drivers/misc/habanalabs/goya/goya.c   | 3 ---
 2 files changed, 6 deletions(-)

diff --git a/drivers/misc/habanalabs/gaudi/gaudi.c b/drivers/misc/habanalabs/gaudi/gaudi.c
index bacb2f1df81e..33f7cfea53ae 100644
--- a/drivers/misc/habanalabs/gaudi/gaudi.c
+++ b/drivers/misc/habanalabs/gaudi/gaudi.c
@@ -3795,9 +3795,6 @@ static void gaudi_halt_engines(struct hl_device *hdev, bool hard_reset, bool fw_
 {
 	u32 wait_timeout_ms;
 
-	dev_info(hdev->dev,
-		"Halting compute engines and disabling interrupts\n");
-
 	if (hdev->pldm)
 		wait_timeout_ms = GAUDI_PLDM_RESET_WAIT_MSEC;
 	else
diff --git a/drivers/misc/habanalabs/goya/goya.c b/drivers/misc/habanalabs/goya/goya.c
index d75a180cf5bb..8572b178ef7d 100644
--- a/drivers/misc/habanalabs/goya/goya.c
+++ b/drivers/misc/habanalabs/goya/goya.c
@@ -2482,9 +2482,6 @@ static void goya_halt_engines(struct hl_device *hdev, bool hard_reset, bool fw_r
 {
 	u32 wait_timeout_ms;
 
-	dev_info(hdev->dev,
-		"Halting compute engines and disabling interrupts\n");
-
 	if (hdev->pldm)
 		wait_timeout_ms = GOYA_PLDM_RESET_WAIT_MSEC;
 	else
-- 
2.25.1

