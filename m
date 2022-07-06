Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF3A25684EF
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 12:14:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232441AbiGFKMC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 06:12:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232332AbiGFKL5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 06:11:57 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBAECB8D
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jul 2022 03:11:56 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id v16so9890599wrd.13
        for <linux-kernel@vger.kernel.org>; Wed, 06 Jul 2022 03:11:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WClSJr2wTkNNtlfG4v+EDUVtabfYnmsiL7xtzFJjbdI=;
        b=CSN4WDV/coQL+oIXgK0iGj7JnylgZf/8LPxTluQg4/wuF/oPmp7KXFzU+3CDIIN+QV
         yvucMLgM71TQ/UCAE/o9Q6H63sTfgKcqsXPr2zKC8j5TwAdvcHNXa4/ROlZGYzb3xd/z
         yh0M+p50M6TZXWM1Pcd1NrdUHXCuvb3sJMoJmL/pghddpJGlKVG3oQaXnLXJv+xhoDkc
         EJg+J9SL+zBO9fYdWgcZ73UFCrUp02Lp0extRfGFMEuNyuzSHZWZuLSIqQE7jTxSmTtx
         JcKzHJ2o1VLegjiFkowe2Wnctg7gfbghs+L8j6tRjBNl3L1P6tqXDADIPFz5rNgMIutF
         Uslw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WClSJr2wTkNNtlfG4v+EDUVtabfYnmsiL7xtzFJjbdI=;
        b=gpLCQUoLBZOdMvX8yonZlpr1qvRE/poVNfpbtTx0xyLmk9jcVu6R9S5HWkzebdp0OA
         m/WjSacCPkTbH263ZDQVdoJ3qEwNATsG5jrz8Mg11nBA3FBNej70K/saiDuGHndAJDHW
         xICbUY050jcxLyGdx9rtWyllS4IfH6auxvKdy39NfuKz7Mo04aIgIxSa9VvaoDDLmabc
         c5+ZVHI9yLhDJ9SI5YyDBA/g58vXg7vzm9x2Pwulz5+TntGreAQM0lVIvl6UcsAHrhO2
         4gH5oejtSvb3BwhJC/EZr7xDiR5R9Qn4FbtiGhotZPEOpxOM0rr4GSNyiwLA9qnLONP2
         tPtg==
X-Gm-Message-State: AJIora8v89c9DM0Bq5n6qxbq10PD3WUhjitXZdMrZ+kSI+Y5T3ZmWdG2
        El9rT4Zg7BZtGEzGWK1aII60rA==
X-Google-Smtp-Source: AGRyM1uHF0POwvmJZhbF5ni8uQH0EleqnO+7qYSMmSgONfoSiD9iQowlmicn9nTuGY4HY7axNKiS1Q==
X-Received: by 2002:adf:f38c:0:b0:21d:6696:5f61 with SMTP id m12-20020adff38c000000b0021d66965f61mr17831552wro.273.1657102315387;
        Wed, 06 Jul 2022 03:11:55 -0700 (PDT)
Received: from srini-hackbase.lan (cpc90716-aztw32-2-0-cust825.18-1.cable.virginm.net. [86.26.103.58])
        by smtp.gmail.com with ESMTPSA id u23-20020a7bcb17000000b0039aef592ca0sm24826620wmj.35.2022.07.06.03.11.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Jul 2022 03:11:54 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, keliu <liuke94@huawei.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 1/2] drivers: slimbus: Directly use ida_alloc()/free()
Date:   Wed,  6 Jul 2022 11:11:30 +0100
Message-Id: <20220706101131.6934-2-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220706101131.6934-1-srinivas.kandagatla@linaro.org>
References: <20220706101131.6934-1-srinivas.kandagatla@linaro.org>
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

From: keliu <liuke94@huawei.com>

Use ida_alloc()/ida_free() instead of deprecated
ida_simple_get()/ida_simple_remove() .

Signed-off-by: keliu <liuke94@huawei.com>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/slimbus/core.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/slimbus/core.c b/drivers/slimbus/core.c
index 78480e332ab8..219483b79c09 100644
--- a/drivers/slimbus/core.c
+++ b/drivers/slimbus/core.c
@@ -250,7 +250,7 @@ int slim_register_controller(struct slim_controller *ctrl)
 {
 	int id;
 
-	id = ida_simple_get(&ctrl_ida, 0, 0, GFP_KERNEL);
+	id = ida_alloc(&ctrl_ida, GFP_KERNEL);
 	if (id < 0)
 		return id;
 
@@ -299,7 +299,7 @@ int slim_unregister_controller(struct slim_controller *ctrl)
 {
 	/* Remove all clients */
 	device_for_each_child(ctrl->dev, NULL, slim_ctrl_remove_device);
-	ida_simple_remove(&ctrl_ida, ctrl->id);
+	ida_free(&ctrl_ida, ctrl->id);
 
 	return 0;
 }
@@ -323,7 +323,7 @@ void slim_report_absent(struct slim_device *sbdev)
 	sbdev->is_laddr_valid = false;
 	mutex_unlock(&ctrl->lock);
 	if (!ctrl->get_laddr)
-		ida_simple_remove(&ctrl->laddr_ida, sbdev->laddr);
+		ida_free(&ctrl->laddr_ida, sbdev->laddr);
 	slim_device_update_status(sbdev, SLIM_DEVICE_STATUS_DOWN);
 }
 EXPORT_SYMBOL_GPL(slim_report_absent);
-- 
2.25.1

