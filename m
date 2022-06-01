Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFAD453A966
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 16:51:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353581AbiFAOvT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 10:51:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233844AbiFAOvQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 10:51:16 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49FAA5DD17
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jun 2022 07:51:16 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id v15so2102106pgk.11
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jun 2022 07:51:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9Di3AWHfW2BtAUx+vGxYzLY0UoxmZ/0cEx6rZNq/IzQ=;
        b=F5M1gdd1//KZvxx+bojh2vf8rGxdfR/UiBy9WQbK8XpcJkbLuuAKuovT8O6O190tOn
         13+aCTaADNFZr7O9eQAXwZxMy6eHSU2RbvA15JbsD7t+A6CHncAVF68uCkaPqFJ0lfi0
         5dhmh/ftBV9ryrgNlsyFYl3Fdf/hH38oNqYX70lWFYXWR3PmohRY3Us9Kvko+m3qBb45
         Iuw7pu7sn00h9jE4p0VC2kU3zo0JCOQWXc6MLGP/O1E80vRgs4T8dq9WSMeEaLXC3Bw6
         GsfWiZjvjzH8/zEHtYhpD3WG2CkrxqRsCNtoR3oq0lLWxo1NhifLs4WAMnoGweC2ttP/
         79wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9Di3AWHfW2BtAUx+vGxYzLY0UoxmZ/0cEx6rZNq/IzQ=;
        b=WCBSt6YwjBzjKULotZh0Ecv9epBPdkoMu9b1TsRQLj5no23DE9ylgc9DQAoUp+MCbM
         V0dykLry7ou8jq+Di82wF/8SBBGaTAtF8PhMzXuVcvyfcy13gOpIJb96a6z7ScY1O4VC
         2eAixHPh4s3KKpj+Nqo316TRPbBAafUEAhUKth9k/iSs0QU/RW3LyfM5Ns0NCxCsKQIO
         1I20RCKvfdxa7EkO+OREzWctr+qFuSDuhklnW9ECRBfyNfQvjdblwts/o7uIQLBXcfOY
         /8v48X7qf3XXkqMKyjdXjOyoSXGCcFPpr4YFfXB2jhZEuiK9qk/WdfFcdMR7ByEZ0Fo7
         SFww==
X-Gm-Message-State: AOAM532k1oLySFMl6esMYVrkHAswAhnwMPAkKjRQdlRw0ccUU6RQN2jW
        UzlrlYOsxdBJ9S0GGLZ16sZ91zsS0wY=
X-Google-Smtp-Source: ABdhPJz9f79ygetP+6T69yOPHwSS/S9j4pj9KLO4dR2e/0Cf8gyv0fo6E+OzSx2kzLuYhi9Pr8/wAQ==
X-Received: by 2002:a05:6a00:2181:b0:51b:560b:dd30 with SMTP id h1-20020a056a00218100b0051b560bdd30mr13725422pfi.44.1654095075073;
        Wed, 01 Jun 2022 07:51:15 -0700 (PDT)
Received: from localhost ([2a00:79e1:abd:4a00:2703:3c72:eb1a:cffd])
        by smtp.gmail.com with ESMTPSA id w124-20020a623082000000b0050dc76281f8sm1588608pfw.210.2022.06.01.07.51.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jun 2022 07:51:13 -0700 (PDT)
From:   Rob Clark <robdclark@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org,
        Christoph Hellwig <hch@lst.de>,
        Robin Murphy <robin.murphy@arm.com>,
        Rob Clark <robdclark@chromium.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        iommu@lists.linux-foundation.org (open list:DMA MAPPING HELPERS)
Subject: [PATCH v2] dma-debug: Make things less spammy under memory pressure
Date:   Wed,  1 Jun 2022 07:51:16 -0700
Message-Id: <20220601145116.280040-1-robdclark@gmail.com>
X-Mailer: git-send-email 2.36.1
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

From: Rob Clark <robdclark@chromium.org>

Limit the error msg to avoid flooding the console.  If you have a lot of
threads hitting this at once, they could have already gotten passed the
dma_debug_disabled() check before they get to the point of allocation
failure, resulting in quite a lot of this error message spamming the
log.  Use pr_err_once() to limit that.

Signed-off-by: Rob Clark <robdclark@chromium.org>
---
v2: Use pr_err_once() instead of ratelimited, and spiff out commit msg a bit.

 kernel/dma/debug.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/dma/debug.c b/kernel/dma/debug.c
index f8ff598596b8..754e3456f017 100644
--- a/kernel/dma/debug.c
+++ b/kernel/dma/debug.c
@@ -564,7 +564,7 @@ static void add_dma_entry(struct dma_debug_entry *entry, unsigned long attrs)
 
 	rc = active_cacheline_insert(entry);
 	if (rc == -ENOMEM) {
-		pr_err("cacheline tracking ENOMEM, dma-debug disabled\n");
+		pr_err_once("cacheline tracking ENOMEM, dma-debug disabled\n");
 		global_disable = true;
 	} else if (rc == -EEXIST && !(attrs & DMA_ATTR_SKIP_CPU_SYNC)) {
 		err_printk(entry->dev, entry,
-- 
2.36.1

