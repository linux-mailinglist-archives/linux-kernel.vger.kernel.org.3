Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB124549A2C
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 19:37:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241685AbiFMRgs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 13:36:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240749AbiFMRe6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 13:34:58 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B00E61312BB;
        Mon, 13 Jun 2022 06:00:49 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 61E95D6E;
        Mon, 13 Jun 2022 06:00:49 -0700 (PDT)
Received: from [192.168.99.12] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B4B273F792;
        Mon, 13 Jun 2022 06:00:47 -0700 (PDT)
Message-ID: <2c4e5950-f6fe-5b97-4856-70e037b7e5bc@foss.arm.com>
Date:   Mon, 13 Jun 2022 14:00:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH 3/3] perf test: Add coresight tests to guage quality of
 data generated
Content-Language: en-US
To:     Mathieu Poirier <mathieu.poirier@linaro.org>
Cc:     linux-kernel@vger.kernel.org, coresight@lists.linaro.org,
        suzuki.poulose@arm.com, mike.leach@linaro.org, leo.yan@linaro.org,
        linux-perf-users@vger.kernel.org, acme@kernel.org
References: <20220309122859.31487-1-carsten.haitzler@foss.arm.com>
 <20220309122859.31487-3-carsten.haitzler@foss.arm.com>
 <20220530162730.GA480245@p14s>
From:   Carsten Haitzler <carsten.haitzler@foss.arm.com>
Organization: Arm Ltd.
In-Reply-To: <20220530162730.GA480245@p14s>
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



On 5/30/22 17:27, Mathieu Poirier wrote:
> On Wed, Mar 09, 2022 at 12:28:59PM +0000, carsten.haitzler@foss.arm.com wrote:
>> From: Carsten Haitzler <carsten.haitzler@arm.com>
>>
>> This adds a test harness and tests to run perf record and examine the
>> resuling output when coresight is enabled on arm64 and check the
>> resulting quality of the output as part of perf test. These tests use
>> various tools to produce output from perf record then measure some key
>> specific aspects of that data to see if the data exists at all and
>> contains key aspects such as measuring some data for every thread of
>> a test or produces sufficient data for large exeuction runs of a large
>> executable. etc.
>>
>> Signed-off-by: Carsten Haitzler <carsten.haitzler@arm.com>
>> ---
>>   MAINTAINERS                                   |   4 +
>>   tools/perf/.gitignore                         |   6 +-
>>   tools/perf/Documentation/arm-coresight.txt    | 140 ++++++++++++++++++
>>   tools/perf/Makefile.perf                      |  14 +-
>>   tools/perf/tests/shell/coresight/Makefile     |  30 ++++
>>   .../tests/shell/coresight/Makefile.miniconfig |  23 +++
>>   .../shell/coresight/asm_pure_loop/.gitignore  |   1 +
>>   .../shell/coresight/asm_pure_loop/Makefile    |  30 ++++
>>   .../coresight/asm_pure_loop/asm_pure_loop.S   |  28 ++++
>>   .../shell/coresight/memcpy_thread/.gitignore  |   1 +
>>   .../shell/coresight/memcpy_thread/Makefile    |  29 ++++
>>   .../coresight/memcpy_thread/memcpy_thread.c   |  79 ++++++++++
>>   .../shell/coresight/thread_loop/.gitignore    |   1 +
>>   .../shell/coresight/thread_loop/Makefile      |  29 ++++
>>   .../shell/coresight/thread_loop/thread_loop.c |  86 +++++++++++
>>   .../coresight/unroll_loop_thread/.gitignore   |   1 +
>>   .../coresight/unroll_loop_thread/Makefile     |  29 ++++
>>   .../unroll_loop_thread/unroll_loop_thread.c   |  74 +++++++++
>>   .../tests/shell/coresight_asm_pure_loop.sh    |  18 +++
>>   .../shell/coresight_memcpy_thread_16k_10.sh   |  18 +++
>>   .../coresight_thread_loop_check_tid_10.sh     |  19 +++
>>   .../coresight_thread_loop_check_tid_2.sh      |  19 +++
>>   .../shell/coresight_unroll_loop_thread_10.sh  |  18 +++
>>   tools/perf/tests/shell/lib/coresight.sh       | 130 ++++++++++++++++
>>   24 files changed, 823 insertions(+), 4 deletions(-)
> 
> As Leo pointed out this is a big patch and hard to digest intellectually.
> 
>>   create mode 100644 tools/perf/Documentation/arm-coresight.txt
>>   create mode 100644 tools/perf/tests/shell/coresight/Makefile
>>   create mode 100644 tools/perf/tests/shell/coresight/Makefile.miniconfig
>>   create mode 100644 tools/perf/tests/shell/coresight/asm_pure_loop/.gitignore
>>   create mode 100644 tools/perf/tests/shell/coresight/asm_pure_loop/Makefile
>>   create mode 100644 tools/perf/tests/shell/coresight/asm_pure_loop/asm_pure_loop.S
>>   create mode 100644 tools/perf/tests/shell/coresight/memcpy_thread/.gitignore
>>   create mode 100644 tools/perf/tests/shell/coresight/memcpy_thread/Makefile
>>   create mode 100644 tools/perf/tests/shell/coresight/memcpy_thread/memcpy_thread.c
>>   create mode 100644 tools/perf/tests/shell/coresight/thread_loop/.gitignore
>>   create mode 100644 tools/perf/tests/shell/coresight/thread_loop/Makefile
>>   create mode 100644 tools/perf/tests/shell/coresight/thread_loop/thread_loop.c
>>   create mode 100644 tools/perf/tests/shell/coresight/unroll_loop_thread/.gitignore
>>   create mode 100644 tools/perf/tests/shell/coresight/unroll_loop_thread/Makefile
>>   create mode 100644 tools/perf/tests/shell/coresight/unroll_loop_thread/unroll_loop_thread.c
>>   create mode 100755 tools/perf/tests/shell/coresight_asm_pure_loop.sh
>>   create mode 100755 tools/perf/tests/shell/coresight_memcpy_thread_16k_10.sh
>>   create mode 100755 tools/perf/tests/shell/coresight_thread_loop_check_tid_10.sh
>>   create mode 100755 tools/perf/tests/shell/coresight_thread_loop_check_tid_2.sh
>>   create mode 100755 tools/perf/tests/shell/coresight_unroll_loop_thread_10.sh
>>   create mode 100644 tools/perf/tests/shell/lib/coresight.sh
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 673c7124ca82..18cc20609f2e 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -1918,10 +1918,14 @@ F:	drivers/hwtracing/coresight/*
>>   F:	include/dt-bindings/arm/coresight-cti-dt.h
>>   F:	include/linux/coresight*
>>   F:	samples/coresight/*
>> +F:	tools/perf/Documentation/arm-coresight.txt
>>   F:	tools/perf/arch/arm/util/auxtrace.c
>>   F:	tools/perf/arch/arm/util/cs-etm.c
>>   F:	tools/perf/arch/arm/util/cs-etm.h
>>   F:	tools/perf/arch/arm/util/pmu.c
>> +F:	tools/perf/tests/shell/coresight_*
>> +F:	tools/perf/tests/shell/tools/Makefile
>> +F:	tools/perf/tests/shell/tools/coresight/*
>>   F:	tools/perf/util/cs-etm-decoder/*
>>   F:	tools/perf/util/cs-etm.*
>>   
>> diff --git a/tools/perf/.gitignore b/tools/perf/.gitignore
>> index 20b8ab984d5f..138c679ecacd 100644
>> --- a/tools/perf/.gitignore
>> +++ b/tools/perf/.gitignore
>> @@ -15,8 +15,9 @@ perf*.1
>>   perf*.xml
>>   perf*.html
>>   common-cmds.h
>> -perf.data
>> -perf.data.old
>> +perf*.data
>> +perf*.data.old
>> +stats-*.csv
>>   output.svg
>>   perf-archive
>>   perf-with-kcore
>> @@ -30,6 +31,7 @@ config.mak.autogen
>>   *-flex.*
>>   *.pyc
>>   *.pyo
>> +*.stdout
>>   .config-detected
>>   util/intel-pt-decoder/inat-tables.c
>>   arch/*/include/generated/
>> diff --git a/tools/perf/Documentation/arm-coresight.txt b/tools/perf/Documentation/arm-coresight.txt
>> new file mode 100644
>> index 000000000000..3a9e6c573c58
>> --- /dev/null
>> +++ b/tools/perf/Documentation/arm-coresight.txt
> 
> I think it would be best to keep all the coresight documentation under the
> current coresight documentation repository[1].  That way all the information on
> coresight can be found in a central place.

OK. I just added this here because this was relevant "get you going" 
documentation for perf + coresight and testing and other relevant docs 
were here including architecture specific ones like the intel docs. I'll 
find a way of merging it with the above mentioned docs.

> Some part of what is added by this patch is redundant with what is currently
> available in [1].  Other parts are tests specific and should be added under
> something like "coresight-perf-test.rst".

Sure - some is, but most is not mentioned there (the vast majority). I'd 
argue essentially all of it is relevant to someone getting started and 
the documentation in the above location is not very friendly or useful 
in that regard (which is why I wrote the documentation here to begin 
with). As I can't really find anything it duplicates other than the 
initial paragraph which I can remove, I'll merge the rest in and link it 
in as above, unless you can be specific on what it really duplicates?

> Thanks,
> Mathieu
> 
> [1]. Documentation/trace/coresight/
> 
> 
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
>> diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
>> index ac861e42c8f7..b97db83992e0 100644
>> --- a/tools/perf/Makefile.perf
>> +++ b/tools/perf/Makefile.perf
>> @@ -630,7 +630,15 @@ sync_file_range_tbls := $(srctree)/tools/perf/trace/beauty/sync_file_range.sh
>>   $(sync_file_range_arrays): $(linux_uapi_dir)/fs.h $(sync_file_range_tbls)
>>   	$(Q)$(SHELL) '$(sync_file_range_tbls)' $(linux_uapi_dir) > $@
>>   
>> -all: shell_compatibility_test $(ALL_PROGRAMS) $(LANG_BINDINGS) $(OTHER_PROGRAMS)
>> +TESTS_CORESIGHT_DIR := $(srctree)/tools/perf/tests/shell/coresight
>> +
>> +tests-coresight-targets: FORCE
>> +	$(Q)$(MAKE) -C $(TESTS_CORESIGHT_DIR)
>> +
>> +tests-coresight-targets-clean:
>> +	$(Q)$(MAKE) -C $(TESTS_CORESIGHT_DIR) clean
>> +
>> +all: shell_compatibility_test $(ALL_PROGRAMS) $(LANG_BINDINGS) $(OTHER_PROGRAMS) tests-coresight-targets
>>   
>>   # Create python binding output directory if not already present
>>   _dummy := $(shell [ -d '$(OUTPUT)python' ] || mkdir -p '$(OUTPUT)python')
>> @@ -1020,6 +1028,7 @@ install-tests: all install-gtk
>>   		$(INSTALL) tests/shell/*.sh '$(DESTDIR_SQ)$(perfexec_instdir_SQ)/tests/shell'; \
>>   		$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(perfexec_instdir_SQ)/tests/shell/lib'; \
>>   		$(INSTALL) tests/shell/lib/*.sh '$(DESTDIR_SQ)$(perfexec_instdir_SQ)/tests/shell/lib'
>> +	$(Q)$(MAKE) -C tests/shell/coresight install-tests
>>   
>>   install-bin: install-tools install-tests install-traceevent-plugins
>>   
>> @@ -1088,7 +1097,7 @@ endif # BUILD_BPF_SKEL
>>   bpf-skel-clean:
>>   	$(call QUIET_CLEAN, bpf-skel) $(RM) -r $(SKEL_TMP_OUT) $(SKELETONS)
>>   
>> -clean:: $(LIBTRACEEVENT)-clean $(LIBAPI)-clean $(LIBBPF)-clean $(LIBSUBCMD)-clean $(LIBPERF)-clean fixdep-clean python-clean bpf-skel-clean
>> +clean:: $(LIBTRACEEVENT)-clean $(LIBAPI)-clean $(LIBBPF)-clean $(LIBSUBCMD)-clean $(LIBPERF)-clean fixdep-clean python-clean bpf-skel-clean tests-coresight-targets-clean
>>   	$(call QUIET_CLEAN, core-objs)  $(RM) $(LIBPERF_A) $(OUTPUT)perf-archive $(OUTPUT)perf-with-kcore $(OUTPUT)perf-iostat $(LANG_BINDINGS)
>>   	$(Q)find $(if $(OUTPUT),$(OUTPUT),.) -name '*.o' -delete -o -name '\.*.cmd' -delete -o -name '\.*.d' -delete
>>   	$(Q)$(RM) $(OUTPUT).config-detected
>> @@ -1155,5 +1164,6 @@ FORCE:
>>   .PHONY: shell_compatibility_test please_set_SHELL_PATH_to_a_more_modern_shell
>>   .PHONY: $(GIT-HEAD-PHONY) TAGS tags cscope FORCE prepare
>>   .PHONY: libtraceevent_plugins archheaders
>> +.PHONY: $(TESTS_CORESIGHT_TARGETS)
>>   
>>   endif # force_fixdep
>> diff --git a/tools/perf/tests/shell/coresight/Makefile b/tools/perf/tests/shell/coresight/Makefile
>> new file mode 100644
>> index 000000000000..dda99aeac158
>> --- /dev/null
>> +++ b/tools/perf/tests/shell/coresight/Makefile
>> @@ -0,0 +1,30 @@
>> +# SPDX-License-Identifier: GPL-2.0-only
>> +# Carsten Haitzler <carsten.haitzler@arm.com>, 2021
>> +include ../../../../../tools/scripts/Makefile.include
>> +include ../../../../../tools/scripts/Makefile.arch
>> +include ../../../../../tools/scripts/utilities.mak
>> +
>> +SUBDIRS = \
>> +	asm_pure_loop \
>> +	thread_loop \
>> +	memcpy_thread \
>> +	unroll_loop_thread
>> +
>> +all: $(SUBDIRS)
>> +$(SUBDIRS):
>> +	$(Q)$(MAKE) -C $@
>> +
>> +INSTALLDIRS = $(SUBDIRS:%=install-%)
>> +
>> +install-tests: $(INSTALLDIRS)
>> +$(INSTALLDIRS):
>> +	$(Q)$(MAKE) -C $(@:install-%=%) install-tests
>> +
>> +CLEANDIRS = $(SUBDIRS:%=clean-%)
>> +
>> +clean: $(CLEANDIRS)
>> +$(CLEANDIRS):
>> +	$(Q)$(MAKE) -C $(@:clean-%=%) clean >/dev/null
>> +
>> +.PHONY: all clean $(SUBDIRS) $(CLEANDIRS) $(INSTALLDIRS)
>> +
>> diff --git a/tools/perf/tests/shell/coresight/Makefile.miniconfig b/tools/perf/tests/shell/coresight/Makefile.miniconfig
>> new file mode 100644
>> index 000000000000..893c12685fed
>> --- /dev/null
>> +++ b/tools/perf/tests/shell/coresight/Makefile.miniconfig
>> @@ -0,0 +1,23 @@
>> +# SPDX-License-Identifier: GPL-2.0-only
>> +# Carsten Haitzler <carsten.haitzler@arm.com>, 2021
>> +
>> +ifndef DESTDIR
>> +prefix ?= $(HOME)
>> +endif
>> +
>> +DESTDIR_SQ = $(subst ','\'',$(DESTDIR))
>> +perfexecdir = libexec/perf-core
>> +perfexec_instdir = $(perfexecdir)
>> +
>> +ifneq ($(filter /%,$(firstword $(perfexecdir))),)
>> +perfexec_instdir = $(perfexecdir)
>> +else
>> +perfexec_instdir = $(prefix)/$(perfexecdir)
>> +endif
>> +
>> +perfexec_instdir_SQ = $(subst ','\'',$(perfexec_instdir))
>> +INSTALL = install
>> +
>> +include ../../../../../scripts/Makefile.include
>> +include ../../../../../scripts/Makefile.arch
>> +include ../../../../../scripts/utilities.mak
>> diff --git a/tools/perf/tests/shell/coresight/asm_pure_loop/.gitignore b/tools/perf/tests/shell/coresight/asm_pure_loop/.gitignore
>> new file mode 100644
>> index 000000000000..468673ac32e8
>> --- /dev/null
>> +++ b/tools/perf/tests/shell/coresight/asm_pure_loop/.gitignore
>> @@ -0,0 +1 @@
>> +asm_pure_loop
>> diff --git a/tools/perf/tests/shell/coresight/asm_pure_loop/Makefile b/tools/perf/tests/shell/coresight/asm_pure_loop/Makefile
>> new file mode 100644
>> index 000000000000..10c5a60cb71c
>> --- /dev/null
>> +++ b/tools/perf/tests/shell/coresight/asm_pure_loop/Makefile
>> @@ -0,0 +1,30 @@
>> +# SPDX-License-Identifier: GPL-2.0
>> +# Carsten Haitzler <carsten.haitzler@arm.com>, 2021
>> +
>> +include ../Makefile.miniconfig
>> +
>> +BIN=asm_pure_loop
>> +LIB=
>> +
>> +all: $(BIN)
>> +
>> +$(BIN): $(BIN).S
>> +ifdef CORESIGHT
>> +ifeq ($(ARCH),arm64)
>> +	$(Q)$(CC) $(BIN).S -nostdlib -static -o $(BIN) $(LIB)
>> +endif
>> +endif
>> +
>> +install-tests: all
>> +ifdef CORESIGHT
>> +ifeq ($(ARCH),arm64)
>> +	$(call QUIET_INSTALL, tests) \
>> +		$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(perfexec_instdir_SQ)/tests/shell/tools/$(BIN)'; \
>> +		$(INSTALL) $(BIN) '$(DESTDIR_SQ)$(perfexec_instdir_SQ)/tests/shell/tools/$(BIN)/$(BIN)'
>> +endif
>> +endif
>> +
>> +clean:
>> +	$(Q)$(RM) -f $(BIN)
>> +
>> +.PHONY: all clean install-tests
>> diff --git a/tools/perf/tests/shell/coresight/asm_pure_loop/asm_pure_loop.S b/tools/perf/tests/shell/coresight/asm_pure_loop/asm_pure_loop.S
>> new file mode 100644
>> index 000000000000..75cf084a927d
>> --- /dev/null
>> +++ b/tools/perf/tests/shell/coresight/asm_pure_loop/asm_pure_loop.S
>> @@ -0,0 +1,28 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +/* Tamas Zsoldos <tamas.zsoldos@arm.com>, 2021 */
>> +
>> +.globl _start
>> +_start:
>> +	mov	x0, 0x0000ffff
>> +	mov	x1, xzr
>> +loop:
>> +	nop
>> +	nop
>> +	cbnz	x1, noskip
>> +	nop
>> +	nop
>> +	adrp	x2, skip
>> +	add 	x2, x2, :lo12:skip
>> +	br	x2
>> +	nop
>> +	nop
>> +noskip:
>> +	nop
>> +	nop
>> +skip:
>> +	sub	x0, x0, 1
>> +	cbnz	x0, loop
>> +
>> +	mov	x0, #0
>> +	mov	x8, #93 // __NR_exit syscall
>> +	svc	#0
>> diff --git a/tools/perf/tests/shell/coresight/memcpy_thread/.gitignore b/tools/perf/tests/shell/coresight/memcpy_thread/.gitignore
>> new file mode 100644
>> index 000000000000..f8217e56091e
>> --- /dev/null
>> +++ b/tools/perf/tests/shell/coresight/memcpy_thread/.gitignore
>> @@ -0,0 +1 @@
>> +memcpy_thread
>> diff --git a/tools/perf/tests/shell/coresight/memcpy_thread/Makefile b/tools/perf/tests/shell/coresight/memcpy_thread/Makefile
>> new file mode 100644
>> index 000000000000..e2604cfae74b
>> --- /dev/null
>> +++ b/tools/perf/tests/shell/coresight/memcpy_thread/Makefile
>> @@ -0,0 +1,29 @@
>> +# SPDX-License-Identifier: GPL-2.0
>> +# Carsten Haitzler <carsten.haitzler@arm.com>, 2021
>> +include ../Makefile.miniconfig
>> +
>> +BIN=memcpy_thread
>> +LIB=-pthread
>> +
>> +all: $(BIN)
>> +
>> +$(BIN): $(BIN).c
>> +ifdef CORESIGHT
>> +ifeq ($(ARCH),arm64)
>> +	$(Q)$(CC) $(BIN).c -o $(BIN) $(LIB)
>> +endif
>> +endif
>> +
>> +install-tests: all
>> +ifdef CORESIGHT
>> +ifeq ($(ARCH),arm64)
>> +	$(call QUIET_INSTALL, tests) \
>> +		$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(perfexec_instdir_SQ)/tests/shell/tools/$(BIN)'; \
>> +		$(INSTALL) $(BIN) '$(DESTDIR_SQ)$(perfexec_instdir_SQ)/tests/shell/tools/$(BIN)/$(BIN)'
>> +endif
>> +endif
>> +
>> +clean:
>> +	$(Q)$(RM) -f $(BIN)
>> +
>> +.PHONY: all clean install-tests
>> diff --git a/tools/perf/tests/shell/coresight/memcpy_thread/memcpy_thread.c b/tools/perf/tests/shell/coresight/memcpy_thread/memcpy_thread.c
>> new file mode 100644
>> index 000000000000..a7e169d1bf64
>> --- /dev/null
>> +++ b/tools/perf/tests/shell/coresight/memcpy_thread/memcpy_thread.c
>> @@ -0,0 +1,79 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +// Carsten Haitzler <carsten.haitzler@arm.com>, 2021
>> +#include <stdio.h>
>> +#include <stdlib.h>
>> +#include <unistd.h>
>> +#include <string.h>
>> +#include <pthread.h>
>> +
>> +struct args {
>> +	unsigned long loops;
>> +	unsigned long size;
>> +	pthread_t th;
>> +	void *ret;
>> +};
>> +
>> +static void *thrfn(void *arg)
>> +{
>> +	struct args *a = arg;
>> +	unsigned long i, len = a->loops;
>> +	unsigned char *src, *dst;
>> +
>> +	src = malloc(a->size * 1024);
>> +	dst = malloc(a->size * 1024);
>> +	if ((!src) || (!dst)) {
>> +		printf("ERR: Can't allocate memory\n");
>> +		exit(1);
>> +	}
>> +	for (i = 0; i < len; i++)
>> +		memcpy(dst, src, a->size * 1024);
>> +}
>> +
>> +static pthread_t new_thr(void *(*fn) (void *arg), void *arg)
>> +{
>> +	pthread_t t;
>> +	pthread_attr_t attr;
>> +
>> +	pthread_attr_init(&attr);
>> +	pthread_create(&t, &attr, fn, arg);
>> +	return t;
>> +}
>> +
>> +int main(int argc, char **argv)
>> +{
>> +	unsigned long i, len, size, thr;
>> +	pthread_t threads[256];
>> +	struct args args[256];
>> +	long long v;
>> +
>> +	if (argc < 4) {
>> +		printf("ERR: %s [copysize Kb] [numthreads] [numloops (hundreds)]\n", argv[0]);
>> +		exit(1);
>> +	}
>> +
>> +	v = atoll(argv[1]);
>> +	if ((v < 1) || (v > (1024 * 1024))) {
>> +		printf("ERR: max memory 1GB (1048576 KB)\n");
>> +		exit(1);
>> +	}
>> +	size = v;
>> +	thr = atol(argv[2]);
>> +	if ((thr < 1) || (thr > 256)) {
>> +		printf("ERR: threads 1-256\n");
>> +		exit(1);
>> +	}
>> +	v = atoll(argv[3]);
>> +	if ((v < 1) || (v > 40000000000ll)) {
>> +		printf("ERR: loops 1-40000000000 (hundreds)\n");
>> +		exit(1);
>> +	}
>> +	len = v * 100;
>> +	for (i = 0; i < thr; i++) {
>> +		args[i].loops = len;
>> +		args[i].size = size;
>> +		args[i].th = new_thr(thrfn, &(args[i]));
>> +	}
>> +	for (i = 0; i < thr; i++)
>> +		pthread_join(args[i].th, &(args[i].ret));
>> +	return 0;
>> +}
>> diff --git a/tools/perf/tests/shell/coresight/thread_loop/.gitignore b/tools/perf/tests/shell/coresight/thread_loop/.gitignore
>> new file mode 100644
>> index 000000000000..6d4c33eaa9e8
>> --- /dev/null
>> +++ b/tools/perf/tests/shell/coresight/thread_loop/.gitignore
>> @@ -0,0 +1 @@
>> +thread_loop
>> diff --git a/tools/perf/tests/shell/coresight/thread_loop/Makefile b/tools/perf/tests/shell/coresight/thread_loop/Makefile
>> new file mode 100644
>> index 000000000000..424df4e8b0e6
>> --- /dev/null
>> +++ b/tools/perf/tests/shell/coresight/thread_loop/Makefile
>> @@ -0,0 +1,29 @@
>> +# SPDX-License-Identifier: GPL-2.0
>> +# Carsten Haitzler <carsten.haitzler@arm.com>, 2021
>> +include ../Makefile.miniconfig
>> +
>> +BIN=thread_loop
>> +LIB=-pthread
>> +
>> +all: $(BIN)
>> +
>> +$(BIN): $(BIN).c
>> +ifdef CORESIGHT
>> +ifeq ($(ARCH),arm64)
>> +	$(Q)$(CC) $(BIN).c -o $(BIN) $(LIB)
>> +endif
>> +endif
>> +
>> +install-tests: all
>> +ifdef CORESIGHT
>> +ifeq ($(ARCH),arm64)
>> +	$(call QUIET_INSTALL, tests) \
>> +		$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(perfexec_instdir_SQ)/tests/shell/tools/$(BIN)'; \
>> +		$(INSTALL) $(BIN) '$(DESTDIR_SQ)$(perfexec_instdir_SQ)/tests/shell/tools/$(BIN)/$(BIN)'
>> +endif
>> +endif
>> +
>> +clean:
>> +	$(Q)$(RM) -f $(BIN)
>> +
>> +.PHONY: all clean install-tests
>> diff --git a/tools/perf/tests/shell/coresight/thread_loop/thread_loop.c b/tools/perf/tests/shell/coresight/thread_loop/thread_loop.c
>> new file mode 100644
>> index 000000000000..c0158fac7d0b
>> --- /dev/null
>> +++ b/tools/perf/tests/shell/coresight/thread_loop/thread_loop.c
>> @@ -0,0 +1,86 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +// Carsten Haitzler <carsten.haitzler@arm.com>, 2021
>> +
>> +// define this for gettid()
>> +#define _GNU_SOURCE
>> +
>> +#include <stdio.h>
>> +#include <stdlib.h>
>> +#include <unistd.h>
>> +#include <string.h>
>> +#include <pthread.h>
>> +#include <sys/syscall.h>
>> +#ifndef SYS_gettid
>> +// gettid is 178 on arm64
>> +# define SYS_gettid 178
>> +#endif
>> +#define gettid() syscall(SYS_gettid)
>> +
>> +struct args {
>> +	unsigned int loops;
>> +	pthread_t th;
>> +	void *ret;
>> +};
>> +
>> +static void *thrfn(void *arg)
>> +{
>> +	struct args *a = arg;
>> +	int i = 0, len = a->loops;
>> +
>> +	if (getenv("SHOW_TID")) {
>> +		unsigned long long tid = gettid();
>> +
>> +		printf("%llu\n", tid);
>> +	}
>> +	asm volatile(
>> +		"loop:\n"
>> +		"add %[i], %[i], #1\n"
>> +		"cmp %[i], %[len]\n"
>> +		"blt loop\n"
>> +		: /* out */
>> +		: /* in */ [i] "r" (i), [len] "r" (len)
>> +		: /* clobber */
>> +	);
>> +	return (void *)(long)i;
>> +}
>> +
>> +static pthread_t new_thr(void *(*fn) (void *arg), void *arg)
>> +{
>> +	pthread_t t;
>> +	pthread_attr_t attr;
>> +
>> +	pthread_attr_init(&attr);
>> +	pthread_create(&t, &attr, fn, arg);
>> +	return t;
>> +}
>> +
>> +int main(int argc, char **argv)
>> +{
>> +	unsigned int i, len, thr;
>> +	pthread_t threads[256];
>> +	struct args args[256];
>> +
>> +	if (argc < 3) {
>> +		printf("ERR: %s [numthreads] [numloops (millions)]\n", argv[0]);
>> +		exit(1);
>> +	}
>> +
>> +	thr = atoi(argv[1]);
>> +	if ((thr < 1) || (thr > 256)) {
>> +		printf("ERR: threads 1-256\n");
>> +		exit(1);
>> +	}
>> +	len = atoi(argv[2]);
>> +	if ((len < 1) || (len > 4000)) {
>> +		printf("ERR: max loops 4000 (millions)\n");
>> +		exit(1);
>> +	}
>> +	len *= 1000000;
>> +	for (i = 0; i < thr; i++) {
>> +		args[i].loops = len;
>> +		args[i].th = new_thr(thrfn, &(args[i]));
>> +	}
>> +	for (i = 0; i < thr; i++)
>> +		pthread_join(args[i].th, &(args[i].ret));
>> +	return 0;
>> +}
>> diff --git a/tools/perf/tests/shell/coresight/unroll_loop_thread/.gitignore b/tools/perf/tests/shell/coresight/unroll_loop_thread/.gitignore
>> new file mode 100644
>> index 000000000000..2cb4e996dbf3
>> --- /dev/null
>> +++ b/tools/perf/tests/shell/coresight/unroll_loop_thread/.gitignore
>> @@ -0,0 +1 @@
>> +unroll_loop_thread
>> diff --git a/tools/perf/tests/shell/coresight/unroll_loop_thread/Makefile b/tools/perf/tests/shell/coresight/unroll_loop_thread/Makefile
>> new file mode 100644
>> index 000000000000..45ab2be8be92
>> --- /dev/null
>> +++ b/tools/perf/tests/shell/coresight/unroll_loop_thread/Makefile
>> @@ -0,0 +1,29 @@
>> +# SPDX-License-Identifier: GPL-2.0
>> +# Carsten Haitzler <carsten.haitzler@arm.com>, 2021
>> +include ../Makefile.miniconfig
>> +
>> +BIN=unroll_loop_thread
>> +LIB=-pthread
>> +
>> +all: $(BIN)
>> +
>> +$(BIN): $(BIN).c
>> +ifdef CORESIGHT
>> +ifeq ($(ARCH),arm64)
>> +	$(Q)$(CC) $(BIN).c -o $(BIN) $(LIB)
>> +endif
>> +endif
>> +
>> +install-tests: all
>> +ifdef CORESIGHT
>> +ifeq ($(ARCH),arm64)
>> +	$(call QUIET_INSTALL, tests) \
>> +		$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(perfexec_instdir_SQ)/tests/shell/tools/$(BIN)'; \
>> +		$(INSTALL) $(BIN) '$(DESTDIR_SQ)$(perfexec_instdir_SQ)/tests/shell/tools/$(BIN)/$(BIN)'
>> +endif
>> +endif
>> +
>> +clean:
>> +	$(Q)$(RM) -f $(BIN)
>> +
>> +.PHONY: all clean install-tests
>> diff --git a/tools/perf/tests/shell/coresight/unroll_loop_thread/unroll_loop_thread.c b/tools/perf/tests/shell/coresight/unroll_loop_thread/unroll_loop_thread.c
>> new file mode 100644
>> index 000000000000..cb9d22c7dfb9
>> --- /dev/null
>> +++ b/tools/perf/tests/shell/coresight/unroll_loop_thread/unroll_loop_thread.c
>> @@ -0,0 +1,74 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +// Carsten Haitzler <carsten.haitzler@arm.com>, 2021
>> +#include <stdio.h>
>> +#include <stdlib.h>
>> +#include <unistd.h>
>> +#include <string.h>
>> +#include <pthread.h>
>> +
>> +struct args {
>> +	pthread_t th;
>> +	unsigned int in, out;
>> +	void *ret;
>> +};
>> +
>> +static void *thrfn(void *arg)
>> +{
>> +	struct args *a = arg;
>> +	unsigned int i, in = a->in;
>> +
>> +	for (i = 0; i < 10000; i++) {
>> +		asm volatile (
>> +// force an unroll of thia add instruction so we can test long runs of code
>> +#define SNIP1 "add %[in], %[in], #1\n"
>> +// 10
>> +#define SNIP2 SNIP1 SNIP1 SNIP1 SNIP1 SNIP1 SNIP1 SNIP1 SNIP1 SNIP1 SNIP1
>> +// 100
>> +#define SNIP3 SNIP2 SNIP2 SNIP2 SNIP2 SNIP2 SNIP2 SNIP2 SNIP2 SNIP2 SNIP2
>> +// 1000
>> +#define SNIP4 SNIP3 SNIP3 SNIP3 SNIP3 SNIP3 SNIP3 SNIP3 SNIP3 SNIP3 SNIP3
>> +// 10000
>> +#define SNIP5 SNIP4 SNIP4 SNIP4 SNIP4 SNIP4 SNIP4 SNIP4 SNIP4 SNIP4 SNIP4
>> +// 100000
>> +			SNIP5 SNIP5 SNIP5 SNIP5 SNIP5 SNIP5 SNIP5 SNIP5 SNIP5 SNIP5
>> +			: /* out */
>> +			: /* in */ [in] "r" (in)
>> +			: /* clobber */
>> +		);
>> +	}
>> +}
>> +
>> +static pthread_t new_thr(void *(*fn) (void *arg), void *arg)
>> +{
>> +	pthread_t t;
>> +	pthread_attr_t attr;
>> +
>> +	pthread_attr_init(&attr);
>> +	pthread_create(&t, &attr, fn, arg);
>> +	return t;
>> +}
>> +
>> +int main(int argc, char **argv)
>> +{
>> +	unsigned int i, thr;
>> +	pthread_t threads[256];
>> +	struct args args[256];
>> +
>> +	if (argc < 2) {
>> +		printf("ERR: %s [numthreads]\n", argv[0]);
>> +		exit(1);
>> +	}
>> +
>> +	thr = atoi(argv[1]);
>> +	if ((thr > 256) || (thr < 1)) {
>> +		printf("ERR: threads 1-256\n");
>> +		exit(1);
>> +	}
>> +	for (i = 0; i < thr; i++) {
>> +		args[i].in = rand();
>> +		args[i].th = new_thr(thrfn, &(args[i]));
>> +	}
>> +	for (i = 0; i < thr; i++)
>> +		pthread_join(args[i].th, &(args[i].ret));
>> +	return 0;
>> +}
>> diff --git a/tools/perf/tests/shell/coresight_asm_pure_loop.sh b/tools/perf/tests/shell/coresight_asm_pure_loop.sh
>> new file mode 100755
>> index 000000000000..3f0dbefcad50
>> --- /dev/null
>> +++ b/tools/perf/tests/shell/coresight_asm_pure_loop.sh
>> @@ -0,0 +1,18 @@
>> +#!/bin/sh -e
>> +# Coresight / ASM Pure Loop
>> +
>> +# SPDX-License-Identifier: GPL-2.0
>> +# Carsten Haitzler <carsten.haitzler@arm.com>, 2021
>> +
>> +TEST="asm_pure_loop"
>> +. $(dirname $0)/lib/coresight.sh
>> +ARGS=""
>> +DATV="out"
>> +DATA="$DATD/perf-$TEST-$DATV.data"
>> +
>> +perf record $PERFRECOPT -o "$DATA" "$BIN" $ARGS
>> +
>> +perf_dump_aux_verify "$DATA" 10 10 10
>> +
>> +err=$?
>> +exit $err
>> diff --git a/tools/perf/tests/shell/coresight_memcpy_thread_16k_10.sh b/tools/perf/tests/shell/coresight_memcpy_thread_16k_10.sh
>> new file mode 100755
>> index 000000000000..8972af835016
>> --- /dev/null
>> +++ b/tools/perf/tests/shell/coresight_memcpy_thread_16k_10.sh
>> @@ -0,0 +1,18 @@
>> +#!/bin/sh -e
>> +# Coresight / Memcpy 16k 10 Threads
>> +
>> +# SPDX-License-Identifier: GPL-2.0
>> +# Carsten Haitzler <carsten.haitzler@arm.com>, 2021
>> +
>> +TEST="memcpy_thread"
>> +. $(dirname $0)/lib/coresight.sh
>> +ARGS="16 10 1"
>> +DATV="16k_10"
>> +DATA="$DATD/perf-$TEST-$DATV.data"
>> +
>> +perf record $PERFRECOPT -o "$DATA" "$BIN" $ARGS
>> +
>> +perf_dump_aux_verify "$DATA" 10 10 10
>> +
>> +err=$?
>> +exit $err
>> diff --git a/tools/perf/tests/shell/coresight_thread_loop_check_tid_10.sh b/tools/perf/tests/shell/coresight_thread_loop_check_tid_10.sh
>> new file mode 100755
>> index 000000000000..5b468901f89b
>> --- /dev/null
>> +++ b/tools/perf/tests/shell/coresight_thread_loop_check_tid_10.sh
>> @@ -0,0 +1,19 @@
>> +#!/bin/sh -e
>> +# Coresight / Thread Loop 10 Threads - Check TID
>> +
>> +# SPDX-License-Identifier: GPL-2.0
>> +# Carsten Haitzler <carsten.haitzler@arm.com>, 2021
>> +
>> +TEST="thread_loop"
>> +. $(dirname $0)/lib/coresight.sh
>> +ARGS="10 1"
>> +DATV="check-tid-10th"
>> +DATA="$DATD/perf-$TEST-$DATV.data"
>> +STDO="$DATD/perf-$TEST-$DATV.stdout"
>> +
>> +SHOW_TID=1 perf record -s $PERFRECOPT -o "$DATA" "$BIN" $ARGS > $STDO
>> +
>> +perf_dump_aux_tid_verify "$DATA" "$STDO"
>> +
>> +err=$?
>> +exit $err
>> diff --git a/tools/perf/tests/shell/coresight_thread_loop_check_tid_2.sh b/tools/perf/tests/shell/coresight_thread_loop_check_tid_2.sh
>> new file mode 100755
>> index 000000000000..f8b7abd3aa03
>> --- /dev/null
>> +++ b/tools/perf/tests/shell/coresight_thread_loop_check_tid_2.sh
>> @@ -0,0 +1,19 @@
>> +#!/bin/sh -e
>> +# Coresight / Thread Loop 2 Threads - Check TID
>> +
>> +# SPDX-License-Identifier: GPL-2.0
>> +# Carsten Haitzler <carsten.haitzler@arm.com>, 2021
>> +
>> +TEST="thread_loop"
>> +. $(dirname $0)/lib/coresight.sh
>> +ARGS="2 20"
>> +DATV="check-tid-2th"
>> +DATA="$DATD/perf-$TEST-$DATV.data"
>> +STDO="$DATD/perf-$TEST-$DATV.stdout"
>> +
>> +SHOW_TID=1 perf record -s $PERFRECOPT -o "$DATA" "$BIN" $ARGS > $STDO
>> +
>> +perf_dump_aux_tid_verify "$DATA" "$STDO"
>> +
>> +err=$?
>> +exit $err
>> diff --git a/tools/perf/tests/shell/coresight_unroll_loop_thread_10.sh b/tools/perf/tests/shell/coresight_unroll_loop_thread_10.sh
>> new file mode 100755
>> index 000000000000..c985dfb025c2
>> --- /dev/null
>> +++ b/tools/perf/tests/shell/coresight_unroll_loop_thread_10.sh
>> @@ -0,0 +1,18 @@
>> +#!/bin/sh -e
>> +# Coresight / Unroll Loop Thread 10
>> +
>> +# SPDX-License-Identifier: GPL-2.0
>> +# Carsten Haitzler <carsten.haitzler@arm.com>, 2021
>> +
>> +TEST="unroll_loop_thread"
>> +. $(dirname $0)/lib/coresight.sh
>> +ARGS="10"
>> +DATV="10"
>> +DATA="$DATD/perf-$TEST-$DATV.data"
>> +
>> +perf record $PERFRECOPT -o "$DATA" "$BIN" $ARGS
>> +
>> +perf_dump_aux_verify "$DATA" 10 10 10
>> +
>> +err=$?
>> +exit $err
>> diff --git a/tools/perf/tests/shell/lib/coresight.sh b/tools/perf/tests/shell/lib/coresight.sh
>> new file mode 100644
>> index 000000000000..6a611b073f02
>> --- /dev/null
>> +++ b/tools/perf/tests/shell/lib/coresight.sh
>> @@ -0,0 +1,130 @@
>> +# SPDX-License-Identifier: GPL-2.0
>> +# Carsten Haitzler <carsten.haitzler@arm.com>, 2021
>> +
>> +# This is sourced from a driver script so no need for #!/bin... etc. at the
>> +# top - the assumption below is that it runs as part of sourcing after the
>> +# test sets up some basic env vars to say what it is.
>> +
>> +# perf record options for the perf tests to use
>> +PERFRECMEM="-m ,128M"
>> +PERFRECOPT="$PERFRECMEM -e cs_etm//u"
>> +
>> +# These tests need to be run as root or coresight won't allow large buffers
>> +# and will not collect proper data
>> +UID=`id -u`
>> +if test "$UID" -ne 0; then
>> +	echo "Not running as root... skip"
>> +	exit 2
>> +fi
>> +
>> +TOOLS=$(dirname $0)
>> +DIR="$TOOLS/coresight/$TEST"
>> +BIN="$DIR/$TEST"
>> +# If the test tool/binary does not exist and is executable then skip the test
>> +if ! test -x "$BIN"; then exit 2; fi
>> +DATD="."
>> +# If the data dir env is set then make the data dir use that instead of ./
>> +if test -n "$PERF_TEST_CORESIGHT_DATADIR"; then
>> +	DATD="$PERF_TEST_CORESIGHT_DATADIR";
>> +fi
>> +# If the stat dir env is set then make the data dir use that instead of ./
>> +STATD="."
>> +if test -n "$PERF_TEST_CORESIGHT_STATDIR"; then
>> +	STATD="$PERF_TEST_CORESIGHT_STATDIR";
>> +fi
>> +
>> +# Called if the test fails - error code 2
>> +err() {
>> +	echo "$1"
>> +	exit 1
>> +}
>> +
>> +# Check that some statistics from our perf
>> +check_val_min() {
>> +	STATF="$4"
>> +	if test "$2" -lt "$3"; then
>> +		echo ", FAILED" >> "$STATF"
>> +		err "Sanity check number of $1 is too low ($2 < $3)"
>> +	fi
>> +}
>> +
>> +perf_dump_aux_verify() {
>> +	# Some basic checking that the AUX chunk contains some sensible data
>> +	# to see that we are recording something and at least a minimum
>> +	# amount of it. We should almost always see F3 atoms in just about
>> +	# anything but certainly we will see some trace info and async atom
>> +	# chunks.
>> +	DUMP="$DATD/perf-tmp-aux-dump.txt"
>> +	perf report --stdio --dump -i "$1" | \
>> +		grep -o -e I_ATOM_F3 -e I_ASYNC -e I_TRACE_INFO > "$DUMP"
>> +	# Simply count how many of these atoms we find to see that we are
>> +	# producing a reasonable amount of data - exact checks are not sane
>> +	# as this is a lossy  process where we may lose some blocks and the
>> +	# compiler may produce different code depending on the compiler and
>> +	# optimization options, so this is rough  just to see if we're
>> +	# either missing almost all the data or all of it
>> +	ATOM_F3_NUM=`grep I_ATOM_F3 "$DUMP" | wc -l`
>> +	ATOM_ASYNC_NUM=`grep I_ASYNC "$DUMP" | wc -l`
>> +	ATOM_TRACE_INFO_NUM=`grep I_TRACE_INFO "$DUMP" | wc -l`
>> +	rm -f "$DUMP"
>> +
>> +	# Arguments provide minimums for a pass
>> +	CHECK_F3_MIN="$2"
>> +	CHECK_ASYNC_MIN="$3"
>> +	CHECK_TRACE_INFO_MIN="$4"
>> +
>> +	# Write out statistics, so over time you can track results to see if
>> +	# there is a pattern - for example we have less "noisy" results that
>> +	# produce more consistent amounts of data each run, to see if over
>> +	# time any techinques to  minimize data loss are having an effect or
>> +	# not
>> +	STATF="$STATD/stats-$TEST-$DATV.csv"
>> +	if ! test -f "$STATF"; then
>> +		echo "ATOM F3 Count, Minimum, ATOM ASYNC Count, Minimum, TRACE INFO Count, Minimum" > "$STATF"
>> +	fi
>> +	echo -n "$ATOM_F3_NUM, $CHECK_F3_MIN, $ATOM_ASYNC_NUM, $CHECK_ASYNC_MIN, $ATOM_TRACE_INFO_NUM, $CHECK_TRACE_INFO_MIN" >> "$STATF"
>> +
>> +	# Actually check to see if we passed or failed.
>> +	check_val_min "ATOM_F3" "$ATOM_F3_NUM" "$CHECK_F3_MIN" "$STATF"
>> +	check_val_min "ASYNC" "$ATOM_ASYNC_NUM" "$CHECK_ASYNC_MIN" "$STATF"
>> +	check_val_min "TRACE_INFO" "$ATOM_TRACE_INFO_NUM" "$CHECK_TRACE_INFO_MIN" "$STATF"
>> +	echo ", Ok" >> "$STATF"
>> +}
>> +
>> +perf_dump_aux_tid_verify() {
>> +	# Specifically crafted test will produce a list of Tread ID's to
>> +	# stdout that need to be checked to  see that they have had trace
>> +	# info collected in AUX blocks in the perf data. This will go
>> +	# through all the TID's that are listed as CID=0xabcdef and see
>> +	# that all the Thread IDs the test tool reports are  in the perf
>> +	# data AUX chunks
>> +
>> +	# The TID test tools will print a TID per stdout line that are being
>> +	# tested
>> +	TIDS=`cat "$2"`
>> +	# Scan the perf report to find the TIDs that are actually CID in hex
>> +	# and build a list of the ones found
>> +	FOUND_TIDS=`perf report --stdio --dump -i "$1" | \
>> +			grep -o "CID=0x[0-9a-z]\+" | sed 's/CID=//g' | \
>> +			uniq | sort | uniq`
>> +
>> +	# Iterate over the list of TIDs that the test says it has and find
>> +	# them in the TIDs found in the perf report
>> +	MISSING=""
>> +	for TID2 in $TIDS; do
>> +		FOUND=""
>> +		for TIDHEX in $FOUND_TIDS; do
>> +			TID=`printf "%i" $TIDHEX`
>> +			if test "$TID" -eq "$TID2"; then
>> +				FOUND="y"
>> +				break
>> +			fi
>> +		done
>> +		if test -z "$FOUND"; then
>> +			MISSING="$MISSING $TID"
>> +		fi
>> +	done
>> +	if test -n "$MISSING"; then
>> +		err "Thread IDs $MISSING not found in perf AUX data"
>> +	fi
>> +}
>> -- 
>> 2.32.0
>>
