Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CA15518500
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 15:05:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235866AbiECNIm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 09:08:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235805AbiECNI3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 09:08:29 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D5DB38BEF
        for <linux-kernel@vger.kernel.org>; Tue,  3 May 2022 06:04:56 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id i27so33306262ejd.9
        for <linux-kernel@vger.kernel.org>; Tue, 03 May 2022 06:04:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=HE6TEqKzjpF8P/f3OJMTxhJhd4luPXA1XQ5KDUdPOFw=;
        b=PRYSWSDLwarb+uV1LsWrJ/SgZraudviNmpgi1zgU34YNcaXjTdU1zxyWgoGR/l4aFl
         ZucjbOOi9Acwly4mFtzN29qcarpEHs4Lde3O5aUYXp4vU7HtGD/Q3YzDHtkjOyrsDJRo
         MPXqiMZnNVMVg+QCRFiy31h6foMdbUfMyDOiscCBOWCuqpY5gUAs4lsbqhbd/80OGVJ7
         Fke9VI8lvNWjmQ9KYdKzDbQDd8ZbSJAQBkrAd3W2Bcmjl9SRyDrKm3agyZO+waGIOLn3
         3fWiTLTGM+76HWGZ73E4yTx+NcPVXw3edX7yZ5CXmSR52WSsxL3T65nv9h9U5HqbGP94
         brrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HE6TEqKzjpF8P/f3OJMTxhJhd4luPXA1XQ5KDUdPOFw=;
        b=HmqqOVsRPvuRXFObyJ+PhB0sDgsdrc/DUxtDBWJk6+gyEfD47Uhad9rfgglwYWQHCy
         OJOhnF9iIZmvMOECmJK3CmnXRnOwls3PFkyxWCT+dauOC+QRS9NeQQBcPU8ZVrKsMumY
         EYheA7i4fTp51PV2XqjlL4soaHIryltElNRB2/r9rgvLVueWrqkAiCtBX/l1xCeaa4h1
         x9eG+fBTkYhupyJ1TTywmQje8ZlylZUXiZbzl18Pg6r6MnSPVA3sUX537s7pruugI9Vk
         Cw0WiApWs5gnrK6smA0nVSukebNhvaOt0SC/1mFS6TTRh5Q7UiiEg44tuOM9Ca/SyUHP
         v8XQ==
X-Gm-Message-State: AOAM532bhR+/ZDyyZX57dJyCN9LJzCMNRRC1fBoCKq6VvkuN0w58WQdB
        7ZPekM1+T6Sy/DyLI+TO+AhJ5g==
X-Google-Smtp-Source: ABdhPJwihD4Mx73DK2RWg8vq9oDDyCbCGuFL7KsHAJIKdDxw5ZxPnSo6PW0X4IyEPiH768CR2cXbHg==
X-Received: by 2002:a17:907:62a2:b0:6e0:e201:b94e with SMTP id nd34-20020a17090762a200b006e0e201b94emr15667761ejc.730.1651583094922;
        Tue, 03 May 2022 06:04:54 -0700 (PDT)
Received: from prec5560.. (freifunk-gw.bsa1-cpe1.syseleven.net. [176.74.57.43])
        by smtp.gmail.com with ESMTPSA id y13-20020aa7cccd000000b0042617ba639asm7868782edt.36.2022.05.03.06.04.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 May 2022 06:04:54 -0700 (PDT)
From:   Robert Foss <robert.foss@linaro.org>
To:     bjorn.andersson@linaro.org, agross@kernel.org,
        mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        krzk+dt@kernel.org, jonathan@marek.ca, tdas@codeaurora.org,
        anischal@codeaurora.org, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Subject: [PATCH v2 2/8] clk: Introduce CLK_ASSUME_ENABLED_WHEN_UNUSED
Date:   Tue,  3 May 2022 15:04:42 +0200
Message-Id: <20220503130448.520470-2-robert.foss@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220503130448.520470-1-robert.foss@linaro.org>
References: <20220503130448.520470-1-robert.foss@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bjorn Andersson <bjorn.andersson@linaro.org>

Some clock implementations doesn't provide means of implementing
is_enabled(), but still requires to be explicitly disabled when found
unused as part of clk_disable_unused().

One such set of clocks are Qualcomm's display RCGs. These can be enabled
and disabled automatically by the hardware, so it's not possible to
reliably query their configuration. Further more, these clocks need to
be disabled when unused, to allow them to be "parked" onto a safe
parent. Failure to disable the RCG results in the hardware locking up as
clk_disable_unused() traverses up the tree and turns off its source
clocks.

Add a new flag, CLK_ASSUME_ENABLED_BOOT, which clock drivers can use to
signal that these clocks should be disabled even if they don't implement
the is_enabled() ops.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---

Changes since v1
 - Removed Vinods r-b


 drivers/clk/clk.c            | 2 +-
 include/linux/clk-provider.h | 2 ++
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index ed119182aa1b..9789ec137219 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -1284,7 +1284,7 @@ static void __init clk_disable_unused_subtree(struct clk_core *core)
 	 * sequence.  call .disable_unused if available, otherwise fall
 	 * back to .disable
 	 */
-	if (clk_core_is_enabled(core)) {
+	if (clk_core_is_enabled(core) || core->flags & CLK_ASSUME_ENABLED_WHEN_UNUSED) {
 		trace_clk_disable(core);
 		if (core->ops->disable_unused)
 			core->ops->disable_unused(core->hw);
diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
index c10dc4c659e2..9038022ffebd 100644
--- a/include/linux/clk-provider.h
+++ b/include/linux/clk-provider.h
@@ -32,6 +32,8 @@
 #define CLK_OPS_PARENT_ENABLE	BIT(12)
 /* duty cycle call may be forwarded to the parent clock */
 #define CLK_DUTY_CYCLE_PARENT	BIT(13)
+/* assume clock is enabled if found unused in late init */
+#define CLK_ASSUME_ENABLED_WHEN_UNUSED	BIT(14)
 
 struct clk;
 struct clk_hw;
-- 
2.34.1

