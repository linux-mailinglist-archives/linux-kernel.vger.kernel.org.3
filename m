Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF7495650CA
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 11:30:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233758AbiGDJaU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 05:30:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233685AbiGDJaB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 05:30:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EBF163DD
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jul 2022 02:29:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 92A8D61414
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jul 2022 09:29:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CCDBC341CA;
        Mon,  4 Jul 2022 09:29:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656926995;
        bh=LDP+ILSGYCIH0SJedjmGJb06qbh5AOxjPgumZ/P4jQ8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rXgSqsdfLWJ1DGifnakLkhI6b1B1VUUUbAp0Hlmsc5YGzPIVxeG+JsseEkRC4Npt4
         YUR791e1CL/qSX3uI1+aYk/2Wv7kTLW9pjNhOH5uRNaIkBBkVtGLfxadMJOvrELdke
         x4mYRIB3DmQi8YKb3NGKTVk3rh0Z4y6Z2qPjTBN/NkeBlNTiJx5QcK6y1qKavIX5sr
         eCBd6EfVWrJd+zmjTMCwIjJ+b1wYyA5wbRZJn8CVxgH+QUmh6vP1U5M+wRux0gW5aU
         PKTI6V4DuV7oQDunouFgEgoEQPKAJ3qaJipxjglOlQN5/toAuyk3A1Dz0zVdog4QCY
         zHOIC9z91GUdw==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     kernel test robot <lkp@intel.com>
Subject: [PATCH 07/12] habanalabs/gaudi2: remove unused variable
Date:   Mon,  4 Jul 2022 12:29:36 +0300
Message-Id: <20220704092941.2237683-7-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220704092941.2237683-1-ogabbay@kernel.org>
References: <20220704092941.2237683-1-ogabbay@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

glbl_sts_clr_val was set but never used

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/gaudi2/gaudi2.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/misc/habanalabs/gaudi2/gaudi2.c b/drivers/misc/habanalabs/gaudi2/gaudi2.c
index 71eb767835bd..6911b42e52e1 100644
--- a/drivers/misc/habanalabs/gaudi2/gaudi2.c
+++ b/drivers/misc/habanalabs/gaudi2/gaudi2.c
@@ -6802,7 +6802,7 @@ static void print_qman_data_on_err(struct hl_device *hdev, u32 qid_base, u32 str
 static void gaudi2_handle_qman_err_generic(struct hl_device *hdev, const char *qm_name,
 						u64 qman_base, u32 qid_base)
 {
-	u32 i, j, glbl_sts_val, arb_err_val, glbl_sts_clr_val, num_error_causes;
+	u32 i, j, glbl_sts_val, arb_err_val, num_error_causes;
 	u64 glbl_sts_addr, arb_err_addr;
 	char reg_desc[32];
 
@@ -6811,7 +6811,6 @@ static void gaudi2_handle_qman_err_generic(struct hl_device *hdev, const char *q
 
 	/* Iterate through all stream GLBL_ERR_STS registers + Lower CP */
 	for (i = 0 ; i < QMAN_STREAMS + 1 ; i++) {
-		glbl_sts_clr_val = 0;
 		glbl_sts_val = RREG32(glbl_sts_addr + 4 * i);
 
 		if (!glbl_sts_val)
@@ -6825,16 +6824,13 @@ static void gaudi2_handle_qman_err_generic(struct hl_device *hdev, const char *q
 			num_error_causes = GAUDI2_NUM_OF_QM_ERR_CAUSE;
 		}
 
-		for (j = 0 ; j < num_error_causes ; j++) {
-			if (glbl_sts_val & BIT(j)) {
+		for (j = 0 ; j < num_error_causes ; j++)
+			if (glbl_sts_val & BIT(j))
 				dev_err_ratelimited(hdev->dev, "%s %s. err cause: %s\n",
 						qm_name, reg_desc,
 						i == QMAN_STREAMS ?
 						gaudi2_qman_lower_cp_error_cause[j] :
 						gaudi2_qman_error_cause[j]);
-				glbl_sts_clr_val |= BIT(j);
-			}
-		}
 
 		print_qman_data_on_err(hdev, qid_base, i, qman_base);
 	}
-- 
2.25.1

