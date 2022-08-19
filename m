Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 913E8599889
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 11:22:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348124AbiHSJTP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 05:19:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348118AbiHSJTL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 05:19:11 -0400
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1732213D5D
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 02:19:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=sang-engineering.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=k1; bh=4mInUs0MiLh5D3/6/SqoqclQnClY
        V6dFTGVPiVoQ3pw=; b=Ktvwwu36fJzB9ibA2wB8SPdGSDEeRiFAfqcm2U9wCt0I
        zVzYyweL0wysvXhmrVUvR0gO+PEuAs5+0OmakvOcWiX9R8/egsb2H04I4z9SyxNX
        Uea/CFe7XSUdPk5A74KZmRoFTm/C9fkoGGXd/YNICXv4UktTWNJKWH0pJSYHJ+A=
Received: (qmail 4189813 invoked from network); 19 Aug 2022 11:19:04 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 19 Aug 2022 11:19:04 +0200
X-UD-Smtp-Session: l3s3148p1@fcW1lpTmbtAgAwDtxwoDABxA2q3xYuRb
Date:   Fri, 19 Aug 2022 11:19:01 +0200
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        Divya Bharathi <divya.bharathi@dell.com>,
        Prasanth Ksr <prasanth.ksr@dell.com>,
        Henrique de Moraes Holschuh <hmh@hmh.eng.br>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Dell.Client.Kernel@dell.com,
        Thinkpad-acpi devel ML <ibm-acpi-devel@lists.sourceforge.net>
Subject: Re: [PATCH] platform: move from strlcpy with unused retval to strscpy
Message-ID: <Yv9VhdVXqXhONj41@shikoro>
Mail-Followup-To: Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        Divya Bharathi <divya.bharathi@dell.com>,
        Prasanth Ksr <prasanth.ksr@dell.com>,
        Henrique de Moraes Holschuh <hmh@hmh.eng.br>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Dell.Client.Kernel@dell.com,
        Thinkpad-acpi devel ML <ibm-acpi-devel@lists.sourceforge.net>
References: <20220818210058.7229-1-wsa+renesas@sang-engineering.com>
 <CAHp75VeM2q7wdnREoenyYpJ-tso2G6M-uyGFJGjPGL8hfUmzhQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="sN5ldFiA7r7yDUmT"
Content-Disposition: inline
In-Reply-To: <CAHp75VeM2q7wdnREoenyYpJ-tso2G6M-uyGFJGjPGL8hfUmzhQ@mail.gmail.com>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--sN5ldFiA7r7yDUmT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> I assume you are experimenting with coccinelle, so I have no objection
> to the change, but in PDx86 we usually want to have one patch per
> driver. Can you split?

I can split if you want.

I intentionally did group per subsystem, otherwise I would have sent out
1200+ patches. So, I chose to do it on subsystem level first and adapt
later where this scheme does not fit.

So, your choice.


--sN5ldFiA7r7yDUmT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmL/VYEACgkQFA3kzBSg
KbY2pxAAhGbToM1LnQiDvgw0ql7M12pchnfN2ASL2BD6Fz5lqxPsR5brI+YXQtr3
e9l1IuGMaV8FseagcmImqlTkjIR4DgFXIITcAq4bhK+ucXkSGcrU8hvVdfsWsS0w
VzPL7SbjlnWm3j5n4X8DsM65PJTfE9BzKpZlH6XylsvFPbt66roiee0ju66rD7OP
qEsS6Q9CYS9BKhbqz6p41NgeJ2p6SHs2Rdt8E9zhR5KWi2jHP396GYrOXqOuNF/f
r9e3/MTLFxU2yHkD3PGpMomEAAGOdhabmIr9Lbzn5VVIXhD81o5QJnJQQ2fGfDRg
bpPx4QpVCQips1trtW6P6FeMLauvHigAA7OtodrKy17iWJU+wwtWLc0jUIEkbmLs
A5UcWaawUTHnqU0jf8vrKxfyYyAVATtzwbjX+H7zUWZgPt+AyxWPUUNJs6rcTdfM
TeGsNkxFJjTBFOcjpY17p5gl9oQmVf3dxPI59Mnnhk3KrREA1wNvlhWMuKmi8adL
VaqSGfM5QdaQ06zSLOQCfXlVeubZuf42CkeUPVNBeYyy5r58bwrZ9SfiPSVxQ+ER
FxB8kKNMops38LSsqsd1XaB8Jq6Su8vrSnjf2jOjLwQBp4il1Ezx5sS4hBzTrytK
idaIrj6vacTvE3zTNX6rY747f/+kJwHSx3LwmIZvxpfliXkBpX4=
=okL7
-----END PGP SIGNATURE-----

--sN5ldFiA7r7yDUmT--
