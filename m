Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82CF8476AC1
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 08:04:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234312AbhLPHEl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 02:04:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231981AbhLPHEk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 02:04:40 -0500
Received: from out1.migadu.com (out1.migadu.com [IPv6:2001:41d0:2:863f::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EF69C061574;
        Wed, 15 Dec 2021 23:04:40 -0800 (PST)
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1639638277;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nNWk5O0CbR7FBc1dZznWt3j4K2i7KWzr7G7vsJMd7v8=;
        b=CBYWSn/9NyHt3VVgz34rR3rVs424/F7Men9AFe0y5jPsMfxSConYJ0YWHMS+Sqj4MSFgjE
        sUqRZGtzjDTrKiWFZNZuQAWRSr7UPsWlAB07OEk0DyyZ8Fb7i3WZJS1FB9itpyOu+61ZM8
        /w6Ks/wQds5LQ641NXdjMkMBFq19ooA=
Date:   Thu, 16 Dec 2021 07:04:37 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   yajun.deng@linux.dev
Message-ID: <b06c5e3ef3413f12a2c2b2a241005af9@linux.dev>
Subject: Re: [PATCH] lib/raid6: fix abnormally high latency
To:     "Song Liu" <song@kernel.org>
Cc:     stockhausen@collogia.de,
        "open list" <linux-kernel@vger.kernel.org>,
        linux-rt-users@vger.kernel.org,
        "linux-raid" <linux-raid@vger.kernel.org>, masahiroy@kernel.org,
        williams@redhat.com
In-Reply-To: <CAPhsuW63KawpM0vBPo9gXjgELKMtUtsL0M4DkbwWZTkub2ZDSw@mail.gmail.com>
References: <CAPhsuW63KawpM0vBPo9gXjgELKMtUtsL0M4DkbwWZTkub2ZDSw@mail.gmail.com>
 <20211214031553.16435-1-yajun.deng@linux.dev>
 <CAPhsuW5X+zewpKoJLjMMGOUeSiJ1EYqD+0i1bA8y7SFtJLkMeg@mail.gmail.com>
 <0d07e13a5454dfb03b22e5223d101a1b@linux.dev>
 <CAPhsuW6T_nqqfOtj_dVn9KV+iUbki2X3WU3pxfo25Ewj3i5ZjA@mail.gmail.com>
 <3ed867e06f7f9bb9d89beaafc50905c8@linux.dev>
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

December 16, 2021 2:39 PM, "Song Liu" <song@kernel.org> wrote:=0A=0A> On =
Wed, Dec 15, 2021 at 6:15 PM <yajun.deng@linux.dev> wrote:=0A> =0A>> Dece=
mber 16, 2021 12:52 AM, "Song Liu" <song@kernel.org> wrote:=0A>> =0A>> On=
 Tue, Dec 14, 2021 at 6:14 PM <yajun.deng@linux.dev> wrote:=0A>> =0A>> De=
cember 15, 2021 1:27 AM, "Song Liu" <song@kernel.org> wrote:=0A>> =0A>> O=
n Mon, Dec 13, 2021 at 7:17 PM Yajun Deng <yajun.deng@linux.dev> wrote:=
=0A>> =0A>> We found an abnormally high latency when executing modprobe r=
aid6_pq, the=0A>> latency is greater than 1.2s when CONFIG_PREEMPT_VOLUNT=
ARY=3Dy, greater than=0A>> 67ms when CONFIG_PREEMPT=3Dy, and greater than=
 16ms when CONFIG_PREEMPT_RT=3Dy.=0A>> This is caused by disable the pree=
mption, this time is too long and=0A>> unreasonable. We just need to disa=
ble migration. so used migrate_disable()/=0A>> migrate_enable() instead o=
f preempt_disable()/preempt_enable(). This is=0A>> beneficial for CONFIG_=
PREEMPT=3Dy or CONFIG_PREEMPT_RT=3Dy, but no effect for=0A>> CONFIG_PREEM=
PT_VOLUNTARY=3Dy.=0A>> =0A>> Fixes: fe5cbc6e06c7 ("md/raid6 algorithms: d=
elta syndrome functions")=0A>> Signed-off-by: Yajun Deng <yajun.deng@linu=
x.dev>=0A>> =0A>> We measure the speed of different RAID algorithms.If we=
 don't disable=0A>> preempt, the result may be inaccurate, right? IIUC, w=
e only disable preempt=0A>> for 16 jiffies. Why do we see 1.2 second dela=
y?=0A>> =0A>> Here are the command of my test=EF=BC=9A=0A>> Execute "sudo=
 cyclictest -S -p 95 -d 0 -i 1000 -D 24h -m" in one terminal and "sudo mo=
dprobe=0A>> raid6_pq" in the other terminal.=0A>> =0A>> Here are the resu=
lts of my test=EF=BC=9A=0A>> CONFIG_PREEMPT_VOLUNTARY=3Dy=EF=BC=8CCONFIG_=
HZ_250=3Dy=0A>> T: 0 ( 3092) P:95 I:1000 C: 8514 Min: 1 Act: 2 Avg: 1 Max=
: 6=0A>> T: 1 ( 3093) P:95 I:1000 C: 8511 Min: 1 Act: 2 Avg: 1 Max: 14=0A=
>> =0A>> I am not very familiar with the RT work, so please forgive me fo=
r some=0A>> rookie questions.=0A>> =0A>> From the result, I think the CON=
FIG_PREEMPT_VOLUNTARY=3Dy and the=0A>> CONFIG_PREEMPT=3Dy cases failed to=
 preempt during the preempt enabled period in=0A>> raid6_choose_gen(). Is=
 this expected?=0A>> =0A>> No, This is due to disable preemption causing =
ksoftirqd fail to schedule, we can use bcc tools see=0A>> that.=0A>> =0A>=
> OTOH, the 16ms latency with CONFIG_PREEMPT_RT=3Dy is more or less expec=
ted.=0A>> Is this acceptable? If not, is 1ms latency acceptable?=0A>> =0A=
>> Here are the test results after adding patch=EF=BC=9A=0A>> CONFIG_PREE=
MPT=3Dy or CONFIG_PREEMPT_RT=3Dy=0A>> T: 0 ( 3167) P:95 I:1000 C: 13958 M=
in: 1 Act: 2 Avg: 1 Max: 5=0A>> T: 1 ( 3168) P:95 I:1000 C: 13956 Min: 1 =
Act: 2 Avg: 1 Max: 7=0A>> T: 2 ( 3169) P:95 I:1000 C: 13946 Min: 1 Act: 2=
 Avg: 1 Max: 12=0A>> T: 3 ( 3170) P:95 I:1000 C: 13951 Min: 1 Act: 2 Avg:=
 1 Max: 5=0A>> T: 4 ( 3171) P:95 I:1000 C: 13949 Min: 1 Act: 2 Avg: 1 Max=
: 3=0A>> T: 5 ( 3172) P:95 I:1000 C: 13947 Min: 1 Act: 2 Avg: 1 Max: 16=
=0A>> T: 6 ( 3173) P:95 I:1000 C: 13945 Min: 1 Act: 2 Avg: 2 Max: 7=0A>> =
T: 7 ( 3174) P:95 I:1000 C: 13942 Min: 1 Act: 2 Avg: 1 Max: 3=0A>> T: 8 (=
 3175) P:95 I:1000 C: 13940 Min: 1 Act: 2 Avg: 1 Max: 3=0A>> T: 9 ( 3176)=
 P:95 I:1000 C: 13938 Min: 1 Act: 1 Avg: 1 Max: 3=0A>> T:10 ( 3177) P:95 =
I:1000 C: 13936 Min: 1 Act: 2 Avg: 1 Max: 6=0A>> T:11 ( 3178) P:95 I:1000=
 C: 13933 Min: 1 Act: 2 Avg: 1 Max: 3=0A>> T:12 ( 3179) P:95 I:1000 C: 13=
931 Min: 1 Act: 2 Avg: 1 Max: 4=0A>> T:13 ( 3180) P:95 I:1000 C: 13929 Mi=
n: 1 Act: 2 Avg: 1 Max: 7=0A>> T:14 ( 3181) P:95 I:1000 C: 13927 Min: 1 A=
ct: 2 Avg: 1 Max: 6=0A>> T:15 ( 3182) P:95 I:1000 C: 13925 Min: 1 Act: 2 =
Avg: 1 Max: 4=0A>> T:16 ( 3183) P:95 I:1000 C: 13923 Min: 1 Act: 2 Avg: 1=
 Max: 5=0A>> T:17 ( 3184) P:95 I:1000 C: 13921 Min: 1 Act: 2 Avg: 1 Max: =
5=0A>> T:18 ( 3185) P:95 I:1000 C: 13919 Min: 1 Act: 2 Avg: 1 Max: 4=0A>>=
 T:19 ( 3186) P:95 I:1000 C: 13916 Min: 1 Act: 2 Avg: 1 Max: 4=0A>> T:20 =
( 3187) P:95 I:1000 C: 13914 Min: 1 Act: 2 Avg: 1 Max: 4=0A>> T:21 ( 3188=
) P:95 I:1000 C: 13912 Min: 1 Act: 2 Avg: 1 Max: 10=0A>> T:22 ( 3189) P:9=
5 I:1000 C: 13910 Min: 1 Act: 2 Avg: 1 Max: 5=0A>> T:23 ( 3190) P:95 I:10=
00 C: 13908 Min: 1 Act: 2 Avg: 1 Max: 5=0A>> T:24 ( 3191) P:95 I:1000 C: =
13906 Min: 1 Act: 2 Avg: 1 Max: 18=0A>> T:25 ( 3192) P:95 I:1000 C: 13904=
 Min: 1 Act: 2 Avg: 1 Max: 7=0A>> T:26 ( 3193) P:95 I:1000 C: 13902 Min: =
1 Act: 2 Avg: 1 Max: 5=0A>> T:27 ( 3194) P:95 I:1000 C: 13900 Min: 1 Act:=
 1 Avg: 1 Max: 11=0A>> T:28 ( 3195) P:95 I:1000 C: 13898 Min: 1 Act: 2 Av=
g: 1 Max: 3=0A>> T:29 ( 3196) P:95 I:1000 C: 13896 Min: 1 Act: 2 Avg: 1 M=
ax: 5=0A>> T:30 ( 3197) P:95 I:1000 C: 13894 Min: 1 Act: 2 Avg: 1 Max: 4=
=0A>> T:31 ( 3198) P:95 I:1000 C: 13892 Min: 1 Act: 2 Avg: 1 Max: 3=0A>> =
=0A>> we can see the latency will not greater than 100us=EF=BC=8Cso 1ms l=
atency is also too long for=0A>> CONFIG_PREEMPT=3Dy or CONFIG_PREEMPT_RT=
=3Dy.=0A>> use migrate_disable()/migrate_enable() instead of preempt_disa=
ble()/preempt_enable() will not=0A>> affect the speed of different RAID a=
lgorithms and the latency can be reduced to a reasonable range.=0A> =0A> =
I think allowing preempt may still affect the speed comparison. But=0A> s=
uch discrepancy=0A> should be acceptable. I will apply this to md-next.=
=0A=0AThank you, would you mind backport this patch to all LTS kernel? As=
 you can see, the latency is not a little higher, but too much higher, it=
 seems unreasonable=EF=BC=8C I think this may be a bug. We are using the =
5.10 kernel and it would be very convenient for us if that was done.=0A=
=0A> Thanks,=0A> Song
