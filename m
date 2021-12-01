Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E488464EC2
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 14:28:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243378AbhLANbs convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 1 Dec 2021 08:31:48 -0500
Received: from gloria.sntech.de ([185.11.138.130]:55118 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232967AbhLANbk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 08:31:40 -0500
Received: from ip4d17a2ab.dynamic.kabel-deutschland.de ([77.23.162.171] helo=diego.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1msPeY-0002eu-RQ; Wed, 01 Dec 2021 14:28:06 +0100
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     Jessica Clarke <jrtc27@jrtc27.com>,
        Atish Patra <atishp@atishpatra.org>
Cc:     Philipp Tomsich <philipp.tomsich@vrull.eu>,
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
        Christoph =?ISO-8859-1?Q?M=FCllner?= 
        <christoph.muellner@vrull.eu>, Christoph Hellwig <hch@lst.de>,
        liush <liush@allwinnertech.com>, Wei Wu <lazyparser@gmail.com>,
        Drew Fustini <drew@beagleboard.org>,
        Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: Re: [PATCH V4 1/2] dt-bindings: riscv: add MMU Standard Extensions support for Svpbmt
Date:   Wed, 01 Dec 2021 14:28:05 +0100
Message-ID: <3495709.4EXlkQ93OV@diego>
In-Reply-To: <CAOnJCUKmP6dsrV9xWC52uEaM0=fZh-FNDYyFg1VxQybpQZABMA@mail.gmail.com>
References: <20211129014007.286478-1-wefu@redhat.com> <03B8F784-4AF3-425D-99B6-F753F7970273@jrtc27.com> <CAOnJCUKmP6dsrV9xWC52uEaM0=fZh-FNDYyFg1VxQybpQZABMA@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Atish,

Am Mittwoch, 1. Dezember 2021, 02:21:46 CET schrieb Atish Patra:
> On Tue, Nov 30, 2021 at 8:13 AM Jessica Clarke <jrtc27@jrtc27.com> wrote:
> >
> > On 30 Nov 2021, at 15:01, Philipp Tomsich <philipp.tomsich@vrull.eu> wrote:
> > >
> > > We did touch on this in our coordination call a few weeks ago: the
> > > grouping under mmu and the bool-entries were chosen because of their
> > > similarity to other extensions (i.e. for Zb[abcs] there could/should
> > > be a bool-entry under each cpu-node — for some Zv* entries a subnode
> > > might be needed with further parameters).
> > >
> > > The string-based approach (as in the originally proposed "mmu-type=")
> > > would like not scale with the proliferation of small & modular
> > > extensions.
> >
> > I don’t see why the Sv* extensions need to be under an mmu node then,
> > unless the intent is that every extension be grouped under a sub-node
> > (which doesn’t seem viable due to extensions like Zbk*, unless you
> > group by Ss, Sv and Z)?
> >
> 
> It shouldn't be. All the ISA extensions (i.e. standard, supervisor & hypervisor)
> with prefix S,Z,H should be kept separate in a separate node for easy
> parsing.
> 
> "riscv,isa" dt property will not scale at all. Just look at the few
> extensions that were ratified this year
> and Linux kernel needs to support them.
> 
> "Sscofpmf", "Svpbmt", "Zicbom"
> 
> > Also, what is going to happen to the current riscv,isa? Will that
> > continue to exist and duplicate the info, or will kernels be required
> > to reconstruct the string themselves if they want to display it to
> > users?
> >
> 
> This is my personal preference:
> riscv,isa will continue to base Standard ISA extensions that have
> single letter extensions.
> 
> This new DT node will encode all the non-single letter extensions.
> I am not sure if it should include some provisions for custom
> extensions starting with X because
> that will be platform specific.
> 
> Again, this is just my personal preference. I will try to send a patch
> soon so that we can initiate a broader
> discussion of the scheme and agree/disagree on something.

that would be really helpful, as it currently looks like we have a number
of different points-of-view so discussing an actual implementation will
probably make things a lot easier compared to dancing around theoretic
cases :-) .

Out of curiosity, how soon is "soon" ? :-D


Heiko


> > As a FreeBSD developer I’m obviously not a part of many of these
> > discussions, but what the Linux community imposes as the device tree
> > bindings has a real impact on us.
> >
> > Jess
> >
> > > On Tue, 30 Nov 2021 at 14:59, Jessica Clarke <jrtc27@jrtc27.com> wrote:
> > >>
> > >> On 30 Nov 2021, at 13:27, Heiko Stübner <heiko@sntech.de> wrote:
> > >>>
> > >>> Hi,
> > >>>
> > >>> Am Dienstag, 30. November 2021, 14:17:41 CET schrieb Jessica Clarke:
> > >>>> On 30 Nov 2021, at 12:07, Heiko Stübner <heiko@sntech.de> wrote:
> > >>>>>
> > >>>>> Am Montag, 29. November 2021, 13:06:23 CET schrieb Heiko Stübner:
> > >>>>>> Am Montag, 29. November 2021, 09:54:39 CET schrieb Heinrich Schuchardt:
> > >>>>>>> On 11/29/21 02:40, wefu@redhat.com wrote:
> > >>>>>>>> From: Wei Fu <wefu@redhat.com>
> > >>>>>>>>
> > >>>>>>>> Previous patch has added svpbmt in arch/riscv and add "riscv,svpmbt"
> > >>>>>>>> in the DT mmu node. Update dt-bindings related property here.
> > >>>>>>>>
> > >>>>>>>> Signed-off-by: Wei Fu <wefu@redhat.com>
> > >>>>>>>> Co-developed-by: Guo Ren <guoren@kernel.org>
> > >>>>>>>> Signed-off-by: Guo Ren <guoren@kernel.org>
> > >>>>>>>> Cc: Anup Patel <anup@brainfault.org>
> > >>>>>>>> Cc: Palmer Dabbelt <palmer@dabbelt.com>
> > >>>>>>>> Cc: Rob Herring <robh+dt@kernel.org>
> > >>>>>>>> ---
> > >>>>>>>> Documentation/devicetree/bindings/riscv/cpus.yaml | 10 ++++++++++
> > >>>>>>>> 1 file changed, 10 insertions(+)
> > >>>>>>>>
> > >>>>>>>> diff --git a/Documentation/devicetree/bindings/riscv/cpus.yaml b/Documentation/devicetree/bindings/riscv/cpus.yaml
> > >>>>>>>> index aa5fb64d57eb..9ff9cbdd8a85 100644
> > >>>>>>>> --- a/Documentation/devicetree/bindings/riscv/cpus.yaml
> > >>>>>>>> +++ b/Documentation/devicetree/bindings/riscv/cpus.yaml
> > >>>>>>>> @@ -63,6 +63,16 @@ properties:
> > >>>>>>>>      - riscv,sv48
> > >>>>>>>>      - riscv,none
> > >>>>>>>>
> > >>>>>>>> +  mmu:
> > >>>>>>>
> > >>>>>>> Shouldn't we keep the items be in alphabetic order, i.e. mmu before
> > >>>>>>> mmu-type?
> > >>>>>>>
> > >>>>>>>> +    description:
> > >>>>>>>> +      Describes the CPU's MMU Standard Extensions support.
> > >>>>>>>> +      These values originate from the RISC-V Privileged
> > >>>>>>>> +      Specification document, available from
> > >>>>>>>> +      https://riscv.org/specifications/
> > >>>>>>>> +    $ref: '/schemas/types.yaml#/definitions/string'
> > >>>>>>>> +    enum:
> > >>>>>>>> +      - riscv,svpmbt
> > >>>>>>>
> > >>>>>>> The privileged specification has multiple MMU related extensions:
> > >>>>>>> Svnapot, Svpbmt, Svinval. Shall they all be modeled in this enum?
> > >>>>>>
> > >>>>>> I remember in some earlier version some way back there was the
> > >>>>>> suggestion of using a sub-node instead and then adding boolean
> > >>>>>> properties for the supported extensions.
> > >>>>>>
> > >>>>>> Aka something like
> > >>>>>>   mmu {
> > >>>>>>           riscv,svpbmt;
> > >>>>>>   };
> > >>>>>
> > >>>>> For the record, I'm talking about the mail from september
> > >>>>> https://lore.kernel.org/linux-riscv/CAAeLtUChjjzG+P8yg45GLZMJy5UR2K5RRBoLFVZhtOaZ5pPtEA@mail.gmail.com/
> > >>>>>
> > >>>>> So having a sub-node would make adding future extensions
> > >>>>> way nicer.
> > >>>>
> > >>>> Svpbmt is just an ISA extension, and should be treated like any other.
> > >>>> Let’s not invent two different ways of representing that in the device
> > >>>> tree.
> > >>>
> > >>> Heinrich asked how the other extensions should be handled
> > >>> (Svnapot, Svpbmt, Svinval), so what do you suggest to do with these?
> > >>
> > >> Whatever is done for Zb[abcs], Zk*, Zv*, Zicbo*, etc. There may not be
> > >> a concrete plan for that yet, but that means you should speak with the
> > >> people involved with such extensions and come up with something
> > >> appropriate together.
> > >>
> > >> Jess
> > >>
> >
> >
> > _______________________________________________
> > linux-riscv mailing list
> > linux-riscv@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-riscv
> 
> 
> 
> --
> Regards,
> Atish
> 




