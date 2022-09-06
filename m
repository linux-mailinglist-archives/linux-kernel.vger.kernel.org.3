Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62D8A5AF7F3
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 00:26:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230228AbiIFWZt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 18:25:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229995AbiIFWZ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 18:25:28 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 328586555A;
        Tue,  6 Sep 2022 15:24:50 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4MMg183B0Vz4xXS;
        Wed,  7 Sep 2022 08:24:44 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1662503085;
        bh=XzxkPfNC6fB8WXGwV1VRT//s4Ab8i65AuSr+Ty5+ric=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=nw6z3aS7Yr4mAsOzGeADQMMUe39Y6VgAWb7oHpRE8LeffCLV3KSX4G3Hbh0O3Tcbc
         p571PRJum+2SI2lc0hirknHNYjwfCnV6JMAyqjQZBzj45F3s50Chv8KRIMRPJwtTAP
         g2GSbOA4hEJLmvCc1yqBk3KiuKfLmklPZb5rG2SpP39N6KXF4C9XfWvGN0Y/lN918Q
         I/atlsZQD6jMFK0ZMX7kO/copjIxxp7n04OROLD45yAGRIOKd9HpnGbQ9HB61PhgKp
         008RuZMhc7QeS2VzH+Vg6MGioZbcKc0M7C4OLLzeCnMBrMmMcDSuaGTedWW8tIro4Y
         jGH1r7dm1HIOA==
Date:   Wed, 7 Sep 2022 04:05:29 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Rob Clark <robdclark@chromium.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Rob Clark <robdclark@gmail.com>,
        Sean Paul <seanpaul@chromium.org>, NeilBrown <neilb@suse.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the mm tree
Message-ID: <20220907040529.266d2d9c@canb.auug.org.au>
In-Reply-To: <CAJs_Fx5CPZRwWwV1=rG+kxx5JM1GWJG-uo-sZ-EdgqdSmNqJ3Q@mail.gmail.com>
References: <20220906210348.4744da42@canb.auug.org.au>
        <CAJs_Fx5CPZRwWwV1=rG+kxx5JM1GWJG-uo-sZ-EdgqdSmNqJ3Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/8tpvhNu0+quhb6SToc.wTUt";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/8tpvhNu0+quhb6SToc.wTUt
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Rob,

On Tue, 6 Sep 2022 05:05:32 -0700 Rob Clark <robdclark@chromium.org> wrote:
>
> It looks like, at least for now, I can replace `sc->gfp_mask &
> __GFP_ATOMIC` with `!(sc->gfp_mask & __GFP_DIRECT_RECLAIM)`.. I'm not
> sure if there would be any cases where we could otherwise sleep but
> __GFP_DIRECT_RECLAIM is not set?

The commit message for 9178e3dcb121 seems to say that would be correct.

--=20
Cheers,
Stephen Rothwell

--Sig_/8tpvhNu0+quhb6SToc.wTUt
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmMXi+kACgkQAVBC80lX
0GxyRAf/cvSPJDrnkrS18iOz+Gg2YEtwYL92Zb1K7onewzTaXGxWgC5hKSdd+Hvn
UHkScK+niw4xhLY+eGj70nbxyRlG5+wqFhebiEYFgZulSPwbsZ8B2H2CKmIfRW/c
2xlzoJWp8DrAMwoQHHu1TemxYI7NVdofwSAnz4qlWc7I5fytL0ZEnxS32tz8PlI5
iiahllsdGYN2iW26FR6iMI4ClzIOVzEg4s5d/hTw0zwanxd+kHwAKr2zmZsXD9NC
4FCaQPuL4xlcFE/5sRT3soSYmC6MbBV/gI11WEUwb7zYbeuEMm1cyd9eZTRSV1dW
uY/bfC2UlaZ+J+kePMWfaRfGJJoKuw==
=Idg9
-----END PGP SIGNATURE-----

--Sig_/8tpvhNu0+quhb6SToc.wTUt--
