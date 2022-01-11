Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7A8748AA93
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 10:32:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237308AbiAKJch (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 04:32:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236995AbiAKJcg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 04:32:36 -0500
Received: from hall.aurel32.net (hall.aurel32.net [IPv6:2001:bc8:30d7:100::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AF33C06173F
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jan 2022 01:32:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=aurel32.net
        ; s=202004.hall; h=In-Reply-To:Content-Transfer-Encoding:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:Reply-To:
        Subject:Content-ID:Content-Description:X-Debbugs-Cc;
        bh=ZM52aN43ucM3YK28bONSh84BI+KZOhx/qnnb9aXOn7A=; b=PekKY6q4tjMvDjClfD7jwNL6kc
        /Bt5hS7Ga4DWv2VnJ4ldhnMsTXc1OGKtIGpzVOtScJsDtT9mkZ0F+o2iR8zH7+CJ8Bmyr82cTu2l0
        z7D4TwM8D8VaomX0BgxF7UAjrruiiLFklW9XiWfTjO2uPpnDS0avRiAskOiXHlZXSKDCR3TILaiQW
        sUSQmiN6IZAHnqvnsk0RFN119FAm5rYv+Li4JUCfBFjIdd8wbUKlDfTHTi9yfUIfsfZe9hhvRU3C8
        vMmFOrRp04cfYUveJ6HrfL0PyfvdZtP3R5tnK+b4J4GZABz1ONOWVAZ6cTfaiaHpbtXmUK0m8Tmkt
        ROFBsmrQ==;
Received: from [2a01:e34:ec5d:a741:8a4c:7c4e:dc4c:1787] (helo=ohm.rr44.fr)
        by hall.aurel32.net with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <aurelien@aurel32.net>)
        id 1n7DVw-006ELw-St; Tue, 11 Jan 2022 10:32:24 +0100
Received: from aurel32 by ohm.rr44.fr with local (Exim 4.95)
        (envelope-from <aurelien@aurel32.net>)
        id 1n7DVw-005ByO-83;
        Tue, 11 Jan 2022 10:32:24 +0100
Date:   Tue, 11 Jan 2022 10:32:24 +0100
From:   Aurelien Jarno <aurelien@aurel32.net>
To:     Atish Patra <atishp@atishpatra.org>,
        Palmer Dabbelt <palmer@dabbelt.com>
Cc:     Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
        Anup Patel <Anup.Patel@wdc.com>,
        Anup Patel <anup@brainfault.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Atish Patra <Atish.Patra@wdc.com>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        Philipp Tomsich <ptomsich@ventanamicro.com>,
        Greg Favor <gfavor@ventanamicro.com>,
        Kumar Sankaran <ksankaran@ventanamicro.com>,
        Mark Himelstein <markhimelstein@riscv.org>
Subject: Re: [PATCH v7 1/1] RISC-V: Use SBI SRST extension when available
Message-ID: <Yd1OqLCSI6h+A0Ry@aurel32.net>
Mail-Followup-To: Atish Patra <atishp@atishpatra.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
        Anup Patel <Anup.Patel@wdc.com>, Anup Patel <anup@brainfault.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Atish Patra <Atish.Patra@wdc.com>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        Philipp Tomsich <ptomsich@ventanamicro.com>,
        Greg Favor <gfavor@ventanamicro.com>,
        Kumar Sankaran <ksankaran@ventanamicro.com>,
        Mark Himelstein <markhimelstein@riscv.org>
References: <mhng-6c25dda6-4c85-447c-ad9c-7641f2858b10@palmerdabbelt-glaptop>
 <mhng-40d64bc7-5a95-4a16-af45-1d7fd7c6167e@palmerdabbelt-glaptop>
 <CAOnJCUJpLSWJ1VsJuUwfrG8vn0+hCkg2RgdOhNLTEq8C7Mo88w@mail.gmail.com>
 <b3cc6176-60b0-119c-ba1d-1fdc015bd081@canonical.com>
 <CAOnJCUKO6YzYsq4XqPHg8SwkbZ_GrE8iyUSmJGKOHkrdE0Bc+A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CAOnJCUKO6YzYsq4XqPHg8SwkbZ_GrE8iyUSmJGKOHkrdE0Bc+A@mail.gmail.com>
User-Agent: Mutt/2.1.4 (2021-12-11)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-11-12 17:49, Atish Patra wrote:
> On Tue, Nov 9, 2021 at 10:19 AM Heinrich Schuchardt
> <heinrich.schuchardt@canonical.com> wrote:
> >
> > On 7/29/21 08:10, Atish Patra wrote:
> > > On Wed, Jul 28, 2021 at 9:30 PM Palmer Dabbelt <palmer@dabbelt.com> w=
rote:
> > >>
> > >> On Sun, 11 Jul 2021 11:59:33 PDT (-0700), Palmer Dabbelt wrote:
> > >>> On Fri, 09 Jul 2021 22:01:02 PDT (-0700), Anup Patel wrote:
> > >>>>
> > >>>>
> > >>>> =EF=BB=BFOn 08/07/21, 9:22 AM, "Anup Patel" <anup@brainfault.org> =
wrote:
> > >>>>
> > >>>>      On Wed, Jul 7, 2021 at 1:57 AM Palmer Dabbelt <palmerdabbelt@=
google.com> wrote:
> > >>>>      >
> > >>>>      > On Mon, 21 Jun 2021 21:46:46 PDT (-0700), anup@brainfault.o=
rg wrote:
> > >>>>      > > Hi Palmer,
> > >>>>      > >
> > >>>>      > > On Wed, Jun 9, 2021 at 5:43 PM Anup Patel <anup.patel@wdc=
=2Ecom> wrote:
> > >>>>      > >>
> > >>>>      > >> The SBI SRST extension provides a standard way to powero=
ff and
> > >>>>      > >> reboot the system irrespective to whether Linux RISC-V S=
-mode
> > >>>>      > >> is running natively (HS-mode) or inside Guest/VM (VS-mod=
e).
> > >>>>      > >>
> > >>>>      > >> The SBI SRST extension is available in the SBI v0.3 spec=
ification.
> > >>>>      > >> (Refer, https://github.com/riscv/riscv-sbi-doc/releases/=
tag/v0.3.0-rc1)
> > >>>>      > >
> > >>>>      > > Can you please consider this patch for Linux-5.14-rc1 ?
> > >>>>      > >
> > >>>>      > > The SBI v0.3 spec is already frozen and this patch has be=
en
> > >>>>      > > floating on LKML for quite a few months now.
> > >>>>      >
> > >>>>      > I didn't realize that SBI-0.3 had been frozed.  That link i=
s to a RC,
> > >>>>      > the cooresponding v0.3.0 tag isn't in that repo.  Can you g=
ive me a
> > >>>>      > pointer to the frozen spec?
> > >>>>
> > >>>>      Here's the link to SBI v0.3.0 tag:
> > >>>>      https://github.com/riscv/riscv-sbi-doc/releases/tag/v0.3.0
> > >>>>
> > >>>>      We treat RC tags as frozen in SBI spec because no functional
> > >>>>      changes are done in SBI spec after it is tagged as RC. We only
> > >>>>      do typo fixes and clarifications on SBI spec RC release.
> > >>>
> > >>> Treating the 0.3.0-rc1 as frozen as soon as it's released is a
> > >>> terrifying policy: some of the fixes I sent in after I saw rc1 rele=
ased
> > >>> change the actual meaning of the text, even if they were meant to c=
hange
> > >>> them to what I thought the intended meaning was supposed to be.  Th=
at
> > >>> means the actual text of 0.3.0-rc1 and 0.3.0 conflict with each oth=
er.
> > >>> Given that frozen comes with a guarntee of backwards compatibility,=
 does
> > >>> that mean that the behavior allowed by 0.3.0-rc1 is compliant with =
the
> > >>> SBI, even if it was likely just allowed by a wording mistake?
> > >>>
> > >>> If you're going to freeze things at rc1 then you really need to be =
quite
> > >>> explicit about that, as generally the point of RCs is to elicit
> > >>> review/testing.  Looks like I was the only person to have provided =
any
> > >>> review, so I guess I was the only one who assumed "We don't expect =
any
> > >>> significant functional changes. We will wait for any further feedba=
ck
> > >>> and release the official v0.3 in a month or so." actually meant "th=
is is
> > >>> frozen".
> > >>>
> > >>>> Can you take this patch for Linux-5.14 ??
> > >>>
> > >>> No, sorry, it's way too late for that.  Please be specific about wh=
en
> > >>> you freeze specifications in the future, so we can all stay on the =
same
> > >>> page.
> > >>
> > >> I went and talked to Krste, and he says that there's a whole process=
 for
> > >> freezing extensions that this hasn't gone through.  They don't have
> > >> anything written down that I can point to, but can you guys please j=
ust
> > >> get on the same page about this?  It seems like every time I talk to
> > >
> > > Absolutely. The freezing extensions process is documented right now[1]
> > > but that is only meant
> > > for ISA/hardware/platform specifications. There is no process defined
> > > for a SBI specification which is purely
> > > a software specification because SBI specification release
> > > processes(v0.1 and v0.2) predate these documented processes.
> > > The SBI specification is owned by the Platform HSC which falls under
> > > the purview of software HC.
> > > You can see a detailed chart of the RVI organization at [2]. All the
> > > aspects of SBI specification are discussed
> > > in platform meetings[3] and frozen only after public review[4] and
> > > approval from the platform working group
> > > and the software HC. The official SBI specification(v0.3) will also be
> > > available along with all other RISC-V specifications
> > > once they figure out how to structure non-ISA specifications.
> > >
> > > I have cc'd Kumar (chair of the Platform HSC) and Philip (chair of the
> > > software HC) in case they want to add anything.
> > > I was not aware of the fact that Krste/Andrew are not aware of the
> > > progress of the SBI specification.
> > > I will raise this topic during the next meeting and make sure they are
> > > in the loop as well.
> > >
> > >> someone from the RISC-V foundation I get a conflicting description of
> > >> what's going on, and I'm entirely out of patience when it comes to
> > >> getting blamed for all the chaos over there.
> > >>
> > > I agree the RVI process has not been very clear in the past. However,
> > > that has changed a lot in recent times thanks to Mark and
> > > other working group chairs. I don't think anybody is blaming you for
> > > the delay in ratification of the RVI specifications.
> > > There is a clear path for all the specifications to be ratified e.g.
> > > the AIA and H extensions are planned to be frozen by the end of this
> > > year.
> > > Let me know if you want to see the timeline of each specification and
> > > I can point you to the correct sheet.
> > >
> > > [1] https://docs.google.com/presentation/d/1nQ5uFb39KA6gvUi5SReWfIQSi=
RN7hp6z7ZPfctE4mKk/edit#slide=3Did.ga0a994c3c8_0_6
> > > [2] https://docs.google.com/presentation/d/1eEVuu6lRZd9iiDnZQSZME7Q7s=
vtTG3pGIKHPmZ79B8E/edit#slide=3Did.ga275a504df_0_9
> > > [3] https://github.com/riscv/riscv-platform-specs/wiki
> > > [4] https://lists.riscv.org/g/tech-unixplatformspec/message/1042
> >
> > https://github.com/riscv-non-isa/riscv-sbi-doc/releases/tag/v0.3.1-rc1
> > has:
> >
> > "This tag the release candidate of version 0.3.1 of the RISC-V SBI
> > specification. It doesn't have any significant changes other than typos.
> > A new release is created to adapt the ratification process for non-ISA
> > specifications defined by RVI recently."
> >
> > Has this patch to wait until release 0.3.1 of the SBI specification is
> > ratified?
>=20
> Not ratified, Frozen (officially as per newly defined RVI process)
>=20
> > What is the timeline?
> >

According to this mail, the "SBI specification is considered as frozen
now as per the RISC-V International policies":
http://lists.infradead.org/pipermail/opensbi/2022-January/002357.html

Therefore can we get this patch queued for 5.17-rc1?

Thanks,
Aurelien

--=20
Aurelien Jarno                          GPG: 4096R/1DDD8C9B
aurelien@aurel32.net                 http://www.aurel32.net
