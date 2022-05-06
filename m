Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EA4151CE08
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 04:16:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1387778AbiEFBKf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 21:10:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232783AbiEFBKe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 21:10:34 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3B414C79D;
        Thu,  5 May 2022 18:06:52 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4KvXTM0bRQz4x7V;
        Fri,  6 May 2022 11:06:47 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1651799207;
        bh=irAcjDvWa15gXKCYWX8jLjN/S5XkcQ3nAmjiGK9I44k=;
        h=Date:From:To:Cc:Subject:From;
        b=cQ2szLTzD/WXSMYsv+d1ljTeLoSf9NBKExT8UwsRmNtbyVhmiMRYhfbbLmmhZHONW
         N4+iY5jchUehLwLlXDPD3qYEKspMnXaR4VMPys783JSmE9rZiRPSIEDoq/EJgeyZpf
         AZFDQo2+AhnvrhNDPda+Bneq7ZUNVlT94dFOla/wd/69cuh2vLF2zaQQDiGTOaCCau
         dOM2kWAWJM5FOxa0AYaZpQt/SXxpr+W4GHQH+BslKE4AhLnlux4sECDXK/4zJUGgAP
         b6cgL8/rgXNXfoSxlFIIQrH5uZmfqtCm9Q7xFT2GgMxDHuakLcv/1pLFXnJnino3Ns
         9LAS0uI4J2RBA==
Date:   Fri, 6 May 2022 11:06:46 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Alex Deucher <alexdeucher@gmail.com>
Cc:     Kenneth Feng <kenneth.feng@amd.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the amdgpu tree
Message-ID: <20220506110646.1eb41dbf@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/pqbz3eLRMHghE6honk4+7Vf";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/pqbz3eLRMHghE6honk4+7Vf
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the amdgpu tree, today's linux-next build (x86_64
allmodconfig) failed like this:

drivers/gpu/drm/amd/amdgpu/../pm/swsmu/smu13/smu_v13_0_7_ppt.c: In function=
 'smu_v13_0_7_get_power_profile_mode':
drivers/gpu/drm/amd/amdgpu/../pm/swsmu/smu13/smu_v13_0_7_ppt.c:1364:84: err=
or: array subscript 8 is above array bounds of 'DpmActivityMonitorCoeffIntE=
xternal_t[8]' [-Werror=3Darray-bounds]
 1364 |                 size +=3D sysfs_emit_at(buf, size, "%-16d", activit=
y_monitor_external[i].DpmActivityMonitorCoeffInt.field);               \
      |                                                           ~~~~~~~~~=
~~~~~~~~~~~~~~~~^~~
drivers/gpu/drm/amd/amdgpu/../pm/swsmu/smu13/smu_v13_0_7_ppt.c:1381:9: note=
: in expansion of macro 'PRINT_DPM_MONITOR'
 1381 |         PRINT_DPM_MONITOR(Fclk_BoosterFreq);
      |         ^~~~~~~~~~~~~~~~~
drivers/gpu/drm/amd/amdgpu/../pm/swsmu/smu13/smu_v13_0_7_ppt.c:1328:46: not=
e: while referencing 'activity_monitor_external'
 1328 |         DpmActivityMonitorCoeffIntExternal_t activity_monitor_exter=
nal[PP_SMC_POWER_PROFILE_COUNT];
      |                                              ^~~~~~~~~~~~~~~~~~~~~~=
~~~
drivers/gpu/drm/amd/amdgpu/../pm/swsmu/smu13/smu_v13_0_7_ppt.c:1364:84: err=
or: array subscript 8 is above array bounds of 'DpmActivityMonitorCoeffIntE=
xternal_t[8]' [-Werror=3Darray-bounds]
 1364 |                 size +=3D sysfs_emit_at(buf, size, "%-16d", activit=
y_monitor_external[i].DpmActivityMonitorCoeffInt.field);               \
      |                                                           ~~~~~~~~~=
~~~~~~~~~~~~~~~~^~~
drivers/gpu/drm/amd/amdgpu/../pm/swsmu/smu13/smu_v13_0_7_ppt.c:1380:9: note=
: in expansion of macro 'PRINT_DPM_MONITOR'
 1380 |         PRINT_DPM_MONITOR(Fclk_MinActiveFreq);
      |         ^~~~~~~~~~~~~~~~~
drivers/gpu/drm/amd/amdgpu/../pm/swsmu/smu13/smu_v13_0_7_ppt.c:1328:46: not=
e: while referencing 'activity_monitor_external'
 1328 |         DpmActivityMonitorCoeffIntExternal_t activity_monitor_exter=
nal[PP_SMC_POWER_PROFILE_COUNT];
      |                                              ^~~~~~~~~~~~~~~~~~~~~~=
~~~
drivers/gpu/drm/amd/amdgpu/../pm/swsmu/smu13/smu_v13_0_7_ppt.c:1364:84: err=
or: array subscript 8 is above array bounds of 'DpmActivityMonitorCoeffIntE=
xternal_t[8]' [-Werror=3Darray-bounds]
 1364 |                 size +=3D sysfs_emit_at(buf, size, "%-16d", activit=
y_monitor_external[i].DpmActivityMonitorCoeffInt.field);               \
      |                                                           ~~~~~~~~~=
~~~~~~~~~~~~~~~~^~~
drivers/gpu/drm/amd/amdgpu/../pm/swsmu/smu13/smu_v13_0_7_ppt.c:1379:9: note=
: in expansion of macro 'PRINT_DPM_MONITOR'
 1379 |         PRINT_DPM_MONITOR(Fclk_BoosterFreqType);
      |         ^~~~~~~~~~~~~~~~~
drivers/gpu/drm/amd/amdgpu/../pm/swsmu/smu13/smu_v13_0_7_ppt.c:1328:46: not=
e: while referencing 'activity_monitor_external'
 1328 |         DpmActivityMonitorCoeffIntExternal_t activity_monitor_exter=
nal[PP_SMC_POWER_PROFILE_COUNT];
      |                                              ^~~~~~~~~~~~~~~~~~~~~~=
~~~
drivers/gpu/drm/amd/amdgpu/../pm/swsmu/smu13/smu_v13_0_7_ppt.c:1364:84: err=
or: array subscript 8 is above array bounds of 'DpmActivityMonitorCoeffIntE=
xternal_t[8]' [-Werror=3Darray-bounds]
 1364 |                 size +=3D sysfs_emit_at(buf, size, "%-16d", activit=
y_monitor_external[i].DpmActivityMonitorCoeffInt.field);               \
      |                                                           ~~~~~~~~~=
~~~~~~~~~~~~~~~~^~~
drivers/gpu/drm/amd/amdgpu/../pm/swsmu/smu13/smu_v13_0_7_ppt.c:1378:9: note=
: in expansion of macro 'PRINT_DPM_MONITOR'
 1378 |         PRINT_DPM_MONITOR(Fclk_MinActiveFreqType);
      |         ^~~~~~~~~~~~~~~~~
drivers/gpu/drm/amd/amdgpu/../pm/swsmu/smu13/smu_v13_0_7_ppt.c:1328:46: not=
e: while referencing 'activity_monitor_external'
 1328 |         DpmActivityMonitorCoeffIntExternal_t activity_monitor_exter=
nal[PP_SMC_POWER_PROFILE_COUNT];
      |                                              ^~~~~~~~~~~~~~~~~~~~~~=
~~~
drivers/gpu/drm/amd/amdgpu/../pm/swsmu/smu13/smu_v13_0_7_ppt.c:1364:84: err=
or: array subscript 8 is above array bounds of 'DpmActivityMonitorCoeffIntE=
xternal_t[8]' [-Werror=3Darray-bounds]
 1364 |                 size +=3D sysfs_emit_at(buf, size, "%-16d", activit=
y_monitor_external[i].DpmActivityMonitorCoeffInt.field);               \
      |                                                           ~~~~~~~~~=
~~~~~~~~~~~~~~~~^~~
drivers/gpu/drm/amd/amdgpu/../pm/swsmu/smu13/smu_v13_0_7_ppt.c:1377:9: note=
: in expansion of macro 'PRINT_DPM_MONITOR'
 1377 |         PRINT_DPM_MONITOR(Fclk_FPS);
      |         ^~~~~~~~~~~~~~~~~
drivers/gpu/drm/amd/amdgpu/../pm/swsmu/smu13/smu_v13_0_7_ppt.c:1328:46: not=
e: while referencing 'activity_monitor_external'
 1328 |         DpmActivityMonitorCoeffIntExternal_t activity_monitor_exter=
nal[PP_SMC_POWER_PROFILE_COUNT];
      |                                              ^~~~~~~~~~~~~~~~~~~~~~=
~~~
drivers/gpu/drm/amd/amdgpu/../pm/swsmu/smu13/smu_v13_0_7_ppt.c:1364:84: err=
or: array subscript 8 is above array bounds of 'DpmActivityMonitorCoeffIntE=
xternal_t[8]' [-Werror=3Darray-bounds]
 1364 |                 size +=3D sysfs_emit_at(buf, size, "%-16d", activit=
y_monitor_external[i].DpmActivityMonitorCoeffInt.field);               \
      |                                                           ~~~~~~~~~=
~~~~~~~~~~~~~~~~^~~
drivers/gpu/drm/amd/amdgpu/../pm/swsmu/smu13/smu_v13_0_7_ppt.c:1376:9: note=
: in expansion of macro 'PRINT_DPM_MONITOR'
 1376 |         PRINT_DPM_MONITOR(Fclk_IdleHystLimit);
      |         ^~~~~~~~~~~~~~~~~
drivers/gpu/drm/amd/amdgpu/../pm/swsmu/smu13/smu_v13_0_7_ppt.c:1328:46: not=
e: while referencing 'activity_monitor_external'
 1328 |         DpmActivityMonitorCoeffIntExternal_t activity_monitor_exter=
nal[PP_SMC_POWER_PROFILE_COUNT];
      |                                              ^~~~~~~~~~~~~~~~~~~~~~=
~~~
drivers/gpu/drm/amd/amdgpu/../pm/swsmu/smu13/smu_v13_0_7_ppt.c:1364:84: err=
or: array subscript 8 is above array bounds of 'DpmActivityMonitorCoeffIntE=
xternal_t[8]' [-Werror=3Darray-bounds]
 1364 |                 size +=3D sysfs_emit_at(buf, size, "%-16d", activit=
y_monitor_external[i].DpmActivityMonitorCoeffInt.field);               \
      |                                                           ~~~~~~~~~=
~~~~~~~~~~~~~~~~^~~
drivers/gpu/drm/amd/amdgpu/../pm/swsmu/smu13/smu_v13_0_7_ppt.c:1375:9: note=
: in expansion of macro 'PRINT_DPM_MONITOR'
 1375 |         PRINT_DPM_MONITOR(Fclk_ActiveHystLimit);
      |         ^~~~~~~~~~~~~~~~~
drivers/gpu/drm/amd/amdgpu/../pm/swsmu/smu13/smu_v13_0_7_ppt.c:1328:46: not=
e: while referencing 'activity_monitor_external'
 1328 |         DpmActivityMonitorCoeffIntExternal_t activity_monitor_exter=
nal[PP_SMC_POWER_PROFILE_COUNT];
      |                                              ^~~~~~~~~~~~~~~~~~~~~~=
~~~
drivers/gpu/drm/amd/amdgpu/../pm/swsmu/smu13/smu_v13_0_7_ppt.c:1364:84: err=
or: array subscript 8 is above array bounds of 'DpmActivityMonitorCoeffIntE=
xternal_t[8]' [-Werror=3Darray-bounds]
 1364 |                 size +=3D sysfs_emit_at(buf, size, "%-16d", activit=
y_monitor_external[i].DpmActivityMonitorCoeffInt.field);               \
      |                                                           ~~~~~~~~~=
~~~~~~~~~~~~~~~~^~~
drivers/gpu/drm/amd/amdgpu/../pm/swsmu/smu13/smu_v13_0_7_ppt.c:1374:9: note=
: in expansion of macro 'PRINT_DPM_MONITOR'
 1374 |         PRINT_DPM_MONITOR(Gfx_BoosterFreq);
      |         ^~~~~~~~~~~~~~~~~
drivers/gpu/drm/amd/amdgpu/../pm/swsmu/smu13/smu_v13_0_7_ppt.c:1328:46: not=
e: while referencing 'activity_monitor_external'
 1328 |         DpmActivityMonitorCoeffIntExternal_t activity_monitor_exter=
nal[PP_SMC_POWER_PROFILE_COUNT];
      |                                              ^~~~~~~~~~~~~~~~~~~~~~=
~~~
drivers/gpu/drm/amd/amdgpu/../pm/swsmu/smu13/smu_v13_0_7_ppt.c:1364:84: err=
or: array subscript 8 is above array bounds of 'DpmActivityMonitorCoeffIntE=
xternal_t[8]' [-Werror=3Darray-bounds]
 1364 |                 size +=3D sysfs_emit_at(buf, size, "%-16d", activit=
y_monitor_external[i].DpmActivityMonitorCoeffInt.field);               \
      |                                                           ~~~~~~~~~=
~~~~~~~~~~~~~~~~^~~
drivers/gpu/drm/amd/amdgpu/../pm/swsmu/smu13/smu_v13_0_7_ppt.c:1373:9: note=
: in expansion of macro 'PRINT_DPM_MONITOR'
 1373 |         PRINT_DPM_MONITOR(Gfx_MinActiveFreq);
      |         ^~~~~~~~~~~~~~~~~
drivers/gpu/drm/amd/amdgpu/../pm/swsmu/smu13/smu_v13_0_7_ppt.c:1328:46: not=
e: while referencing 'activity_monitor_external'
 1328 |         DpmActivityMonitorCoeffIntExternal_t activity_monitor_exter=
nal[PP_SMC_POWER_PROFILE_COUNT];
      |                                              ^~~~~~~~~~~~~~~~~~~~~~=
~~~
drivers/gpu/drm/amd/amdgpu/../pm/swsmu/smu13/smu_v13_0_7_ppt.c:1364:84: err=
or: array subscript 8 is above array bounds of 'DpmActivityMonitorCoeffIntE=
xternal_t[8]' [-Werror=3Darray-bounds]
 1364 |                 size +=3D sysfs_emit_at(buf, size, "%-16d", activit=
y_monitor_external[i].DpmActivityMonitorCoeffInt.field);               \
      |                                                           ~~~~~~~~~=
~~~~~~~~~~~~~~~~^~~
drivers/gpu/drm/amd/amdgpu/../pm/swsmu/smu13/smu_v13_0_7_ppt.c:1372:9: note=
: in expansion of macro 'PRINT_DPM_MONITOR'
 1372 |         PRINT_DPM_MONITOR(Gfx_BoosterFreqType);
      |         ^~~~~~~~~~~~~~~~~
drivers/gpu/drm/amd/amdgpu/../pm/swsmu/smu13/smu_v13_0_7_ppt.c:1328:46: not=
e: while referencing 'activity_monitor_external'
 1328 |         DpmActivityMonitorCoeffIntExternal_t activity_monitor_exter=
nal[PP_SMC_POWER_PROFILE_COUNT];
      |                                              ^~~~~~~~~~~~~~~~~~~~~~=
~~~
drivers/gpu/drm/amd/amdgpu/../pm/swsmu/smu13/smu_v13_0_7_ppt.c:1364:84: err=
or: array subscript 8 is above array bounds of 'DpmActivityMonitorCoeffIntE=
xternal_t[8]' [-Werror=3Darray-bounds]
 1364 |                 size +=3D sysfs_emit_at(buf, size, "%-16d", activit=
y_monitor_external[i].DpmActivityMonitorCoeffInt.field);               \
      |                                                           ~~~~~~~~~=
~~~~~~~~~~~~~~~~^~~
drivers/gpu/drm/amd/amdgpu/../pm/swsmu/smu13/smu_v13_0_7_ppt.c:1371:9: note=
: in expansion of macro 'PRINT_DPM_MONITOR'
 1371 |         PRINT_DPM_MONITOR(Gfx_MinActiveFreqType);
      |         ^~~~~~~~~~~~~~~~~
drivers/gpu/drm/amd/amdgpu/../pm/swsmu/smu13/smu_v13_0_7_ppt.c:1328:46: not=
e: while referencing 'activity_monitor_external'
 1328 |         DpmActivityMonitorCoeffIntExternal_t activity_monitor_exter=
nal[PP_SMC_POWER_PROFILE_COUNT];
      |                                              ^~~~~~~~~~~~~~~~~~~~~~=
~~~
drivers/gpu/drm/amd/amdgpu/../pm/swsmu/smu13/smu_v13_0_7_ppt.c:1364:84: err=
or: array subscript 8 is above array bounds of 'DpmActivityMonitorCoeffIntE=
xternal_t[8]' [-Werror=3Darray-bounds]
 1364 |                 size +=3D sysfs_emit_at(buf, size, "%-16d", activit=
y_monitor_external[i].DpmActivityMonitorCoeffInt.field);               \
      |                                                           ~~~~~~~~~=
~~~~~~~~~~~~~~~~^~~
drivers/gpu/drm/amd/amdgpu/../pm/swsmu/smu13/smu_v13_0_7_ppt.c:1370:9: note=
: in expansion of macro 'PRINT_DPM_MONITOR'
 1370 |         PRINT_DPM_MONITOR(Gfx_FPS);
      |         ^~~~~~~~~~~~~~~~~
drivers/gpu/drm/amd/amdgpu/../pm/swsmu/smu13/smu_v13_0_7_ppt.c:1328:46: not=
e: while referencing 'activity_monitor_external'
 1328 |         DpmActivityMonitorCoeffIntExternal_t activity_monitor_exter=
nal[PP_SMC_POWER_PROFILE_COUNT];
      |                                              ^~~~~~~~~~~~~~~~~~~~~~=
~~~
drivers/gpu/drm/amd/amdgpu/../pm/swsmu/smu13/smu_v13_0_7_ppt.c:1364:84: err=
or: array subscript 8 is above array bounds of 'DpmActivityMonitorCoeffIntE=
xternal_t[8]' [-Werror=3Darray-bounds]
 1364 |                 size +=3D sysfs_emit_at(buf, size, "%-16d", activit=
y_monitor_external[i].DpmActivityMonitorCoeffInt.field);               \
      |                                                           ~~~~~~~~~=
~~~~~~~~~~~~~~~~^~~
drivers/gpu/drm/amd/amdgpu/../pm/swsmu/smu13/smu_v13_0_7_ppt.c:1369:9: note=
: in expansion of macro 'PRINT_DPM_MONITOR'
 1369 |         PRINT_DPM_MONITOR(Gfx_IdleHystLimit);
      |         ^~~~~~~~~~~~~~~~~
drivers/gpu/drm/amd/amdgpu/../pm/swsmu/smu13/smu_v13_0_7_ppt.c:1328:46: not=
e: while referencing 'activity_monitor_external'
 1328 |         DpmActivityMonitorCoeffIntExternal_t activity_monitor_exter=
nal[PP_SMC_POWER_PROFILE_COUNT];
      |                                              ^~~~~~~~~~~~~~~~~~~~~~=
~~~
drivers/gpu/drm/amd/amdgpu/../pm/swsmu/smu13/smu_v13_0_7_ppt.c:1364:84: err=
or: array subscript 8 is above array bounds of 'DpmActivityMonitorCoeffIntE=
xternal_t[8]' [-Werror=3Darray-bounds]
 1364 |                 size +=3D sysfs_emit_at(buf, size, "%-16d", activit=
y_monitor_external[i].DpmActivityMonitorCoeffInt.field);               \
      |                                                           ~~~~~~~~~=
~~~~~~~~~~~~~~~~^~~
drivers/gpu/drm/amd/amdgpu/../pm/swsmu/smu13/smu_v13_0_7_ppt.c:1368:9: note=
: in expansion of macro 'PRINT_DPM_MONITOR'
 1368 |         PRINT_DPM_MONITOR(Gfx_ActiveHystLimit);
      |         ^~~~~~~~~~~~~~~~~
drivers/gpu/drm/amd/amdgpu/../pm/swsmu/smu13/smu_v13_0_7_ppt.c:1328:46: not=
e: while referencing 'activity_monitor_external'
 1328 |         DpmActivityMonitorCoeffIntExternal_t activity_monitor_exter=
nal[PP_SMC_POWER_PROFILE_COUNT];
      |                                              ^~~~~~~~~~~~~~~~~~~~~~=
~~~

Caused by commit

  878205b8c170 ("drm/amd/pm: enable workload type change on smu_v13_0_7")

I have used the amdgpu tree from next-20220505 for today.

--=20
Cheers,
Stephen Rothwell

--Sig_/pqbz3eLRMHghE6honk4+7Vf
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmJ0dKYACgkQAVBC80lX
0GzCzQf+JgxeGhAdedssgUHeB0k8+1WcW6Di1M0Wq100UQvBk6e6P6Jq3Qr2gxov
vK++5FWQtQqGMYKXZ2VczjXKTTNStovSObD7vtgCfIMwVc+esFrnRsdmfL3GTWC3
9uLctIhM75NfolOmyTE8iM6DTN+ehPRMrlMALXcfgKofka5JmLzqtXkNv2+h9ccA
hfKg3zfpr4TjLxyk5uNny1YWEsFEJD9cq1AuDHAm3nywKh4p8Bj/bFTHvKLcaCHJ
mR/Om4W9ZRjRAkK9cIx92Mkbl2ViL4GbkuO32LNYCDM3UnaABROZ4N0IO47BYTOn
U/zkgkIiCgNE2M1WIslUOL2ciHV9og==
=Ql4k
-----END PGP SIGNATURE-----

--Sig_/pqbz3eLRMHghE6honk4+7Vf--
