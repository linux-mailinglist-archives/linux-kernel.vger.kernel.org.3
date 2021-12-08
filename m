Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 920A146D352
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 13:30:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233411AbhLHMeJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 07:34:09 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:36728 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233310AbhLHMeF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 07:34:05 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DD3C4B81F79
        for <linux-kernel@vger.kernel.org>; Wed,  8 Dec 2021 12:30:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97DA3C00446;
        Wed,  8 Dec 2021 12:30:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638966630;
        bh=RyybNb14tsCoWC9bKTMtoSeo+XhvC/N4HUVCjdkZRio=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=P3WFpnn4Cc/PMeXrvukkdIpKbQHPNc2zVZF714YytHRCyQApWLpzpizLt1Sk8/39X
         9lQM1tA0ykyFgAQLVDYqdz1Ku8zLb2c78+s5NBgtzDdMvpjRNCC5JVAfSKyK2j+yp9
         lxK+uYu9svAN8hOKUDursJ9kbEI+sreEOyyG5yd0X7msGapC0/V3maScUroj5WHrtG
         0fbIeZKyQj/7eY37dMi4hCld4bqLMFXYu1vV6QgmRV/UIAHt3MuQuSytfZxWw+LaDB
         n486lQrodKPAMcEhTdBvXd6Aht/bRUE7ZhATUmZjRMcSJdFd4tCjMVahiZTjhjSfjT
         2jBWLPcJySclw==
Date:   Wed, 8 Dec 2021 20:30:24 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Stephan Gerhold <stephan@gerhold.net>
Cc:     Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Jonathan =?iso-8859-1?Q?Neusch=E4fer?= <j.neuschaefer@gmx.net>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>, Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] soc: imx: Register SoC device only on i.MX boards
Message-ID: <20211208123024.GI4216@dragon>
References: <20211206113828.42523-1-stephan@gerhold.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211206113828.42523-1-stephan@gerhold.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 06, 2021 at 12:38:28PM +0100, Stephan Gerhold wrote:
> At the moment, using the ARM32 multi_v7_defconfig always results in two
> SoCs being exposed in sysfs. This is wrong, as far as I'm aware the
> Qualcomm DragonBoard 410c does not actually make use of a i.MX SoC. :)
> 
>   qcom-db410c:/sys/devices/soc0$ grep . *
>   family:Freescale i.MX
>   machine:Qualcomm Technologies, Inc. APQ 8016 SBC
>   revision:0.0
>   serial_number:0000000000000000
>   soc_id:Unknown
> 
>   qcom-db410c:/sys/devices/soc1$ grep . *
>   family:Snapdragon
>   machine:APQ8016
>   ...
> 
> This happens because imx_soc_device_init() registers the soc device
> unconditionally, even when running on devices that do not make use of i.MX.
> Arnd already reported this more than a year ago and even suggested a fix
> similar to this commit, but for some reason it was never submitted.
> 
> Fix it by checking if the "__mxc_cpu_type" variable was actually
> initialized by earlier platform code. On devices without i.MX it will
> simply stay 0.
> 
> Cc: Peng Fan <peng.fan@nxp.com>
> Fixes: d2199b34871b ("ARM: imx: use device_initcall for imx_soc_device_init")
> Reported-by: Arnd Bergmann <arnd@arndb.de>
> Link: https://lore.kernel.org/r/CAK8P3a0hxO1TmK6oOMQ70AHSWJnP_CAq57YMOutrxkSYNjFeuw@mail.gmail.com/
> Signed-off-by: Stephan Gerhold <stephan@gerhold.net>

Applied, thanks!
