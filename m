Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 168DA551C1C
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 15:48:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344376AbiFTNS5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 09:18:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345294AbiFTNOT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 09:14:19 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AF171FCDE
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 06:06:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 5A2D4CE1395
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 13:04:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F271DC3411C;
        Mon, 20 Jun 2022 13:04:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655730290;
        bh=EkiVmwPNEg3FOzf15e9eFLF0yMH/4A+tHea5lErg9qs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=buWOlcul2r5sjtIUpIQJEVZXtEDcHaj+G07vJWJMYiIV712MtZ1F9hgx8fQBbn39Q
         hXHQFTlDJ+NYj1Ybu3jYFSRC7xLLZUdslaTce58blhs3Bd5eYciWiYmmL5ItCi9coj
         3tlV4vleC77OoPFFY9UuxH7rVVgXINaI7W3KSdYLiObE60LTAcFoEVaBn2jJitqaYX
         L9rdhO/je0oFB9R1PrRVnu6c7lrr/ra6ooZ1Fj+saFzzOvXHOljLyb/5DzfnOWRzq8
         KpyG/TUznu3xNjU/Lk9rr7/8Or0V/1+TUn2NJnQYZizsbUhkzLwrX/ivmkNLVgC5Jz
         FqLsq2xRpxlkg==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Yuri Nudelman <ynudelman@habana.ai>
Subject: [PATCH 10/17] habanalabs: fix NULL dereference on cs timeout
Date:   Mon, 20 Jun 2022 16:04:25 +0300
Message-Id: <20220620130432.1180451-10-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220620130432.1180451-1-ogabbay@kernel.org>
References: <20220620130432.1180451-1-ogabbay@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yuri Nudelman <ynudelman@habana.ai>

Device descriptor is accessed before an assignment

Signed-off-by: Yuri Nudelman <ynudelman@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/common/command_submission.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/misc/habanalabs/common/command_submission.c b/drivers/misc/habanalabs/common/command_submission.c
index 72a557b83a7d..c050f38b7091 100644
--- a/drivers/misc/habanalabs/common/command_submission.c
+++ b/drivers/misc/habanalabs/common/command_submission.c
@@ -812,6 +812,8 @@ static void cs_timedout(struct work_struct *work)
 		return;
 	}
 
+	hdev = cs->ctx->hdev;
+
 	if (likely(!skip_reset_on_timeout)) {
 		if (hdev->reset_on_lockup)
 			device_reset = true;
@@ -822,8 +824,6 @@ static void cs_timedout(struct work_struct *work)
 		cs->timedout = true;
 	}
 
-	hdev = cs->ctx->hdev;
-
 	/* Save only the first CS timeout parameters */
 	rc = atomic_cmpxchg(&hdev->last_error.cs_timeout.write_enable, 1, 0);
 	if (rc) {
-- 
2.25.1

