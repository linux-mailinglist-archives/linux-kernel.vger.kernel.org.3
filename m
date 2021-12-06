Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5165646A341
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 18:42:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244157AbhLFRpo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 12:45:44 -0500
Received: from mail-oi1-f175.google.com ([209.85.167.175]:43598 "EHLO
        mail-oi1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244384AbhLFRpk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 12:45:40 -0500
Received: by mail-oi1-f175.google.com with SMTP id o4so22766677oia.10;
        Mon, 06 Dec 2021 09:42:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Fe3CVMpBQRRT3DNNsuf4d0VO78+TZJUoy7pg+WaNgVE=;
        b=7OpSa611szk2/pMKSsfjsF5WQf8XVDQfhRC5plDNGQqQaydP2iWc+VLLZJjoNsOT09
         kdCbooUFhFT/tKn50CSTW8evuamwiW//iCyKEDvYk3MIFHCu764VZ/KXl+C56bYMhK9G
         UNu/VVb3BBg4HqpLDSsdMW6dtyUUNRrduk4xIPtfA33WFdeLNFzxDJhQ1HkJdgPRSqnM
         RmeTvEVU+dgFko4IGMYYk+gGnXY0KskVjYhpJAfq4onOYau/BOMy0mco4WXJyVvAr97D
         /U6eZn6+NyndZgg4nWMLw5KQrpjtgQYyw55BRmBej1qCyf3amyKXwY2i17NYXDBwSNnS
         xNzA==
X-Gm-Message-State: AOAM531sxnhoswUn4KsKg/5gZHVAz+1M4wuRNwfG85/EdMNttgZGRH1g
        2cuT8oXF8eO5k7q6DwwWXA==
X-Google-Smtp-Source: ABdhPJzHP1QkE2s5ndqS+VwuC8jY/yr9YvhnhPWxR574frX67lEfBoHQ/rxu+rSBcZejjTobuxVKnA==
X-Received: by 2002:a05:6808:a08:: with SMTP id n8mr24972066oij.148.1638812531044;
        Mon, 06 Dec 2021 09:42:11 -0800 (PST)
Received: from xps15.herring.priv (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.googlemail.com with ESMTPSA id q10sm2904918oiw.17.2021.12.06.09.42.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Dec 2021 09:42:10 -0800 (PST)
From:   Rob Herring <robh@kernel.org>
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tony Lindgren <tony@atomide.com>,
        Roger Quadros <rogerq@kernel.org>
Cc:     devicetree@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: mtd: ti,gpmc-nand: Add missing 'rb-gpios'
Date:   Mon,  6 Dec 2021 11:42:09 -0600
Message-Id: <20211206174209.2297565-1-robh@kernel.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With 'unevaluatedProperties' support implemented, the TI GPMC example
has a warning:

Documentation/devicetree/bindings/memory-controllers/ti,gpmc.example.dt.yaml: nand@0,0: Unevaluated properties are not allowed ('rb-gpios' was unexpected)

Add the missing definition for 'rb-gpios'.

Cc: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Richard Weinberger <richard@nod.at>
Cc: Vignesh Raghavendra <vigneshr@ti.com>
Cc: Tony Lindgren <tony@atomide.com>
Cc: Roger Quadros <rogerq@kernel.org>
Cc: linux-mtd@lists.infradead.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/mtd/ti,gpmc-nand.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/mtd/ti,gpmc-nand.yaml b/Documentation/devicetree/bindings/mtd/ti,gpmc-nand.yaml
index beb26b9bcfb2..1c280f52baa0 100644
--- a/Documentation/devicetree/bindings/mtd/ti,gpmc-nand.yaml
+++ b/Documentation/devicetree/bindings/mtd/ti,gpmc-nand.yaml
@@ -53,6 +53,11 @@ properties:
     enum: [8, 16]
     default: 8
 
+  rb-gpios:
+    description:
+      GPIO connection to R/B signal from NAND chip
+    maxItems: 1
+
 patternProperties:
   "@[0-9a-f]+$":
     $ref: "/schemas/mtd/partitions/partition.yaml"
-- 
2.32.0

