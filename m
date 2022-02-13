Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D280E4B3D19
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Feb 2022 20:21:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237963AbiBMTVq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Feb 2022 14:21:46 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:35206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229840AbiBMTVq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Feb 2022 14:21:46 -0500
Received: from shelob.surriel.com (shelob.surriel.com [96.67.55.147])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B19DC310
        for <linux-kernel@vger.kernel.org>; Sun, 13 Feb 2022 11:21:39 -0800 (PST)
Received: from imladris.surriel.com ([96.67.55.152])
        by shelob.surriel.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_ECDSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <riel@shelob.surriel.com>)
        id 1nJKR4-0000LX-Ui; Sun, 13 Feb 2022 14:21:26 -0500
Message-ID: <8aafa00865f564d58dfa39a1e2816a8ec0eab097.camel@surriel.com>
Subject: Re: [PATCH] mm: clean up hwpoison page cache page in fault path
From:   Rik van Riel <riel@surriel.com>
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com,
        linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@suse.de>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Matthew Wilcox <willy@infradead.org>
Date:   Sun, 13 Feb 2022 14:21:26 -0500
In-Reply-To: <10f4319c-45fe-2a7b-db6f-2d5fe8ae98a0@nvidia.com>
References: <20220211170557.7964a301@imladris.surriel.com>
         <10f4319c-45fe-2a7b-db6f-2d5fe8ae98a0@nvidia.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-8nhOn9cXF7OD7/XqPxdK"
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


--=-8nhOn9cXF7OD7/XqPxdK
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, 2022-02-13 at 00:56 -0800, John Hubbard wrote:
> On Fri, 11 Feb 2022, Rik van Riel wrote:
>=20
> > =C2=A0=C2=A0=C2=A0=20
> > This is particularly embarrassing when the page was offlined due to
> > having too many corrected memory errors. Now we are killing tasks
> > due to them trying to access memory that probably isn't even
> > corrupted.
>=20
> I'd recommend deleting that paragraph entirely. It's a separate
> question, and it is not necessarily an accurate assessment of that
> question either: the engineers who set the thresholds for "too many
> corrected errors" may not--in fact, probably *will not*--agree with
> your
> feeling that the memory is still working and reliable!

Fair enough. We try to offline pages before we get to
a point where the error correction might no longer be
able to correct the error correctly, but I am pretty
sure I have seen a few odd kernel crashes following a
stream of corrected errors that strongly suggested
corruption had in fact happened.

I'll take that paragraph out if anybody else asks
for further changes for v3 of the patch.

--=20
All Rights Reversed.

--=-8nhOn9cXF7OD7/XqPxdK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEKR73pCCtJ5Xj3yADznnekoTE3oMFAmIJWjYACgkQznnekoTE
3oNdogf+Ich/XnBrCMzlpA+55TM6I1e+YVX3wzvOc+1CPhoPe0GwAcxnPBKfDkOd
Yh9T7IsM71FRlCHL7pl6P7fppcsrfgqcxm5dcsFwPY9Jcj74GCZs9Fi2jxfo8Exb
NOHNFo4mj9X/izCQoKzF887bjoTXZpMhb0RylbNxrm1uxwbw8mSkfRyo7U5kYf24
9gtSCw6Ag/ZKLU5omsYLcvTqeJ5619m3wNwKGXoIKYyYRy74nfTykyD/y+xWIF1z
lb3nNMqUJx4B8J0d6J/x1EafCxHLThObqw2dy6/expQpwDT/rzgNipFCdhDOG0rr
1PIkhOQi80oESJc0zmN/ocoz7I2r+A==
=wbch
-----END PGP SIGNATURE-----

--=-8nhOn9cXF7OD7/XqPxdK--
