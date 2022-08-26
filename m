Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5E8A5A30F2
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 23:22:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344873AbiHZVWP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 17:22:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234440AbiHZVWN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 17:22:13 -0400
Received: from shelob.surriel.com (shelob.surriel.com [96.67.55.147])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 634EEBA9DF
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 14:22:09 -0700 (PDT)
Received: from imladris.surriel.com ([96.67.55.152])
        by shelob.surriel.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_ECDSA_WITH_AES_256_GCM_SHA384
        (Exim 4.95)
        (envelope-from <riel@shelob.surriel.com>)
        id 1oRgj3-0000ZA-44;
        Fri, 26 Aug 2022 17:18:49 -0400
Message-ID: <6448b9a8dba8ef39e42e56a3c0ce0633fff7c6a6.camel@surriel.com>
Subject: Re: [RFC 2/3] mm: changes to split_huge_page() to free zero filled
 tail pages
From:   Rik van Riel <riel@surriel.com>
To:     David Hildenbrand <david@redhat.com>, alexlzhu@fb.com,
        linux-mm@kvack.org
Cc:     willy@infradead.org, hannes@cmpxchg.org, akpm@linux-foundation.org,
        kernel-team@fb.com, linux-kernel@vger.kernel.org
Date:   Fri, 26 Aug 2022 17:18:48 -0400
In-Reply-To: <ead1bc0e-c9df-d590-3423-9cfa449167e7@redhat.com>
References: <cover.1661461643.git.alexlzhu@fb.com>
         <490fcdd204ae129a2e43614a569a1cf4bdde9196.1661461643.git.alexlzhu@fb.com>
         <ead1bc0e-c9df-d590-3423-9cfa449167e7@redhat.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-t7auAH4ZwjgMioVwL5kI"
User-Agent: Evolution 3.42.4 (3.42.4-1.fc35) 
MIME-Version: 1.0
Sender: riel@shelob.surriel.com
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-t7auAH4ZwjgMioVwL5kI
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2022-08-26 at 12:18 +0200, David Hildenbrand wrote:
> On 25.08.22 23:30, alexlzhu@fb.com=C2=A0wrote:
> > From: Alexander Zhu <alexlzhu@fb.com>
> >=20
> > Currently, split_huge_page() does not have a way to identify zero
> > filled
> > pages within the THP. Thus these zero pages get remapped and
> > continue to
> > create memory waste. In this patch, we identify and free tail pages
> > that
> > are zero filled in split_huge_page(). In this way, we avoid mapping
> > these
> > pages back into page table entries and can free up unused memory
> > within
> > THPs.=20
> >=20
>=20
> Isn't this to some degree splitting the THP (PMDs->PTEs + dissolve
> compound page) and then letting KSM replace the zero-filled page by
> the
> shared zeropage?
>=20
Many systems do not run KSM, though, and even on the systems
where it does, KSM only covers a subset of the memory in the
system.

I could see wanting to maybe consolidate the scanning between
KSM and this thing at some point, if it could be done without
too much complexity, but keeping this change to split_huge_page
looks like it might make sense even when KSM is enabled, since
it will get rid of the unnecessary memory much faster than KSM could.

Keeping a hundred MB of unnecessary memory around for longer
would simply result in more THPs getting split up, and more
memory pressure for a longer time than we need.

--=20
All Rights Reversed.

--=-t7auAH4ZwjgMioVwL5kI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEKR73pCCtJ5Xj3yADznnekoTE3oMFAmMJOLgACgkQznnekoTE
3oOSiwf/Z0jX3IxD6abgm8xNOn+XsJMaGEfbsbN2b6y266szPkcPOnKshck+4BkK
7pU5kcT/uNiqQp98UKVmHtbVtE/W+5K135IjeZyn+hd1zmye7NLAsuXWQ3U0hsBx
21iFKOseM5WK06IrnoAPklu/x4p5wKNmEFnV7Dz3mFK/mXfhbDG6gnMwknJXKty8
6sGONhpIYoyLWqIFmOYzX/IWHu8V9PabtIPk7aiZjQvnOL5WqSrEYiC24mZoq+8m
5UbKd/9kY9p9YMMw31IAL453BxlYcYHU1CdqdOAzZnF9L+HD82QTJ5gnQ41/hyhi
VgW/QDY9OHdSYtQKdyntQyxxbVuLHw==
=+VGD
-----END PGP SIGNATURE-----

--=-t7auAH4ZwjgMioVwL5kI--
