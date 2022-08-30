Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BD635A58EA
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 03:41:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229596AbiH3Bln (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 21:41:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbiH3Blm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 21:41:42 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81FBB7C195;
        Mon, 29 Aug 2022 18:41:40 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4MGqlz2j7vz4x7X;
        Tue, 30 Aug 2022 11:41:35 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1661823695;
        bh=P+lb/tIYQq6aag2PQYjfBDSH2pP3UDS2e1DSqGU3JXU=;
        h=Date:From:To:Cc:Subject:From;
        b=comR83GscCRaACGVrchJfsTYOJLBM8wz/rrXxPFs2nVmbzaFPjaeW+e+YPgyB3iBi
         NFgAS4lFl6P4bizsbYOoorNy8unjlElQeZVgBzMhY4loDLWV011TTXMs7y2CQZXhnY
         0XOzXkL9O0fmw1LsFx7fXv+1oGACYRwfTPqMay+ZMwawEIPTEi921WyDRBEOlWB8Il
         ui68KKAj9zvdqKqAgA/GBD+bQ9o8dDo80+YbZkjrHIVNIaDal14HnpFOmIEYieqsKt
         XXDeWZ1Toh495tfPT3oh7f/z+Qp7Pnn9cXUPTYvGkp2/mJbal9Dd8gE1EJPFTQhSye
         yEXhYI/4lPzOA==
Date:   Tue, 30 Aug 2022 11:41:33 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Alex Deucher <alexdeucher@gmail.com>
Cc:     Alvin Lee <Alvin.Lee2@amd.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Jun Lei <Jun.Lei@amd.com>, Brian Chang <Brian.Chang@amd.com>,
        Daniel Wheeler <daniel.wheeler@amd.com>
Subject: linux-next: build failure after merge of the amdgpu tree
Message-ID: <20220830114133.161cab26@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/KZqTmWIR6HoazZO_yCryzKI";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/KZqTmWIR6HoazZO_yCryzKI
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the amdgpu tree, today's linux-next build (x86_64
allmodconfig) failed like this:

drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc.c: In function 'commit_pla=
nes_for_stream':
drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc.c:3508:9: error: this 'if'=
 clause does not guard... [-Werror=3Dmisleading-indentation]
 3508 |         if (update_type !=3D UPDATE_TYPE_FAST)
      |         ^~
drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc.c:3510:17: note: ...this s=
tatement, but the latter is misleadingly indented as if it were guarded by =
the 'if'
 3510 |                 if (update_type !=3D UPDATE_TYPE_FAST)
      |                 ^~
cc1: all warnings being treated as errors

Caused by commit

  e990bd60716d ("drm/amd/display: Only commit SubVP state after pipe progra=
mming")

I have used the amdgpu tree from next-20220829 for today.

--=20
Cheers,
Stephen Rothwell

--Sig_/KZqTmWIR6HoazZO_yCryzKI
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmMNas0ACgkQAVBC80lX
0GzS+Af/XDEAZJ5n3TSpmiFRGHMR2DGBPTnEbCMXgsqXcHlQ0yKlfNVC/gZT3UMO
gBGaAolh3uD+SLweKzztMBBr4qdEO/GaitsqtCQaWyjRkmFSJ3GGx3L7G1xjhjhB
QM0WO/IeNvutl8SrvkLjmKoDuC1oRskUU73+URA4owsr14X0fP+h/0iFtvX4+Kde
/ezeL1eqhyjZ7mhJOSjqMbBn8t3DcqM3/HNG3gPGH37m7EKsfcWLYfkO6iUF6JLl
CWYa59sNfmdixeRkYWwxur7/wBRcUNqjUEZTAzbSIGXVpmOoWR4QOC8VZqo1ea2J
DJ3hCoOgWEtXEMlo37ITqoCLMDE1ZQ==
=RFpT
-----END PGP SIGNATURE-----

--Sig_/KZqTmWIR6HoazZO_yCryzKI--
