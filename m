Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C74B25A8486
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 19:39:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231781AbiHaRjB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 13:39:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231589AbiHaRiy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 13:38:54 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0849ECE471;
        Wed, 31 Aug 2022 10:38:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2F4EBB82208;
        Wed, 31 Aug 2022 17:38:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41D16C433C1;
        Wed, 31 Aug 2022 17:38:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661967528;
        bh=1XnNxYR9RSbb/vkYYF6VkKUg43EOapdgqiqUmDnjOCM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=el2QlU4PNW9l8m9Z5RqSYN9ShBNT0DEyKCpZX2kY7ltm/8z/FL7dnT+cRaDohN42I
         6yBensEzYyW0udGJb+u1geFrMy9DE1g8Z3yFPKOO/BysyI8tFO+BIoJODvn4JsdkPS
         w2pONEYKKhn2lNfTvNqJGbUF2PcBe0c69NggPicTfRkZYZUJA8w7t/kNi0Zlp9P4/5
         USe6kgHIgaq3sJh1jmsYNHKZBw1YfUINZjeks6Uco08FvRjZ2eMbDJhNfbmCy+tG5V
         9Yp/FulqPUSE4AG38D1w+ZH5BqZyKIR7/is0e/THybpOnxJTazNHSXijNusOgMBVX1
         MAQQAz8/sqKJw==
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     linux-sgx@vger.kernel.org
Cc:     Haitao Huang <haitao.huang@linux.intel.com>,
        Vijay Dhanraj <vijay.dhanraj@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Paul Menzel <pmenzel@molgen.mpg.de>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org (maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)),
        "H. Peter Anvin" <hpa@zytor.com>,
        linux-kernel@vger.kernel.org (open list:X86 ARCHITECTURE (32-BIT AND
        64-BIT))
Subject: [PATCH v2 3/6] x86/sgx: Handle VA page allocation failure for EAUG on PF.
Date:   Wed, 31 Aug 2022 20:38:26 +0300
Message-Id: <20220831173829.126661-4-jarkko@kernel.org>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220831173829.126661-1-jarkko@kernel.org>
References: <20220831173829.126661-1-jarkko@kernel.org>
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
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
---
v3:
* Added Reinette's ack.

v2:
* Removed reviewed-by, no other changes.
---
 arch/x86/kernel/cpu/sgx/encl.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/sgx/encl.c b/arch/x86/kernel/cpu/sgx/encl.c
index f40d64206ded..c0fd98a1c658 100644
--- a/arch/x86/kernel/cpu/sgx/encl.c
+++ b/arch/x86/kernel/cpu/sgx/encl.c
@@ -347,8 +347,11 @@ static vm_fault_t sgx_encl_eaug_page(struct vm_area_struct *vma,
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

