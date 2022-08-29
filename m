Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCC1F5A407D
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 02:51:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229590AbiH2Avy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Aug 2022 20:51:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbiH2Avw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Aug 2022 20:51:52 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BC0732AA5;
        Sun, 28 Aug 2022 17:51:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=VeyYToAsC3C3fbPamOCPxUTHQPeUF4DLHeo1aRUxSbo=; b=SMuuDvUUgTrexLVkIRh+xQN9tW
        JMDZtIe00U80TtQtKFMSvMMmcBoW/HdXFc48QQHnlpDCX7UJ3O6Ve8zVMobYzFFqoY9Z2W0xMf0LQ
        qIgYhSJ8MukHK+SmojJybKQmoVAftaDXxmOTE8ukzI5Vp0McmH0XUBDuJsV8ze4kUxAoKSirQ9EK1
        UrAgv0GSpH12p+BhBE/ktLXQf0nWydUBurUlCJXDFQLUBQXoBV3rfhjxD3vPPYsDQRqm2dejsye2v
        41ML1X4Qp7Ju1DFLsaBerCqvR5WV4HF7IeHVcGQATCgjTIIOivHLfgeBIHiHIhZyb0Ael2iWwtuty
        cqvjTdMA==;
Received: from [2601:1c0:6280:3f0::a6b3] (helo=casper.infradead.org)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oST0D-002eU7-GP; Mon, 29 Aug 2022 00:51:46 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        kernel test robot <lkp@intel.com>,
        Dmitry Osipenko <digetx@gmail.com>,
        Thierry Reding <treding@nvidia.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-pm@vger.kernel.org
Subject: [PATCH v2] cpuidle: tegra: restrict to ARCH_SUSPEND_POSSIBLE
Date:   Sun, 28 Aug 2022 17:51:37 -0700
Message-Id: <20220829005137.27435-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.37.2
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

Since 'select' does not follow any dependency chain (ARM_CPU_SUSPEND
in this case), make ARM_TEGRA_CPUIDLE depend on ARCH_SUSPEND_POSSIBLE,
just as ARM_CPU_SUSPEND does.

Fix this kconfig warning:

WARNING: unmet direct dependencies detected for ARM_CPU_SUSPEND
  Depends on [n]: ARCH_SUSPEND_POSSIBLE [=n]
  Selected by [y]:
  - ARM_TEGRA_CPUIDLE [=y] && CPU_IDLE [=y] && (ARM [=y] || ARM64) && (ARCH_TEGRA [=n] || COMPILE_TEST [=y]) && !ARM64 && MMU [=y]

and subsequent build errors:

arm-linux-gnueabi-ld: arch/arm/kernel/sleep.o: in function `__cpu_suspend':
(.text+0x68): undefined reference to `cpu_sa110_suspend_size'
arm-linux-gnueabi-ld: arch/arm/kernel/suspend.o: in function `__cpu_suspend_save':
suspend.c:(.text+0x478): undefined reference to `cpu_sa110_do_suspend'
arm-linux-gnueabi-ld: suspend.c:(.text+0x4e8): undefined reference to `cpu_sa110_do_resume'

Fixes: faae6c9f2e68 ("cpuidle: tegra: Enable compile testing")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Reported-by: kernel test robot <lkp@intel.com>
Cc: Dmitry Osipenko <digetx@gmail.com>
Cc: Thierry Reding <treding@nvidia.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: linux-pm@vger.kernel.org
Reviewed-by: Arnd Bergmann <arnd@arndb.de>
---
v2: add Arnd's Reviewed-by.

 drivers/cpuidle/Kconfig.arm |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/cpuidle/Kconfig.arm
+++ b/drivers/cpuidle/Kconfig.arm
@@ -102,6 +102,7 @@ config ARM_MVEBU_V7_CPUIDLE
 config ARM_TEGRA_CPUIDLE
 	bool "CPU Idle Driver for NVIDIA Tegra SoCs"
 	depends on (ARCH_TEGRA || COMPILE_TEST) && !ARM64 && MMU
+	depends on ARCH_SUSPEND_POSSIBLE
 	select ARCH_NEEDS_CPU_IDLE_COUPLED if SMP
 	select ARM_CPU_SUSPEND
 	help
