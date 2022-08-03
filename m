Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A85E58949F
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 01:06:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236673AbiHCXGX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 19:06:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232503AbiHCXGV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 19:06:21 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AD5E4F1A4
        for <linux-kernel@vger.kernel.org>; Wed,  3 Aug 2022 16:06:18 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id j1so14864537wrw.1
        for <linux-kernel@vger.kernel.org>; Wed, 03 Aug 2022 16:06:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FoVaTdVnnKpapjEtX/Bhowc8mgQLn0GKcR1f2+ULZaU=;
        b=APJ5cgJSkIzr57+jBa3oRb2z34UPYSKa+b/ufo9X8GlDTJhGmNcxt2UT3D6O8AJhYv
         fe5IJq6HulCvtyg8CEBqaW42GWRihB4xUrv+pfwV6jTLu8ALODD+UvWo7YAkZSg+fEbZ
         MKb3WMm1e2aCQAqP4njGZA2TUVkUt8943tSPUhL7KeXr8V6xyKQ7v6xS1fVIJzCVbyyP
         IZam3HmgWZFxPGIs9jNKGQK4P3cWsMaluPcDVgMpM0471A5r3wBE/ZPd6rzdt1KUGkRE
         JEX+0paS44ZrXrteN3j02Bu63IsjIl/dZ2NV3sjzXinD1mgRelOh7orv8aabwA5dmSpV
         C/bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FoVaTdVnnKpapjEtX/Bhowc8mgQLn0GKcR1f2+ULZaU=;
        b=r8Pq1qjJuE/OjfQGSKbLDlsyDW5y5ohFDzRY6qjwbIeSYX2V7AiZACz6Kdoiha9Q0Z
         zudRDncq32HFeBy0Av3+uRbXxRIqet5ak8picWnJuDl1+GTSK4jY7vaUj0c3TUAJlFRZ
         EsLdDnZnYjlgH7xzt6yo7x8E48Zn+c2t6yDy8W6odd6g0fUsRQ+7YkVX16V89+bhFy/K
         ctlztFOfyjLse9Cv1bS7+ednaWZXxIu63zXLqfF7rpKXD0itO4JScb30BQCGocX+Jpd9
         5CSGQ7CgOZ0Gp47nnpONM5v/+aMtGsLDAClFRBv+IEZXQAd0THhNc7406VdSRMOhpfX2
         j/mQ==
X-Gm-Message-State: ACgBeo0bfWvT/uFZR98BFJVEilQTxJ2xargbCXyad1HvwqBPfh++lK0V
        2QO+Lmd1rRKkMP2XHnxTsrHL540hNVm+gonFG8oDzw==
X-Google-Smtp-Source: AA6agR5G0W57caREqGvPCwmAaQ13rQA8ouaOC7td77160JwzDVuMHiVltMu/kLxYKeaBwDLnuBQMRvDJKIsznsdbFjo=
X-Received: by 2002:a05:6000:1ac9:b0:220:7f40:49e3 with SMTP id
 i9-20020a0560001ac900b002207f4049e3mr1834734wry.40.1659567976810; Wed, 03 Aug
 2022 16:06:16 -0700 (PDT)
MIME-Version: 1.0
References: <20220803150744.133128-1-leo.yan@linaro.org>
In-Reply-To: <20220803150744.133128-1-leo.yan@linaro.org>
From:   Ian Rogers <irogers@google.com>
Date:   Wed, 3 Aug 2022 16:06:04 -0700
Message-ID: <CAP-5=fWArHKrxu80WKZystkEDFW_jhuU02m89S8tXkqvOChpoA@mail.gmail.com>
Subject: Re: [PATCH v1] perf test: Introduce script for data symbol parsing
To:     Leo Yan <leo.yan@linaro.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 3, 2022 at 8:07 AM Leo Yan <leo.yan@linaro.org> wrote:
>
> This commit introduces a shell script for data symbol parsing.
>
> The testing is designed a data structure with 64-byte alignment, and it
> has two fields "data1" and "data2", and other fields are reserved.
>
> Using "perf mem" command, it records and reports memory samples for a
> workload with 1 second duration.  If have no any memory sample for the
> data structure "buf1", it reports failure;  and any memory accessing for
> the data structure is not for "data1" and "data2" filed, it also means
> the wrong data symbol parsing and returns failure.
>
> Signed-off-by: Leo Yan <leo.yan@linaro.org>
> ---
>  tools/perf/tests/shell/test_data_symbol.sh | 94 ++++++++++++++++++++++
>  1 file changed, 94 insertions(+)
>  create mode 100755 tools/perf/tests/shell/test_data_symbol.sh
>
> diff --git a/tools/perf/tests/shell/test_data_symbol.sh b/tools/perf/tests/shell/test_data_symbol.sh
> new file mode 100755
> index 000000000000..7039dae4e087
> --- /dev/null
> +++ b/tools/perf/tests/shell/test_data_symbol.sh
> @@ -0,0 +1,94 @@
> +#!/bin/bash
> +# Check perf data symbol parsing
> +
> +# SPDX-License-Identifier: GPL-2.0
> +# Leo Yan <leo.yan@linaro.org>, 2022
> +
> +skip_if_no_mem_event() {
> +       perf mem record -e list 2>&1 | egrep -q 'available' && return 0
> +       return 2
> +}
> +
> +skip_if_no_mem_event || exit 2
> +
> +# skip if there's no compiler
> +if ! [ -x "$(command -v cc)" ]; then
> +       echo "skip: no compiler, install gcc"
> +       exit 2
> +fi
> +
> +TEST_PROGRAM_SOURCE=$(mktemp /tmp/__perf_test.program.XXXXX.c)
> +TEST_PROGRAM=$(mktemp /tmp/__perf_test.program.XXXXX)
> +PERF_DATA=$(mktemp /tmp/__perf_test.perf.data.XXXXX)
> +
> +check_result() {
> +       # The memory report format is as below:
> +       #    99.92%  ...  [.] buf1+0x38  ...
> +       result=$(perf mem report -i ${PERF_DATA} --stdio 2>&1 | egrep "buf1" | \
> +               awk '{ for (i = 1; i <= NF; i++) { if ($i ~ /^buf1/) { print $i; break; } } }')
> +
> +       # Testing is failed if has no any sample for "buf1"
> +       [ -z "$result" ] && return 1
> +
> +       while IFS= read -r line; do
> +               # The "data1" and "data2" fields in structure "buf1" have
> +               # offset "0x0" and "0x38", returns failure if detect any
> +               # other offset value.
> +               if [ "$line" != "buf1+0x0" ] && [ "$line" != "buf1+0x38" ]; then
> +                       return 1
> +               fi
> +       done <<< "$result"
> +
> +       return 0
> +}
> +
> +cleanup_files()
> +{
> +       echo "Cleaning up files..."
> +       rm -f ${PERF_DATA}
> +       rm -f ${TEST_PROGRAM_SOURCE}
> +       rm -f ${TEST_PROGRAM}
> +}
> +
> +trap cleanup_files exit term int
> +
> +# compile test program
> +cat << EOF > $TEST_PROGRAM_SOURCE
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <unistd.h>
> +
> +typedef struct _buf {
> +       long data1;
> +       long reserved[6];
> +       long data2;
> +} buf __attribute__((aligned (64)));
> +
> +static buf buf1;
> +
> +int main() {
> +       int i;
> +       for (;;) {
> +               buf1.data1++;
> +               buf1.data2 += buf1.data1;
> +       }
> +       return 0;
> +}
> +EOF
> +
> +echo "Compiling test program..."
> +cc $TEST_PROGRAM_SOURCE -o $TEST_PROGRAM || exit 1
> +
> +echo "Recording workload..."
> +perf mem record --all-user -o ${PERF_DATA} -- $TEST_PROGRAM &
> +PERFPID=$!

I wonder here you could do:
TESTPID=$(ps -o pid -h --ppid "$PERFPID")

> +sleep 1
> +
> +kill $PERFPID
> +wait $PERFPID
> +# test program may leave an orphan process running the workload
> +killall $(basename $TEST_PROGRAM)

And then here kill $TESTPID to avoid the killall which worries me a little.

Thanks,
Ian

> +
> +check_result "$variable_name"
> +exit $?
> --
> 2.25.1
>
