Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD95E51285F
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 03:00:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239876AbiD1BD4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 21:03:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239874AbiD1BDy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 21:03:54 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 120E442A18;
        Wed, 27 Apr 2022 18:00:33 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Kpcjq1bD4z4xLb;
        Thu, 28 Apr 2022 11:00:30 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1651107631;
        bh=mzl1zsy7DHmvyTHK6qnmEixG54pMXsdUPzzLOtswW3U=;
        h=Date:From:To:Cc:Subject:From;
        b=IawRtdf0t1sZym9gZ1uRt1aVPh1BEhZRFTc346cYNu2CCR6ydKpVfcuFjVpBqjzI8
         e9k8N0NtpjdT2UNx4ZqrNA8PvKnpYg74oGD3//0RA5Tn5qHOglBdTTiooSdu5xSWJT
         /zLPMZegozaspTHA2Xsk919dkTR7SvE1R9YHGcMfyXLb8Kf+cMU8YgPWzDBGAwkRKY
         6XCXCIVtUUTvla7TL7Ni0ycfVKteC/fnQj9kO7s93rKwWw9bEYS9RDZyad/CYZYjuk
         oVcoxU2HNFCSEIW4Kv8quz+q9X/ldg9EuWJb8kT4hNSt67qDCf89i1EgfZRkyl/Gjr
         pDQPiFZrCweAQ==
Date:   Thu, 28 Apr 2022 11:00:30 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Zhang Rui <rui.zhang@intel.com>,
        Artem Bityutskiy <artem.bityutskiy@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the pm tree
Message-ID: <20220428110030.7090a45b@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/QOcjZBC_Hhk3zbI+QXUkdw.";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/QOcjZBC_Hhk3zbI+QXUkdw.
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the pm tree, today's linux-next build (x86_64 allmodconfig)
failed like this:

drivers/idle/intel_idle.c: In function 'adl_idle_state_table_update':
drivers/idle/intel_idle.c:1701:17: error: 'disable_promotion_to_c1e' undecl=
ared (first use in this function)
 1701 |                 disable_promotion_to_c1e =3D true;
      |                 ^~~~~~~~~~~~~~~~~~~~~~~~
drivers/idle/intel_idle.c:1701:17: note: each undeclared identifier is repo=
rted only once for each function it appears in
drivers/idle/intel_idle.c:1706:9: error: implicit declaration of function '=
c1e_promotion_enable' [-Werror=3Dimplicit-function-declaration]
 1706 |         c1e_promotion_enable();
      |         ^~~~~~~~~~~~~~~~~~~~
drivers/idle/intel_idle.c: At top level:
drivers/idle/intel_idle.c:1854:13: error: conflicting types for 'c1e_promot=
ion_enable'; have 'void(void)' [-Werror]
 1854 | static void c1e_promotion_enable(void)
      |             ^~~~~~~~~~~~~~~~~~~~
drivers/idle/intel_idle.c:1854:13: error: static declaration of 'c1e_promot=
ion_enable' follows non-static declaration
drivers/idle/intel_idle.c:1706:9: note: previous implicit declaration of 'c=
1e_promotion_enable' with type 'void(void)'
 1706 |         c1e_promotion_enable();
      |         ^~~~~~~~~~~~~~~~~~~~

Caused by commit

  39c184a6a9a7 ("intel_idle: Fix the 'preferred_cstates' module parameter")

interacting with commit

  cc6e234b8264 ("intel_idle: Add AlderLake support")

Presumably this should have been fixed up in commit

  55ecda6f25ef ("Merge branch 'intel-idle' into linux-next")

I have used the pm tree from next-20220427 for today.

--=20
Cheers,
Stephen Rothwell

--Sig_/QOcjZBC_Hhk3zbI+QXUkdw.
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmJp5y4ACgkQAVBC80lX
0GwbzAgAly0iS4mrQudZx/5Y7NlhGXKItMlDSNnRv/sSJU3uF0iQwkO/oVsekX8Z
jRw3KZmpoMtnOhFepXSBdjfKz7QMRnQxPCmLjP3YTNhWoIPNlQuyf0lryycAdORO
I9lUlPK5xjwXGupnfTyPvzOP2QK8+ZxQtRpPyb0R7I+3uC71ipqGg6NiJIDFmYpH
UfVf2SnFZAHjS+au+uB9GWQVgzEl+VjD2j/Mni+6/RctGgoYosKh3eP1Y5WI86wl
XNavH2U/fo2qVZErtdtxru5hfrZDWHIFC8PXgmLdXWOKVR7YfxhtjZKVrQcDmfdi
N8enPGwTk/rnz20bnPbcBSRoLB1V5A==
=CJeI
-----END PGP SIGNATURE-----

--Sig_/QOcjZBC_Hhk3zbI+QXUkdw.--
