Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDC865857AB
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Jul 2022 03:01:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239349AbiG3BBC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jul 2022 21:01:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229599AbiG3BA7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jul 2022 21:00:59 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F3C6814A8;
        Fri, 29 Jul 2022 18:00:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CAB11B829FD;
        Sat, 30 Jul 2022 01:00:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CF6BC433D6;
        Sat, 30 Jul 2022 01:00:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659142856;
        bh=+InU6DDPWuuUM25a8VhayS37OQxLsx3tuBE0/qqb3aA=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=hey4AyJjXGgwdIeZX+TIzwM0uRat9O61ztXTZTuz1MtO1arOYvAm52jlnKF6+uT74
         WLRjvmkUvS6tWu6u220VrmU8g3ysvF31VTiZUEAjKbtwFb1jTaZrGfl5GpngYisqHb
         skb3PpWxzDzXdMkuRlwh1uqAyScOodeBVnpJsZ6Ty9zvbX7IGJrpa8WuZPOHscPUd2
         2U7K/OVSQAzHCAhwEDCa3lZ8Bpk57K0t599odFuwhOproYWXSQUmgdOG7aXizyE+vL
         4EkAFs8YXu9IzhEU0y37dLo50V1mp/FgsnC8AyHOPeWGHLPcj+ecAOmJ0tkMogHgVT
         bwINbV5mMAZdg==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220630141308.121526-1-yangyingliang@huawei.com>
References: <20220630141308.121526-1-yangyingliang@huawei.com>
Subject: Re: [PATCH -next] clk: imx: remove unnecessary NULL check of clk
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     abelvesa@kernel.org, shawnguo@kernel.org
To:     Yang Yingliang <yangyingliang@huawei.com>,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Fri, 29 Jul 2022 18:00:54 -0700
User-Agent: alot/0.10
Message-Id: <20220730010056.7CF6BC433D6@smtp.kernel.org>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Yang Yingliang (2022-06-30 07:13:08)
> It has NULL check in clk_prepare_enable(), so it no need
> to check the clk before calling it.
>=20
> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
> ---
>  drivers/clk/imx/clk.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>=20
> diff --git a/drivers/clk/imx/clk.c b/drivers/clk/imx/clk.c
> index 5582f18dd632..1c5d5b957c96 100644
> --- a/drivers/clk/imx/clk.c
> +++ b/drivers/clk/imx/clk.c
> @@ -189,9 +189,7 @@ void imx_register_uart_clocks(unsigned int clk_count)
>                         if (IS_ERR(imx_uart_clocks[imx_enabled_uart_clock=
s]))
>                                 return;
> =20
> -                       /* Only enable the clock if it's not NULL */
> -                       if (imx_uart_clocks[imx_enabled_uart_clocks])
> -                               clk_prepare_enable(imx_uart_clocks[imx_en=
abled_uart_clocks++]);
> +                       clk_prepare_enable(imx_uart_clocks[imx_enabled_ua=
rt_clocks++]);

Nak

The ++ operator has side-effects, which wasn't the case before this
patch.
