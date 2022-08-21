Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4408B59B6CF
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 01:45:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231545AbiHUXoy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Aug 2022 19:44:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231322AbiHUXox (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Aug 2022 19:44:53 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D7CB19294;
        Sun, 21 Aug 2022 16:44:48 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4M9sXt0v2mz4wgn;
        Mon, 22 Aug 2022 09:44:45 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1661125486;
        bh=X0n9GqbhrS9frPNon4rXDdshJXUhq9T76USIoiiiOdU=;
        h=Date:From:To:Cc:Subject:From;
        b=AMOv2vhiSpC0Pc10PvbZ8Z6CTZtB2ZyHBGrzDzl/72YdPUOorczupEqn/BMWowpAc
         k9bom61QWJWAmcG7VQf0kuyTUSUkGDL7T3xtzt28EybY6zHiGahov2rpuyFydKrEQI
         pfbTwz11L/5OFzU94Iu0NsbAhInhmHxYEJtitu1RwFcYajmJg0ZkobmaLtI38oBwvo
         0yVlOK5j/VVVTOqemjpD+Q8JXk0ynuJnFu6U8QuVFw8sAMgb6Zpa20ks1PanGDlmOu
         xi4AGh4TTDYT/K2+RrF9V2KpJSMi9x5cAifSwUEZ2Q4Iblqqtr3Aik/IliNRdX2a8j
         BJFSnu5HMySFw==
Date:   Mon, 22 Aug 2022 09:44:40 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     David Sterba <dsterba@suse.cz>
Cc:     Ethan Lien <ethanlien@synology.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the btrfs tree
Message-ID: <20220822094440.67bf94b8@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/B.yTOmGhC3Ip_nUtIKVVJDs";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/B.yTOmGhC3Ip_nUtIKVVJDs
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the btrfs tree, today's linux-next build (x86_64
allmodconfig) failed like this:

fs/btrfs/extent_io.c: In function 'btrfs_do_readpage':
fs/btrfs/extent_io.c:3613:13: error: variable 'cur_end' set but not used [-=
Werror=3Dunused-but-set-variable]
 3613 |         u64 cur_end;
      |             ^~~~~~~
fs/btrfs/inode.c: In function 'btrfs_get_extent':
fs/btrfs/inode.c:6872:32: error: unused variable 'io_tree' [-Werror=3Dunuse=
d-variable]
 6872 |         struct extent_io_tree *io_tree =3D &inode->io_tree;
      |                                ^~~~~~~

Caused by commit

  a4ae8f42bbcf ("btrfs: remove unnecessary EXTENT_UPTODATE state in buffere=
d I/O path")

I have used the btrfs tree from next-20220819 for today.

--=20
Cheers,
Stephen Rothwell

--Sig_/B.yTOmGhC3Ip_nUtIKVVJDs
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmMCw2gACgkQAVBC80lX
0Gwq4wf/dP3/Qvff2/EMJmw2Ra75onrD3n7GcXLaV4QRRYtu8uGKDRd2soaFarhA
2OfnwIAIWtiCyx47JZ6C4un2aFOI8gR8NMz4Cm9nL5GvJkIZP0FgrjG5WefTt1sJ
Zka3/Ez2yKxGH8/OlDJ4uawVn1l94rwXSXn23ZVkLX6ORX7am31UT/89rWaE4zMI
VggjGixLocNkKZ0AdEqEPwuB0jyqQsFPDtSV8cSjxekSwL+QvP9k6Hh0KK6p+y3+
dbs8Jxu4P2SU7O/SvawRXjjrKvHF/zG1gBIfm/8ZW+fJA/SuJGN30Wl9NPCGBTZn
8fcq6n28USBPBiUxzWODH58NO8NcRQ==
=RLa4
-----END PGP SIGNATURE-----

--Sig_/B.yTOmGhC3Ip_nUtIKVVJDs--
