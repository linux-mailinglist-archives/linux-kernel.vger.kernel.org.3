Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8835476BE5
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 09:27:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232464AbhLPI1e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 03:27:34 -0500
Received: from out2.migadu.com ([188.165.223.204]:24539 "EHLO out2.migadu.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232138AbhLPI1d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 03:27:33 -0500
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1639643251;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vM3bL/h4uG3rU4/AfUqTxvE5iQhZqVB5atuwXO4XQZ8=;
        b=IOVt44F88I26g4LaoZY2z7prwv6xIsv/FFMOl+g1oCo5mXrvYg8Vs/HJSV4smZruebeiYE
        Ynrt/Twj+nFaoGYY1Wm1YqSUYb4ajoG4kiCP40ehBd7tv3d73dnWl2C0eaTXM7avZWCjYo
        7ryIOKu9YYRUtpOhc4WSq6kv4AGqwBE=
Date:   Thu, 16 Dec 2021 08:27:31 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   yajun.deng@linux.dev
Message-ID: <2e4c3e7cbfbd4d31aaea1ef459816a5f@linux.dev>
Subject: Re: [PATCH] lib/raid6: fix abnormally high latency
To:     "Paul Menzel" <pmenzel@molgen.mpg.de>
Cc:     stockhausen@collogia.de, "LKML" <linux-kernel@vger.kernel.org>,
        linux-rt-users@vger.kernel.org, linux-raid@vger.kernel.org,
        masahiroy@kernel.org, williams@redhat.com, song@kernel.org
In-Reply-To: <712c7ae8-fde1-fa49-bf4d-49024b436438@molgen.mpg.de>
References: <712c7ae8-fde1-fa49-bf4d-49024b436438@molgen.mpg.de>
 <20211214031553.16435-1-yajun.deng@linux.dev>
 <CAPhsuW5X+zewpKoJLjMMGOUeSiJ1EYqD+0i1bA8y7SFtJLkMeg@mail.gmail.com>
 <0d07e13a5454dfb03b22e5223d101a1b@linux.dev>
 <CAPhsuW6T_nqqfOtj_dVn9KV+iUbki2X3WU3pxfo25Ewj3i5ZjA@mail.gmail.com>
 <3ed867e06f7f9bb9d89beaafc50905c8@linux.dev>
 <CAPhsuW63KawpM0vBPo9gXjgELKMtUtsL0M4DkbwWZTkub2ZDSw@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

December 16, 2021 4:09 PM, "Paul Menzel" <pmenzel@molgen.mpg.de> wrote:=
=0A=0A> Dear Song, dear Yajun,=0A> =0A> Am 16.12.21 um 07:39 schrieb Song=
 Liu:=0A> =0A>> On Wed, Dec 15, 2021 at 6:15 PM <yajun.deng@linux.dev> wr=
ote:=0A>>> December 16, 2021 12:52 AM, "Song Liu" <song@kernel.org> wrote=
:=0A>> =0A>> On Tue, Dec 14, 2021 at 6:14 PM <yajun.deng@linux.dev> wrote=
:=0A>> =0A>> December 15, 2021 1:27 AM, "Song Liu" <song@kernel.org> wrot=
e:=0A>> =0A>> On Mon, Dec 13, 2021 at 7:17 PM Yajun Deng <yajun.deng@linu=
x.dev> wrote:=0A>> =0A>> We found an abnormally high latency when executi=
ng modprobe raid6_pq, the=0A>> latency is greater than 1.2s when CONFIG_P=
REEMPT_VOLUNTARY=3Dy, greater than=0A>> 67ms when CONFIG_PREEMPT=3Dy, and=
 greater than 16ms when CONFIG_PREEMPT_RT=3Dy.=0A>> This is caused by dis=
able the preemption, this time is too long and=0A>> unreasonable. We just=
 need to disable migration. so used migrate_disable()/=0A>> migrate_enabl=
e() instead of preempt_disable()/preempt_enable(). This is=0A>> beneficia=
l for CONFIG_PREEMPT=3Dy or CONFIG_PREEMPT_RT=3Dy, but no effect for=0A>>=
 CONFIG_PREEMPT_VOLUNTARY=3Dy.=0A>> =0A>> Fixes: fe5cbc6e06c7 ("md/raid6 =
algorithms: delta syndrome functions")=0A>> Signed-off-by: Yajun Deng <ya=
jun.deng@linux.dev>=0A>> =0A>> We measure the speed of different RAID alg=
orithms.If we don't disable=0A>> preempt, the result may be inaccurate, r=
ight? IIUC, we only disable preempt=0A>> for 16 jiffies. Why do we see 1.=
2 second delay?=0A>> =0A>> Here are the command of my test=EF=BC=9A=0A>> =
Execute "sudo cyclictest -S -p 95 -d 0 -i 1000 -D 24h -m" in one terminal=
 and "sudo modprobe=0A>> raid6_pq" in the other terminal.=0A>> =0A>> Here=
 are the results of my test=EF=BC=9A=0A>> CONFIG_PREEMPT_VOLUNTARY=3Dy=EF=
=BC=8CCONFIG_HZ_250=3Dy=0A>> T: 0 ( 3092) P:95 I:1000 C: 8514 Min: 1 Act:=
 2 Avg: 1 Max: 6=0A>> T: 1 ( 3093) P:95 I:1000 C: 8511 Min: 1 Act: 2 Avg:=
 1 Max: 14=0A>> =0A>> I am not very familiar with the RT work, so please =
forgive me for some=0A>> rookie questions.=0A>> =0A>> From the result, I =
think the CONFIG_PREEMPT_VOLUNTARY=3Dy and the=0A>> CONFIG_PREEMPT=3Dy ca=
ses failed to preempt during the preempt enabled period in=0A>> raid6_cho=
ose_gen(). Is this expected?=0A>> =0A>>> No, This is due to disable preem=
ption causing ksoftirqd fail to schedule, we can use bcc tools see=0A>>> =
that.=0A>> =0A>> OTOH, the 16ms latency with CONFIG_PREEMPT_RT=3Dy is mor=
e or less expected.=0A>> Is this acceptable? If not, is 1ms latency accep=
table?=0A>> =0A>>> Here are the test results after adding patch=EF=BC=9A=
=0A>>> CONFIG_PREEMPT=3Dy or CONFIG_PREEMPT_RT=3Dy=0A>>> T: 0 ( 3167) P:9=
5 I:1000 C: 13958 Min: 1 Act: 2 Avg: 1 Max: 5=0A>>> T: 1 ( 3168) P:95 I:1=
000 C: 13956 Min: 1 Act: 2 Avg: 1 Max: 7=0A>>> T: 2 ( 3169) P:95 I:1000 C=
: 13946 Min: 1 Act: 2 Avg: 1 Max: 12=0A>>> T: 3 ( 3170) P:95 I:1000 C: 13=
951 Min: 1 Act: 2 Avg: 1 Max: 5=0A>>> T: 4 ( 3171) P:95 I:1000 C: 13949 M=
in: 1 Act: 2 Avg: 1 Max: 3=0A>>> T: 5 ( 3172) P:95 I:1000 C: 13947 Min: 1=
 Act: 2 Avg: 1 Max: 16=0A>>> T: 6 ( 3173) P:95 I:1000 C: 13945 Min: 1 Act=
: 2 Avg: 2 Max: 7=0A>>> T: 7 ( 3174) P:95 I:1000 C: 13942 Min: 1 Act: 2 A=
vg: 1 Max: 3=0A>>> T: 8 ( 3175) P:95 I:1000 C: 13940 Min: 1 Act: 2 Avg: 1=
 Max: 3=0A>>> T: 9 ( 3176) P:95 I:1000 C: 13938 Min: 1 Act: 1 Avg: 1 Max:=
 3=0A>>> T:10 ( 3177) P:95 I:1000 C: 13936 Min: 1 Act: 2 Avg: 1 Max: 6=0A=
>>> T:11 ( 3178) P:95 I:1000 C: 13933 Min: 1 Act: 2 Avg: 1 Max: 3=0A>>> T=
:12 ( 3179) P:95 I:1000 C: 13931 Min: 1 Act: 2 Avg: 1 Max: 4=0A>>> T:13 (=
 3180) P:95 I:1000 C: 13929 Min: 1 Act: 2 Avg: 1 Max: 7=0A>>> T:14 ( 3181=
) P:95 I:1000 C: 13927 Min: 1 Act: 2 Avg: 1 Max: 6=0A>>> T:15 ( 3182) P:9=
5 I:1000 C: 13925 Min: 1 Act: 2 Avg: 1 Max: 4=0A>>> T:16 ( 3183) P:95 I:1=
000 C: 13923 Min: 1 Act: 2 Avg: 1 Max: 5=0A>>> T:17 ( 3184) P:95 I:1000 C=
: 13921 Min: 1 Act: 2 Avg: 1 Max: 5=0A>>> T:18 ( 3185) P:95 I:1000 C: 139=
19 Min: 1 Act: 2 Avg: 1 Max: 4=0A>>> T:19 ( 3186) P:95 I:1000 C: 13916 Mi=
n: 1 Act: 2 Avg: 1 Max: 4=0A>>> T:20 ( 3187) P:95 I:1000 C: 13914 Min: 1 =
Act: 2 Avg: 1 Max: 4=0A>>> T:21 ( 3188) P:95 I:1000 C: 13912 Min: 1 Act: =
2 Avg: 1 Max: 10=0A>>> T:22 ( 3189) P:95 I:1000 C: 13910 Min: 1 Act: 2 Av=
g: 1 Max: 5=0A>>> T:23 ( 3190) P:95 I:1000 C: 13908 Min: 1 Act: 2 Avg: 1 =
Max: 5=0A>>> T:24 ( 3191) P:95 I:1000 C: 13906 Min: 1 Act: 2 Avg: 1 Max: =
18=0A>>> T:25 ( 3192) P:95 I:1000 C: 13904 Min: 1 Act: 2 Avg: 1 Max: 7=0A=
>>> T:26 ( 3193) P:95 I:1000 C: 13902 Min: 1 Act: 2 Avg: 1 Max: 5=0A>>> T=
:27 ( 3194) P:95 I:1000 C: 13900 Min: 1 Act: 1 Avg: 1 Max: 11=0A>>> T:28 =
( 3195) P:95 I:1000 C: 13898 Min: 1 Act: 2 Avg: 1 Max: 3=0A>>> T:29 ( 319=
6) P:95 I:1000 C: 13896 Min: 1 Act: 2 Avg: 1 Max: 5=0A>>> T:30 ( 3197) P:=
95 I:1000 C: 13894 Min: 1 Act: 2 Avg: 1 Max: 4=0A>>> T:31 ( 3198) P:95 I:=
1000 C: 13892 Min: 1 Act: 2 Avg: 1 Max: 3=0A>>> =0A>>> we can see the lat=
ency will not greater than 100us=EF=BC=8Cso 1ms latency is also too long =
for=0A>>> CONFIG_PREEMPT=3Dy or CONFIG_PREEMPT_RT=3Dy.=0A>>> use migrate_=
disable()/migrate_enable() instead of preempt_disable()/preempt_enable() =
will not=0A>>> affect the speed of different RAID algorithms and the late=
ncy can be reduced to a reasonable range.=0A>> =0A>> I think allowing pre=
empt may still affect the speed comparison. But=0A>> such discrepancy sho=
uld be acceptable. I will apply this to md-next.=0A> =0A> Could the commi=
t message please be extended, how to reproduce this? No idea, where to fi=
nd=0A> `cyclictest` for example. Was `initcall_debug` used to measure the=
 execution time of the init=0A> method?=0A> =0A> Lastly, only one Fixes: =
tag is added, but the mentioned one only added one of the changed=0A> `pr=
eempt_enabled()`/`preempt_disable()`. Should all be listed?=0A> =0A> The =
commit message could also say something like:=0A> =0A>> Reduce high laten=
cy by using migrate instead of preempt=0A> =0A> Kind regards,=0A> =0A> Pa=
ul=0A=0AThank you for your suggestion, I will submit another patch, exten=
ding comment message.
