Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A6494894A5
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 10:02:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242641AbiAJJC1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 04:02:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238677AbiAJJAZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 04:00:25 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E24FC061212
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jan 2022 01:00:24 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id o3so25313947wrh.10
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jan 2022 01:00:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hveg2mt6NAFmAOqnRmvpmxANd+423NVK0KBOAAWP8lE=;
        b=0XdfYB87S7DVrpsmYW/tIXqtSSu3gHDU+YaiNdXP48Id0jSJOMYEkHBOu2ZvOtj7iw
         Tz42/r+8820Fn++qZG5dH1y59hPIam+syEJ7Spmbb5WzuNKK5UiVuQDslS+TTWegTY+5
         KTOCkTkQVm/Iaex063VC1KMC0xUUVCKmPTPR7ZlIhhZbt+WdJNaiFYe3AOjbP6spskev
         1m9tVof02oSxxfCzhIH+ldbxKzr/hw2lP9ZBVHM1BXdsRTuXMU25jPXb4UVB8l7bwjsc
         rsdy8nHGRLTWu3pOpCD5+Z85X+pft4Tlijlf70CzKTYG9K6RfKkfXDau6AXefK8qh4g4
         vPJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hveg2mt6NAFmAOqnRmvpmxANd+423NVK0KBOAAWP8lE=;
        b=i/rnFJ7g6jGps6ASiczhwAsFHe2/24954ynRa6dbJgP2gCeqJCCmnn/9ZRYWKApZvT
         8sbTgL9p1CHH3cEC5yESD6n3sAEcXPa2yLCRioz/JGhlusSUTLN94zsvfY3nctLxWNnu
         9rtPdyp1FYMsPoy6zkODUrTMWzvN/X8k1R9ZLY45uLjbp8Z00aEL4PPdmL6DmBYyLV8a
         uchbhGVZnj0kiIgJnS0BxAMckSD9tL4hs/ozy3M6KyAS5zP90SJwxYUasORN0t/fbAfm
         wFZGJR/LSsG7utzaW105VEO/k7OLJGNeu4WZXef1G9wh+ot5BQaSuhCm1SEbYoaGI/qT
         czLg==
X-Gm-Message-State: AOAM5302Yd7nDy/x/DdX+XKktJKPB/rFu09vjsxh7mtY4+qjuqZOxbQh
        JUVm3oLuaYZHfKeJuuo3fKdUGA==
X-Google-Smtp-Source: ABdhPJxPyTDPoP4XneBJsF6h3sbL8JsgarnGb7UcxoBKw3ifbqJjP2kau8jkeQ80X99s4ghC2srTtw==
X-Received: by 2002:a5d:4212:: with SMTP id n18mr124886wrq.362.1641805222821;
        Mon, 10 Jan 2022 01:00:22 -0800 (PST)
Received: from localhost.localdomain (3.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.6.1.f.d.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:df16::3])
        by smtp.gmail.com with ESMTPSA id m15sm6263287wmq.6.2022.01.10.01.00.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jan 2022 01:00:22 -0800 (PST)
From:   Phillip Potter <phil@philpotter.co.uk>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, straube.linux@gmail.com,
        martin@kaiser.cx, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/7] staging: r8188eu: convert DBG_88E calls in core/rtw_ieee80211.c
Date:   Mon, 10 Jan 2022 09:00:14 +0000
Message-Id: <20220110090020.6800-2-phil@philpotter.co.uk>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20220110090020.6800-1-phil@philpotter.co.uk>
References: <20220110090020.6800-1-phil@philpotter.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the DBG_88E macro calls in core/rtw_ieee80211.c to use pr_debug
as their information may be useful to observers, and this gets the
driver closer to the point of being able to remove DBG_88E itself.

These calls are at points in the call chain where use of dev_dbg or
netdev_dbg isn't possible due to lack of device pointer, so plain
pr_debug is appropriate here.

Signed-off-by: Phillip Potter <phil@philpotter.co.uk>
---
 drivers/staging/r8188eu/core/rtw_ieee80211.c | 36 ++++++++++----------
 1 file changed, 18 insertions(+), 18 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_ieee80211.c b/drivers/staging/r8188eu/core/rtw_ieee80211.c
index ad87954bdeb4..25445f3ab4a3 100644
--- a/drivers/staging/r8188eu/core/rtw_ieee80211.c
+++ b/drivers/staging/r8188eu/core/rtw_ieee80211.c
@@ -655,8 +655,8 @@ static int rtw_ieee802_11_parse_vendor_specific(u8 *pos, uint elen,
 	 * sub-type. */
 	if (elen < 4) {
 		if (show_errors) {
-			DBG_88E("short vendor specific information element ignored (len=%lu)\n",
-				(unsigned long)elen);
+			pr_debug("short vendor specific information element ignored (len=%lu)\n",
+				 (unsigned long)elen);
 		}
 		return -1;
 	}
@@ -675,8 +675,8 @@ static int rtw_ieee802_11_parse_vendor_specific(u8 *pos, uint elen,
 			break;
 		case WME_OUI_TYPE: /* this is a Wi-Fi WME info. element */
 			if (elen < 5) {
-				DBG_88E("short WME information element ignored (len=%lu)\n",
-					(unsigned long)elen);
+				pr_debug("short WME information element ignored (len=%lu)\n",
+					 (unsigned long)elen);
 				return -1;
 			}
 			switch (pos[4]) {
@@ -690,8 +690,8 @@ static int rtw_ieee802_11_parse_vendor_specific(u8 *pos, uint elen,
 				elems->wme_tspec_len = elen;
 				break;
 			default:
-				DBG_88E("unknown WME information element ignored (subtype=%d len=%lu)\n",
-					pos[4], (unsigned long)elen);
+				pr_debug("unknown WME information element ignored (subtype=%d len=%lu)\n",
+					 pos[4], (unsigned long)elen);
 				return -1;
 			}
 			break;
@@ -701,8 +701,8 @@ static int rtw_ieee802_11_parse_vendor_specific(u8 *pos, uint elen,
 			elems->wps_ie_len = elen;
 			break;
 		default:
-			DBG_88E("Unknown Microsoft information element ignored (type=%d len=%lu)\n",
-				pos[3], (unsigned long)elen);
+			pr_debug("Unknown Microsoft information element ignored (type=%d len=%lu)\n",
+				 pos[3], (unsigned long)elen);
 			return -1;
 		}
 		break;
@@ -714,14 +714,14 @@ static int rtw_ieee802_11_parse_vendor_specific(u8 *pos, uint elen,
 			elems->vendor_ht_cap_len = elen;
 			break;
 		default:
-			DBG_88E("Unknown Broadcom information element ignored (type=%d len=%lu)\n",
-				pos[3], (unsigned long)elen);
+			pr_debug("Unknown Broadcom information element ignored (type=%d len=%lu)\n",
+				 pos[3], (unsigned long)elen);
 			return -1;
 		}
 		break;
 	default:
-		DBG_88E("unknown vendor specific information element ignored (vendor OUI %02x:%02x:%02x len=%lu)\n",
-			pos[0], pos[1], pos[2], (unsigned long)elen);
+		pr_debug("unknown vendor specific information element ignored (vendor OUI %02x:%02x:%02x len=%lu)\n",
+			 pos[0], pos[1], pos[2], (unsigned long)elen);
 		return -1;
 	}
 	return 0;
@@ -754,8 +754,8 @@ enum parse_res rtw_ieee802_11_parse_elems(u8 *start, uint len,
 
 		if (elen > left) {
 			if (show_errors) {
-				DBG_88E("IEEE 802.11 element parse failed (id=%d elen=%d left=%lu)\n",
-					id, elen, (unsigned long)left);
+				pr_debug("IEEE 802.11 element parse failed (id=%d elen=%d left=%lu)\n",
+					 id, elen, (unsigned long)left);
 			}
 			return ParseFailed;
 		}
@@ -841,8 +841,8 @@ enum parse_res rtw_ieee802_11_parse_elems(u8 *start, uint len,
 			unknown++;
 			if (!show_errors)
 				break;
-			DBG_88E("IEEE 802.11 element parse ignored unknown element (id=%d elen=%d)\n",
-				id, elen);
+			pr_debug("IEEE 802.11 element parse ignored unknown element (id=%d elen=%d)\n",
+				 id, elen);
 			break;
 		}
 		left -= elen;
@@ -892,10 +892,10 @@ void rtw_macaddr_cfg(u8 *mac_addr)
 
 	if (is_broadcast_ether_addr(mac) || is_zero_ether_addr(mac)) {
 		eth_random_addr(mac_addr);
-		DBG_88E("MAC Address from efuse error, assign random one !!!\n");
+		pr_debug("MAC Address from efuse error, assign random one !!!\n");
 	}
 
-	DBG_88E("rtw_macaddr_cfg MAC Address  = %pM\n", mac_addr);
+	pr_debug("MAC Address = %pM\n", mac_addr);
 }
 
 /**
-- 
2.33.1

