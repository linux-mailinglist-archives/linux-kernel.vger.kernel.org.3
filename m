Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA59447735D
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 14:41:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237650AbhLPNlc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 08:41:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237634AbhLPNla (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 08:41:30 -0500
Received: from baptiste.telenet-ops.be (baptiste.telenet-ops.be [IPv6:2a02:1800:120:4::f00:13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34596C06173F
        for <linux-kernel@vger.kernel.org>; Thu, 16 Dec 2021 05:41:29 -0800 (PST)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed20:d13f:527c:5504:a743])
        by baptiste.telenet-ops.be with bizsmtp
        id X1hT26006250X30011hTeg; Thu, 16 Dec 2021 14:41:27 +0100
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1mxr0g-005QFd-Jk; Thu, 16 Dec 2021 14:41:26 +0100
Received: from geert by rox.of.borg with local (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1mxr0g-009y1T-4P; Thu, 16 Dec 2021 14:41:26 +0100
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Sagar Kadam <sagar.kadam@sifive.com>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH v2 1/2] dt-bindings: interrupt-controller: sifive,plic: Fix number of interrupts
Date:   Thu, 16 Dec 2021 14:41:21 +0100
Message-Id: <41942eec41ccdf9831648c600d149af5e5f652a2.1639661878.git.geert@linux-m68k.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1639661878.git.geert@linux-m68k.org>
References: <cover.1639661878.git.geert@linux-m68k.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The number of interrupts lacks an upper bound, thus assuming one,
causing properly grouped "interrupts-extended" properties to be flagged
as an error by "make dtbs_check".

Fix this by adding the missing "maxItems".  As the architectural maximum
is 15872 interrupts, using that as the limit would be unpractical.
Hence limit it to 9 interrupts (one interrupt for a system management
core, and two interrupts per core for other cores).  This should be
sufficient for now, and the limit can always be increased when the need
arises.

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
v2:
  - Split in two patches,
  - Improve patch description and document limit rationale.
---
 .../bindings/interrupt-controller/sifive,plic-1.0.0.yaml         | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.yaml b/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.yaml
index 28b6b17fe4b26778..0c6687511457413e 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.yaml
+++ b/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.yaml
@@ -62,6 +62,7 @@ properties:
 
   interrupts-extended:
     minItems: 1
+    maxItems: 9
     description:
       Specifies which contexts are connected to the PLIC, with "-1" specifying
       that a context is not present. Each node pointed to should be a
-- 
2.25.1

