Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AE1F561F4A
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 17:32:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235254AbiF3PcI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 11:32:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235809AbiF3PcF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 11:32:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D75693A738
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 08:32:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 736BF61904
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 15:32:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49DB7C341CC;
        Thu, 30 Jun 2022 15:32:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656603123;
        bh=DMoXyBY8anTUJp0z5XM+bV0yDDpw0G7731nqB1esFYQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZcYHX7j34PqL86ygQiByoktv5ZxOg5p0qqwuvZlD2xxc/DIBosQtSMBLlmsm6rs4p
         +SW6b8jtsrCQTkWx0KqMnuCk7j1i64FNAutDF+0HGtcNsxoIiU7U+RyhivqP8ZVB1q
         lkiXBA4JarrAhhHIKqoWeQAjlnjXFt5wvzol+ranak6I/76jO6ywEH3B5ruZxsWabd
         9m0wooGnOlGftVn4MP8w+Ugx2gAtRgsUPIx8qnR7wm+gOKpWw6mS2Jr2ld+rQ8vKQY
         TogUk4QCyagiIMj75KLzTiXDos5nk34v3jp9I4F8LSrNPcvnNQzKyZqRE3dEms6g8U
         be0lYglwtp1BA==
From:   Nathan Chancellor <nathan@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     Joey Gouly <joey.gouly@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, patches@lists.linudx.dev,
        Nathan Chancellor <nathan@kernel.org>
Subject: [PATCH 2/2] arm64: vdso32: Add DWARF_DEBUG
Date:   Thu, 30 Jun 2022 08:31:21 -0700
Message-Id: <20220630153121.1317045-3-nathan@kernel.org>
X-Mailer: git-send-email 2.37.0
In-Reply-To: <20220630153121.1317045-1-nathan@kernel.org>
References: <20220630153121.1317045-1-nathan@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When building the 32-bit vDSO with LLVM 15 and CONFIG_DEBUG_INFO, there
are the following orphan section warnings:

  ld.lld: warning: arch/arm64/kernel/vdso32/note.o:(.debug_abbrev) is being placed in '.debug_abbrev'
  ld.lld: warning: arch/arm64/kernel/vdso32/note.o:(.debug_info) is being placed in '.debug_info'
  ld.lld: warning: arch/arm64/kernel/vdso32/note.o:(.debug_str_offsets) is being placed in '.debug_str_offsets'
  ld.lld: warning: arch/arm64/kernel/vdso32/note.o:(.debug_str) is being placed in '.debug_str'
  ld.lld: warning: arch/arm64/kernel/vdso32/note.o:(.debug_addr) is being placed in '.debug_addr'
  ld.lld: warning: arch/arm64/kernel/vdso32/note.o:(.debug_line) is being placed in '.debug_line'
  ld.lld: warning: arch/arm64/kernel/vdso32/note.o:(.debug_line_str) is being placed in '.debug_line_str'
  ld.lld: warning: arch/arm64/kernel/vdso32/vgettimeofday.o:(.debug_loclists) is being placed in '.debug_loclists'
  ld.lld: warning: arch/arm64/kernel/vdso32/vgettimeofday.o:(.debug_abbrev) is being placed in '.debug_abbrev'
  ld.lld: warning: arch/arm64/kernel/vdso32/vgettimeofday.o:(.debug_info) is being placed in '.debug_info'
  ld.lld: warning: arch/arm64/kernel/vdso32/vgettimeofday.o:(.debug_rnglists) is being placed in '.debug_rnglists'
  ld.lld: warning: arch/arm64/kernel/vdso32/vgettimeofday.o:(.debug_str_offsets) is being placed in '.debug_str_offsets'
  ld.lld: warning: arch/arm64/kernel/vdso32/vgettimeofday.o:(.debug_str) is being placed in '.debug_str'
  ld.lld: warning: arch/arm64/kernel/vdso32/vgettimeofday.o:(.debug_addr) is being placed in '.debug_addr'
  ld.lld: warning: arch/arm64/kernel/vdso32/vgettimeofday.o:(.debug_frame) is being placed in '.debug_frame'
  ld.lld: warning: arch/arm64/kernel/vdso32/vgettimeofday.o:(.debug_line) is being placed in '.debug_line'
  ld.lld: warning: arch/arm64/kernel/vdso32/vgettimeofday.o:(.debug_line_str) is being placed in '.debug_line_str'

These are DWARF5 sections, as that is the implicit default version for
clang-14 and newer when just '-g' is used. All DWARF sections are
handled by the DWARF_DEBUG macro from include/asm-generic/vmlinux.lds.h
so use that macro here to fix the warnings regardless of DWARF version.

Fixes: 9d4775b332e1 ("arm64: vdso32: enable orphan handling for VDSO")
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
---
 arch/arm64/kernel/vdso32/vdso.lds.S | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/kernel/vdso32/vdso.lds.S b/arch/arm64/kernel/vdso32/vdso.lds.S
index c25bed8e6df1..8d95d7d35057 100644
--- a/arch/arm64/kernel/vdso32/vdso.lds.S
+++ b/arch/arm64/kernel/vdso32/vdso.lds.S
@@ -57,6 +57,7 @@ SECTIONS
 	.rel.dyn	: { *(.rel*) }
 
 	.ARM.exidx : { *(.ARM.exidx*) }
+	DWARF_DEBUG
 	ELF_DETAILS
 	.ARM.attributes 0 : { *(.ARM.attributes) }
 
-- 
2.37.0

