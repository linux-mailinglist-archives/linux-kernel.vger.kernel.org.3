Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B97251ED24
	for <lists+linux-kernel@lfdr.de>; Sun,  8 May 2022 12:51:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232528AbiEHKxr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 May 2022 06:53:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231674AbiEHKxB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 May 2022 06:53:01 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EFB0B86F;
        Sun,  8 May 2022 03:49:11 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id n10so21888607ejk.5;
        Sun, 08 May 2022 03:49:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iddYG1Rb4tvpla03/UsMyBFX9rB+DvQUSfmApZMvI9E=;
        b=IkijBn+aso3oEEmXipspRhtd94LYOI62nlHAc8Qt8OXvtmM+Hpo7cINcOO4I/zpeG0
         6i1vHt3bJ3Gvs7P92YNRNWl+0MQZmQd6Pa080Bdry0iWETSIuu9OtgvgjHNLdOabas2r
         XcWi/3tl8JlXhxWRWXDBc8pKplAP1qBauWvTChL4kpnfrAvq0Zky0ib+V8STFBhQKz5E
         vgKzROdvBVdm3Z7qAAqPOx+vyrPgCFUoUGywc7I/Y896Bvufc33EEtEFLKVEocNzbhZL
         O+R4U8mT1BRVaGSbiYMumGzoKunoX0vTc7jg4Ew18Pi/NIpvti35GI4U/QWPQUVAJ3kO
         gfKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iddYG1Rb4tvpla03/UsMyBFX9rB+DvQUSfmApZMvI9E=;
        b=elovzcj86+FyD3oZqLxnNVPMqeH4Wxxk62QFB3GvnDtWRNwX6LLp3QQwpmjIO9xgFw
         iYJPr21/xb2q+S7RcJh96r9oorRnmcqrzLd+/zqqZ1UjFnyHhw8RUsR0vsSEq8FqF8t2
         svqet/t/+wvhi0yuWOAKuzG2APS4Ldm0N1yfbmBuSlehWW0EMcVFnRXERTeUVjFs+BLF
         M9+pvtzkqO6h4q4QdbajgYiW7vSEsS0JE38kM+EJ6kzP7oJTol0WEN+5JOUrdkwGloD6
         DfBRBeXnrVIOFv97b2ngPEjFwzwkjpmaZ4pjrKrvfawNfgUeO5v2zkIv5oa67XQTwMG8
         /gWQ==
X-Gm-Message-State: AOAM531FpfAIOLBJW6Jn5HQUrobnUB3GPiEsG3ew0Idmq2cnWJoOXDri
        fdyImGp3CBgWXFguLaonln8=
X-Google-Smtp-Source: ABdhPJwPqM11DpkoohC1S8GN7nYKsErm30mvSyKKdKohNWosCthVywZpnwdbSdvgmoLNgOOevaLVyg==
X-Received: by 2002:a17:907:6d84:b0:6f4:94e2:e708 with SMTP id sb4-20020a1709076d8400b006f494e2e708mr10331759ejc.199.1652006950192;
        Sun, 08 May 2022 03:49:10 -0700 (PDT)
Received: from fedora.robimarko.hr (cpezg-94-253-144-244-cbl.xnet.hr. [94.253.144.244])
        by smtp.googlemail.com with ESMTPSA id hg12-20020a1709072ccc00b006f3ef214e0csm3917471ejc.114.2022.05.08.03.49.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 May 2022 03:49:09 -0700 (PDT)
From:   Robert Marko <robimarko@gmail.com>
To:     agross@kernel.org, bjorn.andersson@linaro.org,
        mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, dmitry.baryshkov@linaro.org
Cc:     Robert Marko <robimarko@gmail.com>
Subject: [PATCH v3 08/11] dt-bindings: clock: qcom: ipq8074: add USB GDSCs
Date:   Sun,  8 May 2022 12:48:52 +0200
Message-Id: <20220508104855.78804-8-robimarko@gmail.com>
X-Mailer: git-send-email 2.36.0
In-Reply-To: <20220508104855.78804-1-robimarko@gmail.com>
References: <20220508104855.78804-1-robimarko@gmail.com>
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

Add bindings for the USB GDSCs found in IPQ8074 GCC.

Signed-off-by: Robert Marko <robimarko@gmail.com>
---
 include/dt-bindings/clock/qcom,gcc-ipq8074.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/dt-bindings/clock/qcom,gcc-ipq8074.h b/include/dt-bindings/clock/qcom,gcc-ipq8074.h
index 5f0928785d7a..e4991d303708 100644
--- a/include/dt-bindings/clock/qcom,gcc-ipq8074.h
+++ b/include/dt-bindings/clock/qcom,gcc-ipq8074.h
@@ -368,4 +368,7 @@
 #define GCC_PCIE1_AXI_MASTER_STICKY_ARES	130
 #define GCC_PCIE0_AXI_SLAVE_STICKY_ARES		131
 
+#define USB0_GDSC				0
+#define USB1_GDSC				1
+
 #endif
-- 
2.36.0

