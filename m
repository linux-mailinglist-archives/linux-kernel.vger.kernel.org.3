Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74247504CA5
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Apr 2022 08:30:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236788AbiDRGcn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 02:32:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236818AbiDRGcl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 02:32:41 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8B6D62D0
        for <linux-kernel@vger.kernel.org>; Sun, 17 Apr 2022 23:30:02 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id f22so299119qtp.13
        for <linux-kernel@vger.kernel.org>; Sun, 17 Apr 2022 23:30:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dYYFTIWJ7vNEYWB3AHkkvvVvqCyIj//35ZW32wFL7v8=;
        b=OCoy3Q6/Rw1ToMw9EGEBJP9bE3WDp+sVHD8RjAl+O5+Q71tvcQ8Ta766r5mmbC/Vgd
         cqjnMIgwIM0NKA6+NKu3RHBdLuBa1NIy53TCJWerStO4jec+Q7Mx70fEhCQhFYRhaYy0
         PXywCP8F7BM7TsWsJKdoczaaQxlzR9pbw92zyQdrVCEccbuoOwbtf+cle/ffzQJ0njlL
         db4y5ocrhLwVAYYC+NJArkaoXy/CgOBXQtnsSuZIQbESV1xOCZBNKBdp6URNIEFjO+dY
         crj0P7Rn9MJNGph0fIIFFdQ4CPwpPO1Pird3ijOAPjf3juPhFwF2P0qx2uxDattd4Otm
         nftg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dYYFTIWJ7vNEYWB3AHkkvvVvqCyIj//35ZW32wFL7v8=;
        b=qkAm5wSHkIbpzxpwRi0A99P7C/hkbKz8L4dn1gUmAnRdlELH9EXZ1TsHDxPM1PdkZc
         SQTMX7HZhfMnyNuUPx6q9w9Nfjye1D22aNuNplchbXX10tvrF2102D5TYfrDqdaPOGd5
         H7meVH/KAsZJ4K2RhzsZY5HtuosLPuzrLErbcWu8t/ovn0VfNLnqGu6FRIEkJfM1345P
         XByX2trIeMnrmiYdMYLmXdunI55/j9IlLZsDVR8BTSI6itQAYalH4vqwxKrieTZbNASE
         vrhtl8H9xQL4sv25lJfWaJ/LZxVgcfp6pZ4DqiABh8RPjcUbNsKC9+aNUk1ypVcUTWJY
         O8Hg==
X-Gm-Message-State: AOAM533RqCIG5SMydnzU0+ckTMuY3irHGaTln/6eCSi+n7BMIC4hD+7G
        pBdOvnJC26GuionvIbSWK+4=
X-Google-Smtp-Source: ABdhPJzItjF6NkBGz/H85SJodzphG3aP2rLDfnSshKeTbDEQrudI8G68AQr2cG0Q5H75Yo/8B6cFaA==
X-Received: by 2002:a05:622a:1c0d:b0:2ed:1335:97ba with SMTP id bq13-20020a05622a1c0d00b002ed133597bamr6007062qtb.485.1650263401960;
        Sun, 17 Apr 2022 23:30:01 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id s15-20020a05620a29cf00b00680ca4b3755sm6402239qkp.119.2022.04.17.23.29.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Apr 2022 23:30:01 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: chi.minghao@zte.com.cn
To:     nm@ti.com
Cc:     ssantosh@kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Minghao Chi <chi.minghao@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH] soc: ti: knav_qmss_queue: using pm_runtime_resume_and_get instead of pm_runtime_get_sync
Date:   Mon, 18 Apr 2022 06:29:55 +0000
Message-Id: <20220418062955.2557949-1-chi.minghao@zte.com.cn>
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
 drivers/soc/ti/knav_qmss_queue.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/soc/ti/knav_qmss_queue.c b/drivers/soc/ti/knav_qmss_queue.c
index 2ac3856b8d42..e37642f390db 100644
--- a/drivers/soc/ti/knav_qmss_queue.c
+++ b/drivers/soc/ti/knav_qmss_queue.c
@@ -1785,9 +1785,8 @@ static int knav_queue_probe(struct platform_device *pdev)
 	INIT_LIST_HEAD(&kdev->pdsps);
 
 	pm_runtime_enable(&pdev->dev);
-	ret = pm_runtime_get_sync(&pdev->dev);
+	ret = pm_runtime_resume_and_get(&pdev->dev);
 	if (ret < 0) {
-		pm_runtime_put_noidle(&pdev->dev);
 		dev_err(dev, "Failed to enable QMSS\n");
 		return ret;
 	}
-- 
2.25.1

