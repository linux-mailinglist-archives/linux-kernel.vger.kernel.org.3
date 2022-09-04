Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A6A75AC7BC
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Sep 2022 23:49:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236080AbiIDVqt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Sep 2022 17:46:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236058AbiIDVpW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Sep 2022 17:45:22 -0400
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C06630F4C
        for <linux-kernel@vger.kernel.org>; Sun,  4 Sep 2022 14:43:03 -0700 (PDT)
Received: by mail-il1-x130.google.com with SMTP id d16so3873630ils.8
        for <linux-kernel@vger.kernel.org>; Sun, 04 Sep 2022 14:43:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=QW8Yf/f/bBn0zBgArR4hEtkqhYHoLP9Dq69jouppMcg=;
        b=CI4O5/XsaFLXciSt5Rdge4MemsUClxFVBZfystEbNfehM5+pbWGL+3/LfbSrWpLkDe
         QLouWGHfFHkP9Q9uTLPz7X3ERsbJXjw8LNi6aoavpvlpTPh0dTvh+IgfdUCbYJdj0GgH
         lUfG76Rd0gmLjbbl/3rZMOmYqTD+WkTN/9K2f2dm2qZHEDNaVZgbBO5+nFxuSbB/CFz4
         0MWqrUks5jKXTp61hPvRrQtbY7qo2RxRkVavCrphAIUunhh48rh0GzTzPFGrJ6BKZ0CD
         yShrbz0hun/rGp39oZ6PrAdWgNTyqGMKHUoak/rTVekwOK81+67c+ffYoQ1p3mVC8bzd
         oPTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=QW8Yf/f/bBn0zBgArR4hEtkqhYHoLP9Dq69jouppMcg=;
        b=UKEYYXR83PsD/sLaeIv86Nev4PbhIk/5RfQK266quicJ2zR6vrMV9JaxDU4lCFlzg/
         kFCwzs4kf9b4aEe1kX8ADZV1fxAIg7gtmQMk3vY9tqYPvq/KK1riYzo3BmRmNrN5kOUv
         f32CeNVUsWnDNwXdfHddOQ33USs+qiwamefgHpxwvm7XH2Aj2zZl5+jwtuVr36yZ8s0I
         nbrzKB3bYhqb+miQ4HC9LM5S063p9YfAsT/N/mJ+2aZoBewtcLEDB9J6WRRcjTRaiIdM
         jrPBfFcGHsODmiYkiFxQsvED255ZaOqIr3jXeG/+uHak9RT2f9W2FSVd1OxNzNtwoQOW
         ZlrA==
X-Gm-Message-State: ACgBeo0APjm57J1bvPDaCWn4gkM7KubZO3q8CPGVMayYjyFLH+5lOFoG
        JgtuHge/M+GhhKSFdxU1x5s=
X-Google-Smtp-Source: AA6agR7eGPKnIe81RJVDfoPI3jJBBD+OXvseERYIHoYQlkUb2mdyRY/RHX6luTHiUDhiH85tZBOfIg==
X-Received: by 2002:a05:6e02:180c:b0:2f1:5405:4bba with SMTP id a12-20020a056e02180c00b002f154054bbamr1923294ilv.152.1662327782986;
        Sun, 04 Sep 2022 14:43:02 -0700 (PDT)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id e12-20020a056602044c00b006889ea7be7bsm3727688iov.29.2022.09.04.14.43.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Sep 2022 14:43:02 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     jbaron@akamai.com, gregkh@linuxfoundation.org,
        dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        intel-gvt-dev@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc:     daniel.vetter@ffwll.ch, seanpaul@chromium.org, robdclark@gmail.com,
        linux@rasmusvillemoes.dk, joe@perches.com,
        Jim Cromie <jim.cromie@gmail.com>, david@redhat.com
Subject: [PATCH v6 55/57] dyndbg: dynamic_debug_sites_reclaim() using free_reserved_page() WAG
Date:   Sun,  4 Sep 2022 15:41:32 -0600
Message-Id: <20220904214134.408619-56-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220904214134.408619-1-jim.cromie@gmail.com>
References: <20220904214134.408619-1-jim.cromie@gmail.com>
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

STATUS:

broken with some over-free, punt and comment out late_initcall

Implement dymamic_debug_sites_reclaim(as a late_initcall) to free the
tail~47% of the builtin __dyndbg_sites[] vector back to the buddy
allocator.  Code is copied from mm/init.c:free_initmem(), wo the
poisoning.  Comments cargo culted wo grokking.

v3pr_info:

 dyndbg: freeing range: ffffea00000c5500-ffffea00000c5700, ffffffff83154668-ffffffff8315c480
 dyndbg:      ie range: ffffea00000c5500-ffffea00000c5700, ffffffff83154000-ffffffff8315c000
 dyndbg: freeing page: ffffea00000c5540, ffffffff83155000
 dyndbg: freeing page: ffffea00000c5580, ffffffff83156000
 dyndbg: freeing page: ffffea00000c55c0, ffffffff83157000
 dyndbg: freeing page: ffffea00000c5600, ffffffff83158000
 dyndbg: freeing page: ffffea00000c5640, ffffffff83159000
 dyndbg: freeing page: ffffea00000c5680, ffffffff8315a000
 dyndbg: freeing page: ffffea00000c56c0, ffffffff8315b000

Presuming those are 4k pages, 28kb is reclaimed, which is reasonably
consistent with the numbers below; 1532/2761 compresson of 64KiB.

I have fixed one edge-case over-free, which gave me a coredump on
```cat control```, there may be (one) other.

 dyndbg: 2762 prdebugs in 235 modules, 11 KiB in ddebug tables, 86 KiB \
 in __dyndbg section, 64 KiB in __dyndbg_sites section

CC: david@redhat.com	# free_reserved_page() tip
Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 lib/dynamic_debug.c | 45 ++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 42 insertions(+), 3 deletions(-)

diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index 0a68fbfd8432..194367bc13fb 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -1542,6 +1542,7 @@ static int __init dynamic_debug_init_control(void)
 fs_initcall(dynamic_debug_init_control);
 
 static struct _ddebug_info builtin_state;
+static __initdata struct _ddebug_site *last_site;
 
 static int __init dynamic_debug_init(void)
 {
@@ -1622,11 +1623,12 @@ static int __init dynamic_debug_init(void)
 	if (ret)
 		goto out_err;
 
+	last_site = &__start___dyndbg_sites[site_base];
 	ddebug_init_success = 1;
 
-	vpr_info("%d prdebugs in %d modules, %d KiB in ddebug tables, %d kiB in __dyndbg section\n",
-		 i, mod_ct, (int)((mod_ct * sizeof(struct ddebug_table)) >> 10),
-		 (int)((i * sizeof(struct _ddebug)) >> 10));
+	vpr_info("%d prdebugs in %d functions, %d modules, %d KiB in ddebug tables, %d,%d kiB in __dyndbg,_sites sections\n",
+		 i, site_base, mod_ct, (int)((mod_ct * sizeof(struct ddebug_table)) >> 10),
+		 (int)((i * sizeof(struct _ddebug)) >> 10), (int)((site_base * sizeof(struct _ddebug_site)) >> 10));
 
 	if (di.num_classes)
 		v2pr_info("  %d builtin ddebug class-maps\n", di.num_classes);
@@ -1652,3 +1654,40 @@ static int __init dynamic_debug_init(void)
 /* Allow early initialization for boot messages via boot param */
 early_initcall(dynamic_debug_init);
 
+static int __init dynamic_debug_sites_reclaim(void)
+{
+	unsigned long addr, end, start;
+	/*
+	 * from mm/init.c:free_initmem (void) wo poisoning
+	 * The init section is aligned to 8k in vmlinux.lds.
+	 * Page align for >8k pagesizes.
+	 */
+	start = (unsigned long)__start___dyndbg_sites;
+	end = (unsigned long)__stop___dyndbg_sites;
+	addr = (unsigned long)last_site;
+
+	vpr_info("full    range: %px-%px, %lx-%lx\n",
+		 virt_to_page(start), virt_to_page(end), start, end);
+
+	vpr_info("freeing range: %px-%px, %lx-%lx\n",
+		 virt_to_page(addr), virt_to_page(end), addr, end);
+
+	addr &= PAGE_MASK;
+	addr += PAGE_SIZE;
+	end &= PAGE_MASK;
+	end += PAGE_SIZE;
+
+	vpr_info("ie      range: %px-%px, %lx-%lx\n",
+		 virt_to_page(addr), virt_to_page(end), addr, end);
+
+	if (verbose < 2) {
+		vpr_info(" skipping reclaim cuz its broken by `cat control`\n");
+		return 0;
+	}
+	for (; addr < end; addr += PAGE_SIZE) {
+		vpr_info("freeing page: %px, %lx\n", virt_to_page(addr), addr);
+		free_reserved_page(virt_to_page(addr));
+	}
+	return 0;
+}
+//late_initcall(dynamic_debug_sites_reclaim);
-- 
2.37.2

