Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CD1A4C0D21
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 08:16:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237974AbiBWHRO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 02:17:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235535AbiBWHRM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 02:17:12 -0500
Received: from mail.pr-group.ru (mail.pr-group.ru [178.18.215.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6D1C46B37
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 23:16:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
        d=metrotek.ru; s=mail;
        h=from:subject:date:message-id:to:cc:mime-version:content-type:in-reply-to:
         references;
        bh=icH7A7Mcs++qD6v5oQ8tnDH0OAovFNxVtZ/iN3vwo5A=;
        b=RyYb6zh4/8jx3DHYHETaBRijqqqVcjILRnS4ag9VD+wVMIvz+CTOz4NdD/Njos+fPsJ8hq3EzxqNs
         crwrKNV12uxtbDVyxO+WocVy9pBuAfOs8H0BwSfIw4Y46VbqLGxDAFMENpe9/BIY5di/KeFg1L5BQr
         HOXheRaxpdsTmXY0gWWOk+Ncxq4zFpWwTBKtSPKnHlX7Xgk5u5LuCLAbNUlf1+4g3Zcbfd/1nwUAoO
         0IJl5tBsDp6XLTh8qDQmjEiFY/20eZeMRyn4GmcoHCtJSXID2HCOf2t7oEz/dRIltfSXOAEwf5WBNn
         D9osPXpy/mC7LHXDhsQrPaTsLduwCTw==
X-Kerio-Anti-Spam:  Build: [Engines: 2.16.2.1410, Stamp: 3], Multi: [Enabled, t: (0.000008,0.005258)], BW: [Enabled, t: (0.000022,0.000001)], RTDA: [Enabled, t: (0.065102), Hit: No, Details: v2.25.0; Id: 15.52kbl7.1fsin0mpv.nh05; mclb], total: 0(700)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Level: 
X-Footer: bWV0cm90ZWsucnU=
Received: from x260 ([178.70.66.234])
        (authenticated user i.bornyakov@metrotek.ru)
        by mail.pr-group.ru with ESMTPSA
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256 bits));
        Wed, 23 Feb 2022 10:16:33 +0300
Date:   Wed, 23 Feb 2022 09:58:15 +0300
From:   Ivan Bornyakov <i.bornyakov@metrotek.ru>
To:     Wan Jiabing <wanjiabing@vivo.com>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        jiabing.wan@qq.com
Subject: Re: [PATCH] bus: imx-weim: fix NULL but dereferenced coccicheck error
Message-ID: <20220223065815.i7qbyz2gtkgjzcwv@x260>
References: <20220223035146.412499-1-wanjiabing@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220223035146.412499-1-wanjiabing@vivo.com>
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 23, 2022 at 11:51:45AM +0800, Wan Jiabing wrote:
> Fix following coccicheck warning:
> ./drivers/bus/imx-weim.c:355:18-21: ERROR: pdev is NULL but dereferenced.
> 
> Signed-off-by: Wan Jiabing <wanjiabing@vivo.com>
> ---
>  drivers/bus/imx-weim.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/bus/imx-weim.c b/drivers/bus/imx-weim.c
> index 60fbd42041dd..2ea0a51f79f6 100644
> --- a/drivers/bus/imx-weim.c
> +++ b/drivers/bus/imx-weim.c
> @@ -352,8 +352,7 @@ static int of_weim_notify(struct notifier_block *nb, unsigned long action,
>  
>  		pdev = of_find_device_by_node(rd->dn);
>  		if (!pdev) {
> -			dev_err(&pdev->dev,
> -				"Could not find platform device for '%pOF'\n",
> +			pr_err("Could not find platform device for '%pOF'\n",
>  				rd->dn);
>  
>  			ret = notifier_from_errno(-EINVAL);
> -- 
> 2.35.1
> 

Acked-by: Ivan Bornyakov <i.bornyakov@metrotek.ru>

