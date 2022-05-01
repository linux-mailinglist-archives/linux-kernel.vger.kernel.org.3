Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E469A516772
	for <lists+linux-kernel@lfdr.de>; Sun,  1 May 2022 21:27:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353815AbiEATaI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 May 2022 15:30:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353330AbiEAT37 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 May 2022 15:29:59 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E4C72DD5B
        for <linux-kernel@vger.kernel.org>; Sun,  1 May 2022 12:26:32 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id d5so17214828wrb.6
        for <linux-kernel@vger.kernel.org>; Sun, 01 May 2022 12:26:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=conchuod-ie.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zcvxHzb8OEubR0d3ZnHVsyg60KtZpqMvRiCsHiDvd8A=;
        b=zmvjifVBMhvWtlSbfD6GknK+sGxQw5lmp2CdidzKMySBsRWio/x/EBc0knxEwLAJqD
         xNgwTI3DlroxWOBZk2bi+IsFDBapRLMpSfqJDmY7w693n71jV5zY7af51hrUhs1aem/c
         KYyBa9euUbjwCp0z83uEkDdOq9FkBLrXbk+LBBKVeM4l4xBaNw6RFrLgfGG/aiNqUMlt
         9bNSIXFZKjmdEwbGlqq37qsd61BjDo2wMPP/9wtML9e+Bv+Ifz818O+jlWH1rfPcsOJN
         y6qmBNgfXAhU/LZ4pJwVXIWaUbdPOlaFEAz/aRkdPe17neTU8EejQhMpkiBYwg5hgE53
         uj5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zcvxHzb8OEubR0d3ZnHVsyg60KtZpqMvRiCsHiDvd8A=;
        b=uvzfoHZa1lVgZYF7JVaf7utjeFDgjuSGZWxZkwmiG6Oc/I0Xom8fQqp4+y86300nGh
         bp7A9FMMcW/rq1PgQhQiPyd0HrsyMA4IwWLo3stcMx7PjMkTN2SXNLs3aCeYCp4EIjWe
         2TQSpgkejm27VxfOPfZc77SirAxK2cauDxd9GR12lMpCJTXjjkX5kG4EYJsnW+Fg0R3j
         rAQ8MaN2K0Hus4ot1KtVTYlWzfPZ3MQmPlcaBpZJJZ8CNiQOiQ1Py00D0ca/Gf/fHFpa
         7eEOjKidDa9GjgNo0JsTrzvR34FrOeRNOj8CyhSA5QR4H0v/L6CIZANCl4zVBySDLbvM
         3dUw==
X-Gm-Message-State: AOAM533WsmR/Kr6MHa5efeJks8BDCcRr4XXCCMSNiGAE6/hAC5x9OZJF
        pERKb+5Kb+X9ViGpR1htlwb1Jw==
X-Google-Smtp-Source: ABdhPJyBlI2wdfs0sSoJucBsSoo1njFepselO+gh2XCZSXanB2H2/0VGN6ShlVVMbnFZFcL2pe/YAw==
X-Received: by 2002:a5d:6345:0:b0:20a:d69f:8126 with SMTP id b5-20020a5d6345000000b0020ad69f8126mr6947931wrw.276.1651433190882;
        Sun, 01 May 2022 12:26:30 -0700 (PDT)
Received: from henark71.. ([109.77.36.132])
        by smtp.gmail.com with ESMTPSA id i14-20020adfa50e000000b0020c5253d8c6sm6448105wrb.18.2022.05.01.12.26.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 May 2022 12:26:30 -0700 (PDT)
From:   Conor Dooley <mail@conchuod.ie>
To:     krzk+dt@kernel.org, palmer@dabbelt.com, robh+dt@kernel.org
Cc:     conor.dooley@microchip.com, Cyril.Jean@microchip.com,
        daire.mcnamara@microchip.com, paul.walmsley@sifive.com,
        aou@eecs.berkeley.edu, palmer@rivosinc.com, arnd@arndb.de,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: [PATCH v3 1/8] riscv: dts: microchip: remove icicle memory clocks
Date:   Sun,  1 May 2022 20:25:52 +0100
Message-Id: <20220501192557.2631936-2-mail@conchuod.ie>
X-Mailer: git-send-email 2.36.0
In-Reply-To: <20220501192557.2631936-1-mail@conchuod.ie>
References: <20220501192557.2631936-1-mail@conchuod.ie>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Conor Dooley <conor.dooley@microchip.com>

The clock properties in the icicle kit's memory entries cause dtbs_check
errors:
arch/riscv/boot/dts/microchip/microchip-mpfs-icicle-kit.dtb: /: memory@80000000: 'clocks' does not match any of the regexes: 'pinctrl-[0-9]+'

Get rid of the clocks to avoid the errors.

Reported-by: Palmer Dabbelt <palmer@rivosinc.com>
Fixes: 0fa6107eca41 ("RISC-V: Initial DTS for Microchip ICICLE board")
Fixes: 5b28df37d311 ("riscv: dts: microchip: update peripherals in icicle kit device tree")
Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
 arch/riscv/boot/dts/microchip/microchip-mpfs-icicle-kit.dts | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/riscv/boot/dts/microchip/microchip-mpfs-icicle-kit.dts b/arch/riscv/boot/dts/microchip/microchip-mpfs-icicle-kit.dts
index 3392153dd0f1..c71d6aa6137a 100644
--- a/arch/riscv/boot/dts/microchip/microchip-mpfs-icicle-kit.dts
+++ b/arch/riscv/boot/dts/microchip/microchip-mpfs-icicle-kit.dts
@@ -32,14 +32,12 @@ cpus {
 	ddrc_cache_lo: memory@80000000 {
 		device_type = "memory";
 		reg = <0x0 0x80000000 0x0 0x2e000000>;
-		clocks = <&clkcfg CLK_DDRC>;
 		status = "okay";
 	};
 
 	ddrc_cache_hi: memory@1000000000 {
 		device_type = "memory";
 		reg = <0x10 0x0 0x0 0x40000000>;
-		clocks = <&clkcfg CLK_DDRC>;
 		status = "okay";
 	};
 };
-- 
2.36.0

