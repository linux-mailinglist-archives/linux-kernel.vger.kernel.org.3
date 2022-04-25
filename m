Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8497750D795
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 05:34:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240648AbiDYDhF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Apr 2022 23:37:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234525AbiDYDhB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Apr 2022 23:37:01 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE10D2CCB0;
        Sun, 24 Apr 2022 20:33:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=+1TvpqD80KcqcXO4DlDpD3nqSxzpIXNoYfaZOHv//ro=; b=QiiJXHVzLz+WIEk6nU0Jptq3Vy
        yk00uoEjWxSX9r5m4PtrXv9AS4SswnMqoEIov81nz1PAF4h7x6l0xNEK6jqv34b1qxdZvToigLGzT
        yDUtrOjGqooxxqeAyKgRb/CPISFdwo7la27/bbYUlhEKScPjoE/TnYRmO/GyPYylJ/IGer9sn9gBc
        V4+msFcayz+1hmDJMTExBmnXPJU45wNZTaZGzl+TaxcB39oO5W8Rr5Rw08Ra1kmcVJqfzNmYYICLL
        3mVZHMe4cX+OgGT6C0CX1aquaraQVhK2XrPNinErsoTVr0O1o5i3g0o0E0OxKchEWw1SNix/tRa+4
        ygvfCDjw==;
Received: from [2601:1c0:6280:3f0::aa0b] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nipU4-007ysB-HY; Mon, 25 Apr 2022 03:33:56 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        kernel test robot <lkp@intel.com>,
        Dmitry Osipenko <digetx@gmail.com>,
        Thierry Reding <treding@nvidia.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-pm@vger.kernel.org
Subject: [PATCH] cpuidle: tegra: restrict to ARCH_SUSPEND_POSSIBLE
Date:   Sun, 24 Apr 2022 20:33:55 -0700
Message-Id: <20220425033355.6281-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
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
---
 drivers/cpuidle/Kconfig.arm |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/cpuidle/Kconfig.arm
+++ b/drivers/cpuidle/Kconfig.arm
@@ -101,6 +101,7 @@ config ARM_MVEBU_V7_CPUIDLE
 config ARM_TEGRA_CPUIDLE
 	bool "CPU Idle Driver for NVIDIA Tegra SoCs"
 	depends on (ARCH_TEGRA || COMPILE_TEST) && !ARM64 && MMU
+	depends on ARCH_SUSPEND_POSSIBLE
 	select ARCH_NEEDS_CPU_IDLE_COUPLED if SMP
 	select ARM_CPU_SUSPEND
 	help
