Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DEF0521560
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 14:26:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241695AbiEJMaO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 08:30:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241318AbiEJMaI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 08:30:08 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FF9116D4BC;
        Tue, 10 May 2022 05:26:08 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4KyHMJ38cxz4xXS;
        Tue, 10 May 2022 22:26:04 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1652185564;
        bh=xFfKRkicEM6exIkb81xPoFhftB5Z/tdYHdSeBEndofw=;
        h=Date:From:To:Cc:Subject:From;
        b=od9YBjg5qYWzXZGUTgNUeqqookvMyd5Rs9zDevTmNJqf4+a9mKCd1gEcdLwUXU/dm
         c9Ee6RQX7AM8YhRlKoZqFLHcAfsIWHL3pEw+ZEFYBHdPpMCAuFHFiDqmtfgVb+VgUU
         eL/BrZbXLSXGn+TOPeWFpCOlhI+9xN4TOI+fqtJi88qU8dg89TItmVq1DYY1YsH5dd
         6gpg7iboY0B4ZImLOs7MIZygWluc1dqPG/fGKKyO22vgQOOxIaVn3Qf/odbK1iolux
         ufHgC47Gy7BMnXbr/svrdlEfzdMzlc4eOJTEjvgc8YRFSf90IRsnY/aUx2QEIbOJOR
         sLwr/A4l2aqZQ==
Date:   Tue, 10 May 2022 22:26:03 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Zev Weiss <zev@bewilderbeest.net>,
        Denis Pauk <pauk.denis@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the hwmon-staging tree
Message-ID: <20220510222603.0d675ce2@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/LZSeDj+9=VIS2/G0KGzZcCM";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/LZSeDj+9=VIS2/G0KGzZcCM
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the hwmon-staging tree, today's linux-next build (powerpc
allyesconfig) failed like this:

ld: drivers/hwmon/nct6775-platform.o: in function `.nct6775_wmi_reg_write':
nct6775-platform.c:(.text.nct6775_wmi_reg_write+0x38): undefined reference =
to `.nct6775_reg_is_word_sized'
ld: drivers/hwmon/nct6775-platform.o: in function `.nct6775_wmi_reg_read':
nct6775-platform.c:(.text.nct6775_wmi_reg_read+0x38): undefined reference t=
o `.nct6775_reg_is_word_sized'
ld: drivers/hwmon/nct6775-platform.o: in function `.nct6775_resume':
nct6775-platform.c:(.text.nct6775_resume+0x61c): undefined reference to `.n=
ct6775_reg_is_word_sized'
ld: drivers/hwmon/nct6775-platform.o: in function `.nct6775_platform_probe':
nct6775-platform.c:(.text.nct6775_platform_probe+0x14c): undefined referenc=
e to `.nct6775_probe'
ld: drivers/hwmon/nct6775-platform.o: in function `.nct6775_reg_read':
nct6775-platform.c:(.text.nct6775_reg_read+0x5c): undefined reference to `.=
nct6775_reg_is_word_sized'
ld: drivers/hwmon/nct6775-platform.o: in function `.nct6775_reg_write':
nct6775-platform.c:(.text.nct6775_reg_write+0x5c): undefined reference to `=
.nct6775_reg_is_word_sized'
ld: drivers/hwmon/nct6775-platform.o:(.data.rel.sensor_dev_attr_beep_enable=
+0x28): undefined reference to `nct6775_show_beep'
ld: drivers/hwmon/nct6775-platform.o:(.data.rel.sensor_dev_attr_beep_enable=
+0x30): undefined reference to `nct6775_store_beep'
ld: drivers/hwmon/nct6775-platform.o:(.data.rel.sensor_dev_attr_intrusion0_=
alarm+0x28): undefined reference to `nct6775_show_alarm'
ld: drivers/hwmon/nct6775-platform.o:(.data.rel.sensor_dev_attr_intrusion0_=
beep+0x28): undefined reference to `nct6775_show_beep'
ld: drivers/hwmon/nct6775-platform.o:(.data.rel.sensor_dev_attr_intrusion0_=
beep+0x30): undefined reference to `nct6775_store_beep'
ld: drivers/hwmon/nct6775-platform.o:(.data.rel.sensor_dev_attr_intrusion1_=
alarm+0x28): undefined reference to `nct6775_show_alarm'
ld: drivers/hwmon/nct6775-platform.o:(.data.rel.sensor_dev_attr_intrusion1_=
beep+0x28): undefined reference to `nct6775_show_beep'
ld: drivers/hwmon/nct6775-platform.o:(.data.rel.sensor_dev_attr_intrusion1_=
beep+0x30): undefined reference to `nct6775_store_beep'
ld: drivers/hwmon/nct6775-i2c.o: in function `.nct6775_i2c_read':
nct6775-i2c.c:(.text.nct6775_i2c_read+0x108): undefined reference to `.nct6=
775_reg_is_word_sized'
ld: drivers/hwmon/nct6775-i2c.o: in function `.nct6775_i2c_probe':
nct6775-i2c.c:(.text.nct6775_i2c_probe+0x134): undefined reference to `.nct=
6775_probe'

Probably caused by commit

  a2105efee6e7 ("hwmon: (nct6775) Split core and platform driver")

I have reverted that commit for today - and the following commits

  4dcbcf34a249 ("hwmon: (nct6775) add ASUS PRO H410T / PRIME H410M-R / ROG =
X570-E GAMING WIFI II")
  58f1d9ebfce6 ("hwmon: (nct6775) Add i2c driver")

--=20
Cheers,
Stephen Rothwell

--Sig_/LZSeDj+9=VIS2/G0KGzZcCM
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmJ6WdsACgkQAVBC80lX
0Gxnbgf8DeH4ri0xSEjzqTkdAlLkOJTKpmQKtA8693I0kY8sYxTVbWBqqkwRotPl
fZmotek3SavgJRo/3a6csiCZmXcaVrXD2JvktRO69Vm3W1GaVx8JJYLp7lp+SoOe
WWRL9dPX5907KXILDZ1uJ0nG7JXybF/qp84OHK5XUNKxDt0v8hLfpz0ZABjk6ffp
vuuGkP69ectDffz5St0r2uNM+Qs40JeNwNvReVZPnLEY2VxEcKDjLy5SxhXyVO5u
e7W4gxVZtqQ7zJbDKZAaS+e0FoTagYwVE8W0/d3xEAiKVHUGNj8q1GvErcojBEje
zdCNgeaDZnmN+01Ju9wTqBabxwIVsA==
=M9LF
-----END PGP SIGNATURE-----

--Sig_/LZSeDj+9=VIS2/G0KGzZcCM--
