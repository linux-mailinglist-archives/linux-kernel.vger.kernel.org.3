Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49801484FED
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 10:21:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238825AbiAEJVV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 04:21:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbiAEJVT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 04:21:19 -0500
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B177EC061761;
        Wed,  5 Jan 2022 01:21:19 -0800 (PST)
Received: by mail-pf1-x42f.google.com with SMTP id q3so30364579pfs.7;
        Wed, 05 Jan 2022 01:21:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=9uJzRUHF9OXlzn3tKPqO1NPbNNIPyU7Xt3hf4JQjz+Q=;
        b=iGrcF8CYe1CwlA/7rDRNJlFdNDovjsfk4Tve0T0SLihtO47GhyMZQgxKXigLgGj89u
         p2gVoqp1P9lxFAGkI0BeW8lOf9Jp2R6XyqGP8c2Hvojr6pDmNjzFDyI1dVqF7wf5KOL4
         oug1ZPhHE4qLBRkDv7tBGlwx1KSISl/m3+fze5HZ0OzCf+VyiEvgRR+5U/oAohB0bf9u
         fQiywqvjLO3nO+X5tHVUi6INTHIaO/s4k7F8xvvhNv7hcyiC2vfED4xF+Hfd4ec1X6n6
         mAzIV5XOnXYomek0wJtDZ3/Qb7Li3FAwKB4hhM3aoUI64VKAG9MOk/TkU4WiGWDGUhkA
         OmMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=9uJzRUHF9OXlzn3tKPqO1NPbNNIPyU7Xt3hf4JQjz+Q=;
        b=4tx7smL7xVY4oroYncFqHgzX1Ay8DZGOIuTT7FmM6RImyPMWWcV0d/sClRql4Z//d0
         DIdLfV0bspAN3wsarklQMDSuPovC8nOQ3WF6vtku7fjVg0AicF5WFDiFz9PqiqjsUbqt
         h4nKpuHBPkfkqdU3fYevONUW5Mxy07RD6fZRQxamTHP2NlDvxYCQ7NlYusqnVUH8m/cm
         hpzPqgitrbf91PQVuJJ4bTPh9vnEjkIs/3U4Iz1g1xQhKNsGXq1Tfw3XFPEWxx4LeHUp
         wHY3lDZBtIg9jR9/oSQlsX84sdxUTyg2MVHHm2r+83P9MIDJlwIweAG105dslWPStyv+
         vF0Q==
X-Gm-Message-State: AOAM530R2G7Qy0yTI887oPFIzlLNY6mALEsGNn0BYzQTsJvFvi7FaArL
        c0AP2SIrYQdMZNJnbDgV4ig=
X-Google-Smtp-Source: ABdhPJy36k17ORaVBVSQNbjrAqIwSmrz8fEOt13jaJbNcwsdDaxTIdBMZc1UrBlSJjHjKAnZL+QVAA==
X-Received: by 2002:a63:33cf:: with SMTP id z198mr45061880pgz.344.1641374479231;
        Wed, 05 Jan 2022 01:21:19 -0800 (PST)
Received: from localhost.localdomain ([159.226.95.43])
        by smtp.googlemail.com with ESMTPSA id l11sm11425040pfu.115.2022.01.05.01.21.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jan 2022 01:21:19 -0800 (PST)
From:   Miaoqian Lin <linmq006@gmail.com>
Cc:     linmq006@gmail.com, Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Tero Kristo <t-kristo@ti.com>, linux-watchdog@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] watchdog: rti-wdt: Add missing pm_runtime_disable() in probe function
Date:   Wed,  5 Jan 2022 09:21:13 +0000
Message-Id: <20220105092114.23932-1-linmq006@gmail.com>
X-Mailer: git-send-email 2.17.1
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the probe fails, we should use pm_runtime_disable() to balance
pm_runtime_enable().

Fixes: 2d63908 ("watchdog: Add K3 RTI watchdog support")
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
 drivers/watchdog/rti_wdt.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/watchdog/rti_wdt.c b/drivers/watchdog/rti_wdt.c
index 117bc2a8eb0a..db843f825860 100644
--- a/drivers/watchdog/rti_wdt.c
+++ b/drivers/watchdog/rti_wdt.c
@@ -228,6 +228,7 @@ static int rti_wdt_probe(struct platform_device *pdev)
 	ret = pm_runtime_get_sync(dev);
 	if (ret) {
 		pm_runtime_put_noidle(dev);
+		pm_runtime_disable(&pdev->dev);
 		return dev_err_probe(dev, ret, "runtime pm failed\n");
 	}
 
-- 
2.17.1

