Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7ACA4965BA
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 20:36:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231319AbiAUTgB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 14:36:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230061AbiAUTf4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 14:35:56 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 665F2C06173B;
        Fri, 21 Jan 2022 11:35:55 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id az25so1508469wrb.6;
        Fri, 21 Jan 2022 11:35:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PSLPG0MzXHr2sBAsU44qorgJ49GZ8FzI0+68Kp64Drs=;
        b=Zb3yvV8MVsbfeX2uJTVV0mDC/k2FVo5eUqOEa/6+RsmzqRnVdxDKLBqIORddIF8P4a
         SJ82SjXJm/LnU/+KgeyRnVoAu2/AZkEFyEBIKuz66YRdjjNYdCsX2m0JJ8OZB3XrSLXd
         ma7fKE0aXjWBMNCiQVaNYvAyW1beQeV8prUT0UgMdyS3jU+RoFRqvqAMuFMG8+CuUgp3
         LcTV1BU09Px/X4sw9YXA1Fyqi+lDmy/tpGN67mn+sGsmeecCtRIfITVlICunM7HYfG4W
         8niX6RdzqQy1Y/R1CdwVynDw7IQb2r7+ENcHd/UbzKs3yeqRHehoYJQTbJw34SlSsHZy
         O1MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PSLPG0MzXHr2sBAsU44qorgJ49GZ8FzI0+68Kp64Drs=;
        b=vmqmXKSazVQs+TLdmND6eO1XOX4ATykgu/BW69ZMb0MI45rSGUaIkw4r0aSv4s8LqA
         XJai+lufYxx7DezoCJzgncbVa8J7YZfVH97bLpFKjY+6LA2OQp/fJCqKksvhImljmv1j
         afJbbOPoBKUdJSpZtmAZLdzL2LvG2JfnTknisq5vcnKO4nd6t+SWuQKOUg/nPLd01non
         7aZnMiBA2etjxihx7ZsXEDZXyaNUkYIaXlhM7rLlCh23xThHJIJ1I+uSw8UgercArHgW
         8umg0JYfll02hUXdSeehXkeoOFQbS7OvpwjCDRupUTAXmnQtRa5lstoneSr5iuqTn348
         EhjA==
X-Gm-Message-State: AOAM5315jVfFm/7Il4II/Jm4mHy30fqV8r9+Ry6bUXp59ez539DQhTDx
        f7q5tyYaggHYk1nvHMRJgrMkPCekafFfeQ==
X-Google-Smtp-Source: ABdhPJz/yyKTop0c1yy7w6Te13IbfsihUpUUoHk/+QjEOJh7+CLMLP5HY4zH5iMxPZBPv9M8ghdBYA==
X-Received: by 2002:a05:6000:1092:: with SMTP id y18mr5111916wrw.668.1642793753680;
        Fri, 21 Jan 2022 11:35:53 -0800 (PST)
Received: from debby ([2a01:e0a:a6d:a8d0:7ff4:8f61:5574:9f95])
        by smtp.gmail.com with ESMTPSA id 16sm5739222wmj.12.2022.01.21.11.35.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jan 2022 11:35:53 -0800 (PST)
From:   Romain Perier <romain.perier@gmail.com>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>, Daniel Palmer <daniel@0x0f.com>,
        Romain Perier <romain.perier@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 4/9] ARM: mstar: Link cpupll to cpu
Date:   Fri, 21 Jan 2022 20:35:39 +0100
Message-Id: <20220121193544.23231-5-romain.perier@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220121193544.23231-1-romain.perier@gmail.com>
References: <20220121193544.23231-1-romain.perier@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daniel Palmer <daniel@0x0f.com>

The CPU clock is sourced from the CPU PLL.
Link cpupll to the cpu so that frequency scaling can happen.

Signed-off-by: Daniel Palmer <daniel@0x0f.com>
---
 arch/arm/boot/dts/mstar-v7.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/mstar-v7.dtsi b/arch/arm/boot/dts/mstar-v7.dtsi
index 2249faaa3aa7..c26ba9b7b6dd 100644
--- a/arch/arm/boot/dts/mstar-v7.dtsi
+++ b/arch/arm/boot/dts/mstar-v7.dtsi
@@ -21,6 +21,8 @@ cpu0: cpu@0 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a7";
 			reg = <0x0>;
+			clocks = <&cpupll>;
+			clock-names = "cpuclk";
 		};
 	};
 
-- 
2.34.1

