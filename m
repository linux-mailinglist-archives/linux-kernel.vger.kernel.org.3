Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D2574D9B9B
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 13:50:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348500AbiCOMvR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 08:51:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348494AbiCOMvM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 08:51:12 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45CE349C9E
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 05:50:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EA054B81636
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 12:49:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54109C340E8;
        Tue, 15 Mar 2022 12:49:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647348597;
        bh=GQi+Mk8CaO7M1q/tv2FzaVzOwe4zE8I9zScA3Q1gXgo=;
        h=Date:From:To:Cc:Subject:From;
        b=OHzTnH2jrIuXyXQ99SJ4IPcg/HzKCZeqq06MtrQxgdw/BtZPXpMZvs/fk54TwYtTp
         TlIdMOegagexnm2/ddfKno5HLHK7q4+iIt6xTeveQww0GfIBiPP+bH1OO+HNVZR1GF
         9R1W8DMrYRs+iyJwKocOQlCPlzLNpSnGTtOPMVDTUDqOnHdUltmMRbFZCgx9t+hMIH
         MQkZ/MUfnVR1KYyx5wrfdyzLCHD5wOiac5zzlDlE2hiftzoGOkYdKHRO+dBaZJ4JpJ
         8FGLAuF44kHIDy6VBR5ACOeZctKISCjX6zI0ZkMzSeluwuhxAdFERSdqlKZK5JzMAK
         vzeBRwtx1BKKA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id CAAE040407; Tue, 15 Mar 2022 09:49:54 -0300 (-03)
Date:   Tue, 15 Mar 2022 09:49:54 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ian Rogers <irogers@google.com>
Cc:     Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: 'perf stat --null sleep 1' segfault related to
 evlist__for_each_entry with affinity == NULL
Message-ID: <YjCLcpcX2peeQVCH@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This bounced yesterday, resending :-\

-----

Hi Ian,

	I just noticed this:

(gdb) run stat --null sleep 1
`/var/home/acme/bin/perf' has changed; re-reading symbols.
Starting program: /var/home/acme/bin/perf stat --null sleep 1
[Thread debugging using libthread_db enabled]
Using host libthread_db library "/lib64/libthread_db.so.1".
[Detaching after fork from child process 900002]

Program received signal SIGSEGV, Segmentation fault.
0x0000000000596790 in create_perf_stat_counter (evsel=3D0xda9580, config=3D=
0xcbeac0 <stat_config>, target=3D0xcbe8a0 <target>, cpu_map_idx=3D0) at uti=
l/stat.c:548
548		if (leader->core.nr_members > 1)
Missing separate debuginfos, use: dnf debuginfo-install bzip2-libs-1.0.8-6.=
fc34.x86_64 cyrus-sasl-lib-2.1.27-8.fc34.x86_64 elfutils-debuginfod-client-=
0.186-1.fc34.x86_64 elfutils-libelf-0.186-1.fc34.x86_64 elfutils-libs-0.186=
-1.fc34.x86_64 glib2-2.68.4-1.fc34.x86_64 glibc-2.33-21.fc34.x86_64 keyutil=
s-libs-1.6.1-2.fc34.x86_64 libbabeltrace-1.5.8-6.fc34.x86_64 libbrotli-1.0.=
9-4.fc34.x86_64 libcap-2.48-2.fc34.x86_64 libcom_err-1.45.6-5.fc34.x86_64 l=
ibcurl-7.76.1-12.fc34.x86_64 libgcc-11.2.1-9.fc34.x86_64 libidn2-2.3.2-1.fc=
34.x86_64 libnghttp2-1.43.0-2.fc34.x86_64 libpsl-0.21.1-3.fc34.x86_64 libss=
h-0.9.6-1.fc34.x86_64 libstdc++-11.2.1-9.fc34.x86_64 libunistring-0.9.10-10=
=2Efc34.x86_64 libunwind-1.4.0-5.fc34.x86_64 libuuid-2.36.2-1.fc34.x86_64 l=
ibxcrypt-4.4.28-1.fc34.x86_64 libzstd-1.5.2-1.fc34.x86_64 numactl-libs-2.0.=
14-3.fc34.x86_64 opencsd-1.1.1-1.fc34.x86_64 openldap-2.4.57-6.fc34.x86_64 =
openssl-libs-1.1.1l-2.fc34.x86_64 pcre-8.44-3.fc34.1.x86_64 perl-libs-5.32.=
1-477.fc34.x86_64 popt-1.18-4.fc34.x86_64 python3-libs-3.9.10-1.fc34.x86_64=
 slang-2.3.2-9.fc34.x86_64 xz-libs-5.2.5-5.fc34.x86_64
(gdb) bt
#0  0x0000000000596790 in create_perf_stat_counter (evsel=3D0xda9580, confi=
g=3D0xcbeac0 <stat_config>, target=3D0xcbe8a0 <target>, cpu_map_idx=3D0) at=
 util/stat.c:548
#1  0x0000000000438c2c in __run_perf_stat (argc=3D2, argv=3D0x7fffffffe1f0,=
 run_idx=3D0) at builtin-stat.c:835
#2  0x00000000004395d5 in run_perf_stat (argc=3D2, argv=3D0x7fffffffe1f0, r=
un_idx=3D0) at builtin-stat.c:1047
#3  0x000000000043ce17 in cmd_stat (argc=3D2, argv=3D0x7fffffffe1f0) at bui=
ltin-stat.c:2561
#4  0x00000000004dc2d1 in run_builtin (p=3D0xcd5760 <commands+288>, argc=3D=
4, argv=3D0x7fffffffe1f0) at perf.c:313
#5  0x00000000004dc538 in handle_internal_command (argc=3D4, argv=3D0x7ffff=
fffe1f0) at perf.c:365
#6  0x00000000004dc684 in run_argv (argcp=3D0x7fffffffe03c, argv=3D0x7fffff=
ffe030) at perf.c:409
#7  0x00000000004dca50 in main (argc=3D4, argv=3D0x7fffffffe1f0) at perf.c:=
539
(gdb) p leader
$1 =3D (struct evsel *) 0x0
(gdb) fr 1
#1  0x0000000000438c2c in __run_perf_stat (argc=3D2, argv=3D0x7fffffffe1f0,=
 run_idx=3D0) at builtin-stat.c:835
835			if (create_perf_stat_counter(counter, &stat_config, &target,
(gdb) p evsel_list
$2 =3D (struct evlist *) 0xda9580
(gdb) p evsel_list->core.nr_entries
$3 =3D 0
(gdb)

I've bisected it to a patch I added that avoids setting up affinity when
there is no need to do so, like when running 'perf stat sleep 1', this
one:

commit 49de179577e7b05b57f625bf05cdc60a72de38d0
Author: Arnaldo Carvalho de Melo <acme@redhat.com>
Date:   Mon Jan 17 13:09:29 2022 -0300

    perf stat: No need to setup affinities when starting a workload

    I.e. the simple:

      $ perf stat sleep 1

    Uses a dummy CPU map and thus there is no need to setup/cleanup
    affinities to avoid IPIs, etc.

    With this we're down to a sched_getaffinity() call, in the libnuma
    initialization, that probably can be removed in a followup patch.

    Acked-by: Ian Rogers <irogers@google.com>

The problem is that when using --null we end up with an empty evlist
and:

  evlist__for_each_cpu(evlist_cpu_itr, evsel_list, affinity)

in __run_perf_stat()

gets called with affinity =3D=3D NULL.

Looking at its code it checks if affinity is NULL, etc, so I thought it
would be ok, but it ends up passing, IIRC, the empty list head:

(gdb) p evsel->core.node
$4 =3D {next =3D 0xda9580, prev =3D 0xda9580}
(gdb) p evsel
$5 =3D (struct evsel *) 0xda9580
(gdb) fr 1
#1  0x0000000000438c2c in __run_perf_stat (argc=3D2, argv=3D0x7fffffffe1f0,=
 run_idx=3D0) at builtin-stat.c:835
835			if (create_perf_stat_counter(counter, &stat_config, &target,
(gdb) p evsel_list->core.entries
$6 =3D {next =3D 0xda9580, prev =3D 0xda9580}
(gdb)

I.e. it gets confused with its end condition when
evlist->core.nr_entries is zero.

Can you take a look at improving this? I'm going AFK now, so just wanted
to dump what I found so far.

I guess the problem got introduced in:

commit 472832d2c000b9611feaea66fe521055c3dbf17a
Author: Ian Rogers <irogers@google.com>
Date:   Tue Jan 4 22:13:37 2022 -0800

    perf evlist: Refactor evlist__for_each_cpu()

    Previously evlist__for_each_cpu() needed to iterate over the evlist in
    an inner loop and call "skip" routines. Refactor this so that the
    iteratr is smarter and the next function can update both the current CPU
    and evsel.

    By using a cpu map index, fix apparent off-by-1 in __run_perf_stat's
    call to perf_evsel__close_cpu().

-----------------

And was dormant as the affinity was being always setup, which we don't
want when it isn't needed.

I'm trying to use:

	perf trace --summary perf stat --null sleep 1

to see what is that perf is unconditionally doing that should be
deferred till it is really needed, for now I'll continue with:

[root@five ~]# perf trace -s perf stat -e dummy sleep 1

 Performance counter stats for 'sleep 1':

                 0      dummy                                              =
        =20

       1.000945692 seconds time elapsed

       0.000000000 seconds user
       0.000861000 seconds sys



 Summary of events:

 perf (900261), 3127 events, 94.7%

   syscall            calls  errors  total       min       avg       max   =
    stddev
                                     (msec)    (msec)    (msec)    (msec)  =
      (%)
   --------------- --------  ------ -------- --------- --------- --------- =
    ------
   wait4                  1      0  1000.903  1000.903  1000.903  1000.903 =
     0.00%
   openat               364    187     1.144     0.002     0.003     0.020 =
     1.90%
   mmap                 263      0     0.796     0.001     0.003     0.015 =
     2.60%
   clone                  1      0     0.620     0.620     0.620     0.620 =
     0.00%
   read                 263      0     0.441     0.001     0.002     0.094 =
    21.06%
   access                80     49     0.277     0.002     0.003     0.006 =
     2.75%
   mprotect              80      0     0.269     0.002     0.003     0.006 =
     3.15%
   newfstatat           174      1     0.210     0.001     0.001     0.007 =
     3.57%
   close                183      0     0.171     0.001     0.001     0.003 =
     1.64%
   getdents64            35      0     0.065     0.001     0.002     0.012 =
    17.24%
   write                 18      0     0.052     0.001     0.003     0.009 =
    15.24%
   brk                   12      0     0.034     0.001     0.003     0.005 =
    11.27%
   ioctl                 29     29     0.029     0.001     0.001     0.003 =
     8.38%
   futex                 20      0     0.026     0.001     0.001     0.002 =
     8.30%
   perf_event_open        1      0     0.016     0.016     0.016     0.016 =
     0.00%
   statfs                 3      0     0.011     0.002     0.004     0.006 =
    38.92%
   rt_sigaction           8      0     0.009     0.001     0.001     0.002 =
    12.76%
   pread64                6      0     0.006     0.001     0.001     0.001 =
     1.44%
   pipe                   2      0     0.006     0.002     0.003     0.004 =
    32.45%
   rt_sigprocmask         4      0     0.006     0.001     0.001     0.002 =
    22.35%
   prctl                  6      4     0.005     0.001     0.001     0.001 =
     6.86%
   munmap                 1      0     0.004     0.004     0.004     0.004 =
     0.00%
   kill                   1      0     0.003     0.003     0.003     0.003 =
     0.00%
   arch_prctl             2      1     0.002     0.001     0.001     0.001 =
    11.96%
   sysinfo                1      0     0.002     0.002     0.002     0.002 =
     0.00%
   sched_getaffinity      1      0     0.001     0.001     0.001     0.001 =
     0.00%
   getpid                 1      0     0.001     0.001     0.001     0.001 =
     0.00%
   fcntl                  1      0     0.001     0.001     0.001     0.001 =
     0.00%
   set_tid_address        1      0     0.001     0.001     0.001     0.001 =
     0.00%
   prlimit64              1      0     0.001     0.001     0.001     0.001 =
     0.00%
   set_robust_list        1      0     0.001     0.001     0.001     0.001 =
     0.00%
   execve                 1      0     0.000     0.000     0.000     0.000 =
     0.00%


 sleep (900262), 107 events, 3.2%

   syscall            calls  errors  total       min       avg       max   =
    stddev
                                     (msec)    (msec)    (msec)    (msec)  =
      (%)
   --------------- --------  ------ -------- --------- --------- --------- =
    ------
   clock_nanosleep        1      0  1000.050  1000.050  1000.050  1000.050 =
     0.00%
   execve                 8      7     0.282     0.008     0.035     0.198 =
    66.26%
   read                   2      0     0.058     0.002     0.029     0.056 =
    94.56%
   mmap                   9      0     0.027     0.002     0.003     0.005 =
     9.92%
   mprotect               4      0     0.015     0.003     0.004     0.005 =
    10.85%
   close                  8      0     0.013     0.001     0.002     0.003 =
    13.67%
   prctl                  1      0     0.012     0.012     0.012     0.012 =
     0.00%
   openat                 3      0     0.010     0.003     0.003     0.004 =
     4.99%
   arch_prctl             2      1     0.006     0.001     0.003     0.005 =
    68.42%
   brk                    3      0     0.006     0.001     0.002     0.002 =
    21.26%
   access                 1      1     0.005     0.005     0.005     0.005 =
     0.00%
   munmap                 1      0     0.005     0.005     0.005     0.005 =
     0.00%
   newfstatat             3      0     0.005     0.001     0.002     0.002 =
     8.55%
   pread64                4      0     0.005     0.001     0.001     0.001 =
     5.39%
   rt_sigaction           1      0     0.002     0.002     0.002     0.002 =
     0.00%
   fcntl                  1      0     0.002     0.002     0.002     0.002 =
     0.00%
   set_robust_list        1      0     0.002     0.002     0.002     0.002 =
     0.00%
   clone                  1      0     0.000     0.000     0.000     0.000 =
     0.00%


[root@five ~]#

- Arnaldo
