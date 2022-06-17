Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC9A254FA74
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 17:40:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382475AbiFQPkO convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 17 Jun 2022 11:40:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380553AbiFQPkM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 11:40:12 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47D034ECE4
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 08:40:10 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1o2E4a-00013h-Dp; Fri, 17 Jun 2022 17:39:48 +0200
Received: from [2a0a:edc0:0:900:1d::4e] (helo=lupine)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1o2E4V-0015Kw-5S; Fri, 17 Jun 2022 17:39:44 +0200
Received: from pza by lupine with local (Exim 4.94.2)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1o2E4V-000AxJ-U4; Fri, 17 Jun 2022 17:39:43 +0200
Message-ID: <fb559ee2b165eeb83f40086ded8c44231cabd372.camel@pengutronix.de>
Subject: Re: [PATCH] arm: mach-imx: Fix refcount leak bug in src
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     Liang He <windhl@126.com>, linux@armlinux.org.uk,
        s.hauer@pengutronix.de, kernel@pengutronix.de, saravanak@google.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Date:   Fri, 17 Jun 2022 17:39:43 +0200
In-Reply-To: <20220617121235.4047670-1-windhl@126.com>
References: <20220617121235.4047670-1-windhl@126.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.38.3-1 
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fr, 2022-06-17 at 20:12 +0800, Liang He wrote:
> In imx7_src_init(), of_find_compatible_node() will return a node
> pointer with refcount incremented. We should use of_node_put() when
> it is not used anymore.
> 
> Signed-off-by: Liang He <windhl@126.com>
> ---
>  arch/arm/mach-imx/src.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/arm/mach-imx/src.c b/arch/arm/mach-imx/src.c
> index 59a8e8cc4469..fff2776f9180 100644
> --- a/arch/arm/mach-imx/src.c
> +++ b/arch/arm/mach-imx/src.c
> @@ -195,6 +195,7 @@ void __init imx7_src_init(void)
>  		return;
>  
> 
> 
> 
>  	src_base = of_iomap(np, 0);
> +	of_node_put(np);

Thank you for the patch. There is another instance of this pattern a
few lines above, in imx_src_init().

regards
Philipp
