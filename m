Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 963F35ADC26
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 02:02:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232817AbiIFACm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 20:02:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232775AbiIFACh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 20:02:37 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B107067C90;
        Mon,  5 Sep 2022 17:02:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3ED11B8076C;
        Tue,  6 Sep 2022 00:02:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACB9CC433D6;
        Tue,  6 Sep 2022 00:02:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662422554;
        bh=oHvBd1ffjg/s99ZfllkCt1FwNVqrZNIyO0l4IQri3jg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MWZ2XNtzxXH+LoDhqOpqMUo+Skcrg54DLcy62PLlsKo9qs6t2ozRHr6Rjt1GLe3i2
         ljAy9qrlACo5Oa7ugT9sczKB6XVfmjFObouougVGngeZyHwXDKOSi4AYiSfOS4WI6+
         qG/5RkI6lPBpIv8mMswwhrduC4zxt3fvsNqGUEWBQ4DVm8c8YesyYCkst+xzqKsMwT
         1d9foAHPpE8YwzkLLSKiknU87BJjAWFJon2snPBEcVpruAm+hXWb1Skz0ycrI8h9l5
         1lu4Q14WL57RrF/iaI7VQpEuemMIQCxRii62JazaPztmEG1v4BOaB5AYmtkCwaP6r2
         qwfBBEbJpffnw==
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     linux-sgx@vger.kernel.org
Cc:     Haitao Huang <haitao.huang@linux.intel.com>,
        Vijay Dhanraj <vijay.dhanraj@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Kai Huang <kai.huang@intel.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org (maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)),
        "H. Peter Anvin" <hpa@zytor.com>,
        linux-kernel@vger.kernel.org (open list:X86 ARCHITECTURE (32-BIT AND
        64-BIT))
Subject: [PATCH v3 2/2] x86/sgx: Handle VA page allocation failure for EAUG on PF.
Date:   Tue,  6 Sep 2022 03:02:21 +0300
Message-Id: <20220906000221.34286-3-jarkko@kernel.org>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220906000221.34286-1-jarkko@kernel.org>
References: <20220906000221.34286-1-jarkko@kernel.org>
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
v4:
* Remove extra white space.

v3:
* Added Reinette's ack.

v2:
* Removed reviewed-by, no other changes.
---
 arch/x86/kernel/cpu/sgx/encl.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/sgx/encl.c b/arch/x86/kernel/cpu/sgx/encl.c
index f40d64206ded..9f13d724172e 100644
--- a/arch/x86/kernel/cpu/sgx/encl.c
+++ b/arch/x86/kernel/cpu/sgx/encl.c
@@ -347,8 +347,11 @@ static vm_fault_t sgx_encl_eaug_page(struct vm_area_struct *vma,
 	}
 
 	va_page = sgx_encl_grow(encl, false);
-	if (IS_ERR(va_page))
+	if (IS_ERR(va_page)) {
+		if (PTR_ERR(va_page) == -EBUSY)
+			vmret = VM_FAULT_NOPAGE;
 		goto err_out_epc;
+	}
 
 	if (va_page)
 		list_add(&va_page->list, &encl->va_pages);
-- 
2.37.2

