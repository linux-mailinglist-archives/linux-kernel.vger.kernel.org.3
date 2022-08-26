Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D618A5A25B1
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 12:17:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245581AbiHZKRW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 06:17:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343749AbiHZKP2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 06:15:28 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8441B14D5
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 03:15:26 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id bu22so897319wrb.3
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 03:15:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=Rz7Ri8U5aOCKdVvdIijp7X/sK+Kj5rWcJ2yernN5/UU=;
        b=gPM3TcVxoDHwYqK27/aPW5GKL7yoXrHcGW40ghqodySkT/N482ydnrzme+qFCnl73g
         uM8ed9i+2UaCZbh4NTfu4SSIorIixGRhxNbUY7Yfe81VHpce18w542bEI7Kg+FcWsz+m
         OiKdk+h7G/YjBfmgeds9f3qYjFgW1Ebjx9kL1HcDPyNrzxPfDyV+e8ixGSOaTKx9Tnt5
         gy+i0OWEwzCYj7hXMxVqTCjiRA4ny+FS/7916/pa6C0ECzaCrpbJwWWJpt09TinZuyWY
         FQ5ScuDMB6sMFrykEtuAna4pF1C/jTFunEszH4OLKPTcGOL5k+2XviTAMrxho7un3kDi
         nN4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=Rz7Ri8U5aOCKdVvdIijp7X/sK+Kj5rWcJ2yernN5/UU=;
        b=6CJSwVWPRpIudgLYyvJcAQN/fP7Y/DzwerH3efb5va0u6BADg5aPFWz94I2KMoeP8C
         dc7ZhLpEwGH5eDNP50/vyNM4j0HxExri9AXs459dvv08G3GaxJXLOOlgjeaNtHdIcOD+
         z1MDKoxFX9T8qu9BMG9gIG5/88puc5Pfehkg8gd5KKlLmPfEvIkiO9Sq86koGWIVNjQz
         4AJhiM9FWpD+VZP6PRscLAIv8tepBCNrk4Qckj1nzWSP1/b7K0+bkVred/ym3TBXiaaV
         SZBGMjgTlnrQH2Gw10ezxE76qOeCNqJkHXrKwOs8d0384xSGrJP7mNLgydAWK26DaVyr
         Oghg==
X-Gm-Message-State: ACgBeo30ldCr8hFmr5IF1XVzOvRYqJeG6RLZn3tEnzqKw6l+UK7yzQvS
        1yFcfx8poqe/06aIslSS1Mjbta9TqoZFhg==
X-Google-Smtp-Source: AA6agR57O1cwi+qphGSKGGSIT5z0TrEh1gdt6SbE8yynmslGWt2m198gFohyG8mk5TSEwcXU7IDXow==
X-Received: by 2002:adf:f2ca:0:b0:225:4800:d201 with SMTP id d10-20020adff2ca000000b002254800d201mr4502643wrp.187.1661508925071;
        Fri, 26 Aug 2022 03:15:25 -0700 (PDT)
Received: from lb02065.fritz.box ([2001:9e8:140d:2300:3a17:fa67:2b0b:b905])
        by smtp.gmail.com with ESMTPSA id e14-20020a5d500e000000b0021f0c0c62d1sm1505882wrt.13.2022.08.26.03.15.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Aug 2022 03:15:24 -0700 (PDT)
From:   Jack Wang <jinpu.wang@ionos.com>
To:     alexander.shishkin@linux.intel.com
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] intel_th: Fix dma_map_sg error check
Date:   Fri, 26 Aug 2022 12:15:23 +0200
Message-Id: <20220826101523.79502-1-jinpu.wang@ionos.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

dma_map_sg return 0 on error.

Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: linux-kernel@vger.kernel.org
Fixes: 4e0eaf239fb3 ("intel_th: msu: Fix single mode with IOMMU")
Signed-off-by: Jack Wang <jinpu.wang@ionos.com>
---
 drivers/hwtracing/intel_th/msu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwtracing/intel_th/msu.c b/drivers/hwtracing/intel_th/msu.c
index 6c8215a47a60..b49237d56a60 100644
--- a/drivers/hwtracing/intel_th/msu.c
+++ b/drivers/hwtracing/intel_th/msu.c
@@ -931,7 +931,7 @@ static int msc_buffer_contig_alloc(struct msc *msc, unsigned long size)
 
 	ret = dma_map_sg(msc_dev(msc)->parent->parent, msc->single_sgt.sgl, 1,
 			 DMA_FROM_DEVICE);
-	if (ret < 0)
+	if (!ret)
 		goto err_free_pages;
 
 	msc->nr_pages = nr_pages;
-- 
2.34.1

