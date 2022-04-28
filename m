Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 116BC512A0B
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 05:35:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241736AbiD1Dij (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 23:38:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242342AbiD1DiW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 23:38:22 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B24C11167;
        Wed, 27 Apr 2022 20:35:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 915A9B82AEB;
        Thu, 28 Apr 2022 03:35:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CE6CC385A9;
        Thu, 28 Apr 2022 03:35:04 +0000 (UTC)
From:   Greg Ungerer <gerg@linux-m68k.org>
To:     linux-m68k@vger.kernel.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org, dalias@libc.org,
        Greg Ungerer <gerg@linux-m68k.org>
Subject: [PATCH 4/4] m68knommu: allow elf_fdpic loader to be selected
Date:   Thu, 28 Apr 2022 13:33:19 +1000
Message-Id: <20220428033319.239341-5-gerg@linux-m68k.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220428033319.239341-1-gerg@linux-m68k.org>
References: <20220428033319.239341-1-gerg@linux-m68k.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The m68k architecture code is capable of supporting the binfmt_elf_fdpic
loader, so allow it to be configured. It is restricted to nommu
configurations at this time due to the MMU context structures/code not
supporting everything elf_fdpic needs when MMU is enabled.

Signed-off-by: Greg Ungerer <gerg@linux-m68k.org>
---
 fs/Kconfig.binfmt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/Kconfig.binfmt b/fs/Kconfig.binfmt
index 21c6332fa785..2666398120c4 100644
--- a/fs/Kconfig.binfmt
+++ b/fs/Kconfig.binfmt
@@ -58,7 +58,7 @@ config ARCH_USE_GNU_PROPERTY
 config BINFMT_ELF_FDPIC
 	bool "Kernel support for FDPIC ELF binaries"
 	default y if !BINFMT_ELF
-	depends on (ARM || (SUPERH && !MMU))
+	depends on (ARM || ((M68K || SUPERH) && !MMU))
 	select ELFCORE
 	help
 	  ELF FDPIC binaries are based on ELF, but allow the individual load
-- 
2.25.1

