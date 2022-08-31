Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7ECA65A78DC
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 10:20:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231538AbiHaIUB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 04:20:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231522AbiHaITd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 04:19:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01FBBC6948;
        Wed, 31 Aug 2022 01:18:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B0178619D3;
        Wed, 31 Aug 2022 08:18:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA0E7C4314C;
        Wed, 31 Aug 2022 08:18:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661933883;
        bh=t182bdU7U0dEHPhdYXFdbvLZ9arqgWMZzee1Mf+ZirY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FK1nXZVTrGm1EJO2IK5DxpJKwqEuVfBoVZ4LtAS9+jBfXLP/aZ3cBibyrisl7CBD+
         NWQ71Op2uLE2/Ej7tX/EPxvRVDC4Su08jkU73t1RSbGQPDlAf5wH+6e1HjbncRtF3U
         CoeiqE3il5Uk8gjobr6VpARNlAUezqbn42nPe04gGn53B8CxwlV/A1N+hTXlVn5gWU
         bV8IHeOcNVa71vBsahw3bXvbDatCMa1vDWo4eUN7KFJ5m+PyEeNRhZkXk41Z6dKn3y
         HhcJpMEXoimGN/KaOUplM3p+KLZNjdmDVK8mvAE379vQNm3plj0rn2pn2+zlfBdjrb
         OTknHu4lW7imA==
Received: by pali.im (Postfix)
        id 8936112A0; Wed, 31 Aug 2022 10:18:00 +0200 (CEST)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
Subject: [PATCH v3 3/3] powerpc: dts: turris1x.dts: Set lower priority for CPLD syscon-reboot
Date:   Wed, 31 Aug 2022 10:17:15 +0200
Message-Id: <20220831081715.14673-3-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220831081715.14673-1-pali@kernel.org>
References: <20220820102925.29476-1-pali@kernel.org>
 <20220831081715.14673-1-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Due to CPLD firmware bugs, set CPLD syscon-reboot priority level to 64
(between rstcr and watchdog) to ensure that rstcr's global-utilities reset
method which is preferred stay as default one, and to ensure that CPLD
syscon-reboot is more preferred than watchdog reset method.

Fixes: 0531a4abd1c6 ("powerpc: dts: turris1x.dts: Add CPLD reboot node")
Signed-off-by: Pali Rohár <pali@kernel.org>
---
 arch/powerpc/boot/dts/turris1x.dts | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/arch/powerpc/boot/dts/turris1x.dts b/arch/powerpc/boot/dts/turris1x.dts
index 69c38ed8a3a5..c189293d5a1e 100644
--- a/arch/powerpc/boot/dts/turris1x.dts
+++ b/arch/powerpc/boot/dts/turris1x.dts
@@ -353,11 +353,34 @@
 			};
 
 			reboot@d {
+				/*
+				 * CPLD firmware which manages system reset and
+				 * watchdog registers has bugs. It does not
+				 * autoclear system reset register after change
+				 * and watchdog ignores reset line on immediate
+				 * succeeding reset cycle triggered by watchdog.
+				 * These bugs have to be workarounded in U-Boot
+				 * bootloader. So use system reset via syscon as
+				 * a last resort because older U-Boot versions
+				 * do not have workaround for watchdog.
+				 *
+				 * Reset method via rstcr's global-utilities
+				 * (the preferred one) has priority level 128,
+				 * watchdog has priority level 0 and default
+				 * syscon-reboot priority level is 192.
+				 *
+				 * So define syscon-reboot with custom priority
+				 * level 64 (between rstcr and watchdog) because
+				 * rstcr should stay as default preferred reset
+				 * method and reset via watchdog is more broken
+				 * than system reset via syscon.
+				 */
 				compatible = "syscon-reboot";
 				reg = <0x0d 0x01>;
 				offset = <0x0d>;
 				mask = <0x01>;
 				value = <0x01>;
+				priority = <64>;
 			};
 
 			led-controller@13 {
-- 
2.20.1

