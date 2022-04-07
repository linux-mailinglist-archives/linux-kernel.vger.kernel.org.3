Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C0B74F8401
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 17:48:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244239AbiDGPuf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 11:50:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232193AbiDGPud (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 11:50:33 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F24A37017;
        Thu,  7 Apr 2022 08:48:32 -0700 (PDT)
Date:   Thu, 07 Apr 2022 15:48:29 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1649346511;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0EUgoUyJOV+ytrCOJgy5gzgNTd08GKnxKCRhqyMu0nE=;
        b=zdIl3g8UNSYqpd+vpQ9Qr829tlSM089AP1JhJEl080Mu66qQwKz0B3spXulKz8ovdGIVlt
        NP2PDcKpDnNtyyE5Zo+oALPEjEl3ewOq3yjxC7aRdw/XjkenNopyDGs7Ykxk8iGZOunIX/
        IeF3JFcyn+dCPTKCEUjXBTjne3j0oQEnLMg0UVvgnBl4954tBdvytTjM3/18Usnhzm7Gmm
        x0pU9Dxn88faNGUTKahRveEmpVq+vYo4oQZAMA4YCDNB16z/gUzQOMQtBdOI2/aQGKMG3D
        HfOKtTm3HT5+nMXXsuLfmMDcW3IVD+KzX0u1RwRn0hxyoc6gWHULoK0D5lGENA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1649346511;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0EUgoUyJOV+ytrCOJgy5gzgNTd08GKnxKCRhqyMu0nE=;
        b=KJ6NEmiMsfpundaRbK/3vT0U/er+WnvU4x5mWUeOO/OG3DZXN3qd5OMCYTnM8Ui9SD2SxM
        AhHi9MyQ8RUBFZAw==
From:   "tip-bot2 for Mike Travis" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/platform] x86/platform/uv: Log gap hole end size
Cc:     Mike Travis <mike.travis@hpe.com>, Steve Wahl <steve.wahl@hpe.com>,
        Borislav Petkov <bp@suse.de>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220406195149.228164-4-steve.wahl@hpe.com>
References: <20220406195149.228164-4-steve.wahl@hpe.com>
MIME-Version: 1.0
Message-ID: <164934650980.389.11541360930801701487.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/platform branch of tip:

Commit-ID:     327c348988c6f0bacd7abd29c151f37bdf1e2a02
Gitweb:        https://git.kernel.org/tip/327c348988c6f0bacd7abd29c151f37bdf1e2a02
Author:        Mike Travis <mike.travis@hpe.com>
AuthorDate:    Wed, 06 Apr 2022 14:51:49 -05:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Thu, 07 Apr 2022 17:25:15 +02:00

x86/platform/uv: Log gap hole end size

Show value of gap end in the kernel log which equates to number of physical
address bits used by system.

Signed-off-by: Mike Travis <mike.travis@hpe.com>
Signed-off-by: Steve Wahl <steve.wahl@hpe.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Acked-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20220406195149.228164-4-steve.wahl@hpe.com
---
 arch/x86/kernel/apic/x2apic_uv_x.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/apic/x2apic_uv_x.c b/arch/x86/kernel/apic/x2apic_uv_x.c
index a6e9c27..4828552 100644
--- a/arch/x86/kernel/apic/x2apic_uv_x.c
+++ b/arch/x86/kernel/apic/x2apic_uv_x.c
@@ -1346,7 +1346,7 @@ static void __init decode_gam_params(unsigned long ptr)
 static void __init decode_gam_rng_tbl(unsigned long ptr)
 {
 	struct uv_gam_range_entry *gre = (struct uv_gam_range_entry *)ptr;
-	unsigned long lgre = 0;
+	unsigned long lgre = 0, gend = 0;
 	int index = 0;
 	int sock_min = 999999, pnode_min = 99999;
 	int sock_max = -1, pnode_max = -1;
@@ -1380,6 +1380,9 @@ static void __init decode_gam_rng_tbl(unsigned long ptr)
 			flag, size, suffix[order],
 			gre->type, gre->nasid, gre->sockid, gre->pnode);
 
+		if (gre->type == UV_GAM_RANGE_TYPE_HOLE)
+			gend = (unsigned long)gre->limit << UV_GAM_RANGE_SHFT;
+
 		/* update to next range start */
 		lgre = gre->limit;
 		if (sock_min > gre->sockid)
@@ -1397,7 +1400,8 @@ static void __init decode_gam_rng_tbl(unsigned long ptr)
 	_max_pnode	= pnode_max;
 	_gr_table_len	= index;
 
-	pr_info("UV: GRT: %d entries, sockets(min:%x,max:%x) pnodes(min:%x,max:%x)\n", index, _min_socket, _max_socket, _min_pnode, _max_pnode);
+	pr_info("UV: GRT: %d entries, sockets(min:%x,max:%x), pnodes(min:%x,max:%x), gap_end(%d)\n",
+	  index, _min_socket, _max_socket, _min_pnode, _max_pnode, fls64(gend));
 }
 
 /* Walk through UVsystab decoding the fields */
