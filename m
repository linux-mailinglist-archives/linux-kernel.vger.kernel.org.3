Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CE274CB847
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 09:05:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230491AbiCCIFk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 03:05:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229620AbiCCIFi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 03:05:38 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4950316F946;
        Thu,  3 Mar 2022 00:04:53 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4K8NnH3yKyz4xbw;
        Thu,  3 Mar 2022 19:04:51 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1646294692;
        bh=7S/eUg9H+1XBZgWh+Ph/h9XWDRoI6irlzEzEdjOtZAM=;
        h=Date:From:To:Cc:Subject:From;
        b=JTDhKOB3AbmuGOIRqBygHpDGCfG9ig1RM6iMMuE4AFeaTB6x3D+NebS8OmAzKlTz0
         yytwnEBiq9zKKJXcpQpZ7QLREALLB4Qni9TzPxrWjyqXzZmWwa+U1B+1JYh7jMU9zU
         v9CXFPDnucQuT/TeEL0gDPuM+cejbcN1lrrisIDDE+lNQuJuhhAwmNFXdvwula3Pxu
         eSkT2onKZ4EuOJ4kQPsPS8hS3zvxVd/pF4Kjx8oER5jG/nJXdsn4RBl9TVyXCrtjpn
         jymKqS4zFdRv4qbaJ4+5q3XNCmzh0p1KkzNonuzMaOiD4r3sK+DlGGdLyTDH6+d+q9
         bFMNL0xgm7UNg==
Date:   Thu, 3 Mar 2022 19:04:50 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Theodore Ts'o <tytso@mit.edu>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the random tree
Message-ID: <20220303190450.18626eea@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/.J72ZladJUcMmD1folqTPeK";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/.J72ZladJUcMmD1folqTPeK
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the random tree, today's linux-next build (arm64 defconfig)
failed like this:

In file included from include/linux/srcu.h:49,
                 from include/linux/notifier.h:16,
                 from include/linux/random.h:10,
                 from arch/arm64/include/asm/pointer_auth.h:7,
                 from arch/arm64/include/asm/processor.h:43,
                 from include/linux/mutex.h:19,
                 from include/linux/kernfs.h:11,
                 from include/linux/sysfs.h:16,
                 from include/linux/kobject.h:20,
                 from include/linux/of.h:17,
                 from include/linux/irqdomain.h:35,
                 from include/linux/acpi.h:13,
                 from include/acpi/apei.h:9,
                 from include/acpi/ghes.h:5,
                 from include/linux/arm_sdei.h:8,
                 from arch/arm64/kernel/asm-offsets.c:10:
include/linux/srcutree.h:67:22: error: field 'srcu_cb_mutex' has incomplete=
 type
   67 |         struct mutex srcu_cb_mutex;             /* Serialize CB pre=
paration. */
      |                      ^~~~~~~~~~~~~
include/linux/srcutree.h:69:22: error: field 'srcu_gp_mutex' has incomplete=
 type
   69 |         struct mutex srcu_gp_mutex;             /* Serialize GP wor=
k. */
      |                      ^~~~~~~~~~~~~
include/linux/srcutree.h:80:22: error: field 'srcu_barrier_mutex' has incom=
plete type
   80 |         struct mutex srcu_barrier_mutex;        /* Serialize barrie=
r ops. */
      |                      ^~~~~~~~~~~~~~~~~~
In file included from include/linux/random.h:10,
                 from arch/arm64/include/asm/pointer_auth.h:7,
                 from arch/arm64/include/asm/processor.h:43,
                 from include/linux/mutex.h:19,
                 from include/linux/kernfs.h:11,
                 from include/linux/sysfs.h:16,
                 from include/linux/kobject.h:20,
                 from include/linux/of.h:17,
                 from include/linux/irqdomain.h:35,
                 from include/linux/acpi.h:13,
                 from include/acpi/apei.h:9,
                 from include/acpi/ghes.h:5,
                 from include/linux/arm_sdei.h:8,
                 from arch/arm64/kernel/asm-offsets.c:10:
include/linux/notifier.h:75:22: error: field 'mutex' has incomplete type
   75 |         struct mutex mutex;
      |                      ^~~~~

Caused by commit

  c3b03baac3f2 ("random: replace custom notifier chain with standard one")

Which added the include of linux/notifier.h to linux/random.h :-(

I have added this patch for today:

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Thu, 3 Mar 2022 18:43:56 +1100
Subject: [PATCH] fix up for "random: replace custom notifier chain with sta=
ndard one"

Only the forward declaration of struct notifier_block is needed.
This prevents a circular include dependency on arm64 (at least).

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 include/linux/random.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/linux/random.h b/include/linux/random.h
index 7fccbc7e5a75..c0baffe7afb1 100644
--- a/include/linux/random.h
+++ b/include/linux/random.h
@@ -7,10 +7,11 @@
 #include <linux/kernel.h>
 #include <linux/list.h>
 #include <linux/once.h>
-#include <linux/notifier.h>
=20
 #include <uapi/linux/random.h>
=20
+struct notifier_block;
+
 extern void add_device_randomness(const void *, size_t);
 extern void add_bootloader_randomness(const void *, size_t);
=20
--=20
2.34.1

--=20
Cheers,
Stephen Rothwell

--Sig_/.J72ZladJUcMmD1folqTPeK
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmIgdqIACgkQAVBC80lX
0Gy0Ygf/W3fFBJnwj4bcY86No7BvTpHTpDrE8VbUeIZGC3k/Y+PDpzBB0s/gZvVE
keLmu+YRJe0hQqaCDeAlZczPmAY2o4s0P238rpkdzc99xgteQ//+vz5KqRgGk+hA
f32fLks5A1qgOm9M/dF+2IsFlV0FB2iZqjoGjepoXA9S617bKhLWJlFC1xo7wV79
cL2fIF54KcetLpTdXqFodrat21q0/VhNJ36ylajGqQJ+67W8bfNVjYeNbfKS/1Yd
Cp+E6vYHQXMh7Gsguz6Mi6G74kijAU+wXJd7xNXOICxOIt/N9J4T8jjuMR6WC1ES
s7U6ci1QV8V1H/uRjo591IO7YHlvbA==
=ixfl
-----END PGP SIGNATURE-----

--Sig_/.J72ZladJUcMmD1folqTPeK--
