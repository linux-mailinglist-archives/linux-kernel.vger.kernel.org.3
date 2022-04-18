Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DB35505B18
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Apr 2022 17:32:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345223AbiDRPeh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 11:34:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345344AbiDRPdr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 11:33:47 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42CA82F00B
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 07:49:19 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id z6-20020a17090a398600b001cb9fca3210so14256790pjb.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 07:49:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LcpBBaLp7yKm4ePUGPYn7cfXcgSTcSPuiQUdtonyWvw=;
        b=EBkHmi4d31qbKwVRASQykxgS+ZPLpHRLQCtY505IyEpcYARyykRr+8YwLkgcesbhUo
         GhmgOmbxINYKVDz8YN6Xtlw1hgcTioANukL3XMsrZhxLsklMAxmrjWluFpN6znmjkHAZ
         K2524nXKtVEkMlVcN8597Ux9NSgQHkc4El09A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LcpBBaLp7yKm4ePUGPYn7cfXcgSTcSPuiQUdtonyWvw=;
        b=OkmwDnn9jY7UJlWT//s9xJ6nSppCCfhVmqLwJWonxZEq8WMbLfIyo80BLcAcNDAC7P
         WNR/jQjnRCECfQ/KbsNctSzRCF3IbhKBG64NE31Y4Psz3rI23MRN3K/dJlHE++g0+mtz
         yTgbWAiVswJYlYYlyonwChxiV0jg9rvwCicHhjer5d3W+G16HY5QUTAMJwnGl9BSWUmV
         6OcyIoB2lpe51r6cxZ5q59utj42dydA3HzikltD5dd4xGcb4Jn8kPDtaDKUlHLJk9a/b
         QGw/o4bf7fiCBnPUZxW/Yi6/9fT8DQfJd1PYPXZn/Da701frDp5MnlJHPt69tPxqrJKU
         dB5w==
X-Gm-Message-State: AOAM532JgWWi3BNTpeoEpr5YUuUZEg3HHIiEfU4/8rxyZxrhxMlbigAB
        zR0ixniHXzkeI4isOCOgg0iseg==
X-Google-Smtp-Source: ABdhPJwogBI5AQX9yHFmWqm+C+1uZD+WyRYxauigff0xcpd3hLwGmIJ+DdkM58lJnWX+vEiWRJioTg==
X-Received: by 2002:a17:903:2291:b0:158:c298:4f7a with SMTP id b17-20020a170903229100b00158c2984f7amr11184374plh.7.1650293358797;
        Mon, 18 Apr 2022 07:49:18 -0700 (PDT)
Received: from localhost.localdomain ([183.83.137.38])
        by smtp.gmail.com with ESMTPSA id d6-20020a056a00244600b004f701135460sm13508532pfj.146.2022.04.18.07.49.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Apr 2022 07:49:18 -0700 (PDT)
From:   Manoj Sai <abbaraju.manojsai@amarulasolutions.com>
To:     Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Li Yang <leoyang.li@nxp.com>,
        Fabio Estevam <festevam@gmail.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Matteo Lisi <matteo.lisi@engicam.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-amarula@amarulasolutions.com,
        Jagan Teki <jagan@amarulasolutions.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Rob Herring <robh@kernel.org>,
        Suniel Mahesh <sunil@amarulasolutions.com>,
        Michael Nazzareno Trimarchi <michael@amarulasolutions.com>,
        Manoj Sai <abbaraju.manojsai@amarulasolutions.com>
Subject: [PATCH v2 1/3] dt-bindings: arm: fsl: Add Engicam i.Core MX8M Plus EDIMM2.2 Starter Kit
Date:   Mon, 18 Apr 2022 20:19:05 +0530
Message-Id: <20220418144907.327511-1-abbaraju.manojsai@amarulasolutions.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220330191437.614065-2-abbaraju.manojsai@amarulasolutions.com>
References: <20220330191437.614065-2-abbaraju.manojsai@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

i.Core MX8M Plus is an EDIMM SoM based on NXP i.MX8M Plus from Engicam.

EDIMM2.2 Starter Kit is an EDIMM 2.2 Form Factor Capacitive Evaluation
Board from Engicam.

i.Core MX8M Plus needs to mount on top of this Evaluation board for
creating complete i.Core MX8M Plus EDIMM2.2 Starter Kit.

Add bindings for it.

Signed-off-by: Manoj Sai <abbaraju.manojsai@amarulasolutions.com>
Reviewed-by: Jagan Teki <jagan@amarulasolutions.com>
---
Changes for v2 :
 -added the device binding of imx8mp as per soc order.
---
 Documentation/devicetree/bindings/arm/fsl.yaml | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
index b6cc34115362..3bdc490cfbe2 100644
--- a/Documentation/devicetree/bindings/arm/fsl.yaml
+++ b/Documentation/devicetree/bindings/arm/fsl.yaml
@@ -936,6 +936,13 @@ properties:
           - const: toradex,verdin-imx8mp          # Verdin iMX8M Plus Module
           - const: fsl,imx8mp
 
+      - description: Engicam i.Core MX8M Plus SoM based boards
+        items:
+          - enum:
+              - engicam,icore-mx8mp-edimm2.2       # i.MX8MP Engicam i.Core MX8M Plus EDIMM2.2 Starter Kit
+          - const: engicam,icore-mx8mp             # i.MX8MP Engicam i.Core MX8M Plus SoM
+          - const: fsl,imx8mp
+
       - description: i.MX8MQ based Boards
         items:
           - enum:
-- 
2.25.1

