Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA449494704
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 06:46:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358612AbiATFq0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 00:46:26 -0500
Received: from conuserg-11.nifty.com ([210.131.2.78]:34409 "EHLO
        conuserg-11.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229989AbiATFqY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 00:46:24 -0500
Received: from grover.. (133-32-232-101.west.xps.vectant.ne.jp [133.32.232.101]) (authenticated)
        by conuserg-11.nifty.com with ESMTP id 20K5iPc1014412;
        Thu, 20 Jan 2022 14:44:25 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-11.nifty.com 20K5iPc1014412
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1642657466;
        bh=6NBzqKga/+HNsV98/PVzJhpBeK1/WIjSf8sHuENVzx0=;
        h=From:To:Cc:Subject:Date:From;
        b=l4h4ieWNaDiDamIOQdOEyCjjFaKazFjf5XcE+i5edODj38bdWDUVxg6bussfVDIOo
         1vPbeOO9bf+7k2XmwJqVLmswwAZhBB2GmNqxeFYm14wJJdmplFUpKoldhZpq5Ad+ke
         BDESRoH+fXu8Fj8rkmVpMFtQ7o6dFFw+lLbUSnM2f3nNaXFW9QgpRX8K2OF9zoU1IV
         4hrbcFCx84ingIE8Vxww5qLBOCHiSP5tvZDqgSC0MlrJmbdBJNWgoKiAPwsivoiGUJ
         4Len3aCJbxgd7d4j8Andhhwt+Pe45bPGX+vdx5JtqFYVHKbO4pugq2opnNE3AP8MvO
         gLjugG4+oS6dQ==
X-Nifty-SrcIP: [133.32.232.101]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     patches@arm.linux.org.uk
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: vdso: remove -nostdlib compiler flag
Date:   Thu, 20 Jan 2022 14:44:18 +0900
Message-Id: <20220120054418.409817-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The -nostdlib option requests the compiler to not use the standard
system startup files or libraries when linking. It is effective only
when $(CC) is used as a linker driver.

Since commit fe00e50b2db8 ("ARM: 8858/1: vdso: use $(LD) instead of
$(CC) to link VDSO"), $(LD) is directly used, hence -nostdlib is
unneeded.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
---

KernelVersion: 5.16

 arch/arm/vdso/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/vdso/Makefile b/arch/arm/vdso/Makefile
index 7c9e395b77f7..ec52b776f926 100644
--- a/arch/arm/vdso/Makefile
+++ b/arch/arm/vdso/Makefile
@@ -18,7 +18,7 @@ ccflags-y += -DDISABLE_BRANCH_PROFILING -DBUILD_VDSO32
 
 ldflags-$(CONFIG_CPU_ENDIAN_BE8) := --be8
 ldflags-y := -Bsymbolic --no-undefined -soname=linux-vdso.so.1 \
-	    -z max-page-size=4096 -nostdlib -shared $(ldflags-y) \
+	    -z max-page-size=4096 -shared $(ldflags-y) \
 	    --hash-style=sysv --build-id=sha1 \
 	    -T
 
-- 
2.32.0

