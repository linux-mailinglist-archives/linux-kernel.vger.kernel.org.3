Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 610C2577B04
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 08:32:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233524AbiGRGcH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 02:32:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230009AbiGRGcG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 02:32:06 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A850D15FFE;
        Sun, 17 Jul 2022 23:32:04 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4LmXDw4Nktz4xXF;
        Mon, 18 Jul 2022 16:32:00 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1658125921;
        bh=u4m9TJdNGX1rL5MkxVo3l4zbaNKUTaSl0NLh/x38pZ0=;
        h=Date:From:To:Cc:Subject:From;
        b=J6inUyhj8DzDty0nBomKyDNb/oIMQD0x598HOXpeIIriEeKpeSn1MoHBL8JZ2rfkY
         6WHUEntbqFrbtb2YhRZA/ULxpEW2yRO+seJmgIQrxTO9aA7rQkWSH3pWdxSSufdhSI
         C4KIwYWILxEzhQsYaqEEXlGTArOUIzR6qkCTuQ9oPDullhrWIVg90Xa7eHj3GyoAgk
         Yd4KtjHiDWPIpgqx87x9w7tcF9w1fHFhui96aiOridkPnx7Cuaci/ZkWrEyi1tj0vO
         Z/zM4PyXsXUXGTSOOmvbNoKOvSGdOHxN8d+973AShF7CPKC6M/q6hQ4AcDtHYnrWFr
         IIjCZh5D48uFg==
Date:   Mon, 18 Jul 2022 16:31:58 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Greg KH <greg@kroah.com>, Benson Leung <bleung@google.com>,
        Guenter Roeck <groeck@chromium.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Prashant Malani <pmalani@chromium.org>,
        Tzung-Bi Shih <tzungbi@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the usb tree
Message-ID: <20220718163158.42176b4e@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/oBci1lv=tF9l4LwqQdfysoa";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/oBci1lv=tF9l4LwqQdfysoa
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the usb tree, today's linux-next build (arm
multi_v7_defconfig) failed like this:

drivers/platform/chrome/cros_typec_switch.c: In function 'cros_typec_cmd_mu=
x_set':
drivers/platform/chrome/cros_typec_switch.c:52:16: error: implicit declarat=
ion of function 'cros_ec_command'; did you mean 'cros_ec_cmd'? [-Werror=3Di=
mplicit-function-declaration]
   52 |         return cros_ec_command(sdata->ec, 0, EC_CMD_TYPEC_CONTROL, =
&req,
      |                ^~~~~~~~~~~~~~~
      |                cros_ec_cmd
drivers/platform/chrome/cros_typec_switch.c: In function 'cros_typec_regist=
er_switches':
drivers/platform/chrome/cros_typec_switch.c:244:23: error: implicit declara=
tion of function 'acpi_evaluate_integer'; did you mean 'acpi_evaluate_objec=
t'? [-Werror=3Dimplicit-function-declaration]
  244 |                 ret =3D acpi_evaluate_integer(adev->handle, "_ADR",=
 NULL, &index);
      |                       ^~~~~~~~~~~~~~~~~~~~~
      |                       acpi_evaluate_object
drivers/platform/chrome/cros_typec_switch.c:244:49: error: invalid use of u=
ndefined type 'struct acpi_device'
  244 |                 ret =3D acpi_evaluate_integer(adev->handle, "_ADR",=
 NULL, &index);
      |                                                 ^~

Caused by commit

  e54369058f3d ("platform/chrome: cros_typec_switch: Add switch driver")

and commits

  34f375f0fdf6 ("platform/chrome: cros_typec_switch: Set EC retimer")
  bb53ad958012 ("platform/chrome: cros_typec_switch: Add event check")

interacting with commit

  b1d288d9c3c5 ("platform/chrome: cros_ec_proto: Rename cros_ec_command fun=
ction")

from the chrome-platform tree.

I have used the usb tree from next-20220715 for today.

I will fix up the cros_ec_command() rename with a merge fix patch after
the apci usage problem is solved.

--=20
Cheers,
Stephen Rothwell

--Sig_/oBci1lv=tF9l4LwqQdfysoa
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmLU/l4ACgkQAVBC80lX
0Gy3vAgAir7AzgK6yRr7V0wPpHR/OguTKRvhjU5NoBbnJOs/BMuBDfrng9pa5TzO
TZmL3sKBLLUMaKWY/ymKtr/h7MA3KXNw/x0W97aEx+z+yt5pHUlYRp7dPJwSjKFv
g/tgSiOrgtruqHhboAEI+jQG9QiDN7OEoy+Z3WTHjC0XwSuQ27iXkSx/8o2SBSTI
iAtvvTCSwUrs2gRt9Qvnft0iiksLy/2cKGOev1yB1gVl7rZ+CUrxxsvNIaPTaabZ
bpcWap1XCHWL1GT3GU3jFBQZ1JCjrXmImwmrB2+fjvf3mHa/pZ01Yl2Tl9cXwvcD
BLZt84tO7tesN0F36fzL1smYNlQTBQ==
=KyZ5
-----END PGP SIGNATURE-----

--Sig_/oBci1lv=tF9l4LwqQdfysoa--
