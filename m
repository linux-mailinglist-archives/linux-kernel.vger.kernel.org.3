Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA9245954C0
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 10:15:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232552AbiHPION (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 04:14:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232254AbiHPINd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 04:13:33 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED41DBC820
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 23:23:45 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1oNpzA-0008La-5A; Tue, 16 Aug 2022 08:23:32 +0200
Received: from mfe by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1oNpz8-0007Um-9l; Tue, 16 Aug 2022 08:23:30 +0200
Date:   Tue, 16 Aug 2022 08:23:30 +0200
From:   Marco Felsch <m.felsch@pengutronix.de>
To:     "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
Cc:     wim@linux-watchdog.org, linux@roeck-us.net, shawnguo@kernel.org,
        s.hauer@pengutronix.de, festevam@gmail.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-imx@nxp.com, kernel@pengutronix.de,
        linux-watchdog@vger.kernel.org
Subject: Re: [PATCH 2/7] watchdog: imx7ulp: Add explict memory barrier for
 unlock sequence
Message-ID: <20220816062330.z2fvurteg337krw2@pengutronix.de>
References: <20220816043643.26569-1-alice.guo@oss.nxp.com>
 <20220816043643.26569-3-alice.guo@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220816043643.26569-3-alice.guo@oss.nxp.com>
User-Agent: NeoMutt/20180716
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: mfe@pengutronix.de
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

On 22-08-16, Alice Guo (OSS) wrote:
> From: Jacky Bai <ping.bai@nxp.com>
> 
> Add explict memory barrier for the wdog unlock sequence.

Did you inspected any failures? It's not enough to say what you did, you
need to specify the why as well.

Regards,
  Marco


> 
> Suggested-by: Ye Li <ye.li@nxp.com>
> Signed-off-by: Jacky Bai <ping.bai@nxp.com>
> Signed-off-by: Alice Guo <alice.guo@nxp.com>
> Reviewed-by: Ye Li <ye.li@nxp.com>
> ---
>  drivers/watchdog/imx7ulp_wdt.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/watchdog/imx7ulp_wdt.c b/drivers/watchdog/imx7ulp_wdt.c
> index 014f497ea0dc..b8ac0cb04d2f 100644
> --- a/drivers/watchdog/imx7ulp_wdt.c
> +++ b/drivers/watchdog/imx7ulp_wdt.c
> @@ -179,9 +179,13 @@ static int imx7ulp_wdt_init(void __iomem *base, unsigned int timeout)
>  	int ret;
>  
>  	local_irq_disable();
> +
> +	mb();
>  	/* unlock the wdog for reconfiguration */
>  	writel_relaxed(UNLOCK_SEQ0, base + WDOG_CNT);
>  	writel_relaxed(UNLOCK_SEQ1, base + WDOG_CNT);
> +	mb();
> +
>  	ret = imx7ulp_wdt_wait(base, WDOG_CS_ULK);
>  	if (ret)
>  		goto init_out;
> -- 
> 2.17.1
> 
> 
> 
