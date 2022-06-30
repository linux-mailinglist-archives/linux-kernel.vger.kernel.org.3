Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3332561393
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 09:49:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233324AbiF3HsJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 03:48:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233020AbiF3HsI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 03:48:08 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EFB9E73
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 00:48:07 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 130-20020a251288000000b0066c81091670so14180766ybs.18
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 00:48:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=XzzQ2qeoRIHvL3OIKjNQCubCMmqjty1j1wRkBLGrTgU=;
        b=Cd/RaHs88ciLdA0+wMopNk5kjW44si1O/9QcrziajxdH20xK3UlUrP0+vLXx20MY1D
         RUAPNooz1wh14yhNsjZ2DPh04r1TSjAWbZGLdxIfADNCLsKIMVoe0rCwGDelPXBS/q07
         bfBF8ggVR84eJmwoJcidKJXXyP0skwxvM4oMo5jDBjsdLzw0hq+urk9Vt1El1I0pNXOY
         Ui9qvmcqqGBAUjeUZNZ2TMfeCjGGtWzShSjtdHoo+rJ8+Q89q47gWg1OYS6AOODEA8yv
         r7cKAeIge6MraBq4l/vTR1evClWD+lPEjdb8uPAySVuqmLU0+iIs7L3MgEN1SzQNTG1I
         CBDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=XzzQ2qeoRIHvL3OIKjNQCubCMmqjty1j1wRkBLGrTgU=;
        b=KQ7BeD4GuS1hJ2xX+KpQEk75aUg80tA6qogJrxTifguXzH28Ep4iuYK+1mXVpsGK2k
         7xkz3taG+UeUrQGF0YjFdPDBODSd8y3j9hSR2c8KV+fJu22HEkNvgrSWM1dOdR5UoLov
         LbOpunGoFvDaZ8HzUWgPUhknc9ilRyY1QINYnSiRzjqQqJg2FIuV90zyZTQAqVMVhzwk
         G/EwBs5drURJB97SxzpLJbt7MQHokzcoGUN7ROMokjn5z9ZP/bUk1T6nDN5BhUqenyk9
         rJaXrRW+K9I0dKL3+EZ2rNy3UVXsdjP31mXUvHbqum2CaJ3g7UlhgI3ceapig2kp/jVO
         8PkQ==
X-Gm-Message-State: AJIora8PKBXKMjd1HqtUIKvBCOWqQGObsT7T2EBOg9Fz6QxCMg512Oe7
        GGP7dWXEtuFAycEI3+k71hrbT0ADPhNslA==
X-Google-Smtp-Source: AGRyM1vSiWG5UsJn1FGs8y/l+5be4umvT4PkYpnDFc4Cbi+MLFCVLCTtuQ8PN01k8FUWH9WOK1+ovGD2Wp1BOA==
X-Received: from slicestar.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:20a1])
 (user=davidgow job=sendgmr) by 2002:a25:2f81:0:b0:66d:9a86:f6de with SMTP id
 v123-20020a252f81000000b0066d9a86f6demr3315237ybv.590.1656575286295; Thu, 30
 Jun 2022 00:48:06 -0700 (PDT)
Date:   Thu, 30 Jun 2022 15:47:56 +0800
Message-Id: <20220630074757.2739000-1-davidgow@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.37.0.rc0.161.g10f37bed90-goog
Subject: [PATCH v3 1/2] mm: Add PAGE_ALIGN_DOWN macro
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

