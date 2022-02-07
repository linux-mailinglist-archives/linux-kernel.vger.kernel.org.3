Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B17CA4AC6DB
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 18:11:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383797AbiBGRJQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 12:09:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381003AbiBGRF1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 12:05:27 -0500
X-Greylist: delayed 2118 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 07 Feb 2022 09:05:25 PST
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B23CC0401D1;
        Mon,  7 Feb 2022 09:05:25 -0800 (PST)
Received: from ip5b412258.dynamic.kabel-deutschland.de ([91.65.34.88] helo=phil.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1nH6tm-0004ET-2l; Mon, 07 Feb 2022 17:29:54 +0100
From:   Heiko Stuebner <heiko@sntech.de>
To:     Rob Herring <robh@kernel.org>
Cc:     palmer@dabbelt.com, paul.walmsley@sifive.com,
        aou@eecs.berkeley.edu, linux-riscv@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        wefu@redhat.com, liush@allwinnertech.com, guoren@kernel.org,
        atishp@atishpatra.org, anup@brainfault.org, drew@beagleboard.org,
        hch@lst.de, arnd@arndb.de, wens@csie.org, maxime@cerno.tech,
        dlustig@nvidia.com, gfavor@ventanamicro.com,
        andrea.mondelli@huawei.com, behrensj@mit.edu, xinhaoqu@huawei.com,
        huffman@cadence.com, mick@ics.forth.gr,
        allen.baum@esperantotech.com, jscheid@ventanamicro.com,
        rtrauben@gmail.com, samuel@sholland.org, cmuellner@linux.com,
        philipp.tomsich@vrull.eu
Subject: Re: [PATCH v5 11/14] dt-bindings: riscv: add MMU Standard Extensions support for Svpbmt
Date:   Mon, 07 Feb 2022 14:39:31 +0100
Message-ID: <2446197.JSQJs4Nv0J@phil>
In-Reply-To: <Yf2pxvmG0t6eugOz@robh.at.kernel.org>
References: <20220121163618.351934-1-heiko@sntech.de> <20220121163618.351934-12-heiko@sntech.de> <Yf2pxvmG0t6eugOz@robh.at.kernel.org>
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

Am Freitag, 4. Februar 2022, 23:33:42 CET schrieb Rob Herring:
> On Fri, Jan 21, 2022 at 05:36:15PM +0100, Heiko Stuebner wrote:
> > From: Wei Fu <wefu@redhat.com>
> > 
> > Previous patch has added svpbmt in arch/riscv and add "riscv,svpmbt"
> > in the DT mmu node. Update dt-bindings related property here.
> > 
> > Signed-off-by: Wei Fu <wefu@redhat.com>
> > Co-developed-by: Guo Ren <guoren@kernel.org>
> > Signed-off-by: Guo Ren <guoren@kernel.org>
> > Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> > Cc: Anup Patel <anup@brainfault.org>
> > Cc: Palmer Dabbelt <palmer@dabbelt.com>
> > Cc: Rob Herring <robh+dt@kernel.org>
> > ---
> >  Documentation/devicetree/bindings/riscv/cpus.yaml | 10 ++++++++++
> >  1 file changed, 10 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/riscv/cpus.yaml b/Documentation/devicetree/bindings/riscv/cpus.yaml
> > index aa5fb64d57eb..3ad2593f1400 100644
> > --- a/Documentation/devicetree/bindings/riscv/cpus.yaml
> > +++ b/Documentation/devicetree/bindings/riscv/cpus.yaml
> > @@ -63,6 +63,16 @@ properties:
> >        - riscv,sv48
> >        - riscv,none
> >  
> > +  mmu:
> 
> riscv,mmu
> 
> > +    description:
> > +      Describes the CPU's MMU Standard Extensions support.
> > +      These values originate from the RISC-V Privileged
> > +      Specification document, available from
> > +      https://riscv.org/specifications/
> > +    $ref: '/schemas/types.yaml#/definitions/string'
> > +    enum:
> > +      - riscv,svpbmt
> 
> Are there per vendor MMU extensions? If not, drop the 'riscv,' part. 

Judging by the somewhat wild-west nature, I guess there might already
be non-riscv extensions existing somewhere, or at least the probability
is quite high that there will be in the future ;-)

> 
> > +
> >    riscv,isa:
> >      description:
> >        Identifies the specific RISC-V instruction set architecture
> 




