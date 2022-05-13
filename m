Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3E3552623B
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 14:45:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380399AbiEMMoG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 08:44:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377793AbiEMMnO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 08:43:14 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93B2B38DB1;
        Fri, 13 May 2022 05:43:13 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id qe3-20020a17090b4f8300b001dc24e4da73so7816518pjb.1;
        Fri, 13 May 2022 05:43:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=h/lzCrNSdK6aw6uu8WZ5885TJVvZQC7khSR0mjKmT9o=;
        b=Vxd1yiOzjv3kwu8hu9Aj+mCmcbe8+8hiJNTdhvpH25P/4+RNW1VFFYZcdUYDX/bJOS
         LDRax70bo3c0nHwPfBrxWNLpINvIihr7F7UwUZplDAqsAe7ON9Tvx49rufjwRMzwAAJf
         GQ4IFoWn/xJumtt9bf1MxXH8zKi+JJXPk+Yi7QTG2Qcu6An2thxl1AHQe6T34DI9Iual
         ZtEO4UexYc3yAdPFHLXPv05LS5zG6hyNrAlPisSidlTvfeu5oiHlTXp2C67fFrRYVj54
         /36OKKi61Oe+3IFB70dtVjA5JUE9PcRgQITtLTBgAk/xHhB6DbEvX/iarwogc34IG4tT
         V6Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=h/lzCrNSdK6aw6uu8WZ5885TJVvZQC7khSR0mjKmT9o=;
        b=jVo31LdT14dRKYz1R8ehyfDUEX/GNeDqGQ5p19qO+d4COqvTEXLvdAHl+rePAGZjP/
         UtRVzigowMKkoYbVwWIfTodCbqeXNmvorym+8QfFMnvEp06aGcHMF1ZjuJPgalBR1WZ0
         KdhCjcNjx9tHKj2/8nYW1PPO+V4XFY2vEeT4wHOQehEGyuKYSZPpKMz60nd3nHV3kT9y
         cEZba1mLRu9rJsEOmZy6AOL9yGzzhdrd5q8alcl1IDm1I4K64TDwu4Zzjq267ZLquPKK
         +Y/pCZfwpV4YlNh+71UqMx/FXKccXm9VDM7ZELQrbhJ9hbjVhJiC/xthuPgJ04+E+wit
         gmyg==
X-Gm-Message-State: AOAM533S17xhR83iIc7aD/YfZxw31McO0gCpiwbaw8kJss9NUBnwJcbN
        M1W82evrGObtE+TT/fF87w==
X-Google-Smtp-Source: ABdhPJw79BFYrocdWto1AapSc9S27/5HmJ8vUy568L6AVdsVn79Ocg7HiJvH5kD4yuoOlyEbwEJNCA==
X-Received: by 2002:a17:90a:a410:b0:1dc:d03b:5623 with SMTP id y16-20020a17090aa41000b001dcd03b5623mr4830324pjp.95.1652445793339;
        Fri, 13 May 2022 05:43:13 -0700 (PDT)
Received: from localhost.localdomain ([144.202.91.207])
        by smtp.gmail.com with ESMTPSA id g11-20020a170902868b00b0015e8d4eb250sm1748653plo.154.2022.05.13.05.43.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 May 2022 05:43:12 -0700 (PDT)
From:   Zheyu Ma <zheyuma97@gmail.com>
To:     marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com
Cc:     linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        Zheyu Ma <zheyuma97@gmail.com>
Subject: [PATCH] bluetooth: bfusb: Check the endpoint type at probe
Date:   Fri, 13 May 2022 20:43:03 +0800
Message-Id: <20220513124303.2192981-1-zheyuma97@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver reported an warning in usb_submit_urb() which is caused by
wrong endpoint type.

[    3.295630] usb 1-1: BOGUS urb xfer, pipe 3 != type 1
[    3.295916] WARNING: CPU: 0 PID: 33 at drivers/usb/core/urb.c:503 usb_submit_urb+0xcd9/0x18b0
[    3.298155] RIP: 0010:usb_submit_urb+0xcd9/0x18b0
[    3.302451] Call Trace:
[    3.302580]  <TASK>
[    3.302698]  bfusb_rx_submit+0x24e/0x390 [bfusb]
[    3.302938]  bfusb_open+0x50/0x90 [bfusb]

Fix this by checking the endpoint type at first.

Signed-off-by: Zheyu Ma <zheyuma97@gmail.com>
---
 drivers/bluetooth/bfusb.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/bluetooth/bfusb.c b/drivers/bluetooth/bfusb.c
index cab93935cc7f..447b6876c552 100644
--- a/drivers/bluetooth/bfusb.c
+++ b/drivers/bluetooth/bfusb.c
@@ -613,7 +613,9 @@ static int bfusb_probe(struct usb_interface *intf, const struct usb_device_id *i
 	bulk_out_ep = &intf->cur_altsetting->endpoint[0];
 	bulk_in_ep  = &intf->cur_altsetting->endpoint[1];
 
-	if (!bulk_out_ep || !bulk_in_ep) {
+	if (!bulk_out_ep || !bulk_in_ep ||
+		!usb_endpoint_is_bulk_out(&bulk_out_ep->desc) ||
+		!usb_endpoint_is_bulk_in(&bulk_in_ep->desc)) {
 		BT_ERR("Bulk endpoints not found");
 		goto done;
 	}
-- 
2.25.1

