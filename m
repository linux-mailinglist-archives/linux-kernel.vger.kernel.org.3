Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34615472155
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 08:05:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232350AbhLMHFM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 02:05:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232341AbhLMHFM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 02:05:12 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3491BC06173F
        for <linux-kernel@vger.kernel.org>; Sun, 12 Dec 2021 23:05:12 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id y14-20020a17090a2b4e00b001a5824f4918so13950418pjc.4
        for <linux-kernel@vger.kernel.org>; Sun, 12 Dec 2021 23:05:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=m/kc7ebJlnLqfaZVU4eMOkFHSZDqfSXCTb3+LTn6SwU=;
        b=LShxVAZyIyqYus7DPwCbQTlPaaUHZLiGxYbFJH10V2CQ1IHefDJR6+7Fo49/Qzh6AU
         Lbw76mOSk/+soRdakEt0fsh8z0H9XwL21N9buUkkH8K50PN+8cDX4wcvo9eT4Dt9MGJW
         Ej0LzjYq6a6JUzQ9qzY5r/Yhavs06Cs6ltLCw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=m/kc7ebJlnLqfaZVU4eMOkFHSZDqfSXCTb3+LTn6SwU=;
        b=VV0yDSohX7ufzQcD/RCREz12yjTl98drMpeKK9zEcNIpJpu2PL8skMru49/ROKjRDt
         htrcezbQLq5gLqsWW5oPHUlw8+1861RUjfM33d2VQR3yNddbDkIjcKj045m3fkRsRrO0
         m3XeqGi1h9BocShjujuPbL38oxLahUD8C2gRvroVgD/0REO77Z5nWJexcqYGJiMOB9pB
         zFIKDRVjy3vBxp/pjhik7CrcXt6h4Lq91UdL6bPWCzoeGc3EF0v6OSJxEI7zXntMWsES
         MoocQdsDDn4xUapt3TYMJOtrzJZ9jtM92wZp+nqL0Y++8V7ExIL5UyNBDVkJKSRy75WL
         zA/w==
X-Gm-Message-State: AOAM531esWEwKD5CTUGd7mV+QHreLCMbagO1u30HVA0MxcBpWm1FLfef
        TcKVLQjgFm39eQAcVotQ7Y5kjr3qOKJF0Q==
X-Google-Smtp-Source: ABdhPJw5eN9BL11bnpjH2Litra/spgqz7gb1zNDlZ8DD8NBRQ5q5FEL8J+LhSLy30C37bExPbUB0QA==
X-Received: by 2002:a17:90b:fd5:: with SMTP id gd21mr43377175pjb.37.1639379111712;
        Sun, 12 Dec 2021 23:05:11 -0800 (PST)
Received: from hsinyi-z840.tpe.corp.google.com ([2401:fa00:1:10:9447:edff:ad23:1bfc])
        by smtp.gmail.com with ESMTPSA id k5sm5079402pgm.94.2021.12.12.23.05.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Dec 2021 23:05:11 -0800 (PST)
From:   Hsin-Yi Wang <hsinyi@chromium.org>
To:     Jassi Brar <jassisinghbrar@gmail.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH v2] mailbox: mtk-cmdq: Silent EPROBE_DEFER errors for clks
Date:   Mon, 13 Dec 2021 15:05:01 +0800
Message-Id: <20211213070500.3977049-1-hsinyi@chromium.org>
X-Mailer: git-send-email 2.34.1.173.g76aa8bc2d0-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Silent the error if it's EPROBE_DEFER for clks.

Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
---
v2: fix comments
---
 drivers/mailbox/mtk-cmdq-mailbox.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/mailbox/mtk-cmdq-mailbox.c b/drivers/mailbox/mtk-cmdq-mailbox.c
index a8845b162dbf..6f9ee831ccd8 100644
--- a/drivers/mailbox/mtk-cmdq-mailbox.c
+++ b/drivers/mailbox/mtk-cmdq-mailbox.c
@@ -573,8 +573,10 @@ static int cmdq_probe(struct platform_device *pdev)
 				cmdq->clocks[alias_id].id = clk_names[alias_id];
 				cmdq->clocks[alias_id].clk = of_clk_get(node, 0);
 				if (IS_ERR(cmdq->clocks[alias_id].clk)) {
-					dev_err(dev, "failed to get gce clk: %d\n", alias_id);
-					return PTR_ERR(cmdq->clocks[alias_id].clk);
+					return dev_err_probe(dev,
+							     PTR_ERR(cmdq->clocks[alias_id].clk),
+							     "failed to get gce clk: %d\n",
+							     alias_id);
 				}
 			}
 		}
@@ -582,8 +584,8 @@ static int cmdq_probe(struct platform_device *pdev)
 		cmdq->clocks[alias_id].id = clk_name;
 		cmdq->clocks[alias_id].clk = devm_clk_get(&pdev->dev, clk_name);
 		if (IS_ERR(cmdq->clocks[alias_id].clk)) {
-			dev_err(dev, "failed to get gce clk\n");
-			return PTR_ERR(cmdq->clocks[alias_id].clk);
+			return dev_err_probe(dev, PTR_ERR(cmdq->clocks[alias_id].clk),
+					     "failed to get gce clk\n");
 		}
 	}
 
-- 
2.34.1.173.g76aa8bc2d0-goog

