Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DE6D4F8D69
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 08:25:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234959AbiDHFpm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 01:45:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234938AbiDHFpi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 01:45:38 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DFD64199531
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 22:43:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649396614;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=A3+os2wVgYd8BmldoUQAq+zPiIq7FsagN51Ze5zNQqg=;
        b=APgHzqCbWt0cxtuVSlySvQ7m+ExlkLRRrOSUW58YeXdpyi4zjJSEJ1oSi7ICfepj6jtnP9
        IrTajCJ4PzudoPWXSPW/S27DaJLrKFTTAL74eIeB1rh0co9EM0eG+kYlwBqiw7Z8fl19C9
        g//0//w+jrU81aDWPCtktGpCWcIdAbs=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-10-DLoiNp9qOkmQqGvR7OtGrg-1; Fri, 08 Apr 2022 01:43:30 -0400
X-MC-Unique: DLoiNp9qOkmQqGvR7OtGrg-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 36EC03811A3C;
        Fri,  8 Apr 2022 05:43:29 +0000 (UTC)
Received: from maya.cloud.tilaa.com (unknown [10.40.208.6])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 11291401475;
        Fri,  8 Apr 2022 05:43:28 +0000 (UTC)
Date:   Fri, 8 Apr 2022 07:43:12 +0200
From:   Stefano Brivio <sbrivio@redhat.com>
To:     Jaehee Park <jhpark1013@gmail.com>
Cc:     =?UTF-8?B?SsOpcsO0bWU=?= Pouiller <jerome.pouiller@silabs.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        outreachy@lists.linux.dev,
        Alison Schofield <alison.schofield@intel.com>
Subject: Re: [PATCH v2] staging: wfx: use container_of() to get vif
Message-ID: <20220408074312.61d297fa@elisabeth>
In-Reply-To: <20220408032349.GA2132476@jaehee-ThinkPad-X1-Extreme>
References: <20220408032349.GA2132476@jaehee-ThinkPad-X1-Extreme>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.10
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jaehee,

Congrats, almost there! This wasn't necessarily an easy change.

A general comment first: please wait a bit longer between re-postings.
I received the first patch at 21:50 UTC+2 (my local time), and the
second one at 5:23 UTC+2.

I could have shared most of the comments below already on your first
patch, if only I had time to read it. I think something between 12 to
15 hours would be appropriate.

Now, to the patch:

On Thu, 7 Apr 2022 23:23:49 -0400
Jaehee Park <jhpark1013@gmail.com> wrote:

> Use container_of() to get vif. This improves the code in two ways:
> [1] it speeds up the compilation because container_of() saves steps to
> retrieve vif (the representation of ieee80211_vif), and

"[1] " looks like a reference, perhaps use "- " or "1. " instead.

It would be good to follow the guidelines at:
	https://www.kernel.org/doc/html/latest/process/submitting-patches.html#des=
cribe-changes

...starting from the problem description, even if it's a bit obvious
here. For example:

	Currently, upon virtual interface creation,
	wfx_add_interface() stores a references to the
	corresponding struct ieee80211_vif in private data, for later
	usage. This is not needed as ...

	Use container_of() instead. This...

> [2] it eliminates the need to define multiple pointers. Previously,
> after setting the pointer to drv_priv, another pointer had to be
> defined by vif in struct wfx_vif to point back to ieee80211_vif.
> Remove vif from the struct wfx_vif, define a macro wvif_to_vif(ptr)
> for container_of(), and replace all wvif->vif with the newly defined
> container_of() construct.
>=20
> Signed-off-by: Jaehee Park <jhpark1013@gmail.com>
> ---
> Note:=20
> This is a revised patch to sequence the wfx.h file (with the new defines)=
 to show up first on the diff, which makes the ordering of the diff more lo=
gical.

Trim your lines at something between 70 and 76 columns, even if it's
not part of the commit message -- that will make it easier to reply.

One additional note given where this patch will need to go: for net and
net-next trees, you're required to describe the change log at the end
of the commit message itself. That's an exception compared to other
trees (including staging -- where adding the commit log here is
appropriate).

> Questions:
> - These changes had built=C2=A0without errors for me but it would be grea=
t if someone can test it on the actual hardware.
> - We noticed that the=C2=A0development of the wfx driver is happening in =
the netdev tree instead of Greg's tree. Do you suggest that I use the net-n=
ext tree for this change?=C2=A0
> https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git/log/d=
rivers/staging/wfx
> https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git/log/dr=
ivers/staging/wfx
>=20
> drivers/staging/wfx/wfx.h     |  3 ++-
>  drivers/staging/wfx/data_rx.c |  4 ++--
>  drivers/staging/wfx/data_tx.c |  2 +-
>  drivers/staging/wfx/key.c     |  3 +--
>  drivers/staging/wfx/queue.c   |  2 +-
>  drivers/staging/wfx/scan.c    |  6 ++---
>  drivers/staging/wfx/sta.c     | 45 ++++++++++++++++-------------------
>  7 files changed, 31 insertions(+), 34 deletions(-)
>=20
> diff --git a/drivers/staging/wfx/wfx.h b/drivers/staging/wfx/wfx.h
> index 6594cc647c2f..78f2a416fe4f 100644
> --- a/drivers/staging/wfx/wfx.h
> +++ b/drivers/staging/wfx/wfx.h
> @@ -25,6 +25,8 @@
>  #define USEC_PER_TXOP 32 /* see struct ieee80211_tx_queue_params */
>  #define USEC_PER_TU 1024
> =20
> +#define wvif_to_vif(ptr)(container_of((void *)ptr, struct ieee80211_vif,=
 drv_priv))

On top of what Greg said (you're missing a space there) the line is also
too long, you can split it by doing something like:

#define wvif_to_vif(...)					\
	container_of(...)

also:

- parentheses around container_of() are not necessary

- "ptr"? It's obvious that it's a pointer, given the cast. "wvif" would
  be more descriptive

> +
>  struct wfx_hwbus_ops;
> =20
>  struct wfx_dev {
> @@ -61,7 +63,6 @@ struct wfx_dev {
> =20
>  struct wfx_vif {
>  	struct wfx_dev             *wdev;
> -	struct ieee80211_vif       *vif;
>  	struct ieee80211_channel   *channel;
>  	int                        id;
> =20
> diff --git a/drivers/staging/wfx/data_rx.c b/drivers/staging/wfx/data_rx.c
> index a4b5ffe158e4..98c2223089b8 100644
> --- a/drivers/staging/wfx/data_rx.c
> +++ b/drivers/staging/wfx/data_rx.c
> @@ -24,12 +24,12 @@ static void wfx_rx_handle_ba(struct wfx_vif *wvif, st=
ruct ieee80211_mgmt *mgmt)
>  	case WLAN_ACTION_ADDBA_REQ:
>  		params =3D le16_to_cpu(mgmt->u.action.u.addba_req.capab);
>  		tid =3D (params & IEEE80211_ADDBA_PARAM_TID_MASK) >> 2;
> -		ieee80211_start_rx_ba_session_offl(wvif->vif, mgmt->sa, tid);
> +		ieee80211_start_rx_ba_session_offl(wvif_to_vif(wvif), mgmt->sa, tid);

Staying under 80 columns is preferred:
	https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/=
?id=3Dbdc48fa11e46f867ea4d75fa59ee87a7f48be144

but checkpatch.pl won't report this. Perhaps to_vif() would be
descriptive enough, or you could also just split this line.

Or, even better, especially if you have several usages in a function:
just grab one reference to vif at the beginning of the function, and
use that instead.

>  		break;
>  	case WLAN_ACTION_DELBA:
>  		params =3D le16_to_cpu(mgmt->u.action.u.delba.params);
>  		tid =3D (params &  IEEE80211_DELBA_PARAM_TID_MASK) >> 12;
> -		ieee80211_stop_rx_ba_session_offl(wvif->vif, mgmt->sa, tid);
> +		ieee80211_stop_rx_ba_session_offl(wvif_to_vif(wvif), mgmt->sa, tid);

Same here.

>  		break;
>  	}
>  }
> diff --git a/drivers/staging/wfx/data_tx.c b/drivers/staging/wfx/data_tx.c
> index e07381b2ff4d..fd79e03a08c5 100644
> --- a/drivers/staging/wfx/data_tx.c
> +++ b/drivers/staging/wfx/data_tx.c
> @@ -216,7 +216,7 @@ static u8 wfx_tx_get_link_id(struct wfx_vif *wvif, st=
ruct ieee80211_sta *sta,
> =20
>  	if (sta_priv && sta_priv->link_id)
>  		return sta_priv->link_id;
> -	if (wvif->vif->type !=3D NL80211_IFTYPE_AP)
> +	if (wvif_to_vif(wvif)->type !=3D NL80211_IFTYPE_AP)
>  		return 0;
>  	if (is_multicast_ether_addr(da))
>  		return 0;
> diff --git a/drivers/staging/wfx/key.c b/drivers/staging/wfx/key.c
> index 8f23e8d42bd4..71b1fca70248 100644
> --- a/drivers/staging/wfx/key.c
> +++ b/drivers/staging/wfx/key.c
> @@ -174,7 +174,7 @@ static int wfx_add_key(struct wfx_vif *wvif, struct i=
eee80211_sta *sta,
>  			k.type =3D fill_tkip_pair(&k.key.tkip_pairwise_key, key, sta->addr);
>  		else
>  			k.type =3D fill_tkip_group(&k.key.tkip_group_key, key, &seq,
> -						 wvif->vif->type);
> +						 wvif_to_vif(wvif)->type);
>  	} else if (key->cipher =3D=3D WLAN_CIPHER_SUITE_CCMP) {
>  		if (pairwise)
>  			k.type =3D fill_ccmp_pair(&k.key.aes_pairwise_key, key, sta->addr);
> @@ -224,4 +224,3 @@ int wfx_set_key(struct ieee80211_hw *hw, enum set_key=
_cmd cmd, struct ieee80211_
>  	mutex_unlock(&wvif->wdev->conf_mutex);
>  	return ret;
>  }
> -
> diff --git a/drivers/staging/wfx/queue.c b/drivers/staging/wfx/queue.c
> index 729825230db2..a2745d1024c6 100644
> --- a/drivers/staging/wfx/queue.c
> +++ b/drivers/staging/wfx/queue.c
> @@ -207,7 +207,7 @@ bool wfx_tx_queues_has_cab(struct wfx_vif *wvif)
>  {
>  	int i;
> =20
> -	if (wvif->vif->type !=3D NL80211_IFTYPE_AP)
> +	if (wvif_to_vif(wvif)->type !=3D NL80211_IFTYPE_AP)
>  		return false;
>  	for (i =3D 0; i < IEEE80211_NUM_ACS; ++i)
>  		/* Note: since only AP can have mcast frames in queue and only one vif=
 can be AP,
> diff --git a/drivers/staging/wfx/scan.c b/drivers/staging/wfx/scan.c
> index 7f34f0d322f9..5c25fde3fc41 100644
> --- a/drivers/staging/wfx/scan.c
> +++ b/drivers/staging/wfx/scan.c
> @@ -25,7 +25,7 @@ static int update_probe_tmpl(struct wfx_vif *wvif, stru=
ct cfg80211_scan_request
>  {
>  	struct sk_buff *skb;
> =20
> -	skb =3D ieee80211_probereq_get(wvif->wdev->hw, wvif->vif->addr, NULL, 0=
, req->ie_len);
> +	skb =3D ieee80211_probereq_get(wvif->wdev->hw, wvif_to_vif(wvif)->addr,=
 NULL, 0, req->ie_len);

...and here,

>  	if (!skb)
>  		return -ENOMEM;
> =20
> @@ -75,8 +75,8 @@ static int send_scan_req(struct wfx_vif *wvif, struct c=
fg80211_scan_request *req
>  	} else {
>  		ret =3D wvif->scan_nb_chan_done;
>  	}
> -	if (req->channels[start_idx]->max_power !=3D wvif->vif->bss_conf.txpowe=
r)
> -		wfx_hif_set_output_power(wvif, wvif->vif->bss_conf.txpower);
> +	if (req->channels[start_idx]->max_power !=3D wvif_to_vif(wvif)->bss_con=
f.txpower)
> +		wfx_hif_set_output_power(wvif, wvif_to_vif(wvif)->bss_conf.txpower);


>  	wfx_tx_unlock(wvif->wdev);
>  	return ret;
>  }
> diff --git a/drivers/staging/wfx/sta.c b/drivers/staging/wfx/sta.c
> index 03025ef7f1be..b634c8e004db 100644
> --- a/drivers/staging/wfx/sta.c
> +++ b/drivers/staging/wfx/sta.c
> @@ -132,7 +132,7 @@ void wfx_configure_filter(struct ieee80211_hw *hw, un=
signed int changed_flags,
>  			filter_bssid =3D true;
> =20
>  		/* In AP mode, chip can reply to probe request itself */
> -		if (*total_flags & FIF_PROBE_REQ && wvif->vif->type =3D=3D NL80211_IFT=
YPE_AP) {
> +		if (*total_flags & FIF_PROBE_REQ && wvif_to_vif(wvif)->type =3D=3D NL8=
0211_IFTYPE_AP) {

and here,

>  			dev_dbg(wdev->dev, "do not forward probe request in AP mode\n");
>  			*total_flags &=3D ~FIF_PROBE_REQ;
>  		}
> @@ -153,18 +153,18 @@ static int wfx_get_ps_timeout(struct wfx_vif *wvif,=
 bool *enable_ps)
>  	struct ieee80211_channel *chan0 =3D NULL, *chan1 =3D NULL;
>  	struct ieee80211_conf *conf =3D &wvif->wdev->hw->conf;
> =20
> -	WARN(!wvif->vif->bss_conf.assoc && enable_ps,
> +	WARN(!wvif_to_vif(wvif)->bss_conf.assoc && enable_ps,
>  	     "enable_ps is reliable only if associated");
>  	if (wdev_to_wvif(wvif->wdev, 0))
> -		chan0 =3D wdev_to_wvif(wvif->wdev, 0)->vif->bss_conf.chandef.chan;
> +		chan0 =3D wvif_to_vif(wdev_to_wvif(wvif->wdev, 0))->bss_conf.chandef.c=
han;
>  	if (wdev_to_wvif(wvif->wdev, 1))
> -		chan1 =3D wdev_to_wvif(wvif->wdev, 1)->vif->bss_conf.chandef.chan;
> -	if (chan0 && chan1 && wvif->vif->type !=3D NL80211_IFTYPE_AP) {
> +		chan1 =3D wvif_to_vif(wdev_to_wvif(wvif->wdev, 1))->bss_conf.chandef.c=
han;
> +	if (chan0 && chan1 && wvif_to_vif(wvif)->type !=3D NL80211_IFTYPE_AP) {
>  		if (chan0->hw_value =3D=3D chan1->hw_value) {
>  			/* It is useless to enable PS if channels are the same. */
>  			if (enable_ps)
>  				*enable_ps =3D false;
> -			if (wvif->vif->bss_conf.assoc && wvif->vif->bss_conf.ps)
> +			if (wvif_to_vif(wvif)->bss_conf.assoc && wvif_to_vif(wvif)->bss_conf.=
ps)
>  				dev_info(wvif->wdev->dev, "ignoring requested PS mode");
>  			return -1;
>  		}
> @@ -177,8 +177,8 @@ static int wfx_get_ps_timeout(struct wfx_vif *wvif, b=
ool *enable_ps)
>  			return 30;
>  	}
>  	if (enable_ps)
> -		*enable_ps =3D wvif->vif->bss_conf.ps;
> -	if (wvif->vif->bss_conf.assoc && wvif->vif->bss_conf.ps)
> +		*enable_ps =3D wvif_to_vif(wvif)->bss_conf.ps;
> +	if (wvif_to_vif(wvif)->bss_conf.assoc && wvif_to_vif(wvif)->bss_conf.ps)
>  		return conf->dynamic_ps_timeout;
>  	else
>  		return -1;
> @@ -189,7 +189,7 @@ int wfx_update_pm(struct wfx_vif *wvif)
>  	int ps_timeout;
>  	bool ps;
> =20
> -	if (!wvif->vif->bss_conf.assoc)
> +	if (!wvif_to_vif(wvif)->bss_conf.assoc)
>  		return 0;
>  	ps_timeout =3D wfx_get_ps_timeout(wvif, &ps);
>  	if (!ps)
> @@ -215,7 +215,7 @@ int wfx_conf_tx(struct ieee80211_hw *hw, struct ieee8=
0211_vif *vif,
>  	mutex_lock(&wdev->conf_mutex);
>  	assign_bit(queue, &wvif->uapsd_mask, params->uapsd);
>  	wfx_hif_set_edca_queue_params(wvif, queue, params);
> -	if (wvif->vif->type =3D=3D NL80211_IFTYPE_STATION && old_uapsd !=3D wvi=
f->uapsd_mask) {
> +	if (wvif_to_vif(wvif)->type =3D=3D NL80211_IFTYPE_STATION && old_uapsd =
!=3D wvif->uapsd_mask) {
>  		wfx_hif_set_uapsd_info(wvif, wvif->uapsd_mask);
>  		wfx_update_pm(wvif);
>  	}
> @@ -242,20 +242,20 @@ void wfx_event_report_rssi(struct wfx_vif *wvif, u8=
 raw_rcpi_rssi)
>  	int cqm_evt;
> =20
>  	rcpi_rssi =3D raw_rcpi_rssi / 2 - 110;
> -	if (rcpi_rssi <=3D wvif->vif->bss_conf.cqm_rssi_thold)
> +	if (rcpi_rssi <=3D wvif_to_vif(wvif)->bss_conf.cqm_rssi_thold)
>  		cqm_evt =3D NL80211_CQM_RSSI_THRESHOLD_EVENT_LOW;
>  	else
>  		cqm_evt =3D NL80211_CQM_RSSI_THRESHOLD_EVENT_HIGH;
> -	ieee80211_cqm_rssi_notify(wvif->vif, cqm_evt, rcpi_rssi, GFP_KERNEL);
> +	ieee80211_cqm_rssi_notify(wvif_to_vif(wvif), cqm_evt, rcpi_rssi, GFP_KE=
RNEL);
>  }
> =20
>  static void wfx_beacon_loss_work(struct work_struct *work)
>  {
>  	struct wfx_vif *wvif =3D container_of(to_delayed_work(work), struct wfx=
_vif,
>  					    beacon_loss_work);
> -	struct ieee80211_bss_conf *bss_conf =3D &wvif->vif->bss_conf;
> +	struct ieee80211_bss_conf *bss_conf =3D &wvif_to_vif(wvif)->bss_conf;
> =20
> -	ieee80211_beacon_loss(wvif->vif);
> +	ieee80211_beacon_loss(wvif_to_vif(wvif));
>  	schedule_delayed_work(to_delayed_work(work), msecs_to_jiffies(bss_conf-=
>beacon_int));
>  }
> =20
> @@ -323,13 +323,13 @@ static int wfx_upload_ap_templates(struct wfx_vif *=
wvif)
>  {
>  	struct sk_buff *skb;
> =20
> -	skb =3D ieee80211_beacon_get(wvif->wdev->hw, wvif->vif);
> +	skb =3D ieee80211_beacon_get(wvif->wdev->hw, wvif_to_vif(wvif));
>  	if (!skb)
>  		return -ENOMEM;
>  	wfx_hif_set_template_frame(wvif, skb, HIF_TMPLT_BCN, API_RATE_INDEX_B_1=
MBPS);
>  	dev_kfree_skb(skb);
> =20
> -	skb =3D ieee80211_proberesp_get(wvif->wdev->hw, wvif->vif);
> +	skb =3D ieee80211_proberesp_get(wvif->wdev->hw, wvif_to_vif(wvif));
>  	if (!skb)
>  		return -ENOMEM;
>  	wfx_hif_set_template_frame(wvif, skb, HIF_TMPLT_PRBRES, API_RATE_INDEX_=
B_1MBPS);
> @@ -339,7 +339,7 @@ static int wfx_upload_ap_templates(struct wfx_vif *wv=
if)
> =20
>  static void wfx_set_mfp_ap(struct wfx_vif *wvif)
>  {
> -	struct sk_buff *skb =3D ieee80211_beacon_get(wvif->wdev->hw, wvif->vif);
> +	struct sk_buff *skb =3D ieee80211_beacon_get(wvif->wdev->hw, wvif_to_vi=
f(wvif));
>  	const int ieoffset =3D offsetof(struct ieee80211_mgmt, u.beacon.variabl=
e);
>  	const u16 *ptr =3D (u16 *)cfg80211_find_ie(WLAN_EID_RSN, skb->data + ie=
offset,
>  						 skb->len - ieoffset);
> @@ -389,7 +389,7 @@ void wfx_stop_ap(struct ieee80211_hw *hw, struct ieee=
80211_vif *vif)
>  static void wfx_join(struct wfx_vif *wvif)
>  {
>  	int ret;
> -	struct ieee80211_bss_conf *conf =3D &wvif->vif->bss_conf;
> +	struct ieee80211_bss_conf *conf =3D &wvif_to_vif(wvif)->bss_conf;
>  	struct cfg80211_bss *bss =3D NULL;
>  	u8 ssid[IEEE80211_MAX_SSID_LEN];
>  	const u8 *ssid_ie =3D NULL;
> @@ -420,7 +420,7 @@ static void wfx_join(struct wfx_vif *wvif)
>  	wvif->join_in_progress =3D true;
>  	ret =3D wfx_hif_join(wvif, conf, wvif->channel, ssid, ssid_len);
>  	if (ret) {
> -		ieee80211_connection_loss(wvif->vif);
> +		ieee80211_connection_loss(wvif_to_vif(wvif));
>  		wfx_reset(wvif);
>  	} else {
>  		/* Due to beacon filtering it is possible that the AP's beacon is not =
known for the
> @@ -440,7 +440,7 @@ static void wfx_join_finalize(struct wfx_vif *wvif, s=
truct ieee80211_bss_conf *i
> =20
>  	rcu_read_lock(); /* protect sta */
>  	if (info->bssid && !info->ibss_joined)
> -		sta =3D ieee80211_find_sta(wvif->vif, info->bssid);
> +		sta =3D ieee80211_find_sta(wvif_to_vif(wvif), info->bssid);
>  	if (sta && sta->ht_cap.ht_supported)
>  		ampdu_density =3D sta->ht_cap.ampdu_density;
>  	if (sta && sta->ht_cap.ht_supported &&
> @@ -565,7 +565,7 @@ static int wfx_update_tim(struct wfx_vif *wvif)
>  	u16 tim_offset, tim_length;
>  	u8 *tim_ptr;
> =20
> -	skb =3D ieee80211_beacon_get_tim(wvif->wdev->hw, wvif->vif, &tim_offset=
, &tim_length);
> +	skb =3D ieee80211_beacon_get_tim(wvif->wdev->hw, wvif_to_vif(wvif), &ti=
m_offset, &tim_length);
>  	if (!skb)
>  		return -ENOENT;
>  	tim_ptr =3D skb->data + tim_offset;
> @@ -707,8 +707,6 @@ int wfx_add_interface(struct ieee80211_hw *hw, struct=
 ieee80211_vif *vif)
>  		return -EOPNOTSUPP;
>  	}
> =20
> -	/* FIXME: prefer use of container_of() to get vif */
> -	wvif->vif =3D vif;
>  	wvif->wdev =3D wdev;
> =20
>  	wvif->link_id_map =3D 1; /* link-id 0 is reserved for multicast */
> @@ -767,7 +765,6 @@ void wfx_remove_interface(struct ieee80211_hw *hw, st=
ruct ieee80211_vif *vif)
> =20
>  	cancel_delayed_work_sync(&wvif->beacon_loss_work);
>  	wdev->vif[wvif->id] =3D NULL;
> -	wvif->vif =3D NULL;
> =20
>  	mutex_unlock(&wdev->conf_mutex);
> =20

The rest looks good to me, except that, as Alison and Greg pointed out,
this isn't in staging anymore:
	https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git/commit/=
?h=3Dstaging-next&id=3D4a5fb1bbcdf1cccae1f6b9c0277b3796b2a468ef

-- even if it was when we first discussed this change, and also,
as you already mentioned, you'll need to find somebody to test this on
actual hardware.

--=20
Stefano

