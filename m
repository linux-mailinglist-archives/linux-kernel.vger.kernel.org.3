Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65B9D478BE9
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 13:58:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236513AbhLQM6K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 07:58:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236047AbhLQM6H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 07:58:07 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94042C061574;
        Fri, 17 Dec 2021 04:58:07 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 350C6621BF;
        Fri, 17 Dec 2021 12:58:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7D72C36AEB;
        Fri, 17 Dec 2021 12:58:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639745886;
        bh=7a2LLhsMgBkLVjnpVVJb8rT8xwIF+4J8sKcfHuqjfYY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SMbsXWEmO50mfG9ws7uel4rR1sQK06gi/4s+YW6gSYttt06ADSmQ0aGBdBq6B+pdf
         jHPIrM9V84BqzgSqS1Ju0yGo42UzbzL4EUXaTWkuvjSBC5W2fHU+T2FdJgUoGvTIwu
         cgnZCOZHfssc5Ov6VXLzOAv/ypfULG8vkWbYoFNvf0idfiaMxWtrrjzpoXINYFFtcu
         uhnSho/rJYcB7RbSGuuWIu3NSXo/Mku1Jj0GrXGOFbl5Jd7Oa1SmDIuR/sn/KRq8o4
         t8AsYQXKTmLsymY+fxxxssXDsjaHMC9kP8d+SxTCEV6oaOHyTPn063U94LQDaCeO9a
         Aa36jiCXchQtQ==
From:   Felipe Balbi <balbi@kernel.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>
Cc:     Rob Herring <robh+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Felipe Balbi <felipe.balbi@microsoft.com>
Subject: [RFC/patch 2/2] arm64: boot: dts: qcom: surface duo: add minimal framebuffer
Date:   Fri, 17 Dec 2021 14:57:57 +0200
Message-Id: <20211217125757.1193256-3-balbi@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211217125757.1193256-1-balbi@kernel.org>
References: <20211217125757.1193256-1-balbi@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Felipe Balbi <felipe.balbi@microsoft.com>

Add a minimal framebuffer device so we can use the display on the
Surface Duo device.

Signed-off-by: Felipe Balbi <felipe.balbi@microsoft.com>
---
 .../dts/qcom/sm8150-microsoft-surface-duo.dts | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8150-microsoft-surface-duo.dts b/arch/arm64/boot/dts/qcom/sm8150-microsoft-surface-duo.dts
index a73317e1a824..c629ec115fec 100644
--- a/arch/arm64/boot/dts/qcom/sm8150-microsoft-surface-duo.dts
+++ b/arch/arm64/boot/dts/qcom/sm8150-microsoft-surface-duo.dts
@@ -25,6 +25,17 @@ chosen {
 		stdout-path = "serial0:115200n8";
 	};
 
+	framebuffer0: framebuffer@9c000000 {
+		compatible = "simple-framebuffer";
+		reg = <0 0x9c000000 0 0x02400000>;
+		status = "okay";
+
+		height = <1800>;
+		width = <1350>;
+		stride = <(1350 * 4)>;
+		format = "a8r8g8b8";
+	};
+
 	vph_pwr: vph-pwr-regulator {
 		compatible = "regulator-fixed";
 		regulator-name = "vph_pwr";
@@ -472,6 +483,14 @@ &pon_resin {
 	linux,code = <KEY_VOLUMEDOWN>;
 };
 
+&reserved_memory {
+	splash_region: splash_region@9c000000 {
+		/* We expect the bootloader to fill in the size */
+		reg = <0x0 0x9c000000 0x0 0x0>;
+		no-map;
+	};
+};
+
 &tlmm {
 	gpio-reserved-ranges = <126 4>;
 
-- 
2.34.1

