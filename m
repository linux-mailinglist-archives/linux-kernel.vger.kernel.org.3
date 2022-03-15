Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DBC04D9978
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 11:49:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347905AbiCOKsb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 06:48:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347301AbiCOKpn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 06:45:43 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FA6B50E29;
        Tue, 15 Mar 2022 03:44:12 -0700 (PDT)
Date:   Tue, 15 Mar 2022 10:44:09 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1647341050;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wF4A1OvXovUia2Hp2T9YRx5+vmPaEde8X/FpwQhRYCE=;
        b=XoJArUnNF/vLR7EoKtx3YEkqlCpn/FWK6EBO6kawChMDt8rG8Oi1YvpNoiPvaDiwBusHWm
        beRDphxFL0Hlvo5Bpfmx8Jy44iINkZgaYxpICWP2uzTctoFNioFtPN0LNwwJHT8AXT39Ot
        6AVCLUUdPUVirJru4opn0IOIatFnDLR5n68V7oSy/agxcmcknkkoVIKubyTzvuFEyGZBQx
        nAKadNqxWeRrDb/EzuRckFqYLheqYg8kBzq1SwgB3GFSoHQJOmm3F/o8OH6N7pR8pXtLOj
        QUR6jQYWBhPV7npuS1r1QTsICANjjwpmgda7wiVGaNV9oY405ZkFJdR/ALg2jw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1647341050;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wF4A1OvXovUia2Hp2T9YRx5+vmPaEde8X/FpwQhRYCE=;
        b=07yh1/klS58DKDhbcsMlExiMp6W230FAo7zG/LJvR70eWyzq8IuvkvDZSQHNepiRcJXL8k
        /+OgL6BxigP7A3CQ==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/core] x86/entry: Cleanup PARAVIRT
Cc:     Andrew Cooper <Andrew.Cooper3@citrix.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220308154317.756014488@infradead.org>
References: <20220308154317.756014488@infradead.org>
MIME-Version: 1.0
Message-ID: <164734104981.16921.1759267394464095618.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/core branch of tip:

Commit-ID:     6cf3e4c0d29102c74aca1ce0c1710be9d02e440e
Gitweb:        https://git.kernel.org/tip/6cf3e4c0d29102c74aca1ce0c1710be9d02e440e
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Tue, 08 Mar 2022 16:30:21 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 15 Mar 2022 10:32:34 +01:00

x86/entry: Cleanup PARAVIRT

Since commit 5c8f6a2e316e ("x86/xen: Add
xenpv_restore_regs_and_return_to_usermode()") Xen will no longer reach
this code and we can do away with the paravirt
SWAPGS/INTERRUPT_RETURN.

Suggested-by: Andrew Cooper <Andrew.Cooper3@citrix.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Josh Poimboeuf <jpoimboe@redhat.com>
Link: https://lore.kernel.org/r/20220308154317.756014488@infradead.org
---
 arch/x86/entry/entry_64.S | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index 466df3e..22e4e9a 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -608,8 +608,8 @@ SYM_INNER_LABEL(swapgs_restore_regs_and_return_to_usermode, SYM_L_GLOBAL)
 
 	/* Restore RDI. */
 	popq	%rdi
-	SWAPGS
-	INTERRUPT_RETURN
+	swapgs
+	jmp	native_iret
 
 
 SYM_INNER_LABEL(restore_regs_and_return_to_kernel, SYM_L_GLOBAL)
