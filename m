Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1BB04E9275
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 12:24:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240216AbiC1K0U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 06:26:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240202AbiC1K0T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 06:26:19 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F15635260
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 03:24:37 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1nYmY1-0003iM-9k; Mon, 28 Mar 2022 12:24:29 +0200
Received: from pengutronix.de (2a03-f580-87bc-d400-accf-b53a-6e18-7f7d.ip6.dokom21.de [IPv6:2a03:f580:87bc:d400:accf:b53a:6e18:7f7d])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 84729554F2;
        Mon, 28 Mar 2022 10:09:27 +0000 (UTC)
Date:   Mon, 28 Mar 2022 12:09:27 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Peter Hurley <peter@hurleysoftware.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Esben Haabendal <esben@geanix.com>,
        Steven Walter <stevenrwalter@gmail.com>,
        linux-kernel@vger.kernel.org,
        Oleksij Rempel <o.rempel@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        =?utf-8?B?QW5kcsOp?= Pribil <a.pribil@beck-ipc.com>,
        Tejun Heo <tj@kernel.org>, Jiri Slaby <jirislaby@kernel.org>,
        linux-rt-users@vger.kernel.org
Subject: Re: [RFC PATCH 0/2] RT scheduling policies for workqueues
Message-ID: <20220328100927.5ax34nea7sp7jdsy@pengutronix.de>
References: <20220323145600.2156689-1-linux@rasmusvillemoes.dk>
 <YkGIhYKJG+w4L7ge@linutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="sxi5n6s7wqxpvtgc"
Content-Disposition: inline
In-Reply-To: <YkGIhYKJG+w4L7ge@linutronix.de>
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--sxi5n6s7wqxpvtgc
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 28.03.2022 12:05:57, Sebastian Andrzej Siewior wrote:
> On 2022-03-23 15:55:58 [+0100], Rasmus Villemoes wrote:
> > This RFC is motivated by an old problem in the tty layer. Ever since
> > commit a9c3f68f3cd8 (tty: Fix low_latency BUG), use of UART for
> > real-time applications has been problematic. Even if both the
> > application itself and the irq thread are set to SCHED_FIFO, the fact
> > that the flush_to_ldisc work is scheduled on the generic and global
> > system_unbound_wq (with all workers running at normal scheduling
> > priority) means that UART RX can suffer unbounded latency.
>=20
> Having a kthread per "low-latency" tty instance is something I would
> prefer. The kwork corner is an anonymous worker instance and probably
> does more harm than good. Especially if it is a knob for everyone which
> is used for the wrong reasons and manages to be harmful in the end.
> With a special kthread for a particular tty, the thread can be assigned
> with the desired priority within the system and ttyS1 can be
> distinguished from ttyS0 (and so on). This turned out to be useful in a
> few setups over the years.

+1

The networking subsystem has gone the same/similar way with NAPI. NAPI
handling can be switched from the softirq to kernel thread on a per
interface basis.

regards
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--sxi5n6s7wqxpvtgc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEBsvAIBsPu6mG7thcrX5LkNig010FAmJBiVQACgkQrX5LkNig
013kAgf/XgFTUqoCWgqZFouYS5Twgl7e1Fy/YTn0pXsn3bq6D+WZBLG7yfmrafoe
VYX5Hg2nFO8YXJEbMCi1mRT7KFjz0s4JlmqVSqK8Pp/2Mt6g4Hw+oT8TDGh7Pirg
Dh607CZuRPf2SgLr5qSxpX2DA/9KvkvselhAh5X2jFv2p67vOWQGh3fp/xg3L2V3
aMTBIsLxGtciaMmlb3uwPzSQV/+oJZwIGwbRiMbJSHrVuFTceUTLQXF8JkPNcYX5
T28BIEOnRgz8IwDNwl9Z+zihlYj82teBCEHTmaNEpBX3te0R51MCPHwKwxXn+G20
+a5sG1rIKrIJ0MSyskiwzfvylsooSw==
=HKoZ
-----END PGP SIGNATURE-----

--sxi5n6s7wqxpvtgc--
