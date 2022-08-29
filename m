Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF81E5A5627
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 23:27:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229967AbiH2V1g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 17:27:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229956AbiH2V0u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 17:26:50 -0400
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39CAE9E888
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 14:26:15 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id i25-20020a635859000000b0042bbb74be8bso2624710pgm.5
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 14:26:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc;
        bh=K93TFWAb7JwQdWCvuFbBF/NwLgqzppA/TxAstG/QPvU=;
        b=f8ZHy6CiTcDXROb3pFMLfetBSV+kFVTeZws7OjDiiohYptMrJjGynWZ4jN+J/j3SJj
         dCEDPAmPkmnX5B3X46hqeY2mb8ZvMpLB7j64gw3uDHSYMAUM2B6ucp8KKPug6MxLnEu7
         BmebG6DC6czjsVXnb7ENc9u7p9QGYJElvc7qRNsIMqXvgjewnR2ulhT9EyPiZ2zz1B9D
         56/cpf1MfCjBxFK5vFsjvAIH2zjjfVoYxcmJWgmvbc3eCKVdp1qhJM+tuigQjNUJJMgZ
         jrHBPRDF7lp+rxYzH8zskIPXprMRBcWxeh9qo4POOeyeUnThUPILDVIwum49CxVeKLEs
         T9zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc;
        bh=K93TFWAb7JwQdWCvuFbBF/NwLgqzppA/TxAstG/QPvU=;
        b=yguYos31KDmZgoOyO8nJfP16xaXx0z1lgP88ijLpXJHVPgTHRit6rUC0gMN0a1GM9/
         Pk63QZUh48bjR1BMHvO5DliukMhHp+CHpr9N2hlxv9RVqDoPeTUilVRcp70yG+26CBf9
         7i4atw6V8nGbhNOrcQwnFy02upV3gv/Gu/ArIdacVcp8pP09TKoedJuUew1au7AHY2ZA
         C6r/YHlM6Nh0IEMLRCROJZUM8D9+NdEYprL5f6WFoxyRvC2j0ATpZsVxOT7s3IMLmWcI
         56ixFtTHqhm0kX2MunIhKf2SbzqdxhIpkpyxBZpJlBRei7y6PQ190fhadaXwgxHleXhK
         Hhsg==
X-Gm-Message-State: ACgBeo0okVUtIzeeQKkMM2cxSjbQ+s3Y5jzsZV/Xc3cF4GZeYocaP+uv
        6QMc8/SvUZz737/Bq1M3OqQVhnwEdN4=
X-Google-Smtp-Source: AA6agR7nf9+ItGZZ0+7hqrcNY7xNhTop6ny3nOph/OxIOFh5WmAm4Kp1l2Jp+ca/L6EEvcmkimt0snMwAs0=
X-Received: from surenb-spec.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3e30])
 (user=surenb job=sendgmr) by 2002:a17:902:b094:b0:173:12d1:4ece with SMTP id
 p20-20020a170902b09400b0017312d14ecemr18383730plr.117.1661808370030; Mon, 29
 Aug 2022 14:26:10 -0700 (PDT)
Date:   Mon, 29 Aug 2022 21:25:22 +0000
In-Reply-To: <20220829212531.3184856-1-surenb@google.com>
Mime-Version: 1.0
References: <20220829212531.3184856-1-surenb@google.com>
X-Mailer: git-send-email 2.37.2.672.g94769d06f0-goog
Message-ID: <20220829212531.3184856-20-surenb@google.com>
Subject: [RFC PATCH 19/28] mm: disallow do_swap_page to handle page faults
 under VMA lock
From:   Suren Baghdasaryan <surenb@google.com>
To:     akpm@linux-foundation.org
Cc:     michel@lespinasse.org, jglisse@google.com, mhocko@suse.com,
        vbabka@suse.cz, hannes@cmpxchg.org, mgorman@techsingularity.net,
        dave@stgolabs.net, willy@infradead.org, liam.howlett@oracle.com,
        peterz@infradead.org, ldufour@linux.ibm.com,
        laurent.dufour@fr.ibm.com, paulmck@kernel.org, riel@surriel.com,
        luto@kernel.org, songliubraving@fb.com, peterx@redhat.com,
        david@redhat.com, dhowells@redhat.com, hughd@google.com,
        bigeasy@linutronix.de, kent.overstreet@linux.dev,
        rientjes@google.com, axelrasmussen@google.com, joelaf@google.com,
        minchan@google.com, surenb@google.com, kernel-team@android.com,
        linux-mm@kvack.org, linux-arm-kernel@lists.infradead.org,
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

Due to the possibility of do_swap_page dropping mmap_lock, abort fault
handling under VMA lock and retry holding mmap_lock. This can be handled
more gracefully in the future.

Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
 mm/memory.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/mm/memory.c b/mm/memory.c
index 9ac9944e8c62..29d2f49f922a 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -3738,6 +3738,11 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 	vm_fault_t ret = 0;
 	void *shadow = NULL;
 
+	if (vmf->flags & FAULT_FLAG_VMA_LOCK) {
+		ret = VM_FAULT_RETRY;
+		goto out;
+	}
+
 	if (!pte_unmap_same(vmf))
 		goto out;
 
-- 
2.37.2.672.g94769d06f0-goog

