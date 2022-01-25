Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9B3749A86A
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 05:11:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1318623AbiAYDGg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 22:06:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S3416031AbiAYByK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 20:54:10 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AF75C028BFF;
        Mon, 24 Jan 2022 17:14:32 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 02426B815FE;
        Tue, 25 Jan 2022 01:14:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93D9FC340E4;
        Tue, 25 Jan 2022 01:14:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643073269;
        bh=vuPHwP5mvesHSyqAIvXrWSziPwVD5YCX+k4I3E3APq4=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=MOMxz1i+dBupYvGtGZbKKOp/v5MChx3K2YKwfCQZupOUGfu7w0EggtKGwG8etHmGP
         Wgq2lKH2GZEaq0TpI/7hKvfEnwDaUQuvmX7oKG4swynQ4zJRc9LqK5Gqf22OSNfU8c
         Oz4AGC8QaXFcFtyog53UhMJuuiG7G7B86/iUI3c9WgH254aYhoLbpIzYeb2hDGITsW
         2G43C3eMsNljAHoTZLKezN0S7Ubxb18/mEVI4BHZd5bhby9rz0IQTcemDPB6m1/EGi
         2IcJEnkzbY2Cnk9Rhqfiy2ho/SesUh4aooLXCSibniW+ZTFLP3ZYCa3NltD8bp4eFz
         wDBQ/sdDrWeBQ==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220110114930.1406665-4-sergio.paracuellos@gmail.com>
References: <20220110114930.1406665-1-sergio.paracuellos@gmail.com> <20220110114930.1406665-4-sergio.paracuellos@gmail.com>
Subject: Re: [PATCH v8 3/4] clk: ralink: make system controller node a reset provider
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     john@phrozen.org, linux-staging@lists.linux.dev,
        gregkh@linuxfoundation.org, neil@brown.name,
        p.zabel@pengutronix.de, linux-kernel@vger.kernel.org
To:     Sergio Paracuellos <sergio.paracuellos@gmail.com>,
        linux-clk@vger.kernel.org
Date:   Mon, 24 Jan 2022 17:14:27 -0800
User-Agent: alot/0.10
Message-Id: <20220125011429.93D9FC340E4@smtp.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Sergio Paracuellos (2022-01-10 03:49:29)
> MT7621 system controller node is already providing the clocks for the who=
le
> system but must also serve as a reset provider. Hence, add reset controll=
er
> related code to the clock driver itself. To get resets properly ready for
> the rest of the world we need to move platform driver initialization proc=
ess
> to 'arch_initcall'.
>=20
> CC: Philipp Zabel <p.zabel@pengutronix.de>
> Signed-off-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>
> ---
>  drivers/clk/ralink/clk-mt7621.c | 92 ++++++++++++++++++++++++++++++++-
>  1 file changed, 91 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/clk/ralink/clk-mt7621.c b/drivers/clk/ralink/clk-mt7=
621.c
> index a2c045390f00..99256659dd96 100644
> --- a/drivers/clk/ralink/clk-mt7621.c
> +++ b/drivers/clk/ralink/clk-mt7621.c
> @@ -11,14 +11,17 @@
>  #include <linux/mfd/syscon.h>
>  #include <linux/platform_device.h>
>  #include <linux/regmap.h>
> +#include <linux/reset-controller.h>
>  #include <linux/slab.h>
>  #include <dt-bindings/clock/mt7621-clk.h>
> +#include <dt-bindings/reset/mt7621-reset.h>

I can't take this patch without taking the first patch. I suppose if
Greg is OK I can take the staging patch #4 through clk tree too? Let me
know.
