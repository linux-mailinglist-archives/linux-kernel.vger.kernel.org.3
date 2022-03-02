Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86A2C4CADB8
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 19:37:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242895AbiCBSih (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 13:38:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237926AbiCBSi2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 13:38:28 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37E5233E87
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 10:37:43 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id pj17so1217637ejb.2
        for <linux-kernel@vger.kernel.org>; Wed, 02 Mar 2022 10:37:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PoZkJu6l4h6aEzKk7gmr65X6dMSH0Mhj2hdZdZe2/k8=;
        b=sCZsWSaON5fifyK+cTu9Jpav7ukmQdPZcvJ8b1jip96KR+SkxHipK9wJjrwjFVQPCL
         asHEqwz1jlbctMX6R4MF5ZgHzXalSY9PNXzB5M1ELN40mdln2T/k1KoIZ6nSC/1+52N0
         SuD1XUwvqwnjZA+T5HBrlH5+8wV1Y8nsT6gNrcLfzINuhkvaglQCEo//V1+vhpdwxIEy
         /KbdSVBZDeMzxuQy/z3t5sCw7fnJiE762wYu1WuM/gyjoroTgVxZaY2HJxmdqtuELCyg
         X0yLgvkUZVZEPLbAXDuQZVGbGghDWdxyVFRJ56apHgHQbMJ0B7lDAM3r2uHEcSaaayvw
         Q8Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PoZkJu6l4h6aEzKk7gmr65X6dMSH0Mhj2hdZdZe2/k8=;
        b=v/6iHG0z121BgY25WUjAs8tR8XuI8HAqKIfbPIwW7tLd6LEfPtIPTS3vC6MBO/uL/a
         yp7WkFKWDPWHhQ+GnKPSsG+3SP96PAxtmfr/ekvCUS0XIZBeAjgOak0sdrK3ZcoFpAvV
         r2UJClJ+gCjGCtuiSOyTxr3w2F/Q6HFgnwfM44/oHGMgRyXOUexMHCUUgR3JCZMOC9T2
         b8aECu6+S4MZaPb1froypGpgI5TLsW+KokFVC7Q3JBSaadftEX6sA9vkBqdFVxc4kbpz
         Gkn7aN8NJR/e/2e7HOJnGmErJ+Qt/EzWMOSLnSJOiyGzyNBoylSx2JOmghOzXp47d9KH
         JgWQ==
X-Gm-Message-State: AOAM5300SuMWp3gCitgjmvl15/onLAYSJ0vBsimlUj3pfkcGKCdAlfb/
        A0TGYxn2wIQZYL1fFaqy4CJsaA==
X-Google-Smtp-Source: ABdhPJz4rF9lPkcQKUWNfVTvbozvbxjzwEWTM141WwHUI8VTZcXbD4YSDWRS8Hr9C8nf3kA1RjFEmQ==
X-Received: by 2002:a17:906:9913:b0:6d6:dc48:5d49 with SMTP id zl19-20020a170906991300b006d6dc485d49mr9576712ejb.325.1646246261332;
        Wed, 02 Mar 2022 10:37:41 -0800 (PST)
Received: from localhost.localdomain (cpc78119-cwma10-2-0-cust590.7-3.cable.virginm.net. [81.96.50.79])
        by smtp.gmail.com with ESMTPSA id b17-20020aa7c6d1000000b0041301be2b5esm8732375eds.58.2022.03.02.10.37.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Mar 2022 10:37:40 -0800 (PST)
From:   Caleb Connolly <caleb.connolly@linaro.org>
To:     caleb.connolly@linaro.org, Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: [PATCH v2] bluetooth: hci_event: don't print an error on vendor events
Date:   Wed,  2 Mar 2022 18:35:17 +0000
Message-Id: <20220302183515.448334-1-caleb.connolly@linaro.org>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit 3e54c5890c87 ("Bluetooth: hci_event: Use of a function table to handle HCI events"),
some devices see warnings being printed for vendor events, e.g.

[   75.806141] Bluetooth: hci0: setting up wcn399x
[   75.948311] Bluetooth: hci0: unexpected event 0xff length: 14 > 0
[   75.955552] Bluetooth: hci0: QCA Product ID   :0x0000000a
[   75.961369] Bluetooth: hci0: QCA SOC Version  :0x40010214
[   75.967417] Bluetooth: hci0: QCA ROM Version  :0x00000201
[   75.973363] Bluetooth: hci0: QCA Patch Version:0x00000001
[   76.000289] Bluetooth: hci0: QCA controller version 0x02140201
[   76.006727] Bluetooth: hci0: QCA Downloading qca/crbtfw21.tlv
[   76.986850] Bluetooth: hci0: unexpected event 0xff length: 3 > 0
[   77.013574] Bluetooth: hci0: QCA Downloading qca/oneplus6/crnv21.bin
[   77.024302] Bluetooth: hci0: unexpected event 0xff length: 3 > 0
[   77.032681] Bluetooth: hci0: unexpected event 0xff length: 3 > 0
[   77.040674] Bluetooth: hci0: unexpected event 0xff length: 3 > 0
[   77.049251] Bluetooth: hci0: unexpected event 0xff length: 3 > 0
[   77.057997] Bluetooth: hci0: unexpected event 0xff length: 3 > 0
[   77.066320] Bluetooth: hci0: unexpected event 0xff length: 3 > 0
[   77.075065] Bluetooth: hci0: unexpected event 0xff length: 3 > 0
[   77.083073] Bluetooth: hci0: unexpected event 0xff length: 3 > 0
[   77.091250] Bluetooth: hci0: unexpected event 0xff length: 3 > 0
[   77.099417] Bluetooth: hci0: unexpected event 0xff length: 3 > 0
[   77.110166] Bluetooth: hci0: unexpected event 0xff length: 3 > 0
[   77.118672] Bluetooth: hci0: unexpected event 0xff length: 3 > 0
[   77.127449] Bluetooth: hci0: unexpected event 0xff length: 3 > 0
[   77.137190] Bluetooth: hci0: unexpected event 0xff length: 3 > 0
[   77.146192] Bluetooth: hci0: unexpected event 0xff length: 3 > 0
[   77.154242] Bluetooth: hci0: unexpected event 0xff length: 3 > 0
[   77.163183] Bluetooth: hci0: unexpected event 0xff length: 3 > 0
[   77.171202] Bluetooth: hci0: unexpected event 0xff length: 3 > 0
[   77.179364] Bluetooth: hci0: unexpected event 0xff length: 3 > 0
[   77.187259] Bluetooth: hci0: unexpected event 0xff length: 3 > 0
[   77.198451] Bluetooth: hci0: QCA setup on UART is completed

Avoid printing the event length warning for vendor events, this reverts
to the previous behaviour where such warnings weren't printed.

Fixes: 3e54c5890c87 ("Bluetooth: hci_event: Use of a function table to handle HCI events")
Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
Changes since v1:
 * Don't return early! Vendor events still get parsed despite the
   warning. I should have looked a little more closely at that...
---
 net/bluetooth/hci_event.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index fc30f4c03d29..9b7c9ab77971 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -6822,7 +6822,7 @@ static void hci_event_func(struct hci_dev *hdev, u8 event, struct sk_buff *skb,
 	 * possible to partially parse the event so leave to callback to
 	 * decide if that is acceptable.
 	 */
-	if (skb->len > ev->max_len)
+	if (skb->len > ev->max_len && event != HCI_EV_VENDOR)
 		bt_dev_warn(hdev, "unexpected event 0x%2.2x length: %u > %u",
 			    event, skb->len, ev->max_len);
 
-- 
2.35.1

