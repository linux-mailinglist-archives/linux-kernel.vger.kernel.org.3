Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 792B14A308E
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jan 2022 17:28:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352555AbiA2Q17 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Jan 2022 11:27:59 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:38948 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352554AbiA2Q15 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jan 2022 11:27:57 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7491CB827EB;
        Sat, 29 Jan 2022 16:27:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C535CC340E5;
        Sat, 29 Jan 2022 16:27:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643473675;
        bh=ydnuLLSPbVTwByYCzZeq7vAqtnlXTC8PzWC+C5Q2PZA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kq2OEZlH40g7mVhiQJfp0QxCdUMjSXPRpPBv7zi2hEwFsOYVsWJhp4JOK/qMqpVgb
         /D+T95hNdvibZltIfi+FRsOa6Ujp072kNWEsWEA4rSyjg+ZwpnlvgZMkZEcADmEIne
         XbK98sVARkN0PZZmgrTnV1Gg76pfi9rlPUG14az8AgcLZ1YErjzwIVJOB/8zfRLCvk
         9zyxBwGqohpVdN0Pok41whgXKcGgQ1IvTvS9YZYx6MKZFTDF7AGV0Ytv/a31LbgOl9
         RLT5WnzN62xgIATWdaubqgM7+CS5N1iyNFUjQ0eZhjrbIs5SbpzXPERd1FCbiqce86
         IT6530KsMea5Q==
From:   guoren@kernel.org
To:     guoren@kernel.org, anup@brainfault.org, maz@kernel.org,
        tglx@linutronix.de, palmer@dabbelt.com, samuel@sholland.org
Cc:     linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        devicetree@vger.kernel.org, Guo Ren <guoren@linux.alibaba.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Rob Herring <robh@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Palmer Dabbelt <palmerdabbelt@google.com>
Subject: [PATCH V6 1/2] dt-bindings: update riscv plic compatible string
Date:   Sun, 30 Jan 2022 00:27:25 +0800
Message-Id: <20220129162726.1154501-2-guoren@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220129162726.1154501-1-guoren@kernel.org>
References: <20220129162726.1154501-1-guoren@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Guo Ren <guoren@linux.alibaba.com>

Add the compatible string "thead,c900-plic" to the riscv plic
bindings to support allwinner d1 SOC which contains c906 core.

Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
Cc: Anup Patel <anup@brainfault.org>
Cc: Heiko Stuebner <heiko@sntech.de>
Cc: Rob Herring <robh@kernel.org>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Palmer Dabbelt <palmerdabbelt@google.com>
Cc: Samuel Holland <samuel@sholland.org>
---
 .../sifive,plic-1.0.0.yaml                    | 21 +++++++++++++------
 1 file changed, 15 insertions(+), 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.yaml b/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.yaml
index 28b6b17fe4b2..1fa5aa7e4c2e 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.yaml
+++ b/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.yaml
@@ -35,6 +35,10 @@ description:
   contains a specific memory layout, which is documented in chapter 8 of the
   SiFive U5 Coreplex Series Manual <https://static.dev.sifive.com/U54-MC-RVCoreIP.pdf>.
 
+  The thead,c900-plic is different from sifive,plic-1.0.0 in opensbi, the
+  T-HEAD PLIC implementation requires setting a delegation bit to allow access
+  from S-mode. So add thead,c900-plic to distinguish them.
+
 maintainers:
   - Sagar Kadam <sagar.kadam@sifive.com>
   - Paul Walmsley  <paul.walmsley@sifive.com>
@@ -42,12 +46,17 @@ maintainers:
 
 properties:
   compatible:
-    items:
-      - enum:
-          - sifive,fu540-c000-plic
-          - starfive,jh7100-plic
-          - canaan,k210-plic
-      - const: sifive,plic-1.0.0
+    oneOf:
+      - items:
+          - enum:
+              - sifive,fu540-c000-plic
+              - starfive,jh7100-plic
+              - canaan,k210-plic
+          - const: sifive,plic-1.0.0
+      - items:
+          - enum:
+              - allwinner,sun20i-d1-plic
+          - const: thead,c900-plic
 
   reg:
     maxItems: 1
-- 
2.25.1

