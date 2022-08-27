Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A91A35A3951
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Aug 2022 19:55:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229595AbiH0Rzm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Aug 2022 13:55:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbiH0Rzj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Aug 2022 13:55:39 -0400
Received: from xry111.site (xry111.site [89.208.246.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE0A380E95
        for <linux-kernel@vger.kernel.org>; Sat, 27 Aug 2022 10:55:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xry111.site;
        s=default; t=1661622932;
        bh=5gF4zRm2HsqlA+R+dZxda56qftVNflTTvjyLrTHAMIM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=c6rb0leMlO7eX0MklNiG6AD2hAIWrbtHCisYgFWqmKST8dVf9FHmklm+j4sXagKLX
         JLSCk3fU7+92bJdpb2l3fP3N0WN0k1VLywJDnxo/mU7lCVUquyu3kOG6Z/KfgGZ+0J
         DdIV8gG40gGjCu/ikWCEsRsm874hlc7I87wB8rT4=
Received: from xry111-x57s1.. (unknown [IPv6:240e:358:1157:dc00:dc73:854d:832e:4])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
        (Client did not present a certificate)
        (Authenticated sender: xry111@xry111.site)
        by xry111.site (Postfix) with ESMTPSA id 1CC9B667FF;
        Sat, 27 Aug 2022 13:55:24 -0400 (EDT)
From:   Xi Ruoyao <xry111@xry111.site>
To:     loongarch@lists.linux.dev
Cc:     linux-kernel@vger.kernel.org, WANG Xuerui <kernel@xen0n.name>,
        Huacai Chen <chenhuacai@kernel.org>,
        Youling Tang <tangyouling@loongson.cn>,
        Jinyang He <hejinyang@loongson.cn>,
        Xi Ruoyao <xry111@xry111.site>
Subject: [PATCH 1/8] LoongArch: Add CONFIG_CC_HAS_EXPLICIT_RELOCS
Date:   Sun, 28 Aug 2022 01:54:29 +0800
Message-Id: <20220827175436.156464-2-xry111@xry111.site>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220827175436.156464-1-xry111@xry111.site>
References: <20220827175436.156464-1-xry111@xry111.site>
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
by default by GCC >= 13.  We need to adapt the kernel for this change,
introduce CONFIG_CC_HAS_EXPLICIT_RELOCS so we can use it in later
patches.

Signed-off-by: Xi Ruoyao <xry111@xry111.site>
---
 arch/loongarch/Kconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
index 810096bbf853..e7cfd451024b 100644
--- a/arch/loongarch/Kconfig
+++ b/arch/loongarch/Kconfig
@@ -203,6 +203,9 @@ config SCHED_OMIT_FRAME_POINTER
 	bool
 	default y
 
+config CC_HAS_EXPLICIT_RELOCS
+	def_bool $(cc-option,-mexplicit-relocs) && $(as-instr,x:pcalau12i \$t0$(comma)%pc_hi20(x))
+
 menu "Kernel type and options"
 
 source "kernel/Kconfig.hz"
-- 
2.37.0

