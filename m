Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C6E050983B
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 09:05:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385433AbiDUG6O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 02:58:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1385478AbiDUG5G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 02:57:06 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A2FD626D
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 23:54:12 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id el3so427520edb.11
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 23:54:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2k962TOjn9cIi6o9LRxiYucZxC9pwRel/qitgtJoDBU=;
        b=JYDD1qZpPGR/23UluceME28UFtKcOuJxb1BZ8dVkZybOHtfk4ybxP9bbwZrvl6jw4b
         81YBFppebQ4aCbV7i4KJPR2IdOR/l1f+vTM6ovEg95jJNK9DpKKDuG4WjpWZYIVBo751
         sE9LjD3acE39pE8BQVs9VjAeoRiNIakXJ6SrAF6kzAXD2AEenXWFPN5sY8btu0nLFxfp
         Nx+MkQs3it3X5JKC2V1R4xm7qlsSZvrpgOTWMjVyLWTeyfKsHafwp2qrNhwfx3YziT30
         DXi55Uq14K0rynaEKWd6Ok0Jb0W/BWBa+GrfdabsfysVWdB5+BHOCS8XOb0fSWet22qz
         9fNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2k962TOjn9cIi6o9LRxiYucZxC9pwRel/qitgtJoDBU=;
        b=y1nMrUSaIIOE0cQNeMsaSb/fvu6oFPuOFovAx8aNZ1QFM1/9rUIY+e9U8r30Kv4s6g
         6rrhetWRknqUG8RnWxFuUk/W+O6eD38YxG4iIUqD2gdosp+j94qWB/KL+9YcidRJPcS+
         vxGp2DEGWomWsVPV5oz4J7i08ar+D+TDiWAFTEAz9RtBy5k49KbdzQNcnZ3QxiP3nNlW
         CWGvXjY+S+bkdN9Ln+ilvnh0hYxp7l2oZZgmXQ3TVKDiqnm0gnkNq8bzADa1Wkg/UWfI
         rpC30gcFum6J3corITijxVBxNKfxx1VtD5tNrjly8MsL4buhVAN2EF47qnkiBsFVScMl
         zx1w==
X-Gm-Message-State: AOAM533+zmjM/k7XI6Z7BrGqozotWV4CBtYC/fITtCl5tOL++KKVv64O
        m2PlzXvxL6bO5w4ftHjmlZszIQ==
X-Google-Smtp-Source: ABdhPJzaklLC0LHx5HR8/i9VgTcXq5QbPfI6GUUCc4D+Iszuqzt/hY1yo3+e5Qa3tW2Mc545sh7adA==
X-Received: by 2002:a05:6402:4493:b0:41d:83ca:35d6 with SMTP id er19-20020a056402449300b0041d83ca35d6mr2254118edb.89.1650524050755;
        Wed, 20 Apr 2022 23:54:10 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id kb28-20020a1709070f9c00b006d5d8bf1b72sm7456045ejc.78.2022.04.20.23.54.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Apr 2022 23:54:10 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Zong Li <zong.li@sifive.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Bin Meng <bmeng.cn@gmail.com>, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] riscv: dts: fu540-c000: fix duplicated dma compatible
Date:   Thu, 21 Apr 2022 08:54:01 +0200
Message-Id: <20220421065401.9303-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove duplicated compatible to fix error:

  u540-c000.dtsi:171.4-42: ERROR (duplicate_property_names): /soc/dma@3000000:compatible: Duplicate property name

Fixes: 7eba954a8de8 ("riscv: dts: Add dma-channels property and modify compatible")
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/riscv/boot/dts/sifive/fu540-c000.dtsi | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/riscv/boot/dts/sifive/fu540-c000.dtsi b/arch/riscv/boot/dts/sifive/fu540-c000.dtsi
index fa8c18c0e5b0..7ea6300191a5 100644
--- a/arch/riscv/boot/dts/sifive/fu540-c000.dtsi
+++ b/arch/riscv/boot/dts/sifive/fu540-c000.dtsi
@@ -168,7 +168,6 @@ uart0: serial@10010000 {
 			status = "disabled";
 		};
 		dma: dma@3000000 {
-			compatible = "sifive,fu540-c000-pdma";
 			compatible = "sifive,fu540-c000-pdma", "sifive,pdma0";
 			reg = <0x0 0x3000000 0x0 0x8000>;
 			interrupt-parent = <&plic0>;
-- 
2.32.0

