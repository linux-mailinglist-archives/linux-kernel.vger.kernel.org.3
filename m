Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08415525818
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 01:06:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359343AbiELXGd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 19:06:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359345AbiELXG3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 19:06:29 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47CD93E0FD;
        Thu, 12 May 2022 16:06:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 6D28DCE2D00;
        Thu, 12 May 2022 23:06:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A4B3C34113;
        Thu, 12 May 2022 23:06:23 +0000 (UTC)
From:   Greg Ungerer <gerg@linux-m68k.org>
To:     linux-m68k@vger.kernel.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org, dalias@libc.org,
        Greg Ungerer <gerg@linux-m68k.org>
Subject: [PATCH v2 4/4] m68knommu: allow elf_fdpic loader to be selected
Date:   Fri, 13 May 2022 09:06:02 +1000
Message-Id: <20220512230602.1408871-1-gerg@linux-m68k.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The m68k architecture code is capable of supporting the binfmt_elf_fdpic
loader, so allow it to be configured. It is restricted to nommu
configurations at this time due to the MMU context structures/code not
supporting everything elf_fdpic needs when MMU is enabled.

Link: https://lore.kernel.org/linux-m68k/20220428033319.239341-1-gerg@linux-m68k.org/
Signed-off-by: Greg Ungerer <gerg@linux-m68k.org>
---
 fs/Kconfig.binfmt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

v2: remove superfluous surrounding "(" ")"

diff --git a/fs/Kconfig.binfmt b/fs/Kconfig.binfmt
index 21c6332fa785..fb325b3aa4b0 100644
--- a/fs/Kconfig.binfmt
+++ b/fs/Kconfig.binfmt
@@ -58,7 +58,7 @@ config ARCH_USE_GNU_PROPERTY
 config BINFMT_ELF_FDPIC
 	bool "Kernel support for FDPIC ELF binaries"
 	default y if !BINFMT_ELF
-	depends on (ARM || (SUPERH && !MMU))
+	depends on ARM || ((M68K || SUPERH) && !MMU)
 	select ELFCORE
 	help
 	  ELF FDPIC binaries are based on ELF, but allow the individual load
-- 
2.25.1

