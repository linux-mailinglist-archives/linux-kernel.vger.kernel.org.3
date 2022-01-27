Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 704D549E928
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 18:36:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244686AbiA0RgM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 12:36:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244682AbiA0RgK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 12:36:10 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 508ABC06173B
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 09:36:10 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id j5-20020a05600c1c0500b0034d2e956aadso2347065wms.4
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 09:36:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Nsh+hcHxytqHnqOptN/J8SZirknsijh3VoYvJB/RpO0=;
        b=JpzTisjrSKaIkSNsb6YJSZq1KWLiQ9HnR1te7+RIqCcWXcChP9Q9jpgOrzsO+5hhF+
         5SDS3y+/o67Pv3fUHaaoqqRI2FtLPlaYMJcfyqGKpnUmNz65F9vuZZtf9SfRlgsjf1V3
         IdI8HRZAlF8jIgSqueePmkyonKaEDEIH+NerqfqdFIBz8hWu94kgtoU4kS/10dv96V1X
         HgNaovIbe8QtQ2HXWqavtg3VsALBQSUgLMCrnXyM4Lc+mQ7wnnVDMlo4lZGZBrj/SlSe
         CkUbLKHjhVKJKeAD6ixkNQyQGjv2mrSGNKD9JiF8a03npnawg7r0T9x2jgnRQLjeGv8w
         VRmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Nsh+hcHxytqHnqOptN/J8SZirknsijh3VoYvJB/RpO0=;
        b=Z+EhHsiU4GPr57oG5EDi6U8znS0RlIQq4tUEN0/UJapcVsCY2qAQuxWh/3BivmKTVF
         B1RHcW2Z0PtYxZcep3PJx1Adbd6X5ZBeTRA6WYi3KQUFDS/kyXJTtEOdFtXvEXFWCCB9
         I9QkBESGO/lW++HA/CbbO4BvTPgX16iQJLCbMw2KX9uKqRa6gV7km5OyMd30XCWKeho9
         GWWwkcSuwlzykiTw6Cq6/4QNhqHElGbV11b+iXI0vUfPTl9MGB9G0eoSk7ebGZ7eQ7Ul
         c2LT4cEml+PZw+FOk2LdCU9afp7TPeflk39eCFWOJ5ExoYbL3FH9y/onR6z/zXZSvu55
         f+4g==
X-Gm-Message-State: AOAM53354vVGRQEgOHjlRrM8bdfsiE8Cr/lXkCx4EDqwX81Krpf3/f89
        tde4GTqxVF6YeiYf3DYy5djZWg==
X-Google-Smtp-Source: ABdhPJx+yLMw0hnU6dpDTJy2lKioILrA7MHPpNBR7BcuuIRu/xUx3YxPVPDbuZ7SnaF8jR5z+BinuA==
X-Received: by 2002:a1c:1f92:: with SMTP id f140mr12152336wmf.31.1643304968788;
        Thu, 27 Jan 2022 09:36:08 -0800 (PST)
Received: from maple.lan (cpc141216-aztw34-2-0-cust174.18-1.cable.virginm.net. [80.7.220.175])
        by smtp.gmail.com with ESMTPSA id 31sm3269267wrl.27.2022.01.27.09.36.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jan 2022 09:36:08 -0800 (PST)
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Daniel Thompson <daniel.thompson@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] soc: qcom: aoss: remove spurious IRQF_ONESHOT flags
Date:   Thu, 27 Jan 2022 17:35:54 +0000
Message-Id: <20220127173554.158111-1-daniel.thompson@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting the header comments, IRQF_ONESHOT is "Used by threaded interrupts
which need to keep the irq line disabled until the threaded handler has
been run.". When applied to an interrupt that doesn't request a threaded
irq then IRQF_ONESHOT has a lesser known (undocumented?) side effect,
which it to disable the forced threading of the irq. For "normal" kernels
(without forced threading) then, if there is no thread_fn, then
IRQF_ONESHOT is a nop.

In this case disabling forced threading is not appropriate for this driver
because it calls wake_up_all() and this API cannot be called from
no-thread interrupt handlers on PREEMPT_RT systems (deadlock risk, triggers
sleeping-while-atomic warnings).

Fix this by removing IRQF_ONESHOT.

Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>
---
 drivers/soc/qcom/qcom_aoss.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soc/qcom/qcom_aoss.c b/drivers/soc/qcom/qcom_aoss.c
index cbe5e39fdaeb0..83f1edcbf7a33 100644
--- a/drivers/soc/qcom/qcom_aoss.c
+++ b/drivers/soc/qcom/qcom_aoss.c
@@ -497,7 +497,7 @@ static int qmp_probe(struct platform_device *pdev)
 	}

 	irq = platform_get_irq(pdev, 0);
-	ret = devm_request_irq(&pdev->dev, irq, qmp_intr, IRQF_ONESHOT,
+	ret = devm_request_irq(&pdev->dev, irq, qmp_intr, 0,
 			       "aoss-qmp", qmp);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "failed to request interrupt\n");

base-commit: e783362eb54cd99b2cac8b3a9aeac942e6f6ac07
prerequisite-patch-id: 59cdecee7d1b3bdd110f0d01790b92428b91862a
--
2.34.1

