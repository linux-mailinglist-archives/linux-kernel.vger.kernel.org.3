Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59D0A4686B8
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Dec 2021 18:42:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385207AbhLDRpa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Dec 2021 12:45:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbhLDRp3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Dec 2021 12:45:29 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70D2EC061751
        for <linux-kernel@vger.kernel.org>; Sat,  4 Dec 2021 09:42:03 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0C98660ED3
        for <linux-kernel@vger.kernel.org>; Sat,  4 Dec 2021 17:42:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9758FC341C2;
        Sat,  4 Dec 2021 17:41:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638639722;
        bh=a0b5S3f+mWkHc56t0rwqSWzPtnhKneIeUeETKFla3u8=;
        h=From:To:Cc:Subject:Date:From;
        b=oJAwozB1MZUiMlzAo2pSI1UXJ6t/MB8+Ws1Su5vgbiOZO61Y77Jd+nOfXUE7Wj+YD
         UCM3uQbn3J2a4MXXsHz0541Q4gkshwfDhZxvSpscIyglxvFk4DdjtxeycIbiKaobfK
         PBVgXUn4G+vjcSPVvR+hVx3GYfXbAMfJeSqtFp3uPg/YqGHrVPAuUwt4e+Gjtgw8tc
         W+6Wg2MpKDxiCvILuT47jKR8ErR7Rst10UojMnkwXr+6mmh3YnsyjR4J0DSPgFb3BW
         BGkipGRQfkxDMblQ+WPBBWZK8KEqvIPrK3W21tlasJrNa6gPwjA+G9Ju65b1fwfuRv
         i1qTjk8OCxagg==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        Ard Biesheuvel <ardb@kernel.org>,
        Tom Lendacky <thomas.lendacky@amd.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, "H. Peter Anvin" <hpa@zytor.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] x86/efi: select ARCH_USE_MEMREMAP_PROT
Date:   Sat,  4 Dec 2021 18:41:10 +0100
Message-Id: <20211204174156.977245-1-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

The patch to map the EFI memmap as encrypted introduces a
link failure in configurations without encryption support:

x86_64-linux-ld: arch/x86/platform/efi/quirks.o: in function `efi_arch_mem_reserve':
quirks.c:(.init.text+0x127): undefined reference to `early_memremap_prot'

Select the necessary symbol here as well to fix the build.

Fixes: 8f1dd76c9b55 ("x86/sme: Explicitly map new EFI memmap table as encrypted")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/x86/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 05362527f6b5..93befe25d787 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -1934,6 +1934,7 @@ config EFI
 	depends on ACPI
 	select UCS2_STRING
 	select EFI_RUNTIME_WRAPPERS
+	select ARCH_USE_MEMREMAP_PROT
 	help
 	  This enables the kernel to use EFI runtime services that are
 	  available (such as the EFI variable services).
-- 
2.29.2

