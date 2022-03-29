Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 292204EAD8E
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 14:48:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235475AbiC2Mti (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 08:49:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236705AbiC2MrA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 08:47:00 -0400
Received: from mail-ej1-x649.google.com (mail-ej1-x649.google.com [IPv6:2a00:1450:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38D2425279E
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 05:42:04 -0700 (PDT)
Received: by mail-ej1-x649.google.com with SMTP id do20-20020a170906c11400b006e0de97a0e9so3084421ejc.19
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 05:42:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=/KmrLQz2B9LUGG5T0s5DB1smaxsYg6k7avQ3Zjj3eGk=;
        b=nf15GMhub2RWppTwCYZIrWIlhESGQRfc/W+NIYyqHWkrAY5ZTdWS9tNg5R+WFNEwDR
         ws+bWlr0jAPjLQgTU8HBYWK/xBDV/+Z4gS8/E0xP18HFUtngLfocVvFSvgaAAKlkp4H3
         kXATs/dpgLrmitCYFBWHPxmJvSrUCCPUNzG/KXTkCq2AyohIUvlifgXGdxppP4apBE5A
         LAliLdtfENt0IXvOlwHuX/jsHQwOwjSPAiUrAj6DAH7RdyI9h/hc7xkf9IhqtKQUhdA7
         KWoj2cicXsXsWzrnFpLIgQlZXdwXJns/c+61ORU+3rxi9tyOWn8w7u20i5xnvlynULyv
         A3iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=/KmrLQz2B9LUGG5T0s5DB1smaxsYg6k7avQ3Zjj3eGk=;
        b=Sf0mpoK8WTYNobzTrf8HVHdc+vAPHNiu44ZeGPLwSAqhXHT2EUACiOOu+cMKvR2JkW
         eNVDVCmtz0G/Wl3odsWdePyMEUJC7Mq3IQJJecQNCFdzqE+bU4Nst2VmgFVLCLcGcZBU
         N6c6qabwFfHdvkXcJTJWmfgIuhVRinG6p6Nf498iUdYwQDjp0TP+DVHdB47DkMIxuCeb
         an1vM/pypFtz/Bxw3kY50s9Mj5ERKEU06HesO1UZTonoxrNPQ0Nj4hmRTf6g8O3455WD
         o+es1wI6hF8vr58ntad6AOfv1sjJQ94ZWaV9zuDbBQRoAC/6RgxH+RripgH7xapvC5mJ
         OxeQ==
X-Gm-Message-State: AOAM533xiYHL4IQc7+5EBy2rK/cbwxwLxE2toRHnDtyKG/y3ll1OttQS
        1wDbB+yZYqnLwriVXoGrDIf8v0O/h1g=
X-Google-Smtp-Source: ABdhPJxVb0eTOD5/UioVaLlWvIUvUDI3ZO47Rl6mwf+HN91ZLWrwoGAWiWD7v0UD4gilbb/v2zNMV7AgqQo=
X-Received: from glider.muc.corp.google.com ([2a00:79e0:15:13:36eb:759:798f:98c3])
 (user=glider job=sendgmr) by 2002:a17:906:3583:b0:6d1:c07:fac0 with SMTP id
 o3-20020a170906358300b006d10c07fac0mr34312763ejb.749.1648557723241; Tue, 29
 Mar 2022 05:42:03 -0700 (PDT)
Date:   Tue, 29 Mar 2022 14:40:04 +0200
In-Reply-To: <20220329124017.737571-1-glider@google.com>
Message-Id: <20220329124017.737571-36-glider@google.com>
Mime-Version: 1.0
References: <20220329124017.737571-1-glider@google.com>
X-Mailer: git-send-email 2.35.1.1021.g381101b075-goog
Subject: [PATCH v2 35/48] kmsan: block: skip bio block merging logic for KMSAN
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
        Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        Eric Biggers <ebiggers@google.com>
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

KMSAN doesn't allow treating adjacent memory pages as such, if they were
allocated by different alloc_pages() calls.
The block layer however does so: adjacent pages end up being used
together. To prevent this, make page_is_mergeable() return false under
KMSAN.

Suggested-by: Eric Biggers <ebiggers@google.com>
Signed-off-by: Alexander Potapenko <glider@google.com>

---

Link: https://linux-review.googlesource.com/id/Ie29cc2464c70032347c32ab2a22e1e7a0b37b905
---
 block/bio.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/block/bio.c b/block/bio.c
index 4312a8085396b..3c8806bbe3a81 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -808,6 +808,8 @@ static inline bool page_is_mergeable(const struct bio_vec *bv,
 		return false;
 
 	*same_page = ((vec_end_addr & PAGE_MASK) == page_addr);
+	if (!*same_page && IS_ENABLED(CONFIG_KMSAN))
+		return false;
 	if (*same_page)
 		return true;
 	return (bv->bv_page + bv_end / PAGE_SIZE) == (page + off / PAGE_SIZE);
-- 
2.35.1.1021.g381101b075-goog

