Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48F4D5786A5
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 17:46:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234528AbiGRPqS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 11:46:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231625AbiGRPqR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 11:46:17 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98E492980C;
        Mon, 18 Jul 2022 08:46:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 216CAB8165A;
        Mon, 18 Jul 2022 15:46:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FCADC341C0;
        Mon, 18 Jul 2022 15:46:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658159172;
        bh=XRNQm3bWdwgMvU3ekPqZ5nX4BCQx8MT+LjlyvWsO9rY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=I3XAP8iIgvDyv9PefjJg50VXQr+sLMg248gppExBQ8omKsBtelTdn3e7vJWG+Otwc
         wrEi/CIwMRQx0Ks5kgPmwwCOMs5gLCzNhT/fzWbFBfWucRATyf4QM+wloHTf+b0E0s
         HIWFiQ40m4EkjxY3tBisuZvHYRGJddtGlcOqKoaDyzhOKyCyUiPZjjl+3pdnJKogr2
         dI9xqqKCi+YKLZCwht1EkaE0RCbAvzhhjg9AgE+a2txf8M5nghsDYdu2U9s9yo3435
         xY6GwUT/P2D0v7tCseUEN2MG1weiiI47ywQWZ/UHDu4T6gqqxZ8Sd/O1SsSy0Cw8iu
         vFoPyljRxd1vA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 680D240374; Mon, 18 Jul 2022 12:46:10 -0300 (-03)
Date:   Mon, 18 Jul 2022 12:46:10 -0300
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
Subject: Re: [PATCH v6 2/2] perf test: Json format checking
Message-ID: <YtWAQqXFp98+N9ej@kernel.org>
References: <20220707201213.331663-1-irogers@google.com>
 <20220707201213.331663-3-irogers@google.com>
 <YtV/+yRsA9SJuntp@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YtV/+yRsA9SJuntp@kernel.org>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Jul 18, 2022 at 12:44:59PM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Thu, Jul 07, 2022 at 01:12:13PM -0700, Ian Rogers escreveu:
> > From: Claire Jensen <cjense@google.com>
> > 
> > Add field checking tests for perf stat JSON output.
> > Sanity checks the expected number of fields are present, that the
> > expected keys are present and they have the correct values.
> 
> it isn't installing the lib:
> 
> [root@five ~]# perf test -v json
>  91: perf stat JSON output linter                                    :
> --- start ---
> test child forked, pid 4086678
> Checking json output: no args python3: can't open file '/var/home/acme/libexec/perf-core/tests/shell/lib/perf_json_output_lint.py': [Errno 2] No such file or directory
> test child finished with -2
> ---- end ----
> perf stat JSON output linter: Skip
> [root@five ~]#
> 
> I'm trying to fix, but please test it after installing...


It should:

install-tests: all install-gtk
        $(call QUIET_INSTALL, tests) \
                $(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(perfexec_instdir_SQ)/tests'; \
                $(INSTALL) tests/attr.py '$(DESTDIR_SQ)$(perfexec_instdir_SQ)/tests'; \
                $(INSTALL) tests/pe-file.exe* '$(DESTDIR_SQ)$(perfexec_instdir_SQ)/tests'; \
                $(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(perfexec_instdir_SQ)/tests/attr'; \
                $(INSTALL) tests/attr/* '$(DESTDIR_SQ)$(perfexec_instdir_SQ)/tests/attr'; \
                $(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(perfexec_instdir_SQ)/tests/shell'; \
                $(INSTALL) tests/shell/*.sh '$(DESTDIR_SQ)$(perfexec_instdir_SQ)/tests/shell'; \
                $(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(perfexec_instdir_SQ)/tests/shell/lib'; \
                $(INSTALL) tests/shell/lib/*.sh '$(DESTDIR_SQ)$(perfexec_instdir_SQ)/tests/shell/lib'

/me checking...

- Arnaldo

> - Arnaldo
> 
>  
> > Signed-off-by: Claire Jensen <cjense@google.com>
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >  .../tests/shell/lib/perf_json_output_lint.py  |  95 +++++++++++
> >  tools/perf/tests/shell/stat+json_output.sh    | 147 ++++++++++++++++++
> >  2 files changed, 242 insertions(+)
> >  create mode 100644 tools/perf/tests/shell/lib/perf_json_output_lint.py
> >  create mode 100755 tools/perf/tests/shell/stat+json_output.sh
> > 
> > diff --git a/tools/perf/tests/shell/lib/perf_json_output_lint.py b/tools/perf/tests/shell/lib/perf_json_output_lint.py
> > new file mode 100644
> > index 000000000000..aaa4a8677b6c
> > --- /dev/null
> > +++ b/tools/perf/tests/shell/lib/perf_json_output_lint.py
> > @@ -0,0 +1,95 @@
> > +#!/usr/bin/python
> > +# SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause)
> > +# Basic sanity check of perf JSON output as specified in the man page.
> > +
> > +import argparse
> > +import sys
> > +import json
> > +
> > +ap = argparse.ArgumentParser()
> > +ap.add_argument('--no-args', action='store_true')
> > +ap.add_argument('--interval', action='store_true')
> > +ap.add_argument('--system-wide-no-aggr', action='store_true')
> > +ap.add_argument('--system-wide', action='store_true')
> > +ap.add_argument('--event', action='store_true')
> > +ap.add_argument('--per-core', action='store_true')
> > +ap.add_argument('--per-thread', action='store_true')
> > +ap.add_argument('--per-die', action='store_true')
> > +ap.add_argument('--per-node', action='store_true')
> > +ap.add_argument('--per-socket', action='store_true')
> > +args = ap.parse_args()
> > +
> > +Lines = sys.stdin.readlines()
> > +
> > +def isfloat(num):
> > +  try:
> > +    float(num)
> > +    return True
> > +  except ValueError:
> > +    return False
> > +
> > +
> > +def isint(num):
> > +  try:
> > +    int(num)
> > +    return True
> > +  except ValueError:
> > +    return False
> > +
> > +def is_counter_value(num):
> > +  return isfloat(num) or num == '<not counted>' or num == '<not supported>'
> > +
> > +def check_json_output(expected_items):
> > +  if expected_items != -1:
> > +    for line in Lines:
> > +      if 'failed' not in line:
> > +        count = 0
> > +        count = line.count(',')
> > +        if count != expected_items and (count == 1 or count == 2) and 'metric-value' in line:
> > +          # Events that generate >1 metric may have isolated metric
> > +          # values and possibly have an interval prefix.
> > +          continue
> > +        if count != expected_items:
> > +          raise RuntimeError(f'wrong number of fields. counted {count} expected {expected_items}'
> > +                             f' in \'{line}\'')
> > +  checks = {
> > +      'aggregate-number': lambda x: isfloat(x),
> > +      'core': lambda x: True,
> > +      'counter-value': lambda x: is_counter_value(x),
> > +      'cgroup': lambda x: True,
> > +      'cpu': lambda x: isint(x),
> > +      'die': lambda x: True,
> > +      'event': lambda x: True,
> > +      'event-runtime': lambda x: isfloat(x),
> > +      'interval': lambda x: isfloat(x),
> > +      'metric-unit': lambda x: True,
> > +      'metric-value': lambda x: isfloat(x),
> > +      'node': lambda x: True,
> > +      'pcnt-running': lambda x: isfloat(x),
> > +      'socket': lambda x: True,
> > +      'thread': lambda x: True,
> > +      'unit': lambda x: True,
> > +  }
> > +  input = '[\n' + ','.join(Lines) + '\n]'
> > +  for item in json.loads(input):
> > +    for key, value in item.items():
> > +      if key not in checks:
> > +        raise RuntimeError(f'Unexpected key: key={key} value={value}')
> > +      if not checks[key](value):
> > +        raise RuntimeError(f'Check failed for: key={key} value={value}')
> > +
> > +
> > +try:
> > +  if args.no_args or args.system_wide or args.event:
> > +    expected_items = 6
> > +  elif args.interval or args.per_thread or args.system_wide_no_aggr:
> > +    expected_items = 7
> > +  elif args.per_core or args.per_socket or args.per_node or args.per_die:
> > +    expected_items = 8
> > +  else:
> > +    # If no option is specified, don't check the number of items.
> > +    expected_items = -1
> > +  check_json_output(expected_items)
> > +except:
> > +  print('Test failed for input:\n' + '\n'.join(Lines))
> > +  raise
> > diff --git a/tools/perf/tests/shell/stat+json_output.sh b/tools/perf/tests/shell/stat+json_output.sh
> > new file mode 100755
> > index 000000000000..ea8714a36051
> > --- /dev/null
> > +++ b/tools/perf/tests/shell/stat+json_output.sh
> > @@ -0,0 +1,147 @@
> > +#!/bin/bash
> > +# perf stat JSON output linter
> > +# SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause)
> > +# Checks various perf stat JSON output commands for the
> > +# correct number of fields.
> > +
> > +set -e
> > +
> > +pythonchecker=$(dirname $0)/lib/perf_json_output_lint.py
> > +if [ "x$PYTHON" == "x" ]
> > +then
> > +	if which python3 > /dev/null
> > +	then
> > +		PYTHON=python3
> > +	elif which python > /dev/null
> > +	then
> > +		PYTHON=python
> > +	else
> > +		echo Skipping test, python not detected please set environment variable PYTHON.
> > +		exit 2
> > +	fi
> > +fi
> > +
> > +# Return true if perf_event_paranoid is > $1 and not running as root.
> > +function ParanoidAndNotRoot()
> > +{
> > +	 [ $(id -u) != 0 ] && [ $(cat /proc/sys/kernel/perf_event_paranoid) -gt $1 ]
> > +}
> > +
> > +check_no_args()
> > +{
> > +	echo -n "Checking json output: no args "
> > +	perf stat -j true 2>&1 | $PYTHON $pythonchecker --no-args
> > +	echo "[Success]"
> > +}
> > +
> > +check_system_wide()
> > +{
> > +	echo -n "Checking json output: system wide "
> > +	if ParanoidAndNotRoot 0
> > +	then
> > +		echo "[Skip] paranoia and not root"
> > +		return
> > +	fi
> > +	perf stat -j -a true 2>&1 | $PYTHON $pythonchecker --system-wide
> > +	echo "[Success]"
> > +}
> > +
> > +check_system_wide_no_aggr()
> > +{
> > +	echo -n "Checking json output: system wide "
> > +	if ParanoidAndNotRoot 0
> > +	then
> > +		echo "[Skip] paranoia and not root"
> > +		return
> > +	fi
> > +	echo -n "Checking json output: system wide no aggregation "
> > +	perf stat -j -A -a --no-merge true 2>&1 | $PYTHON $pythonchecker --system-wide-no-aggr
> > +	echo "[Success]"
> > +}
> > +
> > +check_interval()
> > +{
> > +	echo -n "Checking json output: interval "
> > +	perf stat -j -I 1000 true 2>&1 | $PYTHON $pythonchecker --interval
> > +	echo "[Success]"
> > +}
> > +
> > +
> > +check_event()
> > +{
> > +	echo -n "Checking json output: event "
> > +	perf stat -j -e cpu-clock true 2>&1 | $PYTHON $pythonchecker --event
> > +	echo "[Success]"
> > +}
> > +
> > +check_per_core()
> > +{
> > +	echo -n "Checking json output: per core "
> > +	if ParanoidAndNotRoot 0
> > +	then
> > +		echo "[Skip] paranoia and not root"
> > +		return
> > +	fi
> > +	perf stat -j --per-core -a true 2>&1 | $PYTHON $pythonchecker --per-core
> > +	echo "[Success]"
> > +}
> > +
> > +check_per_thread()
> > +{
> > +	echo -n "Checking json output: per thread "
> > +	if ParanoidAndNotRoot 0
> > +	then
> > +		echo "[Skip] paranoia and not root"
> > +		return
> > +	fi
> > +	perf stat -j --per-thread -a true 2>&1 | $PYTHON $pythonchecker --per-thread
> > +	echo "[Success]"
> > +}
> > +
> > +check_per_die()
> > +{
> > +	echo -n "Checking json output: per die "
> > +	if ParanoidAndNotRoot 0
> > +	then
> > +		echo "[Skip] paranoia and not root"
> > +		return
> > +	fi
> > +	perf stat -j --per-die -a true 2>&1 | $PYTHON $pythonchecker --per-die
> > +	echo "[Success]"
> > +}
> > +
> > +check_per_node()
> > +{
> > +	echo -n "Checking json output: per node "
> > +	if ParanoidAndNotRoot 0
> > +	then
> > +		echo "[Skip] paranoia and not root"
> > +		return
> > +	fi
> > +	perf stat -j --per-node -a true 2>&1 | $PYTHON $pythonchecker --per-node
> > +	echo "[Success]"
> > +}
> > +
> > +check_per_socket()
> > +{
> > +	echo -n "Checking json output: per socket "
> > +	if ParanoidAndNotRoot 0
> > +	then
> > +		echo "[Skip] paranoia and not root"
> > +		return
> > +	fi
> > +	perf stat -j --per-socket -a true 2>&1 | $PYTHON $pythonchecker --per-socket
> > +	echo "[Success]"
> > +}
> > +
> > +check_no_args
> > +check_system_wide
> > +check_system_wide_no_aggr
> > +check_interval
> > +check_event
> > +check_per_core
> > +check_per_thread
> > +check_per_die
> > +check_per_node
> > +check_per_socket
> > +exit 0
> > -- 
> > 2.37.0.rc0.161.g10f37bed90-goog
> 
> -- 
> 
> - Arnaldo

-- 

- Arnaldo
