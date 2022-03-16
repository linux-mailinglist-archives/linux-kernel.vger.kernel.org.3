Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E55494DABAE
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 08:14:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347172AbiCPHPp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 03:15:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244761AbiCPHPl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 03:15:41 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A2DD20F45
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 00:14:26 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id h23so989267wrb.8
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 00:14:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=KFOX7ONiGjYSWSbti5RTwYyu7K7YTppUYftBLz1HLt4=;
        b=SLUAy3TTL1QidpE7T6uz6KQJK7yZ/+37tTvSX/fletRGEk+nPSvYifalrQYF1sd/h7
         rXzEIsI2RNA+suUv/yhxBoLKp9jFLD/inyUvux85aLrPOArKYde6mcJePamAkznBiuU0
         uzWg/9C+By4vPjhD+Jmw5Tf03Y8Q0uLe/mZ5FA7UI2B3mYZM2vvpzqMbGG17ULllB6cO
         3R4IIcMO9tvfARlHamHPPYi+KkX3wKomO4VvnAoEm63uds+RkTAxzS2rJRLklzF1a2Wh
         Ah3RenpDivYbG/zybPPCXBksq9+Ma/1KDMjiJ4pyxZdXYDMJu7YRL/LZsyem6kBHde+X
         4TIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=KFOX7ONiGjYSWSbti5RTwYyu7K7YTppUYftBLz1HLt4=;
        b=gBE0t0vJgvA2ZbuJ4FbzxSphW/+uXlVOii7Kcfe9zH+n4iI8F7j0AfyVQr9f6zSUGk
         nAzJpiinKtjJCTZFKydWK98f41Mwh3PUCoTrb5h8xozLS4vUgZxTFuELsDFwiWANlwV6
         ru29/AgzW8EZyZQ55v0QeuUqIVoFuzSeRYMsF6h8R6QcFAM/zQIWjyNeqPCg+Z/FMmw3
         7nye0cZRzlyKB/4W/IZv7mZfF5FEL+/COfwrwm/WLZ5brjfXkKR6oEnKG8FYTHv/TPVv
         Go+X+5rXaeyaSDkzJabq/3ZVcc3G9Jufhye2pI7vdmDt9xgJPI0X79rmGzw7AXsqtMWQ
         htIA==
X-Gm-Message-State: AOAM531xJSEcEWc0XJAJHMNy4Cy4YH/GPNSKZq2hpFMuyRbwt0G66GJS
        u1/zeF1gXmUzb6CeJ2ZMU5algwcB+LDUTqrA03rN0vgUX4uktQ==
X-Google-Smtp-Source: ABdhPJwoRmRC7CL5BwG+W0shE7sMm5i/wn9T2S8+sXFDUOQJKG+BC6Y4m9S1tupWdK45vAG7cm3N7gAIYnvQeyZgUDk=
X-Received: by 2002:a05:6000:f:b0:203:d97a:947 with SMTP id
 h15-20020a056000000f00b00203d97a0947mr3757424wrx.654.1647414864554; Wed, 16
 Mar 2022 00:14:24 -0700 (PDT)
MIME-Version: 1.0
References: <YjCLcpcX2peeQVCH@kernel.org>
In-Reply-To: <YjCLcpcX2peeQVCH@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Wed, 16 Mar 2022 00:14:12 -0700
Message-ID: <CAP-5=fUW0O2mVopONcTjwYLB6JsLY8HgGzggj=zw7R45wBhozA@mail.gmail.com>
Subject: Re: 'perf stat --null sleep 1' segfault related to
 evlist__for_each_entry with affinity == NULL
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Tue, Mar 15, 2022 at 5:50 AM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> This bounced yesterday, resending :-\
>
> -----
>
> Hi Ian,
>
>         I just noticed this:
>
> (gdb) run stat --null sleep 1
> `/var/home/acme/bin/perf' has changed; re-reading symbols.
> Starting program: /var/home/acme/bin/perf stat --null sleep 1
> [Thread debugging using libthread_db enabled]
> Using host libthread_db library "/lib64/libthread_db.so.1".
> [Detaching after fork from child process 900002]
>
> Program received signal SIGSEGV, Segmentation fault.
> 0x0000000000596790 in create_perf_stat_counter (evsel=3D0xda9580, config=
=3D0xcbeac0 <stat_config>, target=3D0xcbe8a0 <target>, cpu_map_idx=3D0) at =
util/stat.c:548
> 548             if (leader->core.nr_members > 1)
> Missing separate debuginfos, use: dnf debuginfo-install bzip2-libs-1.0.8-=
6.fc34.x86_64 cyrus-sasl-lib-2.1.27-8.fc34.x86_64 elfutils-debuginfod-clien=
t-0.186-1.fc34.x86_64 elfutils-libelf-0.186-1.fc34.x86_64 elfutils-libs-0.1=
86-1.fc34.x86_64 glib2-2.68.4-1.fc34.x86_64 glibc-2.33-21.fc34.x86_64 keyut=
ils-libs-1.6.1-2.fc34.x86_64 libbabeltrace-1.5.8-6.fc34.x86_64 libbrotli-1.=
0.9-4.fc34.x86_64 libcap-2.48-2.fc34.x86_64 libcom_err-1.45.6-5.fc34.x86_64=
 libcurl-7.76.1-12.fc34.x86_64 libgcc-11.2.1-9.fc34.x86_64 libidn2-2.3.2-1.=
fc34.x86_64 libnghttp2-1.43.0-2.fc34.x86_64 libpsl-0.21.1-3.fc34.x86_64 lib=
ssh-0.9.6-1.fc34.x86_64 libstdc++-11.2.1-9.fc34.x86_64 libunistring-0.9.10-=
10.fc34.x86_64 libunwind-1.4.0-5.fc34.x86_64 libuuid-2.36.2-1.fc34.x86_64 l=
ibxcrypt-4.4.28-1.fc34.x86_64 libzstd-1.5.2-1.fc34.x86_64 numactl-libs-2.0.=
14-3.fc34.x86_64 opencsd-1.1.1-1.fc34.x86_64 openldap-2.4.57-6.fc34.x86_64 =
openssl-libs-1.1.1l-2.fc34.x86_64 pcre-8.44-3.fc34.1.x86_64 perl-libs-5.32.=
1-477.fc34.x86_64 popt-1.18-4.fc34.x86_64 python3-libs-3.9.10-1.fc34.x86_64=
 slang-2.3.2-9.fc34.x86_64 xz-libs-5.2.5-5.fc34.x86_64
> (gdb) bt
> #0  0x0000000000596790 in create_perf_stat_counter (evsel=3D0xda9580, con=
fig=3D0xcbeac0 <stat_config>, target=3D0xcbe8a0 <target>, cpu_map_idx=3D0) =
at util/stat.c:548
> #1  0x0000000000438c2c in __run_perf_stat (argc=3D2, argv=3D0x7fffffffe1f=
0, run_idx=3D0) at builtin-stat.c:835
> #2  0x00000000004395d5 in run_perf_stat (argc=3D2, argv=3D0x7fffffffe1f0,=
 run_idx=3D0) at builtin-stat.c:1047
> #3  0x000000000043ce17 in cmd_stat (argc=3D2, argv=3D0x7fffffffe1f0) at b=
uiltin-stat.c:2561
> #4  0x00000000004dc2d1 in run_builtin (p=3D0xcd5760 <commands+288>, argc=
=3D4, argv=3D0x7fffffffe1f0) at perf.c:313
> #5  0x00000000004dc538 in handle_internal_command (argc=3D4, argv=3D0x7ff=
fffffe1f0) at perf.c:365
> #6  0x00000000004dc684 in run_argv (argcp=3D0x7fffffffe03c, argv=3D0x7fff=
ffffe030) at perf.c:409
> #7  0x00000000004dca50 in main (argc=3D4, argv=3D0x7fffffffe1f0) at perf.=
c:539
> (gdb) p leader
> $1 =3D (struct evsel *) 0x0
> (gdb) fr 1
> #1  0x0000000000438c2c in __run_perf_stat (argc=3D2, argv=3D0x7fffffffe1f=
0, run_idx=3D0) at builtin-stat.c:835
> 835                     if (create_perf_stat_counter(counter, &stat_confi=
g, &target,
> (gdb) p evsel_list
> $2 =3D (struct evlist *) 0xda9580
> (gdb) p evsel_list->core.nr_entries
> $3 =3D 0
> (gdb)
>
> I've bisected it to a patch I added that avoids setting up affinity when
> there is no need to do so, like when running 'perf stat sleep 1', this
> one:
>
> commit 49de179577e7b05b57f625bf05cdc60a72de38d0
> Author: Arnaldo Carvalho de Melo <acme@redhat.com>
> Date:   Mon Jan 17 13:09:29 2022 -0300
>
>     perf stat: No need to setup affinities when starting a workload
>
>     I.e. the simple:
>
>       $ perf stat sleep 1
>
>     Uses a dummy CPU map and thus there is no need to setup/cleanup
>     affinities to avoid IPIs, etc.
>
>     With this we're down to a sched_getaffinity() call, in the libnuma
>     initialization, that probably can be removed in a followup patch.
>
>     Acked-by: Ian Rogers <irogers@google.com>
>
> The problem is that when using --null we end up with an empty evlist
> and:
>
>   evlist__for_each_cpu(evlist_cpu_itr, evsel_list, affinity)
>
> in __run_perf_stat()
>
> gets called with affinity =3D=3D NULL.
>
> Looking at its code it checks if affinity is NULL, etc, so I thought it
> would be ok, but it ends up passing, IIRC, the empty list head:
>
> (gdb) p evsel->core.node
> $4 =3D {next =3D 0xda9580, prev =3D 0xda9580}
> (gdb) p evsel
> $5 =3D (struct evsel *) 0xda9580
> (gdb) fr 1
> #1  0x0000000000438c2c in __run_perf_stat (argc=3D2, argv=3D0x7fffffffe1f=
0, run_idx=3D0) at builtin-stat.c:835
> 835                     if (create_perf_stat_counter(counter, &stat_confi=
g, &target,
> (gdb) p evsel_list->core.entries
> $6 =3D {next =3D 0xda9580, prev =3D 0xda9580}
> (gdb)
>
> I.e. it gets confused with its end condition when
> evlist->core.nr_entries is zero.
>
> Can you take a look at improving this? I'm going AFK now, so just wanted
> to dump what I found so far.
>
> I guess the problem got introduced in:
>
> commit 472832d2c000b9611feaea66fe521055c3dbf17a
> Author: Ian Rogers <irogers@google.com>
> Date:   Tue Jan 4 22:13:37 2022 -0800
>
>     perf evlist: Refactor evlist__for_each_cpu()
>
>     Previously evlist__for_each_cpu() needed to iterate over the evlist i=
n
>     an inner loop and call "skip" routines. Refactor this so that the
>     iteratr is smarter and the next function can update both the current =
CPU
>     and evsel.
>
>     By using a cpu map index, fix apparent off-by-1 in __run_perf_stat's
>     call to perf_evsel__close_cpu().
>
> -----------------
>
> And was dormant as the affinity was being always setup, which we don't
> want when it isn't needed.

Thanks for the detailed report, I sent a fix in:
https://lore.kernel.org/lkml/20220316071049.2368250-1-irogers@google.com/
Any thoughts for a shell test to avoid this regressing again in the future?

Thanks,
Ian

> I'm trying to use:
>
>         perf trace --summary perf stat --null sleep 1
>
> to see what is that perf is unconditionally doing that should be
> deferred till it is really needed, for now I'll continue with:
>
> [root@five ~]# perf trace -s perf stat -e dummy sleep 1
>
>  Performance counter stats for 'sleep 1':
>
>                  0      dummy
>
>        1.000945692 seconds time elapsed
>
>        0.000000000 seconds user
>        0.000861000 seconds sys
>
>
>
>  Summary of events:
>
>  perf (900261), 3127 events, 94.7%
>
>    syscall            calls  errors  total       min       avg       max =
      stddev
>                                      (msec)    (msec)    (msec)    (msec)=
        (%)
>    --------------- --------  ------ -------- --------- --------- --------=
-     ------
>    wait4                  1      0  1000.903  1000.903  1000.903  1000.90=
3      0.00%
>    openat               364    187     1.144     0.002     0.003     0.02=
0      1.90%
>    mmap                 263      0     0.796     0.001     0.003     0.01=
5      2.60%
>    clone                  1      0     0.620     0.620     0.620     0.62=
0      0.00%
>    read                 263      0     0.441     0.001     0.002     0.09=
4     21.06%
>    access                80     49     0.277     0.002     0.003     0.00=
6      2.75%
>    mprotect              80      0     0.269     0.002     0.003     0.00=
6      3.15%
>    newfstatat           174      1     0.210     0.001     0.001     0.00=
7      3.57%
>    close                183      0     0.171     0.001     0.001     0.00=
3      1.64%
>    getdents64            35      0     0.065     0.001     0.002     0.01=
2     17.24%
>    write                 18      0     0.052     0.001     0.003     0.00=
9     15.24%
>    brk                   12      0     0.034     0.001     0.003     0.00=
5     11.27%
>    ioctl                 29     29     0.029     0.001     0.001     0.00=
3      8.38%
>    futex                 20      0     0.026     0.001     0.001     0.00=
2      8.30%
>    perf_event_open        1      0     0.016     0.016     0.016     0.01=
6      0.00%
>    statfs                 3      0     0.011     0.002     0.004     0.00=
6     38.92%
>    rt_sigaction           8      0     0.009     0.001     0.001     0.00=
2     12.76%
>    pread64                6      0     0.006     0.001     0.001     0.00=
1      1.44%
>    pipe                   2      0     0.006     0.002     0.003     0.00=
4     32.45%
>    rt_sigprocmask         4      0     0.006     0.001     0.001     0.00=
2     22.35%
>    prctl                  6      4     0.005     0.001     0.001     0.00=
1      6.86%
>    munmap                 1      0     0.004     0.004     0.004     0.00=
4      0.00%
>    kill                   1      0     0.003     0.003     0.003     0.00=
3      0.00%
>    arch_prctl             2      1     0.002     0.001     0.001     0.00=
1     11.96%
>    sysinfo                1      0     0.002     0.002     0.002     0.00=
2      0.00%
>    sched_getaffinity      1      0     0.001     0.001     0.001     0.00=
1      0.00%
>    getpid                 1      0     0.001     0.001     0.001     0.00=
1      0.00%
>    fcntl                  1      0     0.001     0.001     0.001     0.00=
1      0.00%
>    set_tid_address        1      0     0.001     0.001     0.001     0.00=
1      0.00%
>    prlimit64              1      0     0.001     0.001     0.001     0.00=
1      0.00%
>    set_robust_list        1      0     0.001     0.001     0.001     0.00=
1      0.00%
>    execve                 1      0     0.000     0.000     0.000     0.00=
0      0.00%
>
>
>  sleep (900262), 107 events, 3.2%
>
>    syscall            calls  errors  total       min       avg       max =
      stddev
>                                      (msec)    (msec)    (msec)    (msec)=
        (%)
>    --------------- --------  ------ -------- --------- --------- --------=
-     ------
>    clock_nanosleep        1      0  1000.050  1000.050  1000.050  1000.05=
0      0.00%
>    execve                 8      7     0.282     0.008     0.035     0.19=
8     66.26%
>    read                   2      0     0.058     0.002     0.029     0.05=
6     94.56%
>    mmap                   9      0     0.027     0.002     0.003     0.00=
5      9.92%
>    mprotect               4      0     0.015     0.003     0.004     0.00=
5     10.85%
>    close                  8      0     0.013     0.001     0.002     0.00=
3     13.67%
>    prctl                  1      0     0.012     0.012     0.012     0.01=
2      0.00%
>    openat                 3      0     0.010     0.003     0.003     0.00=
4      4.99%
>    arch_prctl             2      1     0.006     0.001     0.003     0.00=
5     68.42%
>    brk                    3      0     0.006     0.001     0.002     0.00=
2     21.26%
>    access                 1      1     0.005     0.005     0.005     0.00=
5      0.00%
>    munmap                 1      0     0.005     0.005     0.005     0.00=
5      0.00%
>    newfstatat             3      0     0.005     0.001     0.002     0.00=
2      8.55%
>    pread64                4      0     0.005     0.001     0.001     0.00=
1      5.39%
>    rt_sigaction           1      0     0.002     0.002     0.002     0.00=
2      0.00%
>    fcntl                  1      0     0.002     0.002     0.002     0.00=
2      0.00%
>    set_robust_list        1      0     0.002     0.002     0.002     0.00=
2      0.00%
>    clone                  1      0     0.000     0.000     0.000     0.00=
0      0.00%
>
>
> [root@five ~]#
>
> - Arnaldo
