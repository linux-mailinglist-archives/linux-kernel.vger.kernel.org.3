Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B4085AC3D2
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Sep 2022 12:15:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233236AbiIDKP1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Sep 2022 06:15:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231446AbiIDKPY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Sep 2022 06:15:24 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:8234::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A03971DA74;
        Sun,  4 Sep 2022 03:15:22 -0700 (PDT)
Received: from [2a02:8108:963f:de38:eca4:7d19:f9a2:22c5]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1oUmev-0004f1-4c; Sun, 04 Sep 2022 12:15:21 +0200
Message-ID: <5eca514c-2f05-2714-b496-233e8a39fe29@leemhuis.info>
Date:   Sun, 4 Sep 2022 12:15:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: perf top -p broken for multithreaded processes since 5.19
 #forregzbot
Content-Language: en-US, de-DE
Cc:     linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
References: <10137382.nUPlyArG6x@mintaka.ncbr.muni.cz>
To:     "regressions@lists.linux.dev" <regressions@lists.linux.dev>
From:   Thorsten Leemhuis <regressions@leemhuis.info>
In-Reply-To: <10137382.nUPlyArG6x@mintaka.ncbr.muni.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1662286522;9afae47c;
X-HE-SMSGID: 1oUmev-0004f1-4c
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

TWIMC: this mail is primarily send for documentation purposes and for
regzbot, my Linux kernel regression tracking bot. These mails usually
contain '#forregzbot' in the subject, to make them easy to spot and filter.

[TLDR: I'm adding this regression report to the list of tracked
regressions; all text from me you find below is based on a few templates
paragraphs you might have encountered already already in similar form.]

Hi, this is your Linux kernel regression tracker. CCing the regression
mailing list, as it should be in the loop for all regressions, as
explained here:
https://www.kernel.org/doc/html/latest/admin-guide/reporting-issues.html

On 02.09.22 16:46, Tomáš Trnka wrote:
> Hello,
> 
> A bug in perf v5.19 and newer completely breaks monitoring multithreaded
> processes using "perf top -p". The tool fails to start with "Failed to mmap
> with 22 (Invalid argument)". It still seems to work fine on single-threaded
> processes. "perf record" is also unaffected.
> 
> I have bisected the issue to the following commit:
> 
> commit ae4f8ae16a07896403c90305d4b9be27f657c1fc
> Author: Adrian Hunter <adrian.hunter@intel.com>
> Date:   Tue May 24 10:54:31 2022 +0300
> 
>     libperf evlist: Allow mixing per-thread and per-cpu mmaps
>     
>     mmap_per_evsel() will skip events that do not match the CPU, so all CPUs
>     can be iterated in any case.
> 
> The issue can be easily reproduced using the following test:
> 
> $ python - <<EOF
> import time
> import threading
> th = threading.Thread(target=time.sleep, args=(3600,))
> th.start()
> th.join()
> EOF
> 
> stracing "perf top -p $(pgrep python)" yields this:
> 
> 145184 perf_event_open({type=PERF_TYPE_HARDWARE, size=PERF_ATTR_SIZE_VER7, config=PERF_COUNT_HW_CPU_CYCLES, sample_freq=4000, sample_type=PERF_SAMPLE_IP|PERF_SAMPLE_TID|PERF_SAMPLE_TIME|PERF_SAMPLE_PERIOD, read_format=PERF_FORMAT_ID, disabled=1, exclude_kernel=1, mmap=1, comm=1, freq=1, task=1, precise_ip=0 /* arbitrary skid */, sample_id_all=1, mmap2=1, comm_exec=1, ksymbol=1, ...}, 92061, -1, -1, PERF_FLAG_FD_CLOEXEC) = 3
>  > tools/perf/perf(evsel__open_cpu+0x287) [0x4c8ad7]
>  > tools/perf/perf(cmd_top+0x1996) [0x439b26]
>  > tools/perf/perf(run_builtin+0x68) [0x4a91f8]
>  > tools/perf/perf(main+0x645) [0x40cad5]
> 145184 perf_event_open({type=PERF_TYPE_HARDWARE, size=PERF_ATTR_SIZE_VER7, config=PERF_COUNT_HW_CPU_CYCLES, sample_freq=4000, sample_type=PERF_SAMPLE_IP|PERF_SAMPLE_TID|PERF_SAMPLE_TIME|PERF_SAMPLE_PERIOD, read_format=PERF_FORMAT_ID, disabled=1, exclude_kernel=1, mmap=1, comm=1, freq=1, task=1, precise_ip=0 /* arbitrary skid */, sample_id_all=1, mmap2=1, comm_exec=1, ksymbol=1, ...}, 104619, -1, -1, PERF_FLAG_FD_CLOEXEC) = 5
>  > tools/perf/perf(evsel__open_cpu+0x287) [0x4c8ad7]
>  > tools/perf/perf(cmd_top+0x1996) [0x439b26]
>  > tools/perf/perf(run_builtin+0x68) [0x4a91f8]
>  > tools/perf/perf(main+0x645) [0x40cad5]
> …(snip)…
> 145184 ioctl(5, PERF_EVENT_IOC_SET_OUTPUT, 3) = -1 EINVAL (Invalid argument)
>  > tools/perf/perf(perf_evlist__mmap_ops+0x2cf) [0x5d497f]
>  > tools/perf/perf(evlist__mmap+0xa7) [0x4c09b7]
>  > perf/perf(cmd_top+0x1ccd) [0x439e5d]
>  > tools/perf/perf(run_builtin+0x68) [0x4a91f8]
>  > tools/perf/perf(main+0x645) [0x40cad5]
> 
> Best regards,
> 
> Tomáš
> --
> Tomáš Trnka
> Software for Chemistry & Materials B.V.

Thanks for the report. To be sure below issue doesn't fall through the
cracks unnoticed, I'm adding it to regzbot, my Linux kernel regression
tracking bot:

#regzbot introduced ae4f8ae16a07896 ^
https://bugzilla.kernel.org/show_bug.cgi?id=216441
#regzbot title perf: perf top -p broken for multithreaded processes
since 5.19
#regzbot ignore-activity

This isn't a regression? This issue or a fix for it are already
discussed somewhere else? It was fixed already? You want to clarify when
the regression started to happen? Or point out I got the title or
something else totally wrong? Then just reply -- ideally with also
telling regzbot about it, as explained here:
https://linux-regtracking.leemhuis.info/tracked-regression/

Reminder for developers: When fixing the issue, add 'Link:' tags
pointing to the report (the mail this one replies to), as explained for
in the Linux kernel's documentation; above webpage explains why this is
important for tracked regressions.

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)

P.S.: As the Linux kernel's regression tracker I deal with a lot of
reports and sometimes miss something important when writing mails like
this. If that's the case here, don't hesitate to tell me in a public
reply, it's in everyone's interest to set the public record straight.
