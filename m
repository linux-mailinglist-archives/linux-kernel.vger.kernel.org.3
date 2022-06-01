Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D69A53ACA2
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 20:21:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354279AbiFASVl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 14:21:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238756AbiFASVc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 14:21:32 -0400
Received: from conuserg-07.nifty.com (conuserg-07.nifty.com [210.131.2.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A67D8A317
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jun 2022 11:21:30 -0700 (PDT)
Received: from grover.sesame (133-32-177-133.west.xps.vectant.ne.jp [133.32.177.133]) (authenticated)
        by conuserg-07.nifty.com with ESMTP id 251IJkAR014364;
        Thu, 2 Jun 2022 03:19:48 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-07.nifty.com 251IJkAR014364
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1654107589;
        bh=LsM4sO5i55Of2kVMrK89AneiaTofuiZcCz2cCABSr0I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TWh2hRSyve09QThcQe6M9jHhdIGvQytWsvsxB6H3RGwETs96Niw8SVPFtoHkPUcLk
         z3c8GzPisT/eJEXWqrMtWIymcwxW0U7cU15llABQq7eD0oDm1qidITvPg/IxiTrghr
         DiuMqUv+1sTG/pijrpxmZJnBwEhhj4srD2mwrQDem8xfZgxttC7qzl40WzPklwOQo6
         RMu/vOkezdfgIEJ1IyziI73a7cthZ/VblQQNAuC/zJX3x23m3jCsdqXgO9uK1g004u
         maUTiFcs84Yp4QD1zspizs/siQVhXCNDKXDFEIw/kEjLEgJWiPk2X2ca88SBB6RuLz
         Yma359gqIlhJw==
X-Nifty-SrcIP: [133.32.177.133]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Carlos Llamas <cmllamas@google.com>,
        Christopher Ferris <cferris@google.com>,
        Todd Kjos <tkjos@android.com>, linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-mips@vger.kernel.org
Subject: [PATCH 1/3] mips: use __kernel_{uid,gid}32_t in uapi/asm/stat.h
Date:   Thu,  2 Jun 2022 03:19:39 +0900
Message-Id: <20220601181941.3706832-2-masahiroy@kernel.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220601181941.3706832-1-masahiroy@kernel.org>
References: <20220601181941.3706832-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 8c1a381a4fbb ("mips: add asm/stat.h to UAPI compile-test
coverage") converted as follows:

  uid_t  -->  __kernel_uid_t
  gid_t  -->  __kernel_gid_t

The bit width of __kernel_{uid,gid}_t is 16 or 32-bits depending on
architectures.

MIPS uses 32-bits for them as in include/uapi/asm-generic/posix_types.h,
so the previous conversion is probably fine, but let's stick to the
arch-independent conversion just in case.

The safe replacements across all architectures are:

  uid_t  -->  __kernel_uid32_t
  gid_t  -->  __kernel_gid32_t

as defined in include/linux/types.h.

A similar issue was reported for the android binder. [1]

[1]: https://lore.kernel.org/all/20220601010017.2639048-1-cmllamas@google.com/

Fixes: 8c1a381a4fbb ("mips: add asm/stat.h to UAPI compile-test coverage")
Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 arch/mips/include/uapi/asm/stat.h | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/mips/include/uapi/asm/stat.h b/arch/mips/include/uapi/asm/stat.h
index 8a8bb78883a4..aaccdc61be74 100644
--- a/arch/mips/include/uapi/asm/stat.h
+++ b/arch/mips/include/uapi/asm/stat.h
@@ -22,8 +22,8 @@ struct stat {
 	__kernel_ino_t	st_ino;
 	__kernel_mode_t	st_mode;
 	__u32		st_nlink;
-	__kernel_uid_t	st_uid;
-	__kernel_gid_t	st_gid;
+	__kernel_uid32_t st_uid;
+	__kernel_gid32_t st_gid;
 	unsigned	st_rdev;
 	long		st_pad2[2];
 	long		st_size;
@@ -58,8 +58,8 @@ struct stat64 {
 	__kernel_mode_t	st_mode;
 	__u32		st_nlink;
 
-	__kernel_uid_t	st_uid;
-	__kernel_gid_t	st_gid;
+	__kernel_uid32_t st_uid;
+	__kernel_gid32_t st_gid;
 
 	unsigned long	st_rdev;
 	unsigned long	st_pad1[3];	/* Reserved for st_rdev expansion  */
@@ -99,8 +99,8 @@ struct stat {
 	__kernel_mode_t		st_mode;
 	__u32			st_nlink;
 
-	__kernel_uid_t		st_uid;
-	__kernel_gid_t		st_gid;
+	__kernel_uid32_t	st_uid;
+	__kernel_gid32_t	st_gid;
 
 	unsigned int		st_rdev;
 	unsigned int		st_pad1[3]; /* Reserved for st_rdev expansion */
-- 
2.32.0

