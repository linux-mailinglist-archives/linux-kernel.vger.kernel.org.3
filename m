Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F39F34A39A9
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jan 2022 22:02:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356468AbiA3VCj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jan 2022 16:02:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356358AbiA3VC1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jan 2022 16:02:27 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04BAFC061714
        for <linux-kernel@vger.kernel.org>; Sun, 30 Jan 2022 13:02:27 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id m14so21385242wrg.12
        for <linux-kernel@vger.kernel.org>; Sun, 30 Jan 2022 13:02:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MNQUuQFFfpeWugiolZqopaG6OtAWAYvBDQU1DSusnnk=;
        b=kHh6+rnAfh1UicGsC+iJz9NJQum0K2Cxfwo4EqwieSebI9JjCzku9c+/47G38UUuuS
         OMZ9UMlxqVkK1n1TuEvSgEESwt2BSbn2IfkLx4Rc8qxW9NOrdgJ/bSED5jAOrNXM3EtJ
         lTZLyHJEufuRQdpYbgHsGC8Ts4qncbAug9thUjRUm2n0kk/1iO4QT3pUHZVbWtTF7hIf
         /HnMPGBos/MHr+Zx2okCr8mjdtkGr2cy7Akp+A1jIHwsnaGDpwFnEo6zggRlT1jKt4Y1
         wFfs6rICskTLjQE2VCdu021HMul+hsBRy6s8mvrCRO4+hvrbUvoTzDAcYnaM8XTEJsAq
         7k/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MNQUuQFFfpeWugiolZqopaG6OtAWAYvBDQU1DSusnnk=;
        b=Kcybp7JMrK5vaS95dbVAMvMoz95jt5/2RaaJICscKIXznwl0Zi9IonA9Tb8eL9oiWI
         yY2HBsa9clLlGAyPm1HQ5f+kkKfpVmwB9XJRkzQOv8U7TeGQovFxdljhhVIqYnHKUpqa
         rypUxqjAanTEZVKFwD73vEmjvOaBWcm/oHOgMTuGOKhdJHVgMJfRZd9vgiwsjjILm9z9
         JuyXcWgh1XOs1ZAVkFY4haF02ZHa0BCB6eoNt8T/quN4Zh1JUwIQwlZXItiXJvsCBSiU
         16LkIyGxyXELlUqOxUNBmCxFIwcM4NprssX7+wZmxH4fR2YTZKHcoYYzCROLDI6JEJ3L
         3jqQ==
X-Gm-Message-State: AOAM533FQpZx5SnnbNqxx8IjW/iz2rZadSc5Bm5wa0k91kvbvDxeszhy
        LohvqZbDrUE0Y11S6hAuETUncA==
X-Google-Smtp-Source: ABdhPJwnWuziiq1f4PdtrcCYU1OtKdjwSfYjmTBoTDV76XQcm47JlfCtRFtPAz9INT1cD5L8qeIjoQ==
X-Received: by 2002:adf:fe01:: with SMTP id n1mr15207083wrr.141.1643576545483;
        Sun, 30 Jan 2022 13:02:25 -0800 (PST)
Received: from localhost.localdomain ([2a01:e34:ed2f:f020:d3c5:fe0:78a4:5227])
        by smtp.gmail.com with ESMTPSA id i6sm9845185wrw.8.2022.01.30.13.02.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Jan 2022 13:02:24 -0800 (PST)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     daniel.lezcano@linaro.org, rjw@rjwysocki.net
Cc:     heiko@sntech.de, lukasz.luba@arm.com, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, ulf.hansson@linaro.org,
        linux-arm-kernel@lists.infradead.org (moderated list:ARM/Rockchip SoC
        support),
        linux-rockchip@lists.infradead.org (open list:ARM/Rockchip SoC support)
Subject: [PATCH v1 7/7] dtpm/soc/rk3399: Add the ability to unload the module
Date:   Sun, 30 Jan 2022 22:02:09 +0100
Message-Id: <20220130210210.549877-7-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220130210210.549877-1-daniel.lezcano@linaro.org>
References: <20220130210210.549877-1-daniel.lezcano@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The dtpm hierarchy can now be removed with the
dtpm_destroy_hierarchy() function. Add the module_exit() callback so
the module can be unloaded by removing the previously created
hierarchy.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/soc/rockchip/dtpm.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/soc/rockchip/dtpm.c b/drivers/soc/rockchip/dtpm.c
index ebebb748488b..5a23784b5221 100644
--- a/drivers/soc/rockchip/dtpm.c
+++ b/drivers/soc/rockchip/dtpm.c
@@ -52,6 +52,12 @@ static int __init rockchip_dtpm_init(void)
 }
 module_init(rockchip_dtpm_init);
 
+static void __exit rockchip_dtpm_exit(void)
+{
+	return dtpm_destroy_hierarchy();
+}
+module_exit(rockchip_dtpm_exit);
+
 MODULE_SOFTDEP("pre: panfrost cpufreq-dt");
 MODULE_DESCRIPTION("Rockchip DTPM driver");
 MODULE_LICENSE("GPL");
-- 
2.25.1

