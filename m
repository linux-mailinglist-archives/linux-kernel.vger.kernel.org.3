Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8C1349841A
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 17:01:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243433AbiAXQBf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 11:01:35 -0500
Received: from mga12.intel.com ([192.55.52.136]:11920 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243292AbiAXQB0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 11:01:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643040086; x=1674576086;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=5mCt9pczVlN4F3Hulq3VHiCab+NKowV9GD/Gt1WNGnM=;
  b=ZnN0wgDE1GMlNCt8DcDZUhvZpLUuu8uAA/3iQZaDVCmyGpwZDEdCEx5e
   3p5iQjRQcenO2/QGQitRSbFYtaJgRS6HgYsiO2vjoMp3uU8PKKhqfwnDn
   FQNWwPBltGl1FPF2wzEyqhb43RURwsCk75JoZkjMc/23CcX3VwVahs5pr
   18CmwksHwRx0+hX8pu45Q+FnOJhdFl5YxJyj0OJxynKwmGspyUEwaxGnC
   oWx+wl+CrhD2rhvpERJK6h106wPs86r6Cjm27omXcYyOPLJonsZ+bxqp7
   PUJ7axQIBZv9B8JVEorSfbdRNSdLG0t6UsRwi6K1207FrkIVws8pzg4up
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10236"; a="226056487"
X-IronPort-AV: E=Sophos;i="5.88,311,1635231600"; 
   d="scan'208";a="226056487"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2022 08:00:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,311,1635231600"; 
   d="scan'208";a="494664364"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga002.jf.intel.com with ESMTP; 24 Jan 2022 08:00:58 -0800
Received: from [10.209.54.174] (kliang2-MOBL.ccr.corp.intel.com [10.209.54.174])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 584C7580921;
        Mon, 24 Jan 2022 08:00:57 -0800 (PST)
Message-ID: <3c35dc76-c187-8d3f-7fc9-75de32e7cbf6@linux.intel.com>
Date:   Mon, 24 Jan 2022 11:00:56 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] x86/perf: Default freeze_on_smi on for Comet Lake and
 later.
Content-Language: en-US
To:     Peter Zijlstra <peterz@infradead.org>, Kyle Huey <me@kylehuey.com>
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Dave Hansen <dave.hansen@linux.intel.com>,
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
From:   "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <Ye6Z31keWVPrsNWU@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/24/2022 7:21 AM, Peter Zijlstra wrote:
> On Fri, Jan 21, 2022 at 11:26:44PM -0800, Kyle Huey wrote:
>> Beginning in Comet Lake, Intel extended the concept of privilege rings to
>> SMM.[0] A side effect of this is that events caused by execution of code
>> in SMM are now visible to performance counters with IA32_PERFEVTSELx.USR
>> set.
>>
>> rr[1] depends on exact counts of performance events for the user space
>> tracee, so this change in behavior is fatal for us. It is, however, easily
>> corrected by setting IA32_DEBUGCTL.FREEZE_WHILE_SMM to 1 (visible in sysfs
>> as /sys/devices/cpu/freeze_on_smi). While we can and will tell our users to
>> set freeze_on_smi manually when appropriate, because observing events in
>> SMM is rarely useful to anyone, we propose to change the default value of
>> this switch.

+ Andi

 From we heard many times from sophisticated customers, they really hate 
blind spots. They want to see everything. That's why we set 
freeze_on_smi to 0 as default. I think the patch breaks the principle.

I don't think there is a way to notify all the users that the default 
kernel value will be changed. (Yes, the end user can always check the 
/sys/devices/cpu/freeze_on_smi to get the latest value. But in practice, 
no one checks it unless some errors found.) I think it may bring 
troubles to the users if they rely on the counts in SMM.

The patch only changes the default values for some platforms, not all 
platforms. The default value is not consistent among platforms anymore. 
It can bring confusion.

All in all, we have already exposed an interface for the end-users to 
change the value. If some apps, e.g., rr, doesn't want the default 
value, I think they can always change it in the app for all platforms.
We should still keep the freeze_on_smi to 0 as default, which should 
benefit more users.


>>
>> In this patch I have assumed that all non-Atom Intel microarchitectures
>> starting with Comet Lake behave like this but it would be good for someone
>> at Intel to verify that.
>>
> 
> Kan, can you look at that?
>

I'm asking internally.

Thanks,
Kan

>> [0] See the Intel white paper "Trustworthy SMM on the Intel vPro Platform"
>> at https://bugzilla.kernel.org/attachment.cgi?id=300300, particularly the
>> end of page 5.
>>
>> [1] https://rr-project.org/
>>
>> Signed-off-by: Kyle Huey <khuey@kylehuey.com>
> 
> Patch seems sensible enough; I'll go queue it up unless Kan comes back
> with anything troublesome.
