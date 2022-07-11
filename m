Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93812570C3B
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 22:56:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230414AbiGKU4q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 16:56:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229629AbiGKU4o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 16:56:44 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD08C52475;
        Mon, 11 Jul 2022 13:56:42 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id b11so10835933eju.10;
        Mon, 11 Jul 2022 13:56:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=6U7gulSRknUpYYWEXTdNp6E6AUAABe5lU5EOH3DspwA=;
        b=EKqLrhsiTY858/1RPyqyO0iuRPCtvGwsWx8M1aZRypCvf0CTqqjqmfnNQmGi/1gN3v
         9CYqqZVuCdqcETuxwQjWqHm3f29fKpm0Jh5rmABs53bXrEgXzXFhejuVr7ovtE04wlbe
         yB1Xm6LNzemy4CAWUKgWkymVFM87zJYr7h70lpzkYJBNKAXBJCdSK+Zh8zOiq4MoMCSp
         zz6RkTipS4EfRYLvSbeZEKhOH/p4JdtnP9zDpO5GlMa/skxhwi3Y/SC3Q7H1RMLo2Fj3
         Sshlw0QpEo5GncAMIwFmrK16MAWhiQ5eq85xzCwSkjCIYFnmzcrA8j9qpFmfPFeTblNK
         tA7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=6U7gulSRknUpYYWEXTdNp6E6AUAABe5lU5EOH3DspwA=;
        b=8R68V7v+by4Hlc3UGwD/kbvZkC2HaOyJ/Qy6GK5fkm/ry+UJrhMdaiUD/DnxS0/At5
         682AxS1Gz7LBCu/TuQs5QWvcQlStZ30W9hKJPsR7G6L/fGYkT4JrDNp/0zXgHGpozhbY
         lURaoz0Ed7IFgTGnxbM7OixIa37j2qtyZ5Uf2m5q5Nq/4QHtwxS5OCfiNJKptlpiklx7
         /JGnnpvgW9sQlBhnAvfahORGYnbcSIaJOH4UN+Jd0y3bXmQAZNh4IB50B8ni2ilhs5+O
         6ah8Yr6q9zAc9N6IVMLDmHW9QO7SPB9FXbPkwyLnzQb0M1N7Kc7Gv1S5BqbjjoiTuJHp
         jBPw==
X-Gm-Message-State: AJIora8HKsttelDN5m9wtVuhM4B8Lcnscdyaqb597JPPYjojmIjTTVcD
        U0485W35ahuNfLCuw1iSYlM=
X-Google-Smtp-Source: AGRyM1u5e5V1eCgplzkxCZ8hQAnsEvw+tppiQYaVt6TQ1EJFukthwZqaAbTyVOcL4OI6P1fC1wbfig==
X-Received: by 2002:a17:907:2d0e:b0:72b:4af7:7ccd with SMTP id gs14-20020a1709072d0e00b0072b4af77ccdmr9351702ejc.209.1657573001345;
        Mon, 11 Jul 2022 13:56:41 -0700 (PDT)
Received: from krava ([151.14.22.253])
        by smtp.gmail.com with ESMTPSA id kv20-20020a17090778d400b0072af6f166c2sm3079328ejc.82.2022.07.11.13.56.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jul 2022 13:56:40 -0700 (PDT)
From:   Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date:   Mon, 11 Jul 2022 22:56:31 +0200
To:     German Gomez <german.gomez@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        acme@kernel.org, irogers@google.com,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>
Subject: Re: [PATCH v2 1/1] perf test: Add test for branch stack sampling
Message-ID: <YsyOfx9D3w5Rfiz8@krava>
References: <20220705150511.473919-1-german.gomez@arm.com>
 <20220705150511.473919-2-german.gomez@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220705150511.473919-2-german.gomez@arm.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 05, 2022 at 04:05:11PM +0100, German Gomez wrote:
> Add a self test for branch stack sampling, to check that we get the
> expected branch types, and filters behave as expected.
> 
> Suggested-by: Anshuman Khandual <anshuman.khandual@arm.com>
> Signed-off-by: German Gomez <german.gomez@arm.com>

Tested-by: Jiri Olsa <jolsa@kernel.org>

thanks,
jirka

> ---
>  tools/perf/tests/shell/test_brstack.sh | 114 +++++++++++++++++++++++++
>  1 file changed, 114 insertions(+)
>  create mode 100755 tools/perf/tests/shell/test_brstack.sh
> 
> diff --git a/tools/perf/tests/shell/test_brstack.sh b/tools/perf/tests/shell/test_brstack.sh
> new file mode 100755
> index 000000000..5f6f40a77
> --- /dev/null
> +++ b/tools/perf/tests/shell/test_brstack.sh
> @@ -0,0 +1,114 @@
> +#!/bin/sh
> +# Check branch stack sampling
> +
> +# SPDX-License-Identifier: GPL-2.0
> +# German Gomez <german.gomez@arm.com>, 2022
> +
> +# we need a C compiler to build the test programs
> +# so bail if none is found
> +if ! [ -x "$(command -v cc)" ]; then
> +	echo "failed: no compiler, install gcc"
> +	exit 2
> +fi
> +
> +# skip the test if the hardware doesn't support branch stack sampling
> +perf record -b -o- -e dummy -B true > /dev/null 2>&1 || exit 2
> +
> +TMPDIR=$(mktemp -d /tmp/__perf_test.program.XXXXX)
> +
> +cleanup() {
> +	rm -rf $TMPDIR
> +}
> +
> +trap cleanup exit term int
> +
> +gen_test_program() {
> +	# generate test program
> +	cat << EOF > $1
> +#define BENCH_RUNS 999999
> +int cnt;
> +void bar(void) {
> +}			/* return */
> +void foo(void) {
> +	bar();		/* call */
> +}			/* return */
> +void bench(void) {
> +  void (*foo_ind)(void) = foo;
> +  if ((cnt++) % 3)	/* branch (cond) */
> +    foo();		/* call */
> +  bar();		/* call */
> +  foo_ind();		/* call (ind) */
> +}
> +int main(void)
> +{
> +  int cnt = 0;
> +  while (1) {
> +    if ((cnt++) > BENCH_RUNS)
> +      break;
> +    bench();		/* call */
> +  }			/* branch (uncond) */
> +  return 0;
> +}
> +EOF
> +}
> +
> +test_user_branches() {
> +	echo "Testing user branch stack sampling"
> +
> +	gen_test_program "$TEMPDIR/program.c"
> +	cc -fno-inline -g "$TEMPDIR/program.c" -o $TMPDIR/a.out
> +
> +	perf record -o $TMPDIR/perf.data --branch-filter any,save_type,u -- $TMPDIR/a.out > /dev/null 2>&1
> +	perf script -i $TMPDIR/perf.data --fields brstacksym | xargs -n1 > $TMPDIR/perf.script
> +
> +	# example of branch entries:
> +	# 	foo+0x14/bar+0x40/P/-/-/0/CALL
> +
> +	set -x
> +	egrep -m1 "^bench\+[^ ]*/foo\+[^ ]*/IND_CALL$"	$TMPDIR/perf.script
> +	egrep -m1 "^foo\+[^ ]*/bar\+[^ ]*/CALL$"	$TMPDIR/perf.script
> +	egrep -m1 "^bench\+[^ ]*/foo\+[^ ]*/CALL$"	$TMPDIR/perf.script
> +	egrep -m1 "^bench\+[^ ]*/bar\+[^ ]*/CALL$"	$TMPDIR/perf.script
> +	egrep -m1 "^bar\+[^ ]*/foo\+[^ ]*/RET$"		$TMPDIR/perf.script
> +	egrep -m1 "^foo\+[^ ]*/bench\+[^ ]*/RET$"	$TMPDIR/perf.script
> +	egrep -m1 "^bench\+[^ ]*/bench\+[^ ]*/COND$"	$TMPDIR/perf.script
> +	egrep -m1 "^main\+[^ ]*/main\+[^ ]*/UNCOND$"	$TMPDIR/perf.script
> +	set +x
> +
> +	# some branch types are still not being tested:
> +	# IND COND_CALL COND_RET SYSCALL SYSRET IRQ SERROR NO_TX
> +}
> +
> +# first argument <arg0> is the argument passed to "--branch-stack <arg0>,save_type,u"
> +# second argument are the expected branch types for the given filter
> +test_filter() {
> +	local filter=$1
> +	local expect=$2
> +
> +	echo "Testing branch stack filtering permutation ($filter,$expect)"
> +
> +	gen_test_program "$TEMPDIR/program.c"
> +	cc -fno-inline -g "$TEMPDIR/program.c" -o $TMPDIR/a.out
> +
> +	perf record -o $TMPDIR/perf.data --branch-filter $filter,save_type,u -- $TMPDIR/a.out > /dev/null 2>&1
> +	perf script -i $TMPDIR/perf.data --fields brstack | xargs -n1 > $TMPDIR/perf.script
> +
> +	# fail if we find any branch type that doesn't match any of the expected ones
> +	# also consider UNKNOWN branch types (-)
> +	if egrep -vm1 "^[^ ]*/($expect|-|( *))$" $TMPDIR/perf.script; then
> +		return 1
> +	fi
> +}
> +
> +set -e
> +
> +test_user_branches
> +
> +test_filter "any_call"	"CALL|IND_CALL|COND_CALL|SYSCALL|IRQ"
> +test_filter "call"	"CALL|SYSCALL"
> +test_filter "cond"	"COND"
> +test_filter "any_ret"	"RET|COND_RET|SYSRET|ERET"
> +
> +test_filter "call,cond"		"CALL|SYSCALL|COND"
> +test_filter "any_call,cond"		"CALL|IND_CALL|COND_CALL|IRQ|SYSCALL|COND"
> +test_filter "cond,any_call,any_ret"	"COND|CALL|IND_CALL|COND_CALL|SYSCALL|IRQ|RET|COND_RET|SYSRET|ERET"
> -- 
> 2.25.1
> 
