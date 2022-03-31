Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE9D34ED0C6
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 02:16:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352057AbiCaASe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 20:18:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbiCaASc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 20:18:32 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21D144550F
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 17:16:46 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id a16-20020a17090a6d9000b001c7d6c1bb13so1904204pjk.4
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 17:16:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20210112.gappssmtp.com; s=20210112;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=hV5Vaha8m52Fl/sbC+q84uMk9aQkw6LUqtUCcgndF8M=;
        b=CV+r1o6zChs5P5InM9X1qElR7wUi9znFVzk+BTEw9wbkC5GpnAL32a0JlFZ5IDVGEs
         VX2dMQ+caneEvjqT0ygPK6CJf2NcwPcVFDb9GtiAYvNrHg1ZDhFz72fD34Y1a8hbQ6RI
         nL2QkUrZrHGMidBFNqIBJdRoKs0Zy261sw1wIyJ9CJngYZCqaX+WVLtzebLvwAe2pHYw
         5Y5mAuJGZPm6WtoZzG7mpZahhtAS8MS8TSND9TArgR+796jXSrne0Lh6wgDOmPulJYNl
         ozTTy8BOxKZ1SSj/if+fYPGeZhmUpBi7gD2PZF1hx9FQk6uFLTkDrLwRMEv3o1Ggo8gH
         JDAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=hV5Vaha8m52Fl/sbC+q84uMk9aQkw6LUqtUCcgndF8M=;
        b=b2ATFeBj693iZzM6SaUqrON9IaBTivTgbn2Ofq3vVQjLDvoAl4vpzkRhxFv5LH5+OK
         x1bPDgeTPJV5n7/kYHlPzSbB38RiMzM4r9WEHsapewu5Xhvzp15GO9hTaSop60QgmrNd
         btfImBqcGBlh/tHetY1l/89TzqZqjJAspKRgtnI9JhQi9tkvw/54gmi8l2WcH7/Ng0JI
         9lEnyzWst+xaAbS/GpdA47WEfe101TOsVsf2AlciyQfrKgIOYOBP8/8zhRC5mEBtlG7y
         UwkQmP0FF7gU13yEuYqSE5wuMm8g7gjVDD6DP6F8nJfB7PHR+t+XulG57cs0Zj6P3A9a
         IzfA==
X-Gm-Message-State: AOAM533t+tDIC9vaY0Pa7SHAVmHGPN8JygeQ0mUdmXIEgCW/3GD0x4CK
        fCrw0JyftMd7vbE4f5Q759w16w==
X-Google-Smtp-Source: ABdhPJz3Vbz6dsNGCNsUCpmIHgTM0rvC4Z04UHGBv/6dn0xozsPKDxJlOJ9mtUs2fY8yqbbfl4uTuQ==
X-Received: by 2002:a17:903:206:b0:153:ebab:a52f with SMTP id r6-20020a170903020600b00153ebaba52fmr2479213plh.118.1648685805530;
        Wed, 30 Mar 2022 17:16:45 -0700 (PDT)
Received: from localhost ([12.3.194.138])
        by smtp.gmail.com with ESMTPSA id b2-20020a056a000a8200b004f1111c66afsm27292172pfl.148.2022.03.30.17.16.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Mar 2022 17:16:44 -0700 (PDT)
Date:   Wed, 30 Mar 2022 17:16:44 -0700 (PDT)
X-Google-Original-Date: Wed, 30 Mar 2022 17:16:33 PDT (-0700)
Subject:     Re: [PATCH v11 0/8] RISC-V CPU Idle Support
In-Reply-To: <20220210054947.170134-1-apatel@ventanamicro.com>
CC:     Paul Walmsley <paul.walmsley@sifive.com>, aou@eecs.berkeley.edu,
        daniel.lezcano@linaro.org, ulf.hansson@linaro.org,
        rjw@rjwysocki.net, pavel@ucw.cz, robh+dt@kernel.org,
        milun.tripathy@gmail.com, atishp@atishpatra.org,
        Alistair Francis <Alistair.Francis@wdc.com>,
        liush@allwinnertech.com, anup@brainfault.org,
        devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kvm-riscv@lists.infradead.org
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     apatel@ventanamicro.com
Message-ID: <mhng-ed3c61a2-45a5-4cc4-b1ec-26e25f92c0a3@palmer-ri-x1c9>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 09 Feb 2022 21:49:39 PST (-0800), apatel@ventanamicro.com wrote:
> From: Anup Patel <anup.patel@wdc.com>
>
> This series adds RISC-V CPU Idle support using SBI HSM suspend function.
> The RISC-V SBI CPU idle driver added by this series is highly inspired
> from the ARM PSCI CPU idle driver.
>
> At high-level, this series includes the following changes:
> 1) Preparatory arch/riscv patches (Patches 1 to 3)
> 2) Defines for RISC-V SBI HSM suspend (Patch 4)
> 3) Preparatory patch to share code between RISC-V SBI CPU idle driver
>    and ARM PSCI CPU idle driver (Patch 5)
> 4) RISC-V SBI CPU idle driver and related DT bindings (Patches 6 to 7)
>
> These patches can be found in riscv_sbi_hsm_suspend_v11 branch of
> https://github.com/avpatel/linux.git
>
> Special thanks Sandeep Tripathy for providing early feeback on SBI HSM
> support in all above projects (RISC-V SBI specification, OpenSBI, and
> Linux RISC-V).
>
> Changes since v10:
>  - Rebased on Linux-5.17-rc3
>  - Typo fix in commit description of PATCH6
>
> Changes since v9:
>  - Rebased on Linux-5.17-rc1
>
> Changes since v8:
>  - Rebased on Linux-5.15-rc5
>  - Fixed DT schema check errors in PATCH7
>
> Changes since v7:
>  - Rebased on Linux-5.15-rc3
>  - Renamed cpuidle-sbi.c to cpuidle-riscv-sbi.c in PATCH6
>
> Changes since v6:
>  - Fixed error reported by "make DT_CHECKER_FLAGS=-m dt_binding_check"
>
> Changes since v5:
>  - Rebased on Linux-5.13-rc5
>  - Removed unnecessary exports from PATCH5
>  - Removed stray ";" from PATCH5
>  - Moved sbi_cpuidle_pd_power_off() under "#ifdef CONFIG_DT_IDLE_GENPD"
>    in PATCH6
>
> Changes since v4:
>  - Rebased on Linux-5.13-rc2
>  - Renamed all dt_idle_genpd functions to have "dt_idle_" prefix
>  - Added MAINTAINERS file entry for dt_idle_genpd
>
> Changes since v3:
>  - Rebased on Linux-5.13-rc2
>  - Fixed __cpu_resume_enter() which was broken due to XIP kernel support
>  - Removed "struct dt_idle_genpd_ops" abstraction which simplifies code
>    sharing between ARM PSCI and RISC-V SBI drivers in PATCH5
>
> Changes since v2:
>  - Rebased on Linux-5.12-rc3
>  - Updated PATCH7 to add common DT bindings for both ARM and RISC-V
>    idle states
>  - Added "additionalProperties = false" for both idle-states node and
>    child nodes in PATCH7
>
> Changes since v1:
>  - Fixex minor typo in PATCH1
>  - Use just "idle-states" as DT node name for CPU idle states
>  - Added documentation for "cpu-idle-states" DT property in
>    devicetree/bindings/riscv/cpus.yaml
>  - Added documentation for "riscv,sbi-suspend-param" DT property in
>    devicetree/bindings/riscv/idle-states.yaml
>
> Anup Patel (8):
>   RISC-V: Enable CPU_IDLE drivers
>   RISC-V: Rename relocate() and make it global
>   RISC-V: Add arch functions for non-retentive suspend entry/exit
>   RISC-V: Add SBI HSM suspend related defines
>   cpuidle: Factor-out power domain related code from PSCI domain driver
>   cpuidle: Add RISC-V SBI CPU idle driver
>   dt-bindings: Add common bindings for ARM and RISC-V idle states
>   RISC-V: Enable RISC-V SBI CPU Idle driver for QEMU virt machine
>
>  .../bindings/arm/msm/qcom,idle-state.txt      |   2 +-
>  .../devicetree/bindings/arm/psci.yaml         |   2 +-
>  .../bindings/{arm => cpu}/idle-states.yaml    | 228 ++++++-
>  .../devicetree/bindings/riscv/cpus.yaml       |   6 +
>  MAINTAINERS                                   |  14 +
>  arch/riscv/Kconfig                            |   7 +
>  arch/riscv/Kconfig.socs                       |   3 +
>  arch/riscv/configs/defconfig                  |   2 +
>  arch/riscv/configs/rv32_defconfig             |   2 +
>  arch/riscv/include/asm/asm.h                  |  27 +
>  arch/riscv/include/asm/cpuidle.h              |  24 +
>  arch/riscv/include/asm/sbi.h                  |  27 +-
>  arch/riscv/include/asm/suspend.h              |  36 +
>  arch/riscv/kernel/Makefile                    |   2 +
>  arch/riscv/kernel/asm-offsets.c               |   3 +
>  arch/riscv/kernel/cpu_ops_sbi.c               |   2 +-
>  arch/riscv/kernel/head.S                      |  28 +-
>  arch/riscv/kernel/process.c                   |   3 +-
>  arch/riscv/kernel/suspend.c                   |  87 +++
>  arch/riscv/kernel/suspend_entry.S             | 124 ++++
>  arch/riscv/kvm/vcpu_sbi_hsm.c                 |   4 +-
>  drivers/cpuidle/Kconfig                       |   9 +
>  drivers/cpuidle/Kconfig.arm                   |   1 +
>  drivers/cpuidle/Kconfig.riscv                 |  15 +
>  drivers/cpuidle/Makefile                      |   5 +
>  drivers/cpuidle/cpuidle-psci-domain.c         | 138 +---
>  drivers/cpuidle/cpuidle-psci.h                |  15 +-
>  drivers/cpuidle/cpuidle-riscv-sbi.c           | 627 ++++++++++++++++++
>  drivers/cpuidle/dt_idle_genpd.c               | 178 +++++
>  drivers/cpuidle/dt_idle_genpd.h               |  50 ++
>  30 files changed, 1484 insertions(+), 187 deletions(-)
>  rename Documentation/devicetree/bindings/{arm => cpu}/idle-states.yaml (74%)
>  create mode 100644 arch/riscv/include/asm/cpuidle.h
>  create mode 100644 arch/riscv/include/asm/suspend.h
>  create mode 100644 arch/riscv/kernel/suspend.c
>  create mode 100644 arch/riscv/kernel/suspend_entry.S
>  create mode 100644 drivers/cpuidle/Kconfig.riscv
>  create mode 100644 drivers/cpuidle/cpuidle-riscv-sbi.c
>  create mode 100644 drivers/cpuidle/dt_idle_genpd.c
>  create mode 100644 drivers/cpuidle/dt_idle_genpd.h

Thanks, these are on for-next.
