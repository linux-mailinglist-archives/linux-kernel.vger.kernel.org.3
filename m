Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5C505713BA
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 09:59:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232547AbiGLH7t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 03:59:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232536AbiGLH7b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 03:59:31 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2B11D10C4;
        Tue, 12 Jul 2022 00:59:24 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5B4BA1516;
        Tue, 12 Jul 2022 00:59:24 -0700 (PDT)
Received: from [10.1.29.134] (e127744.cambridge.arm.com [10.1.29.134])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4BC693F73D;
        Tue, 12 Jul 2022 00:59:22 -0700 (PDT)
Subject: Re: [PATCH v2 1/1] perf test: Add test for branch stack sampling
To:     Jiri Olsa <olsajiri@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        acme@kernel.org, irogers@google.com,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>
References: <20220705150511.473919-1-german.gomez@arm.com>
 <20220705150511.473919-2-german.gomez@arm.com> <YsyOfx9D3w5Rfiz8@krava>
From:   German Gomez <german.gomez@arm.com>
Message-ID: <d4928180-3ef0-4f6a-82c4-6d2592169587@arm.com>
Date:   Tue, 12 Jul 2022 08:59:11 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <YsyOfx9D3w5Rfiz8@krava>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 11/07/2022 21:56, Jiri Olsa wrote:
> On Tue, Jul 05, 2022 at 04:05:11PM +0100, German Gomez wrote:
>> Add a self test for branch stack sampling, to check that we get the
>> expected branch types, and filters behave as expected.
>>
>> Suggested-by: Anshuman Khandual <anshuman.khandual@arm.com>
>> Signed-off-by: German Gomez <german.gomez@arm.com>
> Tested-by: Jiri Olsa <jolsa@kernel.org>

Thanks a lot, Jiri!

>
> thanks,
> jirka
>
>> ---
>>  tools/perf/tests/shell/test_brstack.sh | 114 +++++++++++++++++++++++++
>>  1 file changed, 114 insertions(+)
>>  create mode 100755 tools/perf/tests/shell/test_brstack.sh
>>
>> diff --git a/tools/perf/tests/shell/test_brstack.sh b/tools/perf/tests/shell/test_brstack.sh
>> new file mode 100755
>> index 000000000..5f6f40a77
>> --- /dev/null
>> +++ b/tools/perf/tests/shell/test_brstack.sh
>> @@ -0,0 +1,114 @@
>> +#!/bin/sh
>> +# Check branch stack sampling
>> +
>> +# SPDX-License-Identifier: GPL-2.0
>> +# German Gomez <german.gomez@arm.com>, 2022
>> +
>> +# we need a C compiler to build the test programs
>> +# so bail if none is found
>> +if ! [ -x "$(command -v cc)" ]; then
>> +	echo "failed: no compiler, install gcc"
>> +	exit 2
>> +fi
>> +
>> +# skip the test if the hardware doesn't support branch stack sampling
>> +perf record -b -o- -e dummy -B true > /dev/null 2>&1 || exit 2
>> +
>> +TMPDIR=$(mktemp -d /tmp/__perf_test.program.XXXXX)
>> +
>> +cleanup() {
>> +	rm -rf $TMPDIR
>> +}
>> +
>> +trap cleanup exit term int
>> +
>> +gen_test_program() {
>> +	# generate test program
>> +	cat << EOF > $1
>> +#define BENCH_RUNS 999999
>> +int cnt;
>> +void bar(void) {
>> +}			/* return */
>> +void foo(void) {
>> +	bar();		/* call */
>> +}			/* return */
>> +void bench(void) {
>> +  void (*foo_ind)(void) = foo;
>> +  if ((cnt++) % 3)	/* branch (cond) */
>> +    foo();		/* call */
>> +  bar();		/* call */
>> +  foo_ind();		/* call (ind) */
>> +}
>> +int main(void)
>> +{
>> +  int cnt = 0;
>> +  while (1) {
>> +    if ((cnt++) > BENCH_RUNS)
>> +      break;
>> +    bench();		/* call */
>> +  }			/* branch (uncond) */
>> +  return 0;
>> +}
>> +EOF
>> +}
>> +
>> +test_user_branches() {
>> +	echo "Testing user branch stack sampling"
>> +
>> +	gen_test_program "$TEMPDIR/program.c"
>> +	cc -fno-inline -g "$TEMPDIR/program.c" -o $TMPDIR/a.out
>> +
>> +	perf record -o $TMPDIR/perf.data --branch-filter any,save_type,u -- $TMPDIR/a.out > /dev/null 2>&1
>> +	perf script -i $TMPDIR/perf.data --fields brstacksym | xargs -n1 > $TMPDIR/perf.script
>> +
>> +	# example of branch entries:
>> +	# 	foo+0x14/bar+0x40/P/-/-/0/CALL
>> +
>> +	set -x
>> +	egrep -m1 "^bench\+[^ ]*/foo\+[^ ]*/IND_CALL$"	$TMPDIR/perf.script
>> +	egrep -m1 "^foo\+[^ ]*/bar\+[^ ]*/CALL$"	$TMPDIR/perf.script
>> +	egrep -m1 "^bench\+[^ ]*/foo\+[^ ]*/CALL$"	$TMPDIR/perf.script
>> +	egrep -m1 "^bench\+[^ ]*/bar\+[^ ]*/CALL$"	$TMPDIR/perf.script
>> +	egrep -m1 "^bar\+[^ ]*/foo\+[^ ]*/RET$"		$TMPDIR/perf.script
>> +	egrep -m1 "^foo\+[^ ]*/bench\+[^ ]*/RET$"	$TMPDIR/perf.script
>> +	egrep -m1 "^bench\+[^ ]*/bench\+[^ ]*/COND$"	$TMPDIR/perf.script
>> +	egrep -m1 "^main\+[^ ]*/main\+[^ ]*/UNCOND$"	$TMPDIR/perf.script
>> +	set +x
>> +
>> +	# some branch types are still not being tested:
>> +	# IND COND_CALL COND_RET SYSCALL SYSRET IRQ SERROR NO_TX
>> +}
>> +
>> +# first argument <arg0> is the argument passed to "--branch-stack <arg0>,save_type,u"
>> +# second argument are the expected branch types for the given filter
>> +test_filter() {
>> +	local filter=$1
>> +	local expect=$2
>> +
>> +	echo "Testing branch stack filtering permutation ($filter,$expect)"
>> +
>> +	gen_test_program "$TEMPDIR/program.c"
>> +	cc -fno-inline -g "$TEMPDIR/program.c" -o $TMPDIR/a.out
>> +
>> +	perf record -o $TMPDIR/perf.data --branch-filter $filter,save_type,u -- $TMPDIR/a.out > /dev/null 2>&1
>> +	perf script -i $TMPDIR/perf.data --fields brstack | xargs -n1 > $TMPDIR/perf.script
>> +
>> +	# fail if we find any branch type that doesn't match any of the expected ones
>> +	# also consider UNKNOWN branch types (-)
>> +	if egrep -vm1 "^[^ ]*/($expect|-|( *))$" $TMPDIR/perf.script; then
>> +		return 1
>> +	fi
>> +}
>> +
>> +set -e
>> +
>> +test_user_branches
>> +
>> +test_filter "any_call"	"CALL|IND_CALL|COND_CALL|SYSCALL|IRQ"
>> +test_filter "call"	"CALL|SYSCALL"
>> +test_filter "cond"	"COND"
>> +test_filter "any_ret"	"RET|COND_RET|SYSRET|ERET"
>> +
>> +test_filter "call,cond"		"CALL|SYSCALL|COND"
>> +test_filter "any_call,cond"		"CALL|IND_CALL|COND_CALL|IRQ|SYSCALL|COND"
>> +test_filter "cond,any_call,any_ret"	"COND|CALL|IND_CALL|COND_CALL|SYSCALL|IRQ|RET|COND_RET|SYSRET|ERET"
>> -- 
>> 2.25.1
>>
