Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B78A556B862
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 13:26:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237768AbiGHLZ4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 07:25:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237705AbiGHLZy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 07:25:54 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F669904D5
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jul 2022 04:25:53 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id i190so9508921pge.7
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jul 2022 04:25:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UDl1890BxqLi0+AWKt7rROBs44QkFSQepV5hIlB2ldA=;
        b=odbsLJwCDZDPbK/HbbgrtL+F5N9C4qJ9lmpGU2vfefDkq/Y7Fj4qPROVlczLeNa9zG
         qNDHaXneqMp0+/FgkdNgaz0tCDC4rwV5RUR1HwfufDYlD2khwl03lwPU+ubSyKySFl9y
         lQ4LfqD0GWlb9CO9lhliZ0y2HLSK3npEp5ZlaWVq7WhY3PhmIsAoZNzW/hc7SFFWsRtM
         qVnpMFPSvIdsq2xJTxa2ubi99brCWMKaONNpr5zL5RHLdxCP69+BYnLWtJWn6YhZofBO
         BnQh4KaXnZv0oaEELcNzQfPlu0fIr80JPqDOzm4acqhevFa2ajSBeLxhpPcoH+pZzI/o
         tHBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UDl1890BxqLi0+AWKt7rROBs44QkFSQepV5hIlB2ldA=;
        b=Sq3nDnT1hw96R6dwd1mYhHRilwpVrDbA+OrjD/ABPYI9QTl/Yb7qfALRnwJllM6rAB
         bpH58XTTXduABJeCrfeJ3GRmuxOS/nID+PmCaw5YmAQXI90rjy35gaRSM0IcQXyKgYOa
         2uCO6jNYPMFPVtlWXjeKxPa5BlI9MfQwtFVuRWvkFCK3cTvE5NjgkfWuz11IjEoz3zZH
         6XFsKoI3UuJ3EDFMj+ZWLoyPZ8h/MOyltJFOFK+FFaO+t/HVH52I3zdPY/QeTja4TKxD
         +1/ZX7qwS5O8suJ7uu+ITUkieUxsCKraJTJ+tpuIhnoGgXYBjiJlGae7NzcOo2R1EMJP
         NeBA==
X-Gm-Message-State: AJIora8D7fL1A6V/Xt8dNP/xsy9vaxUdoLLWDKt2LgxfnH/olzzicnWj
        8fYFDxbrqFN5L1HDF8rFjbzi+A==
X-Google-Smtp-Source: AGRyM1scaHl3QUWgfXynBJoqnWLZVQTqjE0oAtWphBChk05i18c2Ayqj4WvS88Vo0rhCcZnQsREy5A==
X-Received: by 2002:a63:da47:0:b0:415:c9d:4e40 with SMTP id l7-20020a63da47000000b004150c9d4e40mr2820515pgj.408.1657279552907;
        Fri, 08 Jul 2022 04:25:52 -0700 (PDT)
Received: from localhost ([122.171.18.80])
        by smtp.gmail.com with ESMTPSA id cp2-20020a170902e78200b0015e8d4eb1d7sm29663610plb.33.2022.07.08.04.25.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Jul 2022 04:25:52 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Dipen Patel <dipenp@nvidia.com>,
        Thierry Reding <treding@nvidia.com>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] gpiolib: cdev: Don't access uninitialized descriptor
Date:   Fri,  8 Jul 2022 16:55:48 +0530
Message-Id: <585795d19c13a7136bc4b61307114591af2aea69.1657279521.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a514
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

linereq_free() can be called from in the middle of errors, where the
descriptor may be NULL for few lines. Don't access uninitialized
descriptor pointer as it leads to kernel crash:

    Unable to handle kernel NULL pointer dereference at virtual address 0000000000000008

    [...]

    Call trace:
     linereq_free+0x54/0xb8
     linereq_create+0x424/0x570
     gpio_ioctl+0x94/0x640
     __arm64_sys_ioctl+0xac/0xf0
     invoke_syscall+0x44/0x100
     el0_svc_common.constprop.3+0x6c/0xf0
     do_el0_svc+0x2c/0xb8
     el0_svc+0x20/0x60
     el0t_64_sync_handler+0x98/0xc0
     el0t_64_sync+0x170/0x174

Fixes: 2068339a6c35 ("gpiolib: cdev: Add hardware timestamp clock type")
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/gpio/gpiolib-cdev.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/gpio/gpiolib-cdev.c b/drivers/gpio/gpiolib-cdev.c
index f5aa5f93342a..d3d1b5aed282 100644
--- a/drivers/gpio/gpiolib-cdev.c
+++ b/drivers/gpio/gpiolib-cdev.c
@@ -1460,11 +1460,13 @@ static ssize_t linereq_read(struct file *file,
 static void linereq_free(struct linereq *lr)
 {
 	unsigned int i;
-	bool hte;
+	bool hte = false;
 
 	for (i = 0; i < lr->num_lines; i++) {
-		hte = !!test_bit(FLAG_EVENT_CLOCK_HTE,
-				 &lr->lines[i].desc->flags);
+		if (lr->lines[i].desc) {
+			hte = !!test_bit(FLAG_EVENT_CLOCK_HTE,
+					 &lr->lines[i].desc->flags);
+		}
 		edge_detector_stop(&lr->lines[i], hte);
 		if (lr->lines[i].desc)
 			gpiod_free(lr->lines[i].desc);
-- 
2.31.1.272.g89b43f80a514

