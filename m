Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42D06560AEC
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 22:11:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230342AbiF2ULk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 16:11:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbiF2ULi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 16:11:38 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 183091BE97;
        Wed, 29 Jun 2022 13:11:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C8CF1B826FC;
        Wed, 29 Jun 2022 20:11:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 649DFC341C8;
        Wed, 29 Jun 2022 20:11:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656533495;
        bh=cvPYtRkUJkulvF6B5y9/eaTzMux14ZpS/4VidSoHfTw=;
        h=From:To:Cc:Subject:Date:From;
        b=Q2mBj6uWK3w/qZRbR2RL1/xLSLuKTWZAG20AhWAIlx5ImSxTk01+Grad9iYvlCQ2M
         in6F9dSHbCuUFchM+Bqaxmdx6G2fEYTdksO9naSgJXxbXXG6aEW0n6tVX0xNBG5LC2
         nWj8MQo/EhS/l/bw53az06UtPuyhUJ8DkS/1Bv6XBuYLsIxpUfVo1BLSjl1TtMS4mC
         XN0WSDwAyQB+lyW+LqlrM5swx3vyRC5823oX3Zxjnpca073L4k8+0rVL6SSh/KzxTq
         pPTrlzbOcS58UlolY/H0SUckJmQJFVfugsH5K0bpEEGKvng5iFAWtxyNS+ZN3Q7R0W
         +Y1rmPjVss1Vw==
From:   Conor Dooley <conor@kernel.org>
To:     Daire McNamara <daire.mcnamara@microchip.com>,
        Ivan Griffin <ivan.griffin@microchip.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Palmer Dabbelt <palmer@rivosinc.com>,
        linux-riscv@lists.infradead.org
Cc:     Conor Dooley <conor.dooley@microchip.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Atish Patra <atishp@atishpatra.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] riscv: dts: microchip: hook up the mpfs' l2cache
Date:   Wed, 29 Jun 2022 21:07:33 +0100
Message-Id: <20220629200732.4039258-1-conor@kernel.org>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Conor Dooley <conor.dooley@microchip.com>

The initial PolarFire SoC devicetree must have been forked off from
the fu540 one prior to the addition of l2cache controller support being
added there. When the controller node was added to mpfs.dtsi, it was
not hooked up to the CPUs & thus sysfs reports an incorrect cache
configuration. Hook it up.

Fixes: 0fa6107eca41 ("RISC-V: Initial DTS for Microchip ICICLE board")
Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
 arch/riscv/boot/dts/microchip/mpfs.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/riscv/boot/dts/microchip/mpfs.dtsi b/arch/riscv/boot/dts/microchip/mpfs.dtsi
index 3095d08453a1..496d3b7642bd 100644
--- a/arch/riscv/boot/dts/microchip/mpfs.dtsi
+++ b/arch/riscv/boot/dts/microchip/mpfs.dtsi
@@ -50,6 +50,7 @@ cpu1: cpu@1 {
 			riscv,isa = "rv64imafdc";
 			clocks = <&clkcfg CLK_CPU>;
 			tlb-split;
+			next-level-cache = <&cctrllr>;
 			status = "okay";
 
 			cpu1_intc: interrupt-controller {
@@ -77,6 +78,7 @@ cpu2: cpu@2 {
 			riscv,isa = "rv64imafdc";
 			clocks = <&clkcfg CLK_CPU>;
 			tlb-split;
+			next-level-cache = <&cctrllr>;
 			status = "okay";
 
 			cpu2_intc: interrupt-controller {
@@ -104,6 +106,7 @@ cpu3: cpu@3 {
 			riscv,isa = "rv64imafdc";
 			clocks = <&clkcfg CLK_CPU>;
 			tlb-split;
+			next-level-cache = <&cctrllr>;
 			status = "okay";
 
 			cpu3_intc: interrupt-controller {
@@ -131,6 +134,7 @@ cpu4: cpu@4 {
 			riscv,isa = "rv64imafdc";
 			clocks = <&clkcfg CLK_CPU>;
 			tlb-split;
+			next-level-cache = <&cctrllr>;
 			status = "okay";
 			cpu4_intc: interrupt-controller {
 				#interrupt-cells = <1>;
-- 
2.36.1

