Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFB4B47952F
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 20:58:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240791AbhLQT5r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 14:57:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230108AbhLQT5n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 14:57:43 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06FD5C061574;
        Fri, 17 Dec 2021 11:57:43 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id v11so6041612wrw.10;
        Fri, 17 Dec 2021 11:57:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vY0vz4OHKS9xBTPvFTuiZ+WCKN0YR03bQMvMz1cRhF4=;
        b=gPLlA3+3Q5vW0h81FGl1ipW5go9sYKsjbDaCKhhc7mkPhXyXgQ0USzkw3hlSMGkoCH
         +Khw/8AkroHdDq6ynxhoSpOs7mWuA8bmMpNdo0awlegaZjfetvoUq959Ou0j8jvb4ppF
         fOdnzNSL1XQNIj6jqlA6Rsd2lGZVUMVNM8Z0XJip8uzklCAAjRVjB9Z+C4ng++6prVjA
         Az/Cc+N1YfR9xFo+NJsUNMU4MeIJDj7YwTrMzp7TsFmOHLbcSlVxwSf1+UOsm0ghYGQd
         stuOzEwbUTJ2cqZGb+fX2EMpFE0H9h9XRza6TqxmArwtZCVvtOSSBRGPRqi12NOoQtp3
         PMiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vY0vz4OHKS9xBTPvFTuiZ+WCKN0YR03bQMvMz1cRhF4=;
        b=f1ibBUm+q6V49HDOmzv5tG6QGM1uVzCCytqJO4M1qaUf9PfI3UGr6cvFiIk+gaKOvN
         3/ukAsB7z7IeT6i9KMl9hLpN5K9scd5n1DDoSbVDyj9idWWlLWRe+JVuHwyjtC78EPRM
         gzJuQnkYwdFIg3YUUEtcDV6KdBYHYt4BEUtd7XnUZoStkScaQhrhK7xu5YsS55msquLj
         61bHgq49t8Gcyjl8PIu4KSwQNi1WZBbbrOE7F9MnNKDUleH+9GYp6ifxecLsBANdqgft
         ySpUxyQIUgEm/6IXjDdp/Wlkq7jc3gq65idSKtB+3Rjg6mAlUwWG5XuDr10+mvvl3C8t
         usPg==
X-Gm-Message-State: AOAM5311ZUJLaewxKjVk+PD7tatIaGOHwllk9TatlU4V2CaqWAC/sjCW
        xStq8mwiQa+Ara09uh6Eewbeal7NuMg=
X-Google-Smtp-Source: ABdhPJziSE1jtSxEZSdWMcZFgQI+yul8bLRjuFrNT7FlAOtdEWLbrAFcRLEG9G25MFLMVAMT+V0cpQ==
X-Received: by 2002:adf:f201:: with SMTP id p1mr3657136wro.243.1639771061248;
        Fri, 17 Dec 2021 11:57:41 -0800 (PST)
Received: from debby ([2a01:e0a:a6d:a8d0:7ff4:8f61:5574:9f95])
        by smtp.gmail.com with ESMTPSA id r20sm6962666wmd.37.2021.12.17.11.57.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Dec 2021 11:57:40 -0800 (PST)
From:   Romain Perier <romain.perier@gmail.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Daniel Palmer <daniel@0x0f.com>,
        Romain Perier <romain.perier@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Russell King <linux@armlinux.org.uk>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/6] clocksource: msc313e: Add support for ssd20xd-based platforms
Date:   Fri, 17 Dec 2021 20:57:23 +0100
Message-Id: <20211217195727.8955-3-romain.perier@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211217195727.8955-1-romain.perier@gmail.com>
References: <20211217195727.8955-1-romain.perier@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On SSD20X family SoCs the timers are connected to a 432MHz clock instead
of 12MHz that all the previous chips used. There is no way to reduce or
divide these clocks in the clktree yet as we do not know exactly where
the 432MHz clock comes from but it is enabled at boot.

The SSD20X timers have an input clock divider within the timer itself
to configure the frequency. timer0 is preconfigured at power up to run
at 12MHz so it is backwards compatible and doesn't need special handling
right now. timer1 and timer2 run at 432Mhz at power up so are not
backward compatible.

This commit adds support for the input clock divider register and sets
timer1 and timer2 to run at 48Mhz for clockevents.

Signed-off-by: Romain Perier <romain.perier@gmail.com>
---
 drivers/clocksource/timer-msc313e.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/clocksource/timer-msc313e.c b/drivers/clocksource/timer-msc313e.c
index 154e73444a0c..54c54ca7c786 100644
--- a/drivers/clocksource/timer-msc313e.c
+++ b/drivers/clocksource/timer-msc313e.c
@@ -33,7 +33,9 @@
 #define MSC313E_REG_TIMER_MAX_HIGH	0x0c
 #define MSC313E_REG_COUNTER_LOW		0x10
 #define MSC313E_REG_COUNTER_HIGH	0x14
+#define MSC313E_REG_TIMER_DIVIDE	0x18
 
+#define MSC313E_CLK_DIVIDER		9
 #define TIMER_SYNC_TICKS		3
 
 #ifdef CONFIG_ARM
@@ -179,6 +181,12 @@ static int __init msc313e_clkevt_init(struct device_node *np)
 	if (ret)
 		return ret;
 
+	if (of_device_is_compatible(np, "sstar,ssd20xd-timer")) {
+		to->of_clk.rate = clk_get_rate(to->of_clk.clk) / MSC313E_CLK_DIVIDER;
+		to->of_clk.period = DIV_ROUND_UP(to->of_clk.rate, HZ);
+		writew(MSC313E_CLK_DIVIDER - 1, timer_of_base(to) + MSC313E_REG_TIMER_DIVIDE);
+	}
+
 	msc313e_clkevt.cpumask = cpu_possible_mask;
 	msc313e_clkevt.irq = to->of_irq.irq;
 	to->clkevt = msc313e_clkevt;
@@ -242,3 +250,4 @@ static int __init msc313e_timer_init(struct device_node *np)
 }
 
 TIMER_OF_DECLARE(msc313, "mstar,msc313e-timer", msc313e_timer_init);
+TIMER_OF_DECLARE(ssd20xd, "sstar,ssd20xd-timer", msc313e_timer_init);
-- 
2.34.1

