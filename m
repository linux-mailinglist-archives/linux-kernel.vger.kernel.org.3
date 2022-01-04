Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C39ED483C83
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 08:29:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233355AbiADH3k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 02:29:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233315AbiADH3c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 02:29:32 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee2:21ea])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3A9DC061785;
        Mon,  3 Jan 2022 23:29:31 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4JSklF5dqtz4y47;
        Tue,  4 Jan 2022 18:29:29 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1641281370;
        bh=fbSaf1pHEa71zu32XebT2YPown4Kq5T5oozgDhCx+y4=;
        h=Date:From:To:Cc:Subject:From;
        b=XZdDeAgmyT5jlGOzHjctWbXbvpV7k9v8rToOTJsqxCimArBBLQkaD9uGR7eTjrYdg
         /YFQ/RZAIikDQ5NyF1CtO2ifJlWMoxM+5Scm+8xao9j3kuG1hcmj6NqxPObBnvWire
         dfA9Vm3rYO0BmNdQUI06dUEvfqcGkOu47TAaRSD8QoSTc8t71bKwLktoFCWyXL50qD
         K7J/r9IcOZpXJUhgjI42xLD0YnzUvXznsoCjDa5x8+sYNZ0E8HoIwzPsF8VjAkstKy
         dlhyFsQvoujeg/YaHSC9PEAuvH3epfG9D+3rGFtorEJkLsqUgq1Yhqd7Tu2jc0k2iH
         Ynl791grFe3Aw==
Date:   Tue, 4 Jan 2022 18:29:25 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     William Kucharski <william.kucharski@oracle.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the folio tree
Message-ID: <20220104182925.0ee8fd17@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/jiUas6EpUPf7oy=aeGL6jnH";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/jiUas6EpUPf7oy=aeGL6jnH
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the folio tree, today's linux-next build (powerpc
ppc64_defconfig) failed like this:

In file included from include/linux/socket.h:8,
                 from include/linux/compat.h:15,
                 from arch/powerpc/kernel/asm-offsets.c:12:
include/linux/uio.h: In function 'copy_folio_to_iter':
include/linux/uio.h:153:33: error: invalid use of undefined type 'struct fo=
lio'
  153 |  return copy_page_to_iter(&folio->page, offset, bytes, i);
      |                                 ^~

Caused by commit

  442f739136ee ("iov_iter: Add copy_folio_to_iter()")

struct folio is only forward declared in uio.h.  Presumably other builds
include mm_types.h indirectly.

I have used the folio tree from next-20211224 for today.

--=20
Cheers,
Stephen Rothwell

--Sig_/jiUas6EpUPf7oy=aeGL6jnH
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmHT91UACgkQAVBC80lX
0Gz/VAf5AQ2ft9hJ59Aqy5TN24eHmPgPM8FyqiVenW4jk5ma2BiWJIaaQ6I6tgC5
Trs85AIiKgEjajPfjgvcIeOqxdV4kVD20Ka+ZXTGnM5GQr6x0F3etKmmk/ZwRTwE
x0WJa7onjADcdyZyvorR4tj9XdqC8gIjO7DA3DHCIMUYSorV8J+NwK7jeRNdAMBu
F4hOsOpW7o2P+vW8NP9/6wnrWbZ+JRCPRlLxRfQmSdMqd2iGUVZAi28FFbqE1ReG
r9rH/mb7yZ/klMi5QjJ5cBbB1QYbve/OzbsAVxcGQv3CLH+QXJhexJ9KxQ8YLIUH
O45QBZ2zNiivo/2sBDGHA1EW9NjP1w==
=sFJK
-----END PGP SIGNATURE-----

--Sig_/jiUas6EpUPf7oy=aeGL6jnH--
