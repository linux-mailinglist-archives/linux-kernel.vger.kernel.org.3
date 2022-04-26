Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D5C5510CDE
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 01:53:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243690AbiDZX43 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 19:56:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230094AbiDZX4X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 19:56:23 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCF3EBB91B;
        Tue, 26 Apr 2022 16:53:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651017194; x=1682553194;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=khnX1ty93jUwk1ufPotG1fbs/K/3Ddf4V9dX4JV7/uw=;
  b=RDrWI4+gCuCPbkxN2elDVgQ1+97GO1Cv3ryfzQ5iXuQZv+AzU2jdY4vP
   88VNmVdSbkWlcdTv0z7sjTBfMWY/65KKwraq6v/g3w0vsEgdrZ1SA0U2w
   S+egZI2l97Q+EKkVk1km1aS81G8LKKgzXCPZBPlOTK7M47eK/7ansR+SM
   Nvk+bOrqbWK7/UdxdVb10ZbuWg5VNrQlYzfEY6K3uJ7iejlUclMm9909P
   QRI2/SOsrha46buwxxl27jNmZS4ZT8Rgzb93GjkCp4Gsr0E/erJK2HUVT
   O2ouzW0xxBySScAx+wavucFd5H6FRx89JyCMDizeV5DSFDbBMygJr2c9C
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10329"; a="265921491"
X-IronPort-AV: E=Sophos;i="5.90,292,1643702400"; 
   d="scan'208";a="265921491"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2022 16:53:14 -0700
X-IronPort-AV: E=Sophos;i="5.90,292,1643702400"; 
   d="scan'208";a="660942056"
Received: from agluck-desk3.sc.intel.com ([172.25.222.78])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2022 16:53:14 -0700
Date:   Tue, 26 Apr 2022 16:53:13 -0700
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     "hdegoede@redhat.com" <hdegoede@redhat.com>,
        "markgross@kernel.org" <markgross@kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "andriy.shevchenko@linux.intel.com" 
        <andriy.shevchenko@linux.intel.com>,
        "Joseph, Jithu" <jithu.joseph@intel.com>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>,
        "patches@lists.linux.dev" <patches@lists.linux.dev>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>
Subject: Re: [PATCH v4 09/10] trace: platform/x86/intel/ifs: Add trace point
 to track Intel IFS operations
Message-ID: <YmiF6Rsy04pUHVQo@agluck-desk3.sc.intel.com>
References: <20220419163859.2228874-1-tony.luck@intel.com>
 <20220422200219.2843823-1-tony.luck@intel.com>
 <20220422200219.2843823-10-tony.luck@intel.com>
 <20220425105251.3f5e8021@gandalf.local.home>
 <1752057af33e4eb28bcea0fd75e44048@intel.com>
 <20220425214928.2aac3391@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220425214928.2aac3391@gandalf.local.home>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 25, 2022 at 09:49:28PM -0400, Steven Rostedt wrote:
> On Mon, 25 Apr 2022 16:49:35 +0000
> "Luck, Tony" <tony.luck@intel.com> wrote:
> 
> > I see two paths:
> > 
> > 1) Create a new user friendly trace point for each new scan mode.
> > 2) Just provide a generic one that dumps both the 64-bit WRMSR and RDMSR values.
> > 
> > Q: Are trace points "expensive" in some way ... so better to just have one than three?
> >      Or are the cheap enough that decoding for the user is an OK thing?
> 
> Yes, they are expensive as each TRACE_EVENT() can add a few KB of text and
> data. But you can add a DECLARE_EVENT_CLASS() and then add "printk"
> differences that are less memory heavy.
> 
> See DEFINE_EVENT_PRINT().

I looked at the examples in samples/trace_events/trace-events-sample.h
and tried to use this. But I'm doing something wrong because the
compiler barfs on something defined but not used.

Maybe my problem is the TP_printk() in the DECLARE_EVENT_CLASS() that
is over-ridden by DEFINE_EVENT_PRINT(). I wasn't at all sure what to
put here ... or how to use the base tracepoint that doesn't have the
printk() over-ridden.

I think I need my class to just save both the u64 values to the trace
buffer. Then the different trace points will extract the bits they want
and print in a user friendly way. While this increases space used in
the trace buffer, these events are not crazy high frequency. Usually 
one or two events per core with a gap 30 minutes or more between tests.

In my ".c" file the tracepoint looks like this using the name from
DEFINE_EVENT_PRINT(), and now passing the full u64 values:

	trace_ifs_status_saf(activate.data, status.data);

and my #include file looks like this:

----------------------------------------------
/* SPDX-License-Identifier: GPL-2.0 */
#undef TRACE_SYSTEM
#define TRACE_SYSTEM intel_ifs

#if !defined(_TRACE_IFS_H) || defined(TRACE_HEADER_MULTI_READ)
#define _TRACE_IFS_H

#include <linux/ktime.h>
#include <linux/tracepoint.h>

DECLARE_EVENT_CLASS(ifs_status,

	TP_PROTO(u64 activate, u64 status),

	TP_ARGS(activate, status),

	TP_STRUCT__entry(
		__field(	u64,	activate	)
		__field(	u64,	status		)
	),

	TP_fast_assign(
		__entry->activate = activate;
		__entry->status	= status;
	),

	TP_printk("activate: %llx status: %llx",
		__entry->activate,
		__entry->status)
);

DEFINE_EVENT_PRINT(ifs_status, ifs_status_saf,
	TP_PROTO(u64 activate, u64 status),
	TP_ARGS(activate, status),
	TP_printk("start: %.2x, stop: %.2x, status: %llx",
		((union ifs_scan *)&(__entry->activate))->start,
		((union ifs_scan *)&(__entry->activate))->stop,
		__entry->status)
);

#endif /* _TRACE_IFS_H */

/* This part must be outside protection */
#include <trace/define_trace.h>
-----------------------------------------------------

GCC messages:


  CC [M]  drivers/platform/x86/intel/ifs/runtest.o
In file included from /home/agluck/GIT/mywork/include/trace/define_trace.h:102,
                 from /home/agluck/GIT/mywork/include/trace/events/intel_ifs.h:44,
                 from /home/agluck/GIT/mywork/drivers/platform/x86/intel/ifs/runtest.c:27:
/home/agluck/GIT/mywork/include/trace/trace_events.h:426:13: warning: ‘print_fmt_ifs_status’ defined but not used [-Wunused-variable]
  426 | static char print_fmt_##call[] = print;                                 \
      |             ^~~~~~~~~~
/home/agluck/GIT/mywork/include/trace/events/intel_ifs.h:11:1: note: in expansion of macro ‘DECLARE_EVENT_CLASS’
   11 | DECLARE_EVENT_CLASS(ifs_status,
      | ^~~~~~~~~~~~~~~~~~~
In file included from /home/agluck/GIT/mywork/include/trace/define_trace.h:102,
                 from /home/agluck/GIT/mywork/include/trace/events/intel_ifs.h:44,
                 from /home/agluck/GIT/mywork/drivers/platform/x86/intel/ifs/runtest.c:27:
/home/agluck/GIT/mywork/include/trace/trace_events.h:207:37: warning: ‘trace_event_type_funcs_ifs_status’ defined but not used [-Wunused-variable]
  207 | static struct trace_event_functions trace_event_type_funcs_##call = {   \
      |                                     ^~~~~~~~~~~~~~~~~~~~~~~
/home/agluck/GIT/mywork/include/trace/events/intel_ifs.h:11:1: note: in expansion of macro ‘DECLARE_EVENT_CLASS’
   11 | DECLARE_EVENT_CLASS(ifs_status,
      | ^~~~~~~~~~~~~~~~~~~
make[1]: Leaving directory '/home/agluck/GIT/mywork/build/ifsv5-rc1'

-Tony
