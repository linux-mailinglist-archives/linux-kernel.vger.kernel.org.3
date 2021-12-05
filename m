Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E464C468BF5
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Dec 2021 16:44:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235848AbhLEPrG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Dec 2021 10:47:06 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:41148 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236316AbhLEPqN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Dec 2021 10:46:13 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DF3A060FC1
        for <linux-kernel@vger.kernel.org>; Sun,  5 Dec 2021 15:42:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC0D4C341C5
        for <linux-kernel@vger.kernel.org>; Sun,  5 Dec 2021 15:42:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638718965;
        bh=fMFA0jy2udX+yJGSPQ5FR1cJnxV732rrPLMj8ZGVpyE=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=fxZiR9nKpVYryw1x5xQeDbN9vciOH9AnFBcs/jG6PMD9EWc+NBqkbU6MZF2QnLoLE
         bwOBEWQl5SHc9/Ec0Ukgt1fy/EvT/oZ6EFq1P1n5KAZiMhQRZ76bIH1KVy0yQAyv56
         L8/tsKHaksrQXvP3pFiKvoF+Ox2OJA24mYXFIxRK+GgBrCmSEXaP7j1fRSfXlmFT7X
         vF/0rcVYLohVUGs93Pfy4XMEN8wdj1GSinMnS8fTPt8tGhsm7dA6AiCv62keiHSXXc
         LwsLsNDBIukntcSO4/HsgEdLBOZ4n5OYx58COeH6YOkb/kKR/9HhduHu2vOHEgGDaA
         bngD3ccivp29A==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Subject: [PATCH 4/9] habanalabs: remove redundant check on ctx_fini
Date:   Sun,  5 Dec 2021 17:42:31 +0200
Message-Id: <20211205154236.2198481-4-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211205154236.2198481-1-ogabbay@kernel.org>
References: <20211205154236.2198481-1-ogabbay@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver supports only a single context. Therefore, no need to check
if the user context that is closed is the compute context. The user
context, if exists, is always the compute context.

Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/common/context.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/misc/habanalabs/common/context.c b/drivers/misc/habanalabs/common/context.c
index d0aaccd4df2c..4f7d39a29a42 100644
--- a/drivers/misc/habanalabs/common/context.c
+++ b/drivers/misc/habanalabs/common/context.c
@@ -97,10 +97,8 @@ static void hl_ctx_fini(struct hl_ctx *ctx)
 		/* The engines are stopped as there is no executing CS, but the
 		 * Coresight might be still working by accessing addresses
 		 * related to the stopped engines. Hence stop it explicitly.
-		 * Stop only if this is the compute context, as there can be
-		 * only one compute context
 		 */
-		if ((hdev->in_debug) && (hdev->compute_ctx == ctx))
+		if (hdev->in_debug)
 			hl_device_set_debug_mode(hdev, false);
 
 		hdev->asic_funcs->ctx_fini(ctx);
-- 
2.25.1

