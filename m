Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97A27484410
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 16:01:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234565AbiADPBy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 10:01:54 -0500
Received: from foss.arm.com ([217.140.110.172]:60418 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231872AbiADPBx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 10:01:53 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A926713A1;
        Tue,  4 Jan 2022 07:01:52 -0800 (PST)
Received: from [192.168.99.12] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0DAF43F774;
        Tue,  4 Jan 2022 07:01:50 -0800 (PST)
Message-ID: <6fb8371e-6c55-14eb-2488-6d34db6085d8@foss.arm.com>
Date:   Tue, 4 Jan 2022 15:01:50 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH 05/12] perf test: Add coresight test to check all threads
 get some data logged
Content-Language: en-US
To:     Leo Yan <leo.yan@linaro.org>
Cc:     linux-kernel@vger.kernel.org, coresight@lists.linaro.org,
        suzuki.poulose@arm.com, mathieu.poirier@linaro.org,
        mike.leach@linaro.org, inux-perf-users@vger.kernel.org,
        acme@kernel.org
References: <20211215160403.69264-1-carsten.haitzler@foss.arm.com>
 <20211215160403.69264-5-carsten.haitzler@foss.arm.com>
 <20220103070700.GA2660949@leoy-ThinkPad-X240s>
From:   Carsten Haitzler <carsten.haitzler@foss.arm.com>
Organization: Arm Ltd.
In-Reply-To: <20220103070700.GA2660949@leoy-ThinkPad-X240s>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/3/22 07:07, Leo Yan wrote:
> On Wed, Dec 15, 2021 at 04:03:56PM +0000, carsten.haitzler@foss.arm.com wrote:
>> From: Carsten Haitzler <carsten.haitzler@arm.com>
>>
>> This adds a test and test scripts to check that all threads in the
>> target binary end up logging some kind of coresight aux data and that
>> they are not missing.
>>
>> Signed-off-by: Carsten Haitzler <carsten.haitzler@arm.com>
>> ---
>>   .../coresight_thread_loop_check_tid_10.sh     | 19 ++++
>>   .../coresight_thread_loop_check_tid_2.sh      | 19 ++++
>>   .../coresight_thread_loop_check_tid_250.sh    | 19 ++++
>>   .../perf/tests/shell/tools/coresight/Makefile |  3 +-
>>   .../tools/coresight/thread_loop/Makefile      | 29 +++++++
>>   .../tools/coresight/thread_loop/thread_loop.c | 86 +++++++++++++++++++
>>   6 files changed, 174 insertions(+), 1 deletion(-)
>>   create mode 100755 tools/perf/tests/shell/coresight_thread_loop_check_tid_10.sh
>>   create mode 100755 tools/perf/tests/shell/coresight_thread_loop_check_tid_2.sh
>>   create mode 100755 tools/perf/tests/shell/coresight_thread_loop_check_tid_250.sh
>>   create mode 100644 tools/perf/tests/shell/tools/coresight/thread_loop/Makefile
>>   create mode 100644 tools/perf/tests/shell/tools/coresight/thread_loop/thread_loop.c
>>
>> diff --git a/tools/perf/tests/shell/coresight_thread_loop_check_tid_10.sh b/tools/perf/tests/shell/coresight_thread_loop_check_tid_10.sh
>> new file mode 100755
>> index 000000000000..283ad9facdee
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
>> +ARGS="10 2000"
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
>> index 000000000000..ce8ba534bba2
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
>> +ARGS="2 4000"
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
>> diff --git a/tools/perf/tests/shell/coresight_thread_loop_check_tid_250.sh b/tools/perf/tests/shell/coresight_thread_loop_check_tid_250.sh
>> new file mode 100755
>> index 000000000000..cb14581c1e68
>> --- /dev/null
>> +++ b/tools/perf/tests/shell/coresight_thread_loop_check_tid_250.sh
>> @@ -0,0 +1,19 @@
>> +#!/bin/sh -e
>> +# Coresight / Thread Loop 250 Threads - Check TID
>> +
>> +# SPDX-License-Identifier: GPL-2.0
>> +# Carsten Haitzler <carsten.haitzler@arm.com>, 2021
>> +
>> +TEST="thread_loop"
>> +. $(dirname $0)/lib/coresight.sh
>> +ARGS="250 100"
>> +DATV="check-tid-250th"
>> +DATA="$DATD/perf-$TEST-$DATV.data"
>> +STDO="$DATD/perf-$TEST-$DATV.stdout"
>> +
>> +SHOW_TID=1 perf record -s $PERFRECOPT -o "$DATA" "$BIN" $ARGS > $STDO
>> +
>> +perf_dump_aux_tid_verify "$DATA" "$STDO"
>> +
>> +err=$?
>> +exit $err
> 
>  From this case I start to understand why the lib/coresight.sh sets
> AUX buffer as 250MB, setting a large buffer size can capture trace
> data for all threads, especially for big amount of threads.
> 
> Seems to me, if we test on server, this case can run for short time, but
> I think (sorry if I am wrong) it might take much longer time to test on
> the embedded system, which might cause testing failure by two factors:
> 
> - The resource (e.g. the required big memory size) is pressure for
>    embedded system;
> - The execution time (IIRC, every test case should be finished within
>    5 minutes).
> 
> Do you think does it make sense for us to only use 32 threads or 64
> threads for the testing and it can give us a good testing coverage,
> and we don't need to maintain multiple cases for 2/10/250 threads?

I actually tested on a dragonboard 845c dev board (with the RB3 - only 
4gb RAM) and took this as a baseline for "embedded board testing" as 
it's probably about normal for a modern dev board. I made sure my tests 
din't run out of RAM on that and would complete in a "not forever" 
timeframe. I can probably reduce the number of cases, but I did go for 
good coverage for stress-testing. I was doing 250 threads for the many 
many many core cases and want to ensure I keep all cores busy (or a very 
large number of them) to stress things out. Dev boards commonly have 8 
cores these days, but servers are pushing 256 cores already (or 64 x 4 
way smt and now are beginning to see 128 real cores etc.). So wanted to 
make sure I'm pushing both ends of the spectrum.

> Thanks,
> Leo
> 
>> diff --git a/tools/perf/tests/shell/tools/coresight/Makefile b/tools/perf/tests/shell/tools/coresight/Makefile
>> index 723006ea827c..1edab729db76 100644
>> --- a/tools/perf/tests/shell/tools/coresight/Makefile
>> +++ b/tools/perf/tests/shell/tools/coresight/Makefile
>> @@ -5,7 +5,8 @@ include ../../../../../../tools/scripts/Makefile.arch
>>   include ../../../../../../tools/scripts/utilities.mak
>>   
>>   SUBDIRS = \
>> -	asm_pure_loop
>> +	asm_pure_loop \
>> +	thread_loop
>>   
>>   all: $(SUBDIRS)
>>   $(SUBDIRS):
>> diff --git a/tools/perf/tests/shell/tools/coresight/thread_loop/Makefile b/tools/perf/tests/shell/tools/coresight/thread_loop/Makefile
>> new file mode 100644
>> index 000000000000..424df4e8b0e6
>> --- /dev/null
>> +++ b/tools/perf/tests/shell/tools/coresight/thread_loop/Makefile
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
>> diff --git a/tools/perf/tests/shell/tools/coresight/thread_loop/thread_loop.c b/tools/perf/tests/shell/tools/coresight/thread_loop/thread_loop.c
>> new file mode 100644
>> index 000000000000..c0158fac7d0b
>> --- /dev/null
>> +++ b/tools/perf/tests/shell/tools/coresight/thread_loop/thread_loop.c
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
>> -- 
>> 2.32.0
>>
