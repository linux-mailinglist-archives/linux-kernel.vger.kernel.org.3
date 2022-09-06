Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 323ED5AE622
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 13:04:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239771AbiIFLD7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 07:03:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233633AbiIFLD5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 07:03:57 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9600E78580;
        Tue,  6 Sep 2022 04:03:55 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4MMMvV06mzz4xG5;
        Tue,  6 Sep 2022 21:03:49 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1662462230;
        bh=TKp9q021Uz41068cFZhqLxmPO0W738ap0XmZrFslujI=;
        h=Date:From:To:Cc:Subject:From;
        b=pKLkQym4+rjfepa4qCCtn6iGF5EwtrrpDcTYaFEZTnQbs8/iwXXBLFA4PyXRm5D5+
         4q5aRCnV+WWqO3G8BkJrgIbfhiPAkPe0Syq6HVFp6vLlgprfRgvK6OgUnEokDf1Jxz
         bBH/qz8HRKwd7oQGsQTkmXvmq8mnwBCfgsUm45yln2cLRaJcXFlciR8rBqbzWGF7b5
         2NtXg0OJOBujbNJnwrpnu0V1HJ4y9I1WEaOA7gYcOPosDnv59NkxRIG/p54he/hWBi
         muIwO+AhUCdDrwzTRvUveawMLXGYrSFi+dB65R8TztS9uX2Bt3E73YawVIx4bbMInE
         PKRCcKs1HYltA==
Date:   Tue, 6 Sep 2022 21:03:48 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Rob Clark <robdclark@gmail.com>,
        Sean Paul <seanpaul@chromium.org>
Cc:     NeilBrown <neilb@suse.de>, Rob Clark <robdclark@chromium.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the mm tree
Message-ID: <20220906210348.4744da42@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/jXqhxJ4RDJqOWukvtHZE9Wq";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/jXqhxJ4RDJqOWukvtHZE9Wq
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the mm tree, today's linux-next build (arm
multi_v7_defconfig) failed like this:

drivers/gpu/drm/msm/msm_gem_shrinker.c: In function 'can_block':
drivers/gpu/drm/msm/msm_gem_shrinker.c:29:28: error: '__GFP_ATOMIC' undecla=
red (first use in this function); did you mean 'GFP_ATOMIC'?
   29 |         if (sc->gfp_mask & __GFP_ATOMIC)
      |                            ^~~~~~~~~~~~
      |                            GFP_ATOMIC

Caused by commit

  9178e3dcb121 ("mm: discard __GFP_ATOMIC")

interacting with commit

  025d27239a2f ("drm/msm/gem: Evict active GEM objects when necessary")

from the drm-msm tree.

I have reverted the drm-msm tree commit for today.

--=20
Cheers,
Stephen Rothwell

--Sig_/jXqhxJ4RDJqOWukvtHZE9Wq
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmMXKRQACgkQAVBC80lX
0GxLDgf8Dqr9xu2yjCmYDUHWmBT1/9B//vGqMgwOvvzBz3/QIKLK6D3yY+RCGOZu
QUOwQaxX0m/5ADGTM+kZzqYN6aVFSxQ8uVuqjtY+nfiVxLsp8auFqntOB7FcjGxz
bDT2hqtaVlCiNxjAhgp8IdcCYdt5gqeMHB6S+A8fApfpffchBvHoml1rJVKPZN5Q
0KkNRZVQUAairj7SsFx3z0rrRE6a9TtxlQnqVQM2u6P6mYi5JqPvdS1F9WCvIxrX
CjzxWcjcadMiZ9MGW6lCd7l3dGNQLihhIN/BiXEVP6tZD1wAlGjRtU3sk7qS6MGg
FpwAeqQfM3nOSW5xMjP6xp8kprni+g==
=hVDK
-----END PGP SIGNATURE-----

--Sig_/jXqhxJ4RDJqOWukvtHZE9Wq--
