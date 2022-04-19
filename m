Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AA22507A78
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 21:45:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356339AbiDSTsU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 15:48:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356163AbiDSTr7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 15:47:59 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E8A311C33
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 12:45:15 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id z16so9341935pfh.3
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 12:45:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=umMtnsauqQeI0NgI+fx6Tr/G9J3sdAyMJ/d4Ny9Ul3U=;
        b=AehAOKeaXjujrUFwMA6ZK71ZoKV0rmjP8U3MvAUztOhHEsG2J0rD+dQWbhsFYAdEE8
         8ZY2LlALZ0XmQuLeQQIaeRRT7u4E27eDJVA3QdfUxT2ojlOLwlmK+E53c+s0iG550u43
         w47YYKXccyOCiXIHqIR11MF0pt/HMYPDSKQMfZ+9ER4v1UeLJepZsl3Ct44G9yBoqNwW
         OlxE05TxKK2ddmy6ZeAiNYfoZdWS+VPyuj00LpztKb3B25ifcUzamp+2qoF2pp4+HXPe
         FaG1usXXb6XTT85qgtfuhQ0sjo21nJqJsdtL4uZLvUtZctI1LfuN3Nglx/7qtGxLqkW+
         YF3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=umMtnsauqQeI0NgI+fx6Tr/G9J3sdAyMJ/d4Ny9Ul3U=;
        b=rMJJIU/baEeIhCaulIVoyvrkEXxO/MwfAXzniUOE0B5dhAjgD7SjnyNHpdwzRicVFO
         1tyBMCBpQWUiLMd9lkLTFeI4Ijm+fD7R8pODtBZ4opK4vrSQJWz2+cjE0oBu6JR6toJN
         43JbrX53v9M+pQQd6/xlqy3BpyAcKpLn8LGlIIzHFgzhdlhOi+enRRVBYbdpJJKIbZzs
         i1o7U8Dcx73bHU30axO6Ij6eo++SDfT5+KrfNRxGeibPhjEiviBn2lR4LF6l5lDVdvQd
         xXS1w5z5VlxzWFbfwNz/4d23SwAKnlpORQ8h08fMBe7EzkQTVyYhFR3/3BrKLnIeOoyY
         e1NA==
X-Gm-Message-State: AOAM533q3ClNsJN44oZ1YV4XFig9bUUtH660hSB60/lt7FNISOdXMsor
        WJ5C4qG4WMhSDXX33xdyf9xYsrmcVisX5hYHYOuVFA==
X-Google-Smtp-Source: ABdhPJwDrg6IREZgfK3FKe60lOcv304qCnNwmMnOuGJueDEDbEPxsP5SKNWyJSrQ/HkYnrQ/DokGtHbNTylYlCtGH3o=
X-Received: by 2002:a05:6a00:e14:b0:4fe:3cdb:23f with SMTP id
 bq20-20020a056a000e1400b004fe3cdb023fmr19497787pfb.86.1650397514500; Tue, 19
 Apr 2022 12:45:14 -0700 (PDT)
MIME-Version: 1.0
References: <20220407191347.9681-1-jithu.joseph@intel.com> <20220419163859.2228874-1-tony.luck@intel.com>
 <20220419163859.2228874-3-tony.luck@intel.com> <Yl7n5TSCnoksz6jp@kroah.com>
In-Reply-To: <Yl7n5TSCnoksz6jp@kroah.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 19 Apr 2022 12:45:03 -0700
Message-ID: <CAPcyv4he5cbftv1VpChc+ifS7Q+TyFbmU68=7UJ6_qwMTQUrCg@mail.gmail.com>
Subject: Re: [PATCH v3 02/11] Documentation: In-Field Scan
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

On Tue, Apr 19, 2022 at 9:48 AM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Tue, Apr 19, 2022 at 09:38:50AM -0700, Tony Luck wrote:
> > Add documentation for In-Field Scan (IFS). This documentation
> > describes the basics of IFS, the loading IFS image, chunk
> > authentication, running scan and how to check result via sysfs
> > as well as tunable parameters.
> >
> > The CORE_CAPABILITIES MSR enumerates whether IFS is supported.
> >
> > The full  github location for distributing the IFS images is
> > still being decided. So just a placeholder included for now
> > in the documentation.
> >
> > Future CPUs will support more than one type of test. Plan for
> > that now by using a ".0" suffix on the ABI directory names.
> > Additional test types will use ".1", etc.
> >
> > Reviewed-by: Dan Williams <dan.j.williams@intel.com>
> > Signed-off-by: Tony Luck <tony.luck@intel.com>
> > ---
> >  Documentation/x86/ifs.rst   | 101 ++++++++++++++++++++++++++++++++++++
> >  Documentation/x86/index.rst |   1 +
> >  2 files changed, 102 insertions(+)
> >  create mode 100644 Documentation/x86/ifs.rst
> >
> > diff --git a/Documentation/x86/ifs.rst b/Documentation/x86/ifs.rst
> > new file mode 100644
> > index 000000000000..62f3c07d433a
> > --- /dev/null
> > +++ b/Documentation/x86/ifs.rst
> > @@ -0,0 +1,101 @@
> > +.. SPDX-License-Identifier: GPL-2.0
> > +
> > +=============
> > +In-Field Scan
> > +=============
> > +
> > +Introduction
> > +------------
> > +
> > +In Field Scan (IFS) is a hardware feature to run circuit level tests on
> > +a CPU core to detect problems that are not caught by parity or ECC checks.
> > +Future CPUs will support more than one type of test which will show up
> > +with a new platform-device instance-id, for now only .0 is exposed.
> > +
> > +
> > +IFS Image
> > +---------
> > +
> > +Intel provides a firmware file containing the scan tests via
> > +github [#f1]_.  Similar to microcode there is a separate file for each
> > +family-model-stepping.
> > +
> > +IFS Image Loading
> > +-----------------
> > +
> > +The driver loads the tests into memory reserved BIOS local to each CPU
> > +socket in a two step process using writes to MSRs to first load the
> > +SHA hashes for the test. Then the tests themselves. Status MSRs provide
> > +feedback on the success/failure of these steps. When a new test file
> > +is installed it can be loaded by writing to the driver reload file::
> > +
> > +  # echo 1 > /sys/bus/platform/drivers/intel_ifs.0/reload
> > +
> > +Similar to microcode, the current version of the scan tests is stored
> > +in a fixed location: /lib/firmware/intel/ifs.0/family-model-stepping.scan
> > +
> > +Running tests
> > +-------------
> > +
> > +Tests are run by the driver synchronizing execution of all threads on a
> > +core and then writing to the ACTIVATE_SCAN MSR on all threads. Instruction
> > +execution continues when:
> > +
> > +1) All tests have completed.
> > +2) Execution was interrupted.
> > +3) A test detected a problem.
> > +
> > +In all cases reading the SCAN_STATUS MSR provides details on what
> > +happened. The driver makes the value of this MSR visible to applications
> > +via the "details" file (see below). Interrupted tests may be restarted.
> > +
> > +The IFS driver provides sysfs interfaces via /sys/devices/platform/intel_ifs.0/
> > +to control execution:
> > +
> > +Test a specific core::
> > +
> > +  # echo <cpu#> > /sys/devices/platform/intel_ifs.0/run_test
> > +
> > +when HT is enabled any of the sibling cpu# can be specified to test its
> > +corresponding physical core. Since the tests are per physical core, the
> > +result of testing any thread is same. It is only necessary to test one
> > +thread.
> > +
> > +For e.g. to test core corresponding to cpu5
> > +
> > +  # echo 5 > /sys/devices/platform/intel_ifs.0/run_test
> > +
> > +Results of the last test is provided in /sys::
> > +
> > +  $ cat /sys/devices/platform/intel_ifs.0/status
> > +  pass
>
> sysfs documentation belongs in Documentation/ABI/
>
> And why not just include this whole thing in the driver itself and suck
> the documentation out of that?  No need to have a separate file.

At a minimum a separate file is needed to house the
---
 .. kernel-doc:: $source_file
   :doc: $header
---
...statements, but ok, I'll recommend that going forward to
de-emphasize shipping content directly from Documentation/ when it can
be ingested from "DOC:" source. I had been assuming DOC: blocks in the
code were more for augmenting kernel-doc on driver internal ABIs and
not longer theory of operation documentation that is an awkward fit
for Documentation/ABI/.
