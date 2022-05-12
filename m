Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F17C5241E7
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 03:17:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349834AbiELBRO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 21:17:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343712AbiELBRN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 21:17:13 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A66B02A72C
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 18:17:12 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id q4so3455728plr.11
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 18:17:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=91WjG8Xgx7zSwWUKmJ5ZSvjr4nPKvPOOCne/40ungPw=;
        b=iktCS3MFPTW3v9KcNEYcXrmVK23wGjhROQSXLkxw0YvX2V+iHCxWCRTIpcPAWSyEaT
         I2IW7NJ2Wmm99rzrcUYT19xGZcElkbm1jDi9MFV7bJIinywBGR30NFywf1fFl7silO2v
         Hafzvq03Z5tXwU8vPtEzBICethZwCdUxt+kN5FvXCEp006yCl5AcRt14hLt6yQ837Hzu
         SdK3KIoURq7EfuC52WwrLB5Y6YDyuMW0iGsOIRDsiYcFY472RMEboKGWiPWpqc2b9s71
         ESyXYoRo1SMCi0G86afjxtyMQ2rArCW24myG3ytAv1wcRcYFeXfNQHETJQiPXGYXX7hj
         CqSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=91WjG8Xgx7zSwWUKmJ5ZSvjr4nPKvPOOCne/40ungPw=;
        b=3XXSxZ2KLFbeM86x+NNVMvRiRiSpIdB4t2E6tWYAAd4KCXNnwHvHrkXN4TCu8vs86Q
         we5ADStC1e2P2OIyPUFU4s54YQnetGYjcrt5wTS3BCAr+8zJjH2HeTe2sz1bV2eBwR70
         lWYqb0pBL1Go1QQF+5t197QwadkIr2+XjGaF/a5W53hVWfWeczmAkjdrK7g/vspSbO6O
         Xn+QasCP/m6aXiyOqqQ8bMwz5N/y902dI5zL4Rv6BfuiFfDUUUOUGr1S8DOu99i5qSFE
         yEPoclzfg5G6RhsoPybw+goh4Lq2w6O+RJnis2gjgflbFto/z2iwMFgoZshfH22YeTVf
         6Mcg==
X-Gm-Message-State: AOAM5306dO3MBCwzuLcY6I31tl61Lrfx86w0ZQ0mPafaFv8C88NzgYXb
        LTxr8Dzs9PTZgfRMKWFtUr0=
X-Google-Smtp-Source: ABdhPJx85MTQXdHNFwU36UFVAAIS/ICXp3PePnf5H5bIDcZeM48iGF15fix0phyLByLEpSVyb2ReDQ==
X-Received: by 2002:a17:90b:3851:b0:1dc:4f70:1cb with SMTP id nl17-20020a17090b385100b001dc4f7001cbmr8080318pjb.167.1652318232159;
        Wed, 11 May 2022 18:17:12 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id h20-20020aa786d4000000b0050dc76281e4sm2396913pfo.190.2022.05.11.18.17.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 May 2022 18:17:11 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: chi.minghao@zte.com.cn
To:     dan.j.williams@intel.com
Cc:     vishal.l.verma@intel.com, nvdimm@lists.linux.dev,
        linux-kernel@vger.kernel.org, Minghao Chi <chi.minghao@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH] libnvdimm/region: use kobj_to_dev()
Date:   Thu, 12 May 2022 01:17:07 +0000
Message-Id: <20220512011707.1621619-1-chi.minghao@zte.com.cn>
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

Use kobj_to_dev() instead of open-coding it.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Minghao Chi <chi.minghao@zte.com.cn>
---
 drivers/nvdimm/region_devs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvdimm/region_devs.c b/drivers/nvdimm/region_devs.c
index 0cb274c2b508..d1bd82a3a500 100644
--- a/drivers/nvdimm/region_devs.c
+++ b/drivers/nvdimm/region_devs.c
@@ -720,7 +720,7 @@ REGION_MAPPING(31);
 
 static umode_t mapping_visible(struct kobject *kobj, struct attribute *a, int n)
 {
-	struct device *dev = container_of(kobj, struct device, kobj);
+	struct device *dev = kobj_to_dev(kobj);
 	struct nd_region *nd_region = to_nd_region(dev);
 
 	if (n < nd_region->ndr_mappings)
--
2.25.1


