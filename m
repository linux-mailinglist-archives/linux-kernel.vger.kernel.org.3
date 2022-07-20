Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 883E957B1DD
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 09:38:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240025AbiGTHi1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 03:38:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237710AbiGTHiZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 03:38:25 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9127762484
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 00:38:24 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id o12so15810368pfp.5
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 00:38:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ecs-corp-partner-google-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=Xc6fgEvmDOLfBjoXIj0m1oyh4sYver0cQuxKyhaoxJM=;
        b=EM3raoSZqNAjsRgHvZ0SU1ze7cgNCDQhvSAlUHFHiki6V7TymxfB2xJX21OA1+Dx/N
         TK5N2I5Qg8gPZcRkasQk66SAnwHpOGwa5ZOEijnsNUM69PHPe0mmIwScg2W4w+1L3zT8
         pGLqqxZAKYEMtdtSFE1A90nk+eGvlfx7TMV/ruIq4581zOjb8n0+oZjQ1XZwoq5mcRRm
         Ke1OU9leiWGyo5ndLh7Nooco2Uu1nNxK+K+YmsWgRRWmDLPi4rwSAj0TrsJibxYwulRi
         vbeI/8O10trz90ZnzunPmJ5UNasNuScp+N9rbKI3IiorRjLpHNymd3x61gThDUGqpgYH
         WnzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Xc6fgEvmDOLfBjoXIj0m1oyh4sYver0cQuxKyhaoxJM=;
        b=pNz8dFZCdUEGkH1HtKckncnZLHpxBcwLn0ng18cNM+raftzNJ1Kqjpr0OnNmyXYXke
         te9Ca7TXkZ4WePdzeukshBl5cvsSs2qx6zidQyOP2vW19Q2cQd3y82erAC7ZBGVnrcPd
         +ljP5yBU+KMCM9QQmAU+zLGIOkmzB2csyl+DFBtAueQm4kjSKxf+mTf/umjlDKM4VXPe
         hKV6Ki2yMCNB7OREzrfqS9L4zsIKDJ2pe+Hjh6cHs1h7Jv59py2Rb2e+hyluXzu2kjsZ
         jJQ329y3mYqtZPNqkkwIBzAzjB+cjHaaA3C4rYGUFbJaCZvpRqDlzZxn4jEP+Q/sCkmO
         tpwg==
X-Gm-Message-State: AJIora9Iw/I6iuOR2g1Y0Iq9m+o0ieGg2dB50q7bMRhcL3Qe7V/vW5av
        mpTz5+VnFRxb/P1dROx4FFCG/qPcUajy2SbM
X-Google-Smtp-Source: AGRyM1uit8I0cHYFIviOVNQ8VWwD3Ep/WPdp05cI6kC1jOq2rPP7+nZ99LB3y8C760QG7rY0ucwQEw==
X-Received: by 2002:a05:6a00:1745:b0:52a:f0d3:ae7 with SMTP id j5-20020a056a00174500b0052af0d30ae7mr38283892pfc.72.1658302703844;
        Wed, 20 Jul 2022 00:38:23 -0700 (PDT)
Received: from localhost.localdomain ([103.104.171.43])
        by smtp.gmail.com with ESMTPSA id u5-20020a655c05000000b0041296135280sm11216243pgr.88.2022.07.20.00.38.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jul 2022 00:38:23 -0700 (PDT)
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
Subject: [PATCH] dt-bindings: arm: qcom: Document additional sku6 for sc7180 pazquel
Date:   Wed, 20 Jul 2022 07:38:16 +0000
Message-Id: <20220720073755.1.Ifab936517646b3876dd31b6e9b1b58a858529e57@changeid>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The difference between sku6 and sku4 is that there is no esim

Signed-off-by: Yunlong Jia <yunlong.jia@ecs.corp-partner.google.com>
---

 Documentation/devicetree/bindings/arm/qcom.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
index 4dd18fbf20b6..aebeefdab27f 100644
--- a/Documentation/devicetree/bindings/arm/qcom.yaml
+++ b/Documentation/devicetree/bindings/arm/qcom.yaml
@@ -410,6 +410,7 @@ properties:
       - description: Google Pazquel with LTE and Parade (newest rev)
         items:
           - const: google,pazquel-sku4
+          - const: google,pazquel-sku6
           - const: qcom,sc7180
 
       - description: Google Pazquel with LTE and TI (newest rev)
-- 
2.17.1

