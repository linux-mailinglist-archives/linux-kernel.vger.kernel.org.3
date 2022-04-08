Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B49024F9166
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 11:08:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232723AbiDHJKv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 05:10:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232540AbiDHJKm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 05:10:42 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9331104A77;
        Fri,  8 Apr 2022 02:08:38 -0700 (PDT)
Date:   Fri, 08 Apr 2022 09:08:35 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1649408916;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6iT0dUCpKXd93Cim/gg7O05ni3UqWXOaBw9BFAlaO4k=;
        b=TQvC8Gey5qQmq50Bflp5Hrcy67okTrJ+IjN/pdbOrDPnvXrpL+gJlqlloCel0RR30LvlE9
        6bNRMFjDfEOx6CWTuDvCmtcWJS4iHI7qJDbOlVyLliNa1K33nKbhIUMqaZQAem/INcYYdu
        jFz1Ww3xuqNABK8bIvNO9/Hev7dZ8DVFhWEbVva9RNeZnsKROH/iCi2b+Isq26ub/4UOwp
        dofGrzxh48cl/ddpjl/t4CKvgEC0UGybg3Pf2F91LKW3aOg/YOfkndzHB6aPCge7ZIRCYn
        RD53E0pq25uWvaVAwLaFDdXYyUxObNzL5NczMvrkc76piWDWfkkiOGTqwuBdTg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1649408916;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6iT0dUCpKXd93Cim/gg7O05ni3UqWXOaBw9BFAlaO4k=;
        b=Fxx7PfSLqRoiQ3+3HGf7gZBtobylCUU+Iv6bgMjXX16PMLKMe/LHT+QsMRUT4Q8u91TR/6
        +nkJur9TZVRhROCA==
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
Message-ID: <164940891535.389.15036684109710307726.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/sev branch of tip:

Commit-ID:     e720ea52e85c9d00cf8c5769795d0a3e585524f6
Gitweb:        https://git.kernel.org/tip/e720ea52e85c9d00cf8c5769795d0a3e585524f6
Author:        Peter Gonda <pgonda@google.com>
AuthorDate:    Thu, 17 Mar 2022 14:19:13 -07:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Fri, 08 Apr 2022 10:57:35 +02:00

x86/sev-es: Replace open-coded hlt-loop with sev_es_terminate()

Replace the halt loop in handle_vc_boot_ghcb() with an
sev_es_terminate(). The HLT gives the system no indication the guest is
unhappy. The termination request will signal there was an error during
VC handling during boot.

  [ bp: Update it to pass the reason set too. ]

Signed-off-by: Peter Gonda <pgonda@google.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Joerg Roedel <jroedel@suse.de>
Link: https://lore.kernel.org/r/20220317211913.1397427-1-pgonda@google.com
---
 arch/x86/kernel/sev.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/x86/kernel/sev.c b/arch/x86/kernel/sev.c
index ace43e1..f01f455 100644
--- a/arch/x86/kernel/sev.c
+++ b/arch/x86/kernel/sev.c
@@ -1982,8 +1982,7 @@ bool __init handle_vc_boot_ghcb(struct pt_regs *regs)
 fail:
 	show_regs(regs);
 
-	while (true)
-		halt();
+	sev_es_terminate(SEV_TERM_SET_GEN, GHCB_SEV_ES_GEN_REQ);
 }
 
 /*
