Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E2915A6300
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 14:14:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230363AbiH3MOR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 08:14:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229736AbiH3MOI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 08:14:08 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A80FE155A64
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 05:14:07 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id z29so6679352lfb.13
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 05:14:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=tV1opztXSWwn25vhDNpyv3M9Wuq0qcdEHDEQPaQUNQU=;
        b=gvk48BAuaZbx67DTS/zy27STTJa1CiM72il9+U1fi55xMqIncbK4p4JrASXirY19eg
         N/Gm1b8vrMghy3M9CEGIpeZIdjeII0fITiDQIxHegJ6adLTJalEcXIwEz1ep0Lzyj8Bt
         EhhlDX+Wf8lThwNTjR72qy07Yf+b/MG+At8XKN36V4NbIK++56lSnWgPr4p6b/xKWhP0
         /atTQucHFtYyAKtZI3Vj3+vQeo2DQX/pSfKqrAUpYbByhkPYZnbTQlqUBNBxPUI0duks
         Mx2ElAbBpcsJ/wwnP9ktoyd2ogCeIe6TStsJpZhyxipvUgQIie/tl7pJZzcdLM5IBbnZ
         oDTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=tV1opztXSWwn25vhDNpyv3M9Wuq0qcdEHDEQPaQUNQU=;
        b=DLZ5H7wvxztV6EG+zP6zGvy6jMw/m5skkX/ra3x8x37thbE1P0vJ8qPfcZf+BHydM8
         MhNsAXilJqoXe+uTVooL7jzQIAL0Rpc+ukPQ3MpgvEYJye2URBCFNmurQsIBkq2lI7Hu
         5Cun+QC42Q4mnQtHvIKDfrP/hvme4mE4MtSHyfrwa0O795ceayiDK+b5swXDpsx5btKr
         ezorAwTffkNg8SkYvNzk7TAFEXr/32E57ccgWqDbf+/QzDvSlBQcXhmGwZ7cJ36fwdHp
         3wREhfLYR1HWbh6IUfWNu1iWRzhDKI4rkpq5dOx4Fe12BIGG7VCD0ChVXJI8fyKApcWP
         KwVQ==
X-Gm-Message-State: ACgBeo2HHjpEwQo12mcycOV3KTxpH+FcmNTQEOMuf4ECvu9p8q5XL4ac
        w0h4QHKGClhs9VLv2TInEf3j5A==
X-Google-Smtp-Source: AA6agR4WYnjWeLAeGRO6Z3iE3KEFyNKY3aDbcTKotgzRbCAOOWTHqUA6Ic12LhVaqAs8aXNrydO8cg==
X-Received: by 2002:ac2:4c48:0:b0:494:6dc8:3a91 with SMTP id o8-20020ac24c48000000b004946dc83a91mr2388200lfk.280.1661861646093;
        Tue, 30 Aug 2022 05:14:06 -0700 (PDT)
Received: from krzk-bin.. (balticom-73-99-134.balticom.lv. [109.73.99.134])
        by smtp.gmail.com with ESMTPSA id e14-20020a2e984e000000b0025e57b40009sm1742436ljj.89.2022.08.30.05.14.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Aug 2022 05:14:05 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arm-msm@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 3/3] slimbus: qcom-ngd: simplify error paths with dev_err_probe
Date:   Tue, 30 Aug 2022 15:13:59 +0300
Message-Id: <20220830121359.634344-3-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220830121359.634344-1-krzysztof.kozlowski@linaro.org>
References: <20220830121359.634344-1-krzysztof.kozlowski@linaro.org>
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

Use dev_err_probe to skip printing of deferred probe errors and to
simplify error paths.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/slimbus/qcom-ngd-ctrl.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/drivers/slimbus/qcom-ngd-ctrl.c b/drivers/slimbus/qcom-ngd-ctrl.c
index bacc6af1d51e..cec11aa106bf 100644
--- a/drivers/slimbus/qcom-ngd-ctrl.c
+++ b/drivers/slimbus/qcom-ngd-ctrl.c
@@ -1543,10 +1543,8 @@ static int qcom_slim_ngd_ctrl_probe(struct platform_device *pdev)
 
 	ret = devm_request_irq(dev, ret, qcom_slim_ngd_interrupt,
 			       IRQF_TRIGGER_HIGH, "slim-ngd", ctrl);
-	if (ret) {
-		dev_err(&pdev->dev, "request IRQ failed\n");
-		return ret;
-	}
+	if (ret)
+		return dev_err_probe(&pdev->dev, ret, "request IRQ failed\n");
 
 	ctrl->nb.notifier_call = qcom_slim_ngd_ssr_notify;
 	ctrl->notifier = qcom_register_ssr_notifier("lpass", &ctrl->nb);
@@ -1575,15 +1573,14 @@ static int qcom_slim_ngd_ctrl_probe(struct platform_device *pdev)
 
 	ctrl->pdr = pdr_handle_alloc(slim_pd_status, ctrl);
 	if (IS_ERR(ctrl->pdr)) {
-		dev_err(dev, "Failed to init PDR handle\n");
-		ret = PTR_ERR(ctrl->pdr);
+		ret = dev_err_probe(dev, PTR_ERR(ctrl->pdr),
+				    "Failed to init PDR handle\n");
 		goto err_pdr_alloc;
 	}
 
 	pds = pdr_add_lookup(ctrl->pdr, "avs/audio", "msm/adsp/audio_pd");
 	if (IS_ERR(pds) && PTR_ERR(pds) != -EALREADY) {
-		ret = PTR_ERR(pds);
-		dev_err(dev, "pdr add lookup failed: %d\n", ret);
+		ret = dev_err_probe(dev, PTR_ERR(pds), "pdr add lookup failed\n");
 		goto err_pdr_lookup;
 	}
 
-- 
2.34.1

