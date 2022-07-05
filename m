Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57A3C5660CF
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 03:55:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233719AbiGEByx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 21:54:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbiGEByu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 21:54:50 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A0AC1027;
        Mon,  4 Jul 2022 18:54:49 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4LcQj11QQrz4xTq;
        Tue,  5 Jul 2022 11:54:45 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1656986085;
        bh=n6obHKKr58ET3hYfiULRhwQq2z2w4zRbntfVtztGqas=;
        h=Date:From:To:Cc:Subject:From;
        b=X500o42hU7Ptp3bEHHyYaGVXhjDeLR7tGWSaiMEEpppDoGStYcfvNTvnptRnlejX/
         ZBYGAI/9onK55XPaVh9IXiv0u1XWbV/FuXI9C5gU3uVJrM6MLsc8lREs0aaZNXMgfX
         BkxT9FJx+0mUKZZAqCa+fTqQ/xlojt5T5dl2tZRcqOarmU8nV94Vl0h+ckZVX+iFQ4
         cvF8lIt9KCRbQqkSamYAHjDVHEYNYqmiSiscSE6LBRI7/P4LkvyhghaSqkmB46OpaG
         yXrXvydAZi21XvsYT+HDe0VUjWxQ+rP6NSWNcMlRCj447al6CY4ylXuFvwbp2d5RQx
         evw7b2YBE0+gw==
Date:   Tue, 5 Jul 2022 11:54:39 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Aidan MacDonald <aidanmacdonald.0x0@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the mfd tree
Message-ID: <20220705115439.5a189cde@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/xr3ecsiJnMy8Zj_oTLt0S4c";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/xr3ecsiJnMy8Zj_oTLt0S4c
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the mfd tree, today's linux-next build (arm
multi_v7_defconfig) failed like this:

drivers/mfd/axp20x.c:634:35: error: initialization of 'unsigned int (*)(str=
uct regmap_irq_chip_data *, unsigned int,  int)' from incompatible pointer =
type 'int (*)(unsigned int,  int)' [-Werror=3Dincompatible-pointer-types]
  634 |         .get_irq_reg            =3D axp192_get_irq_reg,
      |                                   ^~~~~~~~~~~~~~~~~~
drivers/mfd/axp20x.c:634:35: note: (near initialization for 'axp192_regmap_=
irq_chip.get_irq_reg')

Caused by commit

  8c7d8aa029a3 ("mfd: axp20x: Add support for AXP192")

I have used the mfd tree from next-20220704 for today.

--=20
Cheers,
Stephen Rothwell

--Sig_/xr3ecsiJnMy8Zj_oTLt0S4c
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmLDmeAACgkQAVBC80lX
0GzXhQf+JRYamPiaZCQps9XONBpMiIhdHG9rqXpKhTfYUDddvr8wWTqIxQfrOEbs
DcwnhAWgWbt8JePIipHSFpZyyitTsUxKrZX6Nk4LOF445IFI6FxPhCtuzN0sGWTV
tNl6V8Ue8OXSsiSFwUYyh3sLfL6Nn+6BpjB8dvezNb+2X1nLBctpaKTF9J0bL+WG
PItFXf5WZ44/SpJyS6fWHnC2Kjd/Aw4YDhtcR3Q2+moK95UCy3WUKhr78l1KZzv0
R0LA8DKqgACtRyrEkdXwnhfXifjGLnnMLOdrTnghMvKs4DwjjqVq9i3b4eQwa/mJ
C3ln157b90UuaYiXeLaALtrR5dI+9A==
=RH9d
-----END PGP SIGNATURE-----

--Sig_/xr3ecsiJnMy8Zj_oTLt0S4c--
