Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 287124869CA
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jan 2022 19:25:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242739AbiAFSZj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 13:25:39 -0500
Received: from mail-oo1-f42.google.com ([209.85.161.42]:39429 "EHLO
        mail-oo1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242771AbiAFSZe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 13:25:34 -0500
Received: by mail-oo1-f42.google.com with SMTP id t13-20020a4a760d000000b002dab4d502dfso864969ooc.6;
        Thu, 06 Jan 2022 10:25:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bI7eobDSewS2Qd+lbfRTD/gtkMkysWS1nWdoyRyM1q4=;
        b=Cpln5nlcYIi7fgk/fZ3ubsrModn5mFfdNVulECq3G9yVMMNWYx7aX6dv0lBO0Ne7M0
         VQtFlnnwBgPCZ5lPxwB2rEyU0wvw45MGB7CS1nKetGfx6J3QERtfyzafURR029q+qVVc
         /ULXjuWUGYW1q2S93HOgYIvm/DZye62m5TR35ub6xaz05JA6lVntAdSEz6LGatvBKbfS
         O2Uqpb0/5bSEOaBg/NbTFzzRr7CakHQfDUzHgoCFe8482+JkZJo0ZY+Y/oEbpJP988+0
         JJuKqrCkjODYL2iHMS/ghQu4QMO4Hv/gHRzBWW3FKh2YJ1fExzDAvmeZ8w7W4ahXbGxa
         3SmQ==
X-Gm-Message-State: AOAM532sysJlRs1BbSiT9Subq7pYyK3EN/mahzcEn4Z/iermwlQrI4Ie
        ENdQeBD5lp8H4Wn4MGy7qE2d+JKuOA==
X-Google-Smtp-Source: ABdhPJwcLUypC9NTs2U4zWC3D8yMwCErfVX7jBkeuwLiiNOX4ZGKYs3h3IsWsn/EGiyZmJloSEcEKw==
X-Received: by 2002:a4a:2a1b:: with SMTP id k27mr38264788oof.97.1641493533731;
        Thu, 06 Jan 2022 10:25:33 -0800 (PST)
Received: from xps15.herring.priv (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.googlemail.com with ESMTPSA id r13sm484949oth.21.2022.01.06.10.25.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jan 2022 10:25:33 -0800 (PST)
From:   Rob Herring <robh@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>, Marc Zyngier <maz@kernel.org>
Cc:     Marc Zyngier <marc.zyngier@arm.com>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH] dt-bindings: interrupt-controller: arm,gic-v3: Fix 'interrupts'
Date:   Thu,  6 Jan 2022 12:25:13 -0600
Message-Id: <20220106182518.1435497-5-robh@kernel.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The 2nd example has an interrupts cells size of 4, but the 'interrupts'
property has 3 cells. The example should also be separate since the cell
size differs in each example.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/interrupt-controller/arm,gic-v3.yaml   | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/arm,gic-v3.yaml b/Documentation/devicetree/bindings/interrupt-controller/arm,gic-v3.yaml
index c84f9fe7f254..cfb3ec27bd2b 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/arm,gic-v3.yaml
+++ b/Documentation/devicetree/bindings/interrupt-controller/arm,gic-v3.yaml
@@ -239,6 +239,7 @@ examples:
       };
     };
 
+  - |
     interrupt-controller@2c010000 {
       compatible = "arm,gic-v3";
       #interrupt-cells = <4>;
@@ -254,7 +255,7 @@ examples:
             <0x2c040000 0x2000>,  // GICC
             <0x2c060000 0x2000>,  // GICH
             <0x2c080000 0x2000>;  // GICV
-      interrupts = <1 9 4>;
+      interrupts = <1 9 4 0>;
 
       msi-controller@2c200000 {
         compatible = "arm,gic-v3-its";
-- 
2.32.0

