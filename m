Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A80EA5678F5
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 22:56:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231637AbiGEU4T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 16:56:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231238AbiGEU4H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 16:56:07 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDF0915A09;
        Tue,  5 Jul 2022 13:56:05 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id x10so9489390edd.13;
        Tue, 05 Jul 2022 13:56:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=n1pkrcMQjBz/FRxe7ar3hA0ekF4WVND5LanMRiZumKU=;
        b=Cktgf5jOYaT0/fJ4U/vliL1vCroasJ1MYYEkoQjd5JUv8UDT+EFyINLQQctotsDc1Z
         Gzxgy5nbB+HS2Wft2gk1d+MLm4L0iZwFV/I3LFZ/mvXr8o/X2ioqeMMLtEo/yQMcNikU
         dtLBLeebRJpyTZ5M+GeHMgJJ2acji1jHpTo1tUobdA54W17LdnBo6/jyBd1e+PfA21gv
         yBC+Ogj5PB0L5p923hExgZ2aJMsGGCjMEApbK7gnvBGCYZrccHl0w+7s+7j0WNuUZ4gA
         3Eg3leVDbQimeyeqtTk4zVHh+ljUaienm86hw98jPxPctMn9FESF6rNl5/77mCSH8V0f
         uuTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=n1pkrcMQjBz/FRxe7ar3hA0ekF4WVND5LanMRiZumKU=;
        b=F8PHBdHybxXbSRWfdZkQdwJzEde6rJsavadmU/Mf6mT0y8ZfNisCxmH9aJjWcghR2C
         9B/sLyMjcHgTllwchtGyJFVvQdJ9uwBROtlENQrXVbRbDwtIpRk4O8PqDPEGho5pLVWX
         xgBE8rKROvHcEU/zkFa5htZLYCsshfJYPG98DZ73v2m2VX71tazS+eONVQtD4fBzGik8
         jt2ER2MaAyT1LG3GNFaF7mqmfZckhOm/XMo+OITMhD68mmLIL+gHP2r8PGrSrXcjGvLK
         dS4onD0/vhFMFE0oJG848X12N0+liEfMC8DLEASUUqbyM0ucJDpOAR/Mubx772hVFIba
         6Zbg==
X-Gm-Message-State: AJIora9yKsJKvqfIoFtl3OPsWRy3fJ8/8xw7HUYe5EniI+Rllf9oGPkA
        SmSpf/3aNP+WPVAaD9r5hN3ptIxYlyg=
X-Google-Smtp-Source: AGRyM1tLFqjqxPY+jlqMoptKtwWGGw2zkxjJbSsgeRR7luOINLMKNJPz3To1K/2QbVw6uV+coOAZsA==
X-Received: by 2002:aa7:d542:0:b0:43a:875:64d3 with SMTP id u2-20020aa7d542000000b0043a087564d3mr24938401edr.139.1657054564380;
        Tue, 05 Jul 2022 13:56:04 -0700 (PDT)
Received: from localhost.localdomain (93-42-70-190.ip85.fastwebnet.it. [93.42.70.190])
        by smtp.googlemail.com with ESMTPSA id dm3-20020a05640222c300b0043a70c51470sm3836956edb.55.2022.07.05.13.56.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Jul 2022 13:56:04 -0700 (PDT)
From:   Christian Marangi <ansuelsmth@gmail.com>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Christian Marangi <ansuelsmth@gmail.com>
Subject: [PATCH 4/5] ARM: dts: qcom: add pxo/cxo clock-output-names for ipq8064
Date:   Tue,  5 Jul 2022 22:28:36 +0200
Message-Id: <20220705202837.667-5-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220705202837.667-1-ansuelsmth@gmail.com>
References: <20220705202837.667-1-ansuelsmth@gmail.com>
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

Drivers expect to call pxo/cxo_board clock as pxo/cxo.
Use clock-output-names to set the correct naming for these fixed clock
to save drivers that are migrating to parent_data and still use
parent_names.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 arch/arm/boot/dts/qcom-ipq8064.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/qcom-ipq8064.dtsi b/arch/arm/boot/dts/qcom-ipq8064.dtsi
index 1425a4e4283f..720e27e29627 100644
--- a/arch/arm/boot/dts/qcom-ipq8064.dtsi
+++ b/arch/arm/boot/dts/qcom-ipq8064.dtsi
@@ -302,12 +302,14 @@ cxo_board: cxo_board {
 			compatible = "fixed-clock";
 			#clock-cells = <0>;
 			clock-frequency = <25000000>;
+			clock-output-names = "cxo";
 		};
 
 		pxo_board: pxo_board {
 			compatible = "fixed-clock";
 			#clock-cells = <0>;
 			clock-frequency = <25000000>;
+			clock-output-names = "pxo";
 		};
 
 		sleep_clk: sleep_clk {
-- 
2.36.1

