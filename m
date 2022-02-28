Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B3634C6A41
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 12:25:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235773AbiB1LZz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 06:25:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235750AbiB1LZu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 06:25:50 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0134B7091B;
        Mon, 28 Feb 2022 03:25:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=FEvdtgCJqSGYl77XcF14qfdAD9zlLGY8Q32IdruDzFU=; b=4Ne8+TEcPPSjSu4MnCysKN7oQR
        sGmL0hm5hRdylFeAd+kAYiFpNVB3pv/FUiaDANOiMMtTcJPW0zh5MbAbm5gmJf2fX2vaQGAKeX0rP
        NS8e/EBmgCkKUVjR8IrI/R181hnynqPrYrJJIJ8NHlFXsg1gG3lgqredvPFi1Hh5mYm7wuk9Lp15b
        4BSyNokwqxdBGKIaAhrqXnoR2b7+aftHOVN/Nx4uQ84q5oARDV/KLq0D+hMNFcMHcgQcYI5G3iShR
        wz8Fyqwcd55xPTwfZMA49x0tHwmgKxzRteJSx84GyTYCyPY3hEyqOIjgOtMu3H2dTHZLTlDFEHDTg
        rucPgGSA==;
Received: from [2.53.163.181] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nOe9N-00BqSC-SE; Mon, 28 Feb 2022 11:25:10 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Song Liu <song@kernel.org>
Cc:     linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/4] raid5-ppl: fully initialize the bio in ppl_new_iounit
Date:   Mon, 28 Feb 2022 13:25:00 +0200
Message-Id: <20220228112503.841449-2-hch@lst.de>
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

We have all the information to pass the bdev and op directly to bio_init,
so do that.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/md/raid5-ppl.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/md/raid5-ppl.c b/drivers/md/raid5-ppl.c
index 3446797fa0aca..f7fdd8292485d 100644
--- a/drivers/md/raid5-ppl.c
+++ b/drivers/md/raid5-ppl.c
@@ -250,7 +250,8 @@ static struct ppl_io_unit *ppl_new_iounit(struct ppl_log *log,
 	INIT_LIST_HEAD(&io->stripe_list);
 	atomic_set(&io->pending_stripes, 0);
 	atomic_set(&io->pending_flushes, 0);
-	bio_init(&io->bio, NULL, io->biovec, PPL_IO_INLINE_BVECS, 0);
+	bio_init(&io->bio, log->rdev->bdev, io->biovec, PPL_IO_INLINE_BVECS,
+		 REQ_OP_WRITE | REQ_FUA);
 
 	pplhdr = page_address(io->header_page);
 	clear_page(pplhdr);
@@ -465,8 +466,6 @@ static void ppl_submit_iounit(struct ppl_io_unit *io)
 
 
 	bio->bi_end_io = ppl_log_endio;
-	bio->bi_opf = REQ_OP_WRITE | REQ_FUA;
-	bio_set_dev(bio, log->rdev->bdev);
 	bio->bi_iter.bi_sector = log->next_io_sector;
 	bio_add_page(bio, io->header_page, PAGE_SIZE, 0);
 	bio->bi_write_hint = ppl_conf->write_hint;
-- 
2.30.2

