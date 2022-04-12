Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C285F4FD3CF
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 11:59:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236926AbiDLJlQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 05:41:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1388758AbiDLJWp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 05:22:45 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C0D94CD54
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 01:29:28 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id h15-20020a17090a054f00b001cb7cd2b11dso2115752pjf.5
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 01:29:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0dFyqLvQ2p1xNfcfzu7O9DJMNp2UmrxAZtgZZyFjc4U=;
        b=QJycfqPJQWovgMgDFefko+ZRTgkQeqaDHh4yrF684RIOJqogHdrZXuNkJWtD1e86CH
         JfhnULKhAQyzatcivRyRpLB1X6sxBZzUwJuEV+o9PvY4Qt50KpyO+B3dFnvqWNVDe6Aa
         vRjjk1DEXQMKON402pyAAp0fWh2szazajsdfotENvQ6Nz3IsZDa9hd7JPyssGJ0bQ2xb
         jyuOpHy5EPHjebY5hjNMbvD8dTk17H7KqFEu3M5JbAwRMe/MpZ3DXdRNiHJDKUpXKkng
         UwDmjD/Pwh/gx2kdhOHF6NWCr19mYdVlJEtcEho1XjNFtn6QY2WkYeJkr6BVWciQwijO
         nTug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0dFyqLvQ2p1xNfcfzu7O9DJMNp2UmrxAZtgZZyFjc4U=;
        b=gaZB30DP4sQFSHEGObQwEtSJnLsbXY5dxGmlRHMIw65Nf6f12FfgTwJn90+ax6tqQ6
         tavhBWrLxoVPDYgokWzKIY71EcOfYSGDfm0o49Eomwnru0rQbsR/KCCVkUtlSU4r3BHm
         NKw9IEEAiFealGgwW5wfTeuLcdQ8bNHv+fRkn6/MaIcfoH9luQw9D2aVQ5BJz4A5PsHO
         HAW2JOrapHH4+gTBH8X8ulMywKBMBr2WWBD1TiQIkGlsuJpHuobZtniAC1ynau1hmKWp
         wLUg2QxES1CGuYJzP6ddGFJm7s9OVkv8yKRuiLZgFKd/IJVGcjY1WHSwifE8yQDHR5Ap
         nYJQ==
X-Gm-Message-State: AOAM531S5TMMbcMz/DSYHzH5ckLq1wVyRixDx6GqCjBRbQhpbPwB+DiU
        3C1bZMhROd0rAHYjLO9B5fw=
X-Google-Smtp-Source: ABdhPJwFEUBPcpn/+JQSCImfBLLqIXo/H9gF9nfIejTfltPkVQGUiz6pmaIRVoVcSfDik/juAAZfWg==
X-Received: by 2002:a17:902:7006:b0:156:3cbe:6b04 with SMTP id y6-20020a170902700600b001563cbe6b04mr35586867plk.68.1649752167314;
        Tue, 12 Apr 2022 01:29:27 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id j18-20020a633c12000000b0038204629cc9sm2093888pga.10.2022.04.12.01.29.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Apr 2022 01:29:27 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: chi.minghao@zte.com.cn
To:     nm@ti.com
Cc:     ssantosh@kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Minghao Chi <chi.minghao@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH] soc: ti: knav_dma: using pm_runtime_resume_and_get instead of pm_runtime_get_sync
Date:   Tue, 12 Apr 2022 08:29:23 +0000
Message-Id: <20220412082923.2532649-1-chi.minghao@zte.com.cn>
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

Using pm_runtime_resume_and_get is more appropriate
for simplifing code

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Minghao Chi <chi.minghao@zte.com.cn>
---
 drivers/soc/ti/knav_dma.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/soc/ti/knav_dma.c b/drivers/soc/ti/knav_dma.c
index 700d8eecd8c4..061f92c8cf7d 100644
--- a/drivers/soc/ti/knav_dma.c
+++ b/drivers/soc/ti/knav_dma.c
@@ -747,9 +747,8 @@ static int knav_dma_probe(struct platform_device *pdev)
 	INIT_LIST_HEAD(&kdev->list);
 
 	pm_runtime_enable(kdev->dev);
-	ret = pm_runtime_get_sync(kdev->dev);
+	ret = pm_runtime_resume_and_get(kdev->dev);
 	if (ret < 0) {
-		pm_runtime_put_noidle(kdev->dev);
 		dev_err(kdev->dev, "unable to enable pktdma, err %d\n", ret);
 		goto err_pm_disable;
 	}
-- 
2.25.1

