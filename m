Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8DE55AA905
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 09:43:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235445AbiIBHnF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 03:43:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232913AbiIBHnA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 03:43:00 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E50C5B5311
        for <linux-kernel@vger.kernel.org>; Fri,  2 Sep 2022 00:42:58 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id l65so1110180pfl.8
        for <linux-kernel@vger.kernel.org>; Fri, 02 Sep 2022 00:42:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=quanta-corp-partner-google-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=5sF7F1cYmydcaLvnoRnoDfV+9V05QJMlsu+o2biJ3Ik=;
        b=7+dx4KKhOBQoVBh+v8ezLG0jR7SZxOqPY2gkn0us8sEySuVhHCIk0jH1D5Smdv9rW0
         oVkatCp51Di8T/KE2SpRG0ag8RNT4Zoi3gZyyLvTeM1edCc5nBgWnaZpUgjNa4cx7Qwf
         mPJwO8BZ8jXe6faD55PbE505Z87dw40FdAUqClC90PlfB7O67U5Hzp5u5vEXcXvcsKDb
         p4/GG+FgNrqmtfVk8jBobvcmUoVsp3HFAVNlm8qbMAjED5pGbWjZQQf7XNJPHgeY8Ytf
         j3WEbzfTP5K3oYhrBWg1VHsRUiTg5+5eRYViX8ip+/L1APNJq8b0lzbVCDQPIzJAcVs5
         x0AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=5sF7F1cYmydcaLvnoRnoDfV+9V05QJMlsu+o2biJ3Ik=;
        b=waWOJHH9iiT5CMkaQaaX/TOcyoYLod86RhmkSNUvIYi1IXZ8bjuOA760geIYafVy+n
         VzFDAg7MLmW6WjRNODBEJoUIcQvcs3xetp5RYWH6XwgOr1ZdrqEMj9GJBZ22I3EaHMb0
         wfl0qihroDthf05jqBjQDxiQp8paNKbsScqMt2c5thGOGM9PjAJNbJSaMC5oJ4mVGj8j
         ZzzWUMPhmTxk6qqqKCvAKLtKJTkagJPuiQx5gS9SCrW5AW9gDYDzEmroS7Yccla2vYIi
         LjwTJTu0k/0WmwT8X6iTCCqUIP/4i9Qjc2gukHHi6z7vFMpyTPG2Oefw2jFOmvzqnsrF
         5xwg==
X-Gm-Message-State: ACgBeo1Z4cdIt9vt9q/B0MJfFaUMk0KxFDuH5MaaMSg+j+M2KvY7otMy
        0VEetoh8cwlz0F33onyJXc3wZaSEkYiJnw==
X-Google-Smtp-Source: AA6agR4uCjBk9ALADnx7LRBCPpfM6s+szcF5fuTQY1bAwaw56gD71EyFnnq2y/chFCDG7ofRvdr1uQ==
X-Received: by 2002:a65:5941:0:b0:41d:a203:c043 with SMTP id g1-20020a655941000000b0041da203c043mr28974719pgu.483.1662104577677;
        Fri, 02 Sep 2022 00:42:57 -0700 (PDT)
Received: from liang-Predator-PH517-52.. (60-250-232-247.hinet-ip.hinet.net. [60.250.232.247])
        by smtp.gmail.com with ESMTPSA id f21-20020aa79695000000b005363abb6d0bsm975099pfk.15.2022.09.02.00.42.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Sep 2022 00:42:57 -0700 (PDT)
From:   Sheng-Liang Pan <sheng-liang.pan@quanta.corp-partner.google.com>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     dianders@chromium.org, mka@chromium.org,
        Sheng-Liang Pan <sheng-liang.pan@quanta.corp-partner.google.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: [PATCH 1/2] dt-bindings: arm: qcom: document sc7280 and evoker board
Date:   Fri,  2 Sep 2022 15:42:39 +0800
Message-Id: <20220902153441.1.Ief93544cd0cbfa412092f5de92de10d59a2a5b3a@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220902074240.117075-1-sheng-liang.pan@quanta.corp-partner.google.com>
References: <20220902074240.117075-1-sheng-liang.pan@quanta.corp-partner.google.com>
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

Changes in v4:
- Got the version number correct

Changes in v2:
- Bindings patch added

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

