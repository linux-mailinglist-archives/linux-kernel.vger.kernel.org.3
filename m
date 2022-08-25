Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9381C5A0EA4
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 13:02:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241321AbiHYLCk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 07:02:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241038AbiHYLCi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 07:02:38 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45C75ADCDE
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 04:02:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C04E9B82733
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 11:02:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43E98C433D6;
        Thu, 25 Aug 2022 11:02:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661425354;
        bh=PziEPM/90++WWvgQBXi19pLUTGlh88PPi6M3tzIo0Z0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UjVOx2qmAPKPC8PFQ4QEx3inoF+zaKbZT5tTbJu7Xs9DOjemG0O7wupqxGZQ1wzGy
         b/hw4NTxO7taNz2MQc1aNTh/KqgTrDlguXVrI8sEaeu/eaYspxctsTlV/cgYyJdZUU
         iCHluxUre6T2p1T56ug7uoFK2vgG0IKEbpkT43+41A07/uaa2u/3ztnXC5YIaWvNB4
         m2ub+JCUCKwut/Ua1htL1bv38Tv8iebacUPU+ArUPYKkJBAabHNyosbe8OlKQQ7a+l
         gN09/ZNaDO80MMucTYLtzzrR1QrmblGgiDKsn3KXXPYIJOsZJ9mTubFMnCDtZzjbgn
         0Gr99Tu9SKH1Q==
Date:   Thu, 25 Aug 2022 12:02:28 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Xiaolei Wang <xiaolei.wang@windriver.com>
Cc:     lgirdwood@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] regulator: pfuze100: Fix the global-out-of-bounds access
 in pfuze100_regulator_probe()
Message-ID: <YwdWxKywJXpkRC+s@sirena.org.uk>
References: <20220825071541.1228110-1-xiaolei.wang@windriver.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="N0zK4oVlzI+cCpvv"
Content-Disposition: inline
In-Reply-To: <20220825071541.1228110-1-xiaolei.wang@windriver.com>
X-Cookie: Boycott meat -- suck your thumb.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--N0zK4oVlzI+cCpvv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 25, 2022 at 03:15:41PM +0800, Xiaolei Wang wrote:

> This fixes the out of bounds access bug reported by KASAN.
>   BUG: KASAN: global-out-of-bounds in pfuze100_regulator_probe+0x380/0x8b8
>   Read of size 3968 at addr c3390640 by task swapper/0/1
>=20
>   CPU: 0 PID: 1 Comm: swapper/0 Not tainted 6.0.0-rc1-yocto-standard+ #2
>   Hardware name: Freescale i.MX6 SoloX (Device Tree)
>    unwind_backtrace from show_stack+0x18/0x1c
>    show_stack from dump_stack_lvl+0x68/0x90
>    dump_stack_lvl from print_report+0x58/0x4c8
>    print_report from kasan_report+0x7c/0x98
>    kasan_report from kasan_check_range+0x20/0x170
>    kasan_check_range from memcpy+0x28/0x68

Please think hard before including complete backtraces in upstream
reports, they are very large and contain almost no useful information
relative to their size so often obscure the relevant content in your
message. If part of the backtrace is usefully illustrative (it often is
for search engines if nothing else) then it's usually better to pull out
the relevant sections.

--N0zK4oVlzI+cCpvv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmMHVrEACgkQJNaLcl1U
h9AR+wf/WLvhTTUcHCmxgHXLdYWuM89scmK7+yWa+W+iv2Z5V+CVIehj50KIwGah
2oOJsMEr0QeAf2ATfPyOrnbhH05h7jXi+FaI4E3RsizhEC9bLytkUdvqtYLgiwdd
I+6Bh6gAOHVhut8DM6g9Cn6LwkLzug4Xzm+TccrdvZZ4OTs5cligWuAaP+i7je6l
Nshxx+f1cP6U0OxAAm6Bgro1E4HtqdlVJBmvMxTzzk/qXZ4+trRdsWhMT95PTRZ8
2Cyv/4EnEx22nLKJYqr2A8ZUHM+RKgAd41Qgqi0Bis4xDbVtvbYhu1Ovax5+KLu4
zLGkImT6cb8v4vVtIrwzbJ3a2E8vzQ==
=z+O8
-----END PGP SIGNATURE-----

--N0zK4oVlzI+cCpvv--
