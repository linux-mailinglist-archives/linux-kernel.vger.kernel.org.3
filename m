Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1D315A1EE2
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 04:36:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244826AbiHZCgs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 22:36:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244585AbiHZCgo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 22:36:44 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A13231A070;
        Thu, 25 Aug 2022 19:36:41 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4MDP9L1bD7z4wgv;
        Fri, 26 Aug 2022 12:36:37 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1661481400;
        bh=WGwi+ljsDERmTrvD7FgH6btCL+ApehLH36qFOcbf57k=;
        h=Date:From:To:Cc:Subject:From;
        b=WBEzthhTQQs+iXWxKaWDVGI0u9iYD2pChYgPY0IHYbppVAi7Tc6bluR2VIXd2FliO
         WoPTotj0msqCf5JATkcAs1sCATV7iB3CXizarRYPnkOCPBkXSelU0ISpl7FLsLShyO
         M0OAx8nEg8oIN8sIFN5WhUuV0tMXR7y1KCr+YyNZwU8yZylCMVXcsEV8Ib980vgwLk
         rftE65GoVQHzA/e1awr0ZWxzEjynQeXstYna4bSAbyFAy59KbBizRKta3Hd+XNAimX
         rjLOrqlkBcXjwKtwRrqINSlnVeNg0xIsUTwHza13Th9SrAX+I/ziVdYKvstfJ1AoYP
         zb5OFy7jZTBGw==
Date:   Fri, 26 Aug 2022 12:36:36 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Dave Airlie <airlied@linux.ie>
Cc:     Intel Graphics <intel-gfx@lists.freedesktop.org>,
        DRI <dri-devel@lists.freedesktop.org>,
        John Harrison <John.C.Harrison@Intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the drm-intel tree
Message-ID: <20220826123636.72fbea19@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/1fGKZE5_lC.5L6zFZWj1jcL";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/1fGKZE5_lC.5L6zFZWj1jcL
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the drm-intel tree, today's linux-next build (x86_64
allmodconfig) failed like this:

drivers/gpu/drm/i915/gt/uc/intel_guc.c: In function 'intel_guc_dump_time_in=
fo':
drivers/gpu/drm/i915/gt/uc/intel_guc.c:399:9: error: implicit declaration o=
f function 'intel_device_info_print_runtime'; did you mean 'intel_device_in=
fo_print'? [-Werror=3Dimplicit-function-declaration]
  399 |         intel_device_info_print_runtime(RUNTIME_INFO(gt->i915), p);
      |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
      |         intel_device_info_print

Caused by commit

  c7d3c8447b26 ("drm/i915: combine device info printing into one")

interacting with commit

  368d179adbac ("drm/i915/guc: Add GuC <-> kernel time stamp translation in=
formation")

from the drm tree.

I have applied the following merge fix patch for today:

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Fri, 26 Aug 2022 12:30:19 +1000
Subject: [PATCH] fix up for "drm/i915/guc: Add GuC <-> kernel time stamp tr=
anslation information"

interacting with "drm/i915: combine device info printing into one".

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 drivers/gpu/drm/i915/gt/uc/intel_guc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/gt/uc/intel_guc.c b/drivers/gpu/drm/i915/=
gt/uc/intel_guc.c
index ab4aacc516aa..977278d71182 100644
--- a/drivers/gpu/drm/i915/gt/uc/intel_guc.c
+++ b/drivers/gpu/drm/i915/gt/uc/intel_guc.c
@@ -396,7 +396,7 @@ void intel_guc_dump_time_info(struct intel_guc *guc, st=
ruct drm_printer *p)
 	u32 stamp =3D 0;
 	u64 ktime;
=20
-	intel_device_info_print_runtime(RUNTIME_INFO(gt->i915), p);
+	intel_device_info_print(INTEL_INFO(gt->i915), RUNTIME_INFO(gt->i915), p);
=20
 	with_intel_runtime_pm(&gt->i915->runtime_pm, wakeref)
 		stamp =3D intel_uncore_read(gt->uncore, GUCPMTIMESTAMP);
--=20
2.35.1

--=20
Cheers,
Stephen Rothwell

--Sig_/1fGKZE5_lC.5L6zFZWj1jcL
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmMIMbQACgkQAVBC80lX
0GxI3QgAon59yMGf5vKSdI+mDq+GhVj10XuhcnG2AhKKy0M2uPY/CBlzfXqowC8c
AEg5DD0Ey3NnrQxBTIZwXOcjzFSwVjP0+MzcdPKMU0dYer/CXQwGWThxR0adk0NM
d4yzTPxEd3BBWkVYd93OfN9YKZIYHyDjQ/lbrvsMyjrecdxYXiW3FeDbIWfIsTs2
gXtqIZ2m4yUDMG8QaWPzez1zQLt56TplzpT3Dk1KigGLNzNm34wf90OeEI/bBV35
W8UWCATVB98kwrfB/HsjJl+UNL8ALCq2qhqwfKHaBiyyjCahkWaJdCmSIFeulbKH
W0cq4noF+LWw+9k84aztFCZvYSKlsw==
=7x6E
-----END PGP SIGNATURE-----

--Sig_/1fGKZE5_lC.5L6zFZWj1jcL--
