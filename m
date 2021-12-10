Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 283E546F818
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 01:30:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234921AbhLJAd6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 19:33:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234904AbhLJAd6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 19:33:58 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7EF3C061746
        for <linux-kernel@vger.kernel.org>; Thu,  9 Dec 2021 16:30:23 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id iq11so5669243pjb.3
        for <linux-kernel@vger.kernel.org>; Thu, 09 Dec 2021 16:30:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rdvJHl0i5fz0K7jqw1DWezy/+uZJvXUTbxjwuYlGzxY=;
        b=Bv5M2obfVTHY9fhNlOO+2TNvG7pBRtHMBlsY+0Hf04M3OiAxOnTdSQx+Woev4PX1pJ
         tnpOYNolht9TygsbqizHJjmjSzqf8YrHPGPpJiEPqozEhTB//r5yOEageeaVYLb5c9zP
         vINoeuM+pIuW90zRmTEX3I2uzBZUb2YaoXJ71tWACoLOOL+ps5Yti1HqQigrzD2818Kg
         wvdKAArcmxrFK9mUINR9iEyQojd6fwJuMiANFUBMobSebuTWkW1DY/Pk+y5+4pczRfzi
         dEL/NUsSkZQiLBhdW5kc9qXE+RfOd9GHBfU4loc1arzjJOwwrGCXjNROwsBqq8Mqk/9q
         iVcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=rdvJHl0i5fz0K7jqw1DWezy/+uZJvXUTbxjwuYlGzxY=;
        b=Rjft5GrQA07G/Iry9Pc9FitxTcOrxcfOMUEzfeZFI85PgYyTWxjxDmt5n1zVwlFSGA
         4gIOneDR1KJbrEvt+W8ALVdU+jnrFVXGpcBxfQ03VdZ4aO4WtF8ES7EBDtVC8GZHPZ+0
         EcQBwLOst3hCBdozMiBvT0UAtaRta9hJZklpfQa5wBAZWVg44H48ivyvntPrasWwYl1w
         FgsJ6XvghMns/4e4W7dIYrf1wtDBan+UBC7hg2umWcIWyRab8IhzIb4SEhyir1p2ZN/t
         XMM/mu4M2Ykdttq55zjKmx1RWNeDagGrJ9tuA2mRspVlkvfmWd2B/srEC9VImza4DZhV
         avHQ==
X-Gm-Message-State: AOAM531fZpBYTj1xHi7q3ijyVCRMFIQpS42jXInaDTtoRVPwT5bmbkdB
        2gu3Dwzgrly+H+bD23xp70RHHDcjaSk=
X-Google-Smtp-Source: ABdhPJxltfyhSOR+7pzxI138l0a84xLSD7ieiPi2r6U8CTmbE48TU5YjOfNdpK1pxQQ1M5tFtJvQPw==
X-Received: by 2002:a17:902:b615:b0:143:bbf0:aad0 with SMTP id b21-20020a170902b61500b00143bbf0aad0mr71880019pls.12.1639096223184;
        Thu, 09 Dec 2021 16:30:23 -0800 (PST)
Received: from bbox-1.mtv.corp.google.com ([2620:15c:211:201:85e0:23ee:fbe7:282b])
        by smtp.gmail.com with ESMTPSA id i10sm764029pjd.3.2021.12.09.16.30.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Dec 2021 16:30:22 -0800 (PST)
Sender: Minchan Kim <minchan.kim@gmail.com>
From:   Minchan Kim <minchan@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Suren Baghdasaryan <surenb@google.com>,
        John Dias <joaodias@google.com>,
        Minchan Kim <minchan@kernel.org>
Subject: [PATCH] mm/madvise: pageout under plugging
Date:   Thu,  9 Dec 2021 16:30:19 -0800
Message-Id: <20211210003019.1481269-1-minchan@kernel.org>
X-Mailer: git-send-email 2.34.1.173.g76aa8bc2d0-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Likewise shrink_lruvec[1], madvise_pageout could get the benefit
from per-task block plug.

[1] 3da367c3e5fc, vmscan: add block plug for page reclaim
Signed-off-by: Minchan Kim <minchan@kernel.org>
---
 mm/vmscan.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index fb9584641ac7..cf11113f6adb 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -2556,6 +2556,7 @@ unsigned long reclaim_pages(struct list_head *page_list)
 	struct reclaim_stat dummy_stat;
 	struct page *page;
 	unsigned int noreclaim_flag;
+	struct blk_plug plug;
 	struct scan_control sc = {
 		.gfp_mask = GFP_KERNEL,
 		.may_writepage = 1,
@@ -2564,6 +2565,7 @@ unsigned long reclaim_pages(struct list_head *page_list)
 		.no_demotion = 1,
 	};
 
+	blk_start_plug(&plug);
 	noreclaim_flag = memalloc_noreclaim_save();
 
 	while (!list_empty(page_list)) {
@@ -2603,6 +2605,8 @@ unsigned long reclaim_pages(struct list_head *page_list)
 	}
 
 	memalloc_noreclaim_restore(noreclaim_flag);
+	blk_finish_plug(&plug);
+
 
 	return nr_reclaimed;
 }
-- 
2.34.1.173.g76aa8bc2d0-goog

