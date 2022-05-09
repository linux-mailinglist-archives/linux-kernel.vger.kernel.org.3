Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AF9251F414
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 08:02:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229629AbiEIFuZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 01:50:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235376AbiEIFsA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 01:48:00 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4264126C37
        for <linux-kernel@vger.kernel.org>; Sun,  8 May 2022 22:44:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652075047; x=1683611047;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=vGLWB6wm2R99i0n5ZImSofDpnx0nFa2JTFNR1F4AQvM=;
  b=C4fCUU1JlnJoQ1JEFR5W7XzdYptSq2G0lu6dDbGCW8BV6wLCyaKPYdqS
   vzF8RuNPzst7T5w7roiz9b1STHKbmuF6yY5aIgQ7ixy3OpseWu0+pYf5k
   8400p/a33pizXm4MQvARx4DWaZT24lxH0rISgLekjc8LCQ8f7SSN4J+zh
   783hJE5lGUtstJvyiJiRz8CMXReFb97koKseHjTQle8ify17qmXyk9bK4
   MZ6hAz7s1Y/MmMeuItT7odT1PtxpgQrsq1CYatimD7Vjb5YtWzb/AqdG7
   r0cXgzDDtMj+rER2upCL/FuHwdZ32krA4Hewkkz0QlFcuY2oxhlokbByL
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10341"; a="249483601"
X-IronPort-AV: E=Sophos;i="5.91,210,1647327600"; 
   d="scan'208";a="249483601"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2022 22:44:07 -0700
X-IronPort-AV: E=Sophos;i="5.91,210,1647327600"; 
   d="scan'208";a="591129784"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.32.199])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2022 22:44:04 -0700
Message-ID: <a9e97cca-8bd6-9a47-a7d9-79198e6b9a81@intel.com>
Date:   Mon, 9 May 2022 08:44:02 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.8.1
Subject: Re: [PATCH V2 00/23] perf intel-pt: Better support for perf record
 --cpu
Content-Language: en-US
To:     Leo Yan <leo.yan@linaro.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>, Ian Rogers <irogers@google.com>,
        Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org, James Clark <James.Clark@arm.com>,
        German Gomez <german.gomez@arm.com>
References: <20220506122601.367589-1-adrian.hunter@intel.com>
 <20220508150832.GA278102@leoy-ThinkPad-X240s>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20220508150832.GA278102@leoy-ThinkPad-X240s>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/05/22 18:08, Leo Yan wrote:
> Hi Adrian,
> 
> On Fri, May 06, 2022 at 03:25:38PM +0300, Adrian Hunter wrote:
>> Hi
>>
>> Here are V2 patches to support capturing Intel PT sideband events such as
>> mmap, task, context switch, text poke etc, on every CPU even when tracing
>> selected user_requested_cpus.  That is, when using the perf record -C or
>>  --cpu option.
>>
>> This is needed for:
>> 1. text poke: a text poke on any CPU affects all CPUs
>> 2. tracing user space: a user space process can migrate between CPUs so
>> mmap events that happen on a different CPU can be needed to decode a
>> user_requested_cpus CPU.
>>
>> For example:
>>
>> 	Trace on CPU 1:
>>
>> 	perf record --kcore -C 1 -e intel_pt// &
>>
>> 	Start a task on CPU 0:
>>
>> 	taskset 0x1 testprog &
>>
>> 	Migrate it to CPU 1:
>>
>> 	taskset -p 0x2 <testprog pid>
>>
>> 	Stop tracing:
>>
>> 	kill %1
>>
>> 	Prior to these changes there will be errors decoding testprog
>> 	in userspace because the comm and mmap events for testprog will not
>> 	have been captured.
> 
> Thanks a lot for this patch set, I believe this is a common issue for
> AUX trace (not only for Intel-PT), so I verified this patch set for both
> Arm CoreSight and SPE; unfortunately both cannot see MMAP events for
> migrated task.  I used below commands:
> 
>   # perf record -B -N --no-bpf-event -e cs_etm//u -C 0 -- taskset --cpu-list 1 uname
>   # perf script  --no-itrace --show-mmap-events -C 1 2>/dev/null | grep MMAP | wc -l
>   0
> 
> 
>   # perf record -B -N --no-bpf-event -e arm_spe_0//u -C 0 -- taskset --cpu-list 1 uname
>   # perf script --no-itrace --show-mmap-events -C 1 2>/dev/null | grep MMAP | wc -l
>   0
> 
> I didn't dive into details for this patch set, so I cannot say the
> failure is caused by any issue in this patch set.  But it's definitely
> we need to look into for Arm platforms to root cause what's the reason
> it cannot record MMAP events properly when migrate tasks.  Loop James
> and German for this reason.

You would need the equivalent of patch "perf intel-pt: Track sideband
system-wide when needed" which makes use of new helper
evlist__add_aux_dummy() to set up the dummy event with the option to
make it "system wide".

cs_etm_recording_options() and arm_spe_recording_options() have similar
code.

You will need to decide if it is worth the extra sideband.  I decided
if it became an issue, it could be made optional in the future.
