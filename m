Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8960490002
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 02:35:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236789AbiAQBfr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Jan 2022 20:35:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236757AbiAQBfl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jan 2022 20:35:41 -0500
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB070C061574
        for <linux-kernel@vger.kernel.org>; Sun, 16 Jan 2022 17:35:40 -0800 (PST)
Received: by mail-pg1-x530.google.com with SMTP id t32so9197671pgm.7
        for <linux-kernel@vger.kernel.org>; Sun, 16 Jan 2022 17:35:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=95yOM2oPjDW4I8teUQkYRlUXa8kIk+GmIx7gO72jBTY=;
        b=P+GoisCraOgxlHu4ekz372AMVjqGk0k3oxAotFVY+JXZ1wKhghK/9VUBiHjSULBAuP
         YT4wwsz1owUO6iPKiWsGy1oGSOL98t8npnafFRWj4DEjOXLcNTXLnrLnipNYmy/X/59V
         zv0G3qMbqQOTkecphSBHdfCzauar+Qn4EvJPR8jFtiEevja0Dtfpo2IarctGfKHjFxDk
         RDRT+OUyc72T9apyF/om+OYvNxSz/TyAz0HE3JwmeR91oHCM5yiG8rB9AraAmv3V5Uyr
         V34ti5X4PUmue5qVTDpJii8D9glNa22wkQgNu9rqk8ukaXF1h0hiqtROVWDQaiPGjKfM
         7mFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=95yOM2oPjDW4I8teUQkYRlUXa8kIk+GmIx7gO72jBTY=;
        b=6P/HdCMn5g8l/n34UzaFWEpcmWMFNEHsFcekV8rCfkaJ6zh9bWgXvNAz+/mQcfpbVp
         SOq+3RWo26iPktfKkhCZSrrChvfEOp1EVaecWGeCqPOZrRE8AnILsTheTMPq88E5aLo9
         BJ67GbO+1kP4bhEquarCwQVoBlA6FDJfpE7G0cGB2V4JM3gAIR72ZAVeSSvTlRExS4pK
         OS5njkdAhc0p9aj3UdcyqJOP6/kndTAWv2/EQcHv4ZVlqHhZWdOA2TKNYWXC/uhmndgn
         hmgkHw1cJlN9ibxv7dpTvlNaYVisMugTtnIueVnotJj7uMGDMrdRUiuMCB2f0QNXuJSs
         4HcQ==
X-Gm-Message-State: AOAM531+QNsxDS0Xkb17qpzrv/vrdVgGIaoHP/OW6NvGfhNW/+DsL8X2
        0A7eSIqeGovRz/je93NajJUC3g==
X-Google-Smtp-Source: ABdhPJzYYuCt8lJjXiFcWFdBW421Oc4GF3QS64Lff1lAlXxFDNO5aZc7/9nqJvZybIZwWwo2dzrwBQ==
X-Received: by 2002:a63:284:: with SMTP id 126mr16642095pgc.328.1642383340489;
        Sun, 16 Jan 2022 17:35:40 -0800 (PST)
Received: from hsinchu16.internal.sifive.com (59-124-168-89.hinet-ip.hinet.net. [59.124.168.89])
        by smtp.gmail.com with ESMTPSA id l1sm10008335pgn.35.2022.01.16.17.35.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Jan 2022 17:35:39 -0800 (PST)
From:   Zong Li <zong.li@sifive.com>
To:     robh+dt@kernel.org, paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, krzysztof.kozlowski@canonical.com,
        conor.dooley@microchip.com, geert@linux-m68k.org,
        bin.meng@windriver.com, green.wan@sifive.com, vkoul@kernel.org,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Cc:     Zong Li <zong.li@sifive.com>
Subject: [PATCH v4 2/3] dt-bindings: Add dma-channels for pdma device node
Date:   Mon, 17 Jan 2022 09:35:27 +0800
Message-Id: <5db314b798cd9cfcb5cb61bc56515220b7d50315.1642383007.git.zong.li@sifive.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1642383007.git.zong.li@sifive.com>
References: <cover.1642383007.git.zong.li@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add dma-channels property, then we can determine how many channels there
by device tree, rather than statically defines it in PDMA driver

Signed-off-by: Zong Li <zong.li@sifive.com>
---
 .../devicetree/bindings/dma/sifive,fu540-c000-pdma.yaml    | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/dma/sifive,fu540-c000-pdma.yaml b/Documentation/devicetree/bindings/dma/sifive,fu540-c000-pdma.yaml
index d32a71b975fe..3dbb8caefc17 100644
--- a/Documentation/devicetree/bindings/dma/sifive,fu540-c000-pdma.yaml
+++ b/Documentation/devicetree/bindings/dma/sifive,fu540-c000-pdma.yaml
@@ -34,6 +34,12 @@ properties:
     minItems: 1
     maxItems: 8
 
+  dma-channels:
+    description: For backwards-compatible, the default value is 4
+    minimum: 1
+    maximum: 4
+    default: 4
+
   '#dma-cells':
     const: 1
 
@@ -50,6 +56,7 @@ examples:
     dma@3000000 {
       compatible = "sifive,fu540-c000-pdma";
       reg = <0x3000000 0x8000>;
+      dma-channels = <4>;
       interrupts = <23 24 25 26 27 28 29 30>;
       #dma-cells = <1>;
     };
-- 
2.31.1

