Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5659154CEE1
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 18:40:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357022AbiFOQkW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 12:40:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356968AbiFOQkV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 12:40:21 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6B214BFC9;
        Wed, 15 Jun 2022 09:40:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655311218; x=1686847218;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=BjbwGyfiVWkLR1WhUi+9nqSYJkareO9XrSNuTScKYW8=;
  b=P4yqcZeh+wCvcWPVh5QeIcr1NmCIhmbk8OC4wD+NZtBqT1wQkG6Nhc3c
   0LCRplkFyxRhE7NBpnFpBx0xdGYMps+Il5KXjmty6K+2QD75ATleI9GKd
   FnJds8ULXHkEjBRvzWFalDIvOSzELnTSr5xgJFdZVMOPjj3qrRxclPXMJ
   57TmSi9NT8Y6oVAj6zcJ4d0cNjWd7mh49Uybi0gG080UoN2TxxytguHvx
   t5mTU0F+PCpwb83aUow0075RK8IQlzGZCzRkesozyPBKncsF4opJUHOZv
   F1uMu7HkrzouP2grjwWUeADHDfUs4oMeAGk2e+i9DOB5wX+SiBD97+IZN
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10379"; a="340682696"
X-IronPort-AV: E=Sophos;i="5.91,302,1647327600"; 
   d="scan'208";a="340682696"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2022 09:40:17 -0700
X-IronPort-AV: E=Sophos;i="5.91,302,1647327600"; 
   d="scan'208";a="641093258"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.32.80])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2022 09:40:09 -0700
Message-ID: <2524d9e0-644a-7a50-c654-36e973778cc2@intel.com>
Date:   Wed, 15 Jun 2022 19:40:03 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.9.1
Subject: Re: [PATCH] perf io: Make open and read calls more robust
Content-Language: en-US
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>,
        Riccardo Mancini <rickyman7@gmail.com>,
        Dave Marchevsky <davemarchevsky@fb.com>,
        Song Liu <songliubraving@fb.com>, Leo Yan <leo.yan@linaro.org>,
        John Garry <john.garry@huawei.com>,
        Florian Fischer <florian.fischer@muhq.space>,
        Andi Kleen <ak@linux.intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Zechuan Chen <chenzechuan1@huawei.com>,
        Yang Jihong <yangjihong1@huawei.com>,
        German Gomez <german.gomez@arm.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        James Clark <james.clark@arm.com>,
        Denis Nikitin <denik@chromium.org>,
        Lexi Shao <shaolexi@huawei.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Remi Bernon <rbernon@codeweavers.com>,
        Fangrui Song <maskray@google.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Stephane Eranian <eranian@google.com>
References: <20220615060354.1763693-1-irogers@google.com>
 <482ed1f6-af6f-b5cd-393f-77d91f24af9d@intel.com>
 <CAP-5=fWp7NifZm4B_xgnPURxsFbdUPnsyfgLaNQeOBSs+v99YQ@mail.gmail.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <CAP-5=fWp7NifZm4B_xgnPURxsFbdUPnsyfgLaNQeOBSs+v99YQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/06/22 18:34, Ian Rogers wrote:
> On Tue, Jun 14, 2022 at 11:51 PM Adrian Hunter <adrian.hunter@intel.com> wrote:
>>
>> On 15/06/22 09:03, Ian Rogers wrote:
>>> Wrap open and read calls with TEMP_FAILURE_RETRY in case a signal
>>> causes the syscall to need to restart.
>>
>> Please expand on why you want this change.  Can you give an example
>> of where it makes a difference?
> 
> As we can get signals pretty much anywhere in the code many syscalls
> are robust to this:
> https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git/tree/tools/perf/builtin-record.c?h=perf/core#n311
> https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git/tree/tools/perf/builtin-record.c?h=perf/core#n372
> https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git/tree/tools/perf/builtin-record.c?h=perf/core#n1585
> https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git/tree/tools/perf/builtin-record.c?h=perf/core#n2502
> https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git/tree/tools/perf/builtin-top.c?h=perf/core#n707
> https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git/tree/tools/perf/util/copyfile.c?h=perf/core#n59
> https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git/tree/tools/perf/util/evlist.c?h=perf/core#n1966
> 
> But as this change shows there are a large number that are not. They
> will get EINTR and turn it into a failure which really isn't one.
> Making an example of this is near impossible as you need to arrange
> the signal delivery very carefully. I am however motivated to do this
> as we're seeing missing events when running perf in fleetwide
> profiling and I wish to discount EINTR as a cause.

Aren't most signals set to Ign or Term? What signals could you be getting?

Is signal() setting SA_RESTART by default?  Does that make a difference?

> 
>> It looks pretty ugly so maybe making replacement functions or macros
>> is better e.g.
>>
>> #define open_retry(a, ...)                                 \
>>     ({ long int __result;                                  \
>>        do __result = (long int) open((a), ##__VA_ARGS__);  \
>>        while (__result == -1L && errno == EINTR);          \
>>        __result; })
> 
> As open is a user land thing there is no Linux precedent to follow
> here. TEMP_FAILURE_RETRY is the general norm, and I'd like to see it
> used when a raw system call is made. ie, if you want open_retry:
> 
> #define open_retry(a, ...) TEMP_FAILURE_RETRY(open((a), ##__VA_ARGS__))
> 
> I don't think we need to be in the game of reinventing
> TEMP_FAILURE_RETRY.

It was only an example.  TEMP_FAILURE_RETRY seemed non-standard,
but I guess if we're defining _GNU_SOURCE anyway it doesn't matter.

> I think we can follow on from this change with
> changes not to use raw open and read calls, instead preferring some of
> our existing EINTR robust reads like readn, etc. Doing that is beyond
> the scope of what this change is trying to do.
> 
> Thanks,
> Ian
> 
>>>
>>> Signed-off-by: Ian Rogers <irogers@google.com>
>>> ---
>>>  tools/lib/api/io.h                       |  3 ++-
>>>  tools/lib/symbol/kallsyms.c              |  4 ++-
>>>  tools/perf/builtin-daemon.c              | 19 +++++++-------
>>>  tools/perf/builtin-ftrace.c              | 18 ++++++-------
>>>  tools/perf/builtin-inject.c              |  2 +-
>>>  tools/perf/builtin-kvm.c                 |  2 +-
>>>  tools/perf/builtin-record.c              |  6 ++---
>>>  tools/perf/builtin-sched.c               |  2 +-
>>>  tools/perf/builtin-script.c              |  2 +-
>>>  tools/perf/util/copyfile.c               |  2 +-
>>>  tools/perf/util/data.c                   | 11 ++++----
>>>  tools/perf/util/dso.c                    |  6 ++---
>>>  tools/perf/util/evlist.c                 |  6 ++---
>>>  tools/perf/util/lzma.c                   |  4 +--
>>>  tools/perf/util/namespaces.c             |  5 ++--
>>>  tools/perf/util/parse-events.c           |  6 ++---
>>>  tools/perf/util/pmu.c                    | 12 ++++-----
>>>  tools/perf/util/probe-event.c            |  4 +--
>>>  tools/perf/util/probe-file.c             | 10 ++++----
>>>  tools/perf/util/session.c                |  2 +-
>>>  tools/perf/util/symbol-elf.c             | 32 ++++++++++++------------
>>>  tools/perf/util/symbol-minimal.c         |  6 ++---
>>>  tools/perf/util/symbol.c                 |  4 +--
>>>  tools/perf/util/synthetic-events.c       |  7 +++---
>>>  tools/perf/util/trace-event-info.c       |  6 ++---
>>>  tools/perf/util/trace-event-read.c       |  5 ++--
>>>  tools/perf/util/unwind-libunwind-local.c |  4 +--
>>>  tools/perf/util/zlib.c                   |  5 ++--
>>>  28 files changed, 102 insertions(+), 93 deletions(-)
>>>
>>> diff --git a/tools/lib/api/io.h b/tools/lib/api/io.h
>>> index 777c20f6b604..b292bbd39fb0 100644
>>> --- a/tools/lib/api/io.h
>>> +++ b/tools/lib/api/io.h
>>> @@ -7,6 +7,7 @@
>>>  #ifndef __API_IO__
>>>  #define __API_IO__
>>>
>>> +#include <errno.h>
>>>  #include <stdlib.h>
>>>  #include <unistd.h>
>>>
>>> @@ -45,7 +46,7 @@ static inline int io__get_char(struct io *io)
>>>               return -1;
>>>
>>>       if (ptr == io->end) {
>>> -             ssize_t n = read(io->fd, io->buf, io->buf_len);
>>> +             ssize_t n = TEMP_FAILURE_RETRY(read(io->fd, io->buf, io->buf_len));
>>>
>>>               if (n <= 0) {
>>>                       io->eof = true;
>>> diff --git a/tools/lib/symbol/kallsyms.c b/tools/lib/symbol/kallsyms.c
>>> index e335ac2b9e19..5436c038c379 100644
>>> --- a/tools/lib/symbol/kallsyms.c
>>> +++ b/tools/lib/symbol/kallsyms.c
>>> @@ -3,7 +3,9 @@
>>>  #include "api/io.h"
>>>  #include <stdio.h>
>>>  #include <sys/stat.h>
>>> +#include <errno.h>
>>>  #include <fcntl.h>
>>> +#include <unistd.h>
>>>
>>>  u8 kallsyms2elf_type(char type)
>>>  {
>>> @@ -36,7 +38,7 @@ int kallsyms__parse(const char *filename, void *arg,
>>>       char bf[BUFSIZ];
>>>       int err;
>>>
>>> -     io.fd = open(filename, O_RDONLY, 0);
>>> +     io.fd = TEMP_FAILURE_RETRY(open(filename, O_RDONLY, 0));
>>>
>>>       if (io.fd < 0)
>>>               return -1;
>>> diff --git a/tools/perf/builtin-daemon.c b/tools/perf/builtin-daemon.c
>>> index 6cb3f6cc36d0..d4e1a5636056 100644
>>> --- a/tools/perf/builtin-daemon.c
>>> +++ b/tools/perf/builtin-daemon.c
>>> @@ -351,7 +351,7 @@ static int daemon_session__run(struct daemon_session *session,
>>>               return -1;
>>>       }
>>>
>>> -     fd = open("/dev/null", O_RDONLY);
>>> +     fd = TEMP_FAILURE_RETRY(open("/dev/null", O_RDONLY));
>>>       if (fd < 0) {
>>>               perror("failed: open /dev/null");
>>>               return -1;
>>> @@ -360,7 +360,7 @@ static int daemon_session__run(struct daemon_session *session,
>>>       dup2(fd, 0);
>>>       close(fd);
>>>
>>> -     fd = open(SESSION_OUTPUT, O_RDWR|O_CREAT|O_TRUNC, 0644);
>>> +     fd = TEMP_FAILURE_RETRY(open(SESSION_OUTPUT, O_RDWR|O_CREAT|O_TRUNC, 0644));
>>>       if (fd < 0) {
>>>               perror("failed: open session output");
>>>               return -1;
>>> @@ -405,7 +405,8 @@ static pid_t handle_signalfd(struct daemon *daemon)
>>>        * coalesced in kernel and we can receive only single signal even
>>>        * if multiple SIGCHLD were generated.
>>>        */
>>> -     err = read(daemon->signal_fd, &si, sizeof(struct signalfd_siginfo));
>>> +     err = TEMP_FAILURE_RETRY(read(daemon->signal_fd, &si,
>>> +                                   sizeof(struct signalfd_siginfo)));
>>>       if (err != sizeof(struct signalfd_siginfo)) {
>>>               pr_err("failed to read signal fd\n");
>>>               return -1;
>>> @@ -522,7 +523,7 @@ static int daemon_session__control(struct daemon_session *session,
>>>       scnprintf(control_path, sizeof(control_path), "%s/%s",
>>>                 session->base, SESSION_CONTROL);
>>>
>>> -     control = open(control_path, O_WRONLY|O_NONBLOCK);
>>> +     control = TEMP_FAILURE_RETRY(open(control_path, O_WRONLY|O_NONBLOCK));
>>>       if (!control)
>>>               return -1;
>>>
>>> @@ -531,7 +532,7 @@ static int daemon_session__control(struct daemon_session *session,
>>>               scnprintf(ack_path, sizeof(ack_path), "%s/%s",
>>>                         session->base, SESSION_ACK);
>>>
>>> -             ack = open(ack_path, O_RDONLY, O_NONBLOCK);
>>> +             ack = TEMP_FAILURE_RETRY(open(ack_path, O_RDONLY, O_NONBLOCK));
>>>               if (!ack) {
>>>                       close(control);
>>>                       return -1;
>>> @@ -564,7 +565,7 @@ static int daemon_session__control(struct daemon_session *session,
>>>               goto out;
>>>       }
>>>
>>> -     err = read(ack, buf, sizeof(buf));
>>> +     err = TEMP_FAILURE_RETRY(read(ack, buf, sizeof(buf)));
>>>       if (err > 0)
>>>               ret = strcmp(buf, "ack\n");
>>>       else
>>> @@ -1078,7 +1079,7 @@ static int handle_config_changes(struct daemon *daemon, int conf_fd,
>>>       ssize_t len;
>>>
>>>       while (!(*config_changed)) {
>>> -             len = read(conf_fd, buf, sizeof(buf));
>>> +             len = TEMP_FAILURE_RETRY(read(conf_fd, buf, sizeof(buf)));
>>>               if (len == -1) {
>>>                       if (errno != EAGAIN) {
>>>                               perror("failed: read");
>>> @@ -1147,7 +1148,7 @@ static int check_lock(struct daemon *daemon)
>>>
>>>       scnprintf(path, sizeof(path), "%s/lock", daemon->base);
>>>
>>> -     fd = open(path, O_RDWR|O_CREAT|O_CLOEXEC, 0640);
>>> +     fd = TEMP_FAILURE_RETRY(open(path, O_RDWR|O_CREAT|O_CLOEXEC, 0640));
>>>       if (fd < 0)
>>>               return -1;
>>>
>>> @@ -1201,7 +1202,7 @@ static int go_background(struct daemon *daemon)
>>>               return -1;
>>>       }
>>>
>>> -     fd = open("output", O_RDWR|O_CREAT|O_TRUNC, 0644);
>>> +     fd = TEMP_FAILURE_RETRY(open("output", O_RDWR|O_CREAT|O_TRUNC, 0644));
>>>       if (fd < 0) {
>>>               perror("failed: open");
>>>               return -1;
>>> diff --git a/tools/perf/builtin-ftrace.c b/tools/perf/builtin-ftrace.c
>>> index 7de07bb16d23..7553e20f38b2 100644
>>> --- a/tools/perf/builtin-ftrace.c
>>> +++ b/tools/perf/builtin-ftrace.c
>>> @@ -79,7 +79,7 @@ static int __write_tracing_file(const char *name, const char *val, bool append)
>>>       else
>>>               flags |= O_TRUNC;
>>>
>>> -     fd = open(file, flags);
>>> +     fd = TEMP_FAILURE_RETRY(open(file, flags));
>>>       if (fd < 0) {
>>>               pr_debug("cannot open tracing file: %s: %s\n",
>>>                        name, str_error_r(errno, errbuf, sizeof(errbuf)));
>>> @@ -132,7 +132,7 @@ static int read_tracing_file_to_stdout(const char *name)
>>>               return -1;
>>>       }
>>>
>>> -     fd = open(file, O_RDONLY);
>>> +     fd = TEMP_FAILURE_RETRY(open(file, O_RDONLY));
>>>       if (fd < 0) {
>>>               pr_debug("cannot open tracing file: %s: %s\n",
>>>                        name, str_error_r(errno, buf, sizeof(buf)));
>>> @@ -141,7 +141,7 @@ static int read_tracing_file_to_stdout(const char *name)
>>>
>>>       /* read contents to stdout */
>>>       while (true) {
>>> -             int n = read(fd, buf, sizeof(buf));
>>> +             int n = TEMP_FAILURE_RETRY(read(fd, buf, sizeof(buf)));
>>>               if (n == 0)
>>>                       break;
>>>               else if (n < 0)
>>> @@ -608,7 +608,7 @@ static int __cmd_ftrace(struct perf_ftrace *ftrace)
>>>               goto out_reset;
>>>       }
>>>
>>> -     trace_fd = open(trace_file, O_RDONLY);
>>> +     trace_fd = TEMP_FAILURE_RETRY(open(trace_file, O_RDONLY));
>>>
>>>       put_tracing_file(trace_file);
>>>
>>> @@ -645,7 +645,7 @@ static int __cmd_ftrace(struct perf_ftrace *ftrace)
>>>                       break;
>>>
>>>               if (pollfd.revents & POLLIN) {
>>> -                     int n = read(trace_fd, buf, sizeof(buf));
>>> +                     int n = TEMP_FAILURE_RETRY(read(trace_fd, buf, sizeof(buf)));
>>>                       if (n < 0)
>>>                               break;
>>>                       if (fwrite(buf, n, 1, stdout) != 1)
>>> @@ -665,7 +665,7 @@ static int __cmd_ftrace(struct perf_ftrace *ftrace)
>>>
>>>       /* read remaining buffer contents */
>>>       while (true) {
>>> -             int n = read(trace_fd, buf, sizeof(buf));
>>> +             int n = TEMP_FAILURE_RETRY(read(trace_fd, buf, sizeof(buf)));
>>>               if (n <= 0)
>>>                       break;
>>>               if (fwrite(buf, n, 1, stdout) != 1)
>>> @@ -826,7 +826,7 @@ static int prepare_func_latency(struct perf_ftrace *ftrace)
>>>               return -1;
>>>       }
>>>
>>> -     fd = open(trace_file, O_RDONLY);
>>> +     fd = TEMP_FAILURE_RETRY(open(trace_file, O_RDONLY));
>>>       if (fd < 0)
>>>               pr_err("failed to open trace_pipe\n");
>>>
>>> @@ -913,7 +913,7 @@ static int __cmd_latency(struct perf_ftrace *ftrace)
>>>                       break;
>>>
>>>               if (pollfd.revents & POLLIN) {
>>> -                     int n = read(trace_fd, buf, sizeof(buf) - 1);
>>> +                     int n = TEMP_FAILURE_RETRY(read(trace_fd, buf, sizeof(buf) - 1));
>>>                       if (n < 0)
>>>                               break;
>>>
>>> @@ -931,7 +931,7 @@ static int __cmd_latency(struct perf_ftrace *ftrace)
>>>
>>>       /* read remaining buffer contents */
>>>       while (!ftrace->target.use_bpf) {
>>> -             int n = read(trace_fd, buf, sizeof(buf) - 1);
>>> +             int n = TEMP_FAILURE_RETRY(read(trace_fd, buf, sizeof(buf) - 1));
>>>               if (n <= 0)
>>>                       break;
>>>               make_histogram(buckets, buf, n, line, ftrace->use_nsec);
>>> diff --git a/tools/perf/builtin-inject.c b/tools/perf/builtin-inject.c
>>> index a75bf11585b5..960b4a50583e 100644
>>> --- a/tools/perf/builtin-inject.c
>>> +++ b/tools/perf/builtin-inject.c
>>> @@ -155,7 +155,7 @@ static int copy_bytes(struct perf_inject *inject, int fd, off_t size)
>>>       int ret;
>>>
>>>       while (size > 0) {
>>> -             ssz = read(fd, buf, min(size, (off_t)sizeof(buf)));
>>> +             ssz = TEMP_FAILURE_RETRY(read(fd, buf, min(size, (off_t)sizeof(buf))));
>>>               if (ssz < 0)
>>>                       return -errno;
>>>               ret = output_bytes(inject, buf, ssz);
>>> diff --git a/tools/perf/builtin-kvm.c b/tools/perf/builtin-kvm.c
>>> index 3696ae97f149..4dd8292d1941 100644
>>> --- a/tools/perf/builtin-kvm.c
>>> +++ b/tools/perf/builtin-kvm.c
>>> @@ -880,7 +880,7 @@ static int perf_kvm__handle_timerfd(struct perf_kvm_stat *kvm)
>>>       uint64_t c;
>>>       int rc;
>>>
>>> -     rc = read(kvm->timerfd, &c, sizeof(uint64_t));
>>> +     rc = TEMP_FAILURE_RETRY(read(kvm->timerfd, &c, sizeof(uint64_t)));
>>>       if (rc < 0) {
>>>               if (errno == EAGAIN)
>>>                       return 0;
>>> diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
>>> index 9a71f0330137..361610bc96b6 100644
>>> --- a/tools/perf/builtin-record.c
>>> +++ b/tools/perf/builtin-record.c
>>> @@ -902,7 +902,7 @@ static bool record__kcore_readable(struct machine *machine)
>>>
>>>       scnprintf(kcore, sizeof(kcore), "%s/proc/kcore", machine->root_dir);
>>>
>>> -     fd = open(kcore, O_RDONLY);
>>> +     fd = TEMP_FAILURE_RETRY(open(kcore, O_RDONLY));
>>>       if (fd < 0)
>>>               return false;
>>>
>>> @@ -2049,7 +2049,7 @@ static int record__terminate_thread(struct record_thread *thread_data)
>>>
>>>       close(thread_data->pipes.msg[1]);
>>>       thread_data->pipes.msg[1] = -1;
>>> -     err = read(thread_data->pipes.ack[0], &ack, sizeof(ack));
>>> +     err = TEMP_FAILURE_RETRY(read(thread_data->pipes.ack[0], &ack, sizeof(ack)));
>>>       if (err > 0)
>>>               pr_debug2("threads[%d]: sent %s\n", tid, thread_msg_tags[ack]);
>>>       else
>>> @@ -2097,7 +2097,7 @@ static int record__start_threads(struct record *rec)
>>>                       goto out_err;
>>>               }
>>>
>>> -             err = read(thread_data[t].pipes.ack[0], &msg, sizeof(msg));
>>> +             err = TEMP_FAILURE_RETRY(read(thread_data[t].pipes.ack[0], &msg, sizeof(msg)));
>>>               if (err > 0)
>>>                       pr_debug2("threads[%d]: sent %s\n", rec->thread_data[t].tid,
>>>                                 thread_msg_tags[msg]);
>>> diff --git a/tools/perf/builtin-sched.c b/tools/perf/builtin-sched.c
>>> index 646bd938927a..149787268d02 100644
>>> --- a/tools/perf/builtin-sched.c
>>> +++ b/tools/perf/builtin-sched.c
>>> @@ -604,7 +604,7 @@ static u64 get_cpu_usage_nsec_self(int fd)
>>>       u64 runtime;
>>>       int ret;
>>>
>>> -     ret = read(fd, &runtime, sizeof(runtime));
>>> +     ret = TEMP_FAILURE_RETRY(read(fd, &runtime, sizeof(runtime)));
>>>       BUG_ON(ret != sizeof(runtime));
>>>
>>>       return runtime;
>>> diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
>>> index c689054002cc..844f5350bfdf 100644
>>> --- a/tools/perf/builtin-script.c
>>> +++ b/tools/perf/builtin-script.c
>>> @@ -4207,7 +4207,7 @@ int cmd_script(int argc, const char **argv)
>>>                       goto out_delete;
>>>               }
>>>
>>> -             input = open(data.path, O_RDONLY);      /* input_name */
>>> +             input = TEMP_FAILURE_RETRY(open(data.path, O_RDONLY));  /* input_name */
>>>               if (input < 0) {
>>>                       err = -errno;
>>>                       perror("failed to open file");
>>> diff --git a/tools/perf/util/copyfile.c b/tools/perf/util/copyfile.c
>>> index 47e03de7c235..c7bff4943936 100644
>>> --- a/tools/perf/util/copyfile.c
>>> +++ b/tools/perf/util/copyfile.c
>>> @@ -112,7 +112,7 @@ static int copyfile_mode_ns(const char *from, const char *to, mode_t mode,
>>>               goto out_close_to;
>>>
>>>       nsinfo__mountns_enter(nsi, &nsc);
>>> -     fromfd = open(from, O_RDONLY);
>>> +     fromfd = TEMP_FAILURE_RETRY(open(from, O_RDONLY));
>>>       nsinfo__mountns_exit(&nsc);
>>>       if (fromfd < 0)
>>>               goto out_close_to;
>>> diff --git a/tools/perf/util/data.c b/tools/perf/util/data.c
>>> index caabeac24c69..a9066a3d914f 100644
>>> --- a/tools/perf/util/data.c
>>> +++ b/tools/perf/util/data.c
>>> @@ -53,7 +53,8 @@ int perf_data__create_dir(struct perf_data *data, int nr)
>>>                       goto out_err;
>>>               }
>>>
>>> -             ret = open(file->path, O_RDWR|O_CREAT|O_TRUNC, S_IRUSR|S_IWUSR);
>>> +             ret = TEMP_FAILURE_RETRY(open(file->path, O_RDWR|O_CREAT|O_TRUNC,
>>> +                                           S_IRUSR|S_IWUSR));
>>>               if (ret < 0) {
>>>                       ret = -errno;
>>>                       goto out_err;
>>> @@ -123,7 +124,7 @@ int perf_data__open_dir(struct perf_data *data)
>>>               if (!file->path)
>>>                       goto out_err;
>>>
>>> -             ret = open(file->path, O_RDONLY);
>>> +             ret = TEMP_FAILURE_RETRY(open(file->path, O_RDONLY));
>>>               if (ret < 0)
>>>                       goto out_err;
>>>
>>> @@ -248,7 +249,7 @@ static int open_file_read(struct perf_data *data)
>>>       int fd;
>>>       char sbuf[STRERR_BUFSIZE];
>>>
>>> -     fd = open(data->file.path, flags);
>>> +     fd = TEMP_FAILURE_RETRY(open(data->file.path, flags));
>>>       if (fd < 0) {
>>>               int err = errno;
>>>
>>> @@ -288,8 +289,8 @@ static int open_file_write(struct perf_data *data)
>>>       int fd;
>>>       char sbuf[STRERR_BUFSIZE];
>>>
>>> -     fd = open(data->file.path, O_CREAT|O_RDWR|O_TRUNC|O_CLOEXEC,
>>> -               S_IRUSR|S_IWUSR);
>>> +     fd = TEMP_FAILURE_RETRY(open(data->file.path, O_CREAT|O_RDWR|O_TRUNC|O_CLOEXEC,
>>> +                                  S_IRUSR|S_IWUSR));
>>>
>>>       if (fd < 0)
>>>               pr_err("failed to open %s : %s\n", data->file.path,
>>> diff --git a/tools/perf/util/dso.c b/tools/perf/util/dso.c
>>> index 5ac13958d1bd..40befa2429f9 100644
>>> --- a/tools/perf/util/dso.c
>>> +++ b/tools/perf/util/dso.c
>>> @@ -300,7 +300,7 @@ int filename__decompress(const char *name, char *pathname,
>>>        * descriptor to the uncompressed file.
>>>        */
>>>       if (!compressions[comp].is_compressed(name))
>>> -             return open(name, O_RDONLY);
>>> +             return TEMP_FAILURE_RETRY(open(name, O_RDONLY));
>>>
>>>       fd = mkstemp(tmpbuf);
>>>       if (fd < 0) {
>>> @@ -476,7 +476,7 @@ static int do_open(char *name)
>>>       char sbuf[STRERR_BUFSIZE];
>>>
>>>       do {
>>> -             fd = open(name, O_RDONLY|O_CLOEXEC);
>>> +             fd = TEMP_FAILURE_RETRY(open(name, O_RDONLY|O_CLOEXEC));
>>>               if (fd >= 0)
>>>                       return fd;
>>>
>>> @@ -898,7 +898,7 @@ static ssize_t file_read(struct dso *dso, struct machine *machine,
>>>               goto out;
>>>       }
>>>
>>> -     ret = pread(dso->data.fd, data, DSO__DATA_CACHE_SIZE, offset);
>>> +     ret = TEMP_FAILURE_RETRY(pread(dso->data.fd, data, DSO__DATA_CACHE_SIZE, offset));
>>>  out:
>>>       pthread_mutex_unlock(&dso__data_open_lock);
>>>       return ret;
>>> diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
>>> index 48af7d379d82..ba0dcdf91120 100644
>>> --- a/tools/perf/util/evlist.c
>>> +++ b/tools/perf/util/evlist.c
>>> @@ -1440,7 +1440,7 @@ int evlist__prepare_workload(struct evlist *evlist, struct target *target, const
>>>               /*
>>>                * Wait until the parent tells us to go.
>>>                */
>>> -             ret = read(go_pipe[0], &bf, 1);
>>> +             ret = TEMP_FAILURE_RETRY(read(go_pipe[0], &bf, 1));
>>>               /*
>>>                * The parent will ask for the execvp() to be performed by
>>>                * writing exactly one byte, in workload.cork_fd, usually via
>>> @@ -1837,7 +1837,7 @@ static int evlist__parse_control_fifo(const char *str, int *ctl_fd, int *ctl_fd_
>>>        * O_RDWR avoids POLLHUPs which is necessary to allow the other
>>>        * end of a FIFO to be repeatedly opened and closed.
>>>        */
>>> -     fd = open(s, O_RDWR | O_NONBLOCK | O_CLOEXEC);
>>> +     fd = TEMP_FAILURE_RETRY(open(s, O_RDWR | O_NONBLOCK | O_CLOEXEC));
>>>       if (fd < 0) {
>>>               pr_err("Failed to open '%s'\n", s);
>>>               ret = -errno;
>>> @@ -1848,7 +1848,7 @@ static int evlist__parse_control_fifo(const char *str, int *ctl_fd, int *ctl_fd_
>>>
>>>       if (p && *++p) {
>>>               /* O_RDWR | O_NONBLOCK means the other end need not be open */
>>> -             fd = open(p, O_RDWR | O_NONBLOCK | O_CLOEXEC);
>>> +             fd = TEMP_FAILURE_RETRY(open(p, O_RDWR | O_NONBLOCK | O_CLOEXEC));
>>>               if (fd < 0) {
>>>                       pr_err("Failed to open '%s'\n", p);
>>>                       ret = -errno;
>>> diff --git a/tools/perf/util/lzma.c b/tools/perf/util/lzma.c
>>> index 51424cdc3b68..93e0a6a53e28 100644
>>> --- a/tools/perf/util/lzma.c
>>> +++ b/tools/perf/util/lzma.c
>>> @@ -109,7 +109,7 @@ int lzma_decompress_to_file(const char *input, int output_fd)
>>>
>>>  bool lzma_is_compressed(const char *input)
>>>  {
>>> -     int fd = open(input, O_RDONLY);
>>> +     int fd = TEMP_FAILURE_RETRY(open(input, O_RDONLY));
>>>       const uint8_t magic[6] = { 0xFD, '7', 'z', 'X', 'Z', 0x00 };
>>>       char buf[6] = { 0 };
>>>       ssize_t rc;
>>> @@ -117,7 +117,7 @@ bool lzma_is_compressed(const char *input)
>>>       if (fd < 0)
>>>               return -1;
>>>
>>> -     rc = read(fd, buf, sizeof(buf));
>>> +     rc = TEMP_FAILURE_RETRY(read(fd, buf, sizeof(buf)));
>>>       close(fd);
>>>       return rc == sizeof(buf) ?
>>>              memcmp(buf, magic, sizeof(buf)) == 0 : false;
>>> diff --git a/tools/perf/util/namespaces.c b/tools/perf/util/namespaces.c
>>> index dd536220cdb9..89edfba6af06 100644
>>> --- a/tools/perf/util/namespaces.c
>>> +++ b/tools/perf/util/namespaces.c
>>> @@ -9,6 +9,7 @@
>>>  #include "get_current_dir_name.h"
>>>  #include <sys/types.h>
>>>  #include <sys/stat.h>
>>> +#include <errno.h>
>>>  #include <fcntl.h>
>>>  #include <limits.h>
>>>  #include <sched.h>
>>> @@ -266,11 +267,11 @@ void nsinfo__mountns_enter(struct nsinfo *nsi,
>>>       if (!oldcwd)
>>>               return;
>>>
>>> -     oldns = open(curpath, O_RDONLY);
>>> +     oldns = TEMP_FAILURE_RETRY(open(curpath, O_RDONLY));
>>>       if (oldns < 0)
>>>               goto errout;
>>>
>>> -     newns = open(nsi->mntns_path, O_RDONLY);
>>> +     newns = TEMP_FAILURE_RETRY(open(nsi->mntns_path, O_RDONLY));
>>>       if (newns < 0)
>>>               goto errout;
>>>
>>> diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
>>> index 7ed235740431..75f8f2e44195 100644
>>> --- a/tools/perf/util/parse-events.c
>>> +++ b/tools/perf/util/parse-events.c
>>> @@ -189,7 +189,7 @@ static int tp_event_has_id(const char *dir_path, struct dirent *evt_dir)
>>>       int fd;
>>>
>>>       snprintf(evt_path, MAXPATHLEN, "%s/%s/id", dir_path, evt_dir->d_name);
>>> -     fd = open(evt_path, O_RDONLY);
>>> +     fd = TEMP_FAILURE_RETRY(open(evt_path, O_RDONLY));
>>>       if (fd < 0)
>>>               return -EINVAL;
>>>       close(fd);
>>> @@ -233,10 +233,10 @@ struct tracepoint_path *tracepoint_id_to_path(u64 config)
>>>
>>>                       scnprintf(evt_path, MAXPATHLEN, "%s/%s/id", dir_path,
>>>                                 evt_dirent->d_name);
>>> -                     fd = open(evt_path, O_RDONLY);
>>> +                     fd = TEMP_FAILURE_RETRY(open(evt_path, O_RDONLY));
>>>                       if (fd < 0)
>>>                               continue;
>>> -                     if (read(fd, id_buf, sizeof(id_buf)) < 0) {
>>> +                     if (TEMP_FAILURE_RETRY(read(fd, id_buf, sizeof(id_buf))) < 0) {
>>>                               close(fd);
>>>                               continue;
>>>                       }
>>> diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
>>> index 9a1c7e63e663..59252cfc2b5b 100644
>>> --- a/tools/perf/util/pmu.c
>>> +++ b/tools/perf/util/pmu.c
>>> @@ -154,14 +154,14 @@ static int perf_pmu__parse_scale(struct perf_pmu_alias *alias, char *dir, char *
>>>
>>>       scnprintf(path, PATH_MAX, "%s/%s.scale", dir, name);
>>>
>>> -     fd = open(path, O_RDONLY);
>>> +     fd = TEMP_FAILURE_RETRY(open(path, O_RDONLY));
>>>       if (fd == -1)
>>>               return -1;
>>>
>>>       if (fstat(fd, &st) < 0)
>>>               goto error;
>>>
>>> -     sret = read(fd, scale, sizeof(scale)-1);
>>> +     sret = TEMP_FAILURE_RETRY(read(fd, scale, sizeof(scale)-1));
>>>       if (sret < 0)
>>>               goto error;
>>>
>>> @@ -184,11 +184,11 @@ static int perf_pmu__parse_unit(struct perf_pmu_alias *alias, char *dir, char *n
>>>
>>>       scnprintf(path, PATH_MAX, "%s/%s.unit", dir, name);
>>>
>>> -     fd = open(path, O_RDONLY);
>>> +     fd = TEMP_FAILURE_RETRY(open(path, O_RDONLY));
>>>       if (fd == -1)
>>>               return -1;
>>>
>>> -     sret = read(fd, alias->unit, UNIT_MAX_LEN);
>>> +     sret = TEMP_FAILURE_RETRY(read(fd, alias->unit, UNIT_MAX_LEN));
>>>       if (sret < 0)
>>>               goto error;
>>>
>>> @@ -214,7 +214,7 @@ perf_pmu__parse_per_pkg(struct perf_pmu_alias *alias, char *dir, char *name)
>>>
>>>       scnprintf(path, PATH_MAX, "%s/%s.per-pkg", dir, name);
>>>
>>> -     fd = open(path, O_RDONLY);
>>> +     fd = TEMP_FAILURE_RETRY(open(path, O_RDONLY));
>>>       if (fd == -1)
>>>               return -1;
>>>
>>> @@ -232,7 +232,7 @@ static int perf_pmu__parse_snapshot(struct perf_pmu_alias *alias,
>>>
>>>       scnprintf(path, PATH_MAX, "%s/%s.snapshot", dir, name);
>>>
>>> -     fd = open(path, O_RDONLY);
>>> +     fd = TEMP_FAILURE_RETRY(open(path, O_RDONLY));
>>>       if (fd == -1)
>>>               return -1;
>>>
>>> diff --git a/tools/perf/util/probe-event.c b/tools/perf/util/probe-event.c
>>> index 062b5cbe67af..7838889f55df 100644
>>> --- a/tools/perf/util/probe-event.c
>>> +++ b/tools/perf/util/probe-event.c
>>> @@ -276,7 +276,7 @@ static char *find_module_name(const char *module)
>>>       char *mod_name = NULL;
>>>       int name_offset;
>>>
>>> -     fd = open(module, O_RDONLY);
>>> +     fd = TEMP_FAILURE_RETRY(open(module, O_RDONLY));
>>>       if (fd < 0)
>>>               return NULL;
>>>
>>> @@ -598,7 +598,7 @@ static int get_text_start_address(const char *exec, u64 *address,
>>>       struct nscookie nsc;
>>>
>>>       nsinfo__mountns_enter(nsi, &nsc);
>>> -     fd = open(exec, O_RDONLY);
>>> +     fd = TEMP_FAILURE_RETRY(open(exec, O_RDONLY));
>>>       nsinfo__mountns_exit(&nsc);
>>>       if (fd < 0)
>>>               return -errno;
>>> diff --git a/tools/perf/util/probe-file.c b/tools/perf/util/probe-file.c
>>> index 3d50de3217d5..b788932656e8 100644
>>> --- a/tools/perf/util/probe-file.c
>>> +++ b/tools/perf/util/probe-file.c
>>> @@ -115,9 +115,9 @@ int open_trace_file(const char *trace_file, bool readwrite)
>>>       if (ret >= 0) {
>>>               pr_debug("Opening %s write=%d\n", buf, readwrite);
>>>               if (readwrite && !probe_event_dry_run)
>>> -                     ret = open(buf, O_RDWR | O_APPEND, 0);
>>> +                     ret = TEMP_FAILURE_RETRY(open(buf, O_RDWR | O_APPEND, 0));
>>>               else
>>> -                     ret = open(buf, O_RDONLY, 0);
>>> +                     ret = TEMP_FAILURE_RETRY(open(buf, O_RDONLY, 0));
>>>
>>>               if (ret < 0)
>>>                       ret = -errno;
>>> @@ -180,7 +180,7 @@ struct strlist *probe_file__get_rawlist(int fd)
>>>       if (sl == NULL)
>>>               return NULL;
>>>
>>> -     fddup = dup(fd);
>>> +     fddup = TEMP_FAILURE_RETRY(dup(fd));
>>>       if (fddup < 0)
>>>               goto out_free_sl;
>>>
>>> @@ -498,7 +498,7 @@ static int probe_cache__open(struct probe_cache *pcache, const char *target,
>>>       }
>>>
>>>       snprintf(cpath, PATH_MAX, "%s/probes", dir_name);
>>> -     fd = open(cpath, O_CREAT | O_RDWR, 0644);
>>> +     fd = TEMP_FAILURE_RETRY(open(cpath, O_CREAT | O_RDWR, 0644));
>>>       if (fd < 0)
>>>               pr_debug("Failed to open cache(%d): %s\n", fd, cpath);
>>>       free(dir_name);
>>> @@ -514,7 +514,7 @@ static int probe_cache__load(struct probe_cache *pcache)
>>>       int ret = 0, fddup;
>>>       FILE *fp;
>>>
>>> -     fddup = dup(pcache->fd);
>>> +     fddup = TEMP_FAILURE_RETRY(dup(pcache->fd));
>>>       if (fddup < 0)
>>>               return -errno;
>>>       fp = fdopen(fddup, "r");
>>> diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
>>> index 0acb9de54b06..b2fc389cc530 100644
>>> --- a/tools/perf/util/session.c
>>> +++ b/tools/perf/util/session.c
>>> @@ -384,7 +384,7 @@ static int skipn(int fd, off_t n)
>>>       ssize_t ret;
>>>
>>>       while (n > 0) {
>>> -             ret = read(fd, buf, min(n, (off_t)sizeof(buf)));
>>> +             ret = TEMP_FAILURE_RETRY(read(fd, buf, min(n, (off_t)sizeof(buf))));
>>>               if (ret <= 0)
>>>                       return ret;
>>>               n -= ret;
>>> diff --git a/tools/perf/util/symbol-elf.c b/tools/perf/util/symbol-elf.c
>>> index ecd377938eea..02556070a2ce 100644
>>> --- a/tools/perf/util/symbol-elf.c
>>> +++ b/tools/perf/util/symbol-elf.c
>>> @@ -577,7 +577,7 @@ static int read_build_id(const char *filename, struct build_id *bid)
>>>       if (size < BUILD_ID_SIZE)
>>>               goto out;
>>>
>>> -     fd = open(filename, O_RDONLY);
>>> +     fd = TEMP_FAILURE_RETRY(open(filename, O_RDONLY));
>>>       if (fd < 0)
>>>               goto out;
>>>
>>> @@ -638,7 +638,7 @@ int sysfs__read_build_id(const char *filename, struct build_id *bid)
>>>       size_t size = sizeof(bid->data);
>>>       int fd, err = -1;
>>>
>>> -     fd = open(filename, O_RDONLY);
>>> +     fd = TEMP_FAILURE_RETRY(open(filename, O_RDONLY));
>>>       if (fd < 0)
>>>               goto out;
>>>
>>> @@ -647,24 +647,24 @@ int sysfs__read_build_id(const char *filename, struct build_id *bid)
>>>               GElf_Nhdr nhdr;
>>>               size_t namesz, descsz;
>>>
>>> -             if (read(fd, &nhdr, sizeof(nhdr)) != sizeof(nhdr))
>>> +             if (TEMP_FAILURE_RETRY(read(fd, &nhdr, sizeof(nhdr))) != sizeof(nhdr))
>>>                       break;
>>>
>>>               namesz = NOTE_ALIGN(nhdr.n_namesz);
>>>               descsz = NOTE_ALIGN(nhdr.n_descsz);
>>>               if (nhdr.n_type == NT_GNU_BUILD_ID &&
>>>                   nhdr.n_namesz == sizeof("GNU")) {
>>> -                     if (read(fd, bf, namesz) != (ssize_t)namesz)
>>> +                     if (TEMP_FAILURE_RETRY(read(fd, bf, namesz)) != (ssize_t)namesz)
>>>                               break;
>>>                       if (memcmp(bf, "GNU", sizeof("GNU")) == 0) {
>>>                               size_t sz = min(descsz, size);
>>> -                             if (read(fd, bid->data, sz) == (ssize_t)sz) {
>>> +                             if (TEMP_FAILURE_RETRY(read(fd, bid->data, sz)) == (ssize_t)sz) {
>>>                                       memset(bid->data + sz, 0, size - sz);
>>>                                       bid->size = sz;
>>>                                       err = 0;
>>>                                       break;
>>>                               }
>>> -                     } else if (read(fd, bf, descsz) != (ssize_t)descsz)
>>> +                     } else if (TEMP_FAILURE_RETRY(read(fd, bf, descsz)) != (ssize_t)descsz)
>>>                               break;
>>>               } else {
>>>                       int n = namesz + descsz;
>>> @@ -674,7 +674,7 @@ int sysfs__read_build_id(const char *filename, struct build_id *bid)
>>>                               pr_debug("%s: truncating reading of build id in sysfs file %s: n_namesz=%u, n_descsz=%u.\n",
>>>                                        __func__, filename, nhdr.n_namesz, nhdr.n_descsz);
>>>                       }
>>> -                     if (read(fd, bf, n) != n)
>>> +                     if (TEMP_FAILURE_RETRY(read(fd, bf, n)) != n)
>>>                               break;
>>>               }
>>>       }
>>> @@ -732,7 +732,7 @@ int filename__read_debuglink(const char *filename, char *debuglink,
>>>       Elf_Scn *sec;
>>>       Elf_Kind ek;
>>>
>>> -     fd = open(filename, O_RDONLY);
>>> +     fd = TEMP_FAILURE_RETRY(open(filename, O_RDONLY));
>>>       if (fd < 0)
>>>               goto out;
>>>
>>> @@ -844,7 +844,7 @@ int symsrc__init(struct symsrc *ss, struct dso *dso, const char *name,
>>>
>>>               type = dso->symtab_type;
>>>       } else {
>>> -             fd = open(name, O_RDONLY);
>>> +             fd = TEMP_FAILURE_RETRY(open(name, O_RDONLY));
>>>               if (fd < 0) {
>>>                       dso->load_errno = errno;
>>>                       return -1;
>>> @@ -1454,7 +1454,7 @@ static int copy_bytes(int from, off_t from_offs, int to, off_t to_offs, u64 len)
>>>               if (len < n)
>>>                       n = len;
>>>               /* Use read because mmap won't work on proc files */
>>> -             r = read(from, buf, n);
>>> +             r = TEMP_FAILURE_RETRY(read(from, buf, n));
>>>               if (r < 0)
>>>                       goto out;
>>>               if (!r)
>>> @@ -1485,7 +1485,7 @@ static int kcore__open(struct kcore *kcore, const char *filename)
>>>  {
>>>       GElf_Ehdr *ehdr;
>>>
>>> -     kcore->fd = open(filename, O_RDONLY);
>>> +     kcore->fd = TEMP_FAILURE_RETRY(open(filename, O_RDONLY));
>>>       if (kcore->fd == -1)
>>>               return -1;
>>>
>>> @@ -1518,7 +1518,7 @@ static int kcore__init(struct kcore *kcore, char *filename, int elfclass,
>>>       if (temp)
>>>               kcore->fd = mkstemp(filename);
>>>       else
>>> -             kcore->fd = open(filename, O_WRONLY | O_CREAT | O_EXCL, 0400);
>>> +             kcore->fd = TEMP_FAILURE_RETRY(open(filename, O_WRONLY | O_CREAT | O_EXCL, 0400));
>>>       if (kcore->fd == -1)
>>>               return -1;
>>>
>>> @@ -1966,7 +1966,7 @@ static int kcore_copy__compare_fds(int from, int to)
>>>
>>>       while (1) {
>>>               /* Use read because mmap won't work on proc files */
>>> -             ret = read(from, buf_from, page_size);
>>> +             ret = TEMP_FAILURE_RETRY(read(from, buf_from, page_size));
>>>               if (ret < 0)
>>>                       goto out;
>>>
>>> @@ -1994,11 +1994,11 @@ static int kcore_copy__compare_files(const char *from_filename,
>>>  {
>>>       int from, to, err = -1;
>>>
>>> -     from = open(from_filename, O_RDONLY);
>>> +     from = TEMP_FAILURE_RETRY(open(from_filename, O_RDONLY));
>>>       if (from < 0)
>>>               return -1;
>>>
>>> -     to = open(to_filename, O_RDONLY);
>>> +     to = TEMP_FAILURE_RETRY(open(to_filename, O_RDONLY));
>>>       if (to < 0)
>>>               goto out_close_from;
>>>
>>> @@ -2419,7 +2419,7 @@ int get_sdt_note_list(struct list_head *head, const char *target)
>>>       Elf *elf;
>>>       int fd, ret;
>>>
>>> -     fd = open(target, O_RDONLY);
>>> +     fd = TEMP_FAILURE_RETRY(open(target, O_RDONLY));
>>>       if (fd < 0)
>>>               return -EBADF;
>>>
>>> diff --git a/tools/perf/util/symbol-minimal.c b/tools/perf/util/symbol-minimal.c
>>> index f9eb0bee7f15..7e25d476b1b2 100644
>>> --- a/tools/perf/util/symbol-minimal.c
>>> +++ b/tools/perf/util/symbol-minimal.c
>>> @@ -230,7 +230,7 @@ int sysfs__read_build_id(const char *filename, struct build_id *bid)
>>>       size_t buf_size;
>>>       void *buf;
>>>
>>> -     fd = open(filename, O_RDONLY);
>>> +     fd = TEMP_FAILURE_RETRY(open(filename, O_RDONLY));
>>>       if (fd < 0)
>>>               return -1;
>>>
>>> @@ -242,7 +242,7 @@ int sysfs__read_build_id(const char *filename, struct build_id *bid)
>>>       if (buf == NULL)
>>>               goto out;
>>>
>>> -     if (read(fd, buf, buf_size) != (ssize_t) buf_size)
>>> +     if (TEMP_FAILURE_RETRY(read(fd, buf, buf_size)) != (ssize_t) buf_size)
>>>               goto out_free;
>>>
>>>       ret = read_build_id(buf, buf_size, bid, false);
>>> @@ -256,7 +256,7 @@ int sysfs__read_build_id(const char *filename, struct build_id *bid)
>>>  int symsrc__init(struct symsrc *ss, struct dso *dso, const char *name,
>>>                enum dso_binary_type type)
>>>  {
>>> -     int fd = open(name, O_RDONLY);
>>> +     int fd = TEMP_FAILURE_RETRY(open(name, O_RDONLY));
>>>       if (fd < 0)
>>>               goto out_errno;
>>>
>>> diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
>>> index f72baf636724..5212667ea67d 100644
>>> --- a/tools/perf/util/symbol.c
>>> +++ b/tools/perf/util/symbol.c
>>> @@ -1335,7 +1335,7 @@ static int dso__load_kcore(struct dso *dso, struct map *map,
>>>       md.dso = dso;
>>>       INIT_LIST_HEAD(&md.maps);
>>>
>>> -     fd = open(kcore_filename, O_RDONLY);
>>> +     fd = TEMP_FAILURE_RETRY(open(kcore_filename, O_RDONLY));
>>>       if (fd < 0) {
>>>               pr_debug("Failed to open %s. Note /proc/kcore requires CAP_SYS_RAWIO capability to access.\n",
>>>                        kcore_filename);
>>> @@ -2156,7 +2156,7 @@ static int find_matching_kcore(struct map *map, char *dir, size_t dir_sz)
>>>   */
>>>  static bool filename__readable(const char *file)
>>>  {
>>> -     int fd = open(file, O_RDONLY);
>>> +     int fd = TEMP_FAILURE_RETRY(open(file, O_RDONLY));
>>>       if (fd < 0)
>>>               return false;
>>>       close(fd);
>>> diff --git a/tools/perf/util/synthetic-events.c b/tools/perf/util/synthetic-events.c
>>> index 76beda3e1a10..9dcc268bd69c 100644
>>> --- a/tools/perf/util/synthetic-events.c
>>> +++ b/tools/perf/util/synthetic-events.c
>>> @@ -40,6 +40,7 @@
>>>  #include <api/io.h>
>>>  #include <sys/types.h>
>>>  #include <sys/stat.h>
>>> +#include <errno.h>
>>>  #include <fcntl.h>
>>>  #include <unistd.h>
>>>
>>> @@ -86,13 +87,13 @@ static int perf_event__get_comm_ids(pid_t pid, pid_t tid, char *comm, size_t len
>>>       else
>>>               snprintf(bf, sizeof(bf), "/proc/%d/status", tid);
>>>
>>> -     fd = open(bf, O_RDONLY);
>>> +     fd = TEMP_FAILURE_RETRY(open(bf, O_RDONLY));
>>>       if (fd < 0) {
>>>               pr_debug("couldn't open %s\n", bf);
>>>               return -1;
>>>       }
>>>
>>> -     n = read(fd, bf, sizeof(bf) - 1);
>>> +     n = TEMP_FAILURE_RETRY(read(fd, bf, sizeof(bf) - 1));
>>>       close(fd);
>>>       if (n <= 0) {
>>>               pr_warning("Couldn't get COMM, tigd and ppid for pid %d\n",
>>> @@ -410,7 +411,7 @@ int perf_event__synthesize_mmap_events(struct perf_tool *tool,
>>>       snprintf(bf, sizeof(bf), "%s/proc/%d/task/%d/maps",
>>>               machine->root_dir, pid, pid);
>>>
>>> -     io.fd = open(bf, O_RDONLY, 0);
>>> +     io.fd = TEMP_FAILURE_RETRY(open(bf, O_RDONLY, 0));
>>>       if (io.fd < 0) {
>>>               /*
>>>                * We raced with a task exiting - just return:
>>> diff --git a/tools/perf/util/trace-event-info.c b/tools/perf/util/trace-event-info.c
>>> index a65f65d0857e..c917a4217c6f 100644
>>> --- a/tools/perf/util/trace-event-info.c
>>> +++ b/tools/perf/util/trace-event-info.c
>>> @@ -48,7 +48,7 @@ static int record_file(const char *file, ssize_t hdr_sz)
>>>       int r, fd;
>>>       int err = -EIO;
>>>
>>> -     fd = open(file, O_RDONLY);
>>> +     fd = TEMP_FAILURE_RETRY(open(file, O_RDONLY));
>>>       if (fd < 0) {
>>>               pr_debug("Can't read '%s'", file);
>>>               return -errno;
>>> @@ -61,7 +61,7 @@ static int record_file(const char *file, ssize_t hdr_sz)
>>>       }
>>>
>>>       do {
>>> -             r = read(fd, buf, BUFSIZ);
>>> +             r = TEMP_FAILURE_RETRY(read(fd, buf, BUFSIZ));
>>>               if (r > 0) {
>>>                       size += r;
>>>                       if (write(output_fd, buf, r) != r)
>>> @@ -519,7 +519,7 @@ struct tracing_data *tracing_data_get(struct list_head *pattrs,
>>>                       return NULL;
>>>               }
>>>
>>> -             temp_fd = open(tdata->temp_file, O_RDWR);
>>> +             temp_fd = TEMP_FAILURE_RETRY(open(tdata->temp_file, O_RDWR));
>>>               if (temp_fd < 0) {
>>>                       pr_debug("Can't read '%s'", tdata->temp_file);
>>>                       free(tdata);
>>> diff --git a/tools/perf/util/trace-event-read.c b/tools/perf/util/trace-event-read.c
>>> index 8a01af783310..7086770ec225 100644
>>> --- a/tools/perf/util/trace-event-read.c
>>> +++ b/tools/perf/util/trace-event-read.c
>>> @@ -11,6 +11,7 @@
>>>  #include <sys/stat.h>
>>>  #include <sys/wait.h>
>>>  #include <sys/mman.h>
>>> +#include <errno.h>
>>>  #include <fcntl.h>
>>>  #include <unistd.h>
>>>  #include <errno.h>
>>> @@ -28,7 +29,7 @@ static int __do_read(int fd, void *buf, int size)
>>>       int rsize = size;
>>>
>>>       while (size) {
>>> -             int ret = read(fd, buf, size);
>>> +             int ret = TEMP_FAILURE_RETRY(read(fd, buf, size));
>>>
>>>               if (ret <= 0)
>>>                       return -1;
>>> @@ -105,7 +106,7 @@ static char *read_string(void)
>>>       char c;
>>>
>>>       for (;;) {
>>> -             r = read(input_fd, &c, 1);
>>> +             r = TEMP_FAILURE_RETRY(read(input_fd, &c, 1));
>>>               if (r < 0) {
>>>                       pr_debug("reading input file");
>>>                       goto out;
>>> diff --git a/tools/perf/util/unwind-libunwind-local.c b/tools/perf/util/unwind-libunwind-local.c
>>> index 37622699c91a..2ece387a73c6 100644
>>> --- a/tools/perf/util/unwind-libunwind-local.c
>>> +++ b/tools/perf/util/unwind-libunwind-local.c
>>> @@ -362,7 +362,7 @@ static int read_unwind_spec_debug_frame(struct dso *dso,
>>>               }
>>>
>>>               if (ofs <= 0) {
>>> -                     fd = open(dso->symsrc_filename, O_RDONLY);
>>> +                     fd = TEMP_FAILURE_RETRY(open(dso->symsrc_filename, O_RDONLY));
>>>                       if (fd >= 0) {
>>>                               ofs = elf_section_offset(fd, ".debug_frame");
>>>                               close(fd);
>>> @@ -377,7 +377,7 @@ static int read_unwind_spec_debug_frame(struct dso *dso,
>>>                               dso, DSO_BINARY_TYPE__DEBUGLINK,
>>>                               machine->root_dir, debuglink, PATH_MAX);
>>>                       if (!ret) {
>>> -                             fd = open(debuglink, O_RDONLY);
>>> +                             fd = TEMP_FAILURE_RETRY(open(debuglink, O_RDONLY));
>>>                               if (fd >= 0) {
>>>                                       ofs = elf_section_offset(fd,
>>>                                                       ".debug_frame");
>>> diff --git a/tools/perf/util/zlib.c b/tools/perf/util/zlib.c
>>> index 78d2297c1b67..f4563ea094c8 100644
>>> --- a/tools/perf/util/zlib.c
>>> +++ b/tools/perf/util/zlib.c
>>> @@ -1,4 +1,5 @@
>>>  // SPDX-License-Identifier: GPL-2.0
>>> +#include <errno.h>
>>>  #include <fcntl.h>
>>>  #include <stdio.h>
>>>  #include <string.h>
>>> @@ -82,7 +83,7 @@ int gzip_decompress_to_file(const char *input, int output_fd)
>>>
>>>  bool gzip_is_compressed(const char *input)
>>>  {
>>> -     int fd = open(input, O_RDONLY);
>>> +     int fd = TEMP_FAILURE_RETRY(open(input, O_RDONLY));
>>>       const uint8_t magic[2] = { 0x1f, 0x8b };
>>>       char buf[2] = { 0 };
>>>       ssize_t rc;
>>> @@ -90,7 +91,7 @@ bool gzip_is_compressed(const char *input)
>>>       if (fd < 0)
>>>               return -1;
>>>
>>> -     rc = read(fd, buf, sizeof(buf));
>>> +     rc = TEMP_FAILURE_RETRY(read(fd, buf, sizeof(buf)));
>>>       close(fd);
>>>       return rc == sizeof(buf) ?
>>>              memcmp(buf, magic, sizeof(buf)) == 0 : false;
>>

