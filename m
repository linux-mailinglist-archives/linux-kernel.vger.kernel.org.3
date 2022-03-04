Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95E664CD148
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 10:37:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239092AbiCDJij (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 04:38:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239290AbiCDJiA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 04:38:00 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10FED1AAA5E;
        Fri,  4 Mar 2022 01:36:40 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BB54EB827BD;
        Fri,  4 Mar 2022 09:36:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B9D4C340F1;
        Fri,  4 Mar 2022 09:36:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646386597;
        bh=yRyCeWv+M3IKj32rt53/t5L1zqgAFTq44e0cYPNfNgM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AWevxKTjTpkL7dMammx1Ok1LoLGurgaDBfaGZ6isThp3tdPDUgBnuHVpvfqtLA9gG
         AM06mWej8mQZZ5sk0dW+sbeeTVh3/w2PihHqR3i2WngLxxqA73EdJD886yrBAhkES5
         vZaHpkWHpvXjBiKdB075ULa910DSONqqIUV9a+W7IR/n1xep7FCEHz29u5wbehLR4q
         GgwR+VS4u12d01TQ8lxGgB2/h7QYzDskAw/d7VqCPdaTD/AAe4wsq7FCAM1VjGHknw
         JJ85qAqa7QYuFoN+gVpHJ2M4BGMlC72ucxI52SbFgnT5WI0LjoQ834ZHUFnCYSqAhA
         bLXr60qqeX/xg==
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     linux-sgx@vger.kernel.org
Cc:     Nathaniel McCallum <nathaniel@profian.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org (maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)),
        "H. Peter Anvin" <hpa@zytor.com>,
        linux-kernel@vger.kernel.org (open list:X86 ARCHITECTURE (32-BIT AND
        64-BIT))
Subject: [RFC PATCH v2.1 09/30] x86/sgx: Rename sgx_encl_ewb_cpumask() as sgx_encl_cpumask()
Date:   Fri,  4 Mar 2022 11:35:03 +0200
Message-Id: <20220304093524.397485-9-jarkko@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220304093524.397485-1-jarkko@kernel.org>
References: <20220304093524.397485-1-jarkko@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Reinette Chatre <reinette.chatre@intel.com>

sgx_encl_ewb_cpumask() is no longer unique to the reclaimer where it
is used during the EWB ENCLS leaf function when EPC pages are written
out to main memory and sgx_encl_ewb_cpumask() is used to learn which
CPUs might have executed the enclave to ensure that TLBs are cleared.

Upcoming SGX2 enabling will use sgx_encl_ewb_cpumask() during the
EMODPR and EMODT ENCLS leaf functions that make changes to enclave
pages. The function is needed for the same reason it is used now: to
learn which CPUs might have executed the enclave to ensure that TLBs
no longer point to the changed pages.

Rename sgx_encl_ewb_cpumask() to sgx_encl_cpumask() to reflect the
broader usage.

Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
---
 arch/x86/kernel/cpu/sgx/encl.c | 6 +++---
 arch/x86/kernel/cpu/sgx/encl.h | 2 +-
 arch/x86/kernel/cpu/sgx/main.c | 2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kernel/cpu/sgx/encl.c b/arch/x86/kernel/cpu/sgx/encl.c
index 353866e1b16f..54716886e804 100644
--- a/arch/x86/kernel/cpu/sgx/encl.c
+++ b/arch/x86/kernel/cpu/sgx/encl.c
@@ -596,7 +596,7 @@ int sgx_encl_mm_add(struct sgx_encl *encl, struct mm_struct *mm)
 }
 
 /**
- * sgx_encl_ewb_cpumask() - Query which CPUs might be accessing the enclave
+ * sgx_encl_cpumask() - Query which CPUs might be accessing the enclave
  * @encl: the enclave
  *
  * Some SGX functions require that no cached linear-to-physical address
@@ -621,7 +621,7 @@ int sgx_encl_mm_add(struct sgx_encl *encl, struct mm_struct *mm)
  * The following flow is used to support SGX functions that require that
  * no cached linear-to-physical address mappings are present:
  * 1) Execute ENCLS[ETRACK] to initiate hardware tracking.
- * 2) Use this function (sgx_encl_ewb_cpumask()) to query which CPUs might be
+ * 2) Use this function (sgx_encl_cpumask()) to query which CPUs might be
  *    accessing the enclave.
  * 3) Send IPI to identified CPUs, kicking them out of the enclave and
  *    thus flushing all locally cached linear-to-physical address mappings.
@@ -638,7 +638,7 @@ int sgx_encl_mm_add(struct sgx_encl *encl, struct mm_struct *mm)
  *
  * Return: cpumask of CPUs that might be accessing @encl
  */
-const cpumask_t *sgx_encl_ewb_cpumask(struct sgx_encl *encl)
+const cpumask_t *sgx_encl_cpumask(struct sgx_encl *encl)
 {
 	cpumask_t *cpumask = &encl->cpumask;
 	struct sgx_encl_mm *encl_mm;
diff --git a/arch/x86/kernel/cpu/sgx/encl.h b/arch/x86/kernel/cpu/sgx/encl.h
index 2b15615be8c6..817edefa884a 100644
--- a/arch/x86/kernel/cpu/sgx/encl.h
+++ b/arch/x86/kernel/cpu/sgx/encl.h
@@ -105,7 +105,7 @@ int sgx_encl_may_map(struct sgx_encl *encl, unsigned long start,
 
 void sgx_encl_release(struct kref *ref);
 int sgx_encl_mm_add(struct sgx_encl *encl, struct mm_struct *mm);
-const cpumask_t *sgx_encl_ewb_cpumask(struct sgx_encl *encl);
+const cpumask_t *sgx_encl_cpumask(struct sgx_encl *encl);
 int sgx_encl_get_backing(struct sgx_encl *encl, unsigned long page_index,
 			 struct sgx_backing *backing);
 void sgx_encl_put_backing(struct sgx_backing *backing, bool do_write);
diff --git a/arch/x86/kernel/cpu/sgx/main.c b/arch/x86/kernel/cpu/sgx/main.c
index d481e8b0e7bc..60b166bff7b4 100644
--- a/arch/x86/kernel/cpu/sgx/main.c
+++ b/arch/x86/kernel/cpu/sgx/main.c
@@ -249,7 +249,7 @@ static void sgx_encl_ewb(struct sgx_epc_page *epc_page,
 			 * miss cpus that entered the enclave between
 			 * generating the mask and incrementing epoch.
 			 */
-			on_each_cpu_mask(sgx_encl_ewb_cpumask(encl),
+			on_each_cpu_mask(sgx_encl_cpumask(encl),
 					 sgx_ipi_cb, NULL, 1);
 			ret = __sgx_encl_ewb(epc_page, va_slot, backing);
 		}
-- 
2.35.1

