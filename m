Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F07653ACB1
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 20:23:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356069AbiFASWV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 14:22:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345115AbiFASWT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 14:22:19 -0400
Received: from conuserg-07.nifty.com (conuserg-07.nifty.com [210.131.2.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B94A3CFEA
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jun 2022 11:22:17 -0700 (PDT)
Received: from grover.sesame (133-32-177-133.west.xps.vectant.ne.jp [133.32.177.133]) (authenticated)
        by conuserg-07.nifty.com with ESMTP id 251IJkAS014364;
        Thu, 2 Jun 2022 03:19:49 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-07.nifty.com 251IJkAS014364
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1654107589;
        bh=tMDyL0rhu7Lqq/KCehxyT1DbD+leBMoEySfqxZD7ygQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sDGsn6MEry3DL/7zDaFzQ2QZabJwFxfQ6mpizg+eOuNIRBtdbJ15ceBfgtQ//brQH
         C3Q5eGNxQ0LksIrSZf1e2eNInc+GtM6eFsCVl6/hF2Mq1pThTUORjMmQN9mjCubPKy
         47b7vxX+yXHt5OdijhmwhmpRa/umFL1PGMcI5NedbEx7g5reM3v6NDomzyiAtBawvS
         4CYFTabJoLGXJba0xqScxZ9MiLUHucMH/xjk9X23i5zpe6BQDLVBtxu7Jr7JK5AN9b
         NDWvn5tvA/DOV7zQ4oKXD2ZnWUWwHDDToVFJ83wFsb8hLBVHcYvoQ4BiJgpNwCuDSR
         YycShFfIOMI5A==
X-Nifty-SrcIP: [133.32.177.133]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Carlos Llamas <cmllamas@google.com>,
        Christopher Ferris <cferris@google.com>,
        Todd Kjos <tkjos@android.com>, linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 2/3] powerpc: use __kernel_{uid,gid}32_t in uapi/asm/stat.h
Date:   Thu,  2 Jun 2022 03:19:40 +0900
Message-Id: <20220601181941.3706832-3-masahiroy@kernel.org>
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

Commit c01013a2f8dd ("powerpc: add asm/stat.h to UAPI compile-test
coverage") converted as follows:

  uid_t  -->  __kernel_uid_t
  gid_t  -->  __kernel_gid_t

The bit width of __kernel_{uid,gid}_t is 16 or 32-bits depending on
architectures.

PPC uses 32-bits for them as in include/uapi/asm-generic/posix_types.h,
so the previous conversion is probably fine, but let's stick to the
arch-independent conversion just in case.

The safe replacements across all architectures are:

  uid_t  -->  __kernel_uid32_t
  gid_t  -->  __kernel_gid32_t

as defined in include/linux/types.h.

A similar issue was reported for the android binder. [1]

[1]: https://lore.kernel.org/all/20220601010017.2639048-1-cmllamas@google.com/

Fixes: c01013a2f8dd ("powerpc: add asm/stat.h to UAPI compile-test coverage")
Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 arch/powerpc/include/uapi/asm/stat.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/include/uapi/asm/stat.h b/arch/powerpc/include/uapi/asm/stat.h
index a28c9a1201fa..d50901664239 100644
--- a/arch/powerpc/include/uapi/asm/stat.h
+++ b/arch/powerpc/include/uapi/asm/stat.h
@@ -37,8 +37,8 @@ struct stat {
 	__kernel_mode_t	st_mode;
 	unsigned short	st_nlink;
 #endif
-	__kernel_uid_t	st_uid;
-	__kernel_gid_t	st_gid;
+	__kernel_uid32_t st_uid;
+	__kernel_gid32_t st_gid;
 	unsigned long	st_rdev;
 	long		st_size;
 	unsigned long	st_blksize;
-- 
2.32.0

