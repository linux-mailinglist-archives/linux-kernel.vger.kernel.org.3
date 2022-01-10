Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5477E4897FF
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 12:51:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245224AbiAJLvH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 06:51:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245088AbiAJLtg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 06:49:36 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5662C06175A;
        Mon, 10 Jan 2022 03:49:35 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id k30so8659427wrd.9;
        Mon, 10 Jan 2022 03:49:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7Y+fkGNLGqdfMAAiGU48wuA+SIBMA19TPv5MMqKzhcc=;
        b=lVXip1dWvHl5uaJX4J+UpjVH/1Gtu4QhKzJ/mCA/2T5/C0W0OILrKY8FDo7hupDADK
         C2hcH3i3EQ3d9O5s0Ijs1UivEHbEevw7J/Avmq4qHeI7TDblkFWY+vPPZLem+oK5VwoZ
         eMCKpcDn0khEF24WtIBlGubYN2LmANMlqXM8AhiJoVM/HuAQj3alqMg+itaca6H2r624
         3elRU5AELfurEpaHRftnwzO5ppJ3bvx6eVmWIOvuSqyqd/eqRN6eABAuw8m3Xi+pK1nk
         Fzqqlh15ZWObe/iHkyNmFCJdktmF65AvABcRHm6vwGgJDlX/Ql6vXrB2kU5DkxTzRaPQ
         cI9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7Y+fkGNLGqdfMAAiGU48wuA+SIBMA19TPv5MMqKzhcc=;
        b=3WJEXMmWBUwSLhSBOtGsyZkRC9UzLHJiCnq5bu092qD7/kgghqM8ittWj98A2VMrmP
         pvs3FDVEKBdHxMJckNrUUXD5ignbmNucAUV8ow1XLPiHA7KIw/lFBj51zCCNXnWBKB6/
         NrALAZm+klQeGKdxhTmPIit85vst3iHq9BtOdt2ESp3zhygEBqhnwRbOJf8njEjB6pwV
         iDuN/ND2w0hqVrUCcR5MR/gttZcreJhvuHF0zW4lpk/Sg9ysh+aVl7VCr+itvRsR+Y3a
         cHTDKp864u4BD4wRLA6S1ZjG5a0I6WJgm+GD0lwSoO/BFmfoH8nY4RO1/UfuT4OpPoOq
         Ng8w==
X-Gm-Message-State: AOAM533oghEDMdfrihwi2F36ZXWhEcEhHg1QZQSP8OYalDPzvyDf1OQ0
        A1yI8vBA4lAhmjlxvyVWR6VMRLm666c/gQ==
X-Google-Smtp-Source: ABdhPJx0e3sLyqHMqz2xYe//mTRSM6DeViz0IEmgQaHzYtHdudmaf7dxI3j+8ZHcGdpoSWUAXt62GA==
X-Received: by 2002:adf:e3c9:: with SMTP id k9mr1398036wrm.193.1641815374165;
        Mon, 10 Jan 2022 03:49:34 -0800 (PST)
Received: from localhost.localdomain (198.red-81-44-130.dynamicip.rima-tde.net. [81.44.130.198])
        by smtp.gmail.com with ESMTPSA id 9sm8090252wrz.90.2022.01.10.03.49.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jan 2022 03:49:33 -0800 (PST)
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
To:     linux-clk@vger.kernel.org
Cc:     john@phrozen.org, linux-staging@lists.linux.dev,
        gregkh@linuxfoundation.org, neil@brown.name,
        p.zabel@pengutronix.de, linux-kernel@vger.kernel.org,
        sboyd@kernel.org, Rob Herring <robh@kernel.org>
Subject: [PATCH v8 2/4] dt-bindings: clock: mediatek,mt7621-sysc: add '#reset-cells' property
Date:   Mon, 10 Jan 2022 12:49:28 +0100
Message-Id: <20220110114930.1406665-3-sergio.paracuellos@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220110114930.1406665-1-sergio.paracuellos@gmail.com>
References: <20220110114930.1406665-1-sergio.paracuellos@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make system controller a reset provider for all the peripherals in the
MT7621 SoC adding '#reset-cells' property.

Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>
---
 .../bindings/clock/mediatek,mt7621-sysc.yaml         | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/Documentation/devicetree/bindings/clock/mediatek,mt7621-sysc.yaml b/Documentation/devicetree/bindings/clock/mediatek,mt7621-sysc.yaml
index 915f84efd763..0c0b0ae5e2ac 100644
--- a/Documentation/devicetree/bindings/clock/mediatek,mt7621-sysc.yaml
+++ b/Documentation/devicetree/bindings/clock/mediatek,mt7621-sysc.yaml
@@ -22,6 +22,11 @@ description: |
 
   The clocks are provided inside a system controller node.
 
+  This node is also a reset provider for all the peripherals.
+
+  Reset related bits are defined in:
+  [2]: <include/dt-bindings/reset/mt7621-reset.h>.
+
 properties:
   compatible:
     items:
@@ -37,6 +42,12 @@ properties:
       clocks.
     const: 1
 
+  "#reset-cells":
+    description:
+      The first cell indicates the reset bit within the register, see
+      [2] for available resets.
+    const: 1
+
   ralink,memctl:
     $ref: /schemas/types.yaml#/definitions/phandle
     description:
@@ -61,6 +72,7 @@ examples:
       compatible = "mediatek,mt7621-sysc", "syscon";
       reg = <0x0 0x100>;
       #clock-cells = <1>;
+      #reset-cells = <1>;
       ralink,memctl = <&memc>;
       clock-output-names = "xtal", "cpu", "bus",
                            "50m", "125m", "150m",
-- 
2.25.1

