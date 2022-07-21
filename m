Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9FD857C6A4
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 10:42:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231765AbiGUImE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 04:42:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232478AbiGUIl7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 04:41:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DA941145E
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 01:41:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 27FD361E6B
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 08:41:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A0A4C341C0;
        Thu, 21 Jul 2022 08:41:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658392917;
        bh=LR5pBDIaKYvAX59EGQzm+5S1jXRqIW5nFaEA9NPAi2A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lNsyNchgl9lwfqk/uevAIZjLmIBX0G1hIz8TiC+U2YYu6NB4URt5U9WOl1UX/G6Mu
         xLRw46bOadnAMlR9UXqqz6d4KE7GO7fTzzz1XSXAsbGtCv7J+WHyYLzefRQHTe/tfZ
         aRUvkqY2rdNCmJvMqUSm0Plpj7UXDgaQl8HncTJtsQB34Kb3XPkKOizwnxntkd5FRC
         aGCdkJxC8Ro+opPFphsHQT1X7U6M0+4z+EnW8oJaP+dB+5nHe+iPWvNh7Cag86wh1J
         C3nk6wmRzNm09WFCB0/lRUmmgallcHOkn/44Wzjv/tKkXgtgrbz41r9F5A9i1PldF7
         FR+L51Ybrnl/A==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Tomer Tayar <ttayar@habana.ai>
Subject: [PATCH 2/2] habanalabs/gaudi2: mark PCIE access error as fatal
Date:   Thu, 21 Jul 2022 11:41:50 +0300
Message-Id: <20220721084150.4147483-2-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220721084150.4147483-1-ogabbay@kernel.org>
References: <20220721084150.4147483-1-ogabbay@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tomer Tayar <ttayar@habana.ai>

F/W events are enabled in a late phase of the device init, so an event
for a PCIE access error during the init, can be received after the init
is already done and considered as successful.
A resulting device reset, which does the same H/W init, can end
similarly with this event right after the reset is done and considered
as successful, and a loop of this sequence can continue.

To avoid it mark the PCIE access error as a fatal event, so after 2
consecutive events no more resets will be done.

Signed-off-by: Tomer Tayar <ttayar@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/gaudi2/gaudi2.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/misc/habanalabs/gaudi2/gaudi2.c b/drivers/misc/habanalabs/gaudi2/gaudi2.c
index 2c43ed403509..68ab407fa6ba 100644
--- a/drivers/misc/habanalabs/gaudi2/gaudi2.c
+++ b/drivers/misc/habanalabs/gaudi2/gaudi2.c
@@ -8532,6 +8532,7 @@ static void gaudi2_handle_eqe(struct hl_device *hdev, struct hl_eq_entry *eq_ent
 	case GAUDI2_EVENT_PCIE_ADDR_DEC_ERR:
 		gaudi2_print_pcie_addr_dec_info(hdev,
 				le64_to_cpu(eq_entry->intr_cause.intr_cause_data));
+		reset_flags |= HL_DRV_RESET_FW_FATAL_ERR;
 		break;
 
 	case GAUDI2_EVENT_HMMU0_PAGE_FAULT_OR_WR_PERM ... GAUDI2_EVENT_HMMU12_SECURITY_ERROR:
-- 
2.25.1

