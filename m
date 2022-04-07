Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD0D14F80ED
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 15:46:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240345AbiDGNs0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 09:48:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229619AbiDGNsU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 09:48:20 -0400
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1AB42BB18;
        Thu,  7 Apr 2022 06:46:20 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id 3CB773201591;
        Thu,  7 Apr 2022 09:46:19 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Thu, 07 Apr 2022 09:46:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm3; bh=5MSx+d/bXZx5XVZ50S+zjx2/Cpj0N8/ygeOMyG
        KvsCs=; b=G3q6HFdoLRkTmNBNumrXdlcJS8czebdcWGFIoOney3lh9BIiMK4bPk
        B/NIRqJWmvEWZbcEw0iGQBi896zGgdWlDnEPuV1kGcKU1nWPHK6bNE/eIvFvMpI6
        /to7w4McrLT21izHjXAWfB+1u2TPWRpKTB9tshlOCV+6UtsoDjWUjVONg2dYvXey
        lXrqXWSHWsr7aOKYie6jGuGouXdr9eox1P3l79F5gQEDCk7LkauHoQJKjrkf38on
        v5A3PfbRCPyyWbbKtq6sFiYmspIeKBLuS4NyOftHhVp9/seUGBAbf3qvbfbGtFFW
        nKTDkm2xo+Id/Ww+MpvmIG2++F1orA2A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=5MSx+d/bXZx5XVZ50
        S+zjx2/Cpj0N8/ygeOMyGKvsCs=; b=F3kF1OkFZOgLN5KdNWcDu4ISxuQ8KHqzm
        9yLyWIgKjO7g8qJBrb689juCdmpD1GTZXgnH+QMJDa2lm6kgoeJ/pwDmbVDfjeQi
        B+oaMLTxUJgiZ4RlvpHosLycd9WE9pGVgD7LHBsaLCDpcY9k2qJC7Kk+FzHVrSWK
        IZ6gcFu/1RGG37KxmGFSkVAZn/BNNn3o6rYbZklExFZmzQFEFv/xppT4fXfurvDy
        2xUZe5rY3M61iJtAc8wc6B7hpR6q05DCJDFcVbscENsC5Nqvbw3qcfxaQh4aqEQX
        SkNiersEJENFgOfXRgYjcoFXAC5RWyvz250pKctDuVkINSF0ST4IQ==
X-ME-Sender: <xms:KetOYhEPeSNlbcKftz7DvQP1Mwu4B8fMn8eTGPRDBRea8ETtJgd30w>
    <xme:KetOYmXMtsdCZ6Udi84yb2N1TMDaqS5qQ_BjfvIogicWWD937Lq_EtUJ7WYBw-Di5
    EAqJyiaGWT4RcyfobY>
X-ME-Received: <xmr:KetOYjId9D55254Q5KgdNxUEcvM6VAsWymziLCH-ykei5y8SKRBP6SBnUiB-i-5laV3-1uSjcEW4zq3tnunIHUyV7cIko04O80wPV7U>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrudejkedgieekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepkeegveefgefgtdeifeeijefhvdehffekudetheejgeefteeihefffffhlefh
    gefhnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghdpghhithhhuhgsrdgtohhmnecuve
    hluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepmhgrgihimhgv
    segtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:KetOYnHGJqscSlNMgp2WMHjZbbAXtZeEPQ94vnntAWBQSu58jui4_g>
    <xmx:KetOYnXIO-Bhlt9HHApAJTyfMBGvxE7_L1AgrvSGPmmDG79j1W5OYA>
    <xmx:KetOYiMUUPK0YPnUubxWXRmdOMbgihzmXy6SshvNttj4dmZxh3FCKg>
    <xmx:KutOYgVBjRG0zdeycNJhX0xBWTOTbPqfwj4HD3dmXtSCfCpbgf76cQ>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 7 Apr 2022 09:46:16 -0400 (EDT)
Date:   Thu, 7 Apr 2022 15:46:15 +0200
From:   Maxime Ripard <maxime@cerno.tech>
To:     Naresh Kamboju <naresh.kamboju@linaro.org>
Cc:     linux-clk <linux-clk@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-stm32@st-md-mailman.stormreply.com,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>,
        lkft-triage@lists.linaro.org, regressions@lists.linux.dev,
        gabriel.fernandez@foss.st.com,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Nicolas Dechesne <nicolas.dechesne@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [next] db845c: WARNING: CPU: 5 PID: 8 at
 drivers/clk/clk-divider.c:139 divider_recalc_rate
Message-ID: <20220407134615.pqx4lxvgl4ofjrki@houat>
References: <CA+G9fYuqU45hHmK4WMUNEXQbmBucE+9fB=S9wcHEfEHaZ2jgcQ@mail.gmail.com>
 <20220401151058.fipdax3kvmxknctv@houat>
 <CA+G9fYu+WddXTb0NcbviUfGQHhsmThssVCafLPw7+nj3JsoFAA@mail.gmail.com>
 <20220407075435.ahlylmbqmqnpxz64@houat>
 <CA+G9fYvT_W9+0AguQu97mqTm5zNnSvF0asnatZX8BTf=_1oANg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="qlotqj4qfa6bze52"
Content-Disposition: inline
In-Reply-To: <CA+G9fYvT_W9+0AguQu97mqTm5zNnSvF0asnatZX8BTf=_1oANg@mail.gmail.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--qlotqj4qfa6bze52
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Naresh,

On Thu, Apr 07, 2022 at 05:12:09PM +0530, Naresh Kamboju wrote:
> On Thu, 7 Apr 2022 at 13:24, Maxime Ripard <maxime@cerno.tech> wrote:
> >
> > Hi,
> >
> > > > I'm not sure if it's feasible, but if it is, it looks like something
> > > > that could be fixed by the patch pasted here:
> > > >
> > > > https://lore.kernel.org/linux-clk/20220401122736.5yvanksa4pla7uql@h=
ouat/
> > > > Could you test it?
> > >
> > > I have tested the single line patch and reported problems not fixed.
> >
> > Could you test this branch?
> > https://github.com/mripard/linux/tree/rpi/clk-improvements-more-fixes
>=20
> I have tested your tree and branch.
> I saw more clk prints in the boot log and did not notice the reported war=
ning.

I just pushed a new version of my branch? It should get rid of most of
the side effects (and logs) you were seeing.

Thanks!
Maxime

--qlotqj4qfa6bze52
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCYk7rJwAKCRDj7w1vZxhR
xbTsAQC7LjET/cX1wvLVmcjsot44URT7Kp4tB6E6WFMkcILK7AEAzPiySlA4o95h
mfsabSaOvr20D/J3iMVsLQUyauL6xwQ=
=E5bt
-----END PGP SIGNATURE-----

--qlotqj4qfa6bze52--
