Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0830F49C8EA
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 12:45:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240873AbiAZLpK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 06:45:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240867AbiAZLpJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 06:45:09 -0500
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D911C061747
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 03:45:08 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id x11so16365082plg.6
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 03:45:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cPhrS/FGf71tqZJf9nxannjEcaQ4fcOOpUidytEKIP4=;
        b=h4/ofyTO4FVFqg6jJo130MG3UCm5nxdlXdw6QJnlIQv+p3OClTT0/HZJv6RTSRZg2T
         WYy9bV9v5NbINmS4YAFvZFgjPDLOTYwljBGALf3qaybQ7JK7+u7iTQWpPT131TJYK3aj
         qpJhUThqC8Yu+SqcNucRnUsW3F5UXVjX+fYu37/Bhl8te1rAedFq+5gbd+lNrMJ1cUT5
         yeAndi+31m+WRqG6HuR7zpgO0lsXb3HIPXARTyQ6rdsSrls6V4l7bMSaGV8i6yFYrT9Y
         RW8sWKxqcjV1vH8N8kise3/GF28L/+TWOSoJ8bz+FXrfwr0VBI1azEN1xS4YsSGJV59H
         Z7QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cPhrS/FGf71tqZJf9nxannjEcaQ4fcOOpUidytEKIP4=;
        b=DuGLSQRUAWDrw93R67xZS9QqP1Q0IOT8egFwPRcs3CGBhTd4ur7z1GQYk6wVXzYOzO
         tROfPbQFgREovEjJh29QIIUcMhh67t1BsNWgv7z7vsvc0wUxVJJqqYa/EqBElyPhHfjh
         pOifFkGlku8wQs06kk4i9FG23XgcwB8TjQE5ZCqyvnZTN++xgTykkLUIorG8mL4V2/dk
         UjeOEJhOvvZJzG8TlwqZJLEVnCTJtbULej1v0gF34n07ec+KjBN/o2nwjb0XY9QoJPzH
         +eE8XLSTUEi/MeDOME8+I5AJiL6JV5OYmu0UykvHBR4ZOlXOjZafBzbt0IaMSYRDaYI0
         jhXA==
X-Gm-Message-State: AOAM532qabVJwln07l9c2FpThtRNGYswnNs3iwRFsgj9iWAJCmTf6L9A
        dCxKj4cPZnMv5Vk8MVP+5QkN7Q==
X-Google-Smtp-Source: ABdhPJxRqh0aVOXEx6weXjAfHzoenGJ6LcMvV6v7JX2u2rArawi28fGIJCrSkz6WTpc3wAUUSxpeeQ==
X-Received: by 2002:a17:902:8492:b0:149:7c77:7254 with SMTP id c18-20020a170902849200b001497c777254mr22866016plo.19.1643197507867;
        Wed, 26 Jan 2022 03:45:07 -0800 (PST)
Received: from localhost.localdomain ([122.167.221.23])
        by smtp.gmail.com with ESMTPSA id nn2sm2994976pjb.35.2022.01.26.03.45.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jan 2022 03:45:07 -0800 (PST)
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
Subject: [PATCH v10 0/8] RISC-V CPU Idle Support
Date:   Wed, 26 Jan 2022 17:14:44 +0530
Message-Id: <20220126114452.692512-1-apatel@ventanamicro.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

These patches can be found in riscv_sbi_hsm_suspend_v10 branch of
https://github.com/avpatel/linux.git

Special thanks Sandeep Tripathy for providing early feeback on SBI HSM
support in all above projects (RISC-V SBI specification, OpenSBI, and
Linux RISC-V).

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

