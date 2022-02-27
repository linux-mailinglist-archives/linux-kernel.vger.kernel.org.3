Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB0C64C5A1B
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Feb 2022 10:04:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229458AbiB0IyO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Feb 2022 03:54:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiB0IyN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Feb 2022 03:54:13 -0500
Received: from conuserg-10.nifty.com (conuserg-10.nifty.com [210.131.2.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 089DA5BD3F
        for <linux-kernel@vger.kernel.org>; Sun, 27 Feb 2022 00:53:36 -0800 (PST)
Received: from grover.. (133-32-176-37.west.xps.vectant.ne.jp [133.32.176.37]) (authenticated)
        by conuserg-10.nifty.com with ESMTP id 21R8qfos030272;
        Sun, 27 Feb 2022 17:52:41 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-10.nifty.com 21R8qfos030272
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1645951962;
        bh=hp/jhp7PMs3ndVbX8PXnwZo8mIXWoUhisPVyctjQqPM=;
        h=From:To:Cc:Subject:Date:From;
        b=uyUnoa3rdoUY9fbhGPx6vdf8dFi/53IsGwlwKawIIifJMng6PNRnpCwP7t3sBjNBD
         qC/rz2GETlkW67XcIpMAjdxjFypMX531qhOtjnAmG/Lzp/wUgTUrBuZvmdrPcP4/MZ
         bzK88BOpd+Q+J9dN4yBs1EEiBx8xRkXXGzM8yBDUl00H0XsnYhfqQ8AuIJXBtAPeNL
         9a4OpYVALCDrJ6FmYGn17oCAYnTIQ/D6S71ni+xMa93pXGd9jTUs+teLynidLXcOaP
         8YVzL/84+Yobc3ZM2NAyVEPK7W2S9ge9XthM+Nvxj4ABCnOGZKv5Xyu370/lTOuIrt
         lg23HE3ASaTzA==
X-Nifty-SrcIP: [133.32.176.37]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: clean up tools Makefile
Date:   Sun, 27 Feb 2022 17:52:32 +0900
Message-Id: <20220227085232.206529-1-masahiroy@kernel.org>
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

Remove unused gen-y.

Remove redundant $(shell ...) because 'mkdir' is done in cmd_gen_cpucaps.

Replace $(filter-out $(PHONY), $^) with the $(real-prereqs) shorthand.

The '&&' in cmd_gen_cpucaps should be replaced with ';' because it is
run under 'set -e' environment.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 arch/arm64/tools/Makefile | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/arch/arm64/tools/Makefile b/arch/arm64/tools/Makefile
index 932b4fe5c768..cf1307188150 100644
--- a/arch/arm64/tools/Makefile
+++ b/arch/arm64/tools/Makefile
@@ -5,18 +5,14 @@ kapi := $(gen)/asm
 
 kapi-hdrs-y := $(kapi)/cpucaps.h
 
-targets += $(addprefix ../../../,$(gen-y) $(kapi-hdrs-y))
+targets += $(addprefix ../../../, $(kapi-hdrs-y))
 
 PHONY += kapi
 
-kapi:   $(kapi-hdrs-y) $(gen-y)
-
-# Create output directory if not already present
-_dummy := $(shell [ -d '$(kapi)' ] || mkdir -p '$(kapi)')
+kapi:   $(kapi-hdrs-y)
 
 quiet_cmd_gen_cpucaps = GEN     $@
-      cmd_gen_cpucaps = mkdir -p $(dir $@) && \
-                     $(AWK) -f $(filter-out $(PHONY),$^) > $@
+      cmd_gen_cpucaps = mkdir -p $(dir $@); $(AWK) -f $(real-prereqs) > $@
 
 $(kapi)/cpucaps.h: $(src)/gen-cpucaps.awk $(src)/cpucaps FORCE
 	$(call if_changed,gen_cpucaps)
-- 
2.32.0

