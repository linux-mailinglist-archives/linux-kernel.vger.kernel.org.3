Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 467AB4BC294
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 23:27:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240120AbiBRW17 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 17:27:59 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:48074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232331AbiBRW14 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 17:27:56 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B715285A99
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 14:27:39 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id y18so8205155plb.11
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 14:27:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RCW/+7BeMgwUktuYHiRiifRgvAyXvxvZWS62/OY0Kjw=;
        b=JO/IQfkMyJ6+MveDYmKDaOfmZTiiG2uek7d0QuCUe+hr8ZqXUUXnr0/58m0gl9/f8w
         HOQD7OfNrIvhtggF8+5sdaw50g+sdNQsN9czNYdJAnBQVzRLuAKxsRowGk7WDnCHjs/p
         ngOArD7J9QuHG+uWsbU7MFe62knKwwbsbMKlvKRq5HzLWh3+ieLzop4VnIiWF4Qkgg7k
         VN1EC6Ooywpi8VIQWB/YqC+iXJeB6PSD7GPVQ4uXqF82KplmXbc6k9Jveed5C3yWazf4
         Rf9FsuQ4dMx+JWhbmsa/VgSU3C8UGxO4LyEpt4JczN1h5CbECKZmdkExGYWEuvVaU3yi
         9t1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RCW/+7BeMgwUktuYHiRiifRgvAyXvxvZWS62/OY0Kjw=;
        b=A86hmXBK4FNSMIuPOxwDAV4Dlok6ONCPnbvLlpVzHl5p7Wb8UO/USp2Am/VOGcSZju
         r7pDwVNC6yNLTK9Xn7b3MbrJvLoMpYAxnT1G5JQKAcbrnZwDDn/LD05OqpBPvm1f57Zq
         2bkIbnF3lCxirtg8i5ZbhZxS8DrSxJQhipECnhRohRR+j+RrfdEvr+ifXC9SegdskieN
         Fa50afsMwtf/9uHKc+tW8gahlOko1CxwspABgDOMzT9sC82oXL2feNJ2S1fADL0kWGed
         bhsZhp88lHqGIcAmP0+o3WV2wkKXAc9tBfivQs0HaDTisljQnQJH09LrYFNzPgdpurSo
         otNw==
X-Gm-Message-State: AOAM530Qvq9XrAyoxgdC1XOTQfO/UvskLux2dhyuCLugG+m13MR+4BZX
        mNCYJ1vQqvJYbXhKeoLNYQs=
X-Google-Smtp-Source: ABdhPJyujmIMn0tC8gKa5kqHWj0U/Dyhv+iqweU3gzcsS5ysg+BGgCRISeBYEYj30vNfuaxZOdSMjA==
X-Received: by 2002:a17:90a:c913:b0:1b8:d641:cc1e with SMTP id v19-20020a17090ac91300b001b8d641cc1emr10406292pjt.76.1645223259048;
        Fri, 18 Feb 2022 14:27:39 -0800 (PST)
Received: from baohua-VirtualBox.localdomain (47-72-151-34.dsl.dyn.ihug.co.nz. [47.72.151.34])
        by smtp.gmail.com with ESMTPSA id v2sm321403pjt.55.2022.02.18.14.27.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Feb 2022 14:27:38 -0800 (PST)
From:   Barry Song <21cnbao@gmail.com>
X-Google-Original-From: Barry Song <song.bao.hua@hisilicon.com>
To:     agk@redhat.com, snitzer@redhat.com, dm-devel@redhat.com
Cc:     linux-kernel@vger.kernel.org, linuxarm@huawei.com,
        Barry Song <song.bao.hua@hisilicon.com>,
        Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>
Subject: [PATCH v2] dm io: Drop the obsolete and incorrect doc for dm_io()
Date:   Sat, 19 Feb 2022 06:27:24 +0800
Message-Id: <20220218222724.4802-1-song.bao.hua@hisilicon.com>
X-Mailer: git-send-email 2.25.1
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

Commit 7eaceaccab5f ("block: remove per-queue plugging") dropped
unplug_delay and blk_unplug(). Plus, the current kernel has no
fundamental difference between sync_io() and async_io() except
sync_io() uses sync_io_complete() as the notify.fn and explicitly
calls wait_for_completion_io() to sync. The comment isn't valid
any more.

Cc: Jens Axboe <axboe@kernel.dk>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Barry Song <song.bao.hua@hisilicon.com>
---
 -v2: refine commit log;
      add revewed-by of Christoph, thanks!

 drivers/md/dm-io.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/md/dm-io.c b/drivers/md/dm-io.c
index 2d3cda0acacb..7dba193de28b 100644
--- a/drivers/md/dm-io.c
+++ b/drivers/md/dm-io.c
@@ -528,11 +528,6 @@ static int dp_init(struct dm_io_request *io_req, struct dpages *dp,
 
 /*
  * New collapsed (a)synchronous interface.
- *
- * If the IO is asynchronous (i.e. it has notify.fn), you must either unplug
- * the queue with blk_unplug() some time later or set REQ_SYNC in
- * io_req->bi_opf. If you fail to do one of these, the IO will be submitted to
- * the disk after q->unplug_delay, which defaults to 3ms in blk-settings.c.
  */
 int dm_io(struct dm_io_request *io_req, unsigned num_regions,
 	  struct dm_io_region *where, unsigned long *sync_error_bits)
-- 
2.25.1

