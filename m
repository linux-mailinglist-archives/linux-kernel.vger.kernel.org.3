Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1244B51734C
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 17:52:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386015AbiEBPxp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 11:53:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1386007AbiEBPxm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 11:53:42 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01AF82BB;
        Mon,  2 May 2022 08:50:13 -0700 (PDT)
Date:   Mon, 02 May 2022 15:50:09 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1651506611;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RO1SJetwkEj2qJJP1iLyJ0Y8Cv4AWNWm2/rJMQngLE8=;
        b=1V7DLmFVSIToud61kZUmeNEy49eS/Skz7+Qme9O535rwe5D0blfH7UFyahjgOEXV3SdGD4
        gKmuwVQn/2KSxiR61qTN2oDff/O4K3c2toLwDPQbtl0ByCbbMsx9InUegAn1KygZ1iYqEV
        6i+1OyQXx/Z85vJdgRVAtGgC1ThhKKZiEg9QtfZklaA6lAotMtBjB+nrX0XdpcTUS3fPef
        57R63sxpKrIB0hJUuCcsxC7uKg1mE3953YQof397hMxB6LDoNBY55JMooKupQJ/WfoQt6y
        u4/WqYuu+2ggZpPqkf8U68S5edMGdIrOvXkSX0tFHZpdBlBfsILOac1VdjA+Tg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1651506611;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RO1SJetwkEj2qJJP1iLyJ0Y8Cv4AWNWm2/rJMQngLE8=;
        b=GyoroTxblscvDsctMPVav58Sfz2Eb+B85PpD0AEg1jPTKcyYpme2oKOvWldj6dm4RWSmTw
        WfleXiyzu9X6ZWBQ==
From:   "tip-bot2 for Borislav Petkov" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/sev] x86/sev: Fix address space sparse warning
Cc:     kernel test robot <lkp@intel.com>, Borislav Petkov <bp@suse.de>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <202205022233.XgNDR7WR-lkp@intel.com>
References: <202205022233.XgNDR7WR-lkp@intel.com>
MIME-Version: 1.0
Message-ID: <165150660983.4207.3708966616865362991.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/sev branch of tip:

Commit-ID:     ab65f49253ff706723ecbf87af74e9383b5e4582
Gitweb:        https://git.kernel.org/tip/ab65f49253ff706723ecbf87af74e9383b5e4582
Author:        Borislav Petkov <bp@suse.de>
AuthorDate:    Mon, 02 May 2022 17:33:40 +02:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Mon, 02 May 2022 17:34:29 +02:00

x86/sev: Fix address space sparse warning

Fix:

  arch/x86/kernel/sev.c:605:16: warning: incorrect type in assignment (different address spaces)
  arch/x86/kernel/sev.c:605:16:    expected struct snp_secrets_page_layout *layout
  arch/x86/kernel/sev.c:605:16:    got void [noderef] __iomem *[assigned] mem

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lore.kernel.org/r/202205022233.XgNDR7WR-lkp@intel.com
---
 arch/x86/kernel/sev.c |  9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/sev.c b/arch/x86/kernel/sev.c
index 1663750..c05f012 100644
--- a/arch/x86/kernel/sev.c
+++ b/arch/x86/kernel/sev.c
@@ -589,20 +589,23 @@ static u64 __init get_secrets_page(void)
 static u64 __init get_snp_jump_table_addr(void)
 {
 	struct snp_secrets_page_layout *layout;
+	void __iomem *mem;
 	u64 pa, addr;
 
 	pa = get_secrets_page();
 	if (!pa)
 		return 0;
 
-	layout = (__force void *)ioremap_encrypted(pa, PAGE_SIZE);
-	if (!layout) {
+	mem = ioremap_encrypted(pa, PAGE_SIZE);
+	if (!mem) {
 		pr_err("Unable to locate AP jump table address: failed to map the SNP secrets page.\n");
 		return 0;
 	}
 
+	layout = (__force struct snp_secrets_page_layout *)mem;
+
 	addr = layout->os_area.ap_jump_table_pa;
-	iounmap(layout);
+	iounmap(mem);
 
 	return addr;
 }
