Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1BE6562FAC
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 11:17:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235659AbiGAJQ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 05:16:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232001AbiGAJQ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 05:16:27 -0400
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2633E4507B
        for <linux-kernel@vger.kernel.org>; Fri,  1 Jul 2022 02:16:27 -0700 (PDT)
Received: by mail-pj1-x104a.google.com with SMTP id cp20-20020a17090afb9400b001ec75748019so1101614pjb.6
        for <linux-kernel@vger.kernel.org>; Fri, 01 Jul 2022 02:16:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=Gzf9MNYfzuExJ4letAUuWlfZz/ymERxaYUyT/EuC1fc=;
        b=Ziw2qAXAlzhNlbhTjbP0JE77DsFllvjUC3AvzRFw4OJ8KKLOHiNYxCskVSDnjCrbmk
         dRi/Tm4oQcCNrIY5p5Ziht1qS27pnUQatjR262bXMIcKV9YxIj2b/0029BocKRRLJlYU
         HP6zwkl7J2Icx8KXYVj+zvrUrOD58dKKWVnJye31y9E4/J2F4wUXrxoAQ4WcoSR7evCz
         ZSbWZjPy6gy16w95t0NfHgdbfNUgudhTVrD7nIgjoc8Kl8jNzBjvQSMW/2/0mC5xaqQu
         Wao9C47Jn/85zScpvweq1xtOni7nOQTixCgarYqulfUgkf2NQQ33BTBk593QPAqQQhv9
         cLYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=Gzf9MNYfzuExJ4letAUuWlfZz/ymERxaYUyT/EuC1fc=;
        b=e60Dvfn0cGxnIznn3mgktdhTKmoQlQfRoEZECo+4PHFtjFttT8FUmskbu0r7vc5TPI
         CIiAPOTcnOIEKLua7I248WdicHaFtdxlGZzZtjiFzb9ntYCrBAqOsjN50LGh9PiS83PT
         dNsdMWdhp+3uBDvN9txE1Tbi/7hAMG4Y1fwNfgLQCCM61rqiOROsx0jco4HMatWE1IWq
         5UNqQzWIXiU34qzQ39+Z+cCOrGjxQ3GU0YSuJP4CHP6B5WTWUESV49pILSABKrFSzm+g
         VdalXqkLYJp3T/12mnO/q3pKTLWu+qnPzM5TiRF9H4EuAWYv4J5XScvQOIXy32b51OK1
         yf+g==
X-Gm-Message-State: AJIora+g802i7yX5r+hIXPlyzGXgrrwLd4lU0bCj9i6I7RYGuG+NTU0r
        M759iTZGaVM+dKXMag5WT44BQhCdOyJfNQ==
X-Google-Smtp-Source: AGRyM1tlgeuz2bKn2ETD5JL0peIvZI8MizDxt/mQxTKM/Btl6ArdfthuN5ner3m8FquTDc5cMpJaiqaGXiCE8g==
X-Received: from slicestar.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:20a1])
 (user=davidgow job=sendgmr) by 2002:a17:90b:4a42:b0:1ec:adee:e298 with SMTP
 id lb2-20020a17090b4a4200b001ecadeee298mr17874949pjb.161.1656666986727; Fri,
 01 Jul 2022 02:16:26 -0700 (PDT)
Date:   Fri,  1 Jul 2022 17:16:19 +0800
Message-Id: <20220701091621.3022368-1-davidgow@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.37.0.rc0.161.g10f37bed90-goog
Subject: [PATCH v5 1/2] mm: Add PAGE_ALIGN_DOWN macro
From:   David Gow <davidgow@google.com>
To:     Vincent Whitchurch <vincent.whitchurch@axis.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        Patricia Alfonso <trishalfonso@google.com>,
        Jeff Dike <jdike@addtoit.com>,
        Richard Weinberger <richard@nod.at>,
        anton.ivanov@cambridgegreys.com,
        Dmitry Vyukov <dvyukov@google.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>
Cc:     David Gow <davidgow@google.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        linux-um@lists.infradead.org, LKML <linux-kernel@vger.kernel.org>,
        Daniel Latypov <dlatypov@google.com>, linux-mm@kvack.org,
        kunit-dev@googlegroups.com
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

This is just the same as PAGE_ALIGN(), but rounds the address down, not
up.

Suggested-by: Dmitry Vyukov <dvyukov@google.com>
Signed-off-by: David Gow <davidgow@google.com>
Acked-by: Andrew Morton <akpm@linux-foundation.org>
---
Please take this patch as part of the UML tree, along with patch #2,
thanks!

No changes to this patch since v4:
https://lore.kernel.org/lkml/20220630080834.2742777-1-davidgow@google.com/

No changes to this patch since v3 (just a minor issue with patch #2):
https://lore.kernel.org/lkml/20220630074757.2739000-1-davidgow@google.com/

Changes since v2:
https://lore.kernel.org/lkml/20220527185600.1236769-1-davidgow@google.com/
- Add Andrew's Acked-by tag.

v2 was the first version of this patch (it having been introduced as
part of v2 of the UML/KASAN series).

There are almost certainly lots of places where this macro should be
used: just look for ALIGN_DOWN(..., PAGE_SIZE). I haven't gone through
to try to replace them all.

---
 include/linux/mm.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 9f44254af8ce..9abe5975ad11 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -221,6 +221,9 @@ int overcommit_policy_handler(struct ctl_table *, int, void *, size_t *,
 /* to align the pointer to the (next) page boundary */
 #define PAGE_ALIGN(addr) ALIGN(addr, PAGE_SIZE)
 
+/* to align the pointer to the (prev) page boundary */
+#define PAGE_ALIGN_DOWN(addr) ALIGN_DOWN(addr, PAGE_SIZE)
+
 /* test whether an address (unsigned long or pointer) is aligned to PAGE_SIZE */
 #define PAGE_ALIGNED(addr)	IS_ALIGNED((unsigned long)(addr), PAGE_SIZE)
 
-- 
2.37.0.rc0.161.g10f37bed90-goog

