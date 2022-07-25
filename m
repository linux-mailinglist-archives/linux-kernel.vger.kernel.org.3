Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17670580620
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 23:05:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233617AbiGYVF0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 17:05:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229915AbiGYVFY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 17:05:24 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EA2E1EEE4
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 14:05:23 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id m17so17368506wrw.7
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 14:05:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=zNY3kV1UOAIrZf04jkloe2pZc/2EjdxNhL+CWW3NTcY=;
        b=fHAfM5BOy4kZCggACiLsA1J9063PTnoYYxay+hQCNmtS3yQKzPWi1vjuH/gUPEg/Vs
         ta1B2aYlVEDLNrdeAoUuafYto2ObNdNjVvv7Y1PYqHUArglXitXh3R/8BmBa3ljld72L
         Iz41GfDvp2U2cd1Bx/M6/LoPlVwwTpQ9NSzjTxz6zgObE8WwRpR2Xaa9xPTOSzi8mtEE
         0GBQWQPz7XjJZ/Q6SKCCHv4aHSeUt3R0rXE/hYb8YoEVD1TbQpB0/7GIRJMxAtJLpGFL
         nMO1TEbuCkeItqctu1Ezknid3S1z5BZWzKKAVBfmDYs8bqZNZvxsiD9nJBOg+0fzYrFe
         REmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=zNY3kV1UOAIrZf04jkloe2pZc/2EjdxNhL+CWW3NTcY=;
        b=OzHux/deErJHNUhWSKzrDAAA38fDPRlJgcA0Emb/Jyj8YyeUC3MIWiCxWeKie5TvL3
         8srqLZPduMMryyqmvO+HUlbkUcZrOrZfvRlr2ml+kZz0/d2fy+St4UwFkbVVfbPf1KQ1
         2DXVzeoK1+8vICmGUQkDHhv1OAQme53HHUjxg4CgGg2dzYGyoJEH3ycXMISmtBhnzXyZ
         MIdqq5Y4NDHYJ8J3kjCr9E1v9trEAzYxztruJPVQ/E4Aj4lSzCHLoc8Q6CgRa0tAmJfp
         gdK7xNZIScFn+Rz6bEPBM46rNFZE9bQaIJ4KbPAf1Cg+wfL/uPlSh0y84phKn7o/E5Bi
         DSmg==
X-Gm-Message-State: AJIora9ybmCINJJdWaFWGkVwI13XgfLDvmVaDKNeAzvkvrpwbN0vJz0y
        CLzsVYUmyeUehz68YRT8UJuUTA==
X-Google-Smtp-Source: AGRyM1udKYMysUEQNVMcqzi2OnasSwsS/jpQPkd5XK9lOZFWo4T+cGVYhySmxdIGnW4+h3IDcrMkcA==
X-Received: by 2002:a5d:5887:0:b0:21d:bb2f:eee5 with SMTP id n7-20020a5d5887000000b0021dbb2feee5mr8674187wrf.288.1658783121418;
        Mon, 25 Jul 2022 14:05:21 -0700 (PDT)
Received: from equinox (2.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.a.1.e.e.d.f.d.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:dfde:e1a0::2])
        by smtp.gmail.com with ESMTPSA id j20-20020a05600c1c1400b003a319b67f64sm327356wms.0.2022.07.25.14.05.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jul 2022 14:05:20 -0700 (PDT)
Date:   Mon, 25 Jul 2022 22:05:19 +0100
From:   Phillip Potter <phil@philpotter.co.uk>
To:     Philipp Hortmann <philipp.g.hortmann@gmail.com>
Cc:     gregkh@linuxfoundation.org, Larry.Finger@lwfinger.net,
        paskripkin@gmail.com, straube.linux@gmail.com, martin@kaiser.cx,
        abdun.nihaal@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: r8188eu: convert rtw_pwr_wakeup to correct
 error code semantics
Message-ID: <Yt8Fj0ahBzL/T8Aj@equinox>
References: <20220724163055.961-1-phil@philpotter.co.uk>
 <f668b918-84d3-eaba-dfb7-d7b32240ffaf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f668b918-84d3-eaba-dfb7-d7b32240ffaf@gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 24, 2022 at 08:39:42PM +0200, Philipp Hortmann wrote:
> On 7/24/22 18:30, Phillip Potter wrote:
> > Convert the rtw_pwr_wakeup function to use 0 on success and -EPERM on
> > error - in all places where we handle this response, we use either -1 or
> > -EPERM currently anyway, which are equivalent. Also, for other places
> > along the same call chain where we are using -1, use -EPERM.
> > 
> > This gets the driver closer to removal of the non-standard _SUCCESS and
> > _FAIL definitions, which are inverted compared to the standard in-kernel
> > error code mechanism.
> > 
> > Signed-off-by: Phillip Potter <phil@philpotter.co.uk>
> > ---
> >   drivers/staging/r8188eu/core/rtw_p2p.c       |  4 +--
> >   drivers/staging/r8188eu/core/rtw_pwrctrl.c   | 10 +++---
> >   drivers/staging/r8188eu/os_dep/ioctl_linux.c | 32 ++++++++++----------
> >   3 files changed, 23 insertions(+), 23 deletions(-)
> > 
> > diff --git a/drivers/staging/r8188eu/core/rtw_p2p.c b/drivers/staging/r8188eu/core/rtw_p2p.c
> > index c306aafa183b..bd654d4ff8b4 100644
> > --- a/drivers/staging/r8188eu/core/rtw_p2p.c
> > +++ b/drivers/staging/r8188eu/core/rtw_p2p.c
> > @@ -1888,7 +1888,7 @@ int rtw_p2p_enable(struct adapter *padapter, enum P2P_ROLE role)
> >   	if (role == P2P_ROLE_DEVICE || role == P2P_ROLE_CLIENT || role == P2P_ROLE_GO) {
> >   		/* leave IPS/Autosuspend */
> > -		if (rtw_pwr_wakeup(padapter) == _FAIL) {
> > +		if (rtw_pwr_wakeup(padapter)) {
> >   			ret = _FAIL;
> >   			goto exit;
> >   		}
> > @@ -1902,7 +1902,7 @@ int rtw_p2p_enable(struct adapter *padapter, enum P2P_ROLE role)
> >   		init_wifidirect_info(padapter, role);
> >   	} else if (role == P2P_ROLE_DISABLE) {
> > -		if (rtw_pwr_wakeup(padapter) == _FAIL) {
> > +		if (rtw_pwr_wakeup(padapter)) {
> >   			ret = _FAIL;
> >   			goto exit;
> >   		}
> > diff --git a/drivers/staging/r8188eu/core/rtw_pwrctrl.c b/drivers/staging/r8188eu/core/rtw_pwrctrl.c
> > index cf9020a73933..1cef3ef4d5f1 100644
> > --- a/drivers/staging/r8188eu/core/rtw_pwrctrl.c
> > +++ b/drivers/staging/r8188eu/core/rtw_pwrctrl.c
> > @@ -381,24 +381,24 @@ int rtw_pwr_wakeup(struct adapter *padapter)
> >   	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
> >   	unsigned long timeout = jiffies + msecs_to_jiffies(3000);
> >   	unsigned long deny_time;
> > -	int ret = _SUCCESS;
> > +	int ret = 0;
> >   	while (pwrpriv->ps_processing && time_before(jiffies, timeout))
> >   		msleep(10);
> >   	/* I think this should be check in IPS, LPS, autosuspend functions... */
> >   	if (check_fwstate(pmlmepriv, _FW_LINKED)) {
> > -		ret = _SUCCESS;
> > +		ret = 0;
> >   		goto exit;
> >   	}
> >   	if (pwrpriv->rf_pwrstate == rf_off && ips_leave(padapter) == _FAIL) {
> > -		ret = _FAIL;
> > +		ret = -EPERM;
> >   		goto exit;
> >   	}
> >   	if (padapter->bDriverStopped || !padapter->bup || !padapter->hw_init_completed) {
> > -		ret = _FAIL;
> > +		ret = -EPERM;
> >   		goto exit;
> >   	}
> > @@ -439,7 +439,7 @@ int rtw_pm_set_ips(struct adapter *padapter, u8 mode)
> >   		return 0;
> >   	} else if (mode == IPS_NONE) {
> >   		rtw_ips_mode_req(pwrctrlpriv, mode);
> > -		if ((padapter->bSurpriseRemoved == 0) && (rtw_pwr_wakeup(padapter) == _FAIL))
> > +		if ((padapter->bSurpriseRemoved == 0) && rtw_pwr_wakeup(padapter))
> >   			return -EFAULT;
> >   	} else {
> >   		return -EINVAL;
> > diff --git a/drivers/staging/r8188eu/os_dep/ioctl_linux.c b/drivers/staging/r8188eu/os_dep/ioctl_linux.c
> > index 930bb4aea435..e0ae0c3c51f8 100644
> > --- a/drivers/staging/r8188eu/os_dep/ioctl_linux.c
> > +++ b/drivers/staging/r8188eu/os_dep/ioctl_linux.c
> > @@ -689,7 +689,7 @@ static int rtw_wx_set_mode(struct net_device *dev, struct iw_request_info *a,
> > -	if (_FAIL == rtw_pwr_wakeup(padapter)) {
> > +	if (rtw_pwr_wakeup(padapter)) {
> >   		ret = -EPERM;
> >   		goto exit;
> >   	}
> > @@ -933,13 +933,13 @@ static int rtw_wx_set_wap(struct net_device *dev,
> > -	if (_FAIL == rtw_pwr_wakeup(padapter)) {
> > -		ret = -1;
> > +	if (rtw_pwr_wakeup(padapter)) {
> > +		ret = -EPERM;
> >   		goto exit;
> >   	}
> >   	if (!padapter->bup) {
> > -		ret = -1;
> > +		ret = -EPERM;
> >   		goto exit;
> >   	}
> > @@ -1049,23 +1049,23 @@ static int rtw_wx_set_scan(struct net_device *dev, struct iw_request_info *a,
> >   	struct ndis_802_11_ssid ssid[RTW_SSID_SCAN_AMOUNT];
> >   	struct wifidirect_info *pwdinfo = &padapter->wdinfo;
> > -	if (_FAIL == rtw_pwr_wakeup(padapter)) {
> > -		ret = -1;
> > +	if (rtw_pwr_wakeup(padapter)) {
> > +		ret = -EPERM;
> >   		goto exit;
> >   	}
> >   	if (padapter->bDriverStopped) {
> > -		ret = -1;
> > +		ret = -EPERM;
> >   		goto exit;
> >   	}
> >   	if (!padapter->bup) {
> > -		ret = -1;
> > +		ret = -EPERM;
> >   		goto exit;
> >   	}
> >   	if (!padapter->hw_init_completed) {
> > -		ret = -1;
> > +		ret = -EPERM;
> >   		goto exit;
> >   	}
> > @@ -1164,7 +1164,7 @@ static int rtw_wx_set_scan(struct net_device *dev, struct iw_request_info *a,
> >   	}
> >   	if (!_status)
> > -		ret = -1;
> > +		ret = -EPERM;
> >   exit:
> > @@ -1252,13 +1252,13 @@ static int rtw_wx_set_essid(struct net_device *dev,
> >   	uint ret = 0, len;
> > -	if (_FAIL == rtw_pwr_wakeup(padapter)) {
> > -		ret = -1;
> > +	if (rtw_pwr_wakeup(padapter)) {
> > +		ret = -EPERM;
> >   		goto exit;
> >   	}
> >   	if (!padapter->bup) {
> > -		ret = -1;
> > +		ret = -EPERM;
> >   		goto exit;
> >   	}
> > @@ -1268,7 +1268,7 @@ static int rtw_wx_set_essid(struct net_device *dev,
> >   	}
> >   	if (check_fwstate(pmlmepriv, WIFI_AP_STATE)) {
> > -		ret = -1;
> > +		ret = -EPERM;
> >   		goto exit;
> >   	}
> > @@ -1301,7 +1301,7 @@ static int rtw_wx_set_essid(struct net_device *dev,
> >   				}
> >   				if (!rtw_set_802_11_infrastructure_mode(padapter, pnetwork->network.InfrastructureMode)) {
> > -					ret = -1;
> > +					ret = -EPERM;
> >   					spin_unlock_bh(&queue->lock);
> >   					goto exit;
> >   				}
> > @@ -1312,7 +1312,7 @@ static int rtw_wx_set_essid(struct net_device *dev,
> >   		spin_unlock_bh(&queue->lock);
> >   		rtw_set_802_11_authentication_mode(padapter, authmode);
> >   		if (!rtw_set_802_11_ssid(padapter, &ndis_ssid)) {
> > -			ret = -1;
> > +			ret = -EPERM;
> >   			goto exit;
> >   		}
> >   	}
> 
> Tested-by: Philipp Hortmann <philipp.g.hortmann@gmail.com> # Edimax N150

Hi Philipp,

Thank you for testing, much appreciated. Need to do a V2 now, but wanted
to thank you anyway for your effort.

Regards,
Phil
