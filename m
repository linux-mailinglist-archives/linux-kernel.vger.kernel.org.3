Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87DC64D901A
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 00:10:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343585AbiCNXLw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 19:11:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230021AbiCNXLu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 19:11:50 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A64273BF8E;
        Mon, 14 Mar 2022 16:10:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647299440; x=1678835440;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=6C9nVg8jyii5VHo88KHjPTiSG9eWD7pgA09gtw2HDFo=;
  b=RsAX6IxqipUuwfY7L5im2eSk7jSsDzRGNpSRuCJNOK3xhy7X8PCFAaZM
   +Y9fQWmMewXbJNdDydzHKR99l+Sbu17WRI+QegzDqbac43yL9KdaM1nca
   4XCvv4J8S2+pUZwfnUrwuUkJXsmZYsRlyNcR0vK0MKYtIFlatUTdm17dA
   7UmjjRxYqG99NXIXoYV25OFZslmANhf8KzGUCSPDUH4HVcvUZEvjcqtxi
   fhKiFhY8OJkIqW21P/M+Vj3ua4sdGxT4IIPduhgrx6unKT3o52AlgkS5A
   1dxpxxuXStS7yo315mwf4lgB4cPd3813eysApsHQft7W7Zs+oH52yMpWV
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10286"; a="253726560"
X-IronPort-AV: E=Sophos;i="5.90,181,1643702400"; 
   d="scan'208";a="253726560"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2022 16:10:40 -0700
X-IronPort-AV: E=Sophos;i="5.90,181,1643702400"; 
   d="scan'208";a="598096916"
Received: from agluck-desk3.sc.intel.com ([172.25.222.60])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2022 16:10:40 -0700
Date:   Mon, 14 Mar 2022 16:10:39 -0700
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Jithu Joseph <jithu.joseph@intel.com>, hdegoede@redhat.com,
        markgross@kernel.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
        hpa@zytor.com, corbet@lwn.net, andriy.shevchenko@linux.intel.com,
        ashok.raj@intel.com, rostedt@goodmis.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, patches@lists.linux.dev,
        ravi.v.shankar@intel.com, Dan Williams <dan.j.williams@intel.com>
Subject: Re: [RFC 00/10] Introduce In Field Scan driver
Message-ID: <Yi/Lb5laEki0JHft@agluck-desk3.sc.intel.com>
References: <20220301195457.21152-1-jithu.joseph@intel.com>
 <Yh59rOIH24X+6GyI@kroah.com>
 <Yh5+om/Nr06V0+Qj@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yh5+om/Nr06V0+Qj@kroah.com>
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 01, 2022 at 09:14:26PM +0100, Greg KH wrote:
> On Tue, Mar 01, 2022 at 09:10:20PM +0100, Greg KH wrote:
> > On Tue, Mar 01, 2022 at 11:54:47AM -0800, Jithu Joseph wrote:
> > > Note to Maintainers:
> > > Requesting x86 Maintainers to take a look at patch01 as it
> > > touches arch/x86 portion of the kernel. Also would like to guide them
> > > to patch07 which sets up hotplug notifiers and creates kthreads.
> > > 
> > > Patch 2/10 - Adds Documentation. Requesting Documentation maintainer to review it.
> > > 
> > > Requesting Greg KH to review the sysfs changes added by patch08.
> > 
> > "RFC" means you are not comfortable submitting the changes yet, so you
> > don't need my review at this point in time.  Become confident in your
> > changes before asking for others to review the code please.
> 
> Hint, it needs work, sysfs_emit() for one thing, lack of reference
> counting on your cpu objects is another...

Greg,

Thanks for the comments. They triggered a bunch of internal
re-thinking of the interface.  One idea that has some traction
(Credit/Blame: Dan Williams) is to:

1) Don't put anything in /sys/devices/system/cpu/*
2) Driver creates some info/control files in its own
   corner of /sys/devices/.../ifs
3) No per-cpu files ... run a test with:
   # echo ${cpu} > /sys/devices/.../ifs/run_test
4) No test result files.
   When tests complete they report using uevents

Using uevent to report means that we can easily have
mutiple parts to the result (pass/fail/incomplete status, as well
as diagnostic details about the reason for the failure,
or why the test was not completed).

This seems a novel use of uevent ... is it OK, or is is abuse?

Thanks

-Tony
