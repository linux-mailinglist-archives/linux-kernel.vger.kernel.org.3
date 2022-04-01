Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FCCE4EF998
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 20:13:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347281AbiDASPh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Apr 2022 14:15:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345474AbiDASPe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 14:15:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F2CD160470;
        Fri,  1 Apr 2022 11:13:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9F91360C7C;
        Fri,  1 Apr 2022 18:13:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C2DEC34112;
        Fri,  1 Apr 2022 18:13:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648836824;
        bh=uoOd6CO2s8wnGOmWFjDw4Oy54lOS4D8lxWnZseuhhQk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=VF0zRjYoc+rvxniRdQ5zldtCBf+Hfwx7skowS/pb3bZJ/5bgbZ6KbBhlkAIphjOzM
         KuP0KqHZ38g/OoAoOplBgl6CEGS4KQLkUTMYs7ccVK1vjibu+bC/7ABqCW94Y3xnev
         oc72HTRkDQPci/kZZkrMs5Xl9u7TyXAOPiLJs6hLjAfhMQ5B1Rw5HP0GvPNAIf8cwn
         yt0dN8851li8FfoeIEryDXiK3Co6s47/mo95UXRSm/YU3n9N/gn0Pkx8F0qcwRt9Ol
         NleTc1R5JeACuKcQwJOhWUPXwTeLR3kF1hKf85KANjJo4+jcRxVXVWWhJczOQJg8vx
         bjXeB+7Uc9yIQ==
Received: by mail-il1-f175.google.com with SMTP id 8so2534419ilq.4;
        Fri, 01 Apr 2022 11:13:44 -0700 (PDT)
X-Gm-Message-State: AOAM531KffI8msNfE4vKuIq0a+C6wkAxoEcthz2YJH4ubKzg7VoqBiiv
        MOFhlMNiG5xeiBg6KAFWlgo5Tf4Qs/5Va8UVxQ==
X-Google-Smtp-Source: ABdhPJxH/7RXtrmtXxGbu7SQhQXm0osyvvJV67d2HyO3RNnqSa5dtuQj7CsDlGT7RYcOrzRvz+yysf0tDaubJ7OIxOs=
X-Received: by 2002:a92:cd8c:0:b0:2c7:e86b:5139 with SMTP id
 r12-20020a92cd8c000000b002c7e86b5139mr535860ilb.144.1648836823077; Fri, 01
 Apr 2022 11:13:43 -0700 (PDT)
MIME-Version: 1.0
References: <20220210054947.170134-1-apatel@ventanamicro.com> <mhng-ed3c61a2-45a5-4cc4-b1ec-26e25f92c0a3@palmer-ri-x1c9>
In-Reply-To: <mhng-ed3c61a2-45a5-4cc4-b1ec-26e25f92c0a3@palmer-ri-x1c9>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Fri, 1 Apr 2022 13:13:32 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJm7kz1LTrTBMB3rd-K48e2584v6Nn3LwmnLzH8rk_D2w@mail.gmail.com>
Message-ID: <CAL_JsqJm7kz1LTrTBMB3rd-K48e2584v6Nn3LwmnLzH8rk_D2w@mail.gmail.com>
Subject: Re: [PATCH v11 0/8] RISC-V CPU Idle Support
To:     Palmer Dabbelt <palmer@dabbelt.com>, apatel@ventanamicro.com
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Pavel Machek <pavel@ucw.cz>,
        Sandeep Tripathy <milun.tripathy@gmail.com>,
        Atish Patra <atishp@atishpatra.org>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        Liush <liush@allwinnertech.com>,
        Anup Patel <anup@brainfault.org>, devicetree@vger.kernel.org,
        linux-riscv <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        kvm-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 30, 2022 at 7:16 PM Palmer Dabbelt <palmer@dabbelt.com> wrote:
>
> On Wed, 09 Feb 2022 21:49:39 PST (-0800), apatel@ventanamicro.com wrote:
> > From: Anup Patel <anup.patel@wdc.com>
> >
> > This series adds RISC-V CPU Idle support using SBI HSM suspend function.
> > The RISC-V SBI CPU idle driver added by this series is highly inspired
> > from the ARM PSCI CPU idle driver.
> >
> > At high-level, this series includes the following changes:
> > 1) Preparatory arch/riscv patches (Patches 1 to 3)
> > 2) Defines for RISC-V SBI HSM suspend (Patch 4)
> > 3) Preparatory patch to share code between RISC-V SBI CPU idle driver
> >    and ARM PSCI CPU idle driver (Patch 5)
> > 4) RISC-V SBI CPU idle driver and related DT bindings (Patches 6 to 7)
> >
> > These patches can be found in riscv_sbi_hsm_suspend_v11 branch of
> > https://github.com/avpatel/linux.git
> >
> > Special thanks Sandeep Tripathy for providing early feeback on SBI HSM
> > support in all above projects (RISC-V SBI specification, OpenSBI, and
> > Linux RISC-V).
> >
> > Changes since v10:
> >  - Rebased on Linux-5.17-rc3
> >  - Typo fix in commit description of PATCH6
> >
> > Changes since v9:
> >  - Rebased on Linux-5.17-rc1
> >
> > Changes since v8:
> >  - Rebased on Linux-5.15-rc5
> >  - Fixed DT schema check errors in PATCH7
> >
> > Changes since v7:
> >  - Rebased on Linux-5.15-rc3
> >  - Renamed cpuidle-sbi.c to cpuidle-riscv-sbi.c in PATCH6
> >
> > Changes since v6:
> >  - Fixed error reported by "make DT_CHECKER_FLAGS=-m dt_binding_check"
> >
> > Changes since v5:
> >  - Rebased on Linux-5.13-rc5
> >  - Removed unnecessary exports from PATCH5
> >  - Removed stray ";" from PATCH5
> >  - Moved sbi_cpuidle_pd_power_off() under "#ifdef CONFIG_DT_IDLE_GENPD"
> >    in PATCH6
> >
> > Changes since v4:
> >  - Rebased on Linux-5.13-rc2
> >  - Renamed all dt_idle_genpd functions to have "dt_idle_" prefix
> >  - Added MAINTAINERS file entry for dt_idle_genpd
> >
> > Changes since v3:
> >  - Rebased on Linux-5.13-rc2
> >  - Fixed __cpu_resume_enter() which was broken due to XIP kernel support
> >  - Removed "struct dt_idle_genpd_ops" abstraction which simplifies code
> >    sharing between ARM PSCI and RISC-V SBI drivers in PATCH5
> >
> > Changes since v2:
> >  - Rebased on Linux-5.12-rc3
> >  - Updated PATCH7 to add common DT bindings for both ARM and RISC-V
> >    idle states
> >  - Added "additionalProperties = false" for both idle-states node and
> >    child nodes in PATCH7
> >
> > Changes since v1:
> >  - Fixex minor typo in PATCH1
> >  - Use just "idle-states" as DT node name for CPU idle states
> >  - Added documentation for "cpu-idle-states" DT property in
> >    devicetree/bindings/riscv/cpus.yaml
> >  - Added documentation for "riscv,sbi-suspend-param" DT property in
> >    devicetree/bindings/riscv/idle-states.yaml
> >
> > Anup Patel (8):
> >   RISC-V: Enable CPU_IDLE drivers
> >   RISC-V: Rename relocate() and make it global
> >   RISC-V: Add arch functions for non-retentive suspend entry/exit
> >   RISC-V: Add SBI HSM suspend related defines
> >   cpuidle: Factor-out power domain related code from PSCI domain driver
> >   cpuidle: Add RISC-V SBI CPU idle driver
> >   dt-bindings: Add common bindings for ARM and RISC-V idle states
> >   RISC-V: Enable RISC-V SBI CPU Idle driver for QEMU virt machine
> >
> >  .../bindings/arm/msm/qcom,idle-state.txt      |   2 +-
> >  .../devicetree/bindings/arm/psci.yaml         |   2 +-
> >  .../bindings/{arm => cpu}/idle-states.yaml    | 228 ++++++-
> >  .../devicetree/bindings/riscv/cpus.yaml       |   6 +
> >  MAINTAINERS                                   |  14 +
> >  arch/riscv/Kconfig                            |   7 +
> >  arch/riscv/Kconfig.socs                       |   3 +
> >  arch/riscv/configs/defconfig                  |   2 +
> >  arch/riscv/configs/rv32_defconfig             |   2 +
> >  arch/riscv/include/asm/asm.h                  |  27 +
> >  arch/riscv/include/asm/cpuidle.h              |  24 +
> >  arch/riscv/include/asm/sbi.h                  |  27 +-
> >  arch/riscv/include/asm/suspend.h              |  36 +
> >  arch/riscv/kernel/Makefile                    |   2 +
> >  arch/riscv/kernel/asm-offsets.c               |   3 +
> >  arch/riscv/kernel/cpu_ops_sbi.c               |   2 +-
> >  arch/riscv/kernel/head.S                      |  28 +-
> >  arch/riscv/kernel/process.c                   |   3 +-
> >  arch/riscv/kernel/suspend.c                   |  87 +++
> >  arch/riscv/kernel/suspend_entry.S             | 124 ++++
> >  arch/riscv/kvm/vcpu_sbi_hsm.c                 |   4 +-
> >  drivers/cpuidle/Kconfig                       |   9 +
> >  drivers/cpuidle/Kconfig.arm                   |   1 +
> >  drivers/cpuidle/Kconfig.riscv                 |  15 +
> >  drivers/cpuidle/Makefile                      |   5 +
> >  drivers/cpuidle/cpuidle-psci-domain.c         | 138 +---
> >  drivers/cpuidle/cpuidle-psci.h                |  15 +-
> >  drivers/cpuidle/cpuidle-riscv-sbi.c           | 627 ++++++++++++++++++
> >  drivers/cpuidle/dt_idle_genpd.c               | 178 +++++
> >  drivers/cpuidle/dt_idle_genpd.h               |  50 ++
> >  30 files changed, 1484 insertions(+), 187 deletions(-)
> >  rename Documentation/devicetree/bindings/{arm => cpu}/idle-states.yaml (74%)
> >  create mode 100644 arch/riscv/include/asm/cpuidle.h
> >  create mode 100644 arch/riscv/include/asm/suspend.h
> >  create mode 100644 arch/riscv/kernel/suspend.c
> >  create mode 100644 arch/riscv/kernel/suspend_entry.S
> >  create mode 100644 drivers/cpuidle/Kconfig.riscv
> >  create mode 100644 drivers/cpuidle/cpuidle-riscv-sbi.c
> >  create mode 100644 drivers/cpuidle/dt_idle_genpd.c
> >  create mode 100644 drivers/cpuidle/dt_idle_genpd.h
>
> Thanks, these are on for-next.

For 5.18? You are not supposed to put new material into linux-next
during the merge window.

In any case, this now cause warnings on 'cpu-idle-states':

/builds/robherring/linux-dt/Documentation/devicetree/bindings/cpu/idle-states.example.dtb:
cpu@0: cpu-idle-states:0: [1, 2, 3, 4] is too long
From schema: /builds/robherring/linux-dt/Documentation/devicetree/bindings/arm/cpus.yaml
/builds/robherring/linux-dt/Documentation/devicetree/bindings/cpu/idle-states.example.dtb:
cpu@1: cpu-idle-states:0: [1, 2, 3, 4] is too long
From schema: /builds/robherring/linux-dt/Documentation/devicetree/bindings/arm/cpus.yaml
/builds/robherring/linux-dt/Documentation/devicetree/bindings/cpu/idle-states.example.dtb:
cpu@100: cpu-idle-states:0: [1, 2, 3, 4] is too long
From schema: /builds/robherring/linux-dt/Documentation/devicetree/bindings/arm/cpus.yaml
/builds/robherring/linux-dt/Documentation/devicetree/bindings/cpu/idle-states.example.dtb:
cpu@101: cpu-idle-states:0: [1, 2, 3, 4] is too long
From schema: /builds/robherring/linux-dt/Documentation/devicetree/bindings/arm/cpus.yaml

See commit 39bd2b6a3783 ("dt-bindings: Improve phandle-array schemas")
for how to fix.

Rob
