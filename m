Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAA9954F5BB
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 12:44:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381896AbiFQKnR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 06:43:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381885AbiFQKnL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 06:43:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C50C54DF5F
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 03:43:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6155E61E1B
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 10:43:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DAC4C3411D;
        Fri, 17 Jun 2022 10:43:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655462588;
        bh=yT33ldFU3rebbAEBjPVl2UkmZ9uxE9nDsQERpI2t9lU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bdx1va0VaQIh0gxvFkKdeiiFbfXa3T0b+JeBy0oJzTaivbrMmS+D0PfDsHJdoSTQg
         2ysTTvtnPkcGrCtB8dVLefaKCHPFytXWFhB+76e63k9gDlJWx1Gr5TJckULV5lnrld
         2t2HnZ7aCSrwi8beAPSBdu17SYaecrUjjbzWHIfwktOap3CPn3xhnEPJ/GVCrMnZMP
         aV/NKzU4I/2yEbQ9k2H2Mbo+FwYOMj3j4yaqyqBlFeTxBU2prtl0yLfpCboSTMN0Xd
         +xtfgY/csMyT31WruFvag1vLsQHp/4vKy4y7uXDLzIBkDjdWiEa1RuDvuQ+kvSN/w1
         aNJyEpuLjiE5A==
Date:   Fri, 17 Jun 2022 11:43:04 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Fei Shao <fshao@chromium.org>
Cc:     Jiaxin Yu <jiaxin.yu@mediatek.com>, alsa-devel@alsa-project.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH] ASoC: mediatek: mt8186: Fix mutex double unlock in GPIO
 request
Message-ID: <YqxauLOp2sWOU/uc@sirena.org.uk>
References: <20220617100632.1447811-1-fshao@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="jXPaouEK3FOmFDrR"
Content-Disposition: inline
In-Reply-To: <20220617100632.1447811-1-fshao@chromium.org>
X-Cookie: 98% lean.
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--jXPaouEK3FOmFDrR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 17, 2022 at 06:06:33PM +0800, Fei Shao wrote:
> The lockdep mechanism reveals an unbalanced unlocking on MT8186:
>=20
>   [    2.993966] WARNING: bad unlock balance detected!
>   [    2.993971] 5.15.46-421fef3b44d7-lockdep #16 Not tainted
>   [    2.993978] -------------------------------------
>   [    2.993983] kworker/u16:1/10 is trying to release lock (gpio_request=
_mutex) at:
>   [    2.993994] [<ffffffdcd9adebf8>] mt8186_afe_gpio_request+0xf8/0x210
>   [    2.994012] but there are no more locks to release!
>   [    2.994017]
>   [    2.994017] other info that might help us debug this:

Please think hard before including complete backtraces in upstream
reports, they are very large and contain almost no useful information
relative to their size so often obscure the relevant content in your
message. If part of the backtrace is usefully illustrative (it often is
for search engines if nothing else) then it's usually better to pull out
the relevant sections.

--jXPaouEK3FOmFDrR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmKsWrcACgkQJNaLcl1U
h9BEggf+NYEXEA4i95MJoX3RIZCLZsS6j2/wpgysgdDQZK0wcT2Jdy79DDrPIx8K
EQfqgLqIlxrdpjIJn0B3kIN1x6iczamii3Gd+h7odYHf7UWYgvSorSts5Jg0YLwx
Ze17TDN/kFiVmxsE0BKNbTEoSB9teKhpbM0z74xVsg2PMZ2sC/m/5IWPVgHcn/qq
mhjzVUfER075+eOTEaxV+4E9G2TypWG2GAjNrklf6J2Czg842Y0BnO/3Tk/AS9q4
RDigvbROs4g2+pUJAjsIcHhq1LqNf7yo8tSPIT4Evd+uN/AqddkXr166gcn+BOmX
BoRJF1AR869q0iJ4JoVS9xuzSXbswQ==
=v6CV
-----END PGP SIGNATURE-----

--jXPaouEK3FOmFDrR--
