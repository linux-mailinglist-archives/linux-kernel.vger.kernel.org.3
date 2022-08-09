Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C361358E24C
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 00:02:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229923AbiHIWCC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 18:02:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229848AbiHIWBR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 18:01:17 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E3653E2D
        for <linux-kernel@vger.kernel.org>; Tue,  9 Aug 2022 15:01:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1660082473;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QP8/u5AChrIXiwIzqFnG/IHURDZ5n0i12x48YvKEviU=;
        b=HOUX84jyi/ddHHVWOUINEqsZ4eFjZrwsUSYVk+mYSAAeR6WhsZeEzbfOe4YtnvvQZ3JaVU
        dKDCvHwYk5cFJp5PBBonwq0gsyrwdajL5eJEDj8kN7Ccn+s5twSxQGQqwbO2xekGulFAKf
        9Enq4uALLUOIm5kAA0iKiIfNV2CDt2w=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-215-bxTjDqLBN0mCheNzFtgSdg-1; Tue, 09 Aug 2022 18:01:11 -0400
X-MC-Unique: bxTjDqLBN0mCheNzFtgSdg-1
Received: by mail-qk1-f198.google.com with SMTP id bk21-20020a05620a1a1500b006b5c24695a4so11236634qkb.15
        for <linux-kernel@vger.kernel.org>; Tue, 09 Aug 2022 15:01:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=QP8/u5AChrIXiwIzqFnG/IHURDZ5n0i12x48YvKEviU=;
        b=ejk+r1B/hdRG8kNtZm2uYB/omquDrbhUwqHNFnkp3JI6EceyUToML57aw1m63HFNO4
         TiWNgFRujieiOErieoVqmRIVw2sLd5Q2q80rzjwjR0CEQXJMROp7UogFS9p/O124utpO
         3ut2aSUIK5AXQtJ/KmxH2S/svZj+pSvXuirvYwgbsoiCIpcJdV8txcB4Php9jd4KogsT
         7rt6lxogtTzCmjKFKEiGEKfx4I3aOXQl8gvGmtFp5dNx+uW5rGOWlBujUY8NP1b13AOw
         cl3yqPYuA47MaiK6iSDWnb9TSSTg9OrQkp+4zX1MNqyOOR54DBngySHtX0I61JO5JlhE
         HNCA==
X-Gm-Message-State: ACgBeo30GxyshY+sJw8ErRE3nYTvQMZzETy4yGCor4RE7nH8QdF7KB8/
        RQUeGjpC0oNaApqK4P4sAHIcbTCcRsjaRtNjd9gs0YHZVNo3rWF16xeuZ4Ez7LXE1jJU65r3ykI
        bHoSnn3PcuZFMHzjY3lwMXsnT
X-Received: by 2002:a05:622a:184:b0:31e:d9a2:1e7 with SMTP id s4-20020a05622a018400b0031ed9a201e7mr21769870qtw.600.1660082471359;
        Tue, 09 Aug 2022 15:01:11 -0700 (PDT)
X-Google-Smtp-Source: AA6agR6rCoAdukBJ919s0iooFl+Su6+6WLl8fX28qz4Ljb6jLzuDkULdmT6xOGx8775yUr2wJWOu3Q==
X-Received: by 2002:a05:622a:184:b0:31e:d9a2:1e7 with SMTP id s4-20020a05622a018400b0031ed9a201e7mr21769841qtw.600.1660082471059;
        Tue, 09 Aug 2022 15:01:11 -0700 (PDT)
Received: from localhost.localdomain (bras-base-aurron9127w-grc-35-70-27-3-10.dsl.bell.ca. [70.27.3.10])
        by smtp.gmail.com with ESMTPSA id b16-20020a05622a021000b0031eddc83560sm10563383qtx.90.2022.08.09.15.01.09
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 09 Aug 2022 15:01:10 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     peterx@redhat.com, Minchan Kim <minchan@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andi Kleen <andi.kleen@intel.com>,
        Huang Ying <ying.huang@intel.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>
Subject: [PATCH v3 6/7] mm/swap: Cache maximum swapfile size when init swap
Date:   Tue,  9 Aug 2022 18:00:59 -0400
Message-Id: <20220809220100.20033-7-peterx@redhat.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220809220100.20033-1-peterx@redhat.com>
References: <20220809220100.20033-1-peterx@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We used to have swapfile_maximum_size() fetching a maximum value of
swapfile size per-arch.

As the caller of max_swapfile_size() grows, this patch introduce a variable
"swapfile_maximum_size" and cache the value of old max_swapfile_size(), so
that we don't need to calculate the value every time.

Caching the value in swapfile_init() is safe because when reaching the
phase we should have initialized all the relevant information.  Here the
major arch to look after is x86, which defines the max size based on L1TF
mitigation.

Here both X86_BUG_L1TF or l1tf_mitigation should have been setup properly
when reaching swapfile_init(). As a reference, the code path looks like
this for x86:

- start_kernel
  - setup_arch
    - early_cpu_init
      - early_identify_cpu --> setup X86_BUG_L1TF
  - parse_early_param
    - l1tf_cmdline --> set l1tf_mitigation
  - check_bugs
    - l1tf_select_mitigation --> set l1tf_mitigation
  - arch_call_rest_init
    - rest_init
      - kernel_init
        - kernel_init_freeable
          - do_basic_setup
            - do_initcalls --> calls swapfile_init() (initcall level 4)

The swapfile size only depends on swp pte format on non-x86 archs, so
caching it is safe too.

Since at it, rename max_swapfile_size() to arch_max_swapfile_size() because
arch can define its own function, so it's more straightforward to have
"arch_" as its prefix.  At the meantime, keep the swapfile_maximum_size()
function to fetch the value from the cache initialized in swapfile_init().

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 arch/x86/mm/init.c |  2 +-
 mm/swapfile.c      | 10 +++++++++-
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/arch/x86/mm/init.c b/arch/x86/mm/init.c
index 82a042c03824..9121bc1b9453 100644
--- a/arch/x86/mm/init.c
+++ b/arch/x86/mm/init.c
@@ -1054,7 +1054,7 @@ void update_cache_mode_entry(unsigned entry, enum page_cache_mode cache)
 }
 
 #ifdef CONFIG_SWAP
-unsigned long max_swapfile_size(void)
+unsigned long arch_max_swapfile_size(void)
 {
 	unsigned long pages;
 
diff --git a/mm/swapfile.c b/mm/swapfile.c
index 1fdccd2f1422..794fa37bd0c3 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -63,6 +63,7 @@ EXPORT_SYMBOL_GPL(nr_swap_pages);
 /* protected with swap_lock. reading in vm_swap_full() doesn't need lock */
 long total_swap_pages;
 static int least_priority = -1;
+static unsigned long swapfile_maximum_size;
 
 static const char Bad_file[] = "Bad swap file entry ";
 static const char Unused_file[] = "Unused swap file entry ";
@@ -2816,11 +2817,16 @@ unsigned long generic_max_swapfile_size(void)
 }
 
 /* Can be overridden by an architecture for additional checks. */
-__weak unsigned long max_swapfile_size(void)
+__weak unsigned long arch_max_swapfile_size(void)
 {
 	return generic_max_swapfile_size();
 }
 
+unsigned long max_swapfile_size(void)
+{
+	return swapfile_maximum_size;
+}
+
 static unsigned long read_swap_header(struct swap_info_struct *p,
 					union swap_header *swap_header,
 					struct inode *inode)
@@ -3677,6 +3683,8 @@ static int __init swapfile_init(void)
 	for_each_node(nid)
 		plist_head_init(&swap_avail_heads[nid]);
 
+	swapfile_maximum_size = arch_max_swapfile_size();
+
 	return 0;
 }
 subsys_initcall(swapfile_init);
-- 
2.32.0

