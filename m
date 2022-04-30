Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63D27515D67
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Apr 2022 15:13:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382698AbiD3NQl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Apr 2022 09:16:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382699AbiD3NQW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Apr 2022 09:16:22 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31FB282D31
        for <linux-kernel@vger.kernel.org>; Sat, 30 Apr 2022 06:13:01 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id o12-20020a1c4d0c000000b00393fbe2973dso7489485wmh.2
        for <linux-kernel@vger.kernel.org>; Sat, 30 Apr 2022 06:13:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=conchuod-ie.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xYRDXpY3Iw2Mp2L+0vKKbLbTXTTo1snejpw1fL9RgNM=;
        b=U53G3o1zO2TfWVlvRkK8i7XxN1whWKxR20syfYHosot0Pj91VzSi2LEyZqdDh7kfrq
         ESp4RBFRHnhhskiNmRD0FQKf6Rtu9nmKrIFYAqzhmJ8/+4/60Th4hpZyD9Syi36FgMO4
         gROxG2a2Es4t3+lm80t5o+PqPMvWZ0J+jEKDboaBDO8QVWYVmqH7rGMwXwesYGbz9HYf
         Oi5chDxwdMKBkgf+reDZAEeg9+SCarqF6U7DVhUt6lEqCssDu4HlxGgiiJjk/zKAKWeE
         nhIcoJlms6omOF0Z5ScPUvuhmiPG8Lii5VTQC57WigTFac9JUR1kOn6++7lZ4+14BDIW
         zQaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xYRDXpY3Iw2Mp2L+0vKKbLbTXTTo1snejpw1fL9RgNM=;
        b=Dvt92/RrWSyE+PCLzVV0NcCcFWzyRUnyLZXSqacgS2Gm3ImFwETx22zQ1iVlvXkaT4
         YfRERennkJPLFJGP5PCzhLTUTEkrxXAqFzv79epnT9BVQIVA4R88cnmqipuraci/yFzl
         ouXkYw5pH4dOz8yBftv/RGadWHXHD0xDYJeHgIzRH00NmjycKEXY6GQW1yLUmUVU8LQ4
         DTs2rNl8o48UHLPAmXH4wB4bgCVpnZhj58zPXMQM3dysPyr4v9A68/yY4DUMPYjj4yI7
         3qvGNGenfjygefeNGKK2NgBsLaDtRxuQMws7bPEPdXB1qN/VNK/o1CO74VMhUpbrWYet
         npDw==
X-Gm-Message-State: AOAM530KB6+wb1r/RcL6uOsgAkfWO2mB/YRHSnRj7Akvxn0b73149aZ5
        /TtPkopgUSwfOMetSYkOrWfk0w==
X-Google-Smtp-Source: ABdhPJx5TybxW4mPhyRc1B07zUGZnDh+cnuJd20nySqJGiwWmYa+KtUc1qkRi3Adv3YqzZXrvWGq6A==
X-Received: by 2002:a05:600c:19c6:b0:392:926e:5023 with SMTP id u6-20020a05600c19c600b00392926e5023mr7558948wmq.110.1651324379745;
        Sat, 30 Apr 2022 06:12:59 -0700 (PDT)
Received: from henark71.. ([109.77.36.132])
        by smtp.gmail.com with ESMTPSA id p9-20020adfa209000000b0020c5253d8ebsm2004439wra.55.2022.04.30.06.12.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Apr 2022 06:12:59 -0700 (PDT)
From:   Conor Dooley <mail@conchuod.ie>
To:     krzk+dt@kernel.org, palmer@dabbelt.com, robh+dt@kernel.org
Cc:     conor.dooley@microchip.com, Cyril.Jean@microchip.com,
        daire.mcnamara@microchip.com, paul.walmsley@sifive.com,
        aou@eecs.berkeley.edu, palmer@rivosinc.com, arnd@arndb.de,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, Conor Dooley <mail@conchuod.ie>
Subject: [PATCH v2 6/8] dt-bindings: vendor-prefixes: add Sundance DSP
Date:   Sat, 30 Apr 2022 14:09:21 +0100
Message-Id: <20220430130922.3504268-7-mail@conchuod.ie>
X-Mailer: git-send-email 2.36.0
In-Reply-To: <20220430130922.3504268-1-mail@conchuod.ie>
References: <20220430130922.3504268-1-mail@conchuod.ie>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Conor Dooley <conor.dooley@microchip.com>

Sundance DSP Inc. (https://www.sundancedsp.com/) is a supplier of
high-performance DSP and FPGA processor boards and I/O modules.

Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Conor Dooley <mail@conchuod.ie>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index 01430973ecec..1d47a38c2a2e 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -1197,6 +1197,8 @@ patternProperties:
     description: Summit microelectronics
   "^sunchip,.*":
     description: Shenzhen Sunchip Technology Co., Ltd
+  "^sundance,.*":
+    description: Sundance DSP Inc.
   "^sunplus,.*":
     description: Sunplus Technology Co., Ltd.
   "^SUNW,.*":
-- 
2.36.0

