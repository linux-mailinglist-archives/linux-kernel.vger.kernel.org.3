Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE3ED5A4E3D
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 15:35:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229817AbiH2NfK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 09:35:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbiH2NfG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 09:35:06 -0400
Received: from xry111.site (xry111.site [IPv6:2001:470:683e::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 212B51EEDD
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 06:35:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xry111.site;
        s=default; t=1661780102;
        bh=owF+FNmRrMbe7xv+RTni/1sE0a+t4GDngroii48Nl7g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=B+8Gj6thkXofgbnv7dQT3fcXFy7j5xLihma+EuHZDfvFU6SOfxdjKb07rD6VCh8Bo
         OZYHXdnz3DUtAY//u/0bn0eOt9qGtvqNl46BVy7YZjNdgEAkqmcuPMIr3CCZiHel9d
         F8Nh2zIZkoS6Yuo8nLa6YCgKWP2ZzxhzHUrW2SBs=
Received: from xry111-x57s1.. (unknown [IPv6:240e:358:11dd:1900:dc73:854d:832e:5])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
        (Client did not present a certificate)
        (Authenticated sender: xry111@xry111.site)
        by xry111.site (Postfix) with ESMTPSA id 2F72E66903;
        Mon, 29 Aug 2022 09:34:56 -0400 (EDT)
From:   Xi Ruoyao <xry111@xry111.site>
To:     loongarch@lists.linux.dev
Cc:     linux-kernel@vger.kernel.org, WANG Xuerui <kernel@xen0n.name>,
        Huacai Chen <chenhuacai@kernel.org>,
        Youling Tang <tangyouling@loongson.cn>,
        Jinyang He <hejinyang@loongson.cn>,
        Xi Ruoyao <xry111@xry111.site>
Subject: [PATCH v6 1/6] LoongArch: Add CONFIG_AS_HAS_EXPLICIT_RELOCS
Date:   Mon, 29 Aug 2022 21:31:41 +0800
Message-Id: <20220829133146.15236-2-xry111@xry111.site>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220829133146.15236-1-xry111@xry111.site>
References: <20220829133146.15236-1-xry111@xry111.site>
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

