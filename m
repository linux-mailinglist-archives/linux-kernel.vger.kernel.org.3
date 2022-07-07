Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CF0156AB18
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 20:55:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236561AbiGGSzw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 14:55:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236355AbiGGSzv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 14:55:51 -0400
Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.183])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD2412B630
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jul 2022 11:55:49 -0700 (PDT)
X-KPN-MessageId: a57e30ab-fe25-11ec-8ee3-005056992ed3
Received: from smtp.kpnmail.nl (unknown [10.31.155.7])
        by ewsoutbound.so.kpn.org (Halon) with ESMTPS
        id a57e30ab-fe25-11ec-8ee3-005056992ed3;
        Thu, 07 Jul 2022 20:50:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kpnmail.nl; s=kpnmail01;
        h=mime-version:message-id:date:subject:to:from;
        bh=MGz8SrgGh5/hCflKLJeJ+jAX4G1tQH6YpgJmkmIE+nw=;
        b=itT0+T0YCiVzm54Bfoh+ODsU+3bm5N4I20lJgwqKalFNXpCLG+ljr9vonvNUWkD9PLYAN0cf2XdIt
         lMEoLfIuXKyfobK3hv4P/o7z8NrvOyhhwjs9mPtDiUOuGtP3isT5RcIdkw4YEyEpDP/mzUtNKPbO9N
         0pXjYnfJGln0iUX0=
X-KPN-MID: 33|lBCj8tP3hSBtrfO5Tokf0TYKY+xl1N9saTTr9uJ3VHzpxCLYRJlHmQZ23abroOJ
 kw3pIsu4nbusocAEv7SPmG4MtyMrol/abn3ppE+HwaA4=
X-KPN-VerifiedSender: No
X-CMASSUN: 33|cqXLFDEyk0g+mW407f2sKvaVuzLvoBkAk/A9yYS7N3NZp30e/6G1pTZP6M8b3LY
 iRZajsG+2gpSiY+FYCW0JLg==
X-Originating-IP: 80.61.163.207
Received: from copland.sibelius.xs4all.nl (80-61-163-207.fixed.kpn.net [80.61.163.207])
        by smtp.xs4all.nl (Halon) with ESMTPSA
        id 6c789f36-fe26-11ec-8bc8-005056998788;
        Thu, 07 Jul 2022 20:55:52 +0200 (CEST)
From:   Mark Kettenis <kettenis@openbsd.org>
To:     Conor Dooley <mail@conchuod.ie>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Emil Renner Berthing <kernel@esmil.dk>
Cc:     Mark Kettenis <kettenis@openbsd.org>,
        Palmer Dabbelt <palmer@rivosinc.com>,
        devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] riscv: dts: starfive: correct number of external interrupts
Date:   Thu,  7 Jul 2022 20:55:28 +0200
Message-Id: <20220707185529.19509-1-kettenis@openbsd.org>
X-Mailer: git-send-email 2.36.1
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
as the PLIC is concerned.  Fix the property so that the driver can
manage these additional interrupts, which is important since the
interrupts for the L2 cache controller are enabled by default.

Fixes: ec85362fb121 ("RISC-V: Add initial StarFive JH7100 device tree")
Signed-off-by: Mark Kettenis <kettenis@openbsd.org>
---

ChangeLog:

v2: - Fix commit message


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
2.36.1

