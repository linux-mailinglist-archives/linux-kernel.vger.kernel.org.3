Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8246494B6A
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 11:10:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359763AbiATKKd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 05:10:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234793AbiATKKc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 05:10:32 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F87EC061574;
        Thu, 20 Jan 2022 02:10:32 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id d12-20020a17090a628c00b001b4f47e2f51so6427260pjj.3;
        Thu, 20 Jan 2022 02:10:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=IHoRYXmsI6hCwlePGthADoqqx8EGqrGxFXJW5zS+sQ0=;
        b=YvqpLTSOHM9Pz6U4id3HfU1MmCRrcgTcmZmMu7/AyGjpEZsiMKlXASida8OEvzGXFY
         PCcpga6trrt0kerBrrNxJCQMUXEr6uNh3xjzFIiZ7eqDL27zLSCDayK9lnp3+ir8M3ud
         l7l7JmSX7E1rL6Hd1Rkiv0PvJ5WWfVfC5RGxT9D+o4qFcRrKkkJ8DpNyTXMxj6GL5dIg
         cIvzv6l4HkdnbG9LsBIfP4rbzA8VWZnfTtlWHEqIZLWE2/gCRDkudtdwcXdBBJZ5rCmi
         1AcSSwicf50fhecPaZoQrydMVET5WUJv8wkbAX/Y5ZjsAqcEggFLmh5kdtS4dbuoyqWe
         DVRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=IHoRYXmsI6hCwlePGthADoqqx8EGqrGxFXJW5zS+sQ0=;
        b=Q+ng7fZ5PTut7BfxQyy2EpJNVxeD/2+yaHDGuANlfYnmprE+UsBF3E3pS3ORzwwdxM
         nxMcPaLPkRxHES3v3FKMZUfG8xakVf2LLde34KJaG6jHcJuLcwdc6qXaqgyFG2lulG8P
         YnSY4IbNh7oLO0AbwW8meaj/kWaGgJgeVlgdanSnKLEtSsBuXFLT7ST7fjoFrG3kzZhd
         PieELFsUCURX4WbbKrTf60/9TV24f4/7HTfOtN/C7LWwtvutvuqPWMAzbORY0WIOUm1O
         fnyF9KKQHOIzLhoYiT4URorMmFz37xz8OTQox9CBozEHFbLIuUi+I/Zmueg+10pHT9BZ
         Vm5g==
X-Gm-Message-State: AOAM533deGX1r6Q3mEbRh7V2y857kZ75lp8sUyaQHOxyG+JeGBuRxMgp
        Hbr0AUQGgOTwqst+BxOz/c0=
X-Google-Smtp-Source: ABdhPJz/6lhApOItRjC9jAHbqU8MScNTsw4oqQ+fYOBEGjosaF0Bth4k4RFBB6qZHb/wDOjm1Oi7ow==
X-Received: by 2002:a17:90b:1bc9:: with SMTP id oa9mr9912048pjb.47.1642673431696;
        Thu, 20 Jan 2022 02:10:31 -0800 (PST)
Received: from localhost.localdomain ([159.226.95.43])
        by smtp.googlemail.com with ESMTPSA id x7sm2862788pfh.178.2022.01.20.02.10.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jan 2022 02:10:31 -0800 (PST)
From:   Miaoqian Lin <linmq006@gmail.com>
To:     Jens Axboe <axboe@kernel.dk>, Hannes Reinecke <hare@suse.de>,
        Keith Busch <kbusch@kernel.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     linmq006@gmail.com
Subject: [PATCH] block: fix memory leak in disk_register_independent_access_ranges
Date:   Thu, 20 Jan 2022 10:10:25 +0000
Message-Id: <20220120101025.22411-1-linmq006@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kobject_init_and_add() takes reference even when it fails.
According to the doc of kobject_init_and_add()

   If this function returns an error, kobject_put() must be called to
   properly clean up the memory associated with the object.

Fix this issue by adding kobject_put().
Callback function blk_ia_ranges_sysfs_release() in kobject_put()
can handle the pointer "iars" properly.

Fixes: a2247f19ee1c ("block: Add independent access ranges support")
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
 block/blk-ia-ranges.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/blk-ia-ranges.c b/block/blk-ia-ranges.c
index b925f3db3ab7..18c68d8b9138 100644
--- a/block/blk-ia-ranges.c
+++ b/block/blk-ia-ranges.c
@@ -144,7 +144,7 @@ int disk_register_independent_access_ranges(struct gendisk *disk,
 				   &q->kobj, "%s", "independent_access_ranges");
 	if (ret) {
 		q->ia_ranges = NULL;
-		kfree(iars);
+		kobject_put(&iars->kobj);
 		return ret;
 	}
 
-- 
2.17.1

