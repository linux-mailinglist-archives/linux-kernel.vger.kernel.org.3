Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 393E05A415F
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 05:11:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229885AbiH2DLA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Aug 2022 23:11:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229901AbiH2DKT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Aug 2022 23:10:19 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F12AAB9E
        for <linux-kernel@vger.kernel.org>; Sun, 28 Aug 2022 20:09:45 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id t11-20020a17090a510b00b001fac77e9d1fso13268559pjh.5
        for <linux-kernel@vger.kernel.org>; Sun, 28 Aug 2022 20:09:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ecs-corp-partner-google-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:subject:cc:to:from:from:to:cc;
        bh=W8Ym8mQow90BQQ8Mf7QZvEWAQJcUQ3PX8wevLLTVapE=;
        b=gANEPE6ZqSWW8zjOyo738l9oQA94vC7PKDKygUAxwMkd5WrmwonZzYOz0NWZ62iMFn
         uaH3MdLT0ARwV5+2okEuAK68iBcbHsvNyybsCJvR6ZxWzsNJUhdU3PlGkdBjLP0dUwtN
         vWuYI9GDdUbQ8M8sLLhpPdoyfeDylCdOw/4cMgMCGRVrkLX0oAAMdau7hdoGpaSHoSoR
         86tI/MfBOppUbwU6hZQjjSmt/EfhJmKi1aw2AlQtrY+5DX0gqs6rivMVshlNhBacTsGt
         GkVuCWuoHDsUXDJeHE8WMqV2NsOEQ7OZVloyFkmUuQATSiVksJB6ar+gaINBL8kWH2A6
         Q2bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=W8Ym8mQow90BQQ8Mf7QZvEWAQJcUQ3PX8wevLLTVapE=;
        b=FFVbJmaMBf/bNYUndqu+Mih4WzH0Hcvk5AQ98kZwsrpMUSdl4JMxO9J8dcJyaRl8y/
         /oS4+q223c/OiSGvT+7cxwf9AkndL/TO8IzjJ4OOmHLv8tXukIhCcFfN2hg/XP4htRR+
         v0ILAQhQ7QeCrd7SjZuRdU5VgO7+olqng8dhrhiVIPw2X9gwGekJV0mT20qveM31Sou4
         IxZ2HMmbgWEthIGZ7ylPEFi58316SVV/mIKJnYx2sLIaJTArnNLllO8k5kh5rW9J5wQs
         HE0a7u7pLfRkxEworSsOCvpIT0owrPmIkqdpHMwPRFvOzQJQ3fy73dDgmEpScJ3BNbVU
         5zjw==
X-Gm-Message-State: ACgBeo3NQm5HXwmg6spl6xpwZyR0Ob1VxdXXkZibWh/B/begJPBMMfau
        O2Ygk7Wzs0iWbgXtv2WsYhIIf7i0I+vgrm87AY8=
X-Google-Smtp-Source: AA6agR4/iA8k5zMn1ZIWXCFS+YFlaPy/iPdRhabzRqEJn9UYvQDL41n0caWVhI/VLl+BjVoECcKs9w==
X-Received: by 2002:a17:90b:4d12:b0:1f7:a6d1:24c1 with SMTP id mw18-20020a17090b4d1200b001f7a6d124c1mr16080999pjb.15.1661742584916;
        Sun, 28 Aug 2022 20:09:44 -0700 (PDT)
Received: from localhost.localdomain ([103.104.171.43])
        by smtp.gmail.com with ESMTPSA id 18-20020a621412000000b0053725e331a1sm5934991pfu.82.2022.08.28.20.09.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Aug 2022 20:09:44 -0700 (PDT)
From:   Yunlong Jia <yunlong.jia@ecs.corp-partner.google.com>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Douglas Anderson <dianders@chromium.org>,
        Henry Sun <henrysun@google.com>,
        Bob Moragues <moragues@chromium.org>,
        Yunlong Jia <yunlong.jia@ecs.corp-partner.google.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: [PATCH v2 1/2] dt-bindings: arm: qcom: Document additional skus for sc7180 pazquel360
Date:   Mon, 29 Aug 2022 03:09:29 +0000
Message-Id: <20220829030823.v2.1.If97ef7a7d84bcc2cf20e0479b3e00c4a8fb5a2fd@changeid>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pazquel360 is an extension project based on pazquel.
We create 3 sku on pazquel360:
   sku 20 for LTE with physical SIM _and_ eSIM and WiFi
   sku 21 for WiFi only
   sku 22 for LTE with only a physical SIM
 Both sku20 and sku22 are LTE SKUs.
 One has the eSIM stuffed and one doesn't.
 There is a single shared device tree for the two.

Signed-off-by: Yunlong Jia <yunlong.jia@ecs.corp-partner.google.com>

---

(no changes since v1)

 Documentation/devicetree/bindings/arm/qcom.yaml | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
index fb1d00bcc847..851cf5edb582 100644
--- a/Documentation/devicetree/bindings/arm/qcom.yaml
+++ b/Documentation/devicetree/bindings/arm/qcom.yaml
@@ -459,6 +459,17 @@ properties:
           - const: google,pazquel-sku2
           - const: qcom,sc7180
 
+      - description: Google Pazquel360 with LTE (newest rev)
+        items:
+          - const: google,pazquel-sku22
+          - const: google,pazquel-sku20
+          - const: qcom,sc7180
+
+      - description: Google Pazquel360 with WiFi (newest rev)
+        items:
+          - const: google,pazquel-sku21
+          - const: qcom,sc7180
+
       - description: Sharp Dynabook Chromebook C1 (rev1)
         items:
           - const: google,pompom-rev1
-- 
2.17.1

