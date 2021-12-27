Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E37C947FD93
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Dec 2021 14:36:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236834AbhL0NgX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Dec 2021 08:36:23 -0500
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:54696
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236835AbhL0NgM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Dec 2021 08:36:12 -0500
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com [209.85.208.198])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id D76763FFDA
        for <linux-kernel@vger.kernel.org>; Mon, 27 Dec 2021 13:36:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1640612171;
        bh=Xg8khZUOfJf1NqTEkbMr+q22xxCSbQVKtUkZgNNGg4U=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=qkcaJy6b0OXpm2oLWYa1UpPBkSb1ECCP/AvUxqOtideZt6e7Cuj+Qy1+DSf/+XggV
         7MKZDmcieWvQmB3IxB0ZazEEAOfsY+c3zXgdS+2WVhDxg+aaUlNmFjNEjUEtwC+mzI
         y+rU0k8uaUueZYG6RqTb3PA63YbgCCt7QarKBqXs3xel6+purYfSxgPyfpg0cHWrTu
         Yq/51A6XKO8AI6/S2tinFydSv1d/cYmDzlF/NM7fljOlhIjDjio3hz9BIZ4QvwFC26
         FF6ViZ8bWrBHQt7neFzyUE3FupEuD4ItrkZTUGg4MXVdeGkUQImrZJTz0HiVhpat6R
         Fnf/EqRDob4qw==
Received: by mail-lj1-f198.google.com with SMTP id b20-20020a2e9894000000b0022dc5a5f841so1944210ljj.2
        for <linux-kernel@vger.kernel.org>; Mon, 27 Dec 2021 05:36:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Xg8khZUOfJf1NqTEkbMr+q22xxCSbQVKtUkZgNNGg4U=;
        b=p0ArIQnUW27t2SPSOx+Cpr67EyX5owzoElmjzeK9mJL+A981YUCwbfT/QqaoISP+qW
         Svd/wQ7Z/aDcHrMo+ZWM7hHsIoApc7bjeMNjlbQ/YNOCS7cgbunqCVYC16iQjmUMiqdY
         Eg6SDY7ARq3D6Pky8l2SPspsKM4Lj7mhSbJiHo0qlaGw2BJuSDTXhPB+MC33nsHu+y/B
         sf3BvO88nXF/pq8fsj7fyYLejAbdslm+IPtYMRUE01Xg+/RiPHqjy5kGHWAHea7M2833
         yaJhPRcSoiBrDuGg9fRRFS+6Y94HS6lPDkW1Km9zdyqxUh2xaS2XZQxxQ4QhWXc5PKxe
         5rEQ==
X-Gm-Message-State: AOAM533CancyStJqttuyy+fRynoTegh/tQ0I+KoKzRWnz+baBWP0dOmI
        Wbd8Xw4TyKAwC4YVfiXxjMJ6wtfGoVgz/4Hg94uCfP7ndi/h4DdtXHVI+qUQN5+lIdzDVQW/SjW
        8ieMEIgWch+4VrvjjDz2QzeDKjxpEobdT8G8Ox0379Q==
X-Received: by 2002:a05:651c:2104:: with SMTP id a4mr8546242ljq.110.1640612170662;
        Mon, 27 Dec 2021 05:36:10 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwcTXhaVrfLaVpLF0AzUd+PQzoLL+LOJnOJx2UUTk5ykxRQdXsMFxEfO3cnYjPxN9aMqd58Yw==
X-Received: by 2002:a05:651c:2104:: with SMTP id a4mr8546229ljq.110.1640612170519;
        Mon, 27 Dec 2021 05:36:10 -0800 (PST)
Received: from krzk-bin.lan (89-77-68-124.dynamic.chello.pl. [89.77.68.124])
        by smtp.gmail.com with ESMTPSA id g18sm800107ljj.124.2021.12.27.05.36.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Dec 2021 05:36:10 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Dinh Nguyen <dinguyen@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-mmc@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Subject: [PATCH 14/19] arm64: dts: stratix10: move ARM timer out of SoC node
Date:   Mon, 27 Dec 2021 14:35:53 +0100
Message-Id: <20211227133558.135185-8-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211227133131.134369-1-krzysztof.kozlowski@canonical.com>
References: <20211227133131.134369-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ARM timer is usually considered not part of SoC node, just like
other ARM designed blocks (PMU, PSCI).  This fixes dtbs_check warning:

  arch/arm64/boot/dts/altera/socfpga_stratix10_socdk.dt.yaml: soc: timer:
    {'compatible': ['arm,armv8-timer'], 'interrupts': [[1, 13, 3848], [1, 14, 3848], [1, 11, 3848], [1, 10, 3848]]} should not be valid under {'type': 'object'}
    From schema: dtschema/schemas/simple-bus.yaml

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 .../boot/dts/altera/socfpga_stratix10.dtsi    | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi b/arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi
index d301ac0d406b..4a527d614ee5 100644
--- a/arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi
+++ b/arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi
@@ -77,6 +77,16 @@ psci {
 		method = "smc";
 	};
 
+	/* Local timer */
+	timer {
+		compatible = "arm,armv8-timer";
+		interrupts = <1 13 0xf08>,
+			     <1 14 0xf08>,
+			     <1 11 0xf08>,
+			     <1 10 0xf08>;
+		interrupt-parent = <&intc>;
+	};
+
 	intc: interrupt-controller@fffc1000 {
 		compatible = "arm,gic-400", "arm,cortex-a15-gic";
 		#interrupt-cells = <3>;
@@ -406,15 +416,6 @@ sysmgr: sysmgr@ffd12000 {
 			reg = <0xffd12000 0x228>;
 		};
 
-		/* Local timer */
-		timer {
-			compatible = "arm,armv8-timer";
-			interrupts = <1 13 0xf08>,
-				     <1 14 0xf08>,
-				     <1 11 0xf08>,
-				     <1 10 0xf08>;
-		};
-
 		timer0: timer0@ffc03000 {
 			compatible = "snps,dw-apb-timer";
 			interrupts = <0 113 4>;
-- 
2.32.0

