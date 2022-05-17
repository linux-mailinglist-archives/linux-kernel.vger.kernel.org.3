Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69B91529EF6
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 12:13:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240220AbiEQKM6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 06:12:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343788AbiEQKMK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 06:12:10 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22B6514D3D
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 03:11:08 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id p189so10136642wmp.3
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 03:11:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6Lu6f0d73oazesEuBZHPdAXNcyn4PVdVtPrb/jDtJ6I=;
        b=PlrnrUEHymszdmHIcng8m5vAcej0j3tS1D+N6uRoaq2jGq1Lud4hO07wDpPnifs7M/
         N/vvnuH1VyKSKuf5jjfMwvHHwgGEAqepEt4WN5wZoWgUbHqByJgAXy0ynt9kfNGhBJTF
         u/CBML7Fc+zPlufcDyzUM7hBtKgfx86N+8J2KH36TNtwBON/wbS65BRMBiOTQnvXbZbL
         08UEURw98dqxbXLiRPy2CPx7WNDrimZWTDE2R1lHlLqmxZxC8YUVfD4r9Y9bmtdZrfzv
         08trCDrphc+izqhWbp98xkwW8BX+BXF3SQcAeqhWU8rl1PR/ylvM2FRID1cL2hfnBAzp
         M8yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6Lu6f0d73oazesEuBZHPdAXNcyn4PVdVtPrb/jDtJ6I=;
        b=kek11BFlfn4PJwp2JKxw9jXL7FGIwx72yYebm2dmWuciVVsIiv4Vce4WYgfq2nj6KY
         nVVaGp4sliBHQL6Hs9MudylMP1vWfxrvCPBMPJCCMnXCY601l2LY9bVMxQCOkhj7zzHG
         8FBht9Muke8t5yh8y3Pwz4SCIZW/Qgz9dMxFV/zdwBk7Eae4SBwKkks3aYYt6VU32ZSh
         g0NTC0V66Raq+Wg9Fqysz8jrOvHxG193JPpD9fci12AI5SLd/jTl13uVTIwntildD4em
         6KEzZ+lJnvB0IGFL+5uDXHWzD1pozwTVI0B6NN5w1XxqKrspBqqKo1bt9Xce6QpBL9Fv
         IvBQ==
X-Gm-Message-State: AOAM530Sn3GPh8RZ8FEILT3s3cSOs1nEk/qc2iXANWoBUfZZSycFnZLV
        Nlu83S+R2qlvAB65W7wm0jufEnXuMSI9wFyI
X-Google-Smtp-Source: ABdhPJzEcdGO4BEiKj9MU8Numtdd2YBnuh41a11Our/iJU2bQwHov5H0jYcNsPvff8YEb2UsONtN/w==
X-Received: by 2002:a05:600c:3d8c:b0:394:6097:9994 with SMTP id bi12-20020a05600c3d8c00b0039460979994mr30990364wmb.29.1652782266658;
        Tue, 17 May 2022 03:11:06 -0700 (PDT)
Received: from uffe-XPS13.acentic.lan ([193.117.214.243])
        by smtp.gmail.com with ESMTPSA id e12-20020adfa44c000000b0020c5253d8dcsm11767731wra.40.2022.05.17.03.11.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 May 2022 03:11:05 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     linux-mmc@vger.kernel.org,
        Jean Rene Dawin <jdawin@math.uni-bielefeld.de>,
        "H . Nikolaus Schaller" <hns@goldelico.com>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Huijin Park <huijin.park@samsung.com>,
        linux-kernel@vger.kernel.org, stable@vger.kernel.com
Subject: [PATCH] mmc: core: Fix busy polling for MMC_SEND_OP_COND again
Date:   Tue, 17 May 2022 12:10:46 +0200
Message-Id: <20220517101046.27512-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It turned out that polling period for MMC_SEND_OP_COND, that currently is
set to 1ms, still isn't sufficient. In particular a Micron eMMC on a
Beaglebone platform, is reported to sometimes fail to initialize.

Additional test, shows that extending the period to 4ms is working fine, so
let's make that change.

Reported-by: Jean Rene Dawin <jdawin@math.uni-bielefeld.de>
Tested-by: Jean Rene Dawin <jdawin@math.uni-bielefeld.de>
Fixes: 1760fdb6fe9f (mmc: core: Restore (almost) the busy polling for MMC_SEND_OP_COND")
Fixes: 76bfc7ccc2fa ("mmc: core: adjust polling interval for CMD1")
Cc: stable@vger.kernel.com
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/core/mmc_ops.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/core/mmc_ops.c b/drivers/mmc/core/mmc_ops.c
index 180d7e9d3400..81c55bfd6e0c 100644
--- a/drivers/mmc/core/mmc_ops.c
+++ b/drivers/mmc/core/mmc_ops.c
@@ -21,7 +21,7 @@
 
 #define MMC_BKOPS_TIMEOUT_MS		(120 * 1000) /* 120s */
 #define MMC_SANITIZE_TIMEOUT_MS		(240 * 1000) /* 240s */
-#define MMC_OP_COND_PERIOD_US		(1 * 1000) /* 1ms */
+#define MMC_OP_COND_PERIOD_US		(4 * 1000) /* 4ms */
 #define MMC_OP_COND_TIMEOUT_MS		1000 /* 1s */
 
 static const u8 tuning_blk_pattern_4bit[] = {
-- 
2.25.1

