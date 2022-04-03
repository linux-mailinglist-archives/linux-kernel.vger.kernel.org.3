Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4593D4F0714
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Apr 2022 05:14:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231286AbiDCDP6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Apr 2022 23:15:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231280AbiDCDPz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Apr 2022 23:15:55 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5191E12A88;
        Sat,  2 Apr 2022 20:13:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=45+PtY2KxLSf5ox+zJPh8dG5t1TTtpukHGJp11Nd5pA=; b=YSSNmTVTKaN8rHdY0ufjHHfZfp
        b4ja/MhUhjU1AqLmOKgiKgLRjmctKLE257t18zSYl7tIqjsyNuTo8mhEdSsBWheEL47yIlWPwkZbu
        642lWTGiV31EZtDnMlW+fHV9fVuzoLTUuXFVZ7pG/t5g28nMiHmYGFahSDpFs8WcCpNdU90pw6vbb
        czc5wUKXD/PcD/a0S8Pa4mJfn4UXSPE56TxZGw/RYJI0/6O0rmRERYVJS/pAGyT4vQ53jJzO0GdiO
        yK/hD05h0aXVfyNGT9bWuDXGCh44Wvl+9bj+fm2BYVDoocCphJkJo4QHH9U7CMxdyVDpqslOEz3n4
        geeGXQSg==;
Received: from [2601:1c0:6280:3f0::aa0b] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1naqge-00AZ3b-Je; Sun, 03 Apr 2022 03:13:56 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        kernel test robot <lkp@intel.com>,
        Anup Patel <anup.patel@wdc.com>,
        Anup Patel <anup@brainfault.org>,
        Anup Patel <apatel@ventanamicro.com>,
        Atish Patra <atishp@rivosinc.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org,
        linux-riscv@lists.infradead.org,
        Palmer Dabbelt <palmer@rivosinc.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Subject: [PATCH -next] cpuidle: riscv: support non-SMP config
Date:   Sat,  2 Apr 2022 20:13:55 -0700
Message-Id: <20220403031355.20894-1-rdunlap@infradead.org>
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

Add <asm/smp.h> for cpuid_to_hartid_map etc.
This is needed for both SMP and non-SMP builds, but not having it
causes a build error for non-SMP:

drivers/cpuidle/cpuidle-riscv-sbi.c: In function 'sbi_cpuidle_init_cpu':
drivers/cpuidle/cpuidle-riscv-sbi.c:350:26: error: implicit declaration of function 'cpuid_to_hartid_map' [-Werror=implicit-function-declaration]

Fixes: 6abf32f1d9c5 ("cpuidle: Add RISC-V SBI CPU idle driver")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Reported-by: kernel test robot <lkp@intel.com>
Cc: Anup Patel <anup.patel@wdc.com>
Cc: Anup Patel <anup@brainfault.org>
Cc: Anup Patel <apatel@ventanamicro.com>
Cc: Atish Patra <atishp@rivosinc.com>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: linux-pm@vger.kernel.org
Cc: linux-riscv@lists.infradead.org
Cc: Palmer Dabbelt <palmer@rivosinc.com>
Cc: Paul Walmsley <paul.walmsley@sifive.com>
Cc: Albert Ou <aou@eecs.berkeley.edu>
---
 drivers/cpuidle/cpuidle-riscv-sbi.c |    1 +
 1 file changed, 1 insertion(+)

--- linux-next-20220401.orig/drivers/cpuidle/cpuidle-riscv-sbi.c
+++ linux-next-20220401/drivers/cpuidle/cpuidle-riscv-sbi.c
@@ -22,6 +22,7 @@
 #include <linux/pm_runtime.h>
 #include <asm/cpuidle.h>
 #include <asm/sbi.h>
+#include <asm/smp.h>
 #include <asm/suspend.h>
 
 #include "dt_idle_states.h"
