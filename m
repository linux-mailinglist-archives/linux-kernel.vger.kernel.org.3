Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20CAD53E6D4
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 19:07:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241720AbiFFQa5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 12:30:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241716AbiFFQau (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 12:30:50 -0400
X-Greylist: delayed 62 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 06 Jun 2022 09:30:48 PDT
Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.183])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58E0B331C1C
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 09:30:47 -0700 (PDT)
X-KPN-MessageId: 54269503-e5b5-11ec-8ee3-005056992ed3
Received: from smtp.kpnmail.nl (unknown [10.31.155.7])
        by ewsoutbound.so.kpn.org (Halon) with ESMTPS
        id 54269503-e5b5-11ec-8ee3-005056992ed3;
        Mon, 06 Jun 2022 18:25:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kpnmail.nl; s=kpnmail01;
        h=mime-version:message-id:date:subject:to:from;
        bh=t63OwfhftQBAyL+fD30q+bT1pNxqFcyfuKg2Jivjc+Q=;
        b=NnR5/jMNJy7fKwGLzBDJb+7vKGxpMv6unVQu+wRU6nzH03mDnN54TZX2zuFBwYfIgIZy9JVAnU86A
         cNYoWSn+98xKLKM1s8yf0m/qTohHXKno0oZDU6xpzQ61gPoH84pLhrQkZlwYZpNV8H1UYiYN3FoLw/
         FZe6Qpa3GMUp/iGw=
X-KPN-MID: 33|aL9PUIB7qkWLTPrS0P64JdvWC3henaHPZmFqEnNfYTMTLrlXAfey2k1eZRTcV/G
 JqPqfuq/HDP8UfyOKzoEunHjtNzJusZNnGI/gT7ZsFaE=
X-KPN-VerifiedSender: No
X-CMASSUN: 33|A8jqBSxURq+ObuYB9ir+OR6sDf0y1Pyq+KNCzoUeVKU7xfk/lnYhgxDZOP/oTZ8
 NuID5OAQyQIEWmMoElTqImQ==
X-Originating-IP: 80.61.163.207
Received: from copland.sibelius.xs4all.nl (80-61-163-207.fixed.kpn.net [80.61.163.207])
        by smtp.xs4all.nl (Halon) with ESMTPSA
        id ddb736f1-e5b5-11ec-961a-005056998788;
        Mon, 06 Jun 2022 18:29:41 +0200 (CEST)
From:   Mark Kettenis <kettenis@openbsd.org>
To:     kernel@esmil.dk, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Cc:     Mark Kettenis <kettenis@openbsd.org>, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] riscv: dts: startfive: currect number of external interrupts
Date:   Mon,  6 Jun 2022 18:29:23 +0200
Message-Id: <20220606162924.71418-1-kettenis@openbsd.org>
X-Mailer: git-send-email 2.36.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The PLIC integrated on the Vic_U7_Core integrated on the StarFive
JH7100 SoC actually supports 133 external interrupts.  127 of these
are exposed to the outside world; the remainder are used by other
devices that are part of the core-complex such as the L2 cache
controller.  But all 133 interrupts are external interrupts as far
as the PLIC is concerned.  Fixing the property that specifies the
number of external interrupts allows the driver to manage these
additional interrupts, whch is important since the interrupts for
the L2 cache controller are enabled by default.

Signed-off-by: Mark Kettenis <kettenis@openbsd.org>
---
 arch/riscv/boot/dts/starfive/jh7100.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/riscv/boot/dts/starfive/jh7100.dtsi b/arch/riscv/boot/dts/starfive/jh7100.dtsi
index 69f22f9aad9d..f48e232a72a7 100644
--- a/arch/riscv/boot/dts/starfive/jh7100.dtsi
+++ b/arch/riscv/boot/dts/starfive/jh7100.dtsi
@@ -118,7 +118,7 @@ plic: interrupt-controller@c000000 {
 			interrupt-controller;
 			#address-cells = <0>;
 			#interrupt-cells = <1>;
-			riscv,ndev = <127>;
+			riscv,ndev = <133>;
 		};
 
 		clkgen: clock-controller@11800000 {
-- 
2.36.0

