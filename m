Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48F3A4A5ED0
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 16:02:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239651AbiBAPCN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 10:02:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239634AbiBAPCL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 10:02:11 -0500
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FB30C061714
        for <linux-kernel@vger.kernel.org>; Tue,  1 Feb 2022 07:02:11 -0800 (PST)
Received: by mail-io1-xd2f.google.com with SMTP id p63so20674488iod.11
        for <linux-kernel@vger.kernel.org>; Tue, 01 Feb 2022 07:02:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MLEfOvs0XYTBMi37IYE0nxh2vKRdvGYr4hL4oQxHa8M=;
        b=ytR9ybKf78e9r81Jz1vLmp3ngHBYNuUbyHoXl0+O4rFQB6Vs/4C7C1Ecd9rXJcbbig
         YGojHqXI/UcsZAlFVi6QT0jyJprhWEoJ6mM0GBmachNrlLMrvkuvaaDBJMcnJOtb+MT1
         l/l+UU9EAaIk/tCTmy7F6tUZhTEaJ8+KclYhuj/Xs013OY7RIcrqq6nrmGk0hw4+Evc6
         u7F+0nn+IuRWx+0lSZkx9VQXlzcutd7lJ5T+adOPdCBOQF9tSkOa/D/O5zwX5+h4p3Dw
         noH1d0V7Iv04n5Hh97cQJFj4fs1S7GK59N6L8HHZzcFNI0Uo16GuaDszeSV3e4vl1pDY
         QUdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MLEfOvs0XYTBMi37IYE0nxh2vKRdvGYr4hL4oQxHa8M=;
        b=y4+xEQ6990LIjBiNuI/a7nmZ4e1yjjl2OC4ox+YKFN8dhyLqfKGhygOm7g1belJTfE
         vuW+4pRCXKOb3Xj+Pra/c/PLp9yq5TpY/DMsVC+4+2mjYwnprcvwwfAuACKC1Vi3fJ0J
         F4MoPmH+d5+vxmjrpkW07rdAucPfxe3tKgHINleXSxgG7iYe14nKT5g8FgaDf7JquA4M
         Vvi7ojPPUg4+uZaFarawdT4TDtjaakhbs0ssMleWrcQV3ySmqyoYjfoMxpywyHn88+LZ
         kFV7owGsKOhfJWThsu77QjSjaRIzv7XmlIfKczTRzCmQNkMAWMEydZ6u3FtzO0Be95pq
         5sag==
X-Gm-Message-State: AOAM531m/vyuGTYt6F0fu+bcGxipPQQF+rbM39MyMud1ETMzkxOCwWw/
        PTYbLpcLpkLt86Ft6w1+Rhpynw==
X-Google-Smtp-Source: ABdhPJx88GjpHLi9TGbQVzWh0R/FUwA9VTi13g/mfPQwP/mDrRHrsVDnZ9O+iWUbx3B492hm38AOZA==
X-Received: by 2002:a02:9645:: with SMTP id c63mr12719886jai.260.1643727730766;
        Tue, 01 Feb 2022 07:02:10 -0800 (PST)
Received: from localhost.localdomain (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.gmail.com with ESMTPSA id e17sm19141307ilm.67.2022.02.01.07.02.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Feb 2022 07:02:10 -0800 (PST)
From:   Alex Elder <elder@linaro.org>
To:     robh+dt@kernel.org, davem@davemloft.net, kuba@kernel.org
Cc:     bjorn.andersson@linaro.org, agross@kernel.org, mka@chromium.org,
        evgreen@chromium.org, cpratapa@codeaurora.org,
        avuyyuru@codeaurora.org, jponduru@codeaurora.org,
        subashab@codeaurora.org, elder@kernel.org, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH net v2 1/2] dt-bindings: net: qcom,ipa: add optional qcom,qmp property
Date:   Tue,  1 Feb 2022 09:02:04 -0600
Message-Id: <20220201150205.468403-2-elder@linaro.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220201150205.468403-1-elder@linaro.org>
References: <20220201150205.468403-1-elder@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For some systems, the IPA driver must make a request to ensure that
its registers are retained across power collapse of the IPA hardware.
On such systems, we'll use the existence of the "qcom,qmp" property
as a signal that this request is required.

Signed-off-by: Alex Elder <elder@linaro.org>
---
 Documentation/devicetree/bindings/net/qcom,ipa.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/qcom,ipa.yaml b/Documentation/devicetree/bindings/net/qcom,ipa.yaml
index b86edf67ce626..58ecc62adfaae 100644
--- a/Documentation/devicetree/bindings/net/qcom,ipa.yaml
+++ b/Documentation/devicetree/bindings/net/qcom,ipa.yaml
@@ -107,6 +107,10 @@ properties:
           - const: imem
           - const: config
 
+  qcom,qmp:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description: phandle to the AOSS side-channel message RAM
+
   qcom,smem-states:
     $ref: /schemas/types.yaml#/definitions/phandle-array
     description: State bits used in by the AP to signal the modem.
@@ -222,6 +226,8 @@ examples:
                                      "imem",
                                      "config";
 
+                qcom,qmp = <&aoss_qmp>;
+
                 qcom,smem-states = <&ipa_smp2p_out 0>,
                                    <&ipa_smp2p_out 1>;
                 qcom,smem-state-names = "ipa-clock-enabled-valid",
-- 
2.32.0

