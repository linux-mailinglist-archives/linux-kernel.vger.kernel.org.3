Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87EDA58CCA9
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 19:25:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236872AbiHHRY6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 13:24:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243226AbiHHRY4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 13:24:56 -0400
Received: from shelob.surriel.com (shelob.surriel.com [96.67.55.147])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE020167EB
        for <linux-kernel@vger.kernel.org>; Mon,  8 Aug 2022 10:24:55 -0700 (PDT)
Received: from imladris.surriel.com ([96.67.55.152])
        by shelob.surriel.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_ECDSA_WITH_AES_256_GCM_SHA384
        (Exim 4.95)
        (envelope-from <riel@shelob.surriel.com>)
        id 1oL6Ue-0008EX-LY;
        Mon, 08 Aug 2022 13:24:44 -0400
Message-ID: <06dc568d91979a3816af602a00884560cb5ec026.camel@surriel.com>
Subject: Re: [RFC PATCH 5/5] x86/entry: Store CPU info on exception entry
From:   Rik van Riel <riel@surriel.com>
To:     Dave Hansen <dave.hansen@intel.com>,
        Ingo Molnar <mingo@kernel.org>,
        Ira Weiny <ira.weiny@intel.com>,
        Andy Lutomirski <luto@kernel.org>
Cc:     Borislav Petkov <bp@alien8.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com
Date:   Mon, 08 Aug 2022 13:24:43 -0400
In-Reply-To: <01768c70-a012-0d08-cfa5-a7a87ff0a19c@intel.com>
References: <20220805173009.3128098-1-ira.weiny@intel.com>
         <20220805173009.3128098-6-ira.weiny@intel.com>
         <5d62c1d0-7425-d5bb-ecb5-1dc3b4d7d245@intel.com>
         <Yu4t0jkpIY4grgxL@gmail.com> <Yu4wON0MRGH7h5Jv@zn.tnic>
         <Yu+Nwbn4CZUmyD14@gmail.com> <Yu+VV8xFTYRh0D0a@zn.tnic>
         <YvAaXet3sBg3mRDe@iweiny-desk3> <YvDtfKRyMGenRMU5@gmail.com>
         <01768c70-a012-0d08-cfa5-a7a87ff0a19c@intel.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-zLfyIRf1FZ4PsR+JaPBx"
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


--=-zLfyIRf1FZ4PsR+JaPBx
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2022-08-08 at 09:16 -0700, Dave Hansen wrote:
> On 8/8/22 04:03, Ingo Molnar wrote:
> > > Again, I don't believe this is too much overhead but I don't want
> > > people=20
> > > to say it was not discussed.
> > Is it necessary to do this, what are the alternatives, can this
> > overhead be=20
> > avoided?
>=20
> I'm thinking that the whole racy smp_processor_id() thing wasn't so
> bad
> in the first place.
>=20

FWIW, just grabbing the CPU number in show_signal_msg()
appears to be good enough for our use.=C2=A0

It will typically show >90% of the errors happening on the
CPU core that went bad, which is more than enough to diagnose=C2=A0
that a server has a hardware issue and should probably have
the CPU repaired.

--=20
All Rights Reversed.

--=-zLfyIRf1FZ4PsR+JaPBx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEKR73pCCtJ5Xj3yADznnekoTE3oMFAmLxRtsACgkQznnekoTE
3oPpIQf+M/woay+5/L9lVOq1s9YMpVHckK1DzaJLC9heGr3jDjMXrt9zJYouu2M9
p46Sylwg7nU4zxMKPfV4NMIHd+kDYK73jmF41Ypnm5lbtk+Z6LA/qNElmTlWF3I2
xZA1jpA5KarA+l/9vSdQyfcIJIo8xKxYDV8MLPEoX0EBZh5JA25rUH6dxPn3Rtjd
0DR8namlwZpkkWiWOp3ZzaYFqh0azwQLnrB56hVjHU3ckKunY7nEmn70cWnV9+7d
/RSpDNG5MBLs1SFWebF1oWzhbv4XqNMr4KpI6HDVTYw1PmX7uw/G1KzHE7H558Fk
KAZc0I/0VuzunNoBWPSEgjfoUCURTw==
=gGXL
-----END PGP SIGNATURE-----

--=-zLfyIRf1FZ4PsR+JaPBx--
