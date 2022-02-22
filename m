Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8D4E4BF2D8
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 08:46:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231234AbiBVHnC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 02:43:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231266AbiBVHmw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 02:42:52 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37C5459A56;
        Mon, 21 Feb 2022 23:42:27 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C83FF61224;
        Tue, 22 Feb 2022 07:42:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2F5BC340E8;
        Tue, 22 Feb 2022 07:42:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1645515746;
        bh=dBeDgEG5rHIyM94zUzickINy/WRIcWRAB6nD1Yps1Q0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mrEJXmP/SYcYGeltdY4YDilJhpCswQPVZNDGsHreyT49gk+uJjqBTLR4yjhBv404v
         C2CckRQ49qZWvWB+NiofVM6D0QOF9FZcYpXCjl2C5Qp1sHRuMqbK6KSXXcgcbsvnT/
         H0FzQDSnMol40aft1+v0pM5tN7x0W95TMWJtqESs=
Date:   Tue, 22 Feb 2022 08:42:23 +0100
From:   "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
To:     Ricky WU <ricky_wu@realtek.com>
Cc:     "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "kai.heng.feng@canonical.com" <kai.heng.feng@canonical.com>,
        "tommyhebb@gmail.com" <tommyhebb@gmail.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mmc: rtsx: add 74 Clocks in power on flow
Message-ID: <YhST32rsfl7MDv34@kroah.com>
References: <fb7cda69c5c244dfa579229ee2f0da83@realtek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fb7cda69c5c244dfa579229ee2f0da83@realtek.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 22, 2022 at 07:27:52AM +0000, Ricky WU wrote:
> After 1ms stabilizing the voltage time
> add "Host provides at least 74 Clocks
> before issuing first command" that is
> spec definition

You do have 72 columns to use here, no need to wrap this so tightly.

> 
> Signed-off-by: Ricky Wu <ricky_wu@realtek.com>
> ---
>  drivers/mmc/host/rtsx_pci_sdmmc.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/mmc/host/rtsx_pci_sdmmc.c b/drivers/mmc/host/rtsx_pci_sdmmc.c
> index 2a3f14afe9f8..e016d720e453 100644
> --- a/drivers/mmc/host/rtsx_pci_sdmmc.c
> +++ b/drivers/mmc/host/rtsx_pci_sdmmc.c
> @@ -940,10 +940,17 @@ static int sd_power_on(struct realtek_pci_sdmmc *host)
>  	if (err < 0)
>  		return err;
>  
> +	mdelay(1);

What is this delay for?

thanks,

greg k-h
