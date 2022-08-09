Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D710558DBCF
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 18:22:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244983AbiHIQWo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 12:22:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242472AbiHIQWi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 12:22:38 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 49FD32AF8
        for <linux-kernel@vger.kernel.org>; Tue,  9 Aug 2022 09:22:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1660062153;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7dAi7GKOMZX5s+a+ucbkNdP4kEaqhkcEf7NNZjOjw1U=;
        b=LKu9Yc6GaRZ/RuthjEsIfUamnjqhfHypCrisyIWlSI5DT29mNZtxdXstP9z7d0WQFCjrrZ
        qT8cZb6SkT3if5eh1inNDtA0tloUDzyWC4LlJ4HHCbzsG+BCIaakZfud+bTmKKwINmmNdN
        CjfWrIV2ARK+IO9Krh4sGH6mhWz0LUQ=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-616-8OrCvCuLMhiAU7fI_K7z_g-1; Tue, 09 Aug 2022 12:22:30 -0400
X-MC-Unique: 8OrCvCuLMhiAU7fI_K7z_g-1
Received: by mail-ej1-f72.google.com with SMTP id s4-20020a170906500400b006feaccb3a0eso3621171ejj.11
        for <linux-kernel@vger.kernel.org>; Tue, 09 Aug 2022 09:22:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=7dAi7GKOMZX5s+a+ucbkNdP4kEaqhkcEf7NNZjOjw1U=;
        b=A8SbnM0MPljtBe4EKP9JJXMqu8OmBnnta9a7+l/yHmOSSeL66grOdnFqfrIYibd0K3
         uhLBlsdXjbefJFlk9kYzCwbNouzZtLLJGRjKVyYoNGU4PYn6NhBFfM3W3dxznvZyuaIm
         FkCjjcHNwrVR8Pap6h/jie6smblWu62+7seRu4wJT7S2Y2D76+r1Ej9MWA3nmnuoI6kM
         o+y6W53s4LOgds8ezs8vmu35JObkXII8Tsj2E3M/1BM8plL0D3992XjTaFYlspYNcXtJ
         Jb/Dt40NHvXqNmAV9lNQIpdaaYHsFpuUoPsuPJVxd+v6j7jrOFK8aYT/1FIzUKl0sss0
         l0oA==
X-Gm-Message-State: ACgBeo2pVJiNmcv8GaqB4P0xavZx7N7MLOWadNI8R10GZPzDRzgkkOnk
        vwXOENYXOj8Wal/0kql9KcWT6tB8GPU64oXdMrA2AR/yCyDlXgQYTy5EjMmRuyhtgJbLUSyjiOO
        AkjvtCPYQMA1yQ/5jRpkbNhzC
X-Received: by 2002:a05:6402:254b:b0:43e:7c6a:f431 with SMTP id l11-20020a056402254b00b0043e7c6af431mr22927459edb.305.1660062148099;
        Tue, 09 Aug 2022 09:22:28 -0700 (PDT)
X-Google-Smtp-Source: AA6agR4tXILrb7624nGHmtq/sG6oghY7zeyZlROOtFEWrwG/+UCqT4Hc4KrBdcNA3U9p70G6mTzF5Q==
X-Received: by 2002:a05:6402:254b:b0:43e:7c6a:f431 with SMTP id l11-20020a056402254b00b0043e7c6af431mr22927409edb.305.1660062146981;
        Tue, 09 Aug 2022 09:22:26 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c1e:bf00:d69d:5353:dba5:ee81? (2001-1c00-0c1e-bf00-d69d-5353-dba5-ee81.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:d69d:5353:dba5:ee81])
        by smtp.gmail.com with ESMTPSA id es25-20020a056402381900b0043a61f6c389sm6204476edb.4.2022.08.09.09.22.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Aug 2022 09:22:26 -0700 (PDT)
Message-ID: <573fc72b-a3d3-cff3-f2c1-9c79d5517df2@redhat.com>
Date:   Tue, 9 Aug 2022 18:22:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH] Fixes compilation errors after checkpatch warnings
Content-Language: en-US
To:     Simone Serra <serrazimone@gmail.com>, gregkh@linuxfoundation.org,
        fabioaiuto83@gmail.com, soumya.negi97@gmail.com,
        straube.linux@gmail.com
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20220809143743.742636-1-serrazimone@gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20220809143743.742636-1-serrazimone@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 8/9/22 16:37, Simone Serra wrote:
> This patch fixes compilation errors produced by the previous commit that resolved a number of checkpatch warnings and errors

So you are saying that the previous patch was not even compile tested ??

That is *very very* bad!


> 
> Signed-off-by: Simone Serra <serrazimone@gmail.com>
> ---
>  drivers/staging/rtl8723bs/core/rtw_ap.c       | 458 +++++++++---------

That is a huge amount of changes for just a compilation fix.

>  drivers/staging/rtl8723bs/core/rtw_cmd.c      |  16 +-
>  drivers/staging/rtl8723bs/core/rtw_efuse.c    | 197 ++++----

Idem.

>  .../staging/rtl8723bs/core/rtw_ioctl_set.c    |   8 +-
>  drivers/staging/rtl8723bs/core/rtw_mlme.c     |  28 +-
>  drivers/staging/rtl8723bs/core/rtw_mlme_ext.c |  44 +-
>  drivers/staging/rtl8723bs/core/rtw_pwrctrl.c  |   2 +-
>  drivers/staging/rtl8723bs/core/rtw_recv.c     |   4 +-
>  drivers/staging/rtl8723bs/core/rtw_security.c |  16 +-
>  .../staging/rtl8723bs/core/rtw_wlan_util.c    |  22 +-
>  drivers/staging/rtl8723bs/core/rtw_xmit.c     |  18 +-
>  drivers/staging/rtl8723bs/hal/hal_btcoex.c    |   2 +-
>  drivers/staging/rtl8723bs/hal/hal_com.c       |   2 +-
>  drivers/staging/rtl8723bs/hal/hal_intf.c      |   2 +-
>  drivers/staging/rtl8723bs/hal/rtl8723b_dm.c   |   2 +-
>  .../staging/rtl8723bs/hal/rtl8723b_hal_init.c |   4 +-
>  drivers/staging/rtl8723bs/include/rtw_ap.h    |   2 +-
>  .../staging/rtl8723bs/include/rtw_btcoex.h    |   2 +-
>  drivers/staging/rtl8723bs/include/rtw_mlme.h  |   2 +-
>  .../staging/rtl8723bs/include/rtw_mlme_ext.h  |  14 +-
>  .../staging/rtl8723bs/include/rtw_security.h  |  16 +-
>  drivers/staging/rtl8723bs/include/rtw_xmit.h  |   2 +-
>  drivers/staging/rtl8723bs/include/sta_info.h  |   4 +-
>  .../staging/rtl8723bs/include/wlan_bssdef.h   |  12 +-
>  .../staging/rtl8723bs/os_dep/ioctl_cfg80211.c | 108 ++---
>  .../staging/rtl8723bs/os_dep/ioctl_linux.c    |  84 ++--
>  drivers/staging/rtl8723bs/os_dep/mlme_linux.c |  16 +-
>  drivers/staging/rtl8723bs/os_dep/os_intfs.c   |  10 +-
>  28 files changed, 537 insertions(+), 560 deletions(-)

So you need to change over 500 lines just to fix compilation
changes?

Regards,

Hans


> 
> diff --git a/drivers/staging/rtl8723bs/core/rtw_ap.c b/drivers/staging/rtl8723bs/core/rtw_ap.c
> index d30d6e6bcd07..29dcd1f2f377 100644
> --- a/drivers/staging/rtl8723bs/core/rtw_ap.c
> +++ b/drivers/staging/rtl8723bs/core/rtw_ap.c
> @@ -259,9 +259,9 @@ void expire_timeout_chk(struct adapter *padapter)
>  		} else {
>  			/* TODO: Aging mechanism to digest frames in sleep_q to */
>  			/* avoid running out of xmitframe */
> -			if (psta->sleepq_len > (NR_XMITFRAME / pstapriv->asoc_list_cnt)
> -				&& padapter->xmitpriv.free_xmitframe_cnt < ((
> -					NR_XMITFRAME / pstapriv->asoc_list_cnt
> +			if (psta->sleepq_len > (NR_XMITFRAME / pstapriv->asoc_list_cnt) &&
> +			    padapter->xmitpriv.free_xmitframe_cnt <
> +						 ((NR_XMITFRAME / pstapriv->asoc_list_cnt
>  				) / 2)
>  			)
>  				wakeup_sta_to_xmit(padapter, psta);
> @@ -277,7 +277,7 @@ void expire_timeout_chk(struct adapter *padapter)
>  		/* switch to correct channel of current network  before issue keep-alive frames */
>  		if (rtw_get_oper_ch(padapter) != pmlmeext->cur_channel) {
>  			backup_oper_channel = rtw_get_oper_ch(padapter);
> -			SelectChannel(padapter, pmlmeext->cur_channel);
> +			select_channel(padapter, pmlmeext->cur_channel);
>  		}
>  
>  		/* issue null data to check sta alive*/
> @@ -315,17 +315,17 @@ void expire_timeout_chk(struct adapter *padapter)
>  		}
>  
>  		if (backup_oper_channel > 0) /* back to the original operation channel */
> -			SelectChannel(padapter, backup_oper_channel);
> +			select_channel(padapter, backup_oper_channel);
>  	}
>  
>  	associated_clients_update(padapter, updated);
>  }
>  
> -void add_RATid(struct adapter *padapter, struct sta_info *psta, u8 rssi_level)
> +void add_rat_id(struct adapter *padapter, struct sta_info *psta, u8 rssi_level)
>  {
> -	unsigned char sta_band = 0, shortGIrate = false;
> +	unsigned char sta_band = 0, short_gi_rate = false;
>  	unsigned int tx_ra_bitmap = 0;
> -	struct mlme_priv *pmlmepriv = &(padapter->mlmepriv);
> +	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
>  	struct wlan_bssid_ex
>  		*pcur_network = (struct wlan_bssid_ex *)&pmlmepriv->cur_network.network;
>  
> @@ -338,7 +338,7 @@ void add_RATid(struct adapter *padapter, struct sta_info *psta, u8 rssi_level)
>  	rtw_hal_update_sta_rate_mask(padapter, psta);
>  	tx_ra_bitmap = psta->ra_mask;
>  
> -	shortGIrate = query_ra_short_GI(psta);
> +	short_gi_rate = query_ra_short_GI(psta);
>  
>  	if (pcur_network->configuration.ds_config > 14) {
>  		sta_band |= WIRELESS_INVALID;
> @@ -361,7 +361,7 @@ void add_RATid(struct adapter *padapter, struct sta_info *psta, u8 rssi_level)
>  
>  		arg[0] = psta->mac_id;
>  		arg[1] = psta->raid;
> -		arg[2] = shortGIrate;
> +		arg[2] = short_gi_rate;
>  		arg[3] = psta->init_rate;
>  
>  		rtw_hal_add_ra_tid(padapter, tx_ra_bitmap, arg, rssi_level);
> @@ -371,11 +371,11 @@ void add_RATid(struct adapter *padapter, struct sta_info *psta, u8 rssi_level)
>  void update_bmc_sta(struct adapter *padapter)
>  {
>  	unsigned char network_type;
> -	int supportRateNum = 0;
> +	int support_rate_num = 0;
>  	unsigned int tx_ra_bitmap = 0;
> -	struct mlme_priv *pmlmepriv = &(padapter->mlmepriv);
> -	struct mlme_ext_priv *pmlmeext = &(padapter->mlmeextpriv);
> -	struct mlme_ext_info *pmlmeinfo = &(pmlmeext->mlmext_info);
> +	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
> +	struct mlme_ext_priv *pmlmeext = &padapter->mlmeextpriv;
> +	struct mlme_ext_info *pmlmeinfo = &pmlmeext->mlmext_info;
>  	struct wlan_bssid_ex
>  		*pcur_network = (struct wlan_bssid_ex *)&pmlmepriv->cur_network.network;
>  	struct sta_info *psta = rtw_get_bcmc_stainfo(padapter);
> @@ -394,12 +394,10 @@ void update_bmc_sta(struct adapter *padapter)
>  
>  		memset((void *)&psta->sta_stats, 0, sizeof(struct stainfo_stats));
>  
> -		/* psta->dot118021XPrivacy = _NO_PRIVACY_;//!!! remove it, because it has been set before this. */
> -
>  		/* prepare for add_RATid */
> -		supportRateNum = rtw_get_rateset_len((u8 *)&pcur_network->supported_rates);
> +		support_rate_num = rtw_get_rateset_len((u8 *)&pcur_network->supported_rates);
>  		network_type = rtw_check_network_type((u8 *)&pcur_network->supported_rates,
> -						      supportRateNum,
> +						      support_rate_num,
>  						      pcur_network->configuration.ds_config
>  		);
>  		if (is_supported_tx_cck(network_type)) {
> @@ -439,7 +437,6 @@ void update_bmc_sta(struct adapter *padapter)
>  		spin_lock_bh(&psta->lock);
>  		psta->state = _FW_LINKED;
>  		spin_unlock_bh(&psta->lock);
> -
>  	}
>  }
>  
> @@ -452,9 +449,9 @@ void update_bmc_sta(struct adapter *padapter)
>  
>  void update_sta_info_apmode(struct adapter *padapter, struct sta_info *psta)
>  {
> -	struct mlme_priv *pmlmepriv = &(padapter->mlmepriv);
> +	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
>  	struct security_priv *psecuritypriv = &padapter->securitypriv;
> -	struct mlme_ext_priv *pmlmeext = &(padapter->mlmeextpriv);
> +	struct mlme_ext_priv *pmlmeext = &padapter->mlmeextpriv;
>  	struct ht_priv *phtpriv_ap = &pmlmepriv->htpriv;
>  	struct ht_priv *phtpriv_sta = &psta->htpriv;
>  	u8 cur_ldpc_cap = 0, cur_stbc_cap = 0, cur_beamform_cap = 0;
> @@ -468,7 +465,7 @@ void update_sta_info_apmode(struct adapter *padapter, struct sta_info *psta)
>  	/* ap mode */
>  	rtw_hal_set_odm_var(padapter, HAL_ODM_STA_INFO, psta, true);
>  
> -	if (psecuritypriv->dot11AuthAlgrthm == dot11AuthAlgrthm_8021X)
> +	if (psecuritypriv->dot11_auth_algrthm == dot11_auth_algrthm_8021X)
>  		psta->ieee8021x_blocked = true;
>  	else
>  		psta->ieee8021x_blocked = false;
> @@ -483,13 +480,12 @@ void update_sta_info_apmode(struct adapter *padapter, struct sta_info *psta)
>  		/* check if sta supports rx ampdu */
>  		phtpriv_sta->ampdu_enable = phtpriv_ap->ampdu_enable;
>  
> -		phtpriv_sta->rx_ampdu_min_spacing = (
> -			phtpriv_sta->ht_cap.ampdu_params_info & IEEE80211_HT_CAP_AMPDU_DENSITY
> +		phtpriv_sta->rx_ampdu_min_spacing =
> +		(phtpriv_sta->ht_cap.ampdu_params_info & IEEE80211_HT_CAP_AMPDU_DENSITY
>  		) >> 2;
>  
>  		/*  bwmode */
> -		if ((
> -			phtpriv_sta->ht_cap.cap_info & phtpriv_ap->ht_cap.cap_info
> +		if ((phtpriv_sta->ht_cap.cap_info & phtpriv_ap->ht_cap.cap_info
>  		) & cpu_to_le16(IEEE80211_HT_CAP_SUP_WIDTH))
>  			psta->bw_mode = CHANNEL_WIDTH_40;
>  		else
> @@ -501,14 +497,12 @@ void update_sta_info_apmode(struct adapter *padapter, struct sta_info *psta)
>  		phtpriv_sta->ch_offset = pmlmeext->cur_ch_offset;
>  
>  		/* check if sta support s Short GI 20M */
> -		if ((
> -			phtpriv_sta->ht_cap.cap_info & phtpriv_ap->ht_cap.cap_info
> +		if ((phtpriv_sta->ht_cap.cap_info & phtpriv_ap->ht_cap.cap_info
>  		) & cpu_to_le16(IEEE80211_HT_CAP_SGI_20))
>  			phtpriv_sta->sgi_20m = true;
>  
>  		/* check if sta support s Short GI 40M */
> -		if ((
> -			phtpriv_sta->ht_cap.cap_info & phtpriv_ap->ht_cap.cap_info
> +		if ((phtpriv_sta->ht_cap.cap_info & phtpriv_ap->ht_cap.cap_info
>  		) & cpu_to_le16(IEEE80211_HT_CAP_SGI_40)) {
>  			if (psta->bw_mode == CHANNEL_WIDTH_40) /* according to psta->bw_mode */
>  				phtpriv_sta->sgi_40m = true;
> @@ -564,10 +558,10 @@ void update_sta_info_apmode(struct adapter *padapter, struct sta_info *psta)
>  
>  static void update_ap_info(struct adapter *padapter, struct sta_info *psta)
>  {
> -	struct mlme_priv *pmlmepriv = &(padapter->mlmepriv);
> +	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
>  	struct wlan_bssid_ex
>  		*pnetwork = (struct wlan_bssid_ex *)&pmlmepriv->cur_network.network;
> -	struct mlme_ext_priv *pmlmeext = &(padapter->mlmeextpriv);
> +	struct mlme_ext_priv *pmlmeext = &padapter->mlmeextpriv;
>  	struct ht_priv *phtpriv_ap = &pmlmepriv->htpriv;
>  
>  	psta->wireless_mode = pmlmeext->cur_wireless_mode;
> @@ -610,7 +604,7 @@ static void update_hw_ht_param(struct adapter *padapter)
>  	unsigned char max_AMPDU_len;
>  	unsigned char min_MPDU_spacing;
>  	struct mlme_ext_priv *pmlmeext = &padapter->mlmeextpriv;
> -	struct mlme_ext_info *pmlmeinfo = &(pmlmeext->mlmext_info);
> +	struct mlme_ext_info *pmlmeinfo = &pmlmeext->mlmext_info;
>  
>  	/* handle A-MPDU parameter field
>  	 *
> @@ -628,8 +622,8 @@ static void update_hw_ht_param(struct adapter *padapter)
>  	/*  */
>  	/*  Config SM Power Save setting */
>  	/*  */
> -	pmlmeinfo->SM_PS = (le16_to_cpu(
> -		pmlmeinfo->HT_caps.u.HT_cap_element.HT_caps_info
> +	pmlmeinfo->SM_PS = (le16_to_cpu
> +		(pmlmeinfo->HT_caps.u.HT_cap_element.HT_caps_info
>  	) & 0x0C) >> 2;
>  
>  	/*  */
> @@ -646,13 +640,13 @@ void start_bss_network(struct adapter *padapter)
>  	u32 acparm;
>  	int	ie_len;
>  	struct registry_priv  *pregpriv = &padapter->registrypriv;
> -	struct mlme_priv *pmlmepriv = &(padapter->mlmepriv);
> -	struct security_priv *psecuritypriv = &(padapter->securitypriv);
> +	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
> +	struct security_priv *psecuritypriv = &padapter->securitypriv;
>  	struct wlan_bssid_ex
>  		*pnetwork = (struct wlan_bssid_ex *)&pmlmepriv->cur_network.network;
> -	struct mlme_ext_priv *pmlmeext = &(padapter->mlmeextpriv);
> -	struct mlme_ext_info *pmlmeinfo = &(pmlmeext->mlmext_info);
> -	struct wlan_bssid_ex *pnetwork_mlmeext = &(pmlmeinfo->network);
> +	struct mlme_ext_priv *pmlmeext = &padapter->mlmeextpriv;
> +	struct mlme_ext_info *pmlmeinfo = &pmlmeext->mlmext_info;
> +	struct wlan_bssid_ex *pnetwork_mlmeext = &pmlmeinfo->network;
>  	struct HT_info_element *pht_info = NULL;
>  	u8 cbw40_enable = 0;
>  
> @@ -662,7 +656,8 @@ void start_bss_network(struct adapter *padapter)
>  	cur_ch_offset = HAL_PRIME_CHNL_OFFSET_DONT_CARE;
>  
>  	/* check if there is wps ie, */
> -	/* if there is wpsie in beacon, the hostapd will update beacon twice when stating hostapd, */
> +	/* if there is wpsie in beacon, the hostapd will update beacon twice when stating */
> +	/* hostapd, */
>  	/* and at first time the security ie (RSN/WPA IE) will not include in beacon. */
>  	if (!rtw_get_wps_ie(pnetwork->ies + _FIXED_IE_LENGTH_,
>  			    pnetwork->ie_length - _FIXED_IE_LENGTH_, NULL, NULL))
> @@ -685,13 +680,13 @@ void start_bss_network(struct adapter *padapter)
>  	if (!pmlmepriv->cur_network.join_res) { /* setting only at  first time */
>  
>  		/* WEP Key will be set before this function, do not clear CAM. */
> -		if ((psecuritypriv->dot11PrivacyAlgrthm != _WEP40_) &&
> -		    (psecuritypriv->dot11PrivacyAlgrthm != _WEP104_))
> +		if ((psecuritypriv->dot11_privacy_algrthm != _WEP40_) &&
> +		    (psecuritypriv->dot11_privacy_algrthm != _WEP104_))
>  			flush_all_cam_entry(padapter);	/* clear CAM */
>  	}
>  
>  	/* set MSR to AP_Mode */
> -	Set_MSR(padapter, _HW_STATE_AP_);
> +	set_msr(padapter, _HW_STATE_AP_);
>  
>  	/* Set BSSID REG */
>  	rtw_hal_set_hwreg(padapter, HW_VAR_BSSID, pnetwork->mac_address);
> @@ -708,8 +703,7 @@ void start_bss_network(struct adapter *padapter)
>  	rtw_hal_set_hwreg(padapter, HW_VAR_AC_PARAM_BK, (u8 *)(&acparm));
>  
>  	/* Set Security */
> -	val8 = (
> -		psecuritypriv->dot11AuthAlgrthm == dot11AuthAlgrthm_8021X
> +	val8 = (psecuritypriv->dot11_auth_algrthm == dot11_auth_algrthm_8021X
>  	) ? 0xcc : 0xcf;
>  	rtw_hal_set_hwreg(padapter, HW_VAR_SEC_CFG, (u8 *)(&val8));
>  
> @@ -728,7 +722,7 @@ void start_bss_network(struct adapter *padapter)
>  		/* Switch_DM_Func(padapter, DYNAMIC_FUNC_DISABLE, false); */
>  
>  		/* turn on all dynamic functions */
> -		Switch_DM_Func(padapter, DYNAMIC_ALL_FUNC_ENABLE, true);
> +		switch_DM_func(padapter, DYNAMIC_ALL_FUNC_ENABLE, true);
>  
>  		/* rtw_hal_set_hwreg(padapter, HW_VAR_INITIAL_GAIN, (u8 *)(&initialgain)); */
>  	}
> @@ -786,13 +780,12 @@ void start_bss_network(struct adapter *padapter)
>  	update_wireless_mode(padapter);
>  
>  	/* update RRSR after set channel and bandwidth */
> -	UpdateBrateTbl(padapter, pnetwork->supported_rates);
> +	update_brate_tbl(padapter, pnetwork->supported_rates);
>  	rtw_hal_set_hwreg(padapter, HW_VAR_BASIC_RATE, pnetwork->supported_rates);
>  
>  	/* update capability after cur_wireless_mode updated */
> -	update_capinfo(
> -		padapter,
> -		rtw_get_capability((struct wlan_bssid_ex *)pnetwork)
> +	update_capinfo(padapter,
> +		       rtw_get_capability((struct wlan_bssid_ex *)pnetwork)
>  	);
>  
>  	if (pmlmeext->bstart_bss) {
> @@ -812,19 +805,19 @@ int rtw_check_beacon_data(struct adapter *padapter, u8 *pbuf,  int len)
>  {
>  	int ret = _SUCCESS;
>  	u8 *p;
> -	u8 *pHT_caps_ie = NULL;
> -	u8 *pHT_info_ie = NULL;
> +	u8 *pht_caps_ie = NULL;
> +	u8 *pht_info_ie = NULL;
>  	struct sta_info *psta = NULL;
>  	u16 cap, ht_cap = false;
>  	uint ie_len = 0;
>  	int group_cipher, pairwise_cipher;
> -	u8 channel, network_type, supportRate[NDIS_802_11_LENGTH_RATES_EX];
> -	int supportRateNum = 0;
> +	u8 channel, network_type, support_rate[NDIS_802_11_LENGTH_RATES_EX];
> +	int support_rate_num = 0;
>  	u8 OUI1[] = {0x00, 0x50, 0xf2, 0x01};
>  	u8 WMM_PARA_IE[] = {0x00, 0x50, 0xf2, 0x02, 0x01, 0x01};
>  	struct registry_priv *pregistrypriv = &padapter->registrypriv;
>  	struct security_priv *psecuritypriv = &padapter->securitypriv;
> -	struct mlme_priv *pmlmepriv = &(padapter->mlmepriv);
> +	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
>  	struct wlan_bssid_ex
>  		*pbss_network = (struct wlan_bssid_ex *)&pmlmepriv->cur_network.network;
>  	u8 *ie = pbss_network->ies;
> @@ -841,15 +834,16 @@ int rtw_check_beacon_data(struct adapter *padapter, u8 *pbuf,  int len)
>  
>  	memcpy(ie, pbuf, pbss_network->ie_length);
>  
> -	if (pbss_network->infrastructure_mode != Ndis802_11APMode)
> +	if (pbss_network->infrastructure_mode != ndis802_11_ap_mode)
>  		return _FAIL;
>  
>  	pbss_network->rssi = 0;
>  
> -	memcpy(pbss_network->mac_address, myid(&(padapter->eeprompriv)), ETH_ALEN);
> +	memcpy(pbss_network->mac_address, myid(&padapter->eeprompriv), ETH_ALEN);
>  
>  	/* beacon interval */
> -	p = rtw_get_beacon_interval_from_ie(ie);/* ie + 8;	8: TimeStamp, 2: Beacon Interval 2:Capability */
> +	p = rtw_get_beacon_interval_from_ie(ie);/* ie + 8;	8: TimeStamp, */
> +	/* 2: Beacon Interval 2:Capability */
>  	/* pbss_network->configuration.beacon_period = le16_to_cpu(*(unsigned short*)p); */
>  	pbss_network->configuration.beacon_period = get_unaligned_le16(p);
>  
> @@ -859,11 +853,10 @@ int rtw_check_beacon_data(struct adapter *padapter, u8 *pbuf,  int len)
>  	cap = get_unaligned_le16(ie);
>  
>  	/* SSID */
> -	p = rtw_get_ie(
> -		ie + _BEACON_IE_OFFSET_,
> -		WLAN_EID_SSID,
> -		&ie_len,
> -		(pbss_network->ie_length - _BEACON_IE_OFFSET_)
> +	p = rtw_get_ie(ie + _BEACON_IE_OFFSET_,
> +		       WLAN_EID_SSID,
> +		       &ie_len,
> +		       (pbss_network->ie_length - _BEACON_IE_OFFSET_)
>  	);
>  	if (p && ie_len > 0) {
>  		memset(&pbss_network->ssid, 0, sizeof(struct ndis_802_11_ssid));
> @@ -874,51 +867,47 @@ int rtw_check_beacon_data(struct adapter *padapter, u8 *pbuf,  int len)
>  	/* channel */
>  	channel = 0;
>  	pbss_network->configuration.length = 0;
> -	p = rtw_get_ie(
> -		ie + _BEACON_IE_OFFSET_,
> -		WLAN_EID_DS_PARAMS, &ie_len,
> -		(pbss_network->ie_length - _BEACON_IE_OFFSET_)
> +	p = rtw_get_ie(ie + _BEACON_IE_OFFSET_,
> +		       WLAN_EID_DS_PARAMS, &ie_len,
> +		       (pbss_network->ie_length - _BEACON_IE_OFFSET_)
>  	);
>  	if (p && ie_len > 0)
>  		channel = *(p + 2);
>  
>  	pbss_network->configuration.ds_config = channel;
>  
> -	memset(supportRate, 0, NDIS_802_11_LENGTH_RATES_EX);
> +	memset(support_rate, 0, NDIS_802_11_LENGTH_RATES_EX);
>  	/*  get supported rates */
> -	p = rtw_get_ie(
> -		ie + _BEACON_IE_OFFSET_,
> -		WLAN_EID_SUPP_RATES,
> -		&ie_len,
> -		(pbss_network->ie_length - _BEACON_IE_OFFSET_)
> +	p = rtw_get_ie(ie + _BEACON_IE_OFFSET_,
> +		       WLAN_EID_SUPP_RATES,
> +		       &ie_len,
> +		       (pbss_network->ie_length - _BEACON_IE_OFFSET_)
>  	);
>  	if (p) {
> -		memcpy(supportRate, p + 2, ie_len);
> -		supportRateNum = ie_len;
> +		memcpy(support_rate, p + 2, ie_len);
> +		support_rate_num = ie_len;
>  	}
>  
>  	/* get ext_supported rates */
> -	p = rtw_get_ie(
> -		ie + _BEACON_IE_OFFSET_,
> -		WLAN_EID_EXT_SUPP_RATES,
> -		&ie_len,
> -		pbss_network->ie_length - _BEACON_IE_OFFSET_
> +	p = rtw_get_ie(ie + _BEACON_IE_OFFSET_,
> +		       WLAN_EID_EXT_SUPP_RATES,
> +		       &ie_len,
> +		       pbss_network->ie_length - _BEACON_IE_OFFSET_
>  	);
>  	if (p) {
> -		memcpy(supportRate + supportRateNum, p + 2, ie_len);
> -		supportRateNum += ie_len;
> +		memcpy(support_rate + support_rate_num, p + 2, ie_len);
> +		support_rate_num += ie_len;
>  	}
>  
> -	network_type = rtw_check_network_type(supportRate, supportRateNum, channel);
> +	network_type = rtw_check_network_type(support_rate, support_rate_num, channel);
>  
>  	rtw_set_supported_rate(pbss_network->supported_rates, network_type);
>  
>  	/* parsing ERP_IE */
> -	p = rtw_get_ie(
> -		ie + _BEACON_IE_OFFSET_,
> -		WLAN_EID_ERP_INFO,
> -		&ie_len,
> -		(pbss_network->ie_length - _BEACON_IE_OFFSET_)
> +	p = rtw_get_ie(ie + _BEACON_IE_OFFSET_,
> +		       WLAN_EID_ERP_INFO,
> +		       &ie_len,
> +		       (pbss_network->ie_length - _BEACON_IE_OFFSET_)
>  	);
>  	if (p && ie_len > 0)
>  		ERP_IE_handler(padapter, (struct ndis_80211_var_ie *)p);
> @@ -935,21 +924,20 @@ int rtw_check_beacon_data(struct adapter *padapter, u8 *pbuf,  int len)
>  	group_cipher = 0; pairwise_cipher = 0;
>  	psecuritypriv->wpa2_group_cipher = _NO_PRIVACY_;
>  	psecuritypriv->wpa2_pairwise_cipher = _NO_PRIVACY_;
> -	p = rtw_get_ie(
> -		ie + _BEACON_IE_OFFSET_,
> -		WLAN_EID_RSN,
> -		&ie_len,
> -		(pbss_network->ie_length - _BEACON_IE_OFFSET_)
> +	p = rtw_get_ie(ie + _BEACON_IE_OFFSET_,
> +		       WLAN_EID_RSN,
> +		       &ie_len,
> +		       (pbss_network->ie_length - _BEACON_IE_OFFSET_)
>  	);
>  	if (p && ie_len > 0) {
> -		if (rtw_parse_wpa2_ie(
> -			p,
> +		if (rtw_parse_wpa2_ie
> +			(p,
>  			ie_len + 2,
>  			&group_cipher,
>  			&pairwise_cipher,
>  			NULL
>  		) == _SUCCESS) {
> -			psecuritypriv->dot11AuthAlgrthm = dot11AuthAlgrthm_8021X;
> +			psecuritypriv->dot11_auth_algrthm = dot11_auth_algrthm_8021X;
>  
>  			psecuritypriv->dot8021xalg = 1;/* psk,  todo:802.1x */
>  			psecuritypriv->wpa_psk |= BIT(1);
> @@ -965,21 +953,20 @@ int rtw_check_beacon_data(struct adapter *padapter, u8 *pbuf,  int len)
>  	psecuritypriv->wpa_group_cipher = _NO_PRIVACY_;
>  	psecuritypriv->wpa_pairwise_cipher = _NO_PRIVACY_;
>  	for (p = ie + _BEACON_IE_OFFSET_; ; p += (ie_len + 2)) {
> -		p = rtw_get_ie(
> -			p,
> -			WLAN_EID_VENDOR_SPECIFIC,
> -			&ie_len,
> -			(pbss_network->ie_length - _BEACON_IE_OFFSET_ - (ie_len + 2))
> +		p = rtw_get_ie(p,
> +			       WLAN_EID_VENDOR_SPECIFIC,
> +			       &ie_len,
> +			       (pbss_network->ie_length - _BEACON_IE_OFFSET_ - (ie_len + 2))
>  		);
>  		if ((p) && (!memcmp(p + 2, OUI1, 4))) {
> -			if (rtw_parse_wpa_ie(
> -				p,
> +			if (rtw_parse_wpa_ie
> +				(p,
>  				ie_len + 2,
>  				&group_cipher,
>  				&pairwise_cipher,
>  				NULL
>  			) == _SUCCESS) {
> -				psecuritypriv->dot11AuthAlgrthm = dot11AuthAlgrthm_8021X;
> +				psecuritypriv->dot11_auth_algrthm = dot11_auth_algrthm_8021X;
>  
>  				psecuritypriv->dot8021xalg = 1;/* psk,  todo:802.1x */
>  
> @@ -1001,8 +988,8 @@ int rtw_check_beacon_data(struct adapter *padapter, u8 *pbuf,  int len)
>  	pmlmepriv->qospriv.qos_option = 0;
>  	if (pregistrypriv->wmm_enable) {
>  		for (p = ie + _BEACON_IE_OFFSET_; ; p += (ie_len + 2)) {
> -			p = rtw_get_ie(
> -				p,
> +			p = rtw_get_ie
> +				(p,
>  				WLAN_EID_VENDOR_SPECIFIC,
>  				&ie_len,
>  				(pbss_network->ie_length - _BEACON_IE_OFFSET_ - (ie_len + 2))
> @@ -1028,8 +1015,8 @@ int rtw_check_beacon_data(struct adapter *padapter, u8 *pbuf,  int len)
>  	}
>  
>  	/* parsing HT_CAP_IE */
> -	p = rtw_get_ie(
> -		ie + _BEACON_IE_OFFSET_,
> +	p = rtw_get_ie
> +		(ie + _BEACON_IE_OFFSET_,
>  		WLAN_EID_HT_CAPABILITY,
>  		&ie_len,
>  		(pbss_network->ie_length - _BEACON_IE_OFFSET_)
> @@ -1038,17 +1025,17 @@ int rtw_check_beacon_data(struct adapter *padapter, u8 *pbuf,  int len)
>  		u8 max_rx_ampdu_factor = 0;
>  		struct ieee80211_ht_cap *pht_cap = (struct ieee80211_ht_cap *)(p + 2);
>  
> -		pHT_caps_ie = p;
> +		pht_caps_ie = p;
>  
>  		ht_cap = true;
>  		network_type |= WIRELESS_11_24N;
>  
>  		rtw_ht_use_default_setting(padapter);
>  
> -		if (pmlmepriv->htpriv.sgi_20m == false)
> +		if (!pmlmepriv->htpriv.sgi_20m)
>  			pht_cap->cap_info &= cpu_to_le16(~(IEEE80211_HT_CAP_SGI_20));
>  
> -		if (pmlmepriv->htpriv.sgi_40m == false)
> +		if (!pmlmepriv->htpriv.sgi_40m)
>  			pht_cap->cap_info &= cpu_to_le16(~(IEEE80211_HT_CAP_SGI_40));
>  
>  		if (!TEST_FLAG(pmlmepriv->htpriv.ldpc_cap, LDPC_HT_ENABLE_RX))
> @@ -1060,8 +1047,8 @@ int rtw_check_beacon_data(struct adapter *padapter, u8 *pbuf,  int len)
>  		if (!TEST_FLAG(pmlmepriv->htpriv.stbc_cap, STBC_HT_ENABLE_RX))
>  			pht_cap->cap_info &= cpu_to_le16(~(IEEE80211_HT_CAP_RX_STBC_3R));
>  
> -		pht_cap->ampdu_params_info &= ~(
> -			IEEE80211_HT_CAP_AMPDU_FACTOR | IEEE80211_HT_CAP_AMPDU_DENSITY
> +		pht_cap->ampdu_params_info &=
> +			~(IEEE80211_HT_CAP_AMPDU_FACTOR | IEEE80211_HT_CAP_AMPDU_DENSITY
>  		);
>  
>  		if ((psecuritypriv->wpa_pairwise_cipher & WPA_CIPHER_CCMP) ||
> @@ -1073,13 +1060,12 @@ int rtw_check_beacon_data(struct adapter *padapter, u8 *pbuf,  int len)
>  						       0x00);
>  		}
>  
> -		rtw_hal_get_def_var(
> -			padapter,
> -			HW_VAR_MAX_RX_AMPDU_FACTOR,
> -			&max_rx_ampdu_factor
> +		rtw_hal_get_def_var(padapter,
> +				    HW_VAR_MAX_RX_AMPDU_FACTOR,
> +				    &max_rx_ampdu_factor
>  		);
> -		pht_cap->ampdu_params_info |= (
> -			IEEE80211_HT_CAP_AMPDU_FACTOR & max_rx_ampdu_factor
> +		pht_cap->ampdu_params_info |=
> +		(IEEE80211_HT_CAP_AMPDU_FACTOR & max_rx_ampdu_factor
>  		); /* set  Max Rx AMPDU size  to 64K */
>  
>  		pht_cap->mcs.rx_mask[0] = 0xff;
> @@ -1089,27 +1075,27 @@ int rtw_check_beacon_data(struct adapter *padapter, u8 *pbuf,  int len)
>  	}
>  
>  	/* parsing HT_INFO_IE */
> -	p = rtw_get_ie(
> -		ie + _BEACON_IE_OFFSET_,
> +	p = rtw_get_ie
> +		(ie + _BEACON_IE_OFFSET_,
>  		WLAN_EID_HT_OPERATION,
>  		&ie_len,
>  		(pbss_network->ie_length - _BEACON_IE_OFFSET_)
>  	);
>  	if (p && ie_len > 0)
> -		pHT_info_ie = p;
> +		pht_info_ie = p;
>  
>  	switch (network_type) {
>  	case WIRELESS_11B:
> -		pbss_network->network_type_in_use = Ndis802_11DS;
> +		pbss_network->network_type_in_use = ndis802_11ds;
>  		break;
>  	case WIRELESS_11G:
>  	case WIRELESS_11BG:
>  	case WIRELESS_11G_24N:
>  	case WIRELESS_11BG_24N:
> -		pbss_network->network_type_in_use = Ndis802_11OFDM24;
> +		pbss_network->network_type_in_use = ndis802_11ofdm24;
>  		break;
>  	default:
> -		pbss_network->network_type_in_use = Ndis802_11OFDM24;
> +		pbss_network->network_type_in_use = ndis802_11ofdm24;
>  		break;
>  	}
>  
> @@ -1131,13 +1117,13 @@ int rtw_check_beacon_data(struct adapter *padapter, u8 *pbuf,  int len)
>  		if (pregistrypriv->ampdu_enable == 1)
>  			pmlmepriv->htpriv.ampdu_enable = true;
>  
> -		HT_caps_handler(padapter, (struct ndis_80211_var_ie *)pHT_caps_ie);
> +		ht_caps_handler(padapter, (struct ndis_80211_var_ie *)pht_caps_ie);
>  
> -		HT_info_handler(padapter, (struct ndis_80211_var_ie *)pHT_info_ie);
> +		ht_info_handler(padapter, (struct ndis_80211_var_ie *)pht_info_ie);
>  	}
>  
> -	pbss_network->length = get_wlan_bssid_ex_sz(
> -		(struct wlan_bssid_ex  *)pbss_network
> +	pbss_network->length = get_wlan_bssid_ex_sz
> +		((struct wlan_bssid_ex  *)pbss_network
>  	);
>  
>  	/* issue beacon to start bss network */
> @@ -1155,7 +1141,8 @@ int rtw_check_beacon_data(struct adapter *padapter, u8 *pbuf,  int len)
>  	/*  update AP's sta info */
>  	update_ap_info(padapter, psta);
>  
> -	psta->state |= WIFI_AP_STATE;		/* Aries, add, fix bug of flush_cam_entry at STOP AP mode , 0724 */
> +	psta->state |= WIFI_AP_STATE;	/* Aries, add, fix bug of flush_cam_entry */
> +	/* at STOP AP mode , 0724 */
>  	rtw_indicate_connect(padapter);
>  
>  	pmlmepriv->cur_network.join_res = true;/* for check if already set beacon */
> @@ -1187,26 +1174,26 @@ int rtw_acl_add_sta(struct adapter *padapter, u8 *addr)
>  	if ((NUM_ACL - 1) < pacl_list->num)
>  		return (-1);
>  
> -	spin_lock_bh(&(pacl_node_q->lock));
> +	spin_lock_bh(&pacl_node_q->lock);
>  
>  	phead = get_list_head(pacl_node_q);
>  	list_for_each(plist, phead) {
>  		paclnode = list_entry(plist, struct rtw_wlan_acl_node, list);
>  
>  		if (!memcmp(paclnode->addr, addr, ETH_ALEN)) {
> -			if (paclnode->valid == true) {
> +			if (paclnode->valid) {
>  				added = true;
>  				break;
>  			}
>  		}
>  	}
>  
> -	spin_unlock_bh(&(pacl_node_q->lock));
> +	spin_unlock_bh(&pacl_node_q->lock);
>  
>  	if (added)
>  		return ret;
>  
> -	spin_lock_bh(&(pacl_node_q->lock));
> +	spin_lock_bh(&pacl_node_q->lock);
>  
>  	for (i = 0; i < NUM_ACL; i++) {
>  		paclnode = &pacl_list->aclnode[i];
> @@ -1226,7 +1213,7 @@ int rtw_acl_add_sta(struct adapter *padapter, u8 *addr)
>  		}
>  	}
>  
> -	spin_unlock_bh(&(pacl_node_q->lock));
> +	spin_unlock_bh(&pacl_node_q->lock);
>  
>  	return ret;
>  }
> @@ -1238,17 +1225,17 @@ void rtw_acl_remove_sta(struct adapter *padapter, u8 *addr)
>  	struct sta_priv *pstapriv = &padapter->stapriv;
>  	struct wlan_acl_pool *pacl_list = &pstapriv->acl_list;
>  	struct __queue	*pacl_node_q = &pacl_list->acl_node_q;
> -	u8 baddr[ETH_ALEN] = { 0xff, 0xff, 0xff, 0xff, 0xff, 0xff };	/* Baddr is used for clearing acl_list */
> +	u8 baddr[ETH_ALEN] = { 0xff, 0xff, 0xff, 0xff, 0xff, 0xff };	/* Baddr is */
> +	/* used for clearing acl_list */
>  
> -	spin_lock_bh(&(pacl_node_q->lock));
> +	spin_lock_bh(&pacl_node_q->lock);
>  
>  	phead = get_list_head(pacl_node_q);
>  	list_for_each_safe(plist, tmp, phead) {
>  		paclnode = list_entry(plist, struct rtw_wlan_acl_node, list);
>  
> -		if (
> -			!memcmp(paclnode->addr, addr, ETH_ALEN) ||
> -			!memcmp(baddr, addr, ETH_ALEN)
> +		if (!memcmp(paclnode->addr, addr, ETH_ALEN) ||
> +		    !memcmp(baddr, addr, ETH_ALEN)
>  		) {
>  			if (paclnode->valid) {
>  				paclnode->valid = false;
> @@ -1260,8 +1247,7 @@ void rtw_acl_remove_sta(struct adapter *padapter, u8 *addr)
>  		}
>  	}
>  
> -	spin_unlock_bh(&(pacl_node_q->lock));
> -
> +	spin_unlock_bh(&pacl_node_q->lock);
>  }
>  
>  u8 rtw_ap_set_pairwise_key(struct adapter *padapter, struct sta_info *psta)
> @@ -1286,11 +1272,11 @@ u8 rtw_ap_set_pairwise_key(struct adapter *padapter, struct sta_info *psta)
>  
>  	init_h2fwcmd_w_parm_no_rsp(ph2c, psetstakey_para, _SetStaKey_CMD_);
>  
> -	psetstakey_para->algorithm = (u8)psta->dot118021XPrivacy;
> +	psetstakey_para->algorithm = (u8)psta->dot118021_xprivacy;
>  
>  	memcpy(psetstakey_para->addr, psta->hwaddr, ETH_ALEN);
>  
> -	memcpy(psetstakey_para->key, &psta->dot118021x_UncstKey, 16);
> +	memcpy(psetstakey_para->key, &psta->dot118021x_uncst_key, 16);
>  
>  	res = rtw_enqueue_cmd(pcmdpriv, ph2c);
>  
> @@ -1299,18 +1285,17 @@ u8 rtw_ap_set_pairwise_key(struct adapter *padapter, struct sta_info *psta)
>  	return res;
>  }
>  
> -static int rtw_ap_set_key(
> -	struct adapter *padapter,
> -	u8 *key,
> -	u8 alg,
> -	int keyid,
> -	u8 set_tx
> +static int rtw_ap_set_key(struct adapter *padapter,
> +			  u8 *key,
> +			  u8 alg,
> +			  int keyid,
> +			  u8 set_tx
>  )
>  {
>  	u8 keylen;
>  	struct cmd_obj *pcmd;
>  	struct setkey_parm *psetkeyparm;
> -	struct cmd_priv *pcmdpriv = &(padapter->cmdpriv);
> +	struct cmd_priv *pcmdpriv = &padapter->cmdpriv;
>  	int res = _SUCCESS;
>  
>  	pcmd = rtw_zmalloc(sizeof(struct cmd_obj));
> @@ -1347,7 +1332,7 @@ static int rtw_ap_set_key(
>  		keylen = 16;
>  	}
>  
> -	memcpy(&(psetkeyparm->key[0]), key, keylen);
> +	memcpy(&psetkeyparm->key[0], key, keylen);
>  
>  	pcmd->cmdcode = _SetKey_CMD_;
>  	pcmd->parmbuf = (u8 *)psetkeyparm;
> @@ -1369,12 +1354,11 @@ int rtw_ap_set_group_key(struct adapter *padapter, u8 *key, u8 alg, int keyid)
>  	return rtw_ap_set_key(padapter, key, alg, keyid, 1);
>  }
>  
> -int rtw_ap_set_wep_key(
> -	struct adapter *padapter,
> -	u8 *key,
> -	u8 keylen,
> -	int keyid,
> -	u8 set_tx
> +int rtw_ap_set_wep_key(struct adapter *padapter,
> +		       u8 *key,
> +		       u8 keylen,
> +		       int keyid,
> +		       u8 set_tx
>  )
>  {
>  	u8 alg;
> @@ -1399,10 +1383,10 @@ static void update_bcn_fixed_ie(struct adapter *padapter)
>  
>  static void update_bcn_erpinfo_ie(struct adapter *padapter)
>  {
> -	struct mlme_priv *pmlmepriv = &(padapter->mlmepriv);
> -	struct mlme_ext_priv *pmlmeext = &(padapter->mlmeextpriv);
> -	struct mlme_ext_info *pmlmeinfo = &(pmlmeext->mlmext_info);
> -	struct wlan_bssid_ex *pnetwork = &(pmlmeinfo->network);
> +	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
> +	struct mlme_ext_priv *pmlmeext = &padapter->mlmeextpriv;
> +	struct mlme_ext_info *pmlmeinfo = &pmlmeext->mlmext_info;
> +	struct wlan_bssid_ex *pnetwork = &pmlmeinfo->network;
>  	unsigned char *p, *ie = pnetwork->ies;
>  	u32 len = 0;
>  
> @@ -1410,28 +1394,27 @@ static void update_bcn_erpinfo_ie(struct adapter *padapter)
>  		return;
>  
>  	/* parsing ERP_IE */
> -	p = rtw_get_ie(
> -		ie + _BEACON_IE_OFFSET_,
> -		WLAN_EID_ERP_INFO,
> -		&len,
> -		(pnetwork->ie_length - _BEACON_IE_OFFSET_)
> +	p = rtw_get_ie(ie + _BEACON_IE_OFFSET_,
> +		       WLAN_EID_ERP_INFO,
> +		       &len,
> +		       (pnetwork->ie_length - _BEACON_IE_OFFSET_)
>  	);
>  	if (p && len > 0) {
> -		struct ndis_80211_var_ie *pIE = (struct ndis_80211_var_ie *)p;
> +		struct ndis_80211_var_ie *p_ie = (struct ndis_80211_var_ie *)p;
>  
>  		if (pmlmepriv->num_sta_non_erp == 1)
> -			pIE->data[0] |= RTW_ERP_INFO_NON_ERP_PRESENT | RTW_ERP_INFO_USE_PROTECTION;
> +			p_ie->data[0] |= RTW_ERP_INFO_NON_ERP_PRESENT | RTW_ERP_INFO_USE_PROTECTION;
>  		else
> -			pIE->data[0] &= ~(
> -				RTW_ERP_INFO_NON_ERP_PRESENT | RTW_ERP_INFO_USE_PROTECTION
> +			p_ie->data[0] &=
> +				~(RTW_ERP_INFO_NON_ERP_PRESENT | RTW_ERP_INFO_USE_PROTECTION
>  			);
>  
>  		if (pmlmepriv->num_sta_no_short_preamble > 0)
> -			pIE->data[0] |= RTW_ERP_INFO_BARKER_PREAMBLE_MODE;
> +			p_ie->data[0] |= RTW_ERP_INFO_BARKER_PREAMBLE_MODE;
>  		else
> -			pIE->data[0] &= ~(RTW_ERP_INFO_BARKER_PREAMBLE_MODE);
> +			p_ie->data[0] &= ~(RTW_ERP_INFO_BARKER_PREAMBLE_MODE);
>  
> -		ERP_IE_handler(padapter, pIE);
> +		ERP_IE_handler(padapter, p_ie);
>  	}
>  }
>  
> @@ -1463,18 +1446,17 @@ static void update_bcn_wps_ie(struct adapter *padapter)
>  	u8 *pbackup_remainder_ie = NULL;
>  
>  	uint wps_ielen = 0, wps_offset, remainder_ielen;
> -	struct mlme_priv *pmlmepriv = &(padapter->mlmepriv);
> -	struct mlme_ext_priv *pmlmeext = &(padapter->mlmeextpriv);
> -	struct mlme_ext_info *pmlmeinfo = &(pmlmeext->mlmext_info);
> -	struct wlan_bssid_ex *pnetwork = &(pmlmeinfo->network);
> +	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
> +	struct mlme_ext_priv *pmlmeext = &padapter->mlmeextpriv;
> +	struct mlme_ext_info *pmlmeinfo = &pmlmeext->mlmext_info;
> +	struct wlan_bssid_ex *pnetwork = &pmlmeinfo->network;
>  	unsigned char *ie = pnetwork->ies;
>  	u32 ielen = pnetwork->ie_length;
>  
> -	pwps_ie = rtw_get_wps_ie(
> -		ie + _FIXED_IE_LENGTH_,
> -		ielen - _FIXED_IE_LENGTH_,
> -		NULL,
> -		&wps_ielen
> +	pwps_ie = rtw_get_wps_ie(ie + _FIXED_IE_LENGTH_,
> +				 ielen - _FIXED_IE_LENGTH_,
> +				 NULL,
> +				 &wps_ielen
>  	);
>  
>  	if (!pwps_ie || wps_ielen == 0)
> @@ -1499,7 +1481,7 @@ static void update_bcn_wps_ie(struct adapter *padapter)
>  	wps_ielen = (uint)pwps_ie_src[1];/* to get ie data len */
>  	if ((wps_offset + wps_ielen + 2 + remainder_ielen) <= MAX_IE_SZ) {
>  		memcpy(pwps_ie, pwps_ie_src, wps_ielen + 2);
> -		pwps_ie += (wps_ielen+2);
> +		pwps_ie += (wps_ielen + 2);
>  
>  		if (pbackup_remainder_ie)
>  			memcpy(pwps_ie, pbackup_remainder_ie, remainder_ielen);
> @@ -1539,8 +1521,8 @@ void update_beacon(struct adapter *padapter, u8 ie_id, u8 *oui, u8 tx)
>  	if (!padapter)
>  		return;
>  
> -	pmlmepriv = &(padapter->mlmepriv);
> -	pmlmeext = &(padapter->mlmeextpriv);
> +	pmlmepriv = &padapter->mlmepriv;
> +	pmlmeext = &padapter->mlmeextpriv;
>  	/* pmlmeinfo = &(pmlmeext->mlmext_info); */
>  
>  	if (!pmlmeext->bstart_bss)
> @@ -1621,14 +1603,14 @@ static int rtw_ht_operation_update(struct adapter *padapter)
>  {
>  	u16 cur_op_mode, new_op_mode;
>  	int op_mode_changes = 0;
> -	struct mlme_priv *pmlmepriv = &(padapter->mlmepriv);
> +	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
>  	struct ht_priv *phtpriv_ap = &pmlmepriv->htpriv;
>  
>  	if (pmlmepriv->htpriv.ht_option)
>  		return 0;
>  
> -	if (!(pmlmepriv->ht_op_mode & IEEE80211_HT_OP_MODE_NON_GF_STA_PRSNT)
> -	    && pmlmepriv->num_sta_ht_no_gf) {
> +	if (!(pmlmepriv->ht_op_mode & IEEE80211_HT_OP_MODE_NON_GF_STA_PRSNT) &&
> +	    pmlmepriv->num_sta_ht_no_gf) {
>  		pmlmepriv->ht_op_mode |=
>  			IEEE80211_HT_OP_MODE_NON_GF_STA_PRSNT;
>  		op_mode_changes++;
> @@ -1660,9 +1642,8 @@ static int rtw_ht_operation_update(struct adapter *padapter)
>  	if (pmlmepriv->num_sta_no_ht ||
>  	    (pmlmepriv->ht_op_mode & IEEE80211_HT_OP_MODE_NON_GF_STA_PRSNT))
>  		new_op_mode = IEEE80211_HT_OP_MODE_PROTECTION_NONHT_MIXED;
> -	else if (
> -		(le16_to_cpu(phtpriv_ap->ht_cap.cap_info) & IEEE80211_HT_CAP_SUP_WIDTH)
> -		&& pmlmepriv->num_sta_ht_20mhz)
> +	else if ((le16_to_cpu(phtpriv_ap->ht_cap.cap_info) &
> +			IEEE80211_HT_CAP_SUP_WIDTH) && pmlmepriv->num_sta_ht_20mhz)
>  		new_op_mode = IEEE80211_HT_OP_MODE_PROTECTION_20MHZ;
>  	else if (pmlmepriv->olbc_ht)
>  		new_op_mode = IEEE80211_HT_OP_MODE_PROTECTION_NONMEMBER;
> @@ -1705,8 +1686,8 @@ void associated_clients_update(struct adapter *padapter, u8 updated)
>  void bss_cap_update_on_sta_join(struct adapter *padapter, struct sta_info *psta)
>  {
>  	u8 beacon_updated = false;
> -	struct mlme_priv *pmlmepriv = &(padapter->mlmepriv);
> -	struct mlme_ext_priv *pmlmeext = &(padapter->mlmeextpriv);
> +	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
> +	struct mlme_ext_priv *pmlmeext = &padapter->mlmeextpriv;
>  
>  	if (!(psta->flags & WLAN_STA_SHORT_PREAMBLE)) {
>  		if (!psta->no_short_preamble_set) {
> @@ -1825,8 +1806,8 @@ void bss_cap_update_on_sta_join(struct adapter *padapter, struct sta_info *psta)
>  u8 bss_cap_update_on_sta_leave(struct adapter *padapter, struct sta_info *psta)
>  {
>  	u8 beacon_updated = false;
> -	struct mlme_priv *pmlmepriv = &(padapter->mlmepriv);
> -	struct mlme_ext_priv *pmlmeext = &(padapter->mlmeextpriv);
> +	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
> +	struct mlme_ext_priv *pmlmeext = &padapter->mlmeextpriv;
>  
>  	if (!psta)
>  		return beacon_updated;
> @@ -1834,8 +1815,8 @@ u8 bss_cap_update_on_sta_leave(struct adapter *padapter, struct sta_info *psta)
>  	if (psta->no_short_preamble_set) {
>  		psta->no_short_preamble_set = 0;
>  		pmlmepriv->num_sta_no_short_preamble--;
> -		if (pmlmeext->cur_wireless_mode > WIRELESS_11B
> -		    && pmlmepriv->num_sta_no_short_preamble == 0){
> +		if (pmlmeext->cur_wireless_mode > WIRELESS_11B &&
> +		    pmlmepriv->num_sta_no_short_preamble == 0){
>  			beacon_updated = true;
>  			update_beacon(padapter, 0xFF, NULL, true);
>  		}
> @@ -1853,8 +1834,8 @@ u8 bss_cap_update_on_sta_leave(struct adapter *padapter, struct sta_info *psta)
>  	if (psta->no_short_slot_time_set) {
>  		psta->no_short_slot_time_set = 0;
>  		pmlmepriv->num_sta_no_short_slot_time--;
> -		if (pmlmeext->cur_wireless_mode > WIRELESS_11B
> -		    && pmlmepriv->num_sta_no_short_slot_time == 0){
> +		if (pmlmeext->cur_wireless_mode > WIRELESS_11B &&
> +		    pmlmepriv->num_sta_no_short_slot_time == 0){
>  			beacon_updated = true;
>  			update_beacon(padapter, 0xFF, NULL, true);
>  		}
> @@ -1883,11 +1864,10 @@ u8 bss_cap_update_on_sta_leave(struct adapter *padapter, struct sta_info *psta)
>  	return beacon_updated;
>  }
>  
> -u8 ap_free_sta(
> -	struct adapter *padapter,
> -	struct sta_info *psta,
> -	bool active,
> -	u16 reason
> +u8 ap_free_sta(struct adapter *padapter,
> +	       struct sta_info *psta,
> +	       bool active,
> +	       u16 reason
>  )
>  {
>  	u8 beacon_updated = false;
> @@ -1934,7 +1914,7 @@ void rtw_sta_flush(struct adapter *padapter)
>  	struct sta_info *psta = NULL;
>  	struct sta_priv *pstapriv = &padapter->stapriv;
>  	struct mlme_ext_priv *pmlmeext = &padapter->mlmeextpriv;
> -	struct mlme_ext_info *pmlmeinfo = &(pmlmeext->mlmext_info);
> +	struct mlme_ext_info *pmlmeinfo = &pmlmeext->mlmext_info;
>  	u8 bc_addr[ETH_ALEN] = {0xff, 0xff, 0xff, 0xff, 0xff, 0xff};
>  
>  	if ((pmlmeinfo->state & 0x03) != WIFI_FW_AP_STATE)
> @@ -1964,7 +1944,7 @@ void rtw_sta_flush(struct adapter *padapter)
>  void sta_info_update(struct adapter *padapter, struct sta_info *psta)
>  {
>  	int flags = psta->flags;
> -	struct mlme_priv *pmlmepriv = &(padapter->mlmepriv);
> +	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
>  
>  	/* update wmm cap. */
>  	if (WLAN_STA_WME & flags)
> @@ -1993,47 +1973,46 @@ void sta_info_update(struct adapter *padapter, struct sta_info *psta)
>  void ap_sta_info_defer_update(struct adapter *padapter, struct sta_info *psta)
>  {
>  	struct mlme_ext_priv *pmlmeext = &padapter->mlmeextpriv;
> -	struct mlme_ext_info *pmlmeinfo = &(pmlmeext->mlmext_info);
> +	struct mlme_ext_info *pmlmeinfo = &pmlmeext->mlmext_info;
>  
>  	if (psta->state & _FW_LINKED) {
>  		pmlmeinfo->FW_sta_info[psta->mac_id].psta = psta;
>  
>  		/* add ratid */
> -		add_RATid(padapter, psta, 0);/* DM_RATR_STA_INIT */
> +		add_rat_id(padapter, psta, 0);/* DM_RATR_STA_INIT */
>  	}
>  }
> +
>  /* restore hw setting from sw data structures */
>  void rtw_ap_restore_network(struct adapter *padapter)
>  {
>  	struct mlme_ext_priv *pmlmeext = &padapter->mlmeextpriv;
>  	struct sta_priv *pstapriv = &padapter->stapriv;
>  	struct sta_info *psta;
> -	struct security_priv *psecuritypriv = &(padapter->securitypriv);
> +	struct security_priv *psecuritypriv = &padapter->securitypriv;
>  	struct list_head	*phead, *plist;
>  	u8 chk_alive_num = 0;
>  	char chk_alive_list[NUM_STA];
>  	int i;
>  
> -	rtw_setopmode_cmd(padapter, Ndis802_11APMode, false);
> +	rtw_setopmode_cmd(padapter, ndis802_11_ap_mode, false);
>  
> -	set_channel_bwmode(
> -		padapter,
> -		pmlmeext->cur_channel,
> -		pmlmeext->cur_ch_offset,
> -		pmlmeext->cur_bwmode
> +	set_channel_bwmode(padapter,
> +			   pmlmeext->cur_channel,
> +			   pmlmeext->cur_ch_offset,
> +			   pmlmeext->cur_bwmode
>  	);
>  
>  	start_bss_network(padapter);
>  
> -	if ((padapter->securitypriv.dot11PrivacyAlgrthm == _TKIP_) ||
> -	    (padapter->securitypriv.dot11PrivacyAlgrthm == _AES_)) {
> +	if ((padapter->securitypriv.dot11_privacy_algrthm == _TKIP_) ||
> +	    (padapter->securitypriv.dot11_privacy_algrthm == _AES_)) {
>  		/* restore group key, WEP keys is restored in ips_leave() */
> -		rtw_set_key(
> -			padapter,
> -			psecuritypriv,
> -			psecuritypriv->dot118021XGrpKeyid,
> -			0,
> -			false
> +		rtw_set_key(padapter,
> +			    psecuritypriv,
> +			    psecuritypriv->dot118021_xgrp_keyid,
> +			    0,
> +			    false
>  		);
>  	}
>  
> @@ -2060,11 +2039,11 @@ void rtw_ap_restore_network(struct adapter *padapter)
>  
>  		if (psta->state & _FW_LINKED) {
>  			rtw_sta_media_status_rpt(padapter, psta, 1);
> -			Update_RA_Entry(padapter, psta);
> +			update_ra_entry(padapter, psta);
>  			/* pairwise key */
>  			/* per sta pairwise key and settings */
> -			if ((psecuritypriv->dot11PrivacyAlgrthm == _TKIP_) ||
> -			    (psecuritypriv->dot11PrivacyAlgrthm == _AES_)) {
> +			if ((psecuritypriv->dot11_privacy_algrthm == _TKIP_) ||
> +			    (psecuritypriv->dot11_privacy_algrthm == _AES_)) {
>  				rtw_setstakey_cmd(padapter, psta, true, false);
>  			}
>  		}
> @@ -2074,7 +2053,7 @@ void rtw_ap_restore_network(struct adapter *padapter)
>  void start_ap_mode(struct adapter *padapter)
>  {
>  	int i;
> -	struct mlme_priv *pmlmepriv = &(padapter->mlmepriv);
> +	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
>  	struct sta_priv *pstapriv = &padapter->stapriv;
>  	struct mlme_ext_priv *pmlmeext = &padapter->mlmeextpriv;
>  	struct wlan_acl_pool *pacl_list = &pstapriv->acl_list;
> @@ -2111,7 +2090,7 @@ void start_ap_mode(struct adapter *padapter)
>  	pmlmepriv->p2p_probe_resp_ie = NULL;
>  
>  	/* for ACL */
> -	INIT_LIST_HEAD(&(pacl_list->acl_node_q.queue));
> +	INIT_LIST_HEAD(&pacl_list->acl_node_q.queue);
>  	pacl_list->num = 0;
>  	pacl_list->mode = 0;
>  	for (i = 0; i < NUM_ACL; i++) {
> @@ -2126,7 +2105,7 @@ void stop_ap_mode(struct adapter *padapter)
>  	struct rtw_wlan_acl_node *paclnode;
>  	struct sta_info *psta = NULL;
>  	struct sta_priv *pstapriv = &padapter->stapriv;
> -	struct mlme_priv *pmlmepriv = &(padapter->mlmepriv);
> +	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
>  	struct mlme_ext_priv *pmlmeext = &padapter->mlmeextpriv;
>  	struct wlan_acl_pool *pacl_list = &pstapriv->acl_list;
>  	struct __queue	*pacl_node_q = &pacl_list->acl_node_q;
> @@ -2135,16 +2114,15 @@ void stop_ap_mode(struct adapter *padapter)
>  	pmlmeext->bstart_bss = false;
>  
>  	/* reset and init security priv , this can refine with rtw_reset_securitypriv */
> -	memset(
> -		(unsigned char *)&padapter->securitypriv,
> -		0,
> -		sizeof(struct security_priv)
> +	memset((unsigned char *)&padapter->securitypriv,
> +	       0,
> +	       sizeof(struct security_priv)
>  	);
> -	padapter->securitypriv.ndisauthtype = Ndis802_11AuthModeOpen;
> -	padapter->securitypriv.ndisencryptstatus = Ndis802_11WEPDisabled;
> +	padapter->securitypriv.ndisauthtype = ndis802_11auth_mode_open;
> +	padapter->securitypriv.ndisencryptstatus = ndis802_11wep_disabled;
>  
>  	/* for ACL */
> -	spin_lock_bh(&(pacl_node_q->lock));
> +	spin_lock_bh(&pacl_node_q->lock);
>  	phead = get_list_head(pacl_node_q);
>  	list_for_each_safe(plist, tmp, phead) {
>  		paclnode = list_entry(plist, struct rtw_wlan_acl_node, list);
> @@ -2157,7 +2135,7 @@ void stop_ap_mode(struct adapter *padapter)
>  			pacl_list->num--;
>  		}
>  	}
> -	spin_unlock_bh(&(pacl_node_q->lock));
> +	spin_unlock_bh(&pacl_node_q->lock);
>  
>  	rtw_sta_flush(padapter);
>  
> @@ -2171,5 +2149,5 @@ void stop_ap_mode(struct adapter *padapter)
>  
>  	rtw_free_mlme_priv_ie_data(pmlmepriv);
>  
> -	rtw_btcoex_MediaStatusNotify(padapter, 0); /* disconnect */
> +	rtw_btcoex_media_status_notify(padapter, 0); /* disconnect */
>  }
> diff --git a/drivers/staging/rtl8723bs/core/rtw_cmd.c b/drivers/staging/rtl8723bs/core/rtw_cmd.c
> index b4170f64d118..e65de859cb59 100644
> --- a/drivers/staging/rtl8723bs/core/rtw_cmd.c
> +++ b/drivers/staging/rtl8723bs/core/rtw_cmd.c
> @@ -792,9 +792,9 @@ u8 rtw_joinbss_cmd(struct adapter  *padapter, struct wlan_network *pnetwork)
>  		/* Added by Albert 2010/06/23 */
>  		/* For the WEP mode, we will use the bg mode to do the connection to avoid some IOT issue. */
>  		/* Especially for Realtek 8192u SoftAP. */
> -		if ((padapter->securitypriv.dot11PrivacyAlgrthm != _WEP40_) &&
> -			(padapter->securitypriv.dot11PrivacyAlgrthm != _WEP104_) &&
> -			(padapter->securitypriv.dot11PrivacyAlgrthm != _TKIP_)) {
> +		if ((padapter->securitypriv.dot11_privacy_algrthm != _WEP40_) &&
> +			(padapter->securitypriv.dot11_privacy_algrthm != _WEP104_) &&
> +			(padapter->securitypriv.dot11_privacy_algrthm != _TKIP_)) {
>  			rtw_ht_use_default_setting(padapter);
>  
>  			rtw_build_wmm_ie_ht(padapter, &psecnetwork->ies[12], &psecnetwork->ie_length);
> @@ -913,14 +913,14 @@ u8 rtw_setstakey_cmd(struct adapter *padapter, struct sta_info *sta, u8 unicast_
>  	memcpy(psetstakey_para->addr, sta->hwaddr, ETH_ALEN);
>  
>  	if (check_fwstate(pmlmepriv, WIFI_STATION_STATE))
> -		psetstakey_para->algorithm = (unsigned char)psecuritypriv->dot11PrivacyAlgrthm;
> +		psetstakey_para->algorithm = (unsigned char)psecuritypriv->dot11_privacy_algrthm;
>  	else
>  		GET_ENCRY_ALGO(psecuritypriv, sta, psetstakey_para->algorithm, false);
>  
>  	if (unicast_key)
> -		memcpy(&psetstakey_para->key, &sta->dot118021x_UncstKey, 16);
> +		memcpy(&psetstakey_para->key, &sta->dot118021x_uncst_key, 16);
>  	else
> -		memcpy(&psetstakey_para->key, &psecuritypriv->dot118021XGrpKey[psecuritypriv->dot118021XGrpKeyid].skey, 16);
> +		memcpy(&psetstakey_para->key, &psecuritypriv->dot118021XGrpKey[psecuritypriv->dot118021_xgrp_keyid].skey, 16);
>  
>  	/* jeff: set this because at least sw key is ready */
>  	padapter->securitypriv.busetkipkey = true;
> @@ -1380,11 +1380,11 @@ void lps_ctrl_wk_hdl(struct adapter *padapter, u8 lps_ctrl_type)
>  		/*  Reset LPS Setting */
>  		pwrpriv->LpsIdleCount = 0;
>  		rtw_hal_set_hwreg(padapter, HW_VAR_H2C_FW_JOINBSSRPT, (u8 *)(&mstatus));
> -		rtw_btcoex_MediaStatusNotify(padapter, mstatus);
> +		rtw_btcoex_media_status_notify(padapter, mstatus);
>  		break;
>  	case LPS_CTRL_DISCONNECT:
>  		mstatus = 0;/* disconnect */
> -		rtw_btcoex_MediaStatusNotify(padapter, mstatus);
> +		rtw_btcoex_media_status_notify(padapter, mstatus);
>  		LPS_Leave(padapter, "LPS_CTRL_DISCONNECT");
>  		rtw_hal_set_hwreg(padapter, HW_VAR_H2C_FW_JOINBSSRPT, (u8 *)(&mstatus));
>  		break;
> diff --git a/drivers/staging/rtl8723bs/core/rtw_efuse.c b/drivers/staging/rtl8723bs/core/rtw_efuse.c
> index 06e727ce9cc2..2ec77d7fa296 100644
> --- a/drivers/staging/rtl8723bs/core/rtw_efuse.c
> +++ b/drivers/staging/rtl8723bs/core/rtw_efuse.c
> @@ -9,7 +9,6 @@
>  #include <hal_data.h>
>  #include <linux/jiffies.h>
>  
> -
>  /* Define global variables */
>  u8 fakeEfuseBank;
>  u32 fakeEfuseUsedBytes;
> @@ -38,7 +37,7 @@ Efuse_Read1ByteFromFakeContent(u16 Offset, u8 *Value)
>  	if (fakeEfuseBank == 0)
>  		*Value = fakeEfuseContent[Offset];
>  	else
> -		*Value = fakeBTEfuseContent[fakeEfuseBank-1][Offset];
> +		*Value = fakeBTEfuseContent[fakeEfuseBank - 1][Offset];
>  	return true;
>  }
>  
> @@ -50,7 +49,7 @@ Efuse_Write1ByteToFakeContent(u16 Offset, u8 Value)
>  	if (fakeEfuseBank == 0)
>  		fakeEfuseContent[Offset] = Value;
>  	else
> -		fakeBTEfuseContent[fakeEfuseBank-1][Offset] = Value;
> +		fakeBTEfuseContent[fakeEfuseBank - 1][Offset] = Value;
>  	return true;
>  }
>  
> @@ -71,12 +70,12 @@ Efuse_Write1ByteToFakeContent(u16 Offset, u8 Value)
>   * When			Who		Remark
>   * 11/17/2008	MHC		Create Version 0.
>   *
> - *---------------------------------------------------------------------------*/
> + *---------------------------------------------------------------------------
> + */
>  void
> -Efuse_PowerSwitch(
> -struct adapter *padapter,
> -u8 bWrite,
> -u8 PwrState)
> +Efuse_PowerSwitch(struct adapter *padapter,
> +		  u8 bWrite,
> +		  u8 PwrState)
>  {
>  	padapter->HalFunc.EfusePowerSwitch(padapter, bWrite, PwrState);
>  }
> @@ -96,12 +95,12 @@ u8 PwrState)
>   * When			Who		Remark
>   * 11/16/2008	MHC		Create Version 0.
>   *
> - *---------------------------------------------------------------------------*/
> + *---------------------------------------------------------------------------
> + */
>  u16
> -Efuse_GetCurrentSize(
> -	struct adapter *padapter,
> -	u8	efuseType,
> -	bool		bPseudoTest)
> +Efuse_GetCurrentSize(struct adapter *padapter,
> +		     u8	efuseType,
> +		     bool		bPseudoTest)
>  {
>  	return padapter->HalFunc.EfuseGetCurrentSize(padapter, efuseType,
>  						     bPseudoTest);
> @@ -112,6 +111,7 @@ u8
>  Efuse_CalculateWordCnts(u8 word_en)
>  {
>  	u8 word_cnts = 0;
> +
>  	if (!(word_en & BIT(0)))
>  		word_cnts++; /*  0 : write enable */
>  	if (!(word_en & BIT(1)))
> @@ -142,34 +142,31 @@ Efuse_CalculateWordCnts(u8 word_en)
>  /*  */
>  
>  void
> -efuse_ReadEFuse(
> -	struct adapter *Adapter,
> -	u8 efuseType,
> -	u16		_offset,
> -	u16		_size_byte,
> -	u8 *pbuf,
> -bool	bPseudoTest
> +efuse_ReadEFuse(struct adapter *Adapter,
> +		u8 efuseType,
> +		u16		_offset,
> +		u16		_size_byte,
> +		u8 *pbuf,
> +		bool	 bPseudoTest
>  	);
>  void
> -efuse_ReadEFuse(
> -	struct adapter *Adapter,
> -	u8 efuseType,
> -	u16		_offset,
> -	u16		_size_byte,
> -	u8 *pbuf,
> -bool	bPseudoTest
> +efuse_ReadEFuse(struct adapter *Adapter,
> +		u8 efuseType,
> +		u16		_offset,
> +		u16		_size_byte,
> +		u8 *pbuf,
> +		bool	bPseudoTest
>  	)
>  {
>  	Adapter->HalFunc.ReadEFuse(Adapter, efuseType, _offset, _size_byte, pbuf, bPseudoTest);
>  }
>  
>  void
> -EFUSE_GetEfuseDefinition(
> -	struct adapter *padapter,
> -	u8 efuseType,
> -	u8 type,
> -	void	*pOut,
> -	bool		bPseudoTest
> +EFUSE_GetEfuseDefinition(struct adapter *padapter,
> +			 u8 efuseType,
> +			 u8 type,
> +			 void	*pOut,
> +			 bool		bPseudoTest
>  	)
>  {
>  	padapter->HalFunc.EFUSEGetEfuseDefinition(padapter, efuseType, type, pOut, bPseudoTest);
> @@ -190,54 +187,55 @@ EFUSE_GetEfuseDefinition(
>   * When			Who		Remark
>   * 09/23/2008	MHC		Copy from WMAC.
>   *
> - *---------------------------------------------------------------------------*/
> + *---------------------------------------------------------------------------
> + */
>  u8
> -EFUSE_Read1Byte(
> -struct adapter *Adapter,
> -u16		Address)
> +EFUSE_Read1Byte(struct adapter *Adapter,
> +		u16		Address)
>  {
>  	u8 Bytetemp = {0x00};
>  	u8 temp = {0x00};
>  	u32 k = 0;
>  	u16 contentLen = 0;
>  
> -	EFUSE_GetEfuseDefinition(Adapter, EFUSE_WIFI, TYPE_EFUSE_REAL_CONTENT_LEN, (void *)&contentLen, false);
> +	EFUSE_GetEfuseDefinition(Adapter, EFUSE_WIFI, TYPE_EFUSE_REAL_CONTENT_LEN,
> +				 (void *)&contentLen, false);
>  
>  	if (Address < contentLen) {/* E-fuse 512Byte */
>  		/* Write E-fuse Register address bit0~7 */
>  		temp = Address & 0xFF;
> -		rtw_write8(Adapter, EFUSE_CTRL+1, temp);
> -		Bytetemp = rtw_read8(Adapter, EFUSE_CTRL+2);
> +		rtw_write8(Adapter, EFUSE_CTRL + 1, temp);
> +		Bytetemp = rtw_read8(Adapter, EFUSE_CTRL + 2);
>  		/* Write E-fuse Register address bit8~9 */
>  		temp = ((Address >> 8) & 0x03) | (Bytetemp & 0xFC);
> -		rtw_write8(Adapter, EFUSE_CTRL+2, temp);
> +		rtw_write8(Adapter, EFUSE_CTRL + 2, temp);
>  
>  		/* Write 0x30[31]= 0 */
> -		Bytetemp = rtw_read8(Adapter, EFUSE_CTRL+3);
> +		Bytetemp = rtw_read8(Adapter, EFUSE_CTRL + 3);
>  		temp = Bytetemp & 0x7F;
> -		rtw_write8(Adapter, EFUSE_CTRL+3, temp);
> +		rtw_write8(Adapter, EFUSE_CTRL + 3, temp);
>  
>  		/* Wait Write-ready (0x30[31]= 1) */
> -		Bytetemp = rtw_read8(Adapter, EFUSE_CTRL+3);
> +		Bytetemp = rtw_read8(Adapter, EFUSE_CTRL + 3);
>  		while (!(Bytetemp & 0x80)) {
> -			Bytetemp = rtw_read8(Adapter, EFUSE_CTRL+3);
> +			Bytetemp = rtw_read8(Adapter, EFUSE_CTRL + 3);
>  			k++;
>  			if (k == 1000)
>  				break;
>  		}
>  		return rtw_read8(Adapter, EFUSE_CTRL);
> -	} else
> +	} else {
>  		return 0xFF;
> +	}
>  
>  } /* EFUSE_Read1Byte */
>  
>  /*  11/16/2008 MH Read one byte from real Efuse. */
>  u8
> -efuse_OneByteRead(
> -struct adapter *padapter,
> -u16	addr,
> -u8	*data,
> -bool		bPseudoTest)
> +efuse_OneByteRead(struct adapter *padapter,
> +		  u16	addr,
> +		  u8	*data,
> +		  bool		bPseudoTest)
>  {
>  	u32 tmpidx = 0;
>  	u8 bResult;
> @@ -253,16 +251,16 @@ bool		bPseudoTest)
>  
>  	/*  -----------------e-fuse reg ctrl --------------------------------- */
>  	/* address */
> -	rtw_write8(padapter, EFUSE_CTRL+1, (u8)(addr&0xff));
> -	rtw_write8(padapter, EFUSE_CTRL+2, ((u8)((addr>>8) & 0x03)) |
> -	(rtw_read8(padapter, EFUSE_CTRL+2)&0xFC));
> +	rtw_write8(padapter, EFUSE_CTRL + 1, (u8)(addr & 0xff));
> +	rtw_write8(padapter, EFUSE_CTRL + 2, ((u8)((addr >> 8) & 0x03)) |
> +	(rtw_read8(padapter, EFUSE_CTRL + 2) & 0xFC));
>  
>  	/* rtw_write8(padapter, EFUSE_CTRL+3,  0x72); read cmd */
>  	/* Write bit 32 0 */
> -	readbyte = rtw_read8(padapter, EFUSE_CTRL+3);
> -	rtw_write8(padapter, EFUSE_CTRL+3, (readbyte & 0x7f));
> +	readbyte = rtw_read8(padapter, EFUSE_CTRL + 3);
> +	rtw_write8(padapter, EFUSE_CTRL + 3, (readbyte & 0x7f));
>  
> -	while (!(0x80 & rtw_read8(padapter, EFUSE_CTRL+3)) && (tmpidx < 1000)) {
> +	while (!(0x80 & rtw_read8(padapter, EFUSE_CTRL + 3)) && (tmpidx < 1000)) {
>  		mdelay(1);
>  		tmpidx++;
>  	}
> @@ -287,16 +285,13 @@ u8 efuse_OneByteWrite(struct adapter *padapter, u16 addr, u8 data, bool bPseudoT
>  	if (bPseudoTest)
>  		return Efuse_Write1ByteToFakeContent(addr, data);
>  
> -
>  	/*  -----------------e-fuse reg ctrl --------------------------------- */
>  	/* address */
>  
> -
>  	efuseValue = rtw_read32(padapter, EFUSE_CTRL);
> -	efuseValue |= (BIT21|BIT31);
> +	efuseValue |= (BIT21 | BIT31);
>  	efuseValue &= ~(0x3FFFF);
> -	efuseValue |= ((addr<<8 | data) & 0x3FFFF);
> -
> +	efuseValue |= ((addr << 8 | data) & 0x3FFFF);
>  
>  	/*  <20130227, Kordan> 8192E MP chip A-cut had better not set 0x34[11] until B-Cut. */
>  
> @@ -304,9 +299,9 @@ u8 efuse_OneByteWrite(struct adapter *padapter, u16 addr, u8 data, bool bPseudoT
>  	/* 0x34[11]: SW force PGMEN input of efuse to high. (for the bank selected by 0x34[9:8]) */
>  	/* PHY_SetMacReg(padapter, 0x34, BIT11, 1); */
>  	rtw_write16(padapter, 0x34, rtw_read16(padapter, 0x34) | (BIT11));
> -	rtw_write32(padapter, EFUSE_CTRL, 0x90600000|((addr<<8 | data)));
> +	rtw_write32(padapter, EFUSE_CTRL, 0x90600000 | ((addr << 8 | data)));
>  
> -	while ((0x80 &  rtw_read8(padapter, EFUSE_CTRL+3)) && (tmpidx < 100)) {
> +	while ((0x80 &  rtw_read8(padapter, EFUSE_CTRL + 3)) && (tmpidx < 100)) {
>  		mdelay(1);
>  		tmpidx++;
>  	}
> @@ -324,9 +319,9 @@ u8 efuse_OneByteWrite(struct adapter *padapter, u16 addr, u8 data, bool bPseudoT
>  
>  int
>  Efuse_PgPacketRead(struct adapter *padapter,
> -				u8	offset,
> -				u8	*data,
> -				bool		bPseudoTest)
> +		   u8	offset,
> +		   u8	*data,
> +		   bool		bPseudoTest)
>  {
>  	return padapter->HalFunc.Efuse_PgPacketRead(padapter, offset, data,
>  						    bPseudoTest);
> @@ -334,10 +329,10 @@ Efuse_PgPacketRead(struct adapter *padapter,
>  
>  int
>  Efuse_PgPacketWrite(struct adapter *padapter,
> -				u8	offset,
> -				u8	word_en,
> -				u8	*data,
> -				bool		bPseudoTest)
> +		    u8	offset,
> +		    u8	word_en,
> +		    u8	*data,
> +		    bool		bPseudoTest)
>  {
>  	return padapter->HalFunc.Efuse_PgPacketWrite(padapter, offset, word_en,
>  						     data, bPseudoTest);
> @@ -359,37 +354,37 @@ Efuse_PgPacketWrite(struct adapter *padapter,
>   * 11/16/2008	MHC		Create Version 0.
>   * 11/21/2008	MHC		Fix Write bug when we only enable late word.
>   *
> - *---------------------------------------------------------------------------*/
> + *---------------------------------------------------------------------------
> + */
>  void
>  efuse_WordEnableDataRead(u8 word_en,
> -						u8 *sourdata,
> -						u8 *targetdata)
> +			 u8 *sourdata,
> +			 u8 *targetdata)
>  {
> -	if (!(word_en&BIT(0))) {
> +	if (!(word_en & BIT(0))) {
>  		targetdata[0] = sourdata[0];
>  		targetdata[1] = sourdata[1];
>  	}
> -	if (!(word_en&BIT(1))) {
> +	if (!(word_en & BIT(1))) {
>  		targetdata[2] = sourdata[2];
>  		targetdata[3] = sourdata[3];
>  	}
> -	if (!(word_en&BIT(2))) {
> +	if (!(word_en & BIT(2))) {
>  		targetdata[4] = sourdata[4];
>  		targetdata[5] = sourdata[5];
>  	}
> -	if (!(word_en&BIT(3))) {
> +	if (!(word_en & BIT(3))) {
>  		targetdata[6] = sourdata[6];
>  		targetdata[7] = sourdata[7];
>  	}
>  }
>  
> -
>  u8
>  Efuse_WordEnableDataWrite(struct adapter *padapter,
> -						u16		efuse_addr,
> -						u8 word_en,
> -						u8 *data,
> -						bool		bPseudoTest)
> +			  u16		efuse_addr,
> +			  u8 word_en,
> +			  u8 *data,
> +			  bool		bPseudoTest)
>  {
>  	return padapter->HalFunc.Efuse_WordEnableDataWrite(padapter, efuse_addr,
>  							   word_en, data,
> @@ -411,20 +406,21 @@ Efuse_WordEnableDataWrite(struct adapter *padapter,
>   * When			Who		Remark
>   * 11/11/2008	MHC		Create Version 0.
>   *
> - *---------------------------------------------------------------------------*/
> + *---------------------------------------------------------------------------
> + */
>  void
> -Efuse_ReadAllMap(
> -	struct adapter *padapter,
> -	u8 efuseType,
> -	u8 *Efuse,
> -	bool		bPseudoTest);
> +Efuse_ReadAllMap(struct adapter *padapter,
> +		 u8 efuseType,
> +		 u8 *Efuse,
> +		 bool		bPseudoTest);
>  void Efuse_ReadAllMap(struct adapter *padapter, u8 efuseType, u8 *Efuse, bool bPseudoTest)
>  {
>  	u16 mapLen = 0;
>  
>  	Efuse_PowerSwitch(padapter, false, true);
>  
> -	EFUSE_GetEfuseDefinition(padapter, efuseType, TYPE_EFUSE_MAP_LEN, (void *)&mapLen, bPseudoTest);
> +	EFUSE_GetEfuseDefinition(padapter, efuseType, TYPE_EFUSE_MAP_LEN,
> +				 (void *)&mapLen, bPseudoTest);
>  
>  	efuse_ReadEFuse(padapter, efuseType, 0, mapLen, Efuse, bPseudoTest);
>  
> @@ -448,7 +444,8 @@ void Efuse_ReadAllMap(struct adapter *padapter, u8 efuseType, u8 *Efuse, bool bP
>   * When			Who		Remark
>   * 11/12/2008	MHC		Create Version 0.
>   *
> - *---------------------------------------------------------------------------*/
> + *---------------------------------------------------------------------------
> + */
>  static void efuse_ShadowRead1Byte(struct adapter *padapter, u16 Offset, u8 *Value)
>  {
>  	struct eeprom_priv *pEEPROM = GET_EEPROM_EFUSE_PRIV(padapter);
> @@ -463,7 +460,7 @@ static void efuse_ShadowRead2Byte(struct adapter *padapter, u16 Offset, u16 *Val
>  	struct eeprom_priv *pEEPROM = GET_EEPROM_EFUSE_PRIV(padapter);
>  
>  	*Value = pEEPROM->efuse_eeprom_data[Offset];
> -	*Value |= pEEPROM->efuse_eeprom_data[Offset+1]<<8;
> +	*Value |= pEEPROM->efuse_eeprom_data[Offset + 1] << 8;
>  
>  }	/*  EFUSE_ShadowRead2Byte */
>  
> @@ -473,9 +470,9 @@ static void efuse_ShadowRead4Byte(struct adapter *padapter, u16 Offset, u32 *Val
>  	struct eeprom_priv *pEEPROM = GET_EEPROM_EFUSE_PRIV(padapter);
>  
>  	*Value = pEEPROM->efuse_eeprom_data[Offset];
> -	*Value |= pEEPROM->efuse_eeprom_data[Offset+1]<<8;
> -	*Value |= pEEPROM->efuse_eeprom_data[Offset+2]<<16;
> -	*Value |= pEEPROM->efuse_eeprom_data[Offset+3]<<24;
> +	*Value |= pEEPROM->efuse_eeprom_data[Offset + 1] << 8;
> +	*Value |= pEEPROM->efuse_eeprom_data[Offset + 2] << 16;
> +	*Value |= pEEPROM->efuse_eeprom_data[Offset + 3] << 24;
>  
>  }	/*  efuse_ShadowRead4Byte */
>  
> @@ -494,13 +491,15 @@ static void efuse_ShadowRead4Byte(struct adapter *padapter, u16 Offset, u32 *Val
>   * When			Who		Remark
>   * 11/13/2008	MHC		Create Version 0.
>   *
> - *---------------------------------------------------------------------------*/
> + *---------------------------------------------------------------------------
> + */
>  void EFUSE_ShadowMapUpdate(struct adapter *padapter, u8 efuseType, bool bPseudoTest)
>  {
>  	struct eeprom_priv *pEEPROM = GET_EEPROM_EFUSE_PRIV(padapter);
>  	u16 mapLen = 0;
>  
> -	EFUSE_GetEfuseDefinition(padapter, efuseType, TYPE_EFUSE_MAP_LEN, (void *)&mapLen, bPseudoTest);
> +	EFUSE_GetEfuseDefinition(padapter, efuseType, TYPE_EFUSE_MAP_LEN,
> +				 (void *)&mapLen, bPseudoTest);
>  
>  	if (pEEPROM->bautoload_fail_flag)
>  		memset(pEEPROM->efuse_eeprom_data, 0xFF, mapLen);
> @@ -511,7 +510,6 @@ void EFUSE_ShadowMapUpdate(struct adapter *padapter, u8 efuseType, bool bPseudoT
>  	/* void *)&pHalData->EfuseMap[EFUSE_INIT_MAP][0], mapLen); */
>  } /*  EFUSE_ShadowMapUpdate */
>  
> -
>  /*-----------------------------------------------------------------------------
>   * Function:	EFUSE_ShadowRead
>   *
> @@ -527,7 +525,8 @@ void EFUSE_ShadowMapUpdate(struct adapter *padapter, u8 efuseType, bool bPseudoT
>   * When			Who		Remark
>   * 11/12/2008	MHC		Create Version 0.
>   *
> - *---------------------------------------------------------------------------*/
> + *---------------------------------------------------------------------------
> + */
>  void EFUSE_ShadowRead(struct adapter *padapter, u8 Type, u16 Offset, u32 *Value)
>  {
>  	if (Type == 1)
> diff --git a/drivers/staging/rtl8723bs/core/rtw_ioctl_set.c b/drivers/staging/rtl8723bs/core/rtw_ioctl_set.c
> index 8c11daff2d59..c3ce1737e642 100644
> --- a/drivers/staging/rtl8723bs/core/rtw_ioctl_set.c
> +++ b/drivers/staging/rtl8723bs/core/rtw_ioctl_set.c
> @@ -408,7 +408,7 @@ u8 rtw_set_802_11_authentication_mode(struct adapter *padapter, enum ndis_802_11
>  	psecuritypriv->ndisauthtype = authmode;
>  
>  	if (psecuritypriv->ndisauthtype > 3)
> -		psecuritypriv->dot11AuthAlgrthm = dot11AuthAlgrthm_8021X;
> +		psecuritypriv->dot11_auth_algrthm = dot11_auth_algrthm_8021X;
>  
>  	res = rtw_set_auth(padapter, psecuritypriv);
>  
> @@ -436,13 +436,13 @@ u8 rtw_set_802_11_add_wep(struct adapter *padapter, struct ndis_802_11_wep *wep)
>  
>  	switch (wep->key_length) {
>  	case 5:
> -		psecuritypriv->dot11PrivacyAlgrthm = _WEP40_;
> +		psecuritypriv->dot11_privacy_algrthm = _WEP40_;
>  		break;
>  	case 13:
> -		psecuritypriv->dot11PrivacyAlgrthm = _WEP104_;
> +		psecuritypriv->dot11_privacy_algrthm = _WEP104_;
>  		break;
>  	default:
> -		psecuritypriv->dot11PrivacyAlgrthm = _NO_PRIVACY_;
> +		psecuritypriv->dot11_privacy_algrthm = _NO_PRIVACY_;
>  		break;
>  	}
>  
> diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme.c b/drivers/staging/rtl8723bs/core/rtw_mlme.c
> index f2242cf2dfb4..d6cc11a2a2bf 100644
> --- a/drivers/staging/rtl8723bs/core/rtw_mlme.c
> +++ b/drivers/staging/rtl8723bs/core/rtw_mlme.c
> @@ -364,10 +364,10 @@ int rtw_is_same_ibss(struct adapter *adapter, struct wlan_network *pnetwork)
>  	int ret = true;
>  	struct security_priv *psecuritypriv = &adapter->securitypriv;
>  
> -	if ((psecuritypriv->dot11PrivacyAlgrthm != _NO_PRIVACY_) &&
> +	if ((psecuritypriv->dot11_privacy_algrthm != _NO_PRIVACY_) &&
>  		    (pnetwork->network.privacy == 0))
>  		ret = false;
> -	else if ((psecuritypriv->dot11PrivacyAlgrthm == _NO_PRIVACY_) &&
> +	else if ((psecuritypriv->dot11_privacy_algrthm == _NO_PRIVACY_) &&
>  		 (pnetwork->network.privacy == 1))
>  		ret = false;
>  	else
> @@ -1045,15 +1045,15 @@ static struct sta_info *rtw_joinbss_update_stainfo(struct adapter *padapter, str
>  		rtw_hal_set_odm_var(padapter, HAL_ODM_STA_INFO, psta, true);
>  
>  		/* security related */
> -		if (padapter->securitypriv.dot11AuthAlgrthm == dot11AuthAlgrthm_8021X) {
> +		if (padapter->securitypriv.dot11_auth_algrthm == dot11_auth_algrthm_8021X) {
>  			padapter->securitypriv.binstallGrpkey = false;
>  			padapter->securitypriv.busetkipkey = false;
>  			padapter->securitypriv.bgrpkey_handshake = false;
>  
>  			psta->ieee8021x_blocked = true;
> -			psta->dot118021XPrivacy = padapter->securitypriv.dot11PrivacyAlgrthm;
> +			psta->dot118021_xprivacy = padapter->securitypriv.dot11_privacy_algrthm;
>  
> -			memset((u8 *)&psta->dot118021x_UncstKey, 0, sizeof(union Keytype));
> +			memset((u8 *)&psta->dot118021x_uncst_key, 0, sizeof(union Keytype));
>  
>  			memset((u8 *)&psta->dot11tkiprxmickey, 0, sizeof(union Keytype));
>  			memset((u8 *)&psta->dot11tkiptxmickey, 0, sizeof(union Keytype));
> @@ -1376,8 +1376,8 @@ void rtw_stassoc_event_callback(struct adapter *adapter, u8 *pbuf)
>  
>  	rtw_sta_media_status_rpt(adapter, psta, 1);
>  
> -	if (adapter->securitypriv.dot11AuthAlgrthm == dot11AuthAlgrthm_8021X)
> -		psta->dot118021XPrivacy = adapter->securitypriv.dot11PrivacyAlgrthm;
> +	if (adapter->securitypriv.dot11_auth_algrthm == dot11_auth_algrthm_8021X)
> +		psta->dot118021_xprivacy = adapter->securitypriv.dot11_privacy_algrthm;
>  
>  	psta->ieee8021x_blocked = false;
>  
> @@ -1907,7 +1907,7 @@ signed int rtw_set_auth(struct adapter *adapter, struct security_priv *psecurity
>  		goto exit;
>  	}
>  
> -	psetauthparm->mode = (unsigned char)psecuritypriv->dot11AuthAlgrthm;
> +	psetauthparm->mode = (unsigned char)psecuritypriv->dot11_auth_algrthm;
>  
>  	pcmd->cmdcode = _SetAuth_CMD_;
>  	pcmd->parmbuf = (unsigned char *)psetauthparm;
> @@ -1937,10 +1937,10 @@ signed int rtw_set_key(struct adapter *adapter, struct security_priv *psecurityp
>  		goto exit;
>  	}
>  
> -	if (psecuritypriv->dot11AuthAlgrthm == dot11AuthAlgrthm_8021X)
> +	if (psecuritypriv->dot11_auth_algrthm == dot11_auth_algrthm_8021X)
>  		psetkeyparm->algorithm = (unsigned char)psecuritypriv->dot118021XGrpPrivacy;
>  	else
> -		psetkeyparm->algorithm = (u8)psecuritypriv->dot11PrivacyAlgrthm;
> +		psetkeyparm->algorithm = (u8)psecuritypriv->dot11_privacy_algrthm;
>  
>  	psetkeyparm->keyid = (u8)keyid;/* 0~3 */
>  	psetkeyparm->set_tx = set_tx;
> @@ -2148,20 +2148,20 @@ void rtw_update_registrypriv_dev_network(struct adapter *adapter)
>  	struct	wlan_network	*cur_network = &adapter->mlmepriv.cur_network;
>  	/* struct	xmit_priv *pxmitpriv = &adapter->xmitpriv; */
>  
> -	pdev_network->privacy = (psecuritypriv->dot11PrivacyAlgrthm > 0 ? 1 : 0) ; /*  adhoc no 802.1x */
> +	pdev_network->privacy = (psecuritypriv->dot11_privacy_algrthm > 0 ? 1 : 0) ; /*  adhoc no 802.1x */
>  
>  	pdev_network->rssi = 0;
>  
>  	switch (pregistrypriv->wireless_mode) {
>  	case WIRELESS_11B:
> -		pdev_network->network_type_in_use = (Ndis802_11DS);
> +		pdev_network->network_type_in_use = (ndis802_11ds);
>  		break;
>  	case WIRELESS_11G:
>  	case WIRELESS_11BG:
>  	case WIRELESS_11_24N:
>  	case WIRELESS_11G_24N:
>  	case WIRELESS_11BG_24N:
> -		pdev_network->network_type_in_use = (Ndis802_11OFDM24);
> +		pdev_network->network_type_in_use = (ndis802_11ofdm24);
>  		break;
>  	default:
>  		/*  TODO */
> @@ -2398,7 +2398,7 @@ unsigned int rtw_restructure_ht_ie(struct adapter *padapter, u8 *in_ie, u8 *out_
>  	/* rtw_hal_get_def_var(padapter, HW_VAR_MAX_RX_AMPDU_FACTOR, &max_rx_ampdu_factor); */
>  	ht_capie.ampdu_params_info = (max_rx_ampdu_factor&0x03);
>  
> -	if (padapter->securitypriv.dot11PrivacyAlgrthm == _AES_)
> +	if (padapter->securitypriv.dot11_privacy_algrthm == _AES_)
>  		ht_capie.ampdu_params_info |= (IEEE80211_HT_CAP_AMPDU_DENSITY&(0x07<<2));
>  	else
>  		ht_capie.ampdu_params_info |= (IEEE80211_HT_CAP_AMPDU_DENSITY&0x00);
> diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c b/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
> index f878b04076d8..084cec9b5201 100644
> --- a/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
> +++ b/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
> @@ -697,7 +697,7 @@ unsigned int OnAuth(struct adapter *padapter, union recv_frame *precv_frame)
>  
>  	sa = GetAddr2Ptr(pframe);
>  
> -	auth_mode = psecuritypriv->dot11AuthAlgrthm;
> +	auth_mode = psecuritypriv->dot11_auth_algrthm;
>  
>  	if (GetPrivacy(pframe)) {
>  		u8 *iv;
> @@ -721,8 +721,8 @@ unsigned int OnAuth(struct adapter *padapter, union recv_frame *precv_frame)
>  	seq	= le16_to_cpu(*(__le16 *)((SIZE_PTR)pframe + WLAN_HDR_A3_LEN + offset + 2));
>  
>  	if (auth_mode == 2 &&
> -			psecuritypriv->dot11PrivacyAlgrthm != _WEP40_ &&
> -			psecuritypriv->dot11PrivacyAlgrthm != _WEP104_)
> +			psecuritypriv->dot11_privacy_algrthm != _WEP40_ &&
> +			psecuritypriv->dot11_privacy_algrthm != _WEP104_)
>  		auth_mode = 0;
>  
>  	if ((algorithm > 0 && auth_mode == 0) ||	/*  rx a shared-key auth but shared not enabled */
> @@ -1425,11 +1425,11 @@ unsigned int OnAssocRsp(struct adapter *padapter, union recv_frame *precv_frame)
>  			break;
>  
>  		case WLAN_EID_HT_CAPABILITY:	/* HT caps */
> -			HT_caps_handler(padapter, pIE);
> +			ht_caps_handler(padapter, pIE);
>  			break;
>  
>  		case WLAN_EID_HT_OPERATION:	/* HT info */
> -			HT_info_handler(padapter, pIE);
> +			ht_info_handler(padapter, pIE);
>  			break;
>  
>  		case WLAN_EID_ERP_INFO:
> @@ -1447,7 +1447,7 @@ unsigned int OnAssocRsp(struct adapter *padapter, union recv_frame *precv_frame)
>  	pmlmeinfo->state |= WIFI_FW_ASSOC_SUCCESS;
>  
>  	/* Update Basic Rate Table for spec, 2010-12-28 , by thomas */
> -	UpdateBrateTbl(padapter, pmlmeinfo->network.supported_rates);
> +	update_brate_tbl(padapter, pmlmeinfo->network.supported_rates);
>  
>  report_assoc_result:
>  	if (res > 0)
> @@ -3833,10 +3833,10 @@ void site_survey(struct adapter *padapter)
>  		} else {
>  #ifdef DBG_FIXED_CHAN
>  			if (pmlmeext->fixed_chan != 0xff)
> -				SelectChannel(padapter, pmlmeext->fixed_chan);
> +				select_channel(padapter, pmlmeext->fixed_chan);
>  			else
>  #endif
> -				SelectChannel(padapter, survey_channel);
> +				select_channel(padapter, survey_channel);
>  		}
>  
>  		if (ScanType == SCAN_ACTIVE) { /* obey the channel plan setting... */
> @@ -3885,7 +3885,7 @@ void site_survey(struct adapter *padapter)
>  			/* rtw_hal_set_hwreg(padapter, HW_VAR_TXPAUSE, (u8 *)(&val8)); */
>  
>  			/* config MSR */
> -			Set_MSR(padapter, (pmlmeinfo->state & 0x3));
> +			set_msr(padapter, (pmlmeinfo->state & 0x3));
>  
>  			initialgain = 0xff; /* restore RX GAIN */
>  			rtw_hal_set_hwreg(padapter, HW_VAR_INITIAL_GAIN, (u8 *)(&initialgain));
> @@ -4001,7 +4001,7 @@ u8 collect_bss_info(struct adapter *padapter, union recv_frame *precv_frame, str
>  		memcpy(bssid->supported_rates + i, (p + 2), len);
>  	}
>  
> -	bssid->network_type_in_use = Ndis802_11OFDM24;
> +	bssid->network_type_in_use = ndis802_11ofdm24;
>  
>  	if (bssid->ie_length < 12)
>  		return _FAIL;
> @@ -4102,7 +4102,7 @@ void start_create_ibss(struct adapter *padapter)
>  
>  		/* set msr to WIFI_FW_ADHOC_STATE */
>  		pmlmeinfo->state = WIFI_FW_ADHOC_STATE;
> -		Set_MSR(padapter, (pmlmeinfo->state & 0x3));
> +		set_msr(padapter, (pmlmeinfo->state & 0x3));
>  
>  		/* issue beacon */
>  		if (send_beacon(padapter) == _FAIL) {
> @@ -4141,9 +4141,9 @@ void start_clnt_join(struct adapter *padapter)
>  	caps = rtw_get_capability((struct wlan_bssid_ex *)pnetwork);
>  	update_capinfo(padapter, caps);
>  	if (caps&WLAN_CAPABILITY_ESS) {
> -		Set_MSR(padapter, WIFI_FW_STATION_STATE);
> +		set_msr(padapter, WIFI_FW_STATION_STATE);
>  
> -		val8 = (pmlmeinfo->auth_algo == dot11AuthAlgrthm_8021X) ? 0xcc : 0xcf;
> +		val8 = (pmlmeinfo->auth_algo == dot11_auth_algrthm_8021X) ? 0xcc : 0xcf;
>  
>  		rtw_hal_set_hwreg(padapter, HW_VAR_SEC_CFG, (u8 *)(&val8));
>  
> @@ -4167,7 +4167,7 @@ void start_clnt_join(struct adapter *padapter)
>  
>  		pmlmeinfo->state = WIFI_FW_AUTH_NULL | WIFI_FW_STATION_STATE;
>  	} else if (caps&WLAN_CAPABILITY_IBSS) { /* adhoc client */
> -		Set_MSR(padapter, WIFI_FW_ADHOC_STATE);
> +		set_msr(padapter, WIFI_FW_ADHOC_STATE);
>  
>  		val8 = 0xcf;
>  		rtw_hal_set_hwreg(padapter, HW_VAR_SEC_CFG, (u8 *)(&val8));
> @@ -4783,7 +4783,7 @@ static void rtw_mlmeext_disconnect(struct adapter *padapter)
>  	rtw_hal_set_hwreg(padapter, HW_VAR_BSSID, null_addr);
>  
>  	/* set MSR to no link state -> infra. mode */
> -	Set_MSR(padapter, _HW_STATE_STATION_);
> +	set_msr(padapter, _HW_STATE_STATION_);
>  
>  	pmlmeinfo->state = WIFI_FW_NULL_STATE;
>  
> @@ -4826,7 +4826,7 @@ void mlmeext_joinbss_event_callback(struct adapter *padapter, int join_res)
>  
>  
>  	/* turn on dynamic functions */
> -	Switch_DM_Func(padapter, DYNAMIC_ALL_FUNC_ENABLE, true);
> +	switch_DM_func(padapter, DYNAMIC_ALL_FUNC_ENABLE, true);
>  
>  	/*  update IOT-related issue */
>  	update_IOT_info(padapter);
> @@ -4929,7 +4929,7 @@ void mlmeext_sta_add_event_callback(struct adapter *padapter, struct sta_info *p
>  	psta->raid = networktype_to_raid_ex(padapter, psta);
>  
>  	/* rate radaptive */
> -	Update_RA_Entry(padapter, psta);
> +	update_ra_entry(padapter, psta);
>  }
>  
>  void mlmeext_sta_del_event_callback(struct adapter *padapter)
> @@ -5230,7 +5230,7 @@ u8 setopmode_hdl(struct adapter *padapter, u8 *pbuf)
>  	if (psetop->mode == Ndis802_11APMode) {
>  		/*  Do this after port switch to */
>  		/*  prevent from downloading rsvd page to wrong port */
> -		rtw_btcoex_MediaStatusNotify(padapter, 1); /* connect */
> +		rtw_btcoex_media_status_notify(padapter, 1); /* connect */
>  	}
>  
>  	return H2C_SUCCESS;
> @@ -5266,7 +5266,7 @@ u8 createbss_hdl(struct adapter *padapter, u8 *pbuf)
>  
>  		/* disable dynamic functions, such as high power, DIG */
>  		Save_DM_Func_Flag(padapter);
> -		Switch_DM_Func(padapter, DYNAMIC_FUNC_DISABLE, false);
> +		switch_DM_func(padapter, DYNAMIC_FUNC_DISABLE, false);
>  
>  		/* config the initial gain under linking, need to write the BB registers */
>  		/* initialgain = 0x1E; */
> @@ -5321,7 +5321,7 @@ u8 join_cmd_hdl(struct adapter *padapter, u8 *pbuf)
>  
>  		/* set MSR to nolink -> infra. mode */
>  		/* Set_MSR(padapter, _HW_STATE_NOLINK_); */
> -		Set_MSR(padapter, _HW_STATE_STATION_);
> +		set_msr(padapter, _HW_STATE_STATION_);
>  
>  
>  		rtw_hal_set_hwreg(padapter, HW_VAR_MLME_DISCONNECT, NULL);
> @@ -5570,7 +5570,7 @@ u8 sitesurvey_cmd_hdl(struct adapter *padapter, u8 *pbuf)
>  	if ((pmlmeext->sitesurvey_res.state == SCAN_START) || (pmlmeext->sitesurvey_res.state == SCAN_TXNULL)) {
>  		/* disable dynamic functions, such as high power, DIG */
>  		Save_DM_Func_Flag(padapter);
> -		Switch_DM_Func(padapter, DYNAMIC_FUNC_DISABLE, false);
> +		switch_DM_func(padapter, DYNAMIC_FUNC_DISABLE, false);
>  
>  		/* config the initial gain under scanning, need to write the BB
>  		 * registers
> @@ -5580,7 +5580,7 @@ u8 sitesurvey_cmd_hdl(struct adapter *padapter, u8 *pbuf)
>  		rtw_hal_set_hwreg(padapter, HW_VAR_INITIAL_GAIN, (u8 *)(&initialgain));
>  
>  		/* set MSR to no link state */
> -		Set_MSR(padapter, _HW_STATE_NOLINK_);
> +		set_msr(padapter, _HW_STATE_NOLINK_);
>  
>  		val8 = 1; /* under site survey */
>  		rtw_hal_set_hwreg(padapter, HW_VAR_MLME_SITESURVEY, (u8 *)(&val8));
> diff --git a/drivers/staging/rtl8723bs/core/rtw_pwrctrl.c b/drivers/staging/rtl8723bs/core/rtw_pwrctrl.c
> index a392d5b4caf2..083d77200a4e 100644
> --- a/drivers/staging/rtl8723bs/core/rtw_pwrctrl.c
> +++ b/drivers/staging/rtl8723bs/core/rtw_pwrctrl.c
> @@ -333,7 +333,7 @@ static u8 PS_RDY_CHECK(struct adapter *padapter)
>  	)
>  		return false;
>  
> -	if (padapter->securitypriv.dot11AuthAlgrthm == dot11AuthAlgrthm_8021X &&
> +	if (padapter->securitypriv.dot11_auth_algrthm == dot11_auth_algrthm_8021X &&
>  	    !padapter->securitypriv.binstallGrpkey)
>  		return false;
>  
> diff --git a/drivers/staging/rtl8723bs/core/rtw_recv.c b/drivers/staging/rtl8723bs/core/rtw_recv.c
> index d8d394b67eeb..b155db4f9e38 100644
> --- a/drivers/staging/rtl8723bs/core/rtw_recv.c
> +++ b/drivers/staging/rtl8723bs/core/rtw_recv.c
> @@ -408,7 +408,7 @@ static union recv_frame *decryptor(struct adapter *padapter, union recv_frame *p
>  			case _TKIP_:
>  			case _AES_:
>  			default:
> -				prxattrib->key_index = psecuritypriv->dot118021XGrpKeyid;
> +				prxattrib->key_index = psecuritypriv->dot118021_xgrp_keyid;
>  				break;
>  			}
>  		}
> @@ -463,7 +463,7 @@ static union recv_frame *portctrl(struct adapter *adapter, union recv_frame *pre
>  
>  	pstapriv = &adapter->stapriv;
>  
> -	auth_alg = adapter->securitypriv.dot11AuthAlgrthm;
> +	auth_alg = adapter->securitypriv.dot11_auth_algrthm;
>  
>  	ptr = precv_frame->u.hdr.rx_data;
>  	pfhdr = &precv_frame->u.hdr;
> diff --git a/drivers/staging/rtl8723bs/core/rtw_security.c b/drivers/staging/rtl8723bs/core/rtw_security.c
> index ac731415f733..b0d5e713b5fe 100644
> --- a/drivers/staging/rtl8723bs/core/rtw_security.c
> +++ b/drivers/staging/rtl8723bs/core/rtw_security.c
> @@ -487,9 +487,9 @@ u32 rtw_tkip_encrypt(struct adapter *padapter, u8 *pxmitframe)
>  
>  		{
>  			if (IS_MCAST(pattrib->ra))
> -				prwskey = psecuritypriv->dot118021XGrpKey[psecuritypriv->dot118021XGrpKeyid].skey;
> +				prwskey = psecuritypriv->dot118021XGrpKey[psecuritypriv->dot118021_xgrp_keyid].skey;
>  			else
> -				prwskey = pattrib->dot118021x_UncstKey.skey;
> +				prwskey = pattrib->dot118021x_uncst_key.skey;
>  
>  			for (curfragnum = 0; curfragnum < pattrib->nr_frags; curfragnum++) {
>  				iv = pframe+pattrib->hdrlen;
> @@ -598,7 +598,7 @@ u32 rtw_tkip_decrypt(struct adapter *padapter, u8 *precvframe)
>  
>  				prwskey = psecuritypriv->dot118021XGrpKey[prxattrib->key_index].skey;
>  			} else {
> -				prwskey = &stainfo->dot118021x_UncstKey.skey[0];
> +				prwskey = &stainfo->dot118021x_uncst_key.skey[0];
>  			}
>  
>  			iv = pframe+prxattrib->hdrlen;
> @@ -1052,9 +1052,9 @@ u32 rtw_aes_encrypt(struct adapter *padapter, u8 *pxmitframe)
>  	/* 4 start to encrypt each fragment */
>  	if (pattrib->encrypt == _AES_) {
>  		if (IS_MCAST(pattrib->ra))
> -			prwskey = psecuritypriv->dot118021XGrpKey[psecuritypriv->dot118021XGrpKeyid].skey;
> +			prwskey = psecuritypriv->dot118021XGrpKey[psecuritypriv->dot118021_xgrp_keyid].skey;
>  		else
> -			prwskey = pattrib->dot118021x_UncstKey.skey;
> +			prwskey = pattrib->dot118021x_uncst_key.skey;
>  
>  		for (curfragnum = 0; curfragnum < pattrib->nr_frags; curfragnum++) {
>  			if ((curfragnum+1) == pattrib->nr_frags) {	/* 4 the last fragment */
> @@ -1349,12 +1349,12 @@ u32 rtw_aes_decrypt(struct adapter *padapter, u8 *precvframe)
>  				no_gkey_mc_cnt = 0;
>  
>  				prwskey = psecuritypriv->dot118021XGrpKey[prxattrib->key_index].skey;
> -				if (psecuritypriv->dot118021XGrpKeyid != prxattrib->key_index) {
> +				if (psecuritypriv->dot118021_xgrp_keyid != prxattrib->key_index) {
>  					res = _FAIL;
>  					goto exit;
>  				}
>  			} else {
> -				prwskey = &stainfo->dot118021x_UncstKey.skey[0];
> +				prwskey = &stainfo->dot118021x_uncst_key.skey[0];
>  			}
>  
>  			length = ((union recv_frame *)precvframe)->u.hdr.len-prxattrib->hdrlen-prxattrib->iv_len;
> @@ -1554,7 +1554,7 @@ void rtw_sec_restore_wep_key(struct adapter *adapter)
>  	struct security_priv *securitypriv = &(adapter->securitypriv);
>  	signed int keyid;
>  
> -	if ((_WEP40_ == securitypriv->dot11PrivacyAlgrthm) || (_WEP104_ == securitypriv->dot11PrivacyAlgrthm)) {
> +	if ((_WEP40_ == securitypriv->dot11_privacy_algrthm) || (_WEP104_ == securitypriv->dot11_privacy_algrthm)) {
>  		for (keyid = 0; keyid < 4; keyid++) {
>  			if (securitypriv->key_mask & BIT(keyid)) {
>  				if (keyid == securitypriv->dot11PrivacyKeyIndex)
> diff --git a/drivers/staging/rtl8723bs/core/rtw_wlan_util.c b/drivers/staging/rtl8723bs/core/rtw_wlan_util.c
> index 18ba846c0b7b..99fdf84f0a43 100644
> --- a/drivers/staging/rtl8723bs/core/rtw_wlan_util.c
> +++ b/drivers/staging/rtl8723bs/core/rtw_wlan_util.c
> @@ -182,7 +182,7 @@ void set_mcs_rate_by_mask(u8 *mcs_set, u32 mask)
>  	mcs_set[3] &= mcs_rate_4r;
>  }
>  
> -void UpdateBrateTbl(struct adapter *Adapter, u8 *mBratesOS)
> +void update_brate_tbl(struct adapter *Adapter, u8 *mBratesOS)
>  {
>  	u8 i;
>  	u8 rate;
> @@ -236,7 +236,7 @@ void Restore_DM_Func_Flag(struct adapter *padapter)
>  	rtw_hal_set_hwreg(padapter, HW_VAR_DM_FUNC_OP, (u8 *)(&bSaveFlag));
>  }
>  
> -void Switch_DM_Func(struct adapter *padapter, u32 mode, u8 enable)
> +void switch_DM_func(struct adapter *padapter, u32 mode, u8 enable)
>  {
>  	if (enable == true)
>  		rtw_hal_set_hwreg(padapter, HW_VAR_DM_FUNC_SET, (u8 *)(&mode));
> @@ -244,7 +244,7 @@ void Switch_DM_Func(struct adapter *padapter, u32 mode, u8 enable)
>  		rtw_hal_set_hwreg(padapter, HW_VAR_DM_FUNC_CLR, (u8 *)(&mode));
>  }
>  
> -void Set_MSR(struct adapter *padapter, u8 type)
> +void set_msr(struct adapter *padapter, u8 type)
>  {
>  	rtw_hal_set_hwreg(padapter, HW_VAR_MEDIA_STATUS, (u8 *)(&type));
>  }
> @@ -333,7 +333,7 @@ inline unsigned long rtw_get_on_cur_ch_time(struct adapter *adapter)
>  		return 0;
>  }
>  
> -void SelectChannel(struct adapter *padapter, unsigned char channel)
> +void select_channel(struct adapter *padapter, unsigned char channel)
>  {
>  	if (mutex_lock_interruptible(&(adapter_to_dvobj(padapter)->setch_mutex)))
>  		return;
> @@ -930,7 +930,7 @@ static void bwmode_update_check(struct adapter *padapter, struct ndis_80211_var_
>  		pmlmeext->cur_ch_offset = new_ch_offset;
>  
>  		/* update HT info also */
> -		HT_info_handler(padapter, pIE);
> +		ht_info_handler(padapter, pIE);
>  	} else {
>  		pmlmeinfo->bwmode_updated = false;
>  	}
> @@ -961,7 +961,7 @@ static void bwmode_update_check(struct adapter *padapter, struct ndis_80211_var_
>  	}
>  }
>  
> -void HT_caps_handler(struct adapter *padapter, struct ndis_80211_var_ie *pIE)
> +void ht_caps_handler(struct adapter *padapter, struct ndis_80211_var_ie *pIE)
>  {
>  	unsigned int	i;
>  	u8 max_AMPDU_len, min_MPDU_spacing;
> @@ -1031,7 +1031,7 @@ void HT_caps_handler(struct adapter *padapter, struct ndis_80211_var_ie *pIE)
>  	}
>  }
>  
> -void HT_info_handler(struct adapter *padapter, struct ndis_80211_var_ie *pIE)
> +void ht_info_handler(struct adapter *padapter, struct ndis_80211_var_ie *pIE)
>  {
>  	struct mlme_ext_priv *pmlmeext = &padapter->mlmeextpriv;
>  	struct mlme_ext_info *pmlmeinfo = &(pmlmeext->mlmext_info);
> @@ -1434,7 +1434,7 @@ unsigned char get_highest_rate_idx(u32 mask)
>  	return rate_idx;
>  }
>  
> -void Update_RA_Entry(struct adapter *padapter, struct sta_info *psta)
> +void update_ra_entry(struct adapter *padapter, struct sta_info *psta)
>  {
>  	rtw_hal_update_ra_mask(psta, 0);
>  }
> @@ -1442,7 +1442,7 @@ void Update_RA_Entry(struct adapter *padapter, struct sta_info *psta)
>  void set_sta_rate(struct adapter *padapter, struct sta_info *psta)
>  {
>  	/* rate adaptive */
> -	Update_RA_Entry(padapter, psta);
> +	update_ra_entry(padapter, psta);
>  }
>  
>  static u32 get_realtek_assoc_AP_vender(struct ndis_80211_var_ie *pIE)
> @@ -1526,13 +1526,13 @@ void update_IOT_info(struct adapter *padapter)
>  		pmlmeinfo->turboMode_cts2self = 0;
>  		pmlmeinfo->turboMode_rtsen = 1;
>  		/* disable high power */
> -		Switch_DM_Func(padapter, (~DYNAMIC_BB_DYNAMIC_TXPWR), false);
> +		switch_DM_func(padapter, (~DYNAMIC_BB_DYNAMIC_TXPWR), false);
>  		break;
>  	case HT_IOT_PEER_REALTEK:
>  		/* rtw_write16(padapter, 0x4cc, 0xffff); */
>  		/* rtw_write16(padapter, 0x546, 0x01c0); */
>  		/* disable high power */
> -		Switch_DM_Func(padapter, (~DYNAMIC_BB_DYNAMIC_TXPWR), false);
> +		switch_DM_func(padapter, (~DYNAMIC_BB_DYNAMIC_TXPWR), false);
>  		break;
>  	default:
>  		pmlmeinfo->turboMode_cts2self = 0;
> diff --git a/drivers/staging/rtl8723bs/core/rtw_xmit.c b/drivers/staging/rtl8723bs/core/rtw_xmit.c
> index a22512633d1b..d958cd266e42 100644
> --- a/drivers/staging/rtl8723bs/core/rtw_xmit.c
> +++ b/drivers/staging/rtl8723bs/core/rtw_xmit.c
> @@ -382,7 +382,7 @@ static void update_attrib_vcs_info(struct adapter *padapter, struct xmit_frame *
>  		while (true) {
>  			/* IOT action */
>  			if ((pmlmeinfo->assoc_AP_vendor == HT_IOT_PEER_ATHEROS) && (pattrib->ampdu_en == true) &&
> -				(padapter->securitypriv.dot11PrivacyAlgrthm == _AES_)) {
> +				(padapter->securitypriv.dot11_privacy_algrthm == _AES_)) {
>  				pattrib->vcs_mode = CTS_TO_SELF;
>  				break;
>  			}
> @@ -475,7 +475,7 @@ static s32 update_attrib_sec_info(struct adapter *padapter, struct pkt_attrib *p
>  	struct security_priv *psecuritypriv = &padapter->securitypriv;
>  	signed int bmcast = IS_MCAST(pattrib->ra);
>  
> -	memset(pattrib->dot118021x_UncstKey.skey,  0, 16);
> +	memset(pattrib->dot118021x_uncst_key.skey,  0, 16);
>  	memset(pattrib->dot11tkiptxmickey.skey,  0, 16);
>  	pattrib->mac_id = psta->mac_id;
>  
> @@ -489,15 +489,15 @@ static s32 update_attrib_sec_info(struct adapter *padapter, struct pkt_attrib *p
>  	} else {
>  		GET_ENCRY_ALGO(psecuritypriv, psta, pattrib->encrypt, bmcast);
>  
> -		switch (psecuritypriv->dot11AuthAlgrthm) {
> +		switch (psecuritypriv->dot11_auth_algrthm) {
>  		case dot11AuthAlgrthm_Open:
>  		case dot11AuthAlgrthm_Shared:
>  		case dot11AuthAlgrthm_Auto:
>  			pattrib->key_idx = (u8)psecuritypriv->dot11PrivacyKeyIndex;
>  			break;
> -		case dot11AuthAlgrthm_8021X:
> +		case dot11_auth_algrthm_8021X:
>  			if (bmcast)
> -				pattrib->key_idx = (u8)psecuritypriv->dot118021XGrpKeyid;
> +				pattrib->key_idx = (u8)psecuritypriv->dot118021_xgrp_keyid;
>  			else
>  				pattrib->key_idx = 0;
>  			break;
> @@ -556,7 +556,7 @@ static s32 update_attrib_sec_info(struct adapter *padapter, struct pkt_attrib *p
>  	}
>  
>  	if (pattrib->encrypt > 0)
> -		memcpy(pattrib->dot118021x_UncstKey.skey, psta->dot118021x_UncstKey.skey, 16);
> +		memcpy(pattrib->dot118021x_uncst_key.skey, psta->dot118021x_uncst_key.skey, 16);
>  
>  	if (pattrib->encrypt &&
>  		((padapter->securitypriv.sw_encrypt) || (!psecuritypriv->hw_decrypted)))
> @@ -777,10 +777,10 @@ static s32 xmitframe_addmic(struct adapter *padapter, struct xmit_frame *pxmitfr
>  			pframe = pxmitframe->buf_addr + hw_hdr_offset;
>  
>  			if (bmcst) {
> -				if (!memcmp(psecuritypriv->dot118021XGrptxmickey[psecuritypriv->dot118021XGrpKeyid].skey, null_key, 16))
> +				if (!memcmp(psecuritypriv->dot118021XGrptxmickey[psecuritypriv->dot118021_xgrp_keyid].skey, null_key, 16))
>  					return _FAIL;
>  				/* start to calculate the mic code */
> -				rtw_secmicsetkey(&micdata, psecuritypriv->dot118021XGrptxmickey[psecuritypriv->dot118021XGrpKeyid].skey);
> +				rtw_secmicsetkey(&micdata, psecuritypriv->dot118021XGrptxmickey[psecuritypriv->dot118021_xgrp_keyid].skey);
>  			} else {
>  				if (!memcmp(&pattrib->dot11tkiptxmickey.skey[0], null_key, 16))
>  					return _FAIL;
> @@ -1242,7 +1242,7 @@ s32 rtw_mgmt_xmitframe_coalesce(struct adapter *padapter, struct sk_buff *pkt, s
>  				goto xmitframe_coalesce_fail;
>  			/* before encrypt dump the management packet content */
>  			if (pattrib->encrypt > 0)
> -				memcpy(pattrib->dot118021x_UncstKey.skey, psta->dot118021x_UncstKey.skey, 16);
> +				memcpy(pattrib->dot118021x_uncst_key.skey, psta->dot118021x_uncst_key.skey, 16);
>  			/* bakeup original management packet */
>  			memcpy(tmp_buf, pframe, pattrib->pktlen);
>  			/* move to data portion */
> diff --git a/drivers/staging/rtl8723bs/hal/hal_btcoex.c b/drivers/staging/rtl8723bs/hal/hal_btcoex.c
> index 9acd49323c7c..c4945272a221 100644
> --- a/drivers/staging/rtl8723bs/hal/hal_btcoex.c
> +++ b/drivers/staging/rtl8723bs/hal/hal_btcoex.c
> @@ -326,7 +326,7 @@ static u8 halbtcoutsrc_Get(void *pBtcContext, u8 getType, void *pOutBuf)
>  		break;
>  
>  	case BTC_GET_BL_WIFI_ENABLE_ENCRYPTION:
> -		*pu8 = padapter->securitypriv.dot11PrivacyAlgrthm != 0;
> +		*pu8 = padapter->securitypriv.dot11_privacy_algrthm != 0;
>  		break;
>  
>  	case BTC_GET_BL_WIFI_UNDER_B_MODE:
> diff --git a/drivers/staging/rtl8723bs/hal/hal_com.c b/drivers/staging/rtl8723bs/hal/hal_com.c
> index 909b37bcc897..1f637e12542b 100644
> --- a/drivers/staging/rtl8723bs/hal/hal_com.c
> +++ b/drivers/staging/rtl8723bs/hal/hal_com.c
> @@ -604,7 +604,7 @@ void SetHwReg(struct adapter *adapter, u8 variable, u8 *val)
>  
>  		if (val) { /* Enable default key related setting */
>  			reg_scr |= SCR_TXBCUSEDK;
> -			if (sec->dot11AuthAlgrthm != dot11AuthAlgrthm_8021X)
> +			if (sec->dot11_auth_algrthm != dot11_auth_algrthm_8021X)
>  				reg_scr |= (SCR_RxUseDK|SCR_TxUseDK);
>  		} else /* Disable default key related setting */
>  			reg_scr &= ~(SCR_RXBCUSEDK|SCR_TXBCUSEDK|SCR_RxUseDK|SCR_TxUseDK);
> diff --git a/drivers/staging/rtl8723bs/hal/hal_intf.c b/drivers/staging/rtl8723bs/hal/hal_intf.c
> index 94ecefb9113d..137ccd5901c0 100644
> --- a/drivers/staging/rtl8723bs/hal/hal_intf.c
> +++ b/drivers/staging/rtl8723bs/hal/hal_intf.c
> @@ -272,7 +272,7 @@ void rtw_hal_update_ra_mask(struct sta_info *psta, u8 rssi_level)
>  	pmlmepriv = &(padapter->mlmepriv);
>  
>  	if (check_fwstate(pmlmepriv, WIFI_AP_STATE) == true)
> -		add_RATid(padapter, psta, rssi_level);
> +		add_rat_id(padapter, psta, rssi_level);
>  	else {
>  		if (padapter->HalFunc.UpdateRAMaskHandler)
>  			padapter->HalFunc.UpdateRAMaskHandler(padapter, psta->mac_id, rssi_level);
> diff --git a/drivers/staging/rtl8723bs/hal/rtl8723b_dm.c b/drivers/staging/rtl8723bs/hal/rtl8723b_dm.c
> index 2028791988e7..63bb555fd1dd 100644
> --- a/drivers/staging/rtl8723bs/hal/rtl8723b_dm.c
> +++ b/drivers/staging/rtl8723bs/hal/rtl8723b_dm.c
> @@ -92,7 +92,7 @@ static void Update_ODM_ComInfo_8723b(struct adapter *Adapter)
>  	ODM_CmnInfoHook(pDM_Odm, ODM_CMNINFO_RX_UNI, &(dvobj->traffic_stat.rx_bytes));
>  	ODM_CmnInfoHook(pDM_Odm, ODM_CMNINFO_WM_MODE, &(pmlmeext->cur_wireless_mode));
>  	ODM_CmnInfoHook(pDM_Odm, ODM_CMNINFO_SEC_CHNL_OFFSET, &(pHalData->nCur40MhzPrimeSC));
> -	ODM_CmnInfoHook(pDM_Odm, ODM_CMNINFO_SEC_MODE, &(Adapter->securitypriv.dot11PrivacyAlgrthm));
> +	ODM_CmnInfoHook(pDM_Odm, ODM_CMNINFO_SEC_MODE, &(Adapter->securitypriv.dot11_privacy_algrthm));
>  	ODM_CmnInfoHook(pDM_Odm, ODM_CMNINFO_BW, &(pHalData->CurrentChannelBW));
>  	ODM_CmnInfoHook(pDM_Odm, ODM_CMNINFO_CHNL, &(pHalData->CurrentChannel));
>  	ODM_CmnInfoHook(pDM_Odm, ODM_CMNINFO_NET_CLOSED, &(Adapter->net_closed));
> diff --git a/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c b/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c
> index f1fc077ed29c..6073f595a511 100644
> --- a/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c
> +++ b/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c
> @@ -2800,7 +2800,7 @@ void rtl8723b_fill_fake_txdesc(
>  	if (bDataFrame) {
>  		u32 EncAlg;
>  
> -		EncAlg = padapter->securitypriv.dot11PrivacyAlgrthm;
> +		EncAlg = padapter->securitypriv.dot11_privacy_algrthm;
>  		switch (EncAlg) {
>  		case _NO_PRIVACY_:
>  			SET_TX_DESC_SEC_TYPE_8723B(pDesc, 0x0);
> @@ -2839,7 +2839,7 @@ static void hw_var_set_opmode(struct adapter *padapter, u8 variable, u8 *val)
>  		rtw_write8(padapter, REG_BCN_CTRL, val8);
>  
>  		/*  set net_type */
> -		Set_MSR(padapter, mode);
> +		set_msr(padapter, mode);
>  
>  		if ((mode == _HW_STATE_STATION_) || (mode == _HW_STATE_NOLINK_)) {
>  			{
> diff --git a/drivers/staging/rtl8723bs/include/rtw_ap.h b/drivers/staging/rtl8723bs/include/rtw_ap.h
> index 7a735e691399..832fc234cb30 100644
> --- a/drivers/staging/rtl8723bs/include/rtw_ap.h
> +++ b/drivers/staging/rtl8723bs/include/rtw_ap.h
> @@ -11,7 +11,7 @@ void init_mlme_ap_info(struct adapter *padapter);
>  void free_mlme_ap_info(struct adapter *padapter);
>  /* void update_BCNTIM(struct adapter *padapter); */
>  void update_beacon(struct adapter *padapter, u8 ie_id, u8 *oui, u8 tx);
> -void add_RATid(struct adapter *padapter, struct sta_info *psta, u8 rssi_level);
> +void add_rat_id(struct adapter *padapter, struct sta_info *psta, u8 rssi_level);
>  void expire_timeout_chk(struct adapter *padapter);
>  void update_sta_info_apmode(struct adapter *padapter, struct sta_info *psta);
>  void start_bss_network(struct adapter *padapter);
> diff --git a/drivers/staging/rtl8723bs/include/rtw_btcoex.h b/drivers/staging/rtl8723bs/include/rtw_btcoex.h
> index 19764c80b8ba..97622c8572c3 100644
> --- a/drivers/staging/rtl8723bs/include/rtw_btcoex.h
> +++ b/drivers/staging/rtl8723bs/include/rtw_btcoex.h
> @@ -15,7 +15,7 @@
>  #define	PACKET_ARP				2
>  #define	PACKET_EAPOL			3
>  
> -void rtw_btcoex_MediaStatusNotify(struct adapter *, u8 mediaStatus);
> +void rtw_btcoex_media_status_notify(struct adapter *, u8 mediaStatus);
>  void rtw_btcoex_HaltNotify(struct adapter *);
>  
>  /*  ================================================== */
> diff --git a/drivers/staging/rtl8723bs/include/rtw_mlme.h b/drivers/staging/rtl8723bs/include/rtw_mlme.h
> index 1b343b434f4d..b476fd33e850 100644
> --- a/drivers/staging/rtl8723bs/include/rtw_mlme.h
> +++ b/drivers/staging/rtl8723bs/include/rtw_mlme.h
> @@ -74,7 +74,7 @@
>  enum {
>   dot11AuthAlgrthm_Open = 0,
>   dot11AuthAlgrthm_Shared,
> - dot11AuthAlgrthm_8021X,
> + dot11_auth_algrthm_8021X,
>   dot11AuthAlgrthm_Auto,
>   dot11AuthAlgrthm_WAPI,
>   dot11AuthAlgrthm_MaxNum
> diff --git a/drivers/staging/rtl8723bs/include/rtw_mlme_ext.h b/drivers/staging/rtl8723bs/include/rtw_mlme_ext.h
> index 89b389d4c44b..46f037cc7039 100644
> --- a/drivers/staging/rtl8723bs/include/rtw_mlme_ext.h
> +++ b/drivers/staging/rtl8723bs/include/rtw_mlme_ext.h
> @@ -473,14 +473,14 @@ u8 networktype_to_raid_ex(struct adapter *adapter, struct sta_info *psta);
>  
>  void get_rate_set(struct adapter *padapter, unsigned char *pbssrate, int *bssrate_len);
>  void set_mcs_rate_by_mask(u8 *mcs_set, u32 mask);
> -void UpdateBrateTbl(struct adapter *padapter, u8 *mBratesOS);
> +void update_brate_tbl(struct adapter *padapter, u8 *mBratesOS);
>  void UpdateBrateTblForSoftAP(u8 *bssrateset, u32 bssratelen);
>  
>  void Save_DM_Func_Flag(struct adapter *padapter);
>  void Restore_DM_Func_Flag(struct adapter *padapter);
> -void Switch_DM_Func(struct adapter *padapter, u32 mode, u8 enable);
> +void switch_DM_func(struct adapter *padapter, u32 mode, u8 enable);
>  
> -void Set_MSR(struct adapter *padapter, u8 type);
> +void set_msr(struct adapter *padapter, u8 type);
>  
>  u8 rtw_get_oper_ch(struct adapter *adapter);
>  void rtw_set_oper_ch(struct adapter *adapter, u8 ch);
> @@ -492,7 +492,7 @@ u8 rtw_get_center_ch(u8 channel, u8 chnl_bw, u8 chnl_offset);
>  unsigned long rtw_get_on_cur_ch_time(struct adapter *adapter);
>  
>  void set_channel_bwmode(struct adapter *padapter, unsigned char channel, unsigned char channel_offset, unsigned short bwmode);
> -void SelectChannel(struct adapter *padapter, unsigned char channel);
> +void select_channel(struct adapter *padapter, unsigned char channel);
>  
>  unsigned int decide_wait_for_beacon_timeout(unsigned int bcn_interval);
>  
> @@ -532,8 +532,8 @@ unsigned char check_assoc_AP(u8 *pframe, uint len);
>  int WMM_param_handler(struct adapter *padapter, struct ndis_80211_var_ie *pIE);
>  void WMMOnAssocRsp(struct adapter *padapter);
>  
> -void HT_caps_handler(struct adapter *padapter, struct ndis_80211_var_ie *pIE);
> -void HT_info_handler(struct adapter *padapter, struct ndis_80211_var_ie *pIE);
> +void ht_caps_handler(struct adapter *padapter, struct ndis_80211_var_ie *pIE);
> +void ht_info_handler(struct adapter *padapter, struct ndis_80211_var_ie *pIE);
>  void HTOnAssocRsp(struct adapter *padapter);
>  
>  void ERP_IE_handler(struct adapter *padapter, struct ndis_80211_var_ie *pIE);
> @@ -550,7 +550,7 @@ int update_sta_support_rate(struct adapter *padapter, u8 *pvar_ie, uint var_ie_l
>  
>  /* for sta/adhoc mode */
>  void update_sta_info(struct adapter *padapter, struct sta_info *psta);
> -void Update_RA_Entry(struct adapter *padapter, struct sta_info *psta);
> +void update_ra_entry(struct adapter *padapter, struct sta_info *psta);
>  void set_sta_rate(struct adapter *padapter, struct sta_info *psta);
>  
>  unsigned int receive_disconnect(struct adapter *padapter, unsigned char *MacAddr, unsigned short reason);
> diff --git a/drivers/staging/rtl8723bs/include/rtw_security.h b/drivers/staging/rtl8723bs/include/rtw_security.h
> index a68b73858462..409fa03d01d1 100644
> --- a/drivers/staging/rtl8723bs/include/rtw_security.h
> +++ b/drivers/staging/rtl8723bs/include/rtw_security.h
> @@ -96,8 +96,8 @@ struct rt_pmkid_list {
>  
>  
>  struct security_priv {
> -	u32   dot11AuthAlgrthm;		/*  802.11 auth, could be open, shared, 8021x and authswitch */
> -	u32   dot11PrivacyAlgrthm;	/*  This specify the privacy for shared auth. algorithm. */
> +	u32   dot11_auth_algrthm;		/*  802.11 auth, could be open, shared, 8021x and authswitch */
> +	u32   dot11_privacy_algrthm;	/*  This specify the privacy for shared auth. algorithm. */
>  
>  	/* WEP */
>  	u32   dot11PrivacyKeyIndex;	/*  this is only valid for legendary wep, 0~3 for key id. (tx key index) */
> @@ -106,7 +106,7 @@ struct security_priv {
>  	u8 key_mask; /* use to restore wep key after hal_init */
>  
>  	u32 dot118021XGrpPrivacy;	/*  This specify the privacy algthm. used for Grp key */
> -	u32 dot118021XGrpKeyid;		/*  key id used for Grp Key (tx key index) */
> +	u32 dot118021_xgrp_keyid;		/*  key id used for Grp Key (tx key index) */
>  	union Keytype	dot118021XGrpKey[BIP_MAX_KEYID];	/*  802.1x Group Key, for inx0 and inx1 */
>  	union Keytype	dot118021XGrptxmickey[BIP_MAX_KEYID];
>  	union Keytype	dot118021XGrprxmickey[BIP_MAX_KEYID];
> @@ -175,21 +175,21 @@ struct security_priv {
>  
>  #define GET_ENCRY_ALGO(psecuritypriv, psta, encry_algo, bmcst)\
>  do {\
> -	switch (psecuritypriv->dot11AuthAlgrthm)\
> +	switch (psecuritypriv->dot11_auth_algrthm)\
>  	{\
>  		case dot11AuthAlgrthm_Open:\
>  		case dot11AuthAlgrthm_Shared:\
>  		case dot11AuthAlgrthm_Auto:\
> -			encry_algo = (u8)psecuritypriv->dot11PrivacyAlgrthm;\
> +			encry_algo = (u8)psecuritypriv->dot11_privacy_algrthm;\
>  			break;\
> -		case dot11AuthAlgrthm_8021X:\
> +		case dot11_auth_algrthm_8021X:\
>  			if (bmcst)\
>  				encry_algo = (u8)psecuritypriv->dot118021XGrpPrivacy;\
>  			else\
> -				encry_algo = (u8)psta->dot118021XPrivacy;\
> +				encry_algo = (u8)psta->dot118021_xprivacy;\
>  			break;\
>  	     case dot11AuthAlgrthm_WAPI:\
> -		     encry_algo = (u8)psecuritypriv->dot11PrivacyAlgrthm;\
> +		     encry_algo = (u8)psecuritypriv->dot11_privacy_algrthm;\
>  		     break;\
>  	} \
>  } while (0)
> diff --git a/drivers/staging/rtl8723bs/include/rtw_xmit.h b/drivers/staging/rtl8723bs/include/rtw_xmit.h
> index 676ead0372fa..78e22d78b5d5 100644
> --- a/drivers/staging/rtl8723bs/include/rtw_xmit.h
> +++ b/drivers/staging/rtl8723bs/include/rtw_xmit.h
> @@ -182,7 +182,7 @@ struct pkt_attrib {
>  	u8 cts2self;
>  	union Keytype	dot11tkiptxmickey;
>  	/* union Keytype	dot11tkiprxmickey; */
> -	union Keytype	dot118021x_UncstKey;
> +	union Keytype	dot118021x_uncst_key;
>  
>  	u8 icmp_pkt;
>  
> diff --git a/drivers/staging/rtl8723bs/include/sta_info.h b/drivers/staging/rtl8723bs/include/sta_info.h
> index 69c377eeeaf0..4612487c6604 100644
> --- a/drivers/staging/rtl8723bs/include/sta_info.h
> +++ b/drivers/staging/rtl8723bs/include/sta_info.h
> @@ -87,10 +87,10 @@ struct sta_info {
>  	u8 hwaddr[ETH_ALEN];
>  
>  	uint	ieee8021x_blocked;	/* 0: allowed, 1:blocked */
> -	uint	dot118021XPrivacy; /* aes, tkip... */
> +	uint	dot118021_xprivacy; /* aes, tkip... */
>  	union Keytype	dot11tkiptxmickey;
>  	union Keytype	dot11tkiprxmickey;
> -	union Keytype	dot118021x_UncstKey;
> +	union Keytype	dot118021x_uncst_key;
>  	union pn48		dot11txpn;			/*  PN48 used for Unicast xmit */
>  	union pn48		dot11wtxpn;			/*  PN48 used for Unicast mgmt xmit. */
>  	union pn48		dot11rxpn;			/*  PN48 used for Unicast recv. */
> diff --git a/drivers/staging/rtl8723bs/include/wlan_bssdef.h b/drivers/staging/rtl8723bs/include/wlan_bssdef.h
> index eb38594c8f5c..5b4a908974ae 100644
> --- a/drivers/staging/rtl8723bs/include/wlan_bssdef.h
> +++ b/drivers/staging/rtl8723bs/include/wlan_bssdef.h
> @@ -26,9 +26,9 @@ struct ndis_802_11_ssid {
>  
>  enum ndis_802_11_network_type {
>  	Ndis802_11FH,
> -	Ndis802_11DS,
> +	ndis802_11ds,
>  	Ndis802_11OFDM5,
> -	Ndis802_11OFDM24,
> +	ndis802_11ofdm24,
>  	Ndis802_11NetworkTypeMax    /*  not a real type, defined as an upper bound */
>  };
>  
> @@ -48,7 +48,7 @@ enum ndis_802_11_network_infrastructure {
>  	Ndis802_11Infrastructure,
>  	Ndis802_11AutoUnknown,
>  	Ndis802_11InfrastructureMax,     /*  Not a real value, defined as upper bound */
> -	Ndis802_11APMode,
> +	ndis802_11_ap_mode,
>  };
>  
>  struct ndis_802_11_fix_ie {
> @@ -73,7 +73,7 @@ struct ndis_80211_var_ie {
>   * define a macro to present the partial sum.
>   */
>  enum ndis_802_11_authentication_mode {
> -	Ndis802_11AuthModeOpen,
> +	ndis802_11auth_mode_open,
>  	Ndis802_11AuthModeShared,
>  	Ndis802_11AuthModeAutoSwitch,
>  	Ndis802_11AuthModeWPA,
> @@ -86,8 +86,8 @@ enum ndis_802_11_authentication_mode {
>  enum {
>  	Ndis802_11WEPEnabled,
>  	Ndis802_11Encryption1Enabled = Ndis802_11WEPEnabled,
> -	Ndis802_11WEPDisabled,
> -	Ndis802_11EncryptionDisabled = Ndis802_11WEPDisabled,
> +	ndis802_11wep_disabled,
> +	Ndis802_11EncryptionDisabled = ndis802_11wep_disabled,
>  	Ndis802_11WEPKeyAbsent,
>  	Ndis802_11Encryption1KeyAbsent = Ndis802_11WEPKeyAbsent,
>  	Ndis802_11WEPNotSupported,
> diff --git a/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c b/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
> index cb6d287f580d..9690b1c479ce 100644
> --- a/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
> +++ b/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
> @@ -549,13 +549,13 @@ static int rtw_cfg80211_ap_set_encryption(struct net_device *dev, struct ieee_pa
>  		if (psecuritypriv->bWepDefaultKeyIdxSet == 0) {
>  			/* wep default key has not been set, so use this key index as default key. */
>  
> -			psecuritypriv->dot11AuthAlgrthm = dot11AuthAlgrthm_Auto;
> +			psecuritypriv->dot11_auth_algrthm = dot11AuthAlgrthm_Auto;
>  			psecuritypriv->ndisencryptstatus = Ndis802_11Encryption1Enabled;
> -			psecuritypriv->dot11PrivacyAlgrthm = _WEP40_;
> +			psecuritypriv->dot11_privacy_algrthm = _WEP40_;
>  			psecuritypriv->dot118021XGrpPrivacy = _WEP40_;
>  
>  			if (wep_key_len == 13) {
> -				psecuritypriv->dot11PrivacyAlgrthm = _WEP104_;
> +				psecuritypriv->dot11_privacy_algrthm = _WEP104_;
>  				psecuritypriv->dot118021XGrpPrivacy = _WEP104_;
>  			}
>  
> @@ -603,18 +603,18 @@ static int rtw_cfg80211_ap_set_encryption(struct net_device *dev, struct ieee_pa
>  				psecuritypriv->dot118021XGrpPrivacy = _NO_PRIVACY_;
>  			}
>  
> -			psecuritypriv->dot118021XGrpKeyid = param->u.crypt.idx;
> +			psecuritypriv->dot118021_xgrp_keyid = param->u.crypt.idx;
>  
>  			psecuritypriv->binstallGrpkey = true;
>  
> -			psecuritypriv->dot11PrivacyAlgrthm = psecuritypriv->dot118021XGrpPrivacy;/*  */
> +			psecuritypriv->dot11_privacy_algrthm = psecuritypriv->dot118021XGrpPrivacy;/*  */
>  
>  			rtw_ap_set_group_key(padapter, param->u.crypt.key, psecuritypriv->dot118021XGrpPrivacy, param->u.crypt.idx);
>  
>  			pbcmc_sta = rtw_get_bcmc_stainfo(padapter);
>  			if (pbcmc_sta) {
>  				pbcmc_sta->ieee8021x_blocked = false;
> -				pbcmc_sta->dot118021XPrivacy = psecuritypriv->dot118021XGrpPrivacy;/* rx will use bmc_sta's dot118021XPrivacy */
> +				pbcmc_sta->dot118021_xprivacy = psecuritypriv->dot118021XGrpPrivacy;/* rx will use bmc_sta's dot118021XPrivacy */
>  			}
>  
>  		}
> @@ -623,17 +623,17 @@ static int rtw_cfg80211_ap_set_encryption(struct net_device *dev, struct ieee_pa
>  
>  	}
>  
> -	if (psecuritypriv->dot11AuthAlgrthm == dot11AuthAlgrthm_8021X && psta) { /*  psk/802_1x */
> +	if (psecuritypriv->dot11_auth_algrthm == dot11_auth_algrthm_8021X && psta) { /*  psk/802_1x */
>  		if (check_fwstate(pmlmepriv, WIFI_AP_STATE)) {
>  			if (param->u.crypt.set_tx == 1) { /* pairwise key */
> -				memcpy(psta->dot118021x_UncstKey.skey, param->u.crypt.key, (param->u.crypt.key_len > 16 ? 16 : param->u.crypt.key_len));
> +				memcpy(psta->dot118021x_uncst_key.skey, param->u.crypt.key, (param->u.crypt.key_len > 16 ? 16 : param->u.crypt.key_len));
>  
>  				if (strcmp(param->u.crypt.alg, "WEP") == 0) {
> -					psta->dot118021XPrivacy = _WEP40_;
> +					psta->dot118021_xprivacy = _WEP40_;
>  					if (param->u.crypt.key_len == 13)
> -						psta->dot118021XPrivacy = _WEP104_;
> +						psta->dot118021_xprivacy = _WEP104_;
>  				} else if (strcmp(param->u.crypt.alg, "TKIP") == 0) {
> -					psta->dot118021XPrivacy = _TKIP_;
> +					psta->dot118021_xprivacy = _TKIP_;
>  
>  					/* DEBUG_ERR("set key length :param->u.crypt.key_len =%d\n", param->u.crypt.key_len); */
>  					/* set mic key */
> @@ -644,9 +644,9 @@ static int rtw_cfg80211_ap_set_encryption(struct net_device *dev, struct ieee_pa
>  
>  				} else if (strcmp(param->u.crypt.alg, "CCMP") == 0) {
>  
> -					psta->dot118021XPrivacy = _AES_;
> +					psta->dot118021_xprivacy = _AES_;
>  				} else {
> -					psta->dot118021XPrivacy = _NO_PRIVACY_;
> +					psta->dot118021_xprivacy = _NO_PRIVACY_;
>  				}
>  
>  				rtw_ap_set_pairwise_key(padapter, psta);
> @@ -682,18 +682,18 @@ static int rtw_cfg80211_ap_set_encryption(struct net_device *dev, struct ieee_pa
>  					psecuritypriv->dot118021XGrpPrivacy = _NO_PRIVACY_;
>  				}
>  
> -				psecuritypriv->dot118021XGrpKeyid = param->u.crypt.idx;
> +				psecuritypriv->dot118021_xgrp_keyid = param->u.crypt.idx;
>  
>  				psecuritypriv->binstallGrpkey = true;
>  
> -				psecuritypriv->dot11PrivacyAlgrthm = psecuritypriv->dot118021XGrpPrivacy;/*  */
> +				psecuritypriv->dot11_privacy_algrthm = psecuritypriv->dot118021XGrpPrivacy;/*  */
>  
>  				rtw_ap_set_group_key(padapter, param->u.crypt.key, psecuritypriv->dot118021XGrpPrivacy, param->u.crypt.idx);
>  
>  				pbcmc_sta = rtw_get_bcmc_stainfo(padapter);
>  				if (pbcmc_sta) {
>  					pbcmc_sta->ieee8021x_blocked = false;
> -					pbcmc_sta->dot118021XPrivacy = psecuritypriv->dot118021XGrpPrivacy;/* rx will use bmc_sta's dot118021XPrivacy */
> +					pbcmc_sta->dot118021_xprivacy = psecuritypriv->dot118021XGrpPrivacy;/* rx will use bmc_sta's dot118021XPrivacy */
>  				}
>  
>  			}
> @@ -754,11 +754,11 @@ static int rtw_cfg80211_set_encryption(struct net_device *dev, struct ieee_param
>  			wep_key_len = wep_key_len <= 5 ? 5 : 13;
>  
>  			psecuritypriv->ndisencryptstatus = Ndis802_11Encryption1Enabled;
> -			psecuritypriv->dot11PrivacyAlgrthm = _WEP40_;
> +			psecuritypriv->dot11_privacy_algrthm = _WEP40_;
>  			psecuritypriv->dot118021XGrpPrivacy = _WEP40_;
>  
>  			if (wep_key_len == 13) {
> -				psecuritypriv->dot11PrivacyAlgrthm = _WEP104_;
> +				psecuritypriv->dot11_privacy_algrthm = _WEP104_;
>  				psecuritypriv->dot118021XGrpPrivacy = _WEP104_;
>  			}
>  
> @@ -774,7 +774,7 @@ static int rtw_cfg80211_set_encryption(struct net_device *dev, struct ieee_param
>  		goto exit;
>  	}
>  
> -	if (padapter->securitypriv.dot11AuthAlgrthm == dot11AuthAlgrthm_8021X) { /*  802_1x */
> +	if (padapter->securitypriv.dot11_auth_algrthm == dot11_auth_algrthm_8021X) { /*  802_1x */
>  		struct sta_info *psta, *pbcmc_sta;
>  		struct sta_priv *pstapriv = &padapter->stapriv;
>  
> @@ -788,12 +788,12 @@ static int rtw_cfg80211_set_encryption(struct net_device *dev, struct ieee_param
>  
>  				if ((padapter->securitypriv.ndisencryptstatus == Ndis802_11Encryption2Enabled) ||
>  						(padapter->securitypriv.ndisencryptstatus ==  Ndis802_11Encryption3Enabled)) {
> -					psta->dot118021XPrivacy = padapter->securitypriv.dot11PrivacyAlgrthm;
> +					psta->dot118021_xprivacy = padapter->securitypriv.dot11_privacy_algrthm;
>  				}
>  
>  				if (param->u.crypt.set_tx == 1) { /* pairwise key */
>  
> -					memcpy(psta->dot118021x_UncstKey.skey, param->u.crypt.key, (param->u.crypt.key_len > 16 ? 16 : param->u.crypt.key_len));
> +					memcpy(psta->dot118021x_uncst_key.skey, param->u.crypt.key, (param->u.crypt.key_len > 16 ? 16 : param->u.crypt.key_len));
>  
>  					if (strcmp(param->u.crypt.alg, "TKIP") == 0) { /* set mic key */
>  						/* DEBUG_ERR(("\nset key length :param->u.crypt.key_len =%d\n", param->u.crypt.key_len)); */
> @@ -812,7 +812,7 @@ static int rtw_cfg80211_set_encryption(struct net_device *dev, struct ieee_param
>  						memcpy(padapter->securitypriv.dot118021XGrprxmickey[param->u.crypt.idx].skey, &(param->u.crypt.key[24]), 8);
>  	                                        padapter->securitypriv.binstallGrpkey = true;
>  
> -						padapter->securitypriv.dot118021XGrpKeyid = param->u.crypt.idx;
> +						padapter->securitypriv.dot118021_xgrp_keyid = param->u.crypt.idx;
>  						rtw_set_key(padapter, &padapter->securitypriv, param->u.crypt.idx, 1, true);
>  					} else if (strcmp(param->u.crypt.alg, "BIP") == 0) {
>  						/* save the IGTK key, length 16 bytes */
> @@ -837,7 +837,7 @@ static int rtw_cfg80211_set_encryption(struct net_device *dev, struct ieee_param
>  
>  				if ((padapter->securitypriv.ndisencryptstatus == Ndis802_11Encryption2Enabled) ||
>  						(padapter->securitypriv.ndisencryptstatus ==  Ndis802_11Encryption3Enabled)) {
> -					pbcmc_sta->dot118021XPrivacy = padapter->securitypriv.dot11PrivacyAlgrthm;
> +					pbcmc_sta->dot118021_xprivacy = padapter->securitypriv.dot11_privacy_algrthm;
>  				}
>  			}
>  		} else if (check_fwstate(pmlmepriv, WIFI_ADHOC_STATE)) { /* adhoc mode */
> @@ -962,15 +962,15 @@ static int cfg80211_rtw_set_default_key(struct wiphy *wiphy,
>  	struct adapter *padapter = rtw_netdev_priv(ndev);
>  	struct security_priv *psecuritypriv = &padapter->securitypriv;
>  
> -	if ((key_index < WEP_KEYS) && ((psecuritypriv->dot11PrivacyAlgrthm == _WEP40_) || (psecuritypriv->dot11PrivacyAlgrthm == _WEP104_))) { /* set wep default key */
> +	if ((key_index < WEP_KEYS) && ((psecuritypriv->dot11_privacy_algrthm == _WEP40_) || (psecuritypriv->dot11_privacy_algrthm == _WEP104_))) { /* set wep default key */
>  		psecuritypriv->ndisencryptstatus = Ndis802_11Encryption1Enabled;
>  
>  		psecuritypriv->dot11PrivacyKeyIndex = key_index;
>  
> -		psecuritypriv->dot11PrivacyAlgrthm = _WEP40_;
> +		psecuritypriv->dot11_privacy_algrthm = _WEP40_;
>  		psecuritypriv->dot118021XGrpPrivacy = _WEP40_;
>  		if (psecuritypriv->dot11DefKeylen[key_index] == 13) {
> -			psecuritypriv->dot11PrivacyAlgrthm = _WEP104_;
> +			psecuritypriv->dot11_privacy_algrthm = _WEP104_;
>  			psecuritypriv->dot118021XGrpPrivacy = _WEP104_;
>  		}
>  
> @@ -1333,7 +1333,7 @@ static int cfg80211_rtw_set_wiphy_params(struct wiphy *wiphy, u32 changed)
>  static int rtw_cfg80211_set_wpa_version(struct security_priv *psecuritypriv, u32 wpa_version)
>  {
>  	if (!wpa_version) {
> -		psecuritypriv->ndisauthtype = Ndis802_11AuthModeOpen;
> +		psecuritypriv->ndisauthtype = ndis802_11auth_mode_open;
>  		return 0;
>  	}
>  
> @@ -1351,27 +1351,27 @@ static int rtw_cfg80211_set_auth_type(struct security_priv *psecuritypriv,
>  	switch (sme_auth_type) {
>  	case NL80211_AUTHTYPE_AUTOMATIC:
>  
> -		psecuritypriv->dot11AuthAlgrthm = dot11AuthAlgrthm_Auto;
> +		psecuritypriv->dot11_auth_algrthm = dot11AuthAlgrthm_Auto;
>  
>  		break;
>  	case NL80211_AUTHTYPE_OPEN_SYSTEM:
>  
> -		psecuritypriv->dot11AuthAlgrthm = dot11AuthAlgrthm_Open;
> +		psecuritypriv->dot11_auth_algrthm = dot11AuthAlgrthm_Open;
>  
>  		if (psecuritypriv->ndisauthtype > Ndis802_11AuthModeWPA)
> -			psecuritypriv->dot11AuthAlgrthm = dot11AuthAlgrthm_8021X;
> +			psecuritypriv->dot11_auth_algrthm = dot11_auth_algrthm_8021X;
>  
>  		break;
>  	case NL80211_AUTHTYPE_SHARED_KEY:
>  
> -		psecuritypriv->dot11AuthAlgrthm = dot11AuthAlgrthm_Shared;
> +		psecuritypriv->dot11_auth_algrthm = dot11AuthAlgrthm_Shared;
>  
>  		psecuritypriv->ndisencryptstatus = Ndis802_11Encryption1Enabled;
>  
>  
>  		break;
>  	default:
> -		psecuritypriv->dot11AuthAlgrthm = dot11AuthAlgrthm_Open;
> +		psecuritypriv->dot11_auth_algrthm = dot11AuthAlgrthm_Open;
>  		/* return -ENOTSUPP; */
>  	}
>  
> @@ -1383,7 +1383,7 @@ static int rtw_cfg80211_set_cipher(struct security_priv *psecuritypriv, u32 ciph
>  {
>  	u32 ndisencryptstatus = Ndis802_11EncryptionDisabled;
>  
> -	u32 *profile_cipher = ucast ? &psecuritypriv->dot11PrivacyAlgrthm :
> +	u32 *profile_cipher = ucast ? &psecuritypriv->dot11_privacy_algrthm :
>  		&psecuritypriv->dot118021XGrpPrivacy;
>  
>  
> @@ -1432,9 +1432,9 @@ static int rtw_cfg80211_set_key_mgt(struct security_priv *psecuritypriv, u32 key
>  {
>  	if (key_mgt == WLAN_AKM_SUITE_8021X)
>  		/* auth_type = UMAC_AUTH_TYPE_8021X; */
> -		psecuritypriv->dot11AuthAlgrthm = dot11AuthAlgrthm_8021X;
> +		psecuritypriv->dot11_auth_algrthm = dot11_auth_algrthm_8021X;
>  	else if (key_mgt == WLAN_AKM_SUITE_PSK) {
> -		psecuritypriv->dot11AuthAlgrthm = dot11AuthAlgrthm_8021X;
> +		psecuritypriv->dot11_auth_algrthm = dot11_auth_algrthm_8021X;
>  	}
>  
>  	return 0;
> @@ -1477,7 +1477,7 @@ static int rtw_cfg80211_set_wpa_ie(struct adapter *padapter, u8 *pie, size_t iel
>  	pwpa = rtw_get_wpa_ie(buf, &wpa_ielen, ielen);
>  	if (pwpa && wpa_ielen > 0) {
>  		if (rtw_parse_wpa_ie(pwpa, wpa_ielen+2, &group_cipher, &pairwise_cipher, NULL) == _SUCCESS) {
> -			padapter->securitypriv.dot11AuthAlgrthm = dot11AuthAlgrthm_8021X;
> +			padapter->securitypriv.dot11_auth_algrthm = dot11_auth_algrthm_8021X;
>  			padapter->securitypriv.ndisauthtype = Ndis802_11AuthModeWPAPSK;
>  			memcpy(padapter->securitypriv.supplicant_ie, &pwpa[0], wpa_ielen+2);
>  		}
> @@ -1486,7 +1486,7 @@ static int rtw_cfg80211_set_wpa_ie(struct adapter *padapter, u8 *pie, size_t iel
>  	pwpa2 = rtw_get_wpa2_ie(buf, &wpa2_ielen, ielen);
>  	if (pwpa2 && wpa2_ielen > 0) {
>  		if (rtw_parse_wpa2_ie(pwpa2, wpa2_ielen+2, &group_cipher, &pairwise_cipher, NULL) == _SUCCESS) {
> -			padapter->securitypriv.dot11AuthAlgrthm = dot11AuthAlgrthm_8021X;
> +			padapter->securitypriv.dot11_auth_algrthm = dot11_auth_algrthm_8021X;
>  			padapter->securitypriv.ndisauthtype = Ndis802_11AuthModeWPA2PSK;
>  			memcpy(padapter->securitypriv.supplicant_ie, &pwpa2[0], wpa2_ielen+2);
>  		}
> @@ -1523,23 +1523,23 @@ static int rtw_cfg80211_set_wpa_ie(struct adapter *padapter, u8 *pie, size_t iel
>  
>  	switch (pairwise_cipher) {
>  		case WPA_CIPHER_NONE:
> -			padapter->securitypriv.dot11PrivacyAlgrthm = _NO_PRIVACY_;
> +			padapter->securitypriv.dot11_privacy_algrthm = _NO_PRIVACY_;
>  			padapter->securitypriv.ndisencryptstatus = Ndis802_11EncryptionDisabled;
>  			break;
>  		case WPA_CIPHER_WEP40:
> -			padapter->securitypriv.dot11PrivacyAlgrthm = _WEP40_;
> +			padapter->securitypriv.dot11_privacy_algrthm = _WEP40_;
>  			padapter->securitypriv.ndisencryptstatus = Ndis802_11Encryption1Enabled;
>  			break;
>  		case WPA_CIPHER_TKIP:
> -			padapter->securitypriv.dot11PrivacyAlgrthm = _TKIP_;
> +			padapter->securitypriv.dot11_privacy_algrthm = _TKIP_;
>  			padapter->securitypriv.ndisencryptstatus = Ndis802_11Encryption2Enabled;
>  			break;
>  		case WPA_CIPHER_CCMP:
> -			padapter->securitypriv.dot11PrivacyAlgrthm = _AES_;
> +			padapter->securitypriv.dot11_privacy_algrthm = _AES_;
>  			padapter->securitypriv.ndisencryptstatus = Ndis802_11Encryption3Enabled;
>  			break;
>  		case WPA_CIPHER_WEP104:
> -			padapter->securitypriv.dot11PrivacyAlgrthm = _WEP104_;
> +			padapter->securitypriv.dot11_privacy_algrthm = _WEP104_;
>  			padapter->securitypriv.ndisencryptstatus = Ndis802_11Encryption1Enabled;
>  			break;
>  	}
> @@ -1559,9 +1559,9 @@ static int rtw_cfg80211_set_wpa_ie(struct adapter *padapter, u8 *pie, size_t iel
>  	}
>  
>  	/* TKIP and AES disallow multicast packets until installing group key */
> -	if (padapter->securitypriv.dot11PrivacyAlgrthm == _TKIP_
> -		|| padapter->securitypriv.dot11PrivacyAlgrthm == _TKIP_WTMIC_
> -		|| padapter->securitypriv.dot11PrivacyAlgrthm == _AES_)
> +	if (padapter->securitypriv.dot11_privacy_algrthm == _TKIP_
> +		|| padapter->securitypriv.dot11_privacy_algrthm == _TKIP_WTMIC_
> +		|| padapter->securitypriv.dot11_privacy_algrthm == _AES_)
>  		/* WPS open need to enable multicast */
>  		/*  check_fwstate(&padapter->mlmepriv, WIFI_UNDER_WPS) == true) */
>  		rtw_hal_set_hwreg(padapter, HW_VAR_OFF_RCR_AM, null_addr);
> @@ -1608,10 +1608,10 @@ static int cfg80211_rtw_join_ibss(struct wiphy *wiphy, struct net_device *ndev,
>  	memcpy(ndis_ssid.ssid, (u8 *)params->ssid, params->ssid_len);
>  
>  	psecuritypriv->ndisencryptstatus = Ndis802_11EncryptionDisabled;
> -	psecuritypriv->dot11PrivacyAlgrthm = _NO_PRIVACY_;
> +	psecuritypriv->dot11_privacy_algrthm = _NO_PRIVACY_;
>  	psecuritypriv->dot118021XGrpPrivacy = _NO_PRIVACY_;
> -	psecuritypriv->dot11AuthAlgrthm = dot11AuthAlgrthm_Open; /* open system */
> -	psecuritypriv->ndisauthtype = Ndis802_11AuthModeOpen;
> +	psecuritypriv->dot11_auth_algrthm = dot11AuthAlgrthm_Open; /* open system */
> +	psecuritypriv->ndisauthtype = ndis802_11auth_mode_open;
>  
>  	ret = rtw_cfg80211_set_auth_type(psecuritypriv, NL80211_AUTHTYPE_OPEN_SYSTEM);
>  	rtw_set_802_11_authentication_mode(padapter, psecuritypriv->ndisauthtype);
> @@ -1706,10 +1706,10 @@ static int cfg80211_rtw_connect(struct wiphy *wiphy, struct net_device *ndev,
>  		rtw_scan_abort(padapter);
>  
>  	psecuritypriv->ndisencryptstatus = Ndis802_11EncryptionDisabled;
> -	psecuritypriv->dot11PrivacyAlgrthm = _NO_PRIVACY_;
> +	psecuritypriv->dot11_privacy_algrthm = _NO_PRIVACY_;
>  	psecuritypriv->dot118021XGrpPrivacy = _NO_PRIVACY_;
> -	psecuritypriv->dot11AuthAlgrthm = dot11AuthAlgrthm_Open; /* open system */
> -	psecuritypriv->ndisauthtype = Ndis802_11AuthModeOpen;
> +	psecuritypriv->dot11_auth_algrthm = dot11AuthAlgrthm_Open; /* open system */
> +	psecuritypriv->ndisauthtype = ndis802_11auth_mode_open;
>  
>  	ret = rtw_cfg80211_set_wpa_version(psecuritypriv, sme->crypto.wpa_versions);
>  	if (ret < 0)
> @@ -1731,8 +1731,8 @@ static int cfg80211_rtw_connect(struct wiphy *wiphy, struct net_device *ndev,
>  	}
>  
>  	/* For WEP Shared auth */
> -	if ((psecuritypriv->dot11AuthAlgrthm == dot11AuthAlgrthm_Shared ||
> -	    psecuritypriv->dot11AuthAlgrthm == dot11AuthAlgrthm_Auto) && sme->key) {
> +	if ((psecuritypriv->dot11_auth_algrthm == dot11AuthAlgrthm_Shared ||
> +	    psecuritypriv->dot11_auth_algrthm == dot11AuthAlgrthm_Auto) && sme->key) {
>  		u32 wep_key_idx, wep_key_len, wep_total_len;
>  		struct ndis_802_11_wep	 *pwep = NULL;
>  
> @@ -1759,7 +1759,7 @@ static int cfg80211_rtw_connect(struct wiphy *wiphy, struct net_device *ndev,
>  			pwep->length = wep_total_len;
>  
>  			if (wep_key_len == 13) {
> -				padapter->securitypriv.dot11PrivacyAlgrthm = _WEP104_;
> +				padapter->securitypriv.dot11_privacy_algrthm = _WEP104_;
>  				padapter->securitypriv.dot118021XGrpPrivacy = _WEP104_;
>  			}
>  		} else {
> diff --git a/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c b/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c
> index 30374a820496..cb12372b1bb9 100644
> --- a/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c
> +++ b/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c
> @@ -23,17 +23,17 @@ static int wpa_set_auth_algs(struct net_device *dev, u32 value)
>  	if ((value & IW_AUTH_ALG_SHARED_KEY) && (value & IW_AUTH_ALG_OPEN_SYSTEM)) {
>  		padapter->securitypriv.ndisencryptstatus = Ndis802_11Encryption1Enabled;
>  		padapter->securitypriv.ndisauthtype = Ndis802_11AuthModeAutoSwitch;
> -		padapter->securitypriv.dot11AuthAlgrthm = dot11AuthAlgrthm_Auto;
> +		padapter->securitypriv.dot11_auth_algrthm = dot11AuthAlgrthm_Auto;
>  	} else if (value & IW_AUTH_ALG_SHARED_KEY)	{
>  		padapter->securitypriv.ndisencryptstatus = Ndis802_11Encryption1Enabled;
>  
>  		padapter->securitypriv.ndisauthtype = Ndis802_11AuthModeShared;
> -		padapter->securitypriv.dot11AuthAlgrthm = dot11AuthAlgrthm_Shared;
> +		padapter->securitypriv.dot11_auth_algrthm = dot11AuthAlgrthm_Shared;
>  	} else if (value & IW_AUTH_ALG_OPEN_SYSTEM) {
>  		/* padapter->securitypriv.ndisencryptstatus = Ndis802_11EncryptionDisabled; */
>  		if (padapter->securitypriv.ndisauthtype < Ndis802_11AuthModeWPAPSK) {
> -			padapter->securitypriv.ndisauthtype = Ndis802_11AuthModeOpen;
> -			padapter->securitypriv.dot11AuthAlgrthm = dot11AuthAlgrthm_Open;
> +			padapter->securitypriv.ndisauthtype = ndis802_11auth_mode_open;
> +			padapter->securitypriv.dot11_auth_algrthm = dot11AuthAlgrthm_Open;
>  		}
>  	} else {
>  		ret = -EINVAL;
> @@ -78,7 +78,7 @@ static int wpa_set_encryption(struct net_device *dev, struct ieee_param *param,
>  	if (strcmp(param->u.crypt.alg, "WEP") == 0) {
>  
>  		padapter->securitypriv.ndisencryptstatus = Ndis802_11Encryption1Enabled;
> -		padapter->securitypriv.dot11PrivacyAlgrthm = _WEP40_;
> +		padapter->securitypriv.dot11_privacy_algrthm = _WEP40_;
>  		padapter->securitypriv.dot118021XGrpPrivacy = _WEP40_;
>  
>  		wep_key_idx = param->u.crypt.idx;
> @@ -101,7 +101,7 @@ static int wpa_set_encryption(struct net_device *dev, struct ieee_param *param,
>  			pwep->length = wep_total_len;
>  
>  			if (wep_key_len == 13) {
> -				padapter->securitypriv.dot11PrivacyAlgrthm = _WEP104_;
> +				padapter->securitypriv.dot11_privacy_algrthm = _WEP104_;
>  				padapter->securitypriv.dot118021XGrpPrivacy = _WEP104_;
>  			}
>  		} else {
> @@ -118,7 +118,7 @@ static int wpa_set_encryption(struct net_device *dev, struct ieee_param *param,
>  			if (rtw_set_802_11_add_wep(padapter, pwep) == (u8)_FAIL)
>  				ret = -EOPNOTSUPP;
>  		} else {
> -			/* don't update "psecuritypriv->dot11PrivacyAlgrthm" and */
> +			/* don't update "psecuritypriv->dot11_privacy_algrthm" and */
>  			/* psecuritypriv->dot11PrivacyKeyIndex =keyid", but can rtw_set_key to fw/cam */
>  
>  			if (wep_key_idx >= WEP_KEYS) {
> @@ -134,7 +134,7 @@ static int wpa_set_encryption(struct net_device *dev, struct ieee_param *param,
>  		goto exit;
>  	}
>  
> -	if (padapter->securitypriv.dot11AuthAlgrthm == dot11AuthAlgrthm_8021X) { /*  802_1x */
> +	if (padapter->securitypriv.dot11_auth_algrthm == dot11_auth_algrthm_8021X) { /*  802_1x */
>  		struct sta_info *psta, *pbcmc_sta;
>  		struct sta_priv *pstapriv = &padapter->stapriv;
>  
> @@ -149,11 +149,11 @@ static int wpa_set_encryption(struct net_device *dev, struct ieee_param *param,
>  
>  				if ((padapter->securitypriv.ndisencryptstatus == Ndis802_11Encryption2Enabled) ||
>  						(padapter->securitypriv.ndisencryptstatus ==  Ndis802_11Encryption3Enabled)) {
> -					psta->dot118021XPrivacy = padapter->securitypriv.dot11PrivacyAlgrthm;
> +					psta->dot118021_xprivacy = padapter->securitypriv.dot11_privacy_algrthm;
>  				}
>  
>  				if (param->u.crypt.set_tx == 1) { /* pairwise key */
> -					memcpy(psta->dot118021x_UncstKey.skey, param->u.crypt.key, (param->u.crypt.key_len > 16 ? 16 : param->u.crypt.key_len));
> +					memcpy(psta->dot118021x_uncst_key.skey, param->u.crypt.key, (param->u.crypt.key_len > 16 ? 16 : param->u.crypt.key_len));
>  
>  					if (strcmp(param->u.crypt.alg, "TKIP") == 0) { /* set mic key */
>  						/* DEBUG_ERR(("\nset key length :param->u.crypt.key_len =%d\n", param->u.crypt.key_len)); */
> @@ -175,7 +175,7 @@ static int wpa_set_encryption(struct net_device *dev, struct ieee_param *param,
>  						}
>  						padapter->securitypriv.binstallGrpkey = true;
>  
> -						padapter->securitypriv.dot118021XGrpKeyid = param->u.crypt.idx;
> +						padapter->securitypriv.dot118021_xgrp_keyid = param->u.crypt.idx;
>  
>  						rtw_set_key(padapter, &padapter->securitypriv, param->u.crypt.idx, 1, true);
>  					} else if (strcmp(param->u.crypt.alg, "BIP") == 0) {
> @@ -202,7 +202,7 @@ static int wpa_set_encryption(struct net_device *dev, struct ieee_param *param,
>  
>  				if ((padapter->securitypriv.ndisencryptstatus == Ndis802_11Encryption2Enabled) ||
>  						(padapter->securitypriv.ndisencryptstatus ==  Ndis802_11Encryption3Enabled)) {
> -					pbcmc_sta->dot118021XPrivacy = padapter->securitypriv.dot11PrivacyAlgrthm;
> +					pbcmc_sta->dot118021_xprivacy = padapter->securitypriv.dot11_privacy_algrthm;
>  				}
>  			}
>  		} else if (check_fwstate(pmlmepriv, WIFI_ADHOC_STATE)) {
> @@ -246,13 +246,13 @@ static int rtw_set_wpa_ie(struct adapter *padapter, char *pie, unsigned short ie
>  		}
>  
>  		if (rtw_parse_wpa_ie(buf, ielen, &group_cipher, &pairwise_cipher, NULL) == _SUCCESS) {
> -			padapter->securitypriv.dot11AuthAlgrthm = dot11AuthAlgrthm_8021X;
> +			padapter->securitypriv.dot11_auth_algrthm = dot11_auth_algrthm_8021X;
>  			padapter->securitypriv.ndisauthtype = Ndis802_11AuthModeWPAPSK;
>  			memcpy(padapter->securitypriv.supplicant_ie, &buf[0], ielen);
>  		}
>  
>  		if (rtw_parse_wpa2_ie(buf, ielen, &group_cipher, &pairwise_cipher, NULL) == _SUCCESS) {
> -			padapter->securitypriv.dot11AuthAlgrthm = dot11AuthAlgrthm_8021X;
> +			padapter->securitypriv.dot11_auth_algrthm = dot11_auth_algrthm_8021X;
>  			padapter->securitypriv.ndisauthtype = Ndis802_11AuthModeWPA2PSK;
>  			memcpy(padapter->securitypriv.supplicant_ie, &buf[0], ielen);
>  		}
> @@ -287,23 +287,23 @@ static int rtw_set_wpa_ie(struct adapter *padapter, char *pie, unsigned short ie
>  
>  		switch (pairwise_cipher) {
>  		case WPA_CIPHER_NONE:
> -			padapter->securitypriv.dot11PrivacyAlgrthm = _NO_PRIVACY_;
> +			padapter->securitypriv.dot11_privacy_algrthm = _NO_PRIVACY_;
>  			padapter->securitypriv.ndisencryptstatus = Ndis802_11EncryptionDisabled;
>  			break;
>  		case WPA_CIPHER_WEP40:
> -			padapter->securitypriv.dot11PrivacyAlgrthm = _WEP40_;
> +			padapter->securitypriv.dot11_privacy_algrthm = _WEP40_;
>  			padapter->securitypriv.ndisencryptstatus = Ndis802_11Encryption1Enabled;
>  			break;
>  		case WPA_CIPHER_TKIP:
> -			padapter->securitypriv.dot11PrivacyAlgrthm = _TKIP_;
> +			padapter->securitypriv.dot11_privacy_algrthm = _TKIP_;
>  			padapter->securitypriv.ndisencryptstatus = Ndis802_11Encryption2Enabled;
>  			break;
>  		case WPA_CIPHER_CCMP:
> -			padapter->securitypriv.dot11PrivacyAlgrthm = _AES_;
> +			padapter->securitypriv.dot11_privacy_algrthm = _AES_;
>  			padapter->securitypriv.ndisencryptstatus = Ndis802_11Encryption3Enabled;
>  			break;
>  		case WPA_CIPHER_WEP104:
> -			padapter->securitypriv.dot11PrivacyAlgrthm = _WEP104_;
> +			padapter->securitypriv.dot11_privacy_algrthm = _WEP104_;
>  			padapter->securitypriv.ndisencryptstatus = Ndis802_11Encryption1Enabled;
>  			break;
>  		}
> @@ -334,9 +334,9 @@ static int rtw_set_wpa_ie(struct adapter *padapter, char *pie, unsigned short ie
>  	}
>  
>  	/* TKIP and AES disallow multicast packets until installing group key */
> -	if (padapter->securitypriv.dot11PrivacyAlgrthm == _TKIP_ ||
> -		padapter->securitypriv.dot11PrivacyAlgrthm == _TKIP_WTMIC_ ||
> -		padapter->securitypriv.dot11PrivacyAlgrthm == _AES_)
> +	if (padapter->securitypriv.dot11_privacy_algrthm == _TKIP_ ||
> +		padapter->securitypriv.dot11_privacy_algrthm == _TKIP_WTMIC_ ||
> +		padapter->securitypriv.dot11_privacy_algrthm == _AES_)
>  		/* WPS open need to enable multicast */
>  		/*  check_fwstate(&padapter->mlmepriv, WIFI_UNDER_WPS) == true) */
>  		rtw_hal_set_hwreg(padapter, HW_VAR_OFF_RCR_AM, null_addr);
> @@ -356,7 +356,7 @@ static int wpa_set_param(struct net_device *dev, u8 name, u32 value)
>  	switch (name) {
>  	case IEEE_PARAM_WPA_ENABLED:
>  
> -		padapter->securitypriv.dot11AuthAlgrthm = dot11AuthAlgrthm_8021X; /* 802.1x */
> +		padapter->securitypriv.dot11_auth_algrthm = dot11_auth_algrthm_8021X; /* 802.1x */
>  
>  		/* ret = ieee80211_wpa_enable(ieee, value); */
>  
> @@ -561,9 +561,9 @@ static int rtw_set_encryption(struct net_device *dev, struct ieee_param *param,
>  	if (strcmp(param->u.crypt.alg, "none") == 0 && !psta) {
>  		/* todo:clear default encryption keys */
>  
> -		psecuritypriv->dot11AuthAlgrthm = dot11AuthAlgrthm_Open;
> +		psecuritypriv->dot11_auth_algrthm = dot11AuthAlgrthm_Open;
>  		psecuritypriv->ndisencryptstatus = Ndis802_11EncryptionDisabled;
> -		psecuritypriv->dot11PrivacyAlgrthm = _NO_PRIVACY_;
> +		psecuritypriv->dot11_privacy_algrthm = _NO_PRIVACY_;
>  		psecuritypriv->dot118021XGrpPrivacy = _NO_PRIVACY_;
>  
>  		goto exit;
> @@ -598,13 +598,13 @@ static int rtw_set_encryption(struct net_device *dev, struct ieee_param *param,
>  		memcpy(pwep->key_material,  param->u.crypt.key, pwep->key_length);
>  
>  		if (param->u.crypt.set_tx) {
> -			psecuritypriv->dot11AuthAlgrthm = dot11AuthAlgrthm_Auto;
> +			psecuritypriv->dot11_auth_algrthm = dot11AuthAlgrthm_Auto;
>  			psecuritypriv->ndisencryptstatus = Ndis802_11Encryption1Enabled;
> -			psecuritypriv->dot11PrivacyAlgrthm = _WEP40_;
> +			psecuritypriv->dot11_privacy_algrthm = _WEP40_;
>  			psecuritypriv->dot118021XGrpPrivacy = _WEP40_;
>  
>  			if (pwep->key_length == 13) {
> -				psecuritypriv->dot11PrivacyAlgrthm = _WEP104_;
> +				psecuritypriv->dot11_privacy_algrthm = _WEP104_;
>  				psecuritypriv->dot118021XGrpPrivacy = _WEP104_;
>  			}
>  
> @@ -617,7 +617,7 @@ static int rtw_set_encryption(struct net_device *dev, struct ieee_param *param,
>  
>  			rtw_ap_set_wep_key(padapter, pwep->key_material, pwep->key_length, wep_key_idx, 1);
>  		} else {
> -			/* don't update "psecuritypriv->dot11PrivacyAlgrthm" and */
> +			/* don't update "psecuritypriv->dot11_privacy_algrthm" and */
>  			/* psecuritypriv->dot11PrivacyKeyIndex =keyid", but can rtw_set_key to cam */
>  
>  			memcpy(&(psecuritypriv->dot11DefKey[wep_key_idx].skey[0]), pwep->key_material, pwep->key_length);
> @@ -662,18 +662,18 @@ static int rtw_set_encryption(struct net_device *dev, struct ieee_param *param,
>  				psecuritypriv->dot118021XGrpPrivacy = _NO_PRIVACY_;
>  			}
>  
> -			psecuritypriv->dot118021XGrpKeyid = param->u.crypt.idx;
> +			psecuritypriv->dot118021_xgrp_keyid = param->u.crypt.idx;
>  
>  			psecuritypriv->binstallGrpkey = true;
>  
> -			psecuritypriv->dot11PrivacyAlgrthm = psecuritypriv->dot118021XGrpPrivacy;/*  */
> +			psecuritypriv->dot11_privacy_algrthm = psecuritypriv->dot118021XGrpPrivacy;/*  */
>  
>  			rtw_ap_set_group_key(padapter, param->u.crypt.key, psecuritypriv->dot118021XGrpPrivacy, param->u.crypt.idx);
>  
>  			pbcmc_sta = rtw_get_bcmc_stainfo(padapter);
>  			if (pbcmc_sta) {
>  				pbcmc_sta->ieee8021x_blocked = false;
> -				pbcmc_sta->dot118021XPrivacy = psecuritypriv->dot118021XGrpPrivacy;/* rx will use bmc_sta's dot118021XPrivacy */
> +				pbcmc_sta->dot118021_xprivacy = psecuritypriv->dot118021XGrpPrivacy;/* rx will use bmc_sta's dot118021_xprivacy */
>  			}
>  		}
>  
> @@ -681,17 +681,17 @@ static int rtw_set_encryption(struct net_device *dev, struct ieee_param *param,
>  
>  	}
>  
> -	if (psecuritypriv->dot11AuthAlgrthm == dot11AuthAlgrthm_8021X && psta) { /*  psk/802_1x */
> +	if (psecuritypriv->dot11_auth_algrthm == dot11_auth_algrthm_8021X && psta) { /*  psk/802_1x */
>  		if (check_fwstate(pmlmepriv, WIFI_AP_STATE)) {
>  			if (param->u.crypt.set_tx == 1)	{
> -				memcpy(psta->dot118021x_UncstKey.skey, param->u.crypt.key, (param->u.crypt.key_len > 16 ? 16 : param->u.crypt.key_len));
> +				memcpy(psta->dot118021x_uncst_key.skey, param->u.crypt.key, (param->u.crypt.key_len > 16 ? 16 : param->u.crypt.key_len));
>  
>  				if (strcmp(param->u.crypt.alg, "WEP") == 0) {
> -					psta->dot118021XPrivacy = _WEP40_;
> +					psta->dot118021_xprivacy = _WEP40_;
>  					if (param->u.crypt.key_len == 13)
> -						psta->dot118021XPrivacy = _WEP104_;
> +						psta->dot118021_xprivacy = _WEP104_;
>  				} else if (strcmp(param->u.crypt.alg, "TKIP") == 0) {
> -					psta->dot118021XPrivacy = _TKIP_;
> +					psta->dot118021_xprivacy = _TKIP_;
>  
>  					/* DEBUG_ERR("set key length :param->u.crypt.key_len =%d\n", param->u.crypt.key_len); */
>  					/* set mic key */
> @@ -702,9 +702,9 @@ static int rtw_set_encryption(struct net_device *dev, struct ieee_param *param,
>  
>  				} else if (strcmp(param->u.crypt.alg, "CCMP") == 0) {
>  
> -					psta->dot118021XPrivacy = _AES_;
> +					psta->dot118021_xprivacy = _AES_;
>  				} else {
> -					psta->dot118021XPrivacy = _NO_PRIVACY_;
> +					psta->dot118021_xprivacy = _NO_PRIVACY_;
>  				}
>  
>  				rtw_ap_set_pairwise_key(padapter, psta);
> @@ -738,18 +738,18 @@ static int rtw_set_encryption(struct net_device *dev, struct ieee_param *param,
>  					psecuritypriv->dot118021XGrpPrivacy = _NO_PRIVACY_;
>  				}
>  
> -				psecuritypriv->dot118021XGrpKeyid = param->u.crypt.idx;
> +				psecuritypriv->dot118021_xgrp_keyid = param->u.crypt.idx;
>  
>  				psecuritypriv->binstallGrpkey = true;
>  
> -				psecuritypriv->dot11PrivacyAlgrthm = psecuritypriv->dot118021XGrpPrivacy;/*  */
> +				psecuritypriv->dot11_privacy_algrthm = psecuritypriv->dot118021XGrpPrivacy;/*  */
>  
>  				rtw_ap_set_group_key(padapter, param->u.crypt.key, psecuritypriv->dot118021XGrpPrivacy, param->u.crypt.idx);
>  
>  				pbcmc_sta = rtw_get_bcmc_stainfo(padapter);
>  				if (pbcmc_sta) {
>  					pbcmc_sta->ieee8021x_blocked = false;
> -					pbcmc_sta->dot118021XPrivacy = psecuritypriv->dot118021XGrpPrivacy;/* rx will use bmc_sta's dot118021XPrivacy */
> +					pbcmc_sta->dot118021_xprivacy = psecuritypriv->dot118021XGrpPrivacy;/* rx will use bmc_sta's dot118021_xprivacy */
>  				}
>  			}
>  		}
> diff --git a/drivers/staging/rtl8723bs/os_dep/mlme_linux.c b/drivers/staging/rtl8723bs/os_dep/mlme_linux.c
> index 1341801e5c21..2cfb5e6481b6 100644
> --- a/drivers/staging/rtl8723bs/os_dep/mlme_linux.c
> +++ b/drivers/staging/rtl8723bs/os_dep/mlme_linux.c
> @@ -70,7 +70,7 @@ void rtw_reset_securitypriv(struct adapter *adapter)
>  
>  	spin_lock_bh(&adapter->security_key_mutex);
>  
> -	if (adapter->securitypriv.dot11AuthAlgrthm == dot11AuthAlgrthm_8021X) {
> +	if (adapter->securitypriv.dot11_auth_algrthm == dot11_auth_algrthm_8021X) {
>  		/* 802.1x */
>  		/*  Added by Albert 2009/02/18 */
>  		/*  We have to backup the PMK information for WiFi PMK Caching test item. */
> @@ -95,8 +95,8 @@ void rtw_reset_securitypriv(struct adapter *adapter)
>  		adapter->securitypriv.btkip_countermeasure = backupTKIPCountermeasure;
>  		adapter->securitypriv.btkip_countermeasure_time = backupTKIPcountermeasure_time;
>  
> -		adapter->securitypriv.ndisauthtype = Ndis802_11AuthModeOpen;
> -		adapter->securitypriv.ndisencryptstatus = Ndis802_11WEPDisabled;
> +		adapter->securitypriv.ndisauthtype = ndis802_11auth_mode_open;
> +		adapter->securitypriv.ndisencryptstatus = ndis802_11wep_disabled;
>  
>  	} else {
>  		/* reset values in securitypriv */
> @@ -104,15 +104,15 @@ void rtw_reset_securitypriv(struct adapter *adapter)
>  		/*  */
>  		struct security_priv *psec_priv = &adapter->securitypriv;
>  
> -		psec_priv->dot11AuthAlgrthm = dot11AuthAlgrthm_Open;  /* open system */
> -		psec_priv->dot11PrivacyAlgrthm = _NO_PRIVACY_;
> +		psec_priv->dot11_auth_algrthm = dot11AuthAlgrthm_Open;  /* open system */
> +		psec_priv->dot11_privacy_algrthm = _NO_PRIVACY_;
>  		psec_priv->dot11PrivacyKeyIndex = 0;
>  
>  		psec_priv->dot118021XGrpPrivacy = _NO_PRIVACY_;
> -		psec_priv->dot118021XGrpKeyid = 1;
> +		psec_priv->dot118021_xgrp_keyid = 1;
>  
> -		psec_priv->ndisauthtype = Ndis802_11AuthModeOpen;
> -		psec_priv->ndisencryptstatus = Ndis802_11WEPDisabled;
> +		psec_priv->ndisauthtype = ndis802_11auth_mode_open;
> +		psec_priv->ndisencryptstatus = ndis802_11wep_disabled;
>  		/*  */
>  	}
>  	/*  add for CONFIG_IEEE80211W, none 11w also can use */
> diff --git a/drivers/staging/rtl8723bs/os_dep/os_intfs.c b/drivers/staging/rtl8723bs/os_dep/os_intfs.c
> index 380d8c9e1239..6c316d896798 100644
> --- a/drivers/staging/rtl8723bs/os_dep/os_intfs.c
> +++ b/drivers/staging/rtl8723bs/os_dep/os_intfs.c
> @@ -558,16 +558,16 @@ static void rtw_init_default_value(struct adapter *padapter)
>  	psecuritypriv->sw_encrypt = pregistrypriv->software_encrypt;
>  	psecuritypriv->sw_decrypt = pregistrypriv->software_decrypt;
>  
> -	psecuritypriv->dot11AuthAlgrthm = dot11AuthAlgrthm_Open; /* open system */
> -	psecuritypriv->dot11PrivacyAlgrthm = _NO_PRIVACY_;
> +	psecuritypriv->dot11_auth_algrthm = dot11AuthAlgrthm_Open; /* open system */
> +	psecuritypriv->dot11_privacy_algrthm = _NO_PRIVACY_;
>  
>  	psecuritypriv->dot11PrivacyKeyIndex = 0;
>  
>  	psecuritypriv->dot118021XGrpPrivacy = _NO_PRIVACY_;
> -	psecuritypriv->dot118021XGrpKeyid = 1;
> +	psecuritypriv->dot118021_xgrp_keyid = 1;
>  
> -	psecuritypriv->ndisauthtype = Ndis802_11AuthModeOpen;
> -	psecuritypriv->ndisencryptstatus = Ndis802_11WEPDisabled;
> +	psecuritypriv->ndisauthtype = ndis802_11auth_mode_open;
> +	psecuritypriv->ndisencryptstatus = ndis802_11wep_disabled;
>  
>  	/* registry_priv */
>  	rtw_init_registrypriv_dev_network(padapter);

