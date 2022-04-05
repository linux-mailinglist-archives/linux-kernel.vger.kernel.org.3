Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7ACD54F3E09
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Apr 2022 22:40:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235488AbiDENKU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 09:10:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344168AbiDEJS2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 05:18:28 -0400
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59F79443C8;
        Tue,  5 Apr 2022 02:04:38 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id 2B34D32020A8;
        Tue,  5 Apr 2022 05:04:35 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Tue, 05 Apr 2022 05:04:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm3; bh=ecr/cd7Z6SJzZFC1HDrSEJXqgPsjqb23Urnj4l
        ZYBMU=; b=KrGgdmuQIuE3j8aVFK/mAslLpScm8lcxUgFNCwCGMPM9hvL92kyxOo
        6FK83YOShxY9Gdo6ThC3YRuVx0knIYWEva6Qwy/YHw9qqCp3sTpwKfpSaoV4dlm2
        t3z8e9PHEBGoQk5VTjXiZdBGexvz7drmYphxQ+r++0Quvo6+QLctw36uykeMkj+C
        zB88zsbd4NmnlTOFhr2ikz9RRRVdBggL6CiUNHV1I6wGy3Om4O9xHV6Ml895dTmy
        ZM6g2l5G+3wB2ztugXCckjWanOZlLvethgwWsvHhAmydPvgP4N5Q03D88leahNc+
        8l47wgLwwsue+s0c2Kwslb+rfClWtiUw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=ecr/cd7Z6SJzZFC1H
        DrSEJXqgPsjqb23Urnj4lZYBMU=; b=SD9lPJbsCXsD3IRVzWzs6HwdOJjLYmsHn
        oIVvE1szBZvFED9i9hCkXfZsiAqxl9DD8FxETyA4Wfb0XUAe4xunMwB6UfcfQciy
        QYJyvhRVaJ9dHAoQnr4p8WtjoDuWautsr3cxRoRTQYfVavwJt09uPhPpX8FTcAbl
        iVa+WG/9K5oDaTNNUJpv8J3dILea799tLV8qhkPaYbas4ez3unyWvE28LWCxdbvd
        +BFrdzMT6GcqVlTqqjkKlEZPISHIgHZ8HV4FieH0k+sJaBUHuGKHt96RLtWujigV
        v3ivV3wxLqztxe207y7BXj4t+GcCNHvQTCLwCCm3Ww/iABdY06xpw==
X-ME-Sender: <xms:IgZMYlCUSghPrq4O5rYv6tgoVPUV1R-_mbdMReYM-T0TtIMkvzA6Qg>
    <xme:IgZMYjgit-q1l0WvyFNg_zIlBp1-b79Ra-Xw0vfOV0kPINWOhnU1guVJa_DWHV5bH
    WvMbkT5xEz8J0f9wRE>
X-ME-Received: <xmr:IgZMYgk6uItlRrBdTitnOKwRcBDAG_58tPaNzpeCtJy0MWTI1dSItgZzzUu0Jjdv-rNeQ7hbCA_PMMwSBs1lVyr77gzENYz7EmyrCss>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrudejgedgtdejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepleekgeehhfdutdeljefgleejffehfffgieejhffgueefhfdtveetgeehieeh
    gedunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepmh
    grgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:IgZMYvw3xJTqNH3Q1tyYDMZ_3EAGlXRrKotIUzrABzXO2u2yqo-P0g>
    <xmx:IgZMYqQCbAIO7qZWmQHf4I_-_-TqaPhoxiRPsP7O-mMoZtGJSkUl5w>
    <xmx:IgZMYiYUczpsbXJoUFzwkMSALHhMcekoQYAZ3icHdKdibv1bAhgxHw>
    <xmx:IgZMYoeYf2vmZ_Uh-_ms7yUgP8xpvKS4xjEkKu1dM808UNLj3PioUw>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 5 Apr 2022 05:04:33 -0400 (EDT)
Date:   Tue, 5 Apr 2022 11:04:31 +0200
From:   Maxime Ripard <maxime@cerno.tech>
To:     "Ivan T. Ivanov" <iivanov@suse.de>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/2] clk: bcm: rpi: Add support for two more clocks
Message-ID: <20220405090431.ktlybn62eueh7gqi@houat>
References: <20220405082503.61041-1-iivanov@suse.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="hf5en5nuutxdxhwt"
Content-Disposition: inline
In-Reply-To: <20220405082503.61041-1-iivanov@suse.de>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--hf5en5nuutxdxhwt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Apr 05, 2022 at 11:25:01AM +0300, Ivan T. Ivanov wrote:
> Add missing clock required by RPiVid video decoder and make HDMI
> pixel clock more reliable.

For both patches:
Acked-by: Maxime Ripard <maxime@cerno.tech>

Thanks!
Maxime

--hf5en5nuutxdxhwt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCYkwGHwAKCRDj7w1vZxhR
xT9hAP97ZP4m7lMBga/y6bEsBJH/w3jNB0D9XMPN7wd+E5ecDgEAo6EuTF1V6UUw
zhd/u37t4HE4ANpEFb5DuhQCVWaCnAo=
=ifbI
-----END PGP SIGNATURE-----

--hf5en5nuutxdxhwt--
