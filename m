Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 188AD4E1EDD
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 02:43:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343763AbiCUBoS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Mar 2022 21:44:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234768AbiCUBoQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Mar 2022 21:44:16 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAEDF17DCA8
        for <linux-kernel@vger.kernel.org>; Sun, 20 Mar 2022 18:42:51 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id d10so27024331eje.10
        for <linux-kernel@vger.kernel.org>; Sun, 20 Mar 2022 18:42:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aHacubWzDiviNCpvcWTMtixCEncOdpS21OotHIjf+Dg=;
        b=YDppa3f0inukPgu9KdWgyRLBMeRuhoGRKI2PbdhprUhL/Xls4FWt+sf55iJnvNNN4T
         slaQxzj7giHRtUOl84xe77V1cu3OcLAVj8awoAbrbp6ditM1HFZXu2zRhAogzAvosJUK
         CA+FBsqRkE4hB3g3ymXdk/Jxyx+qZ6PM4eJjHYTsMVadG6fWuk6m+824bWT5JCJAtTEZ
         usHT7SVntfueDnMx8lwZp9jkHpNj5xoK+OM+EChCMtW+v/gkrf6bsrsgWSSAxt2harPF
         8EnEmMbOplRV0NBvt+ePbjqbLs0pSUkuPwxCHiLrWjvsxXu6bNyEls7LDCfjinYkmg2Z
         glXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aHacubWzDiviNCpvcWTMtixCEncOdpS21OotHIjf+Dg=;
        b=pNd6L58xRrC8TojVQUB/fZB6UP4QMbPbubqmG7O8cj5YrTzu5wi3iBc1s2iqO20IFC
         Ukaf6jmyFZFkXVqJIRa2N/HZiAa5Uh3KC86eaUMhlu2GceQMzr7Y3WOJdPg+CRx0t9eC
         d0Nm1PESeqssuZAuVMm/iyK11AJZBPTOGfxFVnipOMNWbXE85di2iCFCN2eviuVCkdr1
         GIX81ZHgw/GFi2PuotUeYvAmsK/vhpaPm/DxUe6W/vgkhP/PgV3MOR2mtsLNMczFMvnx
         nhK1uzMiklAueIououjHvJN0k5TrhlSx3PUxcycSmUmmoq8qTXcCn2q+CI875gI5Xyic
         AcGA==
X-Gm-Message-State: AOAM531n0bZ60rYAxtj6IPLHnTzZroaznBQMtNZFMck7eWGbpG+EMsJ8
        77k8Qy/m7er97RoD5q13ysU=
X-Google-Smtp-Source: ABdhPJxXWAkG5BANLeNjWnAYJ9UBgxFcGCMdCGOpr45Mx5CylS2H44mTpU0RZME6/CEdjhBH7pDB4g==
X-Received: by 2002:a17:906:30d1:b0:6cf:c116:c9d3 with SMTP id b17-20020a17090630d100b006cfc116c9d3mr17707760ejb.245.1647826970345;
        Sun, 20 Mar 2022 18:42:50 -0700 (PDT)
Received: from localhost.localdomain (host-87-20-105-171.retail.telecomitalia.it. [87.20.105.171])
        by smtp.gmail.com with ESMTPSA id lb10-20020a170907784a00b006db0aadcbd1sm6289126ejc.219.2022.03.20.18.42.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Mar 2022 18:42:49 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     David Howells <dhowells@redhat.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        linux-kernel@vger.kernel.org
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        syzbot+d55757faa9b80590767b@syzkaller.appspotmail.com
Subject: [PATCH] watch_queue: Free the real number of allocated pages
Date:   Mon, 21 Mar 2022 02:42:46 +0100
Message-Id: <20220321014246.19941-1-fmdefrancesco@gmail.com>
X-Mailer: git-send-email 2.34.1
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

In the "error_p" label, the code calls __free_page() in a loop from
pages[0] to pages[nr_pages -1].

When pages[i] are allocated in a loop with calls to alloc_page() and one
of these allocations fails, the code jumps to the "error_p" label without
saving the real number of successful allocations and without using this
as the limit of the free cycle.

For the above-mentioned reasons, Syzbot reports a bug:
"[syzbot] KASAN: null-ptr-deref Read in __free_pages".[1]

Fix this bug by saving the real number of allocated pages and, in those
cases where the inth iteration of alloc_page() fails and the code jumps
to the "error_p" label, use that number as the upper limit for the index
of the 'for' loop that calls __free_pages(pages[i]).

[1] https://lore.kernel.org/lkml/00000000000084e0cf05daafb25f@google.com/T/#m143407dade7ed9126253175728d6f38505d2393c

Reported-and-tested-by: syzbot+d55757faa9b80590767b@syzkaller.appspotmail.com
Fixes: c73be61cede5 ("pipe: Add general notification queue support")
Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
---
 kernel/watch_queue.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/kernel/watch_queue.c b/kernel/watch_queue.c
index 00703444a219..5b0531020cf8 100644
--- a/kernel/watch_queue.c
+++ b/kernel/watch_queue.c
@@ -220,7 +220,7 @@ long watch_queue_set_size(struct pipe_inode_info *pipe, unsigned int nr_notes)
 	struct page **pages;
 	unsigned long *bitmap;
 	unsigned long user_bufs;
-	int ret, i, nr_pages;
+	int ret, i, nr_pages, allocated_pages;
 
 	if (!wqueue)
 		return -ENODEV;
@@ -254,6 +254,7 @@ long watch_queue_set_size(struct pipe_inode_info *pipe, unsigned int nr_notes)
 
 	for (i = 0; i < nr_pages; i++) {
 		pages[i] = alloc_page(GFP_KERNEL);
+		allocated_pages = i;
 		if (!pages[i])
 			goto error_p;
 		pages[i]->index = i * WATCH_QUEUE_NOTES_PER_PAGE;
@@ -271,7 +272,7 @@ long watch_queue_set_size(struct pipe_inode_info *pipe, unsigned int nr_notes)
 	return 0;
 
 error_p:
-	for (i = 0; i < nr_pages; i++)
+	for (i = 0; i < allocated_pages; i++)
 		__free_page(pages[i]);
 	kfree(pages);
 error:
-- 
2.34.1

