Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EA0F56018F
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 15:42:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233678AbiF2Nly (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 09:41:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229778AbiF2Nlv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 09:41:51 -0400
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E87BD1E3E2;
        Wed, 29 Jun 2022 06:41:49 -0700 (PDT)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 43DAA1C0B8F; Wed, 29 Jun 2022 15:41:48 +0200 (CEST)
Date:   Wed, 29 Jun 2022 15:41:47 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Cc:     Marc Zyngier <maz@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Sagar Kadam <sagar.kadam@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Biju Das <biju.das.jz@bp.renesas.com>
Subject: Re: [PATCH v2 2/2] irqchip/sifive-plic: Add support for Renesas
 RZ/Five SoC
Message-ID: <20220629134147.GA16868@duo.ucw.cz>
References: <20220626004326.8548-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20220626004326.8548-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <87wnd3erab.wl-maz@kernel.org>
 <CA+V-a8tcxj_N0sBHhgAZAN8WSJ12JnDzAvUUnCXto3wHLqNVwg@mail.gmail.com>
 <87v8snehwi.wl-maz@kernel.org>
 <CAMuHMdVt9FjCtvMgJcCh=g2b+8b-fgabGbOLDcXNrrPMpC+3jQ@mail.gmail.com>
 <CA+V-a8uLzLJ=wB6oUu0b2oZO=FPSCTSrqb=3m9=BJxATFKmjMw@mail.gmail.com>
 <CAMuHMdUWC_7MPnP6LcOqi96FAhrAENC4iwtv2ksZVnvR8BC4ww@mail.gmail.com>
 <0fdbfdd0ee1c7ca39f8d3e2f86af1194@kernel.org>
 <CA+V-a8u8X+bne_a3LY13zGTKr-hOWhm=R9gGX1JyE8PzWRNXpQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="zYM0uCDKw75PZbzx"
Content-Disposition: inline
In-Reply-To: <CA+V-a8u8X+bne_a3LY13zGTKr-hOWhm=R9gGX1JyE8PzWRNXpQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--zYM0uCDKw75PZbzx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > >> +#define PLIC_QUIRK_EDGE_INTERRUPT      BIT(0)
> > >>
> > >>  struct plic_priv {
> > >>         struct cpumask lmask;
> > >>         struct irq_domain *irqdomain;
> > >>         void __iomem *regs;
> > >> +       u32 plic_quirks;
> > >>  };
> > >>
> > >> What about something like above?
> > >
> > > LGTM.
> > >
> > > Marc suggested to make this unsigned long, but TBH, that won't make
> > > much of a difference.  PLICs are present on RV32 SoCs, too, so you
> > > cannot rely on having more than 32 bits anyway.
> >
> > But it will make a difference on a 64bit platform, as we want to
> > use test_bit() and co to check for features.
> >
> Ok will change that to unsigned long and use the test_bit/set_bit instead.

Is there good enough reason for that? test_bit/... are when you need
atomicity, and that's not the case here. Plain old & ... should be
enough.

Best regards,
								Pavel
--=20
People of Russia, stop Putin before his war on Ukraine escalates.

--zYM0uCDKw75PZbzx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCYrxWmwAKCRAw5/Bqldv6
8l9XAJ9PDnKunqrF+aGJXyJ5p6LANeuPPQCbB6eNJLatSurZL6FSw4K9O5lrN+I=
=Ha9n
-----END PGP SIGNATURE-----

--zYM0uCDKw75PZbzx--
