Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0504E4BCE03
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Feb 2022 11:38:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231673AbiBTKin (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Feb 2022 05:38:43 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:36234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229788AbiBTKil (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Feb 2022 05:38:41 -0500
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A6C04C40F
        for <linux-kernel@vger.kernel.org>; Sun, 20 Feb 2022 02:38:20 -0800 (PST)
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com [209.85.221.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 77E073F1CF
        for <linux-kernel@vger.kernel.org>; Sun, 20 Feb 2022 10:38:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1645353498;
        bh=HJ3hf05bLGcI9whcyVuKruFWRj+0StPbt+dAPR96XFc=;
        h=From:To:Subject:Date:Message-Id:MIME-Version;
        b=hYYTMXLh8xT4VJ50t43Albuy/HfZbqYa1f/PQNe6rx7Fk8r1E6oa8dH3xQ/3wQeUa
         BP3tNVfsfw6/QScWfw2SXDH0k3NvLgBv8/Fd3q1h4qYqxeZDg9pcS8Iq38ZIYj0YSq
         4co887iLJo7sFh722QRmLXMbuqFO/KF4cF1KdO+K+TqA9njKVVeTtM+sBFt72lm6+Z
         VujAmX4DXJqO3xb5+hpSB2KqNDB9GWmaMgFqhfCZvkWoMSQwV9HGm4WzH/6p+X0vPW
         Dn/sE650OKBKJ1ZzRyleOQPmkWYXwdL0nuvyEo/0gBmZluBudz7WPWkwbtOBGSC4wQ
         GEhZVqxq+sN/A==
Received: by mail-wr1-f71.google.com with SMTP id t8-20020adfa2c8000000b001e8f6889404so3760772wra.0
        for <linux-kernel@vger.kernel.org>; Sun, 20 Feb 2022 02:38:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HJ3hf05bLGcI9whcyVuKruFWRj+0StPbt+dAPR96XFc=;
        b=tpmr+afhb1tqprriJBlyS3jY6nTb55fN9xOxDHUwFebObLIqjahPYAorsm4aNVohTI
         Er2EBRgPUzC4gtSqh3NrhCLrz66i4U+LrEZNmIzEndMQqtbK23WJV39ixPyDG8Ta8OGJ
         8rZ3UmjX0DgY8r3nbPVKT3s5dbxKnlrvSMx67eauBj2HfojKJpW+VqbTxT5L/JmSV80t
         y+K3LsEoLWNygVX4/jMVVlxGlvV70GmaeKBSQntLzHrTZAy5Bdt7Ys6m3e1EdWr3YgxR
         12xYXKJ3ztS8YTf3dwpSCLQtW+LqbACBCmay75bJRzx5DuLd1sLPO+2IiCiAAHI54fcE
         nusA==
X-Gm-Message-State: AOAM532BNuvHTtMP3JJNsQodL2/xFSN4HUhqN0hny60dcTs0vNla/XUo
        c+UmZ1niuSrM6xFkpQOUPRlQvADssL76IlhqaBy+KDWZs8AYAoubcs2GOPBitx9F3as56eZ2g7x
        q0jijxlk5rZHB/jSly8uKDiscQCAMrgR9oP6rjYyttQ==
X-Received: by 2002:a05:6000:25a:b0:1e3:2010:4d14 with SMTP id m26-20020a056000025a00b001e320104d14mr12150903wrz.455.1645353498013;
        Sun, 20 Feb 2022 02:38:18 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwijQTb9gqvlCbIMT5zyu0cBqFSHKsClS4XIKOilmpzDy2v/za0javscwr09IAOAavEpM2L/w==
X-Received: by 2002:a05:6000:25a:b0:1e3:2010:4d14 with SMTP id m26-20020a056000025a00b001e320104d14mr12150893wrz.455.1645353497852;
        Sun, 20 Feb 2022 02:38:17 -0800 (PST)
Received: from localhost.localdomain (xdsl-188-155-181-108.adslplus.ch. [188.155.181.108])
        by smtp.gmail.com with ESMTPSA id l10-20020a7bc44a000000b0037c32873258sm4419213wmi.2.2022.02.20.02.38.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Feb 2022 02:38:17 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Thomas Abraham <thomas.abraham@linaro.org>,
        Stephen Warren <swarren@nvidia.com>,
        Kukjin Kim <kgene.kim@samsung.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org
Subject: [PATCH] clocksource/drivers/exynos_mct: Handle DTS with higher number of interrupts
Date:   Sun, 20 Feb 2022 11:38:15 +0100
Message-Id: <20220220103815.135380-1-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver statically defines maximum number of interrupts it can
handle, however it does not respect that limit when configuring them.
When provided with a DTS with more interrupts than assumed, the driver
will overwrite static array mct_irqs leading to silent memory
corruption.

Validate the interrupts coming from DTS to avoid this.  This does not
change the fact that such DTS might not boot at all, because it is
simply incompatible, however at least some warning will be printed.

Fixes: 36ba5d527e95 ("ARM: EXYNOS: add device tree support for MCT controller driver")
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 drivers/clocksource/exynos_mct.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/clocksource/exynos_mct.c b/drivers/clocksource/exynos_mct.c
index 6db3d5511b0f..03782b399ea1 100644
--- a/drivers/clocksource/exynos_mct.c
+++ b/drivers/clocksource/exynos_mct.c
@@ -541,6 +541,11 @@ static int __init exynos4_timer_interrupts(struct device_node *np,
 	 * irqs are specified.
 	 */
 	nr_irqs = of_irq_count(np);
+	if (nr_irqs > ARRAY_SIZE(mct_irqs)) {
+		pr_err("exynos-mct: too many (%d) interrupts configured in DT\n",
+			nr_irqs);
+		nr_irqs = ARRAY_SIZE(mct_irqs);
+	}
 	for (i = MCT_L0_IRQ; i < nr_irqs; i++)
 		mct_irqs[i] = irq_of_parse_and_map(np, i);
 
@@ -553,11 +558,14 @@ static int __init exynos4_timer_interrupts(struct device_node *np,
 		     mct_irqs[MCT_L0_IRQ], err);
 	} else {
 		for_each_possible_cpu(cpu) {
-			int mct_irq = mct_irqs[MCT_L0_IRQ + cpu];
+			int mct_irq;
 			struct mct_clock_event_device *pcpu_mevt =
 				per_cpu_ptr(&percpu_mct_tick, cpu);
 
 			pcpu_mevt->evt.irq = -1;
+			if (MCT_L0_IRQ + cpu >= ARRAY_SIZE(mct_irqs))
+				break;
+			mct_irq = mct_irqs[MCT_L0_IRQ + cpu];
 
 			irq_set_status_flags(mct_irq, IRQ_NOAUTOEN);
 			if (request_irq(mct_irq,
-- 
2.32.0

