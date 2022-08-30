Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB0D95A59C1
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 05:12:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229884AbiH3DMi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 23:12:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbiH3DM2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 23:12:28 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 912D87DF4A;
        Mon, 29 Aug 2022 20:12:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 46663B8161C;
        Tue, 30 Aug 2022 03:12:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB36EC433D6;
        Tue, 30 Aug 2022 03:12:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661829144;
        bh=lznlkIuqmIdDflb0pFZ7yvm9vSB5zZEIh/s6OQGarcg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bk+qlmdiUylolUTXjQcdohf2EkVXGswl+whCuVTFkhwNQaLIbLmhjUcAVgGYBttq/
         LG6uNAwjJq/X+GlxBZ2Y0lcM9JF5hsPBSnq9W33TemqIVvJEkH6fDb3p11ED/F4Z4s
         qyl8ezXuWMPyA5D0Sbded7b6BeAlHjYaNLeW9YBnuePPH+fCNhWX5uh1En7ysBMnpB
         onUKONDc5FaLpu3+494eHFUXbAKG7vPw5gjJlaxsu5a/v3YziLANVSO8CU4rTI0f80
         oxFBZSd4EwIsMfJlY+l8N2MLnAPsO9GENNIDXeNtLY5n98+30M3yQzUxVAigs3mwbF
         qKn/WXwqvsulg==
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     linux-sgx@vger.kernel.org
Cc:     Haitao Huang <haitao.huang@linux.intel.com>,
        Vijay Dhanraj <vijay.dhanraj@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org (maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)),
        "H. Peter Anvin" <hpa@zytor.com>,
        linux-kernel@vger.kernel.org (open list:X86 ARCHITECTURE (32-BIT AND
        64-BIT))
Subject: [PATCH 2/6] x86/sgx: Handle VA page allocation failure for EAUG on PF.
Date:   Tue, 30 Aug 2022 06:12:02 +0300
Message-Id: <20220830031206.13449-3-jarkko@kernel.org>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220830031206.13449-1-jarkko@kernel.org>
References: <20220830031206.13449-1-jarkko@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Haitao Huang <haitao.huang@linux.intel.com>

VM_FAULT_NOPAGE is expected behaviour for -EBUSY failure path, when
augmenting a page, as this means that the reclaimer thread has been
triggered, and the intention is just to round-trip in ring-3, and
retry with a new page fault.

Fixes: 5a90d2c3f5ef ("x86/sgx: Support adding of pages to an initialized enclave")
Signed-off-by: Haitao Huang <haitao.huang@linux.intel.com>
Tested-by: Vijay Dhanraj <vijay.dhanraj@intel.com>
Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
---
v2:
* Removed reviewed-by, no other changes.
---
 arch/x86/kernel/cpu/sgx/encl.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/sgx/encl.c b/arch/x86/kernel/cpu/sgx/encl.c
index 24c1bb8eb196..de92c1c8b79d 100644
--- a/arch/x86/kernel/cpu/sgx/encl.c
+++ b/arch/x86/kernel/cpu/sgx/encl.c
@@ -344,8 +344,11 @@ static vm_fault_t sgx_encl_eaug_page(struct vm_area_struct *vma,
 	}
 
 	va_page = sgx_encl_grow(encl, false);
-	if (IS_ERR(va_page))
+	if (IS_ERR(va_page)) {
+		if (PTR_ERR(va_page) == -EBUSY)
+			vmret =  VM_FAULT_NOPAGE;
 		goto err_out_epc;
+	}
 
 	if (va_page)
 		list_add(&va_page->list, &encl->va_pages);
-- 
2.37.2

