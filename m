Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66A9C4F4AAF
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 02:50:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442535AbiDEWuo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 18:50:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1573647AbiDET31 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 15:29:27 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B46B8BF000;
        Tue,  5 Apr 2022 12:27:28 -0700 (PDT)
Date:   Tue, 05 Apr 2022 19:27:26 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1649186847;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SH++pPXt5/MXSBZwUFXzyKmchSB5rWCVJKOal0mJc68=;
        b=qOYLmLAh6SrCv0U7WUKdx6kDqTdT45JSqFSK7l7WnGZEIQG8EH/o3+VOyTVKy36my+YN1u
        yQNjG/UhjPr3JEsssUonnTR8ZX9hbs8QBiosXuBLn/SYadeG6fsixMIR4pXFA/UJ56zXIi
        FBBjzEjKXmligf64RB9EuiIpzVwXQktYi7FiTO2qzpCPcJYlmYtzvezC7ycCW7P+ijPlq7
        NtBbhhafIRMbftlDETAevYwRDDPrNf2wv+cdHw6r3+T/Mz26a875Of+LxPnQImWjXnBAf0
        KhOMGHzsRKTZyErU2mwOMaUF907dXR22OZVnzop/0vaqjRldRdtshDjYG2sxjw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1649186847;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SH++pPXt5/MXSBZwUFXzyKmchSB5rWCVJKOal0mJc68=;
        b=7QfmmMCDW0T1IbXkwHXAGX9/cOJHP30DP6rOz6x5yGbr8ZySm7EVJBlgDbXsyUUuKRRkAA
        r4D4Yj9GACKseZAw==
From:   "tip-bot2 for Peter Gonda" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/sev] x86/sev-es: Replace open-coded hlt-loop with
 sev_es_terminate()
Cc:     Peter Gonda <pgonda@google.com>, Borislav Petkov <bp@suse.de>,
        Joerg Roedel <jroedel@suse.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220317211913.1397427-1-pgonda@google.com>
References: <20220317211913.1397427-1-pgonda@google.com>
MIME-Version: 1.0
Message-ID: <164918684623.389.10520041359552585691.tip-bot2@tip-bot2>
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

Commit-ID:     453e580abcdb53f688d5711c68bec96bea35430d
Gitweb:        https://git.kernel.org/tip/453e580abcdb53f688d5711c68bec96bea35430d
Author:        Peter Gonda <pgonda@google.com>
AuthorDate:    Thu, 17 Mar 2022 14:19:13 -07:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Tue, 05 Apr 2022 19:33:55 +02:00

x86/sev-es: Replace open-coded hlt-loop with sev_es_terminate()

Replace the halt loop in handle_vc_boot_ghcb() with an
sev_es_terminate(). The HLT gives the system no indication the guest is
unhappy. The termination request will signal there was an error during
VC handling during boot.

Signed-off-by: Peter Gonda <pgonda@google.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Joerg Roedel <jroedel@suse.de>
Link: https://lore.kernel.org/r/20220317211913.1397427-1-pgonda@google.com
---
 arch/x86/kernel/sev.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/x86/kernel/sev.c b/arch/x86/kernel/sev.c
index e6d316a..ae87fbf 100644
--- a/arch/x86/kernel/sev.c
+++ b/arch/x86/kernel/sev.c
@@ -1425,6 +1425,5 @@ bool __init handle_vc_boot_ghcb(struct pt_regs *regs)
 fail:
 	show_regs(regs);
 
-	while (true)
-		halt();
+	sev_es_terminate(GHCB_SEV_ES_GEN_REQ);
 }
