Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACC89515821
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Apr 2022 00:12:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239704AbiD2WPD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 18:15:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381399AbiD2WO2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 18:14:28 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52D4BDCAA0
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 15:11:08 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id b19so12390101wrh.11
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 15:11:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=57engup4j45HnL7iURERsQ9bmMAMFdlq2bnMX7taFcM=;
        b=KMXgwq1kT4vpGqXVn6WjiTOVMNVqDXTTrwGtMvopzf8LUXavFlq16ADBbLzVjTTiOO
         S80A+O5TSD/4favz/l325p0RuFQVv388Nn8goDchum0+CM+q8+vDd0ydLYOGTcOnulCo
         UqHeyoL5HxMVRhdgv2gtKGhuYrRmWHfYIdD7Ea2xMkVT7W+KVhhqKXoMs+oR5BWlG2EG
         pSsZUlRg2Qzrm2CTV2yilbR5Cs+mRB3xBAPGsTaLFJLZu7c0m0H7awkLPrTBX0PK6jtP
         2WOmrgZlB5b5qwiTJp//3iHNTLH5BFfgJkF8rYeTkKDR89Rhul6gvCZlAj7oBGh2QpHx
         PIKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=57engup4j45HnL7iURERsQ9bmMAMFdlq2bnMX7taFcM=;
        b=4otHIoYQwf8uA9KA+6M0/PEt7XrP2omcMyn4bogougsnOpB5tpIQoBoA6pWhDjgMtS
         x6S0D2/gkRxnsrcc3zVMR8nqhEzLL71ggSQSJ0+FDywGsqGmg7ndjmm1n4K7kPH3VpbX
         WEj6qSzDU+C0kgetWJoMhMdqkkvCI14AUj1qKlVOtYqebDL23Us7vgCOCss25X/eCRlv
         WfFoHNKyioQP2TcwoQRNSDGEjoFuDu0MY+TMv4V85bb4OSH2T9ChetIlS7Rr7M02iDSv
         PkUoIxFXT8uPC9TIYXiRSSDNiOtNP1oWxJgWngVAlMmZy0Ar3CKlQ+vNy/gK+CWf2+S7
         7x1g==
X-Gm-Message-State: AOAM533VgQGLti8Cf5EwuSMWgL9yNLgt6T+MAKhP7GN0SMbrarPRp/lV
        vi0ykdoPM2DaR73OguxMKcXAfQ==
X-Google-Smtp-Source: ABdhPJxxf4Y9z8bowzImAap497E8RuioUTq7E3SZ8AirFC/uZaKYONIF7e4s3jdC60OW704ZIVQ7TQ==
X-Received: by 2002:a05:6000:1a4f:b0:20a:ccdd:c70e with SMTP id t15-20020a0560001a4f00b0020accddc70emr850284wry.444.1651270266909;
        Fri, 29 Apr 2022 15:11:06 -0700 (PDT)
Received: from localhost.localdomain (cpc78119-cwma10-2-0-cust590.7-3.cable.virginm.net. [81.96.50.79])
        by smtp.gmail.com with ESMTPSA id q7-20020a1cf307000000b003942a244ebfsm291985wmq.4.2022.04.29.15.11.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Apr 2022 15:11:06 -0700 (PDT)
From:   Caleb Connolly <caleb.connolly@linaro.org>
To:     caleb.connolly@linaro.org, Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Lee Jones <lee.jones@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Cc:     Jami Kettunen <jami.kettunen@somainline.org>,
        Sumit Semwal <sumit.semwal@linaro.org>
Subject: [PATCH v14 10/10] arm64: dts: qcom: msm8998-oneplus-common: enable RRADC
Date:   Fri, 29 Apr 2022 23:09:05 +0100
Message-Id: <20220429220904.137297-11-caleb.connolly@linaro.org>
X-Mailer: git-send-email 2.36.0
In-Reply-To: <20220429220904.137297-1-caleb.connolly@linaro.org>
References: <20220429220904.137297-1-caleb.connolly@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jami Kettunen <jami.kettunen@somainline.org>

Enable the Round Robin ADC for the OnePlus 5/5T.

Signed-off-by: Jami Kettunen <jami.kettunen@somainline.org>
---
 arch/arm64/boot/dts/qcom/msm8998-oneplus-common.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/msm8998-oneplus-common.dtsi b/arch/arm64/boot/dts/qcom/msm8998-oneplus-common.dtsi
index 9823d48a91b1..d9fff1beaf03 100644
--- a/arch/arm64/boot/dts/qcom/msm8998-oneplus-common.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8998-oneplus-common.dtsi
@@ -257,6 +257,10 @@ pinconf {
 	};
 };
 
+&pmi8998_rradc {
+	status = "okay";
+};
+
 &qusb2phy {
 	status = "okay";
 
-- 
2.36.0

