Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 028E44C6FDE
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 15:46:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237319AbiB1OrY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 09:47:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237302AbiB1OrV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 09:47:21 -0500
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 565497F6F0
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 06:46:42 -0800 (PST)
Received: by mail-pg1-x536.google.com with SMTP id o26so10922064pgb.8
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 06:46:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fpvy3jbctqZ3DaV3M3Ck+o/s7hQ6Jvb06GHLLBI2uuM=;
        b=eUF6yIQhI7vVY2FFpMAxBEeuIuYzFBxyD0xw727eRJl/lmfV2nHlnwLa7GihnQiDU2
         hmOziIEeft81BWXidU2iOelCPUoT2qsFDBV9vxoB+mv8dN+KRJwZPULag2o+4LrK7PQX
         GXm5FsLp8zxYf565CuRaPw3JwncNcrN6AEeNUp89yragBpOVP4a6qsoEkKQxWcxiLQdn
         iq60GAp3vZyZnImDWCEAYN3Fa2agc6n84zPZ7OuOUsPQ0ZWSO2UIxCZvPFsq6l9EVuuu
         1Xv7Uwi3KruSqdVfsfRuTO3+XXOS1JM+QJ6YsQ48UwZWkB7EiIVphr8E356YXwXL/vKO
         awig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fpvy3jbctqZ3DaV3M3Ck+o/s7hQ6Jvb06GHLLBI2uuM=;
        b=IVQONgJpQ/tX9ic69pdOQ3J4G/swNgtpMH5+RaZdmuHVLzwCUCBUzy6bZ91GvANa0l
         BxnSgvsToy93lUCojH4FtAkFEb14mZNysP86v2eVZpqjFgs+OeX6MuEe46NsEVF859BQ
         o/doYTYfaR62IqfUVhDYAP52BMsHku4CeCb25yAwAG3TFE4AtQHQlzDbzVUYGe/ri3l6
         0T8tPc7Vy7FoUVI5UZ8ID7H92ezZT8oMsE592BO+Vccc/DkK1A7uUvAldBg/RHT39Ptn
         cNGqqT4Zh/1Vemcy5XX/jJmPl2B++LRcRFZ2It2/YsbP69UP2TKMVVNMmUlICdQAIHQC
         1cBQ==
X-Gm-Message-State: AOAM530sKMh1BtmqaPSOu9Ps2xSh6iBtzKURKDVAAh1pvwwRSL67mSb0
        d61jzdodt+ul8UU8Mzd5HZKvwQ==
X-Google-Smtp-Source: ABdhPJyLl6Xpu53tARTjusRFoH+Njs/u+LrL60/cEW5HL+5i0K/lhYwZMLQWkEpcbo+wu5OsXPxF8w==
X-Received: by 2002:a63:ce48:0:b0:373:ac94:f489 with SMTP id r8-20020a63ce48000000b00373ac94f489mr17816304pgi.622.1646059601757;
        Mon, 28 Feb 2022 06:46:41 -0800 (PST)
Received: from localhost.localdomain ([223.179.136.225])
        by smtp.gmail.com with ESMTPSA id lr2-20020a17090b4b8200b001bd6b5cce1dsm1736713pjb.36.2022.02.28.06.46.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Feb 2022 06:46:41 -0800 (PST)
From:   Bhupesh Sharma <bhupesh.sharma@linaro.org>
To:     linux-arm-msm@vger.kernel.org
Cc:     bhupesh.sharma@linaro.org, bhupesh.linux@gmail.com,
        agross@kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, sboyd@kernel.org, tdas@codeaurora.org,
        mturquette@baylibre.com, linux-clk@vger.kernel.org,
        robh+dt@kernel.org, Bjorn Andersson <bjorn.andersson@linaro.org>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH v2 1/2] clk: qcom: gcc: Add UFS_CARD_GDSC and UFS_PHY_GDSC for SM8150
Date:   Mon, 28 Feb 2022 20:16:06 +0530
Message-Id: <20220228144607.456194-2-bhupesh.sharma@linaro.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220228144607.456194-1-bhupesh.sharma@linaro.org>
References: <20220228144607.456194-1-bhupesh.sharma@linaro.org>
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

Add the UFS_CARD_GDSC and UFS_PHY_GDSC defines for SM8150,
so that dts files can use the same.

Cc: Stephen Boyd <sboyd@kernel.org>
Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
---
 include/dt-bindings/clock/qcom,gcc-sm8150.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/dt-bindings/clock/qcom,gcc-sm8150.h b/include/dt-bindings/clock/qcom,gcc-sm8150.h
index 3e1a91876610..1bd65cc581c3 100644
--- a/include/dt-bindings/clock/qcom,gcc-sm8150.h
+++ b/include/dt-bindings/clock/qcom,gcc-sm8150.h
@@ -241,6 +241,8 @@
 #define GCC_USB_PHY_CFG_AHB2PHY_BCR				28
 
 /* GCC GDSCRs */
+#define UFS_CARD_GDSC                                          2
+#define UFS_PHY_GDSC                                           3
 #define USB30_PRIM_GDSC                     4
 #define USB30_SEC_GDSC						5
 
-- 
2.35.1

