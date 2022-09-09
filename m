Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E64C5B2D27
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 05:57:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230439AbiIIDz3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 23:55:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230389AbiIIDzI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 23:55:08 -0400
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2FC431357;
        Thu,  8 Sep 2022 20:54:59 -0700 (PDT)
Received: by mail-il1-x130.google.com with SMTP id r7so212083ile.11;
        Thu, 08 Sep 2022 20:54:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=+MQNvWQ+PVJjCkicVnR1j0Hyh5GGHnF4hORpjLJ0L60=;
        b=HYhAsP5NIQVVMkyTvBdCMqAys3Jru6If5QOF52pFF76su5k5YzMyHuZeq45jOWuUJm
         fNsKPbj29BK/6F3YsDiqa8DpJNJs5uRE3i5MJcT00AK04SNVuo4Brx4s0PAtaXkk+2n2
         CxOnMwEK9f8mPBnQ3a6lTLe6oQCDxqDP+rHZqnaMdDVG5tEL7uQGS5NbfthI0y0Zz9rs
         STETWo+x9wbKtkqLXtcMZ6K6Fn1CQRfcHz8CEx9++HbbCWpzc9gBocO8yUxbNDPLWGgY
         yg6YaFBQML488nfrd8hag8OXQqo7bWM4OxEpgURX6Kz2s6Z8oRMjsQnfY2MbRG/nB6yO
         PWNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=+MQNvWQ+PVJjCkicVnR1j0Hyh5GGHnF4hORpjLJ0L60=;
        b=uIDvw0tmRZF798ci+Ek8lk2BTE1JOX36sOlbbD/LP9mAdUTsWMsRwJWtXj7W93kJuD
         TXNqvCtWx9FYd/dtULGi9J2FKS4KECFMlutyg8Wq3ORmvgDw/wUnPYlA9N0+XXkwvPrt
         iJr6EqIOMY5yvMPBLNdgrZsfLUjbewluUms4XM1Ii5yWsyDdBslDYwK0WBSOdCgcLuoM
         3G8pGatiQJiyPfF36CUWxEAoFxHuTHaE7g50GDnlhi3qxPhrQkxa3URQ2AHvLcuu9bD6
         hzZy1mOhwJO6IITtuxuAU3oGPFSoWBvtPBwf3V1fsa8Ycoe1xeOIrETEd3VL1rfDz2B2
         p/DA==
X-Gm-Message-State: ACgBeo0HVnQigkdZHcnbwmWtGOhTZuLVKOpGaocegVY81NIzj+ICVuo3
        0CmtdQIxF85xkt0YjNmTEwcHoUm/AV60fQ==
X-Google-Smtp-Source: AA6agR6hS3PZXwqr4cYpMVfaNYxtT1KD60j8i79leCbaPdQlczoqmkK2VedZ0Zw79qUS1ONev+Rh8A==
X-Received: by 2002:a05:6e02:198f:b0:2ef:7132:6ace with SMTP id g15-20020a056e02198f00b002ef71326acemr3431681ilf.148.1662695698212;
        Thu, 08 Sep 2022 20:54:58 -0700 (PDT)
Received: from fedora.. ([2604:2d80:4d8e:a000:6063:7cd5:2f24:16a6])
        by smtp.gmail.com with ESMTPSA id n28-20020a02715c000000b00346b4b25252sm330579jaf.13.2022.09.08.20.54.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Sep 2022 20:54:57 -0700 (PDT)
From:   Joel Selvaraj <joelselvaraj.oss@gmail.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Joel Selvaraj <joelselvaraj.oss@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v5 2/3] dt-bindings: arm: qcom: Add Xiaomi Poco F1 EBBG variant bindings
Date:   Thu,  8 Sep 2022 22:54:46 -0500
Message-Id: <20220909035447.36674-3-joelselvaraj.oss@gmail.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220909035447.36674-1-joelselvaraj.oss@gmail.com>
References: <20220909035447.36674-1-joelselvaraj.oss@gmail.com>
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

Add documentation for "xiaomi,beryllium-ebbg" device.

Signed-off-by: Joel Selvaraj <joelselvaraj.oss@gmail.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/arm/qcom.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
index fb1d00bcc847..6322ccbc8faa 100644
--- a/Documentation/devicetree/bindings/arm/qcom.yaml
+++ b/Documentation/devicetree/bindings/arm/qcom.yaml
@@ -667,6 +667,7 @@ properties:
               - sony,apollo-row
               - thundercomm,db845c
               - xiaomi,beryllium
+              - xiaomi,beryllium-ebbg
               - xiaomi,polaris
           - const: qcom,sdm845
 
-- 
2.37.3

