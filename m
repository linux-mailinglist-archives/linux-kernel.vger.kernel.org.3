Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14657465BDE
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 02:55:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348672AbhLBB67 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 20:58:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344435AbhLBB66 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 20:58:58 -0500
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6434AC061574
        for <linux-kernel@vger.kernel.org>; Wed,  1 Dec 2021 17:55:36 -0800 (PST)
Received: by mail-yb1-xb2c.google.com with SMTP id f186so68867885ybg.2
        for <linux-kernel@vger.kernel.org>; Wed, 01 Dec 2021 17:55:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atishpatra.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=1UuAy6uLsALXqAftePCQXXu8MwdI8WGC84X6lAuf/hU=;
        b=ZuqO4MZUbzc3aQAWTOB0Oq5fH29ryr1cX6pvChE9mbPYuFjte8KgH6+qTn9IkCMMHx
         vdrRNDd2dCSYVyoKS8JtKX4vIHtngw1RysYXN77EgwCykOXeD8w60AlflQeFuknoimRZ
         fGTV5RoGnFutwO5Z8XF88MfXJ1IbI4Y+CZfwI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=1UuAy6uLsALXqAftePCQXXu8MwdI8WGC84X6lAuf/hU=;
        b=EnMb3XvpmVuJVbaMdcXVC++RV2xJApQKEjMmmqKYgR0X/BvCbH69Y4SMhQcfL516Cf
         wlsOg1EW9GYOgnPhOSivkxOD0rrm1yR8c+1VlYsUhVAN9wvB5DBG/2sBqQ8q54nfyOCs
         atPV1WMfjLrcRhAYLegtOCiE44xTUuHTyiGEO4aKCuTr9QbSnphMFMAyIfwXRUsYCoAV
         hkIemVZT0e91HeKMs0F+WomaLTqxhPS3gFLHnOnD5j5d77uGRyBmSVD6xqpNYSLhJ6Y4
         YA42hqG2dI5J3geFV6VfWRGVBqJVetLWFQMRoRAYvzxdqwJN8uS+a0k1aonpkO3ePe8P
         NL9Q==
X-Gm-Message-State: AOAM530vnXkdJECyXS4D1apQF75SvUgEirqkH91YtnPWEUsRm+T8Vh9r
        GH6Ur5kXI5ZGlnIzE/Xw8HKJsYFyKKrxi14UEDgV
X-Google-Smtp-Source: ABdhPJxGJE/Y00tb5nxsxIPBK7KdVuGZDp7xlDI2Lh4blN993b7LM/xccIclunSWU+CfkX0oXXkbrWHl4b9s/Jm6FvA=
X-Received: by 2002:a25:bbc4:: with SMTP id c4mr11408930ybk.309.1638410135497;
 Wed, 01 Dec 2021 17:55:35 -0800 (PST)
MIME-Version: 1.0
References: <20211129014007.286478-1-wefu@redhat.com> <1909580.k68io2XIxi@diego>
 <D7F256F9-F31F-4663-AADD-A535E159F87C@jrtc27.com> <2728314.U2HhIfhhqV@diego>
 <C19C85E6-821B-4A87-B764-56CF4D53E7FA@jrtc27.com> <CAAeLtUC0Qc6ysf31sh0dkvfJD-JsREZbyFFk=Ko0vQeBRzyjaw@mail.gmail.com>
 <03B8F784-4AF3-425D-99B6-F753F7970273@jrtc27.com> <CAOnJCUKmP6dsrV9xWC52uEaM0=fZh-FNDYyFg1VxQybpQZABMA@mail.gmail.com>
 <1d035613-390c-32c2-aa92-cc0f7797488d@irq.a4lg.com> <CAOnJCULQNz2WtrzAe7--66pMt+0oR9Z2aEwGXffbCi=Y9f=3yQ@mail.gmail.com>
 <9fa0492d-b448-045b-ba8f-e3d68b46d673@irq.a4lg.com>
In-Reply-To: <9fa0492d-b448-045b-ba8f-e3d68b46d673@irq.a4lg.com>
From:   Atish Patra <atishp@atishpatra.org>
Date:   Wed, 1 Dec 2021 17:55:24 -0800
Message-ID: <CAOnJCULUDMYq050gJTe16oB4t2=nCUK7w0PxF_qGTp6NSv-cgg@mail.gmail.com>
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

On Wed, Dec 1, 2021 at 5:31 PM Tsukasa OI <research_trasio@irq.a4lg.com> wr=
ote:
>
> On 2021/12/01 17:15, Atish Patra wrote:
> > On Tue, Nov 30, 2021 at 7:06 PM Tsukasa OI <research_trasio@irq.a4lg.co=
m> wrote:
> >>
> >> On 2021/12/01 10:21, Atish Patra wrote:
> >>> On Tue, Nov 30, 2021 at 8:13 AM Jessica Clarke <jrtc27@jrtc27.com> wr=
ote:
> >>>>
> >>>> On 30 Nov 2021, at 15:01, Philipp Tomsich <philipp.tomsich@vrull.eu>=
 wrote:
> >>>>>
> >>>>> We did touch on this in our coordination call a few weeks ago: the
> >>>>> grouping under mmu and the bool-entries were chosen because of thei=
r
> >>>>> similarity to other extensions (i.e. for Zb[abcs] there could/shoul=
d
> >>>>> be a bool-entry under each cpu-node =E2=80=94 for some Zv* entries =
a subnode
> >>>>> might be needed with further parameters).
> >>>>>
> >>>>> The string-based approach (as in the originally proposed "mmu-type=
=3D")
> >>>>> would like not scale with the proliferation of small & modular
> >>>>> extensions.
> >>>>
> >>>> I don=E2=80=99t see why the Sv* extensions need to be under an mmu n=
ode then,
> >>>> unless the intent is that every extension be grouped under a sub-nod=
e
> >>>> (which doesn=E2=80=99t seem viable due to extensions like Zbk*, unle=
ss you
> >>>> group by Ss, Sv and Z)?
> >>>>
> >>>
> >>> It shouldn't be. All the ISA extensions (i.e. standard, supervisor & =
hypervisor)
> >>> with prefix S,Z,H should be kept separate in a separate node for easy
> >>> parsing.
> >>
> >> "Easy parsing" is not quite convincing.
> >
> > The device tree need to carry a very long "riscv,isa" string. The
> > parser need to parse
> > that string in memory as well.
> >
> >>
> >> There's a reason other than that I made RFC PATCH to parse
> >> multi-letter extensions:
> >>
> >> v1: <http://lists.infradead.org/pipermail/linux-riscv/2021-November/01=
0252.html>
> >> v2: <http://lists.infradead.org/pipermail/linux-riscv/2021-November/01=
0350.html>
> >>
> >
> > It's on my todo list to review the series. I think we can work
> > together to propose a better framework for riscv isa extensions.
>
> Thanks.  I will submit RFC PATCH v3 today so that we can start a healthy
> discussion.  I apologize that I missed so many points and there's a lot
> things to learn.
>
> As far as I know, if we make new DT nodes for separate extensions, we hav=
e
> to (at least) synchronize the implementation with Spike.  This simulator
> accepts ISA string through `--isa' option and (by default) puts entire IS=
A
> string into the device tree as "riscv,isa" (after expansion
> "G" -> "IMAFD").
>
> Of course, it includes "Svpbmt", in which we are discussing.
>
>     spike --isa=3Drv64g_zba_zbb_zbc_zbs_svinval_svnapot_svpbmt ...
>
> I am just wondering whether breaking this behavior would worth it.
>
> IMHO, we could create new DT nodes **and** in addition, we can possibly
> use "riscv,isa" as a fallback.

I don't think that would be necessary. We can just fix the spike implementa=
tion
if a separate DT node approach is accepted upstream.

The device tree formation is Linux specific. Given that we will have a
well defined DT binding
for the new DT node, it is enough to change the spike.

> I'm not sure that this would work (just changing Spike might be better)
> but I ...think... it's worth discussing it.
>
> >
> >> (note: those patches will break RISC-V KVM because of possible ISA
> >>        Manual inconsistency and discussion/resolution needed)
> >>
> >> (...continued below...)
> >>
> >>>
> >>> "riscv,isa" dt property will not scale at all. Just look at the few
> >>> extensions that were ratified this year
> >>> and Linux kernel needs to support them.
> >>>
> >>> "Sscofpmf", "Svpbmt", "Zicbom"
> >>>
> >>>> Also, what is going to happen to the current riscv,isa? Will that
> >>>> continue to exist and duplicate the info, or will kernels be require=
d
> >>>> to reconstruct the string themselves if they want to display it to
> >>>> users?
> >>>>
> >
> > Sorry. I missed this question earlier. See my answer below.
> >
> >>>
> >>> This is my personal preference:
> >>> riscv,isa will continue to base Standard ISA extensions that have
> >>> single letter extensions.
> >>>
> >>> This new DT node will encode all the non-single letter extensions.
> >>> I am not sure if it should include some provisions for custom
> >>> extensions starting with X because
> >>> that will be platform specific.
> >>>
> >>> Again, this is just my personal preference. I will try to send a patc=
h
> >>> soon so that we can initiate a broader
> >>> discussion of the scheme and agree/disagree on something.
> >>
> >> For supervisor-only extensions like "Svpbmt", new DT node would be a
> >> reasonable solution (and I would not directly object about that node).
> >>
> >> However, there's many multi-letter extensions that are useful for
> >> user mode.  Because "riscv,isa" is exposed via sysfs and procfs
> >> (/proc/cpuinfo), it can be really helpful to have multi-letter
> >
> > Irrespective of the method chosen to parse the device tree in kernel,
> > we need to provide the extension information to the userspace.
> >
> > This is what I have in mind. An individual row with comma separated
> > extension names for each type of extensions (Ss, Sv, Sh)
> > after the base extension (rv64imafdc) in /proc/cpuinfo output. I am
> > open to other ideas as well.
> >
> > isa   rv64imafdc
> > isa-ext-Sv Svpbmt
> > isa-ext-Ss Sscofpmf
> > isa-ext-Sh <hypervisor related extensions>
> > isa-ext-Z   Zicbom
> >
> > We can even explicitly name the extensions after isa-ext. However, it
> > may be necessary and too long.
> >
> > I guess you prefer to directly print the entire "riscv,isa" string in
> > "isa" row in /proc/cpuinfo output.
> > It is probably okay with the current number of extensions available
> > today. However, it will become so long string
> > in the future that it has to be broken into multiple lines.
> >
> >> extensions.  Also, current version of Spike, a RISC-V ISA Simulator
> >> puts all multi-letter extensions in "riscv,isa" and I thought this is
> >> intended.
> >>
> >> My preference:
> >> (1) Allow having multi-letter extensions and versions in "riscv,isa"
> >> (2) Adding new DT node for supervisor-related extensions would be
> >>     reasonable (but I don't strongly agree/disagree).
> >>
> >> Thanks,
> >> Tsukasa
> >>
> >>>
> >>>
> >>>
> >>>> As a FreeBSD developer I=E2=80=99m obviously not a part of many of t=
hese
> >>>> discussions, but what the Linux community imposes as the device tree
> >>>> bindings has a real impact on us.
> >>>>
> >>>> Jess
> >>>>
> >>>>> On Tue, 30 Nov 2021 at 14:59, Jessica Clarke <jrtc27@jrtc27.com> wr=
ote:
> >>>>>>
> >>>>>> On 30 Nov 2021, at 13:27, Heiko St=C3=BCbner <heiko@sntech.de> wro=
te:
> >>>>>>>
> >>>>>>> Hi,
> >>>>>>>
> >>>>>>> Am Dienstag, 30. November 2021, 14:17:41 CET schrieb Jessica Clar=
ke:
> >>>>>>>> On 30 Nov 2021, at 12:07, Heiko St=C3=BCbner <heiko@sntech.de> w=
rote:
> >>>>>>>>>
> >>>>>>>>> Am Montag, 29. November 2021, 13:06:23 CET schrieb Heiko St=C3=
=BCbner:
> >>>>>>>>>> Am Montag, 29. November 2021, 09:54:39 CET schrieb Heinrich Sc=
huchardt:
> >>>>>>>>>>> On 11/29/21 02:40, wefu@redhat.com wrote:
> >>>>>>>>>>>> From: Wei Fu <wefu@redhat.com>
> >>>>>>>>>>>>
> >>>>>>>>>>>> Previous patch has added svpbmt in arch/riscv and add "riscv=
,svpmbt"
> >>>>>>>>>>>> in the DT mmu node. Update dt-bindings related property here=
.
> >>>>>>>>>>>>
> >>>>>>>>>>>> Signed-off-by: Wei Fu <wefu@redhat.com>
> >>>>>>>>>>>> Co-developed-by: Guo Ren <guoren@kernel.org>
> >>>>>>>>>>>> Signed-off-by: Guo Ren <guoren@kernel.org>
> >>>>>>>>>>>> Cc: Anup Patel <anup@brainfault.org>
> >>>>>>>>>>>> Cc: Palmer Dabbelt <palmer@dabbelt.com>
> >>>>>>>>>>>> Cc: Rob Herring <robh+dt@kernel.org>
> >>>>>>>>>>>> ---
> >>>>>>>>>>>> Documentation/devicetree/bindings/riscv/cpus.yaml | 10 +++++=
+++++
> >>>>>>>>>>>> 1 file changed, 10 insertions(+)
> >>>>>>>>>>>>
> >>>>>>>>>>>> diff --git a/Documentation/devicetree/bindings/riscv/cpus.ya=
ml b/Documentation/devicetree/bindings/riscv/cpus.yaml
> >>>>>>>>>>>> index aa5fb64d57eb..9ff9cbdd8a85 100644
> >>>>>>>>>>>> --- a/Documentation/devicetree/bindings/riscv/cpus.yaml
> >>>>>>>>>>>> +++ b/Documentation/devicetree/bindings/riscv/cpus.yaml
> >>>>>>>>>>>> @@ -63,6 +63,16 @@ properties:
> >>>>>>>>>>>>      - riscv,sv48
> >>>>>>>>>>>>      - riscv,none
> >>>>>>>>>>>>
> >>>>>>>>>>>> +  mmu:
> >>>>>>>>>>>
> >>>>>>>>>>> Shouldn't we keep the items be in alphabetic order, i.e. mmu =
before
> >>>>>>>>>>> mmu-type?
> >>>>>>>>>>>
> >>>>>>>>>>>> +    description:
> >>>>>>>>>>>> +      Describes the CPU's MMU Standard Extensions support.
> >>>>>>>>>>>> +      These values originate from the RISC-V Privileged
> >>>>>>>>>>>> +      Specification document, available from
> >>>>>>>>>>>> +      https://riscv.org/specifications/
> >>>>>>>>>>>> +    $ref: '/schemas/types.yaml#/definitions/string'
> >>>>>>>>>>>> +    enum:
> >>>>>>>>>>>> +      - riscv,svpmbt
> >>>>>>>>>>>
> >>>>>>>>>>> The privileged specification has multiple MMU related extensi=
ons:
> >>>>>>>>>>> Svnapot, Svpbmt, Svinval. Shall they all be modeled in this e=
num?
> >>>>>>>>>>
> >>>>>>>>>> I remember in some earlier version some way back there was the
> >>>>>>>>>> suggestion of using a sub-node instead and then adding boolean
> >>>>>>>>>> properties for the supported extensions.
> >>>>>>>>>>
> >>>>>>>>>> Aka something like
> >>>>>>>>>>   mmu {
> >>>>>>>>>>           riscv,svpbmt;
> >>>>>>>>>>   };
> >>>>>>>>>
> >>>>>>>>> For the record, I'm talking about the mail from september
> >>>>>>>>> https://lore.kernel.org/linux-riscv/CAAeLtUChjjzG+P8yg45GLZMJy5=
UR2K5RRBoLFVZhtOaZ5pPtEA@mail.gmail.com/
> >>>>>>>>>
> >>>>>>>>> So having a sub-node would make adding future extensions
> >>>>>>>>> way nicer.
> >>>>>>>>
> >>>>>>>> Svpbmt is just an ISA extension, and should be treated like any =
other.
> >>>>>>>> Let=E2=80=99s not invent two different ways of representing that=
 in the device
> >>>>>>>> tree.
> >>>>>>>
> >>>>>>> Heinrich asked how the other extensions should be handled
> >>>>>>> (Svnapot, Svpbmt, Svinval), so what do you suggest to do with the=
se?
> >>>>>>
> >>>>>> Whatever is done for Zb[abcs], Zk*, Zv*, Zicbo*, etc. There may no=
t be
> >>>>>> a concrete plan for that yet, but that means you should speak with=
 the
> >>>>>> people involved with such extensions and come up with something
> >>>>>> appropriate together.
> >>>>>>
> >>>>>> Jess
> >>>>>>
> >>>>
> >>>>
> >>>> _______________________________________________
> >>>> linux-riscv mailing list
> >>>> linux-riscv@lists.infradead.org
> >>>> http://lists.infradead.org/mailman/listinfo/linux-riscv
> >>>
> >>>
> >>>
> >>> --
> >>> Regards,
> >>> Atish
> >>>
> >>> _______________________________________________
> >>> linux-riscv mailing list
> >>> linux-riscv@lists.infradead.org
> >>> http://lists.infradead.org/mailman/listinfo/linux-riscv
> >>>
> >
> >
> >



--=20
Regards,
Atish
