Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51C7552388E
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 18:18:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344601AbiEKQSE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 12:18:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344526AbiEKQRI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 12:17:08 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A0CD2C65F;
        Wed, 11 May 2022 09:16:58 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id a191so2219705pge.2;
        Wed, 11 May 2022 09:16:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rIh+E3nj4ZucvsTWikm/zNRtjIM6XJcYz1RFNPDBCWk=;
        b=pKe5IPl9JxJ0F28WDZ8Rs7q9M09T1glWF2keFY/yF0wEnuz8uqbnx9145UbAcNZunj
         tRdCXrWDQk1tR0taCF+FvfX3gYJW0jtVtx5t0Iwv9E0u9aflrek1oOkncXLFPhqWWf/3
         8xnwQqxSpSHiteWnjfsTCPhshTxfoUbmlWDHtAXht9D8MjATHdAu5bg9Iknm2cSpLrrz
         hVCciKoiHWb4gDFZFDcCiTd5D67L2dFQ0695jbp1kePc6GBYITLnuZNb2O1pvfRY2ayj
         NpcUGQgcOVSBROYgMefaswyb8GPo3BumkWxKJq86VKaFIjUQvEpIVlhtYgFpY+A+xPen
         8n/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rIh+E3nj4ZucvsTWikm/zNRtjIM6XJcYz1RFNPDBCWk=;
        b=3Qw8ymLi3erKp8V6sOxNa5tlYI5fW1AVDPTMisJ0LPLEk94x503c2E5JQbBVhBmv9M
         JJiSMC/mk57IflEMsDc+O2i9lBG6o9UNNRH+fSGThAXxTyGh18YIs8vyc9IXHJWJNJje
         QiS6fv+cmt2UVcALkgvyS5ECDyy8s8XUTOJ0FWjKjmhA1ZelVvP8xecnsMbxvwXkl9qQ
         MECJx5rJ6Xujl9x0ouvaCzAF2sVbCViqsiscjZ7AifbMKgVbvDMVL5zy8Dv6PEfjfn8i
         jmknsAJgOgKiVDWzG9HKX4rjs4ePwICyfp8vIBoFzz7ozAQVRYRGkpvx9iFHUhFdMznZ
         hvkw==
X-Gm-Message-State: AOAM531Kde+8T9FQBfnvaenEpWgF+AuYtkopD9uQ9FhbgS/UzR9v4Qz/
        DCAnICey2VBTnuZNaQM1d9EjLYnZKJ5mO6fg
X-Google-Smtp-Source: ABdhPJxc44jVyPJPWlqlXL6RS8YDigdvrW2+6zf8UtC0DIAUADXr1EBGHtKbWqWOfQGXKosPHfhf0g==
X-Received: by 2002:a63:9752:0:b0:3c6:5a7a:5bd6 with SMTP id d18-20020a639752000000b003c65a7a5bd6mr19901744pgo.390.1652285817617;
        Wed, 11 May 2022 09:16:57 -0700 (PDT)
Received: from skynet-linux.local ([49.204.239.218])
        by smtp.googlemail.com with ESMTPSA id x7-20020a17090a1f8700b001ded49491basm220322pja.2.2022.05.11.09.16.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 May 2022 09:16:57 -0700 (PDT)
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
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 8/9] dt-bindings: remoteproc: qcom: adsp: Add ADSP on MSM8953
Date:   Wed, 11 May 2022 21:46:01 +0530
Message-Id: <20220511161602.117772-9-sireeshkodali1@gmail.com>
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

Add support for booting the Audio DSP on the MSM8953 platform. This is
used by SoCs like SDM450, SDM625, SDM626, APQ8053, etc. Since the
configuration is the same on all SoCs, a single compatible string is
used.

Signed-off-by: Sireesh Kodali <sireeshkodali1@gmail.com>
---
 Documentation/devicetree/bindings/remoteproc/qcom,adsp.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/remoteproc/qcom,adsp.yaml b/Documentation/devicetree/bindings/remoteproc/qcom,adsp.yaml
index a4409c398193..0e70e49b4e53 100644
--- a/Documentation/devicetree/bindings/remoteproc/qcom,adsp.yaml
+++ b/Documentation/devicetree/bindings/remoteproc/qcom,adsp.yaml
@@ -17,6 +17,7 @@ properties:
   compatible:
     enum:
       - qcom,msm8974-adsp-pil
+      - qcom,msm8953-adsp-pil
       - qcom,msm8996-adsp-pil
       - qcom,msm8996-slpi-pil
       - qcom,msm8998-adsp-pas
@@ -160,6 +161,7 @@ allOf:
           contains:
             enum:
               - qcom,msm8974-adsp-pil
+              - qcom,msm8953-adsp-pil
               - qcom,msm8996-adsp-pil
               - qcom,msm8996-slpi-pil
               - qcom,msm8998-adsp-pas
@@ -275,6 +277,7 @@ allOf:
           contains:
             enum:
               - qcom,msm8974-adsp-pil
+              - qcom,msm8953-adsp-pil
               - qcom,msm8996-adsp-pil
               - qcom,msm8996-slpi-pil
               - qcom,msm8998-adsp-pas
@@ -364,6 +367,7 @@ allOf:
         compatible:
           contains:
             enum:
+              - qcom,msm8953-adsp-pil
               - qcom,msm8996-adsp-pil
               - qcom,msm8998-adsp-pas
     then:
@@ -547,6 +551,7 @@ allOf:
           contains:
             enum:
               - qcom,msm8974-adsp-pil
+              - qcom,msm8953-adsp-pil
               - qcom,msm8996-adsp-pil
               - qcom,msm8996-slpi-pil
               - qcom,msm8998-adsp-pas
-- 
2.36.0

