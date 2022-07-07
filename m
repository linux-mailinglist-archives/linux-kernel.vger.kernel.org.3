Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57FA256AA9E
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 20:31:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236452AbiGGS20 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 14:28:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236409AbiGGS1o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 14:27:44 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0068F5C95C;
        Thu,  7 Jul 2022 11:27:41 -0700 (PDT)
Date:   Thu, 07 Jul 2022 18:27:39 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1657218460;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VNZQSRI4ajrZpIgejttQHrXcpJ0cMxK/e0DsgWC+O04=;
        b=C/hhB7gQU4KGI2rHgZ6G8Q7JZJkDOOglfuWtSp6KEg2dT0YTuFLFAm3NHWlRbqU7SteEC1
        PokjMuZi4rSpDRnOuC6g4eXdgedy0b1LoEefRD9CBdBicPEEoevPlfGekpq59Ozu/WNzcj
        7AjoqNJEljwkxjwy/3aP/MJqsYtbE7KjZSsy4vSVyzGKFb4f7FoXsrShRcYBBVEIO/W7kC
        Q4earMCNqAhWZJ+n5dQIqtCOtAHRBioYBZSs/LftTVwdthyM9XOQYSiPqLcb8eubSwT8v/
        Z0lqa7pey7M2gkz4R8ffQkvcVzI1fOCCnz/hWLvY//kBrr9fFRhi/kQZcwr9JA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1657218460;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VNZQSRI4ajrZpIgejttQHrXcpJ0cMxK/e0DsgWC+O04=;
        b=uHTHTB3VywCDXvjo4w5xaLFb+C2hRA+8lhhMABeduHCzzWzB/7duQEUVLYMf9Yi8IkBOuh
        yH2lZHbro2wxBSCw==
From:   "tip-bot2 for Reinette Chatre" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/sgx] x86/sgx: Free up EPC pages directly to support large
 page ranges
Cc:     Reinette Chatre <reinette.chatre@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Jarkko Sakkinen <jarkko@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: =?utf-8?q?=3Ca0d8f037c4a075d56bf79f432438412985f7ff7a=2E16521?=
 =?utf-8?q?37848=2Egit=2Ereinette=2Echatre=40intel=2Ecom=3E?=
References: =?utf-8?q?=3Ca0d8f037c4a075d56bf79f432438412985f7ff7a=2E165213?=
 =?utf-8?q?7848=2Egit=2Ereinette=2Echatre=40intel=2Ecom=3E?=
MIME-Version: 1.0
Message-ID: <165721845959.15455.13984351562767754289.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/sgx branch of tip:

Commit-ID:     a0506b3b063641f0a05b2a4399442a38aad22291
Gitweb:        https://git.kernel.org/tip/a0506b3b063641f0a05b2a4399442a38aad22291
Author:        Reinette Chatre <reinette.chatre@intel.com>
AuthorDate:    Tue, 10 May 2022 11:08:56 -07:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Thu, 07 Jul 2022 10:13:03 -07:00

x86/sgx: Free up EPC pages directly to support large page ranges

The page reclaimer ensures availability of EPC pages across all
enclaves. In support of this it runs independently from the
individual enclaves in order to take locks from the different
enclaves as it writes pages to swap.

When needing to load a page from swap an EPC page needs to be
available for its contents to be loaded into. Loading an existing
enclave page from swap does not reclaim EPC pages directly if
none are available, instead the reclaimer is woken when the
available EPC pages are found to be below a watermark.

When iterating over a large number of pages in an oversubscribed
environment there is a race between the reclaimer woken up and
EPC pages reclaimed fast enough for the page operations to proceed.

Ensure there are EPC pages available before attempting to load
a page that may potentially be pulled from swap into an available
EPC page.

Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Acked-by: Jarkko Sakkinen <jarkko@kernel.org>
Link: https://lkml.kernel.org/r/a0d8f037c4a075d56bf79f432438412985f7ff7a.1652137848.git.reinette.chatre@intel.com
---
 arch/x86/kernel/cpu/sgx/ioctl.c |  6 ++++++
 arch/x86/kernel/cpu/sgx/main.c  | 11 +++++++++++
 arch/x86/kernel/cpu/sgx/sgx.h   |  1 +
 3 files changed, 18 insertions(+)

diff --git a/arch/x86/kernel/cpu/sgx/ioctl.c b/arch/x86/kernel/cpu/sgx/ioctl.c
index 1a2595f..ebe79d6 100644
--- a/arch/x86/kernel/cpu/sgx/ioctl.c
+++ b/arch/x86/kernel/cpu/sgx/ioctl.c
@@ -745,6 +745,8 @@ sgx_enclave_restrict_permissions(struct sgx_encl *encl,
 	for (c = 0 ; c < modp->length; c += PAGE_SIZE) {
 		addr = encl->base + modp->offset + c;
 
+		sgx_reclaim_direct();
+
 		mutex_lock(&encl->lock);
 
 		entry = sgx_encl_load_page(encl, addr);
@@ -910,6 +912,8 @@ static long sgx_enclave_modify_types(struct sgx_encl *encl,
 	for (c = 0 ; c < modt->length; c += PAGE_SIZE) {
 		addr = encl->base + modt->offset + c;
 
+		sgx_reclaim_direct();
+
 		mutex_lock(&encl->lock);
 
 		entry = sgx_encl_load_page(encl, addr);
@@ -1096,6 +1100,8 @@ static long sgx_encl_remove_pages(struct sgx_encl *encl,
 	for (c = 0 ; c < params->length; c += PAGE_SIZE) {
 		addr = encl->base + params->offset + c;
 
+		sgx_reclaim_direct();
+
 		mutex_lock(&encl->lock);
 
 		entry = sgx_encl_load_page(encl, addr);
diff --git a/arch/x86/kernel/cpu/sgx/main.c b/arch/x86/kernel/cpu/sgx/main.c
index 180ad84..5acd4c5 100644
--- a/arch/x86/kernel/cpu/sgx/main.c
+++ b/arch/x86/kernel/cpu/sgx/main.c
@@ -375,6 +375,17 @@ static bool sgx_should_reclaim(unsigned long watermark)
 	       !list_empty(&sgx_active_page_list);
 }
 
+/*
+ * sgx_reclaim_direct() should be called (without enclave's mutex held)
+ * in locations where SGX memory resources might be low and might be
+ * needed in order to make forward progress.
+ */
+void sgx_reclaim_direct(void)
+{
+	if (sgx_should_reclaim(SGX_NR_LOW_PAGES))
+		sgx_reclaim_pages();
+}
+
 static int ksgxd(void *p)
 {
 	set_freezable();
diff --git a/arch/x86/kernel/cpu/sgx/sgx.h b/arch/x86/kernel/cpu/sgx/sgx.h
index b30cee4..0f20206 100644
--- a/arch/x86/kernel/cpu/sgx/sgx.h
+++ b/arch/x86/kernel/cpu/sgx/sgx.h
@@ -86,6 +86,7 @@ static inline void *sgx_get_epc_virt_addr(struct sgx_epc_page *page)
 struct sgx_epc_page *__sgx_alloc_epc_page(void);
 void sgx_free_epc_page(struct sgx_epc_page *page);
 
+void sgx_reclaim_direct(void);
 void sgx_mark_page_reclaimable(struct sgx_epc_page *page);
 int sgx_unmark_page_reclaimable(struct sgx_epc_page *page);
 struct sgx_epc_page *sgx_alloc_epc_page(void *owner, bool reclaim);
