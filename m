Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5EF924737F2
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 23:49:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243917AbhLMWts (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 17:49:48 -0500
Received: from aposti.net ([89.234.176.197]:34516 "EHLO aposti.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243841AbhLMWtr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 17:49:47 -0500
From:   Paul Cercueil <paul@crapouillou.net>
To:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Cc:     list@opendingux.net, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH 3/3] MIPS: Add support for LTO
Date:   Mon, 13 Dec 2021 22:49:14 +0000
Message-Id: <20211213224914.1501303-4-paul@crapouillou.net>
In-Reply-To: <20211213224914.1501303-1-paul@crapouillou.net>
References: <20211213224914.1501303-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allow CONFIG_LTO_CLANG to be enabled. The ThinLTO variant is not yet
supported.

While this option allows to build a LTO'd kernel, the result kernel file
ends up being *bigger* than the non-LTO variant (about 3.6 MiB with LTO
vs. 3.1 MiB without with a ZSTD-compressed kernel).

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 arch/mips/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 0215dc1529e9..6987db8d5f64 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -22,6 +22,7 @@ config MIPS
 	select ARCH_USE_QUEUED_RWLOCKS
 	select ARCH_USE_QUEUED_SPINLOCKS
 	select ARCH_SUPPORTS_HUGETLBFS if CPU_SUPPORTS_HUGEPAGES
+	select ARCH_SUPPORTS_LTO_CLANG if CPU_LITTLE_ENDIAN
 	select ARCH_WANT_DEFAULT_TOPDOWN_MMAP_LAYOUT if MMU
 	select ARCH_WANT_IPC_PARSE_VERSION
 	select ARCH_WANT_LD_ORPHAN_WARN
-- 
2.33.0

