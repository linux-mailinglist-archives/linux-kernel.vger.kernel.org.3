Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 370664767C6
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 03:15:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232804AbhLPCPN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 21:15:13 -0500
Received: from out0.migadu.com ([94.23.1.103]:57677 "EHLO out0.migadu.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229955AbhLPCPM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 21:15:12 -0500
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1639620910;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=k4phbJHuL8+tP9BmJgUGj0AvkreTd5WR5XGVGz/EErs=;
        b=iEzd/CuZnr8rHBKTFUjSyuR/rpZbVLRe1uhQ+UFjq9Bx6exxgkyobtWJKXzEMpCuEs/Eng
        9REM202CHRa91HhvCPgOCeGOumxa8pvHsNMvuhilguRaOkRRmM8C5me7NJfbEkM3Flsjwf
        TPn9r7+elS4iwuwcdKNni4SFJilekvg=
Date:   Thu, 16 Dec 2021 02:15:09 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   yajun.deng@linux.dev
Message-ID: <3ed867e06f7f9bb9d89beaafc50905c8@linux.dev>
Subject: Re: [PATCH] lib/raid6: fix abnormally high latency
To:     "Song Liu" <song@kernel.org>
Cc:     stockhausen@collogia.de,
        "open list" <linux-kernel@vger.kernel.org>,
        linux-rt-users@vger.kernel.org,
        "linux-raid" <linux-raid@vger.kernel.org>, masahiroy@kernel.org,
        williams@redhat.com
In-Reply-To: <CAPhsuW6T_nqqfOtj_dVn9KV+iUbki2X3WU3pxfo25Ewj3i5ZjA@mail.gmail.com>
References: <CAPhsuW6T_nqqfOtj_dVn9KV+iUbki2X3WU3pxfo25Ewj3i5ZjA@mail.gmail.com>
 <20211214031553.16435-1-yajun.deng@linux.dev>
 <CAPhsuW5X+zewpKoJLjMMGOUeSiJ1EYqD+0i1bA8y7SFtJLkMeg@mail.gmail.com>
 <0d07e13a5454dfb03b22e5223d101a1b@linux.dev>
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

December 16, 2021 12:52 AM, "Song Liu" <song@kernel.org> wrote:=0A=0A> On=
 Tue, Dec 14, 2021 at 6:14 PM <yajun.deng@linux.dev> wrote:=0A> =0A>> Dec=
ember 15, 2021 1:27 AM, "Song Liu" <song@kernel.org> wrote:=0A>> =0A>> On=
 Mon, Dec 13, 2021 at 7:17 PM Yajun Deng <yajun.deng@linux.dev> wrote:=0A=
>> =0A>> We found an abnormally high latency when executing modprobe raid=
6_pq, the=0A>> latency is greater than 1.2s when CONFIG_PREEMPT_VOLUNTARY=
=3Dy, greater than=0A>> 67ms when CONFIG_PREEMPT=3Dy, and greater than 16=
ms when CONFIG_PREEMPT_RT=3Dy.=0A>> This is caused by disable the preempt=
ion, this time is too long and=0A>> unreasonable. We just need to disable=
 migration. so used migrate_disable()/=0A>> migrate_enable() instead of p=
reempt_disable()/preempt_enable(). This is=0A>> beneficial for CONFIG_PRE=
EMPT=3Dy or CONFIG_PREEMPT_RT=3Dy, but no effect for=0A>> CONFIG_PREEMPT_=
VOLUNTARY=3Dy.=0A>> =0A>> Fixes: fe5cbc6e06c7 ("md/raid6 algorithms: delt=
a syndrome functions")=0A>> Signed-off-by: Yajun Deng <yajun.deng@linux.d=
ev>=0A>> =0A>> We measure the speed of different RAID algorithms.If we do=
n't disable=0A>> preempt, the result may be inaccurate, right? IIUC, we o=
nly disable preempt=0A>> for 16 jiffies. Why do we see 1.2 second delay?=
=0A>> =0A>> Here are the command of my test=EF=BC=9A=0A>> Execute "sudo c=
yclictest -S -p 95 -d 0 -i 1000 -D 24h -m" in one terminal and "sudo modp=
robe=0A>> raid6_pq" in the other terminal.=0A>> =0A>> Here are the result=
s of my test=EF=BC=9A=0A>> CONFIG_PREEMPT_VOLUNTARY=3Dy=EF=BC=8CCONFIG_HZ=
_250=3Dy=0A>> T: 0 ( 3092) P:95 I:1000 C: 8514 Min: 1 Act: 2 Avg: 1 Max: =
6=0A>> T: 1 ( 3093) P:95 I:1000 C: 8511 Min: 1 Act: 2 Avg: 1 Max: 14=0A> =
=0A> I am not very familiar with the RT work, so please forgive me for so=
me=0A> rookie questions.=0A> =0A> From the result, I think the CONFIG_PRE=
EMPT_VOLUNTARY=3Dy and the=0A> CONFIG_PREEMPT=3Dy cases failed to preempt=
 during the preempt enabled period in=0A> raid6_choose_gen(). Is this exp=
ected?=0A> =0A=0ANo, This is due to disable preemption causing ksoftirqd =
fail to schedule, we can use bcc tools see that.=0A=0A> OTOH, the 16ms la=
tency with CONFIG_PREEMPT_RT=3Dy is more or less expected.=0A> Is this ac=
ceptable? If not, is 1ms latency acceptable?=0A> =0A=0AHere are the test =
results after adding patch=EF=BC=9A=0ACONFIG_PREEMPT=3Dy  or CONFIG_PREEM=
PT_RT=3Dy=0AT: 0 ( 3167) P:95 I:1000 C:  13958 Min:      1 Act:    2 Avg:=
    1 Max:       5=0AT: 1 ( 3168) P:95 I:1000 C:  13956 Min:      1 Act: =
   2 Avg:    1 Max:       7=0AT: 2 ( 3169) P:95 I:1000 C:  13946 Min:    =
  1 Act:    2 Avg:    1 Max:      12=0AT: 3 ( 3170) P:95 I:1000 C:  13951=
 Min:      1 Act:    2 Avg:    1 Max:       5=0AT: 4 ( 3171) P:95 I:1000 =
C:  13949 Min:      1 Act:    2 Avg:    1 Max:       3=0AT: 5 ( 3172) P:9=
5 I:1000 C:  13947 Min:      1 Act:    2 Avg:    1 Max:      16=0AT: 6 ( =
3173) P:95 I:1000 C:  13945 Min:      1 Act:    2 Avg:    2 Max:       7=
=0AT: 7 ( 3174) P:95 I:1000 C:  13942 Min:      1 Act:    2 Avg:    1 Max=
:       3=0AT: 8 ( 3175) P:95 I:1000 C:  13940 Min:      1 Act:    2 Avg:=
    1 Max:       3=0AT: 9 ( 3176) P:95 I:1000 C:  13938 Min:      1 Act: =
   1 Avg:    1 Max:       3=0AT:10 ( 3177) P:95 I:1000 C:  13936 Min:    =
  1 Act:    2 Avg:    1 Max:       6=0AT:11 ( 3178) P:95 I:1000 C:  13933=
 Min:      1 Act:    2 Avg:    1 Max:       3=0AT:12 ( 3179) P:95 I:1000 =
C:  13931 Min:      1 Act:    2 Avg:    1 Max:       4=0AT:13 ( 3180) P:9=
5 I:1000 C:  13929 Min:      1 Act:    2 Avg:    1 Max:       7=0AT:14 ( =
3181) P:95 I:1000 C:  13927 Min:      1 Act:    2 Avg:    1 Max:       6=
=0AT:15 ( 3182) P:95 I:1000 C:  13925 Min:      1 Act:    2 Avg:    1 Max=
:       4=0AT:16 ( 3183) P:95 I:1000 C:  13923 Min:      1 Act:    2 Avg:=
    1 Max:       5=0AT:17 ( 3184) P:95 I:1000 C:  13921 Min:      1 Act: =
   2 Avg:    1 Max:       5=0AT:18 ( 3185) P:95 I:1000 C:  13919 Min:    =
  1 Act:    2 Avg:    1 Max:       4=0AT:19 ( 3186) P:95 I:1000 C:  13916=
 Min:      1 Act:    2 Avg:    1 Max:       4=0AT:20 ( 3187) P:95 I:1000 =
C:  13914 Min:      1 Act:    2 Avg:    1 Max:       4=0AT:21 ( 3188) P:9=
5 I:1000 C:  13912 Min:      1 Act:    2 Avg:    1 Max:      10=0AT:22 ( =
3189) P:95 I:1000 C:  13910 Min:      1 Act:    2 Avg:    1 Max:       5=
=0AT:23 ( 3190) P:95 I:1000 C:  13908 Min:      1 Act:    2 Avg:    1 Max=
:       5=0AT:24 ( 3191) P:95 I:1000 C:  13906 Min:      1 Act:    2 Avg:=
    1 Max:      18=0AT:25 ( 3192) P:95 I:1000 C:  13904 Min:      1 Act: =
   2 Avg:    1 Max:       7=0AT:26 ( 3193) P:95 I:1000 C:  13902 Min:    =
  1 Act:    2 Avg:    1 Max:       5=0AT:27 ( 3194) P:95 I:1000 C:  13900=
 Min:      1 Act:    1 Avg:    1 Max:      11=0AT:28 ( 3195) P:95 I:1000 =
C:  13898 Min:      1 Act:    2 Avg:    1 Max:       3=0AT:29 ( 3196) P:9=
5 I:1000 C:  13896 Min:      1 Act:    2 Avg:    1 Max:       5=0AT:30 ( =
3197) P:95 I:1000 C:  13894 Min:      1 Act:    2 Avg:    1 Max:       4=
=0AT:31 ( 3198) P:95 I:1000 C:  13892 Min:      1 Act:    2 Avg:    1 Max=
:       3=0A=0Awe can see the latency will not greater than 100us=EF=BC=
=8Cso 1ms latency is also too long for CONFIG_PREEMPT=3Dy  or CONFIG_PREE=
MPT_RT=3Dy.=0Ause migrate_disable()/migrate_enable() instead of preempt_d=
isable()/preempt_enable() will not affect the speed of different RAID alg=
orithms and the latency can be reduced to a reasonable range.=0A=0A=0A> T=
hanks,=0A> Song=0A> =0A> [...]
