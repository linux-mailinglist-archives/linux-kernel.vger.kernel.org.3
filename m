Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDDB4520EF9
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 09:45:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236513AbiEJHtY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 03:49:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236375AbiEJHtH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 03:49:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F0D721606B;
        Tue, 10 May 2022 00:45:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BB9C060BBD;
        Tue, 10 May 2022 07:45:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F2A6C385C8;
        Tue, 10 May 2022 07:45:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652168710;
        bh=ugbpxd8hq/QSkUx3xtpNb3sp3DwgNUZqFp9044ceY2w=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=VFPunFaI5TndtsGBePg5J+Qh0sI89pJgb/IjxFbp9l/WFUsySvRK26ASAOeRV/5di
         35T4xOZVCYkarCNdLXm0RLiFji9yYegEmn2sPAnv7mYkUp8kJO0VBytxnIgwdKwUZW
         Ll7dCm991hduGH27fX+4j86Fx9YjWMRJOF56UqzqvAJ6qQN0sN2/m4ceUcy470kDmp
         v14C3u/gLLRsWPLj++xAIbyXvmcxXq1UWdYGQB79GAnsohmVYQkbmZnO0obPj41E9Y
         w5zKNgcDfBD7nY6LoM1Xqmf+U4OQZHN+fYZyshSCKCibIF9LxuZCxxWpR61i+z5PYt
         UIMrW7VnGWgaA==
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <maz@kernel.org>)
        id 1noKYN-00AAdL-7r; Tue, 10 May 2022 08:45:07 +0100
MIME-Version: 1.0
Date:   Tue, 10 May 2022 08:45:07 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     Haoran Jiang <jianghaoran@kylinos.cn>
Cc:     chenhuacai@kernel.org, jiaxun.yang@flygoat.com, tglx@linutronix.de,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] irqchip/loongson-liointc: 4 cores correspond to different
 interrupt status registers
In-Reply-To: <20220510055303.1907165-1-jianghaoran@kylinos.cn>
References: <20220510055303.1907165-1-jianghaoran@kylinos.cn>
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <4d047b6d65b3973b7cb58101a1c197a6@kernel.org>
X-Sender: maz@kernel.org
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: jianghaoran@kylinos.cn, chenhuacai@kernel.org, jiaxun.yang@flygoat.com, tglx@linutronix.de, linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-05-10 06:53, Haoran Jiang wrote:
> According to the loongson cpu manual,different cpu cores
> correspond to different interrupt status registers
> 
> Signed-off-by: Haoran Jiang <jianghaoran@kylinos.cn>
> ---
>  drivers/irqchip/irq-loongson-liointc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/irqchip/irq-loongson-liointc.c
> b/drivers/irqchip/irq-loongson-liointc.c
> index 649c58391618..f4e015b50af0 100644
> --- a/drivers/irqchip/irq-loongson-liointc.c
> +++ b/drivers/irqchip/irq-loongson-liointc.c
> @@ -195,7 +195,7 @@ static int __init liointc_of_init(struct 
> device_node *node,
>  		}
> 
>  		for (i = 0; i < LIOINTC_NUM_CORES; i++)
> -			priv->core_isr[i] = base + LIOINTC_REG_INTC_STATUS;
> +			priv->core_isr[i] = base + LIOINTC_REG_INTC_STATUS + i*8;
>  	}
> 
>  	for (i = 0; i < LIOINTC_NUM_PARENT; i++) {

You need to provide some more detail:

- where is it documented (something more precise than ¨the loongson cpu 
manual¨)?
- if something doesn´t work today, what is the impact?
- why does it work today without this change?
- if this is a fix, what commit does it fix?
- if this is a fix, does it need to be backported to stable kernels?

Thanks,

         M.
-- 
Jazz is not dead. It just smells funny...
