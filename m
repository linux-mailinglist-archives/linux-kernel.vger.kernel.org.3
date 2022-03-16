Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71E864DB61C
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 17:26:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349349AbiCPQ2I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 12:28:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236791AbiCPQ2E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 12:28:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B97116BDDA;
        Wed, 16 Mar 2022 09:26:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5C5F961777;
        Wed, 16 Mar 2022 16:26:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85946C340E9;
        Wed, 16 Mar 2022 16:26:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647448008;
        bh=2nnKMfOwy60kOx/dFCU2LdQ34r1p3osdvyviEMynWTI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=n4YfrMJd77X25AWiIN5jRctkMf5lHY8cb9isdVd0prFcRRjfSqMQ6jWDQpygQ08qr
         PjgTgeecv2IVOTmqFBuA/MCP0j/5PlWaq7qy+qrqkvbUkJbiwSMf91GgnHBtf4/R+S
         ST93Pl/1ScspNnONPY4BkUks4iX+Xu8tWCSeFV1a0ByR7M2vpI/LxiJgadG2bb3t2X
         hqqYJCMBcWd8t9QLAK+3+KsEGtl2ukfx2T85ZwD+d/hHeZH4qx1asN+87G++vcbcDu
         dn2NdI1MHVqd5nSf9HwX56XjqkDerlvaoNgbyAgxMKVojkMEV2gY8E06sYsxy2nlwB
         ahUErQ4X0nIfQ==
Date:   Wed, 16 Mar 2022 16:26:44 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Biju Das <biju.das.jz@bp.renesas.com>
Subject: Re: [GIT PULL] SPI fixes for v5.17-rc7
Message-ID: <YjIPxMrt5rzQ2AtQ@sirena.org.uk>
References: <20220310121327.63C6FC340E8@smtp.kernel.org>
 <CAHk-=wgN6bYPgaB7g0zGXQ5HnbVQ9910o9OQMBLs_S_ax4H67A@mail.gmail.com>
 <YinzW413m6p0H/i1@sirena.org.uk>
 <CAMuHMdU9t2wLonWBjkXBdxxyK_oJiOUTSqrYVrZWjsY2JKEJ2g@mail.gmail.com>
 <CAHk-=wiZnS6n1ROQg3FHd=bcVTHi-sKutKT+toiViQEH47ZACg@mail.gmail.com>
 <CAMuHMdWd_eAGjXRAODXvufoXT_QqqOpuLJTAj9ZG7d-EQyRKBw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="SsEmDHQKnJRn53dV"
Content-Disposition: inline
In-Reply-To: <CAMuHMdWd_eAGjXRAODXvufoXT_QqqOpuLJTAj9ZG7d-EQyRKBw@mail.gmail.com>
X-Cookie: Androphobia:
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--SsEmDHQKnJRn53dV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 15, 2022 at 07:56:13PM +0100, Geert Uytterhoeven wrote:

> You're absolutely right. So the code should be changed to:
>=20
>         if (vmalloced_buf || kmap_buf) {
> -                desc_len =3D min_t(unsigned int, max_seg_size, PAGE_SIZE=
);
> +               desc_len =3D min_t(unsigned long, max_seg_size, PAGE_SIZE=
);
>                 sgs =3D DIV_ROUND_UP(len + offset_in_page(buf), desc_len);
>         } else if (virt_addr_valid(buf)) {
> -               desc_len =3D min_t(unsigned int, max_seg_size, ctlr->max_=
dma_len);
> +               desc_len =3D min_t(size_t, max_seg_size, ctlr->max_dma_le=
n);
>                 sgs =3D DIV_ROUND_UP(len, desc_len);
>         } else {
>                 return -EINVAL;
>         }

Can you send a patch please?

--SsEmDHQKnJRn53dV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmIyD8MACgkQJNaLcl1U
h9AzpQf+LnSWYHu2jiVKTMWxaK4MuIrtWbY4TF5hm0iG1/NQIuLeAWLNGmw7BbJ0
m/SVbtXjMBH5RGGo3NJiFfIN6OWxRA72VtBvdnJEXhwHbBBnz4C79i3IHWHvH6Kv
qfjfKNXhJjGc9qZH44SjB2fAtV3UiqrmfK0TPCbWcr80bjuVJN0xWv7zbOwuxof+
6CBtqECgNIn487PRfCal4+vtT74YvbiG72h8gKGyGmV2KG7AGSKvf/bAhv558Npu
taL/ZE0m10dt4q5pNR0BHH4E1RaZmJUMxfQ3/9qs3gmnp8zbE7EO8yb2oe9vMa4f
9YiivPW922behRiGkQbrtvhUNrq2DQ==
=rKFJ
-----END PGP SIGNATURE-----

--SsEmDHQKnJRn53dV--
