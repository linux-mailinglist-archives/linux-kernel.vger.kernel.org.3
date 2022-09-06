Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DA1C5AF8AF
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 01:56:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229576AbiIFX4W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 19:56:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbiIFX4T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 19:56:19 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89F7C93518;
        Tue,  6 Sep 2022 16:56:17 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4MMj2m0sqnz4xDK;
        Wed,  7 Sep 2022 09:56:15 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1662508576;
        bh=nUhOC8SAw4+WvD9//eLwBTzORyWn6BIWh0ARwrbPPdU=;
        h=Date:From:To:Cc:Subject:From;
        b=PQJFI1CkqhnDf0BeJNGo1UZQhYc60vzINIdhf9H0gQYi7v3Q0r3DgjDH4BWsNqd6J
         j6ObpzeuMUj5BCJ71nmOjg2osb82wwFR/nSp4es9esLfcF8Sgkefl+Xbe5vUs9dzlv
         bNa+mYJUAuZG3ZS+Nutly3Et7AdfZvgeqd7ldgo7tKsIgd/ghYn9JSoY26THP2Zyxe
         3igoAsx2KDyPXH0BIuCqpV1ALAbcLRfrX1dLpmk4gxGY+9p81D89PYniZYtnEIWB7s
         xqmY9hKW5P9gsZ4YID5rCHgg7sO6Pqs1nFcGMoiYo/fVjfjAvqPFBNldl7ov5ZEzHG
         XpPHlHWI9GsuQ==
Date:   Wed, 7 Sep 2022 05:44:37 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     David Sterba <dsterba@suse.cz>
Cc:     Stefan Roesch <shr@fb.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the btrfs tree
Message-ID: <20220907054437.6500d591@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/vrnYs/U5Qsg3n=+Geuflo/y";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-0.4 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/vrnYs/U5Qsg3n=+Geuflo/y
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the btrfs tree, today's linux-next build (powerpc
ppc64_defconfig) failed like this:

ERROR: modpost: ".balance_dirty_pages_ratelimited_flags" [fs/btrfs/btrfs.ko=
] undefined!

Caused by commit

  145103680cd0 ("btrfs: make balance_dirty_pages nowait compatible")

balance_dirty_pages_ratelimited_flags() is not currently exported to module=
s.

I have used the btrfs tree from next-20220906 for today.

--=20
Cheers,
Stephen Rothwell

--Sig_/vrnYs/U5Qsg3n=+Geuflo/y
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmMXoyYACgkQAVBC80lX
0GwUiwf/ZSwIPUN9Otc5AXLnmkpy99f0wtt0PZ+M4ZbYh4tPf8cJ6yFDBpUtJxKi
E9cPV9SqgxWfKkww2OOw2dzGlrza3BcZF9+rZH/r/AoGkfhreQ52C54vDPTVxxv5
umcRl2TTl7cKI4u1BT1AVnClpPmVCy+ySyqWQvQfZLWJiUcQngFenZM1vZ9j3Gmv
yuga4QOYzf9RCFKHHvW4+z4B73+oF3NJbCpJZ1hqrhLux1hZdI9YNIat3Xxn4R/h
daddmFN800qrWJLKJpLYcdPX6LjboHKPpTTVj88YDzyC1LlyJDeMZXSxgyooHqbB
bQ1Kfk8yOrwmy9FOg0+ktXrV9yrVYg==
=16j0
-----END PGP SIGNATURE-----

--Sig_/vrnYs/U5Qsg3n=+Geuflo/y--
