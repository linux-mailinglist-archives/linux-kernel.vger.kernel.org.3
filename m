Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3BCB51048A
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 18:52:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353528AbiDZQxB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 12:53:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353284AbiDZQuS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 12:50:18 -0400
Received: from mail-ej1-x649.google.com (mail-ej1-x649.google.com [IPv6:2a00:1450:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 973AC4739C
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 09:45:39 -0700 (PDT)
Received: by mail-ej1-x649.google.com with SMTP id o8-20020a170906974800b006f3a8be7502so2044232ejy.8
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 09:45:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=bWOHkFAZUowQhXbgV/15IRTSfhe/pFIeo0hpg6VoqgU=;
        b=Y425LRYJ7pqp2qUV4Un5BKaPtlMc56oRipAYvk35bNiZHMqwQj5K1oHUY+3UtaBrm8
         6F8LD23RH7puAqmN6VxxN3dzRPCX2o3jtXwChLes9m38UGHVO/PjltBdViFuvOO0/pv+
         9a5CV3vayhrQVrbmrEv1bjS0Nmz7caoEnvxuLCxERX2znPJk4SiPOZ9Qb7HS9LCHG3Lh
         qNuuAbPiqTn/Kfp6058UKfvV0NLpFCO10Egzm+8gacy2cKWG5HhTdR3sVdEPim8XyvUO
         oM/6bhYxYTS9e2sL18gV9sczR7Og8Y4lewCULG7qERx2rzD5bbV+C50LUjYRSUrnHoTG
         GPqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=bWOHkFAZUowQhXbgV/15IRTSfhe/pFIeo0hpg6VoqgU=;
        b=ihYk+y9wfGQu2tclZzzhdM7bqKD6byTpsOSpPh5Jvy2gqqEi6rL4k0SwSmhtLWkjAy
         teMw/EImpxPF9RPrZma8JX1UNFwmOuKKCA0HyU4afVcUFWfnkT4SDhY1XRZ8gafZ7w62
         7knj+AstYV+LREyUIIUi668ryrE/BgHbx/mlq2QXtQa5Gzd3fwJtxuG3Y85noylLfa5v
         G4iUTiUDwqyiyDtf7xMCr8J40U3kL1orG7PnU6jX2yN5WIIouxsAsYO5UCAqdpZphIeS
         K28u5BiOl7rwdp/jvsXSJ8lymF/5vFvUTl8u7BiPCUOSVW7lFNuUPtutjENxeyzCt8cT
         53sg==
X-Gm-Message-State: AOAM533UDF3b83IjobGRfVMLWfLqCDyrh2UMHRyJd4S4hEPXZqlpfYKl
        q4SI2gvOScltDjjGtJnGKWBHn1kvkYY=
X-Google-Smtp-Source: ABdhPJy8hRX/dOnDKYiAzHg5kT/4VfAMjL04J1HrqWNmAu8buMPT+aF4N+PIwLqQH/MNoEjw6XwUMlGRDw4=
X-Received: from glider.muc.corp.google.com ([2a00:79e0:15:13:d580:abeb:bf6d:5726])
 (user=glider job=sendgmr) by 2002:aa7:c789:0:b0:413:605d:8d17 with SMTP id
 n9-20020aa7c789000000b00413605d8d17mr25370617eds.100.1650991538395; Tue, 26
 Apr 2022 09:45:38 -0700 (PDT)
Date:   Tue, 26 Apr 2022 18:42:59 +0200
In-Reply-To: <20220426164315.625149-1-glider@google.com>
Message-Id: <20220426164315.625149-31-glider@google.com>
Mime-Version: 1.0
References: <20220426164315.625149-1-glider@google.com>
X-Mailer: git-send-email 2.36.0.rc2.479.g8af0fa9b8e-goog
Subject: [PATCH v3 30/46] kmsan: disable strscpy() optimization under KMSAN
From:   Alexander Potapenko <glider@google.com>
To:     glider@google.com
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrey Konovalov <andreyknvl@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>,
        Christoph Hellwig <hch@lst.de>,
        Christoph Lameter <cl@linux.com>,
        David Rientjes <rientjes@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Eric Dumazet <edumazet@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Ilya Leoshkevich <iii@linux.ibm.com>,
        Ingo Molnar <mingo@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Kees Cook <keescook@chromium.org>,
        Marco Elver <elver@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthew Wilcox <willy@infradead.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Pekka Enberg <penberg@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Vegard Nossum <vegard.nossum@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, kasan-dev@googlegroups.com,
        linux-mm@kvack.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Disable the efficient 8-byte reading under KMSAN to avoid false positives.

Signed-off-by: Alexander Potapenko <glider@google.com>

---

Link: https://linux-review.googlesource.com/id/Iffd8336965e88fce915db2e6a9d6524422975f69
---
 lib/string.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/lib/string.c b/lib/string.c
index 485777c9da832..4ece4c7e7831b 100644
--- a/lib/string.c
+++ b/lib/string.c
@@ -197,6 +197,14 @@ ssize_t strscpy(char *dest, const char *src, size_t count)
 		max = 0;
 #endif
 
+	/*
+	 * read_word_at_a_time() below may read uninitialized bytes after the
+	 * trailing zero and use them in comparisons. Disable this optimization
+	 * under KMSAN to prevent false positive reports.
+	 */
+	if (IS_ENABLED(CONFIG_KMSAN))
+		max = 0;
+
 	while (max >= sizeof(unsigned long)) {
 		unsigned long c, data;
 
-- 
2.36.0.rc2.479.g8af0fa9b8e-goog

