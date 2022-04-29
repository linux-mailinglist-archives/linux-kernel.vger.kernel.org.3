Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C10A51572E
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 23:45:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239082AbiD2VsB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 17:48:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238929AbiD2Vrw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 17:47:52 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07702D95CC
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 14:44:31 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id h12so8212328plf.12
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 14:44:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=G+b/5mZlFuHtU2XDozomo84+nsQCdCx5HIlm6/xmsSw=;
        b=Lk7L4IygC+lKFXqlatdS4sTNMrlHQVhH4QHq/GcQWEOUR6yjyfqapWDnENI0syOUvP
         Pzv1QdFuuw86sXzVfRNyM1MpUmh2rZFLO84tTRpO1RKk4nE8A79vzXTk6vg+/EpXwhl3
         GhmbUD8NL9c5bj5oiGDKHapJL4bLvGZP8hYJKNjbpf4YwyFIV/A704gevl80qAnna8dw
         6z/7oAuCmHf9MYIdniHiHYo+yFKWsKFck1vKvl2O02zcet1rDAya5x/AlXPuy64iE0ev
         rU9n9WSGcs5Bhnby8BeF5QDgxgMy2rAenTRY41M2Y2Y/gvok6CsFMUe1AndjZKQUXG74
         hapA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=G+b/5mZlFuHtU2XDozomo84+nsQCdCx5HIlm6/xmsSw=;
        b=lsBzWOxOT5DR8L1yt5nhFh0NGcvGDSfV2OI+RC5Emd64ZYLYyUUcVf0F5v7rMUoPmG
         +29nB0Mv/Tno+chwQvTs3lvMLs49OyzQDGhJF68rZZjs/iSPuE6UDqSAA3ARZaZaPyXj
         J4eAB40isQZzAaP8eZ4Fq1EeCSXX8o8dEvFwcg3lO15AhyzvtkX/TxRT25VG8CtrLuX3
         8KCxkY9azVK1uOn4ziXzZkm2sa48vENZpOWxudQqVR8nmGWmPg6BIimNwv5rOUi2axIA
         5VByVQpXzR5Y+H7jjmdBg5ixi3iYAqMBHlCk8oOjXbRDcdfuKTs2v02sH8aRghJQG6sp
         z8BA==
X-Gm-Message-State: AOAM531B7I9Oxi6IgPEsWGWPKqm6hxo/5mydzCkRJD607m2GhVSavve3
        j3N0qlcQVkRXoZevqnIO35gxbQ==
X-Google-Smtp-Source: ABdhPJwx9C+GPVAfhw27WAXdFgQUSO3zeFDI+lxbdL2k29gyzRGPqHdj1Zd+ey7umQd4Li4UnuYzKw==
X-Received: by 2002:a17:903:1252:b0:154:ca85:59a0 with SMTP id u18-20020a170903125200b00154ca8559a0mr1273711plh.169.1651268670521;
        Fri, 29 Apr 2022 14:44:30 -0700 (PDT)
Received: from localhost.localdomain ([223.233.64.97])
        by smtp.gmail.com with ESMTPSA id fv12-20020a17090b0e8c00b001cd4989fed0sm15271086pjb.28.2022.04.29.14.44.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Apr 2022 14:44:30 -0700 (PDT)
From:   Bhupesh Sharma <bhupesh.sharma@linaro.org>
To:     linux-arm-msm@vger.kernel.org
Cc:     bhupesh.sharma@linaro.org, bhupesh.linux@gmail.com,
        linux-kernel@vger.kernel.org, bjorn.andersson@linaro.org,
        Rob Herring <robh@kernel.org>
Subject: [PATCH 1/3] arm64: dts: qcom: sdm630: Fix 'interconnect-names' for sdhci nodes
Date:   Sat, 30 Apr 2022 03:14:18 +0530
Message-Id: <20220429214420.854335-2-bhupesh.sharma@linaro.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220429214420.854335-1-bhupesh.sharma@linaro.org>
References: <20220429214420.854335-1-bhupesh.sharma@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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
index 7f875bf9390a..db18b35d4a7d 100644
--- a/arch/arm64/boot/dts/qcom/sdm630.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm630.dtsi
@@ -1285,6 +1285,7 @@ sdhc_2: sdhci@c084000 {
 
 			interconnects = <&a2noc 3 &a2noc 10>,
 					<&gnoc 0 &cnoc 28>;
+			interconnect-names = "sdhc-ddr","cpu-sdhc";
 			operating-points-v2 = <&sdhc2_opp_table>;
 
 			pinctrl-names = "default", "sleep";
@@ -1337,7 +1338,7 @@ sdhc_1: sdhci@c0c4000 {
 
 			interconnects = <&a2noc 2 &a2noc 10>,
 					<&gnoc 0 &cnoc 27>;
-			interconnect-names = "sdhc1-ddr", "cpu-sdhc1";
+			interconnect-names = "sdhc-ddr", "cpu-sdhc";
 			operating-points-v2 = <&sdhc1_opp_table>;
 			pinctrl-names = "default", "sleep";
 			pinctrl-0 = <&sdc1_state_on>;
-- 
2.35.1

