Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24EDF5103E4
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 18:44:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353122AbiDZQrg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 12:47:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353096AbiDZQrc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 12:47:32 -0400
Received: from mail-ej1-x64a.google.com (mail-ej1-x64a.google.com [IPv6:2a00:1450:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B0E11815FB
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 09:44:24 -0700 (PDT)
Received: by mail-ej1-x64a.google.com with SMTP id ga41-20020a1709070c2900b006f3b543907eso1186732ejc.0
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 09:44:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=A3NTwB+RJ9VPcHTGR65MbBZ7w/cFn7M1ATQGzKSwE+o=;
        b=Ev6F5DoTQsSpCxCbmkM4Tk/VDlOb3s/m5trmUrtt8ohNngUKfb9OF00S9Mc2nr8vO/
         IQzu1xDBWcfWryuhjSAG5ZlBXRwwzNyAPtvuMgv9hqu42UyoqcQ5XEuNIQ0sSyZ+pKNG
         nprOiwF/8Y6uwcYL1a16ovvRkuJ0Its6Mt6zvkHc2in2l3Y1ZetLaSNnUX8xEJI6/5bz
         L2BalAbeuA6NEVFDlHzBHWrt3POZUDMrT8BCTJ4wmAs/5Yaek0/+fGGtYHWXx1vHXyga
         CXr7UuHGTuK2cG9qbHwIW0QwOAeaZ8omncUskx4plnax4j1B4kX2WY7MzorNhLUuUpPW
         zBig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=A3NTwB+RJ9VPcHTGR65MbBZ7w/cFn7M1ATQGzKSwE+o=;
        b=mkH2LkJYh+rWw2V2md+COuWYXlUw3czxV6tQYZbUVmTDG46AqZ/b+7fux6MybwzNTW
         iiIEs/n7XbL5MNZRRg84kIuYgLc6NkpQ6SHIuq6+HsPOGWDaRRN+kgr8eSpsAaZXRPXx
         WrZYyp35UgkRJBTEBtpeY9s/3fhciSk6Np10f/hs2g0f+Srecd4jN2gRlDyZDABp7Z9Q
         hnxdzBiRvhME9WCC82Z1cqUm4w5n/ttpi7wPnwyuqTDFxgG8lI7grPElfh8Bbajkoe+A
         PBDZZ3TPo1jDziV9KYVvBLtPR38su4aziLiuW9SHMEEmBU6dYelrU+p1TLm1yd7NgdTu
         1YvQ==
X-Gm-Message-State: AOAM533nIF5p2o5Ox7ZmujNagmI8AZFijUX7Z1/J6Z0PQXfcjk/FbhFy
        0OS8NtJx+Kl2w/nekJHOk09GXPxfOFo=
X-Google-Smtp-Source: ABdhPJy2UkBps++xwJwtis+DecVA+28tEyDZziiiovCJIOEA9Q4lRIjJpV+/umWCIrcsFJtphuW7vqpus3Q=
X-Received: from glider.muc.corp.google.com ([2a00:79e0:15:13:d580:abeb:bf6d:5726])
 (user=glider job=sendgmr) by 2002:a50:fe1a:0:b0:425:e276:5adf with SMTP id
 f26-20020a50fe1a000000b00425e2765adfmr13327701edt.284.1650991462573; Tue, 26
 Apr 2022 09:44:22 -0700 (PDT)
Date:   Tue, 26 Apr 2022 18:42:30 +0200
In-Reply-To: <20220426164315.625149-1-glider@google.com>
Message-Id: <20220426164315.625149-2-glider@google.com>
Mime-Version: 1.0
References: <20220426164315.625149-1-glider@google.com>
X-Mailer: git-send-email 2.36.0.rc2.479.g8af0fa9b8e-goog
Subject: [PATCH v3 01/46] x86: add missing include to sparsemem.h
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
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dmitry Vyukov <dvyukov@google.com>

sparsemem.h:34:32: error: unknown type name 'phys_addr_t'
extern int phys_to_target_node(phys_addr_t start);
                               ^
sparsemem.h:36:39: error: unknown type name 'u64'
extern int memory_add_physaddr_to_nid(u64 start);
                                      ^
Signed-off-by: Dmitry Vyukov <dvyukov@google.com>
Signed-off-by: Alexander Potapenko <glider@google.com>
---
Link: https://linux-review.googlesource.com/id/Ifae221ce85d870d8f8d17173bd44d5cf9be2950f
---
 arch/x86/include/asm/sparsemem.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/x86/include/asm/sparsemem.h b/arch/x86/include/asm/sparsemem.h
index 6a9ccc1b2be5d..64df897c0ee30 100644
--- a/arch/x86/include/asm/sparsemem.h
+++ b/arch/x86/include/asm/sparsemem.h
@@ -2,6 +2,8 @@
 #ifndef _ASM_X86_SPARSEMEM_H
 #define _ASM_X86_SPARSEMEM_H
 
+#include <linux/types.h>
+
 #ifdef CONFIG_SPARSEMEM
 /*
  * generic non-linear memory support:
-- 
2.36.0.rc2.479.g8af0fa9b8e-goog

