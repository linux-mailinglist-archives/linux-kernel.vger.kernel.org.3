Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 659E55A5CC6
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 09:20:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230079AbiH3HT6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 03:19:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229823AbiH3HT4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 03:19:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1C37631D;
        Tue, 30 Aug 2022 00:19:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0FEB861466;
        Tue, 30 Aug 2022 07:19:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E168BC433C1;
        Tue, 30 Aug 2022 07:19:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661843993;
        bh=cNl2q6IwhNO1r/WX6/JP3SlN458v5wTt/geQej7BrCw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cTqkeBK2Wg4Rjz1Qdp1w2nJSsduJhiCv9dfwLA5MTJbuLRYnz3vtqKk3Ldhsq8yHt
         SLjbHymv3AUeKCudBUL0w9+QrRSGhOp0Pe+G1dU+OyZXinKR/qYKdn+u+0aMu2UjoM
         kClNAemEplLWLVZj8OZiYKcakpRJmDoVBnOiEbjLi2BWvWRSascb7QAbZRgGpLBx8g
         E69cPMRPj5GnhVphavfGEp2IF/7TpKG9KRDaMqR6XZnRVBGsEX9whTEaBJDGqKJxYA
         PXn3EqzZEabPnnBGZYXwnDXnAv+iiBKANwm5sTNPFCkrS7bTnADuBdzxAMtyp0pbFM
         HPw0ydz2KqMLA==
Date:   Tue, 30 Aug 2022 12:49:49 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     williamsukatube@163.com
Cc:     linux-phy@lists.infradead.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, jckuo@nvidia.com, kishon@ti.com,
        thierry.reding@gmail.com, jonathanh@nvidia.com,
        William Dean <williamsukatube@gmail.com>,
        Hacash Robot <hacashRobot@santino.com>
Subject: Re: [PATCH] phy: tegra: xusb: check the return value of
 devm_kzalloc() in tegra_xusb_setup_usb_role_switch()
Message-ID: <Yw26FXFyb3GwQaux@matsya>
References: <20220723034130.2952016-1-williamsukatube@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220723034130.2952016-1-williamsukatube@163.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23-07-22, 11:41, williamsukatube@163.com wrote:
> From: William Dean <williamsukatube@gmail.com>
> 
> The function devm_kzalloc() in tegra_xusb_setup_usb_role_switch()
> can fail, so its return value should be checked.
> 
> Fixes: f67213cee2b35 ("phy: tegra: xusb: Add usb-role-switch support")
> Reported-by: Hacash Robot <hacashRobot@santino.com>

Where is this bug report?

> Signed-off-by: William Dean <williamsukatube@gmail.com>
> ---
>  drivers/phy/tegra/xusb.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/phy/tegra/xusb.c b/drivers/phy/tegra/xusb.c
> index aa5237eacd29..e3611fb4c779 100644
> --- a/drivers/phy/tegra/xusb.c
> +++ b/drivers/phy/tegra/xusb.c
> @@ -668,6 +668,8 @@ static int tegra_xusb_setup_usb_role_switch(struct tegra_xusb_port *port)
>  	port->dev.driver = devm_kzalloc(&port->dev,
>  					sizeof(struct device_driver),
>  					GFP_KERNEL);
> +	if (!port->dev.driver)
> +		return -ENOMEM;
>  	port->dev.driver->owner	 = THIS_MODULE;
>  
>  	port->usb_role_sw = usb_role_switch_register(&port->dev,
> -- 
> 2.25.1

-- 
~Vinod
