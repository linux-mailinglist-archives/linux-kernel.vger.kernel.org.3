Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50B3F5A9ACB
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 16:47:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233739AbiIAOrZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 10:47:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231484AbiIAOrW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 10:47:22 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B666B75CF8
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 07:47:20 -0700 (PDT)
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 6869D3F470
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 14:47:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1662043638;
        bh=QWY8to+d00rWq/rJi5teSMWyNnP44XxPpW2JtoKQAbY=;
        h=From:To:Subject:Date:Message-Id:MIME-Version;
        b=Wm15ImLzGdsawfNoZL9U8ef2/THt7sViN5sWKlv/yjZR8ViGYcH7Y89a9oYlOyD3C
         LC69XOE8KHAsj4GoosFDiy8csyytCDmFGK+ziYqIKMaCPePKwevD/gue78GRqnj3CR
         Vq38mkLdIdW/3gBzeAgsqvkG1V03NyjTvQVgcGp9wSDSj31arwFPWApLZZlhWEcuY+
         q/j7zbtTA+Uh5c09yEkrUCpQh07kQwOY1rcbfTqSCtm74SjZGWjvwmyX7fFcRrbirc
         JuI+e7JRXUuy9qEVVTQ78bZSYFaKDJDWeKDavPwJGtooNdkf+QSiUIaAiYpSQlou5l
         vRPdnRMaD5Dxg==
Received: by mail-pl1-f198.google.com with SMTP id q6-20020a17090311c600b0017266460b8fso11906826plh.4
        for <linux-kernel@vger.kernel.org>; Thu, 01 Sep 2022 07:47:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date;
        bh=QWY8to+d00rWq/rJi5teSMWyNnP44XxPpW2JtoKQAbY=;
        b=Ts5ghb2bOzjT9DcVPean4Wmc87uLXbnqUlVDsQLPS0k4xYuqgFyGyFAT97bwxPhWTl
         NS0csFcL9WORFeZPKYKfi2aYzKNjRqbWFAjh6TQOg9riALlhPrO4Q48Px9CyfLNQFNOo
         slbU7NIfbMmr1PeJar1C2kYUkEkNyOpI4YYOC02fkcII1+tYIIhwlykiwAGokOaW7+AY
         AfUJQyXD6dG5rB0faLoD56BQu5yC14o8UQHpt6SoPBbpZJzg7Yyq1+Gci2wO3gekrYBB
         jWYkH6YK3LtcN95yquKcpD+5Xtivg9YMLdV+KeZoqvTF+cgPxaiWVPl8KCSd6TYfpbXw
         Y8nQ==
X-Gm-Message-State: ACgBeo04UuYhPL2nK0E/GmG/wZVA3zKv7EwrAQrjYJ9Kvtfn1UKNQBdq
        kknyIq+urPhuuG9442/wdGpFKMVoNrnJPDEWLun+59H7Z/Oadh0tp4cMBnjjUWVoqb0U+Za7Aog
        qr2XGbZih7/ZXuyXosrapH6Rq5x2lqPiaZXirC+VixQ==
X-Received: by 2002:a17:902:dac1:b0:172:eae4:950c with SMTP id q1-20020a170902dac100b00172eae4950cmr30535505plx.70.1662043637047;
        Thu, 01 Sep 2022 07:47:17 -0700 (PDT)
X-Google-Smtp-Source: AA6agR6D73TGKIDAtbJOYiBqwerHebexcmncChBbOyBvPScbeazLBElHcQjrwdL0UBiVzWm7alkZ3g==
X-Received: by 2002:a17:902:dac1:b0:172:eae4:950c with SMTP id q1-20020a170902dac100b00172eae4950cmr30535477plx.70.1662043636582;
        Thu, 01 Sep 2022 07:47:16 -0700 (PDT)
Received: from canonical.com (2001-b011-3815-31f6-fb99-d5df-1120-3f91.dynamic-ip6.hinet.net. [2001:b011:3815:31f6:fb99:d5df:1120:3f91])
        by smtp.gmail.com with ESMTPSA id g16-20020aa796b0000000b005385555e647sm7717029pfk.155.2022.09.01.07.47.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Sep 2022 07:47:14 -0700 (PDT)
From:   Koba Ko <koba.ko@canonical.com>
To:     Tom Lendacky <thomas.lendacky@amd.com>,
        John Allen <john.allen@amd.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH V3] crypto: ccp - Release dma channels before dmaengine unrgister
Date:   Thu,  1 Sep 2022 22:47:12 +0800
Message-Id: <20220901144712.1192698-1-koba.ko@canonical.com>
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

Fixes: 54cce8ecb925 ("crypto: ccp - ccp_dmaengine_unregister release dma channels")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Koba Ko <koba.ko@canonical.com>
Acked-by: Tom Lendacky <thomas.lendacky@amd.com>

---
V2: Fix the unused warning
V3: Fix the Fixes: tag.
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

