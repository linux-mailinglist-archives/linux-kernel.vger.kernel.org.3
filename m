Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19CCC4B72AE
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 17:42:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238254AbiBOPFM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 10:05:12 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:33256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234944AbiBOPFK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 10:05:10 -0500
Received: from shelob.surriel.com (shelob.surriel.com [96.67.55.147])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72E68107D33
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 07:05:00 -0800 (PST)
Received: from imladris.surriel.com ([96.67.55.152])
        by shelob.surriel.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_ECDSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <riel@shelob.surriel.com>)
        id 1nJzNx-0001uA-LX; Tue, 15 Feb 2022 10:04:57 -0500
Message-ID: <c5eefc68193669160429437f7151b53f60c1b755.camel@surriel.com>
Subject: Re: [PATCH v2] mm: clean up hwpoison page cache page in fault path
From:   Rik van Riel <riel@surriel.com>
To:     Oscar Salvador <osalvador@suse.de>
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com,
        linux-mm@kvack.org, Miaohe Lin <linmiaohe@huawei.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@suse.de>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Matthew Wilcox <willy@infradead.org>
Date:   Tue, 15 Feb 2022 10:04:57 -0500
In-Reply-To: <Yguh5JUGHln/iRJ8@localhost.localdomain>
References: <20220212213740.423efcea@imladris.surriel.com>
         <Yguh5JUGHln/iRJ8@localhost.localdomain>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-cEEbhHLZGjBrDgd1rkUJ"
User-Agent: Evolution 3.42.3 (3.42.3-1.fc35) 
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


--=-cEEbhHLZGjBrDgd1rkUJ
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2022-02-15 at 13:51 +0100, Oscar Salvador wrote:
> On Sat, Feb 12, 2022 at 09:37:40PM -0500, Rik van Riel wrote:
> > Sometimes the page offlining code can leave behind a hwpoisoned
> > clean
> > page cache page. This can lead to programs being killed over and
> > over
> > and over again as they fault in the hwpoisoned page, get killed,
> > and
> > then get re-spawned by whatever wanted to run them.
>=20
> Hi Rik,
>=20
> Do you know how that exactly happens? We should not be really leaving
> anything behind, and soft-offline (not hard) code works with the
> premise
> of only poisoning a page in case it was contained, so I am wondering
> what is going on here.
>=20
> In-use pagecache pages are migrated away, and the actual page is
> contained, and for clean ones, we already do the
> invalidate_inode_page()
> and then contain it in case we succeed.

I do not know the exact failure case, since I have never
caught a system in the act of leaking one of these pages.

I just know I have seen this issue on systems where the
"soft_offline: %#lx: invalidated\n" printk was the only
offline method leaving any message in the kernel log.

However, there are a few code paths through the soft
offlining code path that don't seem to have any printks,
so I am not sure exactly where things went wrong.

I only really found the aftermath, and tested this patch
by loading it as a kernel live patch module on some of
those systems.

--=20
All Rights Reversed.

--=-cEEbhHLZGjBrDgd1rkUJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEKR73pCCtJ5Xj3yADznnekoTE3oMFAmILwRkACgkQznnekoTE
3oOatgf/VctfpxQ82Wr2xD3ogIG/T6vKdLWw/cOzRgJoZDyal2JxdXppe3Cu1IPt
C8UGfdwh/LKsmFf2fUdux3aBc9abX4KAzntPkhnfN2ST3Bd4Eph8ejFoLQPsmFV8
UMP966KO25wDVf8eovgXHQLB0gcIMVxivr72wOVXzZz2Iz0DzUovcYwjgPmt1NMG
nGJ4Xre00BEPi0Pb1ktzGoAWOfC8iv27C+mMPR9cQY1RFDvkbAYhS33ch7ntKKHq
9mbNXxIPlIFVR3Zh61qssRrZzGrX3L/PotkiTtZW9qPs+roaWHZQwSCyAhp6tNT5
wCXIC1iwsAqEMS7Lxk74heUHTIscWw==
=1vXq
-----END PGP SIGNATURE-----

--=-cEEbhHLZGjBrDgd1rkUJ--
