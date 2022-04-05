Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CF0E4F4A44
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 02:41:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1454637AbiDEWjL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 18:39:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1455447AbiDEQAC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 12:00:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE7783EAB9;
        Tue,  5 Apr 2022 08:15:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6DFF3614BF;
        Tue,  5 Apr 2022 15:15:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82C50C385A6;
        Tue,  5 Apr 2022 15:15:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649171733;
        bh=b7HiLYng6ZcxAx+QP9a6ZDXxt7R3Fo4ys8vPQiWJYZA=;
        h=From:To:Cc:Subject:Date:From;
        b=dbWLHWHfXZzDgCWo2NUyR1dwtPqFuYGXJ/9aBoNePziXJchr/loOg0AnDOzH7qZXn
         BfEWs7ZN1sEnWIcLOVM0NHMpWeaJ0UUDqv0dJz8rXHLFrG+i+ePScN5uC+DLwYA/VW
         CMYvtUmMi53jCjSzdbCzNfP+ina0DQc7pf7a4pHF0BA3Whp4TYrqASfwCQVEVVpAWA
         O1Omt7RpLiFuhAPMfxuKrqkLX6Qr1p266A5qoZVPZgR6l++VQPKNeEjVCo49tvWW4L
         0vYFpfL9t8dZvJ5dg3lLmfjM6AbW+qneXeciDzOrFEAkA5Y9897rTXtFHdVQhS7OKB
         F4jGqUm4JVLCQ==
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     linux-sgx@vger.kernel.rog
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Nathaniel McCallum <nathaniel@profian.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org (maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)),
        "H. Peter Anvin" <hpa@zytor.com>,
        linux-sgx@vger.kernel.org (open list:INTEL SGX),
        linux-kernel@vger.kernel.org (open list:X86 ARCHITECTURE (32-BIT AND
        64-BIT))
Subject: [PATCH RFC] x86/sgx: Simplify struct sgx_enclave_restrict_permissions
Date:   Tue,  5 Apr 2022 18:16:41 +0300
Message-Id: <20220405151642.96096-1-jarkko@kernel.org>
X-Mailer: git-send-email 2.35.1
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

The reasoning to change SECINFO to simply flags is stated in this inline
comment:

/*
 * Return valid permission fields from a secinfo structure provided by
 * user space. The secinfo structure is required to only have bits in
 * the permission fields set.
 */

It is better to simply change the parameter type than require to use
a malformed version of a data structure.

Link: https://lore.kernel.org/linux-sgx/26ab773de8842d03b40caf8645ca86884b195901.camel@kernel.org/T/#u
Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
---
Only compile-tested.
 arch/x86/include/uapi/asm/sgx.h |  5 ++-
 arch/x86/kernel/cpu/sgx/ioctl.c | 57 ++++++---------------------------
 2 files changed, 12 insertions(+), 50 deletions(-)

diff --git a/arch/x86/include/uapi/asm/sgx.h b/arch/x86/include/uapi/asm/sgx.h
index feda7f85b2ce..627136798f2a 100644
--- a/arch/x86/include/uapi/asm/sgx.h
+++ b/arch/x86/include/uapi/asm/sgx.h
@@ -88,15 +88,14 @@ struct sgx_enclave_provision {
  * @offset:	starting page offset (page aligned relative to enclave base
  *		address defined in SECS)
  * @length:	length of memory (multiple of the page size)
- * @secinfo:	address for the SECINFO data containing the new permission bits
- *		for pages in range described by @offset and @length
+ * @flags:	flags field of the SECINFO data
  * @result:	(output) SGX result code of ENCLS[EMODPR] function
  * @count:	(output) bytes successfully changed (multiple of page size)
  */
 struct sgx_enclave_restrict_permissions {
 	__u64 offset;
 	__u64 length;
-	__u64 secinfo;
+	__u64 flags;
 	__u64 result;
 	__u64 count;
 };
diff --git a/arch/x86/kernel/cpu/sgx/ioctl.c b/arch/x86/kernel/cpu/sgx/ioctl.c
index f88bc1236276..3c334e0bd4d9 100644
--- a/arch/x86/kernel/cpu/sgx/ioctl.c
+++ b/arch/x86/kernel/cpu/sgx/ioctl.c
@@ -676,41 +676,6 @@ static int sgx_ioc_sgx2_ready(struct sgx_encl *encl)
 	return 0;
 }
 
-/*
- * Return valid permission fields from a secinfo structure provided by
- * user space. The secinfo structure is required to only have bits in
- * the permission fields set.
- */
-static int sgx_perm_from_user_secinfo(void __user *_secinfo, u64 *secinfo_perm)
-{
-	struct sgx_secinfo secinfo;
-	u64 perm;
-
-	if (copy_from_user(&secinfo, (void __user *)_secinfo,
-			   sizeof(secinfo)))
-		return -EFAULT;
-
-	if (secinfo.flags & ~SGX_SECINFO_PERMISSION_MASK)
-		return -EINVAL;
-
-	if (memchr_inv(secinfo.reserved, 0, sizeof(secinfo.reserved)))
-		return -EINVAL;
-
-	perm = secinfo.flags & SGX_SECINFO_PERMISSION_MASK;
-
-	/*
-	 * Read access is required for the enclave to be able to use the page.
-	 * SGX instructions like ENCLU[EMODPE] and ENCLU[EACCEPT] require
-	 * read access.
-	 */
-	if (!(perm & SGX_SECINFO_R))
-		return -EINVAL;
-
-	*secinfo_perm = perm;
-
-	return 0;
-}
-
 /*
  * Some SGX functions require that no cached linear-to-physical address
  * mappings are present before they can succeed. Collaborate with
@@ -753,7 +718,6 @@ static int sgx_enclave_etrack(struct sgx_encl *encl)
  * sgx_enclave_restrict_permissions() - Restrict EPCM permissions
  * @encl:	Enclave to which the pages belong.
  * @modp:	Checked parameters from user on which pages need modifying.
- * @secinfo_perm: New (validated) permission bits.
  *
  * Return:
  * - 0:		Success.
@@ -761,8 +725,7 @@ static int sgx_enclave_etrack(struct sgx_encl *encl)
  */
 static long
 sgx_enclave_restrict_permissions(struct sgx_encl *encl,
-				 struct sgx_enclave_restrict_permissions *modp,
-				 u64 secinfo_perm)
+				 struct sgx_enclave_restrict_permissions *modp)
 {
 	struct sgx_encl_page *entry;
 	struct sgx_secinfo secinfo;
@@ -772,7 +735,7 @@ sgx_enclave_restrict_permissions(struct sgx_encl *encl,
 	int ret;
 
 	memset(&secinfo, 0, sizeof(secinfo));
-	secinfo.flags = secinfo_perm;
+	secinfo.flags = modp->flags;
 
 	for (c = 0 ; c < modp->length; c += PAGE_SIZE) {
 		addr = encl->base + modp->offset + c;
@@ -871,7 +834,6 @@ static long sgx_ioc_enclave_restrict_permissions(struct sgx_encl *encl,
 						 void __user *arg)
 {
 	struct sgx_enclave_restrict_permissions params;
-	u64 secinfo_perm;
 	long ret;
 
 	ret = sgx_ioc_sgx2_ready(encl);
@@ -884,15 +846,16 @@ static long sgx_ioc_enclave_restrict_permissions(struct sgx_encl *encl,
 	if (sgx_validate_offset_length(encl, params.offset, params.length))
 		return -EINVAL;
 
-	ret = sgx_perm_from_user_secinfo((void __user *)params.secinfo,
-					 &secinfo_perm);
-	if (ret)
-		return ret;
-
-	if (params.result || params.count)
+	/*
+	 * Read access is required for the enclave to be able to use the page.
+	 * SGX instructions like ENCLU[EMODPE] and ENCLU[EACCEPT] require read
+	 * access.
+	 */
+	if (params.flags & ~SGX_SECINFO_PERMISSION_MASK || !(params.flags & SGX_SECINFO_R) ||
+	    params.result || params.count)
 		return -EINVAL;
 
-	ret = sgx_enclave_restrict_permissions(encl, &params, secinfo_perm);
+	ret = sgx_enclave_restrict_permissions(encl, &params);
 
 	if (copy_to_user(arg, &params, sizeof(params)))
 		return -EFAULT;
-- 
2.35.1

