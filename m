Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B48365790E7
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 04:36:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234439AbiGSCgO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 22:36:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229585AbiGSCgL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 22:36:11 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97E3B1D0C8;
        Mon, 18 Jul 2022 19:36:09 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Ln2yJ1dRRz4xXD;
        Tue, 19 Jul 2022 12:36:08 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1658198168;
        bh=qQmhpa9HzmEVe/Xt2MkQgH+IGQHrUPwe4dG561pSqVg=;
        h=Date:From:To:Cc:Subject:From;
        b=gp5bPKA0AJp2p5/m3iGIfEaLSdprf2XbbxRJRx9Y0hsN5BKKyK7CgIWeWsrYIEUmI
         RLbTqeLUyrUTM4/sWH+TvAd4gsWZJRLjp/SQ8q9di5Yw8J9lA+S4UItSHKXlptTGor
         VQbnLUJ4GohueCU2QvWGm2cZUlVgAgm6rI/mfLXahfPHnvfY36OykILbZgPjwrbvtJ
         mA5+Px6/FHC/hCfqpQTL0l0na32PG7tQJrgUXH9hghrJ0DfYesKXkmx+WOiuAXbk6j
         xTlZ4OZyGVJK6XnnI5wm7SOyy37Rxz7qLLEbkz5wL3eCLXbAj977cguHFFgcywrgSi
         mj/xk5WBG9N7Q==
Date:   Tue, 19 Jul 2022 12:36:07 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Alex Deucher <alexdeucher@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the amdgpu tree
Message-ID: <20220719123607.63cbb3c5@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/WKYGmpRW/SW7MMy8Lngx+cx";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/WKYGmpRW/SW7MMy8Lngx+cx
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the amdgpu tree, today's linux-next build (x86_64
allmodconfig) failed like this:

drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn32/display_mode_vba_32.c: I=
n function 'DISPCLKDPPCLKDCFCLKDeepSleepPrefetchParametersWatermarksAndPerf=
ormanceCalculation':
drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn32/display_mode_vba_32.c:16=
59:1: error: the frame size of 2144 bytes is larger than 2048 bytes [-Werro=
r=3Dframe-larger-than=3D]
 1659 | }
      | ^
drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn32/display_mode_vba_32.c: I=
n function 'dml32_ModeSupportAndSystemConfigurationFull':
drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn32/display_mode_vba_32.c:37=
99:1: error: the frame size of 2464 bytes is larger than 2048 bytes [-Werro=
r=3Dframe-larger-than=3D]
 3799 | } // ModeSupportAndSystemConfigurationFull
      | ^
cc1: all warnings being treated as errors

I can't see anything obvious that caused this.  The second one was
previously fixed by commit

  01cf387b1c7f ("drm/amdgpu/display: reduce stack size in dml32_ModeSupport=
AndSystemConfigurationFull()")

Usinf the amdgpu tree from next-20220718 fixes the problem, so I have
done that for today.

--=20
Cheers,
Stephen Rothwell

--Sig_/WKYGmpRW/SW7MMy8Lngx+cx
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmLWGJcACgkQAVBC80lX
0Gyr/Qf/eU9PrxA94bNj/snSE455OvBxQWstXaznX5Dgu+hRAqDqQdkux6EZShsy
8r2LcId5P0dcIfg16aOeOhI5oGfvRADycJ5n3gUxS0m25fT7CSXQxFcyUQq1b6YZ
VNtPeRVgB79Mot8s82vGqyfC/S6IeNKaNGsRZw6URWJy6/Jl4Bw2ml2pND5y4Uaj
4GpB0LtKch2M6cmVnNhJLNs+YCWR2Pempi4tfVvBxmQo3KJWILF6FUaz+vh6AJIh
yYzI0Uv327PUhgE8egHc3s+32hrHtrsUH8OFEPUxftiA9tlTgIGtls8moWxsW/mu
qrfcTZI2FASqNOFHdZsfqJiYSfx10A==
=5XEZ
-----END PGP SIGNATURE-----

--Sig_/WKYGmpRW/SW7MMy8Lngx+cx--
