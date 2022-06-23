Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FA99557702
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 11:47:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231340AbiFWJq6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 05:46:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231259AbiFWJqk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 05:46:40 -0400
Received: from mx.kernkonzept.com (serv1.kernkonzept.com [IPv6:2a01:4f8:1c1c:b490::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB10D4993C;
        Thu, 23 Jun 2022 02:46:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kernkonzept.com; s=mx1; h=Content-Transfer-Encoding:MIME-Version:References
        :In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=rnBbkQy2L0V7vBcp8pSKVvSDrlQ1RJzOEZhug24jamc=; b=LXPmSKlf9B7PYFcaWRrKfIVTUM
        bkhGQWsAHgBIl0xWK5DfmTsWjmXzUEgxXS59uwJwlDPPBBeNx1V3X9PUvCUHOnVbE5BXhcObGfpVB
        NAcu7z1JPxILcjItyLLCusivbbP2x+ppbL36dSfpYUqtxUawTaJeH0ycCUxtj6pTpCAxDp6wifEyD
        6UJcW6cCH3wZjFMTn6WUIH+UHzVYMM4Mcuk/CFST1RXZmmAKbAHWpbuXYc76sntIxoYWPJmfUjqSC
        tAOEZHQak0OS3FA5yOLp44A0aRGFk2JqF+JFAPcwuQVH4kgp2uDcRyv7Ayw7kfI4/SXymTORNp+Gs
        cfXOIhMw==;
Received: from [10.22.3.24] (helo=kernkonzept.com)
        by mx.kernkonzept.com with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim 4.94.2)
        id 1o4JQ0-005qg2-7B; Thu, 23 Jun 2022 11:46:32 +0200
From:   Stephan Gerhold <stephan.gerhold@kernkonzept.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Stephan Gerhold <stephan.gerhold@kernkonzept.com>
Subject: [PATCH 1/3] regulator: qcom_smd: Fix pm8916_pldo range
Date:   Thu, 23 Jun 2022 11:46:12 +0200
Message-Id: <20220623094614.1410180-2-stephan.gerhold@kernkonzept.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220623094614.1410180-1-stephan.gerhold@kernkonzept.com>
References: <20220623094614.1410180-1-stephan.gerhold@kernkonzept.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The PM8916 device specification [1] documents a programmable range of
1.75V to 3.337V with 12.5mV steps for the PMOS LDOs in PM8916. This
range is also used when controlling the regulator directly using the
qcom_spmi-regulator driver ("ult_pldo" there).

However, for some reason the qcom_smd-regulator driver allows a much
larger range for the same hardware component. This could be simply a
typo, since the start of the range is essentially just missing a '1'.

In practice this does not cause any major problems, since the driver
just sends the actual voltage to the RPM firmware instead of making use
of the incorrect voltage selector. Still, having the wrong range there
is confusing and prevents the regulator core from validating requests
correctly.

[1]: https://developer.qualcomm.com/download/sd410/pm8916pm8916-1-power-management-ic-device-specification.pdf

Fixes: 57d6567680ed ("regulator: qcom-smd: Add PM8916 support")
Signed-off-by: Stephan Gerhold <stephan.gerhold@kernkonzept.com>
---
 drivers/regulator/qcom_smd-regulator.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/regulator/qcom_smd-regulator.c b/drivers/regulator/qcom_smd-regulator.c
index 4051d5fa9df9..8b2d884cd693 100644
--- a/drivers/regulator/qcom_smd-regulator.c
+++ b/drivers/regulator/qcom_smd-regulator.c
@@ -358,10 +358,10 @@ static const struct regulator_desc pm8941_switch = {
 
 static const struct regulator_desc pm8916_pldo = {
 	.linear_ranges = (struct linear_range[]) {
-		REGULATOR_LINEAR_RANGE(750000, 0, 208, 12500),
+		REGULATOR_LINEAR_RANGE(1750000, 0, 127, 12500),
 	},
 	.n_linear_ranges = 1,
-	.n_voltages = 209,
+	.n_voltages = 128,
 	.ops = &rpm_smps_ldo_ops,
 };
 
-- 
2.30.2

