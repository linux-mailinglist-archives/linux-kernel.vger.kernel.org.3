Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84F704E2713
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 13:57:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347677AbiCUM6x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 08:58:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347660AbiCUM6q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 08:58:46 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88D2916BF96;
        Mon, 21 Mar 2022 05:57:21 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id kx5-20020a17090b228500b001c6ed9db871so3978445pjb.1;
        Mon, 21 Mar 2022 05:57:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=aGt0QOXNwCSbtFJRf/ayuNuD4ICQ9tLB6ZQAMSZA3fQ=;
        b=YOIqisPIdsOV4AXIAJlVXH7XAbldaJ4R2x9i2Or0eaf2szg9q8357OFBJJtaEd+hVI
         CejP+TuHCj+pB2qiM+u6XokNVAVvwj/aQJsEgY0C2JvhW+n3jpxhu6j5t7JF6QrUoyeE
         UPjykla2QOOjeDrX1G72k3NfzP5DUMENBpKD891lrsfg3H6mKeQvYKiCNLtLxmkLtfk/
         77LJJ/H+NnaZ0z/J2qj3MruVZ7PmWcObIFkSj+oSsJYzQvI6OfdcYjnQMN+8THfObjrv
         oA/yYttT+VirTpWtYXF3NqFKIW6k0sFjkHBJjVRSnsRUuddzfbTRYDJs5Ih+pVKry/tc
         C6+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=aGt0QOXNwCSbtFJRf/ayuNuD4ICQ9tLB6ZQAMSZA3fQ=;
        b=el5dUgReLvZTKaVKzqkQ86Mel3U67UO1wGQur2Rsw3GCed2GSudNBkXH9XPpj1gyTl
         qJ9WdrUQtoZVQz1Hvqi2yMgWS6YGgJ4jZQC9HfGwSq0ds+1TQ0zOoRfURa4iPhgDuDLw
         +p6hcNmThppxVo4uhCAcN8dwDP7C+JzqHnfvLziV5nApTv+OUaCV2QoPzT5RUgkcW25v
         QyHuR0fMHXsvF7IdsT3AZjQ183oGs5YxGzXox0MIxcwuvrU/YoTDBjbEojZJLJXBvWex
         zhriini2TbRQsxf8d377ByM0+d8YJbgaYVT1D8B+ctOlaGqHYFkNtq0U0EBE5RvyD/Tb
         9Spw==
X-Gm-Message-State: AOAM532+DTqAfk7v1mDyvY7LtAdYcS2yGuCHE28wi2i2IDFEjQLP5UxN
        yms9pj9N2gjyaHBxDetR9A8=
X-Google-Smtp-Source: ABdhPJw+3d6nplioPzwdiaIc4hNRzAJmYdwwJ7vOcAz+jBjj0cPJ/YYPN9PLsUi3PtFs+z77IIq2Kw==
X-Received: by 2002:a17:90a:d154:b0:1c6:64a5:a413 with SMTP id t20-20020a17090ad15400b001c664a5a413mr28068457pjw.6.1647867440860;
        Mon, 21 Mar 2022 05:57:20 -0700 (PDT)
Received: from carrot.localdomain (i114-180-38-233.s42.a014.ap.plala.or.jp. [114.180.38.233])
        by smtp.gmail.com with ESMTPSA id gb5-20020a17090b060500b001c6d46f7e75sm8009046pjb.30.2022.03.21.05.57.18
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 21 Mar 2022 05:57:19 -0700 (PDT)
From:   Ryusuke Konishi <konishi.ryusuke@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-nilfs <linux-nilfs@vger.kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        David Hildenbrand <david@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: [PATCH 3/3] nilfs2: get rid of nilfs_mapping_init()
Date:   Mon, 21 Mar 2022 21:57:07 +0900
Message-Id: <1647867427-30498-4-git-send-email-konishi.ryusuke@gmail.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1647867427-30498-1-git-send-email-konishi.ryusuke@gmail.com>
References: <1647867427-30498-1-git-send-email-konishi.ryusuke@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After applying the lockdep warning fixes, nilfs_mapping_init() is no
longer used, so delete it.

Signed-off-by: Ryusuke Konishi <konishi.ryusuke@gmail.com>
---
 fs/nilfs2/page.c | 9 ---------
 fs/nilfs2/page.h | 1 -
 2 files changed, 10 deletions(-)

diff --git a/fs/nilfs2/page.c b/fs/nilfs2/page.c
index 45e079295008..a8e88cc38e16 100644
--- a/fs/nilfs2/page.c
+++ b/fs/nilfs2/page.c
@@ -436,15 +436,6 @@ unsigned int nilfs_page_count_clean_buffers(struct page *page,
 	return nc;
 }
 
-void nilfs_mapping_init(struct address_space *mapping, struct inode *inode)
-{
-	mapping->host = inode;
-	mapping->flags = 0;
-	mapping_set_gfp_mask(mapping, GFP_NOFS);
-	mapping->private_data = NULL;
-	mapping->a_ops = &empty_aops;
-}
-
 /*
  * NILFS2 needs clear_page_dirty() in the following two cases:
  *
diff --git a/fs/nilfs2/page.h b/fs/nilfs2/page.h
index 569263b23c0c..21ddcdd4d63e 100644
--- a/fs/nilfs2/page.h
+++ b/fs/nilfs2/page.h
@@ -43,7 +43,6 @@ struct buffer_head *nilfs_grab_buffer(struct inode *, struct address_space *,
 void nilfs_copy_back_pages(struct address_space *, struct address_space *);
 void nilfs_clear_dirty_page(struct page *, bool);
 void nilfs_clear_dirty_pages(struct address_space *, bool);
-void nilfs_mapping_init(struct address_space *mapping, struct inode *inode);
 unsigned int nilfs_page_count_clean_buffers(struct page *, unsigned int,
 					    unsigned int);
 unsigned long nilfs_find_uncommitted_extent(struct inode *inode,
-- 
1.8.3.1

