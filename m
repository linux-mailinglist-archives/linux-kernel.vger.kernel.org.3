Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 763C15A9E32
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 19:38:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235090AbiIARhx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 13:37:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234775AbiIARgU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 13:36:20 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC2F394ED5
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 10:36:09 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-33dc390f26cso233048367b3.9
        for <linux-kernel@vger.kernel.org>; Thu, 01 Sep 2022 10:36:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date;
        bh=CCIJQkAZ/MO9EmT200FCEP3Pgl0ISbihE0u87lNvTtM=;
        b=TDQRkBpQdXfWEYFjLGi7wwliNZ+aP0KfPsImVIZlXY8UjoGX+0qAFXnFV7XGW8IS6l
         y3VXrf+I2v9M7dPJOYegMdSPcyR+aiyAikKkPyRgRG+NjsroPpw9/4EU6cvNjVuOFM2u
         OAT4KFsNKXknM9gpAanaNp2m/7ee5CO2zFw2akG6RhT79MTZBIfrWOjgSBLIXLwhTrek
         2rRbzNpBpA/qCfbKpI1w2r4GCLJvz7pk5sgu4I7rxGww2tvEjHalildILdcL14mqDmo6
         PZNZoe3Kcvw46z9n2HY12LGtvHVlCAmPyMAI6EOC1YQSkgyXm1pQjGEvvxRKe2fezN+L
         aw6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date;
        bh=CCIJQkAZ/MO9EmT200FCEP3Pgl0ISbihE0u87lNvTtM=;
        b=GmVTpz2vZl4YMJC+pHkOA36S0GwrGU0UnVwNzcHQgilLJjRm30ZHKaTlk2gWpnEuIu
         8FtfebCa4aa0PwV88M/h71zK3DhHHj6W6nrkmgDZyjZoybNf2F4kRRZMDsIxgF3prax9
         9NtPIoqT2TiBEaJfbAD0zQ0c/V1CY+QKexCmuBh7ZS0DE+I7LDxjGKvT9OhhTTtZbeOg
         CXbGtsSFo7THQ8tkKATgYzpAoXp1GAgkZc984kQs+EwwD5/Va3bNe1PqIVYYQv86ayf0
         7HXDVLY9aqx6ej259Gso1tEd6XVvBQetVLeI5WYHM1l42coElCnhHxSGn2+3KJEdBmkG
         YwMw==
X-Gm-Message-State: ACgBeo0XBrGADVL2d9bra9jZrW0MUF5GzHLLaUC47Yw1aIlEtnq3bQ1A
        dmNaNwzGNlFJlFX5ndaQxZgiiPi92tU=
X-Google-Smtp-Source: AA6agR4qr6moVIHZv2YyIMkU4NbM3gllPWtVCICGpkk6fJrsf7LoBe2Q5GLKhj1E2SNlSJehbfJ330C873A=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:200:1bfc:e7ee:6530:4449])
 (user=surenb job=sendgmr) by 2002:a81:94e:0:b0:33d:bfb0:ff55 with SMTP id
 75-20020a81094e000000b0033dbfb0ff55mr23236112ywj.322.1662053769056; Thu, 01
 Sep 2022 10:36:09 -0700 (PDT)
Date:   Thu,  1 Sep 2022 10:35:06 -0700
In-Reply-To: <20220901173516.702122-1-surenb@google.com>
Mime-Version: 1.0
References: <20220901173516.702122-1-surenb@google.com>
X-Mailer: git-send-email 2.37.2.789.g6183377224-goog
Message-ID: <20220901173516.702122-19-surenb@google.com>
Subject: [RFC PATCH RESEND 18/28] mm: add FAULT_FLAG_VMA_LOCK flag
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

Add a new flag to distinguish page faults handled under protection of
per-vma lock.

Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
 include/linux/mm.h       | 3 ++-
 include/linux/mm_types.h | 1 +
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 0d9c1563c354..7c3190eaabd7 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -466,7 +466,8 @@ static inline bool fault_flag_allow_retry_first(enum fault_flag flags)
 	{ FAULT_FLAG_USER,		"USER" }, \
 	{ FAULT_FLAG_REMOTE,		"REMOTE" }, \
 	{ FAULT_FLAG_INSTRUCTION,	"INSTRUCTION" }, \
-	{ FAULT_FLAG_INTERRUPTIBLE,	"INTERRUPTIBLE" }
+	{ FAULT_FLAG_INTERRUPTIBLE,	"INTERRUPTIBLE" }, \
+	{ FAULT_FLAG_VMA_LOCK,		"VMA_LOCK" }
 
 /*
  * vm_fault is filled by the pagefault handler and passed to the vma's
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 6a03f59c1e78..36562e702baf 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -886,6 +886,7 @@ enum fault_flag {
 	FAULT_FLAG_INTERRUPTIBLE =	1 << 9,
 	FAULT_FLAG_UNSHARE =		1 << 10,
 	FAULT_FLAG_ORIG_PTE_VALID =	1 << 11,
+	FAULT_FLAG_VMA_LOCK =		1 << 12,
 };
 
 typedef unsigned int __bitwise zap_flags_t;
-- 
2.37.2.789.g6183377224-goog

