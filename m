Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E8834C397C
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 00:02:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230009AbiBXXDK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 18:03:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232290AbiBXXC7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 18:02:59 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0B0117774C;
        Thu, 24 Feb 2022 15:02:27 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0F449B829E5;
        Thu, 24 Feb 2022 23:02:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0C49C340F1;
        Thu, 24 Feb 2022 23:02:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645743744;
        bh=kF7xhxhVV3/bWnQwbLdu6duLu2w9N/GwgTupT/4oAJQ=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=WUN7wDzxBt9c0C08JqGPJCv2ef2rZ/jgSUT8ruBVdg4UGd/19a8l65RIY+iCCEXfy
         TqRgIrV1ZLJalq591/8oRBvKVJlZnHYjOKZa5Uo3OlMMc2fYTXFtoRyvK3lRf0h91W
         KekZiLnxDOTxdp47ZfUtdrc+kZmvl+cAIF3KKSyh+XnLrAVYhgbIbbhvbFPvHqhHp3
         5AFmf4UdGwWmuagBIDS+RrSyFiHi5CDdqQGXET3oY6JYl48S31SlJ4QCnTfvhNEWhL
         sDRt+NjNAzewSJd6yqLMCMgdJlyPBjA0q3w+kiZv9WQs9d2cZC7c85tcoJiCArlqRX
         bL3o+8Mg4scxw==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220219152818.4319-4-kabel@kernel.org>
References: <20220219152818.4319-1-kabel@kernel.org> <20220219152818.4319-4-kabel@kernel.org>
Subject: Re: [PATCH v9 3/6] serial: mvebu-uart: implement UART clock driver for configuring UART base clock
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Gregory Clement <gregory.clement@bootlin.com>,
        Pali =?utf-8?q?Roh=C3=A1r?= <pali@kernel.org>,
        linux-clk@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Marek =?utf-8?q?Beh=C3=BAn?= <kabel@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Marek =?utf-8?q?Beh=C3=BAn?= <kabel@kernel.org>
Date:   Thu, 24 Feb 2022 15:02:22 -0800
User-Agent: alot/0.10
Message-Id: <20220224230224.A0C49C340F1@smtp.kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Marek Beh=C3=BAn (2022-02-19 07:28:15)
> From: Pali Roh=C3=A1r <pali@kernel.org>
>=20
> Implement a new device driver for controlling UART clocks on Marvell
> Armada 3700 SoC. This device driver is loaded for devices which match
> the compatible string "marvell,armada-3700-uart-clock".
>=20
> There are more pitfalls related to UART clocks:
> - both UARTs use same parent clock source (which can be xtal or one of
>   the TBG clocks),
> - if a TBG clock is used as the parent clock, there are two additional
>   divisors that can both be configured to divide the rate by 1, 2, ... 6,
>   but these divisors are again shared between the two UART controllers
>   on the SOC,
> - the configuration of the parent clock source and divisors is done in
>   the address space of the first UART controller, UART1. Clocks can be
>   gated separately for UART1 and UART2, but this setting also lives in
>   the address space of UART1,
> - Marvell's Functional Specification for Armada 3720 document has the
>   clock gating bits swapped, so the one described to gate UART1 clock
>   actually gates UART2 and vice versa,
> - each UART has it's own "special divisor", and this uses the parent
>   clock described above. These divisors are configure in each UART's
>   address space separately.
>=20
> Thus the driver for UART2 controller needs to have access to UART1
> address space, since UART1 address space contains some bits exclusive
> for UART2 and also some bits which are shared between UART1 and UART2.
>=20
> Also, during boot, when early console is active on one of the UARTs,
> and we want to switch parent clock from xtal (default) to TBG (to be
> more flexible with baudrates), the driver changing UART clocks also
> needs to be able to change the "special divisor", so that the baudrate
> of earlycon is not changed when swtiching to normal console. Thus the
> clock driver also needs to be able to access UART2 register space,
> for UART2's "special divisor".
>=20
> For these reasons, this new UART clock driver does not use
> ioremap_resource(), but only ioremap() to prevent resource conflicts
> between UART clock driver and UART driver.
>=20
> We need to share only two 32-bit registers between the UART driver and
> the UART clock driver:
> - UART Clock Control
> - UART 2 Baud Rate Divisor
> Access to these two registers are protected by one spinlock to prevent
> any conflicts. Access is required only during probing, when changing
> baudrate or during suspend/resume.
>=20
> Hardware can be configured to use one of following clocks as UART parent
> clock: TBG-A-P, TBG-B-P, TBG-A-S, TBG-B-S, xtal. Not every clock is
> usable for higher buadrates. Any subset can be specified in the
> device-tree and the driver will choose the best one which also still
> supports the mandatory baudrate of 9600 Bd. For smooth boot log output
> it is needed to specify clock used by early console, otherwise garbage
> would be printed on UART during probe of UART clock driver and
> transitioning from early console to normal console.
>=20
> We are implementing this to be able to configure TBG clock as UART
> parent clock, which is required to be able to achieve higher baudrates
> than 230400 Bd. We achieve this by referencing this new UART clock
> device node in UART's device node. UART clock device driver
> automatically chooses the best clock source for UART driver.
>=20
> Until now, UART's device-tree node needed to reference one of the static
> clocks (xtal or one of the TBGs) as parent clock in the `clocks`
> phandle - the parent clock which was configured before booting the
> kernel. If bootloader changed UART's parent clock, it needed to change
> the `clocks` phandle in DTB correspondingly before booting.
>=20
> From now on both the old mechanism (xtal or TBG referenced as parent
> clock in `clocks` phandle) and the new one (UART clock referenced in the
> `clocks` phandle) are supported, to provide full backward compatibility
> with existing DTS files, full backward compatibility with existing boot
> loaders, and to provide new features (runtime clock configuration to
> allow higher baudrates than 230400 Bd). New features are available only
> with new DTS files.
>=20
> There was also a discussion about how the UART node and the
> clock-controller node could be wrapped together in a new binding [1, 2].
> As explained there, this is not possible if we want to keep backwards
> compatibility with existing bootloaders, and thus we are doing this by
> putting the UART clock-controller node inside the UART1 node.
>=20
> [1] https://lore.kernel.org/linux-serial/20220120000651.in7s6nazif5qjkme@=
pali/
> [2] https://lore.kernel.org/linux-serial/20220125204006.A6D09C340E0@smtp.=
kernel.org/
>=20
> Signed-off-by: Pali Roh=C3=A1r <pali@kernel.org>
> Reviewed-by: Marek Beh=C3=BAn <kabel@kernel.org>
> Signed-off-by: Marek Beh=C3=BAn <kabel@kernel.org>
> ---

Reviewed-by: Stephen Boyd <sboyd@kernel.org>
