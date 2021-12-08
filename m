Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD52346CDE8
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 07:50:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239454AbhLHGxt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 01:53:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231193AbhLHGxs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 01:53:48 -0500
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5824CC061574
        for <linux-kernel@vger.kernel.org>; Tue,  7 Dec 2021 22:50:17 -0800 (PST)
Received: by mail-il1-x12a.google.com with SMTP id t8so1294542ilu.8
        for <linux-kernel@vger.kernel.org>; Tue, 07 Dec 2021 22:50:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RIkKniVvrHQO4tEFTaAMu7+zotuSgBCanz/F6fdL7ZM=;
        b=bxDG0AofEbg/2bVIV2Wo+NVdumvz4QvhnbhzDerP1K7630hYmB7chHPi831L8I2s7T
         Gf2PB1A0yAWpZ1dO/wP6zVtYUjedkg64yyZPV9iUUvcI8+ek/7Sxvsm0QakeiOMOEeWy
         YPKBPQidYFShe30H9XMGQ3LgRJQI+gpvKM55fGduLGNOmgVc/hVj1wBf4XC+NT9M4i7d
         QJog0vRxmymBvdyyXygmAbeuSCQ07RV8wp/TJgZd4JrwDUpmsSz7zWl8NbdPIyazCiVt
         Y56MMfegIdu8GbfA8OGn0hhbgVx+AHbjNhyHCXkZv6NZhlYz5x7X6+28MtrJgysKA55g
         Uayg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RIkKniVvrHQO4tEFTaAMu7+zotuSgBCanz/F6fdL7ZM=;
        b=C65ebgdSXBTbA4hSqvVSwu6si//MKvz6aeubOGqnhXgs+zVn5Y1fn/r4iyVpX6dC08
         abOePKym/Cbs9vytC1Qh/ZDKkKqGaEha6xtJe7R6iKSfO+4Z/HqTvEMZksOnrjDf/+3Q
         u4HiuzMzCh7GE/lUGKu5sxMGpinPNJMMEbMNqn8TTr2Ij4Py1EbRDm5UOgVWeajpRJdi
         CaXQa2MbahMPFnLkonDNARg2mF0wf+s3XFkgKOae2/rIq2qPzclY8DebEMr5d6izQaBg
         4MG4iRWFiXuj08olxzURz4jMEW9QserupGhEP1zqiJR7Rw9e3DocVnJKy00l0PjDGumv
         JF3Q==
X-Gm-Message-State: AOAM532CpuGOpKV3AUWOYjizEQzs17bdRsts9S7J2yU3SuUm6fYuqNsE
        f7aI3YUBWGY71jeo2ioQyoz5MA6MIrFSEVG/9BdCPA==
X-Google-Smtp-Source: ABdhPJzfK6YmcbeRUN+j5Hpeb9ZRfCalJbgCxbbyFdGkRHUpDM6QGEdp+dcNLoTTGlfl9Baj2xa97KEm/VUcqYP01hk=
X-Received: by 2002:a05:6e02:f51:: with SMTP id y17mr3698995ilj.2.1638946216584;
 Tue, 07 Dec 2021 22:50:16 -0800 (PST)
MIME-Version: 1.0
References: <20210609044555.27180-1-yao.jin@linux.intel.com>
In-Reply-To: <20210609044555.27180-1-yao.jin@linux.intel.com>
From:   Ian Rogers <irogers@google.com>
Date:   Tue, 7 Dec 2021 22:50:03 -0800
Message-ID: <CAP-5=fXnrz0uPvfBrJ+pftpvDX1c35-WrnZ-6nXcRrZeeD8Cfw@mail.gmail.com>
Subject: Re: [PATCH v2] perf evsel: Adjust hybrid event and global event mixed group
To:     Jin Yao <yao.jin@linux.intel.com>, acme@kernel.org,
        jolsa@kernel.org
Cc:     peterz@infradead.org, mingo@redhat.com,
        alexander.shishkin@linux.intel.com, linux-kernel@vger.kernel.org,
        ak@linux.intel.com, kan.liang@intel.com, yao.jin@intel.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 8, 2021 at 9:48 PM Jin Yao <yao.jin@linux.intel.com> wrote:
>
> A group mixed with hybrid event and global event is allowed. For example,
> group leader is 'intel_pt//' and the group member is 'cpu_atom/cycles/'.
>
> e.g.
> perf record --aux-sample -e '{intel_pt//,cpu_atom/cycles/}:u'
>
> The challenge is their available cpus are not fully matched. For example,
> 'intel_pt//' is available on CPU0-CPU23, but 'cpu_atom/cycles/' is
> available on CPU16-CPU23.
>
> When getting the group id for group member, we must be very careful.
> Because the cpu for 'intel_pt//' is not equal to the cpu for
> 'cpu_atom/cycles/'. Actually the cpu here is the index of evsel->core.cpus,
> not the real CPU ID.
>
> e.g. cpu0 for 'intel_pt//' is CPU0, but cpu0 for 'cpu_atom/cycles/' is CPU16.
>
> Before:
>
>   # perf record --aux-sample -e '{intel_pt//,cpu_atom/cycles/}:u' -vv uname
>   ...
>   ------------------------------------------------------------
>   perf_event_attr:
>     type                             10
>     size                             128
>     config                           0xe601
>     { sample_period, sample_freq }   1
>     sample_type                      IP|TID|TIME|CPU|IDENTIFIER
>     read_format                      ID
>     disabled                         1
>     inherit                          1
>     exclude_kernel                   1
>     exclude_hv                       1
>     enable_on_exec                   1
>     sample_id_all                    1
>     exclude_guest                    1
>   ------------------------------------------------------------
>   sys_perf_event_open: pid 4084  cpu 0  group_fd -1  flags 0x8 = 5
>   sys_perf_event_open: pid 4084  cpu 1  group_fd -1  flags 0x8 = 6
>   sys_perf_event_open: pid 4084  cpu 2  group_fd -1  flags 0x8 = 7
>   sys_perf_event_open: pid 4084  cpu 3  group_fd -1  flags 0x8 = 9
>   sys_perf_event_open: pid 4084  cpu 4  group_fd -1  flags 0x8 = 10
>   sys_perf_event_open: pid 4084  cpu 5  group_fd -1  flags 0x8 = 11
>   sys_perf_event_open: pid 4084  cpu 6  group_fd -1  flags 0x8 = 12
>   sys_perf_event_open: pid 4084  cpu 7  group_fd -1  flags 0x8 = 13
>   sys_perf_event_open: pid 4084  cpu 8  group_fd -1  flags 0x8 = 14
>   sys_perf_event_open: pid 4084  cpu 9  group_fd -1  flags 0x8 = 15
>   sys_perf_event_open: pid 4084  cpu 10  group_fd -1  flags 0x8 = 16
>   sys_perf_event_open: pid 4084  cpu 11  group_fd -1  flags 0x8 = 17
>   sys_perf_event_open: pid 4084  cpu 12  group_fd -1  flags 0x8 = 18
>   sys_perf_event_open: pid 4084  cpu 13  group_fd -1  flags 0x8 = 19
>   sys_perf_event_open: pid 4084  cpu 14  group_fd -1  flags 0x8 = 20
>   sys_perf_event_open: pid 4084  cpu 15  group_fd -1  flags 0x8 = 21
>   sys_perf_event_open: pid 4084  cpu 16  group_fd -1  flags 0x8 = 22
>   sys_perf_event_open: pid 4084  cpu 17  group_fd -1  flags 0x8 = 23
>   sys_perf_event_open: pid 4084  cpu 18  group_fd -1  flags 0x8 = 24
>   sys_perf_event_open: pid 4084  cpu 19  group_fd -1  flags 0x8 = 25
>   sys_perf_event_open: pid 4084  cpu 20  group_fd -1  flags 0x8 = 26
>   sys_perf_event_open: pid 4084  cpu 21  group_fd -1  flags 0x8 = 27
>   sys_perf_event_open: pid 4084  cpu 22  group_fd -1  flags 0x8 = 28
>   sys_perf_event_open: pid 4084  cpu 23  group_fd -1  flags 0x8 = 29
>   ------------------------------------------------------------
>   perf_event_attr:
>     size                             128
>     config                           0x800000000
>     { sample_period, sample_freq }   4000
>     sample_type                      IP|TID|TIME|PERIOD|IDENTIFIER|AUX
>     read_format                      ID
>     inherit                          1
>     exclude_kernel                   1
>     exclude_hv                       1
>     freq                             1
>     sample_id_all                    1
>     exclude_guest                    1
>     aux_sample_size                  4096
>   ------------------------------------------------------------
>   sys_perf_event_open: pid 4084  cpu 16  group_fd 5  flags 0x8
>   sys_perf_event_open failed, error -22
>
> The group_fd 5 is not correct. It should be 22 (the fd of
> 'intel_pt' on CPU16).
>
> After:
>
>   # perf record --aux-sample -e '{intel_pt//,cpu_atom/cycles/}:u' -vv uname
>   ...
>   ------------------------------------------------------------
>   perf_event_attr:
>     type                             10
>     size                             128
>     config                           0xe601
>     { sample_period, sample_freq }   1
>     sample_type                      IP|TID|TIME|CPU|IDENTIFIER
>     read_format                      ID
>     disabled                         1
>     inherit                          1
>     exclude_kernel                   1
>     exclude_hv                       1
>     enable_on_exec                   1
>     sample_id_all                    1
>     exclude_guest                    1
>   ------------------------------------------------------------
>   sys_perf_event_open: pid 5162  cpu 0  group_fd -1  flags 0x8 = 5
>   sys_perf_event_open: pid 5162  cpu 1  group_fd -1  flags 0x8 = 6
>   sys_perf_event_open: pid 5162  cpu 2  group_fd -1  flags 0x8 = 7
>   sys_perf_event_open: pid 5162  cpu 3  group_fd -1  flags 0x8 = 9
>   sys_perf_event_open: pid 5162  cpu 4  group_fd -1  flags 0x8 = 10
>   sys_perf_event_open: pid 5162  cpu 5  group_fd -1  flags 0x8 = 11
>   sys_perf_event_open: pid 5162  cpu 6  group_fd -1  flags 0x8 = 12
>   sys_perf_event_open: pid 5162  cpu 7  group_fd -1  flags 0x8 = 13
>   sys_perf_event_open: pid 5162  cpu 8  group_fd -1  flags 0x8 = 14
>   sys_perf_event_open: pid 5162  cpu 9  group_fd -1  flags 0x8 = 15
>   sys_perf_event_open: pid 5162  cpu 10  group_fd -1  flags 0x8 = 16
>   sys_perf_event_open: pid 5162  cpu 11  group_fd -1  flags 0x8 = 17
>   sys_perf_event_open: pid 5162  cpu 12  group_fd -1  flags 0x8 = 18
>   sys_perf_event_open: pid 5162  cpu 13  group_fd -1  flags 0x8 = 19
>   sys_perf_event_open: pid 5162  cpu 14  group_fd -1  flags 0x8 = 20
>   sys_perf_event_open: pid 5162  cpu 15  group_fd -1  flags 0x8 = 21
>   sys_perf_event_open: pid 5162  cpu 16  group_fd -1  flags 0x8 = 22
>   sys_perf_event_open: pid 5162  cpu 17  group_fd -1  flags 0x8 = 23
>   sys_perf_event_open: pid 5162  cpu 18  group_fd -1  flags 0x8 = 24
>   sys_perf_event_open: pid 5162  cpu 19  group_fd -1  flags 0x8 = 25
>   sys_perf_event_open: pid 5162  cpu 20  group_fd -1  flags 0x8 = 26
>   sys_perf_event_open: pid 5162  cpu 21  group_fd -1  flags 0x8 = 27
>   sys_perf_event_open: pid 5162  cpu 22  group_fd -1  flags 0x8 = 28
>   sys_perf_event_open: pid 5162  cpu 23  group_fd -1  flags 0x8 = 29
>   ------------------------------------------------------------
>   perf_event_attr:
>     size                             128
>     config                           0x800000000
>     { sample_period, sample_freq }   4000
>     sample_type                      IP|TID|TIME|PERIOD|IDENTIFIER|AUX
>     read_format                      ID
>     inherit                          1
>     exclude_kernel                   1
>     exclude_hv                       1
>     freq                             1
>     sample_id_all                    1
>     exclude_guest                    1
>     aux_sample_size                  4096
>   ------------------------------------------------------------
>   sys_perf_event_open: pid 5162  cpu 16  group_fd 22  flags 0x8 = 30
>   sys_perf_event_open: pid 5162  cpu 17  group_fd 23  flags 0x8 = 31
>   sys_perf_event_open: pid 5162  cpu 18  group_fd 24  flags 0x8 = 32
>   sys_perf_event_open: pid 5162  cpu 19  group_fd 25  flags 0x8 = 33
>   sys_perf_event_open: pid 5162  cpu 20  group_fd 26  flags 0x8 = 34
>   sys_perf_event_open: pid 5162  cpu 21  group_fd 27  flags 0x8 = 35
>   sys_perf_event_open: pid 5162  cpu 22  group_fd 28  flags 0x8 = 36
>   sys_perf_event_open: pid 5162  cpu 23  group_fd 29  flags 0x8 = 37
>   ------------------------------------------------------------
>   ...
>
> Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
> ---
>  tools/perf/util/evsel.c | 25 +++++++++++++++++++++++++
>  1 file changed, 25 insertions(+)
>
> diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> index 4a3cd1b5bb33..f81ac6962aec 100644
> --- a/tools/perf/util/evsel.c
> +++ b/tools/perf/util/evsel.c
> @@ -1581,6 +1581,27 @@ int __evsel__read_on_cpu(struct evsel *evsel, int cpu, int thread, bool scale)
>         return 0;
>  }
>
> +static int evsel__match_other_cpu(struct evsel *evsel, struct evsel *other,
> +                                 int cpu)
> +{
> +       int cpuid;
> +
> +       cpuid = perf_cpu_map__cpu(evsel->core.cpus, cpu);

I came across this as part of:
https://lore.kernel.org/lkml/20211208024607.1784932-1-irogers@google.com/
The assumption that evsel's cpu maps are indexable by cpus looks wrong
- it wouldn't work for a SkylakeX's:
$ cat /sys/devices/uncore_imc_0/cpumask
0,18
The cpu here is a real CPU and not a cpu map index, so I'm not sure
what the cpu map translation is trying to do - if this is a full cpu
map then cpuid will equal cpu. Perhaps the code should be:
BUG_ON(!perf_cpu_map__has(evsel->core.cpus, cpu));
return perf_cpu_map__idx(other->core.cpus, cpu);

Thanks,
Ian

> +       return perf_cpu_map__idx(other->core.cpus, cpuid);
> +}
> +
> +static int evsel__hybrid_group_cpu(struct evsel *evsel, int cpu)
> +{
> +       struct evsel *leader = evsel->leader;
> +
> +       if ((evsel__is_hybrid(evsel) && !evsel__is_hybrid(leader)) ||
> +           (!evsel__is_hybrid(evsel) && evsel__is_hybrid(leader))) {
> +               return evsel__match_other_cpu(evsel, leader, cpu);
> +       }
> +
> +       return cpu;
> +}
> +
>  static int get_group_fd(struct evsel *evsel, int cpu, int thread)
>  {
>         struct evsel *leader = evsel->leader;
> @@ -1595,6 +1616,10 @@ static int get_group_fd(struct evsel *evsel, int cpu, int thread)
>          */
>         BUG_ON(!leader->core.fd);
>
> +       cpu = evsel__hybrid_group_cpu(evsel, cpu);
> +       if (cpu == -1)
> +               return -1;
> +
>         fd = FD(leader, cpu, thread);
>         BUG_ON(fd == -1);
>
> --
> 2.17.1
>
