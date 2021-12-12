Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39C88471C29
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Dec 2021 19:20:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231981AbhLLST0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Dec 2021 13:19:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231962AbhLLSTO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Dec 2021 13:19:14 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6DB9C0613F8;
        Sun, 12 Dec 2021 10:19:13 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id a9so23519690wrr.8;
        Sun, 12 Dec 2021 10:19:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=s89O9UyBnTEz8pj2LKhsXhinnDR/gR0LdEysrofCZnU=;
        b=W09La0BG+7pSgIm8pns3h5Skv/cgZCnaGCsZx3T32PGEMSnINojslOO4WUORoM0nh2
         BFcfEAAuXYaBKckeiXHLVO5vrbjIqmiG81nYvey0eFnL9MvJGcZIYP5Rk44U4QeusBx7
         3BUZp/PAtVdGLrhi94MaEephWMuI/WvoruuBP9PO32wCfR74zlAPa5gH4AwKEmnbxwN3
         rKisWfqrclLAHGvJhgm62YYZriUkR2Tk0sWtLgBQv+nxVbE2IrjQ1OyiZlkQCov1rOSg
         6btGMIi90+q3qwkWHNfSBob6k4HiQl75mOfNegfMTpYmEiRkNoDAmcMqvDS7BsPWgOnA
         mEIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=s89O9UyBnTEz8pj2LKhsXhinnDR/gR0LdEysrofCZnU=;
        b=E4UqZpEeqW2x+Q+IBRpcaQR1u+n2bUhmgFJhFwIJhSm+J1cIya1KhGsADTV8AgMpWn
         cRXo9pm+uctKJM9rHLGxm3dp4qekFcSpQvz+KiN1hOIx1k356WN/gRK5BjOHx67c+dmO
         gxb5dI99LXMQLNwjoioYaqjoS4Nu4sZ1yXwonl++nbwQ6dZYtABp4R8xhMTCzoXYKNDx
         RoaMIBOvhGERGOvsSmZybcdCI5BGPAdW4DlDmncgwO9N4CKbQhB6sDOWmiKS5srgK7qI
         jJqf5e2p69zHQjfB5B3p1M0VDPxRfwauFHkCnV/bbUQ1idWK6vSqJm0WXRQ+LPi9CqY6
         bELg==
X-Gm-Message-State: AOAM532lvlXfW3aa/c4FdVA4aL6gxqhQuZiH48av7BlIavZgu2agnchU
        Ynr9Qa5f4Dkj0Cbuli3vyQsGcDW0DHU=
X-Google-Smtp-Source: ABdhPJxw0+E/eGq5Uq2YIXWQ7Qq4DjXeY7Pi14KDR0/z1eOqy92l3jQg8gIKZFhe3LgUpWZX+b5yNw==
X-Received: by 2002:a5d:58f9:: with SMTP id f25mr26777535wrd.206.1639333151056;
        Sun, 12 Dec 2021 10:19:11 -0800 (PST)
Received: from debby ([2a01:e0a:a6d:a8d0:7ff4:8f61:5574:9f95])
        by smtp.gmail.com with ESMTPSA id l4sm8263879wrv.94.2021.12.12.10.19.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Dec 2021 10:19:10 -0800 (PST)
From:   Romain Perier <romain.perier@gmail.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Daniel Palmer <daniel@0x0f.com>,
        Romain Perier <romain.perier@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Russell King <linux@armlinux.org.uk>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/6] clocksource: msc313e: Add support for ssd20xd-based platforms
Date:   Sun, 12 Dec 2021 19:19:02 +0100
Message-Id: <20211212181906.94062-3-romain.perier@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211212181906.94062-1-romain.perier@gmail.com>
References: <20211212181906.94062-1-romain.perier@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SSD20X family SoCs have an oscillator running at ~432Mhz for timer1 and
timer2, while timer0 is running at 12Mhz. There are no ways to reduce or
divide these clocks in the clktree. However, SSD20X SoCs provide an
internal "timer_divide" register that can act on this input oscillator.
This commit adds support for this register, as timer1 and timer2 are
used as clockevents these will run at 48Mhz.

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
2.33.0

