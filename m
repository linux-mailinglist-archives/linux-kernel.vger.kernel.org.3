Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72A0850FAEC
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 12:34:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242157AbiDZKg7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 06:36:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345643AbiDZKgo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 06:36:44 -0400
Received: from ixit.cz (ip-94-112-206-30.net.upcbroadband.cz [94.112.206.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 550A212096;
        Tue, 26 Apr 2022 03:19:17 -0700 (PDT)
Received: from newone.lan (_gateway [10.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ixit.cz (Postfix) with ESMTPSA id 4677924CD1;
        Tue, 26 Apr 2022 12:19:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ixit.cz; s=dkim;
        t=1650968355;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gMico/kd/KLGo7kE0Bi8wMvNY3EFFukpNPtGHdicAV8=;
        b=wXd6SlQ5CH5SoBjd0JNA7xfo3IwCPjZ5M9tTzYhEL7WPRGVaqcexKGmw1Z5EeoMvhmG62x
        +tVH2HdkXNJq/b9B26AdqQA7iQDWxPYTCDCp1o/yIMuH9o8nKKj0skyyMbhgcJvgwNvreS
        CkalUN1dO5sY3faHagUpk2uBBzlgppI=
From:   David Heidelberg <david@ixit.cz>
To:     Manivannan Sadhasivam <mani@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc:     David Heidelberg <david@ixit.cz>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH v4 2/2] dt-bindings: mailbox: qcom-ipcc: add missing properties into example
Date:   Tue, 26 Apr 2022 12:18:37 +0200
Message-Id: <20220426101837.16201-2-david@ixit.cz>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220426101837.16201-1-david@ixit.cz>
References: <20220426101837.16201-1-david@ixit.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RDNS_DYNAMIC,SPF_HELO_PASS,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These missing required properties are needed for
smp2p binding reference checks.

Also includes cosmetic change to the example formatting.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: David Heidelberg <david@ixit.cz>
---
v3:
 - add Krzysztof R-b
---
 .../devicetree/bindings/mailbox/qcom-ipcc.yaml        | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/mailbox/qcom-ipcc.yaml b/Documentation/devicetree/bindings/mailbox/qcom-ipcc.yaml
index c57dd423e98c..50f9aa72c670 100644
--- a/Documentation/devicetree/bindings/mailbox/qcom-ipcc.yaml
+++ b/Documentation/devicetree/bindings/mailbox/qcom-ipcc.yaml
@@ -76,9 +76,14 @@ examples:
 
         smp2p-modem {
                 compatible = "qcom,smp2p";
-                interrupts-extended = <&ipcc_mproc IPCC_CLIENT_MPSS
-                                IPCC_MPROC_SIGNAL_SMP2P IRQ_TYPE_EDGE_RISING>;
-                mboxes = <&ipcc_mproc IPCC_CLIENT_MPSS IPCC_MPROC_SIGNAL_SMP2P>;
+                qcom,smem = <443>, <429>;
+                interrupts-extended = <&ipcc IPCC_CLIENT_LPASS
+                                             IPCC_MPROC_SIGNAL_SMP2P
+                                             IRQ_TYPE_EDGE_RISING>;
+                mboxes = <&ipcc IPCC_CLIENT_LPASS
+                                IPCC_MPROC_SIGNAL_SMP2P>;
 
+                qcom,local-pid = <0>;
+                qcom,remote-pid = <2>;
                 /* Other SMP2P fields */
         };
-- 
2.35.1

