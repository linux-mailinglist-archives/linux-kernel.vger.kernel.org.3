Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01C1649D710
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 02:00:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234218AbiA0BAb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 20:00:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234174AbiA0BA3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 20:00:29 -0500
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F135C06161C;
        Wed, 26 Jan 2022 17:00:29 -0800 (PST)
Received: by mail-qt1-x829.google.com with SMTP id h25so329998qtm.1;
        Wed, 26 Jan 2022 17:00:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vajErjDWK29FvNOeA4ceH5ORPugHRCo1to0RNKcwTFU=;
        b=QgNvaXFHaMQz4rxk5UlHaIxI7n+089K4Astv6OBdqs2zKDF+fKF8kvop+rXFxvlq0W
         ZqdaCg4RP/DFJNkTn5zno3ps/kvQ9SHg/EVkTr9FinV4u/YkdQzO7Yy3XRpq5phdcNW/
         4lPipLqukO3oiRwFsQR/Ndnd7F0Fmzm+Xbgbf3BHhft0ImKfgrCc6WiibW8CZxYuNIVE
         46n306m5bvWDX7itR8X3dXCSJXshDxpWRhz1STS2C5spw2YN2itox9TXgDf5dQwZSNwT
         8E7kdAQmics8nIiZEfX5YEuJL52EcaesDHWSo0JK7OGDqhS4HytMSJOHTECO+V3NDCFi
         8mZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vajErjDWK29FvNOeA4ceH5ORPugHRCo1to0RNKcwTFU=;
        b=T5kdCm1bVQd5b0lkuBbHvIpzdkECdKP820882Kfme9tn6kf4FKPG98ElPgiiDml0/t
         leinHmLiaUwNOdTPJtJARMguEIwTmV1BC8ZfEdoHF7RMnI2TpMl18g7AGCwpB2AWgMlv
         vRnqGBB5Mvv6WxzkUFw6cgrwN3cnvzbREAil40Zi9RqnL+ns88CWSDrVbfZ8isJCaY3D
         1hri4Ccx91PL+unVB98OvKzvvySOS+i+3eabVYLId942FhYZtidkUMjzwuXath2wkZhR
         NH7fCPXlJOPgttu2vtqyIRxYnkhNmuydt9hSD1CgRuWbfl9yOxm0RmE1coSageZRW9kx
         0sRg==
X-Gm-Message-State: AOAM530v1M+u2N7LORXlLoZUFEkSsY6/UtRjhxVqjd5RZequEMd3gENl
        ZG6rX7t3YNAo5TBxcfA/rY4=
X-Google-Smtp-Source: ABdhPJwxQAwzc/Zno4iXwIWNgILmCOnWnIQJd6njQUYmw0iI1RfcM5/4qZKIH/FKJCNK3C1xAvrhQA==
X-Received: by 2002:a05:622a:1102:: with SMTP id e2mr1121245qty.2.1643245228558;
        Wed, 26 Jan 2022 17:00:28 -0800 (PST)
Received: from master-x64.sparksnet (c-98-233-193-225.hsd1.dc.comcast.net. [98.233.193.225])
        by smtp.gmail.com with ESMTPSA id n2sm483389qti.59.2022.01.26.17.00.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jan 2022 17:00:28 -0800 (PST)
From:   Peter Geis <pgwipeout@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
        Peter Geis <pgwipeout@gmail.com>
Cc:     Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] arm64: dts: rockchip: fix Quartz64-A ddr regulator voltage
Date:   Wed, 26 Jan 2022 20:00:21 -0500
Message-Id: <20220127010023.3169415-2-pgwipeout@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220127010023.3169415-1-pgwipeout@gmail.com>
References: <20220127010023.3169415-1-pgwipeout@gmail.com>
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

