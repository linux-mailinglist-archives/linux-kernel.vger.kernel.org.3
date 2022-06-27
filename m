Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC17855CE57
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:04:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232240AbiF0GBU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 02:01:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232144AbiF0GBT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 02:01:19 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2E122DE4;
        Sun, 26 Jun 2022 23:01:17 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4LWcY54zZNz4xR1;
        Mon, 27 Jun 2022 16:01:13 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1656309673;
        bh=B8/DAHfiVekOcHzGj7CK6X9FdVvkmInQqszPWwtuJT8=;
        h=Date:From:To:Cc:Subject:From;
        b=oshMXJEJHT8JEn3YAu6zGL1Hq+bZKx/x5M/1jwL2DDMknNFNRGfXaL0ePfgyYLbm0
         VolzmVbl9mynn3TbjTFdJ9bgmKtJ/eOTFnM0MljXNJtL4PxqP9Z/Yk38fV/EeTUg3z
         mE9nqJLtAkOzbIjz0D4meZIHHJfvSUSvLYNJlK9N9rVXJuizM82zC4TNvnJRUmkO15
         lqMP6GOiM4bo9wnG1jc7M02Cg5PKu2OHyhkkRv53Pqnd49lAByfnMzdkT1CXvn1YkK
         0M8+tNzg0Mwnhq5mGhtLRuEWkCRvJ9CtIEY9FwIoQW/cw6ul+TrWwLcklCCdFFSjWS
         rUWKdZAF/xLnQ==
Date:   Mon, 27 Jun 2022 16:01:09 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the pinctrl tree
Message-ID: <20220627160109.4684e8ad@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/1QaAlSzav0IY=8kXaxHg3i=";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/1QaAlSzav0IY=8kXaxHg3i=
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the pinctrl tree, today's linux-next build (arm64 defconfig)
failed like this:

drivers/pinctrl/qcom/pinctrl-lpass-lpi.c: In function 'lpi_pinctrl_probe':
drivers/pinctrl/qcom/pinctrl-lpass-lpi.c:391:55: error: 'np' undeclared (fi=
rst use in this function); did you mean 'up'?
  391 |         data->is_clk_optional =3D of_property_read_bool(np, "qcom,a=
dsp-bypass-mode");
      |                                                       ^~
      |                                                       up
drivers/pinctrl/qcom/pinctrl-lpass-lpi.c:391:55: note: each undeclared iden=
tifier is reported only once for each function it appears in

Caused by commit

  36fe26843d6d ("pinctrl: qcom: sc7280: Add clock optional check for ADSP b=
ypass targets")

I have reverted that commit for today.

--=20
Cheers,
Stephen Rothwell

--Sig_/1QaAlSzav0IY=8kXaxHg3i=
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmK5R6UACgkQAVBC80lX
0GyQWQf9Ha9HJyRxJMuGETEypNp8FKAursMhBZb/a4470DcBXL5Kg2c3U111huKr
1Ci736DUggjoqvcZfjXs03ujNq6B/ZTaJkClsbxm1j8W2N2KWMoeIygb67UVxclc
74cPXEubby+vXZEy1AaBOygq2eHLiWiMfv6nyvOPsgirtCMYgeAQ5OrGuMvMLD6G
9nIpxq4dKf8LlYY5VKYL630njTKheQAfeDcHfFuEj6T/6S7I783J+9jMsdYBcwiI
u9mdiVoTe/kYxz6cKqZNouugZ2bQ9rb5ioqL3r8vlAzy2h5SnLp2VYNVrYeyWijD
X3RX1JXNJYlwhucCVJBaTb33lyAvUQ==
=BdwN
-----END PGP SIGNATURE-----

--Sig_/1QaAlSzav0IY=8kXaxHg3i=--
