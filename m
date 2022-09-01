Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 004B25A9E2D
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 19:38:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234840AbiIARgc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 13:36:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234612AbiIARfj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 13:35:39 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C311DA454
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 10:35:32 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id z4-20020a5b0a44000000b006a1c47c36beso1425580ybq.15
        for <linux-kernel@vger.kernel.org>; Thu, 01 Sep 2022 10:35:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date;
        bh=SmLlv5S95s1SYD/hq46yY1KSJ7CCwWbvNekA+AzNinI=;
        b=IEnDpG3YZTPCaLyxObjk7amCPTURBOnqU7bJ+HMdi+ub5B49wgcvI5S5rtmD90rv2Q
         AZvqZR25+q4mnRP5jUchvAffVc/FzpkmhNDkv4FRnlMM4OlY6itcjxw3UZXpfpnem++C
         EJWIMKaiqyYuCH4R4X9b15IgDB9xODniSPpGeOsiXfRmLSll0Bi1jUHU15lpXlXRSc5J
         +CLYoEdfwTQrLCZejly8sqYsr7A+RsOmJlAwK6fhbCZlwscLc4WTaIF87eXTXBY8BoJB
         i633PKqUr/jul5ZT9UiyTCl07dJq2r9+I6Xxo/FEUAli95MNIWyATvVTZ7NKsjxM0gu/
         3dZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date;
        bh=SmLlv5S95s1SYD/hq46yY1KSJ7CCwWbvNekA+AzNinI=;
        b=gm/6qTdx5dqSLTMaP1HG5ZNCFGcR9htvHvlppBPPUwibyopyp6FSuEqYZ1C0+ELfGg
         kMHxJwcgDVkGYxuSRcOqydm7Ci/OcoHIdqSSxbsWWO6V8SZPLtJEcUnBkocUDbIQRZv6
         6I+3dvIEEZbhAn5S3yKWAyaDbNZ+Rmxlml8HdsUbCJdIY8RR1Zzu6xeh0NEO2g+CWweM
         AP0gj7zDmwIMK0VPvyIzj2mEuYZpyZZGSgQyFGgxIhFvsinK66QbSzPdlFsiq2zn7GM8
         6eWqgZMa4KXhqkDhsu+6GTcdokDdEyvVPiVFvD9W3Tt26/ol+trx13iYzsrfMwNCpTGj
         xq0w==
X-Gm-Message-State: ACgBeo3IeJm2hr8Vd9Ajw4rNeook4bJm8lMxbLOM2WGDBR9RANfCZIRD
        UBfx9Bo5u3A7ferjl4P9O9SlYn3eeQo=
X-Google-Smtp-Source: AA6agR7LHtl/RnUFMM8Ba/UDLwcr+KKZqP3s3F3o0L7ZSX4nHIA8V0azyARB9tbw+yLexNRTedxLJOpzAXk=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:200:1bfc:e7ee:6530:4449])
 (user=surenb job=sendgmr) by 2002:a05:6902:1366:b0:691:4335:455b with SMTP id
 bt6-20020a056902136600b006914335455bmr19454643ybb.282.1662053731874; Thu, 01
 Sep 2022 10:35:31 -0700 (PDT)
Date:   Thu,  1 Sep 2022 10:34:52 -0700
In-Reply-To: <20220901173516.702122-1-surenb@google.com>
Mime-Version: 1.0
References: <20220901173516.702122-1-surenb@google.com>
X-Mailer: git-send-email 2.37.2.789.g6183377224-goog
Message-ID: <20220901173516.702122-5-surenb@google.com>
Subject: [RFC PATCH RESEND 04/28] mm: move mmap_lock assert function definitions
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

Move mmap_lock assert function definitions up so that they can be used
by other mmap_lock routines.

Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
 include/linux/mmap_lock.h | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/include/linux/mmap_lock.h b/include/linux/mmap_lock.h
index 96e113e23d04..e49ba91bb1f0 100644
--- a/include/linux/mmap_lock.h
+++ b/include/linux/mmap_lock.h
@@ -60,6 +60,18 @@ static inline void __mmap_lock_trace_released(struct mm_struct *mm, bool write)
 
 #endif /* CONFIG_TRACING */
 
+static inline void mmap_assert_locked(struct mm_struct *mm)
+{
+	lockdep_assert_held(&mm->mmap_lock);
+	VM_BUG_ON_MM(!rwsem_is_locked(&mm->mmap_lock), mm);
+}
+
+static inline void mmap_assert_write_locked(struct mm_struct *mm)
+{
+	lockdep_assert_held_write(&mm->mmap_lock);
+	VM_BUG_ON_MM(!rwsem_is_locked(&mm->mmap_lock), mm);
+}
+
 static inline void mmap_init_lock(struct mm_struct *mm)
 {
 	init_rwsem(&mm->mmap_lock);
@@ -150,18 +162,6 @@ static inline void mmap_read_unlock_non_owner(struct mm_struct *mm)
 	up_read_non_owner(&mm->mmap_lock);
 }
 
-static inline void mmap_assert_locked(struct mm_struct *mm)
-{
-	lockdep_assert_held(&mm->mmap_lock);
-	VM_BUG_ON_MM(!rwsem_is_locked(&mm->mmap_lock), mm);
-}
-
-static inline void mmap_assert_write_locked(struct mm_struct *mm)
-{
-	lockdep_assert_held_write(&mm->mmap_lock);
-	VM_BUG_ON_MM(!rwsem_is_locked(&mm->mmap_lock), mm);
-}
-
 static inline int mmap_lock_is_contended(struct mm_struct *mm)
 {
 	return rwsem_is_contended(&mm->mmap_lock);
-- 
2.37.2.789.g6183377224-goog

