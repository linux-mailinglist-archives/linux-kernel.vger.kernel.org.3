Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89852594F8A
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 06:27:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229810AbiHPE06 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 00:26:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230088AbiHPE0k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 00:26:40 -0400
Received: from shelob.surriel.com (shelob.surriel.com [96.67.55.147])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 261E4385CB8;
        Mon, 15 Aug 2022 18:05:25 -0700 (PDT)
Received: from imladris.surriel.com ([96.67.55.152])
        by shelob.surriel.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_ECDSA_WITH_AES_256_GCM_SHA384
        (Exim 4.95)
        (envelope-from <riel@shelob.surriel.com>)
        id 1oNl1D-0004Ma-AH;
        Mon, 15 Aug 2022 21:05:19 -0400
Message-ID: <823dd9856064cef2c7ced2cd4e9f45bf328ae6ef.camel@surriel.com>
Subject: Re: [PATCH RFC] fs,ipc: batch RCU synchronization in free_ipc
From:   Rik van Riel <riel@surriel.com>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-kernel@vger.kernel.org,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Alexey Gladkov <legion@kernel.org>, linux-fs@vger.kernel.org,
        kernel-team@fb.com
Date:   Mon, 15 Aug 2022 21:05:18 -0400
In-Reply-To: <Yvq9SmCUX/eeUuR1@ZenIV>
References: <20220815172620.5d7d4a78@imladris.surriel.com>
         <Yvq9SmCUX/eeUuR1@ZenIV>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-/ZCTgnkWfMwP/d/xAHHc"
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


--=-/ZCTgnkWfMwP/d/xAHHc
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2022-08-15 at 22:40 +0100, Al Viro wrote:
> On Mon, Aug 15, 2022 at 05:26:20PM -0400, Rik van Riel wrote:
> > TL;DR: it runs better than it looks, and I am looking for ideas on
> > how to make it look better
>=20
> > Unfortunately there seems to be a tradeoff between temporarily
> > allocating things on the stack, and having slightly uglier code,
> > or adding a struct rcu_work to the struct vfsmount.
> >=20
> > I am not entirely happy with the way this code looks, and hoping
> > for suggestions on how to improve it.
> >=20
>=20
> IMO you are going in wrong direction with that; it's a long story,
> and I've partial writeup on that, but I won't have it ready for
> posting until the end of the week.=C2=A0 Put it that way - there's
> a possibility of reorganizing the way mount refcounts work,
> eliminating this synchronize_rcu().=C2=A0 RCU delay still has to happen
> in some form, but we get smarter ways to wait for it.
>=20
I'm more than happy to abandon this approach.

I looked at this a bunch, and could not find a
nice way to do this the way the VFS currently
works, and am looking forward to getting this
done in a better way!


--=20
All Rights Reversed.

--=-/ZCTgnkWfMwP/d/xAHHc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEKR73pCCtJ5Xj3yADznnekoTE3oMFAmL67U4ACgkQznnekoTE
3oMsQAgAiKCh6xDIk+hCUi/SG7Bq3a52LS25pOY6jEhppRKChOkTcQ8hZGmi0VkC
O+Y7HZTKn8ZUhOAEUNCpt4+gUgOcGHK/7gZKSH4Ula/MOuDhEOHL1QV6hJHl/Ss/
DSig5WEhCGJJ++Qwa7S0BteI2OxaUTFTPDV4dRDlnUQUoddRG1qkTpTZgdwVjNwZ
ajd1Zn6aQdoKEb4w/G9iwVaUNU70hZ/LBZo31XlSp3/kFa0yUpl9BTMxwWDA3xH9
kmQfaTpmRGzNJJlpWnAH22zHoFz+Uy9zPSMyxkBkG9g4Osf2yjo/XD4JOlfdX/w1
f/7aSY0ti83m/JD6rzsr6BkYxkAw0A==
=wMaA
-----END PGP SIGNATURE-----

--=-/ZCTgnkWfMwP/d/xAHHc--
