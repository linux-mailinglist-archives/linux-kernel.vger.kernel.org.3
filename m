Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 451FC501F4A
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 01:45:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347760AbiDNXqW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 19:46:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230191AbiDNXqT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 19:46:19 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBC67B53D0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 16:43:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649979832; x=1681515832;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=0IUhWj+DA/vCGWmzK8INQH8Jud0K/gNfGVfy/BfNSHA=;
  b=Zw11r+nYhA6yTaH1avcclPEw0Oq7AZdbowLM/4oV85YrsZ0qboXUIjHQ
   82ZRThatbniTG1LH6W3XuH4JzbLNG3m3zkaSXPeYAsIibhLaxDrnRPPFF
   e6XlnFy7U5fOgfqMwMe6B1WsrXA/5/FrHgTyRcc0SiCzbsUCi2Tn3e5Kg
   x7w+O4r5MQlhvT7zUA+gJZHBWlUzaojdcR7TmwmH0xt5AlQtSb428aY2U
   4nCKHUcH5PdzVHHrRShJSraF6eLKx3WzXreuNiStp06agEI0DtdwgjnKT
   5lY+l+P9/hPW51ZszqigaV/YVFUWKQFMXkTy6ty1b8rZUPzBgPcfBk0q3
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10317"; a="243640838"
X-IronPort-AV: E=Sophos;i="5.90,261,1643702400"; 
   d="scan'208";a="243640838"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2022 16:43:52 -0700
X-IronPort-AV: E=Sophos;i="5.90,261,1643702400"; 
   d="scan'208";a="591371274"
Received: from aimeehax-mobl1.amr.corp.intel.com (HELO localhost) ([10.212.113.132])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2022 16:43:51 -0700
Date:   Thu, 14 Apr 2022 16:43:51 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Rebecca Mckeever <remckee0@gmail.com>
Cc:     outreachy@lists.linux.dev,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/4] staging: r8188eu: use sizeof(*pvar) for allocating
 structs
Message-ID: <Ylixt2gxhcmDJq11@iweiny-desk3>
References: <cover.1649233201.git.remckee0@gmail.com>
 <5b526d8c178d89328de935ff4ff57651bdd8379b.1649233201.git.remckee0@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5b526d8c178d89328de935ff4ff57651bdd8379b.1649233201.git.remckee0@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 06, 2022 at 03:31:00AM -0500, Rebecca Mckeever wrote:
> Use sizeof(*pvar) instead of sizeof(struct var) when allocating memory.
> This conforms to Linux kernel coding style, improves readability,
> and decreases the opportunity for bugs if the pointer variable type is
> changed. Issue found by checkpatch messages of the following format:
> 
> CHECK: Prefer kzalloc(sizeof(*pvar)...) over kzalloc(sizeof(struct var)...)
> 
> Signed-off-by: Rebecca Mckeever <remckee0@gmail.com>

Reviewed-by: Ira Weiny <ira.weiny@intel.com>

> ---
>  drivers/staging/r8188eu/core/rtw_cmd.c | 68 +++++++++++++-------------
>  1 file changed, 34 insertions(+), 34 deletions(-)
> 
> diff --git a/drivers/staging/r8188eu/core/rtw_cmd.c b/drivers/staging/r8188eu/core/rtw_cmd.c
> index f4a277e6b654..110959148648 100644
> --- a/drivers/staging/r8188eu/core/rtw_cmd.c
> +++ b/drivers/staging/r8188eu/core/rtw_cmd.c
> @@ -334,11 +334,11 @@ u8 rtw_sitesurvey_cmd(struct adapter  *padapter, struct ndis_802_11_ssid *ssid,
>  	if (check_fwstate(pmlmepriv, _FW_LINKED))
>  		p2p_ps_wk_cmd(padapter, P2P_PS_SCAN, 1);
>  
> -	ph2c = kzalloc(sizeof(struct cmd_obj), GFP_ATOMIC);
> +	ph2c = kzalloc(sizeof(*ph2c), GFP_ATOMIC);
>  	if (!ph2c)
>  		return _FAIL;
>  
> -	psurveyPara = kzalloc(sizeof(struct sitesurvey_parm), GFP_ATOMIC);
> +	psurveyPara = kzalloc(sizeof(*psurveyPara), GFP_ATOMIC);
>  	if (!psurveyPara) {
>  		kfree(ph2c);
>  		return _FAIL;
> @@ -399,13 +399,13 @@ u8 rtw_setdatarate_cmd(struct adapter *padapter, u8 *rateset)
>  	struct cmd_priv *pcmdpriv = &padapter->cmdpriv;
>  	u8	res = _SUCCESS;
>  
> -	ph2c = kzalloc(sizeof(struct cmd_obj), GFP_ATOMIC);
> +	ph2c = kzalloc(sizeof(*ph2c), GFP_ATOMIC);
>  	if (!ph2c) {
>  		res = _FAIL;
>  		goto exit;
>  	}
>  
> -	pbsetdataratepara = kzalloc(sizeof(struct setdatarate_parm), GFP_ATOMIC);
> +	pbsetdataratepara = kzalloc(sizeof(*pbsetdataratepara), GFP_ATOMIC);
>  	if (!pbsetdataratepara) {
>  		kfree(ph2c);
>  		res = _FAIL;
> @@ -438,7 +438,7 @@ u8 rtw_createbss_cmd(struct adapter  *padapter)
>  
>  	rtw_led_control(padapter, LED_CTL_START_TO_LINK);
>  
> -	pcmd = kzalloc(sizeof(struct cmd_obj), GFP_ATOMIC);
> +	pcmd = kzalloc(sizeof(*pcmd), GFP_ATOMIC);
>  	if (!pcmd) {
>  		res = _FAIL;
>  		goto exit;
> @@ -475,7 +475,7 @@ u8 rtw_joinbss_cmd(struct adapter  *padapter, struct wlan_network *pnetwork)
>  
>  	rtw_led_control(padapter, LED_CTL_START_TO_LINK);
>  
> -	pcmd = kzalloc(sizeof(struct cmd_obj), GFP_ATOMIC);
> +	pcmd = kzalloc(sizeof(*pcmd), GFP_ATOMIC);
>  	if (!pcmd) {
>  		res = _FAIL;
>  		goto exit;
> @@ -624,12 +624,12 @@ u8 rtw_setopmode_cmd(struct adapter  *padapter, enum ndis_802_11_network_infra n
>  	struct	cmd_priv   *pcmdpriv = &padapter->cmdpriv;
>  	u8	res = _SUCCESS;
>  
> -	ph2c = kzalloc(sizeof(struct cmd_obj), GFP_KERNEL);
> +	ph2c = kzalloc(sizeof(*ph2c), GFP_KERNEL);
>  	if (!ph2c) {
>  		res = false;
>  		goto exit;
>  	}
> -	psetop = kzalloc(sizeof(struct setopmode_parm), GFP_KERNEL);
> +	psetop = kzalloc(sizeof(*psetop), GFP_KERNEL);
>  
>  	if (!psetop) {
>  		kfree(ph2c);
> @@ -659,20 +659,20 @@ u8 rtw_setstakey_cmd(struct adapter *padapter, u8 *psta, u8 unicast_key)
>  	struct sta_info *sta = (struct sta_info *)psta;
>  	u8	res = _SUCCESS;
>  
> -	ph2c = kzalloc(sizeof(struct cmd_obj), GFP_KERNEL);
> +	ph2c = kzalloc(sizeof(*ph2c), GFP_KERNEL);
>  	if (!ph2c) {
>  		res = _FAIL;
>  		goto exit;
>  	}
>  
> -	psetstakey_para = kzalloc(sizeof(struct set_stakey_parm), GFP_KERNEL);
> +	psetstakey_para = kzalloc(sizeof(*psetstakey_para), GFP_KERNEL);
>  	if (!psetstakey_para) {
>  		kfree(ph2c);
>  		res = _FAIL;
>  		goto exit;
>  	}
>  
> -	psetstakey_rsp = kzalloc(sizeof(struct set_stakey_rsp), GFP_KERNEL);
> +	psetstakey_rsp = kzalloc(sizeof(*psetstakey_rsp), GFP_KERNEL);
>  	if (!psetstakey_rsp) {
>  		kfree(ph2c);
>  		kfree(psetstakey_para);
> @@ -718,13 +718,13 @@ u8 rtw_clearstakey_cmd(struct adapter *padapter, u8 *psta, u8 entry, u8 enqueue)
>  	if (!enqueue) {
>  		clear_cam_entry(padapter, entry);
>  	} else {
> -		ph2c = kzalloc(sizeof(struct cmd_obj), GFP_ATOMIC);
> +		ph2c = kzalloc(sizeof(*ph2c), GFP_ATOMIC);
>  		if (!ph2c) {
>  			res = _FAIL;
>  			goto exit;
>  		}
>  
> -		psetstakey_para = kzalloc(sizeof(struct set_stakey_parm),
> +		psetstakey_para = kzalloc(sizeof(*psetstakey_para),
>  					  GFP_ATOMIC);
>  		if (!psetstakey_para) {
>  			kfree(ph2c);
> @@ -732,7 +732,7 @@ u8 rtw_clearstakey_cmd(struct adapter *padapter, u8 *psta, u8 entry, u8 enqueue)
>  			goto exit;
>  		}
>  
> -		psetstakey_rsp = kzalloc(sizeof(struct set_stakey_rsp),
> +		psetstakey_rsp = kzalloc(sizeof(*psetstakey_rsp),
>  					 GFP_ATOMIC);
>  		if (!psetstakey_rsp) {
>  			kfree(ph2c);
> @@ -765,13 +765,13 @@ u8 rtw_addbareq_cmd(struct adapter *padapter, u8 tid, u8 *addr)
>  	struct addBaReq_parm *paddbareq_parm;
>  	u8	res = _SUCCESS;
>  
> -	ph2c = kzalloc(sizeof(struct cmd_obj), GFP_ATOMIC);
> +	ph2c = kzalloc(sizeof(*ph2c), GFP_ATOMIC);
>  	if (!ph2c) {
>  		res = _FAIL;
>  		goto exit;
>  	}
>  
> -	paddbareq_parm = kzalloc(sizeof(struct addBaReq_parm), GFP_ATOMIC);
> +	paddbareq_parm = kzalloc(sizeof(*paddbareq_parm), GFP_ATOMIC);
>  	if (!paddbareq_parm) {
>  		kfree(ph2c);
>  		res = _FAIL;
> @@ -798,13 +798,13 @@ u8 rtw_dynamic_chk_wk_cmd(struct adapter *padapter)
>  	struct cmd_priv	*pcmdpriv = &padapter->cmdpriv;
>  	u8	res = _SUCCESS;
>  
> -	ph2c = kzalloc(sizeof(struct cmd_obj), GFP_ATOMIC);
> +	ph2c = kzalloc(sizeof(*ph2c), GFP_ATOMIC);
>  	if (!ph2c) {
>  		res = _FAIL;
>  		goto exit;
>  	}
>  
> -	pdrvextra_cmd_parm = kzalloc(sizeof(struct drvextra_cmd_parm), GFP_ATOMIC);
> +	pdrvextra_cmd_parm = kzalloc(sizeof(*pdrvextra_cmd_parm), GFP_ATOMIC);
>  	if (!pdrvextra_cmd_parm) {
>  		kfree(ph2c);
>  		res = _FAIL;
> @@ -839,7 +839,7 @@ u8 rtw_set_chplan_cmd(struct adapter *padapter, u8 chplan)
>  	}
>  
>  	/* prepare cmd parameter */
> -	setChannelPlan_param = kzalloc(sizeof(struct SetChannelPlan_param),
> +	setChannelPlan_param = kzalloc(sizeof(*setChannelPlan_param),
>  				       GFP_KERNEL);
>  	if (!setChannelPlan_param) {
>  		res = _FAIL;
> @@ -848,7 +848,7 @@ u8 rtw_set_chplan_cmd(struct adapter *padapter, u8 chplan)
>  	setChannelPlan_param->channel_plan = chplan;
>  
>  	/* need enqueue, prepare cmd_obj and enqueue */
> -	pcmdobj = kzalloc(sizeof(struct	cmd_obj), GFP_KERNEL);
> +	pcmdobj = kzalloc(sizeof(*pcmdobj), GFP_KERNEL);
>  	if (!pcmdobj) {
>  		kfree(setChannelPlan_param);
>  		res = _FAIL;
> @@ -1010,13 +1010,13 @@ u8 rtw_lps_ctrl_wk_cmd(struct adapter *padapter, u8 lps_ctrl_type, u8 enqueue)
>  	/*	return res; */
>  
>  	if (enqueue) {
> -		ph2c = kzalloc(sizeof(struct cmd_obj), GFP_ATOMIC);
> +		ph2c = kzalloc(sizeof(*ph2c), GFP_ATOMIC);
>  		if (!ph2c) {
>  			res = _FAIL;
>  			goto exit;
>  		}
>  
> -		pdrvextra_cmd_parm = kzalloc(sizeof(struct drvextra_cmd_parm),
> +		pdrvextra_cmd_parm = kzalloc(sizeof(*pdrvextra_cmd_parm),
>  					     GFP_ATOMIC);
>  		if (!pdrvextra_cmd_parm) {
>  			kfree(ph2c);
> @@ -1056,13 +1056,13 @@ u8 rtw_rpt_timer_cfg_cmd(struct adapter *padapter, u16 min_time)
>  
>  	u8	res = _SUCCESS;
>  
> -	ph2c = kzalloc(sizeof(struct cmd_obj), GFP_ATOMIC);
> +	ph2c = kzalloc(sizeof(*ph2c), GFP_ATOMIC);
>  	if (!ph2c) {
>  		res = _FAIL;
>  		goto exit;
>  	}
>  
> -	pdrvextra_cmd_parm = kzalloc(sizeof(struct drvextra_cmd_parm),
> +	pdrvextra_cmd_parm = kzalloc(sizeof(*pdrvextra_cmd_parm),
>  				     GFP_ATOMIC);
>  	if (!pdrvextra_cmd_parm) {
>  		kfree(ph2c);
> @@ -1109,13 +1109,13 @@ u8 rtw_antenna_select_cmd(struct adapter *padapter, u8 antenna, u8 enqueue)
>  		return res;
>  
>  	if (enqueue) {
> -		ph2c = kzalloc(sizeof(struct cmd_obj), GFP_KERNEL);
> +		ph2c = kzalloc(sizeof(*ph2c), GFP_KERNEL);
>  		if (!ph2c) {
>  			res = _FAIL;
>  			goto exit;
>  		}
>  
> -		pdrvextra_cmd_parm = kzalloc(sizeof(struct drvextra_cmd_parm),
> +		pdrvextra_cmd_parm = kzalloc(sizeof(*pdrvextra_cmd_parm),
>  					     GFP_KERNEL);
>  		if (!pdrvextra_cmd_parm) {
>  			kfree(ph2c);
> @@ -1148,13 +1148,13 @@ u8 p2p_protocol_wk_cmd(struct adapter *padapter, int intCmdType)
>  	if (rtw_p2p_chk_state(pwdinfo, P2P_STATE_NONE))
>  		return res;
>  
> -	ph2c = kzalloc(sizeof(struct cmd_obj), GFP_ATOMIC);
> +	ph2c = kzalloc(sizeof(*ph2c), GFP_ATOMIC);
>  	if (!ph2c) {
>  		res = _FAIL;
>  		goto exit;
>  	}
>  
> -	pdrvextra_cmd_parm = kzalloc(sizeof(struct drvextra_cmd_parm), GFP_ATOMIC);
> +	pdrvextra_cmd_parm = kzalloc(sizeof(*pdrvextra_cmd_parm), GFP_ATOMIC);
>  	if (!pdrvextra_cmd_parm) {
>  		kfree(ph2c);
>  		res = _FAIL;
> @@ -1182,13 +1182,13 @@ u8 rtw_ps_cmd(struct adapter *padapter)
>  
>  	u8	res = _SUCCESS;
>  
> -	ppscmd = kzalloc(sizeof(struct cmd_obj), GFP_ATOMIC);
> +	ppscmd = kzalloc(sizeof(*ppscmd), GFP_ATOMIC);
>  	if (!ppscmd) {
>  		res = _FAIL;
>  		goto exit;
>  	}
>  
> -	pdrvextra_cmd_parm = kzalloc(sizeof(struct drvextra_cmd_parm), GFP_ATOMIC);
> +	pdrvextra_cmd_parm = kzalloc(sizeof(*pdrvextra_cmd_parm), GFP_ATOMIC);
>  	if (!pdrvextra_cmd_parm) {
>  		kfree(ppscmd);
>  		res = _FAIL;
> @@ -1253,13 +1253,13 @@ u8 rtw_chk_hi_queue_cmd(struct adapter *padapter)
>  	struct cmd_priv	*pcmdpriv = &padapter->cmdpriv;
>  	u8	res = _SUCCESS;
>  
> -	ph2c = kzalloc(sizeof(struct cmd_obj), GFP_ATOMIC);
> +	ph2c = kzalloc(sizeof(*ph2c), GFP_ATOMIC);
>  	if (!ph2c) {
>  		res = _FAIL;
>  		goto exit;
>  	}
>  
> -	pdrvextra_cmd_parm = kzalloc(sizeof(struct drvextra_cmd_parm), GFP_ATOMIC);
> +	pdrvextra_cmd_parm = kzalloc(sizeof(*pdrvextra_cmd_parm), GFP_ATOMIC);
>  	if (!pdrvextra_cmd_parm) {
>  		kfree(ph2c);
>  		res = _FAIL;
> @@ -1284,13 +1284,13 @@ u8 rtw_c2h_wk_cmd(struct adapter *padapter, u8 *c2h_evt)
>  	struct cmd_priv	*pcmdpriv = &padapter->cmdpriv;
>  	u8	res = _SUCCESS;
>  
> -	ph2c = kzalloc(sizeof(struct cmd_obj), GFP_ATOMIC);
> +	ph2c = kzalloc(sizeof(*ph2c), GFP_ATOMIC);
>  	if (!ph2c) {
>  		res = _FAIL;
>  		goto exit;
>  	}
>  
> -	pdrvextra_cmd_parm = kzalloc(sizeof(struct drvextra_cmd_parm), GFP_ATOMIC);
> +	pdrvextra_cmd_parm = kzalloc(sizeof(*pdrvextra_cmd_parm), GFP_ATOMIC);
>  	if (!pdrvextra_cmd_parm) {
>  		kfree(ph2c);
>  		res = _FAIL;
> -- 
> 2.32.0
> 
