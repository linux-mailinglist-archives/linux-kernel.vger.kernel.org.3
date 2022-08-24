Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFA725A022E
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 21:38:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238988AbiHXTiZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 15:38:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237076AbiHXTiW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 15:38:22 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A602792CD;
        Wed, 24 Aug 2022 12:38:22 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id c2so16562333plo.3;
        Wed, 24 Aug 2022 12:38:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=+a6jv7NfNrfRkmcgmIrBanDX9FdHOAhQmluL8KWS9kY=;
        b=hS9HSmuVExcPoo1oXgtzI+luC6C9dx3+aaSsA3utzcJW2xp+mcy194vf6PDE+5soJJ
         MoOf0ZM30sejHgrOdYtB94MFfcv+wH5JjlWx/ITOUSXpzzoZARlTp1SkASmluEN216e+
         QBd/c9VaKMkxKHZ1h+tltKOZkTRnsEHn+kLKnQxlpuuFuIqczkGF+ixb1PJZbRhI7pvg
         2iRGOHKKO9sK2JcM6Gr8D2eyoae6ErW+yjU+nQslSCyEwutGfMjc5deoT9jEvy9wIuZo
         oRo+a0aL6rueqb2C2C1iHTjK0E+aLYex2+b8eZ4K7+V0kgvZF9mDv1S/7ZP/PyyIq0zT
         INrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=+a6jv7NfNrfRkmcgmIrBanDX9FdHOAhQmluL8KWS9kY=;
        b=sTNyq6Wo2wmYI0H2aFpJEMdO1xK9KsxQ41R6h188jvmDm6jf1rQNLHx11SCNN0a2lc
         ZUrkrVQUma1KYtJMxrl8BiJJlgXqxlB644gZTbZBkm2gUvfwvM69PdUpAMc4zNVxmuHz
         EAxLfeoGE35wwsmT9GdBwTSYOcQfmfN/FWExpKTfwjTiONbrRDM7Zra1yxGzAl1IzjYH
         Q6K9iPkZOODJibD49meHGwWTDGaUzJMz4Bi1PDEIFyj9DLqWYeKeRTGLUda+6ZAosYdz
         iLfZUoDfZuc4goQSjPbrS1VyIwCbd8vnjlwpnKD/Dtybevxp55L1wG6+VCC1JtM5CuCe
         2hXw==
X-Gm-Message-State: ACgBeo01RSzCDVyrnQFyYkdlGBvDMRKPsZyDuppWyVkDnqHlZSjWO/95
        tULRMIvbHkwrspcLN4MmCY4=
X-Google-Smtp-Source: AA6agR7mG1hX2EMA+Idul5KJg99esNSnsDHlCIyKQqqI9GrDY4rzzRbbgZVkiutkB4BTlTMXCYUcwg==
X-Received: by 2002:a17:902:c949:b0:172:e3c3:bdeb with SMTP id i9-20020a170902c94900b00172e3c3bdebmr364156pla.80.1661369901604;
        Wed, 24 Aug 2022 12:38:21 -0700 (PDT)
Received: from fedora.. ([103.159.189.144])
        by smtp.gmail.com with ESMTPSA id p4-20020a1709026b8400b001729da53673sm12968558plk.14.2022.08.24.12.38.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Aug 2022 12:38:20 -0700 (PDT)
From:   Khalid Masum <khalid.masum.92@gmail.com>
To:     Alan Stern <stern@rowland.harvard.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Jack Pham <jackp@codeaurora.org>,
        Manu Gautam <mgautam@codeaurora.org>,
        Khalid Masum <khalid.masum.92@gmail.com>
Subject: [PATCH v2] usb: ehci: Use endpoint in URB to get maxpacket
Date:   Thu, 25 Aug 2022 01:38:13 +0600
Message-Id: <20220824193813.13129-1-khalid.masum.92@gmail.com>
X-Mailer: git-send-email 2.37.1
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

usb_maxpacket() looks up the endpoint number in the pipe which can fail
if the interface or configuration changes before the routine is called.
This is unexpected and may even cause a modulo by zero afterwards.

So use usb_endpoint_maxp() routine which uses the endpoint stored in URB
to get the maxpacket.

Addresses-Coverity: 744857 ("Division or modulo by zero")
Addresses-Coverity: 1487371 ("Division or modulo by zero")
Suggested-by: Alan Stern <stern@rowland.harvard.edu>
Signed-off-by: Khalid Masum <khalid.masum.92@gmail.com>
---
Changes since v1:
 - Update commit description
 - Use usb_endpoint_maxp() instead of checking whether getting maxpacket
   failed
 - Link: https://lore.kernel.org/lkml/20220823182758.13401-1-khalid.masum.92@gmail.com/

 drivers/usb/host/ehci-q.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/host/ehci-q.c b/drivers/usb/host/ehci-q.c
index 807e64991e3e..666f5c4db25a 100644
--- a/drivers/usb/host/ehci-q.c
+++ b/drivers/usb/host/ehci-q.c
@@ -645,7 +645,7 @@ qh_urb_transaction (
 		token |= (1 /* "in" */ << 8);
 	/* else it's already initted to "out" pid (0 << 8) */
 
-	maxpacket = usb_maxpacket(urb->dev, urb->pipe);
+	maxpacket = usb_endpoint_maxp(&urb->ep->desc);
 
 	/*
 	 * buffer gets wrapped in one or more qtds;
@@ -1218,7 +1218,7 @@ static int ehci_submit_single_step_set_feature(
 
 	token |= (1 /* "in" */ << 8);  /*This is IN stage*/
 
-	maxpacket = usb_maxpacket(urb->dev, urb->pipe);
+	maxpacket = usb_endpoint_maxp(&urb->ep->desc);
 
 	qtd_fill(ehci, qtd, buf, len, token, maxpacket);
 
-- 
2.37.1

