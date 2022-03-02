Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B7D94C9DDC
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 07:37:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239722AbiCBGiI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 01:38:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231644AbiCBGiF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 01:38:05 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 297C85F8C9;
        Tue,  1 Mar 2022 22:37:21 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4K7ktj0KcQz4xNm;
        Wed,  2 Mar 2022 17:37:17 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1646203037;
        bh=5+BxKhtnAqvVfvAgUzx1TGaC8TMewO/v7AoiFI0Ypwo=;
        h=Date:From:To:Cc:Subject:From;
        b=JYNvi/cKne4TYhAasMb7Xbcx0CzgqvCQ919SrUlnFD0wI07eahhxGRtjiuN+6NuN6
         DPOTd/pPLdRTduaWITnjyAHullQTBTMBY1vcVx06pMlrWtBJz59f6ME47JQAOQiDap
         J4VGhtEPRAdAQl6jw6/HNSLOzi+jJOrATpxTr6HKEOjpYfYkwlWOasePkWkqfVMILL
         zYA2kB/7mBVjdmVeOgOB7zfq7Xxlgqv8mU+Qj9xK1nXom99CVSfSwoKjriACHKmIUS
         Xt+ng4SGh97/VdyryGFNIxU/OnIqgLhxZ2AtoiYqX4P4VX3szMoWD+s8ll5Vr/v9Wh
         Y2WE+0Pw32K3A==
Date:   Wed, 2 Mar 2022 17:37:14 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     Manivannan Sadhasivam <mani@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the mhi tree
Message-ID: <20220302173714.78c9f43c@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/sWOK5kgboj74CDu8mLDMOXW";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/sWOK5kgboj74CDu8mLDMOXW
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the mhi tree, today's linux-next build (x86_64 allmodconfig)
failed like this:

drivers/bus/mhi/ep/main.c: In function 'mhi_ep_register_controller':
drivers/bus/mhi/ep/main.c:1426:9: error: implicit declaration of function '=
irq_set_status_flags' [-Werror=3Dimplicit-function-declaration]
 1426 |         irq_set_status_flags(mhi_cntrl->irq, IRQ_NOAUTOEN);
      |         ^~~~~~~~~~~~~~~~~~~~
drivers/bus/mhi/ep/main.c:1426:46: error: 'IRQ_NOAUTOEN' undeclared (first =
use in this function); did you mean 'IRQF_NO_AUTOEN'?
 1426 |         irq_set_status_flags(mhi_cntrl->irq, IRQ_NOAUTOEN);
      |                                              ^~~~~~~~~~~~
      |                                              IRQF_NO_AUTOEN
drivers/bus/mhi/ep/main.c:1426:46: note: each undeclared identifier is repo=
rted only once for each function it appears in

Caused by commit

  6cb3bc57b0c5 ("bus: mhi: ep: Add support for processing MHI endpoint inte=
rrupts")

Presumably a missing include.

I have used the mhi tree from next-20220301 for today.

--=20
Cheers,
Stephen Rothwell

--Sig_/sWOK5kgboj74CDu8mLDMOXW
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmIfEJoACgkQAVBC80lX
0Gw71Qf+MXipuPeCVQ9CHodunMeCX9a8HXN82zhxWlfkQpMjZ9XZ64XrPMVT4/P8
t57cC77AjcgE+GUd83ZTQPi5HObbNevXXycFlfK+wbahWa1h6mXXZKWQ4r3zHtKI
KLlpow+PY2APOZV+hTqGaloJtNQHrHgujdciIKKAG/ILnAg4Ct+Cd9ysuX4CiDCd
0R5PLo6U0W5cjIC5VwhjyMETpvoiBac8ZS7MMiVM2uV0nN6HvDRxwx79maaAJ1fp
45tE79wrGsbZFSieHcGBiYcxX270lvtlsFOhadqW6XXGYEWj/3YzXhZgA+uGYtl8
LV+v8S70W1ubnmROHHlocEXSm7OewA==
=b5DF
-----END PGP SIGNATURE-----

--Sig_/sWOK5kgboj74CDu8mLDMOXW--
