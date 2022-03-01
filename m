Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1824B4C8501
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 08:26:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232898AbiCAH0h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 02:26:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232871AbiCAH00 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 02:26:26 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C0387B57E
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 23:25:45 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id v5-20020a17090ac90500b001bc40b548f9so1366484pjt.0
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 23:25:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QR6ESE2OAl/bWxT4TTgx26HVZoBHd22PyQQgfFHvaEM=;
        b=QYUVG1XxsSiq+9WIQTSiT00AJtOjabF3YJUaIFMuZtrtG55j6M/bvKPpIEuge2fu7s
         yyPqARG8xvjSnnjA4aFRy9Ybn7cNil1eIyB+9+PWO3CWh0DIRMO/8+5X7h2yOrDeUnPV
         KBNdKG7hWpYKGCD7tIeQoYqRfy715d3/QDwz3Q/qv5ydXOC2L/CGMycRcl13Ml2Rkz++
         rSYcGEq9ETY1PysoGmkoUPtG3VVGhGgs72qdA1sPlo0o6DIwK/u+dqn8Mns2YEwOUv4t
         2wJupyVTgV+1iHo9eJwaq8nhXkrYZvDH/we/cIWGKayxogBdfq5uT28P+7KwiYi6+d69
         wEMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QR6ESE2OAl/bWxT4TTgx26HVZoBHd22PyQQgfFHvaEM=;
        b=BUlA2ig1DcwNjGGn+tLzwTucTRMi9ABH4m5+gBxesrDgIx8R80IfYv6nE7EUnHDUwr
         ZlV2xGtrAKSgj5ZZUzZVDKGfEDufRmtAZDuS5JA61e6WtUAWGD/thMybZWyd0zeCK9ng
         sW4bTVX7giZTyAXgItXfsaYoMeL8RtJ2X5qDPt9U9o0YpDtO7YNXcRIsH6pEcH+rKgCs
         N8mZ3ji7NlIFl7SdpxUtu6F4OlECZY+jJb9wutKar4C1xNK8cljjZiKVql3w/7daqA8v
         5Ev5wwVHSdvt4DzcDdbiXpgqzu0FFP+pVETP/Npylf8JOUOiNtnSCBX4c7ZFhex+ydhj
         FCxg==
X-Gm-Message-State: AOAM533s56/PZDu8j84GQLNdoyn4hMjd+yF3pcUmqdgHaMXSN8/EpSzy
        p5E9LnmjQrbJDUTEdoou5+N6Zw==
X-Google-Smtp-Source: ABdhPJzPRrnJXmCmZDOwh2M8DI71z41lCJTCgimaM0nvCHg3AeKt3NcTCUEthhMISD0z4qbOr0RnHg==
X-Received: by 2002:a17:902:e5c3:b0:14f:a4ff:34b8 with SMTP id u3-20020a170902e5c300b0014fa4ff34b8mr23792224plf.24.1646119544920;
        Mon, 28 Feb 2022 23:25:44 -0800 (PST)
Received: from localhost.localdomain ([223.179.136.225])
        by smtp.gmail.com with ESMTPSA id m6-20020a62f206000000b004e152bc0527sm15680445pfh.153.2022.02.28.23.25.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Feb 2022 23:25:44 -0800 (PST)
From:   Bhupesh Sharma <bhupesh.sharma@linaro.org>
To:     linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     bhupesh.sharma@linaro.org, bhupesh.linux@gmail.com,
        lorenzo.pieralisi@arm.com, agross@kernel.org,
        bjorn.andersson@linaro.org, svarbanov@mm-sol.com,
        bhelgaas@google.com, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, sboyd@kernel.org, mturquette@baylibre.com,
        linux-clk@vger.kernel.org
Subject: [PATCH v2 3/7] clk: qcom: gcc: Add PCIE_0_GDSC and PCIE_1_GDSC for SM8150
Date:   Tue,  1 Mar 2022 12:55:07 +0530
Message-Id: <20220301072511.117818-4-bhupesh.sharma@linaro.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220301072511.117818-1-bhupesh.sharma@linaro.org>
References: <20220301072511.117818-1-bhupesh.sharma@linaro.org>
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

Add the PCIE_0_GDSC and PCIE_1_GDSC defines for SM8150,
so that dts files can use the same.

Cc: Stephen Boyd <sboyd@kernel.org>
Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
---
 include/dt-bindings/clock/qcom,gcc-sm8150.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/dt-bindings/clock/qcom,gcc-sm8150.h b/include/dt-bindings/clock/qcom,gcc-sm8150.h
index 3e1a91876610..ae9c16410420 100644
--- a/include/dt-bindings/clock/qcom,gcc-sm8150.h
+++ b/include/dt-bindings/clock/qcom,gcc-sm8150.h
@@ -241,6 +241,8 @@
 #define GCC_USB_PHY_CFG_AHB2PHY_BCR				28
 
 /* GCC GDSCRs */
+#define PCIE_0_GDSC						0
+#define PCIE_1_GDSC						1
 #define USB30_PRIM_GDSC                     4
 #define USB30_SEC_GDSC						5
 
-- 
2.35.1

