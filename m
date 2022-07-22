Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2393057E11D
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 13:58:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235139AbiGVL5R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 07:57:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235084AbiGVL5E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 07:57:04 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 401419D525
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jul 2022 04:57:02 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id w12so5513215edd.13
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jul 2022 04:57:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pqrs.dk; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kU972/Ti7378lz0X9ZqJvIJG14FXu8vb+YycDZtlNEs=;
        b=iaadc3k9Vb0dBlWleTRhgOHE6k6K/BUKoYvG4LQcVV5ajYnFAsC+LpC+Jc7o4B1pEq
         u+KUMNvcKJHB/o5l8QuMtG6FOxGNQQR0mQQ5F32d2TcNcjPwp5St9bqUvHzzyH+8Ojfm
         5iMygMxWNc2uhYkJPOjE07sglSlOJO4tJzwHw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kU972/Ti7378lz0X9ZqJvIJG14FXu8vb+YycDZtlNEs=;
        b=BiUvvi+m2FqQVwUgASahOJ2mhwalsDlmLBiLgk1knjp2brPv246vEevdBkgcX4JlrI
         /5VjFBj+IGCeBCIIO5ozdv2kZnnihfKTl+9yfqUZE83Se1OHY5P7iZqXB5vswJ7NWCrs
         zOjcJVNLWxfej2Nrt7qSdhOcA376wdoqQNwGnA7WYSG0y9Mc/VQDdmWQgpuWslksbxIL
         e604BeE4L+m92ySDHWlF+oWQMD8zxHloqYHaWMKUcwrykj+UuVkOnxYNQ1zGpuk1jbyN
         qHkXl7KeLSb2Az6PB+Iw3NJfh4WdCHgc1GFyeXVrlxqHkB1CEP19x6axlJFSEbKktCQg
         cqbA==
X-Gm-Message-State: AJIora/ibz/Nc/iJo0WOzUHtSN8Y1HsfgGyZxBgaWOnTBw6fvjWMjIpe
        97HDMk2XbdL5uouQtJFb07653A==
X-Google-Smtp-Source: AGRyM1tuL1bHSScV4f4fqZVhdg/E7QN0gNWIb72aJ2UbGFtkvUR7uX3cE6hTDLBcuW8sfvGiGSW3FQ==
X-Received: by 2002:a05:6402:48c:b0:43a:8bc7:f440 with SMTP id k12-20020a056402048c00b0043a8bc7f440mr297826edv.8.1658491020686;
        Fri, 22 Jul 2022 04:57:00 -0700 (PDT)
Received: from localhost.localdomain (80.71.142.18.ipv4.parknet.dk. [80.71.142.18])
        by smtp.gmail.com with ESMTPSA id kx6-20020a170907774600b0072b3182368fsm1934370ejc.77.2022.07.22.04.56.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Jul 2022 04:57:00 -0700 (PDT)
From:   =?UTF-8?q?Alvin=20=C5=A0ipraga?= <alvin@pqrs.dk>
To:     Arend van Spriel <aspriel@gmail.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Kalle Valo <kvalo@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Cc:     Syed Rafiuddeen <syed.rafiuddeen@cypress.com>,
        Syed Rafiuddeen <syed.rafiuddeen@infineon.com>,
        Chung-Hsien Hsu <chung-hsien.hsu@infineon.com>,
        Chi-hsien Lin <chi-hsien.lin@infineon.com>,
        =?UTF-8?q?Alvin=20=C5=A0ipraga?= <alsi@bang-olufsen.dk>,
        linux-wireless@vger.kernel.org,
        brcm80211-dev-list.pdl@broadcom.com,
        SHA-cyfmac-dev-list@infineon.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 6/6] brcmfmac: Update SSID of hidden AP while informing its bss to cfg80211 layer
Date:   Fri, 22 Jul 2022 13:56:31 +0200
Message-Id: <20220722115632.620681-7-alvin@pqrs.dk>
X-Mailer: git-send-email 2.37.0
In-Reply-To: <20220722115632.620681-1-alvin@pqrs.dk>
References: <20220722115632.620681-1-alvin@pqrs.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Syed Rafiuddeen <syed.rafiuddeen@cypress.com>

cfg80211 layer on DUT STA is disconnecting ongoing connection attempt after
receiving association response, because cfg80211 layer does not have valid
AP bss information. On association response event, brcmfmac communicates
the AP bss information to cfg80211 layer, but SSID seem to be empty in AP
bss information, and cfg80211 layer prints kernel warning and then
disconnects the ongoing connection attempt.

SSID is empty in SSID IE, but 'bi->SSID' contains a valid SSID, so
updating the SSID for hidden AP while informing its bss information
to cfg80211 layer.

Signed-off-by: Syed Rafiuddeen <syed.rafiuddeen@infineon.com>
Signed-off-by: Chung-Hsien Hsu <chung-hsien.hsu@infineon.com>
Signed-off-by: Chi-hsien Lin <chi-hsien.lin@infineon.com>
Signed-off-by: Alvin Šipraga <alsi@bang-olufsen.dk>
---
 .../net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c    | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
index 6ef574d69755..d6127b855060 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
@@ -2989,6 +2989,7 @@ static s32 brcmf_inform_single_bss(struct brcmf_cfg80211_info *cfg,
 	u8 *notify_ie;
 	size_t notify_ielen;
 	struct cfg80211_inform_bss bss_data = {};
+	const struct brcmf_tlv *ssid = NULL;
 
 	if (le32_to_cpu(bi->length) > WL_BSS_INFO_MAX) {
 		bphy_err(drvr, "Bss info is larger than buffer. Discarding\n");
@@ -3018,6 +3019,12 @@ static s32 brcmf_inform_single_bss(struct brcmf_cfg80211_info *cfg,
 	notify_ielen = le32_to_cpu(bi->ie_length);
 	bss_data.signal = (s16)le16_to_cpu(bi->RSSI) * 100;
 
+	ssid = brcmf_parse_tlvs(notify_ie, notify_ielen, WLAN_EID_SSID);
+	if (ssid && ssid->data[0] == '\0' && ssid->len == bi->SSID_len) {
+		/* Update SSID for hidden AP */
+		memcpy((u8 *)ssid->data, bi->SSID, bi->SSID_len);
+	}
+
 	brcmf_dbg(CONN, "bssid: %pM\n", bi->BSSID);
 	brcmf_dbg(CONN, "Channel: %d(%d)\n", channel, freq);
 	brcmf_dbg(CONN, "Capability: %X\n", notify_capability);
-- 
2.37.0

