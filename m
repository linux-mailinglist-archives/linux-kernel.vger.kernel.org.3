Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54E9452A0F4
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 14:00:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241512AbiEQMAj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 08:00:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343758AbiEQMAN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 08:00:13 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 644554C7BB;
        Tue, 17 May 2022 05:00:07 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id i9so2992394edr.8;
        Tue, 17 May 2022 05:00:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ooYOi4l5nQa47D/Eah2WC+R7MerVr/2GEpfrRHxpbMA=;
        b=Rz+2p3JKDR+LdtBba/c+Ac/6pGd9TQdiVpse9+imTRFwhjQLUkaJ6FGMgxK6wBtGy5
         1XjK03HrIl7K1CN43snO2OZXbKBcDNooi0yZ/QXCYYYhC5S0rrBXXsLPT7J0+78VQRs7
         JDU4xW8daSCst+PYuLHJC2S27xamh7aigmuGENg/zoLQHizilFLVswuBFd7ZmBknm/3i
         mQAWLzgwZG80zYdUxoE1H9fk1xBQOfApCX30spsJXxXYzAIK2zkSGIyFC8nNr3SntpWU
         oxfhmHttqwgIh7pxqCow/J6dIHhsD01C5Q62i3aqczggn1IlW+thFK4E3G3/rDaGX3u2
         NyQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ooYOi4l5nQa47D/Eah2WC+R7MerVr/2GEpfrRHxpbMA=;
        b=fsUnMsAtVIYxuafZ6MBjOF61ahjT/2KRHCoqJ7y42XDMYxIxeKR0Fw/7YyAv+TG/e/
         rPV/YPW14Y14E20kVLwiAcWOOPThgW9GzbIoKdUtXNvPr6aDf2v6QMOwqZ80vx7A0jCR
         IiGKYhj4+DYwwQ+0MYlnCZIqNpCqMAHAkmhzkd2YHwxWTpQDQ71CTXf55hG9ND/dHF3y
         29KRpwXI8d1ACTNUm0+t0Yagaz02ShPSf9eePf5mG6wlCIHWyehMbXLZ5M+zTMXSV03R
         obrwvtHyZhb7KEHDpB31bl1CTE8gzIlBsoT7ykwA0PBUAnWqsV5fU5JDvWWu1xZIn1Gx
         k7lg==
X-Gm-Message-State: AOAM532QuFcLkB63aTdflL5Ht9fAwSAtqpyrE0wQhvrxPZnX3g/dLKo2
        z5V6niNDS4uT4D8uz5VmJL31PAVAMOiWxw==
X-Google-Smtp-Source: ABdhPJxo9vL9nnCYYerUvqY0tYnOcWm/jA8rwxXqEm5mkWDvisQFpPgEq7Dxps/NSmqam2HBYhBsSQ==
X-Received: by 2002:a50:a68e:0:b0:42a:c9ae:469 with SMTP id e14-20020a50a68e000000b0042ac9ae0469mr2199445edc.202.1652788806011;
        Tue, 17 May 2022 05:00:06 -0700 (PDT)
Received: from fedora.robimarko.hr (dh207-98-105.xnet.hr. [88.207.98.105])
        by smtp.googlemail.com with ESMTPSA id hg16-20020a1709072cd000b006f3ef214e20sm948793ejc.134.2022.05.17.05.00.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 May 2022 05:00:05 -0700 (PDT)
From:   Robert Marko <robimarko@gmail.com>
To:     agross@kernel.org, bjorn.andersson@linaro.org, lgirdwood@gmail.com,
        broonie@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Cc:     Robert Marko <robimarko@gmail.com>
Subject: [PATCH v2 3/6] dt-bindings: regulator: qcom,spmi-regulator: add PMP8074 PMIC
Date:   Tue, 17 May 2022 13:59:57 +0200
Message-Id: <20220517120000.71048-3-robimarko@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220517120000.71048-1-robimarko@gmail.com>
References: <20220517120000.71048-1-robimarko@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document the PMP8074 PMIC compatible.

Signed-off-by: Robert Marko <robimarko@gmail.com>
---
 .../devicetree/bindings/regulator/qcom,spmi-regulator.yaml       | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/regulator/qcom,spmi-regulator.yaml b/Documentation/devicetree/bindings/regulator/qcom,spmi-regulator.yaml
index 5c747c832529..4c7c693a48ab 100644
--- a/Documentation/devicetree/bindings/regulator/qcom,spmi-regulator.yaml
+++ b/Documentation/devicetree/bindings/regulator/qcom,spmi-regulator.yaml
@@ -23,6 +23,7 @@ properties:
       - qcom,pm8950-regulators
       - qcom,pm8994-regulators
       - qcom,pmi8994-regulators
+      - qcom,pmp8074-regulators
       - qcom,pms405-regulators
 
   qcom,saw-reg:
-- 
2.36.1

