Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22032535E1C
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 12:23:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350918AbiE0KXi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 May 2022 06:23:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350370AbiE0KXg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 May 2022 06:23:36 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D92F8F6893;
        Fri, 27 May 2022 03:23:33 -0700 (PDT)
Date:   Fri, 27 May 2022 10:23:31 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1653647012;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DvhvamQw95czvXs0uw4uN1J6aqGA3JmU+FjqjMTU1sA=;
        b=IKAfjUqYRKIZimxNT1cOaFoOtYmyID+lHi1/CkuJ0WcfbV+H4Av0oviyJppuIrdSgz3pfu
        Lf07fgSHJbAEjASx8KMMHsB8VMa4pKP0+8E91Oe8T/KK1GWxIpWntQ2uagbSO0lqdzNWUB
        U1I6x67e5ljyQZQ7Jyh0ISheQMOBN+rADn1JWKYVQYlA6lm5oKOOWI9PPJ8XFI2+xB8nSb
        bSb4Ny1347bHU6fq8ml/CvZxPxhrfx0zwIyh4bjOQAJUwU9nkvHGL+Juu58OBYCQ+lnfGE
        vHss7X4RWoyehVqHOFG0s2HWAqQVSfDMHvM7FOdi3VJ+fEWbF9b5yojWZ8B/Pw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1653647012;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DvhvamQw95czvXs0uw4uN1J6aqGA3JmU+FjqjMTU1sA=;
        b=FWpuQNDiXIUO7zALmbpqgr8MxTsZQwgX7NljQKPDHmJbgjbycYW2zl/cjns5sa6GnY2x9e
        bWC4aL7DVgIb00AQ==
From:   "tip-bot2 for Fanjun Kong" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/mm] x86/mm: Use PAGE_ALIGNED(x) instead of IS_ALIGNED(x, PAGE_SIZE)
Cc:     Fanjun Kong <bh1scw@gmail.com>, Ingo Molnar <mingo@kernel.org>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20220526142038.1582839-1-bh1scw@gmail.com>
References: <20220526142038.1582839-1-bh1scw@gmail.com>
MIME-Version: 1.0
Message-ID: <165364701137.4207.15691426598646044587.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/mm branch of tip:

Commit-ID:     e19d11267f0e6c8aff2d15d2dfed12365b4c9184
Gitweb:        https://git.kernel.org/tip/e19d11267f0e6c8aff2d15d2dfed12365b4c9184
Author:        Fanjun Kong <bh1scw@gmail.com>
AuthorDate:    Thu, 26 May 2022 22:20:39 +08:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 27 May 2022 12:19:56 +02:00

x86/mm: Use PAGE_ALIGNED(x) instead of IS_ALIGNED(x, PAGE_SIZE)

The <linux/mm.h> already provides the PAGE_ALIGNED() macro. Let's
use this macro instead of IS_ALIGNED() and passing PAGE_SIZE directly.

No change in functionality.

[ mingo: Tweak changelog. ]

Signed-off-by: Fanjun Kong <bh1scw@gmail.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20220526142038.1582839-1-bh1scw@gmail.com
---
 arch/x86/mm/init_64.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/x86/mm/init_64.c b/arch/x86/mm/init_64.c
index 61d0ab1..8779d6b 100644
--- a/arch/x86/mm/init_64.c
+++ b/arch/x86/mm/init_64.c
@@ -1240,8 +1240,8 @@ remove_pagetable(unsigned long start, unsigned long end, bool direct,
 void __ref vmemmap_free(unsigned long start, unsigned long end,
 		struct vmem_altmap *altmap)
 {
-	VM_BUG_ON(!IS_ALIGNED(start, PAGE_SIZE));
-	VM_BUG_ON(!IS_ALIGNED(end, PAGE_SIZE));
+	VM_BUG_ON(!PAGE_ALIGNED(start));
+	VM_BUG_ON(!PAGE_ALIGNED(end));
 
 	remove_pagetable(start, end, false, altmap);
 }
@@ -1605,8 +1605,8 @@ int __meminit vmemmap_populate(unsigned long start, unsigned long end, int node,
 {
 	int err;
 
-	VM_BUG_ON(!IS_ALIGNED(start, PAGE_SIZE));
-	VM_BUG_ON(!IS_ALIGNED(end, PAGE_SIZE));
+	VM_BUG_ON(!PAGE_ALIGNED(start));
+	VM_BUG_ON(!PAGE_ALIGNED(end));
 
 	if (end - start < PAGES_PER_SECTION * sizeof(struct page))
 		err = vmemmap_populate_basepages(start, end, node, NULL);
