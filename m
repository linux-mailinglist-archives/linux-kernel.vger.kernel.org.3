Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50F72534025
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 17:15:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241608AbiEYPPK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 11:15:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245111AbiEYPO6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 11:14:58 -0400
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98221AFB0A;
        Wed, 25 May 2022 08:14:53 -0700 (PDT)
Received: from ip5b412258.dynamic.kabel-deutschland.de ([91.65.34.88] helo=diego.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1ntsiW-0006cQ-BV; Wed, 25 May 2022 17:14:32 +0200
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     Rob Herring <robh@kernel.org>
Cc:     palmer@dabbelt.com, paul.walmsley@sifive.com,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        wefu@redhat.com, guoren@kernel.org, atishp@atishpatra.org,
        anup@brainfault.org, mick@ics.forth.gr, samuel@sholland.org,
        cmuellner@linux.com, philipp.tomsich@vrull.eu, krzk+dt@kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v2 1/3] dt-bindings: riscv: document cbom-block-size
Date:   Wed, 25 May 2022 17:14:31 +0200
Message-ID: <4376261.8F6SAcFxjW@diego>
In-Reply-To: <20220518002529.GA1928329-robh@kernel.org>
References: <20220511214132.2281431-1-heiko@sntech.de> <20220511214132.2281431-2-heiko@sntech.de> <20220518002529.GA1928329-robh@kernel.org>
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

Am Mittwoch, 18. Mai 2022, 02:25:29 CEST schrieb Rob Herring:
> On Wed, May 11, 2022 at 11:41:30PM +0200, Heiko Stuebner wrote:
> > The Zicbom operates on a block-size defined for the cpu-core,
> > which does not necessarily match other cache-sizes used.
> > 
> > So add the necessary property for the system to know the core's
> > block-size.
> > 
> > Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> > ---
> >  Documentation/devicetree/bindings/riscv/cpus.yaml | 7 +++++++
> >  1 file changed, 7 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/riscv/cpus.yaml b/Documentation/devicetree/bindings/riscv/cpus.yaml
> > index d632ac76532e..b179bfd155a3 100644
> > --- a/Documentation/devicetree/bindings/riscv/cpus.yaml
> > +++ b/Documentation/devicetree/bindings/riscv/cpus.yaml
> > @@ -63,6 +63,13 @@ properties:
> >        - riscv,sv48
> >        - riscv,none
> >  
> > +  riscv,cbom-block-size:
> > +    $ref: /schemas/types.yaml#/definitions/uint32
> 
> Any value 0-2^32 is valid?

funnily enough there really seems to be _no_ constraints defined in the
spec [0] regarding the actual cache-block size.

It essentially only states
"The capacity and organization of a cache and the size of a
cache block are both implementation-specific"

and later in software-discovery:
"The initial set of CMO extensions requires the following information to
be discovered by software:
- The size of the cache block for management and prefetch instructions
- The size of the cache block for zero instructions"



[0] https://github.com/riscv/riscv-CMOs/blob/master/specifications/cmobase-v1.0.pdf


> 
> > +    description:
> > +      Blocksize in bytes for the Zicbom cache operations. The block
> > +      size is a property of the core itself and does not necessarily
> > +      match other software defined cache sizes.
> 
> What about hardware defined cache sizes? I'm scratching my head as to 
> what a 'software defined cache size' is.
> 
> > +
> >    riscv,isa:
> >      description:
> >        Identifies the specific RISC-V instruction set architecture
> 




