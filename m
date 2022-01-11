Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F4A848B1ED
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 17:20:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349947AbiAKQUK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 11:20:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349866AbiAKQUE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 11:20:04 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3454C06173F
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jan 2022 08:20:03 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id e5so11445051wmq.1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jan 2022 08:20:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LNavg6slnLVF2pA7Kvog5iF0WK+VouZt0xEEF7YPuos=;
        b=FSJvbsOCKmqqt5kOvJY3egaKUHZByEsTSa8ZVMnSXdj/+5+Pmu4zWm91p4R58OEdmv
         HpCVFpRfLzs7mIs2Y1iAlpDbA2Pu9nmU6+k6V0wr26iRO7nC+rOR3lyQ/VOU8IIDf/7G
         9RJLf9SheBmCAaLr7k1JNiKiQ4DIb/YMDaTcQk/fPd+oGBEZJIPdGUjyU8tlz/rilVBp
         13jLAD6o2O/rV4mbshO2cdyuUbnxqvYqDayaheygQ7gA86YQ7+heAS3zJF4YFNZpB+BS
         WSSu3zVjkQ+SZpsayRNUoMq4OHxiuSMwTPORcU//Uy+t7Ku3JCB0b0nfHsHzy5SnYjR+
         KRCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LNavg6slnLVF2pA7Kvog5iF0WK+VouZt0xEEF7YPuos=;
        b=qOPDjXRC7DnAD41OKmxdWxISwUOR5qRqfncbu9Jd3W6an7MMjDFbEYYaaGnlbu/5fL
         0JAIVSkWVgrp+gD4cEvFxHB+5e7BbG19b3fainIsv1M5q6sdJW35xeJkemXlkmXG0Ctb
         K5K6eC7MMkWDdQFrlri0o8FiLi3aShrS3CJqltSqAZusiSuZDNM6tRw0Lf7CfYIiu7By
         kMrz6NgooVGzwf4IhzEVjjX2O0dR6Gj6W3SLmNaNJw+8cIXCfdrlrO/xIojv42HTlBrh
         BjprQpvCGUsQIB8YvDV0zZQ3gCw7F57MlMwznrLdLbZCAjjIfjrGksPMYQjhfRFVraGn
         aY+g==
X-Gm-Message-State: AOAM530zSNLTtqLcypiY1u09f43dpxuYYzYddaq61ULC8Nrj7zfU85HY
        PQpFBAYtg/sSDVeZJhKHptwMUFCR7gQ=
X-Google-Smtp-Source: ABdhPJyvq1TOPE/Pn+m67KZVBe4KZZZA4WLdkfUyPTop8wqs03+urlUsij2Z4GDPlZIYrUSRVqk+kA==
X-Received: by 2002:a1c:c915:: with SMTP id f21mr3091697wmb.39.1641918002542;
        Tue, 11 Jan 2022 08:20:02 -0800 (PST)
Received: from lb01399.fkb.profitbricks.net ([85.214.13.132])
        by smtp.gmail.com with ESMTPSA id p18sm3012397wmq.0.2022.01.11.08.20.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jan 2022 08:20:02 -0800 (PST)
From:   Pankaj Gupta <pankaj.gupta.linux@gmail.com>
To:     nvdimm@lists.linux.dev, virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Cc:     dan.j.williams@intel.com, jmoyer@redhat.com, stefanha@redhat.com,
        david@redhat.com, mst@redhat.com, cohuck@redhat.com,
        vishal.l.verma@intel.com, dave.jiang@intel.com,
        ira.weiny@intel.com, pankaj.gupta@ionos.com,
        Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Subject: [RFC v3 2/2] pmem: enable pmem_submit_bio for asynchronous flush
Date:   Tue, 11 Jan 2022 17:19:37 +0100
Message-Id: <20220111161937.56272-3-pankaj.gupta.linux@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220111161937.56272-1-pankaj.gupta.linux@gmail.com>
References: <20220111161937.56272-1-pankaj.gupta.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Return from "pmem_submit_bio" when asynchronous flush is
still in progress in other context.

Signed-off-by: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
---
 drivers/nvdimm/pmem.c        | 15 ++++++++++++---
 drivers/nvdimm/region_devs.c |  4 +++-
 2 files changed, 15 insertions(+), 4 deletions(-)

diff --git a/drivers/nvdimm/pmem.c b/drivers/nvdimm/pmem.c
index fe7ece1534e1..f20e30277a68 100644
--- a/drivers/nvdimm/pmem.c
+++ b/drivers/nvdimm/pmem.c
@@ -201,8 +201,12 @@ static void pmem_submit_bio(struct bio *bio)
 	struct pmem_device *pmem = bio->bi_bdev->bd_disk->private_data;
 	struct nd_region *nd_region = to_region(pmem);
 
-	if (bio->bi_opf & REQ_PREFLUSH)
+	if (bio->bi_opf & REQ_PREFLUSH) {
 		ret = nvdimm_flush(nd_region, bio);
+		/* asynchronous flush completes in other context */
+		if (ret == -EINPROGRESS)
+			return;
+	}
 
 	do_acct = blk_queue_io_stat(bio->bi_bdev->bd_disk->queue);
 	if (do_acct)
@@ -222,13 +226,18 @@ static void pmem_submit_bio(struct bio *bio)
 	if (do_acct)
 		bio_end_io_acct(bio, start);
 
-	if (bio->bi_opf & REQ_FUA)
+	if (bio->bi_opf & REQ_FUA) {
 		ret = nvdimm_flush(nd_region, bio);
+		/* asynchronous flush completes in other context */
+		if (ret == -EINPROGRESS)
+			return;
+	}
 
 	if (ret)
 		bio->bi_status = errno_to_blk_status(ret);
 
-	bio_endio(bio);
+	if (bio)
+		bio_endio(bio);
 }
 
 static int pmem_rw_page(struct block_device *bdev, sector_t sector,
diff --git a/drivers/nvdimm/region_devs.c b/drivers/nvdimm/region_devs.c
index 9ccf3d608799..8512d2eaed4e 100644
--- a/drivers/nvdimm/region_devs.c
+++ b/drivers/nvdimm/region_devs.c
@@ -1190,7 +1190,9 @@ int nvdimm_flush(struct nd_region *nd_region, struct bio *bio)
 	if (!nd_region->flush)
 		rc = generic_nvdimm_flush(nd_region);
 	else {
-		if (nd_region->flush(nd_region, bio))
+		rc = nd_region->flush(nd_region, bio);
+		/* ongoing flush in other context */
+		if (rc && rc != -EINPROGRESS)
 			rc = -EIO;
 	}
 
-- 
2.25.1

