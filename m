Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1A6752B604
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 11:29:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233717AbiERJDO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 05:03:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233682AbiERJDN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 05:03:13 -0400
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02E20131F0E;
        Wed, 18 May 2022 02:03:07 -0700 (PDT)
Received: from ip5b412258.dynamic.kabel-deutschland.de ([91.65.34.88] helo=diego.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1nrFa3-0007Q7-65; Wed, 18 May 2022 11:02:55 +0200
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     Rob Herring <robh@kernel.org>,
        Philipp Tomsich <philipp.tomsich@vrull.eu>
Cc:     palmer@dabbelt.com, paul.walmsley@sifive.com,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        wefu@redhat.com, guoren@kernel.org, atishp@atishpatra.org,
        anup@brainfault.org, mick@ics.forth.gr, samuel@sholland.org,
        cmuellner@linux.com, krzk+dt@kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 1/3] dt-bindings: riscv: document cbom-block-size
Date:   Wed, 18 May 2022 11:02:54 +0200
Message-ID: <1893094.PYKUYFuaPT@diego>
In-Reply-To: <CAAeLtUBLpDHeJHfPtaUb_OLZb_6cUQa1Z_F+06pkdJMSHtWrfQ@mail.gmail.com>
References: <20220511214132.2281431-1-heiko@sntech.de> <20220518002529.GA1928329-robh@kernel.org> <CAAeLtUBLpDHeJHfPtaUb_OLZb_6cUQa1Z_F+06pkdJMSHtWrfQ@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,T_SPF_HELO_TEMPERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Mittwoch, 18. Mai 2022, 10:22:17 CEST schrieb Philipp Tomsich:
> +David Kruckemyer (who is chairing the CMO task-group within RVI).
> 
> On Wed, 18 May 2022 at 02:25, Rob Herring <robh@kernel.org> wrote:
> >
> > On Wed, May 11, 2022 at 11:41:30PM +0200, Heiko Stuebner wrote:
> > > The Zicbom operates on a block-size defined for the cpu-core,
> > > which does not necessarily match other cache-sizes used.
> > >
> > > So add the necessary property for the system to know the core's
> > > block-size.
> > >
> > > Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> > > ---
> > >  Documentation/devicetree/bindings/riscv/cpus.yaml | 7 +++++++
> > >  1 file changed, 7 insertions(+)
> > >
> > > diff --git a/Documentation/devicetree/bindings/riscv/cpus.yaml b/Documentation/devicetree/bindings/riscv/cpus.yaml
> > > index d632ac76532e..b179bfd155a3 100644
> > > --- a/Documentation/devicetree/bindings/riscv/cpus.yaml
> > > +++ b/Documentation/devicetree/bindings/riscv/cpus.yaml
> > > @@ -63,6 +63,13 @@ properties:
> > >        - riscv,sv48
> > >        - riscv,none
> > >
> > > +  riscv,cbom-block-size:
> > > +    $ref: /schemas/types.yaml#/definitions/uint32
> >
> > Any value 0-2^32 is valid?
> >
> > > +    description:
> > > +      Blocksize in bytes for the Zicbom cache operations. The block
> > > +      size is a property of the core itself and does not necessarily
> > > +      match other software defined cache sizes.
> >
> > What about hardware defined cache sizes? I'm scratching my head as to
> > what a 'software defined cache size' is.

I agree that this should be worded better. The intent was to tell that this
is different from say the l1-cache-block-size.

I.e. these values can be the same but don't need to be. But I guess I got
too much lead on by a kernel implementation detail (L1_CACHE_BYTES constant)


> This seems to be a misnomer, as the specification doesn't use the term
> and rather talks about the "size of a cache block for [operation
> name]".
> 
> There are currently two such 'operation sizes' discoverable by software:
> - size of the cache block for management and prefetch instructions
> - size of the cache block for zero instructions
> 
> For whatever it's worth, cache operations in RISC-V attempt to
> disassociate the underlying hardware cache geometry from software.
> See https://github.com/riscv/riscv-CMOs/blob/master/specifications/cmobase-v1.0.1.pdf
> for the CMO specification, and the discoverable parameters are listed
> in section 2.7.
> 
> Philipp.
> 
> > > +
> > >    riscv,isa:
> > >      description:
> > >        Identifies the specific RISC-V instruction set architecture
> > > --
> > > 2.35.1
> > >
> > >
> 




