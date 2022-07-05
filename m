Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2D615679B1
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 23:53:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232662AbiGEVws (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 17:52:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231714AbiGEVwd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 17:52:33 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 820E9140F8
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jul 2022 14:52:31 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id z12so9786908wrq.7
        for <linux-kernel@vger.kernel.org>; Tue, 05 Jul 2022 14:52:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=conchuod.ie; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RIjyo+v4SVWXgjNDfjVuAJAWZ8Bxe92vN1FxyPqfbiA=;
        b=HqLk5zcJWf6yjk0sm6LnL2fNfSHxlMYcx2NwuUldwgNT7LBQbNK8U+CHNU22ohSZfX
         jfsOHnehMji+CkgBY81zgji8jbKG0uw9RDIRgMLentiuJYYOTmn4nVjRS8OlckRy5WTc
         aX7ZxCMNVzNmvoEFSO/1DsXl9LYItNkpj43Am1GvNm/28n8AUqF+L4SddAB0dE0UISfW
         OTEm1sYYtkE0SainnUlBfSPT2PNzJ8nj5JUUbWlj2bCJAtBeTjiQXgsP840dxXt/sT4U
         VAXXJ1jT0os0tnSlMnOAkFvKzIeMM2ToW1M5kBy5hxQ8nGJ29djq+DavH3lQBSjizXUT
         gUYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RIjyo+v4SVWXgjNDfjVuAJAWZ8Bxe92vN1FxyPqfbiA=;
        b=kCo7deFVSJYsa4f6WCncbyyp2MsVaGuNrnFJ7thK7UqDxKyRfc1nHBKAy/1jXh4WEw
         ID6RXXZRKx/q7ZL/+NEnNEkgAIcV1EIIAOkNdP0hbes46tiHQ3YgiOdgUL926Kuwnb8l
         YwMGXkG4t1yu7hxmJt2G9YlSHPfErvynw04WmmX8jV6b7syvqVrCjMhsJW1sdImxyxP7
         7BsZ9NYwqKY7tTpn3iqUgLVo1uWH3huwRaJE8U1+pgmBKvmNtVox7NkeqWry5TSOSkvb
         CQNQhK+uiHbrXV8EB0NQ54CpNwD+of/ydJh3t2PyPJR9I2oUjiGoJKSGI4RHTwtYKXZp
         zEvA==
X-Gm-Message-State: AJIora/0zAFdmJ2FPu7RrlqC8eOlQETjmWujXV8sZ6VeOiZCRi2NTKmO
        vESqNn4sBoG7+QJA3/RAS/JLmw==
X-Google-Smtp-Source: AGRyM1vJjQMyrNGX7U/FSTka+YYEasXPf4fPHcSV9Pyiex5jqMICTkfId8wmcqmwizt28warzAehaQ==
X-Received: by 2002:a05:6000:1acc:b0:21c:439c:7074 with SMTP id i12-20020a0560001acc00b0021c439c7074mr32321649wry.686.1657057950904;
        Tue, 05 Jul 2022 14:52:30 -0700 (PDT)
Received: from henark71.. ([51.37.234.167])
        by smtp.gmail.com with ESMTPSA id g34-20020a05600c4ca200b0039c7dbafa7asm18353920wmp.19.2022.07.05.14.52.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Jul 2022 14:52:30 -0700 (PDT)
From:   Conor Dooley <mail@conchuod.ie>
To:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
        Vinod Koul <vkoul@kernel.org>,
        Serge Semin <fancer.lancer@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Palmer Dabbelt <palmer@rivosinc.com>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Conor Dooley <conor.dooley@microchip.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Niklas Cassel <niklas.cassel@wdc.com>,
        Dillon Min <dillon.minfei@gmail.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: [PATCH v5 05/13] riscv: dts: canaan: fix the k210's memory node
Date:   Tue,  5 Jul 2022 22:52:06 +0100
Message-Id: <20220705215213.1802496-6-mail@conchuod.ie>
X-Mailer: git-send-email 2.37.0
In-Reply-To: <20220705215213.1802496-1-mail@conchuod.ie>
References: <20220705215213.1802496-1-mail@conchuod.ie>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Conor Dooley <conor.dooley@microchip.com>

The k210 U-Boot port has been using the clocks defined in the
devicetree to bring up the board's SRAM, but this violates the
dt-schema. As such, move the clocks to a dedicated node with
the same compatible string. The regs property does not fit in
either node, so is replaced by comments.

Tested-by: Niklas Cassel <niklas.cassel@wdc.com>
Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
 arch/riscv/boot/dts/canaan/k210.dtsi | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/arch/riscv/boot/dts/canaan/k210.dtsi b/arch/riscv/boot/dts/canaan/k210.dtsi
index 44d338514761..cd4eae82d8b2 100644
--- a/arch/riscv/boot/dts/canaan/k210.dtsi
+++ b/arch/riscv/boot/dts/canaan/k210.dtsi
@@ -69,11 +69,13 @@ cpu1_intc: interrupt-controller {
 
 	sram: memory@80000000 {
 		device_type = "memory";
+		reg = <0x80000000 0x400000>, /* sram0 4 MiB */
+		      <0x80400000 0x200000>, /* sram1 2 MiB */
+		      <0x80600000 0x200000>; /* aisram 2 MiB */
+	};
+
+	sram_controller: memory-controller {
 		compatible = "canaan,k210-sram";
-		reg = <0x80000000 0x400000>,
-		      <0x80400000 0x200000>,
-		      <0x80600000 0x200000>;
-		reg-names = "sram0", "sram1", "aisram";
 		clocks = <&sysclk K210_CLK_SRAM0>,
 			 <&sysclk K210_CLK_SRAM1>,
 			 <&sysclk K210_CLK_AI>;
-- 
2.37.0

