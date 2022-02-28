Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B9214C6A43
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 12:25:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235784AbiB1LZ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 06:25:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235764AbiB1LZy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 06:25:54 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54A0F70935;
        Mon, 28 Feb 2022 03:25:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=zi/LDCEjDayuCiJNtlU9uiCyAHTO1zUGruj/KcmLdyU=; b=LVVWpRqvQe80JWh8JrQLd1Uni2
        NXAGP8CjBH69SPnK9w16GUgm5NAW9FofOHif77tG0HBTlv9qUpQxwwrMZWrPoLnauwI4nNAuDmZf/
        WHzOB0BFwvGL6OP0xRneSf/JiZoyrX3D+QtGsJBmbHuh90g5Rc7gnlAT4QIR6YCcACzTdd/3jItlc
        qnm6O72bzGShPQAy4iiISLLvI3UY9MSeXnjYP1ArWagBT04Gioh6QP7A3oNMl/pN9RkyvmZrBW2it
        JaQsIpwFIyM/a+WEB6x6QZWdrteAO9AT9OxBDODH0LPoQfVEq8JyXxoeJHSGodH2ViSw7YDVcNN35
        WTPI4cvg==;
Received: from [2.53.163.181] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nOe9R-00BqTr-1k; Mon, 28 Feb 2022 11:25:13 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Song Liu <song@kernel.org>
Cc:     linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] raid5-cache: fully initialize flush_bio when needed
Date:   Mon, 28 Feb 2022 13:25:01 +0200
Message-Id: <20220228112503.841449-3-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220228112503.841449-1-hch@lst.de>
References: <20220228112503.841449-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Stop using bio_reset and just initialize the bio fully when needed.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/md/raid5-cache.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/md/raid5-cache.c b/drivers/md/raid5-cache.c
index 86e2bb89d9c7b..8907d18c225a9 100644
--- a/drivers/md/raid5-cache.c
+++ b/drivers/md/raid5-cache.c
@@ -1266,6 +1266,8 @@ static void r5l_log_flush_endio(struct bio *bio)
 		r5l_io_run_stripes(io);
 	list_splice_tail_init(&log->flushing_ios, &log->finished_ios);
 	spin_unlock_irqrestore(&log->io_list_lock, flags);
+
+	bio_uninit(bio);
 }
 
 /*
@@ -1301,7 +1303,7 @@ void r5l_flush_stripe_to_raid(struct r5l_log *log)
 
 	if (!do_flush)
 		return;
-	bio_reset(&log->flush_bio, log->rdev->bdev,
+	bio_init(&log->flush_bio, log->rdev->bdev, NULL, 0,
 		  REQ_OP_WRITE | REQ_PREFLUSH);
 	log->flush_bio.bi_end_io = r5l_log_flush_endio;
 	submit_bio(&log->flush_bio);
@@ -3105,7 +3107,6 @@ int r5l_init_log(struct r5conf *conf, struct md_rdev *rdev)
 	INIT_LIST_HEAD(&log->io_end_ios);
 	INIT_LIST_HEAD(&log->flushing_ios);
 	INIT_LIST_HEAD(&log->finished_ios);
-	bio_init(&log->flush_bio, NULL, NULL, 0, 0);
 
 	log->io_kc = KMEM_CACHE(r5l_io_unit, 0);
 	if (!log->io_kc)
-- 
2.30.2

