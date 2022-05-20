Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9705D52E180
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 03:03:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344194AbiETBDV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 21:03:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232272AbiETBDT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 21:03:19 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 841C712389C;
        Thu, 19 May 2022 18:03:17 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4L47kq36zlz4xD8;
        Fri, 20 May 2022 11:03:15 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1653008595;
        bh=2KiUI1LFp2/RuCVP95ICiES2mQtaFZEYTiOZo52wFhA=;
        h=Date:From:To:Cc:Subject:From;
        b=gNI/xJbP+pCH6wE/95q6b3vlcIeFS+Tfu8NkApUWRkXd0dekmHWncyQ1rL4HTMc1W
         woDWDNlwhnT9QDrUmZwxUIOEXF22T8Axv5F7JSU3xC23ixNL5Zn9ACYR6dYrl3nZuo
         MqaA5rw360UImwN7Ela5tZEJLRNuVNPv8pMeTB9xKeYpt2UMUQ7nhfswzWPHKTJka8
         oOOdeP1bAVT2XRIZIlX9nW1Qm+ikZuePI4v/a8T29ICxQjKZEdZEi0KiJOto8D8vw6
         DgXsOpkR/KcnrZ4VpgnRRrFwjIxUrdV+2vDkkJCGJpNk81l692gpNXt4gik0Hdzfle
         Eg1DMomDdF6pA==
Date:   Fri, 20 May 2022 11:03:13 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     Eric Biggers <ebiggers@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build warning after merge of the ext4 tree
Message-ID: <20220520110313.48a824c4@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/WmAeyEYg6Fpy80lvNUt4M+C";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/WmAeyEYg6Fpy80lvNUt4M+C
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the ext4 tree, today's linux-next build (powerpc
ppc64_defconfig) produced this warning:

fs/ext4/super.c: In function 'ext4_check_test_dummy_encryption':
fs/ext4/super.c:2677:36: warning: unused variable 'sbi' [-Wunused-variable]
 2677 |         const struct ext4_sb_info *sbi =3D EXT4_SB(sb);
      |                                    ^~~

Introduced by commit

  0df27ddf69f3 ("ext4: only allow test_dummy_encryption when supported")

--=20
Cheers,
Stephen Rothwell

--Sig_/WmAeyEYg6Fpy80lvNUt4M+C
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmKG6NEACgkQAVBC80lX
0GzBOQf+JHu94bQeLTnt7pBiSDW8BMtqNQwrB+P3jEYDjWvoWObFbUVrU/YHRcgM
deSHeO4mAVVc/2skT/C55c8qSrjj2+1nyW7S5FxhZhr5soTL+OKz5Ksgt0CBUnDP
IQj8pjfB2jWGRrod9PG3DphYi2ys5AR6fnYa7IQ8lWZv7LBV3iBoULMpETT5L6Au
aVyYbQhSeydpiUTHf9ZNLtH7h5qhQ1vOlxamLJv+gBr0sZBewVKOF5LIgECNAeEp
aNIcH/Nj7lm6RabZmbsN0gjWnGzIJv4n5aCvZJlPv+cQgxEv7BRAdkdiFHaLEQUn
/ByRKnDlKv49kEG4xo32BpklDLlZeg==
=BY1V
-----END PGP SIGNATURE-----

--Sig_/WmAeyEYg6Fpy80lvNUt4M+C--
