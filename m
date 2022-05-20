Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60CF452EC2F
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 14:33:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349347AbiETMd2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 08:33:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349313AbiETMdE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 08:33:04 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10ED6163F63
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 05:33:03 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id l13so7407125lfp.11
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 05:33:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MUfpYM4VmS1R+1NDhvJz7pPXB5CM1cLHG7yxQvCsNVc=;
        b=WZ850odhLPTluXPNOhp3oI8Rcp3RoJhpI3ZiGuWJIUQhgOKGEjn2KI7IEtO8nBiWUn
         d4fg09AMECFWWL1HTdwnNF2nCpfQqMQbzVO8FDUMuvYGqGgoZePRoP/AsqyQ60MupXPX
         AFigzSAJ1WtV+lZXZTtROlL/ykzv+Aj05x7bbXsZkIME1vQQN1sIFjgae7cUwD5u9wCP
         Eocz4zYqA8kC88yNssOGHym0rG6FbO73iT1HQZYagzeWRGvAN2tpsjHM14EIT0mV46uf
         rQqzykk1WbjHuzl225sBNRvg6itJKErQ/mpOZloubTfxln+M9WporvAT5ROj8jDjn0pC
         3M5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MUfpYM4VmS1R+1NDhvJz7pPXB5CM1cLHG7yxQvCsNVc=;
        b=lJC57YtAsu/yjidNIDwRJ4SpES3JJ7O5hyyXErh+WB6oWXUKQpYqTf/TOFIeFss5Td
         769OTyZRWxz0OgPim+HX7rted3bM49vmSuQSxaC9LtOA2uJ6bucTM8/uRLh1J141xtjU
         QX0OQxIimemK6bCIsqz1rvjrDD8VwzL3Ui6zdGBOKWyspdcBQXdtRX8tBKImbaBpRLvE
         e4p7M1o2AioI5Z1FvBCqd4CFTLVJR9lnxt9KpSrqBIngGFAFMpkXPlTmv+9YND2nPCEZ
         CxvxYPnBnx72UbUHayhqxASWstk2ZFOJ74ZUC8oOPH7oPDZvnCrJelTpdbl3hSKutMLt
         0ExQ==
X-Gm-Message-State: AOAM532LLZo9EzA9jh6Bck2tTdnaatTfUbuqXd+yhUJYmXKgi/l7zQAu
        sxg6/ftuIkCgC54XWezGruFnSg==
X-Google-Smtp-Source: ABdhPJwH/VBqgDR3cuPxXemZpD+Ep7SJet8ZXgKR5MYnS392i+V1jeppE3lDr83IAWMsxMNcg99KhA==
X-Received: by 2002:a05:6512:3f1a:b0:477:8ecd:368c with SMTP id y26-20020a0565123f1a00b004778ecd368cmr6772401lfa.403.1653049981393;
        Fri, 20 May 2022 05:33:01 -0700 (PDT)
Received: from krzk-bin.. (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id a14-20020a056512374e00b0047255d211bfsm643973lfs.238.2022.05.20.05.33.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 May 2022 05:33:00 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Vinod Koul <vkoul@kernel.org>,
        Stephan Gerhold <stephan@gerhold.net>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 5/9] dt-bindings: arm: qcom: add missing MSM8916 board compatibles
Date:   Fri, 20 May 2022 14:32:48 +0200
Message-Id: <20220520123252.365762-5-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220520123252.365762-1-krzysztof.kozlowski@linaro.org>
References: <20220520123252.365762-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document several board compatibles already present in Linux kernel.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/arm/qcom.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
index 88759f8a3049..71d857dcf6b6 100644
--- a/Documentation/devicetree/bindings/arm/qcom.yaml
+++ b/Documentation/devicetree/bindings/arm/qcom.yaml
@@ -160,8 +160,14 @@ properties:
       - items:
           - enum:
               - alcatel,idol347
+              - asus,z00l
+              - huawei,g7
+              - longcheer,l8910
               - samsung,a3u-eur
               - samsung,a5u-eur
+              - samsung,j5
+              - samsung,serranove
+              - wingtech,wt88047
           - const: qcom,msm8916
 
       - items:
-- 
2.32.0

