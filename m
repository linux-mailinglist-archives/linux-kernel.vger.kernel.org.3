Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD9B84B600C
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 02:37:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233045AbiBOBhz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 20:37:55 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:53046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbiBOBhy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 20:37:54 -0500
Received: from shelob.surriel.com (shelob.surriel.com [96.67.55.147])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F1151275C1
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 17:37:41 -0800 (PST)
Received: from imladris.surriel.com ([96.67.55.152])
        by shelob.surriel.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_ECDSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <riel@shelob.surriel.com>)
        id 1nJmmV-0007om-I1; Mon, 14 Feb 2022 20:37:27 -0500
Message-ID: <6f70cc26ccc92d099f1080e4c57ab44709bafd68.camel@surriel.com>
Subject: Re: [PATCH v2] mm: clean up hwpoison page cache page in fault path
From:   Rik van Riel <riel@surriel.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com,
        linux-mm@kvack.org, Miaohe Lin <linmiaohe@huawei.com>,
        Mel Gorman <mgorman@suse.de>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Matthew Wilcox <willy@infradead.org>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>
Date:   Mon, 14 Feb 2022 20:37:26 -0500
In-Reply-To: <20220214152407.67e0d7dd1a532252c9dd203e@linux-foundation.org>
References: <20220212213740.423efcea@imladris.surriel.com>
         <20220214152407.67e0d7dd1a532252c9dd203e@linux-foundation.org>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-b7zfiHYjDu/3wMt4SsyU"
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


--=-b7zfiHYjDu/3wMt4SsyU
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2022-02-14 at 15:24 -0800, Andrew Morton wrote:
>=20
> > Subject: [PATCH v2] mm: clean up hwpoison page cache page in fault
> > path
>=20
> At first scan I thought this was a code cleanup.
>=20
> I think I'll do s/clean up/invalidate/.
>=20
OK, that sounds good.

> On Sat, 12 Feb 2022 21:37:40 -0500 Rik van Riel <riel@surriel.com>
> wrote:
>=20
> > Sometimes the page offlining code can leave behind a hwpoisoned
> > clean
> > page cache page.
>=20
> Is this correct behaviour?

It is not desirable, and the soft page offlining code
tries to invalidate the page, but I don't think overhauling
the way we lock and refcount page cache pages just to make
offlining them more reliable would be worthwhile, when we
already have a branch in the page fault handler to deal with
these pages, anyway.

> > This can lead to programs being killed over and over
> > and over again as they fault in the hwpoisoned page, get killed,
> > and
> > then get re-spawned by whatever wanted to run them.
> >=20
> > This is particularly embarrassing when the page was offlined due to
> > having too many corrected memory errors. Now we are killing tasks
> > due to them trying to access memory that probably isn't even
> > corrupted.
> >=20
> > This problem can be avoided by invalidating the page from the page
> > fault handler, which already has a branch for dealing with these
> > kinds of pages. With this patch we simply pretend the page fault
> > was successful if the page was invalidated, return to userspace,
> > incur another page fault, read in the file from disk (to a new
> > memory page), and then everything works again.
>=20
> Is this worth a cc:stable?

Maybe. I don't know how far back this issue goes...

--=20
All Rights Reversed.

--=-b7zfiHYjDu/3wMt4SsyU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEyBAABCAAdFiEEKR73pCCtJ5Xj3yADznnekoTE3oMFAmILA9YACgkQznnekoTE
3oOFvAf1Eybcb8fqZjb7Qum00p9okDKc5SuiWsTTFGEsKIXcC7BlUhFblo2zFQEX
98tgwOw5KzXtj5iuvkEw2VLja8XbaH/uWDVMi8OOFwKyPhj2wmnDsS1z3bmhnFbM
Gq36IigdymUctDQnUIJFkXsdVEB+O0LzG19JLbi6BEhnio1Qq6u5Zsu+1bwNvuP3
zOI2rM3Lk4o4++0WidG8W1jQ3aCmMXlZmCqciWkWl4dIP9Gqm21rSSHIhVfgCaKs
PMXMjlX4XbEASBA3pvt2YBa3GRFoUxYlgGqwryzMnO4XZpudG4BfbIV9Ymkx9Rie
Oun+LZjwhT+8180Ks+JvjU0o5Z9E
=UKB2
-----END PGP SIGNATURE-----

--=-b7zfiHYjDu/3wMt4SsyU--
