Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D4CD59F230
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 05:51:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233882AbiHXDvN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 23:51:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234164AbiHXDvI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 23:51:08 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B05F41E3D0
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 20:51:05 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id t11-20020a17090a510b00b001fac77e9d1fso280634pjh.5
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 20:51:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=hVbygpsX18bADu8621RDiTY25Ix7yxtXTuIImkqKqAc=;
        b=imJxJFMkD+pFI/m/eVMOuoWfkOen19J/ktKtwmDwT/PY6U1bYPSWCflbZVFU5jWkV2
         pfQOzdoocVBRJb1gZMFSfQxlLoee6iCsXkcFja/ka+GlaPn29zI33jGlRMvu9YMTmDTP
         AAbB+NZhj1viQNfFLY56OwZGbE6QIPGg+J8QQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=hVbygpsX18bADu8621RDiTY25Ix7yxtXTuIImkqKqAc=;
        b=HMRn5WjA000fGOId86O8CtDBYqncqbANKUkhf4Nqitgw5NN0nil/JGXpBtkw10PGSJ
         YaOwoD962rxIleR/YM/H5d5ATjaTs5swhqVdYSGW2zjYjWhjmu7+XKNhCJZvXoBAaCOY
         L2xFVgFfNRH0MdwP+NeaQ4wMHVxGs8NFvdffPqSS2U4ZjunMrdumFZsYPlBP1Nl9HNKf
         nWpLk5l3EX2VZFXlLm+hUkGrsnpz0JU/JgKNdC0xCF03IsUmif4Ccs4CKnsA6VzaxiO0
         1KQfBQPR1c75P+JTw/w0HiJTXoPJa94P+u1wGj1VoOUixNnj60xjE31XFgCv+ArbmQas
         Wj4g==
X-Gm-Message-State: ACgBeo0e871EZVqt38FSnTXyCHj6mO2iFz812Dv2JRfTcGr0M8kOq+lR
        xsEScAa4sSsrxDAcj1YDYdRqNOHBV3jASQ==
X-Google-Smtp-Source: AA6agR5+lKH6mqJCr0IR+RV7GQ3KgHD8KR0ilIw5+VWN6nDlIo/PEU275jXMmLB7C0ZQdPOcTB+70A==
X-Received: by 2002:a17:90b:1d0b:b0:1f5:6554:d556 with SMTP id on11-20020a17090b1d0b00b001f56554d556mr6356470pjb.168.1661313065077;
        Tue, 23 Aug 2022 20:51:05 -0700 (PDT)
Received: from tigerii.tok.corp.google.com ([2401:fa00:8f:203:969c:a365:dc63:66dc])
        by smtp.gmail.com with ESMTPSA id nn18-20020a17090b38d200b001fa80cde150sm178343pjb.20.2022.08.23.20.51.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Aug 2022 20:51:04 -0700 (PDT)
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Minchan Kim <minchan@kernel.org>
Cc:     Nitin Gupta <ngupta@vflare.org>, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org,
        Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCH] block:zram: do not keep dangling zcomp pointer after zram reset
Date:   Wed, 24 Aug 2022 12:51:00 +0900
Message-Id: <20220824035100.971816-1-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.37.2.609.g9ff673ca1a-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We do all reset operations under write lock, so we don't need
to save ->disksize and ->comp to stack variables. Another thing
is that ->comp is freed during zram reset, but comp pointer is
not NULL-ed, so zram keeps the freed pointer value.

Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 drivers/block/zram/zram_drv.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index 0c8c211f051f..4fc99c5667ef 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -1721,9 +1721,6 @@ static int zram_rw_page(struct block_device *bdev, sector_t sector,
 
 static void zram_reset_device(struct zram *zram)
 {
-	struct zcomp *comp;
-	u64 disksize;
-
 	down_write(&zram->init_lock);
 
 	zram->limit_pages = 0;
@@ -1733,17 +1730,15 @@ static void zram_reset_device(struct zram *zram)
 		return;
 	}
 
-	comp = zram->comp;
-	disksize = zram->disksize;
-	zram->disksize = 0;
-
 	set_capacity_and_notify(zram->disk, 0);
 	part_stat_set_all(zram->disk->part0, 0);
 
 	/* I/O operation under all of CPU are done so let's free */
-	zram_meta_free(zram, disksize);
+	zram_meta_free(zram, zram->disksize);
+	zram->disksize = 0;
 	memset(&zram->stats, 0, sizeof(zram->stats));
-	zcomp_destroy(comp);
+	zcomp_destroy(zram->comp);
+	zram->comp = NULL;
 	reset_bdev(zram);
 
 	up_write(&zram->init_lock);
-- 
2.37.2.609.g9ff673ca1a-goog

