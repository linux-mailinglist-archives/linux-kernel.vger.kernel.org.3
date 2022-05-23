Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 622E2530F13
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 15:18:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234644AbiEWLL3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 07:11:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234522AbiEWLLX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 07:11:23 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 062735FE0
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 04:11:22 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id r71so13418785pgr.0
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 04:11:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UHS/1H01y880FAOLumjFQUSmGq2wt4Kc1CYUuYq+T+8=;
        b=M/kmIjoIH0HE5rSxdyUKmWN4nvj6jHeeKirmX0XfOYKQUtn0crCZuLzdb/jUkOEUaz
         jHmCO547LSP9WmMHp4mz5E9lQSWZr4sX1Fx2H1Vo9CjLcbazk9eH+lecXlB06x6TgEkT
         AsNAoYQw2oXyJxBUdgsQ9G3GVNJv5KFoaLG80u3PiKx7mocClDrL+p1MkSD8GxUwJMH0
         XclhbhES7tfdxt4pg57V97uXXHqsdaJQ8TWU25sJ8Uw1yUwFBmzt1dBlc4q9aNodaiQl
         Cgo6VIa4W00mkLW6LiDaq8r+L9d6y58rbDF+S2PHtjbqSpcL1fwMVs0pMRYI7m8L4Q1g
         AImw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UHS/1H01y880FAOLumjFQUSmGq2wt4Kc1CYUuYq+T+8=;
        b=8RBXonoO2RZt7UMNeVUOu55DwDlTurNT9tGHCGCqtdMBtkEkf9OQ1uQmI11Baf3hkd
         cjYYFpwAyoGCpPnv1lQ/k5gc02BPXcaxdvstHoEotUwxBdNVmZa53Bv9nd8ljAqh8WLP
         OPsH+lyhtKIaXaKqAgKWsY5ZqVr6LQ29e4D1XIFpGrFo9LKMyODfI+IEAunIrvouaL0Z
         kvWH8CQ7gpeTrTbQzNp9HT2TAL4GSuLxJLc4xrkyZ6LKqPrFYEDwWtCbuq/sHOeT+a2p
         j1VIhHtgQ34+EFCSEUy/HvGE1iNhJprHB5kJ0OlhaUMOTYPgGlDTtCm+tpKp+22X14Pd
         Buhw==
X-Gm-Message-State: AOAM530/SnYoXPtez/Md9c405dXGHHfM5kkigeSUslXbYsssRWf0+Kft
        SxxlOkvnaUcVPHuiRV64im4=
X-Google-Smtp-Source: ABdhPJwJSPG5JEpcnsXp2Zp+js+ZyFzCKAhC3sGfIFRSuurmk9tXfgp/Ht6NJTy0UrKwfoDp3tVdRg==
X-Received: by 2002:a63:2b11:0:b0:3f6:5f7f:9e67 with SMTP id r17-20020a632b11000000b003f65f7f9e67mr15842513pgr.492.1653304281479;
        Mon, 23 May 2022 04:11:21 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id i11-20020a1709026acb00b001617ffc6d25sm4878253plt.19.2022.05.23.04.11.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 May 2022 04:11:20 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: chi.minghao@zte.com.cn
To:     sudeep.holla@arm.com
Cc:     cristian.marussi@arm.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Minghao Chi <chi.minghao@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH] firmware: arm_scmi: Avoid leak OF node on error
Date:   Mon, 23 May 2022 11:11:16 +0000
Message-Id: <20220523111116.2898-1-chi.minghao@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Minghao Chi <chi.minghao@zte.com.cn>

The OF node should be put before returning error in smc_chan_available(),
otherwise node's refcount will be leaked.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Minghao Chi <chi.minghao@zte.com.cn>
---
 drivers/firmware/arm_scmi/smc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/firmware/arm_scmi/smc.c b/drivers/firmware/arm_scmi/smc.c
index 745acfdd0b3d..43018be70edc 100644
--- a/drivers/firmware/arm_scmi/smc.c
+++ b/drivers/firmware/arm_scmi/smc.c
@@ -55,10 +55,10 @@ static irqreturn_t smc_msg_done_isr(int irq, void *data)
 static bool smc_chan_available(struct device *dev, int idx)
 {
 	struct device_node *np = of_parse_phandle(dev->of_node, "shmem", 0);
+	of_node_put(np);
 	if (!np)
 		return false;
 
-	of_node_put(np);
 	return true;
 }
 
-- 
2.25.1


