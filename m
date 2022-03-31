Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 968614ED65C
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 11:01:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233521AbiCaJCy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 05:02:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233439AbiCaJCo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 05:02:44 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 749EF541A5;
        Thu, 31 Mar 2022 02:00:57 -0700 (PDT)
Date:   Thu, 31 Mar 2022 09:00:53 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1648717256;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IeZ4/Sb63ngG7P3EFI0+0wB8F765VYIZarNhfw3KqsY=;
        b=PvOvTKTZi0or8c7lus+WiFPsPw6CWqAKKNSr8W6RU2S/FKYVUQY15aEZhnvWVBRxvhxQpV
        8LPBxsKqm0DpjhUDZT5NFkA6uM9kk0wdGf9UQfewRasWHFqBdFmOK48giGyFsgAFM+3ihD
        y0Kb5MMOqFUQpMx1sgvm4+AABg6ASZszCOKZeL8fvMQnuN042s/NV9mTqAxmBlM6wcOvxX
        VgSTy5sXy+Mm4QMZkGuuMFALUttsYf0vaXUC1TDvcaI7jO94Deb/8YtK3ywKPNa9slukAc
        J+LtzyePP+h5M1mbUjNGvYvEBT0unIR+UmFaLTqIuY60UhkHgShfs6gEET0yEw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1648717256;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IeZ4/Sb63ngG7P3EFI0+0wB8F765VYIZarNhfw3KqsY=;
        b=NW+tbKQn5XtVCczasX19SYEe0KIxhJEiHzHcFPobf3ZThv5A4oKCIhnTJam3WSTRg59VwJ
        hdQb1HyObdnvE5Bw==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/fpu/xstate: Handle supervisor states in XSTATE
 permissions
Cc:     Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@suse.de>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20220324134623.681768598@linutronix.de>
References: <20220324134623.681768598@linutronix.de>
MIME-Version: 1.0
Message-ID: <164871725392.389.9637668418038210580.tip-bot2@tip-bot2>
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

Commit-ID:     781c64bfcb735960717d1cb45428047ff6a5030c
Gitweb:        https://git.kernel.org/tip/781c64bfcb735960717d1cb45428047ff6a5030c
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Thu, 24 Mar 2022 14:47:14 +01:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Wed, 30 Mar 2022 11:35:22 +02:00

x86/fpu/xstate: Handle supervisor states in XSTATE permissions

The size calculation in __xstate_request_perm() fails to take supervisor
states into account because the permission bitmap is only relevant for user
states.

Up to 5.17 this does not matter because there are no supervisor states
supported, but the (re-)enabling of ENQCMD makes them available.

Fixes: 7c1ef59145f1 ("x86/cpufeatures: Re-enable ENQCMD")
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lore.kernel.org/r/20220324134623.681768598@linutronix.de
---
 arch/x86/kernel/fpu/xstate.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
index c55f72e..5ac934b 100644
--- a/arch/x86/kernel/fpu/xstate.c
+++ b/arch/x86/kernel/fpu/xstate.c
@@ -1571,6 +1571,9 @@ static int __xstate_request_perm(u64 permitted, u64 requested, bool guest)
 
 	/* Calculate the resulting kernel state size */
 	mask = permitted | requested;
+	/* Take supervisor states into account on the host */
+	if (!guest)
+		mask |= xfeatures_mask_supervisor();
 	ksize = xstate_calculate_size(mask, compacted);
 
 	/* Calculate the resulting user state size */
