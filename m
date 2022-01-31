Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F03524A4DB6
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jan 2022 19:05:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237899AbiAaSFF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 13:05:05 -0500
Received: from foss.arm.com ([217.140.110.172]:39572 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236378AbiAaSFE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 13:05:04 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BE919ED1;
        Mon, 31 Jan 2022 10:05:03 -0800 (PST)
Received: from [192.168.99.12] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 647013F73B;
        Mon, 31 Jan 2022 10:05:02 -0800 (PST)
Message-ID: <cce4cf4b-cf82-a5c1-5b01-16a904305d0a@foss.arm.com>
Date:   Mon, 31 Jan 2022 18:05:01 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH 12/12] perf test: Add docs for coresight and related tests
Content-Language: en-US
To:     James Clark <james.clark@arm.com>, linux-kernel@vger.kernel.org
Cc:     coresight@lists.linaro.org, linux-perf-users@vger.kernel.org,
        acme@kernel.org, mike.leach@linaro.org,
        suzuki K Poulose <suzuki.poulose@arm.com>,
        Leo Yan <leo.yan@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>
References: <20211215160403.69264-1-carsten.haitzler@foss.arm.com>
 <20211215160403.69264-12-carsten.haitzler@foss.arm.com>
 <182f43a8-499e-c672-7925-3e81de65655c@arm.com>
From:   Carsten Haitzler <carsten.haitzler@foss.arm.com>
Organization: Arm Ltd.
In-Reply-To: <182f43a8-499e-c672-7925-3e81de65655c@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James

You've found indeed that the tests are for checking if we're even 
exporting any kind of sane data from the system into perf data files. 
The point of this was not to test all of the openocd decoding path and 
to see if, given a perf trace of sufficient completeness, that we can do 
something sensible (autofdo, coverage etc.). These involve much more 
complex decoding on the other end of "we have a perf.data file... let's 
use it". This is all about checking we get perf data files that contain 
somewhat sane content. Does our ""sandwich" have bread at either end and 
some kind of filling in the middle?"

It does appear that we have bugs. These tests seem to show it. We 
regularly fail the TID checks where we provide ZERO blocks of data for 
some threads that run for an extended period of time. This repeats 
itself across various other tests.

I chose 3 specific things to probe for in the test data - the sync 
"headers" which we get every now and again in the stream to see we're 
producing some data at all. Trace info will tell us more - like what 
thread/pid and we should get at least enough of these to cover every 
thread we might run if we have long-lived threads running for a while. 
Perf data is a lossy matter here - we can't guarantee we always collect 
everything. This is why the tests also store the numbers they collect 
over multiple runs in csv files so it is possible over the long term to 
track the quality of data statistically. The documentation I added in 
the patch set covers this. The F3 atoms were simply the filling in the 
sandwich - is there content other than the "structure" of info/sync. I 
could have picked any ATOM_Fx there. As long as there is something 
there, we're collecting some amount of actual execution content.

The idea is that over time when these issues are fixed, we will see more 
of these tests pass more often and the csv data they collect should show 
a jump (on average in the long run) of data collected. Yes - the numbers 
in the tests are a bit "magical" but they can't be derived or calculated 
exactly as they will depend on the instructions a compiler may product 
for a binary as well as other system factors (races). The numbers I 
chose were a result of actually running the tests and collecting data 
and e.g. deciding "if we collect at least 20% of the lowest numbers I 
see, then we're got a pass". It's the same idea in any qualitative test 
- you decide that some value is a passing grade. Of course I could be 
very lenient and just have all the numbers be "1" (at least get one of 
each) and that is about the only derivable value we could agree on is a 
true minimum.

Coverage will suffer the same problem - it will sometimes happen you 
will get no coverage. Eg.g the thread tests above. IF I formulated them 
with a different function per thread and used coverage to figure out 
which threads reported no data - we'd then need to have the coverage be 
100% to pass and we'd be failing right now.

You are right that perhaps I added too many tests to cover different 
paths (it's unusual that people are unhappy with too many tests and want 
fewer :)), but I see the point of "it takes too long to run" and I can 
certainly trim the tests down.

I've been running on my dragonboard 845 and they don't all pass for me 
either - as above. 95%+ of the test time is spent dumping the perf.data 
file and parsing out the coresight traces. It's not that fast. I did 
quickly look into running perf on perf (seeing if there were some 
blindingly obvious hotspots somewhere to fix) but didn't see anything 
jump out at me. Collecting less data of course speeds it up and that's 
easy to tweak. I could definitely speed things up if I had the checker 
stop parsing the dump output once we had "enough of item X" (I_ASYNC, 
I_TRACE_INFO) which would certainly speed things up. Lowering those 
numbers to bare minimums would make it a lot faster but it would 
probably have issues with the TID checks as I'd like to give the system 
enough time to plausibly collect some data on every thread.

The multiple tests with different threads were there to ensure even on 
many-core system we can saturate all cores to see we are context 
switching between threads and then still capturing data on all cores. 
The point of these tests is to stress-test and not just "bare minimum - 
do we get something" and they certainly seem to find problems in the 
process. I built them so it'd be easy to just drop more tests and tools 
into directories and expand on over time to improve quality of things 
covered. The bubble sort tests were ones that were being used for perf 
quality tests already internally in their own separate git repo, so I 
included them. I can remove them of course as they probably don't 
provide any value over other simpler tests.

Testing the pipeline AFTER collecting some sensible data to see if we 
can decode it and e.g. apply it to fdo or coverage is a separate set of 
tests which this was not meant to address (at this stage). Those tests 
certainly do not fit the same pattern as these which follow a simple 
design patter of build N test tools, run those test tools and collect 
data, check the data is semi-sane and seemingly collecting what it should.

So I can:

  * Trim the number of tests down
    * Fewer versions of the same one
    * Drop the sorts
  * Optimize time spent checking data (bail early when minimum reached)

On 1/19/22 16:43, James Clark wrote:
> 
> 
> On 15/12/2021 16:04, carsten.haitzler@foss.arm.com wrote:
>> From: Carsten Haitzler <carsten.haitzler@arm.com>
>>
>> This adds documentation about the coresight specific tests as part of
>> perf test
>>
>> Signed-off-by: Carsten Haitzler <carsten.haitzler@arm.com>
> 
> I will use this commit to comment on the set as a whole. The other comments about
> specific issues I have left inline.
> 
> I ran the tests twice on N1SDP (kernel version perf/core 48ffaedf017ad) and had two
> different sets of failures, indicating some flakyness, which is one reason to not have
> tests with magic numbers as Leo has raised. Are you able to give a complete list of
> where you have run these so far? I know we can't check everywhere, but at least all
> of Arm's own reference platforms should be passing.
> 
> First run:
>    
>     92: Coresight / Thread Loop 25 Threads                              : FAILED!
>     94: Coresight / Thread Loop 10 Threads - Check TID                  : FAILED!
>     95: Coresight / Thread Loop 2 Threads - Check TID                   : FAILED!
>     96: Coresight / Thread Loop 250 Threads - Check TID                 : FAILED!
>     97: Coresight / Unroll Loop Thread 1                                : FAILED!
>     99: Coresight / Unroll Loop Thread 2                                : FAILED!
>   
> Second run:
> 
>    92: Coresight / Thread Loop 25 Threads                              : FAILED!
>    94: Coresight / Thread Loop 10 Threads - Check TID                  : FAILED!
>    95: Coresight / Thread Loop 2 Threads - Check TID                   : FAILED!
>    96: Coresight / Thread Loop 250 Threads - Check TID                 : FAILED!
>    97: Coresight / Unroll Loop Thread 1                                : FAILED!
> 
> I have pasted the verbose output of two of these at the very end.
> 
> The major problem I have with the tests is the time that they take to run. Now
> a full test run takes 31m+ on N1SDP, where previously it took 1m 9s. There are
> quite a few reasons why this isn't a good idea. It will take extra cycles on
> anyone's CI and that means it will now take longer for anyone to make any changes
> if they run the tests, slowing down all Perf work from now onward. Even if you
> want to run just the Coresight tests, it doesn't really help as that is 90% of
> the time taken, so personally for me I'm not likely to run them while working on
> Coresight changes. The longer the tests take the more likely it is that they are
> skipped, reducing the benefits of the tests. Also if anyone has timeouts set on
> CI these are likely going to have to be adjusted now.
> 
> Is it possible to get the run time of each test down to 5-10 seconds? This will
> make it much nicer for us to work with going forwards.
> 
> I'd also have liked to have had a discussion on the mailing list about what the test
> methodology should be in general before starting. For example for this patch set it
> looks like the coverage is quite wide because of the number of tests and time it
> takes to run, but actually they all use "cs_etm//u -- <process>" as the run command.
> This only tests per-process userspace mode resulting in very narrow coverage.
> And there is no mention in a cover letter about how this expands on or interacts
> with the existing test_arm_coresight.sh test which I don't think can be ignored.
> For example it iterates over sinks. Could that same iteration not be applied to
> these tests? They seem to exist in isolation and it's not clear which one we should
> be adding to going forwards.
> 
> I'd like to see a much more exploration of the different modes and flags to justify
> such a high run time:
>    
>    * per-CPU
>    * per-thread
>    * with and without timestamps
>    * strobing
> 
> If this is supposed to be just an initial implementation covering one case, then
> by the "test one thing" ethos, there should only be one test case. Each case
> should be testing one thing with minimal overlapping. But it looks like tests like
> "Thread loop 10" and "thread loop 250" just test the same thing, and I don't see
> the value in maintaining that. Also "bubblesort" and "memcpy" don't have comments
> explaining why running on those two different test programs actually makes a
> difference. Obviously this comment is partially related to the run time, if it was
> shorter perhaps it would be less important how many variations we ran.
> 
> It's also not clear what failure modes the tests are looking for. There are
> comments like "We should almost always see F3 atoms", but it's not clear how
> F3 atoms are a signal of a high quality trace. And there are numbers like:
>    
>    perf_dump_aux_verify "$DATA" 66 6 6
>    perf_dump_aux_verify "$DATA" 4188 1630 1630
> 
> but there are no comments to say how 66 or 4188 were judged to be "high quality" vs
> any other number. This means that anyone encountering a failure is just going to
> change the number until it passes, undoing any value that the test added. If the tests
> are looking for complete loss of data, then > 1 or > 2 would be sufficient. But if
> someone makes a mistake in the driver to produce less data, then these tests aren't
> going to catch that anyway, since there is a chance that it falls within the allowed
> thresholds.
> 
> In my opinion a much better measure of quality would be to look at the coverage of
> fully decoded trace, for example if you have 10 functions called from a loop across
> multiple DSOs, do each of those functions show up in synthesised instruction samples.
> 
> Which brings me to my next point, the tests only seem to look at the raw trace, rather
> than the synthesised samples. To me this seems like it's validating what comes out of
> the CPU more than looking at what the driver or userspace Perf are doing. I think this
> isn't the right place for these tests to live and would be better suited to run on bare
> metal. This is because a user isn't going to be interested in how many F3 atoms there are,
> that's just an implementation detail. What's much more valuable is what samples are
> synthesised. We're also skipping most of the code in Perf by only looking at the raw
> trace, which makes it harder to justify putting the tests in the Perf code base.
> 
> In short I think it would be much better if we had the following:
> 
>   * Much shorter run time
>   * Run each test program only once (for example it doesn't add value to run memcpy with different sizes)
>   * Only one test for each thing/failure mode
>   * Much less overlapping test code (for example F3 atoms only need to be counted for one test, not all of them)
>   * Concrete descriptions of failure modes and what each test is looking for
>   * Small magic numbers which are easy to justify (like "samples < 1, check for complete loss of data")
>   * Run through the full Perf pipeline and look at the synthesised samples rather than raw trace
>   * Some thought about how this fits in with test_arm_coresight.sh
> 
> Thanks
> James
> 
> 
> 
> Test failure outputs:
> ---
> 
>    94: Coresight / Thread Loop 10 Threads - Check TID                  :
> --- start ---
> test child forked, pid 5821
> Couldn't synthesize bpf events.
> [ perf record: Woken up 1 times to write data ]
> [ perf record: Captured and wrote 128.106 MB ./perf-thread_loop-check-tid-10th.data ]
> 
> 
> 
> Warning:
> AUX data lost 1 times out of 1!
> 
> Thread IDs            not found in perf AUX data
> test child finished with -1
> ---- end ----
> Coresight / Thread Loop 10 Threads - Check TID: FAILED!
> 
> ========================================================
> 
> 
>   92: Coresight / Thread Loop 25 Threads                              :
> --- start ---
> test child forked, pid 5871
> Couldn't synthesize bpf events.
> [ perf record: Woken up 1 times to write data ]
> [ perf record: Captured and wrote 28.849 MB ./perf-thread_loop-25th.data ]
> Sanity check number of ATOM_F3 is too low (92062 < 388121)
> test child finished with -1
> ---- end ----
> Coresight / Thread Loop 25 Threads: FAILED!
> 
> 
>> ---
>>   MAINTAINERS                                |   1 +
>>   tools/perf/Documentation/arm-coresight.txt | 140 +++++++++++++++++++++
>>   2 files changed, 141 insertions(+)
>>   create mode 100644 tools/perf/Documentation/arm-coresight.txt
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index d46e8469c467..1a93977a0132 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -1890,6 +1890,7 @@ F:	Documentation/trace/coresight/*
>>   F:	drivers/hwtracing/coresight/*
>>   F:	include/dt-bindings/arm/coresight-cti-dt.h
>>   F:	include/linux/coresight*
>> +F:	tools/perf/Documentation/arm-coresight.txt
>>   F:	tools/perf/arch/arm/util/auxtrace.c
>>   F:	tools/perf/arch/arm/util/cs-etm.c
>>   F:	tools/perf/arch/arm/util/cs-etm.h
>> diff --git a/tools/perf/Documentation/arm-coresight.txt b/tools/perf/Documentation/arm-coresight.txt
>> new file mode 100644
>> index 000000000000..3a9e6c573c58
>> --- /dev/null
>> +++ b/tools/perf/Documentation/arm-coresight.txt
>> @@ -0,0 +1,140 @@
>> +Arm Coresight Support
>> +=====================
>> +
>> +Coresight is a feature of some Arm based processors that allows for
>> +debugging. One of the things it can do is trace every instruction
>> +executed and remotely expose that information in a hardware compressed
>> +stream. Perf is able to locally access that stream and store it to the
>> +output perf data files. This stream can then be later decoded to give the
>> +instructions that were traced for debugging or profiling purposes. You
>> +can log such data with a perf record command like:
>> +
>> +    perf record -e cs_etm//u testbinary
>> +
>> +This would run some test binary (testbinary) until it exits and record
>> +a perf.data trace file. That file would have AUX sections if coresight
>> +is working correctly. You can dump the content of this file as
>> +readable text with a command like:
>> +
>> +    perf report --stdio --dump -i perf.data
>> +
>> +You should find some sections of this file have AUX data blocks like:
>> +
>> +    0x1e78 [0x30]: PERF_RECORD_AUXTRACE size: 0x11dd0  offset: 0  ref: 0x1b614fc1061b0ad1  idx: 0  tid: 531230  cpu: -1
>> +
>> +    . ... CoreSight ETM Trace data: size 73168 bytes
>> +            Idx:0; ID:10;   I_ASYNC : Alignment Synchronisation.
>> +              Idx:12; ID:10;  I_TRACE_INFO : Trace Info.; INFO=0x0 { CC.0 }
>> +              Idx:17; ID:10;  I_ADDR_L_64IS0 : Address, Long, 64 bit, IS0.; Addr=0x0000000000000000;
>> +              Idx:26; ID:10;  I_TRACE_ON : Trace On.
>> +              Idx:27; ID:10;  I_ADDR_CTXT_L_64IS0 : Address & Context, Long, 64 bit, IS0.; Addr=0x0000FFFFB6069140; Ctxt: AArch64,EL0, NS;
>> +              Idx:38; ID:10;  I_ATOM_F6 : Atom format 6.; EEEEEEEEEEEEEEEEEEEEEEEE
>> +              Idx:39; ID:10;  I_ATOM_F6 : Atom format 6.; EEEEEEEEEEEEEEEEEEEEEEEE
>> +              Idx:40; ID:10;  I_ATOM_F6 : Atom format 6.; EEEEEEEEEEEEEEEEEEEEEEEE
>> +              Idx:41; ID:10;  I_ATOM_F6 : Atom format 6.; EEEEEEEEEEEN
>> +              ...
>> +
>> +If you see these above, then your system is tracing coresight data
>> +correctly.
>> +
>> +To compile perf with coresight support in the perf directory do
>> +
>> +    make CORESIGHT=1
>> +
>> +This will compile the perf tool with coresight support as well as
>> +build some small test binaries for perf test. This requires you also
>> +be compiling for 64bit Arm (ARM64/aarch64). The tools run as part of
>> +perf coresight tracing are in tests/shell/tools/coresight.
>> +
>> +You will also want coresight support enabled in your kernel config.
>> +Ensure it is enabled with:
>> +
>> +    CONFIG_CORESIGHT=y
>> +
>> +There are various other coresight options you probably also want
>> +enabled like:
>> +
>> +    CONFIG_CORESIGHT_LINKS_AND_SINKS=y
>> +    CONFIG_CORESIGHT_LINK_AND_SINK_TMC=y
>> +    CONFIG_CORESIGHT_CATU=y
>> +    CONFIG_CORESIGHT_SINK_TPIU=y
>> +    CONFIG_CORESIGHT_SINK_ETBV10=y
>> +    CONFIG_CORESIGHT_SOURCE_ETM4X=y
>> +    CONFIG_CORESIGHT_STM=y
>> +    CONFIG_CORESIGHT_CPU_DEBUG=y
>> +    CONFIG_CORESIGHT_CTI=y
>> +    CONFIG_CORESIGHT_CTI_INTEGRATION_REGS=y
>> +
>> +Please refer to the kernel configuration help for more information.
>> +
>> +Perf test - Verify kernel and userspace perf coresight work
>> +===========================================================
>> +
>> +When you run perf test, it will do a lot of self tests. Some of those
>> +tests will cover Coresight (only if enabled and on ARM64). You
>> +generally would run perf test from the tools/perf directory in the
>> +kernel tree. Some tests will check some internal perf support like:
>> +
>> +    Check Arm CoreSight trace data recording and synthesized samples
>> +
>> +Some others will actually use perf record and some test binaries that
>> +are in tests/shell/tools/coresight and will collect traces to ensure a
>> +minimum level of functionality is met. The scripts that launch these
>> +tests are in tests/shell. These will all look like:
>> +
>> +    Coresight / Memcpy 1M 25 Threads
>> +    Coresight / Unroll Loop Thread 2
>> +    ...
>> +
>> +These perf record tests will not run if the tool binaries do not exist
>> +in tests/shell/tools/coresight/*/ and will be skipped. If you do not
>> +have coresight support in hardware then either do not build perf with
>> +coresight support or remove these binaries in order to not have these
>> +tests fail and have them skip instead.
>> +
>> +These tests will log historical results in the current working
>> +directory (e.g. tools/perf) and will be named stats-*.csv like:
>> +
>> +    stats-asm_pure_loop-out.csv
>> +    stats-bubble_sort-random.csv
>> +    ...
>> +
>> +These statistic files log some aspects of the AUX data sections in
>> +the perf data output counting some numbers of certain encodings (a
>> +good way to know that it's working in a very simple way). One problem
>> +with coresight is that given a large enough amount of data needing to
>> +be logged, some of it can be lost due to the processor not waking up
>> +in time to read out all the data from buffers etc.. You will notice
>> +that the amount of data collected can vary a lot per run of perf test.
>> +If you wish to see how this changes over time, simply run perf test
>> +multiple times and all these csv files will have more and more data
>> +appended to it that you can later examine, graph and otherwise use to
>> +figure out if things have become worse or better.
>> +
>> +Be aware that amny of these tests take quite a while to run, specifically
>> +in processing the perf data file and dumping contents to then examine what
>> +is inside.
>> +
>> +You can change where these csv logs are stored by setting the
>> +PERF_TEST_CORESIGHT_STATDIR environment variable before running perf
>> +test like:
>> +
>> +    export PERF_TEST_CORESIGHT_STATDIR=/var/tmp
>> +    perf test
>> +
>> +They will also store resulting perf output data in the current
>> +directory for later inspection like:
>> +
>> +    perf-memcpy-1m.data
>> +    perf-thread_loop-2th.data
>> +    ...
>> +
>> +You can alter where the perf data files are stored by setting the
>> +PERF_TEST_CORESIGHT_DATADIR environment variable such as:
>> +
>> +    PERF_TEST_CORESIGHT_DATADIR=/var/tmp
>> +    perf test
>> +
>> +You may wish to set these above environment variables if you which to
>> +keep the output of tests outside of the current working directory for
>> +longer term storage and examination.
>>
