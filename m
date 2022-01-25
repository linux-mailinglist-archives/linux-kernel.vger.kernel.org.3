Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 966FF49B4BD
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 14:16:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1575916AbiAYNPE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 08:15:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1575767AbiAYNLn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 08:11:43 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 356FEC061772;
        Tue, 25 Jan 2022 05:11:30 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id w14so9642212edd.10;
        Tue, 25 Jan 2022 05:11:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/8kXB8Jvsf5emlSsCDXGO/3PDa7GmKokwIjfKKGh1fM=;
        b=aDip0h+8v8iAk9XjOinn9q6DgtgcwkxeyUxnDvg55aTDwwpgfJdyDDV9tFYidAIfJL
         lZcPo1O7Vhz2Zgwcd4r8YWeE/1ZWaSlcNbOYVf6SJsAWAc4zpnvOcQct5tVUGXOCRFOC
         JJtqf+XhAaIX4i4FtuQAtTNT4MSuU+/4FNqiPVYzB60Y7uLQAhmPli1OZsg9o//EUSkU
         Tz7MlT7bZojw/Z9uuUu0GVElMEtda0On0/QDVEKyYBfgoxJ/aCoct9FGzyQ2YpRu6mO9
         ZfotZYk6KN4+fzA6NjJWZge4bU8mDr60VBg3HHYg9l9nRbFaWwOcN2aWBMmh1pVpIVk1
         9uhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/8kXB8Jvsf5emlSsCDXGO/3PDa7GmKokwIjfKKGh1fM=;
        b=PJ5GLodum514Wb3No59CqjFb4XpFtIYhroSQT9dtfZyih1nG0bPqdFQRRRog7PL/3B
         JzLtTs+u7JGYXb+qDvrtF9eb5nyITDJoJxxqTQMQ9hihkHRgKxHdqVdATOD+kUL2S6KW
         GAetRihb8cssl3KULQYquU9DbYTSzTyMOSlVFEzz2LdYb4svukgCVMfzNwezTPRrJU5J
         wJ++twt9kbskO11IjQPEKT/5reAXmVL66qSdpBFBatGugttGkGqEVmZbtHcXnnv5nnuL
         lepnXR2rOxbePR+6BY227GEBt8cSDF5dikKqPW2yGs6sSD7I71get4XpNv9IdVPYRZdd
         KhHQ==
X-Gm-Message-State: AOAM533rIxwD2uB6UFst/AjleDvQBXXxPTVZhXTga66Ey+hwNmxWvK4A
        3Gg+G1out+ETi7PPZi3YEJhPtOq9eyOT2sm7O5uYK3dVF6A=
X-Google-Smtp-Source: ABdhPJzrRWjfMe+b4bzYurtS0s1oDB0hjK68R0oYUz01FkfrBT7Gs8YP+Q/r0N6L9FVvYOiT7kp8W5KQixW8tcDvsmU=
X-Received: by 2002:a50:d709:: with SMTP id t9mr11768142edi.50.1643116288702;
 Tue, 25 Jan 2022 05:11:28 -0800 (PST)
MIME-Version: 1.0
References: <20220125085206.8508-1-ceggers@arri.de> <20220125085206.8508-2-ceggers@arri.de>
In-Reply-To: <20220125085206.8508-2-ceggers@arri.de>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Tue, 25 Jan 2022 10:11:17 -0300
Message-ID: <CAOMZO5A2c1seLDHzb3HL58_cThM5LGB7n0Atywu_BhTCXAThyg@mail.gmail.com>
Subject: Re: [PATCH 1/6] clk: imx6ul: disable gpmi_io clock before changing
 parent clock
To:     Christian Eggers <ceggers@arri.de>
Cc:     Abel Vesa <abel.vesa@nxp.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-clk <linux-clk@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Stefan Riedmueller <s.riedmueller@phytec.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christian,

On Tue, Jan 25, 2022 at 5:53 AM Christian Eggers <ceggers@arri.de> wrote:
>
> gpmi_io clock may have been enabled by the boot loader. All children of
> enfc_clk_root must be gated in order to prevent glitches during parent
> change.
>
> Signed-off-by: Christian Eggers <ceggers@arri.de>
> ---
> drivers/clk/imx/clk-imx6ul.c | 9 +++++++++
> 1 file changed, 9 insertions(+)
>
> diff --git a/drivers/clk/imx/clk-imx6ul.c b/drivers/clk/imx/clk-imx6ul.c
> index 520b100bff4b..f599ae50dd9f 100644
> --- a/drivers/clk/imx/clk-imx6ul.c
> +++ b/drivers/clk/imx/clk-imx6ul.c
> @@ -514,6 +514,15 @@ static void __init imx6ul_clocks_init(struct device_node *ccm_node)
> else if (clk_on_imx6ull())
> clk_set_parent(hws[IMX6ULL_CLK_EPDC_PRE_SEL]->clk, hws[IMX6UL_CLK_PLL3_PFD2]->clk);
>
> + /*
> + * gpmi_io clock may have been enabled by the boot loader. All children of
> + * enfc_clk_root must be gated in order to prevent glitches during parent
> + * change. The task of re-enabling is left to the gpmi-nand driver.
> + */
> + if (clk_hw_is_enabled(hws[IMX6UL_CLK_GPMI_IO])) {
> + clk_prepare_enable(hws[IMX6UL_CLK_GPMI_IO]->clk);
> + clk_disable_unprepare(hws[IMX6UL_CLK_GPMI_IO]->clk);
> + }

It seems your patch series was corrupted.

Could you please try sending it via git send-mail?
