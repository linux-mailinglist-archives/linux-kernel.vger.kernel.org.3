Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0358154C13B
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 07:43:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345534AbiFOFiN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 01:38:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244624AbiFOFiK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 01:38:10 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CCD43EF09;
        Tue, 14 Jun 2022 22:38:08 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4LNDbw10hwz4xYC;
        Wed, 15 Jun 2022 15:38:04 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1655271484;
        bh=LJmba7LF6BiTkgk1BjCNqHyaUX+gSnrZ4yOg/s+noRo=;
        h=Date:From:To:Cc:Subject:From;
        b=tC8Lv2v8MXCM5rM0cCxSeW2kEzEL0L0K9IFiHpjVv7Tf9CudPwIbltUvQt2q1zD8H
         BLOuAc+x2NJnsPeHt4pcpKSsg1xQN9sw2Bw2nYIyfpUD109z0Ai45yGCaPJOT/7i5S
         +Cty3/d8JlKys8poFw2zBxzSQXPcWfsHdE54vDH2MqVOinaL0MBeqOxR/kYaZB0fui
         sQoChlBhZ4c/mHIqD2FtJD1wTItGcxQqNsDYxcQ4g30AHXatf5qGHXANYdQTJT7+ks
         PGoBNZZtHUuTIM9HxAsVyccOucvgtLjyZRVwgEtq92FWhi/S/dMY69/8U7syNLEu5s
         kHzxdplxr7ypw==
Date:   Wed, 15 Jun 2022 15:38:02 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build warning after merge of the rcu tree
Message-ID: <20220615153802.49eeb827@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/0r44u2Bs/.HD3IWKdSYNMdJ";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/0r44u2Bs/.HD3IWKdSYNMdJ
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the rcu tree, today's linux-next build (htmldocs) produced
this warning:

Documentation/RCU/Design/Requirements/Requirements.rst:2220: WARNING: Malfo=
rmed table.

+-----------------------------------------------------------------------+
| **Quick Quiz**:                                                       |
+-----------------------------------------------------------------------+
| But what if my driver has a hardware interrupt handler that can run   |
| for many seconds? I cannot invoke schedule() from an hardware         |
| interrupt handler, after all!                                         |
+-----------------------------------------------------------------------+
| **Answer**:                                                           |
+-----------------------------------------------------------------------+
| One approach is to do ``ct_irq_exit();ct_irq_enter();`` every so    |
| often. But given that long-running interrupt handlers can cause other |
| problems, not least for response time, shouldn't you work to keep     |
| your interrupt handler's runtime within reasonable bounds?            |
+-----------------------------------------------------------------------+

Introduced by commit

  6c5218715286 ("context_tracking: Take IRQ eqs entrypoints over RCU")

--=20
Cheers,
Stephen Rothwell

--Sig_/0r44u2Bs/.HD3IWKdSYNMdJ
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmKpcDoACgkQAVBC80lX
0GzFsAgAkGhhz2ZZIXxCq2Xe9ORs+uEtwBJ04ATVlOsfPdjKAobhRikUnTp9nb2c
JE5NGjwO7jN8rOmVo1ggOxdT4K7DfoFqzqLo4SQvFB8Kb7aeyzNMVhRI1YDNBlHZ
ddAbXGWMQwh7AwJlpvArEMTKcyy0OrGivXNAf3xPZejhrTeh+6MEaa6HG9hv0xCl
9B3MW3Z5314t9zS6i7cYRb2ppFl9Ldj+3Hq+bVJ3xzMUIVivaQfJ8/SZR7LSteOe
+HP4R3jdvau9lSluG0tlejtvOzzeeLpjWRE4r5TbX6G2G1NvoIj9A9o7Ez37aiu7
0zOH8ejKM+wvFKakAVap2qmHIvvxCA==
=nsO0
-----END PGP SIGNATURE-----

--Sig_/0r44u2Bs/.HD3IWKdSYNMdJ--
