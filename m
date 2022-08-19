Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44AA1599514
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 08:11:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346603AbiHSGI5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 02:08:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345200AbiHSGIO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 02:08:14 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90EF42186
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 23:08:12 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id dc19so6944308ejb.12
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 23:08:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=eWEeXziGUOdEI5oNKy03c0myTReCFeg7Foyw+1lcRrk=;
        b=C9BTh0YcOoOM+BaJ2jk5zMccdNL47XP+7S5376uY+xgH6uRxcyHeCmDoyhhrIffsc0
         mIeT1wFHo/21wfMQbD0fKh1NjqQs2sb3ZrmSP2JMItCcYlbBxIx1TADQiRTcyosNM9tw
         +FyZd7QOH81Dme/UxmvamfsGx0WScUC/ViWAgVMozeJatq0kX/BSs7Iez1wV60pEjUBD
         xJfvpv9cn2tJZGwRA9tqEblawThl932jNqLX+yGMqxvkERGnh6xSR3hlOKURMhgcr2y8
         JHYrsxeUt4r8Ee0D1OGfHo6HRsXUNFvRQhC89MqeC/3cT/mua8iAVdzF4VSGrLtY/6c2
         6aYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=eWEeXziGUOdEI5oNKy03c0myTReCFeg7Foyw+1lcRrk=;
        b=qN0TunTAnTNWmz41W1EmXOUYG5z/9mwdXLBygp/xE8/4GcoOlAKAEQ5HhEZM2p/Fm1
         SRzHT50nuU7G2s8q81+RKZt57M+37UUpd62O56YwnretDTQod67kapzg0Lfflgy5MuXj
         AWANMGrvqH6P+5cWbAsXapURUsnua+skqj6iw8X2o8+RSvp4qbSnDS4FzQEA1P8uyJ95
         hDkYc0qeIjerQycXpvy1Z+PWN6xUOKNP3z9Dp/X1umTcZmhI/9jP0si9TurW0o439zdP
         v2hC0JNXdWtsGkdyNgBizmb7k+dpT7dCg/fqNkj7mWMIz6DrDW0UKBvxlrajmuUhgNby
         /JXA==
X-Gm-Message-State: ACgBeo275UQt8zKShAoc4HK7Abu8C6Cvlj5a7+yN5VHa5YCMVvUqng2+
        hMB4jzb46muabGb2M3g9x34uELLSsS1ZaOr8
X-Google-Smtp-Source: AA6agR47/tWuHZ8ns6fn80zPTh504eMTVk+51+SP8s7pyX37EYo602cuTfFZaMo2I/nNiLw/xYzREw==
X-Received: by 2002:a17:907:2c5b:b0:73c:5bcb:8eb2 with SMTP id hf27-20020a1709072c5b00b0073c5bcb8eb2mr2422858ejc.38.1660889290951;
        Thu, 18 Aug 2022 23:08:10 -0700 (PDT)
Received: from lb02065.fritz.box ([2001:9e8:143b:fd00:5207:8c7f:747a:b80d])
        by smtp.gmail.com with ESMTPSA id y14-20020a1709063a8e00b0073a644ef803sm1809660ejd.101.2022.08.18.23.08.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Aug 2022 23:08:10 -0700 (PDT)
From:   Jack Wang <jinpu.wang@ionos.com>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Alexey Sheplyakov <asheplyakov@basealt.ru>,
        Stephen Boyd <swboyd@chromium.org>,
        Weitao Wang <WeitaoWang-oc@zhaoxin.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-usb@vger.kernel.org
Subject: [PATCH v1 06/19] usb/hcd: Fix dma_map_sg error check
Date:   Fri, 19 Aug 2022 08:07:48 +0200
Message-Id: <20220819060801.10443-7-jinpu.wang@ionos.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220819060801.10443-1-jinpu.wang@ionos.com>
References: <20220819060801.10443-1-jinpu.wang@ionos.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

dma_map_sg return 0 on error.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Alan Stern <stern@rowland.harvard.edu>
Cc: Kishon Vijay Abraham I <kishon@ti.com>
Cc: Alexey Sheplyakov <asheplyakov@basealt.ru>
Cc: Stephen Boyd <swboyd@chromium.org>
Cc: Weitao Wang <WeitaoWang-oc@zhaoxin.com>
Cc: Matthias Kaehlcke <mka@chromium.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: linux-usb@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

Signed-off-by: Jack Wang <jinpu.wang@ionos.com>
---
 drivers/usb/core/hcd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/core/hcd.c b/drivers/usb/core/hcd.c
index 94b305bbd621..90dd32a24e5b 100644
--- a/drivers/usb/core/hcd.c
+++ b/drivers/usb/core/hcd.c
@@ -1474,7 +1474,7 @@ int usb_hcd_map_urb_for_dma(struct usb_hcd *hcd, struct urb *urb,
 						urb->sg,
 						urb->num_sgs,
 						dir);
-				if (n <= 0)
+				if (!n)
 					ret = -EAGAIN;
 				else
 					urb->transfer_flags |= URB_DMA_MAP_SG;
-- 
2.34.1

