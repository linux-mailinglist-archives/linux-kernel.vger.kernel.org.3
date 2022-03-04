Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 034124CD165
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 10:40:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239240AbiCDJks (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 04:40:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239367AbiCDJiE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 04:38:04 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68B991AC284;
        Fri,  4 Mar 2022 01:36:48 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4DD8EB827BE;
        Fri,  4 Mar 2022 09:36:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8D75C340E9;
        Fri,  4 Mar 2022 09:36:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646386606;
        bh=q8pqqOEI7ayWuSh5x4Y1jlB8BVxBB20xk/YPxulohaY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=f7n1UFcN/J0zCiEl/D83rTS0ODcmTuUY/1xKn3quJD9iaFrROzg/DQZfvWqHFPyrB
         T84pqn+NymP2bICBF2JfsD+3H9gQqmkWMYDUXbkL1HoC+Rvy6t1UYuxCgRcA8w8INb
         wstW9A9jcuwrTYBbDIg1ax/20dYXaieJRTuYMBL8ZGSC9YTpcqAzRMmNAAvvZGcK8N
         WcDADyAEJmaNF3zoBjexM7bhZI0qq25QdWutll7Oblk/7KUWB75Sn601qZpgzmsrIe
         SM/1Xuu7c8IFR2KWDzC0kf9ksRzBB4BKTd+LEUP/wCIlClskZoORmye9PRtIxA1rzQ
         Q4oOwYS5mPDjw==
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
Subject: [RFC PATCH v2.1 12/30] x86/sgx: Create utility to validate user provided offset and length
Date:   Fri,  4 Mar 2022 11:35:06 +0200
Message-Id: <20220304093524.397485-12-jarkko@kernel.org>
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

User provided offset and length is validated when parsing the parameters
of the SGX_IOC_ENCLAVE_ADD_PAGES ioctl(). Extract this validation
into a utility that can be used by the SGX2 ioctl()s that will
also provide these values.

Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
---
 arch/x86/kernel/cpu/sgx/ioctl.c | 28 ++++++++++++++++++++++------
 1 file changed, 22 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kernel/cpu/sgx/ioctl.c b/arch/x86/kernel/cpu/sgx/ioctl.c
index 83df20e3e633..f487549bccba 100644
--- a/arch/x86/kernel/cpu/sgx/ioctl.c
+++ b/arch/x86/kernel/cpu/sgx/ioctl.c
@@ -372,6 +372,26 @@ static int sgx_encl_add_page(struct sgx_encl *encl, unsigned long src,
 	return ret;
 }
 
+/*
+ * Ensure user provided offset and length values are valid for
+ * an enclave.
+ */
+static int sgx_validate_offset_length(struct sgx_encl *encl,
+				      unsigned long offset,
+				      unsigned long length)
+{
+	if (!IS_ALIGNED(offset, PAGE_SIZE))
+		return -EINVAL;
+
+	if (!length || length & (PAGE_SIZE - 1))
+		return -EINVAL;
+
+	if (offset + length - PAGE_SIZE >= encl->size)
+		return -EINVAL;
+
+	return 0;
+}
+
 /**
  * sgx_ioc_enclave_add_pages() - The handler for %SGX_IOC_ENCLAVE_ADD_PAGES
  * @encl:       an enclave pointer
@@ -425,14 +445,10 @@ static long sgx_ioc_enclave_add_pages(struct sgx_encl *encl, void __user *arg)
 	if (copy_from_user(&add_arg, arg, sizeof(add_arg)))
 		return -EFAULT;
 
-	if (!IS_ALIGNED(add_arg.offset, PAGE_SIZE) ||
-	    !IS_ALIGNED(add_arg.src, PAGE_SIZE))
-		return -EINVAL;
-
-	if (!add_arg.length || add_arg.length & (PAGE_SIZE - 1))
+	if (!IS_ALIGNED(add_arg.src, PAGE_SIZE))
 		return -EINVAL;
 
-	if (add_arg.offset + add_arg.length - PAGE_SIZE >= encl->size)
+	if (sgx_validate_offset_length(encl, add_arg.offset, add_arg.length))
 		return -EINVAL;
 
 	if (copy_from_user(&secinfo, (void __user *)add_arg.secinfo,
-- 
2.35.1

