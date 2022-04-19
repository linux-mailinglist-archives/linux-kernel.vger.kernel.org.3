Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8819507944
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 20:42:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357359AbiDSSfP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 14:35:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358399AbiDSSeV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 14:34:21 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B171A3EF2B
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 11:25:02 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id a15so1492216pfv.11
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 11:25:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1WPXFC2v5PeCzwn6oHjwjH0MDC22utYPzef7qPmYX/s=;
        b=grWuCBAKpgPvvSh5mnB24+PtftUt+CfUvdbQ4ujb7Xzp+oZpTrY7GXabtieIXunfa/
         /4UfM6ayfwXwSculKLSIVtp2t+0qjnssYJNz/wGRb5oHBiGdQUH1bq5bsAwuA6kzLm22
         S68hCyI2k0RUMOFKwP3NHw75dZjW2CxiIN+242sING5yOuC6dYP22k30QASqP7xo8SZz
         K0G4PD5r7wDFOjtBOjmfQc8b5pPy3wdJiQYSAO+YwYzMDOr4H9FeHLHAmdTJXay1JuuQ
         CV0ZQbD7CGY9k6pcE4YlZ5TsJzpD8GP9vjtt7drbmu8HviQJh4pAe1QtQbNU5aMVgdut
         Cymg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1WPXFC2v5PeCzwn6oHjwjH0MDC22utYPzef7qPmYX/s=;
        b=0aRx4XFqZ4K6pXSauqOPZ9xy3fDtbrsUXwGx6ZQK+Z4204icgHDsHiOEms1imbc3hU
         2/H+jK/206IJcznPjeDCq6UXgIxfKTTHtl2/mojD+4TNK+5u9fO44JQzetX4SjSFG1Ox
         EgmTXCZ3VPXnAgvq0m0UM8MUhKbCl79rEcKyr62HMRdFEBnJjer9Dof0pafLX/ehtfhG
         EsW0NuIRWfc7RaweVhYrmpRk3ulmyNyUcrTvztJ0kTUx5nOzVeCz2H3LshrcEXD4DEqj
         OAPw/HiR/QbwF4tnVox75QZ+1OVgrw+2l1Ao20VPKML5hJkS6EO9oEtHmeEGKCyzcS74
         ep3Q==
X-Gm-Message-State: AOAM533FtrMtF4RDkOBjHjfNDJLuLIvCuZtU1iVnr+4HVNFWWhh4Hd+b
        ajX5ITreXpC4/exwBOxM5LAvc7cyUETv2KsyH08gYg==
X-Google-Smtp-Source: ABdhPJwfckCOTHvr6A4RvKE4IWMDK2JEOAHlgCDq2U6fq3RAT4rgbYqPhf5o0SfK9znKPX8sSjJ8b/EvOdiTzc2ZQts=
X-Received: by 2002:a05:6a00:e14:b0:4fe:3cdb:23f with SMTP id
 bq20-20020a056a000e1400b004fe3cdb023fmr19186553pfb.86.1650392701483; Tue, 19
 Apr 2022 11:25:01 -0700 (PDT)
MIME-Version: 1.0
References: <20220407191347.9681-1-jithu.joseph@intel.com> <20220419163859.2228874-1-tony.luck@intel.com>
 <20220419163859.2228874-10-tony.luck@intel.com> <Yl7vdpJgKYRL1jeW@kroah.com>
In-Reply-To: <Yl7vdpJgKYRL1jeW@kroah.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 19 Apr 2022 11:24:50 -0700
Message-ID: <CAPcyv4hj+Cq_Xw2TC0ymKkbYogyJY__0j2wUOhnuRaHMsyuyUg@mail.gmail.com>
Subject: Re: [PATCH v3 09/11] platform/x86/intel/ifs: Add IFS sysfs interface
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Tony Luck <tony.luck@intel.com>,
        Hans de Goede <hdegoede@redhat.com>, markgross@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        X86 ML <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "Joseph, Jithu" <jithu.joseph@intel.com>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        platform-driver-x86@vger.kernel.org, patches@lists.linux.dev,
        Ravi V Shankar <ravi.v.shankar@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 19, 2022 at 10:21 AM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Tue, Apr 19, 2022 at 09:38:57AM -0700, Tony Luck wrote:
> > From: Jithu Joseph <jithu.joseph@intel.com>
> >
> > Implement sysfs interface to trigger ifs test for a specific cpu.
> > Additional interfaces related to checking the status of the
> > scan test and seeing the version of the loaded IFS binary
> > are also added.
> >
> > The basic usage is as below.
> >    - To start test, for example on cpu5:
> >        echo 5 > /sys/devices/platform/intel_ifs/run_test
> >    - To see the status of the last test
> >        cat /sys/devices/platform/intel_ifs/status
> >    - To see the version of the loaded scan binary
> >        cat /sys/devices/platform/intel_ifs/image_version
> >
> > Reviewed-by: Dan Williams <dan.j.williams@intel.com>
> > Signed-off-by: Jithu Joseph <jithu.joseph@intel.com>
> > Co-developed-by: Tony Luck <tony.luck@intel.com>
> > Signed-off-by: Tony Luck <tony.luck@intel.com>
> > ---
> >  drivers/platform/x86/intel/ifs/Makefile  |   2 +-
> >  drivers/platform/x86/intel/ifs/core.c    |   9 ++
> >  drivers/platform/x86/intel/ifs/ifs.h     |   3 +
> >  drivers/platform/x86/intel/ifs/runtest.c |   7 ++
> >  drivers/platform/x86/intel/ifs/sysfs.c   | 151 +++++++++++++++++++++++
> >  5 files changed, 171 insertions(+), 1 deletion(-)
> >  create mode 100644 drivers/platform/x86/intel/ifs/sysfs.c
> >
> > diff --git a/drivers/platform/x86/intel/ifs/Makefile b/drivers/platform/x86/intel/ifs/Makefile
> > index 7de27361b479..dbbe0bf66987 100644
> > --- a/drivers/platform/x86/intel/ifs/Makefile
> > +++ b/drivers/platform/x86/intel/ifs/Makefile
> > @@ -2,4 +2,4 @@ obj-$(CONFIG_INTEL_IFS_DEVICE)        += intel_ifs_device.o
> >
> >  obj-$(CONFIG_INTEL_IFS)              += intel_ifs.o
> >
> > -intel_ifs-objs                       := core.o load.o runtest.o
> > +intel_ifs-objs                       := core.o load.o runtest.o sysfs.o
> > diff --git a/drivers/platform/x86/intel/ifs/core.c b/drivers/platform/x86/intel/ifs/core.c
> > index 0dc4cdda35ff..f56cde0cdfd6 100644
> > --- a/drivers/platform/x86/intel/ifs/core.c
> > +++ b/drivers/platform/x86/intel/ifs/core.c
> > @@ -3,6 +3,7 @@
> >
> >  #include <linux/module.h>
> >  #include <linux/platform_device.h>
> > +#include <linux/semaphore.h>
> >
> >  #include "ifs.h"
> >
> > @@ -26,10 +27,18 @@ static int ifs_probe(struct platform_device *pdev)
> >       return 0;
> >  }
> >
> > +/*
> > + * Note there is no need for a ->remove() call back. There isn't an
> > + * "unload" operation to remove the scan binary from the BIOS reserved
> > + * area. Also ".dev_groups" removal order will guarantee that any in
> > + * flight tests have completed.
> > + */
>
> So you are ok with the warning the kernel gives you when you unload the
> driver?  That feels wrong :(
>
> > +
> >  static struct platform_driver intel_ifs_driver = {
> >       .probe = ifs_probe,
> >       .driver = {
> >               .name = "intel_ifs",
> > +             .dev_groups = plat_ifs_groups,
> >       },
> >  };
> >
> > diff --git a/drivers/platform/x86/intel/ifs/ifs.h b/drivers/platform/x86/intel/ifs/ifs.h
> > index f5e3636d709f..4e6662f2d2f8 100644
> > --- a/drivers/platform/x86/intel/ifs/ifs.h
> > +++ b/drivers/platform/x86/intel/ifs/ifs.h
> > @@ -97,4 +97,7 @@ int ifs_setup_wq(void);
> >  void ifs_destroy_wq(void);
> >  int do_core_test(int cpu, struct device *dev);
> >
> > +extern const struct attribute_group *plat_ifs_groups[];
> > +extern struct semaphore ifs_sem;
> > +
> >  #endif
> > diff --git a/drivers/platform/x86/intel/ifs/runtest.c b/drivers/platform/x86/intel/ifs/runtest.c
> > index 7793a01f7b94..246eff250563 100644
> > --- a/drivers/platform/x86/intel/ifs/runtest.c
> > +++ b/drivers/platform/x86/intel/ifs/runtest.c
> > @@ -10,6 +10,13 @@
> >
> >  #include "ifs.h"
> >
> > +/*
> > + * Note all code and data in this file is protected by
> > + * ifs_sem. On HT systems all threads on a core will
> > + * execute together, but only the first thread on the
> > + * core will update results of the test and indicate
> > + * completion.
> > + */
> >  static struct workqueue_struct *ifs_wq;
> >  static struct completion test_thread_done;
> >  static atomic_t siblings_in;
> > diff --git a/drivers/platform/x86/intel/ifs/sysfs.c b/drivers/platform/x86/intel/ifs/sysfs.c
> > new file mode 100644
> > index 000000000000..41db2a12fbc8
> > --- /dev/null
> > +++ b/drivers/platform/x86/intel/ifs/sysfs.c
> > @@ -0,0 +1,151 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +/* Copyright(c) 2022 Intel Corporation. */
> > +
> > +#include <linux/cpu.h>
> > +#include <linux/delay.h>
> > +#include <linux/fs.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/semaphore.h>
> > +#include <linux/slab.h>
> > +
> > +#include "ifs.h"
> > +
> > +/*
> > + * Protects against simultaneous tests on multiple cores, or
> > + * reloading can file while a test is in progress
> > + */
> > +DEFINE_SEMAPHORE(ifs_sem);
> > +
> > +/*
> > + * The sysfs interface to check additional details of last test
> > + * cat /sys/devices/system/platform/ifs/details
> > + */
> > +static ssize_t details_show(struct device *dev,
> > +                         struct device_attribute *attr,
> > +                         char *buf)
> > +{
> > +     struct ifs_data *ifsd = dev_get_drvdata(dev);
> > +
> > +     return sysfs_emit(buf, "%#llx\n", ifsd->scan_details);
> > +}
> > +
> > +static DEVICE_ATTR_RO(details);
> > +
> > +static const char * const status_msg[] = {
> > +     [SCAN_NOT_TESTED] = "untested",
> > +     [SCAN_TEST_PASS] = "pass",
> > +     [SCAN_TEST_FAIL] = "fail"
> > +};
> > +
> > +/*
> > + * The sysfs interface to check the test status:
> > + * To check the status of last test
> > + * cat /sys/devices/platform/ifs/status
> > + */
> > +static ssize_t status_show(struct device *dev,
> > +                        struct device_attribute *attr,
> > +                        char *buf)
> > +{
> > +     struct ifs_data *ifsd = dev_get_drvdata(dev);
> > +
> > +     return sysfs_emit(buf, "%s\n", status_msg[ifsd->status]);
> > +}
> > +
> > +static DEVICE_ATTR_RO(status);
> > +
> > +/*
> > + * The sysfs interface for single core testing
> > + * To start test, for example, cpu5
> > + * echo 5 > /sys/devices/platform/ifs/run_test
> > + * To check the result:
> > + * cat /sys/devices/platform/ifs/result
> > + * The sibling core gets tested at the same time.
> > + */
> > +static ssize_t run_test_store(struct device *dev,
> > +                           struct device_attribute *attr,
> > +                           const char *buf, size_t count)
> > +{
> > +     struct ifs_data *ifsd = dev_get_drvdata(dev);
> > +     unsigned int cpu;
> > +     int rc;
> > +
> > +     rc = kstrtouint(buf, 0, &cpu);
> > +     if (rc < 0 || cpu >= nr_cpu_ids)
> > +             return -EINVAL;
> > +
> > +     if (down_interruptible(&ifs_sem))
> > +             return -EINTR;
> > +
> > +     if (!ifsd->loaded)
> > +             rc = -EPERM;
> > +     else
> > +             rc = do_core_test(cpu, dev);
> > +
> > +     up(&ifs_sem);
> > +
> > +     return rc ? rc : count;
> > +}
> > +
> > +static DEVICE_ATTR_WO(run_test);
> > +
> > +/*
> > + * Reload the IFS image. When user wants to install new IFS image
> > + */
> > +static ssize_t reload_store(struct device *dev,
> > +                         struct device_attribute *attr,
> > +                         const char *buf, size_t count)
> > +{
> > +     struct ifs_data *ifsd = dev_get_drvdata(dev);
> > +     int rc;
> > +
> > +     if (!sysfs_streq(buf, "1"))
>
> kstrtobool()?

I had asked them to drop kstrtobool() to save a line or 2, because
this is a write-only attribute where "1" is the only valid value.
Otherwise, no worries from me about supporting the other 'true'
values.

>
> > +             return -EINVAL;
> > +
> > +     if (down_interruptible(&ifs_sem))
> > +             return -EINTR;
> > +
> > +     rc = load_ifs_binary(dev);
> > +
> > +     ifsd->loaded = (rc == 0);
> > +
> > +     up(&ifs_sem);
> > +
> > +     return rc ? rc : count;
> > +}
> > +
> > +static DEVICE_ATTR_WO(reload);
> > +
> > +/*
> > + * Display currently loaded IFS image version.
> > + */
> > +static ssize_t image_version_show(struct device *dev,
> > +                               struct device_attribute *attr, char *buf)
> > +{
> > +     struct ifs_data *ifsd = dev_get_drvdata(dev);
> > +
> > +     if (!ifsd->loaded)
> > +             return sysfs_emit(buf, "%s\n", "none");
> > +     else
> > +             return sysfs_emit(buf, "%#x\n", ifsd->loaded_version);
> > +}
> > +
> > +static DEVICE_ATTR_RO(image_version);
> > +
> > +/* global scan sysfs attributes */
> > +static struct attribute *plat_ifs_attrs[] = {
> > +     &dev_attr_details.attr,
> > +     &dev_attr_status.attr,
> > +     &dev_attr_run_test.attr,
> > +     &dev_attr_reload.attr,
> > +     &dev_attr_image_version.attr,
> > +     NULL
> > +};
> > +
> > +static const struct attribute_group plat_ifs_attr_group = {
> > +     .attrs = plat_ifs_attrs,
> > +};
> > +
> > +const struct attribute_group *plat_ifs_groups[] = {
> > +     &plat_ifs_attr_group,
> > +     NULL
> > +};
>
> ATTRIBUTE_GROUPS()?

Yeah, I should have caught that.
