Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BE545A6120
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 12:50:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229747AbiH3KuK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 06:50:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230046AbiH3Kt6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 06:49:58 -0400
Received: from xry111.site (xry111.site [IPv6:2001:470:683e::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E84311120
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 03:49:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xry111.site;
        s=default; t=1661856582;
        bh=owF+FNmRrMbe7xv+RTni/1sE0a+t4GDngroii48Nl7g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OiWgWF3MgWggip5qig6Op1VTJTGCXcxDMKe9WiCTOV7l+lPKcFMiglAeT2CpRBTHb
         pkZ1rWD4jNIzA7wEI47T0eFvtYabNZRt7KcV9BzWkw5tc6/2C3o7RIloZsq2YRauQ3
         DskjLaOcNmmSyVa+kmbmjjXYq5OTKXO7xzwCA/MY=
Received: from xry111-x57s1.. (unknown [IPv6:240e:358:11dd:1900:dc73:854d:832e:5])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
        (Client did not present a certificate)
        (Authenticated sender: xry111@xry111.site)
        by xry111.site (Postfix) with ESMTPSA id B343C66016;
        Tue, 30 Aug 2022 06:49:35 -0400 (EDT)
From:   Xi Ruoyao <xry111@xry111.site>
To:     loongarch@lists.linux.dev
Cc:     linux-kernel@vger.kernel.org, WANG Xuerui <kernel@xen0n.name>,
        Huacai Chen <chenhuacai@kernel.org>,
        Youling Tang <tangyouling@loongson.cn>,
        Jinyang He <hejinyang@loongson.cn>,
        Xi Ruoyao <xry111@xry111.site>
Subject: [PATCH v7 1/5] LoongArch: Add CONFIG_AS_HAS_EXPLICIT_RELOCS
Date:   Tue, 30 Aug 2022 18:48:02 +0800
Message-Id: <20220830104806.128365-2-xry111@xry111.site>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220830104806.128365-1-xry111@xry111.site>
References: <20220830104806.128365-1-xry111@xry111.site>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FROM_SUSPICIOUS_NTLD,
        PDS_OTHER_BAD_TLD,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

GNU as >= 2.40 and GCC >= 13 will support using explicit relocation
hints in the assembly code, instead of la.* macros.  The usage of
explicit relocation hints can improve code generation so it's enabled
by default by GCC >= 13.

Introduce CONFIG_AS_HAS_EXPLICIT_RELOCS as the switch for
"use explicit relocation hints or not."

Signed-off-by: Xi Ruoyao <xry111@xry111.site>
---
 arch/loongarch/Kconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
index d3ce96a1a744..0721b4b2207a 100644
--- a/arch/loongarch/Kconfig
+++ b/arch/loongarch/Kconfig
@@ -204,6 +204,9 @@ config SCHED_OMIT_FRAME_POINTER
 	bool
 	default y
 
+config AS_HAS_EXPLICIT_RELOCS
+	def_bool $(as-instr,x:pcalau12i \$t0$(comma)%pc_hi20(x))
+
 menu "Kernel type and options"
 
 source "kernel/Kconfig.hz"
-- 
2.37.0

