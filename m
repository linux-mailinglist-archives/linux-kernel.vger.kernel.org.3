Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E48274B7C35
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 02:12:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245290AbiBPBHd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 20:07:33 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:53058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245268AbiBPBH0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 20:07:26 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30ABBED941
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 17:07:14 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id w11so844484wra.4
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 17:07:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=p/TDwugZ5mbD8UvFyeCHWaqjYIqieiYST57lq5R6MpQ=;
        b=t0coWrJjZXKBN319xUcQkT35zOgyl6xHdBHml7zYue2Zbkyye6PGHxxnTVw5ISLsM/
         euRpRiZ8qgSM3w5/tbGbP96dbOlX7ORtGf7ltNqSeNglntxfmZV6nR3+vb7dQvRKkvYI
         psUUSajLl+N291HnySOkBZLCg/Q8Omow9hE7S5pX/efYcazo5KU11fq+ofR7cOqASPgX
         bXClw89RGdkFIneTWa/AgPBesrrEuw0J/GU7NME7VAMuzS3iWaDMsVBSDCfxVVMlyOn0
         Ox8zb/EPjAr/pJhZ/oiBcb/vQSW6IVMQMDXZhpC30wb6Cz1qsPipL4jLR+Bi7NcLhxqB
         nxjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=p/TDwugZ5mbD8UvFyeCHWaqjYIqieiYST57lq5R6MpQ=;
        b=1fPYeON91DPA9UykAWvf6aTQRIp3LaowNacmSt/GPxhpoOFSNe2xhw6GwtD8ITOhLk
         VEjfw8Qf1SWWlZlnpmndEa8TzEAr42upCIWJ6ldX185D/dDN8jTT/4p+DpoFdV2oN5YH
         Y2yGQgA6g7NEabVpj1jw6FhC+TSn7DEKBetbIadi3G05NZtLb6ofjymRyZEhneClIn0J
         JSfhQ7ax9JVssBYSbzNI/BHfC0ho0i3AcqnYkssu0q5VOZPxv6aRghJqUd3vZV2uVmqS
         EKpfUy1B7CMPm3MvWb8oGyQ3YE911vbzVZh66LOtADTpfsq2QeR5v3yL56Vxo6oioEaE
         jWxg==
X-Gm-Message-State: AOAM5305g0OD3Jig3fBfZHEN+glF/+wjr+HEMY4va1dOKoqACR/uiPaA
        NmiSAXsslVUkaE+HYegL7Hk3Ig==
X-Google-Smtp-Source: ABdhPJxAAsZYVai7pHXoOhjsMcrRQGpqIbNTJuP0wAWvTJvDYSGYmlYmq4fTYRzGN5yxl+9ZMAOyPg==
X-Received: by 2002:a05:6000:1b04:b0:1e7:3a09:6468 with SMTP id f4-20020a0560001b0400b001e73a096468mr355713wrz.383.1644973632481;
        Tue, 15 Feb 2022 17:07:12 -0800 (PST)
Received: from localhost.localdomain (3.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.6.1.f.d.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:df16::3])
        by smtp.gmail.com with ESMTPSA id m8sm10551185wms.4.2022.02.15.17.07.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Feb 2022 17:07:12 -0800 (PST)
From:   Phillip Potter <phil@philpotter.co.uk>
To:     gregkh@linuxfoundation.org
Cc:     dan.carpenter@oracle.com, Larry.Finger@lwfinger.net,
        straube.linux@gmail.com, martin@kaiser.cx,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        paskripkin@gmail.com
Subject: [PATCH v2 02/15] staging: r8188eu: remove smaller sets of converted DBG_88E calls
Date:   Wed, 16 Feb 2022 01:06:56 +0000
Message-Id: <20220216010709.791-3-phil@philpotter.co.uk>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220216010709.791-1-phil@philpotter.co.uk>
References: <20220216010709.791-1-phil@philpotter.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove all the smaller sets of dev_dbg/netdev_dbg/pr_debug calls that
were previously converted from DBG_88E. After some thought, it makes
more sense to just entirely strip all of these calls, so that debugging
code in the driver can be more consistent and useful going forwards.

Signed-off-by: Phillip Potter <phil@philpotter.co.uk>
---
 drivers/staging/r8188eu/core/rtw_ap.c         | 65 -------------------
 drivers/staging/r8188eu/core/rtw_cmd.c        |  8 ---
 drivers/staging/r8188eu/core/rtw_ieee80211.c  | 19 ------
 drivers/staging/r8188eu/core/rtw_ioctl_set.c  |  5 --
 drivers/staging/r8188eu/core/rtw_iol.c        |  6 --
 drivers/staging/r8188eu/core/rtw_mlme.c       | 57 +---------------
 drivers/staging/r8188eu/core/rtw_security.c   | 12 ----
 drivers/staging/r8188eu/core/rtw_sta_mgt.c    |  4 +-
 drivers/staging/r8188eu/core/rtw_xmit.c       | 17 +----
 .../staging/r8188eu/os_dep/usb_ops_linux.c    | 12 ----
 drivers/staging/r8188eu/os_dep/xmit_linux.c   |  3 -
 11 files changed, 4 insertions(+), 204 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_ap.c b/drivers/staging/r8188eu/core/rtw_ap.c
index 5e22b1baf9a5..505517dbbf8c 100644
--- a/drivers/staging/r8188eu/core/rtw_ap.c
+++ b/drivers/staging/r8188eu/core/rtw_ap.c
@@ -179,10 +179,6 @@ void	expire_timeout_chk(struct adapter *padapter)
 				list_del_init(&psta->auth_list);
 				pstapriv->auth_list_cnt--;
 
-				netdev_dbg(padapter->pnetdev,
-					   "auth expire %6ph\n",
-					   psta->hwaddr);
-
 				spin_unlock_bh(&pstapriv->auth_list_lock);
 
 				spin_lock_bh(&pstapriv->sta_hash_lock);
@@ -250,19 +246,11 @@ void	expire_timeout_chk(struct adapter *padapter)
 			list_del_init(&psta->asoc_list);
 			pstapriv->asoc_list_cnt--;
 
-			netdev_dbg(padapter->pnetdev,
-				   "asoc expire %pM, state = 0x%x\n",
-				   (psta->hwaddr), psta->state);
 			updated = ap_free_sta(padapter, psta, true, WLAN_REASON_DEAUTH_LEAVING);
 		} else {
 			/* TODO: Aging mechanism to digest frames in sleep_q to avoid running out of xmitframe */
 			if (psta->sleepq_len > (NR_XMITFRAME / pstapriv->asoc_list_cnt) &&
 			    padapter->xmitpriv.free_xmitframe_cnt < (NR_XMITFRAME / pstapriv->asoc_list_cnt / 2)) {
-				netdev_dbg(padapter->pnetdev,
-					   "sta:%pM, sleepq_len:%u, free_xmitframe_cnt:%u, asoc_list_cnt:%u, clear sleep_q\n",
-					   (psta->hwaddr), psta->sleepq_len,
-					   padapter->xmitpriv.free_xmitframe_cnt,
-					   pstapriv->asoc_list_cnt);
 				wakeup_sta_to_xmit(padapter, psta);
 			}
 		}
@@ -292,25 +280,16 @@ void	expire_timeout_chk(struct adapter *padapter)
 
 			psta->keep_alive_trycnt++;
 			if (ret == _SUCCESS) {
-				netdev_dbg(padapter->pnetdev,
-					   "asoc check, sta(%pM) is alive\n",
-					   (psta->hwaddr));
 				psta->expire_to = pstapriv->expire_to;
 				psta->keep_alive_trycnt = 0;
 				continue;
 			} else if (psta->keep_alive_trycnt <= 3) {
-				netdev_dbg(padapter->pnetdev,
-					   "ack check for asoc expire, keep_alive_trycnt =%d\n",
-					   psta->keep_alive_trycnt);
 				psta->expire_to = 1;
 				continue;
 			}
 
 			psta->keep_alive_trycnt = 0;
 
-			netdev_dbg(padapter->pnetdev,
-				   "asoc expire %pM, state = 0x%x\n",
-				   (psta->hwaddr), psta->state);
 			spin_lock_bh(&pstapriv->asoc_list_lock);
 			list_del_init(&psta->asoc_list);
 			pstapriv->asoc_list_cnt--;
@@ -390,10 +369,6 @@ void add_RATid(struct adapter *padapter, struct sta_info *psta, u8 rssi_level)
 
 		tx_ra_bitmap |= ((raid << 28) & 0xf0000000);
 
-		netdev_dbg(padapter->pnetdev,
-			   "mac_id:%d, raid:%d, bitmap = 0x%x, arg = 0x%x\n",
-			   psta->mac_id, raid, tx_ra_bitmap, arg);
-
 		/* bitmap[0:27] = tx_rate_bitmap */
 		/* bitmap[28:31]= Rate Adaptive id */
 		/* arg[0:4] = macid */
@@ -408,9 +383,6 @@ void add_RATid(struct adapter *padapter, struct sta_info *psta, u8 rssi_level)
 		psta->init_rate = init_rate;
 
 	} else {
-		netdev_dbg(padapter->pnetdev,
-			   "station aid %d exceed the max number\n",
-			   psta->aid);
 	}
 }
 
@@ -468,9 +440,6 @@ void update_bmc_sta(struct adapter *padapter)
 			arg = psta->mac_id & 0x1f;
 			arg |= BIT(7);
 			tx_ra_bitmap |= ((raid << 28) & 0xf0000000);
-			netdev_dbg(padapter->pnetdev,
-				   "mask = 0x%x, arg = 0x%x\n",
-				   tx_ra_bitmap, arg);
 
 			/* bitmap[0:27] = tx_rate_bitmap */
 			/* bitmap[28:31]= Rate Adaptive id */
@@ -489,7 +458,6 @@ void update_bmc_sta(struct adapter *padapter)
 		spin_unlock_bh(&psta->lock);
 
 	} else {
-		netdev_dbg(padapter->pnetdev, "add_RATid_bmc_sta error!\n");
 	}
 }
 
@@ -575,8 +543,6 @@ static void update_bcn_erpinfo_ie(struct adapter *padapter)
 	unsigned char *p, *ie = pnetwork->IEs;
 	u32 len = 0;
 
-	netdev_dbg(padapter->pnetdev, "ERP_enable = %d\n", pmlmeinfo->ERP_enable);
-
 	if (!pmlmeinfo->ERP_enable)
 		return;
 
@@ -659,8 +625,6 @@ static void update_bcn_vendor_spec_ie(struct adapter *padapter, u8 *oui)
 		update_bcn_wps_ie(padapter);
 	else if (!memcmp(P2P_OUI, oui, 4))
 		update_bcn_p2p_ie(padapter);
-	else
-		netdev_dbg(padapter->pnetdev, "unknown/unused OUI type!\n");
 }
 
 void update_beacon(struct adapter *padapter, u8 ie_id, u8 *oui, u8 tx)
@@ -723,10 +687,6 @@ static int rtw_ht_operation_update(struct adapter *padapter)
 	if (pmlmepriv->htpriv.ht_option)
 		return 0;
 
-	netdev_dbg(padapter->pnetdev,
-		   "current operation mode = 0x%X\n",
-		   pmlmepriv->ht_op_mode);
-
 	if (!(pmlmepriv->ht_op_mode & HT_INFO_OPERATION_MODE_NON_GF_DEVS_PRESENT) &&
 	    pmlmepriv->num_sta_ht_no_gf) {
 		pmlmepriv->ht_op_mode |=
@@ -776,10 +736,6 @@ static int rtw_ht_operation_update(struct adapter *padapter)
 		op_mode_changes++;
 	}
 
-	netdev_dbg(padapter->pnetdev,
-		   "new operation mode = 0x%X changes = %d\n",
-		   pmlmepriv->ht_op_mode, op_mode_changes);
-
 	return op_mode_changes;
 }
 
@@ -894,10 +850,6 @@ void bss_cap_update_on_sta_join(struct adapter *padapter, struct sta_info *psta)
 	if (psta->flags & WLAN_STA_HT) {
 		u16 ht_capab = le16_to_cpu(psta->htpriv.ht_cap.cap_info);
 
-		netdev_dbg(padapter->pnetdev,
-			   "HT: STA %pM HT Capabilities Info: 0x%04x\n",
-			   (psta->hwaddr), ht_capab);
-
 		if (psta->no_ht_set) {
 			psta->no_ht_set = 0;
 			pmlmepriv->num_sta_no_ht--;
@@ -908,9 +860,6 @@ void bss_cap_update_on_sta_join(struct adapter *padapter, struct sta_info *psta)
 				psta->no_ht_gf_set = 1;
 				pmlmepriv->num_sta_ht_no_gf++;
 			}
-			netdev_dbg(padapter->pnetdev,
-				   "STA %pM - no greenfield, num of non-gf stations %d\n",
-				   (psta->hwaddr), pmlmepriv->num_sta_ht_no_gf);
 		}
 
 		if ((ht_capab & IEEE80211_HT_CAP_SUP_WIDTH_20_40) == 0) {
@@ -918,9 +867,6 @@ void bss_cap_update_on_sta_join(struct adapter *padapter, struct sta_info *psta)
 				psta->ht_20mhz_set = 1;
 				pmlmepriv->num_sta_ht_20mhz++;
 			}
-			netdev_dbg(padapter->pnetdev,
-				   "STA %pM - 20 MHz HT, num of 20MHz HT STAs %d\n",
-				   (psta->hwaddr), pmlmepriv->num_sta_ht_20mhz);
 		}
 	} else {
 		if (!psta->no_ht_set) {
@@ -928,9 +874,6 @@ void bss_cap_update_on_sta_join(struct adapter *padapter, struct sta_info *psta)
 			pmlmepriv->num_sta_no_ht++;
 		}
 		if (pmlmepriv->htpriv.ht_option) {
-			netdev_dbg(padapter->pnetdev,
-				   "STA %pM - no HT, num of non-HT stations %d\n",
-				   (psta->hwaddr), pmlmepriv->num_sta_no_ht);
 		}
 	}
 
@@ -941,8 +884,6 @@ void bss_cap_update_on_sta_join(struct adapter *padapter, struct sta_info *psta)
 
 	/* update associated stations cap. */
 	associated_clients_update(padapter,  beacon_updated);
-
-	netdev_dbg(padapter->pnetdev, "updated = %d\n", beacon_updated);
 }
 
 u8 bss_cap_update_on_sta_leave(struct adapter *padapter, struct sta_info *psta)
@@ -1005,8 +946,6 @@ u8 bss_cap_update_on_sta_leave(struct adapter *padapter, struct sta_info *psta)
 
 	/* update associated stations cap. */
 
-	netdev_dbg(padapter->pnetdev, "updated = %d\n", beacon_updated);
-
 	return beacon_updated;
 }
 
@@ -1201,10 +1140,6 @@ void stop_ap_mode(struct adapter *padapter)
 	}
 	spin_unlock_bh(&pacl_node_q->lock);
 
-	netdev_dbg(padapter->pnetdev,
-		   "free acl_node_queue, num = %d\n",
-		   pacl_list->num);
-
 	rtw_sta_flush(padapter);
 
 	/* free_assoc_sta_resources */
diff --git a/drivers/staging/r8188eu/core/rtw_cmd.c b/drivers/staging/r8188eu/core/rtw_cmd.c
index c7e8602d2097..0ef74eb47893 100644
--- a/drivers/staging/r8188eu/core/rtw_cmd.c
+++ b/drivers/staging/r8188eu/core/rtw_cmd.c
@@ -253,9 +253,6 @@ int rtw_cmd_thread(void *context)
 _next:
 		if (padapter->bDriverStopped ||
 		    padapter->bSurpriseRemoved) {
-			netdev_dbg(padapter->pnetdev,
-				   "DriverStopped(%d) SurpriseRemoved(%d) break\n",
-				   padapter->bDriverStopped, padapter->bSurpriseRemoved);
 			break;
 		}
 
@@ -574,8 +571,6 @@ u8 rtw_joinbss_cmd(struct adapter  *padapter, struct wlan_network *pnetwork)
 	else
 		padapter->pwrctrlpriv.smart_ps = padapter->registrypriv.smart_ps;
 
-	netdev_dbg(padapter->pnetdev, "smart_ps = %d\n", padapter->pwrctrlpriv.smart_ps);
-
 	pcmd->cmdsz = get_wlan_bssid_ex_sz(psecnetwork);/* get cmdsz before endian conversion */
 
 	INIT_LIST_HEAD(&pcmd->list);
@@ -944,9 +939,6 @@ static void rtl8188e_sreset_xmit_status_check(struct adapter *padapter)
 
 	txdma_status = rtw_read32(padapter, REG_TXDMA_STATUS);
 	if (txdma_status != 0x00) {
-		netdev_dbg(padapter->pnetdev,
-			   "REG_TXDMA_STATUS: 0x%08x\n",
-			   txdma_status);
 		rtw_write32(padapter, REG_TXDMA_STATUS, txdma_status);
 	}
 	/* total xmit irp = 4 */
diff --git a/drivers/staging/r8188eu/core/rtw_ieee80211.c b/drivers/staging/r8188eu/core/rtw_ieee80211.c
index 25445f3ab4a3..c8998cb276be 100644
--- a/drivers/staging/r8188eu/core/rtw_ieee80211.c
+++ b/drivers/staging/r8188eu/core/rtw_ieee80211.c
@@ -655,8 +655,6 @@ static int rtw_ieee802_11_parse_vendor_specific(u8 *pos, uint elen,
 	 * sub-type. */
 	if (elen < 4) {
 		if (show_errors) {
-			pr_debug("short vendor specific information element ignored (len=%lu)\n",
-				 (unsigned long)elen);
 		}
 		return -1;
 	}
@@ -675,8 +673,6 @@ static int rtw_ieee802_11_parse_vendor_specific(u8 *pos, uint elen,
 			break;
 		case WME_OUI_TYPE: /* this is a Wi-Fi WME info. element */
 			if (elen < 5) {
-				pr_debug("short WME information element ignored (len=%lu)\n",
-					 (unsigned long)elen);
 				return -1;
 			}
 			switch (pos[4]) {
@@ -690,8 +686,6 @@ static int rtw_ieee802_11_parse_vendor_specific(u8 *pos, uint elen,
 				elems->wme_tspec_len = elen;
 				break;
 			default:
-				pr_debug("unknown WME information element ignored (subtype=%d len=%lu)\n",
-					 pos[4], (unsigned long)elen);
 				return -1;
 			}
 			break;
@@ -701,8 +695,6 @@ static int rtw_ieee802_11_parse_vendor_specific(u8 *pos, uint elen,
 			elems->wps_ie_len = elen;
 			break;
 		default:
-			pr_debug("Unknown Microsoft information element ignored (type=%d len=%lu)\n",
-				 pos[3], (unsigned long)elen);
 			return -1;
 		}
 		break;
@@ -714,14 +706,10 @@ static int rtw_ieee802_11_parse_vendor_specific(u8 *pos, uint elen,
 			elems->vendor_ht_cap_len = elen;
 			break;
 		default:
-			pr_debug("Unknown Broadcom information element ignored (type=%d len=%lu)\n",
-				 pos[3], (unsigned long)elen);
 			return -1;
 		}
 		break;
 	default:
-		pr_debug("unknown vendor specific information element ignored (vendor OUI %02x:%02x:%02x len=%lu)\n",
-			 pos[0], pos[1], pos[2], (unsigned long)elen);
 		return -1;
 	}
 	return 0;
@@ -754,8 +742,6 @@ enum parse_res rtw_ieee802_11_parse_elems(u8 *start, uint len,
 
 		if (elen > left) {
 			if (show_errors) {
-				pr_debug("IEEE 802.11 element parse failed (id=%d elen=%d left=%lu)\n",
-					 id, elen, (unsigned long)left);
 			}
 			return ParseFailed;
 		}
@@ -841,8 +827,6 @@ enum parse_res rtw_ieee802_11_parse_elems(u8 *start, uint len,
 			unknown++;
 			if (!show_errors)
 				break;
-			pr_debug("IEEE 802.11 element parse ignored unknown element (id=%d elen=%d)\n",
-				 id, elen);
 			break;
 		}
 		left -= elen;
@@ -892,10 +876,7 @@ void rtw_macaddr_cfg(u8 *mac_addr)
 
 	if (is_broadcast_ether_addr(mac) || is_zero_ether_addr(mac)) {
 		eth_random_addr(mac_addr);
-		pr_debug("MAC Address from efuse error, assign random one !!!\n");
 	}
-
-	pr_debug("MAC Address = %pM\n", mac_addr);
 }
 
 /**
diff --git a/drivers/staging/r8188eu/core/rtw_ioctl_set.c b/drivers/staging/r8188eu/core/rtw_ioctl_set.c
index e7f35370b69c..4b78e42d180d 100644
--- a/drivers/staging/r8188eu/core/rtw_ioctl_set.c
+++ b/drivers/staging/r8188eu/core/rtw_ioctl_set.c
@@ -120,8 +120,6 @@ u8 rtw_set_802_11_bssid(struct adapter *padapter, u8 *bssid)
 
 	spin_lock_bh(&pmlmepriv->lock);
 
-	netdev_dbg(padapter->pnetdev, "Set BSSID under fw_state = 0x%08x\n",
-		   get_fwstate(pmlmepriv));
 	if (check_fwstate(pmlmepriv, _FW_UNDER_SURVEY))
 		goto handle_tkip_countermeasure;
 	else if (check_fwstate(pmlmepriv, _FW_UNDER_LINKING))
@@ -191,8 +189,6 @@ u8 rtw_set_802_11_ssid(struct adapter *padapter, struct ndis_802_11_ssid *ssid)
 
 	spin_lock_bh(&pmlmepriv->lock);
 
-	netdev_dbg(padapter->pnetdev, "Set SSID under fw_state = 0x%08x\n",
-		   get_fwstate(pmlmepriv));
 	if (check_fwstate(pmlmepriv, _FW_UNDER_SURVEY)) {
 		goto handle_tkip_countermeasure;
 	} else if (check_fwstate(pmlmepriv, _FW_UNDER_LINKING)) {
@@ -359,7 +355,6 @@ u8 rtw_set_802_11_bssid_list_scan(struct adapter *padapter, struct ndis_802_11_s
 		res = true;
 	} else {
 		if (rtw_is_scan_deny(padapter)) {
-			netdev_dbg(padapter->pnetdev, "scan deny\n");
 			indicate_wx_scan_complete_event(padapter);
 			return _SUCCESS;
 		}
diff --git a/drivers/staging/r8188eu/core/rtw_iol.c b/drivers/staging/r8188eu/core/rtw_iol.c
index f5f03160759c..5f73413a4511 100644
--- a/drivers/staging/r8188eu/core/rtw_iol.c
+++ b/drivers/staging/r8188eu/core/rtw_iol.c
@@ -12,15 +12,11 @@ struct xmit_frame	*rtw_IOL_accquire_xmit_frame(struct adapter  *adapter)
 
 	xmit_frame = rtw_alloc_xmitframe(pxmitpriv);
 	if (!xmit_frame) {
-		netdev_dbg(adapter->pnetdev,
-			   "rtw_alloc_xmitframe return null\n");
 		return NULL;
 	}
 
 	xmitbuf = rtw_alloc_xmitbuf(pxmitpriv);
 	if (!xmitbuf) {
-		netdev_dbg(adapter->pnetdev,
-			   "rtw_alloc_xmitbuf return null\n");
 		rtw_free_xmitframe(pxmitpriv, xmit_frame);
 		return NULL;
 	}
@@ -51,8 +47,6 @@ int rtw_IOL_append_cmds(struct xmit_frame *xmit_frame, u8 *IOL_cmds, u32 cmd_len
 
 	/* check if the io_buf can accommodate new cmds */
 	if (ori_len + cmd_len + 8 > MAX_XMITBUF_SZ) {
-		pr_debug("%u is larger than MAX_XMITBUF_SZ:%u, can't accommodate new cmds\n",
-			 ori_len + cmd_len + 8, MAX_XMITBUF_SZ);
 		return _FAIL;
 	}
 
diff --git a/drivers/staging/r8188eu/core/rtw_mlme.c b/drivers/staging/r8188eu/core/rtw_mlme.c
index 557f6b96e99c..d7494d820756 100644
--- a/drivers/staging/r8188eu/core/rtw_mlme.c
+++ b/drivers/staging/r8188eu/core/rtw_mlme.c
@@ -611,9 +611,6 @@ static int rtw_is_desired_network(struct adapter *adapter, struct wlan_network *
 	}
 
 	if ((desired_encmode != Ndis802_11EncryptionDisabled) && (privacy == 0)) {
-		netdev_dbg(adapter->pnetdev,
-			   "desired_encmode: %d, privacy: %d\n",
-			   desired_encmode, privacy);
 		bselected = false;
 	}
 
@@ -725,9 +722,6 @@ void rtw_surveydone_event_callback(struct adapter	*adapter, u8 *pbuf)
 				_clr_fwstate_(pmlmepriv, _FW_UNDER_LINKING);
 				rtw_indicate_connect(adapter);
 			} else {
-				netdev_dbg(adapter->pnetdev,
-					   "try_to_join, but select scanning queue fail, to_roaming:%d\n",
-					   pmlmepriv->to_roaming);
 				if (rtw_to_roaming(adapter) != 0) {
 					if (--pmlmepriv->to_roaming == 0 ||
 					    _SUCCESS != rtw_sitesurvey_cmd(adapter, &pmlmepriv->assoc_ssid, 1, NULL, 0)) {
@@ -1225,10 +1219,6 @@ void rtw_stadel_event_callback(struct adapter *adapter, u8 *pbuf)
 	else
 		mac_id = pstadel->mac_id;
 
-	netdev_dbg(adapter->pnetdev,
-		   "(mac_id=%d)=%pM\n",
-		   mac_id, pstadel->macaddr);
-
 	if (mac_id >= 0) {
 		u16 media_status;
 		media_status = (mac_id << 8) | 0; /*   MACID|OPMODE:0 means disconnect */
@@ -1318,8 +1308,6 @@ void _rtw_join_timeout_handler (struct adapter *adapter)
 	struct	mlme_priv *pmlmepriv = &adapter->mlmepriv;
 	int do_join_r;
 
-	netdev_dbg(adapter->pnetdev, "fw_state=%x\n", get_fwstate(pmlmepriv));
-
 	if (adapter->bDriverStopped || adapter->bSurpriseRemoved)
 		return;
 
@@ -1329,19 +1317,12 @@ void _rtw_join_timeout_handler (struct adapter *adapter)
 		while (1) {
 			pmlmepriv->to_roaming--;
 			if (rtw_to_roaming(adapter) != 0) { /* try another */
-				netdev_dbg(adapter->pnetdev,
-					   "try another roaming\n");
 				do_join_r = rtw_do_join(adapter);
 				if (_SUCCESS != do_join_r) {
-					netdev_dbg(adapter->pnetdev,
-						   "roaming do_join return %d\n",
-						   do_join_r);
 					continue;
 				}
 				break;
 			} else {
-				netdev_dbg(adapter->pnetdev,
-					   "We've tried roaming but failed\n");
 				rtw_indicate_disconnect(adapter);
 				break;
 			}
@@ -1362,7 +1343,6 @@ void rtw_scan_timeout_handler (struct adapter *adapter)
 {
 	struct	mlme_priv *pmlmepriv = &adapter->mlmepriv;
 
-	netdev_dbg(adapter->pnetdev, "fw_state=%x\n", get_fwstate(pmlmepriv));
 	spin_lock_bh(&pmlmepriv->lock);
 	_clr_fwstate_(pmlmepriv, _FW_UNDER_SURVEY);
 	spin_unlock_bh(&pmlmepriv->lock);
@@ -1467,15 +1447,6 @@ static int rtw_check_join_candidate(struct mlme_priv *pmlmepriv
 		updated = true;
 	}
 	if (updated) {
-		netdev_dbg(adapter->pnetdev,
-			   "[by_bssid:%u][assoc_ssid:%s]new candidate: %s(%pM rssi:%d\n",
-			   pmlmepriv->assoc_by_bssid,
-			   pmlmepriv->assoc_ssid.Ssid,
-			   (*candidate)->network.Ssid.Ssid,
-			   (*candidate)->network.MacAddress,
-			   (int)(*candidate)->network.Rssi);
-		netdev_dbg(adapter->pnetdev,
-			   "[to_roaming:%u]\n", rtw_to_roaming(adapter));
 	}
 
 exit:
@@ -1513,21 +1484,13 @@ int rtw_select_and_join_from_scanned_queue(struct mlme_priv *pmlmepriv)
 		rtw_check_join_candidate(pmlmepriv, &candidate, pnetwork);
 	}
 	if (!candidate) {
-		netdev_dbg(adapter->pnetdev,
-			   "return _FAIL(candidate==NULL)\n");
 		ret = _FAIL;
 		goto exit;
 	} else {
-		netdev_dbg(adapter->pnetdev, "candidate: %s(%pM ch:%u)\n",
-			   candidate->network.Ssid.Ssid, candidate->network.MacAddress,
-			   candidate->network.Configuration.DSConfig);
 	}
 
 	/*  check for situation of  _FW_LINKED */
 	if (check_fwstate(pmlmepriv, _FW_LINKED)) {
-		netdev_dbg(adapter->pnetdev,
-			   "_FW_LINKED while ask_for_joinbss!!!\n");
-
 		rtw_disassoc_cmd(adapter, 0, true);
 		rtw_indicate_disconnect(adapter);
 		rtw_free_assoc_resources(adapter, 0);
@@ -1537,9 +1500,6 @@ int rtw_select_and_join_from_scanned_queue(struct mlme_priv *pmlmepriv)
 	if (supp_ant_div) {
 		u8 cur_ant;
 		GetHalDefVar8188EUsb(adapter, HAL_DEF_CURRENT_ANTENNA, &cur_ant);
-		netdev_dbg(adapter->pnetdev, "Opt_Ant_(%s), cur_Ant(%s)\n",
-			   (candidate->network.PhyInfo.Optimum_antenna == 2) ? "A" : "B",
-			   (cur_ant == 2) ? "A" : "B");
 	}
 
 	ret = rtw_joinbss_cmd(adapter, candidate);
@@ -1611,10 +1571,6 @@ int rtw_set_key(struct adapter *adapter, struct security_priv *psecuritypriv, in
 	psetkeyparm->keyid = (u8)keyid;/* 0~3 */
 	psetkeyparm->set_tx = set_tx;
 	pmlmepriv->key_mask |= BIT(psetkeyparm->keyid);
-	netdev_dbg(adapter->pnetdev,
-		   "algorithm(%x), keyid(%x), key_mask(%x)\n",
-		   psetkeyparm->algorithm, psetkeyparm->keyid,
-		   pmlmepriv->key_mask);
 
 	switch (psetkeyparm->algorithm) {
 	case _WEP40_:
@@ -2005,7 +1961,7 @@ void rtw_update_ht_cap(struct adapter *padapter, u8 *pie, uint ie_len)
 	/*  Config SM Power Save setting */
 	pmlmeinfo->SM_PS = (le16_to_cpu(pmlmeinfo->HT_caps.u.HT_cap_element.HT_caps_info) & 0x0C) >> 2;
 	if (pmlmeinfo->SM_PS == WLAN_HT_CAP_SM_PS_STATIC)
-		netdev_dbg(padapter->pnetdev, "WLAN_HT_CAP_SM_PS_STATIC\n");
+		;
 
 	/*  Config current HT Protection mode. */
 	pmlmeinfo->HT_protection = pmlmeinfo->HT_info.infos[1] & 0x3;
@@ -2040,7 +1996,6 @@ void rtw_issue_addbareq_cmd(struct adapter *padapter, struct xmit_frame *pxmitfr
 		issued |= (phtpriv->candidate_tid_bitmap >> priority) & 0x1;
 
 		if (0 == issued) {
-			netdev_dbg(padapter->pnetdev, "p=%d\n", priority);
 			psta->htpriv.candidate_tid_bitmap |= BIT((u8)priority);
 			rtw_addbareq_cmd(padapter, (u8)priority, pattrib->ra);
 		}
@@ -2068,11 +2023,6 @@ void _rtw_roaming(struct adapter *padapter, struct wlan_network *tgt_network)
 		pnetwork = &pmlmepriv->cur_network;
 
 	if (0 < rtw_to_roaming(padapter)) {
-		netdev_dbg(padapter->pnetdev,
-			   "roaming from %s(%pM length:%d\n",
-			   pnetwork->network.Ssid.Ssid,
-			   pnetwork->network.MacAddress,
-			   pnetwork->network.Ssid.SsidLength);
 		memcpy(&pmlmepriv->assoc_ssid, &pnetwork->network.Ssid, sizeof(struct ndis_802_11_ssid));
 
 		pmlmepriv->assoc_by_bssid = false;
@@ -2082,16 +2032,11 @@ void _rtw_roaming(struct adapter *padapter, struct wlan_network *tgt_network)
 			if (_SUCCESS == do_join_r) {
 				break;
 			} else {
-				netdev_dbg(padapter->pnetdev,
-					   "roaming do_join return %d\n",
-					   do_join_r);
 				pmlmepriv->to_roaming--;
 
 				if (0 < pmlmepriv->to_roaming) {
 					continue;
 				} else {
-					netdev_dbg(padapter->pnetdev,
-						   "-to roaming fail, indicate_disconnect\n");
 					rtw_indicate_disconnect(padapter);
 					break;
 				}
diff --git a/drivers/staging/r8188eu/core/rtw_security.c b/drivers/staging/r8188eu/core/rtw_security.c
index 4e93c720c1b6..fdd2dbf65eb7 100644
--- a/drivers/staging/r8188eu/core/rtw_security.c
+++ b/drivers/staging/r8188eu/core/rtw_security.c
@@ -545,8 +545,6 @@ u32 rtw_tkip_decrypt(struct adapter *padapter, struct recv_frame *precvframe)
 			if (is_multicast_ether_addr(prxattrib->ra)) {
 				if (!psecuritypriv->binstallGrpkey) {
 					res = _FAIL;
-					netdev_dbg(padapter->pnetdev,
-						   "rx bc/mc packets, but didn't install group key!\n");
 					goto exit;
 				}
 				prwskey = psecuritypriv->dot118021XGrpKey[prxattrib->key_index].skey;
@@ -1330,10 +1328,6 @@ static int aes_decipher(struct adapter *padapter, u8 *key, uint hdrlen,
 	/* compare the mic */
 	for (i = 0; i < 8; i++) {
 		if (pframe[hdrlen + 8 + plen - 8 + i] != message[hdrlen + 8 + plen - 8 + i]) {
-			netdev_dbg(padapter->pnetdev,
-				   "mic check error mic[%d]: pframe(%x)!=message(%x)\n",
-				   i, pframe[hdrlen + 8 + plen - 8 + i],
-				   message[hdrlen + 8 + plen - 8 + i]);
 			res = _FAIL;
 		}
 	}
@@ -1361,16 +1355,10 @@ u32 rtw_aes_decrypt(struct adapter *padapter, struct recv_frame *precvframe)
 				/* in concurrent we should use sw descrypt in group key, so we remove this message */
 				if (!psecuritypriv->binstallGrpkey) {
 					res = _FAIL;
-					netdev_dbg(padapter->pnetdev,
-						   "rx bc/mc packets, but didn't install group key!\n");
 					goto exit;
 				}
 				prwskey = psecuritypriv->dot118021XGrpKey[prxattrib->key_index].skey;
 				if (psecuritypriv->dot118021XGrpKeyid != prxattrib->key_index) {
-					netdev_dbg(padapter->pnetdev,
-						   "not match packet_index=%d, install_index=%d\n",
-						   prxattrib->key_index,
-						   psecuritypriv->dot118021XGrpKeyid);
 					res = _FAIL;
 					goto exit;
 				}
diff --git a/drivers/staging/r8188eu/core/rtw_sta_mgt.c b/drivers/staging/r8188eu/core/rtw_sta_mgt.c
index 79b49a13fe61..1fb9b6cc7eda 100644
--- a/drivers/staging/r8188eu/core/rtw_sta_mgt.c
+++ b/drivers/staging/r8188eu/core/rtw_sta_mgt.c
@@ -104,7 +104,7 @@ inline int rtw_stainfo_offset(struct sta_priv *stapriv, struct sta_info *sta)
 	int offset = (((u8 *)sta) - stapriv->pstainfo_buf) / sizeof(struct sta_info);
 
 	if (!stainfo_offset_valid(offset))
-		pr_debug("invalid offset(%d), out of range!!!", offset);
+		;
 
 	return offset;
 }
@@ -112,7 +112,7 @@ inline int rtw_stainfo_offset(struct sta_priv *stapriv, struct sta_info *sta)
 inline struct sta_info *rtw_get_stainfo_by_offset(struct sta_priv *stapriv, int offset)
 {
 	if (!stainfo_offset_valid(offset))
-		pr_debug("invalid offset(%d), out of range!!!", offset);
+		;
 
 	return (struct sta_info *)(stapriv->pstainfo_buf + offset * sizeof(struct sta_info));
 }
diff --git a/drivers/staging/r8188eu/core/rtw_xmit.c b/drivers/staging/r8188eu/core/rtw_xmit.c
index 30714fee1921..7d616a409c0c 100644
--- a/drivers/staging/r8188eu/core/rtw_xmit.c
+++ b/drivers/staging/r8188eu/core/rtw_xmit.c
@@ -371,7 +371,6 @@ u8	qos_acm(u8 acm_mask, u8 priority)
 			change_priority = 5;
 		break;
 	default:
-		pr_debug("invalid pattrib->priority: %d!!!\n", priority);
 		break;
 	}
 
@@ -889,7 +888,6 @@ s32 rtw_xmitframe_coalesce(struct adapter *padapter, struct sk_buff *pkt, struct
 		return _FAIL;
 
 	if (!pxmitframe->buf_addr) {
-		netdev_dbg(padapter->pnetdev, "buf_addr == NULL\n");
 		return _FAIL;
 	}
 
@@ -900,8 +898,6 @@ s32 rtw_xmitframe_coalesce(struct adapter *padapter, struct sk_buff *pkt, struct
 	mem_start = pbuf_start +	hw_hdr_offset;
 
 	if (rtw_make_wlanhdr(padapter, mem_start, pattrib) == _FAIL) {
-		netdev_dbg(padapter->pnetdev,
-			   "rtw_make_wlanhdr fail; drop pkt\n");
 		res = _FAIL;
 		goto exit;
 	}
@@ -998,8 +994,6 @@ s32 rtw_xmitframe_coalesce(struct adapter *padapter, struct sk_buff *pkt, struct
 	}
 
 	if (xmitframe_addmic(padapter, pxmitframe) == _FAIL) {
-		netdev_dbg(padapter->pnetdev,
-			   "xmitframe_addmic(padapter, pxmitframe) == _FAIL\n");
 		res = _FAIL;
 		goto exit;
 	}
@@ -1130,7 +1124,6 @@ struct xmit_buf *rtw_alloc_xmitbuf_ext(struct xmit_priv *pxmitpriv)
 		/* pxmitbuf->ext_tag = true; */
 
 		if (pxmitbuf->sctx) {
-			pr_debug("pxmitbuf->sctx is not NULL\n");
 			rtw_sctx_done_err(&pxmitbuf->sctx, RTW_SCTX_DONE_BUF_ALLOC);
 		}
 	}
@@ -1185,7 +1178,6 @@ struct xmit_buf *rtw_alloc_xmitbuf(struct xmit_priv *pxmitpriv)
 		pxmitpriv->free_xmitbuf_cnt--;
 		pxmitbuf->priv_data = NULL;
 		if (pxmitbuf->sctx) {
-			pr_debug("pxmitbuf->sctx is not NULL\n");
 			rtw_sctx_done_err(&pxmitbuf->sctx, RTW_SCTX_DONE_BUF_ALLOC);
 		}
 	}
@@ -1203,7 +1195,6 @@ s32 rtw_free_xmitbuf(struct xmit_priv *pxmitpriv, struct xmit_buf *pxmitbuf)
 		return _FAIL;
 
 	if (pxmitbuf->sctx) {
-		pr_debug("pxmitbuf->sctx is not NULL\n");
 		rtw_sctx_done_err(&pxmitbuf->sctx, RTW_SCTX_DONE_BUF_FREE);
 	}
 
@@ -1472,7 +1463,6 @@ s32 rtw_xmit_classifier(struct adapter *padapter, struct xmit_frame *pxmitframe)
 
 	if (!psta) {
 		res = _FAIL;
-		netdev_dbg(padapter->pnetdev, "psta == NULL\n");
 		goto exit;
 	}
 
@@ -1718,8 +1708,6 @@ s32 rtw_xmit(struct adapter *padapter, struct sk_buff **ppkt)
 
 	pxmitframe = rtw_alloc_xmitframe(pxmitpriv);
 	if (!pxmitframe) {
-		netdev_dbg(padapter->pnetdev,
-			   "DBG_TX_DROP_FRAME no more pxmitframe\n");
 		return -1;
 	}
 
@@ -2144,7 +2132,6 @@ int rtw_sctx_wait(struct submit_ctx *sctx)
 	if (!wait_for_completion_timeout(&sctx->done, expire)) {
 		/* timeout, do something?? */
 		status = RTW_SCTX_DONE_TIMEOUT;
-		pr_debug("timeout\n");
 	} else {
 		status = sctx->status;
 	}
@@ -2174,7 +2161,7 @@ void rtw_sctx_done_err(struct submit_ctx **sctx, int status)
 {
 	if (*sctx) {
 		if (rtw_sctx_chk_waring_status(status))
-			pr_debug("status:%d\n", status);
+			;
 		(*sctx)->status = status;
 		complete(&((*sctx)->done));
 		*sctx = NULL;
@@ -2198,6 +2185,4 @@ void rtw_ack_tx_done(struct xmit_priv *pxmitpriv, int status)
 
 	if (pxmitpriv->ack_tx)
 		rtw_sctx_done_err(&pack_tx_ops, status);
-	else
-		pr_debug("ack_tx not set\n");
 }
diff --git a/drivers/staging/r8188eu/os_dep/usb_ops_linux.c b/drivers/staging/r8188eu/os_dep/usb_ops_linux.c
index d75933c73946..82e680abcd61 100644
--- a/drivers/staging/r8188eu/os_dep/usb_ops_linux.c
+++ b/drivers/staging/r8188eu/os_dep/usb_ops_linux.c
@@ -63,32 +63,21 @@ static void usb_write_port_complete(struct urb *purb, struct pt_regs *regs)
 
 	if (padapter->bSurpriseRemoved || padapter->bDriverStopped ||
 	    padapter->bWritePortCancel) {
-		netdev_dbg(padapter->pnetdev,
-			   "TX Warning! bDriverStopped(%d) OR bSurpriseRemoved(%d)\n",
-			   padapter->bDriverStopped, padapter->bSurpriseRemoved);
-		netdev_dbg(padapter->pnetdev,
-			   "TX Warning! bWritePortCancel(%d) pxmitbuf->ext_tag(%x)\n",
-			   padapter->bReadPortCancel, pxmitbuf->ext_tag);
-
 		goto check_completion;
 	}
 
 	if (purb->status) {
-		netdev_dbg(padapter->pnetdev, "status(%d)\n", purb->status);
 		if (purb->status == -EINPROGRESS) {
 			goto check_completion;
 		} else if (purb->status == -ENOENT) {
-			netdev_dbg(padapter->pnetdev, "-ENOENT\n");
 			goto check_completion;
 		} else if (purb->status == -ECONNRESET) {
-			netdev_dbg(padapter->pnetdev, "-ECONNRESET\n");
 			goto check_completion;
 		} else if (purb->status == -ESHUTDOWN) {
 			padapter->bDriverStopped = true;
 			goto check_completion;
 		} else if ((purb->status != -EPIPE) && (purb->status != -EPROTO)) {
 			padapter->bSurpriseRemoved = true;
-			netdev_dbg(padapter->pnetdev, "bSurpriseRemoved = true\n");
 
 			goto check_completion;
 		}
@@ -167,7 +156,6 @@ u32 rtw_write_port(struct adapter *padapter, u32 addr, u32 cnt, u8 *wmem)
 	status = usb_submit_urb(purb, GFP_ATOMIC);
 	if (status) {
 		rtw_sctx_done_err(&pxmitbuf->sctx, RTW_SCTX_DONE_WRITE_PORT_ERR);
-		netdev_dbg(padapter->pnetdev, "usb_write_port, status = %d\n", status);
 
 		switch (status) {
 		case -ENODEV:
diff --git a/drivers/staging/r8188eu/os_dep/xmit_linux.c b/drivers/staging/r8188eu/os_dep/xmit_linux.c
index 7287897b3f65..6032831364c4 100644
--- a/drivers/staging/r8188eu/os_dep/xmit_linux.c
+++ b/drivers/staging/r8188eu/os_dep/xmit_linux.c
@@ -79,7 +79,6 @@ int rtw_os_xmit_resource_alloc(struct adapter *padapter, struct xmit_buf *pxmitb
 	for (i = 0; i < 8; i++) {
 		pxmitbuf->pxmit_urb[i] = usb_alloc_urb(0, GFP_KERNEL);
 		if (!pxmitbuf->pxmit_urb[i]) {
-			netdev_dbg(padapter->pnetdev, "pxmitbuf->pxmit_urb[i]==NULL");
 			return _FAIL;
 		}
 	}
@@ -188,14 +187,12 @@ static int rtw_mlcst2unicst(struct adapter *padapter, struct sk_buff *skb)
 			memcpy(newskb->data, psta->hwaddr, 6);
 			res = rtw_xmit(padapter, &newskb);
 			if (res < 0) {
-				netdev_dbg(padapter->pnetdev, "rtw_xmit() return error!\n");
 				pxmitpriv->tx_drop++;
 				dev_kfree_skb_any(newskb);
 			} else {
 				pxmitpriv->tx_pkts++;
 			}
 		} else {
-			netdev_dbg(padapter->pnetdev, "skb_copy() failed!\n");
 			pxmitpriv->tx_drop++;
 
 			spin_unlock_bh(&pstapriv->asoc_list_lock);
-- 
2.34.1

