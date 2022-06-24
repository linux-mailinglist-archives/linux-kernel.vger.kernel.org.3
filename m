Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7BE6559ADA
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 16:04:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232148AbiFXOEr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 10:04:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232255AbiFXOEl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 10:04:41 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D38054ECCC
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 07:04:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 85B42B8269D
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 14:04:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A490FC341C0
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 14:04:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656079478;
        bh=aaaXZqhsFd1XkEDgk3NzNy1lhAXCYY2HTqKEj5c6LZg=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=Fw7GIwOHRvGWIQjbdvNj8zw2hMbNG2tnuEFUp4LT0xXM479086AyOqGuFUAw8cAjA
         l9GtQMgRIZkMCWMGiu8iQaq9UHYD0CW2AA9KxDHprYNgaYDhSMuO5LuPW5kXhcMkBY
         fyb3jPx2wcCvl5UQWo7cGwEfZEcmIFHfMIP+Zfne8a6bhSpEExrnUop3Rm83rWQAoI
         b9XTLuj47Pmt8imuFE9J1U/u2BVN7grM+BLEn7eT8wvKC9l0nHoxK1p6Qsi2itX55x
         b/VQHzegrOAfqW0nY5f2bk21hhedqj4wlOGNXPFTk1bbU6MRxWJrhXrAqYlajwwe0S
         /XiH5bnItrr5A==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Subject: [PATCH 4/5] habanalabs/gaudi: mask constant value before cast
Date:   Fri, 24 Jun 2022 17:04:28 +0300
Message-Id: <20220624140429.1778402-4-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220624140429.1778402-1-ogabbay@kernel.org>
References: <20220624140429.1778402-1-ogabbay@kernel.org>
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

This fixes a sparse warning of
"cast truncates bits from constant value"

Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/gaudi/gaudi.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/misc/habanalabs/gaudi/gaudi.c b/drivers/misc/habanalabs/gaudi/gaudi.c
index 9ecae3da9133..7d65260e46d7 100644
--- a/drivers/misc/habanalabs/gaudi/gaudi.c
+++ b/drivers/misc/habanalabs/gaudi/gaudi.c
@@ -3384,19 +3384,19 @@ static void gaudi_init_nic_qman(struct hl_device *hdev, u32 nic_offset,
 	u32 nic_qm_err_cfg, irq_handler_offset;
 	u32 q_off;
 
-	mtr_base_en_lo = lower_32_bits(CFG_BASE +
+	mtr_base_en_lo = lower_32_bits((CFG_BASE & U32_MAX) +
 			mmSYNC_MNGR_E_N_SYNC_MNGR_OBJS_MON_PAY_ADDRL_0);
 	mtr_base_en_hi = upper_32_bits(CFG_BASE +
 				mmSYNC_MNGR_E_N_SYNC_MNGR_OBJS_MON_PAY_ADDRL_0);
-	so_base_en_lo = lower_32_bits(CFG_BASE +
+	so_base_en_lo = lower_32_bits((CFG_BASE & U32_MAX) +
 				mmSYNC_MNGR_E_N_SYNC_MNGR_OBJS_SOB_OBJ_0);
 	so_base_en_hi = upper_32_bits(CFG_BASE +
 				mmSYNC_MNGR_E_N_SYNC_MNGR_OBJS_SOB_OBJ_0);
-	mtr_base_ws_lo = lower_32_bits(CFG_BASE +
+	mtr_base_ws_lo = lower_32_bits((CFG_BASE & U32_MAX) +
 				mmSYNC_MNGR_W_S_SYNC_MNGR_OBJS_MON_PAY_ADDRL_0);
 	mtr_base_ws_hi = upper_32_bits(CFG_BASE +
 				mmSYNC_MNGR_W_S_SYNC_MNGR_OBJS_MON_PAY_ADDRL_0);
-	so_base_ws_lo = lower_32_bits(CFG_BASE +
+	so_base_ws_lo = lower_32_bits((CFG_BASE & U32_MAX) +
 				mmSYNC_MNGR_W_S_SYNC_MNGR_OBJS_SOB_OBJ_0);
 	so_base_ws_hi = upper_32_bits(CFG_BASE +
 				mmSYNC_MNGR_W_S_SYNC_MNGR_OBJS_SOB_OBJ_0);
-- 
2.25.1

