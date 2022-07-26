Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62E80580B9E
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 08:27:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237947AbiGZG1t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 02:27:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237946AbiGZG1b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 02:27:31 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E9F027B0A
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 23:25:33 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id q22so7184747pgt.9
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 23:25:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AdOoxODJiumCfXGJPDqlgTRMx1Hwty97pt6JnuBcVOQ=;
        b=ie3eJ3v2MPmIgwvF18zCl0L7By+ZEHT6fvXB5MfvLLOglu2VNhWaFg0Aqpj4oWyFj/
         of1Gi+hZUS/Vcz+B0hP6r8GYy5SVUp4JrJ0MxBXtBzTArlpIZCa9xkZ5jxuW97oFB3fr
         +RtPx5Oj2VyJT2fkx+KuSfmvZb8vBN2+ONNsazQcrLHqXnptWUSZe/Lc9LVzoUOt9qes
         7wGiFnR0kuFDs5/fh25ZMN4wcE2DH3bwvifDn+sDUUnEvvpjFSk/MjVOaWHh0bdVtJny
         Z/czCq1xNx12UrAiJT1VP+uTjBZPt3D5o7F70keje9f+ldWFWS0qkXy1iw2IjqGBYANo
         KMYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AdOoxODJiumCfXGJPDqlgTRMx1Hwty97pt6JnuBcVOQ=;
        b=oBtSmuA8QLNHUNnwjcSBSCsTL9uiXtLINjHiZnkxLwDeZINHE+Yy6pv9B3Hr/ar5pg
         kJ9TlpsDDJlajYLWEXtVYokIdu+0GglTY8iionxKvwW556qLofXRWlBoqUEUrdM0HuJg
         xlV3GKAk1LAkiZtoH0r9aLkvyhLkl9MWEGQtoJaSQ7J7aa+ep6m2TRvDFSXtWFev201X
         jWLJo63doeKEiMxns7K8NQE4i4lFvY8SYFMk9ossdSIxkOUbdF7otkrRfxMcwRy8Rcvi
         8e/D0jjmZWC6jZVq0aoTgpZoxZsOxVIK+96P7AT0dp/v6ntvzU+s99DkobwiVHYC1ioy
         0IQQ==
X-Gm-Message-State: AJIora+7h6TnkgVx6gv/rbdh7iO6GR5ulFo07QquB3hoKpU+t9Zg3cFo
        A0tXp/2wY3QpLby7+T6oy0OLCA==
X-Google-Smtp-Source: AGRyM1sZOfFtsIQ40Oun6bhHyx/tTS7MSrkbkGcu1ueGFKWLbKHLeFdMMbXYXrv+4hW9JJWIBtlHWg==
X-Received: by 2002:a63:ce13:0:b0:40d:d291:7710 with SMTP id y19-20020a63ce13000000b0040dd2917710mr13573244pgf.269.1658816732987;
        Mon, 25 Jul 2022 23:25:32 -0700 (PDT)
Received: from C02DW0BEMD6R.bytedance.net ([139.177.225.241])
        by smtp.gmail.com with ESMTPSA id d11-20020a63d64b000000b00416212f8da7sm9423951pgj.44.2022.07.25.23.25.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jul 2022 23:25:32 -0700 (PDT)
From:   Qi Zheng <zhengqi.arch@bytedance.com>
To:     akpm@linux-foundation.org, david@redhat.com
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Qi Zheng <zhengqi.arch@bytedance.com>
Subject: [PATCH] mm: fix NULL pointer dereference in wp_page_reuse()
Date:   Tue, 26 Jul 2022 14:24:36 +0800
Message-Id: <20220726062436.90290-1-zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The vmf->page can be NULL when the wp_page_reuse() is invoked
by wp_pfn_shared(), it will cause the following panic:

[   12.981200] BUG: kernel NULL pointer dereference, address: 000000000000008
[   12.981954] #PF: supervisor read access in kernel mode
[   12.982615] #PF: error_code(0x0000) - not-present page
[   12.983146] PGD 0 P4D 0
[   12.983417] Oops: 0000 [#1] PREEMPT SMP PTI
[   12.983846] CPU: 18 PID: 923 Comm: Xorg Not tainted 5.19.0-rc8.bm.1-amd64 #263
[   12.984606] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.14.0-0-g14
[   12.985760] RIP: 0010:_compound_head+0x0/0x40
[...]
[   12.995932] Call Trace:
[   12.996199]  <TASK>
[   12.996424]  wp_page_reuse+0x1c/0xa0
[   12.996800]  do_wp_page+0x1a5/0x3f0
[   12.997169]  __handle_mm_fault+0x8cf/0xd20
[   12.997587]  ? _raw_spin_unlock_irqrestore+0x23/0x35
[   12.998105]  handle_mm_fault+0xd5/0x2a0
[   12.998499]  do_user_addr_fault+0x1d0/0x680
[   12.998930]  exc_page_fault+0x78/0x170
[   12.999321]  asm_exc_page_fault+0x22/0x30

To fix it, this patch performs a NULL pointer check before
dereferencing the vmf->page.

Fixes: 6c287605fd56 ("mm: remember exclusively mapped anonymous pages with PG_anon_exclusive")
Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
---
 mm/memory.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/memory.c b/mm/memory.c
index 4cf7d4b6c950..9174918ce3f7 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -3043,7 +3043,7 @@ static inline void wp_page_reuse(struct vm_fault *vmf)
 	pte_t entry;
 
 	VM_BUG_ON(!(vmf->flags & FAULT_FLAG_WRITE));
-	VM_BUG_ON(PageAnon(page) && !PageAnonExclusive(page));
+	VM_BUG_ON(page && PageAnon(page) && !PageAnonExclusive(page));
 
 	/*
 	 * Clear the pages cpupid information as the existing
-- 
2.20.1

