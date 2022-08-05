Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 498B258AB15
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 14:54:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240648AbiHEMyC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Aug 2022 08:54:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233191AbiHEMyA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Aug 2022 08:54:00 -0400
Received: from shelob.surriel.com (shelob.surriel.com [96.67.55.147])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BF1BB0E
        for <linux-kernel@vger.kernel.org>; Fri,  5 Aug 2022 05:53:59 -0700 (PDT)
Received: from imladris.surriel.com ([96.67.55.152])
        by shelob.surriel.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_ECDSA_WITH_AES_256_GCM_SHA384
        (Exim 4.95)
        (envelope-from <riel@shelob.surriel.com>)
        id 1oJwpn-0003u6-On;
        Fri, 05 Aug 2022 08:53:47 -0400
Message-ID: <2239a6e4f5e9d12ef7a55da6dba716df681201ff.camel@surriel.com>
Subject: Re: [PATCH v2]  x86,mm: print likely CPU at segfault time
From:   Rik van Riel <riel@surriel.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Dave Hansen <dave.hansen@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com,
        Thomas Gleixner <tglx@linutronix.de>, Dave Jones <dsj@fb.com>,
        Andy Lutomirski <luto@kernel.org>
Date:   Fri, 05 Aug 2022 08:53:46 -0400
In-Reply-To: <YuzsJfHi+qV6Z16E@zn.tnic>
References: <20220804155450.08c5b87e@imladris.surriel.com>
         <YuzsJfHi+qV6Z16E@zn.tnic>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-0gZB6DDT4tgz7xGj3x7u"
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


--=-0gZB6DDT4tgz7xGj3x7u
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2022-08-05 at 12:08 +0200, Borislav Petkov wrote:
> On Thu, Aug 04, 2022 at 03:54:50PM -0400, Rik van Riel wrote:
> > Add a printk() to show_signal_msg() to print the CPU, core, and
> > socket
> > at segfault time. This is not perfect, since the task might get
> > rescheduled
> > on another CPU between when the fault hit, and when the message is
> > printed,
> > but in practice this has been good enough to help us identify
> > several bad
> > CPU cores.
> >=20
> > segfault[1349]: segfault at 0 ip 000000000040113a sp
> > 00007ffc6d32e360 error 4 in segfault[401000+1000] on CPU 0 (core 0,
> > socket 0)
>=20
> And what happens when someone is looking at this, the CPU information
> is
> wrong because we got rescheduled but...
>=20
> ... someone is missing this important tidbit here that the CPU info
> above is unreliable?
>=20
> Someone is sent on a wild goose chase.
>=20
We have been using this patch for the past year, and it
does not appear to be an issue in practice.

When a faulty CPU core causes tasks to segfault, we
typically see >95% of the errors printed for the CPU
core that is bad, and only a few on other CPUs.

Those other CPU cores tend to be inside the same physical
chip too, so they get replaced at the same time.

CPU failures tend to be oddly specific, often leading to
dozens (or hundreds) of segfaults in bash or python for=C2=A0
some particular script, while the main workload on the=C2=A0
system continues running without issues.

Having a small percentage of the segfaults show up on
cores other than the broken one does not cause issues with
detection or diagnosis.

> Can't you read out the CPU number before interrupts are enabled and
> hand
> it down for printing?
>=20
We could, but then we would be reading the CPU number
on every page fault, just in case it's a segfault.

That does not seem like a worthwhile tradeoff, given
how much of a hot path page faults are, and how rare
segfaults are.

Furthermore, we still have the possibilities that a thread
on one CPU crashes because another, faulty CPU scribbled
over its data, or that a thread is preempted and migrated
while still in userspace in-between deciding on a bad address
and accessing it.

I'm willing to be convinced otherwise, but staying out of
the hot path for something so rare seems like a typical
thing to do?

--=20
All Rights Reversed.

--=-0gZB6DDT4tgz7xGj3x7u
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEKR73pCCtJ5Xj3yADznnekoTE3oMFAmLtEtoACgkQznnekoTE
3oO2Pgf8DdllVYI1zDUtp9HkhV1+V2oUpJoKZlaWUYVw0NhWCO45RZgXJ1twmajy
gJVXJB9hW92grvLGwqfS7EEJjTM3A+RhqBXrTuwfHYktbjG8UA7CeafNB2nVZahD
t5FVNafN95f/xSrJXHAZFEmZh7NL3G/QJH3uMIdyTA0NIMwR1+LjoQT/414F1MVW
gJVcwldx7Y8Y8HZUM38/6qJxGHixcbZIwfOR2GDrMJ4IJv21ectZc/drMr88U5Jl
RCIfYttn4UJfRDh4lfIn//KAmxNJaUCznP/5u1YDTqeg3R7Zb5S3ykeTmA4/Rand
hDt1VGpXWpyGWhb6i2v/gjZ/M48n0g==
=uwBO
-----END PGP SIGNATURE-----

--=-0gZB6DDT4tgz7xGj3x7u--
