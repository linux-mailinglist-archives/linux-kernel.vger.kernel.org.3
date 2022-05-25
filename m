Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09515533B43
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 13:07:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236776AbiEYLH2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 07:07:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236673AbiEYLHY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 07:07:24 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FA4E3B3F3;
        Wed, 25 May 2022 04:07:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DD456B81D0A;
        Wed, 25 May 2022 11:07:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B6CFC385B8;
        Wed, 25 May 2022 11:07:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653476840;
        bh=aZd2Jm71EyfyAuktpRZsuTKx7fZvMLY7U/iTDktxjm8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dNQmzY4yDU4TWBDuf0H4PVhugsbJf9FSEW08GDr1BHgd7U0MeLHNe6DDD5hHEkl3L
         ws1X/+v9jZ1ZvtdhmJAsrY8Ok32DVo9cpvV92Bs/Qto0poylzY3AWxYbdxK4F/gtLo
         GTnY5BDHz9W+AotQu2+b8FL/16T7YOyzhQm6K0W9d4Hz91bdag9MFxsZT0Apfwk91P
         FbgGd2GtEeyS3V3z63Wm4WqjEW2zf4xE8SFajvJMPASCTb57Tt5IYhiWSKKT4oYsTd
         a4EVphY9Gpmz567UlzYGmIT1gXVbtOLJlI3M+yTan+IAwmX1Vz5CphhwAo/qnx24ZA
         Ar4PUdcsIBMqQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 164BB4007E; Wed, 25 May 2022 08:07:18 -0300 (-03)
Date:   Wed, 25 May 2022 08:07:18 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        Sandipan Das <sandipan.das@amd.com>,
        Claire Jensen <cjense@google.com>, Alyssa Ross <hi@alyssa.is>,
        Like Xu <likexu@tencent.com>,
        James Clark <james.clark@arm.com>,
        Florian Fischer <florian.fischer@muhq.space>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Claire Jensen <clairej735@gmail.com>,
        Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH v4 1/3] perf test: Add checking for perf stat CSV output.
Message-ID: <Yo4N5py+ggnREF7p@kernel.org>
References: <20220525053814.3265216-1-irogers@google.com>
 <20220525053814.3265216-2-irogers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220525053814.3265216-2-irogers@google.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, May 24, 2022 at 10:38:12PM -0700, Ian Rogers escreveu:
> From: Claire Jensen <cjense@google.com>
> 
> Counts expected fields for various commands. No testing added for
> summary mode since it is broken.
> 
> An example of the summary output is:
> 
>          summary,263831,,instructions:u,1435072,100.0,0.46,insn per cycle
> ,,,,,1.37,stalled cycles per insn
> 
> This should be:
> 
>          summary,263831,,instructions:u,1435072,100.0,0.46,insn per cycle
>          summary,,,,,,1.37,stalled cycles per insn
> 
> The output has 7 fields when it should have 8. Additionally, the newline
> spacing is wrong, so it was excluded from testing until a fix is made.

s/parnoia/paranoid/ on the [Skip] lines, or am I missing something? :-)

I'll fix this up here.

- Arnaldo
 
> Signed-off-by: Claire Jensen <cjense@google.com>
> ---
>  .../tests/shell/lib/perf_csv_output_lint.py   |  48 ++++++
>  tools/perf/tests/shell/stat+csv_output.sh     | 147 ++++++++++++++++++
>  2 files changed, 195 insertions(+)
>  create mode 100644 tools/perf/tests/shell/lib/perf_csv_output_lint.py
>  create mode 100755 tools/perf/tests/shell/stat+csv_output.sh
> 
> diff --git a/tools/perf/tests/shell/lib/perf_csv_output_lint.py b/tools/perf/tests/shell/lib/perf_csv_output_lint.py
> new file mode 100644
> index 000000000000..714f283cfb1b
> --- /dev/null
> +++ b/tools/perf/tests/shell/lib/perf_csv_output_lint.py
> @@ -0,0 +1,48 @@
> +#!/usr/bin/python
> +# SPDX-License-Identifier: GPL-2.0
> +
> +import argparse
> +import sys
> +
> +# Basic sanity check of perf CSV output as specified in the man page.
> +# Currently just checks the number of fields per line in output.
> +
> +ap = argparse.ArgumentParser()
> +ap.add_argument('--no-args', action='store_true')
> +ap.add_argument('--interval', action='store_true')
> +ap.add_argument('--system-wide-no-aggr', action='store_true')
> +ap.add_argument('--system-wide', action='store_true')
> +ap.add_argument('--event', action='store_true')
> +ap.add_argument('--per-core', action='store_true')
> +ap.add_argument('--per-thread', action='store_true')
> +ap.add_argument('--per-die', action='store_true')
> +ap.add_argument('--per-node', action='store_true')
> +ap.add_argument('--per-socket', action='store_true')
> +ap.add_argument('--separator', default=',', nargs='?')
> +args = ap.parse_args()
> +
> +Lines = sys.stdin.readlines()
> +
> +def check_csv_output(exp):
> +  for line in Lines:
> +    if 'failed' not in line:
> +      count = line.count(args.separator)
> +      if count != exp:
> +        sys.stdout.write(''.join(Lines))
> +        raise RuntimeError(f'wrong number of fields. expected {exp} in {line}')
> +
> +try:
> +  if args.no_args or args.system_wide or args.event:
> +    expected_items = 6
> +  elif args.interval or args.per_thread or args.system_wide_no_aggr:
> +    expected_items = 7
> +  elif args.per_core or args.per_socket or args.per_node or args.per_die:
> +    expected_items = 8
> +  else:
> +    ap.print_help()
> +    raise RuntimeError('No checking option specified')
> +  check_csv_output(expected_items)
> +
> +except:
> +  sys.stdout.write('Test failed for input: ' + ''.join(Lines))
> +  raise
> diff --git a/tools/perf/tests/shell/stat+csv_output.sh b/tools/perf/tests/shell/stat+csv_output.sh
> new file mode 100755
> index 000000000000..82c25e9c7f21
> --- /dev/null
> +++ b/tools/perf/tests/shell/stat+csv_output.sh
> @@ -0,0 +1,147 @@
> +#!/bin/bash
> +# perf stat CSV output linter
> +# SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause)
> +# Tests various perf stat CSV output commands for the
> +# correct number of fields and the CSV separator set to ','.
> +
> +set -e
> +
> +pythonchecker=$(dirname $0)/lib/perf_csv_output_lint.py
> +if [ "x$PYTHON" == "x" ]
> +then
> +	if which python3 > /dev/null
> +	then
> +		PYTHON=python3
> +	elif which python > /dev/null
> +	then
> +		PYTHON=python
> +	else
> +		echo Skipping test, python not detected please set environment variable PYTHON.
> +		exit 2
> +	fi
> +fi
> +
> +# Return true if perf_event_paranoid is > $1 and not running as root.
> +function ParanoidAndNotRoot()
> +{
> +	 [ $(id -u) != 0 ] && [ $(cat /proc/sys/kernel/perf_event_paranoid) -gt $1 ]
> +}
> +
> +check_no_args()
> +{
> +	echo -n "Checking CSV output: no args "
> +	perf stat -x, true 2>&1 | $PYTHON $pythonchecker --no-args
> +	echo "[Success]"
> +}
> +
> +check_system_wide()
> +{
> +	echo -n "Checking CSV output: system wide "
> +	if ParanoidAndNotRoot 0
> +	then
> +		echo "[Skip] parnoia and not root"
> +		return
> +	fi
> +	perf stat -x, -a true 2>&1 | $PYTHON $pythonchecker --system-wide
> +	echo "[Success]"
> +}
> +
> +check_system_wide_no_aggr()
> +{
> +	echo -n "Checking CSV output: system wide "
> +	if ParanoidAndNotRoot 0
> +	then
> +		echo "[Skip] parnoia and not root"
> +		return
> +	fi
> +	echo -n "Checking CSV output: system wide no aggregation "
> +	perf stat -x, -A -a --no-merge true 2>&1 | $PYTHON $pythonchecker --system-wide-no-aggr
> +	echo "[Success]"
> +}
> +
> +check_interval()
> +{
> +	echo -n "Checking CSV output: interval "
> +	perf stat -x, -I 1000 true 2>&1 | $PYTHON $pythonchecker --interval
> +	echo "[Success]"
> +}
> +
> +
> +check_event()
> +{
> +	echo -n "Checking CSV output: event "
> +	perf stat -x, -e cpu-clock true 2>&1 | $PYTHON $pythonchecker --event
> +	echo "[Success]"
> +}
> +
> +check_per_core()
> +{
> +	echo -n "Checking CSV output: per core "
> +	if ParanoidAndNotRoot 0
> +	then
> +		echo "[Skip] parnoia and not root"
> +		return
> +	fi
> +	perf stat -x, --per-core -a true 2>&1 | $PYTHON $pythonchecker --per-core
> +	echo "[Success]"
> +}
> +
> +check_per_thread()
> +{
> +	echo -n "Checking CSV output: per thread "
> +	if ParanoidAndNotRoot 0
> +	then
> +		echo "[Skip] parnoia and not root"
> +		return
> +	fi
> +	perf stat -x, --per-thread -a true 2>&1 | $PYTHON $pythonchecker --per-thread
> +	echo "[Success]"
> +}
> +
> +check_per_die()
> +{
> +	echo -n "Checking CSV output: per die "
> +	if ParanoidAndNotRoot 0
> +	then
> +		echo "[Skip] parnoia and not root"
> +		return
> +	fi
> +	perf stat -x, --per-die -a true 2>&1 | $PYTHON $pythonchecker --per-die
> +	echo "[Success]"
> +}
> +
> +check_per_node()
> +{
> +	echo -n "Checking CSV output: per node "
> +	if ParanoidAndNotRoot 0
> +	then
> +		echo "[Skip] parnoia and not root"
> +		return
> +	fi
> +	perf stat -x, --per-node -a true 2>&1 | $PYTHON $pythonchecker --per-node
> +	echo "[Success]"
> +}
> +
> +check_per_socket()
> +{
> +	echo -n "Checking CSV output: per socket "
> +	if ParanoidAndNotRoot 0
> +	then
> +		echo "[Skip] parnoia and not root"
> +		return
> +	fi
> +	perf stat -x, --per-socket -a true 2>&1 | $PYTHON $pythonchecker --per-socket
> +	echo "[Success]"
> +}
> +
> +check_no_args
> +check_system_wide
> +check_system_wide_no_aggr
> +check_interval
> +check_event
> +check_per_core
> +check_per_thread
> +check_per_die
> +check_per_node
> +check_per_socket
> +exit 0
> -- 
> 2.36.1.124.g0e6072fb45-goog

-- 

- Arnaldo
