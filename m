Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D137B5AF31E
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 19:51:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229653AbiIFRu4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 13:50:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229636AbiIFRuw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 13:50:52 -0400
Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1005B915CB;
        Tue,  6 Sep 2022 10:50:44 -0700 (PDT)
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-12243fcaa67so30010309fac.8;
        Tue, 06 Sep 2022 10:50:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=FQOU2gtbGHU8P+SfVNiDNcpCtIq0ymlv0rdzv/pE/OE=;
        b=l9Qbd73bBw7Ib1TXtqEzZe3uXaRXY5IOakZlB2BjxH7nfTwVXvRlxt9+dOhYNwPrus
         643MitL7rL2oMJ7zgUrCFtX6y1XsRXwfX0Ca6fJJ/gdUagdkdPEnQVoxzkRPcThUS+FI
         IPXO/cW2gyOALCigMnJ4L/pjJrKRK2UlOAi9yXfA1zMbqZaT4Y8zjbjdnp7uyq1N8g6y
         8UvHz2wxRtJ224kh+v1jazaxEQxD0AXOxzU1ws+LjNzsyDGYr9Hs6z+HdvbBnv3NPSoO
         gQOAHOoWfhxE4Wj+gAFrWXlGbY2YdM4faUsMh8qOB0JLxvAeOSLAzeMNuZedmZe07XWA
         bvow==
X-Gm-Message-State: ACgBeo1m70XxipPwLbxOgUxCloheOqZ9bhe0+QdB8bta5SXAkmwwI9JK
        LTlximQWPklL2AXC7j1zJfIarq6JvykdrkOCchM=
X-Google-Smtp-Source: AA6agR6grDYciA8oSOQETrO/w0otbXHspFX2ViD83ps/ULz1jk/FB4tFzmk2i55+ZWzPY93F70shNQqE0t6yM/BhYEs=
X-Received: by 2002:a05:6808:302a:b0:345:ec04:8f11 with SMTP id
 ay42-20020a056808302a00b00345ec048f11mr10483844oib.5.1662486642612; Tue, 06
 Sep 2022 10:50:42 -0700 (PDT)
MIME-Version: 1.0
References: <20220905114209.8389-1-adrian.hunter@intel.com>
In-Reply-To: <20220905114209.8389-1-adrian.hunter@intel.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Tue, 6 Sep 2022 10:50:31 -0700
Message-ID: <CAM9d7cibk1OU95v56J15RG-zZmJ9TccUVZGAp=VHu7F3HwFY8g@mail.gmail.com>
Subject: Re: [PATCH V2] libperf evlist: Fix per-thread mmaps for
 multi-threaded targets
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>, Ian Rogers <irogers@google.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 5, 2022 at 4:42 AM Adrian Hunter <adrian.hunter@intel.com> wrote:
>
> The offending commit removed mmap_per_thread(), which did not consider
> the different set-output rules for per-thread mmaps i.e. in the per-thread
> case set-output is used for file descriptors of the same thread not the
> same cpu.
>
> This was not immediately noticed because it only happens with
> multi-threaded targets and we do not have a test for that yet.

Yeah, this is unfortunate.  I feel like I need to spend some time on it.

>
> Reinstate mmap_per_thread() expanding it to cover also system-wide per-cpu
> events i.e. to continue to allow the mixing of per-thread and per-cpu
> mmaps.
>
> Debug messages (with -vv) show the file descriptors that are opened with
> sys_perf_event_open. New debug messages are added (needs -vvv) that show
> also which file descriptors are mmapped and which are redirected with
> set-output.
>
> In the per-cpu case (cpu != -1) file descriptors for the same CPU are
> set-output to the first file descriptor for that CPU.
>
> In the per-thread case (cpu == -1) file descriptors for the same thread are
> set-output to the first file descriptor for that thread.
>
> Example (process 17489 has 2 threads):
>
>  Before (but with new debug prints):
>
>    $ perf record --no-bpf-event -vvv --per-thread -p 17489
>    <SNIP>
>    sys_perf_event_open: pid 17489  cpu -1  group_fd -1  flags 0x8 = 5
>    sys_perf_event_open: pid 17490  cpu -1  group_fd -1  flags 0x8 = 6
>    <SNIP>
>    libperf: idx 0: mmapping fd 5
>    libperf: idx 0: set output fd 6 -> 5
>    failed to mmap with 22 (Invalid argument)
>
>  After:
>
>    $ perf record --no-bpf-event -vvv --per-thread -p 17489
>    <SNIP>
>    sys_perf_event_open: pid 17489  cpu -1  group_fd -1  flags 0x8 = 5
>    sys_perf_event_open: pid 17490  cpu -1  group_fd -1  flags 0x8 = 6
>    <SNIP>
>    libperf: mmap_per_thread: nr cpu values (may include -1) 1 nr threads 2
>    libperf: idx 0: mmapping fd 5
>    libperf: idx 1: mmapping fd 6
>    <SNIP>
>    [ perf record: Woken up 2 times to write data ]
>    [ perf record: Captured and wrote 0.018 MB perf.data (15 samples) ]

It'd be nice if the example had 2 events so that it could check the
set-output rule actually worked.

Thanks,
Namhyung

>
> Per-cpu example (process 20341 has 2 threads, same as above):
>
>    $ perf record --no-bpf-event -vvv -p 20341
>    <SNIP>
>    sys_perf_event_open: pid 20341  cpu 0  group_fd -1  flags 0x8 = 5
>    sys_perf_event_open: pid 20342  cpu 0  group_fd -1  flags 0x8 = 6
>    sys_perf_event_open: pid 20341  cpu 1  group_fd -1  flags 0x8 = 7
>    sys_perf_event_open: pid 20342  cpu 1  group_fd -1  flags 0x8 = 8
>    sys_perf_event_open: pid 20341  cpu 2  group_fd -1  flags 0x8 = 9
>    sys_perf_event_open: pid 20342  cpu 2  group_fd -1  flags 0x8 = 10
>    sys_perf_event_open: pid 20341  cpu 3  group_fd -1  flags 0x8 = 11
>    sys_perf_event_open: pid 20342  cpu 3  group_fd -1  flags 0x8 = 12
>    sys_perf_event_open: pid 20341  cpu 4  group_fd -1  flags 0x8 = 13
>    sys_perf_event_open: pid 20342  cpu 4  group_fd -1  flags 0x8 = 14
>    sys_perf_event_open: pid 20341  cpu 5  group_fd -1  flags 0x8 = 15
>    sys_perf_event_open: pid 20342  cpu 5  group_fd -1  flags 0x8 = 16
>    sys_perf_event_open: pid 20341  cpu 6  group_fd -1  flags 0x8 = 17
>    sys_perf_event_open: pid 20342  cpu 6  group_fd -1  flags 0x8 = 18
>    sys_perf_event_open: pid 20341  cpu 7  group_fd -1  flags 0x8 = 19
>    sys_perf_event_open: pid 20342  cpu 7  group_fd -1  flags 0x8 = 20
>    <SNIP>
>    libperf: mmap_per_cpu: nr cpu values 8 nr threads 2
>    libperf: idx 0: mmapping fd 5
>    libperf: idx 0: set output fd 6 -> 5
>    libperf: idx 1: mmapping fd 7
>    libperf: idx 1: set output fd 8 -> 7
>    libperf: idx 2: mmapping fd 9
>    libperf: idx 2: set output fd 10 -> 9
>    libperf: idx 3: mmapping fd 11
>    libperf: idx 3: set output fd 12 -> 11
>    libperf: idx 4: mmapping fd 13
>    libperf: idx 4: set output fd 14 -> 13
>    libperf: idx 5: mmapping fd 15
>    libperf: idx 5: set output fd 16 -> 15
>    libperf: idx 6: mmapping fd 17
>    libperf: idx 6: set output fd 18 -> 17
>    libperf: idx 7: mmapping fd 19
>    libperf: idx 7: set output fd 20 -> 19
>    <SNIP>
>    [ perf record: Woken up 7 times to write data ]
>    [ perf record: Captured and wrote 0.020 MB perf.data (17 samples) ]
>
> Fixes: ae4f8ae16a07 ("libperf evlist: Allow mixing per-thread and per-cpu mmaps")
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
