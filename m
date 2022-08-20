Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 350A859AF0E
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Aug 2022 18:53:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345843AbiHTQw6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Aug 2022 12:52:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230179AbiHTQwz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Aug 2022 12:52:55 -0400
Received: from conuserg-11.nifty.com (conuserg-11.nifty.com [210.131.2.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB92A356E9;
        Sat, 20 Aug 2022 09:52:53 -0700 (PDT)
Received: from localhost.localdomain (133-32-182-133.west.xps.vectant.ne.jp [133.32.182.133]) (authenticated)
        by conuserg-11.nifty.com with ESMTP id 27KGpWBs018639;
        Sun, 21 Aug 2022 01:51:33 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-11.nifty.com 27KGpWBs018639
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1661014293;
        bh=Ih0ALdpIOTPB/Sn1mTKqVFaEpGzX4IPJIL6cfPyzDKs=;
        h=From:To:Cc:Subject:Date:From;
        b=FVi2J+uumSNsnyLx9bZCiOYwoPHt/3iuaKCxmj+L45yQLp8Few4zQXDsMj8nbB+D8
         OfxNWScobUfm6Bjk4hyYlUI+nLy/7vn4Ewxkc1rDB7WJoSJSZHduwmgSUZmKt2aNdp
         Z3rl9YdgbrKpJKPh6lENFt0S5u9GMu+SUA91vlck3West0dP7VmLXtGqH7DlwQwu9q
         o78aD71BhLu5BM674qeSYAbY4KolOrxj7d3ZpKCbqd6VIc+3ae4zxT4pdSbj0mXZO0
         LJgahdxAb2Lu+X5/zrqEIoLfGuprgLmil3BCtHORam/upm97d9F+qCC3tWKc1iwPO4
         vAYRT5uIZKiKg==
X-Nifty-SrcIP: [133.32.182.133]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        linuxppc-dev@lists.ozlabs.org
Cc:     linux-kbuild@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] powerpc: align syscall table for ppc32
Date:   Sun, 21 Aug 2022 01:51:29 +0900
Message-Id: <20220820165129.1147589-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.34.1
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

Christophe Leroy reported that commit 7b4537199a4a ("kbuild: link
symbol CRCs at final link,  removing CONFIG_MODULE_REL_CRCS") broke
mpc85xx_defconfig + CONFIG_RELOCATABLE=y.

    LD      vmlinux
    SYSMAP  System.map
    SORTTAB vmlinux
    CHKREL  vmlinux
  WARNING: 451 bad relocations
  c0b312a9 R_PPC_UADDR32     .head.text-0x3ff9ed54
  c0b312ad R_PPC_UADDR32     .head.text-0x3ffac224
  c0b312b1 R_PPC_UADDR32     .head.text-0x3ffb09f4
  c0b312b5 R_PPC_UADDR32     .head.text-0x3fe184dc
  c0b312b9 R_PPC_UADDR32     .head.text-0x3fe183a8
      ...

The compiler emits a bunch of R_PPC_UADDR32, which is not supported by
arch/powerpc/kernel/reloc_32.S.

The reason is there exists an unaligned symbol.

  $ powerpc-linux-gnu-nm -n vmlinux
    ...
  c0b31258 d spe_aligninfo
  c0b31298 d __func__.0
  c0b312a9 D sys_call_table
  c0b319b8 d __func__.0

Commit 7b4537199a4a is not the root cause. Even before that, I can
reproduce the same issue for mpc85xx_defconfig + CONFIG_RELOCATABLE=y
+ CONFIG_MODVERSIONS=n.

It is just that nobody did not notice it because when CONFIG_MODVERSIONS
is enabled, a __crc_* symbol inserted before sys_call_table was hiding
the unalignment issue.

I checked the commit history, but I could not understand commit
46b45b10f142 ("[POWERPC] Align the sys_call_table").

It said 'Our _GLOBAL macro does a ".align 2" so the alignment is fine
for 32 bit'. I checked the _GLOBAL in include/asm-powerpc/ppc_asm.h
at that time. _GLOBAL specifies ".align 2" for ppc64, but no .align
for ppc32.

Commit c857c43b34ec ("powerpc: Don't use a function descriptor for
system call table") removed _GLOBAL from the syscall table.

Anyway, adding alignment to the syscall table for ppc32 fixes the issue.

I am not giving Fixes tag because I do not know since when it has been
broken, but presumably it has been for a long while.

Link: https://lore.kernel.org/lkml/38605f6a-a568-f884-f06f-ea4da5b214f0@csgroup.eu/
Reported-by: Christophe Leroy <christophe.leroy@csgroup.eu>
Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 arch/powerpc/kernel/systbl.S | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/powerpc/kernel/systbl.S b/arch/powerpc/kernel/systbl.S
index cb3358886203..6c1db3b6de2d 100644
--- a/arch/powerpc/kernel/systbl.S
+++ b/arch/powerpc/kernel/systbl.S
@@ -18,6 +18,7 @@
 	.p2align	3
 #define __SYSCALL(nr, entry)	.8byte entry
 #else
+	.p2align	2
 #define __SYSCALL(nr, entry)	.long entry
 #endif
 
-- 
2.34.1

