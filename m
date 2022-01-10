Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA037489710
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 12:11:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244471AbiAJLLI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 06:11:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244468AbiAJLKn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 06:10:43 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 145FFC061757;
        Mon, 10 Jan 2022 03:10:43 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id s1so26063006wra.6;
        Mon, 10 Jan 2022 03:10:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7Y+fkGNLGqdfMAAiGU48wuA+SIBMA19TPv5MMqKzhcc=;
        b=WEPjMZtOAXr7fZIRboXRNF6OMOzS5/39hE9F4zXCYn2EdfnL786zpdkn28+k8Fidky
         RwnQeCtuTO8AauTUqcvS0suoNpCm/R5Gy57MpjQd7W9nzIMyUS4Xzug1zthyBgH9LRo4
         svZqq2ZJtU2z9RTKt9ibxBu7W6GbdzGjpGu/YREmAIIjJOZ8ghee7LsjVlmYHk1BzV5O
         E0B95Zjybm1NmMJK4J4xfholJEsZ5K9iotEbv1T3UCmSk6EYIMFsejR2wSO8POCIh/ZM
         sEa+79OjjjSCtk5n+fMdnSKEECJfyjkbeypV2SSEE0e14J1/42e38OEAEcCfEWR4fBTi
         rryQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7Y+fkGNLGqdfMAAiGU48wuA+SIBMA19TPv5MMqKzhcc=;
        b=RqjkY9bsxNzN42NX0PuRoxDahm4XocuCQqu5Vn7qRYED+RSrZQLOWlhQU4lLKYtiN9
         fUmp3YzDH3VRZZe71K2BJeT7dXuIp9zklzbWX934lh85qRz9jO5J58J+CTUs1bbv8juu
         VwkH4Sl9nV1Kp/ZBD27VpOPDf+bRixIwzDEpxuTMBzQ6WFqEn6m+QkywlcQKQJqIfXDC
         jcp0rJo6rJjQRezDToCNKLNQ0DqklST3FBzmLBSPu8L3nB397VsgTqs7qquUDq93h/kl
         Stt6n8a0jLQ/KEA3B72fU15WQAhGBOar7wCC5qy5HG6GbhK+tzK4VZHTR22e0ZW16ics
         md9w==
X-Gm-Message-State: AOAM533KdSpq3XP3Fbj8i8gxGAWQSK3jcf/DNvo9XoA6/Bv5uDCI14ak
        nKbioFlnHP48IdlPTFIAMdq5SfH0yYwgsw==
X-Google-Smtp-Source: ABdhPJwW9kIN/9Mh/TG8AKFuyWScF5czudxJwo1Pcxa3oPDf+2UX/F48pWPW1R/oPWWcYS1b30TCLQ==
X-Received: by 2002:adf:a443:: with SMTP id e3mr3841195wra.183.1641813041463;
        Mon, 10 Jan 2022 03:10:41 -0800 (PST)
Received: from localhost.localdomain (198.red-81-44-130.dynamicip.rima-tde.net. [81.44.130.198])
        by smtp.gmail.com with ESMTPSA id x8sm6256733wmj.44.2022.01.10.03.10.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jan 2022 03:10:41 -0800 (PST)
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
To:     linux-clk@vger.kernel.org
Cc:     john@phrozen.org, linux-staging@lists.linux.dev,
        gregkh@linuxfoundation.org, neil@brown.name,
        p.zabel@pengutronix.de, linux-kernel@vger.kernel.org,
        sboyd@kernel.org, Rob Herring <robh@kernel.org>
Subject: [PATCH v7 2/4] dt-bindings: clock: mediatek,mt7621-sysc: add '#reset-cells' property
Date:   Mon, 10 Jan 2022 12:10:34 +0100
Message-Id: <20220110111036.1380288-3-sergio.paracuellos@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220110111036.1380288-1-sergio.paracuellos@gmail.com>
References: <20220110111036.1380288-1-sergio.paracuellos@gmail.com>
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

