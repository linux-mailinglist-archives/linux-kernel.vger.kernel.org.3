Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDAB44EAD43
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 14:40:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234213AbiC2Mm2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 08:42:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236376AbiC2MmP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 08:42:15 -0400
Received: from mail-ed1-x54a.google.com (mail-ed1-x54a.google.com [IPv6:2a00:1450:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E9662013F2
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 05:40:32 -0700 (PDT)
Received: by mail-ed1-x54a.google.com with SMTP id v15-20020a50f08f000000b0041902200ab4so10938751edl.22
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 05:40:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=3CQYkeXdj1XVJNClFGQhidAhDBObT15U+enV+/AhM6A=;
        b=Rs1GnbfzAh48GyKvXrTviY6xmcPrSlCBrhBam52FN5lKhGkSSoDXuC/+sTSLnCX5XO
         /i4ncOwVT391qnv8EZbsDSgMBgczL/nCzy9Jqzu/nf38q/o+9kZr7KSlVoUWiViJ9870
         M0b0YE9E38a6zKyq5m0p8rIATZFa84ILdXxkvPpuNk7AfC4/9N8vExikGAHybh4Pb0rX
         8KcC4OmYsI0xN2dW728NWEU8I1Adn92Xl7Ph9hUyWVnxsPmYOh4rsrvl7JDTJxDDCuk+
         Va2vfsVuAq80Q0B5XplgXmEPTnrJ0hx+BQmCkMVH18sZhimHpdOgC1BUg2+kBBmprNgo
         nutA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=3CQYkeXdj1XVJNClFGQhidAhDBObT15U+enV+/AhM6A=;
        b=PiHPj49wTnzCJT8B6hf91x4L1jrGSaNe10CZCuqcpVaY50BcsfYHTOfxP0FGI/5HRO
         e3q1dQhkdyDlEF9PxVU4RH/ncJ3ph4eO4V0edwqB389oyh4Z+QhaQi+iQGhA2/UM3juX
         i5lmFjfGRWuUpnoIJFxsORb4Ug5vGlUihpA0DiOnLnCsQ83+gowEGZahIF/Ph5Dch0uC
         D1q6F4to6twtdXK5CuhiqYVszkPG9ZRpQZdH+b4MspVjFQkZxXPWiOXgIOUWGnzMMFzq
         BKi3uk9oz4z94EdrKfvAKXzKrezblBCsc5XPf1jQkzvVC5tqa8MC/MXfWKJ2xj+Qey1Z
         MlXw==
X-Gm-Message-State: AOAM531VIoSxIpxC98jDFJjPz+JRiymlQrDeCULFRKzfjaradk5eB3ER
        X18s3TIGs/W2K6W4tS9yblZ2Z6m1RGM=
X-Google-Smtp-Source: ABdhPJwxfLc7E5CGNpFchMAnZqVrfibLaBjl6ZrGzY59hWiYTgmr/LPloRQjIFWbW4/icF3FYORBAEJgcTc=
X-Received: from glider.muc.corp.google.com ([2a00:79e0:15:13:36eb:759:798f:98c3])
 (user=glider job=sendgmr) by 2002:a17:906:9c82:b0:6df:c5f0:d456 with SMTP id
 fj2-20020a1709069c8200b006dfc5f0d456mr34088614ejc.287.1648557630566; Tue, 29
 Mar 2022 05:40:30 -0700 (PDT)
Date:   Tue, 29 Mar 2022 14:39:30 +0200
In-Reply-To: <20220329124017.737571-1-glider@google.com>
Message-Id: <20220329124017.737571-2-glider@google.com>
Mime-Version: 1.0
References: <20220329124017.737571-1-glider@google.com>
X-Mailer: git-send-email 2.35.1.1021.g381101b075-goog
Subject: [PATCH v2 01/48] x86: add missing include to sparsemem.h
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
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
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
2.35.1.1021.g381101b075-goog

