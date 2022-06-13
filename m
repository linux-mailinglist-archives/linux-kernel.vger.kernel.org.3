Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9361549B4E
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 20:18:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244929AbiFMSSC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 14:18:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234072AbiFMSRe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 14:17:34 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BF9545522C;
        Mon, 13 Jun 2022 07:16:01 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 55FF323A;
        Mon, 13 Jun 2022 07:16:01 -0700 (PDT)
Received: from [192.168.99.12] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 176A93F792;
        Mon, 13 Jun 2022 07:15:59 -0700 (PDT)
Message-ID: <c421ed20-f422-0c96-23d6-2ac964755e9f@foss.arm.com>
Date:   Mon, 13 Jun 2022 15:15:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH 3/3] perf test: Add coresight tests to guage quality of
 data generated
Content-Language: en-US
To:     Leo Yan <leo.yan@linaro.org>
Cc:     linux-kernel@vger.kernel.org, coresight@lists.linaro.org,
        suzuki.poulose@arm.com, mathieu.poirier@linaro.org,
        mike.leach@linaro.org, linux-perf-users@vger.kernel.org,
        acme@kernel.org
References: <20220309122859.31487-1-carsten.haitzler@foss.arm.com>
 <20220309122859.31487-3-carsten.haitzler@foss.arm.com>
 <20220410083041.GA184647@leoy-ThinkPad-X240s>
 <050209c2-c784-e255-4e75-5c8674c5cfe0@foss.arm.com>
 <20220526082039.GA795802@leoy-ThinkPad-X240s>
From:   Carsten Haitzler <carsten.haitzler@foss.arm.com>
Organization: Arm Ltd.
In-Reply-To: <20220526082039.GA795802@leoy-ThinkPad-X240s>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/26/22 09:20, Leo Yan wrote:
> Hi Carsten,
> 
> Sorry for late response.
> 
> On Thu, Apr 21, 2022 at 06:38:33PM +0100, Carsten Haitzler wrote:
> 
> [...]
> 
>>> Very big change...  Why squash all patches form previous verion to this
>>> single one big patch?  Usually the format with small patches is much
>>> better for reviewing.
>>
>> I was asked to re-jig the tree and in doing so I also ended up cutting down
>> the size a lot so this just makes more sense together as a "here are the
>> tests" as adding infra without any tests makes no sense and the tests
>> themelves are self-contained in their own directories and source files and
>> "drivign scripts" thus it's essentially patch 1 appended to patch 2 to patch
>> 3 etc. and still broken up in the patch file by file.
> 
> I am not sure if I understand the meaning, seems to me you could
> organize the patch series like:
> 
> - Patch for common files (e.g. script lib/coresight.sh or some
>    Makefile changes);
> - Patches for enabling test cases, E.g.:
>    patch for asm_pure_loop;
>    patch for thread loop (include unroll loop);
>    patch for memcpy;
> - Patch for documentation.

Each of those last patches are simple a patch with added "fluff" to add 
a line to a makefile each time then entire new files. A single patch set 
already divides each of these into their own files in the same patch are 
already divided - the only difference is - do you get the added fluff 
fiddling to add files to the makefile or just have them all added at 
once and the rest is already broken up. If you scroll through a patch 
with 3 files, or have 3 patches with 1 file in each - it's the same in 
the end. It's divided either way, but creating a patch set where one 
patch after the other adds a new test and each adds a line to the same 
makefle is a more work as I can't just git add/commit the test files to 
each patch. I have to first remove all tests. Then add the parent 
makefile for the tools with 1 line in it for 1 tool and 1 set of patch 
scripts. I then have to add the next one and edit this parent makefile 
to add one line and so on - where it actually makes the total size of 
all the patches bigger as this makefile that lists all the child dirs 
keeps being modified only to just add a single line added to it and the 
rest is all stand-alone new files anyway. As all the changes to this 
parent makefile all modify the same context, they can't be  separated 
out and cherry-picked as they then get conflicts in the context anyways 
so the patches can't be chosen separately without resolving conflicts 
anyway, thus to me it makes no sense to do all the extra work for a 
bigger total patch set that can't be split out without conflicts anyway...

But I kind of give up. It seems there is a view (that I don't understand 
as over-all the data is more complex and larger to review when broken 
out) that more data in N patches is preferable to less data in a single 
patch (even though it's all broken out into different file blocks in the 
same patch so you scroll down and basically in essence "cat *.patch" and 
"cat onefile.patch" produce the same thing other than the "add one more 
line to this makefile"). I'll break it up - it just is more busy-work to 
create a bigger overall patch set with more changes to look at overall.

> If this is not comfortable for you, at least we can use three patches:
> 
> - Patch for common file (e.g. script lib/coresight.sh);
> - Patch for test cases;
> - Patch for documentation.

The documentation I can see breaking out - though that wants to be moved 
somewhere else in the tree now and not alongside the perf tool. I 
generally go for the view of documentation belongs with the thing it 
documents and if there is new information to document, it belongs with 
the patch introducing what it documents. :)

> [...]
> 
>>>> +If you see these above, then your system is tracing coresight data
>>>> +correctly.
>>>> +
>>>> +To compile perf with coresight support in the perf directory do
>>>> +
>>>> +    make CORESIGHT=1
>>>
>>> It is inaccurate that if we don't mention openCSD lib.
>>
>> Do you mean I need to mention that you need the opencsd library installed
>> too?
> 
> Yes, otherwise, users might directly build perf without opencsd lib,
> then finally they cannot use perf with Arm CoreSight.

OK - sure. Will document that OpenCSD is needed and where to possibly 
get it (git, packages etc.).

>>>> +This will compile the perf tool with coresight support as well as
>>>> +build some small test binaries for perf test. This requires you also
>>>> +be compiling for 64bit Arm (ARM64/aarch64). The tools run as part of
>>>> +perf coresight tracing are in tests/shell/tools/coresight.
>>>
>>> For build perf tool, I think above paragraphs are duplicate with the
>>> document Documentation/trace/coresight/coresight.rst.  Can we simply
>>> say:
>>>
>>> "The details for building perf tool with support Arm Coresight can be
>>> found in the "HOWTO.md" file of the openCSD gitHub repository:
>>> https://github.com/Linaro/opencsd.
>>
>> I can. I put this here as I didn't go clone OpencCSD first but used my
>> distro OpenCSD packages and thus of course didn't have the documentation in
>> front of me. I spent some time wondering why it wasn't building with
>> coresight support even though it detected OpenCSD when I compiled... I
>> didn't expect to have to go to some separate project git repository and read
>> docs there on how to build the perf tool here in the kernel. I wrote this
>> because it was an actual problem I hit and it's a lot less frustrating to
>> "end users" to give them the information they need in the relevant place
>> they need it instead of sending them around to other project trees. Building
>> perf with coresight support is handled by the perf tree int he kernel, not
>> OpenCSD, thus IMHO that is where the documentation belongs - alongside the
>> thing that determines how to build something.
> 
> Understand.

I'll move this over to the place that Matthieu and you mention 
(Documentation/trace/coresight), but I do think this kind of information 
is necessary as above, so thanks. :)

>>> And "HOWTO.md" file gives the information and examples for how to use
>>> perf tool to record and report Coresight trace data.  It's the
>>> prerequisite for this perf Coresight test."
>>>
>>>> +You will also want coresight support enabled in your kernel config.
>>>> +Ensure it is enabled with:
>>>> +
>>>> +    CONFIG_CORESIGHT=y
>>>> +
>>>> +There are various other coresight options you probably also want
>>>> +enabled like:
>>>> +
>>>> +    CONFIG_CORESIGHT_LINKS_AND_SINKS=y
>>>> +    CONFIG_CORESIGHT_LINK_AND_SINK_TMC=y
>>>> +    CONFIG_CORESIGHT_CATU=y
>>>> +    CONFIG_CORESIGHT_SINK_TPIU=y
>>>> +    CONFIG_CORESIGHT_SINK_ETBV10=y
>>>> +    CONFIG_CORESIGHT_SOURCE_ETM4X=y
>>>> +    CONFIG_CORESIGHT_STM=y
>>>> +    CONFIG_CORESIGHT_CPU_DEBUG=y
>>>> +    CONFIG_CORESIGHT_CTI=y
>>>> +    CONFIG_CORESIGHT_CTI_INTEGRATION_REGS=y
>>>> +
>>>> +Please refer to the kernel configuration help for more information.
>>>
>>> I prefer to remove these kernel configuration since they are not
>>> inconsistent on different platforms (e.g. ETBV10, ETM4X, etc), and
>>> some configurations might not necessary (e.g. CPU_DEBUG).
>>
>> Certainly there should be some documentation on which kernel configs you
>> might want to turn on then? Imagine someone new comes along and doesn't have
>> any idea what to possible enable at all and manages to build perf with
>> coresight support (as above) then finds it doesn't work because they didn't
>> enable enough config in the kernel? Sure - could probably trim these down a
>> bit but the point here is to alert the user to there being a range of
>> coresight config options that you need to turn on that you likely will find
>> are not turned on. They certainly are not turned on on distro kernels and a
>> lot of the time when you have a platform that already boots/works you start
>> with your distro kernel config file because you want everything enabled so
>> it actually boots. I've learned the hard way to do this as you manage to
>> forget to turn on some MMC driver or some other feature and your boot hangs
>> or doesn't find rootfs etc.
> 
> So far, we will have two documents in Linux kernel:
> 
> - Documentation/trace/coresight/coresight.rst;
> - tools/perf/Documentation/arm-coresight.txt.
> 
> We need to avoid overlap between these two files.  I think we could use
> the file Documentation/trace/coresight/coresight.rst to focus on
> CoreSight driver module relates stuffs and
> tools/perf/Documentation/arm-coresight.txt is more about the perf
> usages.

That's the case here with this patch set. To me - I would look for the 
perf docs where I put them - in the perf documentation directory, not 
somewhere else.

> But, the file Documentation/trace/coresight/coresight.rst doesn't give
> any info for kernel configs, I think which would be a better place to
> give information for building kernel modules.

Correct. I do think you're right. I think that the "core docs" should 
give this information and the perf tool docs should at least reference 
these so you know to look there. I think I should at least put a stub 
doc in the perf tool doc tree to tell someone to go look at the "core 
docs" for more information.

>> What would you recommend then as a "turn these on and coresight will almost
>> certainly work for you on your given hardware " then?
> 
> This would be fine.  Alternatively, we could add a section in the file
> Documentation/trace/coresight/coresight.rst to describe how to build
> CoreSight modules.

I think that is good/best and then "link" the docs so someone knows 
where to look for more information.

> How you think for this?   I also would like to get suggestions from
> CoreSight maintainers Suzuki/Mathieu/Mike.
> 
> [...]
> 
>>> Please update based on the latest test case names, at my side, I can
>>> see the testing case like:
>>>
>>>          Coresight / ASM Pure Loop
>>>          Coresight / Memcpy 16k 10 Threads
>>>          Coresight / Thread Loop 10 Threads - Check TID
>>>          Coresight / Thread Loop 2 Threads - Check TID
>>>          Coresight / Unroll Loop Thread 10
>>
>> Oh sorry - yeah. I wrote the docs based on the earlier tests. Will fix.
> 
> Thanks.
> 
>>>> +
>>>> +These perf record tests will not run if the tool binaries do not exist
>>>> +in tests/shell/tools/coresight/*/ and will be skipped. If you do not
>>>> +have coresight support in hardware then either do not build perf with
>>>> +coresight support or remove these binaries in order to not have these
>>>> +tests fail and have them skip instead.
>>>> +
>>>> +These tests will log historical results in the current working
>>>> +directory (e.g. tools/perf) and will be named stats-*.csv like:
>>>> +
>>>> +    stats-asm_pure_loop-out.csv
>>>> +    stats-bubble_sort-random.csv
>>>> +    ...
>>>> +
>>>> +These statistic files log some aspects of the AUX data sections in
>>>> +the perf data output counting some numbers of certain encodings (a
>>>> +good way to know that it's working in a very simple way). One problem
>>>> +with coresight is that given a large enough amount of data needing to
>>>> +be logged, some of it can be lost due to the processor not waking up
>>>> +in time to read out all the data from buffers etc.. You will notice
>>>> +that the amount of data collected can vary a lot per run of perf test.
>>>> +If you wish to see how this changes over time, simply run perf test
>>>> +multiple times and all these csv files will have more and more data
>>>> +appended to it that you can later examine, graph and otherwise use to
>>>> +figure out if things have become worse or better.
>>>
>>> I am confused by this narrative.  Does it try to remind that the final
>>> testing result (pass or fail) is not stable?  Or should we run for
>>> multiple times so have more chance to capture issues?
>>
>> That is correct. I thought I was clear that it's lossy. That is actually the
>> case. I have tests here that actually fail because there is no data
>> collected from some threads at all (missing CID blocks for some of the
>> threads that run in the test). The point is to have tests that may be
>> failing now but in future will improve. I lowered the minimum bar to pass
>> for most tests to have "at least just a little data" but most tests show
>> highly variable amount of captured data. the csv files are there to
>> over-time give you a good idea of the stability of the captured data.
> 
> Okay, this would be fine for me.  Though I am a bit worry that later if
> users report a failure, then how we can tell them this is a bug or it's
> just tracing quality issue?

Well this is kind of both a bug and a quality issue. Reality is I have 
tests that literally get no information in the perf trace for some 
threads. Reality is we have what I'd call "Quality of trace" bugs and I 
was doing these test as a way of beginning to explore that and quantify 
it as that is not something the existing tests were doing. We want to 
have tests that in future with new designs show the quality bug to be 
fixed. It's kind of test driven development. Expose the quality bug, 
document it as such and then in future show it to be fixed when that 
happens (v9 should fix this...). I probably should document this as such 
(as a quality bug and why such failures are to be expected) so I'll add 
that to my TODO to make sure it's clear that these tests might fail and 
it's a quality issue (I mention the CSV files that are generated as a 
way to over-time track that quality).

> [...]
> 
>>>> diff --git a/tools/perf/tests/shell/coresight/asm_pure_loop/.gitignore b/tools/perf/tests/shell/coresight/asm_pure_loop/.gitignore
>>>> new file mode 100644
>>>> index 000000000000..468673ac32e8
>>>> --- /dev/null
>>>> +++ b/tools/perf/tests/shell/coresight/asm_pure_loop/.gitignore
>>>> @@ -0,0 +1 @@
>>>> +asm_pure_loop
>>>
>>> Do we really need there '.gitignore' files under the folder
>>> 'tools/perf/tests/shell/coresight/'.
>>
>> Where would you rather have them to ignore the generated binary tools?
> 
> It's interesting that I wanted to find a case to object you, so I tried
> to check the folder linux/samples/bpf, but it does use .gitignore file
> to ignore built binaries :)
> 
> Adding .gitignore is in practice and this would be fine for me.

:)

>>>> diff --git a/tools/perf/tests/shell/coresight/asm_pure_loop/Makefile b/tools/perf/tests/shell/coresight/asm_pure_loop/Makefile
>>>> new file mode 100644
>>>> index 000000000000..10c5a60cb71c
>>>> --- /dev/null
>>>> +++ b/tools/perf/tests/shell/coresight/asm_pure_loop/Makefile
>>>> @@ -0,0 +1,30 @@
>>>> +# SPDX-License-Identifier: GPL-2.0
>>>> +# Carsten Haitzler <carsten.haitzler@arm.com>, 2021
>>>> +
>>>> +include ../Makefile.miniconfig
>>>> +
>>>> +BIN=asm_pure_loop
>>>> +LIB=
>>>
>>> Remove the unused variable 'LIB='.
>>
>> I have this because I wanted to have a simple template to be able to re-use
>> for more tests over time. It's so much easier to maintain and extend if
>> every makefile and tool follow a similar pattern and you can almost copy &
>> paste between them as they don't have "exceptions". You really want me to
>> remove this?
> 
> It's fine to keep it.  Could you add a comment for this?

No problems! Can do.

> To be honest, I am not experienced for bash shell script, so I have no
> idea why write like this way.  If you think this is very common usage
> in shell, then you could keep it and don't need to add comment.

Well this is a makefile above (not shell), but having done lots of 
makefile and other higher level make tooling (autotools, cmake, meson) 
and having to maintain larger trees with "We build the same kind of 
thing N times but each module/tool needs slightly different 
linking/includes/tooling" ... I have learned the value of using 
templates that are the same but sometimes you have empty fields or 
fields that change. When you have to fix/change a "design pattern" issue 
it's easier to do when the files share more in common and it's easier 
for someone to start a new tool/module/subdir by taking an existing 
template and just modifying it as needed and everything they need is 
there. It really makes maintenance so much easier in the long-run as you 
expand the set of things something builds. Design patterns in your build 
system really help. :)

> [...]
> 
> 
>>> There have four sub folders under tools/perf/tests/shell/coresight:
>>>
>>>     asm_pure_loop
>>>     memcpy_thread
>>>     thread_loop
>>>     unroll_loop_thread
>>>
>>> And every folder has its own Makefile and every Makefile is quite
>>> close to each other.  I am just wandering if it's possible to
>>> remove the 4 Makefiles in these four sub folders, and simply use
>>> tools/perf/tests/shell/coresight/Makefile as the central place to
>>> build these assistant programs.
>>
>> I did this so it's easier to etxent over time. having a single parent
>> makefile that over time accumulates little ugly "if's" and exceptions makes
>> longer-term maintenance and extending harder. I did it this way to make this
>> easy - make a copy of a dir - add that dir to a parent makefile then modify
>> the makefile as needed (but only as needed).
> 
> Okay, let's keep the saperate makefiles.

:)

>>>> diff --git a/tools/perf/tests/shell/coresight/asm_pure_loop/asm_pure_loop.S b/tools/perf/tests/shell/coresight/asm_pure_loop/asm_pure_loop.S
>>>> new file mode 100644
>>>> index 000000000000..75cf084a927d
>>>> --- /dev/null
>>>> +++ b/tools/perf/tests/shell/coresight/asm_pure_loop/asm_pure_loop.S
>>>> @@ -0,0 +1,28 @@
>>>> +/* SPDX-License-Identifier: GPL-2.0 */
>>>> +/* Tamas Zsoldos <tamas.zsoldos@arm.com>, 2021 */
>>>> +
>>>> +.globl _start
>>>> +_start:
>>>> +	mov	x0, 0x0000ffff
>>>> +	mov	x1, xzr
>>>> +loop:
>>>> +	nop
>>>> +	nop
>>>> +	cbnz	x1, noskip
>>>> +	nop
>>>> +	nop
>>>> +	adrp	x2, skip
>>>> +	add 	x2, x2, :lo12:skip
>>>> +	br	x2
>>>> +	nop
>>>> +	nop
>>>> +noskip:
>>>> +	nop
>>>> +	nop
>>>> +skip:
>>>> +	sub	x0, x0, 1
>>>> +	cbnz	x0, loop
>>>> +
>>>> +	mov	x0, #0
>>>> +	mov	x8, #93 // __NR_exit syscall
>>>> +	svc	#0
>>>
>>> I tested the case "ASM Pure Loop" on my Juno board, and it complaints:
>>>
>>> root@debian:/mnt/export/arm-linux-kernel/tools/perf# ./perf test -v 76
>>>    76: Coresight / ASM Pure Loop                                       :
>>> --- start ---
>>> test child forked, pid 9063
>>> failed to mmap with 12 (Cannot allocate memory)
>>> test child finished with -1
>>> ---- end ----
>>> Coresight / ASM Pure Loop: FAILED!
>>>
>>> Since I only setup the 1GB memory for the Linux kernel, it fails to
>>> allocate AUX ring buffer with the size 256MB.  So I manully change
>>> the buffer size to 8MB in tools/perf/tests/shell/lib/coresight.sh:
>>>
>>>     PERFRECMEM="-m ,8M"
>>>
>>> So finally I can see the test case is passed:
>>
>> This is artificial isn't it? limiting to 1GB. You certainly have far more
>> memory than that available. My testse were on a system with 4GB and I had no
>> issues.
> 
> Please see below comment.
> 
>>> root@debian:/mnt/export/arm-linux-kernel/tools/perf# ./perf test -v 76
>>>    76: Coresight / ASM Pure Loop                                       :
>>> --- start ---
>>> test child forked, pid 9481
>>> -m ,8M -e cs_etm//u
>>> [ perf record: Woken up 1 times to write data ]
>>> [ perf record: Captured and wrote 0.681 MB ./perf-asm_pure_loop-out.data ]
>>> test child finished with 0
>>> ---- end ----
>>> Coresight / ASM Pure Loop: Ok
>>>
>>> Do you think we really need to use 256MiB as the AUX buffer size?
>>> IIRC, it means we allocate 256MiB per CPU for this case, on the other
>>> hand, you could see the final perf data file size is small (0.681
>>> MiB).
>>>
>>> Seems to me, it's not necessary to allocate so big buffer for
>>> the test, and I tried to run below 4 cases with 8MiB, all of them can
>>> pass the testing :)
>>
>> I didn't think anyone with a system with coresight support that would be
>> running perf record locally would only have 1GB of ram... I knew junos had
>> 8GB and my dragonboard has 4GB ... so I know I was on the smaller side. I
>> thought a larger buffer == safer results (less chance of needing to write
>> out the buffer during capture). Admittdly I used 256Mb when my tests ran for
>> much longer and collected more data. I can try drop to 8 or 16gb and see.
> 
> Yes, my Juno board has 8GB but I also have DB410c with 1GB with quad
> coes [1].  I am still concern for 256MB buffer size, it's not friendly for
> embedded system, and even not good for server.  For example, if we run
> this testing on Arm server with 96 cores (like Hisilicon D06 board),
> then we need the buffer size is:
> 
>    256MiB * 96 = 16GiB

A bit more actually 24M - but I see you correct this already in a 
following mail, but your point remains the same. :)

> I agree usually 16GiB is not a problem for server, but seems to me
> it doesn't make much sense to consume huge memory resource for the
> testing.

Even 24GB is not a problem IMHO if you have 96 cores, but ... I see your 
point.

> In other words, if set 8MiB (or 16MiB, 32MiB) buffer size and doesn't
> see testing result regression, I think this would be good to decrease
> the buffer size.

I'll drop it down to something less - sure. Maybe between 16-64M and 
that should mean everything you have there is able to do this without 
issues. 1GB with 8 cores would only need 512M for buffers - you have a 
lot left over. So 64M or less would be just fine I think (and with 4 
cores... even more headroom).

> [1] https://www.96boards.org/product/dragonboard410c/
> 
> [...]
> 
>>>> diff --git a/tools/perf/tests/shell/coresight_asm_pure_loop.sh b/tools/perf/tests/shell/coresight_asm_pure_loop.sh
>>>> new file mode 100755
>>>> index 000000000000..3f0dbefcad50
>>>> --- /dev/null
>>>> +++ b/tools/perf/tests/shell/coresight_asm_pure_loop.sh
>>>> @@ -0,0 +1,18 @@
>>>> +#!/bin/sh -e
>>>> +# Coresight / ASM Pure Loop
>>>> +
>>>> +# SPDX-License-Identifier: GPL-2.0
>>>> +# Carsten Haitzler <carsten.haitzler@arm.com>, 2021
>>>> +
>>>> +TEST="asm_pure_loop"
>>>> +. $(dirname $0)/lib/coresight.sh
>>>> +ARGS=""
>>>> +DATV="out"
>>>> +DATA="$DATD/perf-$TEST-$DATV.data"
>>>> +
>>>> +perf record $PERFRECOPT -o "$DATA" "$BIN" $ARGS
>>>> +
>>>> +perf_dump_aux_verify "$DATA" 10 10 10
>>>> +
>>>> +err=$?
>>>> +exit $err
>>>
>>> Can we organize the shell scripts by moving them into the folder
>>> tools/perf/tests/shell/coresight?
>>
>> We can - but it comes with a fair few more changes.
>>
>>>     coresight_asm_pure_loop.sh
>>>     coresight_memcpy_thread_16k_10.sh
>>>     coresight_thread_loop_check_tid_10.sh
>>>     coresight_thread_loop_check_tid_2.sh
>>>     coresight_unroll_loop_thread_10.sh
>>>
>>> And we even can consider to move script test_arm_coresight.sh into
>>> the folder tools/perf/tests/shell/coresight and change its
>>> name as 'coresight_smoke_test.sh'.
>>
>> Indeed these other tests I left alone for now and had not thought about how
>> to marry these together yet - leaving this for another day and another patch
>> set rather than this patch set itself. That was my thoguht. I was trying to
>> make an "Easier to extend by just dropping a test into a dir" setup here to
>> make maintenance and expansion easier over time (and thus encourage testing
>> by having a simple repeatable test infra to duplicate). I ended up with a
>> dir per test tool you need to build and a driver script in the tests/shell
>> dir. I think this is certainly worth considering but perhaps as a separate
>> set of work to marry these?
> 
> Okay, it would be fine to use separate set for moving the script
> test_arm_coresight.sh, which is a simple case.

I think that breaking out test_arm_coresight.sh into sub-tests that are 
stand-alone is better. I've had to deal with test suites that have one 
test case and that test fails/succeeds BUT this test case actually tests 
30+ API calls or something like that and one of those fail. Which one? 
You don't immediately know. You have to now go digging through log files 
to find out. Breaking this out into less efficient but easier to see 
"one test per thing you test" is much better and long-run really saves 
time and headaches, but this is "let's do this another day" but it is 
why I am over-engineering the tests with the view that these will expand 
in number and move over such tests.

>> I piggybacked on the existing shell test infra but added a fair few more
>> scripts. To do what you suggest I'd need to modify the core shell test code
>> to walk subdirs recursively then looking for child scripts. The problem is
>> how does perf test's shell handling know about the coresight subdir vs the
>> lib subdir?
> 
> Yeah, now I understand your point.  How about file layout like below?
> 
>    tools/perf/tests/shell/coresight_test_hub.sh
>    tools/perf/tests/shell/coresight/coresight_asm_pure_loop.sh
>    tools/perf/tests/shell/coresight/coresight_memcpy_thread_16k_10.sh
>    tools/perf/tests/shell/coresight/coresight_thread_loop_check_tid_10.sh
>    tools/perf/tests/shell/coresight/coresight_thread_loop_check_tid_2.sh
>    tools/perf/tests/shell/coresight/coresight_unroll_loop_thread_10.sh
> 
> So we use tools/perf/tests/shell/coresight_test_hub.sh as an interface
> to hook with Perf test infrastructure, and then hub.sh file calls
> testing scripts under the sub folder.  Seems to me, this is also
> friendly for later's extension.

Aaaaah here I disagree. The current test infra will only see 
"coresight_test_hub.sh" and then that all passes, fails or skips as a 
single test (see above). ub-tests are hidden when you do "perf test". 
I've had to deal with this before and it is (IMHO) a horrible way to go 
as you spend time then re-running the tests by hand and digging through 
other logs to see what failed rather than the toplevel tests indicating 
right there pass, fail or skip. Over time it becomes a time-sink to hunt 
these and mystifies new people who don't know where to dig for the 
specific failure.

To break them up like you want into subdirs then requires me to go to 
perf test (builtin-script.c) and change how the walking of test subdirs 
works with shells. It seems to have some legacy code in there that walks 
some "lang" dirs with "bin" dirs in them that seemingly do not exist 
today in the kernel tree. The right way to do this if you want to break 
this out into a coresight dir would be to modify how perf test walks 
dirs and builds the list of tests. I'd have to walk all subdirs then 
specifically filter for tests it knows will exist (executable, end in 
.sh, maybe be named like parentdir/parentdir_XXX.sh like your above 
suggestion of coresight/coresight_XXX.sh etc.). This now involves 
re-jigging a lot more code and abstracting the walking into a single 
function that walks once then stores the data in an array of struct 
pef_shell_test or such which now is filtered (and sorted which we should 
do which we don't now), and thus clean this all up, remove the 
(seemingly) legacy lang/bin dir walk code (I need to dig through history 
to find out where this came in and why it was there) and so on.

This certainly then makes this set of patches bigger and I need to break 
out this "revamp" of the walking of test shell scripts a preparation 
patch, but just saying: It certainly raises the bar for work and I don't 
think having a single parent .sh that then walks all the children and 
produces a single test output is right. I could popen this test and read 
the output to generate multiple output tests but, IMHO, that is worse 
and more complex than fixing the tree walk above to build an index of 
all shell tests once etc. like:

struct script_file {
    char *dir;
    char *file;
    char *label;
}

struct script_file *list_script_files(void);

... so we run this whenever we want a list of shell tests and just 
iterate over it until a NULL member (dir, file, label are all NULL). 
Simple and does the job but moves all the walking into a single function 
instead of there being like 3 of them now.

>> Both contain *.sh shell scripts - the difference is the ones in
>> lib are not executable. Is this sufficiently different? I could also open
>> them to check the have #!/bin/... as the first line. Hardcoding just a
>> single coresight subdir just feels wrong and hacky to me, thus the generic
>> recursion solution I suggest here.
> 
> Agreed.  I also don't prefer this way.
> 
>> I can definitely see how extending to subdirs would make supporting testing
>> cleaner and divide things into their own domains (dirs).
> 
> Thanks a lot for the work!  The test cases are good for me (but I would
> say Mike is the best person for reviewing testing trace data quaility),
> I just want to make sure it's not hard for later maintenance.

Sure. Let me at least make a start on the shell-test walk code and 
cleaning it up. I've just been staring at this and trying to find a 
"better way" but I'm pretty much at "Do it my current way with no subdir 
and keep the patch simple" or "Make this a more complex a patch to try 
streamline the code and abstract the shell tests better and include 
sub-dir walking" as I describe above. Long term I think this is actually 
a very good idea to clean this up and allow tests then in general to go 
into domain-specific subdirs. It just brings forward this kind of work 
ahead of getting extra tests in. I can't really see another sensible option.
