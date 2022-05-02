Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38448516E83
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 13:07:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231177AbiEBLLL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 07:11:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230421AbiEBLLE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 07:11:04 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCCA217072;
        Mon,  2 May 2022 04:07:35 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4KsL0P6klVz4ySt;
        Mon,  2 May 2022 21:07:33 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1651489654;
        bh=PbNV0+fkwkL8XXp/ClFrNw34pzLTNB92XJjc04GNdz0=;
        h=Date:From:To:Cc:Subject:From;
        b=CS1JnE3fmm2Qw1gppXnE2p7Alb4O5YvNdAaGNjPC7m7YjNvVyU7Or3hXAkawhjHtY
         BUqiAelDCCxfsvdmj0xY8dZPZMsUxVwXc1sVM1xvUr2P6Ef9cRFoK69KDdr3PLYFFM
         NROxSHnsuYxU3pT3ezvR13/IgzLx+TtNa7VtlLzypHpTH4+2DwjIXsEm25uwdWTIRm
         nxRaeEf2amRR2GWCF3Vk/gKa0CvCQ/noxlbnU8pFNLLlUQJJ4+XCb3A/MjiGCTUzPJ
         5cEHBsvX8fBsPHXX8yaZsnOOifOodYelykF6nbd910Z/sLYB6al1/tMiRScHS5afyV
         syfaqGwU6rKpQ==
Date:   Mon, 2 May 2022 21:07:28 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Greg KH <greg@kroah.com>
Cc:     Matthias Kaehlcke <mka@chromium.org>,
        Ravi Chandra Sadineni <ravisadineni@chromium.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the usb tree
Message-ID: <20220502210728.0b36f3cd@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/Ct9KkP6+GXVdD9QDtI=pdX7";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/Ct9KkP6+GXVdD9QDtI=pdX7
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the usb tree, today's linux-next build (x86_64
modules_install) failed like this:

depmod: ERROR: Cycle detected: usbcore -> onboard_usb_hub -> usbcore
depmod: ERROR: Found 2 modules in dependency cycles!

Caused by commit

  c40b62216c1a ("usb: core: hcd: Create platform devices for onboard hubs i=
n probe()")

I have reverted that commit for today.

--=20
Cheers,
Stephen Rothwell

--Sig_/Ct9KkP6+GXVdD9QDtI=pdX7
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmJvu3AACgkQAVBC80lX
0GwJ9Qf/TG02wn3ldTLt7nYpSZpE7R1eHgPML+lx3eJhANl6DCLZrFz8n6xxt0L5
NQ6ZQSxnPe5f2owkblb1/efsiA1YgUQlnx4EfUyzlmOB+7I7ec6bdCF56GVco2pD
W+LKwAp+2y4SKyPrgezgdU0waLv4Zb4Y0+XrfBRqfJ0MnEjh61e3aLfHJAV1d5l0
YeW6KKc4vHDIhLWJA9xRolrNd64w0cm5xwrtanUyAR7n/G9M7SjT/TaSDJ2WzDh9
ro+PnsByb83+z7GyhhJxdmYd+lIXCrt6gGA1gTZf2hhYVgfPuR9okUvqBPkgmprF
sRYA84PhgumzyppBYHuKlR6kBd0h+A==
=ysi5
-----END PGP SIGNATURE-----

--Sig_/Ct9KkP6+GXVdD9QDtI=pdX7--
