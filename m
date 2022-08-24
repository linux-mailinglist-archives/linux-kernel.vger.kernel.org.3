Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87FF15A0279
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 22:08:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239329AbiHXUIo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 16:08:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229930AbiHXUIl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 16:08:41 -0400
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4B307C192
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 13:08:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=sang-engineering.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=k1; bh=cGo8IqrG/KMEITictY7c3nGCM3fN
        8IhhTVEah6GE6VI=; b=Q+De1sStZ3EMtn0rk0NMKRhepZ0v1mmx+EIFS1Dan3Zo
        fHV8fjTU5Gmbana/BPunGB4IUkyu3HKhb2PRimrsnFXDeOXa9T/uavq/uDl3IKDQ
        HOS8biVFgncyIhY1PF6oRqTMd/Of3AnAQzoOuA7F6WhP6M0IwRDp7zlWzgzVwBo=
Received: (qmail 2367966 invoked from network); 24 Aug 2022 22:08:39 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 24 Aug 2022 22:08:39 +0200
X-UD-Smtp-Session: l3s3148p1@f20gPwLnwIcgAwDtxwoDABxA2q3xYuRb
Date:   Wed, 24 Aug 2022 22:08:38 +0200
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     Andrew Price <anprice@redhat.com>
Cc:     cluster-devel@redhat.com, linux-kernel@vger.kernel.org,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Bob Peterson <rpeterso@redhat.com>
Subject: Re: [Cluster-devel] [PATCH] gfs2: move from strlcpy with unused
 retval to strscpy
Message-ID: <YwaFRvWw5hi/uWYs@shikoro>
Mail-Followup-To: Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Andrew Price <anprice@redhat.com>, cluster-devel@redhat.com,
        linux-kernel@vger.kernel.org,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Bob Peterson <rpeterso@redhat.com>
References: <20220818210144.7915-1-wsa+renesas@sang-engineering.com>
 <bd7275c6-4ebe-de99-75c2-400cfa2e5026@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="4Tos7O8I/5EpltQ3"
Content-Disposition: inline
In-Reply-To: <bd7275c6-4ebe-de99-75c2-400cfa2e5026@redhat.com>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--4Tos7O8I/5EpltQ3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Andy.

> > -	strlcpy(sdp->sd_proto_name, proto, GFS2_FSNAME_LEN);
> > -	strlcpy(sdp->sd_table_name, table, GFS2_FSNAME_LEN);
> > +	strscpy(sdp->sd_proto_name, proto, GFS2_FSNAME_LEN);
> > +	strscpy(sdp->sd_table_name, table, GFS2_FSNAME_LEN);
>=20
> Perhaps the size should be changed to GFS2_LOCKNAME_LEN to match the size=
 of
> the destination, too.
>=20
> With that addition, this patch fixes this syzkaller report:
>=20
> https://listman.redhat.com/archives/cluster-devel/2022-August/022755.html

Linus wrote another summary about strlcpy vs. strscpy use[1]. So, the
size argument should be the size of the smaller buffer if the buffers
are of different size. GFS2_LOCKNAME_LEN is smaller, so that looks
suitable. Shall I resend the patch with the suggested change?

All the best,

   Wolfram

[1] https://lore.kernel.org/lkml/CAHk-=3Dwi+xbVq++uqW9YgWpHjyBHNB8a-xad+Xp2=
3-B+eodLCEA@mail.gmail.com/


--4Tos7O8I/5EpltQ3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmMGhUYACgkQFA3kzBSg
KbZFCw//Uv87sZJFYRzCSSRxchAgtLlyCFwPcJBZHh6W85/umoJN6WDBWqcUS8IN
+vCugF8lo2gUkBvQxfltmEP39oVI9aDdNSz+d5OPt1vCBfkRu5JMAa/jUQxHEGzm
vmmILcol1Zr+GYbbcDu3qxV44EPoHdvMjLzJ2FEZP5ODIy/zDNIsLxtdSupjR1ut
YsWH6LT5i9jZrrC+PpHecxGC3wU9dIsGcxgwhpR9Mz3/M0YwxU3DQb4hMAIEh3Yg
yedUz71kLZqjC9nuXbVZnfhwEOolDXgt6j6wdkM0F5/TL6et6a4pPUaO6U560FgM
SeORpAYWbLAizkdS+2/LrebOG3ZSGhyi1O1ty735J40RuE9XzP+fmmyN9D5MdmOe
PYundwj3LbDy5CK7jRPd/AV36Wu0Z8c/zThZoTmTSL0e0S3ZWp2oxNpwwBVJGZWd
LJ/teDfKB0fj1IoG3MdiurtU5S5Dk8Z83ahNcthWINeL183JSTeA7qw3FiawTXiP
u2xQ5hq9nenUBy7F0S5MU1nyQrnGpraLzpY/UVEAeW1McZ6K/IAYB6O5hV30O7Cg
aup1oQEmIYM65/jHU0fgj1yBi39luLF/RQ0JKL5nV3YnAXZPyYVZWPaSyVb8C+xt
69QAaFnB/+rITWKMTlUURgPfSZ3xyp928Pg5lKOo0ogtFNA25FE=
=LSxC
-----END PGP SIGNATURE-----

--4Tos7O8I/5EpltQ3--
