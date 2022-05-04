Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9940A51ACD7
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 20:30:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353662AbiEDSdK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 14:33:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355371AbiEDScv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 14:32:51 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C26FA5AED8
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 11:09:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8E325B82753
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 18:09:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2671AC385A4;
        Wed,  4 May 2022 18:09:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651687767;
        bh=3kqhCh3SolC+njYvrb7YQlbkMsd43/qschNFbE7v3Ws=;
        h=From:To:Cc:Subject:Date:From;
        b=il4XHKFtZrHDm4R3lYlPB+0PXkhshnPKaJhlUEv5+5oFwY8GwlWrgOodHjYI9OSzP
         uMd5kuvN1bSfQbJM5nzIDpsr2oXt5540xxSoG+3Bym0+CjnPlFZcBhxTcWwokhKJZB
         SG7uK52bxDbXhk82tr5fbuNS4F6cVWetEWMx+uanTleLnUccgDLYhXf0sLehRvd+mL
         2izCqUROVPJMZpGotj5rYScky6sgw+QqMiHS1eGl9iI6tT2dYt0fvJPeliii7CyVEl
         IsFZQOENiTQ8Hr9dRf+BLmAv9grs6aJOcgGcutV2ynOVCXDGbYa0dIJGEw5iDgNRpN
         mM7tiaxAAs81w==
Received: by pali.im (Postfix)
        id 7AA0996D; Wed,  4 May 2022 20:09:24 +0200 (CEST)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH] powerpc/85xx: P2020: Add law_trgt_if property to PCIe DT nodes
Date:   Wed,  4 May 2022 20:08:22 +0200
Message-Id: <20220504180822.29782-1-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DT law_trgt_if property defines Local Access Window Target Interface.

Local Access Window Target Interface is used for identifying individual
peripheral and mapping its memory to CPU. Interface id is defined by
hardware itself.

U-Boot uses law_trgt_if DT property in PCIe nodes for configuring memory
mapping of individual PCIe controllers.

Linux kernel fsl_pci.c driver currently does not touch Local Access Window
and expects that U-Boot configures it properly.

Add law_trgt_if property to PCIe DT nodes for P2020. This allows usage of
kernel P2020 PCIe DT nodes in U-Boot. And therefore allows to share P2020
DTS files between Linux kernel and U-Boot.

Signed-off-by: Pali Rohár <pali@kernel.org>
---
 arch/powerpc/boot/dts/fsl/p2020si-post.dtsi | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/powerpc/boot/dts/fsl/p2020si-post.dtsi b/arch/powerpc/boot/dts/fsl/p2020si-post.dtsi
index 884e01bcb243..6345629524fe 100644
--- a/arch/powerpc/boot/dts/fsl/p2020si-post.dtsi
+++ b/arch/powerpc/boot/dts/fsl/p2020si-post.dtsi
@@ -48,6 +48,7 @@
 	bus-range = <0 255>;
 	clock-frequency = <33333333>;
 	interrupts = <26 2 0 0>;
+	law_trgt_if = <2>;
 
 	pcie@0 {
 		reg = <0 0 0 0 0>;
@@ -76,6 +77,7 @@
 	bus-range = <0 255>;
 	clock-frequency = <33333333>;
 	interrupts = <25 2 0 0>;
+	law_trgt_if = <1>;
 
 	pcie@0 {
 		reg = <0 0 0 0 0>;
@@ -105,6 +107,7 @@
 	bus-range = <0 255>;
 	clock-frequency = <33333333>;
 	interrupts = <24 2 0 0>;
+	law_trgt_if = <0>;
 
 	pcie@0 {
 		reg = <0 0 0 0 0>;
-- 
2.20.1

