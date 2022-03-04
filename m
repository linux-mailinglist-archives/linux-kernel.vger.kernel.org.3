Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B626F4CCB3A
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 02:17:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237517AbiCDBSI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 20:18:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236828AbiCDBSH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 20:18:07 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1B4B17B0DC;
        Thu,  3 Mar 2022 17:17:21 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 51176B8272B;
        Fri,  4 Mar 2022 01:17:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8481C340E9;
        Fri,  4 Mar 2022 01:17:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646356639;
        bh=X7GFmAeiZFNUL2ZBPgnJc14xc7vgBJWoZ4umiDmwMF0=;
        h=From:To:Cc:Subject:Date:From;
        b=QFO8J9GxC4PIjUpt4e50S1KT28uYR3Le9VUls3Y/xOSmI84qX0haGizyoOIXYVM+1
         j/gDvu0muXSA3si66ij3wweI336ahcZFlH63NiN+9yg1rykeEDpE09kZZZnX9/DlCD
         fTlVPMtjGUcd1pbwYKu2QR09KHJTx5K7IX4RVT2WWoVzdv/WoXy+Yf0+40qBKz5EKa
         3A518ZiIO8d7Ufam7IGxW+j7gO3lsz4L6lZ89yeZsCZk9iFjyP80/su0FeMcz469cv
         GcTZ1YypDuddT6SQKF6TFXXQ6k4NeEfKYxAbjLsrH8iZxQ7kIs4QgJe2Y3nbGH0Fcv
         HEsxbhO35mIgg==
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     linux-sgx@vger.kernel.org
Cc:     Jarkko Sakkinen <jarkko@kernel.org>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Nathaniel McCallum <nathaniel@profian.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org (maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)),
        "H. Peter Anvin" <hpa@zytor.com>,
        linux-kernel@vger.kernel.org (open list:X86 ARCHITECTURE (32-BIT AND
        64-BIT))
Subject: [PATCH] x86/sgx: Do not limit EAUG'd pages by pre-initialization policy
Date:   Fri,  4 Mar 2022 03:16:35 +0200
Message-Id: <20220304011636.327511-1-jarkko@kernel.org>
X-Mailer: git-send-email 2.35.1
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

Pre-initialization policy is meant for EADD'd pages because they are
part of the enclave identity. It's a good practice to not let touch the
permissions after initialization, and does provide guarantees to e.g.
LSM's about the enclave.

For EAUG'd pages it should be sufficient to let mmap(), mprotect() and
SGX opcodes to control the permissions. Thus effectively disable
pre-initialization policy by setting vm_max_prot_bit and
vm_run_prot_bits to RWX.

Cc: Reinette Chatre <reinette.chatre@intel.com>
Cc: Nathaniel McCallum <nathaniel@profian.com>
Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
---
 arch/x86/kernel/cpu/sgx/encl.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/arch/x86/kernel/cpu/sgx/encl.c b/arch/x86/kernel/cpu/sgx/encl.c
index 5fe7189eac9d..17feb6fa5578 100644
--- a/arch/x86/kernel/cpu/sgx/encl.c
+++ b/arch/x86/kernel/cpu/sgx/encl.c
@@ -200,13 +200,7 @@ static vm_fault_t sgx_encl_eaug_page(struct vm_area_struct *vma,
 	encl_page->desc = addr;
 	encl_page->encl = encl;
 
-	/*
-	 * Adding a regular page that is architecturally allowed to only
-	 * be created with RW permissions.
-	 * TBD: Interface with user space policy to support max permissions
-	 * of RWX.
-	 */
-	prot = PROT_READ | PROT_WRITE;
+	prot = PROT_READ | PROT_WRITE | PROT_EXEC;
 	encl_page->vm_run_prot_bits = calc_vm_prot_bits(prot, 0);
 	encl_page->vm_max_prot_bits = encl_page->vm_run_prot_bits;
 
-- 
2.35.1

