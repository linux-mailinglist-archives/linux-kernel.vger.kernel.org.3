Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 090255156BA
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 23:20:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237746AbiD2VWp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 17:22:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236993AbiD2VWi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 17:22:38 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 401DD7CB1E;
        Fri, 29 Apr 2022 14:19:19 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id i19so17626635eja.11;
        Fri, 29 Apr 2022 14:19:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gyPvT6DKhtv2LPGNMnZpj5WqaEJs4Q758Rx/bvZztkE=;
        b=K3IcMyLBnInq9tUXoAQmLRUn1n0CcUvwxaNSopGX4VEgfzz8O0/XMIsrlCdyXQFbuv
         i2EzK7Mdscn59II/wyTd12IcePJebAc+XAiW5eFGoT+dPynWOjM0P7FLsQpXr1RxEQZu
         6K6+ucWpN34OaMyZlRB1QmAcT6ekPsHvfQb03RzCKy1PEfJzLYlzGCIYuiupLtcYG4Gr
         LH+wJanQC4gj1TIPGX8oxglqFpSYwJq169oMaf1lp/Z9KUGJXrBEv1qtid1ZlFHcI3h3
         JALgObBe9GLtLhUrgbQHIjliMjQmyJ8JQI9yMf5zWrAe/4C/pMk1djaSF9eTIGnFX6qK
         bhKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gyPvT6DKhtv2LPGNMnZpj5WqaEJs4Q758Rx/bvZztkE=;
        b=sMfFFolvxk4/nFz0Iqc6V+KRsyI+ujPmjKESTb+r1ssSpSZw49bkNeUg+GD/1BGoZ4
         MXQobToHzEiXNB6pI6KZY/Jx7RMaOa1PWlmlIpbKaWAe0cGPO7jCggZ2DqijnOR5wPyn
         9qx9iZ4t9TfqeZ3ZKysPQq91qkEzmMkmKN/P6qLS5A543rAnibzIQPgLBka9ltp9oKrQ
         MBGWp8qtPnEp6R7njNjnMzKf3NTdQSoBwjJcrbjCkKp62kx0sJL5IXtC+vBJ6lETUDFM
         POPaf+8ukF4A9L3pTrfyKahk6Hr1gDIIDolOvTwU3yLf8ZjsMDvvsIXmVUyRs3xG4/mO
         Mnmg==
X-Gm-Message-State: AOAM530Syz6NnUVn0QWOl3XN5uQILkcOCS7sED1gif5awNyj5+9RLNhu
        WVZlPvMWQ/RVL6KYeyU97ZU=
X-Google-Smtp-Source: ABdhPJzPoQ/CPHg7g31DTKdKA5Cdrb5zHLXus8chii2zzudP/i37wdo/X/9NgP9i4O2ifmgOFtzLhg==
X-Received: by 2002:a17:907:1c87:b0:6f0:29ea:cc01 with SMTP id nb7-20020a1709071c8700b006f029eacc01mr1139319ejc.671.1651267157597;
        Fri, 29 Apr 2022 14:19:17 -0700 (PDT)
Received: from localhost.localdomain (93-42-70-190.ip85.fastwebnet.it. [93.42.70.190])
        by smtp.googlemail.com with ESMTPSA id hx14-20020a170906846e00b006f3ef214db6sm990143ejc.28.2022.04.29.14.19.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Apr 2022 14:19:17 -0700 (PDT)
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-mtd@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Ansuel Smith <ansuelsmth@gmail.com>
Subject: [PATCH 2/2] dt-bindings: mtd: qcom_nandc: document qcom,boot_pages binding
Date:   Fri, 29 Apr 2022 23:16:30 +0200
Message-Id: <20220429211630.7812-3-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220429211630.7812-1-ansuelsmth@gmail.com>
References: <20220429211630.7812-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document new qcom,boot_pages binding used to apply special
read/write configuration to boot pages.

QCOM apply a special configuration where spare data is not protected
by ECC for some special pages (used for boot partition). Add
Documentation on how to declare these special pages.

Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
---
 .../devicetree/bindings/mtd/qcom,nandc.yaml         | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/Documentation/devicetree/bindings/mtd/qcom,nandc.yaml b/Documentation/devicetree/bindings/mtd/qcom,nandc.yaml
index 84ad7ff30121..ef243109689d 100644
--- a/Documentation/devicetree/bindings/mtd/qcom,nandc.yaml
+++ b/Documentation/devicetree/bindings/mtd/qcom,nandc.yaml
@@ -78,6 +78,17 @@ allOf:
             Must contain the ADM data type CRCI block instance number
             specified for the NAND controller on the given platform
 
+        qcom,boot_pages:
+          $ref: /schemas/types.yaml#/definitions/uint32-array
+          description:
+            Some special page used by boot partition have spare data
+            not protected by ECC. Use this to declare these special page
+            by defining first the offset and then the size.
+
+            It's in the form of <offset1 size1 offset2 size2 offset3 ...>
+
+            Refer to the ipq8064 example on how to use this special binding.
+
   - if:
       properties:
         compatible:
@@ -135,6 +146,8 @@ examples:
         nand-ecc-strength = <4>;
         nand-bus-width = <8>;
 
+        qcom,boot_pages = <0x0 0x58a0000>;
+
         partitions {
           compatible = "fixed-partitions";
           #address-cells = <1>;
-- 
2.34.1

