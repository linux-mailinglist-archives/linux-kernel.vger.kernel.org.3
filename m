Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B3CF53B081
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 02:34:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232706AbiFBAaW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 20:30:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232732AbiFBAaT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 20:30:19 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 182A521CBE4;
        Wed,  1 Jun 2022 17:30:18 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4LD6Nj2FWgz4xD3;
        Thu,  2 Jun 2022 10:30:13 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1654129813;
        bh=+1q/22m1IHM/P5rHSZFvEoy7FzOr9cvRUyGbisuWivk=;
        h=Date:From:To:Cc:Subject:From;
        b=XM4pwS/0KvrDfY8Aoi3vCmr2GfLPS1lHJSvwbii0420b5rlRdjzdXahnrQN22+LJR
         hLnKet7fTqH4bft9cPHgr0xPCRDhtGTKv9+Iu1nqzvuvwr6sd6bBmixoD1Zhzu5ZNN
         yiJlcq08EOO+gnDp4CdRyJNghQNQao9ykdztdJyAl1rStlfRjTTPG54vVAa0IZ+gT5
         Hh+o39TGOvcO68ClMWIVN4I2hI23Yey8k1h49t7loV3UrP6nyHHoswHg1KxYX3UHsV
         tB3zyQilIj3zzbvWVF74GNtTVbkeppRQ5Cw4w3x8d+N5+VdT68GHer4EBxmk37Xwcn
         xdSBUsoebs9mA==
Date:   Thu, 2 Jun 2022 10:30:12 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Alex Deucher <alexdeucher@gmail.com>
Cc:     Aurabindo Pillai <aurabindo.pillai@amd.com>,
        Dave Airlie <airlied@linux.ie>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the amdgpu tree
Message-ID: <20220602103012.7534a2f4@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/blWPP1MO.JVA3bMKI.ChseV";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/blWPP1MO.JVA3bMKI.ChseV
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the amdgpu tree, today's linux-next build (x86_64
allmodconfig) failed like this:

drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc_resource.c:1835:13: error:=
 'remove_hpo_dp_link_enc_from_ctx' defined but not used [-Werror=3Dunused-f=
unction]
 1835 | static void remove_hpo_dp_link_enc_from_ctx(struct resource_context=
 *res_ctx,
      |             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Caused by commit

  9b0e0d433f74 ("drm/amd/display: Add dependant changes for DCN32/321")

I have used the amdgpu tree from next-20220601 for today.

--=20
Cheers,
Stephen Rothwell

--Sig_/blWPP1MO.JVA3bMKI.ChseV
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmKYBJQACgkQAVBC80lX
0GxTjQf/QgDfg69hsmBLIMXRzgB2EHnsHoAvVuaFL21zkZIvne/+lLzh5boMoCmQ
/7+hR1jt1CkGN+e0P4njB9YXqw7kTHWbIomGsLOfJfLoNQqP3MQtS8c/YLxhKBeg
NGgtW/qbaaID6krqWsonqX+q0rRTHMUf7tODCWWtFCUGUy2BgFFM5px93YmOsQve
F4iblC3ig2pF0aSBeaRbOGQ5Syyr21TBMcjwGFV4z4OFMnGFGOceBZSmGxSLKP5u
KSCTHDPPAJbGyMiXq4Osz04c+2eVhrUmFD9LRGBfxNI0psfSt/MXbxuZP/BtrW49
6r+K9arOPSruZ67lV4OF2mahxifmtw==
=TT6V
-----END PGP SIGNATURE-----

--Sig_/blWPP1MO.JVA3bMKI.ChseV--
