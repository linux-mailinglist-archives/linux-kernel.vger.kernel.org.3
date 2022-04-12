Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9530B4FDE30
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 13:44:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347561AbiDLLlY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 07:41:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352602AbiDLLht (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 07:37:49 -0400
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DF33219
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 03:17:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=sang-engineering.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=k1; bh=lvq+dp4SVUtTyznMC+oj6omSMZVw
        vOhhf9wU8J4aQDE=; b=A6Lw9TJ9/QI4XkB6TOnlYq7CIB/RLS+HWw/twpb9Zw+v
        FzkUG2HK4vfHcvgX1smi8GNEoR7gTXJTLpPlBaZzZV5hicYgPeDaJX0nfByEbyqY
        peYG2jDxm/N4AJT5+RJddfXMkzENJGbChSi3wic7NVKLEue0Y7bbV7/XtPLgXRc=
Received: (qmail 995989 invoked from network); 12 Apr 2022 12:17:39 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 12 Apr 2022 12:17:39 +0200
X-UD-Smtp-Session: l3s3148p1@TKDcXnLczOcgAQnoAGZ4AFi7qjeMIP6q
Date:   Tue, 12 Apr 2022 12:17:39 +0200
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Sergey Shtylyov <s.shtylyov@omp.ru>,
        Duc Nguyen <duc.nguyen.ub@renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Andrew Gabbasov <andrew_gabbasov@mentor.com>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        MTD Maling List <linux-mtd@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] memory: renesas-rpc-if: Simplify single/double data
 register access
Message-ID: <YlVRw4ypp3+0Miz3@ninjato>
Mail-Followup-To: Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Sergey Shtylyov <s.shtylyov@omp.ru>,
        Duc Nguyen <duc.nguyen.ub@renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Andrew Gabbasov <andrew_gabbasov@mentor.com>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        MTD Maling List <linux-mtd@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <19358863deae03b1b26f473e878305a1c6e40d19.1649681638.git.geert+renesas@glider.be>
 <YlVJc3z1xXT2emIc@ninjato>
 <CAMuHMdUGkba3hiRJPEw26oBdc6_MK_eBO==Z9QeinaoeZv8Qbw@mail.gmail.com>
 <YlVLEnRaARVmWZnZ@ninjato>
 <CAMuHMdWAQ08K6NCdBGrY+-vBrsTQHi6UHaER4eCON1t9JEG1RA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="+PJSAI9U9iARmGKo"
Content-Disposition: inline
In-Reply-To: <CAMuHMdWAQ08K6NCdBGrY+-vBrsTQHi6UHaER4eCON1t9JEG1RA@mail.gmail.com>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--+PJSAI9U9iARmGKo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> But that's not what happened. I even compared the assembler output of
> various solutions.

I am sure you did. I just said "it looks like..." to state a reason why
I don't think it looks prettier. But this turns to bike-shedding for me,
just keep it if everyone else is happy.


--+PJSAI9U9iARmGKo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmJVUb8ACgkQFA3kzBSg
KbYFtxAAnMVfoYwfPBsJgmeGyalXpEG+cLcE1gOTw7oMGiHPxT6foxFB9GZBW7m0
ZnqughRm+tMhzFvb/sHwI/W9m1dP1g4+U7OZQYiVFCGo5Dqgl2QADwU1kVZAgTl4
tXz3W4VdX80rOI4bhLPopQ72Z/GmTlxedu6HpjPz57LF2YRDioL7DO9j9V1O9QSz
knPl1Jz9+rPxBXtJ+CW5/WfJ7hL6U8LA4D6BCFHfEI+xH9AjWEOCIFRSHiV2QDHY
mV9AuEDbto6Fw3iSSebi4SgkzYE3h0/jNTbHE8jYuZiZ03U5f+d9q5ixldnC5Ljq
ec9MVbB8VAoPAjN8XV1pP5c+n07xMQjNRchEzKem4b1jNkSWAZnMpUuaJCJnxk1e
MkZgFSDM6EuGlYGuV+A9JrkidHzdUzwsq8o4JwjEN3st+Tj5yOFL1M+iiFjxCzMo
hngWeRHxhI2gJf6RrLJYIudbN6koKPH9QzNikyaIYkz3hAdGHgPDHiUw1tTfFovO
0wWCJbBLVJ5Z1RWiPdRDwl/KPWr9/pWrlNQngPX8NHLCAwUzCicCt4ChJduPDcMt
YLd0v6VG/5TBRfHSuSfjOk0b3ItOZ4QjleYBhbQQ5VAAyEKHuZzXUqFGYCVhPT5M
DT67uH1tS9STOUFxUT6af4DGGzz5oTRI+mvXFqIOtzdDR2+azj8=
=ALuo
-----END PGP SIGNATURE-----

--+PJSAI9U9iARmGKo--
