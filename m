Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5194749F5E5
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 10:04:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243369AbiA1JE3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 04:04:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237214AbiA1JEG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 04:04:06 -0500
Received: from laurent.telenet-ops.be (laurent.telenet-ops.be [IPv6:2a02:1800:110:4::f00:19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E8E0C06174A
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jan 2022 01:04:04 -0800 (PST)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed40:3999:e79d:cb59:f2ec])
        by laurent.telenet-ops.be with bizsmtp
        id o9402600X04fKGS01940tC; Fri, 28 Jan 2022 10:04:01 +0100
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1nDNAm-00BjtA-79; Fri, 28 Jan 2022 10:04:00 +0100
Received: from geert by rox.of.borg with local (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1nDNAl-005poh-He; Fri, 28 Jan 2022 10:03:59 +0100
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Sagar Kadam <sagar.kadam@sifive.com>
Cc:     Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v4 1/2] dt-bindings: interrupt-controller: sifive,plic: Fix number of interrupts
Date:   Fri, 28 Jan 2022 10:03:57 +0100
Message-Id: <f73a0aead89e1426b146c4c64f797aa035868bf0.1643360419.git.geert@linux-m68k.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1643360419.git.geert@linux-m68k.org>
References: <cover.1643360419.git.geert@linux-m68k.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The number of interrupts lacks an upper bound, thus assuming one,
causing properly grouped "interrupts-extended" properties to be flagged
as an error by "make dtbs_check".

Fix this by adding the missing "maxItems", using the architectural
maximum of 15872 interrupts.

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
Acked-by: Rob Herring <robh@kernel.org>
---
v4:
  - Use architectural maximum instead of practical maximum of 9,

v3:
  - Add Acked-by,

v2:
  - Split in two patches,
  - Improve patch description and document limit rationale.
---
 .../bindings/interrupt-controller/sifive,plic-1.0.0.yaml         | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.yaml b/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.yaml
index 28b6b17fe4b26778..57c06126c99502fa 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.yaml
+++ b/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.yaml
@@ -62,6 +62,7 @@ properties:
 
   interrupts-extended:
     minItems: 1
+    maxItems: 15872
     description:
       Specifies which contexts are connected to the PLIC, with "-1" specifying
       that a context is not present. Each node pointed to should be a
-- 
2.25.1

