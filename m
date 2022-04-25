Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CB4F50E252
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 15:48:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242249AbiDYNug (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 09:50:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234107AbiDYNu1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 09:50:27 -0400
Received: from ixit.cz (ip-94-112-206-30.net.upcbroadband.cz [94.112.206.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97CCF49F2A;
        Mon, 25 Apr 2022 06:47:22 -0700 (PDT)
Received: from newone.lan (_gateway [10.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ixit.cz (Postfix) with ESMTPSA id 7C60A24CD1;
        Mon, 25 Apr 2022 15:47:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ixit.cz; s=dkim;
        t=1650894440;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=B3wDqWWJHIVaagerOvGAtw8VaSEVJ80LKDclB0SMhEw=;
        b=c92Hbs7mOrOfYmkRluL7/YuAh1AqNr52XGdCili3pYlH0PHKbkJJ0JERPc7IXUdDNk7VwP
        VHJUh7am7nHlTuElyn5H2lyYC8edU8qdwAJs7y1ZLE8v+q7Yp3V+JWrRk6wwV+l1ltIGys
        wVJ4KnbSOxY94CcMISAAcB2YgSk/oKQ=
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
Subject: [PATCH v3 2/2] dt-bindings: mailbox: qcom-ipcc: add missing properties into example
Date:   Mon, 25 Apr 2022 15:47:16 +0200
Message-Id: <20220425134717.55418-2-david@ixit.cz>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220425134717.55418-1-david@ixit.cz>
References: <20220425134717.55418-1-david@ixit.cz>
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

 .../devicetree/bindings/mailbox/qcom-ipcc.yaml        | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/mailbox/qcom-ipcc.yaml b/Documentation/devicetree/bindings/mailbox/qcom-ipcc.yaml
index 825d29367737..a31f1f098246 100644
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

