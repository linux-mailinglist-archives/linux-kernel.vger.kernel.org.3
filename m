Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44FE8527454
	for <lists+linux-kernel@lfdr.de>; Sat, 14 May 2022 23:55:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235495AbiENVyw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 May 2022 17:54:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235498AbiENVyl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 May 2022 17:54:41 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EA602D1DC
        for <linux-kernel@vger.kernel.org>; Sat, 14 May 2022 14:54:40 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id a11so10761281pff.1
        for <linux-kernel@vger.kernel.org>; Sat, 14 May 2022 14:54:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iVHLE0FSagaU/6sD2J6a+GPzkzj/n/6jKnq+SCiWCmE=;
        b=IJfTXbvryw4AOaqheyB6aks6Uqee2W4Vcx70IGzPZ8a55Ny4CH71weNSkvbqBAv3lH
         kneSd9V4aNcyl8fvtwp/oDN63xavWRhovZbFzXKLXTOFAWWN++RA2cnZeDVs9yhqNJUh
         CqBi0uBDUnx0E4d3FXGPio7BXeP5esbQw2l3MtjZgHhVLNK1bRfrFlyT3dQ2aRgwnJGt
         4HEXKm1J0NDUFnffMn6WQzHfoEXcXRLPQMpyZIGNVM9X6NU1HRBqHlQ5nXEfCaewY3Kn
         jduWHsElj/dKW9xwLR2GkKmQuaPG6vFQ3IVikCcGRWb+SfTy+xzhVK6sIfH3tj9jG+v8
         dXhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iVHLE0FSagaU/6sD2J6a+GPzkzj/n/6jKnq+SCiWCmE=;
        b=LqHbVyUsElH4NWCNx8O1dkAaXE0thAAyuYb6M1JN+ksmBCfagR85+Msw21jcIFH7dQ
         SBG14fV0vniI+Sw7Hb2o2B4sGphSz95d0ngVamrwb508rH1n5IxAhQ8Rg9ade8e4oPjl
         zwXdiDBUmHdLpwM7xkkspG/k030yZp5qU+Lw7OKVeuxvV+fmHyik8+3m7zrw84GkEyvF
         vuKpsfH9lq+5wCpinitl/USdWYjlY/9G1mVaADYaVA6tpNte7Z3wUnLpRsBv4iRwxQKq
         WsTswTVyMVhtfKdthEXuVQNedDKH14XFZJ1vZTk4Pwswim408Pfs9NzHHDIeElykAstQ
         fMFw==
X-Gm-Message-State: AOAM532vULT+daQ8Ck80I3sjVtvNNktyigWvY3I6XC/fOx7G+x14xajV
        Xa7UJtlzlvmJA9i7seg4nQjkJA==
X-Google-Smtp-Source: ABdhPJz1bGqQv7MnwByvRME1qtAsZA8IMh4C+YpU2vxO34U/+WpSRQNWYMgR4YDBYtU+ns2qAtcONQ==
X-Received: by 2002:a63:87c6:0:b0:3c6:a7d9:5d01 with SMTP id i189-20020a6387c6000000b003c6a7d95d01mr9433225pge.341.1652565279662;
        Sat, 14 May 2022 14:54:39 -0700 (PDT)
Received: from localhost.localdomain ([2401:4900:1c60:931c:dd30:fa99:963:d0be])
        by smtp.gmail.com with ESMTPSA id m13-20020a170902db0d00b0015e8d4eb2d2sm4189522plx.284.2022.05.14.14.54.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 May 2022 14:54:39 -0700 (PDT)
From:   Bhupesh Sharma <bhupesh.sharma@linaro.org>
To:     linux-arm-msm@vger.kernel.org
Cc:     bhupesh.sharma@linaro.org, bhupesh.linux@gmail.com,
        linux-kernel@vger.kernel.org, bjorn.andersson@linaro.org,
        robh@kernel.org
Subject: [PATCH v2 2/6] arm64: dts: qcom: sdm630: Fix 'interconnect-names' for sdhci nodes
Date:   Sun, 15 May 2022 03:24:20 +0530
Message-Id: <20220514215424.1007718-3-bhupesh.sharma@linaro.org>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220514215424.1007718-1-bhupesh.sharma@linaro.org>
References: <20220514215424.1007718-1-bhupesh.sharma@linaro.org>
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

Since the Qualcomm sdhci-msm device-tree binding has been converted
to yaml format, 'make dtbs_check' reports issues with
inconsistent 'interconnect-names' used for sdhci nodes.

Fix the same.

Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: Rob Herring <robh@kernel.org>
Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
---
 arch/arm64/boot/dts/qcom/sdm630.dtsi | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sdm630.dtsi b/arch/arm64/boot/dts/qcom/sdm630.dtsi
index cadc920bcd9c..34b177f0ce87 100644
--- a/arch/arm64/boot/dts/qcom/sdm630.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm630.dtsi
@@ -1289,6 +1289,7 @@ sdhc_2: mmc@c084000 {
 
 			interconnects = <&a2noc 3 &a2noc 10>,
 					<&gnoc 0 &cnoc 28>;
+			interconnect-names = "sdhc-ddr","cpu-sdhc";
 			operating-points-v2 = <&sdhc2_opp_table>;
 
 			pinctrl-names = "default", "sleep";
@@ -1341,7 +1342,7 @@ sdhc_1: mmc@c0c4000 {
 
 			interconnects = <&a2noc 2 &a2noc 10>,
 					<&gnoc 0 &cnoc 27>;
-			interconnect-names = "sdhc1-ddr", "cpu-sdhc1";
+			interconnect-names = "sdhc-ddr", "cpu-sdhc";
 			operating-points-v2 = <&sdhc1_opp_table>;
 			pinctrl-names = "default", "sleep";
 			pinctrl-0 = <&sdc1_state_on>;
-- 
2.35.3

