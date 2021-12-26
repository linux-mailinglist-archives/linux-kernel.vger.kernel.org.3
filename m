Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACC6047F8CE
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Dec 2021 21:39:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233618AbhLZUhp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Dec 2021 15:37:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232955AbhLZUhn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Dec 2021 15:37:43 -0500
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CF99C06173E
        for <linux-kernel@vger.kernel.org>; Sun, 26 Dec 2021 12:37:43 -0800 (PST)
Received: from martin by viti.kaiser.cx with local (Exim 4.89)
        (envelope-from <martin@viti.kaiser.cx>)
        id 1n1aGw-0000ca-5d; Sun, 26 Dec 2021 21:37:38 +0100
Date:   Sun, 26 Dec 2021 21:37:38 +0100
From:   Martin Kaiser <martin@kaiser.cx>
To:     Michael Straube <straube.linux@gmail.com>
Cc:     gregkh@linuxfoundation.org, Larry.Finger@lwfinger.net,
        phil@philpotter.co.uk, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: r8188eu: DM_PriCCA is set but never used
Message-ID: <20211226203738.kft33vkqtsx66zzz@viti.kaiser.cx>
References: <20211226162921.10227-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211226162921.10227-1-straube.linux@gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: Martin Kaiser <martin@viti.kaiser.cx>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thus wrote Michael Straube (straube.linux@gmail.com):

> The field DM_PriCCA of struct odm_dm_struct is set but never used.
> Remove it and remove related dead code.

> Signed-off-by: Michael Straube <straube.linux@gmail.com>
> ---
>  drivers/staging/r8188eu/hal/odm.c              |  1 -
>  drivers/staging/r8188eu/hal/odm_RTL8188E.c     | 15 ---------------
>  drivers/staging/r8188eu/include/odm.h          |  9 ---------
>  drivers/staging/r8188eu/include/odm_RTL8188E.h |  2 --
>  4 files changed, 27 deletions(-)

> diff --git a/drivers/staging/r8188eu/hal/odm.c b/drivers/staging/r8188eu/hal/odm.c
> index 7a42687b3128..a820bdc26fbc 100644
> --- a/drivers/staging/r8188eu/hal/odm.c
> +++ b/drivers/staging/r8188eu/hal/odm.c
> @@ -152,7 +152,6 @@ void ODM_DMInit(struct odm_dm_struct *pDM_Odm)
>  	odm_DIGInit(pDM_Odm);
>  	odm_RateAdaptiveMaskInit(pDM_Odm);

> -	odm_PrimaryCCA_Init(pDM_Odm);    /*  Gary */
>  	odm_DynamicBBPowerSavingInit(pDM_Odm);
>  	odm_TXPowerTrackingInit(pDM_Odm);
>  	ODM_EdcaTurboInit(pDM_Odm);
> diff --git a/drivers/staging/r8188eu/hal/odm_RTL8188E.c b/drivers/staging/r8188eu/hal/odm_RTL8188E.c
> index 8af45c7535ea..34530fcd00d8 100644
> --- a/drivers/staging/r8188eu/hal/odm_RTL8188E.c
> +++ b/drivers/staging/r8188eu/hal/odm_RTL8188E.c
> @@ -260,18 +260,3 @@ void ODM_AntennaDiversity_88E(struct odm_dm_struct *dm_odm)
>  	if ((dm_odm->AntDivType == CG_TRX_HW_ANTDIV) || (dm_odm->AntDivType == CGCS_RX_HW_ANTDIV))
>  		odm_HWAntDiv(dm_odm);
>  }
> -
> -/* 3============================================================ */
> -/* 3 Dynamic Primary CCA */
> -/* 3============================================================ */
> -
> -void odm_PrimaryCCA_Init(struct odm_dm_struct *dm_odm)
> -{
> -	struct dyn_primary_cca *PrimaryCCA = &dm_odm->DM_PriCCA;
> -
> -	PrimaryCCA->dup_rts_flag = 0;
> -	PrimaryCCA->intf_flag = 0;
> -	PrimaryCCA->intf_type = 0;
> -	PrimaryCCA->monitor_flag = 0;
> -	PrimaryCCA->pri_cca_flag = 0;
> -}
> diff --git a/drivers/staging/r8188eu/include/odm.h b/drivers/staging/r8188eu/include/odm.h
> index 19e859b989ad..306640e92e6f 100644
> --- a/drivers/staging/r8188eu/include/odm.h
> +++ b/drivers/staging/r8188eu/include/odm.h
> @@ -81,14 +81,6 @@ struct false_alarm_stats {
>  	u32	Cnt_BW_LSC;	/* Gary */
>  };

> -struct dyn_primary_cca {
> -	u8		pri_cca_flag;
> -	u8		intf_flag;
> -	u8		intf_type;
> -	u8		dup_rts_flag;
> -	u8		monitor_flag;
> -};
> -
>  struct rx_hpc {
>  	u8		RXHP_flag;
>  	u8		PSD_func_trigger;
> @@ -487,7 +479,6 @@ struct odm_dm_struct {
>  	struct fast_ant_train DM_FatTable;
>  	struct rtw_dig	DM_DigTable;
>  	struct rtl_ps	DM_PSTable;
> -	struct dyn_primary_cca DM_PriCCA;
>  	struct false_alarm_stats FalseAlmCnt;
>  	struct sw_ant_switch DM_SWAT_Table;
>  	bool		RSSI_test;
> diff --git a/drivers/staging/r8188eu/include/odm_RTL8188E.h b/drivers/staging/r8188eu/include/odm_RTL8188E.h
> index 96e50c9224aa..85a0d7ec7378 100644
> --- a/drivers/staging/r8188eu/include/odm_RTL8188E.h
> +++ b/drivers/staging/r8188eu/include/odm_RTL8188E.h
> @@ -29,6 +29,4 @@ void odm_FastAntTrainingCallback(struct odm_dm_struct *pDM_Odm);

>  void odm_FastAntTrainingWorkItemCallback(struct odm_dm_struct *pDM_Odm);

> -void odm_PrimaryCCA_Init(struct odm_dm_struct *pDM_Odm);
> -
>  #endif
> -- 
> 2.34.1

looks good to me

Acked-by: Martin Kaiser <martin@kaiser.cx>
