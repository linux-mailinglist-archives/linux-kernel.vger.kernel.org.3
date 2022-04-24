Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D790850D1E3
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Apr 2022 15:15:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233897AbiDXNSp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Apr 2022 09:18:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233876AbiDXNSn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Apr 2022 09:18:43 -0400
Received: from ixit.cz (ip-94-112-206-30.net.upcbroadband.cz [94.112.206.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 317A514005;
        Sun, 24 Apr 2022 06:15:39 -0700 (PDT)
Received: from localhost.localdomain (unknown [185.14.232.186])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ixit.cz (Postfix) with ESMTPSA id A14C724CD1;
        Sun, 24 Apr 2022 15:15:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ixit.cz; s=dkim;
        t=1650806137;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QvNIByDPWVlUgq4sXqZW7DEkdiTU/qc8abTFhlUfzbA=;
        b=mGzbTnEIMiQMC4UseBr6IXSQT4mFg7LjQ0reaGagczg/On51YrH9Xsv2x4q/umcFjQhM+j
        3jPTNIdOmIZ93RzsbgjSFfvPxr0KBZICwnzlH+RnFhptDy3WQYGWLvI8lBYsL3jS6viFGv
        w6yswJEq2bt+2HjM2LXkImhk9kY7W5M=
From:   David Heidelberg <david@ixit.cz>
To:     Manivannan Sadhasivam <mani@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc:     David Heidelberg <david@ixit.cz>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH v2 2/3] dt-bindings: mailbox: qcom-ipcc: add missing properties into example
Date:   Sun, 24 Apr 2022 15:15:20 +0200
Message-Id: <20220424131522.14185-2-david@ixit.cz>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220424131522.14185-1-david@ixit.cz>
References: <20220424131522.14185-1-david@ixit.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RDNS_DYNAMIC,SPF_HELO_PASS,
        SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These missing required properties are needed for
smp2p binding reference checks.

Misc: adjusted examples properties formatting from dtsi.

Signed-off-by: David Heidelberg <david@ixit.cz>
---
 .../devicetree/bindings/mailbox/qcom-ipcc.yaml        | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/mailbox/qcom-ipcc.yaml b/Documentation/devicetree/bindings/mailbox/qcom-ipcc.yaml
index 866efb278813..d573d555f4c6 100644
--- a/Documentation/devicetree/bindings/mailbox/qcom-ipcc.yaml
+++ b/Documentation/devicetree/bindings/mailbox/qcom-ipcc.yaml
@@ -75,9 +75,14 @@ examples:
 
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

