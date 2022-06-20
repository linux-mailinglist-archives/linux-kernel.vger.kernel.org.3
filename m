Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F77555239A
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 20:11:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237952AbiFTSL1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 14:11:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238101AbiFTSL0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 14:11:26 -0400
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A52DD1903C;
        Mon, 20 Jun 2022 11:11:22 -0700 (PDT)
Received: from [88.128.92.94] (helo=phil.localnet)
        by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <heiko@sntech.de>)
        id 1o3Lrg-0006lF-Jd; Mon, 20 Jun 2022 20:11:08 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     Atish Patra <atishp@atishpatra.org>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        Wei Fu <wefu@redhat.com>, Guo Ren <guoren@kernel.org>,
        Christoph Muellner <cmuellner@linux.com>,
        Philipp Tomsich <philipp.tomsich@vrull.eu>,
        Christoph Hellwig <hch@lst.de>,
        Samuel Holland <samuel@sholland.org>,
        Anup Patel <anup@brainfault.org>,
        Nick Kossifidis <mick@ics.forth.gr>,
        Rob Herring <robh+dt@kernel.org>, krzk+dt@kernel.org,
        devicetree <devicetree@vger.kernel.org>,
        Drew Fustini <drew@beagleboard.org>,
        Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH 1/4] of: also handle dma-noncoherent in of_dma_is_coherent()
Date:   Mon, 20 Jun 2022 20:11:06 +0200
Message-ID: <5907887.LM0AJKV5NW@phil>
In-Reply-To: <CAOnJCUJC3dk21cYXXDOsamvwFDHsukoBx7HEYwqHM+MN5fLRpA@mail.gmail.com>
References: <20220619203212.3604485-1-heiko@sntech.de> <20220619203212.3604485-2-heiko@sntech.de> <CAOnJCUJC3dk21cYXXDOsamvwFDHsukoBx7HEYwqHM+MN5fLRpA@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,T_SPF_HELO_TEMPERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Atish,

Am Montag, 20. Juni 2022, 18:33:09 CEST schrieb Atish Patra:
> On Sun, Jun 19, 2022 at 1:32 PM Heiko Stuebner <heiko@sntech.de> wrote:
> >
> > of_dma_is_coherent() currently expects the architecture to be
> > non-coherent and some devices being coherent getting marked
> > as such with the dma-coherent devicetree property.
> >
> > For PowerPC CONFIG_OF_DMA_DEFAULT_COHERENT was added which currently
> > makes of_dma_is_coherent() always return true but doesn't handle
> > the case of the architecture being coherent but some devices not.
> >
> > So modify the function to also check for dma-noncoherent and
> > set a suitable default return value. If CONFIG_OF_DMA_DEFAULT_COHERENT
> > is set the value starts with true and finding dma-noncoherent will
> > set it to false and without CONFIG_OF_DMA_DEFAULT_COHERENT, the
> > behaviour is reversed.
> >
> > Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> > ---
> >  drivers/of/address.c | 16 +++++++++++-----
> >  1 file changed, 11 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/of/address.c b/drivers/of/address.c
> > index 94f017d808c4..1c362d09983d 100644
> > --- a/drivers/of/address.c
> > +++ b/drivers/of/address.c
> > @@ -1045,26 +1045,32 @@ phys_addr_t __init of_dma_get_max_cpu_address(struct device_node *np)
> >   *
> >   * It returns true if "dma-coherent" property was found
> >   * for this device in the DT, or if DMA is coherent by
> > - * default for OF devices on the current platform.
> > + * default for OF devices on the current platform and no
> > + * "dma-noncoherent" property was found for this device.
> 
> "dma-noncoherent" is not a standard DT property. I couldn't find any
> references to
> it in the kernel as well. If we are introducing a new DT property for
> non-coherent devices,
> it should be added in DT bindings as well ?

The dma-coherent is part of the core devicetree-spec,
so I sent a patch adding dma-noncoherent [0]
to the devicetree-spec mailing list yesterday as well.

[0] https://www.spinics.net/lists/devicetree-spec/msg01053.html


> 
> >   */
> >  bool of_dma_is_coherent(struct device_node *np)
> >  {
> >         struct device_node *node;
> > +       bool ret = false;
> >
> >         if (IS_ENABLED(CONFIG_OF_DMA_DEFAULT_COHERENT))
> > -               return true;
> > +               ret = true;
> >
> >         node = of_node_get(np);
> >
> >         while (node) {
> >                 if (of_property_read_bool(node, "dma-coherent")) {
> > -                       of_node_put(node);
> > -                       return true;
> > +                       ret = true;
> > +                       break;
> > +               }
> > +               if (of_property_read_bool(node, "dma-noncoherent")) {
> > +                       ret = false;
> > +                       break;
> >                 }
> >                 node = of_get_next_dma_parent(node);
> >         }
> >         of_node_put(node);
> > -       return false;
> > +       return ret;
> >  }
> >  EXPORT_SYMBOL_GPL(of_dma_is_coherent);
> >
> > --
> > 2.35.1
> >
> 
> 
> 




