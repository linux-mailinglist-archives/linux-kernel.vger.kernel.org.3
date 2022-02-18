Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B6A54BAE66
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 01:36:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230216AbiBRAeG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 19:34:06 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:43956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230146AbiBRAeF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 19:34:05 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0FC840A09;
        Thu, 17 Feb 2022 16:33:41 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 39610B819EE;
        Fri, 18 Feb 2022 00:33:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBFE5C340E9;
        Fri, 18 Feb 2022 00:33:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645144418;
        bh=e/znNyDINSmervQbv/vjQdjL+iOg2YVcl9VW/Ak7M34=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=MhnvbVUGqtcfi8MC1zO5YLdbZ9LvVI+GP0ULoeKxwQ9yubWwXRLDaovyn4cEXKkdU
         b7C3lqMBjLhborfb2ZHKcfC287/fFbhQpPaY+WZpAyX+WM5RE3baErc+FzyvXQyXG8
         2HEwl6Wujsj+eauQUcFZ+NQTWSUaH6o0g1sIvgjedKlIABrW1aevxwnu+q+q6s/KlC
         5Ao/1ZEF2M/NjahLNQDRs5Dt73RNlNi1n/4UYRg7XYkEtYJK9IVC3bnrcU9XQdupNM
         xwbeBZXQN6nw7KyE2LuOefGFgbf4kbKCoIXC7ohkyEyGIbreccfLTUCeihMBDiFh1p
         pDdjkgWKDDLgQ==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <YghBkp/sUHdqSn4G@piout.net>
References: <20220203021736.13434-1-samuel@sholland.org> <20220203021736.13434-6-samuel@sholland.org> <164422443570.21572.13511859513410998733.b4-ty@cerno.tech> <bb05bc64-2a9e-fe21-5a69-0ea31134e978@sholland.org> <20220211124312.kiw6t25nojvkp2rw@houat> <YghBkp/sUHdqSn4G@piout.net>
Subject: Re: (subset) [PATCH v3 5/6] clk: sunxi-ng: Add support for the sun6i RTC clocks
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Samuel Holland <samuel@sholland.org>, Chen-Yu Tsai <wens@csie.org>,
        linux-sunxi@lists.linux.dev,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Alessandro Zummo <a.zummo@towertech.it>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Maxime Ripard <maxime@cerno.tech>
Date:   Thu, 17 Feb 2022 16:33:37 -0800
User-Agent: alot/0.10
Message-Id: <20220218003338.DBFE5C340E9@smtp.kernel.org>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Alexandre Belloni (2022-02-12 15:24:02)
> On 11/02/2022 13:43:12+0100, Maxime Ripard wrote:
> > Hi Samuel,
> >=20
> > On Mon, Feb 07, 2022 at 05:54:02PM -0600, Samuel Holland wrote:
> > > On 2/7/22 3:00 AM, Maxime Ripard wrote:
> > > > On Wed, 2 Feb 2022 20:17:35 -0600, Samuel Holland wrote:
> > > >> The RTC power domain in sun6i and newer SoCs manages the 16 MHz RC
> > > >> oscillator (called "IOSC" or "osc16M") and the optional 32 kHz cry=
stal
> > > >> oscillator (called "LOSC" or "osc32k"). Starting with the H6, this=
 power
> > > >> domain also handles the 24 MHz DCXO (called variously "HOSC", "dcx=
o24M",
> > > >> or "osc24M") as well. The H6 also adds a calibration circuit for I=
OSC.
> > > >>
> > > >> Later SoCs introduce further variations on the design:
> > > >>  - H616 adds an additional mux for the 32 kHz fanout source.
> > > >>  - R329 adds an additional mux for the RTC timekeeping clock, a cl=
ock
> > > >>    for the SPI bus between power domains inside the RTC, and remov=
es the
> > > >>    IOSC calibration functionality.
> > > >>
> > > >> [...]
> > > >=20
> > > > Applied to local tree (sunxi/clk-for-5.18).
> > >=20
> > > Part of the build failures were because this patch depends on patch 3=
. Is that
> > > okay, or should I update this patch to be independent?
> >=20
> > We don't have anything queued up yet, so I think the easiest would be to
> > merge this through the RTC tree. So nothing to do on your side yet, we
> > just need Alex to answer :)
> >=20
>=20
> I can take the whole series but I think I would need acks from Stephen
>=20

For the clk patches

Acked-by: Stephen Boyd <sboyd@kernel.org>
