Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E22B149D529
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 23:18:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233096AbiAZWSF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 17:18:05 -0500
Received: from gandalf.ozlabs.org ([150.107.74.76]:33339 "EHLO
        gandalf.ozlabs.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233059AbiAZWSD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 17:18:03 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4JkdQK4c5nz4y4h;
        Thu, 27 Jan 2022 09:18:01 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1643235482;
        bh=pqKmV1+sA3ysIMqwWvsV/2bshz9rBVkAJxRMcw0Ep7A=;
        h=Date:From:To:Cc:Subject:From;
        b=rhyflr3TRldBrcKcVF/IPAlxOT9tW+SQKtr0NPr6TcpzAKVrN/JznW+pyP9m4Vk/B
         nIQNL7NyQU6FnHKiftZwACZEabc5e1ecIkcayNSSfavVlIQF/A0JylKHCMbRMSisCb
         IdHFT0jub43WAwmL0GN6kQBa0LEQTHaoM12M5JpzhmOGdmsgSulwiidHzbSR36MI6t
         2tAVoxTzHtH/YZ5YgW2AASc+wM2MZDp0bKb06vviOMRvuhZCdU5XP7uAvxms87YPR/
         754TH1ewQcT5xYXS4MbZ0fCQeHfU4hhRJwQPJ76qVxK6bg7zM+RDFXCnEaK5AzyO3Y
         UlxKd2NuXImgA==
Date:   Thu, 27 Jan 2022 09:18:00 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Greg KH <greg@kroah.com>
Cc:     "Maciej W. Rozycki" <macro@embecosm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build warnings after merge of the tty.current tree
Message-ID: <20220127091800.1e8f333b@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/v=2uYWWNVzpOwakz1k7_3mM";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/v=2uYWWNVzpOwakz1k7_3mM
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the tty.current tree, today's linux-next build (x86_64
allmodconfig) produced these warnings:

In file included from <command-line>:
./usr/include/linux/cyclades.h:6:2: warning: #warning "Support for features=
 provided by this header has been removed" [-Wcpp]
    6 | #warning "Support for features provided by this header has been rem=
oved"
      |  ^~~~~~~
./usr/include/linux/cyclades.h:7:2: warning: #warning "Please consider upda=
ting your code" [-Wcpp]
    7 | #warning "Please consider updating your code"
      |  ^~~~~~~


Introduced by commit

  f23653fe6447 ("tty: Partially revert the removal of the Cyclades public A=
PI")

This is a bit annoying :-(

Can we exclude include/uapi/linux/cyclades.h from the headers checking,
please?

--=20
Cheers,
Stephen Rothwell

--Sig_/v=2uYWWNVzpOwakz1k7_3mM
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmHxyJgACgkQAVBC80lX
0Gz03Af7B8GI4oPRwLbhNgw+eRGOyKrn/WyMDq70A1kJTPi07ZZrUXXSi4K2kKci
6LVCg6TUQU7D+d2T6FbSfqwgpyg2mWsrGpwWGxRyoIfLyWdSKzbn9Y+7YHY32t0H
WLNkvD2P55NdqC0wu9f12Pl7plC9LkrX2ZZPXtW+9nCuxndAcZ093bfqYBeYw1T0
Ij4bc8U7ME8g9ZCOA+RWAk0u8SsUeqm9IZTL/ZziSUXWVIZHtcRZkAPQ/PRqdZk0
qB2ZvMQqMd10CPq/Bch30/Yiqv4sQnf4Zb92UnX6Ky4kpo2TMPerxgvFIwpsK25E
V9gPEx6h/NRIuJGajdF/MruKOsfsMQ==
=Iusj
-----END PGP SIGNATURE-----

--Sig_/v=2uYWWNVzpOwakz1k7_3mM--
