Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B67EA522FD8
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 11:49:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232412AbiEKJtl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 05:49:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235331AbiEKJtX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 05:49:23 -0400
Received: from albert.telenet-ops.be (albert.telenet-ops.be [IPv6:2a02:1800:110:4::f00:1a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30A0F4ECC9
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 02:48:59 -0700 (PDT)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed40:c9c1:6ba7:bb0d:8433])
        by albert.telenet-ops.be with bizsmtp
        id VMou2700f1sk9zo06MouV6; Wed, 11 May 2022 11:48:56 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1noixi-003iYm-3x; Wed, 11 May 2022 11:48:54 +0200
Received: from geert by rox.of.borg with local (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1noixh-004bcs-3d; Wed, 11 May 2022 11:48:53 +0200
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     Greg Ungerer <gerg@uclinux.org>
Cc:     linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH] m68k: math-emu: Fix dependencies of math emulation support
Date:   Wed, 11 May 2022 11:48:48 +0200
Message-Id: <e0a9cf982a80f14efbf01cdc38e31128a9f41999.1652262437.git.geert@linux-m68k.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If CONFIG_M54xx=y, CONFIG_MMU=y, and CONFIG_M68KFPU_EMU=y:

    {standard input}:272: Error: invalid instruction for this architecture; needs 68000 or higher (68000 [68ec000, 68hc000, 68hc001, 68008, 68302, 68306, 68307, 68322, 68356], 68010, 68020 [68k, 68ec020], 68030 [68ec030], 68040 [68ec040], 68060 [68ec060], cpu32 [68330, 68331, 68332, 68333, 68334, 68336, 68340, 68341, 68349, 68360], fidoa [fido]) -- statement `sub.b %d1,%d3' ignored
    {standard input}:609: Error: invalid instruction for this architecture; needs 68020 or higher (68020 [68k, 68ec020], 68030 [68ec030], 68040 [68ec040], 68060 [68ec060]) -- statement `bfextu 4(%a1){%d0,#8},%d0' ignored
    {standard input}:752: Error: operands mismatch -- statement `mulu.l 4(%a0),%d3:%d0' ignored
    {standard input}:1155: Error: operands mismatch -- statement `divu.l %d0,%d3:%d7' ignored

The math emulation support code is intended for 68020 and higher, and
uses several instructions or instruction modes not available on coldfire
or 68000.

Originally, the dependency of M68KFPU_EMU on MMU was fine, as MMU
support was only available on 68020 or higher.  But this assumption
was broken by the introduction of MMU support for M547x and M548x.

Drop the dependency on MMU, as the code should work fine on 68020 and up
without MMU (which are not yet supported by Linux, though).
Add dependencies on M68K_CLASSIC (to rule out Coldfire) and FPU (to rule
out 68xxx below 68020).

Fixes: 1f7034b9616e6f14 ("m68k: allow ColdFire 547x and 548x CPUs to be built with MMU enabled")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
To be queued in the m68k for-v5.19 branch.

 arch/m68k/Kconfig.cpu | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/m68k/Kconfig.cpu b/arch/m68k/Kconfig.cpu
index 16ea9a67723c09dc..9abddbbee819f1d3 100644
--- a/arch/m68k/Kconfig.cpu
+++ b/arch/m68k/Kconfig.cpu
@@ -327,7 +327,7 @@ comment "Processor Specific Options"
 
 config M68KFPU_EMU
 	bool "Math emulation support"
-	depends on MMU
+	depends on M68K_CLASSIC && FPU
 	help
 	  At some point in the future, this will cause floating-point math
 	  instructions to be emulated by the kernel on machines that lack a
-- 
2.25.1

