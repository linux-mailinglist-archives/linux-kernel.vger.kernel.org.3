Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E8E95A5E60
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 10:42:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231644AbiH3ImY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 04:42:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231235AbiH3ImW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 04:42:22 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F14A2CD799
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 01:42:19 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id v5so4221791plo.9
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 01:42:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ecs-corp-partner-google-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:subject:cc:to:from:from:to:cc;
        bh=kcIm0U0ucDYNF4GdKdc+KO2BzaJqo9jU7lP+5SuHRBY=;
        b=qoxy961B0zYqNbaFQEC5mzrpoVbAtKALWh5r+G+3JbyBt9gNG88DCYvmM7EAmSx845
         dmWajuT2i7+xKMhMyuoazbG0RwFR6+xNfXICPJ7DCzwQ5BHgtSjpzl8/slwdJav4hz8f
         EaV/Gv7+uc/YTO3SaT82UP5Rt3rAmvBT0dzTTI/A8jpNGITxUSLTsQlYJ/09d3O6s29h
         SsIEbH//NyIc3VUjRUzqU8Xsv3FTZg/7GFV2cjeXhVHEtAPlOMk/KvSwWYxs30kA3YIp
         ij7CYnmIxj1Pxg/Irh7Ke5wmu7YO3J/HVnT+9wptuyKtvu7wNUdJ9AaresP3bYVFUYzC
         jb+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=kcIm0U0ucDYNF4GdKdc+KO2BzaJqo9jU7lP+5SuHRBY=;
        b=4TFNWj7Kh2VYl/9JBuiMKSai8VegRwRceghOmDwXp0t2quLCfJYIbdNr1FM34pvDXd
         GL6pprt1pUNzll53Qjn5lnRXBc7irJ68M46wrTxP35zhWSSpigK5R+l8KrLB5ENsYOdM
         Byb2skyPYM4/u4SvuP458/0c3Siepd1JBv4BQcxmcPgD+DsqwMqW+LFsXrgJ+drgy8Pn
         9cYsBpbE7eO2oXbS4XfuujPzQxbX8NrXKHfdraeSzyEDndC+OqsO09HwAskAhILCnuIH
         K3X6GRu6IrVnrltNwGj1NHPNjLTwfNvf6R/hFx9jVhUh1mXz6SUPN6/CxQuJhAPcZ5at
         i1ww==
X-Gm-Message-State: ACgBeo1kr4jUQ9QlugPUoeJMf4qFbG5gfSTHE8/Y6SaJiF+XIuAAScRE
        l+K1fk80HNf0XvvaLcgdEFLmuiQOZaGMBspp
X-Google-Smtp-Source: AA6agR6pfUb4rXR4hGs5O70w+hwbCYSYVzWmWB7cM3Bllbcb+Zz0cM0H+qFug4ibSfxc43PbwKY7Kw==
X-Received: by 2002:a17:903:2411:b0:172:ba7e:e54d with SMTP id e17-20020a170903241100b00172ba7ee54dmr20562426plo.165.1661848939195;
        Tue, 30 Aug 2022 01:42:19 -0700 (PDT)
Received: from localhost.localdomain ([103.150.184.130])
        by smtp.gmail.com with ESMTPSA id r21-20020a170902e3d500b0016d1f6d1b99sm4810331ple.49.2022.08.30.01.42.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Aug 2022 01:42:18 -0700 (PDT)
From:   Yunlong Jia <yunlong.jia@ecs.corp-partner.google.com>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Henry Sun <henrysun@google.com>,
        Douglas Anderson <dianders@chromium.org>,
        Bob Moragues <moragues@chromium.org>,
        Yunlong Jia <yunlong.jia@ecs.corp-partner.google.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: [PATCH v2 1/2] dt-bindings: arm: qcom: Document additional skus for sc7180 pazquel360
Date:   Tue, 30 Aug 2022 08:42:10 +0000
Message-Id: <20220830083740.v2.1.Ic4d4e0777115011544dbc2ab07ed4d7b408c003a@changeid>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
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
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Douglas Anderson <dianders@chromium.org>
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

