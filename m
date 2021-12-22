Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3238D47D289
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 13:58:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245068AbhLVM6b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 07:58:31 -0500
Received: from www.zeus03.de ([194.117.254.33]:44762 "EHLO mail.zeus03.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240607AbhLVM63 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 07:58:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=sang-engineering.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=k1; bh=1nIjg3+81S8PpIpyM/622UZk5jW8
        luO276mlBCCaRH0=; b=k58GqFsJm7Jol5kpL42DPmyYaeBhfdWtkophTQQ75lgW
        fcs4OCEtq0QMWgjCtTl7LHj7gXsFXwO1G28KH+eWX/RArHbYZCmUtaiiLHq05b7b
        tv8B+oeDCfBJutQr7H6ewMqa4SYBzstQOTDy2I5DbOpy9iV+6LtoAVFZFQD0JnQ=
Received: (qmail 1769551 invoked from network); 22 Dec 2021 13:58:27 +0100
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 22 Dec 2021 13:58:27 +0100
X-UD-Smtp-Session: l3s3148p1@KgpYrbvTiMYgAQnoAE7AABWUu3WTN36y
Date:   Wed, 22 Dec 2021 13:58:24 +0100
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v6 1/1] gpio: add sloppy logic analyzer using polling
Message-ID: <YcMg8NzjlNDLksNT@ninjato>
Mail-Followup-To: Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20211219132442.4080-1-wsa+renesas@sang-engineering.com>
 <20211219132442.4080-2-wsa+renesas@sang-engineering.com>
 <CAMuHMdVh60ocfzkJKz8zR1hODr8SWp=sbyHrR3KGx2ntLmuFGQ@mail.gmail.com>
 <YcL7p5nzZs8vnojl@shikoro>
 <CAMuHMdXn-cmK1HewukjOnjC1JEgfFfH7FW23YvPTKHcNCiet2w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="88VcK3OE27ZRg7Tw"
Content-Disposition: inline
In-Reply-To: <CAMuHMdXn-cmK1HewukjOnjC1JEgfFfH7FW23YvPTKHcNCiet2w@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--88VcK3OE27ZRg7Tw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> > Yes, the search engines helped[1]. I run a minimal system, so when I
> > mount cpusets, it will actually mount cgroups with a default mount
> > option of "noprefix". But you likely run a rootfs with cgroups already,
> > so it gets mounted directly without "noprefix". Then, when the logic
> > analyzer tries to mount again, the implied default "noprefix" is
> > discarded.
>=20
> Yeah, systemd on Debian has it mounted.

So, the proper solution is to use/mount 'cgroups2' instead of 'cpuset'.
But this needs more thinking and testing and, thus, another revision.
Dunno if I can make it this year, so I am probably going to miss the
next merge window after all :(

Geert, if you still want to test the PFC patch I sent, then this patch
for the script should get you going:

diff --git a/tools/gpio/gpio-sloppy-logic-analyzer b/tools/gpio/gpio-sloppy=
-logic-analyzer
index eb2065fe6733..f1bfdd3568cf 100755
--- a/tools/gpio/gpio-sloppy-logic-analyzer
+++ b/tools/gpio/gpio-sloppy-logic-analyzer
@@ -80,13 +80,13 @@ init_cpu()
 	mount | grep -q $cpusetdir || mount -t cpuset cpuset $cpusetdir
 	[ -d "$lacpusetdir" ] || mkdir "$lacpusetdir"
=20
-	cur_cpu=3D"$(cat "$lacpusetdir"/cpus)"
+	cur_cpu=3D"$(cat "$lacpusetdir"/cpuset.cpus)"
 	[ "$cur_cpu" =3D "$isol_cpu" ] && return
 	[ -z "$cur_cpu" ] || fail "CPU$isol_cpu requested but CPU$cur_cpu already=
 isolated"
=20
-	echo "$isol_cpu" > "$lacpusetdir"/cpus || fail "Could not isolate CPU$iso=
l_cpu. Does it exist?"
-	echo 1 > "$lacpusetdir"/cpu_exclusive
-	echo 0 > "$lacpusetdir"/mems
+	echo "$isol_cpu" > "$lacpusetdir"/cpuset.cpus || fail "Could not isolate =
CPU$isol_cpu. Does it exist?"
+	echo 1 > "$lacpusetdir"/cpuset.cpu_exclusive
+	echo 0 > "$lacpusetdir"/cpuset.mems
=20
 	oldmask=3D$(cat /proc/irq/default_smp_affinity)
 	newmask=3D$(printf "%x" $((0x$oldmask & ~(1 << isol_cpu))))
@@ -213,7 +213,7 @@ if [ -n "$triggerdat" ]; then
 	printf "$trigger_bindat" > "$lasysfsdir"/trigger 2>/dev/null || fail "Tri=
gger data '$triggerdat' rejected"
 fi
=20
-workcpu=3D$(cat "$lacpusetdir"/effective_cpus)
+workcpu=3D$(cat "$lacpusetdir"/cpuset.effective_cpus)
 [ -n "$workcpu" ] || fail "No isolated CPU found"
 cpumask=3D$(printf '%x' $((1 << workcpu)))
 instance=3D${lasysfsdir##*/}


--88VcK3OE27ZRg7Tw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmHDIOwACgkQFA3kzBSg
KbYTQxAAg4lBRLmsgJwsKmT7aqv9a24V8wcazaw2rI1QhCx34BgfxAko/CgO7Tah
mny71vhIk+cSKdkBMnXU2gTG2V7Dx6kb5XVI9IXTIc1PBnJ/syS1M1ao8QmGenkK
+lp+NBQT+lCcgPVOHP36Er9G5CG+yn4NH4VK1mT53d63KsdGyUGCi0xyB01tSwNl
vok6xNZFksOvzWivCd7HKEVK26pK8gDYkFOrVwVx7clgAIOMurZTtEWI+ejNB11s
DJx0kQl6ouOh0B7VZndGEQTvoOwR6hCWJ3R32z61sMO4h5hQIMfEznAVTiBRqNqQ
2z1pzbwNq10kkQIyAKeOotxOuHzVdsZ5/yXl4JJUdn8rxxBhJXlMggAjYfKST3Qd
pL3xcZeC+kIYiNP/QWgO5M2n+x3SFChY/jbAmUXw0N+3XL/K+6nCeMhcKLxfK+/A
8Zpgzxd3rMbfFzg5A8TIuCojorgpKQ9XEuKbmJdu7KW2MlHiHqqTjI/kjinvjkbw
Hqr7MkoC9QgUBZU/LmfFVV/NG4DVFhGHRVTNaOif5Tj7jx/p+daRYox7z8thMvDl
vse5sBH0kulMdvSynvUNceKhk/tzJ/pvTYNTtyj/5Huywv9W1satgpRQbcy3V3or
9MT+wpYFLq4SY39+/6xNgPv6sVAU/M4bUv2t/r4wR1EOcMIsYy0=
=T8QE
-----END PGP SIGNATURE-----

--88VcK3OE27ZRg7Tw--
