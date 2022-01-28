Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BDAA49F5FF
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 10:09:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238053AbiA1JJk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 04:09:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347483AbiA1JHm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 04:07:42 -0500
Received: from albert.telenet-ops.be (albert.telenet-ops.be [IPv6:2a02:1800:110:4::f00:1a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C4BCC06173B
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jan 2022 01:07:42 -0800 (PST)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed40:3999:e79d:cb59:f2ec])
        by albert.telenet-ops.be with bizsmtp
        id o97e2600p04fKGS0697fYU; Fri, 28 Jan 2022 10:07:40 +0100
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1nDNEI-00BjuV-NZ; Fri, 28 Jan 2022 10:07:38 +0100
Received: from geert by rox.of.borg with local (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1nDNEH-005psG-W2; Fri, 28 Jan 2022 10:07:37 +0100
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Anup Patel <anup.patel@wdc.com>
Cc:     Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v4 1/2] dt-bindings: timer: sifive,clint: Fix number of interrupts
Date:   Fri, 28 Jan 2022 10:07:35 +0100
Message-Id: <e6a4c5b20d2acb52125d7d6e6c7e3694d7cb182c.1643360652.git.geert@linux-m68k.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1643360652.git.geert@linux-m68k.org>
References: <cover.1643360652.git.geert@linux-m68k.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The number of interrupts lacks an upper bound, thus assuming one,
causing properly grouped "interrupts-extended" properties to be flagged
as an error by "make dtbs_check".

Fix this by adding the missing "maxItems", using the architectural
maximum of 4095 interrupts.

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
Acked-by: Rob Herring <robh@kernel.org>
---
v4:
  - Use architectural maximum instead of practical maximum of 10,

v3:
  - Add Acked-by,

v2:
  - Split in two patches,
  - Improve patch description and document limit rationale.
---
 Documentation/devicetree/bindings/timer/sifive,clint.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/timer/sifive,clint.yaml b/Documentation/devicetree/bindings/timer/sifive,clint.yaml
index 8d5f4687add9e81e..fe4b73c3f269fc0f 100644
--- a/Documentation/devicetree/bindings/timer/sifive,clint.yaml
+++ b/Documentation/devicetree/bindings/timer/sifive,clint.yaml
@@ -44,6 +44,7 @@ properties:
 
   interrupts-extended:
     minItems: 1
+    maxItems: 4095
 
 additionalProperties: false
 
-- 
2.25.1

