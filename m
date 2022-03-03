Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 279D44CC6AA
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 20:59:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235760AbiCCT77 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 14:59:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235678AbiCCT74 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 14:59:56 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1D9719CCC8;
        Thu,  3 Mar 2022 11:59:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646337550; x=1677873550;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Pwhtk1GrrqE/4VynDFryxgHiiPKn9d6coiqO1HnGW5Q=;
  b=Jj8P/Zy5EOtwhxQnbeJD9jTMAuvKkvB+vn4VJdhIrY8E/ZfDt8HCpqMc
   9A5EV28QpCAUJ1ST27kr3x8rpUEs2qawQrHMQ6liC0t4uU7+okuJC2vyG
   +tUt/tvQthPXOHAVKQXdlAvlTKH/hOGOxZHOB6YaT9FMaEnN2UIlG4Ab5
   hDB2+KHhABfpvqLFMKgeuPlRR85Q1u3yQNl0Za+xk4FlO58eK+EiM78pC
   GvLKHJGcpzkThyT1qvC9kFYkh17in7AUwbSDnv8SyhycDu5+LpEVO1Ecx
   uWp6jfa89lEb+yKEL9ZIPyurC//CXKpz2xsMCcSIO3JKR85YF9SJd0pcL
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10275"; a="251373167"
X-IronPort-AV: E=Sophos;i="5.90,153,1643702400"; 
   d="scan'208";a="251373167"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2022 11:59:10 -0800
X-IronPort-AV: E=Sophos;i="5.90,153,1643702400"; 
   d="scan'208";a="630922010"
Received: from agluck-desk3.sc.intel.com ([172.25.222.60])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2022 11:59:10 -0800
Date:   Thu, 3 Mar 2022 11:59:09 -0800
From:   "Luck, Tony" <tony.luck@intel.com>
To:     "Williams, Dan J" <dan.j.williams@intel.com>
Cc:     "hdegoede@redhat.com" <hdegoede@redhat.com>,
        "markgross@kernel.org" <markgross@kernel.org>,
        "Joseph, Jithu" <jithu.joseph@intel.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "Raj, Ashok" <ashok.raj@intel.com>,
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
Subject: Re: [RFC 07/10] platform/x86/intel/ifs: Create kthreads for online
 cpus for scan test
Message-ID: <YiEeDfuQyqperN9x@agluck-desk3.sc.intel.com>
References: <20220301195457.21152-1-jithu.joseph@intel.com>
 <20220301195457.21152-8-jithu.joseph@intel.com>
 <09b5b05018a8600ca8fab896790ab16827c80e4e.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <09b5b05018a8600ca8fab896790ab16827c80e4e.camel@intel.com>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 02, 2022 at 08:17:32PM -0800, Williams, Dan J wrote:

> What is this requirement to try to synchronize CPU execution? Comments
> should explain the "why", the code usually explains the "what".

I need to put some more bits into the Documentation/x86/ifs.rst
because if I had explained the IFS feature better there, you wouldn't
have had to ask this (and some other questions).

IFS works on one CORE at a time. But with HT enabled there are two
logical CPUs that are on that core.

Entering IFS test mode is done by all HT threads writing to the
ACTIVATE_SCAN MSR "together". The microcode for that MSR will
make the first logical CPU to write wait for a while. User can
choose how many cycles to wait with some of the bits in the value
written to the MSR ... in this driver we hard coded 5 milli-seconds.
That seemed plenty to allow for the bottom half of interrupts, or
a perf NMI to knock the HT threads a little bit out of sync with
each other.

So the code flow when running a test is to wake the kthreads for
the logical CPUs that share the core. The threads may wake at
different times, so there is the software sync to get them close
enough.

Then comes the loop to execute the test ... it is a loop because
the core may not complete all "chunks" in one ACTIVATE_SCAN
MSR write ... if it doesn't, the loop restarts execution from
the chunk where IFS execution stopped.

Interrupts are only blocked during the ACTIVATE_SCAN to
increase the chances of completion. But preemption is
disabled for the whole loop so that the threads won't
get too far out of sync.

-Tony
