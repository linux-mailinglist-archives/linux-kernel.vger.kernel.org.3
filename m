Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54A8D5A20F8
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 08:39:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245031AbiHZGjC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 02:39:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244807AbiHZGjA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 02:39:00 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86A69D1241
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 23:38:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661495938; x=1693031938;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=EbczJ88fttB5bYh+zGlquRohosXl9qQVRraO8q3zRZc=;
  b=VPV15ueUcOIfkrOZYdbT0hA5/+NwavYuOEcjxphkhTHqbyoXvT9r80RW
   j8slaNhSYymkDoUdPV+P4t5b4NoDwg3oOK8WP0seF4zHmLPnBdIn7B1qi
   UsYdEEsvFB1WH0wxRHZxZefIyg9mDJHuxOTXjfsYLCGQfc3R4kkAA1fJL
   mWe8D02xxC58s28mAM0Ui5nT7tRyMuvL7Jnw3DlqoIf8z/TG/70fqBFwY
   l/8e+l5wVjERgRlRIIJHOJIZ1ZB+PoZ/FpxUPM7rGxV0iKzvrGQU8c+B4
   sZOpFWXjBtcrjox2g7ohzSHCxvujPrTZz2BMudEqcLS0Yty/zyp3PrE35
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10450"; a="320530890"
X-IronPort-AV: E=Sophos;i="5.93,264,1654585200"; 
   d="scan'208";a="320530890"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2022 23:38:49 -0700
X-IronPort-AV: E=Sophos;i="5.93,264,1654585200"; 
   d="scan'208";a="671341537"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.50.209])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2022 23:38:47 -0700
Message-ID: <cf375937-2c7b-b943-c0ab-20365ac2bbfe@intel.com>
Date:   Fri, 26 Aug 2022 09:38:42 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.11.0
Subject: Re: [PATCH 5/5] perf record: Allow multiple recording time ranges
Content-Language: en-US
To:     Ian Rogers <irogers@google.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>,
        linux-kernel@vger.kernel.org
References: <20220824072814.16422-1-adrian.hunter@intel.com>
 <20220824072814.16422-6-adrian.hunter@intel.com>
 <CAP-5=fWwAEgj_X2dKCuZF7MdgnH-V-VEuYdaN8AQAvbAqPY-MA@mail.gmail.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <CAP-5=fWwAEgj_X2dKCuZF7MdgnH-V-VEuYdaN8AQAvbAqPY-MA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/08/22 18:52, Ian Rogers wrote:
> On Wed, Aug 24, 2022 at 12:28 AM Adrian Hunter <adrian.hunter@intel.com> wrote:
>>
>> AUX area traces can produce too much data to record successfully or
>> analyze subsequently. Add another means to reduce data collection by
>> allowing multiple recording time ranges.
>>
>> This is useful, for instance, in cases where a workload produces
>> predictably reproducible events in specific time ranges.
>>
>> Today we only have perf record -D <msecs> to start at a specific region, or
>> some complicated approach using snapshot mode and external scripts sending
>> signals or using the fifos. But these approaches are difficult to set up
>> compared with simply having perf do it.
>>
>> Extend perf record option -D/--delay option to specifying relative time
>> stamps for start stop controlled by perf with the right time offset, for
>> instance:
>>
>>     perf record -e intel_pt// -D 10-20,30-40
>>
>> to record 10ms to 20ms into the trace and 30ms to 40ms.
> 
> Could you add a test like this in:
> https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git/tree/tools/perf/tests/shell/record.sh?h=perf/core
> If for no other reason than code coverage. It would also be
> interesting to see what happens if floating point values are passed,
> ranges are incomplete, etc. As the functionality is generic the event
> could be cycles or instructions rather than intel_pt.

Just checking arguments does not add much value. Really it needs to
get information about what perf is doing. A simple way would be to
add debug messages specifically formatted to give that information.
Then a test could capture them and check they match what is expected.

For example, to test the -D option, print debug messages with
timestamps when events are enabled / disabled, when the workload
starts etc.

Maybe want a new pr_... for such messages like pr_test()
that print at, say, verbose level 3 or 4 (or 5)?  Or a new
"verbose" option just for test messages?

> 
> Thanks,
> Ian
> 
>> Example:
>>
>>  The example workload is:
>>
>>  $ cat repeat-usleep.c
>>
>>  int usleep(useconds_t usec);
>>
>>  int usage(int ret, const char *msg)
>>  {
>>          if (msg)
>>                  fprintf(stderr, "%s\n", msg);
>>
>>          fprintf(stderr, "Usage is: repeat-usleep <microseconds>\n");
>>
>>          return ret;
>>  }
>>
>>  int main(int argc, char *argv[])
>>  {
>>          unsigned long usecs;
>>          char *end_ptr;
>>
>>          if (argc != 2)
>>                  return usage(1, "Error: Wrong number of arguments!");
>>
>>          errno = 0;
>>          usecs = strtoul(argv[1], &end_ptr, 0);
>>          if (errno || *end_ptr || usecs > UINT_MAX)
>>                  return usage(1, "Error: Invalid argument!");
>>
>>          while (1) {
>>                  int ret = usleep(usecs);
>>
>>                  if (ret & errno != EINTR)
>>                          return usage(1, "Error: usleep() failed!");
>>          }
>>
>>          return 0;
>>  }
>>
>>  $ perf record -e intel_pt//u --delay 10-20,40-70,110-160 -- ./repeat-usleep 500
>>  Events disabled
>>  Events enabled
>>  Events disabled
>>  Events enabled
>>  Events disabled
>>  Events enabled
>>  Events disabled
>>  [ perf record: Woken up 5 times to write data ]
>>  [ perf record: Captured and wrote 0.204 MB perf.data ]
>>  Terminated
>>
>>  A dlfilter is used to determine continuous data collection (timestamps
>>  less than 1ms apart):
>>
>>  $ cat dlfilter-show-delays.c
>>
>>  static __u64 start_time;
>>  static __u64 last_time;
>>
>>  int start(void **data, void *ctx)
>>  {
>>          printf("%-17s\t%-9s\t%-6s\n", " Time", " Duration", " Delay");
>>          return 0;
>>  }
>>
>>  int filter_event_early(void *data, const struct perf_dlfilter_sample *sample, void *ctx)
>>  {
>>          __u64 delta;
>>
>>          if (!sample->time)
>>                  return 1;
>>          if (!last_time)
>>                  goto out;
>>          delta = sample->time - last_time;
>>          if (delta < 1000000)
>>                  goto out2;;
>>          printf("%17.9f\t%9.1f\t%6.1f\n", start_time / 1000000000.0, (last_time - start_time) / 1000000.0, delta / 1000000.0);
>>  out:
>>          start_time = sample->time;
>>  out2:
>>          last_time = sample->time;
>>          return 1;
>>  }
>>
>>  int stop(void *data, void *ctx)
>>  {
>>          printf("%17.9f\t%9.1f\n", start_time / 1000000000.0, (last_time - start_time) / 1000000.0);
>>          return 0;
>>  }
>>
>>  The result shows the times roughly match the --delay option:
>>
>>  $ perf script --itrace=qb --dlfilter dlfilter-show-delays.so
>>   Time                    Duration        Delay
>>    39215.302317300             9.7         20.5
>>    39215.332480217            30.4         40.9
>>    39215.403837717            49.8
>>
>> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
>> ---
>>  tools/perf/Documentation/perf-record.txt |   6 +-
>>  tools/perf/builtin-record.c              |  24 ++-
>>  tools/perf/util/evlist.c                 | 234 +++++++++++++++++++++++
>>  tools/perf/util/evlist.h                 |   9 +
>>  4 files changed, 269 insertions(+), 4 deletions(-)
>>
>> diff --git a/tools/perf/Documentation/perf-record.txt b/tools/perf/Documentation/perf-record.txt
>> index 099817ef5150..953b9663522a 100644
>> --- a/tools/perf/Documentation/perf-record.txt
>> +++ b/tools/perf/Documentation/perf-record.txt
>> @@ -430,8 +430,10 @@ if combined with -a or -C options.
>>  -D::
>>  --delay=::
>>  After starting the program, wait msecs before measuring (-1: start with events
>> -disabled). This is useful to filter out the startup phase of the program, which
>> -is often very different.
>> +disabled), or enable events only for specified ranges of msecs (e.g.
>> +-D 10-20,30-40 means wait 10 msecs, enable for 10 msecs, wait 10 msecs, enable
>> +for 10 msecs, then stop). Note, delaying enabling of events is useful to filter
>> +out the startup phase of the program, which is often very different.
>>
>>  -I::
>>  --intr-regs::
>> diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
>> index cefb3028f565..7fdb1dd9a0a8 100644
>> --- a/tools/perf/builtin-record.c
>> +++ b/tools/perf/builtin-record.c
>> @@ -2498,6 +2498,10 @@ static int __cmd_record(struct record *rec, int argc, const char **argv)
>>                 }
>>         }
>>
>> +       err = event_enable_timer__start(rec->evlist->eet);
>> +       if (err)
>> +               goto out_child;
>> +
>>         trigger_ready(&auxtrace_snapshot_trigger);
>>         trigger_ready(&switch_output_trigger);
>>         perf_hooks__invoke_record_start();
>> @@ -2621,6 +2625,14 @@ static int __cmd_record(struct record *rec, int argc, const char **argv)
>>                         }
>>                 }
>>
>> +               err = event_enable_timer__process(rec->evlist->eet);
>> +               if (err < 0)
>> +                       goto out_child;
>> +               if (err) {
>> +                       err = 0;
>> +                       done = 1;
>> +               }
>> +
>>                 /*
>>                  * When perf is starting the traced process, at the end events
>>                  * die with the process and we wait for that. Thus no need to
>> @@ -2842,6 +2854,12 @@ static int perf_record_config(const char *var, const char *value, void *cb)
>>         return 0;
>>  }
>>
>> +static int record__parse_event_enable_time(const struct option *opt, const char *str, int unset)
>> +{
>> +       struct record *rec = (struct record *)opt->value;
>> +
>> +       return evlist__parse_event_enable_time(rec->evlist, &rec->opts, str, unset);
>> +}
>>
>>  static int record__parse_affinity(const struct option *opt, const char *str, int unset)
>>  {
>> @@ -3303,8 +3321,10 @@ static struct option __record_options[] = {
>>         OPT_CALLBACK('G', "cgroup", &record.evlist, "name",
>>                      "monitor event in cgroup name only",
>>                      parse_cgroups),
>> -       OPT_INTEGER('D', "delay", &record.opts.initial_delay,
>> -                 "ms to wait before starting measurement after program start (-1: start with events disabled)"),
>> +       OPT_CALLBACK('D', "delay", &record, "ms",
>> +                    "ms to wait before starting measurement after program start (-1: start with events disabled), "
>> +                    "or ranges of time to enable events e.g. '-D 10-20,30-40'",
>> +                    record__parse_event_enable_time),
>>         OPT_BOOLEAN(0, "kcore", &record.opts.kcore, "copy /proc/kcore"),
>>         OPT_STRING('u', "uid", &record.opts.target.uid_str, "user",
>>                    "user to profile"),
>> diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
>> index 3cfe730c12b8..fcfe5bcc0bcf 100644
>> --- a/tools/perf/util/evlist.c
>> +++ b/tools/perf/util/evlist.c
>> @@ -15,6 +15,7 @@
>>  #include "target.h"
>>  #include "evlist.h"
>>  #include "evsel.h"
>> +#include "record.h"
>>  #include "debug.h"
>>  #include "units.h"
>>  #include "bpf_counter.h"
>> @@ -40,12 +41,14 @@
>>  #include <sys/ioctl.h>
>>  #include <sys/mman.h>
>>  #include <sys/prctl.h>
>> +#include <sys/timerfd.h>
>>
>>  #include <linux/bitops.h>
>>  #include <linux/hash.h>
>>  #include <linux/log2.h>
>>  #include <linux/err.h>
>>  #include <linux/string.h>
>> +#include <linux/time64.h>
>>  #include <linux/zalloc.h>
>>  #include <perf/evlist.h>
>>  #include <perf/evsel.h>
>> @@ -147,6 +150,7 @@ static void evlist__purge(struct evlist *evlist)
>>
>>  void evlist__exit(struct evlist *evlist)
>>  {
>> +       event_enable_timer__exit(&evlist->eet);
>>         zfree(&evlist->mmap);
>>         zfree(&evlist->overwrite_mmap);
>>         perf_evlist__exit(&evlist->core);
>> @@ -2167,6 +2171,236 @@ int evlist__ctlfd_process(struct evlist *evlist, enum evlist_ctl_cmd *cmd)
>>         return err;
>>  }
>>
>> +/**
>> + * struct event_enable_time - perf record -D/--delay single time range.
>> + * @start: start of time range to enable events in milliseconds
>> + * @end: end of time range to enable events in milliseconds
>> + *
>> + * N.B. this structure is also accessed as an array of int.
>> + */
>> +struct event_enable_time {
>> +       int     start;
>> +       int     end;
>> +};
>> +
>> +static int parse_event_enable_time(const char *str, struct event_enable_time *range, bool first)
>> +{
>> +       const char *fmt = first ? "%u - %u %n" : " , %u - %u %n";
>> +       int ret, start, end, n;
>> +
>> +       ret = sscanf(str, fmt, &start, &end, &n);
>> +       if (ret != 2 || end <= start)
>> +               return -EINVAL;
>> +       if (range) {
>> +               range->start = start;
>> +               range->end = end;
>> +       }
>> +       return n;
>> +}
>> +
>> +static ssize_t parse_event_enable_times(const char *str, struct event_enable_time *range)
>> +{
>> +       int incr = !!range;
>> +       bool first = true;
>> +       ssize_t ret, cnt;
>> +
>> +       for (cnt = 0; *str; cnt++) {
>> +               ret = parse_event_enable_time(str, range, first);
>> +               if (ret < 0)
>> +                       return ret;
>> +               /* Check no overlap */
>> +               if (!first && range && range->start <= range[-1].end)
>> +                       return -EINVAL;
>> +               str += ret;
>> +               range += incr;
>> +               first = false;
>> +       }
>> +       return cnt;
>> +}
>> +
>> +/**
>> + * struct event_enable_timer - control structure for perf record -D/--delay.
>> + * @evlist: event list
>> + * @times: time ranges that events are enabled (N.B. this is also accessed as an
>> + *         array of int)
>> + * @times_cnt: number of time ranges
>> + * @timerfd: timer file descriptor
>> + * @pollfd_pos: position in @evlist array of file descriptors to poll (fdarray)
>> + * @times_step: current position in (int *)@times)[],
>> + *              refer event_enable_timer__process()
>> + *
>> + * Note, this structure is only used when there are time ranges, not when there
>> + * is only an initial delay.
>> + */
>> +struct event_enable_timer {
>> +       struct evlist *evlist;
>> +       struct event_enable_time *times;
>> +       size_t  times_cnt;
>> +       int     timerfd;
>> +       int     pollfd_pos;
>> +       size_t  times_step;
>> +};
>> +
>> +static int str_to_delay(const char *str)
>> +{
>> +       char *endptr;
>> +       long d;
>> +
>> +       d = strtol(str, &endptr, 10);
>> +       if (*endptr || d > INT_MAX || d < -1)
>> +               return 0;
>> +       return d;
>> +}
>> +
>> +int evlist__parse_event_enable_time(struct evlist *evlist, struct record_opts *opts,
>> +                                   const char *str, int unset)
>> +{
>> +       enum fdarray_flags flags = fdarray_flag__nonfilterable | fdarray_flag__non_perf_event;
>> +       struct event_enable_timer *eet;
>> +       ssize_t times_cnt;
>> +       ssize_t ret;
>> +       int err;
>> +
>> +       if (unset)
>> +               return 0;
>> +
>> +       opts->initial_delay = str_to_delay(str);
>> +       if (opts->initial_delay)
>> +               return 0;
>> +
>> +       ret = parse_event_enable_times(str, NULL);
>> +       if (ret < 0)
>> +               return ret;
>> +
>> +       times_cnt = ret;
>> +       if (times_cnt == 0)
>> +               return -EINVAL;
>> +
>> +       eet = zalloc(sizeof(*eet));
>> +       if (!eet)
>> +               return -ENOMEM;
>> +
>> +       eet->times = calloc(times_cnt, sizeof(*eet->times));
>> +       if (!eet->times) {
>> +               err = -ENOMEM;
>> +               goto free_eet;
>> +       }
>> +
>> +       if (parse_event_enable_times(str, eet->times) != times_cnt) {
>> +               err = -EINVAL;
>> +               goto free_eet_times;
>> +       }
>> +
>> +       eet->times_cnt = times_cnt;
>> +
>> +       eet->timerfd = timerfd_create(CLOCK_MONOTONIC, TFD_CLOEXEC);
>> +       if (eet->timerfd == -1) {
>> +               err = -errno;
>> +               pr_err("timerfd_create failed: %s\n", strerror(errno));
>> +               goto free_eet_times;
>> +       }
>> +
>> +       eet->pollfd_pos = perf_evlist__add_pollfd(&evlist->core, eet->timerfd, NULL, POLLIN, flags);
>> +       if (eet->pollfd_pos < 0) {
>> +               err = eet->pollfd_pos;
>> +               goto close_timerfd;
>> +       }
>> +
>> +       eet->evlist = evlist;
>> +       evlist->eet = eet;
>> +       opts->initial_delay = eet->times[0].start;
>> +
>> +       return 0;
>> +
>> +close_timerfd:
>> +       close(eet->timerfd);
>> +free_eet_times:
>> +       free(eet->times);
>> +free_eet:
>> +       free(eet);
>> +       return err;
>> +}
>> +
>> +static int event_enable_timer__set_timer(struct event_enable_timer *eet, int ms)
>> +{
>> +       struct itimerspec its = {
>> +               .it_value.tv_sec = ms / MSEC_PER_SEC,
>> +               .it_value.tv_nsec = (ms % MSEC_PER_SEC) * NSEC_PER_MSEC,
>> +       };
>> +       int err = 0;
>> +
>> +       if (timerfd_settime(eet->timerfd, 0, &its, NULL) < 0) {
>> +               err = -errno;
>> +               pr_err("timerfd_settime failed: %s\n", strerror(errno));
>> +       }
>> +       return err;
>> +}
>> +
>> +int event_enable_timer__start(struct event_enable_timer *eet)
>> +{
>> +       int ms;
>> +
>> +       if (!eet)
>> +               return 0;
>> +
>> +       ms = eet->times[0].end - eet->times[0].start;
>> +       eet->times_step = 1;
>> +
>> +       return event_enable_timer__set_timer(eet, ms);
>> +}
>> +
>> +int event_enable_timer__process(struct event_enable_timer *eet)
>> +{
>> +       struct pollfd *entries;
>> +       short revents;
>> +
>> +       if (!eet)
>> +               return 0;
>> +
>> +       entries = eet->evlist->core.pollfd.entries;
>> +       revents = entries[eet->pollfd_pos].revents;
>> +       entries[eet->pollfd_pos].revents = 0;
>> +
>> +       if (revents & POLLIN) {
>> +               size_t step = eet->times_step;
>> +               size_t pos = step / 2;
>> +
>> +               if (step & 1) {
>> +                       evlist__disable_non_dummy(eet->evlist);
>> +                       pr_info(EVLIST_DISABLED_MSG);
>> +                       if (pos >= eet->times_cnt - 1) {
>> +                               /* Disarm timer */
>> +                               event_enable_timer__set_timer(eet, 0);
>> +                               return 1; /* Stop */
>> +                       }
>> +               } else {
>> +                       evlist__enable_non_dummy(eet->evlist);
>> +                       pr_info(EVLIST_ENABLED_MSG);
>> +               }
>> +
>> +               step += 1;
>> +               pos = step / 2;
>> +
>> +               if (pos < eet->times_cnt) {
>> +                       int *times = (int *)eet->times; /* Accessing 'times' as array of int */
>> +                       int ms = times[step] - times[step - 1];
>> +
>> +                       eet->times_step = step;
>> +                       return event_enable_timer__set_timer(eet, ms);
>> +               }
>> +       }
>> +
>> +       return 0;
>> +}
>> +
>> +void event_enable_timer__exit(struct event_enable_timer **ep)
>> +{
>> +       if (!ep || !*ep)
>> +               return;
>> +       free((*ep)->times);
>> +       zfree(ep);
>> +}
>> +
>>  struct evsel *evlist__find_evsel(struct evlist *evlist, int idx)
>>  {
>>         struct evsel *evsel;
>> diff --git a/tools/perf/util/evlist.h b/tools/perf/util/evlist.h
>> index 3a8474406738..9d967fe3953a 100644
>> --- a/tools/perf/util/evlist.h
>> +++ b/tools/perf/util/evlist.h
>> @@ -48,6 +48,8 @@ enum bkw_mmap_state {
>>         BKW_MMAP_EMPTY,
>>  };
>>
>> +struct event_enable_timer;
>> +
>>  struct evlist {
>>         struct perf_evlist core;
>>         bool             enabled;
>> @@ -79,6 +81,7 @@ struct evlist {
>>                 int     ack;    /* ack file descriptor for control commands */
>>                 int     pos;    /* index at evlist core object to check signals */
>>         } ctl_fd;
>> +       struct event_enable_timer *eet;
>>  };
>>
>>  struct evsel_str_handler {
>> @@ -426,6 +429,12 @@ int evlist__ctlfd_ack(struct evlist *evlist);
>>  #define EVLIST_ENABLED_MSG "Events enabled\n"
>>  #define EVLIST_DISABLED_MSG "Events disabled\n"
>>
>> +int evlist__parse_event_enable_time(struct evlist *evlist, struct record_opts *opts,
>> +                                   const char *str, int unset);
>> +int event_enable_timer__start(struct event_enable_timer *eet);
>> +void event_enable_timer__exit(struct event_enable_timer **ep);
>> +int event_enable_timer__process(struct event_enable_timer *eet);
>> +
>>  struct evsel *evlist__find_evsel(struct evlist *evlist, int idx);
>>
>>  int evlist__scnprintf_evsels(struct evlist *evlist, size_t size, char *bf);
>> --
>> 2.25.1
>>

