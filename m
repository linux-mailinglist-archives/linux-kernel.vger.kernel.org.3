Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76689563F58
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Jul 2022 11:55:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232214AbiGBJyg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Jul 2022 05:54:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232122AbiGBJyb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Jul 2022 05:54:31 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EFD117A97;
        Sat,  2 Jul 2022 02:54:30 -0700 (PDT)
Date:   Sat, 02 Jul 2022 09:54:27 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1656755668;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PKApq4U1SQ86Vmc/jq0O6mKSJtDk9jWeFmLcPOmEbmM=;
        b=xv4TaJvMxH+vtkYw6BFuII2pceQ1QdF5NWXmwzXgIdrD3AU0uTvdKaY6C+odX9eLsZqpc7
        YSF1MyTCDY+2CM4H62laGskWoTtZt//fforr4qmoV3YK6yrn3S+4PHJE2RcuFpm5JmZSpr
        wYKEXTq/niIxWFkm1gavbUZKySXbVdo4+BQdR92/DFKXONDLr+jWVgCuwQtqvqOL82zWvK
        ctRe+qrl6Xnz9f7kxuRYvV01U2L6/cvegz/tq9YvCPEA9i075jYxWvwQ4447tl9KGieFXA
        oEK7ZdqYy8eshF/mh24oDEeDEfluQJtds0ZP5vaCREIEsREgZpehQSPUtX7/eA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1656755668;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PKApq4U1SQ86Vmc/jq0O6mKSJtDk9jWeFmLcPOmEbmM=;
        b=VrUOUS87Blm5I8kDv5Ru611XqIujlLcaU64GErokJc3rbFBf/hEF9o3cYRCKKHBQI06bph
        XtaTfzOCnddqalAg==
From:   "tip-bot2 for Juergen Gross" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86: Clear .brk area at early boot
Cc:     Juergen Gross <jgross@suse.com>, Borislav Petkov <bp@suse.de>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20220630071441.28576-3-jgross@suse.com>
References: <20220630071441.28576-3-jgross@suse.com>
MIME-Version: 1.0
Message-ID: <165675566764.15455.13299455113008964537.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     38fa5479b41376dc9d7f57e71c83514285a25ca0
Gitweb:        https://git.kernel.org/tip/38fa5479b41376dc9d7f57e71c83514285a25ca0
Author:        Juergen Gross <jgross@suse.com>
AuthorDate:    Thu, 30 Jun 2022 09:14:40 +02:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Fri, 01 Jul 2022 11:11:34 +02:00

x86: Clear .brk area at early boot

The .brk section has the same properties as .bss: it is an alloc-only
section and should be cleared before being used.

Not doing so is especially a problem for Xen PV guests, as the
hypervisor will validate page tables (check for writable page tables
and hypervisor private bits) before accepting them to be used.

Make sure .brk is initially zero by letting clear_bss() clear the brk
area, too.

Signed-off-by: Juergen Gross <jgross@suse.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lore.kernel.org/r/20220630071441.28576-3-jgross@suse.com
---
 arch/x86/kernel/head64.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/x86/kernel/head64.c b/arch/x86/kernel/head64.c
index e7e2332..6a3cfaf 100644
--- a/arch/x86/kernel/head64.c
+++ b/arch/x86/kernel/head64.c
@@ -430,6 +430,8 @@ void __init clear_bss(void)
 {
 	memset(__bss_start, 0,
 	       (unsigned long) __bss_stop - (unsigned long) __bss_start);
+	memset(__brk_base, 0,
+	       (unsigned long) __brk_limit - (unsigned long) __brk_base);
 }
 
 static unsigned long get_cmd_line_ptr(void)
