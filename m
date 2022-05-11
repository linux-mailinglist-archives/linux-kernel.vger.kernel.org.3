Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68681523CD4
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 20:47:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346474AbiEKSr5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 14:47:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346466AbiEKSry (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 14:47:54 -0400
Received: from conuserg-11.nifty.com (conuserg-11.nifty.com [210.131.2.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D15E2196FFE
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 11:47:48 -0700 (PDT)
Received: from grover.jp (133-32-177-133.west.xps.vectant.ne.jp [133.32.177.133]) (authenticated)
        by conuserg-11.nifty.com with ESMTP id 24BIkGMn020990;
        Thu, 12 May 2022 03:46:17 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-11.nifty.com 24BIkGMn020990
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1652294777;
        bh=jJh/rcQpxowKUX3OBDTsgiLvIWifNhLTl01lAPYb4N4=;
        h=From:To:Cc:Subject:Date:From;
        b=dWK61NOYKgPPbd9JoMMr0o1RXkfZ7+nOR1vsR2j9AWWrnH7WiKkVKdUC5lKtB8NBU
         mEwFTO8+wV3nvqKxm6L1KDuVm1CpMPW8KShM+LYJwjA2M9yQmqAiCzf/yrrM1THUMh
         TMTvQqH4X91Oblt2XOh5D3Cuh3Ba8B0TA5oAP0z4EvmxG2bsXL9WtXAPGl4R3H0WTl
         4ZkEjqWQ236CcX72NbZ9TdypzEMZkfdEDyjUZk/CRKJK+gzRs1/ufxu1NunqaZ4HeE
         LKSwXA3wj/5dVnjb9qXAStAlKGTGSbLnEAQ4U4XtRZtD8sjhP+YgmysACPaAdO1qU9
         NURasB6JayaAA==
X-Nifty-SrcIP: [133.32.177.133]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH] riscv: move errata/ and kvm/ builds to arch/riscv/Kbuild
Date:   Thu, 12 May 2022 03:44:08 +0900
Message-Id: <20220511184408.2751850-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 909548d6c578 ("riscv: add arch/riscv/Kbuild") intended that
subdirectories in arch/riscv/ would be added in arch/riscv/Kbuild.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 arch/riscv/Kbuild   | 2 ++
 arch/riscv/Makefile | 3 ---
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/riscv/Kbuild b/arch/riscv/Kbuild
index fb3397223d52..525ef2482253 100644
--- a/arch/riscv/Kbuild
+++ b/arch/riscv/Kbuild
@@ -2,6 +2,8 @@
 
 obj-y += kernel/ mm/ net/
 obj-$(CONFIG_BUILTIN_DTB) += boot/dts/
+obj-$(CONFIG_RISCV_ERRATA_ALTERNATIVE) += errata/
+obj-$(CONFIG_KVM) += kvm/
 
 # for cleaning
 subdir- += boot
diff --git a/arch/riscv/Makefile b/arch/riscv/Makefile
index 7d81102cffd4..fd9fda67c038 100644
--- a/arch/riscv/Makefile
+++ b/arch/riscv/Makefile
@@ -103,9 +103,6 @@ endif
 
 head-y := arch/riscv/kernel/head.o
 
-core-$(CONFIG_RISCV_ERRATA_ALTERNATIVE) += arch/riscv/errata/
-core-$(CONFIG_KVM) += arch/riscv/kvm/
-
 libs-y += arch/riscv/lib/
 libs-$(CONFIG_EFI_STUB) += $(objtree)/drivers/firmware/efi/libstub/lib.a
 
-- 
2.32.0

