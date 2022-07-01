Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 116E756351B
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 16:23:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232011AbiGAOXi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 10:23:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231765AbiGAOXV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 10:23:21 -0400
Received: from mail-lf1-x149.google.com (mail-lf1-x149.google.com [IPv6:2a00:1450:4864:20::149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93DA119C28
        for <linux-kernel@vger.kernel.org>; Fri,  1 Jul 2022 07:23:20 -0700 (PDT)
Received: by mail-lf1-x149.google.com with SMTP id h18-20020a056512055200b004810d1b257aso1181814lfl.13
        for <linux-kernel@vger.kernel.org>; Fri, 01 Jul 2022 07:23:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=/yIHROt1QYP0boO+vuzmQ126QU/rx8ZuEvPrfW89F9Y=;
        b=RMeY6Ur3ouU5biN/Uz6Pi1vECHINkdUQ1XcdDhpxam1K7Tmx2sZMlF9fAiiBGiDeb0
         U7Aa8QqJ+VzQP8OpEO/pKz35Tdfyk3WWhmM4pgL6mDH0PoavMplCXSLjU0240DaBpzjO
         QbDGael0DJV5cJgd2vGBzYz8gomx8CJ50pgg+tLhgpdbZUtX5ayyxuW6RmdLsX6TBH+C
         o0DtNWdueVL830o3hq+mgXMzlCK2+/F+OKqDr/zxODRC5vpVa5UwODat1/WfKYe86OhU
         lS0UhtJlWn+ziWveaLeyRQpu/EtFNlZ1zDnOV0otO8OsP7edPw4pO0p+qmnwXROxdlBV
         mvtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=/yIHROt1QYP0boO+vuzmQ126QU/rx8ZuEvPrfW89F9Y=;
        b=q+LVCIdf2ShAdLZWWndgZd/nceyur5L4dT4ayQx2RhnHEqr4AufSk2BzOH8SnKn7Q4
         L93TQIXdinyMvomhF5Hjx3U7faOiTLd4t8FIe0I6IbtS8u0b+ge9KTDwbLbsh2FEfmGX
         meWcWiwe7iYp696d8hU2NAMqZl8crX+lWTO9EDlU7fH0OpQmeOSVJRfiese89MpyHlT2
         i6/bxrDPzjaKP+rWr/CvEsmuMJVJnOeLIj4en+UVrV0WhJS5rsIu9GzpNxCi87DaVM7q
         ELw+Y1pbgFdF7fVRB4MIpMeOTpupzKN0P893vqz2O0cZuMNFburWJqGpE7lzup4BHxSU
         X7dQ==
X-Gm-Message-State: AJIora8n/MBVBN3FP3qwS4hEXV6MTuOVgevB4Q0xHG99Z+EF1YQROp3l
        fQN4p6IKx8GWo2I2TUWfc5zdAYg7uaU=
X-Google-Smtp-Source: AGRyM1uD+3Ia18lHCKIGMfEeSdvCpSjDt0Xq3SAkrsJ1OFDc0LZZ0ntvnmsmvOrkKwNT5g2Svgk1nfZ8tIw=
X-Received: from glider.muc.corp.google.com ([2a00:79e0:9c:201:a6f5:f713:759c:abb6])
 (user=glider job=sendgmr) by 2002:a05:6512:1588:b0:481:1a00:4f10 with SMTP id
 bp8-20020a056512158800b004811a004f10mr9629583lfb.435.1656685398820; Fri, 01
 Jul 2022 07:23:18 -0700 (PDT)
Date:   Fri,  1 Jul 2022 16:22:26 +0200
In-Reply-To: <20220701142310.2188015-1-glider@google.com>
Message-Id: <20220701142310.2188015-2-glider@google.com>
Mime-Version: 1.0
References: <20220701142310.2188015-1-glider@google.com>
X-Mailer: git-send-email 2.37.0.rc0.161.g10f37bed90-goog
Subject: [PATCH v4 01/45] x86: add missing include to sparsemem.h
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
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dmitry Vyukov <dvyukov@google.com>

Including sparsemem.h from other files (e.g. transitively via
asm/pgtable_64_types.h) results in compilation errors due to unknown
types:

sparsemem.h:34:32: error: unknown type name 'phys_addr_t'
extern int phys_to_target_node(phys_addr_t start);
                               ^
sparsemem.h:36:39: error: unknown type name 'u64'
extern int memory_add_physaddr_to_nid(u64 start);
                                      ^

Fix these errors by including linux/types.h from sparsemem.h
This is required for the upcoming KMSAN patches.

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
2.37.0.rc0.161.g10f37bed90-goog

