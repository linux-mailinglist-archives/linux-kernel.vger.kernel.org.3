Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73A314985C0
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 18:05:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244173AbiAXRFF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 12:05:05 -0500
Received: from mga09.intel.com ([134.134.136.24]:37754 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244205AbiAXREs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 12:04:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643043888; x=1674579888;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=5GW29a7dNLwPV7sPNKD+sRYk/vKbBA0PW2mGmkEjUQA=;
  b=InGaoFLOIPpa/k11Kx1AtYwl+KLr4bSGMTfrpjaXVFtVybDCwMC7wufq
   fGaVZ2ZN6+tFQZZsLkgGn/Gh9pc46dr94EOai4PLRB5EJje+NtQtO32j5
   zVEwUH5oD6kqN5Jqnzsdju1AuYC0tUPphpi9RY/IlJhsaZJb44ub7nWxT
   38Ajgl+vFuIt0IO4gGLgpEhFOGMLErGqom3EfdsGtGM56aaVUQB3ovFx7
   5QLTBZp2GoPOXrRcXHG9aQS0gDJXj+zn3zlBk2KUG6Nko8gBwBlh9ftNj
   tIL6dBs/LeXZl5afLopS1NrdpTdYno/0twGX1zDYkQkEBbP0wIf1qqzG4
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10236"; a="245875352"
X-IronPort-AV: E=Sophos;i="5.88,311,1635231600"; 
   d="scan'208";a="245875352"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2022 09:03:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,311,1635231600"; 
   d="scan'208";a="768741206"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga005.fm.intel.com with ESMTP; 24 Jan 2022 09:03:13 -0800
Received: from [10.209.54.174] (kliang2-MOBL.ccr.corp.intel.com [10.209.54.174])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 1D880580921;
        Mon, 24 Jan 2022 09:03:12 -0800 (PST)
Message-ID: <3bfa617e-007c-ebc3-8c71-0bcb83b24794@linux.intel.com>
Date:   Mon, 24 Jan 2022 12:03:10 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] x86/perf: Default freeze_on_smi on for Comet Lake and
 later.
Content-Language: en-US
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Kyle Huey <me@kylehuey.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        x86@kernel.org, Dave Hansen <dave.hansen@linux.intel.com>,
        Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Namhyung Kim <namhyung@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Robert O'Callahan <rocallahan@gmail.com>,
        Keno Fischer <keno@juliacomputing.com>,
        Andi Kleen <ak@linux.intel.com>
References: <20220122072644.92292-1-khuey@kylehuey.com>
 <Ye6Z31keWVPrsNWU@hirez.programming.kicks-ass.net>
 <3c35dc76-c187-8d3f-7fc9-75de32e7cbf6@linux.intel.com>
 <Ye7UDFAV5/OPaE5N@hirez.programming.kicks-ass.net>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <Ye7UDFAV5/OPaE5N@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/24/2022 11:30 AM, Peter Zijlstra wrote:
> On Mon, Jan 24, 2022 at 11:00:56AM -0500, Liang, Kan wrote:
>>
>>
>> On 1/24/2022 7:21 AM, Peter Zijlstra wrote:
>>> On Fri, Jan 21, 2022 at 11:26:44PM -0800, Kyle Huey wrote:
>>>> Beginning in Comet Lake, Intel extended the concept of privilege rings to
>>>> SMM.[0] A side effect of this is that events caused by execution of code
>>>> in SMM are now visible to performance counters with IA32_PERFEVTSELx.USR
>>>> set.
>>>>
>>>> rr[1] depends on exact counts of performance events for the user space
>>>> tracee, so this change in behavior is fatal for us. It is, however, easily
>>>> corrected by setting IA32_DEBUGCTL.FREEZE_WHILE_SMM to 1 (visible in sysfs
>>>> as /sys/devices/cpu/freeze_on_smi). While we can and will tell our users to
>>>> set freeze_on_smi manually when appropriate, because observing events in
>>>> SMM is rarely useful to anyone, we propose to change the default value of
>>>> this switch.
>>
>> + Andi
>>
>>  From we heard many times from sophisticated customers, they really hate
>> blind spots. They want to see everything. That's why we set freeze_on_smi to
>> 0 as default. I think the patch breaks the principle.
> 
> Well, USR really, as in *REALLY* should not be counting SMM. That's just
> plain broken.
> 

For the USR only case, the bit could be set.

> There's maybe an argument to include it in OS, but USR is ring-3.

But we don't have an option for the USR only case. The changing will 
impact the SYS case as well. Personally, maybe it's better to let the 
user apace app control the bit as needed rather than changing the 
default kernel value for all cases.

Thanks,
Kan
