Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FBE1482C4A
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jan 2022 18:02:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229794AbiABRCK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Jan 2022 12:02:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229648AbiABRCK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jan 2022 12:02:10 -0500
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1B3CC061761
        for <linux-kernel@vger.kernel.org>; Sun,  2 Jan 2022 09:02:09 -0800 (PST)
Received: from dslb-188-104-058-096.188.104.pools.vodafone-ip.de ([188.104.58.96] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <postmaster@kaiser.cx>)
        id 1n44FB-0005FB-5O; Sun, 02 Jan 2022 18:02:05 +0100
Received: from martin by martin-debian-2.paytec.ch with local (Exim 4.94.2)
        (envelope-from <martin@martin-debian-2.paytec.ch>)
        id 1n44FA-000DFb-IA; Sun, 02 Jan 2022 18:02:04 +0100
Date:   Sun, 2 Jan 2022 18:02:04 +0100
From:   Martin Kaiser <martin@kaiser.cx>
To:     Michael Straube <straube.linux@gmail.com>
Cc:     gregkh@linuxfoundation.org, Larry.Finger@lwfinger.net,
        phil@philpotter.co.uk, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/7] staging: r8188eu: bRDGEnable is always false
Message-ID: <YdHajL5y9banviZN@martin-debian-1.paytec.ch>
References: <20220101084937.3411-1-straube.linux@gmail.com>
 <20220101084937.3411-2-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220101084937.3411-2-straube.linux@gmail.com>
Sender: "Martin Kaiser,,," <martin@martin-debian-2.paytec.ch>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thus wrote Michael Straube (straube.linux@gmail.com):

> The field bRDGEnable in struct hal_data_8188e is never set. It stays
> at its default value 0. Remove bRDGEnable and related dead code.

> Signed-off-by: Michael Straube <straube.linux@gmail.com>
> ---
> v3: no changes
> v2: no changes

>  drivers/staging/r8188eu/hal/usb_halinit.c      | 10 ----------
>  drivers/staging/r8188eu/include/rtl8188e_hal.h |  3 ---
>  2 files changed, 13 deletions(-)

> diff --git a/drivers/staging/r8188eu/hal/usb_halinit.c b/drivers/staging/r8188eu/hal/usb_halinit.c
> index d5c7e8bf1f38..104705ef170e 100644
> --- a/drivers/staging/r8188eu/hal/usb_halinit.c
> +++ b/drivers/staging/r8188eu/hal/usb_halinit.c
> @@ -384,13 +384,6 @@ static void _InitEDCA(struct adapter *Adapter)
>  	rtw_write32(Adapter, REG_EDCA_VO_PARAM, 0x002FA226);
>  }

> -static void _InitRDGSetting(struct adapter *Adapter)
> -{
> -	rtw_write8(Adapter, REG_RD_CTRL, 0xFF);
> -	rtw_write16(Adapter, REG_RD_NAV_NXT, 0x200);
> -	rtw_write8(Adapter, REG_RD_RESP_PKT_TH, 0x05);
> -}
> -
>  static void _InitRetryFunction(struct adapter *Adapter)
>  {
>  	u8 value8;
> @@ -712,9 +705,6 @@ u32 rtl8188eu_hal_init(struct adapter *Adapter)
>  	value16 |= (MACTXEN | MACRXEN);
>  	rtw_write8(Adapter, REG_CR, value16);

> -	if (haldata->bRDGEnable)
> -		_InitRDGSetting(Adapter);
> -
>  	/* Enable TX Report */
>  	/* Enable Tx Report Timer */
>  	value8 = rtw_read8(Adapter, REG_TX_RPT_CTRL);
> diff --git a/drivers/staging/r8188eu/include/rtl8188e_hal.h b/drivers/staging/r8188eu/include/rtl8188e_hal.h
> index b42af86555cd..e8cb093abb62 100644
> --- a/drivers/staging/r8188eu/include/rtl8188e_hal.h
> +++ b/drivers/staging/r8188eu/include/rtl8188e_hal.h
> @@ -236,9 +236,6 @@ struct hal_data_8188e {

>  	u32	RfRegChnlVal[2];

> -	/* RDG enable */
> -	bool	 bRDGEnable;
> -
>  	/* for host message to fw */
>  	u8	LastHMEBoxNum;

> -- 
> 2.34.1

Acked-by: Martin Kaiser <martin@kaiser.cx>
