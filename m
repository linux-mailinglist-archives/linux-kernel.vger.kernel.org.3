Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A988532DEF
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 17:57:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239134AbiEXP5p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 11:57:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232287AbiEXP5n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 11:57:43 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75D5D986D7;
        Tue, 24 May 2022 08:57:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=B8XT5WxddcuyBOpLYerWnhTOFuVD+zv031mAdqT881Y=; b=qnN3we4WI+oi/EwyaNHt8O2sCV
        kHYyoy78xzATv6nYHAqOJz/lRBrRGh+1vbn83L7gWzIjQSWbwCV/v2v/H3O7IGkCOld/JYiecMtZa
        LbK9ZWRWW3LcV+1WCu41UfNAS1tHHLEnaaFHDFiqGjgxI2J4dRe5+TsF+J8FFiiGFYoweeRdT5mVp
        IYg8KuwK63VGm1bc2oSCsRRVpqmbKyTCtJYr5QtQ8UiR1U3j+A+pvK14wXcaVJpac/59NLvrmHDvk
        6E+iZTW54PPVI4M4+6TvGDKQpGFR8U4wRZUVbBR4thmFIdqZahF66ENjamuDwN2UtLWdP2cJWGqQq
        Z19JrGAA==;
Received: from [2601:1c0:6280:3f0::aa0b] (helo=casper.infradead.org)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ntWug-00HEa4-Ux; Tue, 24 May 2022 15:57:39 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        kernel test robot <lkp@intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-pm@vger.kernel.org, Dmitry Osipenko <digetx@gmail.com>,
        Thierry Reding <treding@nvidia.com>
Subject: [PATCH] cpuidle: tegra: honor ARCH_SUSPEND_POSSIBLE
Date:   Tue, 24 May 2022 08:57:33 -0700
Message-Id: <20220524155733.28262-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.35.3
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

When ARCH_SUSPEND_POSSIBLE is not enabled, selecting ARM_CPU_SUSPEND
causes a Kconfig warning, so make ARM_TEGRA_CPUIDLE depend on
ARCH_SUSPEND_POSSIBLE to prevent that warning.

WARNING: unmet direct dependencies detected for ARM_CPU_SUSPEND
  Depends on [n]: ARCH_SUSPEND_POSSIBLE [=n]
  Selected by [y]:
  - ARM_TEGRA_CPUIDLE [=y] && CPU_IDLE [=y] && (ARM [=y] || ARM64) && (ARCH_TEGRA [=n] || COMPILE_TEST [=y]) && !ARM64 && MMU [=y]

Fixes: 860fbde438dc ("cpuidle: Refactor and move out NVIDIA Tegra20 driver into drivers/cpuidle")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Reported-by: kernel test robot <lkp@intel.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: linux-pm@vger.kernel.org
Cc: Dmitry Osipenko <digetx@gmail.com>
Cc: Thierry Reding <treding@nvidia.com>
---
 drivers/cpuidle/Kconfig.arm |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/cpuidle/Kconfig.arm
+++ b/drivers/cpuidle/Kconfig.arm
@@ -100,6 +100,7 @@ config ARM_MVEBU_V7_CPUIDLE
 
 config ARM_TEGRA_CPUIDLE
 	bool "CPU Idle Driver for NVIDIA Tegra SoCs"
+	depends on ARCH_SUSPEND_POSSIBLE
 	depends on (ARCH_TEGRA || COMPILE_TEST) && !ARM64 && MMU
 	select ARCH_NEEDS_CPU_IDLE_COUPLED if SMP
 	select ARM_CPU_SUSPEND
