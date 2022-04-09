Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 018B64FA145
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Apr 2022 03:39:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240305AbiDIBaA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 21:30:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240246AbiDIB3b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 21:29:31 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DBB4DA6DF;
        Fri,  8 Apr 2022 18:27:25 -0700 (PDT)
Date:   Sat, 09 Apr 2022 01:27:22 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1649467643;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pj7zAY+ecbdHbFINkS7R1cfeTd265W+vWoWHJuTlpxo=;
        b=OUkBWS/0mTUmSLJSWQ2HBji8YhoSVSRkWZZT7B89wq2YxxW72GkBTXWyx06oFFVg0+sdHG
        YEQXljyGwZTNdCCTDKijMAabhY+1k4GbxSEnOCl5mVNIcbMKwHx3eHMgE7l8wwt5nRsZve
        FY1Dzw8Plpci1Z+ILe9p5ZqFesplyGeslPkqkJJZMlCZZYqWu1T6n3XsH11ydWzEmlt/fP
        iMYtfysd+Zsbjia3sggLwCkNxOi0uZ/X5ROPMf10O9/jpivKJqt220iFjii/YBuc3mH0og
        jNSEjwn0nIc+O6raHJBl9q2NRa/zq5EbFIftbhS0In6BOsGKGYeDBs897PMJMg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1649467643;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pj7zAY+ecbdHbFINkS7R1cfeTd265W+vWoWHJuTlpxo=;
        b=QT6f4+wuoxz1nwco4jdxYD4xnT/VFU0tlMvnkX2L0cN2nYi9HHK4vICrY/b+tUPCykdbGo
        LzaoQgRPwJa/XoDA==
From:   "tip-bot2 for Kirill A. Shutemov" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/tdx] x86/tdx: Make pages shared in ioremap()
Cc:     Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220405232939.73860-26-kirill.shutemov@linux.intel.com>
References: <20220405232939.73860-26-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Message-ID: <164946764230.4207.8183154708201575322.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/tdx branch of tip:

Commit-ID:     9aa6ea69852c46e551f4180dce4208bd53df418c
Gitweb:        https://git.kernel.org/tip/9aa6ea69852c46e551f4180dce4208bd53df418c
Author:        Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
AuthorDate:    Wed, 06 Apr 2022 02:29:34 +03:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Thu, 07 Apr 2022 08:27:53 -07:00

x86/tdx: Make pages shared in ioremap()

In TDX guests, guest memory is protected from host access. If a guest
performs I/O, it needs to explicitly share the I/O memory with the host.

Make all ioremap()ed pages that are not backed by normal memory
(IORES_DESC_NONE or IORES_DESC_RESERVED) mapped as shared.

The permissions in PAGE_KERNEL_IO already work for "decrypted" memory
on AMD SEV/SME systems.  That means that they have no need to make a
pgprot_decrypted() call.

TDX guests, on the other hand, _need_ change to PAGE_KERNEL_IO for
"decrypted" mappings.  Add a pgprot_decrypted() for TDX.

Co-developed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Reviewed-by: Andi Kleen <ak@linux.intel.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
Reviewed-by: Dave Hansen <dave.hansen@linux.intel.com>
Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lkml.kernel.org/r/20220405232939.73860-26-kirill.shutemov@linux.intel.com
---
 arch/x86/mm/ioremap.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/x86/mm/ioremap.c b/arch/x86/mm/ioremap.c
index 17a492c..1ad0228 100644
--- a/arch/x86/mm/ioremap.c
+++ b/arch/x86/mm/ioremap.c
@@ -242,10 +242,15 @@ __ioremap_caller(resource_size_t phys_addr, unsigned long size,
 	 * If the page being mapped is in memory and SEV is active then
 	 * make sure the memory encryption attribute is enabled in the
 	 * resulting mapping.
+	 * In TDX guests, memory is marked private by default. If encryption
+	 * is not requested (using encrypted), explicitly set decrypt
+	 * attribute in all IOREMAPPED memory.
 	 */
 	prot = PAGE_KERNEL_IO;
 	if ((io_desc.flags & IORES_MAP_ENCRYPTED) || encrypted)
 		prot = pgprot_encrypted(prot);
+	else
+		prot = pgprot_decrypted(prot);
 
 	switch (pcm) {
 	case _PAGE_CACHE_MODE_UC:
