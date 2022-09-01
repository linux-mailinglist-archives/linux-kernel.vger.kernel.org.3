Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26B885A9E34
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 19:38:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234720AbiIARgr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 13:36:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234655AbiIARfm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 13:35:42 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 151C354CAF
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 10:35:41 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id d135-20020a25688d000000b0069578d248abso4979568ybc.21
        for <linux-kernel@vger.kernel.org>; Thu, 01 Sep 2022 10:35:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date;
        bh=byYdzgQ2nb1BwMzAK8Db5EPtebwswE17va5vsTNHDvI=;
        b=U5hxVmDFnvg3Zh8mYi2DwtWs5BxWMTUQESfFDYoN6r6izeiWA5yaRxl1nHFUTbwk//
         Dnd8HHqghiMd97Zw1zIzmeB4ars9SXmdp/qLpi9efptTbpKgnXouiU6jw117QN+WP9qs
         3UWSwrzjzVFJ688YmwTVx+XNrjpewHxiYcGpgCH/HREdk2crWCVRYVVfKgVwMdBm3Bmp
         0cmyfTq+1Is86HcJ8rQc8vT+aBrCdpHLLyCE4j/1ArHGf12SJ516YZIyRc8DbZTCjB20
         ojn6KPPAcVM9EzDOR735/i5/Hcf8Q/BBi2k53VcG0tY24s/K8Lqz5/8Ca9tGedcRR97p
         PE0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date;
        bh=byYdzgQ2nb1BwMzAK8Db5EPtebwswE17va5vsTNHDvI=;
        b=cvr257bKQy7NuaLaeJLjfe3FL7HPFemBWd8qqe0o9eYGrmCAvLFPqxqlG/MZ1GH8N3
         GEFztoHcYMFtAUpWb8RF3cSwuna3Hd9e3DBtHaIsuHYh2+DS3FhBuEvglDuX0siGAF0e
         hcbgNlSpWBDish6djvlrXm5abVuy6g6priPbshGizTnqOzBj/3XyGrUjHiKOqvxcTt63
         AOR6rs1ZLrf2WkPu0BPudU0+dIF6Z5XlTOtZULMQjz5WzxbF3nGRVGYWblhWbGhEmVxw
         TsORC8yAhe6QNc6P5ptegZS7h1P9Vqhet01ZKoYzbZC7P3TRnJQ3TV7S9m9vOZk1+5pg
         9rjw==
X-Gm-Message-State: ACgBeo3ouszl6hgCw1zQI67HQLHd+LXP3SurvOHpUNOZnxcNanjCqQoa
        3nWUT3iq9QaaLe5vfercltiznLGKX7w=
X-Google-Smtp-Source: AA6agR7fnwkRjroGVHJxi1RhhEsQJMH0R75zEmK00qUWtCXpP69RbgB6GRXVWsVMb26fPpccLe4aPhca22w=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:200:1bfc:e7ee:6530:4449])
 (user=surenb job=sendgmr) by 2002:a25:40c6:0:b0:67a:5c8a:21d2 with SMTP id
 n189-20020a2540c6000000b0067a5c8a21d2mr20567843yba.158.1662053739927; Thu, 01
 Sep 2022 10:35:39 -0700 (PDT)
Date:   Thu,  1 Sep 2022 10:34:55 -0700
In-Reply-To: <20220901173516.702122-1-surenb@google.com>
Mime-Version: 1.0
References: <20220901173516.702122-1-surenb@google.com>
X-Mailer: git-send-email 2.37.2.789.g6183377224-goog
Message-ID: <20220901173516.702122-8-surenb@google.com>
Subject: [RFC PATCH RESEND 07/28] kernel/fork: mark VMAs as locked before
 copying pages during fork
From:   Suren Baghdasaryan <surenb@google.com>
To:     akpm@linux-foundation.org
Cc:     michel@lespinasse.org, jglisse@google.com, mhocko@suse.com,
        vbabka@suse.cz, hannes@cmpxchg.org, mgorman@suse.de,
        dave@stgolabs.net, willy@infradead.org, liam.howlett@oracle.com,
        peterz@infradead.org, ldufour@linux.ibm.com,
        laurent.dufour@fr.ibm.com, paulmck@kernel.org, luto@kernel.org,
        songliubraving@fb.com, peterx@redhat.com, david@redhat.com,
        dhowells@redhat.com, hughd@google.com, bigeasy@linutronix.de,
        kent.overstreet@linux.dev, rientjes@google.com,
        axelrasmussen@google.com, joelaf@google.com, minchan@google.com,
        surenb@google.com, kernel-team@android.com, linux-mm@kvack.org,
        linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, x86@kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Protect VMAs from concurrent page fault handler while performing
copy_page_range for VMAs having VM_WIPEONFORK flag set.

Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
 kernel/fork.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/kernel/fork.c b/kernel/fork.c
index bfab31ecd11e..1872ad549fed 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -709,8 +709,10 @@ static __latent_entropy int dup_mmap(struct mm_struct *mm,
 		rb_parent = &tmp->vm_rb;
 
 		mm->map_count++;
-		if (!(tmp->vm_flags & VM_WIPEONFORK))
+		if (!(tmp->vm_flags & VM_WIPEONFORK)) {
+			vma_mark_locked(mpnt);
 			retval = copy_page_range(tmp, mpnt);
+		}
 
 		if (tmp->vm_ops && tmp->vm_ops->open)
 			tmp->vm_ops->open(tmp);
-- 
2.37.2.789.g6183377224-goog

