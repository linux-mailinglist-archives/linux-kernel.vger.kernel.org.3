Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D9134AB3EC
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 07:12:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237000AbiBGFuA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 00:50:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229793AbiBGEG7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Feb 2022 23:06:59 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FF57C061A73;
        Sun,  6 Feb 2022 20:06:58 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4JsXdr4h8Nz4xPv;
        Mon,  7 Feb 2022 15:06:56 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1644206816;
        bh=L6tKb33/O1w3gvZdBQUa7i+NvihKIKciWhy/zQyQ8EM=;
        h=Date:From:To:Cc:Subject:From;
        b=DoHMl4lOHO/bta48hMqe2PY4/ki4vc8iBXRLeHC4meXA3wPehPG02uvQqe41fxSDY
         ZbvbmfYtMB+kvzfCJzCzaJA+Gifuw9ZVZu4wqgHeIsKVwOlf0J+CRwydBs4fNrNPQQ
         kfvmiCpetOsj6XSzfnWBkpK0PskeGP68SfybJAKZO8QiE5OPcASav9qTQzCvWffSly
         SFLBpzotTPbd85B/VrfINcUVgN367/zRXlL3vyqZHPEwaqWuSsAhbWXK31Fh2BQH3u
         mWs+jDbCbD7/ACz7JFFjJ99B8A+FPGutBHTQzRR0Ogf/R97oHrHS9BPDRj76v4Uhsh
         ycZo0gM/K/Lkg==
Date:   Mon, 7 Feb 2022 15:06:55 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Yang Shi <shy828301@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build warning after merge of the akpm-current tree
Message-ID: <20220207150655.76173d43@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/zfn5waytRg/k5PpHJZdDabO";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/zfn5waytRg/k5PpHJZdDabO
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the akpm-current tree, today's linux-next build (arm
multi_v7_defconfig) produced this warning:

fs/proc/task_mmu.c: In function 'pagemap_pmd_range':
fs/proc/task_mmu.c:1444:14: warning: unused variable 'migration' [-Wunused-=
variable]
 1444 |         bool migration =3D false;
      |              ^~~~~~~~~

Introduced by commit

  78cff485ae77 ("fs-proc-task_mmuc-dont-read-mapcount-for-migration-entry-v=
4")

"migration" is only used when CONFIG_TRANSPARENT_HUGEPAGE is defined.

--=20
Cheers,
Stephen Rothwell

--Sig_/zfn5waytRg/k5PpHJZdDabO
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmIAmt8ACgkQAVBC80lX
0GxfCQf/QG/+1XHNBO6hv4bMP+crdvPVf7yKTsT6l/fRRUqH53KGHyLQmk14TtRY
cN/3mV0qhyXp9RTYQfQp8ktefPpREci8IGCmR7tU1qQ9NtA1AL1E2JD1H0cHmPXO
3dqHD2tl5uixPCDdDSSeBBKwlyGIWJsUKJjrWc+mMqt8zi34pORlCwoDu/MKtNMf
JgVnKY6nKfcfUzzGz10+oFGLKVEbQBUkQ2pBg3FMm9J/iVpcVkUF6tdLPkyvAvQJ
o9W8DUAmx4CDwj6wVoz0ih+cI2JNCXrqor+OLJmaZFNa+rtc4goSoVYbgDGxH1va
V3jf2g+eytTtwTUwB/KzGnV2LyrOaw==
=ka1T
-----END PGP SIGNATURE-----

--Sig_/zfn5waytRg/k5PpHJZdDabO--
