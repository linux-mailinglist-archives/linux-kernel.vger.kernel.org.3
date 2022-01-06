Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98718485DF5
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jan 2022 02:17:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344211AbiAFBRW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 20:17:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344162AbiAFBRT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 20:17:19 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 707DEC061245;
        Wed,  5 Jan 2022 17:17:19 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D265E61989;
        Thu,  6 Jan 2022 01:17:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28688C36AE3;
        Thu,  6 Jan 2022 01:17:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641431838;
        bh=C9DJbx1jyTAdcd6/2nGN1NMoyhjr2dFB0KEldiDjXTk=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=jnH26uJMnogWLPVGyd4A1TMIy0WVnUVd+dYK/p8eQAbX5yCt/6twc0LUJmJiN80Vt
         at56NwYXO00D/PsNkULJteXHjohwQzQUSx/nsuIpfBRYRxb9hJIxDFjsbWk5WrMc5U
         cJ3flBvEXjSgAEs2xM+weEEbKJ8rG67phIN/YZyHwrp1BV8N50O6WZ+Kp/AtP7ABAp
         wgn/1S3tvXX3rL6ljVM4x0FXhV2zXdF8ClMpfQo73bPvYdBpQsJ7yOs0AiEDOvjM7I
         y0iryBcBrBxOy5vgVWFHvIAJFKRu2/13K1Bslhe7AxQAyBX7RMemG2rfDEP2SyhFwQ
         FOgWl0QCjo/3w==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20211221031638.3499920-1-peng.fan@oss.nxp.com>
References: <20211221031638.3499920-1-peng.fan@oss.nxp.com>
Subject: Re: [PATCH] clk: bulk: export of_clk_bulk_get_all
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-kernel@vger.kernel.org, van.freenix@gmail.com,
        Peng Fan <peng.fan@nxp.com>
To:     Peng Fan (OSS) <peng.fan@oss.nxp.com>, aisheng.dong@nxp.com,
        bjorn.andersson@linaro.org, jbrunet@baylibre.com,
        linux-clk@vger.kernel.org, s.nawrocki@samsung.com,
        shawn.lin@rock-chips.com, ulf.hansson@linaro.org
Date:   Wed, 05 Jan 2022 17:17:16 -0800
User-Agent: alot/0.9.1
Message-Id: <20220106011718.28688C36AE3@smtp.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Peng Fan (OSS) (2021-12-20 19:16:38)
> From: Peng Fan <peng.fan@nxp.com>
>=20
> There are cases that need to get the bulk clks of a device_node which not
> has device created, so export of_clk_bulk_get_all to let consumers could
> use it.
>=20
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>=20
> V1:
>      An example here, mediamix node has clocks property, but it will not

Sorry I don't get the example. What does a DT snippet have to do with
modular kernel code? What specific kernel module is calling this API?

>      have device of it, so we need of_X api to get the clks.
>      src: src@0x30390000 {
>           compatible =3D "fsl,imx[X]-src";
>           reg =3D <0x30390000 0x10000>;
>=20
>           slice {

Is this upstream?

>                 #address-cells =3D <1>;
>                 #size-cells =3D <0>;
>=20
>                 mediamix: slice@2400 {
>                    reg =3D <IMX93_POWER_DOMAIN_MEDIAMIX>;
>                    #power-domain-cells =3D <0>;
