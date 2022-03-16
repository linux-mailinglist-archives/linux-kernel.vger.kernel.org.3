Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6FE24DABDE
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 08:32:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353851AbiCPHdv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 03:33:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235615AbiCPHds (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 03:33:48 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C66133EBC;
        Wed, 16 Mar 2022 00:32:33 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4KJMRw1pmgz4xc2;
        Wed, 16 Mar 2022 18:32:28 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1647415949;
        bh=2bX5m0dsEEShAIhhM2xgXf0DVIPBckL0DuRea6ZzCqA=;
        h=Date:From:To:Cc:Subject:From;
        b=XTrp/N0YyvAa9f1NUK7e8ZOsh7UkQxDa8esQfRRfM3YjfVu5sskhaKo6oBM6wGN5w
         LiWo7OIx52lUteflz4D718IAq0+kGVfKdm3z+UGB6xUjdU/uRZ92/aaN0k2Jzi4di0
         h4LdNCE4YhLhIZlKteP4TAU+xOfrlTI4XEXsupM2w/5t9WCbyFYGiPPJZ59omjFyRS
         fUtUu/qasaJU5TIIT9a8jdCQ3jKOawOzx+ULQ5/S2MZS9QJcesgZxOlCT6qDCiSSEP
         ZWTyvVVBdYMmeDy/Q58+MfJeuMNSkzpy/7WfhWlejwY2mpKRtHnzKUuFCvC/5EUtzS
         bgVsCw7jw3LGQ==
Date:   Wed, 16 Mar 2022 18:32:27 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Kees Cook <keescook@chromium.org>
Cc:     Jonathan =?UTF-8?B?TmV1c2Now6RmZXI=?= <j.neuschaefer@gmx.net>,
        Linus Walleij <linus.walleij@linaro.org>,
        Tomer Maimon <tmaimon77@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the kspp tree
Message-ID: <20220316183227.725bfd37@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/CeQoGL5Gyf7NaVBeLj14Qq.";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/CeQoGL5Gyf7NaVBeLj14Qq.
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the kspp tree, today's linux-next build (x86_64
allmodconfig) failed like this:

In file included from include/linux/bitmap.h:9,
                 from include/linux/cpumask.h:12,
                 from arch/x86/include/asm/paravirt.h:17,
                 from arch/x86/include/asm/irqflags.h:63,
                 from include/linux/irqflags.h:16,
                 from include/linux/rcupdate.h:26,
                 from include/linux/rculist.h:11,
                 from include/linux/pid.h:5,
                 from include/linux/sched.h:14,
                 from include/linux/ratelimit.h:6,
                 from include/linux/dev_printk.h:16,
                 from include/linux/device.h:15,
                 from drivers/pinctrl/nuvoton/pinctrl-npcm7xx.c:5:
drivers/pinctrl/nuvoton/pinctrl-npcm7xx.c: In function 'npcmgpio_irq_handle=
r':
include/linux/find.h:40:23: error: array subscript 'long unsigned int[0]' i=
s partly outside array bounds of 'u32[1]' {aka 'unsigned int[1]'} [-Werror=
=3Darray-bounds]
   40 |                 val =3D *addr & GENMASK(size - 1, offset);
      |                       ^~~~~
drivers/pinctrl/nuvoton/pinctrl-npcm7xx.c:219:13: note: while referencing '=
sts'
  219 |         u32 sts, en, bit;
      |             ^~~

Caused by commit

  3b588e43ee5c ("pinctrl: nuvoton: add NPCM7xx pinctrl and GPIO driver")

probably exposed by commit

  a1d1e0e3d80a ("pinctrl: nuvoton: Add driver for WPCM450")

from the pinctrl tree and enabling -Werror=3Darray-bounds.

I have applied the following hack patch for today.

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Wed, 16 Mar 2022 18:12:14 +1100
Subject: [PATCH] fixup for "pinctrl: nuvoton: add NPCM7xx pinctrl and GPIO =
driver"

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 drivers/pinctrl/nuvoton/pinctrl-npcm7xx.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/pinctrl/nuvoton/pinctrl-npcm7xx.c b/drivers/pinctrl/nu=
voton/pinctrl-npcm7xx.c
index 41136f63014a..fddcb7d6bdf4 100644
--- a/drivers/pinctrl/nuvoton/pinctrl-npcm7xx.c
+++ b/drivers/pinctrl/nuvoton/pinctrl-npcm7xx.c
@@ -216,7 +216,8 @@ static void npcmgpio_irq_handler(struct irq_desc *desc)
 	struct gpio_chip *gc;
 	struct irq_chip *chip;
 	struct npcm7xx_gpio *bank;
-	u32 sts, en, bit;
+	unsigned long sts, bit;
+	u32 en;
=20
 	gc =3D irq_desc_get_handler_data(desc);
 	bank =3D gpiochip_get_data(gc);
@@ -225,7 +226,7 @@ static void npcmgpio_irq_handler(struct irq_desc *desc)
 	chained_irq_enter(chip, desc);
 	sts =3D ioread32(bank->base + NPCM7XX_GP_N_EVST);
 	en  =3D ioread32(bank->base + NPCM7XX_GP_N_EVEN);
-	dev_dbg(bank->gc.parent, "=3D=3D> got irq sts %.8x %.8x\n", sts,
+	dev_dbg(bank->gc.parent, "=3D=3D> got irq sts %.8lx %.8x\n", sts,
 		en);
=20
 	sts &=3D en;
--=20
2.34.1

--=20
Cheers,
Stephen Rothwell

--Sig_/CeQoGL5Gyf7NaVBeLj14Qq.
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmIxkosACgkQAVBC80lX
0GyAVAf9EDaiyTpOPnikRZDOntfvtXbmoOSoeMyqXgCcdNkaJscEvWLS1UEP0vfB
Jb4P4NONmB3ICz5U+Y2UL1UXWnBBwrIN+es3YCVKthFhY59npcSRx2noB+bloDj1
/BTL+MRHbDu4l5uFAWxecdTnWYvX5Y/W+ZklyxElnCDg/0pYOFt0HBVogywpniEQ
8cfVvyKHsEJQTaTyzno4xA4cIvCSd6e5zSzjda12AbvHGw0CPc2j1mdb5x3ypSH/
/yiayAE0+/OcEnehgaoErP4oWAOrfnFCBsxLoQHF5VVE3u5H9nJsPNtLK3xc/MXW
zjHd9twjBO9zJwUf4aXHilWCSibWwg==
=Z0sR
-----END PGP SIGNATURE-----

--Sig_/CeQoGL5Gyf7NaVBeLj14Qq.--
