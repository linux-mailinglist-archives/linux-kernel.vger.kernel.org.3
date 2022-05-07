Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51A5D51E7F7
	for <lists+linux-kernel@lfdr.de>; Sat,  7 May 2022 17:02:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1446589AbiEGPGJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 May 2022 11:06:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1446582AbiEGPGC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 May 2022 11:06:02 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E31345ADA;
        Sat,  7 May 2022 08:02:11 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id p12so8648583pfn.0;
        Sat, 07 May 2022 08:02:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8S2Ee/r4gdu8szylQWKNq1eYo0gsqwwKtcV/b5eUXQk=;
        b=WO2s8NhiV9YPSglSonwtbrQzbnmw2d1x+XbJXFiPdeEBcNXIdqqc/5eybtaqtUxVLb
         jjfenTFQuY0rRqyta56BStnCdEjYzasC3/C2LWYMNSo07kPjYlcUXHJJ6obqK0WvtSmL
         Jz/IqDoK8dZL07vEWaSHK6yFadd1vuT0dI1vYunMg5wEPItzyMEzuorlRF3KJdtwy7RM
         QUWmtRDQQZdX8+o/0Qc/dHOAqtVl5ub8PJ0NvRpSxk+HhJrEpltQIeRHKWR8Z60jFwLu
         I4Pq3yEshPLQ0IrWP/gwJ0gZOokfdhMU3nso4rkfQlELvVCAwq0mKgluwU47w1Izy89S
         fzJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8S2Ee/r4gdu8szylQWKNq1eYo0gsqwwKtcV/b5eUXQk=;
        b=KEw8hjML/2y9PZx+IFb8pJ934pydRDMljTH2l6w8refU28dlGFMY0fgvmXakIufl/q
         RBial7Jog9kUIc2CQ4ut1mLa/nYF3CXGQUMDmtFZn7E0OrqLNQqI9zkKr8Q4rB4tWTlQ
         oooDVTlF/zMtRBARZ6UiYY3leajih3l/VAMimrsQJ2YswWqGOBVyM+0DtU3QYYzx/vpF
         Jn9ghNaFXAwUpnMva1y1NJ1ARYQqWn8AI9RFovc0tKtIHdv6qakUSmVfdeg912gO3ghw
         wmMT9IpxPsDDmCwGYGQp9Drfmn+O8MSUEYy5qFFpTB0uwMHsjduqyD1mTdIrKwQ9XCWz
         qcmQ==
X-Gm-Message-State: AOAM532NoYEQ7iJm+O7BcHIcKOEYAA6ptxBC8OaMkzAlYShT8vHEPnGD
        ThQuNAQ7TxjzgO4lm7xgIGm9bCTXp3+nAw==
X-Google-Smtp-Source: ABdhPJzcrR6UqrpIoIICLxvdLEh6oKCdG7X7TQJujmjnLjlvWv3z90HwvvVSumbJwjkyaR/8DYengA==
X-Received: by 2002:a05:6a00:b8b:b0:50d:6080:6be7 with SMTP id g11-20020a056a000b8b00b0050d60806be7mr8408789pfj.56.1651935730651;
        Sat, 07 May 2022 08:02:10 -0700 (PDT)
Received: from localhost.localdomain ([14.32.163.5])
        by smtp.gmail.com with ESMTPSA id v21-20020a170902ca9500b0015e8d4eb2a8sm3711007pld.242.2022.05.07.08.02.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 May 2022 08:02:10 -0700 (PDT)
From:   Chanwoo Choi <cwchoi00@gmail.com>
X-Google-Original-From: Chanwoo Choi <cw00.choi@samsung.com>
To:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     cw00.choi@samsung.com, myungjoo.ham@samsung.com,
        kyungmin.park@samsung.com, johnson.wang@mediatek.com,
        mka@chromium.org, jia-wei.chang@mediatek.com,
        andrew-sh.cheng@mediatek.com, hsinyi@chromium.org,
        sibis@codeaurora.org, saravanak@google.com
Subject: [PATCH v2 5/5] PM / devfreq: passive: Update frequency when start governor
Date:   Sun,  8 May 2022 00:01:45 +0900
Message-Id: <20220507150145.531864-6-cw00.choi@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220507150145.531864-1-cw00.choi@samsung.com>
References: <20220507150145.531864-1-cw00.choi@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the parent device changes the their frequency before registering
the passive device, the passive device cannot receive the notification
from parent device and then the passive device cannot be able to
set the proper frequency according to the frequency of parent device.

So, when start the passive governor, update the frequency
according to the frequency of parent device.

Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
---
 drivers/devfreq/governor_passive.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/devfreq/governor_passive.c b/drivers/devfreq/governor_passive.c
index b34dbe750c0a..74d26c193fdb 100644
--- a/drivers/devfreq/governor_passive.c
+++ b/drivers/devfreq/governor_passive.c
@@ -412,6 +412,23 @@ static int devfreq_passive_event_handler(struct devfreq *devfreq,
 		if (!p_data->this)
 			p_data->this = devfreq;
 
+		/*
+		 * If the parent device changes the their frequency before
+		 * registering the passive device, the passive device cannot
+		 * receive the notification from parent device and then the
+		 * passive device cannot be able to set the proper frequency
+		 * according to the frequency of parent device.
+		 *
+		 * When start the passive governor, update the frequency
+		 * according to the frequency of parent device.
+		 */
+		mutex_lock(&devfreq->lock);
+		ret = devfreq_update_target(devfreq, parent->previous_freq);
+		if (ret < 0)
+			dev_warn(&devfreq->dev,
+			"failed to update devfreq using passive governor\n");
+		mutex_unlock(&devfreq->lock);
+
 		if (p_data->parent_type == DEVFREQ_PARENT_DEV)
 			ret = devfreq_passive_register_notifier(devfreq);
 		else if (p_data->parent_type == CPUFREQ_PARENT_DEV)
-- 
2.25.1

