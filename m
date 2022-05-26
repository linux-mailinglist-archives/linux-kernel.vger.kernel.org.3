Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E09D2534E80
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 13:46:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344879AbiEZLqH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 07:46:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347353AbiEZLo4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 07:44:56 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 255ABD029E
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 04:44:42 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id x12so1124120pgj.7
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 04:44:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ea7OeFJXlMpFcPLCRl9ByzN+8R9kDLKU8gAyymKSibQ=;
        b=M6bRg+ULJ96LPwVQ7+5mReEW6ZqyIV3Sw0mUefHoAbPfZkGsn0gU5r1icGCEjYkHeS
         LZYzMws85x1JW1ZIVi11yxmJEZt9nPXRXAzUBUiJRa2eWGg/HEfMPMQxVATCKPOD+jrx
         OdWVyEgzxpUBJzJcm/blvmIT/3RPW2UkGXrAjD/+ovhUmhml8N2JhwpaDLxJjLWK+yOA
         UT0x1q9jF/CQPOmxPMdb8UK++Y+myFIm6xEWiyNyKBiN3dqv8crhWv2uDYjW7mTv+eVX
         TZdFxHmBplkzg1lzvyh+YKaqrQJ/aFOtFsAR4POd2B9XTCgETMvLsA8VT1Wf3E+qIgb+
         rZaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ea7OeFJXlMpFcPLCRl9ByzN+8R9kDLKU8gAyymKSibQ=;
        b=DX63RWM9aPEX+3j1+IeaxsnE77f0QwiuDlLxlsEqcODO4re8uDMQGho1j60DUp3oeh
         +Hboa0G5IKtVw9xtxsb2pqlMv5lhbgXHAPrIsLuj7w+WEUHXYYEg3aeWslC/7mCRrMF7
         PEb/8dOgGjxMJUl192Q9csHwSM+N7dFCn3HfFbZ+sO/SEaWfinPWTyhb2qgYBEbiLMcs
         q5yrc+Gc8SHGx9Nco0+F0scdHJyhf4Vg1+I+CSGwKQNjJBCwEU5D0aEVeK5TptcGT/33
         4xa9BpfV39xisxYnLbR8o1wA84V9mpYobMmyC4UT8ls5tRsyBepCvF5HxUKtQ9cwU+M4
         5uPg==
X-Gm-Message-State: AOAM531OdFjQvSaGCmzabZWjS8jnTZgM/D02m9iCOfSfLnmm36hL2jnF
        tIQg773a4OKTafSa2voHAqoB816Z8V33cQ==
X-Google-Smtp-Source: ABdhPJxmzRiAXnitzctuPYAA9jUL7Rnfwu6jdDAlzlKlkWUlBLdlfPYGPy437OiWOPMUX61OXwUPFQ==
X-Received: by 2002:a05:6a00:1d1d:b0:518:421c:b65e with SMTP id a29-20020a056a001d1d00b00518421cb65emr35712261pfx.43.1653565481268;
        Thu, 26 May 2022 04:44:41 -0700 (PDT)
Received: from localhost ([122.162.234.2])
        by smtp.gmail.com with ESMTPSA id i13-20020a170902eb4d00b001635f9b6e2fsm1360265pli.61.2022.05.26.04.44.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 May 2022 04:44:40 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Rafael Wysocki <rjw@rjwysocki.net>,
        Stephen Boyd <sboyd@kernel.org>, Nishanth Menon <nm@ti.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 24/31] serial: qcom: Migrate to dev_pm_opp_set_config()
Date:   Thu, 26 May 2022 17:12:23 +0530
Message-Id: <49aff8c5f72dae52ef7e9acb4f821d0c3e097813.1653564321.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a514
In-Reply-To: <cover.1653564321.git.viresh.kumar@linaro.org>
References: <cover.1653564321.git.viresh.kumar@linaro.org>
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

The OPP core now provides a unified API for setting all configuration
types, i.e. dev_pm_opp_set_config().

Lets start using it.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/tty/serial/qcom_geni_serial.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/serial/qcom_geni_serial.c
index 1543a6028856..391fcc3a0f61 100644
--- a/drivers/tty/serial/qcom_geni_serial.c
+++ b/drivers/tty/serial/qcom_geni_serial.c
@@ -1331,6 +1331,9 @@ static int qcom_geni_serial_probe(struct platform_device *pdev)
 	int irq;
 	bool console = false;
 	struct uart_driver *drv;
+	struct dev_pm_opp_config config = {
+		.clk_name = "se",
+	};
 
 	if (of_device_is_compatible(pdev->dev.of_node, "qcom,geni-debug-uart"))
 		console = true;
@@ -1414,7 +1417,7 @@ static int qcom_geni_serial_probe(struct platform_device *pdev)
 	if (of_property_read_bool(pdev->dev.of_node, "cts-rts-swap"))
 		port->cts_rts_swap = true;
 
-	ret = devm_pm_opp_set_clkname(&pdev->dev, "se");
+	ret = devm_pm_opp_set_config(&pdev->dev, &config);
 	if (ret)
 		return ret;
 	/* OPP table is optional */
-- 
2.31.1.272.g89b43f80a514

