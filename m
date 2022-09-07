Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EF685AFB6D
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 06:52:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229625AbiIGEwQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 00:52:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiIGEwO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 00:52:14 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43CEB85AB5;
        Tue,  6 Sep 2022 21:52:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662526330; x=1694062330;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=9F0zAaH33oC4rqXkuHnBrqUOPAQEq6KgcFVAYKgK2Vs=;
  b=ct7JY5A3KEKGl0VinDXHi4X99zWQ4r7YVICzbc+9rrnn40UPxYk9Y3YC
   cMkBMqIHhIITMzII+N+OLAuQdW5p4kd5B7maR5Q77NckbpEQ/JnR+YAG5
   PimmKsJDASRXsx/ykVMV+47AGYW4+TS8eKmAl3L60VG6xdVwnnUO929Mp
   76M6OU3QbaVIE3F/0JIphdrCyjVZ9BZuvZGO+E83vF87t5wyLNsHkyvdo
   zuy5ML6OcpkttZCr0T1VfueP1cHf+KIfLSFAOiwQ0r2A1lR8W1m2QEbRR
   8ZYXWA4HCXfFwrCf6+Mt3EH8Uyz4pFUlRDSPy3xvtWLqg3YmY4DxRTDsC
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10462"; a="279792345"
X-IronPort-AV: E=Sophos;i="5.93,295,1654585200"; 
   d="scan'208";a="279792345"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2022 21:52:09 -0700
X-IronPort-AV: E=Sophos;i="5.93,295,1654585200"; 
   d="scan'208";a="676008617"
Received: from alinassi-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.58.27])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2022 21:52:06 -0700
Message-ID: <15afb29c-ca33-adf5-b685-a43d5be78a28@intel.com>
Date:   Wed, 7 Sep 2022 07:52:03 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.11.0
Subject: Re: [PATCH V2] libperf evlist: Fix per-thread mmaps for
 multi-threaded targets
Content-Language: en-US
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>, Ian Rogers <irogers@google.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>
References: <20220905114209.8389-1-adrian.hunter@intel.com>
 <CAM9d7cibk1OU95v56J15RG-zZmJ9TccUVZGAp=VHu7F3HwFY8g@mail.gmail.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <CAM9d7cibk1OU95v56J15RG-zZmJ9TccUVZGAp=VHu7F3HwFY8g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/09/22 20:50, Namhyung Kim wrote:
> On Mon, Sep 5, 2022 at 4:42 AM Adrian Hunter <adrian.hunter@intel.com> wrote:
>>
>> The offending commit removed mmap_per_thread(), which did not consider
>> the different set-output rules for per-thread mmaps i.e. in the per-thread
>> case set-output is used for file descriptors of the same thread not the
>> same cpu.
>>
>> This was not immediately noticed because it only happens with
>> multi-threaded targets and we do not have a test for that yet.
> 
> Yeah, this is unfortunate.  I feel like I need to spend some time on it.
> 
>>
>> Reinstate mmap_per_thread() expanding it to cover also system-wide per-cpu
>> events i.e. to continue to allow the mixing of per-thread and per-cpu
>> mmaps.
>>
>> Debug messages (with -vv) show the file descriptors that are opened with
>> sys_perf_event_open. New debug messages are added (needs -vvv) that show
>> also which file descriptors are mmapped and which are redirected with
>> set-output.
>>
>> In the per-cpu case (cpu != -1) file descriptors for the same CPU are
>> set-output to the first file descriptor for that CPU.
>>
>> In the per-thread case (cpu == -1) file descriptors for the same thread are
>> set-output to the first file descriptor for that thread.
>>
>> Example (process 17489 has 2 threads):
>>
>>  Before (but with new debug prints):
>>
>>    $ perf record --no-bpf-event -vvv --per-thread -p 17489
>>    <SNIP>
>>    sys_perf_event_open: pid 17489  cpu -1  group_fd -1  flags 0x8 = 5
>>    sys_perf_event_open: pid 17490  cpu -1  group_fd -1  flags 0x8 = 6
>>    <SNIP>
>>    libperf: idx 0: mmapping fd 5
>>    libperf: idx 0: set output fd 6 -> 5
>>    failed to mmap with 22 (Invalid argument)
>>
>>  After:
>>
>>    $ perf record --no-bpf-event -vvv --per-thread -p 17489
>>    <SNIP>
>>    sys_perf_event_open: pid 17489  cpu -1  group_fd -1  flags 0x8 = 5
>>    sys_perf_event_open: pid 17490  cpu -1  group_fd -1  flags 0x8 = 6
>>    <SNIP>
>>    libperf: mmap_per_thread: nr cpu values (may include -1) 1 nr threads 2
>>    libperf: idx 0: mmapping fd 5
>>    libperf: idx 1: mmapping fd 6
>>    <SNIP>
>>    [ perf record: Woken up 2 times to write data ]
>>    [ perf record: Captured and wrote 0.018 MB perf.data (15 samples) ]
> 
> It'd be nice if the example had 2 events so that it could check the
> set-output rule actually worked.

Here is an Intel PT example

$ perf record -vvv --per-thread -p 1521 -e intel_pt//
Using CPUID GenuineIntel-6-8C-1
intel_pt default config: tsc,mtc,mtc_period=3,psb_period=3,pt,branch
DEBUGINFOD_URLS=
nr_cblocks: 0
affinity: SYS
mmap flush: 1
comp level: 0
------------------------------------------------------------
perf_event_attr:
  type                             9
  size                             128
  config                           0x300e601
  { sample_period, sample_freq }   1
  sample_type                      IP|TID|IDENTIFIER
  read_format                      ID
  disabled                         1
  sample_id_all                    1
  exclude_guest                    1
  aux_watermark                    1048576
------------------------------------------------------------
sys_perf_event_open: pid 1521  cpu -1  group_fd -1  flags 0x8 = 5
sys_perf_event_open: pid 1522  cpu -1  group_fd -1  flags 0x8 = 6
------------------------------------------------------------
perf_event_attr:
  type                             1
  size                             128
  config                           0x9
  { sample_period, sample_freq }   1
  sample_type                      IP|TID|IDENTIFIER
  read_format                      ID
  disabled                         1
  exclude_kernel                   1
  exclude_hv                       1
  mmap                             1
  comm                             1
  task                             1
  sample_id_all                    1
  exclude_guest                    1
  mmap2                            1
  comm_exec                        1
  bpf_event                        1
------------------------------------------------------------
sys_perf_event_open: pid 1521  cpu -1  group_fd -1  flags 0x8 = 7
sys_perf_event_open: pid 1522  cpu -1  group_fd -1  flags 0x8 = 8
------------------------------------------------------------
perf_event_attr:
  type                             1
  size                             128
  config                           0x9
  { sample_period, sample_freq }   1
  sample_type                      IP|TID|TIME|IDENTIFIER
  read_format                      ID
  exclude_kernel                   1
  exclude_hv                       1
  sample_id_all                    1
  exclude_guest                    1
  ksymbol                          1
  text_poke                        1
------------------------------------------------------------
sys_perf_event_open: pid -1  cpu 0  group_fd -1  flags 0x8 = 9
sys_perf_event_open: pid -1  cpu 1  group_fd -1  flags 0x8 = 10
sys_perf_event_open: pid -1  cpu 2  group_fd -1  flags 0x8 = 11
sys_perf_event_open: pid -1  cpu 3  group_fd -1  flags 0x8 = 12
sys_perf_event_open: pid -1  cpu 4  group_fd -1  flags 0x8 = 13
sys_perf_event_open: pid -1  cpu 5  group_fd -1  flags 0x8 = 14
sys_perf_event_open: pid -1  cpu 6  group_fd -1  flags 0x8 = 15
sys_perf_event_open: pid -1  cpu 7  group_fd -1  flags 0x8 = 16
mmap size 528384B
AUX area mmap length 4194304
libperf: mmap_per_thread: nr cpu values (may include -1) 9 nr threads 2
libperf: idx 0: mmapping fd 5
libperf: idx 0: set output fd 7 -> 5
libperf: idx 1: mmapping fd 6
libperf: idx 1: set output fd 8 -> 6
libperf: idx 2: mmapping fd 9
libperf: idx 3: mmapping fd 10
libperf: idx 4: mmapping fd 11
libperf: idx 5: mmapping fd 12
libperf: idx 6: mmapping fd 13
libperf: idx 7: mmapping fd 14
libperf: idx 8: mmapping fd 15
libperf: idx 9: mmapping fd 16
Control descriptor is not initialized
thread_data[0x5572a73ec2f0]: nr_mmaps=10, maps=0x5572a73ec380, ow_maps=(nil)
thread_data[0x5572a73ec2f0]: cpu-1: maps[0] -> mmap[0]
thread_data[0x5572a73ec2f0]: cpu0: maps[1] -> mmap[1]
thread_data[0x5572a73ec2f0]: cpu1: maps[2] -> mmap[2]
thread_data[0x5572a73ec2f0]: cpu2: maps[3] -> mmap[3]
thread_data[0x5572a73ec2f0]: cpu3: maps[4] -> mmap[4]
thread_data[0x5572a73ec2f0]: cpu4: maps[5] -> mmap[5]
thread_data[0x5572a73ec2f0]: cpu5: maps[6] -> mmap[6]
thread_data[0x5572a73ec2f0]: cpu6: maps[7] -> mmap[7]
thread_data[0x5572a73ec2f0]: cpu7: maps[8] -> mmap[8]
thread_data[0x5572a73ec2f0]: cpu-1: maps[9] -> mmap[9]
thread_data[0x5572a73ec2f0]: pollfd[0] <- event_fd=5
thread_data[0x5572a73ec2f0]: pollfd[1] <- event_fd=7
thread_data[0x5572a73ec2f0]: pollfd[2] <- event_fd=6
thread_data[0x5572a73ec2f0]: pollfd[3] <- event_fd=8
thread_data[0x5572a73ec2f0]: pollfd[4] <- non_perf_event fd=4
------------------------------------------------------------
perf_event_attr:
  type                             1
  size                             128
  config                           0x9
  watermark                        1
  sample_id_all                    1
  bpf_event                        1
  { wakeup_events, wakeup_watermark } 1
------------------------------------------------------------
sys_perf_event_open: pid 1521  cpu -1  group_fd -1  flags 0x8 = 17
sys_perf_event_open: pid 1522  cpu -1  group_fd -1  flags 0x8 = 18
mmap size 528384B
libperf: mmap_per_thread: nr cpu values (may include -1) 1 nr threads 2
libperf: idx 0: mmapping fd 17
libperf: idx 1: mmapping fd 18
Synthesizing TSC conversion information
Synthesizing id index
Synthesizing auxtrace information
auxtrace idx 1 old 0 head 0x2c0 diff 0x2c0
auxtrace idx 0 old 0 head 0x2060 diff 0x2060
[ perf record: Woken up 2 times to write data ]
[ perf record: Captured and wrote 0.029 MB perf.data ]




> 
> Thanks,
> Namhyung
> 
>>
>> Per-cpu example (process 20341 has 2 threads, same as above):
>>
>>    $ perf record --no-bpf-event -vvv -p 20341
>>    <SNIP>
>>    sys_perf_event_open: pid 20341  cpu 0  group_fd -1  flags 0x8 = 5
>>    sys_perf_event_open: pid 20342  cpu 0  group_fd -1  flags 0x8 = 6
>>    sys_perf_event_open: pid 20341  cpu 1  group_fd -1  flags 0x8 = 7
>>    sys_perf_event_open: pid 20342  cpu 1  group_fd -1  flags 0x8 = 8
>>    sys_perf_event_open: pid 20341  cpu 2  group_fd -1  flags 0x8 = 9
>>    sys_perf_event_open: pid 20342  cpu 2  group_fd -1  flags 0x8 = 10
>>    sys_perf_event_open: pid 20341  cpu 3  group_fd -1  flags 0x8 = 11
>>    sys_perf_event_open: pid 20342  cpu 3  group_fd -1  flags 0x8 = 12
>>    sys_perf_event_open: pid 20341  cpu 4  group_fd -1  flags 0x8 = 13
>>    sys_perf_event_open: pid 20342  cpu 4  group_fd -1  flags 0x8 = 14
>>    sys_perf_event_open: pid 20341  cpu 5  group_fd -1  flags 0x8 = 15
>>    sys_perf_event_open: pid 20342  cpu 5  group_fd -1  flags 0x8 = 16
>>    sys_perf_event_open: pid 20341  cpu 6  group_fd -1  flags 0x8 = 17
>>    sys_perf_event_open: pid 20342  cpu 6  group_fd -1  flags 0x8 = 18
>>    sys_perf_event_open: pid 20341  cpu 7  group_fd -1  flags 0x8 = 19
>>    sys_perf_event_open: pid 20342  cpu 7  group_fd -1  flags 0x8 = 20
>>    <SNIP>
>>    libperf: mmap_per_cpu: nr cpu values 8 nr threads 2
>>    libperf: idx 0: mmapping fd 5
>>    libperf: idx 0: set output fd 6 -> 5
>>    libperf: idx 1: mmapping fd 7
>>    libperf: idx 1: set output fd 8 -> 7
>>    libperf: idx 2: mmapping fd 9
>>    libperf: idx 2: set output fd 10 -> 9
>>    libperf: idx 3: mmapping fd 11
>>    libperf: idx 3: set output fd 12 -> 11
>>    libperf: idx 4: mmapping fd 13
>>    libperf: idx 4: set output fd 14 -> 13
>>    libperf: idx 5: mmapping fd 15
>>    libperf: idx 5: set output fd 16 -> 15
>>    libperf: idx 6: mmapping fd 17
>>    libperf: idx 6: set output fd 18 -> 17
>>    libperf: idx 7: mmapping fd 19
>>    libperf: idx 7: set output fd 20 -> 19
>>    <SNIP>
>>    [ perf record: Woken up 7 times to write data ]
>>    [ perf record: Captured and wrote 0.020 MB perf.data (17 samples) ]
>>
>> Fixes: ae4f8ae16a07 ("libperf evlist: Allow mixing per-thread and per-cpu mmaps")
>> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>

