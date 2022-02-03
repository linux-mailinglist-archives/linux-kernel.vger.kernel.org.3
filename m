Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4611C4A896B
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 18:10:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352591AbiBCRJu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 12:09:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352525AbiBCRJg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 12:09:36 -0500
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02962C061714
        for <linux-kernel@vger.kernel.org>; Thu,  3 Feb 2022 09:09:36 -0800 (PST)
Received: by mail-il1-x131.google.com with SMTP id o10so2697896ilh.0
        for <linux-kernel@vger.kernel.org>; Thu, 03 Feb 2022 09:09:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=S9Js8VpK5v34d/SHjXYqifp26sYx/3WFpJFibcc3jAA=;
        b=Dn5ffHOFIO+yxvEZJhMhn0TK54JUtSJ2/L9VR8EWcm2GiNI9xyomj0/XMucFfjR+Tg
         fhpqJKugfueNgWmfNR7AqjlAvAjpZyNz7nO1q7RWCnDNaQZxROARuFoWEXYxwZczrnPp
         luJ3+P4mfLGnSQ5BzdktgImcQ1HiNIfw4RAqTiVjsh5YbN9jyJcnjpxHspVIdp3dzkXl
         qUNxvbTwW6VrLRl/Hz/MiBaq0Un1xdjSUnyNRkUpZLvEuc6SWvl224SUPQ9HFrnck56v
         s6Xr4S501o1zb8Q2F79tjsRE9OtN9e/BtkkH5FabZ/QvqxO6OMKDrwk9vCNszyBSEFSN
         A2Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=S9Js8VpK5v34d/SHjXYqifp26sYx/3WFpJFibcc3jAA=;
        b=ymraGvUh6QTCoQOKc7YNNx+75V3SIqFwVzV7gl5kGzCHRdR3KmV79ovC4/dICKlxue
         Skgrs5TDHefwgU3VocX/Njkw8yn3QbD18LvZWS7Q4K7EvHZBWoJm9OTEmCXWEt7Mdsc6
         2WmKvDsWupacr0Fm5ci6srmLkg3yQUbvm85KENAOWynruygYiGV6hEFiiNryVrnDlnb/
         elkqUVe1R1LfrXwyMwux8FoBSRBbZcHhCAhdufhe6HiixtaIUtBigONrPvQvkzV0PAyV
         2+0bRCyWwPpbsTNJdpnyJXawT58NyT56VIxMhxH8Mq0WrhHqsd7ge2jthPSwjufEaFTx
         GApQ==
X-Gm-Message-State: AOAM531xQpAPgRKLHmdmIlYBHu9U8d5AUPiaB/MiOFaGef+dYvujWBVd
        f4M2h51Zq3engrKNUvMNS565r5k0vJvrXCwo
X-Google-Smtp-Source: ABdhPJysyug1E35eI4H34ILFMbMQbJPCwvEOSw1CqL4sKLek2Gd8fXdvo80lPbU6RyGAS50+Bn3uEw==
X-Received: by 2002:a05:6e02:1a05:: with SMTP id s5mr14464952ild.231.1643908175442;
        Thu, 03 Feb 2022 09:09:35 -0800 (PST)
Received: from localhost.localdomain (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.gmail.com with ESMTPSA id m12sm21869671iow.54.2022.02.03.09.09.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Feb 2022 09:09:34 -0800 (PST)
From:   Alex Elder <elder@linaro.org>
To:     davem@davemloft.net, kuba@kernel.org
Cc:     bjorn.andersson@linaro.org, mka@chromium.org, evgreen@chromium.org,
        cpratapa@codeaurora.org, avuyyuru@codeaurora.org,
        jponduru@codeaurora.org, subashab@codeaurora.org, elder@kernel.org,
        netdev@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH net-next 02/10] net: ipa: allocate transaction before pages when replenishing
Date:   Thu,  3 Feb 2022 11:09:19 -0600
Message-Id: <20220203170927.770572-3-elder@linaro.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220203170927.770572-1-elder@linaro.org>
References: <20220203170927.770572-1-elder@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A transaction failure only occurs if no more transactions are
available for an endpoint.  It's a very cheap test.

When replenishing an RX endpoint buffer, there's no point in
allocating pages if transactions are exhausted.  So don't bother
doing so unless the transaction allocation succeeds.

Signed-off-by: Alex Elder <elder@linaro.org>
---
 drivers/net/ipa/ipa_endpoint.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ipa/ipa_endpoint.c b/drivers/net/ipa/ipa_endpoint.c
index a9f6d4083f869..f8dbd43949e16 100644
--- a/drivers/net/ipa/ipa_endpoint.c
+++ b/drivers/net/ipa/ipa_endpoint.c
@@ -1046,14 +1046,14 @@ static int ipa_endpoint_replenish_one(struct ipa_endpoint *endpoint)
 	u32 len;
 	int ret;
 
+	trans = ipa_endpoint_trans_alloc(endpoint, 1);
+	if (!trans)
+		return -ENOMEM;
+
 	buffer_size = endpoint->data->rx.buffer_size;
 	page = dev_alloc_pages(get_order(buffer_size));
 	if (!page)
-		return -ENOMEM;
-
-	trans = ipa_endpoint_trans_alloc(endpoint, 1);
-	if (!trans)
-		goto err_free_pages;
+		goto err_trans_free;
 
 	/* Offset the buffer to make space for skb headroom */
 	offset = NET_SKB_PAD;
@@ -1061,7 +1061,7 @@ static int ipa_endpoint_replenish_one(struct ipa_endpoint *endpoint)
 
 	ret = gsi_trans_page_add(trans, page, len, offset);
 	if (ret)
-		goto err_trans_free;
+		goto err_free_pages;
 	trans->data = page;	/* transaction owns page now */
 
 	if (++endpoint->replenish_ready == IPA_REPLENISH_BATCH) {
@@ -1073,10 +1073,10 @@ static int ipa_endpoint_replenish_one(struct ipa_endpoint *endpoint)
 
 	return 0;
 
-err_trans_free:
-	gsi_trans_free(trans);
 err_free_pages:
 	__free_pages(page, get_order(buffer_size));
+err_trans_free:
+	gsi_trans_free(trans);
 
 	return -ENOMEM;
 }
-- 
2.32.0

