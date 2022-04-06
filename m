Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8CA14F5652
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 08:24:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443511AbiDFFyh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 01:54:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442417AbiDFF1c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 01:27:32 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01BF61D788C;
        Tue,  5 Apr 2022 17:58:31 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4KY5jd3mCZz4xgX;
        Wed,  6 Apr 2022 10:58:29 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1649206710;
        bh=pi9XiXNOUCWDkzxj0K1TVRkwxuLVNRPtWNUbObBWuwc=;
        h=Date:From:To:Cc:Subject:From;
        b=lfud6uyclEmjYXOZX/GX/MCHGDXZ0PdazufiH3wBaM4Z9yeBlmq/Ab1gmiG2COzL/
         eevGdFWUWov+Wu2QDnRa+PJkkCVHFqBe94gHNCmaPuaYkeP60E2Rsw2o486RpZBqx+
         jVBoHI4HLmuzfZ/Ob47L6gkCzjh054cV9E2nMS/6sA7g2VfPdECaidfnM+cIX1gUM/
         vklirSaonTk+V/VSxzKHSCb0j6cQBuaFX8l76+C4O1NRZVhN3WiWOObB4Zag+/tIl1
         dS0f1YkM7CC5Y/SHbnsuuItn/b9gLbJhljBMeFkZm8cjERtULNBGaecaKzIPOXPw6/
         TpwyZ9oFxtIKg==
Date:   Wed, 6 Apr 2022 10:58:28 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        Intel Graphics <intel-gfx@lists.freedesktop.org>,
        DRI <dri-devel@lists.freedesktop.org>
Cc:     Marek Vasut <marex@denx.de>, Robert Foss <robert.foss@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build warning after merge of the drm-misc tree
Message-ID: <20220406105828.6d238651@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/8khWjiccJo17txCVA+lH=D+";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/8khWjiccJo17txCVA+lH=D+
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the drm-misc tree, today's linux-next build (x86_64
allmodconfig) produced this warning:

WARNING: modpost: drivers/gpu/drm/bridge/chipone-icn6211.prelink.o(.exit.da=
ta+0x0): Section mismatch in reference from the variable __cfi_jt_cleanup_m=
odule to the function .init.text:cleanup_module()
The variable __exitdata __cfi_jt_cleanup_module references
a function __init cleanup_module().
This is often seen when error handling in the exit function
uses functionality in the init path.
The fix is often to remove the __init annotation of
cleanup_module() so it may be used outside an init section.

Introduced by commit

  8dde6f7452a1 ("drm: bridge: icn6211: Add I2C configuration support")

The chipone_exit function should not be marked __init.

--=20
Cheers,
Stephen Rothwell

--Sig_/8khWjiccJo17txCVA+lH=D+
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmJM5bQACgkQAVBC80lX
0Gyl4ggAoejsSpMqlTgpt87ppk4jvpqqjuMoEk7wVlY0xo9FQQvjbxbboiHZUn8v
fIWdbVjL9LTDkiduXGG+1JLMLMqUT8VmPr3dXnbp34Y4/kqS5Vh966ItFTtprmxV
DrA83Q1DXZ1gNJO4XUjjgS62csfi2cqF8BYY099nH9jtJLinxJKWtvkj1+yb8OD/
W33SLXoMxAN1FtlDOZunCeKDImk4+QKQoVV9ORqasGtjNmgOET3ybpGdAzrdhGfw
MYT/B/cRFhfFB+EQIBZLGoCh8/7vcerzj0Kg0LWuMR1YaXVMdr59pliyOFsZCzz9
mnAfCh13W0BGtJ//UJQKQQnqBZojLg==
=/2nT
-----END PGP SIGNATURE-----

--Sig_/8khWjiccJo17txCVA+lH=D+--
