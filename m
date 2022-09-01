Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F31C5A8B4C
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 04:16:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232507AbiIACQm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 22:16:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230189AbiIACQi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 22:16:38 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6B3BD7D27
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 19:16:36 -0700 (PDT)
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 653223F10A
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 02:16:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1661998593;
        bh=1IzFF6NAQjDWF+6OiRwseJVIAWC07UHezHJ/hzeYRN8=;
        h=From:To:Subject:Date:Message-Id:MIME-Version;
        b=qWhHWEn4igmEgy/Tm06YyI09hzpR6hkNB6YprvG2JYPj7PmAcdvjIcbydPYpQppJu
         weCKmIv3h67XdF7revUHBSR3mXiN02vh0Wgm2ngSJ3IosT7jEvrMARurHGTQ2Pm/G5
         hCt7KtPSHS8iIL2XVDVTg/BuMCjiHNKIvL0xgyYP4Ur9gbtlvl/OxJxDPszmAXQNCd
         Bu2VjYAwqvQVjuArI22/At6g1V69Xbv9TDVy4XrD6UvqgOmhcy8N/7DnCq5Hqu+m21
         nK8m9jE226krvFUlc+qYdabWnB6xly3lziOL/zN9/eron16dT5UZtq9o4WX+DOhLkD
         EEaKvrGZljTKA==
Received: by mail-pf1-f200.google.com with SMTP id s129-20020a625e87000000b005383388a6bcso4808601pfb.2
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 19:16:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc;
        bh=1IzFF6NAQjDWF+6OiRwseJVIAWC07UHezHJ/hzeYRN8=;
        b=LeGXC9p9DLDMYI3LEBiZarkBwBH5oZ07oel2KJ2bTQrwW9Y2nQNVAB8Poey5dh9abp
         E5NJO9UtFWU2z691B6sgxiPNvYhLuwkuNV2XmKqjB1JEcXmy7Uv9mX01lIsoS81sUfvf
         wYvr7Hpoc8OY6dggfGEm7ClixwXYBNOBNbgLiJcxyW6ZrbrDcRGdV7izrvkWZye2e2kP
         Q8DOAKaYVlsbmqBQaki3XHk1h/Fs7OIvXHgDa+XX/WsHCB/lnEgYStTia7T8vbgHCoSF
         3k62cpSL84qfksJZs+9NJp9T5sZ1GUVnBZ5wBCtWhYtArLNawuFykw2vW3Ho9m7NAKKU
         oaWQ==
X-Gm-Message-State: ACgBeo254t8f/rULQpogGChIR1Ncy7rn8bXVoSEtt6hqIUkIg/nJZwLt
        IF9Lx3AL8HZI2CJNUWkKRWVfMpl1pl1LlkK2y6i6OwycHabO32JdK93+lQwAMeXNZ/V1xW/2ur4
        geQOJsULgEnqRT7v2SdlfKIxYqvaFPcQe0h32KELNGA==
X-Received: by 2002:a63:4d5b:0:b0:42c:299e:eecc with SMTP id n27-20020a634d5b000000b0042c299eeeccmr13844071pgl.41.1661998591633;
        Wed, 31 Aug 2022 19:16:31 -0700 (PDT)
X-Google-Smtp-Source: AA6agR7N7E+WOAR5KMVrMlnNNPvwtUZG4N5E7Zz8yJZq3UvydP/V9Fw6/gRWjas/qyikocmrTGqKDg==
X-Received: by 2002:a63:4d5b:0:b0:42c:299e:eecc with SMTP id n27-20020a634d5b000000b0042c299eeeccmr13844056pgl.41.1661998591331;
        Wed, 31 Aug 2022 19:16:31 -0700 (PDT)
Received: from canonical.com (2001-b011-3815-31f6-fb99-d5df-1120-3f91.dynamic-ip6.hinet.net. [2001:b011:3815:31f6:fb99:d5df:1120:3f91])
        by smtp.gmail.com with ESMTPSA id b4-20020a63eb44000000b0041c30def5e8sm4033374pgk.33.2022.08.31.19.16.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Aug 2022 19:16:30 -0700 (PDT)
From:   Koba Ko <koba.ko@canonical.com>
To:     Tom Lendacky <thomas.lendacky@amd.com>,
        John Allen <john.allen@amd.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH V2] crypto: ccp - Release dma channels before dmaengine unrgister
Date:   Thu,  1 Sep 2022 10:16:28 +0800
Message-Id: <20220901021628.1130985-1-koba.ko@canonical.com>
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
WARNING: CPU: 15 PID: 1 at drivers/dma/dmaengine.c:1110 __dma_async_device_channel_unregister+0xb7/0xc0

Call dma_release_channel for occupied channles before dma_async_device_unregister.

Fixes: 4cbe9bc34ed0 ("crypto: ccp - ccp_dmaengine_unregister release dma channels")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Koba Ko <koba.ko@canonical.com>
---
V2: Fix the unused warning
---
 drivers/crypto/ccp/ccp-dmaengine.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/crypto/ccp/ccp-dmaengine.c b/drivers/crypto/ccp/ccp-dmaengine.c
index 7d4b4ad1db1f3..9f753cb4f5f18 100644
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
@@ -766,8 +770,8 @@ void ccp_dmaengine_unregister(struct ccp_device *ccp)
 	if (!dmaengine)
 		return;
 
-	dma_async_device_unregister(dma_dev);
 	ccp_dma_release(ccp);
+	dma_async_device_unregister(dma_dev);
 
 	kmem_cache_destroy(ccp->dma_desc_cache);
 	kmem_cache_destroy(ccp->dma_cmd_cache);
-- 
2.25.1

