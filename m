Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66C5B56BF90
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 20:36:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238614AbiGHRIZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 13:08:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232885AbiGHRIX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 13:08:23 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0994B675A3;
        Fri,  8 Jul 2022 10:08:18 -0700 (PDT)
Date:   Fri, 08 Jul 2022 17:08:14 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1657300095;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HEeeNKkKfpAyXXGZb5h2rQb6WrXOrmy6AZrVXbSV7yQ=;
        b=geOmLUSIavp0x+XmP8GexYCAOO/YBi9V8ZtICODohwicZ7MY2EqV7VOwmJsg9aNbus17ME
        OXNedrhsjkdVUfXCELuJmRLYsTqDkzBdaS1f1R1SMWkYWBdYQqHjb9dMQsbGzstgIrFC/+
        LTtRrB5KzpJ5DAcntsBsURyazMYmSRQPN3HHPhpEkOSm3vO+hwn6hrYQjC/gyXO5ZqUCfz
        54SotL5LvE6OWS2ut+9emjdfG1lBwp3EL2zHqY+BFqlwATvXZb0jAr8vyYwW/fvAFJ95KW
        qBkoygJ7loIfh5HZM+h5aFWxpRqKFx6jqvIRuv6ofIIHmMpyXrJ47mTfDlXmHQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1657300095;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HEeeNKkKfpAyXXGZb5h2rQb6WrXOrmy6AZrVXbSV7yQ=;
        b=VWXcRfm2FoC8IMRm8VWgvlUHzdWbd1/IgEtk5eAvvSJ2eTdVuoMA4AwYRRBvd9fJtmudgh
        cm1oQepBmiEN6CAg==
From:   "tip-bot2 for Sean Christopherson" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/sgx] x86/sgx: Drop 'page_index' from sgx_backing
Cc:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Kristen Carlson Accardi <kristen@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220708162124.8442-1-kristen@linux.intel.com>
References: <20220708162124.8442-1-kristen@linux.intel.com>
MIME-Version: 1.0
Message-ID: <165730009436.15455.4017448965985915771.tip-bot2@tip-bot2>
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

Commit-ID:     e0a5915f1cca21da8ffc0563aea9fa1df5d16fb4
Gitweb:        https://git.kernel.org/tip/e0a5915f1cca21da8ffc0563aea9fa1df5d16fb4
Author:        Sean Christopherson <sean.j.christopherson@intel.com>
AuthorDate:    Fri, 08 Jul 2022 09:21:24 -07:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Fri, 08 Jul 2022 09:31:11 -07:00

x86/sgx: Drop 'page_index' from sgx_backing

Storing the 'page_index' value in the sgx_backing struct is
dead code and no longer needed.

Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
Signed-off-by: Kristen Carlson Accardi <kristen@linux.intel.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Link: https://lkml.kernel.org/r/20220708162124.8442-1-kristen@linux.intel.com
---
 arch/x86/kernel/cpu/sgx/encl.c | 1 -
 arch/x86/kernel/cpu/sgx/encl.h | 1 -
 2 files changed, 2 deletions(-)

diff --git a/arch/x86/kernel/cpu/sgx/encl.c b/arch/x86/kernel/cpu/sgx/encl.c
index 295a9c9..73bfc5a 100644
--- a/arch/x86/kernel/cpu/sgx/encl.c
+++ b/arch/x86/kernel/cpu/sgx/encl.c
@@ -943,7 +943,6 @@ int sgx_encl_get_backing(struct sgx_encl *encl, unsigned long page_index,
 		return PTR_ERR(pcmd);
 	}
 
-	backing->page_index = page_index;
 	backing->contents = contents;
 	backing->pcmd = pcmd;
 	backing->pcmd_offset = page_pcmd_off & (PAGE_SIZE - 1);
diff --git a/arch/x86/kernel/cpu/sgx/encl.h b/arch/x86/kernel/cpu/sgx/encl.h
index 3d0e0ba..57cc236 100644
--- a/arch/x86/kernel/cpu/sgx/encl.h
+++ b/arch/x86/kernel/cpu/sgx/encl.h
@@ -79,7 +79,6 @@ struct sgx_va_page {
 };
 
 struct sgx_backing {
-	pgoff_t page_index;
 	struct page *contents;
 	struct page *pcmd;
 	unsigned long pcmd_offset;
