Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC6FC4869BA
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jan 2022 19:25:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242731AbiAFSZa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 13:25:30 -0500
Received: from mail-oo1-f51.google.com ([209.85.161.51]:39435 "EHLO
        mail-oo1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242685AbiAFSZ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 13:25:29 -0500
Received: by mail-oo1-f51.google.com with SMTP id t13-20020a4a760d000000b002dab4d502dfso864913ooc.6;
        Thu, 06 Jan 2022 10:25:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WtCQ64pgnWNLBdjxVsdLoyMOG4H3ImMrrn1XpG3ExcA=;
        b=4YpOrtgsYqKG+ThblPcG/YT7aaNA/Qt7pvIaFEIBRUxeh7wFSzdoFKP3tamUxzcKzY
         Y3jUGlVbL/sb6IA0CiUkjIp9CFLISdJWyK0FvUnVL/7PDmLc7FCS29MFX6FHEtX3RfyY
         nBwfs5gHjWXKqeCeXiFEG70rdb/hjresHF1gSybEUk6b4VY4yT337Cecou+EYs593xuM
         P5ZVIg9GuYvomLEFwtwxyOc01brH60ROdcjS506LID16daz+DGNTuYvRTl7cJO4O4FJo
         a9UrpbytMTib4iUBIxkmjy+tYzwyt5UZq5e8y42N4vcYWBXUqrRUnuNOf+IFITTA7T92
         LDEw==
X-Gm-Message-State: AOAM530l1voEnnpQbHCMhsnUKVLJy8GSVdor/R9z0ABmqtfF4YB1TTG0
        ZyrfJzqQHpd+m4DlFG2R7g==
X-Google-Smtp-Source: ABdhPJzKDWd6vBFFNsqBd4lZyEsZpnUl3yI1fJXxIsRANiAi/P4L/f0feB7E4LSMjdWW3N4GAg6dLg==
X-Received: by 2002:a4a:2f81:: with SMTP id p123mr36268575oop.77.1641493528400;
        Thu, 06 Jan 2022 10:25:28 -0800 (PST)
Received: from xps15.herring.priv (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.googlemail.com with ESMTPSA id r13sm484949oth.21.2022.01.06.10.25.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jan 2022 10:25:27 -0800 (PST)
From:   Rob Herring <robh@kernel.org>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>
Cc:     linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: clock: imx5: Drop clock consumer node from example
Date:   Thu,  6 Jan 2022 12:25:09 -0600
Message-Id: <20220106182518.1435497-1-robh@kernel.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The example nodes have different sized interrupt cells which is not valid
given no interrupt-parent is specified. As provider examples don't need to
show the consumer side in the first place, just drop the consumer node.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/clock/imx5-clock.yaml | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/Documentation/devicetree/bindings/clock/imx5-clock.yaml b/Documentation/devicetree/bindings/clock/imx5-clock.yaml
index b1740d7abe68..c0e19ff92c76 100644
--- a/Documentation/devicetree/bindings/clock/imx5-clock.yaml
+++ b/Documentation/devicetree/bindings/clock/imx5-clock.yaml
@@ -55,11 +55,4 @@ examples:
                      <0 72 IRQ_TYPE_LEVEL_HIGH>;
         #clock-cells = <1>;
     };
-
-    can@53fc8000 {
-        compatible = "fsl,imx53-flexcan", "fsl,imx25-flexcan";
-        reg = <0x53fc8000 0x4000>;
-        interrupts = <82>;
-        clocks = <&clks IMX5_CLK_CAN1_IPG_GATE>, <&clks IMX5_CLK_CAN1_SERIAL_GATE>;
-        clock-names = "ipg", "per";
-    };
+...
-- 
2.32.0

