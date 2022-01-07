Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E8544870EF
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 04:04:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345701AbiAGDEt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 22:04:49 -0500
Received: from mail-oi1-f182.google.com ([209.85.167.182]:35708 "EHLO
        mail-oi1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344981AbiAGDEt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 22:04:49 -0500
Received: by mail-oi1-f182.google.com with SMTP id s127so6512294oig.2;
        Thu, 06 Jan 2022 19:04:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LyWkM4tBgwFCX05sZIe2VIqupQhhasHmfIXlEJszdhg=;
        b=tyxRcmf2INP7z2PZdtMn0PXDdFuMd263Xi0ftMh+zqkwhmCPrBPcK903w5EteKwpI/
         Io8D1kvnfQz2qIuod5V5ZumDNBRyrDBAYlxvp+RZp45dryr4+sqdtmjb1mMcQDQx0IhQ
         5TgcIMKwArvuUWmOAjbtHJK3OYtPOrMcOLNS80M7zBl+FGtR+0T12qCB63lKQnxg+d6a
         K1HxC/wsXEcnT5yFVc0KIMFSP2Py1D29R6lmzmUjsABeSAIKHz6iGj/c9wOFfoijYlAK
         h381ZhmB8NoV7JhfuihH0I8EKUvvET+XGNFW2Bz6bmOQ9uUw9pF3g6PCvOfiPSnTzr0W
         800w==
X-Gm-Message-State: AOAM5330wtNXi5zaGi6dIIXfjxWEoqdOA0I1sRAVv3Pa79vSBU3/sGpU
        2ntDJFWfc/bxkm5ptnRvoqZhu+2ajA==
X-Google-Smtp-Source: ABdhPJwNWLclG7pcGqVKKoFpRqEDnbF4dkRo1by5R2tPaVNaQL9z0uXVtkGML4c9a3bIT8Y6DXV3yA==
X-Received: by 2002:aca:ac93:: with SMTP id v141mr8597056oie.106.1641524688602;
        Thu, 06 Jan 2022 19:04:48 -0800 (PST)
Received: from xps15.herring.priv (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.googlemail.com with ESMTPSA id g17sm721400oiy.14.2022.01.06.19.04.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jan 2022 19:04:48 -0800 (PST)
From:   Rob Herring <robh@kernel.org>
To:     Iskren Chernev <iskren.chernev@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Matheus Castello <matheus@castello.eng.br>,
        Sebastian Reichel <sre@kernel.org>
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: power: maxim,max17040: Fix incorrect type for 'maxim,rcomp'
Date:   Thu,  6 Jan 2022 21:04:33 -0600
Message-Id: <20220107030433.2381616-1-robh@kernel.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The 'maxim,rcomp' is defined as a uint32, but the description and users all
say it is uint8-array with 1 or 2 elements. The tools missed checking this
case.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/power/supply/maxim,max17040.yaml      | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/power/supply/maxim,max17040.yaml b/Documentation/devicetree/bindings/power/supply/maxim,max17040.yaml
index ffb344987a7b..6b4588a3253b 100644
--- a/Documentation/devicetree/bindings/power/supply/maxim,max17040.yaml
+++ b/Documentation/devicetree/bindings/power/supply/maxim,max17040.yaml
@@ -44,7 +44,9 @@ properties:
       SoC == State of Charge == Capacity.
 
   maxim,rcomp:
-    $ref: /schemas/types.yaml#/definitions/uint32
+    $ref: /schemas/types.yaml#/definitions/uint8-array
+    minItems: 1
+    maxItems: 2
     description: |
       A value to compensate readings for various battery chemistries and operating temperatures.
       max17040,41 have 2 byte rcomp, default to 0x97 0x00.
-- 
2.32.0

