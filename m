Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 191F84C13B5
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 14:13:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240793AbiBWNNy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 08:13:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240759AbiBWNNw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 08:13:52 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86626AA2D7;
        Wed, 23 Feb 2022 05:13:21 -0800 (PST)
Date:   Wed, 23 Feb 2022 13:13:18 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1645622000;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EojgvNbu+tKwdafgqsm2eLiSkbl2Ih3egpnjICgeVF0=;
        b=nOxxI+cZX7HN7AI/UXtV3zA9yyUJ+B2z61mgn3iVZwnO5VFx4EVBKzuPm5yb5hW76AUvLe
        Q6BiMrUXsyIowkIqRL7IkadllWp55r6WTI/e5+6k62g5/7Ph6rVBkHzj0QlXByFZz2j0Pi
        sCvKT4o97rq4RbWL4Mwe2h2LOrsgvIksV+XuRUDQpV9pHRqapuuieezBBLqQME6qpvY/l/
        ucmxlZFOn/i7Mexel5aTRx7Aidk3Zl8Uq+uuBM50+g6FeML2kAMdvMN+xM9X6ljVMxG00M
        /+AgZoxuC74NfOLuDKVU82Tsfr2fFKiEgbLxBZg+N0Bm8nniQnrPD3G/0YZkLA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1645622000;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EojgvNbu+tKwdafgqsm2eLiSkbl2Ih3egpnjICgeVF0=;
        b=abNeLLol9M7RVRV9SEKf8kAbLiZnD9Rdyp2ucUvYYPZPthXrEVApeT2rg45zjevKcKIDou
        8vNNQsZkEuxJJFDg==
From:   "tip-bot2 for Christoph Hellwig" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cleanups] x86/pat: Remove the unused set_pages_array_wt() function
Cc:     Christoph Hellwig <hch@lst.de>, Borislav Petkov <bp@suse.de>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20220223072852.616143-1-hch@lst.de>
References: <20220223072852.616143-1-hch@lst.de>
MIME-Version: 1.0
Message-ID: <164562199842.16921.5937202395813182097.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/cleanups branch of tip:

Commit-ID:     4509d950a6764d18a99776614513d280cca422d8
Gitweb:        https://git.kernel.org/tip/4509d950a6764d18a99776614513d280cca422d8
Author:        Christoph Hellwig <hch@lst.de>
AuthorDate:    Wed, 23 Feb 2022 08:28:52 +01:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Wed, 23 Feb 2022 13:34:08 +01:00

x86/pat: Remove the unused set_pages_array_wt() function

Commit

  623dffb2a2e0 ("x86/mm/pat: Add set_memory_wt() for Write-Through type")

added it but there were no users.

  [ bp: Add a commit message. ]

Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lore.kernel.org/r/20220223072852.616143-1-hch@lst.de
---
 arch/x86/include/asm/set_memory.h | 1 -
 arch/x86/mm/pat/set_memory.c      | 6 ------
 2 files changed, 7 deletions(-)

diff --git a/arch/x86/include/asm/set_memory.h b/arch/x86/include/asm/set_memory.h
index ff0f2d9..60bdede 100644
--- a/arch/x86/include/asm/set_memory.h
+++ b/arch/x86/include/asm/set_memory.h
@@ -53,7 +53,6 @@ int set_memory_global(unsigned long addr, int numpages);
 
 int set_pages_array_uc(struct page **pages, int addrinarray);
 int set_pages_array_wc(struct page **pages, int addrinarray);
-int set_pages_array_wt(struct page **pages, int addrinarray);
 int set_pages_array_wb(struct page **pages, int addrinarray);
 
 /*
diff --git a/arch/x86/mm/pat/set_memory.c b/arch/x86/mm/pat/set_memory.c
index b407211..9bdaf82 100644
--- a/arch/x86/mm/pat/set_memory.c
+++ b/arch/x86/mm/pat/set_memory.c
@@ -2121,12 +2121,6 @@ int set_pages_array_wc(struct page **pages, int numpages)
 }
 EXPORT_SYMBOL(set_pages_array_wc);
 
-int set_pages_array_wt(struct page **pages, int numpages)
-{
-	return _set_pages_array(pages, numpages, _PAGE_CACHE_MODE_WT);
-}
-EXPORT_SYMBOL_GPL(set_pages_array_wt);
-
 int set_pages_wb(struct page *page, int numpages)
 {
 	unsigned long addr = (unsigned long)page_address(page);
