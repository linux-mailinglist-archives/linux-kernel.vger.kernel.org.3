Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88F3C471F42
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 03:07:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231258AbhLMCH0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Dec 2021 21:07:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbhLMCH0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Dec 2021 21:07:26 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee2:21ea])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02492C06173F
        for <linux-kernel@vger.kernel.org>; Sun, 12 Dec 2021 18:07:25 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4JC4dg0zSsz4xRC;
        Mon, 13 Dec 2021 13:07:18 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1639361240;
        bh=lTfx18VymoG9QuC0MsUrsAbIld1kAWqt3BRTz6V4ggw=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=gR10PwgAzp/T52v0btkLWPb+Y6q9XmoBPPxU1s4IH88OqNaDe9tLwfIEC9Dlkp49l
         M7mlMD+H2PRnQjo3ptVvI9KFZEzIY9Js/7Rm5IluLBRmBWvTSYNK54NmgB8DxY6HrU
         I/ZJIY91BUtElnjtTcmBP1SQPyW8GblOxwXzr/K63e5jALf52ENJSxph6mRE4NI51b
         zlePJJiUpzmyndLAmc347Z0IMpwPp5eCymsFQyfd2+5QYNMY8KwFVrVZj3Z3e+mlE6
         I8W978ee54sx8ZfTiItYMXgQGJPvVqnlR35q/2pcNzRKgwGF+xzFtSFjwZWgm+Di26
         3OetNd3y+JmHA==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     xkernel <xkernel.wang@foxmail.com>, agust@denx.de
Cc:     benh@kernel.crashing.org, paulus@samba.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        xkernel <xkernel.wang@foxmail.com>
Subject: Re: [PATCH] powerpc: mpc52xx_gpt: fix a potential memory leak
In-Reply-To: <tencent_765F05E486793F9790A388C2289C5429F705@qq.com>
References: <tencent_765F05E486793F9790A388C2289C5429F705@qq.com>
Date:   Mon, 13 Dec 2021 13:07:18 +1100
Message-ID: <87lf0pmf55.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

xkernel <xkernel.wang@foxmail.com> writes:
> When some internal memory errors happend in of_iomap(), we should free
> gpt to prevent memory leak.

But it's allocated with devm_kzalloc(), so the devres core is meant to
free it for us isn't it?

cheers

> diff --git a/arch/powerpc/platforms/52xx/mpc52xx_gpt.c b/arch/powerpc/platforms/52xx/mpc52xx_gpt.c
> index f862b48..c506cfd 100644
> --- a/arch/powerpc/platforms/52xx/mpc52xx_gpt.c
> +++ b/arch/powerpc/platforms/52xx/mpc52xx_gpt.c
> @@ -722,8 +722,10 @@ static int mpc52xx_gpt_probe(struct platform_device *ofdev)
>  	gpt->dev = &ofdev->dev;
>  	gpt->ipb_freq = mpc5xxx_get_bus_frequency(ofdev->dev.of_node);
>  	gpt->regs = of_iomap(ofdev->dev.of_node, 0);
> -	if (!gpt->regs)
> +	if (!gpt->regs) {
> +		devm_kfree(&ofdev->dev, gpt);
>  		return -ENOMEM;
> +	}
>  
>  	dev_set_drvdata(&ofdev->dev, gpt);
>  
> -- 
