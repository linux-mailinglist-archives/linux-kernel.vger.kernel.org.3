Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2D4647CFD4
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 11:19:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244115AbhLVKTW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 05:19:22 -0500
Received: from www.zeus03.de ([194.117.254.33]:44918 "EHLO mail.zeus03.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236558AbhLVKTU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 05:19:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=sang-engineering.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=k1; bh=R5JyNbV41eVlN2rpLYyTGZBmbf0D
        gJKsxksorKk3WpM=; b=D1Ru1GyHecO5uI+4F743tKOu7AkcOEvxiZCU2kE0y++K
        dYhZsOIfjDoa6PlviH23EVg4EvjZwaYoa3o2V2DIAaJjUps3x5vvwDNEum4H++Y8
        UQ8sGrPmAsO03P7wlwnvHZjIK6R7Er4ZCSVFFp/p72L6Sh2J2yCBjySBhgJb2V4=
Received: (qmail 1711019 invoked from network); 22 Dec 2021 11:19:19 +0100
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 22 Dec 2021 11:19:19 +0100
X-UD-Smtp-Session: l3s3148p1@Vz9rdLnTYLYgAQnoAFCUAc+q0T6Ni/m/
Date:   Wed, 22 Dec 2021 11:19:19 +0100
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v6 1/1] gpio: add sloppy logic analyzer using polling
Message-ID: <YcL7p5nzZs8vnojl@shikoro>
Mail-Followup-To: Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20211219132442.4080-1-wsa+renesas@sang-engineering.com>
 <20211219132442.4080-2-wsa+renesas@sang-engineering.com>
 <CAMuHMdVh60ocfzkJKz8zR1hODr8SWp=sbyHrR3KGx2ntLmuFGQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="1KCfx6qEZh2LZMVG"
Content-Disposition: inline
In-Reply-To: <CAMuHMdVh60ocfzkJKz8zR1hODr8SWp=sbyHrR3KGx2ntLmuFGQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--1KCfx6qEZh2LZMVG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> Anyone with a clue? Thanks!

Yes, the search engines helped[1]. I run a minimal system, so when I
mount cpusets, it will actually mount cgroups with a default mount
option of "noprefix". But you likely run a rootfs with cgroups already,
so it gets mounted directly without "noprefix". Then, when the logic
analyzer tries to mount again, the implied default "noprefix" is
discarded.

[1] https://cgroups.vger.kernel.narkive.com/20fAhMNN/noprefix-mount-option

So, I will update the script to mount "cgroups" instead of "cpuset" and
use the newer filenames instead. This seems to be the proper way.

Thanks for testing, Geert!


--1KCfx6qEZh2LZMVG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmHC+6YACgkQFA3kzBSg
KbYZ/hAAhaxLkQWTonCJs1G98B3/mfZNfYHQDq+pWhpe7vyBmMo7ah1mAaqRnP/a
c6hXnhvMchXz0jsJUEMi6PVYN46QZsBXJYsCTMvWeBiiKYFEZgJTrDSwMpU6cQXj
ZJ4bq/1EI00d3jlITnMs1BJPjo9jvgJgJ7L0pULBxg9U9z/3d8qnwfRg5/uF4f3E
y6f/ogbv6QCqiOXBwz3e7esIfICuYJrU/4jFhl52TKUEITCdYrujdcpc19vF9NG+
gB4Tvbds81QbE7vL0yzMNlV/8kk0iG/nEylxBr/8C6UQ0TdlSpXc+CekrFkaWyrn
wgyj5L2hp5inLhTGyWr3QLi9GKpgs2+Uy6VS0HhDLD3AISMfGRS96AhlnaLQ2vWj
mC6o0AdWqJh64P+SpeWhND9/SgcFneTw/rGyvlCGnI2ohS8GrkrFnyGDyvVjKt/9
K9Y6licQti5S3JMNh26+P2Jbkoamhe/PGdb3RSOWPPd3YuAWUknAb10iKPqHjAvG
mML6xLdEeeItxsQXCelnTbLUaIqC3s6QtiOWLEHRnrXwif/oq1PljOWQZ6GFzK/A
u3ce9zKci9vp+PDYGoChRQWEk/PQ6/vRlBAhJSHASnuRU/2rjXVaq5Wxlwic6aJJ
izl120QmSEIiuIctzC0DhfQhHkjUZDok1WOTSBzLXK8wLziMw4s=
=W980
-----END PGP SIGNATURE-----

--1KCfx6qEZh2LZMVG--
