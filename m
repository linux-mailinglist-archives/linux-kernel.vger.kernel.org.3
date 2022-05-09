Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B171252009B
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 17:03:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237863AbiEIPD7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 11:03:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237817AbiEIPD4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 11:03:56 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53D422C96D7
        for <linux-kernel@vger.kernel.org>; Mon,  9 May 2022 07:59:54 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id d17so14123095plg.0
        for <linux-kernel@vger.kernel.org>; Mon, 09 May 2022 07:59:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zVLvc36s8wFy0NwwyUQY9+GAzhoxm6ANmW5t5SeS4wc=;
        b=lL109MqdgpeKUJKTzJme+MShTxpF/zVho7YdlzRI0evfUnaB6lEse1tOtQTjS1Tc+1
         8eS+fvHwpyXPUjVXohx8hHOQC2QAW2O0j/43NLUBKH3TmXcD3m6rslYcOGX5yWphvM6K
         S8ISGa5UuXL/RJ8hQaLUwwYha/LshcaxHJLAzT61ae/p2/Hv1IRwJSBH0dE+i0dWrLxJ
         XFc6YuOjB/NQ2bLC6qbPIKyvBpjT7nib4SVITU3PIMD8rVdt7ECeMz1fgZa6QCH6WusN
         hQzb6Q9CXg61+1p4uYdq9FpZ/h633SZRU0GdGFsCgclNY6izDszV7FxnbiEXOiNzIM3V
         lsiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zVLvc36s8wFy0NwwyUQY9+GAzhoxm6ANmW5t5SeS4wc=;
        b=iSYmAyVjm85fX+wqzOZdWkpCg2dGlTqxil4W0CAFxAXWtZ8tRpmV/GF4r4pn9dukbM
         kh7p5Q9KoTuBzWZYiVvuGEGKq5xN2gP3GdjhcAp6zqMoff37uPztUmW112EdEC3B/tDk
         e96xPHH47HT4DPShKeK/rrgJLpdpoTNZ8F0hpWVib2aC3MZBP6JMv3igpLji/sfo7fho
         iSnTdBeKjSttH14z35vJzMDV9cD0IrLc7ax/oE7kiomPwSGt8WqjEmgpWwHDuZKUyrEq
         P9wRPMsMWF5HrMSampMYLtfWD/URxav5bUb28Udxo04UmPKkMH0jS8Nnse3nPPscfUrr
         8DbA==
X-Gm-Message-State: AOAM533PTtZA9MaXH1etAu3QYQ5DWI8n+9rGyn+a70rtV1p2IWTzw1++
        k3/YgiYMke5c2fsQS5U6sOw=
X-Google-Smtp-Source: ABdhPJyioPNRcbngaf3SWmm7/A2zW3bmZ3CORM2h7zud6vyHvSXxQeZNu8Qnc8O6rpE/HOYY9xelSA==
X-Received: by 2002:a17:902:8501:b0:15f:173:40e1 with SMTP id bj1-20020a170902850100b0015f017340e1mr9313015plb.74.1652108393048;
        Mon, 09 May 2022 07:59:53 -0700 (PDT)
Received: from edumazet1.svl.corp.google.com ([2620:15c:2c4:201:3495:a425:2eb9:fac3])
        by smtp.gmail.com with ESMTPSA id h189-20020a636cc6000000b003c18ab7389asm8068977pgc.36.2022.05.09.07.59.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 May 2022 07:59:52 -0700 (PDT)
From:   Eric Dumazet <eric.dumazet@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        Eric Dumazet <edumazet@google.com>,
        Eric Dumazet <eric.dumazet@gmail.com>,
        syzbot <syzkaller@googlegroups.com>,
        Waiman Long <longman@redhat.com>
Subject: [PATCH] mm/page_owner: use strscpy() instead of strlcpy()
Date:   Mon,  9 May 2022 07:59:49 -0700
Message-Id: <20220509145949.265184-1-eric.dumazet@gmail.com>
X-Mailer: git-send-email 2.36.0.512.ge40c2bad7a-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eric Dumazet <edumazet@google.com>

current->comm[] is not a string (no guarantee for
a zero byte in it).

strlcpy(s1, s2, l) is calling strlen(s2), potentially
causing out-of-bound access, as reported by syzbot:

detected buffer overflow in __fortify_strlen
------------[ cut here ]------------
kernel BUG at lib/string_helpers.c:980!
invalid opcode: 0000 [#1] PREEMPT SMP KASAN
CPU: 0 PID: 4087 Comm: dhcpcd-run-hooks Not tainted 5.18.0-rc3-syzkaller-01537-g20b87e7c29df #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:fortify_panic+0x18/0x1a lib/string_helpers.c:980
Code: 8c e8 c5 ba e1 fa e9 23 0f bf fa e8 0b 5d 8c f8 eb db 55 48 89 fd e8 e0 49 40 f8 48 89 ee 48 c7 c7 80 f5 26 8a e8 99 09 f1 ff <0f> 0b e8 ca 49 40 f8 48 8b 54 24 18 4c 89 f1 48 c7 c7 00 00 27 8a
RSP: 0018:ffffc900000074a8 EFLAGS: 00010286

RAX: 000000000000002c RBX: ffff88801226b728 RCX: 0000000000000000
RDX: ffff8880198e0000 RSI: ffffffff81600458 RDI: fffff52000000e87
RBP: ffffffff89da2aa0 R08: 000000000000002c R09: 0000000000000000
R10: ffffffff815fae2e R11: 0000000000000000 R12: ffff88801226b700
R13: ffff8880198e0830 R14: 0000000000000000 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff8880b9c00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f5876ad6ff8 CR3: 000000001a48c000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000600
Call Trace:
 <IRQ>
 __fortify_strlen include/linux/fortify-string.h:128 [inline]
 strlcpy include/linux/fortify-string.h:143 [inline]
 __set_page_owner_handle+0x2b1/0x3e0 mm/page_owner.c:171
 __set_page_owner+0x3e/0x50 mm/page_owner.c:190
 prep_new_page mm/page_alloc.c:2441 [inline]
 get_page_from_freelist+0xba2/0x3e00 mm/page_alloc.c:4182
 __alloc_pages+0x1b2/0x500 mm/page_alloc.c:5408
 alloc_pages+0x1aa/0x310 mm/mempolicy.c:2272
 alloc_slab_page mm/slub.c:1799 [inline]
 allocate_slab+0x26c/0x3c0 mm/slub.c:1944
 new_slab mm/slub.c:2004 [inline]
 ___slab_alloc+0x8df/0xf20 mm/slub.c:3005
 __slab_alloc.constprop.0+0x4d/0xa0 mm/slub.c:3092
 slab_alloc_node mm/slub.c:3183 [inline]
 slab_alloc mm/slub.c:3225 [inline]
 __kmem_cache_alloc_lru mm/slub.c:3232 [inline]
 kmem_cache_alloc+0x360/0x3b0 mm/slub.c:3242
 dst_alloc+0x146/0x1f0 net/core/dst.c:92

Fixes: 865ed6a32786 ("mm/page_owner: record task command name")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Reported-by: syzbot <syzkaller@googlegroups.com>
Cc: Waiman Long <longman@redhat.com>
---
 mm/page_owner.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/page_owner.c b/mm/page_owner.c
index fb3a05fdebdbf1c3646ba1584cbf06facf0e7a9a..19bc559e49040e60c03a5f4268c89618fa0f1b1c 100644
--- a/mm/page_owner.c
+++ b/mm/page_owner.c
@@ -168,7 +168,7 @@ static inline void __set_page_owner_handle(struct page_ext *page_ext,
 		page_owner->pid = current->pid;
 		page_owner->tgid = current->tgid;
 		page_owner->ts_nsec = local_clock();
-		strlcpy(page_owner->comm, current->comm,
+		strscpy(page_owner->comm, current->comm,
 			sizeof(page_owner->comm));
 		__set_bit(PAGE_EXT_OWNER, &page_ext->flags);
 		__set_bit(PAGE_EXT_OWNER_ALLOCATED, &page_ext->flags);
-- 
2.36.0.512.ge40c2bad7a-goog

