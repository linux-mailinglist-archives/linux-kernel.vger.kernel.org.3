Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D958E482C5C
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jan 2022 18:28:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230072AbiABR2R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Jan 2022 12:28:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbiABR2Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jan 2022 12:28:16 -0500
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BDA8C061761
        for <linux-kernel@vger.kernel.org>; Sun,  2 Jan 2022 09:28:16 -0800 (PST)
Received: from dslb-188-104-058-096.188.104.pools.vodafone-ip.de ([188.104.58.96] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <postmaster@kaiser.cx>)
        id 1n44eS-0005OQ-2v; Sun, 02 Jan 2022 18:28:12 +0100
Received: from martin by martin-debian-2.paytec.ch with local (Exim 4.94.2)
        (envelope-from <martin@martin-debian-2.paytec.ch>)
        id 1n44eR-000GOd-Ep; Sun, 02 Jan 2022 18:28:11 +0100
Date:   Sun, 2 Jan 2022 18:28:11 +0100
From:   Martin Kaiser <martin@kaiser.cx>
To:     Michael Straube <straube.linux@gmail.com>
Cc:     gregkh@linuxfoundation.org, Larry.Finger@lwfinger.net,
        phil@philpotter.co.uk, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 7/7] staging: r8188eu: FwRsvdPageStartOffset is set
 but never used
Message-ID: <YdHgq1jBjNC6lWDL@martin-debian-1.paytec.ch>
References: <20220101084937.3411-1-straube.linux@gmail.com>
 <20220101084937.3411-8-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220101084937.3411-8-straube.linux@gmail.com>
Sender: "Martin Kaiser,,," <martin@martin-debian-2.paytec.ch>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thus wrote Michael Straube (straube.linux@gmail.com):

> The field FwRsvdPageStartOffset of struct hal_data_8188e is set but
> never used. Remove it.

> Signed-off-by: Michael Straube <straube.linux@gmail.com>
> ---
> v3: no changes
> v2: no changes

>  drivers/staging/r8188eu/hal/rtl8188e_cmd.c     | 3 ---
>  drivers/staging/r8188eu/include/rtl8188e_hal.h | 2 --
>  2 files changed, 5 deletions(-)

> diff --git a/drivers/staging/r8188eu/hal/rtl8188e_cmd.c b/drivers/staging/r8188eu/hal/rtl8188e_cmd.c
> index ca24e17c369d..a491c37777df 100644
> --- a/drivers/staging/r8188eu/hal/rtl8188e_cmd.c
> +++ b/drivers/staging/r8188eu/hal/rtl8188e_cmd.c
> @@ -440,7 +440,6 @@ void CheckFwRsvdPageContent(struct adapter *Adapter)
>  /*  2009.10.15 by tynli. */
>  static void SetFwRsvdPagePkt(struct adapter *adapt, bool bDLFinished)
>  {
> -	struct hal_data_8188e *haldata;
>  	struct xmit_frame	*pmgntframe;
>  	struct pkt_attrib	*pattrib;
>  	struct xmit_priv *pxmitpriv;
> @@ -461,7 +460,6 @@ static void SetFwRsvdPagePkt(struct adapter *adapt, bool bDLFinished)
>  		return;
>  	}

> -	haldata = &adapt->haldata;
>  	pxmitpriv = &adapt->xmitpriv;
>  	pmlmeext = &adapt->mlmeextpriv;
>  	pmlmeinfo = &pmlmeext->mlmext_info;
> @@ -480,7 +478,6 @@ static void SetFwRsvdPagePkt(struct adapter *adapt, bool bDLFinished)
>  	if (PageNeed == 1)
>  		PageNeed += 1;
>  	PageNum += PageNeed;
> -	haldata->FwRsvdPageStartOffset = PageNum;

>  	BufIndex += PageNeed * 128;

> diff --git a/drivers/staging/r8188eu/include/rtl8188e_hal.h b/drivers/staging/r8188eu/include/rtl8188e_hal.h
> index 239d0db55639..25f3c04e81b7 100644
> --- a/drivers/staging/r8188eu/include/rtl8188e_hal.h
> +++ b/drivers/staging/r8188eu/include/rtl8188e_hal.h
> @@ -230,8 +230,6 @@ struct hal_data_8188e {

>  	u8	bDumpRxPkt;/* for debug */
>  	u8	bDumpTxPkt;/* for debug */
> -	u8	FwRsvdPageStartOffset; /* Reserve page start offset except
> -					*  beacon in TxQ. */

>  	u8	OutEpQueueSel;
>  	u8	OutEpNumber;
> -- 
> 2.34.1

Acked-by: Martin Kaiser <martin@kaiser.cx>
