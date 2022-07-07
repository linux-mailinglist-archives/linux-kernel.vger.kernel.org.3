Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F31456973F
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 03:12:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234774AbiGGBKe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 21:10:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234611AbiGGBKQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 21:10:16 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 489632E683;
        Wed,  6 Jul 2022 18:10:15 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id q6so29796845eji.13;
        Wed, 06 Jul 2022 18:10:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DqA/PYcFjqc35dtwpOSvvpQVHjaEPTenZ8v5MpUqkpE=;
        b=XNWD1s6HrVpg1euEQFIBPPVSvsoa4PfWYMidItBPykvKxpfzYMc7+vULRUW+vT6UgZ
         7rqb3i/Y0ICNm4r4wTWyjgs2dGsUILsQERDDcMolVJ6azEsZB22NcXZuSrt45ivwuhu1
         8m+HREp+yVRjDuxg82XCWDOXGyCSMWzyHJG0YKkehJckNAsew5TDWzOeRyqayq/zqcYk
         OkRSZKkEhVQpa2R4vyMhbbJy4wfx2Eg4015RQDFM/z2J6IqxTV/xVVtnRTQ11p+riJ8C
         O4eJPwz+hgI6kXnfUNoPRjWBpqVjxrBosc3yYPlSnL3kctHPcAA3llkc3U+w5C1BSdih
         qfEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DqA/PYcFjqc35dtwpOSvvpQVHjaEPTenZ8v5MpUqkpE=;
        b=Oqj4BLMcf9IG0eeUfw/KSXk8twKF6Z69jYK7U3G6TYhMVlSr3cnsbpfDUQvw6Il7tV
         wG25HYGgAXFRpT6R4Iemaybze5epE+3i+YrTSQFKfwEnork7DQf7gqibLQmL6YhT9Mhi
         OQ26+mbGGNpRNOz0CJPjEggBKslmU60sJBs6hVbJ+b8LcPOHUwIeWHMg/eUFV9Nz0/oC
         OgOTIN+xfWNIYnbB36PiXik7cWdw+MKsOQ/u3ieQAUp2ndV3f42fIZ1bHuOMJP0qd9AS
         n63jdXbpUh9KxmkzDgn0kCJHwG6robC9Nuxyjw4JEFls5lyCfqFjaKkNzJKRIZT6/bbZ
         Sibw==
X-Gm-Message-State: AJIora8ueD7+q+elNFjTXlb409yZSP5U/gtlXUJPeeXQHwtx70Xp9ul6
        zkbduaCmfJqkkyfx61hU3LzZQZ3SISQ=
X-Google-Smtp-Source: AGRyM1vRlf71nDSp0AeuPEQOj5EdTIakkESFyMNewE4EARiDUmc8l5w/9d/QFV3JAKwJgs8QBad1gQ==
X-Received: by 2002:a17:907:6e1b:b0:72a:f376:34de with SMTP id sd27-20020a1709076e1b00b0072af37634demr7714625ejc.320.1657156213782;
        Wed, 06 Jul 2022 18:10:13 -0700 (PDT)
Received: from localhost.localdomain (93-42-70-190.ip85.fastwebnet.it. [93.42.70.190])
        by smtp.googlemail.com with ESMTPSA id u17-20020a056402111100b0043a6e807febsm6915464edv.46.2022.07.06.18.10.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Jul 2022 18:10:13 -0700 (PDT)
From:   Christian Marangi <ansuelsmth@gmail.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Christian Marangi <ansuelsmth@gmail.com>,
        Jonathan McDowell <noodles@earth.li>
Subject: [PATCH v2 8/8] ARM: dts: qcom: add speedbin efuse nvmem node
Date:   Thu,  7 Jul 2022 03:09:43 +0200
Message-Id: <20220707010943.20857-10-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220707010943.20857-1-ansuelsmth@gmail.com>
References: <20220707010943.20857-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add speedbin efuse nvmem cell needed for the opp table for the CPU
freqs.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
Tested-by: Jonathan McDowell <noodles@earth.li>
---
 arch/arm/boot/dts/qcom-ipq8064.dtsi | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/boot/dts/qcom-ipq8064.dtsi b/arch/arm/boot/dts/qcom-ipq8064.dtsi
index 69cf664851c6..71572028bc36 100644
--- a/arch/arm/boot/dts/qcom-ipq8064.dtsi
+++ b/arch/arm/boot/dts/qcom-ipq8064.dtsi
@@ -854,6 +854,9 @@ qfprom: qfprom@700000 {
 			reg = <0x00700000 0x1000>;
 			#address-cells = <1>;
 			#size-cells = <1>;
+			speedbin_efuse: speedbin@c0 {
+				reg = <0xc0 0x4>;
+			};
 			tsens_calib: calib@400 {
 				reg = <0x400 0xb>;
 			};
-- 
2.36.1

