Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAE485A5F96
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 11:38:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231234AbiH3Jhs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 05:37:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230133AbiH3JhX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 05:37:23 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13520322
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 02:34:47 -0700 (PDT)
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 0F6E33F45B
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 09:34:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1661852085;
        bh=CHqY99GLtJsApSMjqMH/7szxzsT67JjTWutPGr/E5Rs=;
        h=From:To:Subject:Date:Message-Id:MIME-Version;
        b=Vd/hI9mXWqotwiwE7y2zAKGBDpqDUhv2pYgE6d6XYYQ0soFMQsWQPis7rWhTC5V/n
         x30/YFY2hfh2YkN9kKu0CZfulVp2rSQT8t2+L1YAr9Hrkj29vU14njvG9QHkoGusS7
         whu4ONoIw/+lUFfbTwXKXPrhumxN/rzbQXuLwxM6RzhtR20gBKAG8eOwq+xcIKC6tU
         ubSFH9RV4BwO7EEVShfg/efUvWvofMdkAMFDSD0iPFuxCpsYI8DQRgXVWwnw5fjaCa
         AzZoPz03LrVKBoFCEznm6MuDvL+W5GgiIB0OWflD5OpHLQpIcVIQxfNOx8LhpAFFaY
         7e2rmsMnXwrWw==
Received: by mail-pl1-f200.google.com with SMTP id z14-20020a170903018e00b00174fff57d17so1917524plg.14
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 02:34:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc;
        bh=CHqY99GLtJsApSMjqMH/7szxzsT67JjTWutPGr/E5Rs=;
        b=GuZMa4skWcokWuiBKWMAyrkj7AiF6WmNbkeI7ig7KOUMAaNWQ4yEnnI7Monmyx1fj5
         Y/gLo69bPLnjMlrwGD8ju6lSJNTiuDxwTVc1M2MU9LgZR8HBRutG45krRr1dpsc7U8JH
         tkx/t2LD8kp0zwxuXC3dnhJLxKnqiijAaONVJOhOqT7Siom+SjxufwFC98xjEgv/lA9t
         YFRtMuPnbMxgLWMd0hWWL2fYUprPBhB9duaczm7OyYxnjGut42b9YqQRaaS3z7INOyXa
         ryxyHd0d7lFhrqYV1SWgRZjcawpc+LG0IBTAJ4cZ7JXlUBNM/ycJbZedm+5akBS7BMOV
         dnBw==
X-Gm-Message-State: ACgBeo1z2PbQ2iNashVOhbNi76M9UazTTeWe0lM8adZ64bgsQW8o267H
        TcEkV6QWk71/ffDtst24jdJu6e/FTNZ7b75HW06DGujGzNN0Vvjh1uJwBJjx9cQP7X2ckd/nXuj
        EWbG6dAeZgAPnIAUFliUOCxMydjs8Z3qvvyq6Oy7qOw==
X-Received: by 2002:a17:90b:388f:b0:1f5:7748:9667 with SMTP id mu15-20020a17090b388f00b001f577489667mr23095649pjb.158.1661852083556;
        Tue, 30 Aug 2022 02:34:43 -0700 (PDT)
X-Google-Smtp-Source: AA6agR6Wk9P3i8UhaVxV9GyDBpsSXp0cc6E2T6UpDcQUroyyCgFNQDLxPK6AteHfPviKWoRcn/cnng==
X-Received: by 2002:a17:90b:388f:b0:1f5:7748:9667 with SMTP id mu15-20020a17090b388f00b001f577489667mr23095634pjb.158.1661852083297;
        Tue, 30 Aug 2022 02:34:43 -0700 (PDT)
Received: from canonical.com (2001-b011-3815-3671-090c-7c62-b076-d6cb.dynamic-ip6.hinet.net. [2001:b011:3815:3671:90c:7c62:b076:d6cb])
        by smtp.gmail.com with ESMTPSA id d81-20020a621d54000000b0052ac12e7596sm8734418pfd.114.2022.08.30.02.34.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Aug 2022 02:34:41 -0700 (PDT)
From:   Koba Ko <koba.ko@canonical.com>
To:     Tom Lendacky <thomas.lendacky@amd.com>,
        John Allen <john.allen@amd.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: crypto: ccp - Release dma channels before dmaengine unrgister
Date:   Tue, 30 Aug 2022 17:34:39 +0800
Message-Id: <20220830093439.951960-1-koba.ko@canonical.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A warning is shown during shutdown,

__dma_async_device_channel_unregister called while 2 clients hold a reference
WARNING: CPU: 15 PID: 1 at drivers/dma/dmaengine.c:1110 
__dma_async_device_channel_unregister

Call dma_release_channel for occupied channles 
before dma_async_device_unregister.

Fixes: 4cbe9bc34ed0 ("crypto: ccp - ccp_dmaengine_unregister release dma channels")
Signed-off-by: Koba Ko <koba.ko@canonical.com>
---
 drivers/crypto/ccp/ccp-dmaengine.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/crypto/ccp/ccp-dmaengine.c b/drivers/crypto/ccp/ccp-dmaengine.c
index 7d4b4ad1db1f3..ba3eb1ac3b55d 100644
--- a/drivers/crypto/ccp/ccp-dmaengine.c
+++ b/drivers/crypto/ccp/ccp-dmaengine.c
@@ -641,6 +641,10 @@ static void ccp_dma_release(struct ccp_device *ccp)
 	for (i = 0; i < ccp->cmd_q_count; i++) {
 		chan = ccp->ccp_dma_chan + i;
 		dma_chan = &chan->dma_chan;
+
+		if (dma_chan->client_count)
+			dma_release_channel(dma_chan);
+
 		tasklet_kill(&chan->cleanup_tasklet);
 		list_del_rcu(&dma_chan->device_node);
 	}
@@ -762,12 +766,14 @@ int ccp_dmaengine_register(struct ccp_device *ccp)
 void ccp_dmaengine_unregister(struct ccp_device *ccp)
 {
 	struct dma_device *dma_dev = &ccp->dma_dev;
+	struct dma_chan *dma_chan;
+	unsigned int i;
 
 	if (!dmaengine)
 		return;
 
-	dma_async_device_unregister(dma_dev);
 	ccp_dma_release(ccp);
+	dma_async_device_unregister(dma_dev);
 
 	kmem_cache_destroy(ccp->dma_desc_cache);
 	kmem_cache_destroy(ccp->dma_cmd_cache);
-- 
2.25.1

