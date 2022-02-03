Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F9FA4A8815
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 16:53:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352015AbiBCPxl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 10:53:41 -0500
Received: from mail.efficios.com ([167.114.26.124]:35182 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239753AbiBCPxk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 10:53:40 -0500
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 08112390D23;
        Thu,  3 Feb 2022 10:53:40 -0500 (EST)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id b7R6ljw7HSO1; Thu,  3 Feb 2022 10:53:39 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 5E81C390BCD;
        Thu,  3 Feb 2022 10:53:39 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 5E81C390BCD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1643903619;
        bh=/8wVYthViEyRys4kgMvHu8UD3IzJeS/ZOiKEPGOloZw=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=ZZiJR0hhbxAZ82ZsI9KT9a6uORRBezuLQPNIT4/YxjYbKKtM5vO2ejTKwMm/zUarZ
         z4ZUH/Z5Fzn+Pq/08vQE8LW6RxcAcm0t+WWcdohS83mEnxtiDznGILJ6xj/0hE9QqM
         rkbyLqprq/U2fa4qXXy4cwOoitXTqAK6aiTieSXR8vZdHT6nNWaGbegjvrZIwNef6u
         GYamXGViEobnjleunolsa5oMbQ9lKNikAJtx9PiOcn8Q7Mx1E6Rp63GeNvM2AsDG10
         2ZpsOhH+hyXjrofDfLwS6YcwG06Z7jHI96O4+OIr9AA8gi5oga/IUWAKhVcDcUVmim
         9j6CHyyf2y0fA==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id KjRa12abZ1Nl; Thu,  3 Feb 2022 10:53:39 -0500 (EST)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
        by mail.efficios.com (Postfix) with ESMTP id 4BE65390BC7;
        Thu,  3 Feb 2022 10:53:39 -0500 (EST)
Date:   Thu, 3 Feb 2022 10:53:39 -0500 (EST)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Florian Weimer <fw@deneb.enyo.de>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        paulmck <paulmck@kernel.org>, Boqun Feng <boqun.feng@gmail.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Paul Turner <pjt@google.com>,
        linux-api <linux-api@vger.kernel.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        David Laight <David.Laight@ACULAB.COM>,
        carlos <carlos@redhat.com>, Peter Oskolkov <posk@posk.io>
Message-ID: <1685571268.31788.1643903619178.JavaMail.zimbra@efficios.com>
In-Reply-To: <1285409089.26848.1643765557716.JavaMail.zimbra@efficios.com>
References: <20220201192540.10439-1-mathieu.desnoyers@efficios.com> <20220201192540.10439-2-mathieu.desnoyers@efficios.com> <87bkzqz75q.fsf@mid.deneb.enyo.de> <1075473571.25688.1643746930751.JavaMail.zimbra@efficios.com> <87sft2xr7w.fsf@mid.deneb.enyo.de> <1339477886.25835.1643750440726.JavaMail.zimbra@efficios.com> <87o83qxok9.fsf@mid.deneb.enyo.de> <1285409089.26848.1643765557716.JavaMail.zimbra@efficios.com>
Subject: Re: [RFC PATCH 2/3] rseq: extend struct rseq with per thread group
 vcpu id
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_4203 (ZimbraWebClient - FF96 (Linux)/8.8.15_GA_4203)
Thread-Topic: rseq: extend struct rseq with per thread group vcpu id
Thread-Index: C6NWYE2w3ULPRtwNBg28J/VU9Te00jWeL08W
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- On Feb 1, 2022, at 8:32 PM, Mathieu Desnoyers mathieu.desnoyers@effic=
ios.com wrote:

> ----- On Feb 1, 2022, at 4:30 PM, Florian Weimer fw@deneb.enyo.de wrote:
>=20
>> * Mathieu Desnoyers:
>>=20
>>> ----- On Feb 1, 2022, at 3:32 PM, Florian Weimer fw@deneb.enyo.de wrote=
:
>>> [...]
>>>>=20
>>>>>> Is the switch really useful?  I suspect it's faster to just write as
>>>>>> much as possible all the time.  The switch should be well-predictabl=
e
>>>>>> if running uniform userspace, but still =E2=80=A6
>>>>>
>>>>> The switch ensures the kernel don't try to write to a memory area bey=
ond
>>>>> the rseq size which has been registered by user-space. So it seems to=
 be
>>>>> useful to ensure we don't corrupt user-space memory. Or am I missing =
your
>>>>> point ?
>>>>=20
>>>> Due to the alignment, I think you'd only ever see 32 and 64 bytes for
>>>> now?
>>>
>>> Yes, but I would expect the rseq registration arguments to have a rseq_=
len
>>> of offsetofend(struct rseq, tg_vcpu_id) when userspace wants the tg_vcp=
u_id
>>> feature to be supported (but not the following features).
>>=20
>> But if rseq is managed by libc, it really has to use the full size
>> unconditionally.  I would even expect that eventually, the kernel only
>> supports the initial 32, maybe 64 for a few early extension, and the
>> size indicated by the auxiliary vector.
>>=20
>> Not all of that area would be ABI, some of it would be used by the
>> vDSO only and opaque to userspace application (with applications/libcs
>> passing __rseq_offset as an argument to these functions).
>>=20
>=20
> I think one aspect leading to our misunderstanding here is the distinctio=
n
> between the size of the rseq area _allocation_, and the offset after the =
last
> field supported by the given kernel.
>=20
> With this in mind, let's state a bit more clearly our expected aux. vecto=
r
> extensibility scheme.
>=20
> With CONFIG_RSEQ=3Dy, the kernel would pass the following information thr=
ough
> the ELF auxv:
>=20
> - rseq allocation size (auxv_rseq_alloc_size),
> - rseq allocation alignment (auxv_rseq_alloc_align),
> - offset after the end of the last rseq field supported by this kernel
> (auxv_rseq_offset_end),
>=20
> We always have auxv_rseq_alloc_size >=3D auxv_rseq_offset_end.
>=20
> I would expect libc to use this information to allocate a memory area
> at least auxv_rseq_alloc_size in size, with an alignment respecting
> auxv_rseq_alloc_align. It would use a value >=3D auvx_rseq_alloc_size
> as rseq_len argument for the rseq registration.
>=20
> But I would expect libc to use the auxv_rseq_offset_end value to populate
> __rseq_size,
> so rseq users can rely on this to check whether the fields they are tryin=
g to
> access
> is indeed populated by the kernel.
>=20
> Of course, the kernel would still allow the original 32-byte rseq_len arg=
ument
> for the rseq registration, so the original ABI still works. It would howe=
ver
> reject any rseq registration with size smaller than auxv_rseq_alloc_size =
(other
> than the 32-byte special-case).
>=20
> Is that in line with what you have in mind ? Do we really need to expose =
those 3
> auxv variables independently or can we somehow remove auxv_rseq_alloc_siz=
e and
> use auxv_rseq_offset_end as a min value for allocation instead ?

After giving all this some more thoughts, I think we can extend struct rseq
cleanly without adding any "padding1" fields at the end of the existing str=
ucture
(which would be effectively wasting very useful hot cache line space).

Here is what I have in mind:

We consider separately the "size" and the "feature_size" of the rseq struct=
ure.

- The "size" is really the size for memory allocation (includes padding),
- The "feature_size" is the offset after the last supported feature field.

So for the original struct rseq, size=3D32 bytes and feature_size=3D20 byte=
s
(offsetofend(struct rseq, flags)).

The kernel can expose this "supported rseq feature size" value through the =
ELF auxiliary
vector (with a new AT_RSEQ_FEATURE_SIZE). It would also expose a new AT_RSE=
Q_ALIGN for the
minimal allocation alignment required by the kernel. Those can be queried b=
y user-space
through getauxval(3).

glibc can add a new const unsigned int __rseq_feature_size symbol in a futu=
re release which
will support extended rseq structures. This is the symbol I expect rseq use=
rs to check
at least once in the program's lifetime before they try to access rseq fiel=
ds beyond
the originally populated 20 bytes.

The rseq_len argument passed to sys_rseq would really be the allocated size=
 for the rseq
area (as it is today, considering that the kernel expects sizeof(struct rse=
q)). Typically,
I would expect glibc to take the rseq feature_size value and round it up to=
 a value which
is a multiple of the AT_RSEQ_ALIGN. That allocation size would be used to p=
opulate
__rseq_size.

Am I missing something ?

Thanks,

Mathieu

--=20
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
