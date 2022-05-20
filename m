Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B64AC52E5DC
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 09:05:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346336AbiETHFH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 03:05:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346492AbiETHEq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 03:04:46 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 979F016329F
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 00:04:19 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id m20so13862548ejj.10
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 00:04:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LvKzpoZaHH4k3rMn3ckQg2LuMnl5MssN3o1bB1rWqok=;
        b=OViChFl12HJmyRk/c/o9JsiSWCltZinEzP/s7MBGK2BtTa1F8jzZ0X+w7aF/rSfpFn
         HBreouKn8DKQi78xbpDI76HKBZOGQaPEvZUhOe4ICYs5QcpWstSDCVL0in5bR8kF0yo1
         sf1joUhz9JOIbGgJwewt6fXIWjxfCOZw0/2+vLpqRiyyXSXK8Q5ngrsIpC9vOiDb1BAZ
         vIQ9Eu0pGJaGvBTmRSLu/2TWgKpK2+BTNiqm8gNV8gN9/lXy34pbwu2EKr8S1E3E/Ngs
         bpHX7U7pXzV9/6B5+minAQ4GIzkPig7T12zRpKQ+AuuJRKQ/sOjDKuLa3hrpzKr1LpQ0
         wPCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LvKzpoZaHH4k3rMn3ckQg2LuMnl5MssN3o1bB1rWqok=;
        b=C9ssUQE+CsvB1sG5AgtSQwda+dSXtj/mE694MOCI1QsQMrhPC1Mmwpl5/aFjxYKBh7
         vAQqu4YtrQcqXn6mMzyPp/OtAHyQWEbqCapYZAqmfoi4Rr5USFB36U6mh0FczqQtmpKu
         4nvZcicypBiZh46k4hzw7K8xJDVQhhup2XZtZx2XqsQ9HokyNg/2zSxER/zNFxW2TFkr
         6s4Q7iSpt+zVBJ2pRa2aIs2iwJJ29hfC6kYCkpoyW5pNXTxcFv3DyaPj+aBlfI6zgtj7
         EiJEr/rGbL4EnZsUYqmOLXn1SWEBY/q4MV5iDlOX5nZ34rJIu8U3lUR5U0IiavMu8UFb
         watQ==
X-Gm-Message-State: AOAM531uZ9gUU740fyxArraLYt0LpSgJdurDzNzxX8Noc/PkldpTScS+
        k3Z6dT2G89+bRLsjOXQs4/urhA==
X-Google-Smtp-Source: ABdhPJzPhZ0o+MelOlAh9e2Ibbc1Agkg5iZCBeM+vmobJqj3vr58v4krX6d7A0s8PV5OSznurM733Q==
X-Received: by 2002:a17:907:9613:b0:6f4:3b48:b004 with SMTP id gb19-20020a170907961300b006f43b48b004mr7194106ejc.171.1653030258195;
        Fri, 20 May 2022 00:04:18 -0700 (PDT)
Received: from otso.. (144-178-202-138.static.ef-service.nl. [144.178.202.138])
        by smtp.gmail.com with ESMTPSA id md17-20020a170906ae9100b006feaf472637sm336092ejb.53.2022.05.20.00.04.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 May 2022 00:04:17 -0700 (PDT)
From:   Luca Weiss <luca.weiss@fairphone.com>
To:     linux-arm-msm@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Luca Weiss <luca.weiss@fairphone.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Georgi Djakov <djakov@kernel.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/5] interconnect: qcom: icc-rpmh: Support child NoC device probe
Date:   Fri, 20 May 2022 09:03:13 +0200
Message-Id: <20220520070318.48521-2-luca.weiss@fairphone.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220520070318.48521-1-luca.weiss@fairphone.com>
References: <20220520070318.48521-1-luca.weiss@fairphone.com>
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

As per e39bf2972c6e ("interconnect: icc-rpm: Support child NoC device
probe") also update the rpmh interconnect driver to support probing NoCs
that are modelled as child devices of a different NoC.

As the driver doesn't yet use the 'reg' property, no change is done for
that.

Downstream DT reference:
https://android.googlesource.com/kernel/msm-extra/devicetree/+/refs/tags/android-11.0.0_r0.56/qcom/lagoon-bus.dtsi

Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
Changes since v1:
* none

 drivers/interconnect/qcom/icc-rpmh.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/interconnect/qcom/icc-rpmh.c b/drivers/interconnect/qcom/icc-rpmh.c
index 3c40076eb5fb..8acc8e67a332 100644
--- a/drivers/interconnect/qcom/icc-rpmh.c
+++ b/drivers/interconnect/qcom/icc-rpmh.c
@@ -258,6 +258,10 @@ int qcom_icc_rpmh_probe(struct platform_device *pdev)
 	data->num_nodes = num_nodes;
 	platform_set_drvdata(pdev, qp);
 
+	/* Populate child NoC devices if any */
+	if (of_get_child_count(dev->of_node) > 0)
+		return of_platform_populate(dev->of_node, NULL, NULL, dev);
+
 	return 0;
 err:
 	icc_nodes_remove(provider);
-- 
2.36.1

