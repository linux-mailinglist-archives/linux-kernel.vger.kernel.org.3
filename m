Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F00194D0566
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 18:38:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240039AbiCGRjm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 12:39:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233274AbiCGRjl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 12:39:41 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 493E5673F2
        for <linux-kernel@vger.kernel.org>; Mon,  7 Mar 2022 09:38:46 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id p17so14493640plo.9
        for <linux-kernel@vger.kernel.org>; Mon, 07 Mar 2022 09:38:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SjU0oXobpRpnXcUO/93qSq5ehS6YBCVrORBGrEIUgVg=;
        b=35y2SvUPBz9DIp9rCXt7B/HVCyv1VFUBkQJ8QhgJ2GRQi9cY7AoWnbibFGfqXgp6R3
         By80QYVp8UzzPU+fqMKE2WdYHu0sOfXc4JXWnuJLOFkOcH5j/7bnhU/c0cJaN8EP70ge
         gM8f9oA7DSR1PqUl8R0Hzy8CcEtzlo8MjBlq/YbD4G7FPAr4sb0n4g+9CRESsCltnFd5
         TBSCgxsB5rv/2dgMe7AzwNdh02g9HStKTe0JdybFUjzh+8xpX2KQuyf/5OybEQ0t0Rxk
         XCAZM8EOKVH8aYO3jUu1kc6w/AckLet71KdJAj79ldmvkjLFq+rbcI9Rzmiwc3dOPt5n
         HuiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SjU0oXobpRpnXcUO/93qSq5ehS6YBCVrORBGrEIUgVg=;
        b=g4SrDDmqfn3g95w70/0Q/Xv3Ic+bfv5j8xpE9AQhfPAhMXL0LMNEjU/ZVwxJzYyysS
         AXQpHnPVwQ26ryJTaPVD0bFLCHyOW2DwK9moVbKX41x2YXORaspyJ6CI1YBoCnMnlYPk
         zxix/XNGhet8sdD3kXYlrP+7UPgkG4sOiAhQdTQ/jofo8BZ9cfkcuMuTB+XEE1Kj6M2P
         pphZDm4NX8bCq5i3rQRXEpcI1fM4SJPMPGn4UYHhYzkB+f4XGPEXeU58rydo+POZehhH
         yPS4nKtL6Avkbpf6+ocovAW2yi5d+5PR3sRDn/VGbDPhqpQpS2/qJh+qpma8s9NPB1QB
         DukQ==
X-Gm-Message-State: AOAM530SpBlczH5jKFenjDNgaxq6zFjGLFvXNF0CTffaMej8U87+qe1D
        NAPomSxza+mgGSri1XabxrH2xvBcfNeKyfQ4JPxByA==
X-Google-Smtp-Source: ABdhPJyl1MNAZYmuSUn5DffojCNiXtCU4KLr9RzODEdlQb8ACV697LzSMGC0kpeiJqnZxYn1ir+yx0ojFb8zWlLOhrs=
X-Received: by 2002:a17:902:d506:b0:151:ced2:3cf with SMTP id
 b6-20020a170902d50600b00151ced203cfmr13366259plg.147.1646674725766; Mon, 07
 Mar 2022 09:38:45 -0800 (PST)
MIME-Version: 1.0
References: <20220301195457.21152-1-jithu.joseph@intel.com>
 <20220301195457.21152-9-jithu.joseph@intel.com> <188492dc80c017375da76d444347b1d00c2031f6.camel@intel.com>
 <7b9c788e-21dc-eedc-a1b4-9c6877fa48fe@intel.com>
In-Reply-To: <7b9c788e-21dc-eedc-a1b4-9c6877fa48fe@intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Mon, 7 Mar 2022 09:38:37 -0800
Message-ID: <CAPcyv4h=qPFrP+mRqaZhkh5ZmYjuQawsqvf+-R036ZJVKBNK4Q@mail.gmail.com>
Subject: Re: [RFC 08/10] platform/x86/intel/ifs: Add IFS sysfs interface
To:     "Joseph, Jithu" <jithu.joseph@intel.com>
Cc:     "hdegoede@redhat.com" <hdegoede@redhat.com>,
        "markgross@kernel.org" <markgross@kernel.org>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        "Luck, Tony" <tony.luck@intel.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "patches@lists.linux.dev" <patches@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "hpa@zytor.com" <hpa@zytor.com>, "bp@alien8.de" <bp@alien8.de>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "andriy.shevchenko@linux.intel.com" 
        <andriy.shevchenko@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 4, 2022 at 12:42 PM Joseph, Jithu <jithu.joseph@intel.com> wrote:
>
>
>
> On 3/3/2022 4:31 PM, Williams, Dan J wrote:
> > On Tue, 2022-03-01 at 11:54 -0800, Jithu Joseph wrote:
> >> Implement sysfs interface to trigger ifs test for a targeted core or
> >> all cores. For all core testing, the kernel will start testing from core 0
> >> and proceed to the next core one after another. After the ifs test on the
> >> last core, the test stops until the administrator starts another round of
>
> >> +
> >> +/*
> >> + * The sysfs interface to check the test status:
> >> + * To check the result, for example, cpu0
> >> + * cat /sys/devices/system/cpu/cpu0/ifs/details
> >> + */
> >> +static ssize_t details_show(struct device *dev,
> >> +                           struct device_attribute *attr,
> >> +                           char *buf)
> >> +{
> >> +       unsigned int cpu = dev->id;
> >> +       int ret;
> >> +
> >> +       if (down_trylock(&ifs_sem))
> >> +               return -EBUSY;
> >
> > What is the ifs_sem protecting? This result is immediately invalid
> > after the lock is dropped anyway, so why hold it over reading the
> > value? You can't prevent 2 threads racing each other here.
>
> percpu thread running scan_test_worker() will update per_cpu(ifs_state, cpu).scan_details. (before signalling this thread to run, this lock would be acquired)
> This is to protect against the scenario where if the percpu thread is running a test and if at the same time a user is querying its status, they would see busy.

That begs the question why would userspace be polling this file? Is it
because it does not know when a test completes otherwise? How does it
know that the result it is seeing is from the test it ran and not some
other invocation to start a new test?

These questions would be easier to answer with a sample tool
implementation to look at even if that's only test code that lives in
tools/testing/. At first glance it seems possible to fake a scan to
test the ABI.

> >> +
> >> +       ret = sprintf(buf, "%llx\n", per_cpu(ifs_state, cpu).scan_details);
> >
> > Should be sysfs_emit() which includes the page buffer safety.
>
> grep KH also pointed this out ... will replace this throughout
>
> >
> > Also, you likely want that format string to be %#llx so that userspace
> > knows explicitly that this is a hexadecimal value.
>
> Agreed will do this
>
>
> >> +
> >> +/*
> >> + * The sysfs interface for single core testing
> >> + * To start test, for example, cpu0
> >> + * echo 1 > /sys/devices/system/cpu/cpu0/ifs/run_test
> >> + * To check the result:
> >> + * cat /sys/devices/system/cpu/cpu0/ifs/result
> (there is a typo in the comment result -> status)
> >
> > Just have a CPU mask as an input parameter and avoid needing to hang
> > ifs sysfs attributes underneath /sys/device/system/cpu/ifs.
>
> The percpu sysfs has the additional function of providing percpu status and  details.

That still does not answer the question about the input parameter for
selecting cores.

> The global interface is unable to provide the status and details for all the cores in the system. It does give a summary, which
> guides the user to the appropriate percpu status/details

It does not sound like the global sysfs interface is all that useful,
especially as it just expands the window for the global results to
become out of sync with the per-cpu results. With a uevent  the tool
can get called to handle results on per-cpu / per-test,chunk basis
atomically. I.e. a udev rule like:

ACTION=="change", DRIVER=="ifs", SUBSYSTEM=="platform" \
RUN+="/bin/ifs-log
--testid=$env{IFS_TESTID}\t--cpu=$end{IFS_CPU}\t--result=$env{IFS_RESULT}\t--detail=$env{IFS_DETAIL}\t--hardware-status=$env{IFS_HWSTATUS}\t--software-status=$env{IFS_SWSTATUS}

...that way this retrieves all the relevant details without a need to
poll sysfs, it does so atomically so there is no worry about running
back to back tests as that will just increment IFS_TESTID to keep all
the runs distinct in the log, it allows for separation of software and
hardware error codes, and it's extensible for new fields if the need
arises.

>
>
> >> + */
> >> +static ssize_t allcpu_run_test_store(struct device *dev,
> >> +                                    struct device_attribute *attr,
> >> +                                    const char *buf, size_t count)
> >> +{
> >> +       bool var;
> >> +       int rc;
> >> +
> >> +       if (ifs_disabled)
> >> +               return -ENXIO;

I missed this earlier, but you could remove the sysfs ABI visibility
entirely when this happens with sysfs_update_group() rather than leave
dead ABI files.
