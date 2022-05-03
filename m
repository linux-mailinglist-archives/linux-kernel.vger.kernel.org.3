Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36B6C5188F6
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 17:46:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238833AbiECPtf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 11:49:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238851AbiECPtI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 11:49:08 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4196033E24;
        Tue,  3 May 2022 08:45:33 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id k27so20311162edk.4;
        Tue, 03 May 2022 08:45:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=S2tw9LJk+d2FPX5CW//2TgutvMaT3ZAnSGVaZGs0cVc=;
        b=dTJu+AA18pGDu+Mgrone8iJ6Z5vFaP/hKQ8qJv5XDiiu1KshAcRfRm1fj1TNKMUBJT
         9ElyDG+MwSx8JE84tlJ9mjm70uLNRC02R891DmUZjV0Kxn5fS+n7EYN51GITLL5dkVuC
         vxPWvd1K+x397FdQyz6N56FjkiorFYzmzEy55u9R70soQiG7Q1u+1/sJN/Yk1FbM2BvP
         6uOcMgkpMJI6TLULOw9vyrs0mooGDkPpAZH2LQGf8ZSl7uW4tGgtxLm/nknqDPbinTNy
         eNfz0qEEe2/fYEzO5N9D6aNU4TNzp8h9/It3hnOMxuvrk1xQ/2kaev5wFhjqdTDLwd/H
         Myqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=S2tw9LJk+d2FPX5CW//2TgutvMaT3ZAnSGVaZGs0cVc=;
        b=NLnfj5DP7obJ3D+W14ZjbqVXLQYXZiofjwC+n7YZvQeY/p6Z7Lq6RjIcWBhK9F45h7
         jRLJWllvDnuOX1U70ZSwanJgyvYcmbH5m3pWMWzlyTMvP79pueNceWNAf4/rMcnbm40E
         2IMe7/NUXZHe+BFEXf4LvPTUSy/+9S+EX3AR6poDu79mpFMMbOPLvcnoryRx4DAS4SYs
         QX3g2pPFKzQszTvN8gXmxYeNxUaI2UMB9cgfYOKhP2OlZWWobqruqmB1psoHGTlPe/Jr
         91Imxn9YOJvQKBRvE2+S9IoPrWxF9+ZBYDFz6OBsXdBLt5VQTCrgZax1Ue+189Mgexpn
         035Q==
X-Gm-Message-State: AOAM530OM1eS7Mrc1bW8oxktCamtYr17FChzjJmIyUHUqE3cFUp+w1nM
        Xu86R/9AcQwl+esPytjEndAgu2bl9qQ=
X-Google-Smtp-Source: ABdhPJw71h8u7bNYCJUDffMoU514rCTVKO4FY77cSkL3yVy0Qw21I63fWcfq/vLCAnTa/czwvXfPXQ==
X-Received: by 2002:aa7:dcd5:0:b0:425:e49f:db86 with SMTP id w21-20020aa7dcd5000000b00425e49fdb86mr18498439edu.202.1651592731707;
        Tue, 03 May 2022 08:45:31 -0700 (PDT)
Received: from localhost.localdomain (93-42-70-190.ip85.fastwebnet.it. [93.42.70.190])
        by smtp.googlemail.com with ESMTPSA id zp26-20020a17090684fa00b006f3ef214e62sm4723961ejb.200.2022.05.03.08.45.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 May 2022 08:45:31 -0700 (PDT)
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
Subject: [PATCH v2 2/2] dt-bindings: mtd: qcom_nandc: document qcom,boot-pages binding
Date:   Tue,  3 May 2022 17:43:53 +0200
Message-Id: <20220503154353.4367-3-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220503154353.4367-1-ansuelsmth@gmail.com>
References: <20220503154353.4367-1-ansuelsmth@gmail.com>
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

Document new qcom,boot_pages binding used to apply special
read/write configuration to boot pages.

QCOM apply a special configuration where spare data is not protected
by ECC for some special pages (used for boot partition). Add
Documentation on how to declare these special pages.

Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
---
 .../devicetree/bindings/mtd/qcom,nandc.yaml   | 22 +++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/Documentation/devicetree/bindings/mtd/qcom,nandc.yaml b/Documentation/devicetree/bindings/mtd/qcom,nandc.yaml
index 84ad7ff30121..fafeca0cafff 100644
--- a/Documentation/devicetree/bindings/mtd/qcom,nandc.yaml
+++ b/Documentation/devicetree/bindings/mtd/qcom,nandc.yaml
@@ -102,6 +102,26 @@ allOf:
             - const: rx
             - const: cmd
 
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - qcom,ipq8074-nand
+
+    then:
+      properties:
+        qcom,boot-pages:
+          $ref: /schemas/types.yaml#/definitions/uint32-matrix
+          description:
+            Some special page used by boot partition have spare data
+            not protected by ECC. Use this to declare these special page
+            by defining first the offset and then the size.
+
+            It's in the form of <offset1 size1 offset2 size2 offset3 ...>
+
+            Refer to the ipq8064 example on how to use this special binding.
+
 required:
   - compatible
   - reg
@@ -135,6 +155,8 @@ examples:
         nand-ecc-strength = <4>;
         nand-bus-width = <8>;
 
+        qcom,boot-pages = <0x0 0x58a0000>;
+
         partitions {
           compatible = "fixed-partitions";
           #address-cells = <1>;
-- 
2.34.1

