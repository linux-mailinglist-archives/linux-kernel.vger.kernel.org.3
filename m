Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E046C469114
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 08:58:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238784AbhLFICP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 03:02:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238762AbhLFICK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 03:02:10 -0500
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BFFEC061D7E
        for <linux-kernel@vger.kernel.org>; Sun,  5 Dec 2021 23:58:42 -0800 (PST)
Received: by mail-pf1-x431.google.com with SMTP id k26so5037591pfp.10
        for <linux-kernel@vger.kernel.org>; Sun, 05 Dec 2021 23:58:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=id7DvGBlJbwLopapF2TpliiENdQPCEGHhQVDE16kcTQ=;
        b=IOo5n81L4X8sOufuyxoiBhEMQP/Ta/G92ov/znSbutShHD7yUzr8tmqLiX07lQMUoC
         UiaRSdmeNEs3clCInFDE27mhfQY/alW18GqTTzFU7xzPuBahyAUjpLIYxmR7SR+2xOgb
         KrauDDO14UHjBptGzbLkI/fDu0p5Kn2mVvMFZN74ZVYuRJXX2ZQkIeKl9zTZgZyWliY7
         v23XgoOuYrB6ZTTdVih3+/jE7kEhf+RAI9s5pR2kW0RtMWUI+BgnZJ0dJ9a6AjYfT+ch
         fp60glxRspSiEmsH88cDS9tVykQ7M8c7bMndoGc5+7aITVjEP1GFlSzh1PrLIPtE70JF
         QEdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=id7DvGBlJbwLopapF2TpliiENdQPCEGHhQVDE16kcTQ=;
        b=qY2eOp78+4efs5/0eqh7QnP+wpHKlyozrs3aEYPHfspgycUKg3FFLR34iN7YpQEzdh
         XCSFUNNWLjN60ejV2ZvYtRelAcyhZxK1bgfOyrbEmEceC+QP1prVgJ6GvMpjRP4R3LoP
         d+/V7Rxs95bdZ82CVBc+6rq7WXF8sJqaB6PHnnnve2OT1lHYEnCJZywdquV3cNXUmLA+
         VdhA6WHVRR0ZDzZvwR8VlydrBEjoi8mRKe0MKtthNStBzkhuFhNWlxpoDcdGVrOQpBwc
         Sgno/L5kfNOdKGL7IcmzEf1968ouhedRuC7yaSeG4tz2wM5AU1GZtIlSU2ZwLAhQ5lNb
         vO3A==
X-Gm-Message-State: AOAM531/H8ZMDd8qqH1zX8IChKxrjz2BjGxto0t/O5olOPzqaBBrS+Wk
        t4Fwd69OF8jA74Xf4VLZjVBRYA==
X-Google-Smtp-Source: ABdhPJydE8rwQNEkqZq95lFuHS7EM3yeZYSaPp5fQo56KmHN9dlgeJDkt3fp6WOWvztBp1hfQ2z0WQ==
X-Received: by 2002:a63:8849:: with SMTP id l70mr17648733pgd.257.1638777522048;
        Sun, 05 Dec 2021 23:58:42 -0800 (PST)
Received: from localhost.localdomain (80.251.214.228.16clouds.com. [80.251.214.228])
        by smtp.gmail.com with ESMTPSA id p15sm11794476pfo.143.2021.12.05.23.58.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Dec 2021 23:58:41 -0800 (PST)
From:   Shawn Guo <shawn.guo@linaro.org>
To:     Georgi Djakov <djakov@kernel.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Loic Poulain <loic.poulain@linaro.org>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shawn Guo <shawn.guo@linaro.org>
Subject: [PATCH v3 4/6] interconnect: icc-rpm: Support child NoC device probe
Date:   Mon,  6 Dec 2021 15:58:06 +0800
Message-Id: <20211206075808.18124-5-shawn.guo@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211206075808.18124-1-shawn.guo@linaro.org>
References: <20211206075808.18124-1-shawn.guo@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As shown in downstream DT[1], the System NoC of QCM2290 is modelled
using 4 fab/noc devices: sys_noc + qup_virt + mmnrt_virt + mmrt_virt.
Among those 3 virtual devices, qup is owned by RPM and has no regmap
resource, while mmnrt and mmrt are owned by AP and share the same
regmap as sys_noc.  So it's logical to represent these virtual devices
as child nodes of sys_noc in DT, so that such configuration can be
supported with a couple of changes on qnoc_probe():

- If there are child nodes, populate them.
- If the device descriptor has .regmap_cfg but there is no IOMEM
  resource for the device, use parent's regmap.

[1] https://android.googlesource.com/kernel/msm-extra/devicetree/+/refs/tags/android-11.0.0_r0.56/qcom/scuba-bus.dtsi

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 drivers/interconnect/qcom/icc-rpm.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/interconnect/qcom/icc-rpm.c b/drivers/interconnect/qcom/icc-rpm.c
index 22a98c0b29af..2dfa79ba27bd 100644
--- a/drivers/interconnect/qcom/icc-rpm.c
+++ b/drivers/interconnect/qcom/icc-rpm.c
@@ -347,8 +347,13 @@ int qnoc_probe(struct platform_device *pdev)
 		void __iomem *mmio;
 
 		res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-		if (!res)
+		if (!res) {
+			/* Try parent's regmap */
+			qp->regmap = dev_get_regmap(dev->parent, NULL);
+			if (qp->regmap)
+				goto regmap_done;
 			return -ENODEV;
+		}
 
 		mmio = devm_ioremap_resource(dev, res);
 
@@ -364,6 +369,7 @@ int qnoc_probe(struct platform_device *pdev)
 		}
 	}
 
+regmap_done:
 	ret = devm_clk_bulk_get(dev, qp->num_clks, qp->bus_clks);
 	if (ret)
 		return ret;
@@ -409,6 +415,10 @@ int qnoc_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, qp);
 
+	/* Populate child NoC devices if any */
+	if (of_get_child_count(dev->of_node) > 0)
+		return of_platform_populate(dev->of_node, NULL, NULL, dev);
+
 	return 0;
 err:
 	icc_nodes_remove(provider);
-- 
2.17.1

