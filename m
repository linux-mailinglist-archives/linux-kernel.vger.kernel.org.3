Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 321014B8A92
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 14:45:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234689AbiBPNp2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 08:45:28 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:33300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234073AbiBPNp0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 08:45:26 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FD751F6BB8
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 05:45:12 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id o34so1245360wms.1
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 05:45:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jrtc27.com; s=gmail.jrtc27.user;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=2N8+AAThXZWgbrtGOQW8JH3XEpNcu9l3U/WkErttgTU=;
        b=PHNQfRsGmCrhG36xlaazT+rGmGif3HkbHzTw78WOBTL//yn05YzCiqiSNZl5T3YsIe
         nuZhPnFzElqbKT7CMK4nCdVOi/8ziyzt+ppHw1Eu2oM0pEKNjH/dThZfX47j8gegQp3b
         mvr8xxWHTI8vcIc46pgfsSD2sKJHusLiUV2Xlagoe3csmQLkovHrPdvH8TKN6KyqSCF8
         ul06Y+IJHFF9cPJhsZzY86SJL8TOQo2PZJr6O1qwhxHStEnMdQRdPKaTIK3qvdyuJUGt
         /UUbpJy7QEOsZHGh6wtqPtek9OONKDaaorns6YWcveRoizc1NP8/v32S6wKqLT/HveB4
         W7yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=2N8+AAThXZWgbrtGOQW8JH3XEpNcu9l3U/WkErttgTU=;
        b=ALh4gNf24cjM26blAVC2WMvJLDNZtnHwMRgRMQzRzr8/jScV7WmaIw3qIz0PBnUINT
         k/l8yPwAn72Ygb2emlZIbc69JFyKvM3/HYMOB8cpMBkjoMxszDA6DOSWZWhAgbusg+F0
         KoqlG+VBP5xdm3E8wt7+PECmpzbWJhYJ3Ce9ID6sW676hY3QSw794VA0F3WI3j4Pm/62
         QMU6wQgu21s3xVCt2wOGyq7GQ7VoL/OAqXZSGisytMnYqJswfDf+bYQLmLA00ySA6CBe
         AX2tKy7WFGyW0WipvfUnMHu1qao4NIxzTJCScTrJ6rA36lBddZRcrhgZeltqt2o1IZ6B
         GuzA==
X-Gm-Message-State: AOAM530UTjFdE+6Lh2TJxX/peWySxOb3MiA8UxH1UaGWn8j2ejNN95zK
        rc719hz/nlxkCGCI6bjCe2SnbQ==
X-Google-Smtp-Source: ABdhPJwIf4rDT936fX6Rbm+ED5Of31QpbfykachwUxe71+vTdGkQdJe7A2MBa9muZ3+0adtrfpywJA==
X-Received: by 2002:a05:600c:1f16:b0:37b:c7f2:fbb4 with SMTP id bd22-20020a05600c1f1600b0037bc7f2fbb4mr1684124wmb.47.1645019110426;
        Wed, 16 Feb 2022 05:45:10 -0800 (PST)
Received: from smtpclient.apple (global-5-143.nat-2.net.cam.ac.uk. [131.111.5.143])
        by smtp.gmail.com with ESMTPSA id u25sm17707907wmm.15.2022.02.16.05.45.09
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 16 Feb 2022 05:45:09 -0800 (PST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 15.0 \(3693.40.0.1.81\))
Subject: Re: [PATCH v11 6/8] cpuidle: Add RISC-V SBI CPU idle driver
From:   Jessica Clarke <jrtc27@jrtc27.com>
In-Reply-To: <CAOnJCUKmwk=VbwCtkjS_rxArMWhVExeRp4QkkjDUmcvJ69Bqqg@mail.gmail.com>
Date:   Wed, 16 Feb 2022 13:45:09 +0000
Cc:     Anup Patel <apatel@ventanamicro.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>,
        Sandeep Tripathy <milun.tripathy@gmail.com>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        Liush <liush@allwinnertech.com>,
        Anup Patel <anup@brainfault.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        kvm-riscv@lists.infradead.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <E1C6F0F1-1FC2-43ED-AD26-6F2B8925BF04@jrtc27.com>
References: <20220210054947.170134-1-apatel@ventanamicro.com>
 <20220210054947.170134-7-apatel@ventanamicro.com>
 <CAOnJCUKmwk=VbwCtkjS_rxArMWhVExeRp4QkkjDUmcvJ69Bqqg@mail.gmail.com>
To:     Atish Patra <atishp@atishpatra.org>
X-Mailer: Apple Mail (2.3693.40.0.1.81)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16 Feb 2022, at 08:09, Atish Patra <atishp@atishpatra.org> wrote:
>=20
> On Wed, Feb 9, 2022 at 9:51 PM Anup Patel <apatel@ventanamicro.com> =
wrote:
>>=20
>> From: Anup Patel <anup.patel@wdc.com>
>>=20
>> The RISC-V SBI HSM extension provides HSM suspend call which can
>> be used by Linux RISC-V to enter platform specific low-power state.
>>=20
>> This patch adds a CPU idle driver based on RISC-V SBI calls which
>> will populate idle states from device tree and use SBI calls to
>> entry these idle states.
>>=20
>> Signed-off-by: Anup Patel <anup.patel@wdc.com>
>> Signed-off-by: Anup Patel <apatel@ventanamicro.com>
>> ---
>> MAINTAINERS                         |   7 +
>> drivers/cpuidle/Kconfig             |   5 +
>> drivers/cpuidle/Kconfig.riscv       |  15 +
>> drivers/cpuidle/Makefile            |   4 +
>> drivers/cpuidle/cpuidle-riscv-sbi.c | 627 =
++++++++++++++++++++++++++++
>> 5 files changed, 658 insertions(+)
>> create mode 100644 drivers/cpuidle/Kconfig.riscv
>> create mode 100644 drivers/cpuidle/cpuidle-riscv-sbi.c
>>=20
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 39ece23e8d93..2ff0055a26a7 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -5058,6 +5058,13 @@ S:       Supported
>> F:     drivers/cpuidle/dt_idle_genpd.c
>> F:     drivers/cpuidle/dt_idle_genpd.h
>>=20
>> +CPUIDLE DRIVER - RISC-V SBI
>> +M:     Anup Patel <anup@brainfault.org>
>> +L:     linux-pm@vger.kernel.org
>> +L:     linux-riscv@lists.infradead.org
>> +S:     Maintained
>> +F:     drivers/cpuidle/cpuidle-riscv-sbi.c
>> +
>> CRAMFS FILESYSTEM
>> M:     Nicolas Pitre <nico@fluxnic.net>
>> S:     Maintained
>> diff --git a/drivers/cpuidle/Kconfig b/drivers/cpuidle/Kconfig
>> index f1afe7ab6b54..ff71dd662880 100644
>> --- a/drivers/cpuidle/Kconfig
>> +++ b/drivers/cpuidle/Kconfig
>> @@ -66,6 +66,11 @@ depends on PPC
>> source "drivers/cpuidle/Kconfig.powerpc"
>> endmenu
>>=20
>> +menu "RISC-V CPU Idle Drivers"
>> +depends on RISCV
>> +source "drivers/cpuidle/Kconfig.riscv"
>> +endmenu
>> +
>> config HALTPOLL_CPUIDLE
>>        tristate "Halt poll cpuidle driver"
>>        depends on X86 && KVM_GUEST
>> diff --git a/drivers/cpuidle/Kconfig.riscv =
b/drivers/cpuidle/Kconfig.riscv
>> new file mode 100644
>> index 000000000000..78518c26af74
>> --- /dev/null
>> +++ b/drivers/cpuidle/Kconfig.riscv
>> @@ -0,0 +1,15 @@
>> +# SPDX-License-Identifier: GPL-2.0-only
>> +#
>> +# RISC-V CPU Idle drivers
>> +#
>> +
>> +config RISCV_SBI_CPUIDLE
>> +       bool "RISC-V SBI CPU idle Driver"
>> +       depends on RISCV_SBI
>> +       select DT_IDLE_STATES
>> +       select CPU_IDLE_MULTIPLE_DRIVERS
>> +       select DT_IDLE_GENPD if PM_GENERIC_DOMAINS_OF
>> +       help
>> +         Select this option to enable RISC-V SBI firmware based CPU =
idle
>> +         driver for RISC-V systems. This drivers also supports =
hierarchical
>> +         DT based layout of the idle state.
>> diff --git a/drivers/cpuidle/Makefile b/drivers/cpuidle/Makefile
>> index 11a26cef279f..d103342b7cfc 100644
>> --- a/drivers/cpuidle/Makefile
>> +++ b/drivers/cpuidle/Makefile
>> @@ -35,3 +35,7 @@ obj-$(CONFIG_MIPS_CPS_CPUIDLE)                +=3D =
cpuidle-cps.o
>> # POWERPC drivers
>> obj-$(CONFIG_PSERIES_CPUIDLE)          +=3D cpuidle-pseries.o
>> obj-$(CONFIG_POWERNV_CPUIDLE)          +=3D cpuidle-powernv.o
>> +
>> =
+#########################################################################=
######
>> +# RISC-V drivers
>> +obj-$(CONFIG_RISCV_SBI_CPUIDLE)                +=3D =
cpuidle-riscv-sbi.o
>> diff --git a/drivers/cpuidle/cpuidle-riscv-sbi.c =
b/drivers/cpuidle/cpuidle-riscv-sbi.c
>> new file mode 100644
>> index 000000000000..b459eda2cd37
>> --- /dev/null
>> +++ b/drivers/cpuidle/cpuidle-riscv-sbi.c
>> @@ -0,0 +1,627 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +/*
>> + * RISC-V SBI CPU idle driver.
>> + *
>> + * Copyright (c) 2021 Western Digital Corporation or its affiliates.
>> + * Copyright (c) 2022 Ventana Micro Systems Inc.
>> + */
>> +
>> +#define pr_fmt(fmt) "cpuidle-riscv-sbi: " fmt
>> +
>> +#include <linux/cpuidle.h>
>> +#include <linux/cpumask.h>
>> +#include <linux/cpu_pm.h>
>> +#include <linux/cpu_cooling.h>
>> +#include <linux/kernel.h>
>> +#include <linux/module.h>
>> +#include <linux/of.h>
>> +#include <linux/of_device.h>
>> +#include <linux/slab.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/pm_domain.h>
>> +#include <linux/pm_runtime.h>
>> +#include <asm/cpuidle.h>
>> +#include <asm/sbi.h>
>> +#include <asm/suspend.h>
>> +
>> +#include "dt_idle_states.h"
>> +#include "dt_idle_genpd.h"
>> +
>> +struct sbi_cpuidle_data {
>> +       u32 *states;
>> +       struct device *dev;
>> +};
>> +
>> +struct sbi_domain_state {
>> +       bool available;
>> +       u32 state;
>> +};
>> +
>> +static DEFINE_PER_CPU_READ_MOSTLY(struct sbi_cpuidle_data, =
sbi_cpuidle_data);
>> +static DEFINE_PER_CPU(struct sbi_domain_state, domain_state);
>> +static bool sbi_cpuidle_use_osi;
>> +static bool sbi_cpuidle_use_cpuhp;
>> +static bool sbi_cpuidle_pd_allow_domain_state;
>> +
>> +static inline void sbi_set_domain_state(u32 state)
>> +{
>> +       struct sbi_domain_state *data =3D =
this_cpu_ptr(&domain_state);
>> +
>> +       data->available =3D true;
>> +       data->state =3D state;
>> +}
>> +
>> +static inline u32 sbi_get_domain_state(void)
>> +{
>> +       struct sbi_domain_state *data =3D =
this_cpu_ptr(&domain_state);
>> +
>> +       return data->state;
>> +}
>> +
>> +static inline void sbi_clear_domain_state(void)
>> +{
>> +       struct sbi_domain_state *data =3D =
this_cpu_ptr(&domain_state);
>> +
>> +       data->available =3D false;
>> +}
>> +
>> +static inline bool sbi_is_domain_state_available(void)
>> +{
>> +       struct sbi_domain_state *data =3D =
this_cpu_ptr(&domain_state);
>> +
>> +       return data->available;
>> +}
>> +
>> +static int sbi_suspend_finisher(unsigned long suspend_type,
>> +                               unsigned long resume_addr,
>> +                               unsigned long opaque)
>> +{
>> +       struct sbiret ret;
>> +
>> +       ret =3D sbi_ecall(SBI_EXT_HSM, SBI_EXT_HSM_HART_SUSPEND,
>> +                       suspend_type, resume_addr, opaque, 0, 0, 0);
>> +
>> +       return (ret.error) ? sbi_err_map_linux_errno(ret.error) : 0;
>> +}
>> +
>> +static int sbi_suspend(u32 state)
>> +{
>> +       if (state & SBI_HSM_SUSP_NON_RET_BIT)
>> +               return cpu_suspend(state, sbi_suspend_finisher);
>> +       else
>> +               return sbi_suspend_finisher(state, 0, 0);
>> +}
>> +
>> +static int sbi_cpuidle_enter_state(struct cpuidle_device *dev,
>> +                                  struct cpuidle_driver *drv, int =
idx)
>> +{
>> +       u32 *states =3D __this_cpu_read(sbi_cpuidle_data.states);
>> +
>> +       return CPU_PM_CPU_IDLE_ENTER_PARAM(sbi_suspend, idx, =
states[idx]);
>> +}
>> +
>> +static int __sbi_enter_domain_idle_state(struct cpuidle_device *dev,
>> +                                         struct cpuidle_driver *drv, =
int idx,
>> +                                         bool s2idle)
>> +{
>> +       struct sbi_cpuidle_data *data =3D =
this_cpu_ptr(&sbi_cpuidle_data);
>> +       u32 *states =3D data->states;
>> +       struct device *pd_dev =3D data->dev;
>> +       u32 state;
>> +       int ret;
>> +
>> +       ret =3D cpu_pm_enter();
>> +       if (ret)
>> +               return -1;
>> +
>> +       /* Do runtime PM to manage a hierarchical CPU toplogy. */
>> +       rcu_irq_enter_irqson();
>> +       if (s2idle)
>> +               dev_pm_genpd_suspend(pd_dev);
>> +       else
>> +               pm_runtime_put_sync_suspend(pd_dev);
>> +       rcu_irq_exit_irqson();
>> +
>> +       if (sbi_is_domain_state_available())
>> +               state =3D sbi_get_domain_state();
>> +       else
>> +               state =3D states[idx];
>> +
>> +       ret =3D sbi_suspend(state) ? -1 : idx;
>> +
>> +       rcu_irq_enter_irqson();
>> +       if (s2idle)
>> +               dev_pm_genpd_resume(pd_dev);
>> +       else
>> +               pm_runtime_get_sync(pd_dev);
>> +       rcu_irq_exit_irqson();
>> +
>> +       cpu_pm_exit();
>> +
>> +       /* Clear the domain state to start fresh when back from idle. =
*/
>> +       sbi_clear_domain_state();
>> +       return ret;
>> +}
>> +
>> +static int sbi_enter_domain_idle_state(struct cpuidle_device *dev,
>> +                                      struct cpuidle_driver *drv, =
int idx)
>> +{
>> +       return __sbi_enter_domain_idle_state(dev, drv, idx, false);
>> +}
>> +
>> +static int sbi_enter_s2idle_domain_idle_state(struct cpuidle_device =
*dev,
>> +                                             struct cpuidle_driver =
*drv,
>> +                                             int idx)
>> +{
>> +       return __sbi_enter_domain_idle_state(dev, drv, idx, true);
>> +}
>> +
>> +static int sbi_cpuidle_cpuhp_up(unsigned int cpu)
>> +{
>> +       struct device *pd_dev =3D =
__this_cpu_read(sbi_cpuidle_data.dev);
>> +
>> +       if (pd_dev)
>> +               pm_runtime_get_sync(pd_dev);
>> +
>> +       return 0;
>> +}
>> +
>> +static int sbi_cpuidle_cpuhp_down(unsigned int cpu)
>> +{
>> +       struct device *pd_dev =3D =
__this_cpu_read(sbi_cpuidle_data.dev);
>> +
>> +       if (pd_dev) {
>> +               pm_runtime_put_sync(pd_dev);
>> +               /* Clear domain state to start fresh at next online. =
*/
>> +               sbi_clear_domain_state();
>> +       }
>> +
>> +       return 0;
>> +}
>> +
>> +static void sbi_idle_init_cpuhp(void)
>> +{
>> +       int err;
>> +
>> +       if (!sbi_cpuidle_use_cpuhp)
>> +               return;
>> +
>> +       err =3D cpuhp_setup_state_nocalls(CPUHP_AP_CPU_PM_STARTING,
>> +                                       "cpuidle/sbi:online",
>> +                                       sbi_cpuidle_cpuhp_up,
>> +                                       sbi_cpuidle_cpuhp_down);
>> +       if (err)
>> +               pr_warn("Failed %d while setup cpuhp state\n", err);
>> +}
>> +
>> +static const struct of_device_id sbi_cpuidle_state_match[] =3D {
>> +       { .compatible =3D "riscv,idle-state",
>> +         .data =3D sbi_cpuidle_enter_state },
>> +       { },
>> +};
>> +
>> +static bool sbi_suspend_state_is_valid(u32 state)
>> +{
>> +       if (state > SBI_HSM_SUSPEND_RET_DEFAULT &&
>> +           state < SBI_HSM_SUSPEND_RET_PLATFORM)
>> +               return false;
>> +       if (state > SBI_HSM_SUSPEND_NON_RET_DEFAULT &&
>> +           state < SBI_HSM_SUSPEND_NON_RET_PLATFORM)
>> +               return false;
>> +       return true;
>> +}
>> +
>> +static int sbi_dt_parse_state_node(struct device_node *np, u32 =
*state)
>> +{
>> +       int err =3D of_property_read_u32(np, =
"riscv,sbi-suspend-param", state);
>> +
>> +       if (err) {
>> +               pr_warn("%pOF missing riscv,sbi-suspend-param =
property\n", np);
>> +               return err;
>> +       }
>> +
>> +       if (!sbi_suspend_state_is_valid(*state)) {
>> +               pr_warn("Invalid SBI suspend state %#x\n", *state);
>> +               return -EINVAL;
>> +       }
>> +
>> +       return 0;
>> +}
>> +
>> +static int sbi_dt_cpu_init_topology(struct cpuidle_driver *drv,
>> +                                    struct sbi_cpuidle_data *data,
>> +                                    unsigned int state_count, int =
cpu)
>> +{
>> +       /* Currently limit the hierarchical topology to be used in =
OSI mode. */
>> +       if (!sbi_cpuidle_use_osi)
>> +               return 0;
>> +
>> +       data->dev =3D dt_idle_attach_cpu(cpu, "sbi");
>> +       if (IS_ERR_OR_NULL(data->dev))
>> +               return PTR_ERR_OR_ZERO(data->dev);
>> +
>> +       /*
>> +        * Using the deepest state for the CPU to trigger a potential =
selection
>> +        * of a shared state for the domain, assumes the domain =
states are all
>> +        * deeper states.
>> +        */
>> +       drv->states[state_count - 1].enter =3D =
sbi_enter_domain_idle_state;
>> +       drv->states[state_count - 1].enter_s2idle =3D
>> +                                       =
sbi_enter_s2idle_domain_idle_state;
>> +       sbi_cpuidle_use_cpuhp =3D true;
>> +
>> +       return 0;
>> +}
>> +
>> +static int sbi_cpuidle_dt_init_states(struct device *dev,
>> +                                       struct cpuidle_driver *drv,
>> +                                       unsigned int cpu,
>> +                                       unsigned int state_count)
>> +{
>> +       struct sbi_cpuidle_data *data =3D =
per_cpu_ptr(&sbi_cpuidle_data, cpu);
>> +       struct device_node *state_node;
>> +       struct device_node *cpu_node;
>> +       u32 *states;
>> +       int i, ret;
>> +
>> +       cpu_node =3D of_cpu_device_node_get(cpu);
>> +       if (!cpu_node)
>> +               return -ENODEV;
>> +
>> +       states =3D devm_kcalloc(dev, state_count, sizeof(*states), =
GFP_KERNEL);
>> +       if (!states) {
>> +               ret =3D -ENOMEM;
>> +               goto fail;
>> +       }
>> +
>> +       /* Parse SBI specific details from state DT nodes */
>> +       for (i =3D 1; i < state_count; i++) {
>> +               state_node =3D of_get_cpu_state_node(cpu_node, i - =
1);
>> +               if (!state_node)
>> +                       break;
>> +
>> +               ret =3D sbi_dt_parse_state_node(state_node, =
&states[i]);
>> +               of_node_put(state_node);
>> +
>> +               if (ret)
>> +                       return ret;
>> +
>> +               pr_debug("sbi-state %#x index %d\n", states[i], i);
>> +       }
>> +       if (i !=3D state_count) {
>> +               ret =3D -ENODEV;
>> +               goto fail;
>> +       }
>> +
>> +       /* Initialize optional data, used for the hierarchical =
topology. */
>> +       ret =3D sbi_dt_cpu_init_topology(drv, data, state_count, =
cpu);
>> +       if (ret < 0)
>> +               return ret;
>> +
>> +       /* Store states in the per-cpu struct. */
>> +       data->states =3D states;
>> +
>> +fail:
>> +       of_node_put(cpu_node);
>> +
>> +       return ret;
>> +}
>> +
>> +static void sbi_cpuidle_deinit_cpu(int cpu)
>> +{
>> +       struct sbi_cpuidle_data *data =3D =
per_cpu_ptr(&sbi_cpuidle_data, cpu);
>> +
>> +       dt_idle_detach_cpu(data->dev);
>> +       sbi_cpuidle_use_cpuhp =3D false;
>> +}
>> +
>> +static int sbi_cpuidle_init_cpu(struct device *dev, int cpu)
>> +{
>> +       struct cpuidle_driver *drv;
>> +       unsigned int state_count =3D 0;
>> +       int ret =3D 0;
>> +
>> +       drv =3D devm_kzalloc(dev, sizeof(*drv), GFP_KERNEL);
>> +       if (!drv)
>> +               return -ENOMEM;
>> +
>> +       drv->name =3D "sbi_cpuidle";
>> +       drv->owner =3D THIS_MODULE;
>> +       drv->cpumask =3D (struct cpumask *)cpumask_of(cpu);
>> +
>> +       /* RISC-V architectural WFI to be represented as state index =
0. */
>> +       drv->states[0].enter =3D sbi_cpuidle_enter_state;
>> +       drv->states[0].exit_latency =3D 1;
>> +       drv->states[0].target_residency =3D 1;
>> +       drv->states[0].power_usage =3D UINT_MAX;
>> +       strcpy(drv->states[0].name, "WFI");
>> +       strcpy(drv->states[0].desc, "RISC-V WFI");
>> +
>> +       /*
>> +        * If no DT idle states are detected (ret =3D=3D 0) let the =
driver
>> +        * initialization fail accordingly since there is no reason =
to
>> +        * initialize the idle driver if only wfi is supported, the
>> +        * default archictectural back-end already executes wfi
>> +        * on idle entry.
>> +        */
>> +       ret =3D dt_init_idle_driver(drv, sbi_cpuidle_state_match, 1);
>> +       if (ret <=3D 0) {
>> +               pr_debug("HART%ld: failed to parse DT idle states\n",
>> +                        cpuid_to_hartid_map(cpu));
>> +               return ret ? : -ENODEV;
>> +       }
>> +       state_count =3D ret + 1; /* Include WFI state as well */
>> +
>> +       /* Initialize idle states from DT. */
>> +       ret =3D sbi_cpuidle_dt_init_states(dev, drv, cpu, =
state_count);
>> +       if (ret) {
>> +               pr_err("HART%ld: failed to init idle states\n",
>> +                      cpuid_to_hartid_map(cpu));
>> +               return ret;
>> +       }
>> +
>> +       ret =3D cpuidle_register(drv, NULL);
>> +       if (ret)
>> +               goto deinit;
>> +
>> +       cpuidle_cooling_register(drv);
>> +
>> +       return 0;
>> +deinit:
>> +       sbi_cpuidle_deinit_cpu(cpu);
>> +       return ret;
>> +}
>> +
>> +static void sbi_cpuidle_domain_sync_state(struct device *dev)
>> +{
>> +       /*
>> +        * All devices have now been attached/probed to the PM domain
>> +        * topology, hence it's fine to allow domain states to be =
picked.
>> +        */
>> +       sbi_cpuidle_pd_allow_domain_state =3D true;
>> +}
>> +
>> +#ifdef CONFIG_DT_IDLE_GENPD
>> +
>> +static int sbi_cpuidle_pd_power_off(struct generic_pm_domain *pd)
>> +{
>> +       struct genpd_power_state *state =3D =
&pd->states[pd->state_idx];
>> +       u32 *pd_state;
>> +
>> +       if (!state->data)
>> +               return 0;
>> +
>> +       if (!sbi_cpuidle_pd_allow_domain_state)
>> +               return -EBUSY;
>> +
>> +       /* OSI mode is enabled, set the corresponding domain state. =
*/
>> +       pd_state =3D state->data;
>> +       sbi_set_domain_state(*pd_state);
>> +
>> +       return 0;
>> +}
>> +
>> +struct sbi_pd_provider {
>> +       struct list_head link;
>> +       struct device_node *node;
>> +};
>> +
>> +static LIST_HEAD(sbi_pd_providers);
>> +
>> +static int sbi_pd_init(struct device_node *np)
>> +{
>> +       struct generic_pm_domain *pd;
>> +       struct sbi_pd_provider *pd_provider;
>> +       struct dev_power_governor *pd_gov;
>> +       int ret =3D -ENOMEM, state_count =3D 0;
>> +
>> +       pd =3D dt_idle_pd_alloc(np, sbi_dt_parse_state_node);
>> +       if (!pd)
>> +               goto out;
>> +
>> +       pd_provider =3D kzalloc(sizeof(*pd_provider), GFP_KERNEL);
>> +       if (!pd_provider)
>> +               goto free_pd;
>> +
>> +       pd->flags |=3D GENPD_FLAG_IRQ_SAFE | GENPD_FLAG_CPU_DOMAIN;
>> +
>> +       /* Allow power off when OSI is available. */
>> +       if (sbi_cpuidle_use_osi)
>> +               pd->power_off =3D sbi_cpuidle_pd_power_off;
>> +       else
>> +               pd->flags |=3D GENPD_FLAG_ALWAYS_ON;
>> +
>> +       /* Use governor for CPU PM domains if it has some states to =
manage. */
>> +       pd_gov =3D state_count > 0 ? &pm_domain_cpu_gov : NULL;
>> +
>> +       ret =3D pm_genpd_init(pd, pd_gov, false);
>> +       if (ret)
>> +               goto free_pd_prov;
>> +
>> +       ret =3D of_genpd_add_provider_simple(np, pd);
>> +       if (ret)
>> +               goto remove_pd;
>> +
>> +       pd_provider->node =3D of_node_get(np);
>> +       list_add(&pd_provider->link, &sbi_pd_providers);
>> +
>> +       pr_debug("init PM domain %s\n", pd->name);
>> +       return 0;
>> +
>> +remove_pd:
>> +       pm_genpd_remove(pd);
>> +free_pd_prov:
>> +       kfree(pd_provider);
>> +free_pd:
>> +       dt_idle_pd_free(pd);
>> +out:
>> +       pr_err("failed to init PM domain ret=3D%d %pOF\n", ret, np);
>> +       return ret;
>> +}
>> +
>> +static void sbi_pd_remove(void)
>> +{
>> +       struct sbi_pd_provider *pd_provider, *it;
>> +       struct generic_pm_domain *genpd;
>> +
>> +       list_for_each_entry_safe(pd_provider, it, &sbi_pd_providers, =
link) {
>> +               of_genpd_del_provider(pd_provider->node);
>> +
>> +               genpd =3D of_genpd_remove_last(pd_provider->node);
>> +               if (!IS_ERR(genpd))
>> +                       kfree(genpd);
>> +
>> +               of_node_put(pd_provider->node);
>> +               list_del(&pd_provider->link);
>> +               kfree(pd_provider);
>> +       }
>> +}
>> +
>> +static int sbi_genpd_probe(struct device_node *np)
>> +{
>> +       struct device_node *node;
>> +       int ret =3D 0, pd_count =3D 0;
>> +
>> +       if (!np)
>> +               return -ENODEV;
>> +
>> +       /*
>> +        * Parse child nodes for the "#power-domain-cells" property =
and
>> +        * initialize a genpd/genpd-of-provider pair when it's found.
>> +        */
>> +       for_each_child_of_node(np, node) {
>> +               if (!of_find_property(node, "#power-domain-cells", =
NULL))
>> +                       continue;
>> +
>> +               ret =3D sbi_pd_init(node);
>> +               if (ret)
>> +                       goto put_node;
>> +
>> +               pd_count++;
>> +       }
>> +
>> +       /* Bail out if not using the hierarchical CPU topology. */
>> +       if (!pd_count)
>> +               goto no_pd;
>> +
>> +       /* Link genpd masters/subdomains to model the CPU topology. =
*/
>> +       ret =3D dt_idle_pd_init_topology(np);
>> +       if (ret)
>> +               goto remove_pd;
>> +
>> +       return 0;
>> +
>> +put_node:
>> +       of_node_put(node);
>> +remove_pd:
>> +       sbi_pd_remove();
>> +       pr_err("failed to create CPU PM domains ret=3D%d\n", ret);
>> +no_pd:
>> +       return ret;
>> +}
>> +
>> +#else
>> +
>> +static inline int sbi_genpd_probe(struct device_node *np)
>> +{
>> +       return 0;
>> +}
>> +
>> +#endif
>> +
>> +static int sbi_cpuidle_probe(struct platform_device *pdev)
>> +{
>> +       int cpu, ret;
>> +       struct cpuidle_driver *drv;
>> +       struct cpuidle_device *dev;
>> +       struct device_node *np, *pds_node;
>> +
>> +       /* Detect OSI support based on CPU DT nodes */
>> +       sbi_cpuidle_use_osi =3D true;
>> +       for_each_possible_cpu(cpu) {
>> +               np =3D of_cpu_device_node_get(cpu);
>> +               if (np &&
>> +                   of_find_property(np, "power-domains", NULL) &&
>> +                   of_find_property(np, "power-domain-names", NULL)) =
{
>> +                       continue;
>> +               } else {
>> +                       sbi_cpuidle_use_osi =3D false;
>> +                       break;
>> +               }
>> +       }
>> +
>> +       /* Populate generic power domains from DT nodes */
>> +       pds_node =3D of_find_node_by_path("/cpus/power-domains");
>> +       if (pds_node) {
>> +               ret =3D sbi_genpd_probe(pds_node);
>> +               of_node_put(pds_node);
>> +               if (ret)
>> +                       return ret;
>> +       }
>> +
>> +       /* Initialize CPU idle driver for each CPU */
>> +       for_each_possible_cpu(cpu) {
>> +               ret =3D sbi_cpuidle_init_cpu(&pdev->dev, cpu);
>> +               if (ret) {
>> +                       pr_debug("HART%ld: idle driver init =
failed\n",
>> +                                cpuid_to_hartid_map(cpu));
>> +                       goto out_fail;
>> +               }
>> +       }
>> +
>> +       /* Setup CPU hotplut notifiers */
>> +       sbi_idle_init_cpuhp();
>> +
>> +       pr_info("idle driver registered for all CPUs\n");
>> +
>> +       return 0;
>> +
>> +out_fail:
>> +       while (--cpu >=3D 0) {
>> +               dev =3D per_cpu(cpuidle_devices, cpu);
>> +               drv =3D cpuidle_get_cpu_driver(dev);
>> +               cpuidle_unregister(drv);
>> +               sbi_cpuidle_deinit_cpu(cpu);
>> +       }
>> +
>> +       return ret;
>> +}
>> +
>> +static struct platform_driver sbi_cpuidle_driver =3D {
>> +       .probe =3D sbi_cpuidle_probe,
>> +       .driver =3D {
>> +               .name =3D "sbi-cpuidle",
>> +               .sync_state =3D sbi_cpuidle_domain_sync_state,
>> +       },
>> +};
>> +
>> +static int __init sbi_cpuidle_init(void)
>> +{
>> +       int ret;
>> +       struct platform_device *pdev;
>> +
>> +       /*
>> +        * The SBI HSM suspend function is only available when:
>> +        * 1) SBI version is 0.3 or higher
>> +        * 2) SBI HSM extension is available
>> +        */
>> +       if ((sbi_spec_version < sbi_mk_version(0, 3)) ||
>> +           sbi_probe_extension(SBI_EXT_HSM) <=3D 0) {
>> +               pr_info("HSM suspend not available\n");
>> +               return 0;
>> +       }
>> +
>> +       ret =3D platform_driver_register(&sbi_cpuidle_driver);
>> +       if (ret)
>> +               return ret;
>> +
>> +       pdev =3D platform_device_register_simple("sbi-cpuidle",
>> +                                               -1, NULL, 0);
>> +       if (IS_ERR(pdev)) {
>> +               platform_driver_unregister(&sbi_cpuidle_driver);
>> +               return PTR_ERR(pdev);
>> +       }
>> +
>> +       return 0;
>> +}
>> +device_initcall(sbi_cpuidle_init);
>> --
>> 2.25.1
>>=20
>=20
> For the SBI part,
> Acked-by: Atish Patra <atishp@rivosinc.com>
>=20
> FYI..
> SBI HSM suspend was included in SBI v0.3. The current version of the
> SBI specification (v1.0-rc2)
> is already frozen as per the RVI guidelines. All the comments received
> during the public review period
> have been addressed as well.

Yet not all comments from *before* the public review period.

Jess

