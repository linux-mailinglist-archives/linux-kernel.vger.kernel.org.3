Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 009C2589E67
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 17:10:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240192AbiHDPKw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 11:10:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239029AbiHDPKD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 11:10:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6247E5E308;
        Thu,  4 Aug 2022 08:09:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 968526106C;
        Thu,  4 Aug 2022 15:09:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A548C41679;
        Thu,  4 Aug 2022 15:09:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659625795;
        bh=IO2m3x1jImWrsxZYiJ2BMxGUrpa2LxovXjBMsp4YmCo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QanGkkS4xs9guEML3UUpdfeTWuhqiyq1gKgwPxX0liM7aZuxQKXtTSxuFlR5aBUBU
         2JLwKWrkuUxAAMKOH8mLsuGPQ2eYFH7zIT54cDycwqHzjYQXB9rQGG092mY+o0g9AU
         U0WYe8pYX45Z+mxM25zX5lxAhBml0q91KPnohgt+OUYOPCvTLUZjZpKzY7oyRyV5j0
         gVlz7IJJkIhOLCUA1lNgtFbVqIR4XdCK8+Sy2DiNUV18khQlQ8oRrhbTTw+rCTyCjl
         AIulqYUjJl1RC84pkMhtDJTD0Am4w+NNQgswzBDGUw8NOo1nIxzKGCAvRTWac5j6EZ
         ovUq+BCe8ycVQ==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1oJcUL-00069c-CT; Thu, 04 Aug 2022 17:10:17 +0200
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Felipe Balbi <balbi@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Krishna Kurapati <quic_kriskura@quicinc.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Doug Anderson <dianders@chromium.org>,
        "Matthias Kaehlcke" <mka@chromium.org>,
        Pavankumar Kondeti <quic_pkondeti@quicinc.com>,
        quic_ppratap@quicinc.com, quic_vpulyala@quicinc.com,
        linux-arm-msm@vger.kernel.org, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v2 7/9] dt-bindings: usb: qcom,dwc3: add wakeup-source property
Date:   Thu,  4 Aug 2022 17:09:59 +0200
Message-Id: <20220804151001.23612-8-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220804151001.23612-1-johan+linaro@kernel.org>
References: <20220804151001.23612-1-johan+linaro@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a wakeup-source property to the binding to describe whether the
wakeup interrupts can wake the system from suspend.

Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---

Changes in v2
 - disallow 'wakeup-source' in child node (Krzysztof)

 Documentation/devicetree/bindings/usb/qcom,dwc3.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/usb/qcom,dwc3.yaml b/Documentation/devicetree/bindings/usb/qcom,dwc3.yaml
index fea3e7092ace..d5959bdea63e 100644
--- a/Documentation/devicetree/bindings/usb/qcom,dwc3.yaml
+++ b/Documentation/devicetree/bindings/usb/qcom,dwc3.yaml
@@ -108,12 +108,17 @@ properties:
       HS/FS/LS modes are supported.
     type: boolean
 
+  wakeup-source: true
+
 # Required child node:
 
 patternProperties:
   "^usb@[0-9a-f]+$":
     $ref: snps,dwc3.yaml#
 
+    properties:
+      wakeup-source: false
+
 required:
   - compatible
   - reg
-- 
2.35.1

