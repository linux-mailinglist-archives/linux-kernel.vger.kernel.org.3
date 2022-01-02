Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A458F482C47
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jan 2022 17:58:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229727AbiABQ6l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Jan 2022 11:58:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229648AbiABQ6k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jan 2022 11:58:40 -0500
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28A62C061761
        for <linux-kernel@vger.kernel.org>; Sun,  2 Jan 2022 08:58:40 -0800 (PST)
Received: from dslb-188-104-058-096.188.104.pools.vodafone-ip.de ([188.104.58.96] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <postmaster@kaiser.cx>)
        id 1n44Bj-0005Dr-Aa; Sun, 02 Jan 2022 17:58:31 +0100
Received: from martin by martin-debian-2.paytec.ch with local (Exim 4.94.2)
        (envelope-from <martin@martin-debian-2.paytec.ch>)
        id 1n44Bh-000CiE-N5; Sun, 02 Jan 2022 17:58:29 +0100
Date:   Sun, 2 Jan 2022 17:58:29 +0100
From:   Martin Kaiser <martin@kaiser.cx>
To:     Abdun Nihaal <abdun.nihaal@gmail.com>
Cc:     gregkh@linuxfoundation.org, Larry.Finger@lwfinger.net,
        phil@philpotter.co.uk, straube.linux@gmail.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: r8188eu: remove unneeded ret variables
Message-ID: <YdHZtYgYteO8t2Ec@martin-debian-1.paytec.ch>
References: <20211231172527.184788-1-abdun.nihaal@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211231172527.184788-1-abdun.nihaal@gmail.com>
Sender: "Martin Kaiser,,," <martin@martin-debian-2.paytec.ch>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thus wrote Abdun Nihaal (abdun.nihaal@gmail.com):

> Remove unneeded return variables in ioctl_linux.c that are initialized
> to 0 and are not assigned after. Instead, return 0 directly.

> Found using coccinelle (returnvar.cocci).

> Signed-off-by: Abdun Nihaal <abdun.nihaal@gmail.com>
> ---
>  drivers/staging/r8188eu/os_dep/ioctl_linux.c | 88 +++++++-------------
>  1 file changed, 31 insertions(+), 57 deletions(-)

> diff --git a/drivers/staging/r8188eu/os_dep/ioctl_linux.c b/drivers/staging/r8188eu/os_dep/ioctl_linux.c
> index adc03862bc03..9d277151a5ee 100644
> --- a/drivers/staging/r8188eu/os_dep/ioctl_linux.c
> +++ b/drivers/staging/r8188eu/os_dep/ioctl_linux.c
> @@ -1383,7 +1383,7 @@ static int rtw_wx_get_essid(struct net_device *dev,
>  			      struct iw_request_info *a,
>  			      union iwreq_data *wrqu, char *extra)
>  {
> -	u32 len, ret = 0;
> +	u32 len;
>  	struct adapter *padapter = (struct adapter *)rtw_netdev_priv(dev);
>  	struct	mlme_priv	*pmlmepriv = &padapter->mlmepriv;
>  	struct wlan_bssid_ex  *pcur_bss = &pmlmepriv->cur_network.network;
> @@ -1399,7 +1399,7 @@ static int rtw_wx_get_essid(struct net_device *dev,
>  	wrqu->essid.length = len;
>  	wrqu->essid.flags = 1;

> -	return ret;
> +	return 0;
>  }

>  static int rtw_wx_set_rate(struct net_device *dev,
> @@ -1717,7 +1717,7 @@ static int rtw_wx_get_enc(struct net_device *dev,
>  			    struct iw_request_info *info,
>  			    union iwreq_data *wrqu, char *keybuf)
>  {
> -	uint key, ret = 0;
> +	uint key;
>  	struct adapter *padapter = (struct adapter *)rtw_netdev_priv(dev);
>  	struct iw_point *erq = &wrqu->encoding;
>  	struct	mlme_priv	*pmlmepriv = &padapter->mlmepriv;
> @@ -1777,8 +1777,7 @@ static int rtw_wx_get_enc(struct net_device *dev,
>  		break;
>  	}

> -
> -	return ret;
> +	return 0;
>  }

>  static int rtw_wx_get_power(struct net_device *dev,
> @@ -2312,7 +2311,6 @@ static int rtw_p2p_set_go_nego_ssid(struct net_device *dev,
>  			       struct iw_request_info *info,
>  			       union iwreq_data *wrqu, char *extra)
>  {
> -	int ret = 0;
>  	struct adapter *padapter = (struct adapter *)rtw_netdev_priv(dev);
>  	struct wifidirect_info *pwdinfo = &padapter->wdinfo;

> @@ -2320,7 +2318,7 @@ static int rtw_p2p_set_go_nego_ssid(struct net_device *dev,
>  	memcpy(pwdinfo->nego_ssid, extra, strlen(extra));
>  	pwdinfo->nego_ssidlen = strlen(extra);

> -	return ret;
> +	return 0;
>  }

>  static int rtw_p2p_set_intent(struct net_device *dev,
> @@ -2460,7 +2458,6 @@ static int rtw_p2p_setDN(struct net_device *dev,
>  			       struct iw_request_info *info,
>  			       union iwreq_data *wrqu, char *extra)
>  {
> -	int ret = 0;
>  	struct adapter *padapter = (struct adapter *)rtw_netdev_priv(dev);
>  	struct wifidirect_info *pwdinfo = &padapter->wdinfo;

> @@ -2469,14 +2466,13 @@ static int rtw_p2p_setDN(struct net_device *dev,
>  	memcpy(pwdinfo->device_name, extra, wrqu->data.length - 1);
>  	pwdinfo->device_name_len = wrqu->data.length - 1;

> -	return ret;
> +	return 0;
>  }

>  static int rtw_p2p_get_status(struct net_device *dev,
>  			       struct iw_request_info *info,
>  			       union iwreq_data *wrqu, char *extra)
>  {
> -	int ret = 0;
>  	struct adapter *padapter = (struct adapter *)rtw_netdev_priv(dev);
>  	struct wifidirect_info *pwdinfo = &padapter->wdinfo;

> @@ -2491,7 +2487,7 @@ static int rtw_p2p_get_status(struct net_device *dev,
>  	sprintf(extra, "\n\nStatus =%.2d\n", rtw_p2p_state(pwdinfo));
>  	wrqu->data.length = strlen(extra);

> -	return ret;
> +	return 0;
>  }

>  /*	Commented by Albert 20110520 */
> @@ -2503,20 +2499,18 @@ static int rtw_p2p_get_req_cm(struct net_device *dev,
>  			       struct iw_request_info *info,
>  			       union iwreq_data *wrqu, char *extra)
>  {
> -	int ret = 0;
>  	struct adapter *padapter = (struct adapter *)rtw_netdev_priv(dev);
>  	struct wifidirect_info *pwdinfo = &padapter->wdinfo;

>  	sprintf(extra, "\n\nCM =%s\n", pwdinfo->rx_prov_disc_info.strconfig_method_desc_of_prov_disc_req);
>  	wrqu->data.length = strlen(extra);
> -	return ret;
> +	return 0;
>  }

>  static int rtw_p2p_get_role(struct net_device *dev,
>  			       struct iw_request_info *info,
>  			       union iwreq_data *wrqu, char *extra)
>  {
> -	int ret = 0;
>  	struct adapter *padapter = (struct adapter *)rtw_netdev_priv(dev);
>  	struct wifidirect_info *pwdinfo = &padapter->wdinfo;

> @@ -2526,14 +2520,13 @@ static int rtw_p2p_get_role(struct net_device *dev,

>  	sprintf(extra, "\n\nRole =%.2d\n", rtw_p2p_role(pwdinfo));
>  	wrqu->data.length = strlen(extra);
> -	return ret;
> +	return 0;
>  }

>  static int rtw_p2p_get_peer_ifaddr(struct net_device *dev,
>  			       struct iw_request_info *info,
>  			       union iwreq_data *wrqu, char *extra)
>  {
> -	int ret = 0;
>  	struct adapter *padapter = (struct adapter *)rtw_netdev_priv(dev);
>  	struct wifidirect_info *pwdinfo = &padapter->wdinfo;

> @@ -2543,7 +2536,7 @@ static int rtw_p2p_get_peer_ifaddr(struct net_device *dev,
>  	sprintf(extra, "\nMAC %pM",
>  		pwdinfo->p2p_peer_interface_addr);
>  	wrqu->data.length = strlen(extra);
> -	return ret;
> +	return 0;
>  }

>  static int rtw_p2p_get_peer_devaddr(struct net_device *dev,
> @@ -2551,7 +2544,6 @@ static int rtw_p2p_get_peer_devaddr(struct net_device *dev,
>  			       union iwreq_data *wrqu, char *extra)

>  {
> -	int ret = 0;
>  	struct adapter *padapter = (struct adapter *)rtw_netdev_priv(dev);
>  	struct wifidirect_info *pwdinfo = &padapter->wdinfo;

> @@ -2561,7 +2553,7 @@ static int rtw_p2p_get_peer_devaddr(struct net_device *dev,
>  	sprintf(extra, "\n%pM",
>  		pwdinfo->rx_prov_disc_info.peerDevAddr);
>  	wrqu->data.length = strlen(extra);
> -	return ret;
> +	return 0;
>  }

>  static int rtw_p2p_get_peer_devaddr_by_invitation(struct net_device *dev,
> @@ -2569,7 +2561,6 @@ static int rtw_p2p_get_peer_devaddr_by_invitation(struct net_device *dev,
>  			       union iwreq_data *wrqu, char *extra)

>  {
> -	int ret = 0;
>  	struct adapter *padapter = (struct adapter *)rtw_netdev_priv(dev);
>  	struct wifidirect_info *pwdinfo = &padapter->wdinfo;

> @@ -2579,7 +2570,7 @@ static int rtw_p2p_get_peer_devaddr_by_invitation(struct net_device *dev,
>  	sprintf(extra, "\nMAC %pM",
>  		pwdinfo->p2p_peer_device_addr);
>  	wrqu->data.length = strlen(extra);
> -	return ret;
> +	return 0;
>  }

>  static int rtw_p2p_get_groupid(struct net_device *dev,
> @@ -2587,7 +2578,6 @@ static int rtw_p2p_get_groupid(struct net_device *dev,
>  			       union iwreq_data *wrqu, char *extra)

>  {
> -	int ret = 0;
>  	struct adapter *padapter = (struct adapter *)rtw_netdev_priv(dev);
>  	struct wifidirect_info *pwdinfo = &padapter->wdinfo;

> @@ -2597,7 +2587,7 @@ static int rtw_p2p_get_groupid(struct net_device *dev,
>  		pwdinfo->groupid_info.go_device_addr[4], pwdinfo->groupid_info.go_device_addr[5],
>  		pwdinfo->groupid_info.ssid);
>  	wrqu->data.length = strlen(extra);
> -	return ret;
> +	return 0;
>  }

>  static int rtw_p2p_get_op_ch(struct net_device *dev,
> @@ -2605,7 +2595,6 @@ static int rtw_p2p_get_op_ch(struct net_device *dev,
>  			       union iwreq_data *wrqu, char *extra)

>  {
> -	int ret = 0;
>  	struct adapter *padapter = (struct adapter *)rtw_netdev_priv(dev);
>  	struct wifidirect_info *pwdinfo = &padapter->wdinfo;

> @@ -2613,14 +2602,13 @@ static int rtw_p2p_get_op_ch(struct net_device *dev,

>  	sprintf(extra, "\n\nOp_ch =%.2d\n", pwdinfo->operating_channel);
>  	wrqu->data.length = strlen(extra);
> -	return ret;
> +	return 0;
>  }

>  static int rtw_p2p_get_wps_configmethod(struct net_device *dev,
>  			       struct iw_request_info *info,
>  			       union iwreq_data *wrqu, char *extra)
>  {
> -	int ret = 0;
>  	struct adapter *padapter = (struct adapter *)rtw_netdev_priv(dev);
>  	u8 peerMAC[ETH_ALEN] = {0x00};
>  	int jj, kk;
> @@ -2681,14 +2669,13 @@ static int rtw_p2p_get_wps_configmethod(struct net_device *dev,

>  	if (copy_to_user(wrqu->data.pointer, attr_content_str, 6 + 17))
>  		return -EFAULT;
> -	return ret;
> +	return 0;
>  }

>  static int rtw_p2p_get_go_device_address(struct net_device *dev,
>  			       struct iw_request_info *info,
>  			       union iwreq_data *wrqu, char *extra)
>  {
> -	int ret = 0;
>  	struct adapter *padapter = (struct adapter *)rtw_netdev_priv(dev);
>  	u8 peerMAC[ETH_ALEN] = {0x00};
>  	int jj, kk;
> @@ -2764,14 +2751,13 @@ static int rtw_p2p_get_go_device_address(struct net_device *dev,

>  	if (copy_to_user(wrqu->data.pointer, go_devadd_str, 10 + 17))
>  		return -EFAULT;
> -	return ret;
> +	return 0;
>  }

>  static int rtw_p2p_get_device_type(struct net_device *dev,
>  			       struct iw_request_info *info,
>  			       union iwreq_data *wrqu, char *extra)
>  {
> -	int ret = 0;
>  	struct adapter *padapter = (struct adapter *)rtw_netdev_priv(dev);
>  	u8 peerMAC[ETH_ALEN] = {0x00};
>  	int jj, kk;
> @@ -2840,14 +2826,13 @@ static int rtw_p2p_get_device_type(struct net_device *dev,
>  		return -EFAULT;
>  	}

> -	return ret;
> +	return 0;
>  }

>  static int rtw_p2p_get_device_name(struct net_device *dev,
>  			       struct iw_request_info *info,
>  			       union iwreq_data *wrqu, char *extra)
>  {
> -	int ret = 0;
>  	struct adapter *padapter = (struct adapter *)rtw_netdev_priv(dev);
>  	u8 peerMAC[ETH_ALEN] = {0x00};
>  	int jj, kk;
> @@ -2906,14 +2891,13 @@ static int rtw_p2p_get_device_name(struct net_device *dev,

>  	if (copy_to_user(wrqu->data.pointer, dev_name_str, 5 + ((dev_len > 17) ? dev_len : 17)))
>  		return -EFAULT;
> -	return ret;
> +	return 0;
>  }

>  static int rtw_p2p_get_invitation_procedure(struct net_device *dev,
>  			       struct iw_request_info *info,
>  			       union iwreq_data *wrqu, char *extra)
>  {
> -	int ret = 0;
>  	struct adapter *padapter = (struct adapter *)rtw_netdev_priv(dev);
>  	u8 peerMAC[ETH_ALEN] = {0x00};
>  	int jj, kk;
> @@ -2982,7 +2966,7 @@ static int rtw_p2p_get_invitation_procedure(struct net_device *dev,
>  	}
>  	if (copy_to_user(wrqu->data.pointer, inv_proc_str, 8 + 17))
>  		return -EFAULT;
> -	return ret;
> +	return 0;
>  }

>  static int rtw_p2p_connect(struct net_device *dev,
> @@ -3068,7 +3052,6 @@ static int rtw_p2p_invite_req(struct net_device *dev,
>  			      struct iw_request_info *info,
>  			      union iwreq_data *wrqu, char *extra)
>  {
> -	int ret = 0;
>  	struct adapter *padapter = (struct adapter *)rtw_netdev_priv(dev);
>  	struct wifidirect_info *pwdinfo = &padapter->wdinfo;
>  	int jj, kk;
> @@ -3092,12 +3075,12 @@ static int rtw_p2p_invite_req(struct net_device *dev,

>  	if (wrqu->data.length <=  37) {
>  		DBG_88E("[%s] Wrong format!\n", __func__);
> -		return ret;
> +		return 0;
>  	}

>  	if (rtw_p2p_chk_state(pwdinfo, P2P_STATE_NONE)) {
>  		DBG_88E("[%s] WiFi Direct is disable!\n", __func__);
> -		return ret;
> +		return 0;
>  	} else {
>  		/*	Reset the content of struct tx_invite_req_info */
>  		pinvite_req_info->benable = false;
> @@ -3170,14 +3153,13 @@ static int rtw_p2p_invite_req(struct net_device *dev,
>  	} else {
>  		DBG_88E("[%s] NOT Found in the Scanning Queue!\n", __func__);
>  	}
> -	return ret;
> +	return 0;
>  }

>  static int rtw_p2p_set_persistent(struct net_device *dev,
>  			       struct iw_request_info *info,
>  			       union iwreq_data *wrqu, char *extra)
>  {
> -	int ret = 0;
>  	struct adapter *padapter = (struct adapter *)rtw_netdev_priv(dev);
>  	struct wifidirect_info *pwdinfo = &padapter->wdinfo;

> @@ -3189,7 +3171,7 @@ static int rtw_p2p_set_persistent(struct net_device *dev,

>  	if (rtw_p2p_chk_state(pwdinfo, P2P_STATE_NONE)) {
>  		DBG_88E("[%s] WiFi Direct is disable!\n", __func__);
> -		return ret;
> +		return 0;
>  	} else {
>  		if (extra[0] == '0')	/*	Disable the persistent group function. */
>  			pwdinfo->persistent_supported = false;
> @@ -3199,14 +3181,13 @@ static int rtw_p2p_set_persistent(struct net_device *dev,
>  			pwdinfo->persistent_supported = false;
>  	}
>  	pr_info("[%s] persistent_supported = %d\n", __func__, pwdinfo->persistent_supported);
> -	return ret;
> +	return 0;
>  }

>  static int rtw_p2p_prov_disc(struct net_device *dev,
>  			       struct iw_request_info *info,
>  			       union iwreq_data *wrqu, char *extra)
>  {
> -	int ret = 0;
>  	struct adapter *padapter = (struct adapter *)rtw_netdev_priv(dev);
>  	struct wifidirect_info *pwdinfo = &padapter->wdinfo;
>  	u8 peerMAC[ETH_ALEN] = {0x00};
> @@ -3232,7 +3213,7 @@ static int rtw_p2p_prov_disc(struct net_device *dev,

>  	if (pwdinfo->p2p_state == P2P_STATE_NONE) {
>  		DBG_88E("[%s] WiFi Direct is disable!\n", __func__);
> -		return ret;
> +		return 0;
>  	} else {
>  		/*	Reset the content of struct tx_provdisc_req_info excluded the wps_config_method_request. */
>  		memset(pwdinfo->tx_prov_disc_info.peerDevAddr, 0x00, ETH_ALEN);
> @@ -3256,7 +3237,7 @@ static int rtw_p2p_prov_disc(struct net_device *dev,
>  		pwdinfo->tx_prov_disc_info.wps_config_method_request = WPS_CM_LABEL;
>  	} else {
>  		DBG_88E("[%s] Unknown WPS config methodn", __func__);
> -		return ret;
> +		return 0;
>  	}

>  	spin_lock_bh(&pmlmepriv->scanned_queue.lock);
> @@ -3328,7 +3309,7 @@ static int rtw_p2p_prov_disc(struct net_device *dev,
>  	} else {
>  		DBG_88E("[%s] NOT Found in the Scanning Queue!\n", __func__);
>  	}
> -	return ret;
> +	return 0;
>  }

>  /*	This function is used to inform the driver the user had specified the pin code value or pbc */
> @@ -3338,7 +3319,6 @@ static int rtw_p2p_got_wpsinfo(struct net_device *dev,
>  			       struct iw_request_info *info,
>  			       union iwreq_data *wrqu, char *extra)
>  {
> -	int ret = 0;
>  	struct adapter *padapter = (struct adapter *)rtw_netdev_priv(dev);
>  	struct wifidirect_info *pwdinfo = &padapter->wdinfo;

> @@ -3359,15 +3339,13 @@ static int rtw_p2p_got_wpsinfo(struct net_device *dev,
>  		pwdinfo->ui_got_wps_info = P2P_GOT_WPSINFO_PBC;
>  	else
>  		pwdinfo->ui_got_wps_info = P2P_NO_WPSINFO;
> -	return ret;
> +	return 0;
>  }

>  static int rtw_p2p_set(struct net_device *dev,
>  			       struct iw_request_info *info,
>  			       union iwreq_data *wrqu, char *extra)
>  {
> -	int ret = 0;
> -
>  	DBG_88E("[%s] extra = %s\n", __func__, extra);
>  	if (!memcmp(extra, "enable =", 7)) {
>  		rtw_wext_p2p_enable(dev, info, wrqu, &extra[7]);
> @@ -3415,15 +3393,13 @@ static int rtw_p2p_set(struct net_device *dev,
>  		rtw_p2p_set_persistent(dev, info, wrqu, &extra[11]);
>  	}

> -	return ret;
> +	return 0;
>  }

>  static int rtw_p2p_get(struct net_device *dev,
>  			       struct iw_request_info *info,
>  			       union iwreq_data *wrqu, char *extra)
>  {
> -	int ret = 0;
> -
>  	struct adapter *padapter = (struct adapter *)rtw_netdev_priv(dev);

>  	if (padapter->bShowGetP2PState)
> @@ -3447,15 +3423,13 @@ static int rtw_p2p_get(struct net_device *dev,
>  	} else if (!memcmp(wrqu->data.pointer, "op_ch", 5)) {
>  		rtw_p2p_get_op_ch(dev, info, wrqu, extra);
>  	}
> -	return ret;
> +	return 0;
>  }

>  static int rtw_p2p_get2(struct net_device *dev,
>  			       struct iw_request_info *info,
>  			       union iwreq_data *wrqu, char *extra)
>  {
> -	int ret = 0;
> -
>  	DBG_88E("[%s] extra = %s\n", __func__, (char *)wrqu->data.pointer);
>  	if (!memcmp(extra, "wpsCM =", 6)) {
>  		wrqu->data.length -= 6;
> @@ -3474,7 +3448,7 @@ static int rtw_p2p_get2(struct net_device *dev,
>  		rtw_p2p_get_invitation_procedure(dev, info, wrqu, &extra[8]);
>  	}

> -	return ret;
> +	return 0;
>  }

>  static int rtw_rereg_nd_name(struct net_device *dev,
> -- 
> 2.34.1

Acked-by: Martin Kaiser <martin@kaiser.cx>
