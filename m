Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DADE55ACF5
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Jun 2022 00:37:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233551AbiFYWgc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Jun 2022 18:36:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233534AbiFYWg1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jun 2022 18:36:27 -0400
Received: from conuserg-12.nifty.com (conuserg-12.nifty.com [210.131.2.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D35D8BF56
        for <linux-kernel@vger.kernel.org>; Sat, 25 Jun 2022 15:36:23 -0700 (PDT)
Received: from grover.sesame (133-32-177-133.west.xps.vectant.ne.jp [133.32.177.133]) (authenticated)
        by conuserg-12.nifty.com with ESMTP id 25PMYreK012075;
        Sun, 26 Jun 2022 07:34:54 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-12.nifty.com 25PMYreK012075
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1656196494;
        bh=WgQFNPYHMxqyTX5c5nAwQv5As8G9LUvywSuGoACkOUs=;
        h=From:To:Cc:Subject:Date:From;
        b=QcTUgYjurPsf2efpKisRgROBAzCFU7cFnKDW9nul/gyD8TJnU/ZnS4uK07qUYXjAE
         oLx1B3FWuxMZGfL+yMcRBgk9+ZGrKvtxwjUfyfyZg0qOOFvvo1Mm2EB1FPOgNcv+lC
         h8tbZC6t+1vi8gdYR0jTiNa11N4whzZtEiNWlBa+VdeuO+VHYl/yX0lINBPvltOxHN
         0dzDSk855TXFXeknCBrCNtuEiZG7Sryw5qkZUBm78SB+F2phNpiS+aFSp7UweLm8h/
         BH0O0cUGOESLL+e/tAG/8rU6NyO9TrmT0ZI7PHUUBp7KLDoXU5wT1l/1CeHIUEN+qd
         5cuBi6Oq1MqNg==
X-Nifty-SrcIP: [133.32.177.133]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] riscv/purgatory: hard-code obj-y in Makefile
Date:   Sun, 26 Jun 2022 07:34:36 +0900
Message-Id: <20220625223438.835408-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.32.0
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

The purgatory/ directory is entirely guarded in arch/riscv/Kbuild.
CONFIG_ARCH_HAS_KEXEC_PURGATORY is bool type.

$(CONFIG_ARCH_HAS_KEXEC_PURGATORY) is always 'y' when Kbuild visits
this Makefile for building.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 arch/riscv/purgatory/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/riscv/purgatory/Makefile b/arch/riscv/purgatory/Makefile
index d4df200f7edf..c2d14e2f345d 100644
--- a/arch/riscv/purgatory/Makefile
+++ b/arch/riscv/purgatory/Makefile
@@ -92,4 +92,4 @@ quiet_cmd_bin2c = BIN2C   $@
 $(obj)/kexec-purgatory.c: $(obj)/purgatory.ro $(obj)/purgatory.chk FORCE
 	$(call if_changed,bin2c)
 
-obj-$(CONFIG_ARCH_HAS_KEXEC_PURGATORY)	+= kexec-purgatory.o
+obj-y += kexec-purgatory.o
-- 
2.32.0

