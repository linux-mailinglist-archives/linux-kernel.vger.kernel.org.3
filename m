Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B4684B406A
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 04:39:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240039AbiBNDi0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Feb 2022 22:38:26 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:60526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231546AbiBNDiY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Feb 2022 22:38:24 -0500
Received: from conuserg-07.nifty.com (conuserg-07.nifty.com [210.131.2.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3411C55BEF;
        Sun, 13 Feb 2022 19:38:18 -0800 (PST)
Received: from grover.. (133-32-232-101.west.xps.vectant.ne.jp [133.32.232.101]) (authenticated)
        by conuserg-07.nifty.com with ESMTP id 21E3bQd7025106;
        Mon, 14 Feb 2022 12:37:26 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-07.nifty.com 21E3bQd7025106
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1644809847;
        bh=6U+P0O57K3zoiwNswCDioD5bcJiskXErl3e1WoppLMo=;
        h=From:To:Cc:Subject:Date:From;
        b=GcYVD3HiQd7Xif2IIvUUPnSamPfsBmPM1XDM5rNFx/C39e6djLnnAt6E9Ls1jk/dq
         NdVPp1u7+c14AO7z092uj7g5FG6a1XVwFOODdHiy58E2M7OIziBPO/qoSxvS40+C34
         ocYZNU/Vx0X4bgdnnfLiB/ANmnai6uD3uVvrpKz4TlJUkr9klTxCSIxzuCW6UizBIm
         O3tEgcd+EN+8ZCmBCjen4u2LFGGgtmjN4TsWt1Kff1OVF5zhI972rORg5k9odVMHcN
         iiGi4fvQ+JrWFOcPjHjxtyKFeyUjQZ70B+HWKh14hhQDXZEYKwMJxxxlgtXNa0nm3F
         fdgqZmWJ6JP6A==
X-Nifty-SrcIP: [133.32.232.101]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Greentime Hu <green.hu@gmail.com>,
        Nick Hu <nickhu@andestech.com>,
        Vincent Chen <deanbo422@gmail.com>
Subject: [PATCH] nds32: move core-y in arch/nds32/Makefile to arch/nds32/Kbuild
Date:   Mon, 14 Feb 2022 12:37:24 +0900
Message-Id: <20220214033724.2409951-1-masahiroy@kernel.org>
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

Use obj-y to clean up Makefile.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 arch/nds32/Kbuild   | 3 +++
 arch/nds32/Makefile | 3 ---
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/nds32/Kbuild b/arch/nds32/Kbuild
index 4e39f7abdeb6..ac127371afa4 100644
--- a/arch/nds32/Kbuild
+++ b/arch/nds32/Kbuild
@@ -1,4 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0-only
+obj-y			+= kernel/ mm/
+obj-$(CONFIG_FPU)	+= math-emu/
+obj-y			+= boot/dts/
 
 # for cleaning
 subdir- += boot
diff --git a/arch/nds32/Makefile b/arch/nds32/Makefile
index b33d5d81b6ae..7be31e3d7f2d 100644
--- a/arch/nds32/Makefile
+++ b/arch/nds32/Makefile
@@ -27,8 +27,6 @@ export	TEXTADDR
 
 
 # If we have a machine-specific directory, then include it in the build.
-core-y				+= arch/nds32/kernel/ arch/nds32/mm/
-core-$(CONFIG_FPU)              += arch/nds32/math-emu/
 libs-y				+= arch/nds32/lib/
 
 ifdef CONFIG_CPU_LITTLE_ENDIAN
@@ -44,7 +42,6 @@ CHECKFLAGS      += -D__NDS32_EB__
 endif
 
 boot := arch/nds32/boot
-core-y += $(boot)/dts/
 
 Image: vmlinux
 	$(Q)$(MAKE) $(build)=$(boot) $(boot)/$@
-- 
2.32.0

