Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 179984F1706
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 16:32:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359377AbiDDOeT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 10:34:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349018AbiDDOeR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 10:34:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 543FB3EF3F
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 07:32:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E42CF61475
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 14:32:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E958DC2BBE4;
        Mon,  4 Apr 2022 14:32:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1649082740;
        bh=Dj36icQ5FGKXlBd/rFO86IF80muiRSiYMEcz20M5cfE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=05KayeMn4CSJCwMj1m7ue4qAKCZbP/RK52o9OIj8pJUEvbaaPyjn3kIL+sUaNnuEH
         O9pTzYMPV7e06rn0viw1qigtk4U2ByMyMnmY8h6NCyN9kiGOxIcmRWxBiw3Q8LdGGf
         hnz7EVRjZS5kxyvxx1UQZ/xPUOz/4qDQFwj+p3lA=
Date:   Mon, 4 Apr 2022 16:32:17 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Michael Straube <straube.linux@gmail.com>
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/5] staging: r8188eu: remove HAL_DEF_IS_SUPPORT_ANT_DIV
Message-ID: <YksBcUBXbgzXmEBO@kroah.com>
References: <20220403165255.6900-1-straube.linux@gmail.com>
 <20220403165255.6900-2-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220403165255.6900-2-straube.linux@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 03, 2022 at 06:52:51PM +0200, Michael Straube wrote:
> In order to get rid of the function GetHalDefVar8188EUsb(), remove
> the HAL_DEF_IS_SUPPORT_ANT_DIV case from it and move the functionality
> into a new function. This is part of the ongoing effort to get rid of
> the unwanted hal layer.
> 
> Signed-off-by: Michael Straube <straube.linux@gmail.com>
> ---
>  drivers/staging/r8188eu/core/rtw_cmd.c     |  4 +---
>  drivers/staging/r8188eu/core/rtw_mlme.c    |  4 +---
>  drivers/staging/r8188eu/hal/usb_halinit.c  | 10 +++++++---
>  drivers/staging/r8188eu/include/hal_intf.h |  3 ++-
>  4 files changed, 11 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/staging/r8188eu/core/rtw_cmd.c b/drivers/staging/r8188eu/core/rtw_cmd.c
> index 8b24330e97c1..c286485e6a40 100644
> --- a/drivers/staging/r8188eu/core/rtw_cmd.c
> +++ b/drivers/staging/r8188eu/core/rtw_cmd.c
> @@ -1099,11 +1099,9 @@ u8 rtw_antenna_select_cmd(struct adapter *padapter, u8 antenna, u8 enqueue)
>  	struct cmd_obj		*ph2c;
>  	struct drvextra_cmd_parm	*pdrvextra_cmd_parm;
>  	struct cmd_priv	*pcmdpriv = &padapter->cmdpriv;
> -	u8	support_ant_div;
>  	u8	res = _SUCCESS;
>  
> -	GetHalDefVar8188EUsb(padapter, HAL_DEF_IS_SUPPORT_ANT_DIV, &support_ant_div);
> -	if (!support_ant_div)
> +	if (!support_ant_div(padapter))
>  		return res;
>  
>  	if (enqueue) {
> diff --git a/drivers/staging/r8188eu/core/rtw_mlme.c b/drivers/staging/r8188eu/core/rtw_mlme.c
> index f94b1536a177..b6ed5fb5b281 100644
> --- a/drivers/staging/r8188eu/core/rtw_mlme.c
> +++ b/drivers/staging/r8188eu/core/rtw_mlme.c
> @@ -1458,7 +1458,6 @@ int rtw_select_and_join_from_scanned_queue(struct mlme_priv *pmlmepriv)
>  	struct __queue *queue	= &pmlmepriv->scanned_queue;
>  	struct	wlan_network	*pnetwork = NULL;
>  	struct	wlan_network	*candidate = NULL;
> -	u8	supp_ant_div = false;
>  
>  	spin_lock_bh(&pmlmepriv->scanned_queue.lock);
>  	phead = get_list_head(queue);
> @@ -1485,8 +1484,7 @@ int rtw_select_and_join_from_scanned_queue(struct mlme_priv *pmlmepriv)
>  		rtw_free_assoc_resources(adapter, 0);
>  	}
>  
> -	GetHalDefVar8188EUsb(adapter, HAL_DEF_IS_SUPPORT_ANT_DIV, &supp_ant_div);
> -	if (supp_ant_div) {
> +	if (support_ant_div(adapter)) {
>  		u8 cur_ant;
>  		GetHalDefVar8188EUsb(adapter, HAL_DEF_CURRENT_ANTENNA, &cur_ant);
>  	}
> diff --git a/drivers/staging/r8188eu/hal/usb_halinit.c b/drivers/staging/r8188eu/hal/usb_halinit.c
> index 4bc6b08fb282..31ec88b7a400 100644
> --- a/drivers/staging/r8188eu/hal/usb_halinit.c
> +++ b/drivers/staging/r8188eu/hal/usb_halinit.c
> @@ -481,6 +481,13 @@ static void _BBTurnOnBlock(struct adapter *Adapter)
>  	rtl8188e_PHY_SetBBReg(Adapter, rFPGA0_RFMOD, bOFDMEn, 0x1);
>  }
>  
> +bool support_ant_div(struct adapter *adapter)

That's a very odd function name to add to the kernel's global namespace
:(

Pleas emake it more obvious what this is for, with the driver name as
part of the prefix?

thanks,

greg k-h
