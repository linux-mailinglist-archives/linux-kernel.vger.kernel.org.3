Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5943F4D0305
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 16:35:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243824AbiCGPgq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 10:36:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235983AbiCGPgo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 10:36:44 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 897BD5C373;
        Mon,  7 Mar 2022 07:35:50 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 36FD5B815E5;
        Mon,  7 Mar 2022 15:35:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50F40C340E9;
        Mon,  7 Mar 2022 15:35:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646667347;
        bh=JbY5diFr5DxLb353nQpEtMPOmLgwWU265WRVU2Sa3gs=;
        h=From:To:Cc:Subject:Date:From;
        b=TQZVPcmNWFx3KoCVbAtcqbmRxBlREjxRlqgYPDRU+Erw7qGlNkJDbSAgTBy2wzkFq
         BI/wXu31ar6PvEUzPO442Zbn1oeAelVVtdsnd10dI2AVp8OuqsK+PnRx/FQ216yVDZ
         LFFnvbvYe4kXQXZbAznh/2RF1rIiA/X4mWHqPJzmHbgiJhQ7K6mp3uVEN3CrMrs+Qc
         DQJcr7NnRQkK4SD+wblqWNAA8Gphl4orMBRcvlPyUiGc/lsAs9t5IFCBOAevBGiEW2
         G+oz7dajXVHK9hGSQMdWtgmkUk3ZHtnWIsLpYJp0WpuvECsvUD9DhjTSLDe58mFbVr
         ok5uLUOmV6gAA==
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     linux-sgx@vger.kernel.org
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        Nathaniel McCallum <nathaniel@profian.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] x86/sgx: Enable PROT_EXEC for EAUG'd pages
Date:   Mon,  7 Mar 2022 17:35:04 +0200
Message-Id: <20220307153504.198112-1-jarkko@kernel.org>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

vm_max_permissions was created to control the pre-initialization content
that contributes to MRSIGNATURE. It was never meant to be as a limit to
dynamically added pages.

E.g. static content could be used as a hook for LSM's to decide whether
certain signature is qualified for EINIT. Dynamic content has nothing to
do with that. The current mechanisms only add to the complexity on how
to control PTE and EPCM permissions, and do not add anything else than
obfuscity to security side of things.

Thus add PROT_EXEC to the permissions assigned by the #PF handler.

Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
---
 arch/x86/kernel/cpu/sgx/encl.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kernel/cpu/sgx/encl.c b/arch/x86/kernel/cpu/sgx/encl.c
index 79e39bd99c09..0256918b2c2f 100644
--- a/arch/x86/kernel/cpu/sgx/encl.c
+++ b/arch/x86/kernel/cpu/sgx/encl.c
@@ -160,12 +160,11 @@ static vm_fault_t sgx_encl_eaug_page(struct vm_area_struct *vma,
 	encl_page->encl = encl;
 
 	/*
-	 * Adding a regular page that is architecturally allowed to only
-	 * be created with RW permissions.
-	 * TBD: Interface with user space policy to support max permissions
-	 * of RWX.
+	 * Dynamic pages do not contribute to MRSIGNATURE, i.e. they are
+	 * controlled only by PTE and EPCM permissions. Thus, the no limit
+	 * is set here.
 	 */
-	prot = PROT_READ | PROT_WRITE;
+	prot = PROT_READ | PROT_WRITE | PROT_EXEC;
 	encl_page->vm_run_prot_bits = calc_vm_prot_bits(prot, 0);
 	encl_page->vm_max_prot_bits = encl_page->vm_run_prot_bits;
 
-- 
2.35.1

