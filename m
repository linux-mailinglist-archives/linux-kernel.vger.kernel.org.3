Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 905EF49ACC1
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 07:54:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376545AbiAYGyG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 01:54:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376456AbiAYGuN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 01:50:13 -0500
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0B7DC06B59C
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jan 2022 21:17:58 -0800 (PST)
Received: by mail-pl1-x64a.google.com with SMTP id q21-20020a170902edd500b0014ae79cc6d5so4550101plk.18
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jan 2022 21:17:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=Ocy1f8e8l5tnDktp3A5HwcgpUMQpU1wPRyfhdTDw5M8=;
        b=VeHwN5GkQbTg4xXyCkEkUwiJWbtdR+uqWnLLC+h4ovZG0cDZTJcvgJIH2cBuR1bq/z
         k+hrJ7P+DlciIwsI/fEaKDEwZan3zTiRMxn5AE3MW2Kqp8OauhOn/pkI0mA1UjkWnTFm
         diE1GSsMVdImczBIfjkOnOLAiUiVdFxrWlAMOgJprfvVLmsaVyZD8LBDJp/J6+QWxfFA
         EEAqgOVm7jfqtvD5PS8JkwyHDco7E32xgfm85lhcGhUajCeP4FVyE64zuCKLKG7TytbE
         pYakrcdz72KFPOKsz1d3RJsonbFJVmLkvYDsdmqW4rNRDr20wfwybVVPUZsZUKe4TUfd
         gSEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=Ocy1f8e8l5tnDktp3A5HwcgpUMQpU1wPRyfhdTDw5M8=;
        b=08AJXVYaMCPYjnJL9Fx43nC+j/t5r53wr103EPqveVtxRr4povO7g8ArXJhsQ7saR6
         DAl+JCBM0HsrMmjm1dE4Nf+xA8nUQLI0YcVzMPIYZ5f4TrgLfmqd5Ko0G5L5SpHpEqJA
         hURlgec0+tuQVhRFgBZLwXiFsWRxP66UOBT7MrtRoSSvXFRRSn842sKWcQXq5ci6J6s9
         Sd3r2DkTLejPoIRwfhUFR8BkfndnHj2PpPwLXIn7GyK7GPmm5UAsVE/vW3SfZOlQII5O
         ZJFTud9Fo4WyZEougb7l3pmuIsSVYxt/xJ92xmMfvGtpB1beoUl5Wd5DtPAw7EA6uq3S
         iTAQ==
X-Gm-Message-State: AOAM5328iv96UQaGfsQfX58kgo+zDNtNg9HzwlhKWHpEZfrLCa9EQFZt
        qeYUQc/9Rcsh3S9SFbJspGpe94Y4gbbNng==
X-Google-Smtp-Source: ABdhPJxe8AfKsCPhuglY9hr0mXjNrX0aldbMm31sCb7LADfE3npZOHRYWdmErVF1V2X6jR/3AHWfOJIeO4t9vQ==
X-Received: from shakeelb.svl.corp.google.com ([2620:15c:2cd:202:276f:dcd0:a2cf:ec4c])
 (user=shakeelb job=sendgmr) by 2002:a17:902:ab82:b0:14a:188a:cd1f with SMTP
 id f2-20020a170902ab8200b0014a188acd1fmr17395057plr.44.1643087878415; Mon, 24
 Jan 2022 21:17:58 -0800 (PST)
Date:   Mon, 24 Jan 2022 21:17:36 -0800
Message-Id: <20220125051736.2981459-1-shakeelb@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.35.0.rc0.227.g00780c9af4-goog
Subject: [PATCH] mm: io_uring: allow oom-killer from io_uring_setup
From:   Shakeel Butt <shakeelb@google.com>
To:     Jens Axboe <axboe@kernel.dk>,
        Pavel Begunkov <asml.silence@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, io-uring@vger.kernel.org,
        Shakeel Butt <shakeelb@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On an overcommitted system which is running multiple workloads of
varying priorities, it is preferred to trigger an oom-killer to kill a
low priority workload than to let the high priority workload receiving
ENOMEMs. On our memory overcommitted systems, we are seeing a lot of
ENOMEMs instead of oom-kills because io_uring_setup callchain is using
__GFP_NORETRY gfp flag which avoids the oom-killer. Let's remove it and
allow the oom-killer to kill a lower priority job.

Signed-off-by: Shakeel Butt <shakeelb@google.com>
---
 fs/io_uring.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/fs/io_uring.c b/fs/io_uring.c
index e54c4127422e..d9eeb202363c 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -8928,10 +8928,9 @@ static void io_mem_free(void *ptr)
 
 static void *io_mem_alloc(size_t size)
 {
-	gfp_t gfp_flags = GFP_KERNEL | __GFP_ZERO | __GFP_NOWARN | __GFP_COMP |
-				__GFP_NORETRY | __GFP_ACCOUNT;
+	gfp_t gfp = GFP_KERNEL_ACCOUNT | __GFP_ZERO | __GFP_NOWARN | __GFP_COMP;
 
-	return (void *) __get_free_pages(gfp_flags, get_order(size));
+	return (void *) __get_free_pages(gfp, get_order(size));
 }
 
 static unsigned long rings_size(unsigned sq_entries, unsigned cq_entries,
-- 
2.35.0.rc0.227.g00780c9af4-goog

