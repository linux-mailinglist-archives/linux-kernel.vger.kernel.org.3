Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 668A647F0A9
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Dec 2021 20:25:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233428AbhLXTZu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Dec 2021 14:25:50 -0500
Received: from ixit.cz ([94.230.151.217]:49956 "EHLO ixit.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229553AbhLXTZt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Dec 2021 14:25:49 -0500
Received: from localhost.localdomain (ip-89-176-96-70.net.upcbroadband.cz [89.176.96.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ixit.cz (Postfix) with ESMTPSA id 182842243C;
        Fri, 24 Dec 2021 20:25:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ixit.cz; s=dkim;
        t=1640373947;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=uq+pd2cBQPP3mCP6SdirmaMt2hCmEe5DR66+la6dDTM=;
        b=F1dT4Kx27/UiJH2WE9v8TvS9DlKDPAmPKlbljxy2W4wjbFeo20GSlf18WCV0AD2YSkBp8S
        t8EzfVxAxC/A1arwAQ/ughhsWmoYKjupyySZGdIHbMsxeIgaSBIW09ohDcib9xsCdzHSqD
        S4EiE+o7TnRUpPrjRNB4GZVOALMoS5k=
From:   David Heidelberg <david@ixit.cz>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Thierry Reding <treding@nvidia.com>
Cc:     ~okias/devicetree@lists.sr.ht, David Heidelberg <david@ixit.cz>,
        Rob Herring <robh@kernel.org>, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: mmc: PL18x stop relying on order of dma-names
Date:   Fri, 24 Dec 2021 20:25:45 +0100
Message-Id: <20211224192545.74528-1-david@ixit.cz>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We don't care in which order are "rx" and "tx" DMA names supplied.

Fixes: 4df297aaeb9c ("dt-bindings: mmc: Add missing properties used in examples")

Signed-off-by: David Heidelberg <david@ixit.cz>
---
 Documentation/devicetree/bindings/mmc/arm,pl18x.yaml | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/mmc/arm,pl18x.yaml b/Documentation/devicetree/bindings/mmc/arm,pl18x.yaml
index f0a44b2cfa79..a4f74bec68a3 100644
--- a/Documentation/devicetree/bindings/mmc/arm,pl18x.yaml
+++ b/Documentation/devicetree/bindings/mmc/arm,pl18x.yaml
@@ -70,9 +70,13 @@ properties:
     maxItems: 2
 
   dma-names:
-    items:
-      - const: rx
-      - const: tx
+    oneOf:
+      - items:
+          - const: tx
+          - const: rx
+      - items:
+          - const: rx
+          - const: tx
 
   power-domains: true
 
-- 
2.34.1

