Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27B124CA6DA
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 15:00:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241548AbiCBOBN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 09:01:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240897AbiCBOBJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 09:01:09 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE3197C148;
        Wed,  2 Mar 2022 06:00:25 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8EAD6B81FEC;
        Wed,  2 Mar 2022 14:00:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7301DC340F1;
        Wed,  2 Mar 2022 14:00:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646229623;
        bh=JIzJgdja99gaS0mVD7G0oF0YG123mLDRGSr0/UKFBY8=;
        h=In-Reply-To:References:Date:From:To:Cc:Subject:From;
        b=Oyvc2LCtHuYPoFjcL5M8fI1RSTHr6U47iRjuhzOIY2yyBFmfeLhy1UdfepnP8EOBA
         jyfBZ8akpF4nNhJd72EJmiKCuscf0oPUiawa/Yw85AybTi+KQK5XJ/2+vJpyFVJdBO
         DQbY8OFx4xY5QcFEq1V0ekMLw9lefiJZKk6akTAFaw2Z0yzr90TbO37oYKW27mtwsa
         C4sJvTZv1WH2inFpAl8NjZ53MBai5+MaH1eRt37cDnJBpMKqjqVvZAR8qEep1cm7qs
         KQrLrJSqDhTAMxVZ39TNNHUIeOTmic67b9Oqu9pehoq9ZiI+CRdp3amu6deR4QABoG
         TZjxly3pvbtcQ==
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailauth.nyi.internal (Postfix) with ESMTP id 0AEB627C005B;
        Wed,  2 Mar 2022 09:00:20 -0500 (EST)
Received: from imap48 ([10.202.2.98])
  by compute5.internal (MEProxy); Wed, 02 Mar 2022 09:00:21 -0500
X-ME-Sender: <xms:c3gfYlJApHOxbxXXVZkJ7-wOP_8jNSzmT5CRY2W1uLgU75SJ0EoHWQ>
    <xme:c3gfYhIrR34AvJoz4dnUDY8NtkAAaqb13smpvByKEMSy48dAmf_Wnz2olEBzoAcwF
    V5GjHUzFmbvvEdRLUo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddruddtgedghedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvffutgesthdtredtreertdenucfhrhhomhepfdetnhgu
    hicunfhuthhomhhirhhskhhifdcuoehluhhtoheskhgvrhhnvghlrdhorhhgqeenucggtf
    frrghtthgvrhhnpedthfehtedtvdetvdetudfgueeuhfdtudegvdelveelfedvteelfffg
    fedvkeegfeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpegrnhguhidomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqudduiedukeeh
    ieefvddqvdeifeduieeitdekqdhluhhtoheppehkvghrnhgvlhdrohhrgheslhhinhhugi
    drlhhuthhordhush
X-ME-Proxy: <xmx:c3gfYtva9_xsK0Y0-8xy2xczyzGJ6FMkaecx0S-_VWAmFlh732Quhw>
    <xmx:c3gfYmZd8FTx0ve2eQEgHlXS08flnULGDUuAdknZQtOzbH-uk7LxbQ>
    <xmx:c3gfYsYsjejDFL4psgWiRUGEU1lpkC8dKlc-p3eWmWng5_ZeDdX29g>
    <xmx:dHgfYmtrKbSDiBae5ya_UVTnLzmSIdIokF669pN5Dlh0d9eiNKuKZ4XJkeg>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id B0E8F21E0073; Wed,  2 Mar 2022 09:00:19 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.5.0-alpha0-4778-g14fba9972e-fm-20220217.001-g14fba997
Mime-Version: 1.0
Message-Id: <1b793ead-a47c-4719-b7b5-cba7d49633f2@www.fastmail.com>
In-Reply-To: <20220301195457.21152-1-jithu.joseph@intel.com>
References: <20220301195457.21152-1-jithu.joseph@intel.com>
Date:   Wed, 02 Mar 2022 05:59:59 -0800
From:   "Andy Lutomirski" <luto@kernel.org>
To:     "Jithu Joseph" <jithu.joseph@intel.com>, hdegoede@redhat.com,
        markgross@kernel.org
Cc:     "Thomas Gleixner" <tglx@linutronix.de>,
        "Ingo Molnar" <mingo@redhat.com>, "Borislav Petkov" <bp@alien8.de>,
        "Dave Hansen" <dave.hansen@linux.intel.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Jonathan Corbet" <corbet@lwn.net>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        "Andy Shevchenko" <andriy.shevchenko@linux.intel.com>,
        "Raj Ashok" <ashok.raj@intel.com>,
        "Tony Luck" <tony.luck@intel.com>,
        "Steven Rostedt" <rostedt@goodmis.org>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        linux-doc@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        patches@lists.linux.dev,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>
Subject: Re: [RFC 00/10] Introduce In Field Scan driver
Content-Type: text/plain
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, Mar 1, 2022, at 11:54 AM, Jithu Joseph wrote:
> Note to Maintainers:
> Requesting x86 Maintainers to take a look at patch01 as it
> touches arch/x86 portion of the kernel. Also would like to guide them
> to patch07 which sets up hotplug notifiers and creates kthreads.
>
> Patch 2/10 - Adds Documentation. Requesting Documentation maintainer to 
> review it.
>
> Requesting Greg KH to review the sysfs changes added by patch08.
>
> Patch10 adds tracing support, requesting Steven Rostedt to review that.
>
> Rest of the patches adds the IFS platform driver, requesting Platform 
> driver maintainers
> to review them.
>
>
> In Field Scan (IFS) is a hardware feature to run circuit level tests on
> a CPU core to detect problems that are not caught by parity or ECC checks.
>
> Intel will provide a firmware file containing the scan tests.  Similar to
> microcode there is a separate file for each family-model-stepping. The
> tests in the file are divided into some number of "chunks" that can be
> run individually.
>
> The driver loads the tests into memory reserved BIOS local to each CPU
> socket in a two step process using writes to MSRs to first load the
> SHA hashes for the test. Then the tests themselves. Status MSRs provide
> feedback on the success/failure of these steps.
>
> Tests are run by synchronizing execution of all threads on a core and
> then writing to the ACTIVATE_SCAN MSR on all threads. Instruction
> execution continues when:
>
> 1) all tests have completed
> 2) execution was interrupted
> 3) a test detected a problem
>
> In all cases reading the SCAN_STATUS MSR provides details on what
> happened. Interrupted tests may be restarted.
>
> The IFS driver provides interfaces from /sys to reload tests and to
> control execution:
>
> /sys/devices/system/cpu/ifs/reload
>   Writing "1" to this file will reload the tests from
>   /lib/firmware/intel/ifs/{ff-mm-ss}.scan

IMO this interface is wrong.  /lib/firmware is for firmware (or ucode, etc) files that should be provided by a distribution and loaded, as needed, by a driver so the hardware can function.  This is not at all what IFS does. For IFS, an administrator wants to run a specific test, and the test blob is part of the instruction to run the test.  The distribution should not be involved, and this should work even on systems where /lib/firmware is immutable.

So either the blob should be written to a file in sysfs or it should be supplied by write or ioctl to a device node.

>
> /sys/devices/system/cpu/ifs/run_test
>   Writing "1" to this file will trigger a scan on each core
>   sequentially by logical CPU number (when HT is enabled this only
>   runs the tests once for each core)
>
> /sys/devices/system/cpu/cpu#/ifs/run_test
>   Writing "1" to one of these files will trigger a scan on just
>   that core.
>
> Results of the tests are also provided in /sys:
>
> /sys/devices/system/cpu/ifs/status
>   Global status. Will show the most serious status across
>   all cores (fail > untested > pass)
>
> /sys/devices/system/cpu/ifs/cpu_fail_list
> /sys/devices/system/cpu/ifs/cpu_pass_list
> /sys/devices/system/cpu/ifs/cpu_untested_list
>   CPU lists showing which CPUs have which test status
>
> /sys/devices/system/cpu/cpu#/ifs/status
>   Status (pass/fail/untested) of each core
>
> /sys/devices/system/cpu/cpu#/ifs/details
>   Hex value of the SCAN_STATUS MSR for the most recent test on
>   this core. Note that the error_code field may contain driver
>   defined software code not defined in the Intel SDM.
>
> Current driver limitations:
>
> 1) The ACTIVATE_SCAN MSR allows for running any consecutive subrange or
> available tests. But the driver always tries to run all tests and only
> uses the subrange feature to restart an interrupted test.
>
> 2) Hardware allows for some number of cores to be tested in parallel.
> The driver does not make use of this, it only tests one core at a time.
>
>
> Jithu Joseph (8):
>   x86/microcode/intel: expose collect_cpu_info_early() for IFS
>   platform/x86/intel/ifs: Add driver for In-Field Scan
>   platform/x86/intel/ifs: Load IFS Image
>   platform/x86/intel/ifs: Check IFS Image sanity
>   platform/x86/intel/ifs: Authenticate and copy to secured memory
>   platform/x86/intel/ifs: Create kthreads for online cpus for scan test
>   platform/x86/intel/ifs: Add IFS sysfs interface
>   platform/x86/intel/ifs: add ABI documentation for IFS
>
> Tony Luck (2):
>   Documentation: In-Field Scan
>   trace: platform/x86/intel/ifs: Add trace point to track Intel IFS
>     operations
>
>  Documentation/ABI/stable/sysfs-driver-ifs |  85 +++++
>  Documentation/x86/ifs.rst                 | 108 ++++++
>  Documentation/x86/index.rst               |   1 +
>  MAINTAINERS                               |   7 +
>  arch/x86/include/asm/microcode_intel.h    |   6 +
>  arch/x86/kernel/cpu/microcode/intel.c     |   8 +-
>  drivers/platform/x86/intel/Kconfig        |   1 +
>  drivers/platform/x86/intel/Makefile       |   1 +
>  drivers/platform/x86/intel/ifs/Kconfig    |   9 +
>  drivers/platform/x86/intel/ifs/Makefile   |   7 +
>  drivers/platform/x86/intel/ifs/core.c     | 387 +++++++++++++++++++++
>  drivers/platform/x86/intel/ifs/ifs.h      | 155 +++++++++
>  drivers/platform/x86/intel/ifs/load.c     | 299 ++++++++++++++++
>  drivers/platform/x86/intel/ifs/sysfs.c    | 394 ++++++++++++++++++++++
>  include/trace/events/ifs.h                |  38 +++
>  15 files changed, 1503 insertions(+), 3 deletions(-)
>  create mode 100644 Documentation/ABI/stable/sysfs-driver-ifs
>  create mode 100644 Documentation/x86/ifs.rst
>  create mode 100644 drivers/platform/x86/intel/ifs/Kconfig
>  create mode 100644 drivers/platform/x86/intel/ifs/Makefile
>  create mode 100644 drivers/platform/x86/intel/ifs/core.c
>  create mode 100644 drivers/platform/x86/intel/ifs/ifs.h
>  create mode 100644 drivers/platform/x86/intel/ifs/load.c
>  create mode 100644 drivers/platform/x86/intel/ifs/sysfs.c
>  create mode 100644 include/trace/events/ifs.h
>
> -- 
> 2.17.1
