Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA9D955EDB0
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 21:15:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232211AbiF1TP0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 15:15:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237412AbiF1TOZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 15:14:25 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EA191C122
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 12:12:54 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id d5so11892415plo.12
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 12:12:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=getcruise.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZxCPE0B5f3Bac55W0MZntTn0q8GmAKl08WmW5xL6H1g=;
        b=LiKgaFcZpBhB0XVa5KRvk2DxLBrqjdvNnMkA9fIajsFma9ZC7TY7BqcbVV17A/45EB
         6Fqtp+smqXhgaXlYHcSTnhORJMx2uOZAKfxwaSfOx/hs9cS6wQRlJhSfgG0RnuYqsXWN
         NEyX4JoHTw+JNo/R5tPOquF3SP9VnrOaS4VvfPZ2dreeGg6v9nsFLYgQth+k0SqX125W
         Ns8+rbNp4WZfSc0UURcGbycGgL1ZlXVOmGRyZwzWus19p/8TjUZbRUAjUGHTkWl25xrP
         leB51BYqAxZg5sR5FUrBYzPrDHs/8E7zr6s0eYm1agCC1zUYFbMHbj9BtgVd/NhQkILM
         LMNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZxCPE0B5f3Bac55W0MZntTn0q8GmAKl08WmW5xL6H1g=;
        b=YHVVU2jp6XUTjnbeHHQivnKyrHBrw2+cripyhAAD/3ABAYPDVLWmKJ6cP2wh8/EyvD
         r1044iEBVJ1bb+YEr6imQC9vPqRAaRqHb2iRzbE+izQHsKtR8RigpIUmdoqvYqSyMA1s
         bOq6+VwBVf6x5UVNSdsZwCnJE9wDDwdFa1tcj9gPbIt12q0wUok42fwqna9Kd2C7Uang
         QARHGX3tMmts9k6PrxyzRXqYaIUSOGG57PEiCUlty686MHbDWq4BhXahqLB73KWjV056
         B5b3YxWZlhom+uw5Jof0nqRwyNNLHzlKKAx06LVdLm4xCqvxxSyUG7i6HwP9DfBL6ZNW
         7o5w==
X-Gm-Message-State: AJIora8X8Zq/GAT3O7RICPTdfiVcBI6btBsKMht53UYajypoINImrDn9
        hMLB68wr7CN2AqMc/3qoCFP0GA==
X-Google-Smtp-Source: AGRyM1t1MLy7fhAwHac9zOZIhses1FLTKxC4bxEkQuzxievZCNPR/1rumBzvz7D6Lktak5zXwc6GEA==
X-Received: by 2002:a17:90b:4acd:b0:1ed:55f:3ba3 with SMTP id mh13-20020a17090b4acd00b001ed055f3ba3mr1301263pjb.10.1656443564679;
        Tue, 28 Jun 2022 12:12:44 -0700 (PDT)
Received: from 6SRZ2L3-DT.corp.robot.car ([199.73.125.240])
        by smtp.gmail.com with ESMTPSA id d21-20020a63d715000000b00408a81ea6basm9545197pgg.21.2022.06.28.12.12.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jun 2022 12:12:43 -0700 (PDT)
From:   Satish Nagireddy <satish.nagireddy@getcruise.com>
To:     wsa@kernel.org
Cc:     linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org,
        michal.simek@xilinx.com, lars@metafoo.de,
        Satish Nagireddy <satish.nagireddy@getcruise.com>
Subject: [PATCH] i2c: cadence: Unregister the clk notifier in error path
Date:   Tue, 28 Jun 2022 12:12:16 -0700
Message-Id: <20220628191216.39459-1-satish.nagireddy@getcruise.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch ensures that the clock notifier is unregistered
when driver probe is returning error.

Signed-off-by: Satish Nagireddy <satish.nagireddy@getcruise.com>
---
 drivers/i2c/busses/i2c-cadence.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/i2c/busses/i2c-cadence.c b/drivers/i2c/busses/i2c-cadence.c
index b4c1ad19cdae..3d6f8ee355bf 100644
--- a/drivers/i2c/busses/i2c-cadence.c
+++ b/drivers/i2c/busses/i2c-cadence.c
@@ -1338,6 +1338,7 @@ static int cdns_i2c_probe(struct platform_device *pdev)
 	return 0;
 
 err_clk_dis:
+	clk_notifier_unregister(id->clk, &id->clk_rate_change_nb);
 	clk_disable_unprepare(id->clk);
 	pm_runtime_disable(&pdev->dev);
 	pm_runtime_set_suspended(&pdev->dev);
-- 
2.36.1

