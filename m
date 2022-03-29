Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42F874EB13C
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 18:03:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239136AbiC2QEo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 12:04:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231715AbiC2QEm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 12:04:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0270A51590
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 09:03:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 909BB612BB
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 16:02:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AB74C340ED;
        Tue, 29 Mar 2022 16:02:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1648569779;
        bh=+q4+Hl3IcsnX+jNp7JBRzeIp3DEq5pwNrnRmkAODPD0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=1Xt8gzFJFS6qOnX+HIQScyDTNlcEsj7AfOwO9j5OsVFAuHowA32AwbSC75+Kep43D
         q+Yz7vv2BQBVIC3fMJBx5aauKIhdB7zQJOgrphL/3rPPw0nJwsR519zsKtMgQNsJpS
         RamQFeAhYrpr3f6RqjPNTlBJulBn9X0G9g4o08qo=
Date:   Tue, 29 Mar 2022 18:02:56 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Michael Straube <straube.linux@gmail.com>
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/9] staging: r8188eu: remove HW_VAR_ACM_CTRL from
 SetHwReg8188EU()
Message-ID: <YkMtsKlCsMOnV1Q0@kroah.com>
References: <20220328113940.6396-1-straube.linux@gmail.com>
 <20220328113940.6396-5-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220328113940.6396-5-straube.linux@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 28, 2022 at 01:39:35PM +0200, Michael Straube wrote:
> SetHwReg8188EU() is called with HW_VAR_ACM_CTRL only in one place.
> Remove the HW_VAR_RESP_SIFS case from SetHwReg8188EU() and replace its
> call with the code from that case. This is part of the ongoing effort
> to get rid of the unwanted hal layer.
> 
> Signed-off-by: Michael Straube <straube.linux@gmail.com>
> ---
>  drivers/staging/r8188eu/core/rtw_wlan_util.c | 27 +++++++++++++++++---
>  drivers/staging/r8188eu/hal/usb_halinit.c    | 26 -------------------
>  drivers/staging/r8188eu/include/hal_intf.h   |  1 -
>  3 files changed, 24 insertions(+), 30 deletions(-)
> 
> diff --git a/drivers/staging/r8188eu/core/rtw_wlan_util.c b/drivers/staging/r8188eu/core/rtw_wlan_util.c
> index eda4e5f9a6af..cde3779ff21d 100644
> --- a/drivers/staging/r8188eu/core/rtw_wlan_util.c
> +++ b/drivers/staging/r8188eu/core/rtw_wlan_util.c
> @@ -571,10 +571,31 @@ void WMMOnAssocRsp(struct adapter *padapter)
>  		}
>  	}
>  
> -	if (padapter->registrypriv.acm_method == 1)
> -		SetHwReg8188EU(padapter, HW_VAR_ACM_CTRL, (u8 *)(&acm_mask));
> -	else
> +	if (padapter->registrypriv.acm_method == 1) {
> +		u8 acmctrl = rtw_read8(padapter, REG_ACMHWCTRL);
> +
> +		if (acm_mask > 1)
> +			acmctrl = acmctrl | 0x1;
> +
> +		if (acm_mask & BIT(3))
> +			acmctrl |= ACMHW_VOQEN;
> +		else
> +			acmctrl &= (~ACMHW_VOQEN);
> +
> +		if (acm_mask & BIT(2))
> +			acmctrl |= ACMHW_VIQEN;
> +		else
> +			acmctrl &= (~ACMHW_VIQEN);
> +
> +		if (acm_mask & BIT(1))
> +			acmctrl |= ACMHW_BEQEN;
> +		else
> +			acmctrl &= (~ACMHW_BEQEN);
> +
> +		rtw_write8(padapter, REG_ACMHWCTRL, acmctrl);

Shouldn't be a function that explains what you are doing here?  Like you
did with previous changes in this patch series?

thanks,

greg k-h
