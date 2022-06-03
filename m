Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B69953C3D1
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jun 2022 06:43:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233303AbiFCEn2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jun 2022 00:43:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229665AbiFCEnX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jun 2022 00:43:23 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5428C36B59;
        Thu,  2 Jun 2022 21:43:22 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4LDqyD49Hlz4xD7;
        Fri,  3 Jun 2022 14:43:16 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1654231397;
        bh=bglz4sZohKUx/6D+QBESld/9ICNrShVB8JDfs7YyIfU=;
        h=Date:From:To:Cc:Subject:From;
        b=qJKuHNmJMjJi2+NNFWARfHNNivpwFUibxTpUMp0e0yuQxEOW2/0jengOgLE24Gkjv
         gnO0HpLlEcI3Vkw9MhDk8FAGjhDXNHNJcrqsg9mKVJujPlsp9lY0S2V1vnsxwh9J+A
         dZqDwrmC9XYzqXjPOppnSgOhhveI1CrkeQeDKgFdeaeMiMKTIo/lRKSkxU9hA4yfad
         3qxuNVMEsKvEgAy0ssDYLT44Vy/EL/B1G6DmtpG3VIl9sPzFT1yTJIYd9LqKav9CWC
         8q6KBpTI/oNZwmjbHG54iz5gI0tkoRFc5J7h2OEYQvgcYiAZsYdWp63Ih0zN8UBui8
         UeX0q7WDtd5fg==
Date:   Fri, 3 Jun 2022 14:43:15 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Alex Deucher <alexdeucher@gmail.com>
Cc:     Aurabindo Pillai <aurabindo.pillai@amd.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Dave Airlie <airlied@linux.ie>
Subject: linux-next: build failure after merge of the amdgpu tree
Message-ID: <20220603144315.5adcddbf@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/Iqqin6z3DvvDMuKuw08d4Nm";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/Iqqin6z3DvvDMuKuw08d4Nm
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the amdgpu tree, today's linux-next build (powerpc
allyesconfig) failed like this:

drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn32/display_mode_vba_32.c: I=
n function 'dml32_ModeSupportAndSystemConfigurationFull':
drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn32/display_mode_vba_32.c:38=
35:1: error: the frame size of 2752 bytes is larger than 2048 bytes [-Werro=
r=3Dframe-larger-than=3D]
 3835 | } // ModeSupportAndSystemConfigurationFull
      | ^
cc1: all warnings being treated as errors
make[5]: *** [scripts/Makefile.build:250: drivers/gpu/drm/amd/amdgpu/../dis=
play/dc/dml/dcn32/display_mode_vba_32.o] Error 1
gcc: error: unrecognized command-line option '-msse'
gcc: error: unrecognized command-line option '-msse2'
make[5]: *** [scripts/Makefile.build:251: drivers/gpu/drm/amd/amdgpu/../dis=
play/dc/dcn32/dcn32_resource.o] Error 1
gcc: error: unrecognized command-line option '-msse'
gcc: error: unrecognized command-line option '-msse2'

Caused (probably) by commits

  5cbb369e32bd ("drm/amd/display: DML changes for DCN32/321")
  b5dbe04a9c8c ("drm/amd/display: add CLKMGR changes for DCN32/321")
  4f185390597e ("drm/amd/display: add DCN32/321 specific files for Display =
Core")

I have used the amdgpu tree from next-20220601 again for today.

Is this new stuff really for the current merge window?  If so, it has
arrived pretty late.  If not then it should not have been in linux-next
at all ...
--=20
Cheers,
Stephen Rothwell

--Sig_/Iqqin6z3DvvDMuKuw08d4Nm
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmKZkWMACgkQAVBC80lX
0Gx4EAf/ZSx9kndMooybyfvl/xs9uQbnbTSizQDEhArCiLJM1qLiygS/A0Mdtbzn
P9kRJifpo59SKkvwyFuFpYXwoyXyDME26Ju7yJRVsNSCObTNS/CF3qb75Nb/Assf
Ch3rSAPHVgoHmOwrK0RFzIx33fcx+KdSNYL3OVG76CwByphadhRWMk8ptrZviWbz
u2FW4Tvn6xoQBBdgoowEZ5sNixC4WuFsTSkY/lEMHZp1z6wP05y64uNFmX+zoZXL
2meaojU51kUHzT5UfEHq3n7DVbgOGyHevG562utM0Vh/IV0+hd+hJZgWMVrsbCyG
H6jMzQLkwfLTzvY4MkSYqqRu7Np2tw==
=6k6h
-----END PGP SIGNATURE-----

--Sig_/Iqqin6z3DvvDMuKuw08d4Nm--
