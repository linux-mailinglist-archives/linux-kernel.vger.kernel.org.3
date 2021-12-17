Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD44C478BA1
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 13:45:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236404AbhLQMpx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 07:45:53 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:44766 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbhLQMpx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 07:45:53 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B91E762160;
        Fri, 17 Dec 2021 12:45:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F23DC36AE1;
        Fri, 17 Dec 2021 12:45:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639745152;
        bh=l+SCwxc+wY2dm/Ieek4EKeWRjkBv6W7lUhT0BytkOFY=;
        h=From:To:Cc:Subject:Date:From;
        b=IZclTaJhFvX6WWdIGYNjuhJK/EFDAYpToJk0lEYEVtbzL2EP3vJ5brG7BnM4dFdUG
         t4o99TmUzZiGw0RZ9kWD2a8IBcWyAdXdw1K9I7ZjD8gs/cAqsBgCKTuJphFrj2575g
         MDpVsT0TR2WTpODVxh+RpWiWjBXfgAcSB/7S++6Oou6fLYTZmprGWFYrnq3D2hq9fP
         293/BdCkH4LS9PMIlpBbQH02p65fOtcC4JLjhX4imQZdqwAN6Cf05j++SfUWPjdEBw
         hyFFbtuQnMTfPDmUko2BF7UmcbO2i6puJ4qQgXqfx0LN2oTpuHsU1q0Z/ekPOMBqHz
         LBWL83wI1U+fg==
From:   Felipe Balbi <balbi@kernel.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Felipe Balbi <felipe.balbi@microsoft.com>
Subject: [PATCH] arm64: boot: dts: sm8150: simplify references to pwrkey and resin
Date:   Fri, 17 Dec 2021 14:45:46 +0200
Message-Id: <20211217124546.1192281-1-balbi@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Felipe Balbi <felipe.balbi@microsoft.com>

Since commit d0a6ce59ea4e ("arm64: dts: qcom: sm8150: Add support for
SONY Xperia 1 / 5 (Kumano platform)"), we can directly refer to pwrkey
and resin by their new labels, respectively pon_pwrkey and pon_resin.

Simplify microsof surface duo DTS by utilizing the new labels.

Signed-off-by: Felipe Balbi <felipe.balbi@microsoft.com>
---
 .../dts/qcom/sm8150-microsoft-surface-duo.dts | 20 ++++++++-----------
 1 file changed, 8 insertions(+), 12 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8150-microsoft-surface-duo.dts b/arch/arm64/boot/dts/qcom/sm8150-microsoft-surface-duo.dts
index 5901c28e6696..a73317e1a824 100644
--- a/arch/arm64/boot/dts/qcom/sm8150-microsoft-surface-duo.dts
+++ b/arch/arm64/boot/dts/qcom/sm8150-microsoft-surface-duo.dts
@@ -430,18 +430,8 @@ &i2c19 {
 	/* MAX34417 @ 0x1e */
 };
 
-&pon {
-	pwrkey {
-		status = "okay";
-	};
-
-	resin {
-		compatible = "qcom,pm8941-resin";
-		interrupts = <0x0 0x8 0x1 IRQ_TYPE_EDGE_BOTH>;
-		debounce = <15625>;
-		bias-pull-up;
-		linux,code = <KEY_VOLUMEDOWN>;
-	};
+&pon_pwrkey {
+	status = "okay";
 };
 
 &qupv3_id_0 {
@@ -476,6 +466,12 @@ &remoteproc_slpi {
 	firmware-name = "qcom/sm8150/microsoft/slpi.mdt";
 };
 
+&pon_resin {
+	status = "okay";
+
+	linux,code = <KEY_VOLUMEDOWN>;
+};
+
 &tlmm {
 	gpio-reserved-ranges = <126 4>;
 
-- 
2.34.1

