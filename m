Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93F514614B2
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 13:08:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239555AbhK2ML7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 07:11:59 -0500
Received: from gloria.sntech.de ([185.11.138.130]:38980 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231688AbhK2MJ6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 07:09:58 -0500
Received: from ip5f5b2004.dynamic.kabel-deutschland.de ([95.91.32.4] helo=diego.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1mrfQP-0006lK-70; Mon, 29 Nov 2021 13:06:25 +0100
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     wefu@redhat.com, linux-riscv@lists.infradead.org
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        taiten.peng@canonical.com, aniket.ponkshe@canonical.com,
        gordan.markus@canonical.com, guoren@linux.alibaba.com,
        arnd@arndb.de, wens@csie.org, maxime@cerno.tech,
        dlustig@nvidia.com, gfavor@ventanamicro.com,
        andrea.mondelli@huawei.com, behrensj@mit.edu, xinhaoqu@huawei.com,
        huffman@cadence.com, mick@ics.forth.gr,
        allen.baum@esperantotech.com, jscheid@ventanamicro.com,
        rtrauben@gmail.com, Anup Patel <anup@brainfault.org>,
        Rob Herring <robh+dt@kernel.org>, anup.patel@wdc.com,
        atishp04@gmail.com, palmer@dabbelt.com, guoren@kernel.org,
        christoph.muellner@vrull.eu, philipp.tomsich@vrull.eu, hch@lst.de,
        liush@allwinnertech.com, lazyparser@gmail.com,
        drew@beagleboard.org,
        Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: Re: [PATCH V4 1/2] dt-bindings: riscv: add MMU Standard Extensions support for Svpbmt
Date:   Mon, 29 Nov 2021 13:06:23 +0100
Message-ID: <9930802.MB9u6SvQ6m@diego>
In-Reply-To: <97431cab-d67d-4bc7-e181-d64534791f03@canonical.com>
References: <20211129014007.286478-1-wefu@redhat.com> <20211129014007.286478-2-wefu@redhat.com> <97431cab-d67d-4bc7-e181-d64534791f03@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Montag, 29. November 2021, 09:54:39 CET schrieb Heinrich Schuchardt:
> On 11/29/21 02:40, wefu@redhat.com wrote:
> > From: Wei Fu <wefu@redhat.com>
> > 
> > Previous patch has added svpbmt in arch/riscv and add "riscv,svpmbt"
> > in the DT mmu node. Update dt-bindings related property here.
> > 
> > Signed-off-by: Wei Fu <wefu@redhat.com>
> > Co-developed-by: Guo Ren <guoren@kernel.org>
> > Signed-off-by: Guo Ren <guoren@kernel.org>
> > Cc: Anup Patel <anup@brainfault.org>
> > Cc: Palmer Dabbelt <palmer@dabbelt.com>
> > Cc: Rob Herring <robh+dt@kernel.org>
> > ---
> >   Documentation/devicetree/bindings/riscv/cpus.yaml | 10 ++++++++++
> >   1 file changed, 10 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/riscv/cpus.yaml b/Documentation/devicetree/bindings/riscv/cpus.yaml
> > index aa5fb64d57eb..9ff9cbdd8a85 100644
> > --- a/Documentation/devicetree/bindings/riscv/cpus.yaml
> > +++ b/Documentation/devicetree/bindings/riscv/cpus.yaml
> > @@ -63,6 +63,16 @@ properties:
> >         - riscv,sv48
> >         - riscv,none
> >   
> > +  mmu:
> 
> Shouldn't we keep the items be in alphabetic order, i.e. mmu before 
> mmu-type?
> 
> > +    description:
> > +      Describes the CPU's MMU Standard Extensions support.
> > +      These values originate from the RISC-V Privileged
> > +      Specification document, available from
> > +      https://riscv.org/specifications/
> > +    $ref: '/schemas/types.yaml#/definitions/string'
> > +    enum:
> > +      - riscv,svpmbt
> 
> The privileged specification has multiple MMU related extensions: 
> Svnapot, Svpbmt, Svinval. Shall they all be modeled in this enum?

I remember in some earlier version some way back there was the
suggestion of using a sub-node instead and then adding boolean
properties for the supported extensions.

Aka something like
	mmu {
		riscv,svpbmt;	
	};

Which I guess would be a lot nicer. Also right now there is string-
comparison done on the code side, which would look way easier
when just looking for booleans in the dt instead.

Also isn't an enum a "one-of" selection, so wouldn't work directly
for multiple extensions?


Heiko


> 
> Best regards
> 
> Heinrich
> 
> > +
> >     riscv,isa:
> >       description:
> >         Identifies the specific RISC-V instruction set architecture
> > 
> 
> 
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv
> 




