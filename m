Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33E104A802E
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 09:15:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349457AbiBCIPV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 03:15:21 -0500
Received: from wout5-smtp.messagingengine.com ([64.147.123.21]:33709 "EHLO
        wout5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238509AbiBCIPT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 03:15:19 -0500
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id 338C132020DA;
        Thu,  3 Feb 2022 03:15:18 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Thu, 03 Feb 2022 03:15:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm2; bh=hQLqEoOkiqPgXibgOKaXEAezpzBwTePKZNPS6u
        0twQ8=; b=VwnXJ4ESF8BR0H5DNQxp4WTHPKIsCqkv/YDsQKhLUXwupzjXHN4Gui
        b0tsVSWf10YYeTeOKBirvlXFPcpMAp63miVlmWq09qpaGZ65b3DfH5PlxF7JVTt+
        KD7pqnAxQxD+s433xn8VUn/GdMwJ2+7s/ET//VC/mRI5Z6T6xddpfNM7WgasyuyR
        VDRsb5fu7V3fbHW6w2ZlKd/DzIlxDKLuLFQ55LuRwlpeZ0MyHi30cPiPtjtJjgGJ
        NbHEVoZ8cPXGZFQHdTuzgiHhcPZfwRKzV5KN+xfukfZjsN15/aOtPhCXFTdwP91v
        8/Cqw5na8pwJ+KVUqsYSKjX0I4bpda/w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=hQLqEoOkiqPgXibgO
        KaXEAezpzBwTePKZNPS6u0twQ8=; b=SDm3nCUQF9g/4CANZhRMkingGGuQJyXfd
        ggG5dzSi0P2BuhjLmG5hxuxIj3ZaxIUO1kgX+F+rFvguoS1qIGbjCysxPDs0fg2g
        bBN8vBkpsN4rqts9uf5jdNJ/eDx8hlTMaohP3zmrLmKSu7NRRGZYH+5irKevQyFD
        8E+5aNfK0SaQtp6/aiu46OX0NgFc6hiilBQwYL0+hWMMhMKm08NSIPHgLFrJmt13
        noHr0Gz9rl2zTLr/KUDvJW5n3WVNjLshYG/yil30ztH4MOxP3Uz12HVoAKOzD/CV
        sazo1Yoo3BKVo30WbzBlV2bNdLXBuwIqmc3KFHqYYLp/AQ1K+vxpg==
X-ME-Sender: <xms:FY_7YcZ9cDMhrgW7sI8hDp-vjgNRxCdO3RcWe63mQqKFMmwEQHoI1g>
    <xme:FY_7YXaNY-aHpsNMO9BXadMhOY6573SI1rYXq-294zuvjulRcFJARLudO8O-Db5xb
    feUuWa5KBwOAtOS2eA>
X-ME-Received: <xmr:FY_7YW-Xoz3ws8mpyM4dc4BsRUpyvkgReAgrLhE8PM5OEQVPXdAo5wMBbuZS1hirO1z35fTXOuxCM-atiWQu3n5pJfb-dCnEgCZ6oDs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrgeeigdduudeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepleekgeehhfdutdeljefgleejffehfffgieejhffgueefhfdtveetgeehieeh
    gedunecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepmh
    grgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:FY_7YWqg7FllDXCoHFiOv2EttQxbZyxPqtAzqRK3ankYDrXdx9FHkw>
    <xmx:FY_7YXpN2-szHFNXteYmBd1pVXL2n8TpDHTgtMSzjS_4BHtTCipKlA>
    <xmx:FY_7YUQ1Wi2LylOX-JVgSbhs2SWGe_y0Tdhgy-NOSyFEVwO6NiL_RQ>
    <xmx:FY_7Ybc5s2OIuhL5vjv7435v0jn3_AJdyrzKQx75lsiZECYeoi8cbA>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 3 Feb 2022 03:15:16 -0500 (EST)
Date:   Thu, 3 Feb 2022 09:15:15 +0100
From:   Maxime Ripard <maxime@cerno.tech>
To:     Samuel Holland <samuel@sholland.org>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        linux-sunxi@lists.linux.dev, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/2] dt-bindings: mmc: sunxi: Add D1 MMC and eMMC
 compatibles
Message-ID: <20220203081515.xxizvo65b2sm2aob@houat>
References: <20220203015112.12008-1-samuel@sholland.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="louvw55igjxjbwah"
Content-Disposition: inline
In-Reply-To: <20220203015112.12008-1-samuel@sholland.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--louvw55igjxjbwah
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 02, 2022 at 07:51:10PM -0600, Samuel Holland wrote:
> D1 contains variants of the usual sunxi MMC controller. The eMMC
> controller has the same parameters as the A100 eMMC controller. The
> other controllers have a DMA address shift like on A100, but they have
> a smaller 13-bit size field, making them a new incompatible variant.
>=20
> Signed-off-by: Samuel Holland <samuel@sholland.org>

For both patches:
Acked-by: Maxime Ripard <maxime@cerno.tech>

Maxime

--louvw55igjxjbwah
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCYfuPEwAKCRDj7w1vZxhR
xYfFAPkBe/Tzmm4bPDBab5Mm5/QLxg3IwcVe/hd2lOS9+hvhigD9FdTPJehtqcfZ
Rp8tc58XUgdgQjqZs+lfNG9osyLe8gA=
=Oc4O
-----END PGP SIGNATURE-----

--louvw55igjxjbwah--
