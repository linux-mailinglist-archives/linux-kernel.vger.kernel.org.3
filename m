Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7699557BFD3
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 23:53:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230033AbiGTVx2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 17:53:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbiGTVx1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 17:53:27 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 64EF348C8D
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 14:53:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1658354004;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=i3Va9g3YkA6BXU/AcK1jCkeA4AOd/o3VNIc0Hlti7UU=;
        b=giJSHWA9Cb826tHQVAd7AC+Gi1N0VlO3nhoBOqH5KGSTvNiWuUp6F2kLFrbkqMcycJPb/M
        rh4kXBj2af7c+z4O1v7A5iIigMZO8WdjrMsBssFiJup1qbotaje2NHbkuvHHFkCHpa8c5+
        PPgqqktdKbunl85zF8yYKtdBI0T5buQ=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-110-KLb92zRNO6mJUKgOj59_NQ-1; Wed, 20 Jul 2022 17:53:22 -0400
X-MC-Unique: KLb92zRNO6mJUKgOj59_NQ-1
Received: by mail-qt1-f197.google.com with SMTP id i8-20020ac871c8000000b0031ed35facf3so58113qtp.0
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 14:53:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=i3Va9g3YkA6BXU/AcK1jCkeA4AOd/o3VNIc0Hlti7UU=;
        b=A1N7MIaja2ZKoqVtJccz8ZlNyM+N9s4lujbGWpno9G9xA2KROaWZhYtO2qoDDEwPlE
         1mQA8RtqnsLUXmZqYb6ICUqKqhBLitq4o8uphmNp+KhdMqKgEtsZ69ih1xIpGmKpsHHZ
         cRRVl43RyC3MTXBrKtAIz5uQho5CV3M0pJkePIiPw/9StYvIdWv15bwKcdRlenD+GOB9
         IgXQG71EV9my/HBQIdT+FYv3COJVEg1e/oB6iJRpGaBf1On0iJ+J1U0dGIhySPkTzBoF
         9Iqqb2rqCkgLRXPPdRwxmD94c19SHXUHMf49Qs0nDSJz3l502d1wRHe5I/JyrItUmnsl
         tcWQ==
X-Gm-Message-State: AJIora8bb7Zu3j0Srog7NoMYQzBoLJbOw6VEQmMnYpYDgrPDrx0e2y6o
        S7R7q5lURiVZSjtR7yGQB+v1rrviEt8krZv7gwMaMMci0d2xDrx0glio/cKK72UZyKL6AMkh+5q
        KwSMOIMNVvIARe2gv17I28mWz
X-Received: by 2002:a05:6214:5292:b0:473:3f82:f947 with SMTP id kj18-20020a056214529200b004733f82f947mr31973960qvb.72.1658354002190;
        Wed, 20 Jul 2022 14:53:22 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1v3iNU023iwalNqWReGAA6yDZlG8JijiYsICQZScSUsRWUvYcY4qSe5hJAq2luceAqy0IeOMA==
X-Received: by 2002:a05:6214:5292:b0:473:3f82:f947 with SMTP id kj18-20020a056214529200b004733f82f947mr31973941qvb.72.1658354001933;
        Wed, 20 Jul 2022 14:53:21 -0700 (PDT)
Received: from localhost.localdomain (bras-base-aurron9127w-grc-37-74-12-30-48.dsl.bell.ca. [74.12.30.48])
        by smtp.gmail.com with ESMTPSA id x27-20020a05620a0b5b00b006b5e43466ebsm199642qkg.59.2022.07.20.14.53.20
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 20 Jul 2022 14:53:21 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     peterx@redhat.com, David Hildenbrand <david@redhat.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH] mm/mprotect: Fix soft-dirty check in can_change_pte_writable()
Date:   Wed, 20 Jul 2022 17:53:19 -0400
Message-Id: <20220720215319.87839-1-peterx@redhat.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The check wanted to make sure when soft-dirty tracking is enabled we won't
grant write bit by accident, as a page fault is needed for dirty tracking.
The intention is correct but we didn't check it right because VM_SOFTDIRTY
set actually means soft-dirty tracking disabled.  Fix it.

It wasn't a bug for a long time because we used to only optimize the write
bit settings in change_pte_range() for page caches, and since we've got a
higher level check in vma_wants_writenotify(), we will never set the bit
MM_CP_TRY_CHANGE_WRITABLE for soft-dirty enabled page caches, hence even if
we checked with the wrong value of VM_SOFTDIRTY in change_pte_range() it'll
just be an no-op.  Functionally it was still correct, even if cpu cycles
wasted.

However after the recent work of anonymous page optimization on exclusive
pages we'll start to make it wrong because anonymous page does not require
the check in vma_wants_writenotify() hence it'll suffer from the wrong
check here in can_change_pte_writable().

We can easily verify this with any exclusive anonymous page, like program
below:

=======8<======

unsigned int psize;
char *page;

uint64_t pagemap_read_vaddr(int fd, void *vaddr)
{
    uint64_t value;
    int ret;

    ret = pread(fd, &value, sizeof(uint64_t),
                ((uint64_t)vaddr >> 12) * sizeof(uint64_t));
    assert(ret == sizeof(uint64_t));

    return value;
}

void clear_refs_write(void)
{
    int fd = open("/proc/self/clear_refs", O_RDWR);

    assert(fd >= 0);
    write(fd, "4", 2);
    close(fd);
}

        bool dirty = pagemap_read_vaddr(fd, page) & PM_SOFT_DIRTY;      \
        if (dirty != expect) {                                          \
            printf("ERROR: %s, soft-dirty=%d (expect: %d)\n", str, dirty, expect); \
            exit(-1);                                                   \
        }                                                               \
} while (0)

int main(void)
{
    int fd = open("/proc/self/pagemap", O_RDONLY);

    assert(fd >= 0);
    psize = getpagesize();
    page = mmap(NULL, psize, PROT_READ|PROT_WRITE,
                MAP_ANONYMOUS|MAP_PRIVATE, -1, 0);
    assert(page != MAP_FAILED);

    *page = 1;
    check_soft_dirty("Just faulted in page", 1);
    clear_refs_write();
    check_soft_dirty("Clear_refs written", 0);
    mprotect(page, psize, PROT_READ);
    check_soft_dirty("Marked RO", 0);
    mprotect(page, psize, PROT_READ|PROT_WRITE);
    check_soft_dirty("Marked RW", 0);
    *page = 2;
    check_soft_dirty("Wrote page again", 1);

    munmap(page, psize);
    close(fd);
    printf("Test passed.\n");

    return 0;
}
=======8<======

So even if commit 64fe24a3e05e kept the old behavior and didn't attempt to
change the behavior here, the bug will only be able to be triggered after
commit 64fe24a3e05e because only anonymous page will suffer from it.

Fixes: 64fe24a3e05e ("mm/mprotect: try avoiding write faults for exclusive anonymous pages when changing protection")
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 mm/mprotect.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/mm/mprotect.c b/mm/mprotect.c
index 0420c3ed936c..804807ab14e6 100644
--- a/mm/mprotect.c
+++ b/mm/mprotect.c
@@ -48,8 +48,11 @@ static inline bool can_change_pte_writable(struct vm_area_struct *vma,
 	if (pte_protnone(pte) || !pte_dirty(pte))
 		return false;
 
-	/* Do we need write faults for softdirty tracking? */
-	if ((vma->vm_flags & VM_SOFTDIRTY) && !pte_soft_dirty(pte))
+	/*
+	 * Do we need write faults for softdirty tracking?  Note,
+	 * soft-dirty is enabled when !VM_SOFTDIRTY.
+	 */
+	if (!(vma->vm_flags & VM_SOFTDIRTY) && !pte_soft_dirty(pte))
 		return false;
 
 	/* Do we need write faults for uffd-wp tracking? */
-- 
2.32.0

