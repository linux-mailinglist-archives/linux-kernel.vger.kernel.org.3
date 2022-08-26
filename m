Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 521335A2ACE
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 17:16:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344318AbiHZPOP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 11:14:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245408AbiHZPMg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 11:12:36 -0400
Received: from mail-ed1-x549.google.com (mail-ed1-x549.google.com [IPv6:2a00:1450:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EDE9DF080
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 08:09:36 -0700 (PDT)
Received: by mail-ed1-x549.google.com with SMTP id s3-20020a056402520300b00446f5068565so1236480edd.7
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 08:09:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc;
        bh=ThlNJAw9Kex8KZrskRhHj0vt2sXcunlblCUmHxCmdH0=;
        b=qQ2U4pH+aEHV3VhL/BG61D7fD+fTTCboEipAha6RdIlQZwkpHT+D6S+zluEN3z1B+q
         p6KSrVqARRa5621nYeg6EZduZRldgx+r7wiEO2xx4Q1xdyk3NHKRP+n4BtOU+EkTRiBv
         n9pYohc41L9MNpZ4FFw1iKeBekfif+vSNYJKYp9IPK+WdwoL5Xq+pRz96l2kWYetAuz9
         ItAJhGyVh4AlEUo/NPut7UEgT36U97b+onPRJ1+xwb33JHHm9d1XBCaLKaZdeHB78F1o
         GDrzwrmR2heq2RM/Ijy6NFuNEoHEGLQn9rAcq11k6RQRmGERKya5Rzxx6la0Wnscwu1/
         yKKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc;
        bh=ThlNJAw9Kex8KZrskRhHj0vt2sXcunlblCUmHxCmdH0=;
        b=z3FJPUTAR37Bl0Vi9mScDSh3tu2+iFxD0E5Tks0nAujW8XYuinksn7IjDFzJIdiC2Y
         ev62G2iWck8Eu/qXJHX6GsrY7YgnBNaJojPviJRobOlQHdoRbISMYCJbDRJElMO66vGW
         9VLvG6VX3AGk6fALtvWDtAu5r6YgnIApF3LMGkbuv3qFV+FPUWlXZ4W8HOZcucO9uh3w
         l/906bM/IDrtRifIYyESP+hd34+3/HsQ6ycdteQ7pH8DoU9/w+q3iZSLWNCryxvY+hgr
         b9EgcrvsT4aY6XklUY4fSxY0kp7POTbyCNlwpBDfts08vNEnVQLXMY2Iu4HH34kVSzAd
         ogRg==
X-Gm-Message-State: ACgBeo2ffdAwdw5vjUi5zeovcaA3fr8YpLSLgGPsdpl4gHuYR4UdU7XV
        VNf6/Ry9IU/ucGH0bQMvHS0ArNxSFs4=
X-Google-Smtp-Source: AA6agR7P1+orY1RNadpoV0ZNi4BGK9MvXVRSI3uWf43JN88nANc9J/bmowMSnW9dE0hDywQIYKYvs/S52Ck=
X-Received: from glider.muc.corp.google.com ([2a00:79e0:9c:201:5207:ac36:fdd3:502d])
 (user=glider job=sendgmr) by 2002:a17:906:9b16:b0:73d:af6f:746e with SMTP id
 eo22-20020a1709069b1600b0073daf6f746emr5932849ejc.32.1661526573448; Fri, 26
 Aug 2022 08:09:33 -0700 (PDT)
Date:   Fri, 26 Aug 2022 17:07:52 +0200
In-Reply-To: <20220826150807.723137-1-glider@google.com>
Mime-Version: 1.0
References: <20220826150807.723137-1-glider@google.com>
X-Mailer: git-send-email 2.37.2.672.g94769d06f0-goog
Message-ID: <20220826150807.723137-30-glider@google.com>
Subject: [PATCH v5 29/44] block: kmsan: skip bio block merging logic for KMSAN
From:   Alexander Potapenko <glider@google.com>
To:     glider@google.com
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Alexei Starovoitov <ast@kernel.org>,
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
        linux-kernel@vger.kernel.org, Eric Biggers <ebiggers@google.com>
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

v4:
 -- swap block: and kmsan: in the subject

v5:
 -- address Marco Elver's comments

Link: https://linux-review.googlesource.com/id/Ie29cc2464c70032347c32ab2a22e1e7a0b37b905
---
 block/bio.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/block/bio.c b/block/bio.c
index 3d3a2678fea25..106ef14f28c2a 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -869,6 +869,8 @@ static inline bool page_is_mergeable(const struct bio_vec *bv,
 	*same_page = ((vec_end_addr & PAGE_MASK) == page_addr);
 	if (*same_page)
 		return true;
+	else if (IS_ENABLED(CONFIG_KMSAN))
+		return false;
 	return (bv->bv_page + bv_end / PAGE_SIZE) == (page + off / PAGE_SIZE);
 }
 
-- 
2.37.2.672.g94769d06f0-goog

