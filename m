Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60D0C47602A
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 19:03:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343607AbhLOSCm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 13:02:42 -0500
Received: from 82-65-109-163.subs.proxad.net ([82.65.109.163]:58976 "EHLO
        luna.linkmauve.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245518AbhLOSCS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 13:02:18 -0500
Received: by luna.linkmauve.fr (Postfix, from userid 1000)
        id DF294F40EAD; Wed, 15 Dec 2021 18:55:06 +0100 (CET)
From:   Emmanuel Gil Peyrot <linkmauve@linkmauve.fr>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Alessandro Zummo <a.zummo@towertech.it>
Cc:     Emmanuel Gil Peyrot <linkmauve@linkmauve.fr>,
        rw-r-r-0644 <r.r.qwertyuiop.r.r@gmail.com>,
        Ash Logan <ash@heyquark.com>,
        =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.ne@posteo.net>,
        Rob Herring <robh+dt@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        linux-kernel@vger.kernel.org, linux-rtc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, devicetree@vger.kernel.org
Subject: [PATCH v3 3/5] powerpc: wii.dts: Expose HW_SRNPROT on this platform
Date:   Wed, 15 Dec 2021 18:54:59 +0100
Message-Id: <20211215175501.6761-4-linkmauve@linkmauve.fr>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211215175501.6761-1-linkmauve@linkmauve.fr>
References: <20211027223516.2031-1-linkmauve@linkmauve.fr>
 <20211215175501.6761-1-linkmauve@linkmauve.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This Hollywood register isn’t properly understood, but can allow or
reject access to the SRAM, which we need to set for RTC usage if it
isn’t previously set correctly beforehand.

See https://wiibrew.org/wiki/Hardware/Hollywood_Registers#HW_SRNPROT

Signed-off-by: Emmanuel Gil Peyrot <linkmauve@linkmauve.fr>
---
 arch/powerpc/boot/dts/wii.dts | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/powerpc/boot/dts/wii.dts b/arch/powerpc/boot/dts/wii.dts
index c5720fdd0686..34d9732d5910 100644
--- a/arch/powerpc/boot/dts/wii.dts
+++ b/arch/powerpc/boot/dts/wii.dts
@@ -175,6 +175,11 @@ PIC1: pic1@d800030 {
 			interrupts = <14>;
 		};
 
+		srnprot@d800060 {
+			compatible = "nintendo,hollywood-srnprot";
+			reg = <0x0d800060 0x4>;
+		};
+
 		GPIO: gpio@d8000c0 {
 			#gpio-cells = <2>;
 			compatible = "nintendo,hollywood-gpio";
-- 
2.34.1

