Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E1D749B5AF
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 15:07:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386983AbiAYOGJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 09:06:09 -0500
Received: from mga17.intel.com ([192.55.52.151]:12204 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1387856AbiAYODn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 09:03:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643119423; x=1674655423;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=tFnuLuY9oElKJDCq2VE/qinMRbQq/Wj5fuO0jaXmt2g=;
  b=GqH8McwTltsCz6wF7REFuaq1IUelQXr+5v9RZel+1fBBPFzORO+Snbih
   ojXuuU4yqhqsMEPcaxH6cvTs5ZRKrVjcSNSsY6RXrK9z9q1vERZVELXVX
   94R4WYX864BLWsD6BmyY98EYcG6n/sWwHTHXkz73xGRVPj983Y9Wv6pUu
   d6jaYwwufFBj5A8WUgb13ZwXe0dlEQpDDhXnZMc8MQFB9oqb09rw03uua
   cxCl/87Qw1fXuWuQ/Nt9RhupDrVSJ2VEWvX4T5G2+IvguQCRU1GX0ZprR
   ql+ltYVP16NJ9x8uc5fUIlCZAGKC5b/S6IL4202KN0K6oUOGo12JP//qU
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10237"; a="226972497"
X-IronPort-AV: E=Sophos;i="5.88,315,1635231600"; 
   d="scan'208";a="226972497"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2022 05:57:12 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,315,1635231600"; 
   d="scan'208";a="597129564"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga004.fm.intel.com with ESMTP; 25 Jan 2022 05:57:12 -0800
Received: from [10.209.56.163] (bdobabaa-mobl.amr.corp.intel.com [10.209.56.163])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 58D86580808;
        Tue, 25 Jan 2022 05:57:10 -0800 (PST)
Message-ID: <7ef1bf66-4184-7f5b-c0bd-351ec743d4e9@linux.intel.com>
Date:   Tue, 25 Jan 2022 08:57:09 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] x86/perf: Default freeze_on_smi on for Comet Lake and
 later.
Content-Language: en-US
To:     Kyle Huey <me@kylehuey.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        open list <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
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
 <3c35dc76-c187-8d3f-7fc9-75de32e7cbf6@linux.intel.com>
 <CAP045ArbX7cYKyv0H4X2SxUJWycB1VoLZWLME=_RXttBFBfP3A@mail.gmail.com>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <CAP045ArbX7cYKyv0H4X2SxUJWycB1VoLZWLME=_RXttBFBfP3A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/24/2022 9:59 PM, Kyle Huey wrote:
> On Mon, Jan 24, 2022 at 8:01 AM Liang, Kan <kan.liang@linux.intel.com> wrote:
>>
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
>>   From we heard many times from sophisticated customers, they really hate
>> blind spots. They want to see everything. That's why we set
>> freeze_on_smi to 0 as default. I think the patch breaks the principle.
> 
> The default kernel settings for perf events prioritize preventing
> information leaks to less privileged code. perf_event_paranoid
> defaults to 2, preventing unprivileged users from observing kernel
> space. If "sophisticated customers" want to see everything they have
> already needed privileges (or an explicit opt-in through decreasing
> perf_event_paranoid) for some time.
> 
> The current situation on Comet Lake+ where an unprivileged user
> *cannot* observe kernel code due to security concerns but
> simultaneously *must* observe SMM code seems rather absurd.
>

I see. I was thought the unprivileged user can observe the SMM code on 
the previous platforms. The CML+ change only makes part of the SMM code 
CPL0. Seems I'm wrong. The change looks like changing the previous CPL0 
code to CPL3 code. If so, yes, I think we should prevent the information 
leaks for the unprivileged user.

>> I don't think there is a way to notify all the users that the default
>> kernel value will be changed. (Yes, the end user can always check the
>> /sys/devices/cpu/freeze_on_smi to get the latest value. But in practice,
>> no one checks it unless some errors found.) I think it may bring
>> troubles to the users if they rely on the counts in SMM.
> 
> Unfortunately the new hardware has already changed the behavior
> without notifying users, no matter what we do here.
> 
>> The patch only changes the default values for some platforms, not all
>> platforms. The default value is not consistent among platforms anymore.
>> It can bring confusion.
> 
> I don't personally object to changing freeze_on_smi for all platforms
> :) I was merely trying to limit the changes.


Changing it to all platforms seems a too big hammer. I agree we should 
limit it to the impacted platforms.

I've contacted the author of the white paper. I was told that the change 
is for the client vPro platforms. They are not sure whether it impacts 
Server platform or Atom platforms. I'm still working on it. I will let 
you and Peter know once I get more information.

Thanks,
Kan
