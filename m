Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC516582026
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 08:33:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229766AbiG0GdU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 02:33:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbiG0GdS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 02:33:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 131433C8F7
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 23:33:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9C8A861388
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 06:33:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 799CBC433D6;
        Wed, 27 Jul 2022 06:33:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1658903596;
        bh=YRgKS1iX/LI3SK7g1hoSWb6zXVcjUyivmN8wTnsx/7E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ANGAj4QADm/IaNfPpTxKlzAZebSK3DoQnhZxkC+fgVMZ4GCb9P0jEt5qu66vjXG6e
         Cd3PUYbxJJx9RzTtdkY6HqsKntk3lxrtv2F2JKlY4GpP0Dx6HGB3SWu+xWOawbCM1B
         6OBmVdp6MbrOcnJbbPSjh0E+bRKE+VaK6O//td3o=
Date:   Wed, 27 Jul 2022 08:33:14 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Phillip Potter <phil@philpotter.co.uk>
Cc:     dan.carpenter@oracle.com, Larry.Finger@lwfinger.net,
        paskripkin@gmail.com, straube.linux@gmail.com, martin@kaiser.cx,
        abdun.nihaal@gmail.com, philipp.g.hortmann@gmail.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] staging: r8188eu: convert rtw_pwr_wakeup to correct
 error code semantics
Message-ID: <YuDcKoSibAo93a6P@kroah.com>
References: <20220725220745.12739-1-phil@philpotter.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220725220745.12739-1-phil@philpotter.co.uk>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 25, 2022 at 11:07:45PM +0100, Phillip Potter wrote:
> Convert the rtw_pwr_wakeup function to use 0 on success and an appropriate
> error code on error. For the first failure block where ips_leave is
> invoked, use -ENOMEM as this is the main cause of failure here anyway.
> For the second failure block, use -EBUSY, as it seems the most
> appropriate.
> 
> Finally, within the functions rtw_wx_set_mode, rtw_wx_set_wap,
> rtw_wx_set_scan and rtw_wx_set_essid, pass the error code on from
> rtw_pwr_wakeup as appropriate now that it is converted.
> 
> This gets the driver closer to removal of the non-standard _SUCCESS and
> _FAIL definitions, which are inverted compared to the standard in-kernel
> error code mechanism.
> 
> Signed-off-by: Phillip Potter <phil@philpotter.co.uk>
> ---
> 
> Changes from V1: Act on feedback from Dan Carpenter:
> * Try to use more appropriate error codes than -EPERM.
> * Revert the places where existing -1 was converted as they are out of
>   scope.
> * Preserve error codes in places where calling function already uses
>   proper negative semantics, so that they can be passed through to the
>   caller.
> 
> ---
>  drivers/staging/r8188eu/core/rtw_p2p.c       |  4 ++--
>  drivers/staging/r8188eu/core/rtw_pwrctrl.c   | 10 ++++----
>  drivers/staging/r8188eu/os_dep/ioctl_linux.c | 24 +++++++-------------
>  3 files changed, 15 insertions(+), 23 deletions(-)
> 
> diff --git a/drivers/staging/r8188eu/core/rtw_p2p.c b/drivers/staging/r8188eu/core/rtw_p2p.c
> index c306aafa183b..bd654d4ff8b4 100644
> --- a/drivers/staging/r8188eu/core/rtw_p2p.c
> +++ b/drivers/staging/r8188eu/core/rtw_p2p.c
> @@ -1888,7 +1888,7 @@ int rtw_p2p_enable(struct adapter *padapter, enum P2P_ROLE role)
>  
>  	if (role == P2P_ROLE_DEVICE || role == P2P_ROLE_CLIENT || role == P2P_ROLE_GO) {
>  		/* leave IPS/Autosuspend */
> -		if (rtw_pwr_wakeup(padapter) == _FAIL) {
> +		if (rtw_pwr_wakeup(padapter)) {
>  			ret = _FAIL;
>  			goto exit;
>  		}
> @@ -1902,7 +1902,7 @@ int rtw_p2p_enable(struct adapter *padapter, enum P2P_ROLE role)
>  		init_wifidirect_info(padapter, role);
>  
>  	} else if (role == P2P_ROLE_DISABLE) {
> -		if (rtw_pwr_wakeup(padapter) == _FAIL) {
> +		if (rtw_pwr_wakeup(padapter)) {
>  			ret = _FAIL;
>  			goto exit;
>  		}
> diff --git a/drivers/staging/r8188eu/core/rtw_pwrctrl.c b/drivers/staging/r8188eu/core/rtw_pwrctrl.c
> index cf9020a73933..8b1c50668dfe 100644
> --- a/drivers/staging/r8188eu/core/rtw_pwrctrl.c
> +++ b/drivers/staging/r8188eu/core/rtw_pwrctrl.c
> @@ -381,24 +381,24 @@ int rtw_pwr_wakeup(struct adapter *padapter)
>  	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
>  	unsigned long timeout = jiffies + msecs_to_jiffies(3000);
>  	unsigned long deny_time;
> -	int ret = _SUCCESS;
> +	int ret = 0;
>  
>  	while (pwrpriv->ps_processing && time_before(jiffies, timeout))
>  		msleep(10);
>  
>  	/* I think this should be check in IPS, LPS, autosuspend functions... */
>  	if (check_fwstate(pmlmepriv, _FW_LINKED)) {
> -		ret = _SUCCESS;
> +		ret = 0;

Nit, you don't need to set this again, as you already set it above to 0.

I'll take this as-is, as you are just keeping the original duplicated
logic, but it's something to clean up later.

Nice to see that moving to using the standard error values actually
removed lines of code, that's encouraging.

thanks,

greg k-h
