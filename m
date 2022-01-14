Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8977C48E196
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 01:36:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238442AbiANAgr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 19:36:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238400AbiANAgq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 19:36:46 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee2:21ea])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3BFDC061574;
        Thu, 13 Jan 2022 16:36:45 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4JZj6H6r7Tz4xtf;
        Fri, 14 Jan 2022 11:36:39 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1642120600;
        bh=nACV+LjVxjYi12tPMg0p/WAn7P3DgqSJ0YPnJTcJhKQ=;
        h=Date:From:To:Cc:Subject:From;
        b=PSOWkDUdpZ0wGRS93EcY74xczwAZg+SwvPbmQhE5W1DpG5kJDqX0c/Z0Xa7haQgCh
         jINWXVcoYQf6M9LcoPaVh6vjLYfe9CA8N+32W9wngPH3eR+sDsnMyQmLt2QXBosHRl
         58G7TqOApd0EP6APf+PXDz8IPfokufrOaH5cjM/lnseUVt2ilm/jq+KB1UCcedRByZ
         Ta7Ggut5Y130sx7K9CGdioX+ubsslALMXRehDV327HLZxx+y5JpqDpjW6DiWEqOkkx
         fKDDSKOx2vAzZjcykt5LallJMR2MXDcOL6IZ+dzv7IvEkXYzIHkQ9oF2yJZU+zUN1D
         3wPEKNu/1sDXQ==
Date:   Fri, 14 Jan 2022 11:36:39 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Alex Deucher <alexdeucher@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Dave Airlie <airlied@linux.ie>
Subject: linux-next: build failure after merge of the amdgpu tree
Message-ID: <20220114113639.2e2cc115@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/VzoRggXv9sgl.a/DeHmK2rz";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/VzoRggXv9sgl.a/DeHmK2rz
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the amdgpu tree, today's linux-next build (x86_64
allmodconfig) failed like this:

drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc.c: In function 'program_ti=
ming_sync':
drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc.c:1409:17: error: 'struct =
dc_config' has no member named 'use_pipe_ctx_sync_logic'
 1409 |   if (dc->config.use_pipe_ctx_sync_logic) {
      |                 ^
drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc.c:1412:20: error: 'struct =
pipe_ctx' has no member named 'pipe_idx_syncd'
 1412 |     if (pipe_set[j]->pipe_idx_syncd =3D=3D pipe_set[0]->pipe_idx_sy=
ncd) {
      |                    ^~
drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc.c:1412:51: error: 'struct =
pipe_ctx' has no member named 'pipe_idx_syncd'
 1412 |     if (pipe_set[j]->pipe_idx_syncd =3D=3D pipe_set[0]->pipe_idx_sy=
ncd) {
      |                                                   ^~
drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc.c:1418:17: error: 'struct =
pipe_ctx' has no member named 'pipe_idx_syncd'
 1418 |      pipe_set[j]->pipe_idx_syncd =3D pipe_set[0]->pipe_idx_syncd;
      |                 ^~
drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc.c:1418:47: error: 'struct =
pipe_ctx' has no member named 'pipe_idx_syncd'
 1418 |      pipe_set[j]->pipe_idx_syncd =3D pipe_set[0]->pipe_idx_syncd;
      |                                               ^~

Caused by git doing a bad automatic merge with Linus' tree because commit

  75b950ef6166 ("Revert "drm/amd/display: Fix for otg synchronization logic=
"")

has been cherry-picked into the amdgpu tree and then a fixed version of
the reverted commit applied on top.  It would be easier if just a
fix up for the oriingal commit was added to the amdgpu tree, or Linus'
tree was merged into the amdgpu tree and then the fixed version applied.

I have used the amdgpu tree from next-20220113 for today.

--=20
Cheers,
Stephen Rothwell

--Sig_/VzoRggXv9sgl.a/DeHmK2rz
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmHgxZcACgkQAVBC80lX
0GzSEwf/T7jFWABx576CJeNAIeB3asMjIY4Mo0BBsQ9PDNrkUDo4sRPTeZfrvYyX
bWtxzoWcUeKRoofhjLm2Jg5c9Wnu3eN1+MvycCKzzPcHhhsB3b8ytRQB+h+/6muu
Wnl1lnKisFP2q7wZCTmILSm9HXdMBJ5Y4NfbCZvfMbNLlRMk7BdwGGWGLYLIT+UG
tPPtGRjWEh6H0QOJhDQ8i7zWlS26GI3OT/p3SRh5Dkl0oaPa1raOkFhaHyu0v9lS
Ub/wG7i3TG6hnH7p9/3p1y2AqHjKTl5q1rvugX0Ff47TK4zOcvz+rL/Z1sOKw8cg
4t7wjOt/mt39KErzLSSk9fbH6MUatg==
=QRxE
-----END PGP SIGNATURE-----

--Sig_/VzoRggXv9sgl.a/DeHmK2rz--
