Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F5B75279E4
	for <lists+linux-kernel@lfdr.de>; Sun, 15 May 2022 22:31:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238597AbiEOUbe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 May 2022 16:31:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233281AbiEOUb0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 May 2022 16:31:26 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DB082BE5;
        Sun, 15 May 2022 13:31:25 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id i40so939992eda.7;
        Sun, 15 May 2022 13:31:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ENgyZIarJt3vx0WIXiC6L0+jAAX3vWhh6cAjsl5a67I=;
        b=SZFpiN8zhdmdVfDFONWVxa4X3LiXAkoHxyC9IzvkoFe/QoZrcetJZU/JXmQm9HXQFv
         NMfbWmRekKmuE2oBEVR75w6N5bj/4fcNfg7gIDcubWs2i1I9W7lqvcgkF/rGjadNkCEL
         T/VLOLtlg/GHcJ8KkqMOnSSjIkaTVI/8/IShYt0W5W3CHsm9OAXxWDPW/DTao27c0rE/
         hmjhujBCw9T1Py27mX8WsyE7UwS3nyKSqwrwIgD1rblF00lBhBJkx3p3CJ8/uV+JbreC
         rHzHgLKRK75KXGFUjWrO1wNRPNA2yToiiqPorpRuh9VKum5QPJGKZvQLp5ynZY7xTrQ4
         Fzhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ENgyZIarJt3vx0WIXiC6L0+jAAX3vWhh6cAjsl5a67I=;
        b=kbK0YYbum+ueBk8BdQalngSjvRvu3jV2nUrOBcrFQcIilkQUfX1oAFsmaxvP3saKBr
         rBCGPJuY34mZszvF9Qt/iXZcFD1S2MZ8bg9NDzyIFZlBUcHbfYl97NBtSOW3/MMZd3dX
         drGAuGFsfHsRrAVTBcOg9Sd9acqOpO3Z7V6Cz+O1heB/cHM8jW6o9mQ5yUPdtG9EHyqw
         Or/OjTRGWsahkmVuWvM8HTjXDpho3TN/g4nvDSZHr46ggd0bMzfVqWy8/pOHf8cPinCq
         iBUjyp/JFuI9Z3ZtyeHhVKa+YecH3iJljxi+QngKVJycexlbXUJducZC0TbKwDzfffQ4
         QRvQ==
X-Gm-Message-State: AOAM531n7yR7XKzvBeoPMz+lC2ODDc3pa4zhBcyaxoOD0+AGoThL+TcQ
        QaUte+5II4QZ1M8oc8gKWsw=
X-Google-Smtp-Source: ABdhPJwmuEMVFMd3pOhbiXip1TKJdHQndx6BAJa7uGYqCpSA87Jir89Hbfu2jtrHA9DhPU4RPnqLnA==
X-Received: by 2002:a05:6402:c90:b0:42a:98c7:3fe with SMTP id cm16-20020a0564020c9000b0042a98c703femr7851455edb.270.1652646683799;
        Sun, 15 May 2022 13:31:23 -0700 (PDT)
Received: from fedora.robimarko.hr (dh207-98-105.xnet.hr. [88.207.98.105])
        by smtp.googlemail.com with ESMTPSA id ze16-20020a170906ef9000b006f3ef214e4esm2944884ejb.180.2022.05.15.13.31.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 May 2022 13:31:23 -0700 (PDT)
From:   Robert Marko <robimarko@gmail.com>
To:     agross@kernel.org, bjorn.andersson@linaro.org, lgirdwood@gmail.com,
        broonie@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Cc:     Robert Marko <robimarko@gmail.com>
Subject: [PATCH 3/6] dt-bindings: regulator: qcom,spmi-regulator: add PMP8074 PMIC
Date:   Sun, 15 May 2022 22:31:15 +0200
Message-Id: <20220515203118.474684-3-robimarko@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220515203118.474684-1-robimarko@gmail.com>
References: <20220515203118.474684-1-robimarko@gmail.com>
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
index f7da310f1845..960e61661bc8 100644
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

