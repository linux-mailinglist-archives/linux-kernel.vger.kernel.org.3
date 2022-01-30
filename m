Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B0AD4A39A8
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jan 2022 22:02:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356433AbiA3VCe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jan 2022 16:02:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356377AbiA3VCY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jan 2022 16:02:24 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09B2CC06173D
        for <linux-kernel@vger.kernel.org>; Sun, 30 Jan 2022 13:02:24 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id c190-20020a1c9ac7000000b0035081bc722dso8026550wme.5
        for <linux-kernel@vger.kernel.org>; Sun, 30 Jan 2022 13:02:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8cWPqnuW+Zg66Vr4iSn8qLu3H5+h06l8a0hGtLAknWg=;
        b=cZHZhTccn2hbg7ktHjSg0CRhqTvQxcDiHYXdlm01ktRZK8oCI1whTseKVOZOoR4Ihh
         dV1GSFlK5GzLq5dS7UlrCW9X/hpdVjSYzQi9mvSrwJQ+82KfpcY5z2X12VSEBc8vcDD9
         mhXmdAg39mrkV6G/b3Sy1eosrkLL8iduggMPakIdbFvSuvU39x+wauek4P7KYKkcxizk
         SyyFFnInW5uXarWujd+Fg+eR99Vv0CyDYDgmHKjyC1kU0qPFkFn8d0OtJtHnpTiwuU6u
         solUKUvj2FipgkX3A1MfRxHbjuDPo0v3GgbL5N3MociQ75/lRCyhwc6Zwb334j5OmogE
         Yp9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8cWPqnuW+Zg66Vr4iSn8qLu3H5+h06l8a0hGtLAknWg=;
        b=V8KRwA3n2Y1jEclr7L7jt+KQniaaR+RmGtj2t5yhCA3qm9yleLjJTV1gwmGukBEVcQ
         a+kNQ3JgF86UFmz6elEftrYANZO6KtCaSfhjdlfgMqav8MWh8jK0iZMNszfLKzBUijas
         nLQeVQ54rCb5K+N8Z0iQ/vXPYZGMJZfZhlc3pUoXzdnLGmKUQsqw9wQq831BTJh0eQlp
         x8xfwCXFo54vy4r7jlCJ4qQHMcAVTGo6ZBKOdpskOdkypZ8nZWUT2426eTYgV+dL8HPw
         r3ry2A5fZFPEq4S1iyetgQTLcbQsWEx9EMoCTqWu4WmmQDonKetGxqhr6w6gYuZf7pfi
         rl8A==
X-Gm-Message-State: AOAM531vXcO/0WX2t+gH09s5W7nmU4SaRIfsl/mV16mxIQd8xzGPytJN
        Dry/vEDLDzPGpX234feglI60Tg==
X-Google-Smtp-Source: ABdhPJzwUtuKgb1uWNz9UUnzE+Fi7SoOUIyGplaM3rWp/eKpXB/QwTP2IUG3LBsNy98m1QCKnIS43w==
X-Received: by 2002:a05:600c:2251:: with SMTP id a17mr24622958wmm.102.1643576542485;
        Sun, 30 Jan 2022 13:02:22 -0800 (PST)
Received: from localhost.localdomain ([2a01:e34:ed2f:f020:d3c5:fe0:78a4:5227])
        by smtp.gmail.com with ESMTPSA id i6sm9845185wrw.8.2022.01.30.13.02.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Jan 2022 13:02:21 -0800 (PST)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     daniel.lezcano@linaro.org, rjw@rjwysocki.net
Cc:     heiko@sntech.de, lukasz.luba@arm.com, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, ulf.hansson@linaro.org,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [PATCH v1 6/7] powercap/dtpm/dtpm_cpu: Add exit function
Date:   Sun, 30 Jan 2022 22:02:08 +0100
Message-Id: <20220130210210.549877-6-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220130210210.549877-1-daniel.lezcano@linaro.org>
References: <20220130210210.549877-1-daniel.lezcano@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that we can destroy the hierarchy, the code must remove what it
had put in place at the creation. In our case, the cpu hotplug
callbacks.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/powercap/dtpm_cpu.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/powercap/dtpm_cpu.c b/drivers/powercap/dtpm_cpu.c
index 71f45d2f5a60..bca2f912d349 100644
--- a/drivers/powercap/dtpm_cpu.c
+++ b/drivers/powercap/dtpm_cpu.c
@@ -299,8 +299,15 @@ static int dtpm_cpu_init(void)
 	return 0;
 }
 
+static void dtpm_cpu_exit(void)
+{
+	cpuhp_remove_state_nocalls(CPUHP_AP_ONLINE_DYN);
+	cpuhp_remove_state_nocalls(CPUHP_AP_DTPM_CPU_DEAD);
+}
+
 struct dtpm_subsys_ops dtpm_cpu_ops = {
 	.name = KBUILD_MODNAME,
 	.init = dtpm_cpu_init,
+	.exit = dtpm_cpu_exit,
 	.setup = dtpm_cpu_setup,
 };
-- 
2.25.1

