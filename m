Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8267C5075D1
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 19:01:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235243AbiDSQ4q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 12:56:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355658AbiDSQxY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 12:53:24 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B3323C708;
        Tue, 19 Apr 2022 09:48:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D70F5B81C07;
        Tue, 19 Apr 2022 16:48:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19F5EC385A7;
        Tue, 19 Apr 2022 16:48:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1650386919;
        bh=QOMS7KLEHZGEz3no8RbaBIVj+K/SNB015Dr7S2LBI7g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YWnqwfS6FQOqhotaDyxXSpeMaZVt6GxtLZhWlcqTx0VaXaxxzthVaONrVNl4Fpg+M
         U3iIBFkMBV0Da0G/8cK0LS3rdfqQC2URdVDjnTOay6z7vMmcTCU9+0RwiHlfknojAh
         /2vClM2WnTy6W4VU+0MgMbdVvrjS2swwKMBwTXSQ=
Date:   Tue, 19 Apr 2022 18:48:37 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Tony Luck <tony.luck@intel.com>
Cc:     hdegoede@redhat.com, markgross@kernel.org, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        x86@kernel.org, hpa@zytor.com, corbet@lwn.net,
        andriy.shevchenko@linux.intel.com, jithu.joseph@intel.com,
        ashok.raj@intel.com, rostedt@goodmis.org, dan.j.williams@intel.com,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, patches@lists.linux.dev,
        ravi.v.shankar@intel.com
Subject: Re: [PATCH v3 02/11] Documentation: In-Field Scan
Message-ID: <Yl7n5TSCnoksz6jp@kroah.com>
References: <20220407191347.9681-1-jithu.joseph@intel.com>
 <20220419163859.2228874-1-tony.luck@intel.com>
 <20220419163859.2228874-3-tony.luck@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220419163859.2228874-3-tony.luck@intel.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 19, 2022 at 09:38:50AM -0700, Tony Luck wrote:
> Add documentation for In-Field Scan (IFS). This documentation
> describes the basics of IFS, the loading IFS image, chunk
> authentication, running scan and how to check result via sysfs
> as well as tunable parameters.
> 
> The CORE_CAPABILITIES MSR enumerates whether IFS is supported.
> 
> The full  github location for distributing the IFS images is
> still being decided. So just a placeholder included for now
> in the documentation.
> 
> Future CPUs will support more than one type of test. Plan for
> that now by using a ".0" suffix on the ABI directory names.
> Additional test types will use ".1", etc.
> 
> Reviewed-by: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Tony Luck <tony.luck@intel.com>
> ---
>  Documentation/x86/ifs.rst   | 101 ++++++++++++++++++++++++++++++++++++
>  Documentation/x86/index.rst |   1 +
>  2 files changed, 102 insertions(+)
>  create mode 100644 Documentation/x86/ifs.rst
> 
> diff --git a/Documentation/x86/ifs.rst b/Documentation/x86/ifs.rst
> new file mode 100644
> index 000000000000..62f3c07d433a
> --- /dev/null
> +++ b/Documentation/x86/ifs.rst
> @@ -0,0 +1,101 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +=============
> +In-Field Scan
> +=============
> +
> +Introduction
> +------------
> +
> +In Field Scan (IFS) is a hardware feature to run circuit level tests on
> +a CPU core to detect problems that are not caught by parity or ECC checks.
> +Future CPUs will support more than one type of test which will show up
> +with a new platform-device instance-id, for now only .0 is exposed.
> +
> +
> +IFS Image
> +---------
> +
> +Intel provides a firmware file containing the scan tests via
> +github [#f1]_.  Similar to microcode there is a separate file for each
> +family-model-stepping.
> +
> +IFS Image Loading
> +-----------------
> +
> +The driver loads the tests into memory reserved BIOS local to each CPU
> +socket in a two step process using writes to MSRs to first load the
> +SHA hashes for the test. Then the tests themselves. Status MSRs provide
> +feedback on the success/failure of these steps. When a new test file
> +is installed it can be loaded by writing to the driver reload file::
> +
> +  # echo 1 > /sys/bus/platform/drivers/intel_ifs.0/reload
> +
> +Similar to microcode, the current version of the scan tests is stored
> +in a fixed location: /lib/firmware/intel/ifs.0/family-model-stepping.scan
> +
> +Running tests
> +-------------
> +
> +Tests are run by the driver synchronizing execution of all threads on a
> +core and then writing to the ACTIVATE_SCAN MSR on all threads. Instruction
> +execution continues when:
> +
> +1) All tests have completed.
> +2) Execution was interrupted.
> +3) A test detected a problem.
> +
> +In all cases reading the SCAN_STATUS MSR provides details on what
> +happened. The driver makes the value of this MSR visible to applications
> +via the "details" file (see below). Interrupted tests may be restarted.
> +
> +The IFS driver provides sysfs interfaces via /sys/devices/platform/intel_ifs.0/
> +to control execution:
> +
> +Test a specific core::
> +
> +  # echo <cpu#> > /sys/devices/platform/intel_ifs.0/run_test
> +
> +when HT is enabled any of the sibling cpu# can be specified to test its
> +corresponding physical core. Since the tests are per physical core, the
> +result of testing any thread is same. It is only necessary to test one
> +thread.
> +
> +For e.g. to test core corresponding to cpu5
> +
> +  # echo 5 > /sys/devices/platform/intel_ifs.0/run_test
> +
> +Results of the last test is provided in /sys::
> +
> +  $ cat /sys/devices/platform/intel_ifs.0/status
> +  pass

sysfs documentation belongs in Documentation/ABI/

And why not just include this whole thing in the driver itself and suck
the documentation out of that?  No need to have a separate file.

thanks,

greg k-h
