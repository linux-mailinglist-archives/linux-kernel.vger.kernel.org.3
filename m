Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D2DE464962
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 09:15:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347882AbhLAISw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 03:18:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235464AbhLAISu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 03:18:50 -0500
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 891D3C061574
        for <linux-kernel@vger.kernel.org>; Wed,  1 Dec 2021 00:15:30 -0800 (PST)
Received: by mail-yb1-xb30.google.com with SMTP id 131so60941260ybc.7
        for <linux-kernel@vger.kernel.org>; Wed, 01 Dec 2021 00:15:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atishpatra.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=S57qk9mhuZ/g9C5aLfnY7NgUAbFruX4cbQRxWnSY0Qo=;
        b=XKaXoRWEyNhdWcptCHCbe1Spt26+vDVf1FRuDp6eCHOdfmu+9NfsdK19MZysgHysat
         FuoQsKIVoJu5/71JQz1zAbE3LZ171iidsMuZ143uv15CMWnSzmhQSEuKwtumvWAnPzGT
         EQCnziTHV4t1dWnhAfScQXbrXgydtQ595KkeA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=S57qk9mhuZ/g9C5aLfnY7NgUAbFruX4cbQRxWnSY0Qo=;
        b=qCPVdWaYvwmeFpVjSumOZSYgfVqhwTbRc9hdO7IQrBbPgUjLr1XgIqp7Ee4SH44lJC
         cO4d9A+/zVJuFTaqllSTXazgxndoDwbMDoXTrMncxQVkMaLJc2udhGnlVx6mhNy68jZd
         D5lUjtZ9h8Rt+6CXhXWCkDvNdi/t+9qbGNFY4WltFC3ACg9lbVdU3/TmHxvgSnblJiPX
         IpGbAHYpcu+bVWd39U1ySNIm/SYortLFmNTMRiMZaVCVYDHkoqfIscrCB0EFdKBdMsZ/
         kPVvkseY5S5p0SC7Z6KTSK1M2NtvM18wOb3GrLIGvGUG03bBUwjOewNQU4q35/D6WJnD
         rrDQ==
X-Gm-Message-State: AOAM530/jljAcl745Td6nKDlgf1KENQ/K0q9ne0wz5JMIF/YxINgp7ci
        n/4sWTM6sHgSCpGxoT4foC9nPiPJIGJaJRzhnhZijY0oewjYe4s=
X-Google-Smtp-Source: ABdhPJz0cVhVudhWNrU98JYmr+mF04YoMJevZYn10+Y2LsG+oJ4QsaHVeibE2VrPporEVQwWPzEoFn1u2qQhqFG8Trw=
X-Received: by 2002:a25:4d8:: with SMTP id 207mr5311533ybe.320.1638346529662;
 Wed, 01 Dec 2021 00:15:29 -0800 (PST)
MIME-Version: 1.0
References: <20211129014007.286478-1-wefu@redhat.com> <1909580.k68io2XIxi@diego>
 <D7F256F9-F31F-4663-AADD-A535E159F87C@jrtc27.com> <2728314.U2HhIfhhqV@diego>
 <C19C85E6-821B-4A87-B764-56CF4D53E7FA@jrtc27.com> <CAAeLtUC0Qc6ysf31sh0dkvfJD-JsREZbyFFk=Ko0vQeBRzyjaw@mail.gmail.com>
 <03B8F784-4AF3-425D-99B6-F753F7970273@jrtc27.com> <CAOnJCUKmP6dsrV9xWC52uEaM0=fZh-FNDYyFg1VxQybpQZABMA@mail.gmail.com>
 <1d035613-390c-32c2-aa92-cc0f7797488d@irq.a4lg.com>
In-Reply-To: <1d035613-390c-32c2-aa92-cc0f7797488d@irq.a4lg.com>
From:   Atish Patra <atishp@atishpatra.org>
Date:   Wed, 1 Dec 2021 00:15:18 -0800
Message-ID: <CAOnJCULQNz2WtrzAe7--66pMt+0oR9Z2aEwGXffbCi=Y9f=3yQ@mail.gmail.com>
Subject: Re: [PATCH V4 1/2] dt-bindings: riscv: add MMU Standard Extensions
 support for Svpbmt
To:     Tsukasa OI <research_trasio@irq.a4lg.com>
Cc:     Jessica Clarke <jrtc27@jrtc27.com>,
        Philipp Tomsich <philipp.tomsich@vrull.eu>,
        =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Wei Fu <wefu@redhat.com>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        taiten.peng@canonical.com,
        Aniket Ponkshe <aniket.ponkshe@canonical.com>,
        Gordan Markus <gordan.markus@canonical.com>,
        Guo Ren <guoren@linux.alibaba.com>,
        Arnd Bergmann <arnd@arndb.de>, Chen-Yu Tsai <wens@csie.org>,
        Maxime Ripard <maxime@cerno.tech>,
        Dan Lustig <dlustig@nvidia.com>,
        Greg Favor <gfavor@ventanamicro.com>,
        Andrea Mondelli <andrea.mondelli@huawei.com>,
        Jonathan Behrens <behrensj@mit.edu>,
        Xinhaoqu <xinhaoqu@huawei.com>,
        Bill Huffman <huffman@cadence.com>,
        Nick Kossifidis <mick@ics.forth.gr>,
        Allen Baum <allen.baum@esperantotech.com>,
        Josh Scheid <jscheid@ventanamicro.com>,
        Richard Trauben <rtrauben@gmail.com>,
        Anup Patel <anup@brainfault.org>,
        Rob Herring <robh+dt@kernel.org>,
        Anup Patel <Anup.Patel@wdc.com>, atishp04@gmail.com,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Guo Ren <guoren@kernel.org>,
        =?UTF-8?Q?Christoph_M=C3=BCllner?= <christoph.muellner@vrull.eu>,
        Christoph Hellwig <hch@lst.de>,
        liush <liush@allwinnertech.com>, Wei Wu <lazyparser@gmail.com>,
        Drew Fustini <drew@beagleboard.org>,
        Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 30, 2021 at 7:06 PM Tsukasa OI <research_trasio@irq.a4lg.com> w=
rote:
>
> On 2021/12/01 10:21, Atish Patra wrote:
> > On Tue, Nov 30, 2021 at 8:13 AM Jessica Clarke <jrtc27@jrtc27.com> wrot=
e:
> >>
> >> On 30 Nov 2021, at 15:01, Philipp Tomsich <philipp.tomsich@vrull.eu> w=
rote:
> >>>
> >>> We did touch on this in our coordination call a few weeks ago: the
> >>> grouping under mmu and the bool-entries were chosen because of their
> >>> similarity to other extensions (i.e. for Zb[abcs] there could/should
> >>> be a bool-entry under each cpu-node =E2=80=94 for some Zv* entries a =
subnode
> >>> might be needed with further parameters).
> >>>
> >>> The string-based approach (as in the originally proposed "mmu-type=3D=
")
> >>> would like not scale with the proliferation of small & modular
> >>> extensions.
> >>
> >> I don=E2=80=99t see why the Sv* extensions need to be under an mmu nod=
e then,
> >> unless the intent is that every extension be grouped under a sub-node
> >> (which doesn=E2=80=99t seem viable due to extensions like Zbk*, unless=
 you
> >> group by Ss, Sv and Z)?
> >>
> >
> > It shouldn't be. All the ISA extensions (i.e. standard, supervisor & hy=
pervisor)
> > with prefix S,Z,H should be kept separate in a separate node for easy
> > parsing.
>
> "Easy parsing" is not quite convincing.

The device tree need to carry a very long "riscv,isa" string. The
parser need to parse
that string in memory as well.

>
> There's a reason other than that I made RFC PATCH to parse
> multi-letter extensions:
>
> v1: <http://lists.infradead.org/pipermail/linux-riscv/2021-November/01025=
2.html>
> v2: <http://lists.infradead.org/pipermail/linux-riscv/2021-November/01035=
0.html>
>

It's on my todo list to review the series. I think we can work
together to propose a better framework for riscv isa extensions.

> (note: those patches will break RISC-V KVM because of possible ISA
>        Manual inconsistency and discussion/resolution needed)
>
> (...continued below...)
>
> >
> > "riscv,isa" dt property will not scale at all. Just look at the few
> > extensions that were ratified this year
> > and Linux kernel needs to support them.
> >
> > "Sscofpmf", "Svpbmt", "Zicbom"
> >
> >> Also, what is going to happen to the current riscv,isa? Will that
> >> continue to exist and duplicate the info, or will kernels be required
> >> to reconstruct the string themselves if they want to display it to
> >> users?
> >>

Sorry. I missed this question earlier. See my answer below.

> >
> > This is my personal preference:
> > riscv,isa will continue to base Standard ISA extensions that have
> > single letter extensions.
> >
> > This new DT node will encode all the non-single letter extensions.
> > I am not sure if it should include some provisions for custom
> > extensions starting with X because
> > that will be platform specific.
> >
> > Again, this is just my personal preference. I will try to send a patch
> > soon so that we can initiate a broader
> > discussion of the scheme and agree/disagree on something.
>
> For supervisor-only extensions like "Svpbmt", new DT node would be a
> reasonable solution (and I would not directly object about that node).
>
> However, there's many multi-letter extensions that are useful for
> user mode.  Because "riscv,isa" is exposed via sysfs and procfs
> (/proc/cpuinfo), it can be really helpful to have multi-letter

Irrespective of the method chosen to parse the device tree in kernel,
we need to provide the extension information to the userspace.

This is what I have in mind. An individual row with comma separated
extension names for each type of extensions (Ss, Sv, Sh)
after the base extension (rv64imafdc) in /proc/cpuinfo output. I am
open to other ideas as well.

isa   rv64imafdc
isa-ext-Sv Svpbmt
isa-ext-Ss Sscofpmf
isa-ext-Sh <hypervisor related extensions>
isa-ext-Z   Zicbom

We can even explicitly name the extensions after isa-ext. However, it
may be necessary and too long.

I guess you prefer to directly print the entire "riscv,isa" string in
"isa" row in /proc/cpuinfo output.
It is probably okay with the current number of extensions available
today. However, it will become so long string
in the future that it has to be broken into multiple lines.

> extensions.  Also, current version of Spike, a RISC-V ISA Simulator
> puts all multi-letter extensions in "riscv,isa" and I thought this is
> intended.
>
> My preference:
> (1) Allow having multi-letter extensions and versions in "riscv,isa"
> (2) Adding new DT node for supervisor-related extensions would be
>     reasonable (but I don't strongly agree/disagree).
>
> Thanks,
> Tsukasa
>
> >
> >
> >
> >> As a FreeBSD developer I=E2=80=99m obviously not a part of many of the=
se
> >> discussions, but what the Linux community imposes as the device tree
> >> bindings has a real impact on us.
> >>
> >> Jess
> >>
> >>> On Tue, 30 Nov 2021 at 14:59, Jessica Clarke <jrtc27@jrtc27.com> wrot=
e:
> >>>>
> >>>> On 30 Nov 2021, at 13:27, Heiko St=C3=BCbner <heiko@sntech.de> wrote=
:
> >>>>>
> >>>>> Hi,
> >>>>>
> >>>>> Am Dienstag, 30. November 2021, 14:17:41 CET schrieb Jessica Clarke=
:
> >>>>>> On 30 Nov 2021, at 12:07, Heiko St=C3=BCbner <heiko@sntech.de> wro=
te:
> >>>>>>>
> >>>>>>> Am Montag, 29. November 2021, 13:06:23 CET schrieb Heiko St=C3=BC=
bner:
> >>>>>>>> Am Montag, 29. November 2021, 09:54:39 CET schrieb Heinrich Schu=
chardt:
> >>>>>>>>> On 11/29/21 02:40, wefu@redhat.com wrote:
> >>>>>>>>>> From: Wei Fu <wefu@redhat.com>
> >>>>>>>>>>
> >>>>>>>>>> Previous patch has added svpbmt in arch/riscv and add "riscv,s=
vpmbt"
> >>>>>>>>>> in the DT mmu node. Update dt-bindings related property here.
> >>>>>>>>>>
> >>>>>>>>>> Signed-off-by: Wei Fu <wefu@redhat.com>
> >>>>>>>>>> Co-developed-by: Guo Ren <guoren@kernel.org>
> >>>>>>>>>> Signed-off-by: Guo Ren <guoren@kernel.org>
> >>>>>>>>>> Cc: Anup Patel <anup@brainfault.org>
> >>>>>>>>>> Cc: Palmer Dabbelt <palmer@dabbelt.com>
> >>>>>>>>>> Cc: Rob Herring <robh+dt@kernel.org>
> >>>>>>>>>> ---
> >>>>>>>>>> Documentation/devicetree/bindings/riscv/cpus.yaml | 10 +++++++=
+++
> >>>>>>>>>> 1 file changed, 10 insertions(+)
> >>>>>>>>>>
> >>>>>>>>>> diff --git a/Documentation/devicetree/bindings/riscv/cpus.yaml=
 b/Documentation/devicetree/bindings/riscv/cpus.yaml
> >>>>>>>>>> index aa5fb64d57eb..9ff9cbdd8a85 100644
> >>>>>>>>>> --- a/Documentation/devicetree/bindings/riscv/cpus.yaml
> >>>>>>>>>> +++ b/Documentation/devicetree/bindings/riscv/cpus.yaml
> >>>>>>>>>> @@ -63,6 +63,16 @@ properties:
> >>>>>>>>>>      - riscv,sv48
> >>>>>>>>>>      - riscv,none
> >>>>>>>>>>
> >>>>>>>>>> +  mmu:
> >>>>>>>>>
> >>>>>>>>> Shouldn't we keep the items be in alphabetic order, i.e. mmu be=
fore
> >>>>>>>>> mmu-type?
> >>>>>>>>>
> >>>>>>>>>> +    description:
> >>>>>>>>>> +      Describes the CPU's MMU Standard Extensions support.
> >>>>>>>>>> +      These values originate from the RISC-V Privileged
> >>>>>>>>>> +      Specification document, available from
> >>>>>>>>>> +      https://riscv.org/specifications/
> >>>>>>>>>> +    $ref: '/schemas/types.yaml#/definitions/string'
> >>>>>>>>>> +    enum:
> >>>>>>>>>> +      - riscv,svpmbt
> >>>>>>>>>
> >>>>>>>>> The privileged specification has multiple MMU related extension=
s:
> >>>>>>>>> Svnapot, Svpbmt, Svinval. Shall they all be modeled in this enu=
m?
> >>>>>>>>
> >>>>>>>> I remember in some earlier version some way back there was the
> >>>>>>>> suggestion of using a sub-node instead and then adding boolean
> >>>>>>>> properties for the supported extensions.
> >>>>>>>>
> >>>>>>>> Aka something like
> >>>>>>>>   mmu {
> >>>>>>>>           riscv,svpbmt;
> >>>>>>>>   };
> >>>>>>>
> >>>>>>> For the record, I'm talking about the mail from september
> >>>>>>> https://lore.kernel.org/linux-riscv/CAAeLtUChjjzG+P8yg45GLZMJy5UR=
2K5RRBoLFVZhtOaZ5pPtEA@mail.gmail.com/
> >>>>>>>
> >>>>>>> So having a sub-node would make adding future extensions
> >>>>>>> way nicer.
> >>>>>>
> >>>>>> Svpbmt is just an ISA extension, and should be treated like any ot=
her.
> >>>>>> Let=E2=80=99s not invent two different ways of representing that i=
n the device
> >>>>>> tree.
> >>>>>
> >>>>> Heinrich asked how the other extensions should be handled
> >>>>> (Svnapot, Svpbmt, Svinval), so what do you suggest to do with these=
?
> >>>>
> >>>> Whatever is done for Zb[abcs], Zk*, Zv*, Zicbo*, etc. There may not =
be
> >>>> a concrete plan for that yet, but that means you should speak with t=
he
> >>>> people involved with such extensions and come up with something
> >>>> appropriate together.
> >>>>
> >>>> Jess
> >>>>
> >>
> >>
> >> _______________________________________________
> >> linux-riscv mailing list
> >> linux-riscv@lists.infradead.org
> >> http://lists.infradead.org/mailman/listinfo/linux-riscv
> >
> >
> >
> > --
> > Regards,
> > Atish
> >
> > _______________________________________________
> > linux-riscv mailing list
> > linux-riscv@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-riscv
> >



--=20
Regards,
Atish
