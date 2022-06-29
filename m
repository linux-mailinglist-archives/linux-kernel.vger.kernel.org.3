Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AA665606BE
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 18:54:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231558AbiF2Qx1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 12:53:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229582AbiF2QxU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 12:53:20 -0400
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 556251581C;
        Wed, 29 Jun 2022 09:53:19 -0700 (PDT)
Received: by mail-yb1-f169.google.com with SMTP id i15so29104833ybp.1;
        Wed, 29 Jun 2022 09:53:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cN6Ljuohbb0Vlk0TDH1NJISR1t0bRPA1FSG4C0YqDUA=;
        b=N5uTEytaB9WsY6gMNqB565XhMDaoCLGL4/JNjTFhLEzsW5SzfXWHF0dv69k/4Xxees
         i0VqH1e6N4EfInUPA7NBxk8M3dHWZ8ZNK78ibGn2ywK6VeRSFhNHBM9FZanDesoUiUDT
         uWyrmG3FKjbBFc29gxxbvS7psV0P5yocjAL56BojvuITsw2KCR6up70yjsocxi5bF6pj
         8icxdH/K8kedLZaG64E0AEdEPlnbB+8LlOxnF+/PQpC7KSAoGzTQwY4yq6aCPLVPrpFA
         rKbObRE0gNyz++XIVkFH5sKCAWOHInVZ5dtcsxaPGZc6o6cgWxn0HPHKbQclP58mVcuj
         inuw==
X-Gm-Message-State: AJIora9k4FVCq8+k1uASwxrwfsN/udhJZJqJoj10U/eUJdbwF1Ek8FTD
        0LUylemCqfvWixOxdW1hsiQYvE+mpdxZSzTB6xNV9FO5
X-Google-Smtp-Source: AGRyM1t3o9GsoqPByrdcwwMReVyOghctXRZ85jfyKlh8iiyQixMj21AmpSZwxGzKdeoP+bInImchsDTHeYc9Yc5KQTk=
X-Received: by 2002:a25:664f:0:b0:66c:d0f4:36cc with SMTP id
 z15-20020a25664f000000b0066cd0f436ccmr4277441ybm.482.1656521598411; Wed, 29
 Jun 2022 09:53:18 -0700 (PDT)
MIME-Version: 1.0
References: <TYWP286MB2601965DDE4D251807F70415B1AF9@TYWP286MB2601.JPNP286.PROD.OUTLOOK.COM>
 <871qvnpro3.fsf@stealth>
In-Reply-To: <871qvnpro3.fsf@stealth>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 29 Jun 2022 18:53:07 +0200
Message-ID: <CAJZ5v0gbqxWjJjEJWJUt3HCMARtaewewNSHuD1zjoxOUeE89Rg@mail.gmail.com>
Subject: Re: [PATCH v3] ACPI: Split out processor thermal register from ACPI PSS
To:     Punit Agrawal <punit.agrawal@bytedance.com>,
        Riwen Lu <luriwen@hotmail.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        "Zhang, Rui" <rui.zhang@intel.com>,
        Robert Moore <robert.moore@intel.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:ACPI COMPONENT ARCHITECTURE (ACPICA)" <devel@acpica.org>,
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

On Fri, Jun 17, 2022 at 11:26 AM Punit Agrawal
<punit.agrawal@bytedance.com> wrote:
>
> Riwen Lu <luriwen@hotmail.com> writes:
>
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
> >
> > Signed-off-by: Riwen Lu <luriwen@kylinos.cn>
> >
> > ---
> > v1 -> v2:
> >  - Reword the commit message.
> >  - Update the signature of acpi_pss_perf_init() to void, and remove the
> >    acpi_device parameter.
> >  - Move the processor thermal register/remove into a separate function in
> >    processor_thermal.c.
> >
> > v2 -> v3:
> >  - Remove the "pr" NULL check in processor thermal init/exit fuction.
> >  - Pass the acpi_device into processor thermal init/exit, and remove the
> >    convert in it.
> > ---
> >  drivers/acpi/Kconfig             |  2 +-
> >  drivers/acpi/Makefile            |  5 +--
> >  drivers/acpi/processor_driver.c  | 72 ++++----------------------------
> >  drivers/acpi/processor_thermal.c | 54 ++++++++++++++++++++++++
> >  include/acpi/processor.h         |  8 +++-
> >  5 files changed, 71 insertions(+), 70 deletions(-)
> >
> > diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
> > index 1e34f846508f..2457ade3f82d 100644
> > --- a/drivers/acpi/Kconfig
> > +++ b/drivers/acpi/Kconfig
> > @@ -255,7 +255,6 @@ config ACPI_DOCK
> >
> >  config ACPI_CPU_FREQ_PSS
> >       bool
> > -     select THERMAL
> >
> >  config ACPI_PROCESSOR_CSTATE
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
> >  obj-$(CONFIG_ACPI_PFRUT)     += pfr_update.o pfr_telemetry.o
> >
> >  # processor has its own "processor." module_param namespace
> > -processor-y                  := processor_driver.o
> > +processor-y                  := processor_driver.o processor_thermal.o
> >  processor-$(CONFIG_ACPI_PROCESSOR_IDLE) += processor_idle.o
> > -processor-$(CONFIG_ACPI_CPU_FREQ_PSS)        += processor_throttling.o       \
> > -     processor_thermal.o
> > +processor-$(CONFIG_ACPI_CPU_FREQ_PSS)        += processor_throttling.o
> >  processor-$(CONFIG_CPU_FREQ) += processor_perflib.o
> >
> >  obj-$(CONFIG_ACPI_PROCESSOR_AGGREGATOR) += acpi_pad.o
> > diff --git a/drivers/acpi/processor_driver.c b/drivers/acpi/processor_driver.c
> > index 368a9edefd0c..1278969eec1f 100644
> > --- a/drivers/acpi/processor_driver.c
> > +++ b/drivers/acpi/processor_driver.c
> > @@ -139,75 +139,17 @@ static int acpi_soft_cpu_dead(unsigned int cpu)
> >  }
> >
> >  #ifdef CONFIG_ACPI_CPU_FREQ_PSS
> > -static int acpi_pss_perf_init(struct acpi_processor *pr,
> > -             struct acpi_device *device)
> > +static void acpi_pss_perf_init(struct acpi_processor *pr)
> >  {
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
> >  }
> >  #else
> > -static inline int acpi_pss_perf_init(struct acpi_processor *pr,
> > -             struct acpi_device *device)
> > -{
> > -     return 0;
> > -}
> > -
> > -static inline void acpi_pss_perf_exit(struct acpi_processor *pr,
> > -             struct acpi_device *device) {}
> > +static inline void acpi_pss_perf_init(struct acpi_processor *pr) {}
> >  #endif /* CONFIG_ACPI_CPU_FREQ_PSS */
> >
> >  static int __acpi_processor_start(struct acpi_device *device)
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
> >  err_power_exit:
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
> >  }
> >
> > diff --git a/drivers/acpi/processor_thermal.c b/drivers/acpi/processor_thermal.c
> > index d8b2dfcd59b5..db6ac540e924 100644
> > --- a/drivers/acpi/processor_thermal.c
> > +++ b/drivers/acpi/processor_thermal.c
> > @@ -266,3 +266,57 @@ const struct thermal_cooling_device_ops processor_cooling_ops = {
> >       .get_cur_state = processor_get_cur_state,
> >       .set_cur_state = processor_set_cur_state,
> >  };
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
> >  /* in processor_thermal.c */
> >  int acpi_processor_get_limit_info(struct acpi_processor *pr);
> > +int acpi_processor_thermal_init(struct acpi_processor *pr,
> > +                             struct acpi_device *device);
> > +void acpi_processor_thermal_exit(struct acpi_processor *pr,
> > +                              struct acpi_device *device);
> >  extern const struct thermal_cooling_device_ops processor_cooling_ops;
> > -#if defined(CONFIG_ACPI_CPU_FREQ_PSS) & defined(CONFIG_CPU_FREQ)
> > +#ifdef CONFIG_CPU_FREQ
> >  void acpi_thermal_cpufreq_init(struct cpufreq_policy *policy);
> >  void acpi_thermal_cpufreq_exit(struct cpufreq_policy *policy);
> >  #else
> > @@ -455,6 +459,6 @@ static inline void acpi_thermal_cpufreq_exit(struct cpufreq_policy *policy)
> >  {
> >       return;
> >  }
> > -#endif       /* CONFIG_ACPI_CPU_FREQ_PSS */
> > +#endif       /* CONFIG_CPU_FREQ */
> >
> >  #endif
>
> Thanks for updating the patch.
>
> FWIW,
>
> Reviewed-by: Punit Agrawal <punit.agrawal@bytedance.com>

Applied as 5.20 material under edited subject, thanks!
