Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFC5056B147
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 06:14:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237034AbiGHENx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 00:13:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230230AbiGHENv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 00:13:51 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3554024BE0;
        Thu,  7 Jul 2022 21:13:50 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4LfKf12V0tz4xRC;
        Fri,  8 Jul 2022 14:13:45 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1657253625;
        bh=UPCLsI8kzTLEeLtvvKQ1vWxhgI7ISuuekfJhJqu8SHs=;
        h=Date:From:To:Cc:Subject:From;
        b=XU9grpgVbEHEk+z7yPDzgHpusKWbj4aWEqXBKMNDkB3tcdgmhzGEOeh47Mo56hQcb
         C6LtVKNyjI3e9yI81tzZK/Nb0UBWVJzzZfaeAD8NmMznMOSX80zKMlwyrsFlEYqVd/
         sWNnJlRHL3DhbdWa35R9JNyRFSui82adORY2Nanp/+noy0fSA7PzCnyRAkHuwaNlBd
         68Tc4TI2MNPDTfbfERgRNo7zSiXun8bJDbhHzB5zUpM4+J1RPFuiz1gQulJjv/xPTN
         QUvbwSU60+HKVKYjuiFjfU8lRaRWXWOLITj79JNRjX1gfG805LDU62KWwbQ63RNMlN
         REAVPoHl/8AZw==
Date:   Fri, 8 Jul 2022 14:13:44 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Marc Zyngier <maz@kernel.org>
Cc:     Samuel Holland <samuel@sholland.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the irqchip tree
Message-ID: <20220708141344.3b521664@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/4ezgDNzaqerq4FgysJuS+=O";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/4ezgDNzaqerq4FgysJuS+=O
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the irqchip tree, today's linux-next build (x86_64
allmodconfig) failed like this:

drivers/pci/controller/pci-hyperv.c: In function 'hv_compose_msi_req_v2':
drivers/pci/controller/pci-hyperv.c:1654:42: error: passing argument 1 of '=
hv_compose_msi_req_get_cpu' discards 'const' qualifier from pointer target =
type [-Werror=3Ddiscarded-qualifiers]
 1654 |         cpu =3D hv_compose_msi_req_get_cpu(affinity);
      |                                          ^~~~~~~~
drivers/pci/controller/pci-hyperv.c:1638:55: note: expected 'struct cpumask=
 *' but argument is of type 'const struct cpumask *'
 1638 | static int hv_compose_msi_req_get_cpu(struct cpumask *affinity)
      |                                       ~~~~~~~~~~~~~~~~^~~~~~~~
drivers/pci/controller/pci-hyperv.c: In function 'hv_compose_msi_req_v3':
drivers/pci/controller/pci-hyperv.c:1674:42: error: passing argument 1 of '=
hv_compose_msi_req_get_cpu' discards 'const' qualifier from pointer target =
type [-Werror=3Ddiscarded-qualifiers]
 1674 |         cpu =3D hv_compose_msi_req_get_cpu(affinity);
      |                                          ^~~~~~~~
drivers/pci/controller/pci-hyperv.c:1638:55: note: expected 'struct cpumask=
 *' but argument is of type 'const struct cpumask *'
 1638 | static int hv_compose_msi_req_get_cpu(struct cpumask *affinity)
      |                                       ~~~~~~~~~~~~~~~~^~~~~~~~
cc1: all warnings being treated as errors

Caused by commit

  4d0b8298818b ("genirq: Return a const cpumask from irq_data_get_affinity_=
mask")

I have used the irqchip tree from next-20220707 for today.

--=20
Cheers,
Stephen Rothwell

--Sig_/4ezgDNzaqerq4FgysJuS+=O
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmLHrvgACgkQAVBC80lX
0GxCuAgAgm4sypkWdSt10GzOjfY+JFglURoXdBGA30cSIuV4GKqPiRkKZx6aUm6W
PxZez+1NRtczKS8YUEojyCl/qqbjD8JjbVEQ9MMB43y7O6hDr3FRD2ETamRl4ej7
7tHf+/Wfaot0DwvLbyJjAkoT8/LdKTQg+7W9C/jjILaS/4FsLN8U+1FvTrXN3eNV
2BqEmJNiAHNHU1C3Xeg43ptwFChvaKoRN6MwkSH6tUK2An0/CMyfwuZbPgJ3W0ix
eycmFxovdODDg3cYgDD2ORKyhznQc67C0XOOcFrXJaNyaMgwb06Q4lQSnGIQERLT
9aEAF25s4QeAhwcwAzqoswnVBaFcug==
=PWC5
-----END PGP SIGNATURE-----

--Sig_/4ezgDNzaqerq4FgysJuS+=O--
