Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0BAD4A66EA
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 22:20:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230410AbiBAVUn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 16:20:43 -0500
Received: from mail.efficios.com ([167.114.26.124]:34862 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbiBAVUm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 16:20:42 -0500
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 7C44D3489E5;
        Tue,  1 Feb 2022 16:20:41 -0500 (EST)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id CZZ_RyJthgKz; Tue,  1 Feb 2022 16:20:41 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id E578D3489E4;
        Tue,  1 Feb 2022 16:20:40 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com E578D3489E4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1643750440;
        bh=Rs42uhd61aoxm5cSNaX6/XcFhJcPHx0iBwfw7ZTWSPY=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=bLay9OZ4WIiR/B5W9gVMoxWiQCdNpza/6lnCDnHEXtBySQd+nWIP2Sl9QRtUuH/jO
         mbrtm903kjlopgDANUa8l1cZJjWBxDDWVr6p2Rg6LYggmU0lcz8kB+HH71MxelfGJE
         U3MsxEP+V01t5TwkaiTiCWk3pvor6VdWp6fKeuWBjr60mvLXZCTa1t0Jg5B/B9sM4V
         aBsrJX/HB6Qhd6DnvTdADtB8ZaYlP3e4gNfDSHmLnJIv9jTGLCq30FtYXdEsQ17yLy
         2PCpgDn8p8QTACBoac3TyrbmbHKB4mh8wv5+VVnC2OlQX3hOo8f4SjFOQuB0mK2vWx
         vf9DfiATwN+vg==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id JkcVu1ICMl1z; Tue,  1 Feb 2022 16:20:40 -0500 (EST)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
        by mail.efficios.com (Postfix) with ESMTP id D24C0348BCC;
        Tue,  1 Feb 2022 16:20:40 -0500 (EST)
Date:   Tue, 1 Feb 2022 16:20:40 -0500 (EST)
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
Message-ID: <1339477886.25835.1643750440726.JavaMail.zimbra@efficios.com>
In-Reply-To: <87sft2xr7w.fsf@mid.deneb.enyo.de>
References: <20220201192540.10439-1-mathieu.desnoyers@efficios.com> <20220201192540.10439-2-mathieu.desnoyers@efficios.com> <87bkzqz75q.fsf@mid.deneb.enyo.de> <1075473571.25688.1643746930751.JavaMail.zimbra@efficios.com> <87sft2xr7w.fsf@mid.deneb.enyo.de>
Subject: Re: [RFC PATCH 2/3] rseq: extend struct rseq with per thread group
 vcpu id
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_4203 (ZimbraWebClient - FF96 (Linux)/8.8.15_GA_4203)
Thread-Topic: rseq: extend struct rseq with per thread group vcpu id
Thread-Index: HxTS/X/4/EGniWu5U6wjiNX9x9OEuQ==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- On Feb 1, 2022, at 3:32 PM, Florian Weimer fw@deneb.enyo.de wrote:
[...]
>=20
>>> Is the switch really useful?  I suspect it's faster to just write as
>>> much as possible all the time.  The switch should be well-predictable
>>> if running uniform userspace, but still =E2=80=A6
>>
>> The switch ensures the kernel don't try to write to a memory area beyond
>> the rseq size which has been registered by user-space. So it seems to be
>> useful to ensure we don't corrupt user-space memory. Or am I missing you=
r
>> point ?
>=20
> Due to the alignment, I think you'd only ever see 32 and 64 bytes for
> now?

Yes, but I would expect the rseq registration arguments to have a rseq_len
of offsetofend(struct rseq, tg_vcpu_id) when userspace wants the tg_vcpu_id
feature to be supported (but not the following features).

Then, as we append additional features as follow-up fields, those
eventually become requested by glibc by increasing the requested size.

Then it's kind of weird to receive a registration size which is not
aligned on 32-byte, but then use internal knowledge of the structure
alignment in the kernel code to write beyond the requested size. And all
this in a case where we are returning to user-space after a preemption,
so I don't expect this extra switch/case to cause significant overhead.

>=20
> I'd appreciate if you could put the maximm supported size and possibly
> the alignment in the auxiliary vector, so that we don't have to rseq
> system calls in a loop on process startup.

Yes, it's a good idea. I'm not too familiar with the auxiliary vector.
Are we talking about the kernel's

fs/binfmt_elf.c:fill_auxv_note()

?

Thanks,

Mathieu

--=20
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
