Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACBB252206A
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 17:58:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347051AbiEJQCW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 12:02:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346707AbiEJPxp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 11:53:45 -0400
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C487F972AA
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 08:48:37 -0700 (PDT)
Received: by mail-qv1-xf2c.google.com with SMTP id n10so3453364qvi.5
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 08:48:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5nIvN5jHmvL0M7rHAiydx+MWBBo1BQ8EVOcMzgPyHJc=;
        b=j+jYLe396oClyr5IHojQ3d3KU6CeFejzRlvRHDs9Ld9I/vVTSMS/OCJJ3NgIEdFwM4
         qlzj1QWuhz3Htg3OAhvNBNTX+bUfe0zlzVmt5DPIOXzEl/0D4ZjxedPdj6XgnJtA4C3B
         UbjsIgCaJNia8fULd3Sp3pc6Kxe/xk36JvDQzR+DZVncMyp8aT9nFrZPOvkRr+sm2B1p
         /3u957lpabocPIUdjjWz2kFKSkxylMGytjRrUyhMStAst040927tIJNsghiGfYjkPZuE
         7kDnn3cwlxqrT/G+cXepRjcT+H44svQFZtMX1ljteWIRgaYPTqnmYdw/h8zbuXMcL0lt
         RKrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5nIvN5jHmvL0M7rHAiydx+MWBBo1BQ8EVOcMzgPyHJc=;
        b=phGnTiaXjXIbpc+tRtEOaOhXCojI+4+9U/h383hCB8720iXHLLi1Z+Sk6em5hrhxJd
         IHzomvP4/sZMzFkI6Gh6dluOvBUUNC9nYUyBtggLLfctmi0uoSRbt9iI8nWa5fWAUT3V
         JRi1nrbe/e77bFxSPgLRHODGDXOisSi+/OIVI4J+o60v0BeRCH+5fEe0DizbXdts94zT
         B/W86XkAKqp1obqxNEIFVcnG9JNI/Fmp5t8SDpLwfXP3C3SG9HBUClzOzwXvWCwVqcMp
         +fFcXimk94NgR0UKG1SW310TCXTo60GgxzaqCFMIe3xrge/WJFQcyyZKS+BPb6wllgME
         UjoA==
X-Gm-Message-State: AOAM5314zMLA75oNAdY03AwN+O99K4Qf5Rl3YfVVMr+u8KXJNRCcSEf3
        0vJDUEd6skqgU3+x5LWwGgc=
X-Google-Smtp-Source: ABdhPJw8iCNDbTjDVJIhcwYTc0zGu0KHeiFsS7FlFbhAt6h15Suwh8rvq3HB2CClhGBjxk0axAjAZQ==
X-Received: by 2002:a05:6214:1844:b0:456:4f8f:7369 with SMTP id d4-20020a056214184400b004564f8f7369mr18301205qvy.107.1652197716406;
        Tue, 10 May 2022 08:48:36 -0700 (PDT)
Received: from localhost ([98.242.65.84])
        by smtp.gmail.com with ESMTPSA id n2-20020a05622a11c200b002f3dc9ebb4bsm3969501qtk.65.2022.05.10.08.48.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 May 2022 08:48:36 -0700 (PDT)
From:   Yury Norov <yury.norov@gmail.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        David Laight <David.Laight@ACULAB.COM>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Joe Perches <joe@perches.com>,
        Julia Lawall <Julia.Lawall@inria.fr>,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>,
        Nicholas Piggin <npiggin@gmail.com>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        Peter Zijlstra <peterz@infradead.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Matti Vaittinen <Matti.Vaittinen@fi.rohmeurope.com>,
        linux-kernel@vger.kernel.org
Cc:     Yury Norov <yury.norov@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH 22/22] clockevents: use cpumask_weight_eq() in tick_cleanup_dead_cpu()
Date:   Tue, 10 May 2022 08:47:50 -0700
Message-Id: <20220510154750.212913-23-yury.norov@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220510154750.212913-1-yury.norov@gmail.com>
References: <20220510154750.212913-1-yury.norov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace cpumask_weight() with cpumask_weight_eq(..., 1) because the it may
return earlier.

CC: Thomas Gleixner <tglx@linutronix.de>
CC: linux-kernel@vger.kernel.org
Signed-off-by: Yury Norov <yury.norov@gmail.com>
---
 kernel/time/clockevents.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/time/clockevents.c b/kernel/time/clockevents.c
index 5d85014d59b5..fa651263650f 100644
--- a/kernel/time/clockevents.c
+++ b/kernel/time/clockevents.c
@@ -648,7 +648,7 @@ void tick_cleanup_dead_cpu(int cpu)
 	 */
 	list_for_each_entry_safe(dev, tmp, &clockevent_devices, list) {
 		if (cpumask_test_cpu(cpu, dev->cpumask) &&
-		    cpumask_weight(dev->cpumask) == 1 &&
+		    cpumask_weight_eq(dev->cpumask, 1) &&
 		    !tick_is_broadcast_device(dev)) {
 			BUG_ON(!clockevent_state_detached(dev));
 			list_del(&dev->list);
-- 
2.32.0

