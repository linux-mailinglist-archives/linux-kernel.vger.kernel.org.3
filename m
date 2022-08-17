Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF1015969F6
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 09:01:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229548AbiHQG7z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 02:59:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229578AbiHQG7x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 02:59:53 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00A1A77564
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 23:59:51 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id s9so12689966ljs.6
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 23:59:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=B8c7iJnhZX47NU6lClMolig3bID9Hx28YLYzcvicntU=;
        b=dZ321f00RmYZbLfA/Oo9QhhpkQq30XrhmtyNgiJxyfYkPndUQMbzNxL8wuRIZ+c4qa
         /Fx+vzBUiWa1bhyl89th1aPCJZC4jGvigOkfwChDZPEP+AszBJ0vj4qZignfws/a5l11
         APPSZrrPBGHWBJsbFFOrhAGso3TgFlvFxjNgPD5fKGYSuIfGc6MyKmzeuvkVxql+GMPp
         O0FSAtL37rDqju6xzyEQ+ANVcNDLBoWDi/ETFo7C0eUhSHJgqppYQERWocDlnYBMr+71
         xL9ESdj7Ev0A0k37sDom5yVnlIZOxOn/yQYpVgrVxwpVhOXU/ae+Vlg2FrpXz22l9vVH
         1wow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=B8c7iJnhZX47NU6lClMolig3bID9Hx28YLYzcvicntU=;
        b=A1a2CKVe3cvxzSyldcxSfE7MyBToh/460bdO8myi5pyetC7zBqc+dm7jHPT4BMMOrx
         9+Ur+IIb4Zx+0dT8Z/2pJwDdv30SC7swD7HhiKSxJoyE0aFASbuOpbSUYpih2AmKE7um
         XTfKhYdXliumkwNnZG8LDrpAlp3HiSnoCYmxKM37uG+ftLR8l9yTM5CRNAqTCIX8fbiH
         vayIM8LP3dNe0Zw2tr+EpTPvFMNPD3CN4sKH5lefKB/bRcAKOKBosxbHw/ztpV11p1FH
         iUFxAU0kIYwOfmTSYbjY+QSZlB/tOJs6AEPNAwFZ2ayFx9GEa7JLRViEnUBTGA3PuEy2
         8Upg==
X-Gm-Message-State: ACgBeo3+bLwMvEYzp0Kl8NWaS6vIprZs3pd9BYbWkQmtSHrDlvO9kxde
        gpit8JYKMz9f9ES9zEJqh9zS7w==
X-Google-Smtp-Source: AA6agR48unqwKvTH3CALdNY8zDuto+UBkHv7JYgMSQrdYta5L/I1+HE/cwgez4BxN3ndftjt9pRybw==
X-Received: by 2002:a2e:953:0:b0:25e:6894:6b9 with SMTP id 80-20020a2e0953000000b0025e689406b9mr7849045ljj.275.1660719590343;
        Tue, 16 Aug 2022 23:59:50 -0700 (PDT)
Received: from krzk-bin.. (d15l54h48cw7vbh-qr4-4.rev.dnainternet.fi. [2001:14bb:ae:539c:1b1c:14b7:109b:ed76])
        by smtp.gmail.com with ESMTPSA id o2-20020ac24e82000000b004896ed8dce3sm1599480lfr.2.2022.08.16.23.59.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Aug 2022 23:59:49 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Georgi Djakov <djakov@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Peng Fan <peng.fan@nxp.com>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 1/2] dt-bindings: interconnect: fsl,imx8m-noc: drop Leonard Crestez
Date:   Wed, 17 Aug 2022 09:59:45 +0300
Message-Id: <20220817065946.24303-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Emails to Leonard Crestez bounce ("550 5.4.1 Recipient address rejected:
Access denied:), so change maintainer to Peng Fan from NXP.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Peng, please ack it if you agree.
---
 .../devicetree/bindings/interconnect/fsl,imx8m-noc.yaml         | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/interconnect/fsl,imx8m-noc.yaml b/Documentation/devicetree/bindings/interconnect/fsl,imx8m-noc.yaml
index 7d8d0896e979..f7a5e31c506e 100644
--- a/Documentation/devicetree/bindings/interconnect/fsl,imx8m-noc.yaml
+++ b/Documentation/devicetree/bindings/interconnect/fsl,imx8m-noc.yaml
@@ -7,7 +7,7 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
 title: Generic i.MX bus frequency device
 
 maintainers:
-  - Leonard Crestez <leonard.crestez@nxp.com>
+  - Peng Fan <peng.fan@nxp.com>
 
 description: |
   The i.MX SoC family has multiple buses for which clock frequency (and
-- 
2.34.1

