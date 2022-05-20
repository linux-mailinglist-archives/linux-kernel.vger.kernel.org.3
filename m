Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E130A52F006
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 18:06:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351329AbiETQGr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 12:06:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351323AbiETQGp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 12:06:45 -0400
Received: from shelob.surriel.com (shelob.surriel.com [96.67.55.147])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C27E1737DC
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 09:06:44 -0700 (PDT)
Received: from imladris.surriel.com ([96.67.55.152])
        by shelob.surriel.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_ECDSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <riel@shelob.surriel.com>)
        id 1ns598-0001eJ-0c; Fri, 20 May 2022 12:06:34 -0400
Message-ID: <7c57004c1f9a2580b34ea6708065260ec2706122.camel@surriel.com>
Subject: Re: [RFC PATCH v2] printk: console: Allow each console to have its
 own loglevel
From:   Rik van Riel <riel@surriel.com>
To:     Chris Down <chris@chrisdown.name>, linux-kernel@vger.kernel.org
Cc:     Petr Mladek <pmladek@suse.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>, kernel-team@fb.com
Date:   Fri, 20 May 2022 12:06:33 -0400
In-Reply-To: <YoeQLxhDeIk4VSmx@chrisdown.name>
References: <YoeQLxhDeIk4VSmx@chrisdown.name>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-ubMqwuwXY5KJJLvOxJq9"
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


--=-ubMqwuwXY5KJJLvOxJq9
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2022-05-20 at 13:57 +0100, Chris Down wrote:
> [Once the goals of this patch are generally agreed upon, it can be
> split
> out further with more detailed changelogs if desired.]
>=20
> Consoles can have vastly different latencies and throughputs. For
> example, writing a message to the serial console can take on the
> order
> of tens of milliseconds to get the UART to successfully write a
> message.
> While this might be fine for a single, one-off message, this can
> cause
> significant application-level stalls in situations where the kernel
> writes large amounts of information to the console.
>=20
It's more than just application-level stalls. I have seen
some cases of the kernel spending so much time logging things
to serial console that it thinks it locked up, and panics as
a result of how slow the serial console is.

Adding insult to injury, because the log level is sytem wide,
we only see _some_ of the hints of why the kernel started
spewing like that in the netcons logs.

If we print all the information, we will have more hosts panic
because we spent too much time in the serial console code.

If we print less information, we won't find out some of the
other things causing issues on systems.

Having per console log levels will allow us to avoid the
serial console issues, and gather all the info we need on
other stuff happening on the system.

--=20
All Rights Reversed.

--=-ubMqwuwXY5KJJLvOxJq9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEKR73pCCtJ5Xj3yADznnekoTE3oMFAmKHvIkACgkQznnekoTE
3oPluwgAgd1aI2eHB0PNcmJzACgNDCZRTTPFVakAgsImqCCrJ5IUkquQso2VAXZU
bE4ElQQWEuXwJaPbR/vQprD6619dmVjObAabS/plvaba1WhxGVp/qdFMbqCPI/QI
At21/ar8mC65RK/gdV4h/7FRMhd85AfpXGXVfuW1Fq5mpGMG00Gtwp4EtkCJV8nh
MqJHM2pJK9vY0jZAEGECX3Oj9XpZKAhf5W/ldt5n794LAf56GbnTmHyFwPd78YjY
cfAFmJ0/SLg2x5znMLt5sJAcvEMhzZz6zAR2IdsNyxlb9nmtoCnCNdtsqdIkiibj
LbPSGBM/WcHG4trXnJZWYJOUts5PtQ==
=pfnw
-----END PGP SIGNATURE-----

--=-ubMqwuwXY5KJJLvOxJq9--
