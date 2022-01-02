Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AA30482C53
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jan 2022 18:17:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229955AbiABRRp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Jan 2022 12:17:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229821AbiABRRp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jan 2022 12:17:45 -0500
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF156C061761
        for <linux-kernel@vger.kernel.org>; Sun,  2 Jan 2022 09:17:44 -0800 (PST)
Received: from dslb-188-104-058-096.188.104.pools.vodafone-ip.de ([188.104.58.96] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <postmaster@kaiser.cx>)
        id 1n44UG-0005LM-Ax; Sun, 02 Jan 2022 18:17:40 +0100
Received: from martin by martin-debian-2.paytec.ch with local (Exim 4.94.2)
        (envelope-from <martin@martin-debian-2.paytec.ch>)
        id 1n44UF-000Epa-Nb; Sun, 02 Jan 2022 18:17:39 +0100
Date:   Sun, 2 Jan 2022 18:17:39 +0100
From:   Martin Kaiser <martin@kaiser.cx>
To:     Michael Straube <straube.linux@gmail.com>
Cc:     gregkh@linuxfoundation.org, Larry.Finger@lwfinger.net,
        phil@philpotter.co.uk, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 4/7] staging: r8188eu: bAPKThermalMeterIgnore is set
 but never used
Message-ID: <YdHeM12+1huOMez0@martin-debian-1.paytec.ch>
References: <20220101084937.3411-1-straube.linux@gmail.com>
 <20220101084937.3411-5-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220101084937.3411-5-straube.linux@gmail.com>
Sender: "Martin Kaiser,,," <martin@martin-debian-2.paytec.ch>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thus wrote Michael Straube (straube.linux@gmail.com):

> The field bAPKThermalMeterIgnore of struct hal_data_8188e is set but
> never used. Remove it.

> Signed-off-by: Michael Straube <straube.linux@gmail.com>
> ---
> v3: no changes
> v2: no changes

>  drivers/staging/r8188eu/hal/rtl8188e_hal_init.c | 5 ++---
>  drivers/staging/r8188eu/include/rtl8188e_hal.h  | 1 -
>  2 files changed, 2 insertions(+), 4 deletions(-)

> diff --git a/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c b/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
> index 065c2701077d..cce291ca44b1 100644
> --- a/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
> +++ b/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
> @@ -1230,9 +1230,8 @@ void Hal_ReadThermalMeter_88E(struct adapter *Adapter, u8 *PROMContent, bool Aut
>  	else
>  		pHalData->EEPROMThermalMeter = EEPROM_Default_ThermalMeter_88E;

> -	if (pHalData->EEPROMThermalMeter == 0xff || AutoloadFail) {
> -		pHalData->bAPKThermalMeterIgnore = true;
> +	if (pHalData->EEPROMThermalMeter == 0xff || AutoloadFail)
>  		pHalData->EEPROMThermalMeter = EEPROM_Default_ThermalMeter_88E;
> -	}
> +
>  	DBG_88E("ThermalMeter = 0x%x\n", pHalData->EEPROMThermalMeter);
>  }
> diff --git a/drivers/staging/r8188eu/include/rtl8188e_hal.h b/drivers/staging/r8188eu/include/rtl8188e_hal.h
> index de58c85b8bdc..40b3db34b8f2 100644
> --- a/drivers/staging/r8188eu/include/rtl8188e_hal.h
> +++ b/drivers/staging/r8188eu/include/rtl8188e_hal.h
> @@ -181,7 +181,6 @@ struct hal_data_8188e {
>  	u8	EEPROMRegulatory;

>  	u8	EEPROMThermalMeter;
> -	u8	bAPKThermalMeterIgnore;

>  	bool	EepromOrEfuse;

> -- 
> 2.34.1

Acked-by: Martin Kaiser <martin@kaiser.cx>
