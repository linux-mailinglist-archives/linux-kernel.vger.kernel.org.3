Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BDBA4ECD13
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 21:15:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350752AbiC3TRI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 15:17:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350720AbiC3TQz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 15:16:55 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7253D3F8AC
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 12:15:00 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id g9-20020a17090ace8900b001c7cce3c0aeso652558pju.2
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 12:15:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YmPIfZNsaOlAIH1o6bSjpUNVHoOAM+3blRAMWjhkViM=;
        b=i/9AGbekHVmAEVgVqKC1AUh5aPA5z5rqIRsE1oc5RBq9rROZt0LFG4QSmFFRSwPZBk
         32zamTdxiEXojV+INntLXH7cnOYxIoDK6CEc3FhqwjFIb3VUQWg1bzv8BYKpQ1toW30F
         WFvN/BkBL/Feg+BF/BQjjkTb/qfmtCqvOySLw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YmPIfZNsaOlAIH1o6bSjpUNVHoOAM+3blRAMWjhkViM=;
        b=KFxO3tYtXehCfPTjEOwfgNqYmipfmSoHZruCTkgS12hEE6GbSJQ7q757WzQtUGV5Mk
         iHw+mRIQLIWKqskS3iSHPDEYsaz2NTvvITN3OokaNf67UqE+a0FcBmMDVesBw133T3sw
         qVPXea9lbHI3/wgSRA38GFa0ikYK8uspKrwD92UP96fYdSEDgiPAqHuhJB+B4wwhMJL9
         eMpYJTEY/HIbajuahZEY4opPe+jdC7omkkKrJv3mkOKxOiShfacX/bbQNbnzJBbaBc0h
         gKW2FcR37RUWjqD+IQBMIcENrYQsK8yFbgUNhWKayQIKG9KLnppPf8QTRUN2jueE1tqx
         Qi+A==
X-Gm-Message-State: AOAM530VDrGR2v1unmlBM+SF5lUDb31DGbTmvFLLOWZcJHCAEJz5Ai2v
        9bvAPDNKN4VGWua9qEj4FjKsJQ==
X-Google-Smtp-Source: ABdhPJzTF8TOMM5PoTjVeSaSdFZKNFPUwtgHrsWRzTy2EgCCJ4sBcGu/aI9vbnGU9guI3pEOd2DS+w==
X-Received: by 2002:a17:902:8b88:b0:156:2b14:cb6e with SMTP id ay8-20020a1709028b8800b001562b14cb6emr1228327plb.14.1648667699738;
        Wed, 30 Mar 2022 12:14:59 -0700 (PDT)
Received: from localhost.localdomain ([183.83.137.38])
        by smtp.gmail.com with ESMTPSA id ng17-20020a17090b1a9100b001c9f79927bfsm2955451pjb.25.2022.03.30.12.14.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Mar 2022 12:14:59 -0700 (PDT)
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
Subject: [PATCH 1/3] dt-bindings: arm: fsl: Add Engicam i.Core MX8M Plus EDIMM2.2 Starter Kit
Date:   Thu, 31 Mar 2022 00:44:35 +0530
Message-Id: <20220330191437.614065-2-abbaraju.manojsai@amarulasolutions.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220330191437.614065-1-abbaraju.manojsai@amarulasolutions.com>
References: <20220330191437.614065-1-abbaraju.manojsai@amarulasolutions.com>
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

i.Core MX8M Plus is an EDIMM SoM based on NXP i.MX8M Plus from Engicam.

EDIMM2.2 Starter Kit is an EDIMM 2.2 Form Factor Capacitive Evaluation
Board from Engicam.

i.Core MX8M Plus needs to mount on top of this Evaluation board for
creating complete i.Core MX8M Plus EDIMM2.2 Starter Kit.

Add bindings for it.

Signed-off-by: Manoj Sai <abbaraju.manojsai@amarulasolutions.com>
Reviewed-by: Jagan Teki <jagan@amarulasolutions.com>
---
 Documentation/devicetree/bindings/arm/fsl.yaml | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
index 08bdd30e511c..5c4137e4c859 100644
--- a/Documentation/devicetree/bindings/arm/fsl.yaml
+++ b/Documentation/devicetree/bindings/arm/fsl.yaml
@@ -787,6 +787,13 @@ properties:
           - const: engicam,icore-mx8mm             # i.MX8MM Engicam i.Core MX8M Mini SoM
           - const: fsl,imx8mm
 
+      - description: Engicam i.Core MX8M Plus SoM based boards
+        items:
+          - enum:
+              - engicam,icore-mx8mp-edimm2.2       # i.MX8MP Engicam i.Core MX8M Plus EDIMM2.2 Starter Kit
+          - const: engicam,icore-mx8mp             # i.MX8MP Engicam i.Core MX8M Plus SoM
+          - const: fsl,imx8mp
+
       - description: Kontron BL i.MX8MM (N801X S) Board
         items:
           - const: kontron,imx8mm-n801x-s
-- 
2.25.1

