Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A6424FAB17
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Apr 2022 00:53:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232845AbiDIWze (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Apr 2022 18:55:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230498AbiDIWzc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Apr 2022 18:55:32 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B8666213C;
        Sat,  9 Apr 2022 15:53:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=ROno+fSVX2ST3zHwFKC2Cb/T5gT1F1McUAUXklUQVvA=; b=gn6SwgAtZ7c4je7+kW7StqPt3z
        BuHpJRdWKUCGJuQlbFEUfYx6jz0emH2pg+7IQ0ihZrw6uBuUnMqsH8lauV/Uwaw+ThdYem4kr96Rl
        3OL44vvVuPW2GggibzdS0/9OIGX92jIrzMFWozhA9H2Fv1/cRvC6YyP5BhNcncb/Vw16EO8M+46Np
        RgEIkl5chZRNglhtpTnu7gu9zSVFfnAMuoMaeqLMJHdNvWGVPF5cfy0rRi7h3/OJBSzqvBT4TMD5a
        RhU8nBp1CVOLCZKh7PWcOxKKthh1Q1qkiH3+etyhkl3ozMpIlxkh9T21dDut5Hnmbz5wEGi2jWYR9
        Ren4K4AQ==;
Received: from [2601:1c0:6280:3f0::aa0b] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ndJxH-003syH-MI; Sat, 09 Apr 2022 22:53:19 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        kernel test robot <lkp@intel.com>,
        Anup Patel <anup.patel@wdc.com>,
        Anup Patel <apatel@ventanamicro.com>,
        Anup Patel <anup@brainfault.org>,
        Palmer Dabbelt <palmer@rivosinc.com>, linux-pm@vger.kernel.org,
        linux-riscv@lists.infradead.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Subject: [PATCH] RISC-V: cpuidle: fix Kconfig select for RISCV_SBI_CPUIDLE
Date:   Sat,  9 Apr 2022 15:53:17 -0700
Message-Id: <20220409225317.14332-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There can be lots of build errors when building cpuidle-riscv-sbi.o.
They are all caused by a kconfig problem with this warning:

WARNING: unmet direct dependencies detected for RISCV_SBI_CPUIDLE
  Depends on [n]: CPU_IDLE [=y] && RISCV [=y] && RISCV_SBI [=n]
  Selected by [y]:
  - SOC_VIRT [=y] && CPU_IDLE [=y]

so make the 'select' of RISCV_SBI_CPUIDLE also depend on RISCV_SBI.

Fixes: c5179ef1ca0c ("RISC-V: Enable RISC-V SBI CPU Idle driver for QEMU virt machine")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Reported-by: kernel test robot <lkp@intel.com>
Cc: Anup Patel <anup.patel@wdc.com>
Cc: Anup Patel <apatel@ventanamicro.com>
Cc: Anup Patel <anup@brainfault.org>
Cc: Palmer Dabbelt <palmer@rivosinc.com>
Cc: linux-pm@vger.kernel.org
Cc: linux-riscv@lists.infradead.org
Cc: Paul Walmsley <paul.walmsley@sifive.com>
Cc: Palmer Dabbelt <palmer@dabbelt.com>
Cc: Albert Ou <aou@eecs.berkeley.edu>
---
 arch/riscv/Kconfig.socs |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/riscv/Kconfig.socs
+++ b/arch/riscv/Kconfig.socs
@@ -38,7 +38,7 @@ config SOC_VIRT
 	select SIFIVE_PLIC
 	select PM_GENERIC_DOMAINS if PM
 	select PM_GENERIC_DOMAINS_OF if PM && OF
-	select RISCV_SBI_CPUIDLE if CPU_IDLE
+	select RISCV_SBI_CPUIDLE if CPU_IDLE && RISCV_SBI
 	help
 	  This enables support for QEMU Virt Machine.
 
