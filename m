Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE121553090
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 13:18:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349102AbiFULS1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 07:18:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349061AbiFULSY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 07:18:24 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D407027FE6;
        Tue, 21 Jun 2022 04:18:23 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id o10so18895560edi.1;
        Tue, 21 Jun 2022 04:18:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=v7nxHvlawisf1+yiWy1FwkyOpuVc183YG++a4GngDmg=;
        b=k8kgSfSqpz4vdo2wbxKrJU85FLNZ8v/bI9PXo+y9KI/dhCGuPwYzTeZiDdJnsCD0Jh
         RzMqbKjDufSesLdcXfredMI5zxB43WU8LRGAjgFvDRZ+05doGEtkKZpj5VjDjLVZBqG0
         +egaSeByeYTobiRwEjMM1YfUyOti+MmspmEik+rjsb0DUYOuSIzaUcRgK6hm5+JDV+TT
         fejvmPtoQyag964WuObuXh3Rxgh4Iz14l59oMVxHZId7KBPuoKpsWevd00/CsJpoEAfZ
         +dzb1JHB63C8vXAQ/w6BRq7q62cDiQzKBlyGXNPfpNwsBjx+VPckrP5FSQ/CWG2UjxKR
         bmfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=v7nxHvlawisf1+yiWy1FwkyOpuVc183YG++a4GngDmg=;
        b=dGZXUhEaejzTyPwMwOoEqkunVpJurt16vd3SXrdZIV6MdMkqojE/HMxfJv3DyvQ0tG
         hMh74N8n+hWo0RopHrw3DDyNd691W/sHiiWRHr6QUqyMmDtxtFl5m+hJyaB8BcK/FgoK
         peSpv5NPGFsTTRGJT1njYX5Q75VW7+DweutOo5p0UlR6r2OhziJQ9WfPu4Xf6erP9Jxu
         eIxrGot3pqmVWgxWnc/ZuLRDU0h3ju3DZj/srR/fePj0HRO0WxgPXLw0+FC+Tp+OdvdY
         8TA42GGJvY/dyjrAWkMfYxaLfJFO91aOeI2WK+h2N0/HVIW2Et0MWnJ+Z7BOtCGa02RY
         ypDQ==
X-Gm-Message-State: AJIora9YUnT7VIBSI1v39Oe4CNvqT+RkiImLKG0P9hhHsj0dD4osdi5j
        MTo+usCRh2l8u+3Ez116pMzmjxCQDWE=
X-Google-Smtp-Source: AGRyM1uOXGc3Fg4VuwVFdAiuaxJzSz066rV0cx1EG856h7qraoEOp+CrttjskSMpN0foOQElXk7dnw==
X-Received: by 2002:a05:6402:51c7:b0:42d:f4ea:c09 with SMTP id r7-20020a05640251c700b0042df4ea0c09mr34199959edd.319.1655810302306;
        Tue, 21 Jun 2022 04:18:22 -0700 (PDT)
Received: from fedora.robimarko.hr (dh207-98-140.xnet.hr. [88.207.98.140])
        by smtp.googlemail.com with ESMTPSA id 15-20020a170906300f00b006f3ef214dd9sm7513063ejz.63.2022.06.21.04.18.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jun 2022 04:18:21 -0700 (PDT)
From:   Robert Marko <robimarko@gmail.com>
To:     agross@kernel.org, bjorn.andersson@linaro.org, kishon@ti.com,
        vkoul@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Robert Marko <robimarko@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v2 1/2] dt-bindings: phy: qcom,qmp: add IPQ8074 PCIe Gen3 PHY binding
Date:   Tue, 21 Jun 2022 13:18:17 +0200
Message-Id: <20220621111818.447452-1-robimarko@gmail.com>
X-Mailer: git-send-email 2.36.1
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

IPQ8074 has 2 different single lane PCIe PHY-s, one Gen2 and one Gen3.
Gen2 one is already supported, document the bindings for the Gen3 one.

Signed-off-by: Robert Marko <robimarko@gmail.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/phy/qcom,qmp-phy.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/phy/qcom,qmp-phy.yaml b/Documentation/devicetree/bindings/phy/qcom,qmp-phy.yaml
index 8b850c5ab116..220788ce215f 100644
--- a/Documentation/devicetree/bindings/phy/qcom,qmp-phy.yaml
+++ b/Documentation/devicetree/bindings/phy/qcom,qmp-phy.yaml
@@ -19,6 +19,7 @@ properties:
     enum:
       - qcom,ipq6018-qmp-pcie-phy
       - qcom,ipq6018-qmp-usb3-phy
+      - qcom,ipq8074-qmp-gen3-pcie-phy
       - qcom,ipq8074-qmp-pcie-phy
       - qcom,ipq8074-qmp-usb3-phy
       - qcom,msm8996-qmp-pcie-phy
@@ -312,6 +313,7 @@ allOf:
           contains:
             enum:
               - qcom,ipq6018-qmp-pcie-phy
+              - qcom,ipq8074-qmp-gen3-pcie-phy
               - qcom,ipq8074-qmp-pcie-phy
     then:
       properties:
-- 
2.36.1

