Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7649D523872
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 18:17:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344561AbiEKQQw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 12:16:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344524AbiEKQQl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 12:16:41 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60A21289B0;
        Wed, 11 May 2022 09:16:41 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id l20-20020a17090a409400b001dd2a9d555bso2547978pjg.0;
        Wed, 11 May 2022 09:16:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QspKJ7xS9nMjXQDdB9sl+PR92lMjE5l6tz6HCa/X19M=;
        b=L8BTlzbq3h80jRyTNdtMJQFUl863m2DcWr6Ml3fI/ukeWa2rXcVeJ90F847VqjVEnh
         ljbIpi1JC/y2ZD+bRduwSKk0P89Il2XVXYWlX9uAhjdP/I2Sjet/MaUBBfRghLJKoZ9A
         MZovwEJLRrkFlAlA4ITFQl+k9NliFqmD+e+fNjMSWmx8dUji4rkE8Y/7CeZyGMEbWytw
         sYXaxmPu0r8iYZ6QeIqTXWvWD/v4yiVeF1JOUptZ2ZPoCByyIeoE38IhRHq8Y6GjmngY
         rHS5HtiS6N303zVHE6oT5HPgin4MR3I1QsN1xsh20ZftGzQrAN2Uy3uV2r5rCrijrBtE
         ZAHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QspKJ7xS9nMjXQDdB9sl+PR92lMjE5l6tz6HCa/X19M=;
        b=0LDvQzjkcSKDnKs9pQNzEpzABmNoLCez20xf00xFURWu3j/MJhZu5yk48UcWi4nwB+
         NwSsplCTqtRHqTf9Qlw9c2O7nUvf5yem/VmJWOv2+D7Lbf01dPcO4csFnuPLd92IGRjW
         YKMtKMALTq2nIHeQKT4Pt9nuetz0d4O2OAH5yhJ9PqJibujxMAdteG1gbWYVt+MaNznb
         lUYjxKAcS+o6svloDrgG8YDRBwxV699hitlqRQrHS+PodBYwAPGTu5q7wDuE8thI1360
         VnOa8zEyfOg4Dbro0WvzvivZfwYMgmnqJ0C7uKJo/5enl76VgNPOfrYMSlchu4v1vQQv
         jD0g==
X-Gm-Message-State: AOAM531TWzn7xiqDQI2xSu7IfzLMEIj0VzB8aiU8Kxp4HI+J01DPvkNV
        pDGkH1D+k7LvJ0oe43Vdh7P/fuIAj2U64Y9f
X-Google-Smtp-Source: ABdhPJw2FnVkiIQCYaV3Cxgsel5YXB2aKTEFlJin3pjYuIdhpltlbkyYFiXCXRr1/vvI+yi47nbRkA==
X-Received: by 2002:a17:90b:1945:b0:1dc:69bc:69f with SMTP id nk5-20020a17090b194500b001dc69bc069fmr6044764pjb.217.1652285800648;
        Wed, 11 May 2022 09:16:40 -0700 (PDT)
Received: from skynet-linux.local ([49.204.239.218])
        by smtp.googlemail.com with ESMTPSA id x7-20020a17090a1f8700b001ded49491basm220322pja.2.2022.05.11.09.16.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 May 2022 09:16:40 -0700 (PDT)
From:   Sireesh Kodali <sireeshkodali1@gmail.com>
To:     linux-remoteproc@vger.kernel.org
Cc:     linux-arm-msm@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, bjorn.andersson@linaro.org,
        devicetree@vger.kernel.org, phone-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Sireesh Kodali <sireeshkodali1@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Subject: [PATCH 5/9] dt-bindings: remoteproc: qcom: wcnss: Add compatible for pronto v3
Date:   Wed, 11 May 2022 21:45:58 +0530
Message-Id: <20220511161602.117772-6-sireeshkodali1@gmail.com>
X-Mailer: git-send-email 2.36.0
In-Reply-To: <20220511161602.117772-1-sireeshkodali1@gmail.com>
References: <20220511161602.117772-1-sireeshkodali1@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pronto v3 remoteproc is similar to pronto v2. It is found on the
MSM8953 platform, which is used by SDM450, SDM625, SDM626, APQ8053 and
other SoCs. Since the configuration is same on all SoCs, a single
compatible is used.

Signed-off-by: Sireesh Kodali <sireeshkodali1@gmail.com>
---
 .../devicetree/bindings/remoteproc/qcom,wcnss-pil.yaml      | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/remoteproc/qcom,wcnss-pil.yaml b/Documentation/devicetree/bindings/remoteproc/qcom,wcnss-pil.yaml
index d19f9f87a3e3..89bef16f153d 100644
--- a/Documentation/devicetree/bindings/remoteproc/qcom,wcnss-pil.yaml
+++ b/Documentation/devicetree/bindings/remoteproc/qcom,wcnss-pil.yaml
@@ -26,6 +26,7 @@ properties:
               - qcom,riva-pil
               - qcom,pronto-v1-pil
               - qcom,pronto-v2-pil
+              - qcom,pronto-v3-pil
 
   reg:
     description: must specify the base address and size of the CCU, DXE and PMU
@@ -143,15 +144,16 @@ if:
         enum:
           - qcom,pronto-v1-pil
           - qcom,pronto-v2-pil
+          - qcom,pronto-v3-pil
 then:
   properties:
     vddmx-supply:
       deprecated: true
-      description: Deprecated for qcom,pronto-v1/2-pil
+      description: Deprecated for qcom,pronto-v1/2/3-pil
 
     vddcx-supply:
       deprecated: true
-      description: Deprecated for qcom,pronto-v1/2-pil
+      description: Deprecated for qcom,pronto-v1/2/3-pil
 
   required:
     - power-domains
-- 
2.36.0

