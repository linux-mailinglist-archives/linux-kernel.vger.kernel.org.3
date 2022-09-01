Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29D895A8E19
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 08:14:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233287AbiIAGOM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 02:14:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233058AbiIAGOC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 02:14:02 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12707119C42
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 23:13:55 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id 145so16215469pfw.4
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 23:13:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=quanta-corp-partner-google-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=u2QS6fg72hwaCjD3sPqvtQp+8aS8fo77aTYpyXjXL8Y=;
        b=QYZ39M/brjdmrbBFxHKRM/xw3eqZTzhWWd8GZLQ2ZdqduWz9JSy5FqUhK8PyVfXd22
         x5UvjyR/eTpcJnHQqGCZPI/07E0+KhJ4Jbd7TTNFdBOHMQv3AbLzE/m37K5EaFBTQviQ
         NJtEB6f/XCqv+VL0nWqXeVmIkF+iVaU2mmCaeZdDrLZMHy3G5pZVuvU9KPZcVcSGzW7C
         ucTHomik0CLWA/jdKoA6iWBnHnucuyO27lUpOBW6CWU5XC4Fc3qIpyjsesswsosIEl3u
         IGZlUTZamO+3FHQZMnxpvbDiV3iuOFEV1f8hae5Lf9zVKb7mpvEkxnLPM0DwuBCZNGVB
         8d6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=u2QS6fg72hwaCjD3sPqvtQp+8aS8fo77aTYpyXjXL8Y=;
        b=pYNbmkp29RsAUILpdXo2Yvwx+A1bGnHQ2vgIKjL0hcQzfbHkxQTAtIAe3QoirfDkDD
         xEu5O9p8etyf4kCIWog6DmMaIjoASp3m8C22WM8hacFq7czo8GuJxqyhHKkD3GcE4jn+
         eMgBOBIkk956jFm2McRfNdyTZCxY+iB7yQ8EHcO0nyUNzGE5DlwVRy0os4dbl4F/jRZj
         jRKd7xn6i6DWQLKRe4ors1VfU5nPtAY2eKpYp04zJnXkXaqEe/ur/rttBbs3XKKO2L/j
         Ee/n6DWWRf6dYlpiBTB+hFB7gvywdaFzmtoqL4zvBvb9RaLdqUCRckSo+LIPNKfmkG5I
         nnag==
X-Gm-Message-State: ACgBeo2H1RHx/3Uply4d6B0nVq/b8Ihth0C029+5hM2lrQwhNVY2svE2
        n7i4TRwjZLeotduRMqSWmY1nhIkh7KdQsw==
X-Google-Smtp-Source: AA6agR49J7Y71mPjD7u9FvaoRAz+HMtSv25FhhVXHQ5FVGPKTEGFja0XTTohrXxhlBGO3wfEvgAGow==
X-Received: by 2002:a63:4b5e:0:b0:41d:e04b:4515 with SMTP id k30-20020a634b5e000000b0041de04b4515mr24514182pgl.100.1662012834367;
        Wed, 31 Aug 2022 23:13:54 -0700 (PDT)
Received: from liang-Predator-PH517-52.. (60-250-232-247.hinet-ip.hinet.net. [60.250.232.247])
        by smtp.gmail.com with ESMTPSA id c14-20020a170903234e00b00174e9e14f60sm7016929plh.82.2022.08.31.23.13.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Aug 2022 23:13:54 -0700 (PDT)
From:   Sheng-Liang Pan <sheng-liang.pan@quanta.corp-partner.google.com>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     mka@chromium.org, dianders@chromium.org,
        Sheng-Liang Pan <sheng-liang.pan@quanta.corp-partner.google.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: [PATCH 2/2] dt-bindings: arm: qcom: document sc7280 and evoker board
Date:   Thu,  1 Sep 2022 14:13:35 +0800
Message-Id: <20220901141304.2.Ief93544cd0cbfa412092f5de92de10d59a2a5b3a@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220901061336.61386-1-sheng-liang.pan@quanta.corp-partner.google.com>
References: <20220901061336.61386-1-sheng-liang.pan@quanta.corp-partner.google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds Chromebook Evoker to the yaml.

Signed-off-by: Sheng-Liang Pan <sheng-liang.pan@quanta.corp-partner.google.com>
---

 Documentation/devicetree/bindings/arm/qcom.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
index fb1d00bcc847c..d4b2d947859d4 100644
--- a/Documentation/devicetree/bindings/arm/qcom.yaml
+++ b/Documentation/devicetree/bindings/arm/qcom.yaml
@@ -565,6 +565,11 @@ properties:
           - const: google,piglin
           - const: qcom,sc7280
 
+      - description: Google Evoker (newest rev)
+        items:
+          - const: google,evoker
+          - const: qcom,sc7280
+
       - description: Google Herobrine (newest rev)
         items:
           - const: google,herobrine
-- 
2.34.1

