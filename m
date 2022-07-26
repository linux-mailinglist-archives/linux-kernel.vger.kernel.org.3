Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6CFB580AAE
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 07:09:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237398AbiGZFJz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 01:09:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229749AbiGZFJy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 01:09:54 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E909D205E5
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 22:09:52 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id w5so3951866edd.13
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 22:09:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=/vrj0ZAYlkRkM3MR6rLnbZa6ZHZq3DoeX+4DGlYxSVE=;
        b=g7veB7jCo2DHD87qhWivYptJhK6fkYeCcaa66xSo4oC/h3QzVguKeZZ2es6FFsRG+x
         XHmRgRvYl1S+wWU+Q8UHKqkP9FFlNWoRovr/+uQ0pp1Uq2Dao91iRa+4nBs3yYAQ8Kpy
         fZ/CoDeWhasTzE+JHpvBW5qB09lyx9q90b5JRmVsAYQdVoHv405xUdJ/9urp68Kx0nv7
         kr+5gYrV+r2HT3TqQByNP+w+UcxOY5GaSzAG+xOBtwOAQCuBRATbN7wI9NWKIgaU06Mf
         2pj+w1TaE9fzFMoHKj6pk5i+bHyXZ+f8WuCESVNnOMWOyVNlDGHwmMrz4CFwkBosOzn0
         EwAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=/vrj0ZAYlkRkM3MR6rLnbZa6ZHZq3DoeX+4DGlYxSVE=;
        b=vjRt0HWBL3ke5N0NFjEF5ipqNOiFiZl4p2Dmm/h2vq5S4f4szikXbbgDiOsTHMPehQ
         DlyjkhcZ/ElBqRdIBJY1svpe+mjPXc8m7myweudrZGwn9aYlA37jhXZcZOmSLt92TvAB
         xjHmA8h6WWgprxWtOXzY2p1Lsf+dRoafSFzb+qk5hYIshtJ2zdhnbPTmphyYK8DeGe9i
         kjTyGRAFZbuguwDaQm5P2Hfe8VZwA6UMVVQzLgYQNIyYR7wddVqy+5IkrDMZFL8ZwHaT
         Mtq4uyzWM9UYNmo7Eo94khqLIkOUMOLGDck4gzN4bLO2YZhjJdgk205Y1J1oLhJhdzet
         yE7A==
X-Gm-Message-State: AJIora8zAsYWgipLYtcGiH4Mn/4Qq16cv4zkkPaRKRFKCY5oSg+Ub20V
        HMmEykyjTBLqDTGkElBlFwdAXjWOKwE=
X-Google-Smtp-Source: AGRyM1vVdnGR1eT1h/4wVbxvmVfKlY68pxk8soBgzwxC/QBpW0t/fg5kFNLUGpOrLQ/4v/S0ZQkIkQ==
X-Received: by 2002:a05:6402:5001:b0:437:8918:8dbe with SMTP id p1-20020a056402500100b0043789188dbemr16697170eda.70.1658812191390;
        Mon, 25 Jul 2022 22:09:51 -0700 (PDT)
Received: from [192.168.1.100] (p54a07b82.dip0.t-ipconnect.de. [84.160.123.130])
        by smtp.gmail.com with ESMTPSA id u18-20020a056402111200b0043bb892a86csm7938819edv.69.2022.07.25.22.09.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Jul 2022 22:09:51 -0700 (PDT)
Message-ID: <13992777-97c4-2b1b-99dc-876bec9a6dde@gmail.com>
Date:   Tue, 26 Jul 2022 07:09:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2] staging: r8188eu: convert rtw_pwr_wakeup to correct
 error code semantics
Content-Language: en-US
To:     Phillip Potter <phil@philpotter.co.uk>, gregkh@linuxfoundation.org,
        dan.carpenter@oracle.com
Cc:     Larry.Finger@lwfinger.net, paskripkin@gmail.com,
        straube.linux@gmail.com, martin@kaiser.cx, abdun.nihaal@gmail.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20220725220745.12739-1-phil@philpotter.co.uk>
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
In-Reply-To: <20220725220745.12739-1-phil@philpotter.co.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/26/22 00:07, Phillip Potter wrote:
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
>    scope.
> * Preserve error codes in places where calling function already uses
>    proper negative semantics, so that they can be passed through to the
>    caller.
> 
> ---
>   drivers/staging/r8188eu/core/rtw_p2p.c       |  4 ++--
>   drivers/staging/r8188eu/core/rtw_pwrctrl.c   | 10 ++++----
>   drivers/staging/r8188eu/os_dep/ioctl_linux.c | 24 +++++++-------------
>   3 files changed, 15 insertions(+), 23 deletions(-)
> 
> diff --git a/drivers/staging/r8188eu/core/rtw_p2p.c b/drivers/staging/r8188eu/core/rtw_p2p.c
> index c306aafa183b..bd654d4ff8b4 100644
> --- a/drivers/staging/r8188eu/core/rtw_p2p.c
> +++ b/drivers/staging/r8188eu/core/rtw_p2p.c
> @@ -1888,7 +1888,7 @@ int rtw_p2p_enable(struct adapter *padapter, enum P2P_ROLE role)
>   
>   	if (role == P2P_ROLE_DEVICE || role == P2P_ROLE_CLIENT || role == P2P_ROLE_GO) {
>   		/* leave IPS/Autosuspend */
> -		if (rtw_pwr_wakeup(padapter) == _FAIL) {
> +		if (rtw_pwr_wakeup(padapter)) {
>   			ret = _FAIL;
>   			goto exit;
>   		}
> @@ -1902,7 +1902,7 @@ int rtw_p2p_enable(struct adapter *padapter, enum P2P_ROLE role)
>   		init_wifidirect_info(padapter, role);
>   
>   	} else if (role == P2P_ROLE_DISABLE) {
> -		if (rtw_pwr_wakeup(padapter) == _FAIL) {
> +		if (rtw_pwr_wakeup(padapter)) {
>   			ret = _FAIL;
>   			goto exit;
>   		}
> diff --git a/drivers/staging/r8188eu/core/rtw_pwrctrl.c b/drivers/staging/r8188eu/core/rtw_pwrctrl.c
> index cf9020a73933..8b1c50668dfe 100644
> --- a/drivers/staging/r8188eu/core/rtw_pwrctrl.c
> +++ b/drivers/staging/r8188eu/core/rtw_pwrctrl.c
> @@ -381,24 +381,24 @@ int rtw_pwr_wakeup(struct adapter *padapter)
>   	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
>   	unsigned long timeout = jiffies + msecs_to_jiffies(3000);
>   	unsigned long deny_time;
> -	int ret = _SUCCESS;
> +	int ret = 0;
>   
>   	while (pwrpriv->ps_processing && time_before(jiffies, timeout))
>   		msleep(10);
>   
>   	/* I think this should be check in IPS, LPS, autosuspend functions... */
>   	if (check_fwstate(pmlmepriv, _FW_LINKED)) {
> -		ret = _SUCCESS;
> +		ret = 0;
>   		goto exit;
>   	}
>   
>   	if (pwrpriv->rf_pwrstate == rf_off && ips_leave(padapter) == _FAIL) {
> -		ret = _FAIL;
> +		ret = -ENOMEM;
>   		goto exit;
>   	}
>   
>   	if (padapter->bDriverStopped || !padapter->bup || !padapter->hw_init_completed) {
> -		ret = _FAIL;
> +		ret = -EBUSY;
>   		goto exit;
>   	}
>   
> @@ -439,7 +439,7 @@ int rtw_pm_set_ips(struct adapter *padapter, u8 mode)
>   		return 0;
>   	} else if (mode == IPS_NONE) {
>   		rtw_ips_mode_req(pwrctrlpriv, mode);
> -		if ((padapter->bSurpriseRemoved == 0) && (rtw_pwr_wakeup(padapter) == _FAIL))
> +		if ((padapter->bSurpriseRemoved == 0) && rtw_pwr_wakeup(padapter))
>   			return -EFAULT;
>   	} else {
>   		return -EINVAL;
> diff --git a/drivers/staging/r8188eu/os_dep/ioctl_linux.c b/drivers/staging/r8188eu/os_dep/ioctl_linux.c
> index 930bb4aea435..7f91dac2e41b 100644
> --- a/drivers/staging/r8188eu/os_dep/ioctl_linux.c
> +++ b/drivers/staging/r8188eu/os_dep/ioctl_linux.c
> @@ -687,12 +687,9 @@ static int rtw_wx_set_mode(struct net_device *dev, struct iw_request_info *a,
>   	enum ndis_802_11_network_infra networkType;
>   	int ret = 0;
>   
> -
> -
> -	if (_FAIL == rtw_pwr_wakeup(padapter)) {
> -		ret = -EPERM;
> +	ret = rtw_pwr_wakeup(padapter);
> +	if (ret)
>   		goto exit;
> -	}
>   
>   	if (!padapter->hw_init_completed) {
>   		ret = -EPERM;
> @@ -931,12 +928,9 @@ static int rtw_wx_set_wap(struct net_device *dev,
>   	struct	wlan_network	*pnetwork = NULL;
>   	enum ndis_802_11_auth_mode	authmode;
>   
> -
> -
> -	if (_FAIL == rtw_pwr_wakeup(padapter)) {
> -		ret = -1;
> +	ret = rtw_pwr_wakeup(padapter);
> +	if (ret)
>   		goto exit;
> -	}
>   
>   	if (!padapter->bup) {
>   		ret = -1;
> @@ -1049,10 +1043,9 @@ static int rtw_wx_set_scan(struct net_device *dev, struct iw_request_info *a,
>   	struct ndis_802_11_ssid ssid[RTW_SSID_SCAN_AMOUNT];
>   	struct wifidirect_info *pwdinfo = &padapter->wdinfo;
>   
> -	if (_FAIL == rtw_pwr_wakeup(padapter)) {
> -		ret = -1;
> +	ret = rtw_pwr_wakeup(padapter);
> +	if (ret)
>   		goto exit;
> -	}
>   
>   	if (padapter->bDriverStopped) {
>   		ret = -1;
> @@ -1252,10 +1245,9 @@ static int rtw_wx_set_essid(struct net_device *dev,
>   
>   	uint ret = 0, len;
>   
> -	if (_FAIL == rtw_pwr_wakeup(padapter)) {
> -		ret = -1;
> +	ret = rtw_pwr_wakeup(padapter);
> +	if (ret)
>   		goto exit;
> -	}
>   
>   	if (!padapter->bup) {
>   		ret = -1;

Tested-by: Philipp Hortmann <philipp.g.hortmann@gmail.com> # Edimax N150
