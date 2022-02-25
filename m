Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C416B4C3A8B
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 01:54:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236170AbiBYAxo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 19:53:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236167AbiBYAxh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 19:53:37 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE62B6211C;
        Thu, 24 Feb 2022 16:53:06 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 772D2B82A7B;
        Fri, 25 Feb 2022 00:53:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 140FFC340E9;
        Fri, 25 Feb 2022 00:53:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645750384;
        bh=WiU8eEovdrcQvzN/+8CTcDkJk87O1toyFK3+Ul8Gjb8=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=X1YIG8CgztDg9F5f0ybeylBTdTUrK+zafUIqud9XcPsM3jDkPkqdorMHGP1L9xIpp
         RPkhp5owG7Mx2z8HpR6BpCYOOrg/yDmSMUy3YFmYeXTPDYCEE20swn/eXS0BBxp1ZV
         cMNwj1RFR6ojLFQPSuHTW87F00TNzZWsR26HZr97UP6+vrJ5zhEgrphCZxnu44OpTB
         EyTR3un+hl1a9nWAJk18TW+6oQ445lAUNzMDG2JUFluJqPGlNrRcMXhx6LnyhBsVSh
         e4G0CARftrojyHJVMsVZNmDsShiGfmMfxpSKtV8p5gVgiOOMcDqvEGrhS6WZBwgcsg
         NA0IEEa5iSSSQ==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220224035902.1594253-1-davidgow@google.com>
References: <20220224035902.1594253-1-davidgow@google.com>
Subject: Re: [PATCH] clk: lan966x: Depend on CONFIG_IOMEM
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     David Gow <davidgow@google.com>, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-um@lists.infradead.org
To:     David Gow <davidgow@google.com>,
        Michael Turquette <mturquette@baylibre.com>
Date:   Thu, 24 Feb 2022 16:53:02 -0800
User-Agent: alot/0.10
Message-Id: <20220225005304.140FFC340E9@smtp.kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting David Gow (2022-02-23 19:59:02)
> The lan966x clk driver depends on IOMEM functions, in particular
> devm_platform_ioremap_resource(), but doesn't state a formal dependency
> on it in Kconfig.
>=20
> Add such a dependency, which prevents this driver from being enabled
> on UML configurations without IOMEM.
>=20
> This fixes the following build failure:
>=20
> /usr/bin/ld: drivers/clk/clk-lan966x.o: in function `lan966x_clk_probe':
> clk-lan966x.c:(.text+0x294): undefined reference to `devm_platform_iorema=
p_resource'
> /usr/bin/ld: clk-lan966x.c:(.text+0x3aa): undefined reference to `devm_io=
remap_resource'
> collect2: error: ld returned 1 exit status
>=20
> Signed-off-by: David Gow <davidgow@google.com>
> ---
>  drivers/clk/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
> index 3cdf33470a75..7b5db8a9eb4f 100644
> --- a/drivers/clk/Kconfig
> +++ b/drivers/clk/Kconfig
> @@ -231,6 +231,7 @@ config COMMON_CLK_GEMINI
> =20
>  config COMMON_CLK_LAN966X
>         bool "Generic Clock Controller driver for LAN966X SoC"
> +       depends on IOMEM

What is CONFIG_IOMEM? This is superseded by
https://lore.kernel.org/r/20220219141536.460812-1-horatiu.vultur@microchip.=
com

>         help
>           This driver provides support for Generic Clock Controller(GCK) =
on
>           LAN966X SoC. GCK generates and supplies clock to various periph=
erals
