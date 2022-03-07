Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 015944D0496
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 17:53:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241589AbiCGQxv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 11:53:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239265AbiCGQxt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 11:53:49 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00C742DD75
        for <linux-kernel@vger.kernel.org>; Mon,  7 Mar 2022 08:52:54 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id q11so14321623pln.11
        for <linux-kernel@vger.kernel.org>; Mon, 07 Mar 2022 08:52:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vL4YwE7tYa3Y01MHIJ9wMqV9n4oV1xcyqck3EB7a8Uw=;
        b=ODOS8TaRivkbMrCQdxGZB9ku05H2tP3eQzrcHIjQprhEE6RkiQRJo+B6SpabdFrO1K
         cuIDFVVuRQBiXGM2cvBLLXkBs/ktz/H/VAE+/SxgAemWvAlFhjWJwiSoCcbhlpTMvdGi
         qMMf8LM/LNeDF0iuw2aydULDwhUlvAEiZpTXR+UphXx0whGm+vKQrmY3ttkWesIZR3qp
         11lVdUK4U/gYBeipOIfMo0GTXeLYAEJSxBSQgfi4CWmwDrv/Co2SQmwLki74fUTk8QCD
         fUZGxM2YiQpwm0+M8B9oc81+br1oZB1BxJC+mUB5FMxv1WLkr+pLeorpnubUJ1U1E9hj
         BxDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vL4YwE7tYa3Y01MHIJ9wMqV9n4oV1xcyqck3EB7a8Uw=;
        b=t/SsjDs3XgrbiqnxKIJrNMkrn1EZKnKQDwfKi4VQHS1bYHFzL1nZ/DW8Hn2Y6yyL2k
         wCxuBZW3YK64MJDx4ER+KUsVAZgjktvceRaBREVMbANUs7zOHUFDi260F1WFd8BpCHGL
         fXTHQ4xnyDyVevK6Le/ApJ+JTIJMSNFSDf+1bdr9g5fHM+7aZS3wAM7SCYNBI2x5fuPw
         ETvJUV8wK1amXJRC1JqVM+sbRUPFnz1+6P5gJrL1yoIxjQaemMt0v0kvioqOmjyJKvgZ
         6DYzzRfdBc2O5y+S8ta4JoOfDWvdvca/0Rn/twy+ffHIn4IFGC6+xlqyeW+PU5opy7zf
         34Lw==
X-Gm-Message-State: AOAM531usGvy38yH46kntI/UXQhLnxDwFDkKW6ymY1Tsj3/FJL8ctVEH
        iuf8xHX+0+4WoHYw3vXSX66Nutq+CGQOATcLY2SGIA==
X-Google-Smtp-Source: ABdhPJywcchzxpEjs8LqsQz7iZ/kl4FGjgJE/a56/donerPGzTzg3QGeaPTZBHhugLSS8UedUrGOIaTESfJpqP4Y3Y0=
X-Received: by 2002:a17:902:7296:b0:14b:4bc6:e81 with SMTP id
 d22-20020a170902729600b0014b4bc60e81mr13029503pll.132.1646671973397; Mon, 07
 Mar 2022 08:52:53 -0800 (PST)
MIME-Version: 1.0
References: <20220301195457.21152-1-jithu.joseph@intel.com>
 <20220301195457.21152-8-jithu.joseph@intel.com> <09b5b05018a8600ca8fab896790ab16827c80e4e.camel@intel.com>
 <e282377b-8ee4-99fc-432f-2aa3441b2989@intel.com>
In-Reply-To: <e282377b-8ee4-99fc-432f-2aa3441b2989@intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Mon, 7 Mar 2022 08:52:45 -0800
Message-ID: <CAPcyv4gcfMZu38EAGBq59A-RPUmR3fFiamRiR6QaP=D1gPS+6A@mail.gmail.com>
Subject: Re: [RFC 07/10] platform/x86/intel/ifs: Create kthreads for online
 cpus for scan test
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
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 4, 2022 at 11:20 AM Joseph, Jithu <jithu.joseph@intel.com> wrote:
>
>
>
> On 3/2/2022 8:17 PM, Williams, Dan J wrote:
> > On Tue, 2022-03-01 at 11:54 -0800, Jithu Joseph wrote:
> >> Create scan kthreads for online logical cpus. Once scan test is triggered,
> >> it wakes up the corresponding thread and its sibling threads to execute
> >> the test. Once the scan test is done, the threads go back to thread wait
> >> for next signal to start a new scan.
> >>
> ...
> >> +
> >> +static int retry = 5;
> >> +module_param_cb(retry, &ifs_retry_ops, &retry, 0644);
> >> +
> >> +MODULE_PARM_DESC(retry, "Maximum retry count when the test is not executed");
> >
> > Why does this retry need to be in the kernel? Can't the test runner
> > retry the test if they want? If it stays in the kernel, why a module
> > parameter and not a sysfs attribute?
>
> A core is tested by writing 1 to "runtest" file.  When user writes  a 1 to run_test file it tests all the subtests (chunks) on a core.
> Distinct from this, retry parameter describes the autoretry driver would do at  "chunk" granularity (bit more on why, is available in the doc)
>
> Why not a sysfs attribute: good qn,  Our earlier prototype had this as a percpu sysfs attribute, however this was removed to keep the sysfs entries simple/minimal and less confusing.
> (and tunable options which are not strictly needed in the normal course of use were moved to module parameters)
> In the percpu sysfs we now only have the essential stuff i.e  run_test , status , and details making it simpler for user who wants to test the core.

...but you are putting it in sysfs, just in a different directory:

/sys/module/ifs/parameters

vs

/sys/devices/{system/cpu/,platform}/ifs

Just unify it all in one place, otherwise, I fail to see the
simplification for the user over spreading settings over multiple
locations.

>
>
> >
> >> +
> >> +static bool noint = 1;
> >> +module_param(noint, bool, 0644);
> >> +MODULE_PARM_DESC(noint, "Option to enable/disable interrupt during test");
> >
> > Same sysfs vs module parameter question...
>
> Same as above

Same multiple sysfs ABI location concern.

>
> >
>
> >> +
> >> +static const char * const scan_test_status[] = {
> >> +       "SCAN no error",
> >> +       "Other thread could not join.",
> >> +       "Interrupt occurred prior to SCAN coordination.",
> >> +       "Core Abort SCAN Response due to power management condition.",
> >> +       "Non valid chunks in the range",
> >> +       "Mismatch in arguments between threads T0/T1.",
> >> +       "Core not capable of performing SCAN currently",
> >> +       "Unassigned error code 0x7",
> >> +       "Exceeded number of Logical Processors (LP) allowed to run Scan-At-Field concurrently",
> >> +       "Interrupt occurred prior to SCAN start",
> >
> > This looks unmaintainable...
> >
> > /me finds large comment block around IFS_* error codes and suggests
> > killing 2 birds with one stone, i.e. delete that comment and make this
> > self documenting:
> >
> > static const char * const scan_test_status[] = {
> >     [IFS_NO_ERROR] = "SCAN no error",
> >     [IFS_OTHER_THREAD_DID_NOT_JOIN] = "Other thread could not join.",
> >     ...etc...
> > };
>
> Will use this format.
>
> >
> > Btw, which is it "did not join" and "could not join"? If the symbol
> > name is going to be that long might as well make it match the log
> > message verbatim.
>
> Will make them identical. Thanks for pointing this out.
>
> >
> > That way you can add / delete error codes without wondering if you
> > managed to match the code number to the right position in the array.
> >
> > Even better would be to kick this out of the kernel and let the user
> > tool translate the error codes to test result log messages.
> >
> >> +};
> >> +
> >> +static void message_not_tested(int cpu, union ifs_status status)
> >> +{
> >> +       if (status.error_code < ARRAY_SIZE(scan_test_status))
> >> +               pr_warn("CPU %d: SCAN operation did not start. %s\n", cpu,
> >> +                       scan_test_status[status.error_code]);
> >> +       else if (status.error_code == IFS_SW_TIMEOUT)
> >> +               pr_warn("CPU %d: software timeout during scan\n", cpu);
> >> +       else if (status.error_code == IFS_SW_PARTIAL_COMPLETION)
> >> +               pr_warn("CPU %d: %s\n", cpu,
> >> +                       "Not all scan chunks were executed. Maximum forward progress retries exceeded");
> >
> > Why are these codes not in the scan_test_status set? I see that
> > IFS_SW_PARTIAL_COMPLETION and IFS_SW_TIMEOUT are defined with larger
> > values, but why?
>
> These are software(driver) defined error codes. Rest of the error codes are supplied by
> the hardware. Software defined error codes were kept at the other end to provide ample space
> in case (future) hardware decides to provide extend error codes.

Why put them in the same number space? Separate software results from
the raw hardware results and have a separate mechanism to convey each.

>
> >
> >> +       else
> >> +               pr_warn("CPU %d: SCAN unknown status %llx\n", cpu, status.data);
> >> +}
> >> +
> >> +static void message_fail(int cpu, union ifs_status status)
> >> +{
> >> +       if (status.control_error) {
> >> +               pr_err("CPU %d: scan failed. %s\n", cpu,
> >> +                      "Suggest reload scan file: # echo 1 > /sys/devices/system/cpu/ifs/reload");
> >> +       }
> >> +       if (status.signature_error) {
> >> +               pr_err("CPU %d: test signature incorrect. %s\n", cpu,
> >> +                      "Suggest retry scan to check if problem is transient");
> >> +       }
> >
> > This looks and feels more like tools/testing/selftests/ style code
> > printing information for a kernel developer to read. For a production
> > capability I would expect these debug messages to be elided and have an
> > ifs user tool that knows when to "Suggest reload scan file". Otherwise,
> > it's not scalable to use the kernel log buffer like a utility's stdout.
>
> The two pr_err here are for really really grave errors and warrants being displayed to console,
> possibly indicating some fault with the particular core. They are never expected to come in normal
> course of testing on a working core.

Kernel log messages with user action recommendations belong in a user tool.

> But I see your larger point. We will convert all the pr_warn preceeding this (in message_not_tested())
> to pr_dbg so that they dont normally take up the kernel log buffer. (they are not as grave a scenario as the earlier one).
>
> The same information is also available from percpu sysfs/cpu#/ifs/status for user spaces tools to operate on

"Suggest retry" does not seem like "grave error" to me. User feedback
belongs in a user tool.
