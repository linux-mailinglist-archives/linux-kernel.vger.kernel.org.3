Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF6654C566C
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Feb 2022 14:55:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231694AbiBZNyT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Feb 2022 08:54:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232002AbiBZNxb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Feb 2022 08:53:31 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C83CE339E;
        Sat, 26 Feb 2022 05:52:53 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id g20so11119264edw.6;
        Sat, 26 Feb 2022 05:52:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=C+K2lBtTnUG/zOR0yeLMU3tKfbWOdMbyUCThXXICUks=;
        b=ZH/NeeGyrl+gF39Lx/VmrDRoqZpKMdNXWFI/+VVJdHFtDBOYbcjrofEYs+xr1BZ3xP
         5YWcf86yIld614xbD+i7UKYsy+gT6HSyYNu+w/bRwR0zj2FG34tCin1jQ0qdg5uUaKLv
         ETA1W5Dq5Z7JDsmQfxl/e3uhxxT9VJI1DKzwZWu7ZOqag8zkJn1jdeyuoejS4EzX1fpe
         wVmhGPsdqogeYs3uhuVzzo2bzNiLF2Mat0ZSZqSboMpfRopAl7K9g68TkRQoQtr29Wqu
         Rrde7DaSDOnBXOOi5yzi/se26wpoM5XlD0NQgRcVgMQAW51zwx2xIMYOI3tW+xPWjeiU
         XXgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=C+K2lBtTnUG/zOR0yeLMU3tKfbWOdMbyUCThXXICUks=;
        b=uNUo5mR45oY3Q49l51V36ZsGxCXiUYV74bf0NzS94LzAc0AfojNViNUVF50KVXljk1
         VziViqM7rX+B4o0cuU31qsaC2Lx2m3p5wFIs+BWTQz43ZKQB+PcNDRmAVLWKH4ITwl5G
         GImXEphsRAySM8Xo6gtvP4Z2AoXgkSP4Ecwo98Pg8H2BGZJR+h1WIVUa1hivSSKpYFO4
         zqZAyYEIOG4PR6+JUzT4ENCYR3YB+Ciq7uciwH8JnVfAnWcLKoV/2OvpEb/j55FD4qV8
         pSqYg5OC8Fkh5rDXYGAeZ8m8o3GHxDbIxgVXY66qSMzBT45wdk6yijMOfH0fByN0/ENF
         70AQ==
X-Gm-Message-State: AOAM5313u6o/4tpjTWiDqI28S9OZ2SWxy/nc65yqSVLUDfGPLUG9Kedl
        7hCRjQh1GV58SvC0GaykdCQ=
X-Google-Smtp-Source: ABdhPJxts0nnN1Yijd+7WkTy3jxB08A6ahPe3xyIQ56OIEgbAgfx7eOtXFiwBQrROStv1NZZoai1Vg==
X-Received: by 2002:aa7:d7d3:0:b0:410:d23b:6746 with SMTP id e19-20020aa7d7d3000000b00410d23b6746mr11729660eds.453.1645883571817;
        Sat, 26 Feb 2022 05:52:51 -0800 (PST)
Received: from Ansuel-xps.localdomain (host-95-251-226-220.retail.telecomitalia.it. [95.251.226.220])
        by smtp.googlemail.com with ESMTPSA id j21-20020aa7c415000000b004127ac9ddc3sm2836369edq.50.2022.02.26.05.52.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Feb 2022 05:52:51 -0800 (PST)
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Taniya Das <tdas@codeaurora.org>,
        Ansuel Smith <ansuelsmth@gmail.com>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Rob Herring <robh@kernel.org>
Subject: [PATCH v6 11/15] dt-bindings: clock: add ipq8064 ce5 clk define
Date:   Sat, 26 Feb 2022 14:52:31 +0100
Message-Id: <20220226135235.10051-12-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220226135235.10051-1-ansuelsmth@gmail.com>
References: <20220226135235.10051-1-ansuelsmth@gmail.com>
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

Add ipq8064 ce5 clk define needed for CryptoEngine in gcc driver.
Define CE5_SRC is not used so it's OK to change and we align it to
the QSDK naming.

Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
Acked-by: Rob Herring <robh@kernel.org>
Reviewed-by: Stephen Boyd <sboyd@kernel.org>
---
 include/dt-bindings/clock/qcom,gcc-ipq806x.h | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/include/dt-bindings/clock/qcom,gcc-ipq806x.h b/include/dt-bindings/clock/qcom,gcc-ipq806x.h
index 7deec14a6dee..02262d2ac899 100644
--- a/include/dt-bindings/clock/qcom,gcc-ipq806x.h
+++ b/include/dt-bindings/clock/qcom,gcc-ipq806x.h
@@ -240,7 +240,7 @@
 #define PLL14					232
 #define PLL14_VOTE				233
 #define PLL18					234
-#define CE5_SRC					235
+#define CE5_A_CLK				235
 #define CE5_H_CLK				236
 #define CE5_CORE_CLK				237
 #define CE3_SLEEP_CLK				238
@@ -283,5 +283,8 @@
 #define EBI2_AON_CLK				281
 #define NSSTCM_CLK_SRC				282
 #define NSSTCM_CLK				283
+#define CE5_A_CLK_SRC				285
+#define CE5_H_CLK_SRC				286
+#define CE5_CORE_CLK_SRC			287
 
 #endif
-- 
2.34.1

