Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEB2B506233
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 04:38:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345463AbiDSCjJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 22:39:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232957AbiDSCjI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 22:39:08 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02967DF98;
        Mon, 18 Apr 2022 19:36:27 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Kj7Gd44lVz4xL4;
        Tue, 19 Apr 2022 12:36:25 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1650335785;
        bh=oMrzUi04AV+ANN49YbNpkN9W7z6eq6wLjwMluWdUU2A=;
        h=Date:From:To:Cc:Subject:From;
        b=PT6Ea1+nmpA5NdfzamuM/PFrfdL4GrJmAfWbFlIuVfEMFl7NJA7UAjWt9nXJ6RqYv
         s0ElG9R5Hjuee4lRtoNYZN+Mbl+2WcnxvmxC5AADaHufelnRHRvoXKhNU+i0olWsG4
         SNlG5+DM3i3KgwZtW03b3ziez2PZpdfy48wBQGZ4p62Ilo/kTGGL+Z/wga9wq2pM/d
         cHSkbXN8Lop/WvP6VveaU6e8rw/2aHu/615ezy7f3gxGIHj9+XLj/e5ItQe+xx2SZn
         ZSwnBhiM01+ZZdqfMtTwi/ScQf/SBQmDAsp18itVwsU+sxK8Iglz8W4rgRQ90pPUHK
         7SyODevJ5L8gw==
Date:   Tue, 19 Apr 2022 12:36:24 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the rcu tree
Message-ID: <20220419123624.12c57642@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/OnNTJqksbvO=f3B/ky.=Gxz";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/OnNTJqksbvO=f3B/ky.=Gxz
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the rcu tree, today's linux-next build (x86_64 allmodconfig)
failed like this:

In file included from kernel/rcu/tree.c:5031:
kernel/rcu/tree_nocb.h: In function 'rcu_init_nohz':
kernel/rcu/tree_nocb.h:1162:14: error: 'rcu_nocb_is_setup' undeclared (firs=
t use in this function); did you mean 'rcu_nocb_setup'?
 1162 |         if (!rcu_nocb_is_setup) {
      |              ^~~~~~~~~~~~~~~~~
      |              rcu_nocb_setup
kernel/rcu/tree_nocb.h:1162:14: note: each undeclared identifier is reporte=
d only once for each function it appears in

Caused by commit

  d6932dca19b1 ("rcu/nocb: Add an option to offload all CPUs on boot")

interacting with commit

  8d2aaa9b7c29 ("rcu/nocb: Move rcu_nocb_is_setup to rcu_state")

I have used the rcu tree from next-20220414 for today.

--=20
Cheers,
Stephen Rothwell

--Sig_/OnNTJqksbvO=f3B/ky.=Gxz
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmJeICgACgkQAVBC80lX
0GzSJgf/dfmU5U6Z22cj/kOQZ6GYnFypYBtv6QuBPmStaFbqZ2+Iuj5U8ydihFzi
Tx9Q7SVWIRcYJJ4v1VPeTQAQRJq0gFw79B5X0ulNMCah2MtN8WxiEFF1dxFOuuXJ
OpoBPALTyryWvhY+4ARQUWRWaQBRST94aBHPc8Um6myAtgyxOt+3nYbzZ79b6K67
dJejQuqwVEOf82rpm8lxSVEQDy5ryzkoq2/uVKY4WIDvf2N5FCdA63XdAO4R1ubZ
7gaCL6MDhsFBV8b2yTLSuOGFgEaif8Fp34gcMQMAuUTymnHO68ztFjL1nUD4gUSV
p9aI08fCWYySWrIcbd47ARTQvToRcQ==
=rWwp
-----END PGP SIGNATURE-----

--Sig_/OnNTJqksbvO=f3B/ky.=Gxz--
