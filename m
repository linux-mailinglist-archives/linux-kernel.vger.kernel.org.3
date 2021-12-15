Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D39A54750C8
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 03:14:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235734AbhLOCOs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 21:14:48 -0500
Received: from out2.migadu.com ([188.165.223.204]:42219 "EHLO out2.migadu.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231312AbhLOCOr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 21:14:47 -0500
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1639534484;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=k50eUXTjitWTOC0VkxAcsznesFmo8uGKi6Uf0Teh0Cg=;
        b=tpnh2nod/w9uZW6/1x+S1O2hJsj1j9xQsLkfxe6u2Gy8psNzAlIFya77wqJH2Y1quZz/lY
        GkGsZZqEqlvPjmBRLf5DLDeKRN2dWASH5It8gtgA1ukoBoP9UfqbMrEd+0M34XXJwPfFen
        tbHZRDuUOXNKQj8kb3EWsLsmlnbvWV0=
Date:   Wed, 15 Dec 2021 02:14:44 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   yajun.deng@linux.dev
Message-ID: <0d07e13a5454dfb03b22e5223d101a1b@linux.dev>
Subject: Re: [PATCH] lib/raid6: fix abnormally high latency
To:     "Song Liu" <song@kernel.org>
Cc:     stockhausen@collogia.de,
        "open list" <linux-kernel@vger.kernel.org>,
        linux-rt-users@vger.kernel.org,
        "linux-raid" <linux-raid@vger.kernel.org>, masahiroy@kernel.org,
        williams@redhat.com
In-Reply-To: <CAPhsuW5X+zewpKoJLjMMGOUeSiJ1EYqD+0i1bA8y7SFtJLkMeg@mail.gmail.com>
References: <CAPhsuW5X+zewpKoJLjMMGOUeSiJ1EYqD+0i1bA8y7SFtJLkMeg@mail.gmail.com>
 <20211214031553.16435-1-yajun.deng@linux.dev>
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

December 15, 2021 1:27 AM, "Song Liu" <song@kernel.org> wrote:=0A=0A> On =
Mon, Dec 13, 2021 at 7:17 PM Yajun Deng <yajun.deng@linux.dev> wrote:=0A>=
 =0A>> We found an abnormally high latency when executing modprobe raid6_=
pq, the=0A>> latency is greater than 1.2s when CONFIG_PREEMPT_VOLUNTARY=
=3Dy, greater than=0A>> 67ms when CONFIG_PREEMPT=3Dy, and greater than 16=
ms when CONFIG_PREEMPT_RT=3Dy.=0A>> This is caused by disable the preempt=
ion, this time is too long and=0A>> unreasonable. We just need to disable=
 migration. so used migrate_disable()/=0A>> migrate_enable() instead of p=
reempt_disable()/preempt_enable(). This is=0A>> beneficial for CONFIG_PRE=
EMPT=3Dy or CONFIG_PREEMPT_RT=3Dy, but no effect for=0A>> CONFIG_PREEMPT_=
VOLUNTARY=3Dy.=0A>> =0A>> Fixes: fe5cbc6e06c7 ("md/raid6 algorithms: delt=
a syndrome functions")=0A>> Signed-off-by: Yajun Deng <yajun.deng@linux.d=
ev>=0A> =0A> We measure the speed of different RAID algorithms.If we don'=
t disable=0A> preempt, the result may be inaccurate, right? IIUC, we only=
 disable preempt=0A> for 16 jiffies. Why do we see 1.2 second delay?=0A=
=0AHere are the command of my test=EF=BC=9A=0AExecute "sudo cyclictest -S=
 -p 95 -d 0 -i 1000 -D 24h -m" in one terminal and "sudo modprobe raid6_p=
q" in the other terminal.=0A=0AHere are the results of my test=EF=BC=9A=
=0ACONFIG_PREEMPT_VOLUNTARY=3Dy=EF=BC=8CCONFIG_HZ_250=3Dy=0AT: 0 ( 3092) =
P:95 I:1000 C:   8514 Min:      1 Act:    2 Avg:    1 Max:       6=0AT: 1=
 ( 3093) P:95 I:1000 C:   8511 Min:      1 Act:    2 Avg:    1 Max:      =
14=0AT: 2 ( 3094) P:95 I:1000 C:   8509 Min:      1 Act:    2 Avg:    1 M=
ax:       5=0AT: 3 ( 3095) P:95 I:1000 C:   8506 Min:      1 Act:    2 Av=
g:    1 Max:       2=0AT: 4 ( 3096) P:95 I:1000 C:   8504 Min:      1 Act=
:    2 Avg:    1 Max:       3=0AT: 5 ( 3097) P:95 I:1000 C:   8502 Min:  =
    1 Act:    2 Avg:    1 Max:       3=0AT: 6 ( 3098) P:95 I:1000 C:   84=
99 Min:      1 Act:    2 Avg:    1 Max:       3=0AT: 7 ( 3099) P:95 I:100=
0 C:   8497 Min:      1 Act:    1 Avg:    1 Max:      16=0AT: 8 ( 3100) P=
:95 I:1000 C:   8495 Min:      1 Act:    2 Avg:    1 Max:       5=0AT: 9 =
( 3101) P:95 I:1000 C:   8493 Min:      1 Act:    2 Avg:    1 Max:       =
4=0AT:10 ( 3102) P:95 I:1000 C:   8490 Min:      1 Act:    2 Avg:    1 Ma=
x:      13=0AT:11 ( 3103) P:95 I:1000 C:   8488 Min:      1 Act:    2 Avg=
:    1 Max:       8=0AT:12 ( 3104) P:95 I:1000 C:   8486 Min:      1 Act:=
    2 Avg:    1 Max:      10=0AT:13 ( 3105) P:95 I:1000 C:   8484 Min:   =
   1 Act:    2 Avg:    2 Max:       6=0AT:14 ( 3106) P:95 I:1000 C:   848=
2 Min:      1 Act:    2 Avg:    1 Max:       3=0AT:15 ( 3107) P:95 I:1000=
 C:   8479 Min:      1 Act:    2 Avg:    1 Max:       5=0AT:16 ( 3108) P:=
95 I:1000 C:   8477 Min:      1 Act:    2 Avg:    2 Max:     137=0AT:17 (=
 3109) P:95 I:1000 C:   7255 Min:      1 Act:    2 Avg:  170 Max: 1220832=
=0AT:18 ( 3110) P:95 I:1000 C:   8473 Min:      1 Act:    2 Avg:    1 Max=
:       5=0AT:19 ( 3111) P:95 I:1000 C:   8471 Min:      1 Act:    2 Avg:=
    1 Max:       4=0AT:20 ( 3112) P:95 I:1000 C:   8469 Min:      1 Act: =
   2 Avg:    1 Max:       4=0AT:21 ( 3113) P:95 I:1000 C:   8466 Min:    =
  1 Act:    2 Avg:    1 Max:       3=0AT:22 ( 3114) P:95 I:1000 C:   8464=
 Min:      1 Act:    2 Avg:    1 Max:       8=0AT:23 ( 3115) P:95 I:1000 =
C:   8462 Min:      1 Act:    2 Avg:    1 Max:      10=0AT:24 ( 3116) P:9=
5 I:1000 C:   8457 Min:      1 Act:    2 Avg:    1 Max:       9=0AT:25 ( =
3117) P:95 I:1000 C:   8458 Min:      1 Act:    2 Avg:    1 Max:       4=
=0AT:26 ( 3118) P:95 I:1000 C:   8456 Min:      1 Act:    2 Avg:    1 Max=
:       5=0AT:27 ( 3119) P:95 I:1000 C:   8454 Min:      1 Act:    2 Avg:=
    1 Max:       2=0AT:28 ( 3120) P:95 I:1000 C:   8452 Min:      1 Act: =
   2 Avg:    1 Max:       3=0AT:29 ( 3121) P:95 I:1000 C:   8450 Min:    =
  2 Act:    2 Avg:    2 Max:       3=0AT:30 ( 3122) P:95 I:1000 C:   8447=
 Min:      1 Act:    2 Avg:    1 Max:       2=0AT:31 ( 3123) P:95 I:1000 =
C:   8445 Min:      1 Act:    2 Avg:    1 Max:      12=0A=0ACONFIG_PREEMP=
T=3Dy,CONFIG_HZ_250=3Dy=0AT: 0 ( 2460) P:95 I:1000 C:  49161 Min:      1 =
Act:    2 Avg:    2 Max:       8=0AT: 1 ( 2461) P:95 I:1000 C:  49158 Min=
:      1 Act:    2 Avg:    2 Max:       9=0AT: 2 ( 2462) P:95 I:1000 C:  =
49024 Min:      1 Act:    2 Avg:    4 Max:   67888=0AT: 3 ( 2463) P:95 I:=
1000 C:  49153 Min:      1 Act:    2 Avg:    2 Max:       4=0AT: 4 ( 2464=
) P:95 I:1000 C:  48882 Min:      1 Act:    2 Avg:    7 Max:   67726=0AT:=
 5 ( 2465) P:95 I:1000 C:  49148 Min:      1 Act:    2 Avg:    2 Max:    =
   5=0AT: 6 ( 2466) P:95 I:1000 C:  49146 Min:      1 Act:    2 Avg:    1=
 Max:       6=0AT: 7 ( 2467) P:95 I:1000 C:  49143 Min:      2 Act:    2 =
Avg:    2 Max:       6=0AT: 8 ( 2468) P:95 I:1000 C:  49140 Min:      1 A=
ct:    2 Avg:    2 Max:     929=0AT: 9 ( 2469) P:95 I:1000 C:  49139 Min:=
      1 Act:    2 Avg:    2 Max:       8=0AT:10 ( 2470) P:95 I:1000 C:  4=
9136 Min:      1 Act:    2 Avg:    2 Max:       8=0AT:11 ( 2471) P:95 I:1=
000 C:  48866 Min:      1 Act:    2 Avg:    7 Max:   67417=0AT:12 ( 2472)=
 P:95 I:1000 C:  49132 Min:      1 Act:    2 Avg:    2 Max:       6=0AT:1=
3 ( 2473) P:95 I:1000 C:  49063 Min:      1 Act:    2 Avg:    3 Max:   67=
854=0AT:14 ( 2474) P:95 I:1000 C:  49127 Min:      1 Act:    2 Avg:    2 =
Max:       5=0AT:15 ( 2475) P:95 I:1000 C:  49125 Min:      1 Act:    2 A=
vg:    2 Max:       7=0AT:16 ( 2476) P:95 I:1000 C:  49123 Min:      1 Ac=
t:    2 Avg:    2 Max:       5=0AT:17 ( 2477) P:95 I:1000 C:  49121 Min: =
     1 Act:    2 Avg:    2 Max:       6=0AT:18 ( 2478) P:95 I:1000 C:  49=
052 Min:      1 Act:    2 Avg:    3 Max:   67717=0AT:19 ( 2479) P:95 I:10=
00 C:  49116 Min:      1 Act:    2 Avg:    2 Max:       6=0AT:20 ( 2480) =
P:95 I:1000 C:  48913 Min:      1 Act:    2 Avg:    6 Max:   67291=0AT:21=
 ( 2481) P:95 I:1000 C:  49112 Min:      1 Act:    2 Avg:    1 Max:      =
 4=0AT:22 ( 2482) P:95 I:1000 C:  49110 Min:      1 Act:    2 Avg:    2 M=
ax:       5=0AT:23 ( 2483) P:95 I:1000 C:  49108 Min:      1 Act:    2 Av=
g:    1 Max:       4=0AT:24 ( 2484) P:95 I:1000 C:  49105 Min:      1 Act=
:    2 Avg:    2 Max:       6=0AT:25 ( 2485) P:95 I:1000 C:  49103 Min:  =
    1 Act:    2 Avg:    2 Max:       7=0AT:26 ( 2486) P:95 I:1000 C:  491=
01 Min:      1 Act:    2 Avg:    2 Max:       6=0AT:27 ( 2487) P:95 I:100=
0 C:  48898 Min:      1 Act:    2 Avg:    6 Max:   67004=0AT:28 ( 2488) P=
:95 I:1000 C:  49097 Min:      1 Act:    2 Avg:    2 Max:       7=0AT:29 =
( 2489) P:95 I:1000 C:  49095 Min:      1 Act:    2 Avg:    1 Max:       =
3=0AT:30 ( 2490) P:95 I:1000 C:  49092 Min:      1 Act:    2 Avg:    1 Ma=
x:       4=0AT:31 ( 2491) P:95 I:1000 C:  49090 Min:      1 Act:    2 Avg=
:    2 Max:       6=0A=0ACONFIG_PREEMPT_RT=3Dy,CONFIG_HZ_1000=3Dy=0AT: 0 =
( 2555) P:95 I:1000 C:  25336 Min:      2 Act:    2 Avg:    2 Max:      1=
1=0AT: 1 ( 2556) P:95 I:1000 C:  25332 Min:      2 Act:    4 Avg:    3 Ma=
x:      10=0AT: 2 ( 2557) P:95 I:1000 C:  25329 Min:      3 Act:    3 Avg=
:    3 Max:       7=0AT: 3 ( 2558) P:95 I:1000 C:  25326 Min:      3 Act:=
    3 Avg:    3 Max:       9=0AT: 4 ( 2559) P:95 I:1000 C:  25322 Min:   =
   3 Act:    3 Avg:    3 Max:      19=0AT: 5 ( 2560) P:95 I:1000 C:  2531=
9 Min:      3 Act:    3 Avg:    3 Max:       9=0AT: 6 ( 2561) P:95 I:1000=
 C:  25284 Min:      3 Act:    3 Avg:    4 Max:   16593=0AT: 7 ( 2562) P:=
95 I:1000 C:  25265 Min:      3 Act:    3 Avg:    5 Max:   16375=0AT: 8 (=
 2563) P:95 I:1000 C:  25293 Min:      3 Act:    3 Avg:    3 Max:   16138=
=0AT: 9 ( 2564) P:95 I:1000 C:  25290 Min:      3 Act:    5 Avg:    5 Max=
:   16902=0AT:10 ( 2565) P:95 I:1000 C:  25287 Min:      3 Act:    3 Avg:=
    4 Max:   16696=0AT:11 ( 2566) P:95 I:1000 C:  25300 Min:      3 Act: =
   3 Avg:    3 Max:       7=0AT:12 ( 2567) P:95 I:1000 C:  25297 Min:    =
  2 Act:    2 Avg:    2 Max:       9=0AT:13 ( 2568) P:95 I:1000 C:  25277=
 Min:      3 Act:    3 Avg:    3 Max:   16179=0AT:14 ( 2569) P:95 I:1000 =
C:  25274 Min:      3 Act:    3 Avg:    3 Max:   16043=0AT:15 ( 2570) P:9=
5 I:1000 C:  25287 Min:      3 Act:    3 Avg:    3 Max:       8=0AT:16 ( =
2571) P:95 I:1000 C:  25284 Min:      2 Act:    2 Avg:    2 Max:       5=
=0AT:17 ( 2572) P:95 I:1000 C:  25281 Min:      3 Act:    3 Avg:    3 Max=
:       7=0AT:18 ( 2573) P:95 I:1000 C:  25278 Min:      3 Act:    3 Avg:=
    3 Max:       7=0AT:19 ( 2574) P:95 I:1000 C:  25275 Min:      3 Act: =
   3 Avg:    3 Max:       6=0AT:20 ( 2575) P:95 I:1000 C:  25272 Min:    =
  3 Act:    3 Avg:    3 Max:       7=0AT:21 ( 2576) P:95 I:1000 C:  25269=
=20Min:      3 Act:    4 Avg:    3 Max:      10=0AT:22 ( 2577) P:95 I:100=
0 C:  25234 Min:      2 Act:    3 Avg:    4 Max:   16244=0AT:23 ( 2578) P=
:95 I:1000 C:  25231 Min:      2 Act:    4 Avg:    4 Max:   16200=0AT:24 =
( 2579) P:95 I:1000 C:  25259 Min:      3 Act:    3 Avg:    3 Max:       =
6=0AT:25 ( 2580) P:95 I:1000 C:  25256 Min:      3 Act:    3 Avg:    3 Ma=
x:       8=0AT:26 ( 2581) P:95 I:1000 C:  25237 Min:      3 Act:    3 Avg=
:    3 Max:   16078=0AT:27 ( 2582) P:95 I:1000 C:  25250 Min:      3 Act:=
    3 Avg:    3 Max:       7=0AT:28 ( 2583) P:95 I:1000 C:  25247 Min:   =
   3 Act:    3 Avg:    3 Max:       8=0AT:29 ( 2584) P:95 I:1000 C:  2521=
4 Min:      2 Act:    3 Avg:    4 Max:   15985=0AT:30 ( 2585) P:95 I:1000=
 C:  25225 Min:      2 Act:    2 Avg:    3 Max:   16988=0AT:31 ( 2586) P:=
95 I:1000 C:  25238 Min:      3 Act:    3 Avg:    3 Max:      12=0A=0A=0A=
> =0A> Thanks,=0A> Song=0A> =0A>> ---=0A>> lib/raid6/algos.c | 8 ++++----=
=0A>> 1 file changed, 4 insertions(+), 4 deletions(-)=0A>> =0A>> diff --g=
it a/lib/raid6/algos.c b/lib/raid6/algos.c=0A>> index 6d5e5000fdd7..21611=
d05c34c 100644=0A>> --- a/lib/raid6/algos.c=0A>> +++ b/lib/raid6/algos.c=
=0A>> @@ -162,7 +162,7 @@ static inline const struct raid6_calls *raid6_c=
hoose_gen(=0A>> =0A>> perf =3D 0;=0A>> =0A>> - preempt_disable();=0A>> + =
migrate_disable();=0A>> j0 =3D jiffies;=0A>> while ((j1 =3D jiffies) =3D=
=3D j0)=0A>> cpu_relax();=0A>> @@ -171,7 +171,7 @@ static inline const st=
ruct raid6_calls *raid6_choose_gen(=0A>> (*algo)->gen_syndrome(disks, PAG=
E_SIZE, *dptrs);=0A>> perf++;=0A>> }=0A>> - preempt_enable();=0A>> + migr=
ate_enable();=0A>> =0A>> if (perf > bestgenperf) {=0A>> bestgenperf =3D p=
erf;=0A>> @@ -186,7 +186,7 @@ static inline const struct raid6_calls *rai=
d6_choose_gen(=0A>> =0A>> perf =3D 0;=0A>> =0A>> - preempt_disable();=0A>=
> + migrate_disable();=0A>> j0 =3D jiffies;=0A>> while ((j1 =3D jiffies) =
=3D=3D j0)=0A>> cpu_relax();=0A>> @@ -196,7 +196,7 @@ static inline const=
 struct raid6_calls *raid6_choose_gen(=0A>> PAGE_SIZE, *dptrs);=0A>> perf=
++;=0A>> }=0A>> - preempt_enable();=0A>> + migrate_enable();=0A>> =0A>> i=
f (best =3D=3D *algo)=0A>> bestxorperf =3D perf;=0A>> --=0A>> 2.32.0
