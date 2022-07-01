Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3653F563538
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 16:24:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232249AbiGAOYh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 10:24:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231146AbiGAOYJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 10:24:09 -0400
Received: from mail-ed1-x54a.google.com (mail-ed1-x54a.google.com [IPv6:2a00:1450:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9675C35841
        for <linux-kernel@vger.kernel.org>; Fri,  1 Jul 2022 07:23:39 -0700 (PDT)
Received: by mail-ed1-x54a.google.com with SMTP id q18-20020a056402519200b004358ce90d97so1869731edd.4
        for <linux-kernel@vger.kernel.org>; Fri, 01 Jul 2022 07:23:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=os0Zx5VZv6p+Rm8I/hkYFMfJuZRHr+O61ed8WspeRIk=;
        b=OV7vbBjecQ+2aw/zjF5UI7FBbnLXSdlTtfDvhPtucRYMTl+svaPlqkq36KZQsvGhP/
         ne8e4l8I3/0GRvxegtfKUO6cwS2qPksp9NrQQ5lnpQwHWvK+HWlKJBwNEAVhhJIwF7u5
         Ns847PNFYy8k60pdHRyM2PsMAizAqLlGYbkafF+wOEnPqhwIwE4aYtsL1hd1Jq6fCqFz
         ce+lc///QcEti81QlLr7Y54ODBIMH5AChXdc7cPCvHBnFhpkGjgRkrjcUhJb8u74OZGE
         PCvurUMEpDHYof925nelBMEr785dzxSUlTT5q2hRH/q3uOyGgTsSk9NCo4066mule3qb
         +5Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=os0Zx5VZv6p+Rm8I/hkYFMfJuZRHr+O61ed8WspeRIk=;
        b=muoByKWIpHhamH/CFXWWbIMG+TozInlMSQSTN+hl9i4QW60nliRIl+jIxL5J1BpEpT
         qaQZtRSYBuo5LZbXb6ik5ChSPP/VuPVbQIlq3LMitOJE2zIGrcQQ5rMmfOpQUNHmbEQE
         5MY1TjzsnKy6HUDn54UfQIEtNG69aZ3Xhp+QQVQ6pJvWD9Rd51W4T40VW3OV4U0DwqyK
         7oi2M5NJA/MeRDX3ViXV7sxjn1ggrNxXjz1kmV8wVGVRcUyIDlra+4v5r7DlUhR3HrNX
         xX81cfPYbOJzdRkgP9tJaXzxfaCJDBB6dQo8fqGJ4JG/uB/9PmLIhIPsNYvx7R9QPv5g
         Rl7A==
X-Gm-Message-State: AJIora/hFIxDzE/xioywpz2qQMaHGGxQTnMyK26pQ95ISKsHylrGNXkw
        E3Lzn2WJ3PLAObiAsvJhN15RGRYFmuo=
X-Google-Smtp-Source: AGRyM1sWpivMRCzyWBt2NMDYpIZXoVXItcZn0l1qEGR/DeU09TxwkO65LsmcVUOum8/EZGKYMgfViYv/FwA=
X-Received: from glider.muc.corp.google.com ([2a00:79e0:9c:201:a6f5:f713:759c:abb6])
 (user=glider job=sendgmr) by 2002:a05:6402:4244:b0:437:726c:e1a with SMTP id
 g4-20020a056402424400b00437726c0e1amr19866573edb.107.1656685417915; Fri, 01
 Jul 2022 07:23:37 -0700 (PDT)
Date:   Fri,  1 Jul 2022 16:22:33 +0200
In-Reply-To: <20220701142310.2188015-1-glider@google.com>
Message-Id: <20220701142310.2188015-9-glider@google.com>
Mime-Version: 1.0
References: <20220701142310.2188015-1-glider@google.com>
X-Mailer: git-send-email 2.37.0.rc0.161.g10f37bed90-goog
Subject: [PATCH v4 08/45] kmsan: mark noinstr as __no_sanitize_memory
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
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

noinstr functions should never be instrumented, so make KMSAN skip them
by applying the __no_sanitize_memory attribute.

Signed-off-by: Alexander Potapenko <glider@google.com>
---
v2:
 -- moved this patch earlier in the series per Mark Rutland's request

Link: https://linux-review.googlesource.com/id/I3c9abe860b97b49bc0c8026918b17a50448dec0d
---
 include/linux/compiler_types.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/linux/compiler_types.h b/include/linux/compiler_types.h
index d08dfcb0ac687..fb5777e5228e7 100644
--- a/include/linux/compiler_types.h
+++ b/include/linux/compiler_types.h
@@ -227,7 +227,8 @@ struct ftrace_likely_data {
 /* Section for code which can't be instrumented at all */
 #define noinstr								\
 	noinline notrace __attribute((__section__(".noinstr.text")))	\
-	__no_kcsan __no_sanitize_address __no_profile __no_sanitize_coverage
+	__no_kcsan __no_sanitize_address __no_profile __no_sanitize_coverage \
+	__no_sanitize_memory
 
 #endif /* __KERNEL__ */
 
-- 
2.37.0.rc0.161.g10f37bed90-goog

