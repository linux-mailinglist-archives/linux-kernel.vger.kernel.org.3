Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D67C04EC778
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 16:53:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347558AbiC3Oyn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 10:54:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347694AbiC3Ow5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 10:52:57 -0400
Received: from mail-0201.mail-europe.com (mail-0201.mail-europe.com [51.77.79.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2C8549244
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 07:50:58 -0700 (PDT)
Date:   Wed, 30 Mar 2022 14:50:45 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=michaelmarod.com;
        s=protonmail; t=1648651850;
        bh=/cdd9dnBqCUPdFnZXztmHrFsm1vmke5W3heCEaonUtI=;
        h=Date:To:From:Reply-To:Subject:Message-ID:In-Reply-To:References:
         From:To:Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID;
        b=ErvtgQN8hM+YuKTL0xEfOBh/ulOf8/WVJUHaUvIFwJAiyzJEa5jSr4OofyXLJwcSw
         DfKoFwWT5jkWptB0Ohi1uWqKGGf11JzP7Sfr1V70OHoYY/SMl/w9r7D+3rhwlLHw5N
         FaDm1sEi/0qBNm3Zfowujgtxg5yCrjsHocqDnMuA=
To:     linux-kernel@vger.kernel.org
From:   Michael Marod <michael@michaelmarod.com>
Reply-To: Michael Marod <michael@michaelmarod.com>
Subject: Re: NVME performance regression in Linux 5.x due to lack of block level IO queueing
Message-ID: <847D3821-1D92-468C-88C3-34284BA7922E@michaelmarod.com>
In-Reply-To: <51E3A396-F68B-496D-AE36-B0457A3B0968@michaelmarod.com>
References: <51E3A396-F68B-496D-AE36-B0457A3B0968@michaelmarod.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix: There were 0 "IO unplugs" and 5 "Timer unplugs" on the Linux 4.4.0 ins=
tance and 5 "IO unplugs" and 0 "Timer unplugs" on the Linux 5.4.0 one.

> On Mar 30, 2022, at 10:31 AM, Michael Marod <michael@michaelmarod.com> wr=
ote:
>
> It has been noticed in an AWS Cloud environment that the IO performance o=
n an Ubuntu Bionic 18.04 i3 instance with Linux 5.4.0 is significantly wors=
e than that of an Ubuntu Xenial 16.04 i3 instance with Linux 4.4.0. I've be=
en digging into the issue and it seems like block level queueing is not wor=
king as well (if at all?) on the Linux 5 instance. When I've run performanc=
e tests using fio, iostat reports 0.00 average queue size for the Linux 5.4=
.0 instance but goes up to 0.5 or higher on the 4.4.0 one.
>
> In my setup, I have 2 NVMe devices (/dev/nvme0n1 and /dev/nvme1n1) config=
ured in a raid0 on /dev/md127 which is mounted on /opt. I've tested devices=
 directly and through the RAID controller and it does not seem to make a di=
fference. In the output below I am writing through /opt which exercises the=
 file system and RAID controller. Also, fio was compiled from source with l=
atest version on both instances.
>
> # fio -name=3Drandrw -filename=3D/opt/testfile -direct=3D1 -thread -rw=3D=
randrw -ioengine=3Dpsync -bs=3D4k -size=3D10G -numjobs=3D1 -group_reporting=
=3D1 -runtime=3D120
>
> Note: these are different versions of iostat which is why the output is d=
ifferent
>
> # Linux 4.4.0-1137-aws:
> Device:         rrqm/s   wrqm/s     r/s     w/s    rkB/s    wkB/s avgrq-s=
z avgqu-sz   await r_await w_await  svctm  %util
> nvme1n1           0.00     0.00 3248.00 3173.00 12992.00 12692.00     8.0=
0     0.44    0.07    0.10    0.03   0.07  44.00
> nvme0n1           0.00     0.00 3229.00 3292.00 12916.00 13168.00     8.0=
0     0.47    0.07    0.10    0.04   0.07  46.80
>
> # Linux 5.4.0-1068-aws:
> Device            r/s     w/s     rkB/s     wkB/s   rrqm/s   wrqm/s  %rrq=
m  %wrqm r_await w_await aqu-sz rareq-sz wareq-sz  svctm  %util
> nvme0n1       2842.57 2789.11  11370.30  11156.44     0.00     0.00   0.0=
0   0.00    0.10    0.04   0.00     4.00     4.00   0.18  99.01
> nvme1n1       2849.50 2748.51  11398.02  10994.06     0.00     0.00   0.0=
0   0.00    0.10    0.04   0.00     4.00     4.00   0.18  99.01
>
> For another (possibly simpler) demonstration -- I ran blktrace/blkparse o=
n both Linux 4.4.0 and 5.5.0 instances with the same hardware (i3.4xlarge).=
 Then I used fio to do a simple stress test that sends 5 write requests.
>
> # fio -name=3Dwrite -filename=3D/opt/testfile -direct=3D1 -thread -rw=3Dw=
rite, -ioengine=3Dpsync -bs=3D4k -size=3D4k -numjobs=3D5 -group_reporting=
=3D1 -runtime=3D5
>
> The blkparse output shows that the Linux 4.4.0 instance had 5 "Writes Que=
ued" while the Linux 5.4.0 one had 0. Additionally, there were 0 "IO unplug=
s" and 5 "Timer unplugs" on the Linux 4.4.0 instance and 5 "Timer unplugs" =
and 0 "IO unplugs" on the Linux 5.4.0 one.
>
> // On the Bionic machine with Linux 5.4.0-1068-aws #72~18.04.1-Ubuntu SMP=
 Thu Mar 3 08:49:49 UTC 2022 x86_64 x86_64 x86_64 GNU/Linux:
> # blktrace -d /dev/nvme0n1 -d /dev/nvme1n1 -o - | blkparse -i -
> 259,0   12        1     0.000000000 114067  A  WS 401408 + 8 <- (9,127) 2=
74432
> 259,0   12        2     0.000003433 114067  G  WS 401408 + 8 [fio]
> 259,0   12        3     0.000004078 114067  P   N [fio]
> 259,0   12        4     0.000004548 114067  U   N [fio] 1
> 259,0   12        5     0.000005654 114067  D  WS 401408 + 8 [fio]
> 259,0    4        1     0.000045379     0  C  WS 401408 + 8 [0]
> 259,0   14        1     0.000210927     0  C  WS 401408 + 8 [0]
> 259,0   14        2     0.000254591 114065  A  WS 401408 + 8 <- (9,127) 2=
74432
> 259,0   14        3     0.000257373 114065  G  WS 401408 + 8 [fio]
> 259,0   14        4     0.000257853 114065  P   N [fio]
> 259,0   14        5     0.000258340 114065  U   N [fio] 1
> 259,0   14        6     0.000259293 114065  D  WS 401408 + 8 [fio]
> 259,0    8        2     0.000290583     0  C  WS 401408 + 8 [0]
> 259,0   13        1     0.000080964 114068  A  WS 401408 + 8 <- (9,127) 2=
74432
> 259,0   13        2     0.000083702 114068  G  WS 401408 + 8 [fio]
> 259,0   13        3     0.000084247 114068  P   N [fio]
> 259,0   13        4     0.000084654 114068  U   N [fio] 1
> 259,0   13        5     0.000085801 114068  D  WS 401408 + 8 [fio]
> 259,0    3        1 1266874889.709450585 114066  A  WS 401408 + 8 <- (9,1=
27) 274432
> 259,0    3        2 1266874889.709455280 114066  G  WS 401408 + 8 [fio]
> 259,0    3        3 1266874889.709456267 114066  P   N [fio]
> 259,0    3        4 1266874889.709456843 114066  U   N [fio] 1
> 259,0    3        5 1266874889.709458888 114066  D  WS 401408 + 8 [fio]
> 259,0   15        1     0.000164738 114069  A  WS 401408 + 8 <- (9,127) 2=
74432
> 259,0   15        2     0.000168016 114069  G  WS 401408 + 8 [fio]
> 259,0   15        3     0.000168571 114069  P   N [fio]
> 259,0   15        4     0.000169037 114069  U   N [fio] 1
> 259,0   15        5     0.000169993 114069  D  WS 401408 + 8 [fio]
> 259,0   10        1     0.000128797     0  C  WS 401408 + 8 [0]
> ^C259,0    8        1 1266874889.709500996     0  C  WS 401408 + 8 [0]
> CPU3 (259,0):
> Reads Queued:           0,        0KiB=09 Writes Queued:           0,    =
    0KiB
> Read Dispatches:        0,        0KiB=09 Write Dispatches:        1,    =
    4KiB
> Reads Requeued:         0=09=09 Writes Requeued:         0
> Reads Completed:        0,        0KiB=09 Writes Completed:        0,    =
    0KiB
> Read Merges:            0,        0KiB=09 Write Merges:            0,    =
    0KiB
> Read depth:             0        =09 Write depth:             3
> IO unplugs:             1        =09 Timer unplugs:           0
> CPU4 (259,0):
> Reads Queued:           0,        0KiB=09 Writes Queued:           0,    =
    0KiB
> Read Dispatches:        0,        0KiB=09 Write Dispatches:        0,    =
    0KiB
> Reads Requeued:         0=09=09 Writes Requeued:         0
> Reads Completed:        0,        0KiB=09 Writes Completed:        1,    =
    4KiB
> Read Merges:            0,        0KiB=09 Write Merges:            0,    =
    0KiB
> Read depth:             0        =09 Write depth:             3
> IO unplugs:             0        =09 Timer unplugs:           0
> CPU8 (259,0):
> Reads Queued:           0,        0KiB=09 Writes Queued:           0,    =
    0KiB
> Read Dispatches:        0,        0KiB=09 Write Dispatches:        0,    =
    0KiB
> Reads Requeued:         0=09=09 Writes Requeued:         0
> Reads Completed:        0,        0KiB=09 Writes Completed:        2,    =
    8KiB
> Read Merges:            0,        0KiB=09 Write Merges:            0,    =
    0KiB
> Read depth:             0        =09 Write depth:             3
> IO unplugs:             0        =09 Timer unplugs:           0
> CPU10 (259,0):
> Reads Queued:           0,        0KiB=09 Writes Queued:           0,    =
    0KiB
> Read Dispatches:        0,        0KiB=09 Write Dispatches:        0,    =
    0KiB
> Reads Requeued:         0=09=09 Writes Requeued:         0
> Reads Completed:        0,        0KiB=09 Writes Completed:        1,    =
    4KiB
> Read Merges:            0,        0KiB=09 Write Merges:            0,    =
    0KiB
> Read depth:             0        =09 Write depth:             3
> IO unplugs:             0        =09 Timer unplugs:           0
> CPU12 (259,0):
> Reads Queued:           0,        0KiB=09 Writes Queued:           0,    =
    0KiB
> Read Dispatches:        0,        0KiB=09 Write Dispatches:        1,    =
    4KiB
> Reads Requeued:         0=09=09 Writes Requeued:         0
> Reads Completed:        0,        0KiB=09 Writes Completed:        0,    =
    0KiB
> Read Merges:            0,        0KiB=09 Write Merges:            0,    =
    0KiB
> Read depth:             0        =09 Write depth:             3
> IO unplugs:             1        =09 Timer unplugs:           0
> CPU13 (259,0):
> Reads Queued:           0,        0KiB=09 Writes Queued:           0,    =
    0KiB
> Read Dispatches:        0,        0KiB=09 Write Dispatches:        1,    =
    4KiB
> Reads Requeued:         0=09=09 Writes Requeued:         0
> Reads Completed:        0,        0KiB=09 Writes Completed:        0,    =
    0KiB
> Read Merges:            0,        0KiB=09 Write Merges:            0,    =
    0KiB
> Read depth:             0        =09 Write depth:             3
> IO unplugs:             1        =09 Timer unplugs:           0
> CPU14 (259,0):
> Reads Queued:           0,        0KiB=09 Writes Queued:           0,    =
    0KiB
> Read Dispatches:        0,        0KiB=09 Write Dispatches:        1,    =
    4KiB
> Reads Requeued:         0=09=09 Writes Requeued:         0
> Reads Completed:        0,        0KiB=09 Writes Completed:        1,    =
    4KiB
> Read Merges:            0,        0KiB=09 Write Merges:            0,    =
    0KiB
> Read depth:             0        =09 Write depth:             3
> IO unplugs:             1        =09 Timer unplugs:           0
> CPU15 (259,0):
> Reads Queued:           0,        0KiB=09 Writes Queued:           0,    =
    0KiB
> Read Dispatches:        0,        0KiB=09 Write Dispatches:        1,    =
    4KiB
> Reads Requeued:         0=09=09 Writes Requeued:         0
> Reads Completed:        0,        0KiB=09 Writes Completed:        0,    =
    0KiB
> Read Merges:            0,        0KiB=09 Write Merges:            0,    =
    0KiB
> Read depth:             0        =09 Write depth:             3
> IO unplugs:             1        =09 Timer unplugs:           0
>
> Total (259,0):
> Reads Queued:           0,        0KiB=09 Writes Queued:           0,    =
    0KiB
> Read Dispatches:        0,        0KiB=09 Write Dispatches:        5,    =
   20KiB
> Reads Requeued:         0=09=09 Writes Requeued:         0
> Reads Completed:        0,        0KiB=09 Writes Completed:        5,    =
   20KiB
> Read Merges:            0,        0KiB=09 Write Merges:            0,    =
    0KiB
> IO unplugs:             5        =09 Timer unplugs:           0
>
> Throughput (R/W): 0KiB/s / 0KiB/s
> Events (259,0): 30 entries
> Skips: 0 forward (0 -   0.0%)
>
> // On the Xenial machine with 4.4.0-1137-aws #151-Ubuntu SMP Tue Mar 1 09=
:47:43 UTC 2022 x86_64 x86_64 x86_64 GNU/Linux
> # blktrace -d /dev/nvme0n1 -d /dev/nvme1n1 -o - | blkparse -i -
> 259,1    1        1     0.000000000 82519  Q  WS 399368 + 8 [fio]
> 259,1    1        2     0.000000980 82519  G  WS 399368 + 8 [fio]
> 259,1    1        3     0.000003468 82519 UT   N [fio] 1
> 259,1    1        4     0.000003867 82519  I  WS 399368 + 8 [fio]
> 259,1    1        5     0.000011785  1393  D  WS 399368 + 8 [kworker/1:1H=
]
> 259,1    2        1 1266874889.709465021 82517  Q  WS 399368 + 8 [fio]
> 259,1    2        2 1266874889.709467133 82517  G  WS 399368 + 8 [fio]
> 259,1    2        3 1266874889.709471568 82517 UT   N [fio] 1
> 259,1    2        4 1266874889.709471568 82517  I  WS 399368 + 8 [fio]
> 259,1    2        5 1266874889.709476205   980  D  WS 399368 + 8 [kworker=
/2:1H]
> 259,1   15        1     0.000051309     0  C  WS 399368 + 8 [0]
> 259,1    3        1     0.000079179 82520  Q  WS 399368 + 8 [fio]
> 259,1    3        2     0.000080079 82520  G  WS 399368 + 8 [fio]
> 259,1    3        3     0.000082140 82520 UT   N [fio] 1
> 259,1    3        4     0.000082391 82520  I  WS 399368 + 8 [fio]
> 259,1    3        5     0.000087819   975  D  WS 399368 + 8 [kworker/3:1H=
]
> 259,1   12        1     0.000125455     0  C  WS 399368 + 8 [0]
> 259,1    5        1     0.000152778 82521  Q  WS 399368 + 8 [fio]
> 259,1    5        2     0.000153811 82521  G  WS 399368 + 8 [fio]
> 259,1    5        3     0.000155811 82521 UT   N [fio] 1
> 259,1    5        4     0.000156314 82521  I  WS 399368 + 8 [fio]
> 259,1    5        5     0.000168577  1552  D  WS 399368 + 8 [kworker/5:1H=
]
> 259,1    7        1     0.000206251     0  C  WS 399368 + 8 [0]
> 259,1    9        1     0.000234725 82518  Q  WS 399368 + 8 [fio]
> 259,1    9        2     0.000235496 82518  G  WS 399368 + 8 [fio]
> 259,1    9        3     0.000237147 82518 UT   N [fio] 1
> 259,1    9        4     0.000237382 82518  I  WS 399368 + 8 [fio]
> 259,1    9        5     0.000242425  2001  D  WS 399368 + 8 [kworker/9:1H=
]
> 259,1   15        2     0.000290161     0  C  WS 399368 + 8 [0]
> 259,1   13        1 1266874889.709520875     0  C  WS 399368 + 8 [0]
> ^CCPU1 (259,1):
> Reads Queued:           0,        0KiB=09 Writes Queued:           1,    =
    4KiB
> Read Dispatches:        0,        0KiB=09 Write Dispatches:        1,    =
    4KiB
> Reads Requeued:         0=09=09 Writes Requeued:         0
> Reads Completed:        0,        0KiB=09 Writes Completed:        0,    =
    0KiB
> Read Merges:            0,        0KiB=09 Write Merges:            0,    =
    0KiB
> Read depth:             0        =09 Write depth:             2
> IO unplugs:             0        =09 Timer unplugs:           1
> CPU2 (259,1):
> Reads Queued:           0,        0KiB=09 Writes Queued:           1,    =
    4KiB
> Read Dispatches:        0,        0KiB=09 Write Dispatches:        1,    =
    4KiB
> Reads Requeued:         0=09=09 Writes Requeued:         0
> Reads Completed:        0,        0KiB=09 Writes Completed:        0,    =
    0KiB
> Read Merges:            0,        0KiB=09 Write Merges:            0,    =
    0KiB
> Read depth:             0        =09 Write depth:             2
> IO unplugs:             0        =09 Timer unplugs:           1
> CPU3 (259,1):
> Reads Queued:           0,        0KiB=09 Writes Queued:           1,    =
    4KiB
> Read Dispatches:        0,        0KiB=09 Write Dispatches:        1,    =
    4KiB
> Reads Requeued:         0=09=09 Writes Requeued:         0
> Reads Completed:        0,        0KiB=09 Writes Completed:        0,    =
    0KiB
> Read Merges:            0,        0KiB=09 Write Merges:            0,    =
    0KiB
> Read depth:             0        =09 Write depth:             2
> IO unplugs:             0        =09 Timer unplugs:           1
> CPU5 (259,1):
> Reads Queued:           0,        0KiB=09 Writes Queued:           1,    =
    4KiB
> Read Dispatches:        0,        0KiB=09 Write Dispatches:        1,    =
    4KiB
> Reads Requeued:         0=09=09 Writes Requeued:         0
> Reads Completed:        0,        0KiB=09 Writes Completed:        0,    =
    0KiB
> Read Merges:            0,        0KiB=09 Write Merges:            0,    =
    0KiB
> Read depth:             0        =09 Write depth:             2
> IO unplugs:             0        =09 Timer unplugs:           1
> CPU7 (259,1):
> Reads Queued:           0,        0KiB=09 Writes Queued:           0,    =
    0KiB
> Read Dispatches:        0,        0KiB=09 Write Dispatches:        0,    =
    0KiB
> Reads Requeued:         0=09=09 Writes Requeued:         0
> Reads Completed:        0,        0KiB=09 Writes Completed:        1,    =
    4KiB
> Read Merges:            0,        0KiB=09 Write Merges:            0,    =
    0KiB
> Read depth:             0        =09 Write depth:             2
> IO unplugs:             0        =09 Timer unplugs:           0
> CPU9 (259,1):
> Reads Queued:           0,        0KiB=09 Writes Queued:           1,    =
    4KiB
> Read Dispatches:        0,        0KiB=09 Write Dispatches:        1,    =
    4KiB
> Reads Requeued:         0=09=09 Writes Requeued:         0
> Reads Completed:        0,        0KiB=09 Writes Completed:        0,    =
    0KiB
> Read Merges:            0,        0KiB=09 Write Merges:            0,    =
    0KiB
> Read depth:             0        =09 Write depth:             2
> IO unplugs:             0        =09 Timer unplugs:           1
> CPU12 (259,1):
> Reads Queued:           0,        0KiB=09 Writes Queued:           0,    =
    0KiB
> Read Dispatches:        0,        0KiB=09 Write Dispatches:        0,    =
    0KiB
> Reads Requeued:         0=09=09 Writes Requeued:         0
> Reads Completed:        0,        0KiB=09 Writes Completed:        1,    =
    4KiB
> Read Merges:            0,        0KiB=09 Write Merges:            0,    =
    0KiB
> Read depth:             0        =09 Write depth:             2
> IO unplugs:             0        =09 Timer unplugs:           0
> CPU13 (259,1):
> Reads Queued:           0,        0KiB=09 Writes Queued:           0,    =
    0KiB
> Read Dispatches:        0,        0KiB=09 Write Dispatches:        0,    =
    0KiB
> Reads Requeued:         0=09=09 Writes Requeued:         0
> Reads Completed:        0,        0KiB=09 Writes Completed:        1,    =
    4KiB
> Read Merges:            0,        0KiB=09 Write Merges:            0,    =
    0KiB
> Read depth:             0        =09 Write depth:             2
> IO unplugs:             0        =09 Timer unplugs:           0
> CPU15 (259,1):
> Reads Queued:           0,        0KiB=09 Writes Queued:           0,    =
    0KiB
> Read Dispatches:        0,        0KiB=09 Write Dispatches:        0,    =
    0KiB
> Reads Requeued:         0=09=09 Writes Requeued:         0
> Reads Completed:        0,        0KiB=09 Writes Completed:        2,    =
    8KiB
> Read Merges:            0,        0KiB=09 Write Merges:            0,    =
    0KiB
> Read depth:             0        =09 Write depth:             2
> IO unplugs:             0        =09 Timer unplugs:           0
>
> Total (259,1):
> Reads Queued:           0,        0KiB=09 Writes Queued:           5,    =
   20KiB
> Read Dispatches:        0,        0KiB=09 Write Dispatches:        5,    =
   20KiB
> Reads Requeued:         0=09=09 Writes Requeued:         0
> Reads Completed:        0,        0KiB=09 Writes Completed:        5,    =
   20KiB
> Read Merges:            0,        0KiB=09 Write Merges:            0,    =
    0KiB
> IO unplugs:             0        =09 Timer unplugs:           5
>
> Throughput (R/W): 0KiB/s / 0KiB/s
> Events (259,1): 30 entries
> Skips: 0 forward (0 -   0.0%)
>
> Please CC me directly as I am not subscribed to LKML.
>
> Thanks,
>
> -- Michael Marod (michael@michaelmarod.com)


