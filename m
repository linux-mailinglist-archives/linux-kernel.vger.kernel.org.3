Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1140B56146E
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 10:16:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232153AbiF3IKk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 04:10:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233711AbiF3IJk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 04:09:40 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1827B427EB
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 01:08:40 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-31797057755so148681787b3.16
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 01:08:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=GYiA9a77cHEq6HAaCDmf6SI0OmewmuXNtKGENJPyeDQ=;
        b=C1EfKr+StywKgVJq/OBLvMLrK8heQvFtjIGCGGyT7rZ69b5pEQPGxTEhFvO2BYcjEy
         g8ZS17+7JsRQ95zhsgiOMkfTwS3li5dwnG7XEpm57ZkE1rhwFbw0sQfTIqFSMUe2FWXd
         FDmNZSkIIaXOQDIpKCFOm8ja+Hhl0uhdA6myzfve5xULGXTW204yGkTZydfQL5EDnouO
         5mNv99T+S/mp7gh/QW+Tf9ygT+H6W91jY9O0kOG9pLpcPMqSAa0h1mvt06NFXSrElzJ5
         iOkJIEe1i08IEujUg3ijvej4K+LucoNqEI8Lae5M+VGTkRfr/Zq7rVM6Iaek+b/85BH9
         eCYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=GYiA9a77cHEq6HAaCDmf6SI0OmewmuXNtKGENJPyeDQ=;
        b=NYGfqZM+qFSQFFRnlsaXxhLnK2O7ePeFDc9ORWMzl8cL5bS1n1EqhLZL/d2Hchiu36
         4pxlRBJ05itshIGUDRo673+oCLS7y6ef3wcBHBwBp6UO1AjxszrO/3Fa25nwApkNEkhS
         STUVq0ulIC5V0HC5JUzWgS7BkgtgCaRGnnn+gY1wu5lVi1vVy3DRQ6IOHHkthzabE5rM
         27HVj3l+3d7DuFg4gp511gib95O7bP+mcfvolKf3cq+UE+O8VYSFG7l9gvp4uCd7QqRW
         qc8jWnd0n+HqP3yZCAXyrXolj/8smHsaVDNGnWPsgd5DphzuJDkshHezGtivwWt/2Tr0
         lbEg==
X-Gm-Message-State: AJIora8AB+gt/LQQsw6Dp0LjPtgZq4gjJj7nR4eYK/W9sVduAYauzGjQ
        J7T2rEYyt2HP2ktmX4sVS8ebkK7wry4uRg==
X-Google-Smtp-Source: AGRyM1vm38iy2eLMKhhFXCCu+SfPwrcidn0k3qk7MdnQqnMvfwdUj/TRVk/LjaEK39jKP3KXpV4aVpj1UMke7g==
X-Received: from slicestar.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:20a1])
 (user=davidgow job=sendgmr) by 2002:a05:6902:1d0:b0:668:b5ea:10ec with SMTP
 id u16-20020a05690201d000b00668b5ea10ecmr8084737ybh.419.1656576519392; Thu,
 30 Jun 2022 01:08:39 -0700 (PDT)
Date:   Thu, 30 Jun 2022 16:08:33 +0800
Message-Id: <20220630080834.2742777-1-davidgow@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.37.0.rc0.161.g10f37bed90-goog
Subject: [PATCH v4 1/2] mm: Add PAGE_ALIGN_DOWN macro
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

