Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0189952821C
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 12:31:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233020AbiEPKb2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 06:31:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229762AbiEPKbT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 06:31:19 -0400
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED8211837E
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 03:31:15 -0700 (PDT)
Received: from ip5b412258.dynamic.kabel-deutschland.de ([91.65.34.88] helo=diego.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1nqY08-0001ig-KU; Mon, 16 May 2022 12:30:56 +0200
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     Christoph Hellwig <hch@lst.de>,
        Philipp Tomsich <philipp.tomsich@vrull.eu>
Cc:     palmer@dabbelt.com, paul.walmsley@sifive.com,
        aou@eecs.berkeley.edu, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, wefu@redhat.com,
        liush@allwinnertech.com, guoren@kernel.org, atishp@atishpatra.org,
        anup@brainfault.org, drew@beagleboard.org, arnd@arndb.de,
        wens@csie.org, maxime@cerno.tech, gfavor@ventanamicro.com,
        andrea.mondelli@huawei.com, behrensj@mit.edu, xinhaoqu@huawei.com,
        mick@ics.forth.gr, allen.baum@esperantotech.com,
        jscheid@ventanamicro.com, rtrauben@gmail.com, samuel@sholland.org,
        cmuellner@linux.com, Wei Wu <lazyparser@gmail.com>,
        Daniel Lustig <dlustig@nvidia.com>,
        Bill Huffman <huffman@cadence.com>
Subject: Re: [PATCH 09/12] riscv: add RISC-V Svpbmt extension support
Date:   Mon, 16 May 2022 12:30:55 +0200
Message-ID: <4710483.GXAFRqVoOG@diego>
In-Reply-To: <CAAeLtUA1FWQRot6=zHXWBa3YnfxuhL2TW-a-TNomDeUFPrrz1A@mail.gmail.com>
References: <20220511192921.2223629-1-heiko@sntech.de> <20220516061057.GL12339@lst.de> <CAAeLtUA1FWQRot6=zHXWBa3YnfxuhL2TW-a-TNomDeUFPrrz1A@mail.gmail.com>
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

Am Montag, 16. Mai 2022, 11:09:12 CEST schrieb Philipp Tomsich:
> On Mon, 16 May 2022 at 08:11, Christoph Hellwig <hch@lst.de> wrote:
> >
> > > +config RISCV_ISA_SVPBMT
> > > +     bool "SVPBMT extension support"
> >
> > I don't think this prompt is very useful as it doesn't describe
> > what it does.  But do we even want people to disable it as it is
> > really essentially for a fully functioning kernel and a pity that
> > it took RISC-V so long to get there?
> 
> Given that RISC-V is (in some ways) an ISA construction set, there
> will be valid use cases for embedded users to disable this (e.g. if
> they have their own non-standard way to configure these).  So while
> kernels for binary distributions (and desktop, server, or
> general-purpose embedded) will always enable these, I would fully
> expect some users to want to turn these off.

Also, enabling the SVPBMT extension will pull in the alternative-patching
as well of course, and having a way to disable that was a review-request
a version in the past.


> @Heiko: I would request that we have a longer help text on this, which
> explains what it is and ends with the usual "When in doubt, say Y."

ok, will do


> > > +     depends on 64BIT && MMU
> > > +     select RISCV_ALTERNATIVE
> > > +     default y
> > > +     help
> > > +        Adds support to dynamically detect the presence of the SVPBMT extension
> >
> > overly long line here.

will fix together with Philipp's help-text wish


> > > index 5f1046e82d9f..dbfcd9b72bd8 100644
> > > --- a/arch/riscv/include/asm/errata_list.h
> > > +++ b/arch/riscv/include/asm/errata_list.h
> > > @@ -14,6 +14,9 @@
> > >  #define      ERRATA_SIFIVE_NUMBER 2
> > >  #endif
> > >
> > > +#define      CPUFEATURE_SVPBMT 0
> > > +#define      CPUFEATURE_NUMBER 1
> >
> > is errata_list.h really the right place for architectural features?

That probably stems from the alternatives being exclusively used
for erratas in the past.

I guess making this "alternative-list.h" might be a better naming?
Or are there even better suggestions?

> > Otherwise looks good:
> >
> > Reviewed-by: Christoph Hellwig <hch@lst.de>

Thanks
Heiko



