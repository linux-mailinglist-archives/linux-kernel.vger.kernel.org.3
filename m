Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 475CA4974A0
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jan 2022 19:42:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234801AbiAWSmQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jan 2022 13:42:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239984AbiAWSlX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jan 2022 13:41:23 -0500
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA93CC06177E;
        Sun, 23 Jan 2022 10:41:22 -0800 (PST)
Received: by mail-pg1-x52f.google.com with SMTP id h23so13123433pgk.11;
        Sun, 23 Jan 2022 10:41:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=6Ui4qYj030cyXXLNoJCYbzVgN3GtE9ORNZ/WmrY4RZ0=;
        b=bvjD/rU6iqsebFa6UrcK3iewqd10jG4LVBWUGqLPKS6DQHmKsM0GlWrRcDkwm32wez
         K2Tav2t5udTw/hhvd4t8Ul9uRQspEUYlHM2i05GSTepFyaem1ef2UrxlUOykmr/yIVwQ
         /LBLWZgnweBxdfSFAOGfeJDVTH8CBqw5Z6Tjd4R8ePwhjhCFathcOrwavkUjnB6NU7re
         rNo7Wqa3tUpSJLsAu4J/S0oXA9AhDk6aKHUwEoolQiPPOZJnjRuSzrwbX89WRuubEGpG
         JV3SpEZBVcZaT1MRC3c+z3VssVlfm7kpONiwsTOcm5S+lWEWrx6Ow2eBzVXGhCJbZ0Kz
         8Mtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6Ui4qYj030cyXXLNoJCYbzVgN3GtE9ORNZ/WmrY4RZ0=;
        b=gTmwqm+gEreKHs475whqEdd50qE1hR3TMs5xD1b8Qljvdnes5nZ2RBmXeI6wXnLG4h
         9BDvkxMZZkQ/TNPXCsrI8q5l2emy+b5Z39IKRHuf0INfKo7lAuuVLbKGNAlcNW1iNlXa
         6Z0jFklUqwAtfE87SwaGemWrH9cGymdVbKGdfQIQSPIK5LFdYZkHDlDBpbZXvFfd71Yy
         CctB6e+Vs9Cg0rCyWvANKt73CuiNHV7HZtyKl0ykgo3GuDd5YhDMIfCnDB/5qv5k76ai
         Pjgh0LFvPCKwelGA0cNl81GVvCvr8PY9QggEcAgGZqUXn0KE26QEnyWA9T6vo34EzzHX
         IATg==
X-Gm-Message-State: AOAM532RjT3/yEf65t1DOGCNth+EBP/hVHcuVpRa1MCCBS7Cyrzx7s5A
        ORdYcZLmvxPygjNwgjocwlE=
X-Google-Smtp-Source: ABdhPJyHxkBqoZNM3/a8yoh+/kvzF/9ryJCIZITMK5v7+MiHPMppX6GN7won1auHHokIPW78B5j2mA==
X-Received: by 2002:a63:1f07:: with SMTP id f7mr9444383pgf.219.1642963282332;
        Sun, 23 Jan 2022 10:41:22 -0800 (PST)
Received: from localhost (searspoint.nvidia.com. [216.228.112.21])
        by smtp.gmail.com with ESMTPSA id y42sm5576483pfw.157.2022.01.23.10.41.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Jan 2022 10:41:22 -0800 (PST)
From:   Yury Norov <yury.norov@gmail.com>
To:     Yury Norov <yury.norov@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Andrew Morton <akpm@linux-foundation.org>,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        David Laight <David.Laight@aculab.com>,
        Joe Perches <joe@perches.com>, Dennis Zhou <dennis@kernel.org>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Nicholas Piggin <npiggin@gmail.com>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Alexey Klimov <aklimov@redhat.com>,
        linux-kernel@vger.kernel.org,
        Maxim Levitsky <maximlevitsky@gmail.com>,
        Alex Dubov <oakad@yahoo.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Jens Axboe <axboe@kernel.dk>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Colin Ian King <colin.king@intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Shubhankar Kuranagatti <shubhankarvk@gmail.com>,
        linux-mmc@vger.kernel.org
Subject: [PATCH 30/54] drivers/memstick: replace bitmap_weight with bitmap_weight_eq where appropriate
Date:   Sun, 23 Jan 2022 10:39:01 -0800
Message-Id: <20220123183925.1052919-31-yury.norov@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220123183925.1052919-1-yury.norov@gmail.com>
References: <20220123183925.1052919-1-yury.norov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

msb_validate_used_block_bitmap() calls bitmap_weight() to compare the
weight of bitmap with a given number. We can do it more efficiently with
bitmap_weight_eq because conditional bitmap_weight may stop traversing the
bitmap earlier, as soon as condition is met.

Signed-off-by: Yury Norov <yury.norov@gmail.com>
---
 drivers/memstick/core/ms_block.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/memstick/core/ms_block.c b/drivers/memstick/core/ms_block.c
index 0cda6c6baefc..5cdd987e78f7 100644
--- a/drivers/memstick/core/ms_block.c
+++ b/drivers/memstick/core/ms_block.c
@@ -155,8 +155,8 @@ static int msb_validate_used_block_bitmap(struct msb_data *msb)
 	for (i = 0; i < msb->zone_count; i++)
 		total_free_blocks += msb->free_block_count[i];
 
-	if (msb->block_count - bitmap_weight(msb->used_blocks_bitmap,
-					msb->block_count) == total_free_blocks)
+	if (bitmap_weight_eq(msb->used_blocks_bitmap, msb->block_count,
+				msb->block_count - total_free_blocks))
 		return 0;
 
 	pr_err("BUG: free block counts don't match the bitmap");
-- 
2.30.2

