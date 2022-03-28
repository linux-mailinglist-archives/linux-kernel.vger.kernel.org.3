Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B2AA4EA2B9
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 00:16:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229789AbiC1WRE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 18:17:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229724AbiC1WQi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 18:16:38 -0400
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C4787C143
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 15:12:55 -0700 (PDT)
Received: by mail-oi1-x22d.google.com with SMTP id j83so17189592oih.6
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 15:12:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mime-version;
        bh=hYgV/cj7s/KJHrRdB4rcVThWkKuipKsBWWVTwy7GkeY=;
        b=ThkJbWLv9rIxaiiAXpFpGA+YNbqtfsNkqlw3AzbmFPP3LcN4iJXeUF9gPpwXpDO01P
         FVR0aoODFvCx6scl2+ryNEa8dSFVhyJttsE953LXv+e0Qj9KAmHc1nSGGOEGy6mOGO18
         lQ2xXlaJ8YZDQfaNnAUL7djpj3Yg6aBk8y0mQDaoWcJiPsXqtjnEPx3EIpC0VT+Qod1y
         C61Xf8MN6RuLa9xpy410KXx0z1ik+WoyOGzFyTt2A06XAjp8S+I+/0KyRcj/urg3nsc+
         PgWU31Bw4LtPiBL6RU44AiRmtVwF82RQHhT7ygzH+3PWe3c2YDFEc4/qjCsmH/v1uB3E
         RyKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version;
        bh=hYgV/cj7s/KJHrRdB4rcVThWkKuipKsBWWVTwy7GkeY=;
        b=BLoyeUVWQuEnEvB+4dA6YJI0pcnV/WQLbG1CkKM9uCLRG++UtQxCppVETfSlL3ox7L
         jnVdQi05QAcyMQHNMhw4/Oh3ZpRhFw7qh0WFBiXH5R3xxGWGRsFgpuNK8MD3NYVc1xHF
         EnGugN3im6L70WI9NVwJ9j99LqcB3OCifIE7aMcrmstsW7i/FUmIPk7oRV+ZqF0XGYHQ
         VKdVNd29BdFNG42gl3uOcHUBtF/qr2HrTIAeAabLXEnfE0R5iKJK096o5Xz3ytlBqhHH
         HjfKbs8nKFxmoveqjGG8vDg1s/rTjcqWScG1pggdDY0Wb9UHXuv574gKRNQliE3316+r
         DvYg==
X-Gm-Message-State: AOAM533LrOqrtBvnOtdCHXmvknNfPg7p9XVcZWaRNcNgElFjnOIT0hCf
        y3YlUqbWgItQHoPVMlj5WR4LhT3ZWAr3vA==
X-Google-Smtp-Source: ABdhPJzIBjwmQbEY1T2jGgJO1yNijei4zyMA//zsn44ah4IfxKMgs56Z1dXVOvquog8xahe2gztSsw==
X-Received: by 2002:a05:6870:1714:b0:dd:a30e:d23e with SMTP id h20-20020a056870171400b000dda30ed23emr577361oae.85.1648503853461;
        Mon, 28 Mar 2022 14:44:13 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id r7-20020a056830418700b005cda6037350sm7614141otu.79.2022.03.28.14.44.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Mar 2022 14:44:13 -0700 (PDT)
Date:   Mon, 28 Mar 2022 14:44:11 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.anvils
To:     Andrew Morton <akpm@linux-foundation.org>
cc:     Mike Galbraith <efault@gmx.de>, Vlastimil Babka <vbabka@suse.cz>,
        Hugh Dickins <hughd@google.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: [PATCH] mm/munlock: add lru_add_drain() to fix memcg_stat_test
Message-ID: <47f6d39c-a075-50cb-1cfb-26dd957a48af@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mike reports that LTP memcg_stat_test usually leads to...
memcg_stat_test 3 TINFO: Test unevictable with MAP_LOCKED
memcg_stat_test 3 TINFO: Running memcg_process --mmap-lock1 -s 135168
memcg_stat_test 3 TINFO: Warming up pid: 3460
memcg_stat_test 3 TINFO: Process is still here after warm up: 3460
memcg_stat_test 3 TFAIL: unevictable is 122880, 135168 expected
...but may lead to...
memcg_stat_test 4 TINFO: Test unevictable with mlock
memcg_stat_test 4 TINFO: Running memcg_process --mmap-lock2 -s 135168
memcg_stat_test 4 TINFO: Warming up pid: 4271
memcg_stat_test 4 TINFO: Process is still here after warm up: 4271
memcg_stat_test 4 TFAIL: unevictable is 122880, 135168 expected
...or both.  A wee bit flaky.

follow_page_pte() used to have an lru_add_drain() per each page mlocked,
and the test came to rely on accurate stats.  The pagevec to be drained
is different now, but still covered by lru_add_drain(); and, never mind
the test, I believe it's in everyone's interest that a bulk faulting
interface like populate_vma_page_range() or faultin_vma_page_range()
should drain its local pagevecs at the end, to save others sometimes
needing the much more expensive lru_add_drain_all().  This does not
absolutely guarantee exact stats - the mlocking task can be migrated
between CPUs as it proceeds - but it's good enough and the tests pass.

Reported-by: Mike Galbraith <efault@gmx.de>
Fixes: b67bf49ce7aa ("mm/munlock: delete FOLL_MLOCK and FOLL_POPULATE")
Signed-off-by: Hugh Dickins <hughd@google.com>
---
One can argue about the Fixes tag - I'd have chosen the pagevec commit,
but this is the one Mike identified, and the one which touches mm/gup.c,
so I'm happy to go with this - and doesn't matter so long as 5.18 gets it.

 mm/gup.c |   10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

--- 5.18-pre/mm/gup.c
+++ linux/mm/gup.c
@@ -1404,6 +1404,7 @@ long populate_vma_page_range(struct vm_a
 	struct mm_struct *mm = vma->vm_mm;
 	unsigned long nr_pages = (end - start) / PAGE_SIZE;
 	int gup_flags;
+	long ret;
 
 	VM_BUG_ON(!PAGE_ALIGNED(start));
 	VM_BUG_ON(!PAGE_ALIGNED(end));
@@ -1438,8 +1439,10 @@ long populate_vma_page_range(struct vm_a
 	 * We made sure addr is within a VMA, so the following will
 	 * not result in a stack expansion that recurses back here.
 	 */
-	return __get_user_pages(mm, start, nr_pages, gup_flags,
+	ret = __get_user_pages(mm, start, nr_pages, gup_flags,
 				NULL, NULL, locked);
+	lru_add_drain();
+	return ret;
 }
 
 /*
@@ -1471,6 +1474,7 @@ long faultin_vma_page_range(struct vm_ar
 	struct mm_struct *mm = vma->vm_mm;
 	unsigned long nr_pages = (end - start) / PAGE_SIZE;
 	int gup_flags;
+	long ret;
 
 	VM_BUG_ON(!PAGE_ALIGNED(start));
 	VM_BUG_ON(!PAGE_ALIGNED(end));
@@ -1498,8 +1502,10 @@ long faultin_vma_page_range(struct vm_ar
 	if (check_vma_flags(vma, gup_flags))
 		return -EINVAL;
 
-	return __get_user_pages(mm, start, nr_pages, gup_flags,
+	ret = __get_user_pages(mm, start, nr_pages, gup_flags,
 				NULL, NULL, locked);
+	lru_add_drain();
+	return ret;
 }
 
 /*
