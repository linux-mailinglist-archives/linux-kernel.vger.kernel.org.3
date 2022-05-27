Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78E2053673E
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 20:57:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354505AbiE0S4O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 May 2022 14:56:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351455AbiE0S4I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 May 2022 14:56:08 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E69774C796
        for <linux-kernel@vger.kernel.org>; Fri, 27 May 2022 11:56:07 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id y85-20020a253258000000b0064eaa00a2cbso4868594yby.2
        for <linux-kernel@vger.kernel.org>; Fri, 27 May 2022 11:56:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=342jTvfgyTJ/fKu8Bj0JFN4DakYoNTyydnegV/i2TgI=;
        b=PYF1hpmpeKbQiDJ/Giw7g7NYnRSZrSPt/VlmV/6M4r4b+0XL11D1xYacFWIZqvAtBQ
         vHSmkE0rFQ7KBxsBOjVKZCqLFqjc+J5rJPdw0Jbu4PbCZNQl5/3g5LZG3igketLFOd7D
         X2ZXrF/tVd9fODrr0L3cZhFZauOVLuGN0QGLV6d2ui+IHO/pBKWqNY8ZqDaU20S2hAIM
         R0dLzRzLLq0/dcasaM8x3vRAJuf1qpiGoVRP0HIyRNW5FyKkVCcelzEbvbHXIX66MRzw
         NynXbaVdI/lNEgbxseGDoKyrMn2BVsaQXBTlW9vyUJRDtF0+apPC4BMnyDzI49cJuvhH
         NJWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=342jTvfgyTJ/fKu8Bj0JFN4DakYoNTyydnegV/i2TgI=;
        b=H6+U51cJ6vFirBCoEY6PQpbXU8HsAGbL0uHSPokmyzpvF71sAG8CQvPitTLPb93kcT
         Gj7VETj3dkMAsCjS19UlI5BWdJHwAHtigj9KLzxrkv7mkbLD67Fop37xCg1/FFCAq4n2
         ydG1k9vByvwxq8LLoPHh/zcH077155UkXEVsRiHMINP1X3S5FFTc1amdIgo7x12LJxx6
         bCK9AI2veMSrpPPsuOEB/cmQ7NLTjV000O9JlOLwRjsYh4HlbsMIYBH7WZpOt3b6Cg59
         i9LTvT5s9TZ9aCzgukbPgOnS3/nb4IXDfJbNIWsrtzh/NjUXXQ7wkDqdjX9fYb/ehrlu
         cn3g==
X-Gm-Message-State: AOAM531XCIyyM8gQOBMLLsq6Xl7H0yt7t4zpHwNAxbrQcURgD1g+r1Nd
        uDuBeokiq+B+eTlC08rEDaXWjNKn4iR5ew==
X-Google-Smtp-Source: ABdhPJz/QBLvmoj2qBlJY5WE42RVyqoRYZSp2QGQ5nHYPaFHzDB2qiRgsV/jwMBxoLb0CkvVpPclZj6wMdcAxg==
X-Received: from spirogrip.svl.corp.google.com ([2620:15c:2cb:201:122e:1813:2b92:fe8e])
 (user=davidgow job=sendgmr) by 2002:a25:9742:0:b0:64e:2c40:b33e with SMTP id
 h2-20020a259742000000b0064e2c40b33emr41935567ybo.455.1653677767170; Fri, 27
 May 2022 11:56:07 -0700 (PDT)
Date:   Fri, 27 May 2022 11:55:59 -0700
Message-Id: <20220527185600.1236769-1-davidgow@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.36.1.124.g0e6072fb45-goog
Subject: [PATCH v2 1/2] mm: Add PAGE_ALIGN_DOWN macro
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
        Daniel Latypov <dlatypov@google.com>, linux-mm@kvack.org
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
---

Note: there is no v1 of this patch, it's just part of v2 of the
UML/KASAN series.

There are almost certainly lots of places where this macro should be
used: just look for ALIGN_DOWN(..., PAGE_SIZE). I haven't gone through
to try to replace them all.

---
 include/linux/mm.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index e34edb775334..e68731f0ef20 100644
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
2.36.1.124.g0e6072fb45-goog

