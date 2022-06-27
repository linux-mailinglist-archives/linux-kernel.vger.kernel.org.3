Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D237E55C6AA
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 14:53:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239309AbiF0QjB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 12:39:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234772AbiF0Qi7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 12:38:59 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70D7718361
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 09:38:58 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id n185so5769304wmn.4
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 09:38:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2X0YMR4doGI5s4MFYhx72Aqlx/HSr/zz0dnGpOBKJrI=;
        b=eo1IOeTJvZiZniGYJFFgAk698L+00MlWQOrG2gWirsUWOqoesM22S/XvZRZWJAMyKK
         i9JzzAUR+049lxrM/++AAAMKJ2+KcXVwuEPUheYreeiKEVybhSe+gjvvt2m0ro/+VgCj
         BmLs/lMSb6pqsjaRd0YT5nINZNC3sstCSO9hkwfvFrWyAUEQZgZp2tHM/PctFwr4Pmp3
         EwDJb5tDrb99wryofOaorvPD/qJt1pmIodVoH1sUASx1hZw57aDSVrZoWBbBmA7AwwPm
         FACK3P8s8SMel7DWA8oxiHJWtEokPH5KTX2b5h5s4NFH2+zAFFX6tL5LpGJFy+NxqGJw
         vTfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2X0YMR4doGI5s4MFYhx72Aqlx/HSr/zz0dnGpOBKJrI=;
        b=pEJ6+gAlYl2LPjnDi+KqDXDhHtIYMvFsdtF3R/wHWEnXH7dp1ChuYMlIbtuitr2DGt
         WBHklU76T4iTCObqahHGBKc+zl7dfWza0AdvsARJ5riy1AHNum6UtDW/sHBmpCUbaJei
         V+QbeRDnYCnCfNTdmBgrXpBnSjCAO3Z6sL1h+H51hqM8Nl3+9Chb5D7a+fqg2H+RJQoV
         yNfDobQRXS5Rmrj3P0dHKdpv6hfiXs8EMcR6dXXBpsCCungFP8w+9jK1jzTdIjI2YqVn
         8JZrLCyCMopO7abIdEMllrr1QjT+mmydqYr1b1jBgs7oxttKgNUy8FqSdl4LCiy9AAxH
         LkuQ==
X-Gm-Message-State: AJIora8yH7Is+lW8LsrdJilJSGq9MqfqqWXiJHPcrAWvj/S+DwG1GFtz
        4/6rz5K8q5583ENkn+di9/Xs0NhIHh5y2Dci6FLZuQ==
X-Google-Smtp-Source: AGRyM1v7yilIE6a1bBX0SDsItjQBLoyAw+z0fd/Z6DYlMHs2qDS/BSvav9Ttef9A19nGeYif8daXLEZ5hFPStHYwBME=
X-Received: by 2002:a7b:c10c:0:b0:3a0:439d:6d66 with SMTP id
 w12-20020a7bc10c000000b003a0439d6d66mr14029728wmi.149.1656347936902; Mon, 27
 Jun 2022 09:38:56 -0700 (PDT)
MIME-Version: 1.0
References: <20220615130901.1151397-1-german.gomez@arm.com> <20220615130901.1151397-2-german.gomez@arm.com>
In-Reply-To: <20220615130901.1151397-2-german.gomez@arm.com>
From:   Ian Rogers <irogers@google.com>
Date:   Mon, 27 Jun 2022 09:38:44 -0700
Message-ID: <CAP-5=fU2duRRY3f0PKuM_a4_Nwi3zy576ajKMVp1cs_qfcr8kw@mail.gmail.com>
Subject: Re: [PATCH] perf test: Add test for branch stack sampling
To:     German Gomez <german.gomez@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        acme@kernel.org, Anshuman Khandual <anshuman.khandual@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 15, 2022 at 6:09 AM German Gomez <german.gomez@arm.com> wrote:
>
> Add a self test for branch stack sampling, to check that we get the
> expected branch types, and filters behave as expected.
>
> Suggested-by: Anshuman Khandual <anshuman.khandual@arm.com>
> Signed-off-by: German Gomez <german.gomez@arm.com>

Love tests, thanks! There are already shell tests that compile C code
but they do it by having the C code within the shell test, for
example:
https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git/tree/tools/perf/tests/shell/pipe_test.sh?h=perf/core#n14
Having it this way I thinks means the tests can run properly when
installed, as we don't install non-sh files:
https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git/tree/tools/perf/Makefile.perf?h=perf/core#n1016

Thanks,
Ian

> ---
>  tools/perf/tests/shell/lib/brstack/main.h | 16 +++++
>  tools/perf/tests/shell/lib/brstack/test.c | 24 +++++++
>  tools/perf/tests/shell/test_brstack.sh    | 86 +++++++++++++++++++++++
>  3 files changed, 126 insertions(+)
>  create mode 100644 tools/perf/tests/shell/lib/brstack/main.h
>  create mode 100644 tools/perf/tests/shell/lib/brstack/test.c
>  create mode 100755 tools/perf/tests/shell/test_brstack.sh
>
> diff --git a/tools/perf/tests/shell/lib/brstack/main.h b/tools/perf/tests/shell/lib/brstack/main.h
> new file mode 100644
> index 000000000..94d2665ec
> --- /dev/null
> +++ b/tools/perf/tests/shell/lib/brstack/main.h
> @@ -0,0 +1,16 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#define BENCH_RUNS 99999
> +
> +void bench(void);
> +
> +int main(void)
> +{
> +       int cnt = 0;
> +
> +       while (1) {
> +               if ((cnt++) > BENCH_RUNS)
> +                       break;
> +               bench();                /* call */
> +       }                               /* branch (uncond) */
> +       return 0;
> +}
> diff --git a/tools/perf/tests/shell/lib/brstack/test.c b/tools/perf/tests/shell/lib/brstack/test.c
> new file mode 100644
> index 000000000..8a2308901
> --- /dev/null
> +++ b/tools/perf/tests/shell/lib/brstack/test.c
> @@ -0,0 +1,24 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#include "main.h"
> +
> +int cnt;
> +
> +void bar(void)
> +{
> +}                              /* return */
> +
> +void foo(void)
> +{
> +       bar();                  /* call */
> +}                              /* return */
> +
> +void bench(void)
> +{
> +       void (*foo_ind)(void) = foo;
> +
> +       if ((cnt++) % 3)        /* branch (cond) */
> +               foo();          /* call */
> +
> +       bar();                  /* call */
> +       foo_ind();              /* call (ind) */
> +}
> diff --git a/tools/perf/tests/shell/test_brstack.sh b/tools/perf/tests/shell/test_brstack.sh
> new file mode 100755
> index 000000000..2b1a1b20a
> --- /dev/null
> +++ b/tools/perf/tests/shell/test_brstack.sh
> @@ -0,0 +1,86 @@
> +#!/bin/sh
> +# Check branch stack sampling
> +
> +# SPDX-License-Identifier: GPL-2.0
> +# German Gomez <german.gomez@arm.com>, 2022
> +
> +set -e
> +
> +# we need a C compiler to build the test programs
> +# so bail if none is found
> +if ! [ -x "$(command -v cc)" ]; then
> +       echo "failed: no compiler, install gcc"
> +       exit 2
> +fi
> +
> +# skip the test if the hardware doesn't support branch stack sampling
> +perf record -b -o- -- true > /dev/null || exit 2
> +
> +TMPDIR=$(mktemp -d /tmp/__perf_test.program.XXXXX)
> +
> +cleanup() {
> +       rm -rf $TMPDIR
> +}
> +
> +trap cleanup exit term int
> +
> +test_user_branches() {
> +       echo
> +       echo "Testing user branch stack sampling"
> +       echo
> +
> +       cc -fno-inline -g "$(dirname $0)/lib/brstack/test.c" -o $TMPDIR/a.out
> +
> +       perf record -o $TMPDIR/perf.data -q --branch-filter any,save_type,u -- $TMPDIR/a.out
> +       perf script -i $TMPDIR/perf.data --fields brstacksym | xargs -n1 > $TMPDIR/perf.script
> +
> +       # example of branch entries:
> +       #       foo+0x14/bar+0x40/P/-/-/0/CALL
> +
> +       set -x
> +       egrep -m1 "^bench\+[^ ]*/foo\+[^ ]*/IND_CALL$"  $TMPDIR/perf.script
> +       egrep -m1 "^foo\+[^ ]*/bar\+[^ ]*/CALL$"        $TMPDIR/perf.script
> +       egrep -m1 "^bench\+[^ ]*/foo\+[^ ]*/CALL$"      $TMPDIR/perf.script
> +       egrep -m1 "^bench\+[^ ]*/bar\+[^ ]*/CALL$"      $TMPDIR/perf.script
> +       egrep -m1 "^bar\+[^ ]*/foo\+[^ ]*/RET$"         $TMPDIR/perf.script
> +       egrep -m1 "^foo\+[^ ]*/bench\+[^ ]*/RET$"       $TMPDIR/perf.script
> +       egrep -m1 "^bench\+[^ ]*/bench\+[^ ]*/COND$"    $TMPDIR/perf.script
> +       egrep -m1 "^main\+[^ ]*/main\+[^ ]*/UNCOND$"    $TMPDIR/perf.script
> +       set +x
> +
> +       # some branch types are still not being tested:
> +       # IND COND_CALL COND_RET SYSCALL SYSRET IRQ SERROR NO_TX
> +}
> +
> +test_filter() {
> +       local filter=$1
> +       local expect=$2
> +
> +       echo
> +       echo "Testing branch stack filtering permutation ($filter,$expect)"
> +       echo
> +
> +       cc -fno-inline -g "$(dirname $0)/lib/brstack/test.c" -o $TMPDIR/a.out
> +
> +       perf record -o $TMPDIR/perf.data -q --branch-filter $filter,save_type,u -- $TMPDIR/a.out
> +       perf script -i $TMPDIR/perf.data --fields brstack | xargs -n1 > $TMPDIR/perf.script
> +
> +       # fail if we find any branch type that doesn't match any of the expected ones
> +       # also consider UNKNOWN branch types (-)
> +       if egrep -vm1 "^[^ ]*/($expect|-|( *))$" $TMPDIR/perf.script; then
> +               return 1
> +       fi
> +}
> +
> +test_user_branches
> +
> +# first argument <arg0> is the argument passed to "--branch-stack <arg0>,save_type,u"
> +# second argument are the expected branch types for the given filter
> +test_filter "any_call" "CALL|IND_CALL|COND_CALL|SYSCALL|IRQ|FAULT_DATA|FAULT_INST"
> +test_filter "call"     "CALL|SYSCALL"
> +test_filter "cond"     "COND"
> +test_filter "any_ret"  "RET|COND_RET|SYSRET|ERET"
> +
> +test_filter "call,cond"                "CALL|SYSCALL|COND"
> +test_filter "any_call,cond"            "CALL|IND_CALL|COND_CALL|IRQ|FAULT_DATA|FAULT_INST|SYSCALL|COND"
> +test_filter "cond,any_call,any_ret"    "COND|CALL|IND_CALL|COND_CALL|SYSCALL|IRQ|FAULT_DATA|FAULT_INST|RET|COND_RET|SYSRET|ERET"
> --
> 2.25.1
>
