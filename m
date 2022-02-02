Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89ED94A69A3
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 02:32:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243658AbiBBBcl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 20:32:41 -0500
Received: from mail.efficios.com ([167.114.26.124]:34636 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243588AbiBBBcj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 20:32:39 -0500
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 94CEE34ADCC;
        Tue,  1 Feb 2022 20:32:38 -0500 (EST)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id B08G1LtHUYL6; Tue,  1 Feb 2022 20:32:38 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id E66E634AD59;
        Tue,  1 Feb 2022 20:32:37 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com E66E634AD59
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1643765557;
        bh=lPiM71Cp9ZD6U9r0qS47fL7HiJ2HIt5ccbckyQ6rHVs=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=ABnXjypffa7t/zyFCUaUIlLar2q6MXBX4wO5rTMDtL9WalG5487R+eU9V4YMPIdmx
         rDJTMqW/bSvLvYlZLwaB+igGua9RNLjj5OcQK9NczwPouKJ9xJuOdiNGF1hBl4i4eg
         6XRvbA4hZnpZFG0RMy6gYAIFpMnial2Kdyr/acQrRpFqbIMjdB+YoGFlgWDngtrBHF
         Egic14uAqbylWKK118k3HG5WycZOco3W1dzbd/2ZQjCWwMnuYaXXAop+KJ5dEItfPR
         elax4Jijk+135s2kxcQQ0SJWKFZ5Es094apKmbHvCxAKUHta6TzfhP64QYaOvcXzJ2
         hhvYJw7ipEMUA==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id M7mesyI4WlzK; Tue,  1 Feb 2022 20:32:37 -0500 (EST)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
        by mail.efficios.com (Postfix) with ESMTP id D2F5234AF27;
        Tue,  1 Feb 2022 20:32:37 -0500 (EST)
Date:   Tue, 1 Feb 2022 20:32:37 -0500 (EST)
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
Message-ID: <1285409089.26848.1643765557716.JavaMail.zimbra@efficios.com>
In-Reply-To: <87o83qxok9.fsf@mid.deneb.enyo.de>
References: <20220201192540.10439-1-mathieu.desnoyers@efficios.com> <20220201192540.10439-2-mathieu.desnoyers@efficios.com> <87bkzqz75q.fsf@mid.deneb.enyo.de> <1075473571.25688.1643746930751.JavaMail.zimbra@efficios.com> <87sft2xr7w.fsf@mid.deneb.enyo.de> <1339477886.25835.1643750440726.JavaMail.zimbra@efficios.com> <87o83qxok9.fsf@mid.deneb.enyo.de>
Subject: Re: [RFC PATCH 2/3] rseq: extend struct rseq with per thread group
 vcpu id
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_4203 (ZimbraWebClient - FF96 (Linux)/8.8.15_GA_4203)
Thread-Topic: rseq: extend struct rseq with per thread group vcpu id
Thread-Index: C6NWYE2w3ULPRtwNBg28J/VU9Te00g==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- On Feb 1, 2022, at 4:30 PM, Florian Weimer fw@deneb.enyo.de wrote:

> * Mathieu Desnoyers:
>=20
>> ----- On Feb 1, 2022, at 3:32 PM, Florian Weimer fw@deneb.enyo.de wrote:
>> [...]
>>>=20
>>>>> Is the switch really useful?  I suspect it's faster to just write as
>>>>> much as possible all the time.  The switch should be well-predictable
>>>>> if running uniform userspace, but still =E2=80=A6
>>>>
>>>> The switch ensures the kernel don't try to write to a memory area beyo=
nd
>>>> the rseq size which has been registered by user-space. So it seems to =
be
>>>> useful to ensure we don't corrupt user-space memory. Or am I missing y=
our
>>>> point ?
>>>=20
>>> Due to the alignment, I think you'd only ever see 32 and 64 bytes for
>>> now?
>>
>> Yes, but I would expect the rseq registration arguments to have a rseq_l=
en
>> of offsetofend(struct rseq, tg_vcpu_id) when userspace wants the tg_vcpu=
_id
>> feature to be supported (but not the following features).
>=20
> But if rseq is managed by libc, it really has to use the full size
> unconditionally.  I would even expect that eventually, the kernel only
> supports the initial 32, maybe 64 for a few early extension, and the
> size indicated by the auxiliary vector.
>=20
> Not all of that area would be ABI, some of it would be used by the
> vDSO only and opaque to userspace application (with applications/libcs
> passing __rseq_offset as an argument to these functions).
>=20

I think one aspect leading to our misunderstanding here is the distinction
between the size of the rseq area _allocation_, and the offset after the la=
st
field supported by the given kernel.

With this in mind, let's state a bit more clearly our expected aux. vector
extensibility scheme.

With CONFIG_RSEQ=3Dy, the kernel would pass the following information throu=
gh
the ELF auxv:

- rseq allocation size (auxv_rseq_alloc_size),
- rseq allocation alignment (auxv_rseq_alloc_align),
- offset after the end of the last rseq field supported by this kernel (aux=
v_rseq_offset_end),

We always have auxv_rseq_alloc_size >=3D auxv_rseq_offset_end.

I would expect libc to use this information to allocate a memory area
at least auxv_rseq_alloc_size in size, with an alignment respecting
auxv_rseq_alloc_align. It would use a value >=3D auvx_rseq_alloc_size
as rseq_len argument for the rseq registration.

But I would expect libc to use the auxv_rseq_offset_end value to populate _=
_rseq_size,
so rseq users can rely on this to check whether the fields they are trying =
to access
is indeed populated by the kernel.

Of course, the kernel would still allow the original 32-byte rseq_len argum=
ent
for the rseq registration, so the original ABI still works. It would howeve=
r
reject any rseq registration with size smaller than auxv_rseq_alloc_size (o=
ther
than the 32-byte special-case).

Is that in line with what you have in mind ? Do we really need to expose th=
ose 3
auxv variables independently or can we somehow remove auxv_rseq_alloc_size =
and
use auxv_rseq_offset_end as a min value for allocation instead ?

Thanks,

Mathieu

--=20
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
