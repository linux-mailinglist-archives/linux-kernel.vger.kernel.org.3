Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 256F349765A
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 00:34:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240458AbiAWXeJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jan 2022 18:34:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230242AbiAWXeH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jan 2022 18:34:07 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F098BC06173B;
        Sun, 23 Jan 2022 15:34:06 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id u15so10398648wrt.3;
        Sun, 23 Jan 2022 15:34:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gX00LRfhLCwbvXu3aEovaKIbbvwVWpZ2zTED2Jz94hQ=;
        b=NpLW2Eki7mEVKi5nncvoW0FPpKpzZ0NkLEkJaqkI5Rt+KtuC6DWKpSqMz0FbqpQ/+B
         NgPrUxWuK3v34tNdIscSMLRoVByDpF8TkMDjf1ixugoKWs5Yyr9O23buM3VczPTtmVBa
         tA8duLElAsFUWuIyebGBbG/ejiSws11SUGs2SLd3VBEt06bya/SBkdsDMq0zBaJOTbiV
         TKzmkRp7h9GGXieEEzR+JhtzwYiQZcyppstExzUW28+SGQnQkUKzSx6guDWMim/REXzc
         VsNSY7UXwMwfwMNdl2Hh21JdS2uGwcqax/ztveqbokcKuwWfUX2hcGY982gKExvSUVEl
         uQtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gX00LRfhLCwbvXu3aEovaKIbbvwVWpZ2zTED2Jz94hQ=;
        b=VLe1UCAkrSdrQe72p+NrwSsQ7LacqW24siQeTkHEK/gzLrxiPkQtaK9cxRwxMn+kwe
         rMQu5MJFRo5lSDNX9rSdz5rwdf5vvLIdetTygfg8+UxErzQd+dc1k8W3BJ8P4H9VWeaQ
         e+VHE8oyP0olCtz4+7RULt5mWqLL44tiLDPMJk9lt+5SBTz9GzcKCBRQsCRcr8DLlOJy
         ZukruC85F5p765aNFOn9XvdxRu43GimD283KSoaecqqxit3g2CfHGY3wz8CitfSzRXIC
         If3J06ThFBufMP4MW5mB3wGBUg/dMI6tEdJnn6gkKL1y632Bj+SFKtOsZGm3ockxql7x
         D5vQ==
X-Gm-Message-State: AOAM533pO1oQXOBtSjO8i2OdZ52Ohm/+wBUUF+2uDfAWpzs9II+0+N7H
        XPAktMhpFTMUuDGYeI1qAgbi9gqXE7ps5w==
X-Google-Smtp-Source: ABdhPJw5+dICUhQBxSLbu9/1d8Kqd/W4DA9m4VwhtLtn+Ip/6m5srbg1xboW1rgya5qhkmQFElR81w==
X-Received: by 2002:a5d:47ad:: with SMTP id 13mr12566259wrb.545.1642980845130;
        Sun, 23 Jan 2022 15:34:05 -0800 (PST)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id i3sm12307206wru.33.2022.01.23.15.34.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Jan 2022 15:34:04 -0800 (PST)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Dominik Brodowski <linux@dominikbrodowski.net>
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] pcmcia: rsrc_nonstatic: make static read-only array order const
Date:   Sun, 23 Jan 2022 23:34:03 +0000
Message-Id: <20220123233403.8482-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The static array is order read-only so it make sense to make
it const.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/pcmcia/rsrc_nonstatic.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pcmcia/rsrc_nonstatic.c b/drivers/pcmcia/rsrc_nonstatic.c
index 6b6c578b5f92..bde377655d48 100644
--- a/drivers/pcmcia/rsrc_nonstatic.c
+++ b/drivers/pcmcia/rsrc_nonstatic.c
@@ -480,7 +480,7 @@ static u_long inv_probe(struct resource_map *m, struct pcmcia_socket *s)
 static int validate_mem(struct pcmcia_socket *s, unsigned int probe_mask)
 {
 	struct resource_map *m, mm;
-	static unsigned char order[] = { 0xd0, 0xe0, 0xc0, 0xf0 };
+	static const unsigned char order[] = { 0xd0, 0xe0, 0xc0, 0xf0 };
 	unsigned long b, i, ok = 0;
 	struct socket_data *s_data = s->resource_data;
 
-- 
2.33.1

