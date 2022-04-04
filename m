Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05B8A4F1BCF
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 23:25:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381621AbiDDVX3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 17:23:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380525AbiDDUVM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 16:21:12 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09A832AE9;
        Mon,  4 Apr 2022 13:19:14 -0700 (PDT)
Date:   Mon, 04 Apr 2022 20:19:11 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1649103552;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WNOBe1vWppvbexr1o50poyMJPOCbE2eiR5qK3R+vlbI=;
        b=T067flIDohX2+TyixlVRL8HA7ygMbllJ/gZcGsZfe8mZPfN79lqkR9KxUfpTGzmqjJetPf
        NQQlklPvSYAdShldT+ZnRCizyZqt/Bq3yhbKU3yNf3XtWHLBNyGpPVMi01N9OFJDTXtbnl
        gTJJ0qn8JBntelxYiYhT2+Ap2NrMLSYRiMspZ5Z33caZEvi8BMHHJv4ACfFCf/ub6l9OPR
        J6CA/x/gXgKPaoXNeGfy0ay2Lc0Eo22fjmzIfC/1SjmYPIFtMIS+EDpIyUk8nMAqbKqWQ9
        Poe2552ePa/NNrGfzq+hPCWA4voDqbYvXehoWtSq1HA9zRYgnKzRnVg7ZvtHzg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1649103552;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WNOBe1vWppvbexr1o50poyMJPOCbE2eiR5qK3R+vlbI=;
        b=Gc1nLM+EMvKNKUZ3Taubma8zjwasPWNQuC5Pm7+tt1Ye65s0W1SoLAV2JwtHnydm6+E3Q9
        Fyy7DMYiOsP1miCQ==
From:   "tip-bot2 for Mike Travis" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/platform] x86/platform/uv: Log gap hole end size
Cc:     Mike Travis <mike.travis@hpe.com>, Borislav Petkov <bp@suse.de>,
        Steve Wahl <steve.wahl@hpe.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220318224304.174967-4-mike.travis@hpe.com>
References: <20220318224304.174967-4-mike.travis@hpe.com>
MIME-Version: 1.0
Message-ID: <164910355134.389.13915883561213298641.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/platform branch of tip:

Commit-ID:     f93ba85de0d1ce1924b0752b6a7a784c11c36414
Gitweb:        https://git.kernel.org/tip/f93ba85de0d1ce1924b0752b6a7a784c11c36414
Author:        Mike Travis <mike.travis@hpe.com>
AuthorDate:    Fri, 18 Mar 2022 17:43:04 -05:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Mon, 04 Apr 2022 20:21:47 +02:00

x86/platform/uv: Log gap hole end size

Show value of gap end in the kernel log which equates to number of physical
address bits used by system.  The end address of the gap holds PA bits 56:26
which gives the range up to 64PB max size with 64MB of granularity.

Signed-off-by: Mike Travis <mike.travis@hpe.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Steve Wahl <steve.wahl@hpe.com>
Link: https://lore.kernel.org/r/20220318224304.174967-4-mike.travis@hpe.com
---
 arch/x86/kernel/apic/x2apic_uv_x.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/apic/x2apic_uv_x.c b/arch/x86/kernel/apic/x2apic_uv_x.c
index 387d653..146f0f6 100644
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
