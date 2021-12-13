Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B89EB4737EC
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 23:49:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243885AbhLMWt2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 17:49:28 -0500
Received: from aposti.net ([89.234.176.197]:34392 "EHLO aposti.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243825AbhLMWt0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 17:49:26 -0500
From:   Paul Cercueil <paul@crapouillou.net>
To:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Cc:     list@opendingux.net, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH 0/3] MIPS: Add support for LTO
Date:   Mon, 13 Dec 2021 22:49:11 +0000
Message-Id: <20211213224914.1501303-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

With this set of patches, it becomes possible to build a LTO'd kernel
with LLVM/Clang on MIPS.

This was tested on a Ingenic JZ4770 based system. It requires the
linking step of the vmlinuz.bin to be done with binutils' LD instead of
LLVM's ld.lld [1], but the vmlinuz ELF itself can be completely built
with LLVM.

Strangely, the LTO'd kernel is bigger in size (3.6 MiB vs. 3.1 MiB
without LTO), which might be completely normal and I just have wrong
expectations.

Cheers,
-Paul

[1]: https://github.com/ClangBuiltLinux/linux/issues/1333

Paul Cercueil (3):
  MIPS: boot/compressed: Disable abicalls
  MIPS: boot/compressed: Build without LTO
  MIPS: Add support for LTO

 arch/mips/Kconfig                  | 1 +
 arch/mips/boot/compressed/Makefile | 7 +++++--
 2 files changed, 6 insertions(+), 2 deletions(-)

-- 
2.33.0

