Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A7FD4DCEE8
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 20:37:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231217AbiCQTig (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 15:38:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230122AbiCQTie (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 15:38:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C15122C6D4;
        Thu, 17 Mar 2022 12:37:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D3276618A9;
        Thu, 17 Mar 2022 19:37:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33264C340E9;
        Thu, 17 Mar 2022 19:37:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647545837;
        bh=wZADvi8AH8u7rrJ6fm+rJHZo13IxweiVHExl3Kx7B8w=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=hxtB08nDB74+ElGeDdXkWH2FwFo4gBAPQhiuOUh6fiSJfkzsO9ah0hwNQZenA/2th
         knoPfLRHIgJRHROWhmzJTG6F9Fq+0/Zh5mk1NQJiWYukgxxHc/hvBkXrluk/dPk2NU
         qkFORdIDaAGS2ottyyHKj5SJQnYlXq2XJN69JdWRSEW7N8ytZOLmZnmP/z610zzvCu
         Nk1pkksgr4jUvI6cnWW1Sdz3ngU4P0226G1+zvejoiISo33DYMD/URR3oOf/dErLxX
         8+8mguAIhlrHNj5hau8+szip14RmlbPiL01ExsNKXhGXXwobUN/RBIIIrcIsst1Lnd
         QbY9JPVh18gxA==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220228124112.3974242-1-peng.fan@oss.nxp.com>
References: <20220228124112.3974242-1-peng.fan@oss.nxp.com>
Subject: Re: [PATCH V2 1/2] clk: imx: add mcore_booted module paratemter
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
To:     Peng Fan (OSS) <peng.fan@oss.nxp.com>, abel.vesa@nxp.com,
        s.hauer@pengutronix.de, shawnguo@kernel.org
Date:   Thu, 17 Mar 2022 12:37:15 -0700
User-Agent: alot/0.10
Message-Id: <20220317193717.33264C340E9@smtp.kernel.org>
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Peng Fan (OSS) (2022-02-28 04:41:11)
> From: Peng Fan <peng.fan@nxp.com>
>=20
> Add mcore_booted boot parameter which could simplify AMP clock
> management. To i.MX8M, there is CCM(clock control Module) to generate
> clock root clock, anatop(analog PLL module) to generate PLL, and CCGR
> (clock gating) to gate clocks to peripherals. As below:
>   anatop->ccm->ccgr->peripheral
>=20
> Linux handles the clock management and the auxiliary core is under
> control of Linux. Although there is per hardware domain control for CCGR
> and CCM, auxiliary core normally only use CCGR hardware domain control
> to avoid linux gate off the clk to peripherals and leave CCM ana anatop
> to Linux.
>=20
> Per NXP hardware design, because CCGR already support gate to
> peripherals, and clk root gate power leakage is negligible. So
> when in AMP case, we could not register the clk root gate.
>=20
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>=20
> V2:
>  Switch to use module parameter, tested on i.MX8MP-EVK

Why is a module parameter being used? I'd expect this informatioon that
mcore is booted to come from devicetree/firmware somehow.
