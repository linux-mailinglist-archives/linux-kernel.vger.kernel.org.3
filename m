Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33AD54ED6EE
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 11:30:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234018AbiCaJaz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 05:30:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234103AbiCaJak (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 05:30:40 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79F18204A85
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 02:28:14 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=[IPv6:::1])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <l.stach@pengutronix.de>)
        id 1nZr67-00066h-2h; Thu, 31 Mar 2022 11:28:07 +0200
Message-ID: <319e976acb0a686e596b88520dbcda59c78afe9e.camel@pengutronix.de>
Subject: Re: [PATCH] soc: imx: gpcv2: keep i.MX8MM VPU-H1 bus clock active
From:   Lucas Stach <l.stach@pengutronix.de>
To:     Adam Ford <aford173@gmail.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     tharvey@gateworks.com, aford@beaconembedded.com,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Peng Fan <peng.fan@nxp.com>, linux-kernel@vger.kernel.org
Date:   Thu, 31 Mar 2022 11:28:05 +0200
In-Reply-To: <20211120193916.1309236-1-aford173@gmail.com>
References: <20211120193916.1309236-1-aford173@gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.4 (3.40.4-1.fc34) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: l.stach@pengutronix.de
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

Hi Adam, hi Shawn,

Am Samstag, dem 20.11.2021 um 13:39 -0600 schrieb Adam Ford:
> Enable the vpu-h1 clock when the domain is active because reading
> or writing to the VPU-H1 IP block cause the system to hang.
> 
> Fixes: 656ade7aa42a ("soc: imx: gpcv2: keep i.MX8M* bus clocks enabled")
> Signed-off-by: Adam Ford <aford173@gmail.com>
> 
> diff --git a/drivers/soc/imx/gpcv2.c b/drivers/soc/imx/gpcv2.c
> index b8d52d8d29db..7b6dfa33dcb9 100644
> --- a/drivers/soc/imx/gpcv2.c
> +++ b/drivers/soc/imx/gpcv2.c
> @@ -734,6 +734,7 @@ static const struct imx_pgc_domain imx8mm_pgc_domains[] = {
>  			.map = IMX8MM_VPUH1_A53_DOMAIN,
>  		},
>  		.pgc   = BIT(IMX8MM_PGC_VPUH1),
> +		.keep_clocks = true,
>  	},
> 
I missed this patch and just stumbled across it when looking at the git
history. I don't think this patch is correct. The H1 GPC domain does
not even have clocks assigned in the DT, so there is nothing to keep
active. Also H1 is not a MIX domain, so it should not keep any bus
clocks active, that is the job of the VPUMIX domain.

While this patch is a no-op, as far as I can see, it still seems wrong
and I think it should be reverted.

Regards,
Lucas

