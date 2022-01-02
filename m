Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E95F482C50
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jan 2022 18:06:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229669AbiABRGu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Jan 2022 12:06:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbiABRGt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jan 2022 12:06:49 -0500
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64B50C061761
        for <linux-kernel@vger.kernel.org>; Sun,  2 Jan 2022 09:06:49 -0800 (PST)
Received: from dslb-188-104-058-096.188.104.pools.vodafone-ip.de ([188.104.58.96] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <postmaster@kaiser.cx>)
        id 1n44Jg-0005Gp-NC; Sun, 02 Jan 2022 18:06:44 +0100
Received: from martin by martin-debian-2.paytec.ch with local (Exim 4.94.2)
        (envelope-from <martin@martin-debian-2.paytec.ch>)
        id 1n44Jf-000DmX-6I; Sun, 02 Jan 2022 18:06:43 +0100
Date:   Sun, 2 Jan 2022 18:06:43 +0100
From:   Martin Kaiser <martin@kaiser.cx>
To:     Michael Straube <straube.linux@gmail.com>
Cc:     gregkh@linuxfoundation.org, Larry.Finger@lwfinger.net,
        phil@philpotter.co.uk, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/7] staging: r8188eu: UsbRxHighSpeedMode is set but
 never used
Message-ID: <YdHbo6YXFmI+UQJh@martin-debian-1.paytec.ch>
References: <20220101084937.3411-1-straube.linux@gmail.com>
 <20220101084937.3411-3-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220101084937.3411-3-straube.linux@gmail.com>
Sender: "Martin Kaiser,,," <martin@martin-debian-2.paytec.ch>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thus wrote Michael Straube (straube.linux@gmail.com):

> The field UsbRxHighSpeedMode of struct hal_data_8188e is set but
> never used. Remove it.

> Signed-off-by: Michael Straube <straube.linux@gmail.com>
> ---
> v3: no changes
> v2: no changes

>  drivers/staging/r8188eu/hal/usb_halinit.c      | 5 -----
>  drivers/staging/r8188eu/include/rtl8188e_hal.h | 3 ---
>  2 files changed, 8 deletions(-)

> diff --git a/drivers/staging/r8188eu/hal/usb_halinit.c b/drivers/staging/r8188eu/hal/usb_halinit.c
> index 104705ef170e..96db9a8e7667 100644
> --- a/drivers/staging/r8188eu/hal/usb_halinit.c
> +++ b/drivers/staging/r8188eu/hal/usb_halinit.c
> @@ -502,16 +502,11 @@ usb_AggSettingRxUpdate(

>  static void InitUsbAggregationSetting(struct adapter *Adapter)
>  {
> -	struct hal_data_8188e *haldata = &Adapter->haldata;
> -
>  	/*  Tx aggregation setting */
>  	usb_AggSettingTxUpdate(Adapter);

>  	/*  Rx aggregation setting */
>  	usb_AggSettingRxUpdate(Adapter);
> -
> -	/*  201/12/10 MH Add for USB agg mode dynamic switch. */
> -	haldata->UsbRxHighSpeedMode = false;
>  }

>  static void _InitOperationMode(struct adapter *Adapter)
> diff --git a/drivers/staging/r8188eu/include/rtl8188e_hal.h b/drivers/staging/r8188eu/include/rtl8188e_hal.h
> index e8cb093abb62..8b54f52f49e2 100644
> --- a/drivers/staging/r8188eu/include/rtl8188e_hal.h
> +++ b/drivers/staging/r8188eu/include/rtl8188e_hal.h
> @@ -262,9 +262,6 @@ struct hal_data_8188e {
>  	u8	OutEpQueueSel;
>  	u8	OutEpNumber;

> -	/*  Add for USB aggreation mode dynamic shceme. */
> -	bool		UsbRxHighSpeedMode;
> -
>  	/*  2010/11/22 MH Add for slim combo debug mode selective. */
>  	/*  This is used for fix the drawback of CU TSMC-A/UMC-A cut.
>  	 * HW auto suspend ability. Close BT clock. */
> -- 
> 2.34.1

Acked-by: Martin Kaiser <martin@kaiser.cx>
