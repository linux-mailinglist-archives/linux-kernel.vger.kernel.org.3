Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAEE059ADE1
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Aug 2022 14:21:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241900AbiHTMVB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Aug 2022 08:21:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345238AbiHTMU7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Aug 2022 08:20:59 -0400
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B45597C194;
        Sat, 20 Aug 2022 05:20:57 -0700 (PDT)
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-3376851fe13so150291507b3.6;
        Sat, 20 Aug 2022 05:20:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=Qd3b1djKFtVn9Y67UYq0L15YeD0LNq0Z/gjNRn27B8I=;
        b=TKg82ADIA+ppabe3GS5dXyQ/1F7XrLqmDkPJ0jNByQK8/ym6Cg7zgrK+dG0vazyXGu
         wUzEqgrpqS1hTBrq7efxzivfWgzqEDRQ4TYWyMtmrlbLZcmoD/QULyf1UspECt+K7JP9
         jp18L4ger6ZEN3kKkhRKBAPxFY2VHFY/LIL1sQKMUXTgCvqtelndnDH3q8MFI+rrtKEa
         TrVSF9qB+2jB9BqJ3Bg9NzfY/ataRg/HwKoKXsDus7eAP6wwGwi5WiTetjHC3ODLiJTH
         lhTuyKjdEVkcj2NKTneuT2x0m3UAZH4jKOlzAiCboOdbtRw5OaqRNeU6V9YktkVdnLls
         L+AQ==
X-Gm-Message-State: ACgBeo363dF4GgwTIqeq7ohVxlfdY+sR18cYbu3+8rft2hExLVXRMg0+
        Mi9k6puhlofL/Xsw0WaMZ6qmAItNA4NlxFRyU8ulvUUe
X-Google-Smtp-Source: AA6agR4DmQaiur4npa6kKa4E6+XIw7FwRyLXK/rmmfCl7pL0N4kd1626K58VStwrCbWqW0t/QFdd/B2dLvu5BAYftS4=
X-Received: by 2002:a25:b749:0:b0:68f:171f:96bd with SMTP id
 e9-20020a25b749000000b0068f171f96bdmr11765148ybm.137.1660998056910; Sat, 20
 Aug 2022 05:20:56 -0700 (PDT)
MIME-Version: 1.0
References: <TYWP286MB2601965DDE4D251807F70415B1AF9@TYWP286MB2601.JPNP286.PROD.OUTLOOK.COM>
 <6e61d429-9020-53f3-458e-bb265d47b8f4@arm.com>
In-Reply-To: <6e61d429-9020-53f3-458e-bb265d47b8f4@arm.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Sat, 20 Aug 2022 14:20:45 +0200
Message-ID: <CAJZ5v0hzYbZR0p_O3u1d6BA05Zmkm-QvB+mjSCub6MMc6hqWJQ@mail.gmail.com>
Subject: Re: Bug: Re: [PATCH v3] ACPI: Split out processor thermal register
 from ACPI PSS
To:     Jeremy Linton <jeremy.linton@arm.com>
Cc:     Riwen Lu <luriwen@hotmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        "Zhang, Rui" <rui.zhang@intel.com>,
        Robert Moore <robert.moore@intel.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:ACPI COMPONENT ARCHITECTURE (ACPICA)" <devel@acpica.org>,
        Punit Agrawal <punit.agrawal@bytedance.com>,
        Riwen Lu <luriwen@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 18, 2022 at 10:23 PM Jeremy Linton <jeremy.linton@arm.com> wrote:
>
> Hi,
>
> On 6/16/22 21:51, Riwen Lu wrote:
> > From: Riwen Lu <luriwen@kylinos.cn>
> >
> > Commit 239708a3af44 ("ACPI: Split out ACPI PSS from ACPI Processor
> > driver"), moves processor thermal registration to acpi_pss_perf_init(),
> > which doesn't get executed if ACPI_CPU_FREQ_PSS is not enabled.
> >
> > As ARM64 supports P-states using CPPC, it should be possible to also
> > support processor passive cooling even if PSS is not enabled. Split
> > out the processor thermal cooling register from ACPI PSS to support
> > this, and move it into a separate function in processor_thermal.c.
>
> It appears this commit 7fdc74da940d ACPI: processor: Split out thermal
> initialization from ACPI PSS

I've just reverted the above commit, thanks for the report!

> Is causing the following:
>     41.341659] ------------[ cut here ]------------
> [   41.346280] freq_qos_remove_request() called for unknown object
> [   41.352251] WARNING: CPU: 3 PID: 1089 at kernel/power/qos.c:597
> freq_qos_remove_request+0xa4/0xc4
> [   41.361152] Modules linked in: nf_nat_tftp nft_objref
> nf_conntrack_tftp nft_fib_inet nft_fib_ipv4 nft_fib_ipv6 nft_fib
> nft_reject_inet nf_reject_ipv4 nf_reject_ipv6 nft_reject nft_ct
> nft_chain_nat nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 ip_set
> nf_tables nfnetlink qrtr bnep sunrpc vfat fat btsdio brcmfmac hci_uart
> btqca cfg80211 bs
> [   41.413245] CPU: 3 PID: 1089 Comm: rmmod Not tainted 6.0.0-rc1MINI+ #237
> [   41.419951] Hardware name: Raspberry Pi Foundation Raspberry Pi 4
> Model B/Raspberry Pi 4 Model B, BIOS EDK2-DEV 07/18/2022
> [   41.430990] pstate: 40400005 (nZcv daif +PAN -UAO -TCO -DIT -SSBS
> BTYPE=--)
> [   41.437955] pc : freq_qos_remove_request+0xa4/0xc4
> [   41.442752] lr : freq_qos_remove_request+0xa4/0xc4
> [   41.447550] sp : ffff80000a4bbb60
> [   41.450862] x29: ffff80000a4bbb60 x28: ffff07858798a1c0 x27:
> 0000000000000000
> [   41.458012] x26: 0000000000000000 x25: ffffdf6ade80f850 x24:
> ffff07858b07d200
> [   41.465158] x23: ffffdf6ade812cb0 x22: ffff07858b07d000 x21:
> ffffdf6ade80f850
> [   41.472303] x20: ffffdf6ade26b998 x19: ffff0785809ba5a8 x18:
> ffffffffffffffff
> [   41.479447] x17: 0000000000000000 x16: ffffdf6adcc25320 x15:
> 0000000000000006
> [   41.486592] x14: 0000000000000000 x13: 7463656a626f206e x12:
> 776f6e6b6e752072
> [   41.493736] x11: 00000000ffffdfff x10: ffffdf6ade8fd520 x9 :
> ffffdf6adcae53ac
> [   41.500881] x8 : 000000000002ffe8 x7 : c0000000ffffdfff x6 :
> 0000000000000001
> [   41.508026] x5 : 0000000000000000 x4 : ffff07863b7ac450 x3 :
> ffff07863b7b8bb0
> [   41.515170] x2 : 0000000000000001 x1 : ffff281b5d54f000 x0 :
> 0000000000000033
> [   41.522315] Call trace:
> [   41.524759]  freq_qos_remove_request+0xa4/0xc4
> [   41.529210]  acpi_thermal_cpufreq_exit+0x90/0xb0
> [   41.533834]  acpi_processor_notifier+0x74/0x90
> [   41.538281]  blocking_notifier_call_chain+0x78/0xb0
> [   41.543161]  cpufreq_policy_free+0x154/0x1e0
> [   41.547438]  cpufreq_remove_dev+0xc0/0x10c
> [   41.551538]  subsys_interface_unregister+0xf0/0xfc
> [   41.556335]  cpufreq_unregister_driver+0x54/0x120
> [   41.561043]  cppc_cpufreq_exit+0x28/0xd2c [cppc_cpufreq]
> [   41.566370]  __do_sys_delete_module.constprop.0+0x150/0x2bc
> [   41.571947]  __arm64_sys_delete_module+0x20/0x30
> [   41.576567]  invoke_syscall+0x50/0x120
> [   41.580318]  el0_svc_common.constprop.0+0x4c/0xf4
> [   41.585023]  do_el0_svc+0x38/0x4c
> [   41.588338]  el0_svc+0x34/0xdc
> [   41.591394]  el0t_64_sync_handler+0x11c/0x150
> [   41.595752]  el0t_64_sync+0x190/0x194
> [   41.599416] ---[ end trace 0000000000000000 ]---
>
> When the cppc_cpufreq driver is rmmod'ed from a running machine that has
> both CPPC and a thermal zone. I reverted and bisected it, and in both
> cases the splat above goes away.
>
>
> Thanks,
>
> >
> > Signed-off-by: Riwen Lu <luriwen@kylinos.cn>
> >
> > ---
> > v1 -> v2:
> >   - Reword the commit message.
> >   - Update the signature of acpi_pss_perf_init() to void, and remove the
> >     acpi_device parameter.
> >   - Move the processor thermal register/remove into a separate function in
> >     processor_thermal.c.
> >
> > v2 -> v3:
> >   - Remove the "pr" NULL check in processor thermal init/exit fuction.
> >   - Pass the acpi_device into processor thermal init/exit, and remove the
> >     convert in it.
> > ---
> >   drivers/acpi/Kconfig             |  2 +-
> >   drivers/acpi/Makefile            |  5 +--
> >   drivers/acpi/processor_driver.c  | 72 ++++----------------------------
> >   drivers/acpi/processor_thermal.c | 54 ++++++++++++++++++++++++
> >   include/acpi/processor.h         |  8 +++-
> >   5 files changed, 71 insertions(+), 70 deletions(-)
> >
> > diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
> > index 1e34f846508f..2457ade3f82d 100644
> > --- a/drivers/acpi/Kconfig
> > +++ b/drivers/acpi/Kconfig
> > @@ -255,7 +255,6 @@ config ACPI_DOCK
> >
> >   config ACPI_CPU_FREQ_PSS
> >       bool
> > -     select THERMAL
> >
> >   config ACPI_PROCESSOR_CSTATE
> >       def_bool y
> > @@ -287,6 +286,7 @@ config ACPI_PROCESSOR
> >       depends on X86 || IA64 || ARM64 || LOONGARCH
> >       select ACPI_PROCESSOR_IDLE
> >       select ACPI_CPU_FREQ_PSS if X86 || IA64 || LOONGARCH
> > +     select THERMAL
> >       default y
> >       help
> >         This driver adds support for the ACPI Processor package. It is required
> > diff --git a/drivers/acpi/Makefile b/drivers/acpi/Makefile
> > index b5a8d3e00a52..0002eecbf870 100644
> > --- a/drivers/acpi/Makefile
> > +++ b/drivers/acpi/Makefile
> > @@ -109,10 +109,9 @@ obj-$(CONFIG_ACPI_PPTT)  += pptt.o
> >   obj-$(CONFIG_ACPI_PFRUT)    += pfr_update.o pfr_telemetry.o
> >
> >   # processor has its own "processor." module_param namespace
> > -processor-y                  := processor_driver.o
> > +processor-y                  := processor_driver.o processor_thermal.o
> >   processor-$(CONFIG_ACPI_PROCESSOR_IDLE) += processor_idle.o
> > -processor-$(CONFIG_ACPI_CPU_FREQ_PSS)        += processor_throttling.o       \
> > -     processor_thermal.o
> > +processor-$(CONFIG_ACPI_CPU_FREQ_PSS)        += processor_throttling.o
> >   processor-$(CONFIG_CPU_FREQ)        += processor_perflib.o
> >
> >   obj-$(CONFIG_ACPI_PROCESSOR_AGGREGATOR) += acpi_pad.o
> > diff --git a/drivers/acpi/processor_driver.c b/drivers/acpi/processor_driver.c
> > index 368a9edefd0c..1278969eec1f 100644
> > --- a/drivers/acpi/processor_driver.c
> > +++ b/drivers/acpi/processor_driver.c
> > @@ -139,75 +139,17 @@ static int acpi_soft_cpu_dead(unsigned int cpu)
> >   }
> >
> >   #ifdef CONFIG_ACPI_CPU_FREQ_PSS
> > -static int acpi_pss_perf_init(struct acpi_processor *pr,
> > -             struct acpi_device *device)
> > +static void acpi_pss_perf_init(struct acpi_processor *pr)
> >   {
> > -     int result = 0;
> > -
> >       acpi_processor_ppc_has_changed(pr, 0);
> >
> >       acpi_processor_get_throttling_info(pr);
> >
> >       if (pr->flags.throttling)
> >               pr->flags.limit = 1;
> > -
> > -     pr->cdev = thermal_cooling_device_register("Processor", device,
> > -                                                &processor_cooling_ops);
> > -     if (IS_ERR(pr->cdev)) {
> > -             result = PTR_ERR(pr->cdev);
> > -             return result;
> > -     }
> > -
> > -     dev_dbg(&device->dev, "registered as cooling_device%d\n",
> > -             pr->cdev->id);
> > -
> > -     result = sysfs_create_link(&device->dev.kobj,
> > -                                &pr->cdev->device.kobj,
> > -                                "thermal_cooling");
> > -     if (result) {
> > -             dev_err(&device->dev,
> > -                     "Failed to create sysfs link 'thermal_cooling'\n");
> > -             goto err_thermal_unregister;
> > -     }
> > -
> > -     result = sysfs_create_link(&pr->cdev->device.kobj,
> > -                                &device->dev.kobj,
> > -                                "device");
> > -     if (result) {
> > -             dev_err(&pr->cdev->device,
> > -                     "Failed to create sysfs link 'device'\n");
> > -             goto err_remove_sysfs_thermal;
> > -     }
> > -
> > -     return 0;
> > -
> > - err_remove_sysfs_thermal:
> > -     sysfs_remove_link(&device->dev.kobj, "thermal_cooling");
> > - err_thermal_unregister:
> > -     thermal_cooling_device_unregister(pr->cdev);
> > -
> > -     return result;
> > -}
> > -
> > -static void acpi_pss_perf_exit(struct acpi_processor *pr,
> > -             struct acpi_device *device)
> > -{
> > -     if (pr->cdev) {
> > -             sysfs_remove_link(&device->dev.kobj, "thermal_cooling");
> > -             sysfs_remove_link(&pr->cdev->device.kobj, "device");
> > -             thermal_cooling_device_unregister(pr->cdev);
> > -             pr->cdev = NULL;
> > -     }
> >   }
> >   #else
> > -static inline int acpi_pss_perf_init(struct acpi_processor *pr,
> > -             struct acpi_device *device)
> > -{
> > -     return 0;
> > -}
> > -
> > -static inline void acpi_pss_perf_exit(struct acpi_processor *pr,
> > -             struct acpi_device *device) {}
> > +static inline void acpi_pss_perf_init(struct acpi_processor *pr) {}
> >   #endif /* CONFIG_ACPI_CPU_FREQ_PSS */
> >
> >   static int __acpi_processor_start(struct acpi_device *device)
> > @@ -229,7 +171,9 @@ static int __acpi_processor_start(struct acpi_device *device)
> >       if (!cpuidle_get_driver() || cpuidle_get_driver() == &acpi_idle_driver)
> >               acpi_processor_power_init(pr);
> >
> > -     result = acpi_pss_perf_init(pr, device);
> > +     acpi_pss_perf_init(pr);
> > +
> > +     result = acpi_processor_thermal_init(pr, device);
> >       if (result)
> >               goto err_power_exit;
> >
> > @@ -239,7 +183,7 @@ static int __acpi_processor_start(struct acpi_device *device)
> >               return 0;
> >
> >       result = -ENODEV;
> > -     acpi_pss_perf_exit(pr, device);
> > +     acpi_processor_thermal_exit(pr, device);
> >
> >   err_power_exit:
> >       acpi_processor_power_exit(pr);
> > @@ -277,10 +221,10 @@ static int acpi_processor_stop(struct device *dev)
> >               return 0;
> >       acpi_processor_power_exit(pr);
> >
> > -     acpi_pss_perf_exit(pr, device);
> > -
> >       acpi_cppc_processor_exit(pr);
> >
> > +     acpi_processor_thermal_exit(pr, device);
> > +
> >       return 0;
> >   }
> >
> > diff --git a/drivers/acpi/processor_thermal.c b/drivers/acpi/processor_thermal.c
> > index d8b2dfcd59b5..db6ac540e924 100644
> > --- a/drivers/acpi/processor_thermal.c
> > +++ b/drivers/acpi/processor_thermal.c
> > @@ -266,3 +266,57 @@ const struct thermal_cooling_device_ops processor_cooling_ops = {
> >       .get_cur_state = processor_get_cur_state,
> >       .set_cur_state = processor_set_cur_state,
> >   };
> > +
> > +int acpi_processor_thermal_init(struct acpi_processor *pr,
> > +                             struct acpi_device *device)
> > +{
> > +     int result = 0;
> > +
> > +     pr->cdev = thermal_cooling_device_register("Processor", device,
> > +                                                &processor_cooling_ops);
> > +     if (IS_ERR(pr->cdev)) {
> > +             result = PTR_ERR(pr->cdev);
> > +             return result;
> > +     }
> > +
> > +     dev_dbg(&device->dev, "registered as cooling_device%d\n",
> > +             pr->cdev->id);
> > +
> > +     result = sysfs_create_link(&device->dev.kobj,
> > +                                &pr->cdev->device.kobj,
> > +                                "thermal_cooling");
> > +     if (result) {
> > +             dev_err(&device->dev,
> > +                     "Failed to create sysfs link 'thermal_cooling'\n");
> > +             goto err_thermal_unregister;
> > +     }
> > +
> > +     result = sysfs_create_link(&pr->cdev->device.kobj,
> > +                                &device->dev.kobj,
> > +                                "device");
> > +     if (result) {
> > +             dev_err(&pr->cdev->device,
> > +                     "Failed to create sysfs link 'device'\n");
> > +             goto err_remove_sysfs_thermal;
> > +     }
> > +
> > +     return 0;
> > +
> > +err_remove_sysfs_thermal:
> > +     sysfs_remove_link(&device->dev.kobj, "thermal_cooling");
> > +err_thermal_unregister:
> > +     thermal_cooling_device_unregister(pr->cdev);
> > +
> > +     return result;
> > +}
> > +
> > +void acpi_processor_thermal_exit(struct acpi_processor *pr,
> > +                              struct acpi_device *device)
> > +{
> > +     if (pr->cdev) {
> > +             sysfs_remove_link(&device->dev.kobj, "thermal_cooling");
> > +             sysfs_remove_link(&pr->cdev->device.kobj, "device");
> > +             thermal_cooling_device_unregister(pr->cdev);
> > +             pr->cdev = NULL;
> > +     }
> > +}
> > diff --git a/include/acpi/processor.h b/include/acpi/processor.h
> > index 194027371928..ba1e3ed98d3d 100644
> > --- a/include/acpi/processor.h
> > +++ b/include/acpi/processor.h
> > @@ -442,8 +442,12 @@ static inline int acpi_processor_hotplug(struct acpi_processor *pr)
> >
> >   /* in processor_thermal.c */
> >   int acpi_processor_get_limit_info(struct acpi_processor *pr);
> > +int acpi_processor_thermal_init(struct acpi_processor *pr,
> > +                             struct acpi_device *device);
> > +void acpi_processor_thermal_exit(struct acpi_processor *pr,
> > +                              struct acpi_device *device);
> >   extern const struct thermal_cooling_device_ops processor_cooling_ops;
> > -#if defined(CONFIG_ACPI_CPU_FREQ_PSS) & defined(CONFIG_CPU_FREQ)
> > +#ifdef CONFIG_CPU_FREQ
> >   void acpi_thermal_cpufreq_init(struct cpufreq_policy *policy);
> >   void acpi_thermal_cpufreq_exit(struct cpufreq_policy *policy);
> >   #else
> > @@ -455,6 +459,6 @@ static inline void acpi_thermal_cpufreq_exit(struct cpufreq_policy *policy)
> >   {
> >       return;
> >   }
> > -#endif       /* CONFIG_ACPI_CPU_FREQ_PSS */
> > +#endif       /* CONFIG_CPU_FREQ */
> >
> >   #endif
>
