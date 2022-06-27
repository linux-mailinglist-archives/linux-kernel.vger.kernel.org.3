Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E96455CBCB
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:00:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238570AbiF0Qpu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 12:45:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234113AbiF0Qps (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 12:45:48 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3302CDFCD;
        Mon, 27 Jun 2022 09:45:47 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2FB0B1758;
        Mon, 27 Jun 2022 09:45:47 -0700 (PDT)
Received: from [10.1.31.127] (e127744.cambridge.arm.com [10.1.31.127])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 35AE73F66F;
        Mon, 27 Jun 2022 09:45:45 -0700 (PDT)
Subject: Re: [PATCH] perf test: Add test for branch stack sampling
To:     Ian Rogers <irogers@google.com>
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        acme@kernel.org, Anshuman Khandual <anshuman.khandual@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>
References: <20220615130901.1151397-1-german.gomez@arm.com>
 <20220615130901.1151397-2-german.gomez@arm.com>
 <CAP-5=fU2duRRY3f0PKuM_a4_Nwi3zy576ajKMVp1cs_qfcr8kw@mail.gmail.com>
From:   German Gomez <german.gomez@arm.com>
Message-ID: <e40b8e64-3028-37e0-3b56-82947b09ece3@arm.com>
Date:   Mon, 27 Jun 2022 17:45:29 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <CAP-5=fU2duRRY3f0PKuM_a4_Nwi3zy576ajKMVp1cs_qfcr8kw@mail.gmail.com>
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


On 27/06/2022 17:38, Ian Rogers wrote:
> On Wed, Jun 15, 2022 at 6:09 AM German Gomez <german.gomez@arm.com> wrote:
>> Add a self test for branch stack sampling, to check that we get the
>> expected branch types, and filters behave as expected.
>>
>> Suggested-by: Anshuman Khandual <anshuman.khandual@arm.com>
>> Signed-off-by: German Gomez <german.gomez@arm.com>
> Love tests, thanks! There are already shell tests that compile C code
> but they do it by having the C code within the shell test, for
> example:
> https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git/tree/tools/perf/tests/shell/pipe_test.sh?h=perf/core#n14
> Having it this way I thinks means the tests can run properly when
> installed, as we don't install non-sh files:
> https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git/tree/tools/perf/Makefile.perf?h=perf/core#n1016

Ah! thanks for pointing this out, Ian. I've embedded C code within shell tests before, but I wasn't aware of the install issue.

We'll take care of this, thanks for the review!

>
> Thanks,
> Ian
>
>> ---
>>  tools/perf/tests/shell/lib/brstack/main.h | 16 +++++
>>  tools/perf/tests/shell/lib/brstack/test.c | 24 +++++++
>>  tools/perf/tests/shell/test_brstack.sh    | 86 +++++++++++++++++++++++
>>  3 files changed, 126 insertions(+)
>>  create mode 100644 tools/perf/tests/shell/lib/brstack/main.h
>>  create mode 100644 tools/perf/tests/shell/lib/brstack/test.c
>>  create mode 100755 tools/perf/tests/shell/test_brstack.sh
>>
>> diff --git a/tools/perf/tests/shell/lib/brstack/main.h b/tools/perf/tests/shell/lib/brstack/main.h
>> new file mode 100644
>> index 000000000..94d2665ec
>> --- /dev/null
>> +++ b/tools/perf/tests/shell/lib/brstack/main.h
>> @@ -0,0 +1,16 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +#define BENCH_RUNS 99999
>> +
>> +void bench(void);
>> +
>> +int main(void)
>> +{
>> +       int cnt = 0;
>> +
>> +       while (1) {
>> +               if ((cnt++) > BENCH_RUNS)
>> +                       break;
>> +               bench();                /* call */
>> +       }                               /* branch (uncond) */
>> +       return 0;
>> +}
>> diff --git a/tools/perf/tests/shell/lib/brstack/test.c b/tools/perf/tests/shell/lib/brstack/test.c
>> new file mode 100644
>> index 000000000..8a2308901
>> --- /dev/null
>> +++ b/tools/perf/tests/shell/lib/brstack/test.c
>> @@ -0,0 +1,24 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +#include "main.h"
>> +
>> +int cnt;
>> +
>> +void bar(void)
>> +{
>> +}                              /* return */
>> +
>> +void foo(void)
>> +{
>> +       bar();                  /* call */
>> +}                              /* return */
>> +
>> +void bench(void)
>> +{
>> +       void (*foo_ind)(void) = foo;
>> +
>> +       if ((cnt++) % 3)        /* branch (cond) */
>> +               foo();          /* call */
>> +
>> +       bar();                  /* call */
>> +       foo_ind();              /* call (ind) */
>> +}
>> diff --git a/tools/perf/tests/shell/test_brstack.sh b/tools/perf/tests/shell/test_brstack.sh
>> new file mode 100755
>> index 000000000..2b1a1b20a
>> --- /dev/null
>> +++ b/tools/perf/tests/shell/test_brstack.sh
>> @@ -0,0 +1,86 @@
>> +#!/bin/sh
>> +# Check branch stack sampling
>> +
>> +# SPDX-License-Identifier: GPL-2.0
>> +# German Gomez <german.gomez@arm.com>, 2022
>> +
>> +set -e
>> +
>> +# we need a C compiler to build the test programs
>> +# so bail if none is found
>> +if ! [ -x "$(command -v cc)" ]; then
>> +       echo "failed: no compiler, install gcc"
>> +       exit 2
>> +fi
>> +
>> +# skip the test if the hardware doesn't support branch stack sampling
>> +perf record -b -o- -- true > /dev/null || exit 2
>> +
>> +TMPDIR=$(mktemp -d /tmp/__perf_test.program.XXXXX)
>> +
>> +cleanup() {
>> +       rm -rf $TMPDIR
>> +}
>> +
>> +trap cleanup exit term int
>> +
>> +test_user_branches() {
>> +       echo
>> +       echo "Testing user branch stack sampling"
>> +       echo
>> +
>> +       cc -fno-inline -g "$(dirname $0)/lib/brstack/test.c" -o $TMPDIR/a.out
>> +
>> +       perf record -o $TMPDIR/perf.data -q --branch-filter any,save_type,u -- $TMPDIR/a.out
>> +       perf script -i $TMPDIR/perf.data --fields brstacksym | xargs -n1 > $TMPDIR/perf.script
>> +
>> +       # example of branch entries:
>> +       #       foo+0x14/bar+0x40/P/-/-/0/CALL
>> +
>> +       set -x
>> +       egrep -m1 "^bench\+[^ ]*/foo\+[^ ]*/IND_CALL$"  $TMPDIR/perf.script
>> +       egrep -m1 "^foo\+[^ ]*/bar\+[^ ]*/CALL$"        $TMPDIR/perf.script
>> +       egrep -m1 "^bench\+[^ ]*/foo\+[^ ]*/CALL$"      $TMPDIR/perf.script
>> +       egrep -m1 "^bench\+[^ ]*/bar\+[^ ]*/CALL$"      $TMPDIR/perf.script
>> +       egrep -m1 "^bar\+[^ ]*/foo\+[^ ]*/RET$"         $TMPDIR/perf.script
>> +       egrep -m1 "^foo\+[^ ]*/bench\+[^ ]*/RET$"       $TMPDIR/perf.script
>> +       egrep -m1 "^bench\+[^ ]*/bench\+[^ ]*/COND$"    $TMPDIR/perf.script
>> +       egrep -m1 "^main\+[^ ]*/main\+[^ ]*/UNCOND$"    $TMPDIR/perf.script
>> +       set +x
>> +
>> +       # some branch types are still not being tested:
>> +       # IND COND_CALL COND_RET SYSCALL SYSRET IRQ SERROR NO_TX
>> +}
>> +
>> +test_filter() {
>> +       local filter=$1
>> +       local expect=$2
>> +
>> +       echo
>> +       echo "Testing branch stack filtering permutation ($filter,$expect)"
>> +       echo
>> +
>> +       cc -fno-inline -g "$(dirname $0)/lib/brstack/test.c" -o $TMPDIR/a.out
>> +
>> +       perf record -o $TMPDIR/perf.data -q --branch-filter $filter,save_type,u -- $TMPDIR/a.out
>> +       perf script -i $TMPDIR/perf.data --fields brstack | xargs -n1 > $TMPDIR/perf.script
>> +
>> +       # fail if we find any branch type that doesn't match any of the expected ones
>> +       # also consider UNKNOWN branch types (-)
>> +       if egrep -vm1 "^[^ ]*/($expect|-|( *))$" $TMPDIR/perf.script; then
>> +               return 1
>> +       fi
>> +}
>> +
>> +test_user_branches
>> +
>> +# first argument <arg0> is the argument passed to "--branch-stack <arg0>,save_type,u"
>> +# second argument are the expected branch types for the given filter
>> +test_filter "any_call" "CALL|IND_CALL|COND_CALL|SYSCALL|IRQ|FAULT_DATA|FAULT_INST"
>> +test_filter "call"     "CALL|SYSCALL"
>> +test_filter "cond"     "COND"
>> +test_filter "any_ret"  "RET|COND_RET|SYSRET|ERET"
>> +
>> +test_filter "call,cond"                "CALL|SYSCALL|COND"
>> +test_filter "any_call,cond"            "CALL|IND_CALL|COND_CALL|IRQ|FAULT_DATA|FAULT_INST|SYSCALL|COND"
>> +test_filter "cond,any_call,any_ret"    "COND|CALL|IND_CALL|COND_CALL|SYSCALL|IRQ|FAULT_DATA|FAULT_INST|RET|COND_RET|SYSRET|ERET"
>> --
>> 2.25.1
>>
