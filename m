Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43B895A4DD0
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 15:21:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230095AbiH2NVQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 09:21:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230469AbiH2NUi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 09:20:38 -0400
Received: from shelob.surriel.com (shelob.surriel.com [96.67.55.147])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB5F98768F
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 06:18:09 -0700 (PDT)
Received: from imladris.surriel.com ([96.67.55.152])
        by shelob.surriel.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_ECDSA_WITH_AES_256_GCM_SHA384
        (Exim 4.96)
        (envelope-from <riel@shelob.surriel.com>)
        id 1oSedY-0005QW-1I;
        Mon, 29 Aug 2022 09:17:08 -0400
Message-ID: <37db29410990991555362154a371b58f47d3cb0c.camel@surriel.com>
Subject: Re: [RFC 2/3] mm: changes to split_huge_page() to free zero filled
 tail pages
From:   Rik van Riel <riel@surriel.com>
To:     David Hildenbrand <david@redhat.com>, alexlzhu@fb.com,
        linux-mm@kvack.org
Cc:     willy@infradead.org, hannes@cmpxchg.org, akpm@linux-foundation.org,
        kernel-team@fb.com, linux-kernel@vger.kernel.org
Date:   Mon, 29 Aug 2022 09:17:07 -0400
In-Reply-To: <42c164c6-8c69-7b4b-d965-ac62d1607061@redhat.com>
References: <cover.1661461643.git.alexlzhu@fb.com>
         <490fcdd204ae129a2e43614a569a1cf4bdde9196.1661461643.git.alexlzhu@fb.com>
         <ead1bc0e-c9df-d590-3423-9cfa449167e7@redhat.com>
         <6448b9a8dba8ef39e42e56a3c0ce0633fff7c6a6.camel@surriel.com>
         <42c164c6-8c69-7b4b-d965-ac62d1607061@redhat.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-ewTTOtihmzCHaP0At5qy"
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


--=-ewTTOtihmzCHaP0At5qy
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2022-08-29 at 12:02 +0200, David Hildenbrand wrote:
> On 26.08.22 23:18, Rik van Riel wrote:
> > On Fri, 2022-08-26 at 12:18 +0200, David Hildenbrand wrote:
> > > On 25.08.22 23:30, alexlzhu@fb.com=C2=A0wrote:
> > > > From: Alexander Zhu <alexlzhu@fb.com>
> >=20
> > I could see wanting to maybe consolidate the scanning between
> > KSM and this thing at some point, if it could be done without
> > too much complexity, but keeping this change to split_huge_page
> > looks like it might make sense even when KSM is enabled, since
> > it will get rid of the unnecessary memory much faster than KSM
> > could.
> >=20
> > Keeping a hundred MB of unnecessary memory around for longer
> > would simply result in more THPs getting split up, and more
> > memory pressure for a longer time than we need.
>=20
> Right. I was wondering if we want to map the shared zeropage instead
> of
> the "detected to be zero" page, similar to how KSM would do it. For
> example, with userfaultfd there would be an observable difference.
>=20
> (maybe that's already done in this patch set)
>=20
The patch does not currently do that, but I suppose it could?

What exactly are the userfaultfd differences here, and how does
dropping 4kB pages break things vs. using the shared zeropage?

--=20
All Rights Reversed.

--=-ewTTOtihmzCHaP0At5qy
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEyBAABCAAdFiEEKR73pCCtJ5Xj3yADznnekoTE3oMFAmMMvFMACgkQznnekoTE
3oN0jAf4rHO+YfpYMXfHD18EnjUbWe5R2ZnUT7wVZGN2DsP5qndjRMtnerruYVI3
0rCfGLFYBqhcYeeBcsA/jaxJDuGCJGxPkm4hyLW3kLz9x5txWVybLRaedq/47xZz
TmGtIm5W2DWF/OROaQWBqSWM+uWFSD1VKYfE9/ZpGqVOybNaQtbFH82Hb/+Jvuyj
QJeMWMyvpOTmcg2Rdsqj1DCbddp4U9KDOHtVuTstCpZuL1jrO3lgu1PYfkY58/Cj
mQifBMMWmHHEyLtpjRd6okKILcz8PxKGttOZgK3c/d2A9SwqkIeK4BbbfVi44mI3
eU4D6A9vfeg6UbW3S9M9vs9Oq+Lt
=uOBY
-----END PGP SIGNATURE-----

--=-ewTTOtihmzCHaP0At5qy--
