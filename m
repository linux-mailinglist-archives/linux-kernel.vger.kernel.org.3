Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D0A94B05CF
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 06:51:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234815AbiBJFuj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 00:50:39 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:44028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231986AbiBJFuS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 00:50:18 -0500
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D00D510CE
        for <linux-kernel@vger.kernel.org>; Wed,  9 Feb 2022 21:50:19 -0800 (PST)
Received: by mail-pf1-x42d.google.com with SMTP id 9so5462527pfx.12
        for <linux-kernel@vger.kernel.org>; Wed, 09 Feb 2022 21:50:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UuYvub3Z8EBowURerfOySZ1eEDSGZNWibhgVNvKw2rA=;
        b=n2BOKto+S5qvwcPV9B3PxUAGJddz5awCGs9hneNmZQKmE+BULKzAi3rm/a7Mv5ANxw
         drO9JtmltNRZg7zBwwN4SHzwkGD1rSdgMpmJrB36ZRHbMEGBAsmSE6XRT4sFsJ1CMJc0
         O4JunSoTrmKX9xWBGQtcyD6huLCb8gw9YAoXFf437P8DKgucsJGdik2YEDbuwbr9Bx6p
         wKTJLWPFNGxCdJJGfwtTGCzY6WBKlMmiwbieN5uF29DFwQLsYjj+rsdmlnXGeOmLhhmU
         XLmKK3YqJ2+RGHZZAYeGtMyrLUA/8iwNUQtUhFTU1bdWZeZ10zj6qXrVaBzv11DkcX3B
         +skQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UuYvub3Z8EBowURerfOySZ1eEDSGZNWibhgVNvKw2rA=;
        b=CL3pri6SkjxrdJLy82AQVaM+2nPptagvaUb7iSThy6gSgm6O25owBIjZdWY191zODV
         VK4GPy7J4cqUzs7mCeCT5rz5iICl8kQmqP8jIdsTJeyIUzZEvtNtkjDAjvKb3Yw5yoal
         F2IQAaYHeBOjFeiER5M3wG8eSXyQOAMaJlCK9lm1Z27aezsondrLmn1H6KnMzYygrE4U
         B5AIGcN3aoB7x/6pyZgSdHYyKigvPRkY+d+PounMeGhWmuX2Zdm4K7ejCMzMN+t0UX6a
         DFYyGQsR/nZfsXDIYCgZuFGjMsI3JAiGyQWonV4lfYrOvtN4KQuy8HYx072pCKd1ufaX
         cfIg==
X-Gm-Message-State: AOAM531un0reMGXHCmfv5Y7QtoXT1qKq1tQHlD5xlU2ISw/vo4mnvjjV
        z1aS4tm++4lYlIE67rIM13WOKA==
X-Google-Smtp-Source: ABdhPJyXYV31XW1XO52vFcxi9ex8CQM/n5s3f5qUEZi2p/CP9x1LoGOoZJ8+PS18busvh/WRPM9plA==
X-Received: by 2002:a63:5144:: with SMTP id r4mr4892868pgl.382.1644472219329;
        Wed, 09 Feb 2022 21:50:19 -0800 (PST)
Received: from localhost.localdomain ([122.179.114.46])
        by smtp.gmail.com with ESMTPSA id s32sm15192270pfw.80.2022.02.09.21.50.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Feb 2022 21:50:18 -0800 (PST)
From:   Anup Patel <apatel@ventanamicro.com>
To:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>
Cc:     Sandeep Tripathy <milun.tripathy@gmail.com>,
        Atish Patra <atishp@atishpatra.org>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        Liush <liush@allwinnertech.com>,
        Anup Patel <anup@brainfault.org>, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kvm-riscv@lists.infradead.org
Subject: [PATCH v11 0/8] RISC-V CPU Idle Support
Date:   Thu, 10 Feb 2022 11:19:39 +0530
Message-Id: <20220210054947.170134-1-apatel@ventanamicro.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Anup Patel <anup.patel@wdc.com>

This series adds RISC-V CPU Idle support using SBI HSM suspend function.
The RISC-V SBI CPU idle driver added by this series is highly inspired
from the ARM PSCI CPU idle driver.

At high-level, this series includes the following changes:
1) Preparatory arch/riscv patches (Patches 1 to 3)
2) Defines for RISC-V SBI HSM suspend (Patch 4)
3) Preparatory patch to share code between RISC-V SBI CPU idle driver
   and ARM PSCI CPU idle driver (Patch 5)
4) RISC-V SBI CPU idle driver and related DT bindings (Patches 6 to 7)

These patches can be found in riscv_sbi_hsm_suspend_v11 branch of
https://github.com/avpatel/linux.git

Special thanks Sandeep Tripathy for providing early feeback on SBI HSM
support in all above projects (RISC-V SBI specification, OpenSBI, and
Linux RISC-V).

Changes since v10:
 - Rebased on Linux-5.17-rc3
 - Typo fix in commit description of PATCH6

Changes since v9:
 - Rebased on Linux-5.17-rc1

Changes since v8:
 - Rebased on Linux-5.15-rc5
 - Fixed DT schema check errors in PATCH7

Changes since v7:
 - Rebased on Linux-5.15-rc3
 - Renamed cpuidle-sbi.c to cpuidle-riscv-sbi.c in PATCH6

Changes since v6:
 - Fixed error reported by "make DT_CHECKER_FLAGS=-m dt_binding_check"

Changes since v5:
 - Rebased on Linux-5.13-rc5
 - Removed unnecessary exports from PATCH5
 - Removed stray ";" from PATCH5
 - Moved sbi_cpuidle_pd_power_off() under "#ifdef CONFIG_DT_IDLE_GENPD"
   in PATCH6

Changes since v4:
 - Rebased on Linux-5.13-rc2
 - Renamed all dt_idle_genpd functions to have "dt_idle_" prefix
 - Added MAINTAINERS file entry for dt_idle_genpd

Changes since v3:
 - Rebased on Linux-5.13-rc2
 - Fixed __cpu_resume_enter() which was broken due to XIP kernel support
 - Removed "struct dt_idle_genpd_ops" abstraction which simplifies code
   sharing between ARM PSCI and RISC-V SBI drivers in PATCH5

Changes since v2:
 - Rebased on Linux-5.12-rc3
 - Updated PATCH7 to add common DT bindings for both ARM and RISC-V
   idle states
 - Added "additionalProperties = false" for both idle-states node and
   child nodes in PATCH7

Changes since v1:
 - Fixex minor typo in PATCH1
 - Use just "idle-states" as DT node name for CPU idle states
 - Added documentation for "cpu-idle-states" DT property in
   devicetree/bindings/riscv/cpus.yaml
 - Added documentation for "riscv,sbi-suspend-param" DT property in
   devicetree/bindings/riscv/idle-states.yaml

Anup Patel (8):
  RISC-V: Enable CPU_IDLE drivers
  RISC-V: Rename relocate() and make it global
  RISC-V: Add arch functions for non-retentive suspend entry/exit
  RISC-V: Add SBI HSM suspend related defines
  cpuidle: Factor-out power domain related code from PSCI domain driver
  cpuidle: Add RISC-V SBI CPU idle driver
  dt-bindings: Add common bindings for ARM and RISC-V idle states
  RISC-V: Enable RISC-V SBI CPU Idle driver for QEMU virt machine

 .../bindings/arm/msm/qcom,idle-state.txt      |   2 +-
 .../devicetree/bindings/arm/psci.yaml         |   2 +-
 .../bindings/{arm => cpu}/idle-states.yaml    | 228 ++++++-
 .../devicetree/bindings/riscv/cpus.yaml       |   6 +
 MAINTAINERS                                   |  14 +
 arch/riscv/Kconfig                            |   7 +
 arch/riscv/Kconfig.socs                       |   3 +
 arch/riscv/configs/defconfig                  |   2 +
 arch/riscv/configs/rv32_defconfig             |   2 +
 arch/riscv/include/asm/asm.h                  |  27 +
 arch/riscv/include/asm/cpuidle.h              |  24 +
 arch/riscv/include/asm/sbi.h                  |  27 +-
 arch/riscv/include/asm/suspend.h              |  36 +
 arch/riscv/kernel/Makefile                    |   2 +
 arch/riscv/kernel/asm-offsets.c               |   3 +
 arch/riscv/kernel/cpu_ops_sbi.c               |   2 +-
 arch/riscv/kernel/head.S                      |  28 +-
 arch/riscv/kernel/process.c                   |   3 +-
 arch/riscv/kernel/suspend.c                   |  87 +++
 arch/riscv/kernel/suspend_entry.S             | 124 ++++
 arch/riscv/kvm/vcpu_sbi_hsm.c                 |   4 +-
 drivers/cpuidle/Kconfig                       |   9 +
 drivers/cpuidle/Kconfig.arm                   |   1 +
 drivers/cpuidle/Kconfig.riscv                 |  15 +
 drivers/cpuidle/Makefile                      |   5 +
 drivers/cpuidle/cpuidle-psci-domain.c         | 138 +---
 drivers/cpuidle/cpuidle-psci.h                |  15 +-
 drivers/cpuidle/cpuidle-riscv-sbi.c           | 627 ++++++++++++++++++
 drivers/cpuidle/dt_idle_genpd.c               | 178 +++++
 drivers/cpuidle/dt_idle_genpd.h               |  50 ++
 30 files changed, 1484 insertions(+), 187 deletions(-)
 rename Documentation/devicetree/bindings/{arm => cpu}/idle-states.yaml (74%)
 create mode 100644 arch/riscv/include/asm/cpuidle.h
 create mode 100644 arch/riscv/include/asm/suspend.h
 create mode 100644 arch/riscv/kernel/suspend.c
 create mode 100644 arch/riscv/kernel/suspend_entry.S
 create mode 100644 drivers/cpuidle/Kconfig.riscv
 create mode 100644 drivers/cpuidle/cpuidle-riscv-sbi.c
 create mode 100644 drivers/cpuidle/dt_idle_genpd.c
 create mode 100644 drivers/cpuidle/dt_idle_genpd.h

-- 
2.25.1

