Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADE0147A303
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Dec 2021 00:31:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233925AbhLSXbQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Dec 2021 18:31:16 -0500
Received: from mx1.riseup.net ([198.252.153.129]:45040 "EHLO mx1.riseup.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229628AbhLSXbP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Dec 2021 18:31:15 -0500
Received: from fews2.riseup.net (fews2-pn.riseup.net [10.0.1.84])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256
         client-signature RSA-PSS (2048 bits) client-digest SHA256)
        (Client CN "mail.riseup.net", Issuer "R3" (not verified))
        by mx1.riseup.net (Postfix) with ESMTPS id 4JHJrL2C4ZzF4cX;
        Sun, 19 Dec 2021 15:31:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=riseup.net; s=squak;
        t=1639956674; bh=ofrrWkTnLgCHmCZLAl5Y++KdB1wAoT8x+6ANCAoT8Vw=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=dEEjF4yIAZr03gHKjIqhVjVuJx7cV0A6kFEmcJUTFgoUspjs/Eg7T1TOyKJKHo97a
         06Mn0BgXR6xsxWDqPZd8xp/EMmc41ycY2VUn1U5d4R9jYEOT7i8pvlLh6Mbgu938G8
         aVPG4G5m7fcFgMqNC9lNwdregrcSMaeaZOnDlUFk=
X-Riseup-User-ID: 0318FE7131BEB3CCB7F3EB23A1CC30DD67B8B74EEED98BE88F09A503823954CC
Received: from [127.0.0.1] (localhost [127.0.0.1])
         by fews2.riseup.net (Postfix) with ESMTPSA id 4JHJrK4S7Zz1xmv;
        Sun, 19 Dec 2021 15:31:13 -0800 (PST)
From:   Francisco Jerez <currojerez@riseup.net>
To:     Julia Lawall <julia.lawall@inria.fr>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Len Brown <lenb@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: Re: cpufreq: intel_pstate: map utilization into the pstate range
In-Reply-To: <alpine.DEB.2.22.394.2112192312520.3181@hadrien>
References: <alpine.DEB.2.22.394.2112132215060.215073@hadrien>
 <CAJZ5v0iBU8gw8+-5nxj2cKzf7tyN=p3Adcm4Z5bn=oVYhU28bQ@mail.gmail.com>
 <alpine.DEB.2.22.394.2112172022100.2968@hadrien>
 <87r1abt1d2.fsf@riseup.net>
 <alpine.DEB.2.22.394.2112172258480.2968@hadrien>
 <87fsqqu6by.fsf@riseup.net>
 <alpine.DEB.2.22.394.2112180654470.3139@hadrien>
 <878rwitdu3.fsf@riseup.net>
 <alpine.DEB.2.22.394.2112181138210.3130@hadrien>
 <871r29tvdj.fsf@riseup.net>
 <alpine.DEB.2.22.394.2112190734070.3181@hadrien>
 <87wnk0s0tf.fsf@riseup.net>
 <alpine.DEB.2.22.394.2112192312520.3181@hadrien>
Date:   Sun, 19 Dec 2021 15:31:07 -0800
Message-ID: <87lf0grx38.fsf@riseup.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Julia Lawall <julia.lawall@inria.fr> writes:

> On Sun, 19 Dec 2021, Francisco Jerez wrote:
>
>> Julia Lawall <julia.lawall@inria.fr> writes:
>>
>> > On Sat, 18 Dec 2021, Francisco Jerez wrote:
>> >
>> >> Julia Lawall <julia.lawall@inria.fr> writes:
>> >>
>> >> > On Sat, 18 Dec 2021, Francisco Jerez wrote:
>> >> >
>> >> >> Julia Lawall <julia.lawall@inria.fr> writes:
>> >> >>
>> >> >> >> As you can see in intel_pstate.c, min_pstate is initialized on core
>> >> >> >> platforms from MSR_PLATFORM_INFO[47:40], which is "Maximum Efficiency
>> >> >> >> Ratio (R/O)".  However that seems to deviate massively from the most
>> >> >> >> efficient ratio on your system, which may indicate a firmware bug, some
>> >> >> >> sort of clock gating problem, or an issue with the way that
>> >> >> >> intel_pstate.c processes this information.
>> >> >> >
>> >> >> > I'm not sure to understand the bug part.  min_pstate gives the frequency
>> >> >> > that I find as the minimum frequency when I look for the specifications of
>> >> >> > the CPU.  Should one expect that it should be something different?
>> >> >> >
>> >> >>
>> >> >> I'd expect the minimum frequency on your processor specification to
>> >> >> roughly match the "Maximum Efficiency Ratio (R/O)" value from that MSR,
>> >> >> since there's little reason to claim your processor can be clocked down
>> >> >> to a frequency which is inherently inefficient /and/ slower than the
>> >> >> maximum efficiency ratio -- In fact they both seem to match in your
>> >> >> system, they're just nowhere close to the frequency which is actually
>> >> >> most efficient, which smells like a bug, like your processor
>> >> >> misreporting what the most efficient frequency is, or it deviating from
>> >> >> the expected one due to your CPU static power consumption being greater
>> >> >> than it would be expected to be under ideal conditions -- E.g. due to
>> >> >> some sort of clock gating issue, possibly due to a software bug, or due
>> >> >> to our scheduling of such workloads with a large amount of lightly
>> >> >> loaded threads being unnecessarily inefficient which could also be
>> >> >> preventing most of your CPU cores from ever being clock-gated even
>> >> >> though your processor may be sitting idle for a large fraction of their
>> >> >> runtime.
>> >> >
>> >> > The original mail has results from two different machines: Intel 6130
>> >> > (skylake) and Intel 5218 (cascade lake).  I have access to another cluster
>> >> > of 6130s and 5218s.  I can try them.
>> >> >
>> >> > I tried 5.9 in which I just commented out the schedutil code to make
>> >> > frequency requests.  I only tested avrora (tiny pauses) and h2 (longer
>> >> > pauses) and in both case the execution is almost entirely in the turbo
>> >> > frequencies.
>> >> >
>> >> > I'm not sure to understand the term "clock-gated".  What C state does that
>> >> > correspond to?  The turbostat output for one run of avrora is below.
>> >> >
>> >>
>> >> I didn't have any specific C1+ state in mind, most of the deeper ones
>> >> implement some sort of clock gating among other optimizations, I was
>> >> just wondering whether some sort of software bug and/or the highly
>> >> intermittent CPU utilization pattern of these workloads are preventing
>> >> most of your CPU cores from entering deep sleep states.  See below.
>> >>
>> >> > julia
>> >> >
>> >> > 78.062895 sec
>> >> > Package Core  CPU     Avg_MHz Busy%   Bzy_MHz TSC_MHz IRQ     SMI     POLL    C1      C1E     C6      POLL%   C1%     C1E%    C6%     CPU%c1  CPU%c6  CoreTmp PkgTmp  Pkg%pc2 Pkg%pc6 Pkg_J   RAM_J   PKG_%   RAM_%
>> >> > -     -       -       31      2.95    1065    2096    156134  0       1971    155458  2956270 657130  0.00    0.20    4.78    92.26   14.75   82.31   40      41      45.14   0.04    4747.52 2509.05 0.00    0.00
>> >> > 0     0       0       13      1.15    1132    2095    11360   0       0       2       39      19209   0.00    0.00    0.01    99.01   8.02    90.83   39      41      90.24   0.04    2266.04 1346.09 0.00    0.00
>> >>
>> >> This seems suspicious:                                                                                                                                                          ^^^^    ^^^^^^^
>> >>
>> >> I hadn't understood that you're running this on a dual-socket system
>> >> until I looked at these results.
>> >
>> > Sorry not to have mentioned that.
>> >
>> >> It seems like package #0 is doing
>> >> pretty much nothing according to the stats below, but it's still
>> >> consuming nearly half of your energy, apparently because the idle
>> >> package #0 isn't entering deep sleep states (Pkg%pc6 above is close to
>> >> 0%).  That could explain your unexpectedly high static power consumption
>> >> and the deviation of the real maximum efficiency frequency from the one
>> >> reported by your processor, since the reported maximum efficiency ratio
>> >> cannot possibly take into account the existence of a second CPU package
>> >> with dysfunctional idle management.
>> >
>> > Our assumption was that if anything happens on any core, all of the
>> > packages remain in a state that allows them to react in a reasonable
>> > amount of time ot any memory request.
>>
>> I can see how that might be helpful for workloads that need to be able
>> to unleash the whole processing power of your multi-socket system with
>> minimal latency, but the majority of multi-socket systems out there with
>> completely idle CPU packages are unlikely to notice any performance
>> difference as long as their idle CPU packages are idle, so the
>> environmentalist in me tells me that this is a bad idea. ;)
>
> Certainly it sounds like a bad idea from the point of view of anyone who
> wants to save energy, but it's how the machine seems to work (at least in
> its current configuration, which is not entirely under my control).
>

Yes that seems to be how it works right now, but honestly it seems like
an idle management bug to me.

> Note also that of the benchmarks, only avrora has the property of often
> using only one of the sockets.  The others let their threads drift around
> more.
>
>>
>> >
>> >> I'm guessing that if you fully disable one of your CPU packages and
>> >> repeat the previous experiment forcing various P-states between 10 and
>> >> 37 you should get a maximum efficiency ratio closer to the theoretical
>> >> one for this CPU?
>> >
>> > OK, but that's not really a natural usage context...  I do have a
>> > one-socket Intel 5220.  I'll see what happens there.
>> >
>>
>> Fair, I didn't intend to suggest you take it offline manually every time
>> you don't plan to use it, my suggestion was just intended as an
>> experiment to help us confirm or disprove the theory that the reason for
>> the deviation from reality of your reported maximum efficiency ratio is
>> the presence of that second CPU package with broken idle management.  If
>> that's the case the P-state vs. energy usage plot should show a minimum
>> closer to the ideal maximum efficiency ratio after disabling the second
>> CPU package.
>
> More numbers are attached.  Pages 1-3 have two socket machines.  Page 4
> has a one socket machine.  The values for p state 20 are highlighted.
> For avrora (the one-socket application) on page 2, 20 is not the pstate
> with the lowest CPU energy consumption.  35 and 37 do better.  Also for
> xalan on page 4 (one-socket machine) 15 does slightly better than 20.
> Otherwise, 20 always seems to be the best.
>

It seems like your results suggest that the presence of a second CPU
package cannot be the only factor leading to this deviation, however
it's hard to tell how much of an influence it's having on that
deviation, since your single- and dual-socket samples are taken from
machines with different CPUs so it's unclear whether moving to a single
CPU has led to a shift of the maximum efficiency frequency, and if it
has it may have had a smaller impact than the ~5 P-state granularity of
your samples.

Either way it seems like we're greatly underestimating the maximum
efficiency frequency even on your single-socket system.  The reason may
still be suboptimal idle management -- I hope it is, since the
alternative that your processor is lying about its maximum efficiency
ratio seems far more difficult to deal with as some generic software
change...

>> > I did some experiements with forcing different frequencies.  I haven't
>> > finished processing the results, but I notice that as the frequency goes
>> > up, the utilization (specifically the value of
>> > map_util_perf(sg_cpu->util) at the point of the call to
>> > cpufreq_driver_adjust_perf in sugov_update_single_perf) goes up as well.
>> > Is this expected?
>> >
>>
>> Actually, it *is* expected based on our previous hypothesis that these
>> workloads are largely latency-bound: In cases where a given burst of CPU
>> work is not parallelizable with any other tasks the thread needs to
>> complete subsequently, its overall runtime will decrease monotonically
>> with increasing frequency, therefore the number of instructions executed
>> per unit of time will increase monotonically with increasing frequency,
>> and with it its frequency-invariant utilization.
>
> I'm not sure.  If you have two tasks, each one alternately waiting for the
> other, if the frequency doubles, they will each run faster and wait less,
> but as long as one is computing the utilization in a small interval, ie
> before the application ends, the utilization will always be 50%.

Not really, because we're talking about frequency-invariant utilization
rather than just the CPU's duty cycle (which may indeed remain at 50%
regardless).  If the frequency doubles and the thread is still active
50% of the time its frequency-invariant utilization will also double,
since the thread would be utilizing twice as many computational
resources per unit of time as before.  As you can see in the definition
in [1], the frequency-invariant utilization is scaled by the running
frequency of the thread.

[1] Documentation/scheduler/sched-capacity.rst

> The applications, however, are probably not as simple as this.
>
> julia
>
>> > thanks,
>> > julia
>> >
>> >> > 0     0       32      1       0.09    1001    2095    37      0       0       0       0       42      0.00    0.00    0.00    100.00  9.08
>> >> > 0     1       4       0       0.04    1000    2095    57      0       0       0       1       133     0.00    0.00    0.00    99.96   0.08    99.88   38
>> >> > 0     1       36      0       0.00    1000    2095    35      0       0       0       0       40      0.00    0.00    0.00    100.00  0.12
>> >> > 0     2       8       0       0.03    1000    2095    64      0       0       0       1       124     0.00    0.00    0.00    99.97   0.08    99.89   38
>> >> > 0     2       40      0       0.00    1000    2095    36      0       0       0       0       40      0.00    0.00    0.00    100.00  0.10
>> >> > 0     3       12      0       0.00    1000    2095    42      0       0       0       0       71      0.00    0.00    0.00    100.00  0.14    99.86   38
>> >> > 0     3       44      1       0.09    1000    2095    63      0       0       0       0       65      0.00    0.00    0.00    99.91   0.05
>> >> > 0     4       14      0       0.00    1010    2095    38      0       0       0       1       41      0.00    0.00    0.00    100.00  0.04    99.96   39
>> >> > 0     4       46      0       0.00    1011    2095    36      0       0       0       1       41      0.00    0.00    0.00    100.00  0.04
>> >> > 0     5       10      0       0.01    1084    2095    39      0       0       0       0       58      0.00    0.00    0.00    99.99   0.04    99.95   38
>> >> > 0     5       42      0       0.00    1114    2095    35      0       0       0       0       39      0.00    0.00    0.00    100.00  0.05
>> >> > 0     6       6       0       0.03    1005    2095    89      0       0       0       1       116     0.00    0.00    0.00    99.97   0.07    99.90   39
>> >> > 0     6       38      0       0.00    1000    2095    38      0       0       0       0       41      0.00    0.00    0.00    100.00  0.10
>> >> > 0     7       2       0       0.05    1001    2095    59      0       0       0       1       133     0.00    0.00    0.00    99.95   0.09    99.86   40
>> >> > 0     7       34      0       0.00    1000    2095    39      0       0       0       0       65      0.00    0.00    0.00    100.00  0.13
>> >> > 0     8       16      0       0.00    1000    2095    43      0       0       0       0       47      0.00    0.00    0.00    100.00  0.04    99.96   38
>> >> > 0     8       48      0       0.00    1000    2095    37      0       0       0       0       41      0.00    0.00    0.00    100.00  0.04
>> >> > 0     9       20      0       0.00    1000    2095    33      0       0       0       0       37      0.00    0.00    0.00    100.00  0.03    99.97   38
>> >> > 0     9       52      0       0.00    1000    2095    33      0       0       0       0       36      0.00    0.00    0.00    100.00  0.03
>> >> > 0     10      24      0       0.00    1000    2095    36      0       0       0       1       40      0.00    0.00    0.00    100.00  0.03    99.96   39
>> >> > 0     10      56      0       0.00    1000    2095    37      0       0       0       1       38      0.00    0.00    0.00    100.00  0.03
>> >> > 0     11      28      0       0.00    1002    2095    35      0       0       0       1       37      0.00    0.00    0.00    100.00  0.03    99.97   38
>> >> > 0     11      60      0       0.00    1004    2095    34      0       0       0       0       36      0.00    0.00    0.00    100.00  0.03
>> >> > 0     12      30      0       0.00    1001    2095    35      0       0       0       0       40      0.00    0.00    0.00    100.00  0.11    99.88   38
>> >> > 0     12      62      0       0.01    1000    2095    197     0       0       0       0       197     0.00    0.00    0.00    99.99   0.10
>> >> > 0     13      26      0       0.00    1000    2095    37      0       0       0       0       41      0.00    0.00    0.00    100.00  0.03    99.97   39
>> >> > 0     13      58      0       0.00    1000    2095    38      0       0       0       0       40      0.00    0.00    0.00    100.00  0.03
>> >> > 0     14      22      0       0.01    1000    2095    149     0       1       2       0       142     0.00    0.01    0.00    99.99   0.07    99.92   39
>> >> > 0     14      54      0       0.00    1000    2095    35      0       0       0       0       38      0.00    0.00    0.00    100.00  0.07
>> >> > 0     15      18      0       0.00    1000    2095    33      0       0       0       0       36      0.00    0.00    0.00    100.00  0.03    99.97   39
>> >> > 0     15      50      0       0.00    1000    2095    34      0       0       0       0       38      0.00    0.00    0.00    100.00  0.03
>> >> > 1     0       1       32      3.23    1008    2095    2385    0       31      3190    45025   10144   0.00    0.28    4.68    91.99   11.21   85.56   32      35      0.04    0.04    2481.49 1162.96 0.00    0.00
>> >> > 1     0       33      9       0.63    1404    2095    12206   0       5       162     2480    10283   0.00    0.04    0.75    98.64   13.81
>> >> > 1     1       5       1       0.07    1384    2095    236     0       0       38      24      314     0.00    0.09    0.06    99.77   4.66    95.27   33
>> >> > 1     1       37      81      3.93    2060    2095    1254    0       5       40      59      683     0.00    0.01    0.02    96.05   0.80
>> >> > 1     2       9       37      3.46    1067    2095    2396    0       29      2256    55406   11731   0.00    0.17    6.02    90.54   54.10   42.44   31
>> >> > 1     2       41      151     14.51   1042    2095    10447   0       135     10494   248077  42327   0.01    0.87    26.57   58.84   43.05
>> >> > 1     3       13      110     10.47   1053    2095    7120    0       120     9218    168938  33884   0.01    0.77    16.63   72.68   42.58   46.95   32
>> >> > 1     3       45      69      6.76    1021    2095    4730    0       66      5598    115410  23447   0.00    0.44    12.06   81.12   46.29
>> >> > 1     4       15      112     10.64   1056    2095    7204    0       116     8831    171423  37754   0.01    0.70    17.56   71.67   28.01   61.35   33
>> >> > 1     4       47      18      1.80    1006    2095    1771    0       13      915     29315   6564    0.00    0.07    3.20    95.03   36.85
>> >> > 1     5       11      63      5.96    1065    2095    4090    0       58      6449    99015   18955   0.00    0.45    10.27   83.64   31.24   62.80   31
>> >> > 1     5       43      72      7.11    1016    2095    4794    0       73      6203    115361  26494   0.00    0.48    11.79   81.02   30.09
>> >> > 1     6       7       35      3.39    1022    2095    2328    0       45      3377    52721   13759   0.00    0.27    5.10    91.43   25.84   70.77   32
>> >> > 1     6       39      67      6.09    1096    2095    4483    0       52      3696    94964   19366   0.00    0.30    10.32   83.61   23.14
>> >> > 1     7       3       1       0.06    1395    2095    91      0       0       0       1       167     0.00    0.00    0.00    99.95   25.36   74.58   35
>> >> > 1     7       35      83      8.16    1024    2095    5785    0       100     7398    134640  27428   0.00    0.56    13.39   78.34   17.26
>> >> > 1     8       17      46      4.49    1016    2095    3229    0       52      3048    74914   16010   0.00    0.27    8.29    87.19   29.71   65.80   33
>> >> > 1     8       49      64      6.12    1052    2095    4210    0       89      5782    100570  21463   0.00    0.42    10.63   83.17   28.08
>> >> > 1     9       21      73      7.02    1036    2095    4917    0       64      5786    109887  21939   0.00    0.55    11.61   81.18   22.10   70.88   33
>> >> > 1     9       53      64      6.33    1012    2095    4074    0       69      5957    97596   20580   0.00    0.51    9.78    83.74   22.79
>> >> > 1     10      25      26      2.58    1013    2095    1825    0       22      2124    42630   8627    0.00    0.17    4.17    93.24   53.91   43.52   33
>> >> > 1     10      57      159     15.59   1022    2095    10951   0       175     14237   256828  56810   0.01    1.10    26.00   58.16   40.89
>> >> > 1     11      29      112     10.54   1065    2095    7462    0       126     9548    179206  39821   0.01    0.85    18.49   70.71   29.46   60.00   31
>> >> > 1     11      61      29      2.89    1011    2095    2002    0       24      2468    45558   10288   0.00    0.20    4.71    92.36   37.11
>> >> > 1     12      31      37      3.66    1011    2095    2596    0       79      3161    61027   13292   0.00    0.24    6.48    89.79   23.75   72.59   32
>> >> > 1     12      63      56      5.08    1107    2095    3789    0       62      4777    79133   17089   0.00    0.41    7.91    86.86   22.31
>> >> > 1     13      27      12      1.14    1045    2095    1477    0       16      888     18744   3250    0.00    0.06    2.18    96.70   21.23   77.64   32
>> >> > 1     13      59      60      5.81    1038    2095    5230    0       60      4936    87225   21402   0.00    0.41    8.95    85.14   16.55
>> >> > 1     14      23      28      2.75    1024    2095    2008    0       20      1839    47417   9177    0.00    0.13    5.08    92.21   34.18   63.07   32
>> >> > 1     14      55      106     9.58    1105    2095    6292    0       89      7182    141379  31354   0.00    0.63    14.45   75.81   27.36
>> >> > 1     15      19      118     11.65   1012    2095    7872    0       121     10014   193186  40448   0.01    0.80    19.53   68.68   37.53   50.82   32
>> >> > 1     15      51      59      5.58    1059    2095    3967    0       54      5842    88063   21138   0.00    0.39    9.12    85.23   43.60
>> >>
>>
