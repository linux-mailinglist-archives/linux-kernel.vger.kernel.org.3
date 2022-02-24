Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A12F4C27BE
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 10:13:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232674AbiBXJKG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 04:10:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232651AbiBXJJo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 04:09:44 -0500
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E3E819E0A5;
        Thu, 24 Feb 2022 01:08:54 -0800 (PST)
Received: by mail-pf1-x42c.google.com with SMTP id z16so1328493pfh.3;
        Thu, 24 Feb 2022 01:08:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=hDQsn9Et1mc617/JcmOs/nm/EITJxazgEKeIY7DZHEc=;
        b=AYqn9zvsWXt6SlmmpusdHONKfDhXfLeTtIgNOIRE8rITdkQMmJa6InC1EOUvTFCBGJ
         f1t23LHEkeHf/OrcyXv+05XVM2mTSe60zxf+RAM+Cjn5P1DA8qNwhuh6FZ1l+Q+EgpYB
         66k6/8SU9a9Ef3U1HxMZVi5RH2cmALp34/P4If0BBXCoP8exsKircnskxezz70Ya2xCx
         R9IXFaayHQWbD1fuAopsMeOcNqieW4uuvE8wtrb8re011UvLI5CDTcpuTPpge3avPfUy
         mkriR9ntBZjgCWEAYoARFoO+Ohb+24cy5SEQd/gNlTB70Jb3PRrxPJMcwzGUDk3SRkfJ
         RZnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=hDQsn9Et1mc617/JcmOs/nm/EITJxazgEKeIY7DZHEc=;
        b=xTiYs8cH3McGhpYqmAxJqJD+FULFcyFValf17hdPks8f3ETU1yJRCksULg0oFO8tWD
         +84cOodJVniprQx9N4nFzWc4RNdYWZGZUvb926dv3EEB3y0ZJ2VhiM+RwOUgQ4N42WPo
         wM8WpDf+fP5pVosl7+P7wvllryF5AyTf0tcyPHv/hm1qIfHm5xN9iuu1jqExt4M1m3+9
         +nST9td2daMBkyCxQ5Fnl/U/a7vdTRFYW/Yv04s28JEvM2Au+cyMfG84jvSusEvwkN0b
         Tf/CyS/jIVfEB/S0saeViZrtTWXI646dOHF95C+VwJ0ZFsnJTHL+OzS8vjRr3xxD2G6G
         SF/A==
X-Gm-Message-State: AOAM530TaGHTlpYzVGjl2YWoUrvWmoLZnW3UMAoa41ErG1G5RVNyuLo6
        7QkCD8rRmJceoCniqqqIc60=
X-Google-Smtp-Source: ABdhPJzxPBzdZB7shuFUOj6z0/OMnu1A/4jYFIhVA0x1FOsKqiDw74qlk8e6Fk58UvQMiSxuH71FuA==
X-Received: by 2002:a62:e112:0:b0:4e1:301e:9faa with SMTP id q18-20020a62e112000000b004e1301e9faamr1956157pfh.56.1645693733778;
        Thu, 24 Feb 2022 01:08:53 -0800 (PST)
Received: from localhost.localdomain ([162.219.34.248])
        by smtp.gmail.com with ESMTPSA id nn14sm2023999pjb.45.2022.02.24.01.08.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Feb 2022 01:08:53 -0800 (PST)
From:   "Wang Jianchao (Kuaishou)" <jianchao.wan9@gmail.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Josef Bacik <jbacik@fb.com>, Tejun Heo <tj@kernel.org>,
        Bart Van Assche <bvanassche@acm.org>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC V5 13/16] blk-wbt: move cache setting to rq_qos_setting_changed()
Date:   Thu, 24 Feb 2022 17:06:51 +0800
Message-Id: <20220224090654.54671-14-jianchao.wan9@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220224090654.54671-1-jianchao.wan9@gmail.com>
References: <20220224090654.54671-1-jianchao.wan9@gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move cache setting to rq_qos_setting_changed then we can avoid
to export a standalone wbt interface to blk_queue_write_cache().

Signed-off-by: Wang Jianchao (Kuaishou) <jianchao.wan9@gmail.com>
---
 block/blk-settings.c |  4 ++--
 block/blk-wbt.c      | 13 ++-----------
 block/blk-wbt.h      |  7 -------
 3 files changed, 4 insertions(+), 20 deletions(-)

diff --git a/block/blk-settings.c b/block/blk-settings.c
index bceb1925e978..124bf5cc623f 100644
--- a/block/blk-settings.c
+++ b/block/blk-settings.c
@@ -16,7 +16,7 @@
 #include <linux/dma-mapping.h>
 
 #include "blk.h"
-#include "blk-wbt.h"
+#include "blk-rq-qos.h"
 
 void blk_queue_rq_timeout(struct request_queue *q, unsigned int timeout)
 {
@@ -800,7 +800,7 @@ void blk_queue_write_cache(struct request_queue *q, bool wc, bool fua)
 	else
 		blk_queue_flag_clear(QUEUE_FLAG_FUA, q);
 
-	wbt_set_write_cache(q, test_bit(QUEUE_FLAG_WC, &q->queue_flags));
+	rq_qos_setting_changed(q);
 }
 EXPORT_SYMBOL_GPL(blk_queue_write_cache);
 
diff --git a/block/blk-wbt.c b/block/blk-wbt.c
index 3a3a683009c4..83e05417e25f 100644
--- a/block/blk-wbt.c
+++ b/block/blk-wbt.c
@@ -615,16 +615,6 @@ static void wbt_requeue(struct rq_qos *rqos, struct request *rq)
 	}
 }
 
-void wbt_set_write_cache(struct request_queue *q, bool write_cache_on)
-{
-	struct rq_qos *rqos = wbt_rq_qos(q);
-
-	if (rqos) {
-		RQWB(rqos)->wc = write_cache_on;
-		rq_qos_put(rqos);
-	}
-}
-
 static u64 wbt_default_latency_nsec(struct request_queue *q)
 {
 	/*
@@ -656,6 +646,7 @@ static void wbt_setting_changed(struct rq_qos *rqos)
 		RQWB(rqos)->rq_depth.queue_depth = blk_queue_depth(rqos->q);
 		wbt_update_limits(RQWB(rqos));
 	}
+	RQWB(rqos)->wc = test_bit(QUEUE_FLAG_WC, &rqos->q->queue_flags);
 }
 
 static ssize_t wbt_lat_show(struct request_queue *q, char *page)
@@ -844,7 +835,7 @@ static int wbt_init(struct request_queue *q)
 	rwb->min_lat_nsec = wbt_default_latency_nsec(q);
 
 	wbt_setting_changed(&rwb->rqos);
-	wbt_set_write_cache(q, test_bit(QUEUE_FLAG_WC, &q->queue_flags));
+	rwb->wc = test_bit(QUEUE_FLAG_WC, &q->queue_flags);
 
 	ret = sysfs_create_file(&q->kobj, &wbt_attr.attr);
 	if (ret < 0)
diff --git a/block/blk-wbt.h b/block/blk-wbt.h
index fe26f78390bd..eb837dfd0ace 100644
--- a/block/blk-wbt.h
+++ b/block/blk-wbt.h
@@ -74,17 +74,10 @@ static inline unsigned int wbt_inflight(struct rq_wb *rwb)
 }
 
 #ifdef CONFIG_BLK_WBT
-
-void wbt_set_write_cache(struct request_queue *, bool);
-
 #else
-
 static inline void wbt_track(struct request *rq, enum wbt_flags flags)
 {
 }
-static inline void wbt_set_write_cache(struct request_queue *q, bool wc)
-{
-}
 #endif /* CONFIG_BLK_WBT */
 
 #endif
-- 
2.17.1

