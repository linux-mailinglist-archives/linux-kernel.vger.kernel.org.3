Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EF204833CC
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jan 2022 15:54:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233534AbiACOyH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jan 2022 09:54:07 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:53552 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229605AbiACOyG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jan 2022 09:54:06 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 304CBB80EF2;
        Mon,  3 Jan 2022 14:54:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9876FC36AEB;
        Mon,  3 Jan 2022 14:54:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641221644;
        bh=ZKRXbXIL57BA0aWBAxv3+SWbfv19RZyITq0IuJTyZwM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sJfd7Po/w5HhZia59mB09HNqXXMMPAt6ULTfbRPtyWannYrjg8P/P9IAoJ700bjH+
         KAg23fbSfCAzgz3zk0dH/Bybj0SKV3qFOL7KYHqSAv94iQ294AK8272p0+C5fb5IZb
         qndvzPAtx6skQILg+6tHzBwv0Ka3XJvd83cI4kSkrsOtzL6AjsUaA9deWy9NEl8wDF
         EpFhNX3sj3W4/4SuOA2sWRXcpYqEEl+r1ULHq0AMwkHhaaNiVlKd9YvddaPFNIm54W
         FZE0355YPQWkc5daKsC4kJjDUuWO03QTOxBupgPNWqq5j45AT0qKtRhSyqoIt+qgLh
         t+Jehwnt/SZcA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 8B8EF40B92; Mon,  3 Jan 2022 11:53:59 -0300 (-03)
Date:   Mon, 3 Jan 2022 11:53:59 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Claire Jensen <cjense@google.com>, Jiri Olsa <jolsa@redhat.com>
Cc:     peterz@infradead.org, mingo@redhat.com, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, namhyung@kernel.org,
        yao.jin@linux.intel.com, song@kernel.org, andi@firstfloor.org,
        adrian.hunter@intel.com, kan.liang@linux.intel.com,
        james.clark@arm.com, alexander.antonov@linux.intel.com,
        changbin.du@intel.com, liuqi115@huawei.com, irogers@google.com,
        eranian@google.com, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, clairej735@gmail.com
Subject: Re: [PATCH v2 1/1] Add field checking tests for perf stat JSON
 output.
Message-ID: <YdMOB4tamyCsHs2f@kernel.org>
References: <20210813220936.2105426-1-cjense@google.com>
 <YS6HAvjCxq4kDk5z@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YS6HAvjCxq4kDk5z@krava>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Aug 31, 2021 at 09:46:10PM +0200, Jiri Olsa escreveu:
> On Fri, Aug 13, 2021 at 10:09:37PM +0000, Claire Jensen wrote:
> > Counts number of fields to make sure expected fields are present.
> > 
> > Signed-off-by: Claire Jensen <cjense@google.com>
> > ---
> >  .../tests/shell/lib/perf_json_output_lint.py  |  48 ++++++++
> >  tools/perf/tests/shell/stat+json_output.sh    | 114 ++++++++++++++++++
> >  2 files changed, 162 insertions(+)
> >  create mode 100644 tools/perf/tests/shell/lib/perf_json_output_lint.py
> >  create mode 100644 tools/perf/tests/shell/stat+json_output.sh
> 
> this one needs to have exec priv, right?
> 
> > 
> > diff --git a/tools/perf/tests/shell/lib/perf_json_output_lint.py b/tools/perf/tests/shell/lib/perf_json_output_lint.py
> > new file mode 100644
> > index 000000000000..45d9163e7423
> > --- /dev/null
> 
> SNIP
> 
> > diff --git a/tools/perf/tests/shell/stat+json_output.sh b/tools/perf/tests/shell/stat+json_output.sh
> > new file mode 100644
> > index 000000000000..8a772badae45
> > --- /dev/null
> > +++ b/tools/perf/tests/shell/stat+json_output.sh
> > @@ -0,0 +1,114 @@
> > +#!/bin/bash
> > +# perf stat JSON output linter
> > +# SPDX-License-Identifier: GPL-2.0
> > +# Checks various perf stat JSON output commands for the
> > +# correct number of fields.
> > +
> > +set -e
> > +set -x
> > +
> > +pythonchecker=$(dirname $0)/lib/perf_json_output_lint.py
> > +file="/proc/sys/kernel/perf_event_paranoid"
> > +paranoia=$(cat "$file" | grep -o -E '[0-9]+')
> > +
> > +check_no_args()
> > +{
> > +	perf stat -j sleep 1 2>&1 | \
> 
> hum, is this based on some other change? I don't see -j option in perf stat

Yeah, testing it I stumbled in both problems as reported by Jiri:

⬢[acme@toolbox perf]$ perf test -v linter
Couldn't bump rlimit(MEMLOCK), failures may take place when creating BPF maps, etc
87: perf stat JSON output linter                                    :
--- start ---
test child forked, pid 1826327
sh: line 1: ./tools/perf/tests/shell/stat+json_output.sh: Permission denied
test child finished with -1
---- end ----
perf stat JSON output linter: FAILED!
⬢[acme@toolbox perf]$
⬢[acme@toolbox perf]$ ls -la tools/perf/tests/shell/stat+json_output.sh
-rw-r--r--. 1 acme acme 2113 Jan  3 11:51 tools/perf/tests/shell/stat+json_output.sh
⬢[acme@toolbox perf]$ chmod +x tools/perf/tests/shell/stat+json_output.sh
⬢[acme@toolbox perf]$ perf test -v linter
Couldn't bump rlimit(MEMLOCK), failures may take place when creating BPF maps, etc
87: perf stat JSON output linter                                    :
--- start ---
test child forked, pid 1826350
++ dirname ./tools/perf/tests/shell/stat+json_output.sh
+ pythonchecker=./tools/perf/tests/shell/lib/perf_json_output_lint.py
+ file=/proc/sys/kernel/perf_event_paranoid
++ cat /proc/sys/kernel/perf_event_paranoid
++ grep -o -E '[0-9]+'
+ paranoia=2
+ '[' 2 -gt 0 ']'
+ echo check_all_cpus test skipped because of paranoia level.
check_all_cpus test skipped because of paranoia level.
+ '[' 2 -gt 0 ']'
+ echo check_all_cpus test skipped because of paranoia level.
check_all_cpus test skipped because of paranoia level.
+ '[' 2 -gt 0 ']'
+ echo check_all_cpus test skipped because of paranoia level.
check_all_cpus test skipped because of paranoia level.
+ '[' 2 -gt 0 ']'
+ echo check_per_die test skipped because of paranoia level.
check_per_die test skipped because of paranoia level.
+ '[' 2 -gt 0 ']'
+ echo check_per_node test skipped because of paranoia level.
check_per_node test skipped because of paranoia level.
+ '[' 2 -gt 0 ']'
+ echo check_per_socket test skipped because of paranoia level.
check_per_socket test skipped because of paranoia level.
+ check_no_args
+ perf stat -j sleep 1
+ python ./tools/perf/tests/shell/lib/perf_json_output_lint.py --no-args
  Error: unknown switch `j'

 Usage: perf stat [<options>] [<command>]

    -a, --all-cpus        system-wide collection from all CPUs
    -A, --no-aggr         disable CPU count aggregation
    -B, --big-num         print large numbers with thousands' separators
    -b, --bpf-prog <bpf-prog-id>
                          stat events on existing bpf program id
    -C, --cpu <cpu>       list of cpus to monitor in system-wide
    -D, --delay <n>       ms to wait before starting measurement after program start (-1: start with events disabled)
    -d, --detailed        detailed run - start a lot of events
    -e, --event <event>   event selector. use 'perf list' to list available events
    -G, --cgroup <name>   monitor event in cgroup name only
    -g, --group           put the counters into a counter group
    -I, --interval-print <n>
                          print counts at regular interval in ms (overhead is possible for values <= 100ms)
    -i, --no-inherit      child tasks do not inherit counters
    -M, --metrics <metric/metric group list>
                          monitor specified metrics or metric groups (separated by ,)
    -n, --null            null run - dont start any counters
    -o, --output <file>   output file name
    -p, --pid <pid>       stat events on existing process id
    -r, --repeat <n>      repeat command and print average + stddev (max: 100, forever: 0)
    -S, --sync            call sync() before starting a run
    -t, --tid <tid>       stat events on existing thread id
    -T, --transaction     hardware transaction statistics
    -v, --verbose         be more verbose (show counter open errors, etc)
    -x, --field-separator <separator>
                          print counts with custom separator
        --all-kernel      Configure all used events to run in kernel space.
        --all-user        Configure all used events to run in user space.
        --append          append to the output file
        --bpf-attr-map <attr-map-path>
                          path to perf_event_attr map
        --bpf-counters    use bpf program to count events
        --control <fd:ctl-fd[,ack-fd] or fifo:ctl-fifo[,ack-fifo]>
                          Listen on ctl-fd descriptor for command to control measurement ('enable': enable events, 'disable': disable events).
			  Optionally send control command completion ('ack\n') to ack-fd descriptor.
			  Alternatively, ctl-fifo / ack-fifo will be opened and used as ctl-fd / ack-fd.
        --filter <filter>
                          event filter
        --for-each-cgroup <name>
                          expand events for each cgroup
        --interval-clear  clear screen in between new interval
        --interval-count <n>
                          print counts for fixed number of times
        --iostat[=<default>]
                          measure I/O performance metrics provided by arch/platform
        --log-fd <n>      log output to fd, instead of stderr
        --metric-no-group
                          don't group metric events, impacts multiplexing
        --metric-no-merge
                          don't try to share events between metrics in a group
        --metric-only     Only print computed metrics. No raw values
        --no-csv-summary  don't print 'summary' for CSV summary output
        --no-merge        Do not merge identical named events
        --per-core        aggregate counts per physical processor core
        --per-die         aggregate counts per processor die
        --per-node        aggregate counts per numa node
        --per-socket      aggregate counts per processor socket
        --per-thread      aggregate counts per thread
        --percore-show-thread
                          Use with 'percore' event qualifier to show the event counts of one hardware thread by sum up total hardware threads of same physical core
        --post <command>  command to run after to the measured command
        --pre <command>   command to run prior to the measured command
        --quiet           don't print output (useful with record)
        --scale           Use --no-scale to disable counter scaling for multiplexing
        --smi-cost        measure SMI cost
        --summary         print summary for interval mode
        --table           display details about each run (only with -r option)
        --td-level <n>    Set the metrics level for the top-down statistics (0: max level)
        --timeout <n>     stop workload and print counts after a timeout period in ms (>= 10ms)
        --topdown         measure top-down statistics

Test failed for input:
  Error: unknown switch `j'

 Usage: perf stat [<options>] [<command>]

    -a, --all-cpus        system-wide collection from all CPUs
    -A, --no-aggr         disable CPU count aggregation
    -B, --big-num         print large numbers with thousands' separators
    -b, --bpf-prog <bpf-prog-id>
                          stat events on existing bpf program id
    -C, --cpu <cpu>       list of cpus to monitor in system-wide
    -D, --delay <n>       ms to wait before starting measurement after program start (-1: start with events disabled)
    -d, --detailed        detailed run - start a lot of events
    -e, --event <event>   event selector. use 'perf list' to list available events
    -G, --cgroup <name>   monitor event in cgroup name only
    -g, --group           put the counters into a counter group
    -I, --interval-print <n>
                          print counts at regular interval in ms (overhead is possible for values <= 100ms)
    -i, --no-inherit      child tasks do not inherit counters
    -M, --metrics <metric/metric group list>
                          monitor specified metrics or metric groups (separated by ,)
    -n, --null            null run - dont start any counters
    -o, --output <file>   output file name
    -p, --pid <pid>       stat events on existing process id
    -r, --repeat <n>      repeat command and print average + stddev (max: 100, forever: 0)
    -S, --sync            call sync() before starting a run
    -t, --tid <tid>       stat events on existing thread id
    -T, --transaction     hardware transaction statistics
    -v, --verbose         be more verbose (show counter open errors, etc)
    -x, --field-separator <separator>
                          print counts with custom separator
        --all-kernel      Configure all used events to run in kernel space.
        --all-user        Configure all used events to run in user space.
        --append          append to the output file
        --bpf-attr-map <attr-map-path>
                          path to perf_event_attr map
        --bpf-counters    use bpf program to count events
        --control <fd:ctl-fd[,ack-fd] or fifo:ctl-fifo[,ack-fifo]>
                          Listen on ctl-fd descriptor for command to control measurement ('enable': enable events, 'disable': disable events).
			  Optionally send control command completion ('ack\n') to ack-fd descriptor.
			  Alternatively, ctl-fifo / ack-fifo will be opened and used as ctl-fd / ack-fd.
        --filter <filter>
                          event filter
        --for-each-cgroup <name>
                          expand events for each cgroup
        --interval-clear  clear screen in between new interval
        --interval-count <n>
                          print counts for fixed number of times
        --iostat[=<default>]
                          measure I/O performance metrics provided by arch/platform
        --log-fd <n>      log output to fd, instead of stderr
        --metric-no-group
                          don't group metric events, impacts multiplexing
        --metric-no-merge
                          don't try to share events between metrics in a group
        --metric-only     Only print computed metrics. No raw values
        --no-csv-summary  don't print 'summary' for CSV summary output
        --no-merge        Do not merge identical named events
        --per-core        aggregate counts per physical processor core
        --per-die         aggregate counts per processor die
        --per-node        aggregate counts per numa node
        --per-socket      aggregate counts per processor socket
        --per-thread      aggregate counts per thread
        --percore-show-thread
                          Use with 'percore' event qualifier to show the event counts of one hardware thread by sum up total hardware threads of same physical core
        --post <command>  command to run after to the measured command
        --pre <command>   command to run prior to the measured command
        --quiet           don't print output (useful with record)
        --scale           Use --no-scale to disable counter scaling for multiplexing
        --smi-cost        measure SMI cost
        --summary         print summary for interval mode
        --table           display details about each run (only with -r option)
        --td-level <n>    Set the metrics level for the top-down statistics (0: max level)
        --timeout <n>     stop workload and print counts after a timeout period in ms (>= 10ms)
        --topdown         measure top-down statistics

Traceback (most recent call last):
  File "/var/home/acme/git/perf/./tools/perf/tests/shell/lib/perf_json_output_lint.py", line 40, in <module>
    check_json_output(6)
  File "/var/home/acme/git/perf/./tools/perf/tests/shell/lib/perf_json_output_lint.py", line 34, in check_json_output
    raise RuntimeError('wrong number of fields. counted {0}'
RuntimeError: wrong number of fields. counted 0 expected 6 in   Error: unknown switch `j'


test child finished with -1
---- end ----
perf stat JSON output linter: FAILED!
⬢[acme@toolbox perf]$




