Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD668587ECF
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 17:14:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237396AbiHBPOg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 11:14:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234433AbiHBPOT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 11:14:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B66417E12;
        Tue,  2 Aug 2022 08:14:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A5C9D60682;
        Tue,  2 Aug 2022 15:14:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04A83C43470;
        Tue,  2 Aug 2022 15:14:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659453257;
        bh=hWf/PttupFOeNrraP/UCkmJULP8/JeCaWQYuByvGBJ4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WsMAAOaNz6It61LU7U0hj9yT6Jep64APeNUprgTkP4sBE6sH2iXKoQPlLgi5QPAgg
         L3YRjT8D6TKyYsPhlDTp9gCpMWOTt+rfAVfQVrKBTwU48lxPycwXcKYgeNf+t0bx5U
         //toRJ0q/OL8TBrgKBfc9EqA5WbE+3RyLsdicjdpBhv39LNIf1Ypx5Qloq8P6JjBUz
         qBghT+50Z+FNYALrbWWltqjTFSdnBH1bbgnLRseSbK337upz4HXhKHpou3VgnNK080
         lnQnw01yN+sMp+ySHAVciPORh69LtKVjN0YF8S7HM+ourkQQYYBHYlngyKlzYxvlyh
         k/4OrrZfqN0hQ==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1oItbM-0000Tc-EW; Tue, 02 Aug 2022 17:14:32 +0200
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
        Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH 5/8] Revert "dt-bindings: usb: dwc3: Add wakeup-source property support"
Date:   Tue,  2 Aug 2022 17:14:01 +0200
Message-Id: <20220802151404.1797-6-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220802151404.1797-1-johan+linaro@kernel.org>
References: <20220802151404.1797-1-johan+linaro@kernel.org>
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

This reverts commit 098c4d43b91a269e89f60331a26a3f3b914677ed.

A devicetree binding should describe hardware capabilities and not be
used to configure power-management policies (even if things are a bit
blurry when it comes to "wakeup-source"). It should also not be used to
work around Linux driver implementation issues such as how to coordinate
the glue and core dwc3 drivers.

For the Qualcomm dwc3 controllers, it is the glue device that manages
the wakeup interrupts, which may or may not be able to wake the system
up from system suspend.

Also note that USB remote wakeup is always enabled during runtime
suspend.

Fixes: 098c4d43b91a ("dt-bindings: usb: dwc3: Add wakeup-source property support")
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 Documentation/devicetree/bindings/usb/snps,dwc3.yaml | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/usb/snps,dwc3.yaml b/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
index 1779d08ba1c0..d41265ba8ce2 100644
--- a/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
+++ b/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
@@ -343,11 +343,6 @@ properties:
       This port is used with the 'usb-role-switch' property  to connect the
       dwc3 to type C connector.
 
-  wakeup-source:
-    $ref: /schemas/types.yaml#/definitions/flag
-    description:
-      Enable USB remote wakeup.
-
 unevaluatedProperties: false
 
 required:
-- 
2.35.1

