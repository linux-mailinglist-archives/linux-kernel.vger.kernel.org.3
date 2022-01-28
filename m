Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F41CD49EFE2
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 01:38:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344573AbiA1AiT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 19:38:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241477AbiA1AiS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 19:38:18 -0500
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6FFDC06173B;
        Thu, 27 Jan 2022 16:38:17 -0800 (PST)
Received: by mail-qv1-xf30.google.com with SMTP id h16so4389011qvk.10;
        Thu, 27 Jan 2022 16:38:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vajErjDWK29FvNOeA4ceH5ORPugHRCo1to0RNKcwTFU=;
        b=n6hH5bE0tAhwSpDQfYcACSaoNCPingDZDvHbL/z2fUqpjUxXolUF5Lddf+Ulk3FcSk
         uIOaVxUSetYMbtgUL0PF//qrQ+foqdwWOi8MdsUTvIKtGuK4LDg66AIG3XcN3BccrqPR
         wrowKuCSNvx8hSimAVZKlwiPzMgCci4UK+n6C1uawK3mML4uwLcuZTRfrGUsdIX9gmO4
         qYTZ4FBTwIR4gt+8pbcHeiXcBStn0TwITrVx5QgX2p18LC59OkW3pUTYzm8W/FKQZxZS
         C9tyb9vVM+CmJm7Ytw1WX7n3e4pFr9oaS27ge+VViaJ9nkHXcIR4ngAV7/6hELyoZD4I
         J/UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vajErjDWK29FvNOeA4ceH5ORPugHRCo1to0RNKcwTFU=;
        b=kl3WGC1z1fzzMhjrDGOopwubuqrMi4vIEg/1EoyPntcgtC2c/bjZLZYc30ahMbCNgd
         FSDXX7Yo0Mzx67teVz/zUNVXxVQCGBpGHtEjEfEsFxiGVr2AYWMM+lFN6WMDhVDOQyCF
         RK7e25JDq6SufCi6YoZhy+tHuALR7s+5pNIX7ORIXBjoymKMw/23PX5R32yDS64zJn0m
         MaStJTZxrqJGzlZt+JaY7G0/yvYLwnEAbx3tdbWMqJeWN92Urc4K6egGI5vcQYjlwJ2L
         7Ite0ObpbJ1XsiG9uURHO4ja4C6REjJ1c6L582U6fVYG5SGse/K3Snn2r0Z1mTw4YUab
         oVnQ==
X-Gm-Message-State: AOAM530eF8GK09ujtLqqUrDVjauBd/WF83P3PRsiCyBRG5Ryz1+kA9Fe
        i7iB8PpeGvbDjnTA6E2+AM4=
X-Google-Smtp-Source: ABdhPJx6Ewcb3mNLM99tOI9RuDyK8k/N3O3ytSQsjCpu8y3yQASkoh7sG45wXL3ayDBANmW6nd8v9w==
X-Received: by 2002:ad4:5968:: with SMTP id eq8mr5136360qvb.80.1643330295757;
        Thu, 27 Jan 2022 16:38:15 -0800 (PST)
Received: from master-x64.sparksnet (c-98-233-193-225.hsd1.dc.comcast.net. [98.233.193.225])
        by smtp.gmail.com with ESMTPSA id t1sm2142883qtc.48.2022.01.27.16.38.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jan 2022 16:38:15 -0800 (PST)
From:   Peter Geis <pgwipeout@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
        Peter Geis <pgwipeout@gmail.com>
Cc:     Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/4] arm64: dts: rockchip: fix Quartz64-A ddr regulator voltage
Date:   Thu, 27 Jan 2022 19:38:05 -0500
Message-Id: <20220128003809.3291407-2-pgwipeout@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220128003809.3291407-1-pgwipeout@gmail.com>
References: <20220128003809.3291407-1-pgwipeout@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Quartz64 Model A uses a voltage divider to ensure ddr voltage is
within specification from the default regulator configuration.
Adjusting this voltage is detrimental, and currently causes the ddr
voltage to be about 0.8v.

Remove the min and max voltage setpoints for the ddr regulator.

Fixes: b33a22a1e7c4 ("arm64: dts: rockchip: add basic dts for Pine64
Quartz64-A")

Signed-off-by: Peter Geis <pgwipeout@gmail.com>
---
 arch/arm64/boot/dts/rockchip/rk3566-quartz64-a.dts | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3566-quartz64-a.dts b/arch/arm64/boot/dts/rockchip/rk3566-quartz64-a.dts
index 166399b7f13f..d9eb92d59099 100644
--- a/arch/arm64/boot/dts/rockchip/rk3566-quartz64-a.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3566-quartz64-a.dts
@@ -285,8 +285,6 @@ regulator-state-mem {
 			vcc_ddr: DCDC_REG3 {
 				regulator-always-on;
 				regulator-boot-on;
-				regulator-min-microvolt = <1100000>;
-				regulator-max-microvolt = <1100000>;
 				regulator-initial-mode = <0x2>;
 				regulator-name = "vcc_ddr";
 				regulator-state-mem {
-- 
2.25.1

