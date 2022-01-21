Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A1B34966F3
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 22:04:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233578AbiAUVEp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 16:04:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233366AbiAUVEH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 16:04:07 -0500
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C31C1C06174E;
        Fri, 21 Jan 2022 13:04:06 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id s13so3332715ejy.3;
        Fri, 21 Jan 2022 13:04:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=AjXtNoxCWeIUyUrNbQiYIAA3OZQBx2qW4EKDiOvy2ws=;
        b=HEtv1uSt2Bqyh0qXdkiNjgKh0C95Ccd4+oApTG+V4+xJLhjYI75t/zHeWDA8vgTGGa
         cGuGnduhoyWCRrbVEeFcKUl66c5ISt5ZXFtCi/jgo9g8N1nV2ov+dGUsY9f23hIfvYOn
         l3icLto8cJXwmFgkRvxmSijF8E4C6t6+d+mevgP+gST7QJlZODLgRSzJp+DTTSBAbVXT
         xJTEfNtaoxp+cJcY259kGRVHZiieXx2dHHWNHqwYMtMfQek5PF3+BJwvosHBwQy9t05Y
         kV4POI57TIidN9Ud9zP/2mS0eNWfCYiktUgvzRqFWuhoYY2JNcQsTQv0q/zTdOMOw9O4
         zomw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AjXtNoxCWeIUyUrNbQiYIAA3OZQBx2qW4EKDiOvy2ws=;
        b=SZqp1c91Sq7le2YShW5AI8JNd780YdTSaE+wp+V5UZh0t/0QWLU6zHemMD7b0BYRUo
         2h4UTf1TdwOFd96kKvlW7O/MlobB+BgCpew5qtbxvsjGpqZ+VLGHUsLx5mhJaBP7XuSr
         R4BaRHZUBBbS8RBy38xe78kXXEkQiaT0dxz1yAlkCL/NSqXcSbLzRG0LT3O06D/FhRaD
         eu8JqWmghjNn51njmFb+Q8YPEQv8eTgxLBTSqfFE8w73eBrJPTf6ZGP4XRLFg6r1+VyT
         BMLGnkYvBN+0LKNWReJkDxMz9If7W9BVSh/180EYgKeozYVGB4ukw+p7w/SvmF0f3U4S
         ge1w==
X-Gm-Message-State: AOAM5317yu60Kuj7RM3mU0pkCfw8Lcj5R9X0ZdfEjUiEiaiKk/qVQc6a
        7X07ZiOKHupKFeJrfYF1bWc=
X-Google-Smtp-Source: ABdhPJyed0qTSbL9BJbBNFGluKihGGw8N8jCVmQfug9BHwLwXwvM/g4+5wYgQyon3230Btco10L3/A==
X-Received: by 2002:a17:907:72c2:: with SMTP id du2mr4761257ejc.90.1642799045115;
        Fri, 21 Jan 2022 13:04:05 -0800 (PST)
Received: from localhost.localdomain (93-42-71-246.ip85.fastwebnet.it. [93.42.71.246])
        by smtp.googlemail.com with ESMTPSA id p23sm2898595edx.86.2022.01.21.13.04.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jan 2022 13:04:04 -0800 (PST)
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
Subject: [PATCH v3 13/15] dt-bindings: reset: add ipq8064 ce5 resets
Date:   Fri, 21 Jan 2022 22:03:38 +0100
Message-Id: <20220121210340.32362-14-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20220121210340.32362-1-ansuelsmth@gmail.com>
References: <20220121210340.32362-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add ipq8064 ce5 resets needed for CryptoEngine gcc driver.

Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
---
 include/dt-bindings/reset/qcom,gcc-ipq806x.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/dt-bindings/reset/qcom,gcc-ipq806x.h b/include/dt-bindings/reset/qcom,gcc-ipq806x.h
index 26b6f9200620..020c9cf18751 100644
--- a/include/dt-bindings/reset/qcom,gcc-ipq806x.h
+++ b/include/dt-bindings/reset/qcom,gcc-ipq806x.h
@@ -163,5 +163,10 @@
 #define NSS_CAL_PRBS_RST_N_RESET			154
 #define NSS_LCKDT_RST_N_RESET				155
 #define NSS_SRDS_N_RESET				156
+#define CRYPTO_ENG1_RESET				157
+#define CRYPTO_ENG2_RESET				158
+#define CRYPTO_ENG3_RESET				159
+#define CRYPTO_ENG4_RESET				160
+#define CRYPTO_AHB_RESET				161
 
 #endif
-- 
2.33.1

