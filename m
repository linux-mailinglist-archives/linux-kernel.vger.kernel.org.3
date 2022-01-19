Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 839DC493E7C
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 17:43:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356193AbiASQnZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 11:43:25 -0500
Received: from foss.arm.com ([217.140.110.172]:60774 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239684AbiASQnW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 11:43:22 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id ED8DBED1;
        Wed, 19 Jan 2022 08:43:21 -0800 (PST)
Received: from [10.57.35.152] (unknown [10.57.35.152])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6209B3F774;
        Wed, 19 Jan 2022 08:43:20 -0800 (PST)
Subject: Re: [PATCH 12/12] perf test: Add docs for coresight and related tests
To:     carsten.haitzler@foss.arm.com, linux-kernel@vger.kernel.org
Cc:     coresight@lists.linaro.org, linux-perf-users@vger.kernel.org,
        acme@kernel.org, mike.leach@linaro.org,
        suzuki K Poulose <suzuki.poulose@arm.com>,
        Leo Yan <leo.yan@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>
References: <20211215160403.69264-1-carsten.haitzler@foss.arm.com>
 <20211215160403.69264-12-carsten.haitzler@foss.arm.com>
From:   James Clark <james.clark@arm.com>
Message-ID: <182f43a8-499e-c672-7925-3e81de65655c@arm.com>
Date:   Wed, 19 Jan 2022 16:43:18 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211215160403.69264-12-carsten.haitzler@foss.arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 15/12/2021 16:04, carsten.haitzler@foss.arm.com wrote:
> From: Carsten Haitzler <carsten.haitzler@arm.com>
> 
> This adds documentation about the coresight specific tests as part of
> perf test
> 
> Signed-off-by: Carsten Haitzler <carsten.haitzler@arm.com>

I will use this commit to comment on the set as a whole. The other comments about
specific issues I have left inline.

I ran the tests twice on N1SDP (kernel version perf/core 48ffaedf017ad) and had two
different sets of failures, indicating some flakyness, which is one reason to not have
tests with magic numbers as Leo has raised. Are you able to give a complete list of
where you have run these so far? I know we can't check everywhere, but at least all
of Arm's own reference platforms should be passing.

First run:
  
   92: Coresight / Thread Loop 25 Threads                              : FAILED!
   94: Coresight / Thread Loop 10 Threads - Check TID                  : FAILED!
   95: Coresight / Thread Loop 2 Threads - Check TID                   : FAILED!
   96: Coresight / Thread Loop 250 Threads - Check TID                 : FAILED!
   97: Coresight / Unroll Loop Thread 1                                : FAILED!
   99: Coresight / Unroll Loop Thread 2                                : FAILED!
 
Second run:

  92: Coresight / Thread Loop 25 Threads                              : FAILED!
  94: Coresight / Thread Loop 10 Threads - Check TID                  : FAILED!
  95: Coresight / Thread Loop 2 Threads - Check TID                   : FAILED!
  96: Coresight / Thread Loop 250 Threads - Check TID                 : FAILED!
  97: Coresight / Unroll Loop Thread 1                                : FAILED!

I have pasted the verbose output of two of these at the very end.

The major problem I have with the tests is the time that they take to run. Now
a full test run takes 31m+ on N1SDP, where previously it took 1m 9s. There are
quite a few reasons why this isn't a good idea. It will take extra cycles on
anyone's CI and that means it will now take longer for anyone to make any changes
if they run the tests, slowing down all Perf work from now onward. Even if you
want to run just the Coresight tests, it doesn't really help as that is 90% of
the time taken, so personally for me I'm not likely to run them while working on
Coresight changes. The longer the tests take the more likely it is that they are
skipped, reducing the benefits of the tests. Also if anyone has timeouts set on
CI these are likely going to have to be adjusted now.

Is it possible to get the run time of each test down to 5-10 seconds? This will
make it much nicer for us to work with going forwards.

I'd also have liked to have had a discussion on the mailing list about what the test
methodology should be in general before starting. For example for this patch set it
looks like the coverage is quite wide because of the number of tests and time it
takes to run, but actually they all use "cs_etm//u -- <process>" as the run command.
This only tests per-process userspace mode resulting in very narrow coverage.
And there is no mention in a cover letter about how this expands on or interacts
with the existing test_arm_coresight.sh test which I don't think can be ignored.
For example it iterates over sinks. Could that same iteration not be applied to
these tests? They seem to exist in isolation and it's not clear which one we should
be adding to going forwards.

I'd like to see a much more exploration of the different modes and flags to justify
such a high run time:
  
  * per-CPU
  * per-thread
  * with and without timestamps
  * strobing

If this is supposed to be just an initial implementation covering one case, then
by the "test one thing" ethos, there should only be one test case. Each case
should be testing one thing with minimal overlapping. But it looks like tests like
"Thread loop 10" and "thread loop 250" just test the same thing, and I don't see
the value in maintaining that. Also "bubblesort" and "memcpy" don't have comments
explaining why running on those two different test programs actually makes a
difference. Obviously this comment is partially related to the run time, if it was
shorter perhaps it would be less important how many variations we ran.

It's also not clear what failure modes the tests are looking for. There are
comments like "We should almost always see F3 atoms", but it's not clear how
F3 atoms are a signal of a high quality trace. And there are numbers like:
  
  perf_dump_aux_verify "$DATA" 66 6 6
  perf_dump_aux_verify "$DATA" 4188 1630 1630

but there are no comments to say how 66 or 4188 were judged to be "high quality" vs
any other number. This means that anyone encountering a failure is just going to
change the number until it passes, undoing any value that the test added. If the tests
are looking for complete loss of data, then > 1 or > 2 would be sufficient. But if
someone makes a mistake in the driver to produce less data, then these tests aren't
going to catch that anyway, since there is a chance that it falls within the allowed
thresholds.

In my opinion a much better measure of quality would be to look at the coverage of
fully decoded trace, for example if you have 10 functions called from a loop across
multiple DSOs, do each of those functions show up in synthesised instruction samples.

Which brings me to my next point, the tests only seem to look at the raw trace, rather
than the synthesised samples. To me this seems like it's validating what comes out of
the CPU more than looking at what the driver or userspace Perf are doing. I think this
isn't the right place for these tests to live and would be better suited to run on bare
metal. This is because a user isn't going to be interested in how many F3 atoms there are,
that's just an implementation detail. What's much more valuable is what samples are
synthesised. We're also skipping most of the code in Perf by only looking at the raw
trace, which makes it harder to justify putting the tests in the Perf code base.

In short I think it would be much better if we had the following:

 * Much shorter run time
 * Run each test program only once (for example it doesn't add value to run memcpy with different sizes)
 * Only one test for each thing/failure mode
 * Much less overlapping test code (for example F3 atoms only need to be counted for one test, not all of them)
 * Concrete descriptions of failure modes and what each test is looking for
 * Small magic numbers which are easy to justify (like "samples < 1, check for complete loss of data") 
 * Run through the full Perf pipeline and look at the synthesised samples rather than raw trace
 * Some thought about how this fits in with test_arm_coresight.sh

Thanks
James



Test failure outputs:
---

  94: Coresight / Thread Loop 10 Threads - Check TID                  :
--- start ---
test child forked, pid 5821
Couldn't synthesize bpf events.
[ perf record: Woken up 1 times to write data ]
[ perf record: Captured and wrote 128.106 MB ./perf-thread_loop-check-tid-10th.data ]



Warning:
AUX data lost 1 times out of 1!

Thread IDs            not found in perf AUX data
test child finished with -1
---- end ----
Coresight / Thread Loop 10 Threads - Check TID: FAILED!

========================================================


 92: Coresight / Thread Loop 25 Threads                              :
--- start ---
test child forked, pid 5871
Couldn't synthesize bpf events.
[ perf record: Woken up 1 times to write data ]
[ perf record: Captured and wrote 28.849 MB ./perf-thread_loop-25th.data ]
Sanity check number of ATOM_F3 is too low (92062 < 388121)
test child finished with -1
---- end ----
Coresight / Thread Loop 25 Threads: FAILED!


> ---
>  MAINTAINERS                                |   1 +
>  tools/perf/Documentation/arm-coresight.txt | 140 +++++++++++++++++++++
>  2 files changed, 141 insertions(+)
>  create mode 100644 tools/perf/Documentation/arm-coresight.txt
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index d46e8469c467..1a93977a0132 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1890,6 +1890,7 @@ F:	Documentation/trace/coresight/*
>  F:	drivers/hwtracing/coresight/*
>  F:	include/dt-bindings/arm/coresight-cti-dt.h
>  F:	include/linux/coresight*
> +F:	tools/perf/Documentation/arm-coresight.txt
>  F:	tools/perf/arch/arm/util/auxtrace.c
>  F:	tools/perf/arch/arm/util/cs-etm.c
>  F:	tools/perf/arch/arm/util/cs-etm.h
> diff --git a/tools/perf/Documentation/arm-coresight.txt b/tools/perf/Documentation/arm-coresight.txt
> new file mode 100644
> index 000000000000..3a9e6c573c58
> --- /dev/null
> +++ b/tools/perf/Documentation/arm-coresight.txt
> @@ -0,0 +1,140 @@
> +Arm Coresight Support
> +=====================
> +
> +Coresight is a feature of some Arm based processors that allows for
> +debugging. One of the things it can do is trace every instruction
> +executed and remotely expose that information in a hardware compressed
> +stream. Perf is able to locally access that stream and store it to the
> +output perf data files. This stream can then be later decoded to give the
> +instructions that were traced for debugging or profiling purposes. You
> +can log such data with a perf record command like:
> +
> +    perf record -e cs_etm//u testbinary
> +
> +This would run some test binary (testbinary) until it exits and record
> +a perf.data trace file. That file would have AUX sections if coresight
> +is working correctly. You can dump the content of this file as
> +readable text with a command like:
> +
> +    perf report --stdio --dump -i perf.data
> +
> +You should find some sections of this file have AUX data blocks like:
> +
> +    0x1e78 [0x30]: PERF_RECORD_AUXTRACE size: 0x11dd0  offset: 0  ref: 0x1b614fc1061b0ad1  idx: 0  tid: 531230  cpu: -1
> +
> +    . ... CoreSight ETM Trace data: size 73168 bytes
> +            Idx:0; ID:10;   I_ASYNC : Alignment Synchronisation.
> +              Idx:12; ID:10;  I_TRACE_INFO : Trace Info.; INFO=0x0 { CC.0 }
> +              Idx:17; ID:10;  I_ADDR_L_64IS0 : Address, Long, 64 bit, IS0.; Addr=0x0000000000000000;
> +              Idx:26; ID:10;  I_TRACE_ON : Trace On.
> +              Idx:27; ID:10;  I_ADDR_CTXT_L_64IS0 : Address & Context, Long, 64 bit, IS0.; Addr=0x0000FFFFB6069140; Ctxt: AArch64,EL0, NS;
> +              Idx:38; ID:10;  I_ATOM_F6 : Atom format 6.; EEEEEEEEEEEEEEEEEEEEEEEE
> +              Idx:39; ID:10;  I_ATOM_F6 : Atom format 6.; EEEEEEEEEEEEEEEEEEEEEEEE
> +              Idx:40; ID:10;  I_ATOM_F6 : Atom format 6.; EEEEEEEEEEEEEEEEEEEEEEEE
> +              Idx:41; ID:10;  I_ATOM_F6 : Atom format 6.; EEEEEEEEEEEN
> +              ...
> +
> +If you see these above, then your system is tracing coresight data
> +correctly.
> +
> +To compile perf with coresight support in the perf directory do
> +
> +    make CORESIGHT=1
> +
> +This will compile the perf tool with coresight support as well as
> +build some small test binaries for perf test. This requires you also
> +be compiling for 64bit Arm (ARM64/aarch64). The tools run as part of
> +perf coresight tracing are in tests/shell/tools/coresight.
> +
> +You will also want coresight support enabled in your kernel config.
> +Ensure it is enabled with:
> +
> +    CONFIG_CORESIGHT=y
> +
> +There are various other coresight options you probably also want
> +enabled like:
> +
> +    CONFIG_CORESIGHT_LINKS_AND_SINKS=y
> +    CONFIG_CORESIGHT_LINK_AND_SINK_TMC=y
> +    CONFIG_CORESIGHT_CATU=y
> +    CONFIG_CORESIGHT_SINK_TPIU=y
> +    CONFIG_CORESIGHT_SINK_ETBV10=y
> +    CONFIG_CORESIGHT_SOURCE_ETM4X=y
> +    CONFIG_CORESIGHT_STM=y
> +    CONFIG_CORESIGHT_CPU_DEBUG=y
> +    CONFIG_CORESIGHT_CTI=y
> +    CONFIG_CORESIGHT_CTI_INTEGRATION_REGS=y
> +
> +Please refer to the kernel configuration help for more information.
> +
> +Perf test - Verify kernel and userspace perf coresight work
> +===========================================================
> +
> +When you run perf test, it will do a lot of self tests. Some of those
> +tests will cover Coresight (only if enabled and on ARM64). You
> +generally would run perf test from the tools/perf directory in the
> +kernel tree. Some tests will check some internal perf support like:
> +
> +    Check Arm CoreSight trace data recording and synthesized samples
> +
> +Some others will actually use perf record and some test binaries that
> +are in tests/shell/tools/coresight and will collect traces to ensure a
> +minimum level of functionality is met. The scripts that launch these
> +tests are in tests/shell. These will all look like:
> +
> +    Coresight / Memcpy 1M 25 Threads
> +    Coresight / Unroll Loop Thread 2
> +    ...
> +
> +These perf record tests will not run if the tool binaries do not exist
> +in tests/shell/tools/coresight/*/ and will be skipped. If you do not
> +have coresight support in hardware then either do not build perf with
> +coresight support or remove these binaries in order to not have these
> +tests fail and have them skip instead.
> +
> +These tests will log historical results in the current working
> +directory (e.g. tools/perf) and will be named stats-*.csv like:
> +
> +    stats-asm_pure_loop-out.csv
> +    stats-bubble_sort-random.csv
> +    ...
> +
> +These statistic files log some aspects of the AUX data sections in
> +the perf data output counting some numbers of certain encodings (a
> +good way to know that it's working in a very simple way). One problem
> +with coresight is that given a large enough amount of data needing to
> +be logged, some of it can be lost due to the processor not waking up
> +in time to read out all the data from buffers etc.. You will notice
> +that the amount of data collected can vary a lot per run of perf test.
> +If you wish to see how this changes over time, simply run perf test
> +multiple times and all these csv files will have more and more data
> +appended to it that you can later examine, graph and otherwise use to
> +figure out if things have become worse or better.
> +
> +Be aware that amny of these tests take quite a while to run, specifically
> +in processing the perf data file and dumping contents to then examine what
> +is inside.
> +
> +You can change where these csv logs are stored by setting the
> +PERF_TEST_CORESIGHT_STATDIR environment variable before running perf
> +test like:
> +
> +    export PERF_TEST_CORESIGHT_STATDIR=/var/tmp
> +    perf test
> +
> +They will also store resulting perf output data in the current
> +directory for later inspection like:
> +
> +    perf-memcpy-1m.data
> +    perf-thread_loop-2th.data
> +    ...
> +
> +You can alter where the perf data files are stored by setting the
> +PERF_TEST_CORESIGHT_DATADIR environment variable such as:
> +
> +    PERF_TEST_CORESIGHT_DATADIR=/var/tmp
> +    perf test
> +
> +You may wish to set these above environment variables if you which to
> +keep the output of tests outside of the current working directory for
> +longer term storage and examination.
> 
