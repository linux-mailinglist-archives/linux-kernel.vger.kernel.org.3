Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 772694CCC92
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 05:31:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237070AbiCDEc0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 23:32:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236451AbiCDEcX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 23:32:23 -0500
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 205981795FE
        for <linux-kernel@vger.kernel.org>; Thu,  3 Mar 2022 20:31:35 -0800 (PST)
Received: by mail-qt1-x832.google.com with SMTP id 11so6485342qtt.9
        for <linux-kernel@vger.kernel.org>; Thu, 03 Mar 2022 20:31:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mime-version;
        bh=aTbJtV8j5fplGh+y9hP64K8aiDbN2PZ+yad5jwKxTY8=;
        b=LbTdUllock64OE1OwMtnYr4r0KmMGLlymE7Lee64D5z+FkbK7nQj7/BhYDZNVg1M5K
         tLUHU8xB1wXdV2Gu4Winb3UnlhKZko26C4nxL4Ck6dleHa7C8p4Em7VP9H4d4aQIKqsX
         Je1Sk/eAq1OEKZ188GPC3M44Z/ozBUAgx/kasoe1RRt9xehf4Sc2Ezk7dCTm7gwdmjt9
         5lVyHJtoBdxHdDfSeWcFuC0z4omqUaUV1saqJ9G4ptNeaHQzdqRIt88qcB9P8UkAwy7B
         SinFQ6F7fGs2YQfhs+tIjwY5eTGPH3ZPGWzb7QiavHaknUJqMf2dOB0lh+KS2Auu0CZQ
         AOsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version;
        bh=aTbJtV8j5fplGh+y9hP64K8aiDbN2PZ+yad5jwKxTY8=;
        b=IlCkO+80/vZs3hxP0+T12cr76CclgJV6DrDWNYX/EGAef9mlLU98JVDtrNyYj1vyad
         H3C4jb6UnFYymVocS+mhKw8mKj7PF24BQ0rCBd6Kf0R0GnTbMRCQWsW3AvSA/QIigDsh
         M2f1TnFWpPeBnJ8Bfx9qDx/FY47iD8yg8xGKiXSB7pSYcqg1caEjBZ5hBpi2Ze492gpz
         xdGlmKEDF+MoUi144Mh0dblNHJgsV9AA7dGAXlyBIsW2EFFxB54HAENgWvgdvIiyySF+
         +3OTOEqoXrqJBl6d6N/BaspjSE5+xSYOpBz5/Szsp3wvJINr3CTDAK8blpfh7/iazGtQ
         6N7w==
X-Gm-Message-State: AOAM532qKcHctkqTP7b/GkSIyxO3AxyTShl8uzt162FxRPWbrkVEUqFc
        JZJmVeRQLBGc9g8uqSMK3f2dBw==
X-Google-Smtp-Source: ABdhPJwifbzXSXQ/wLbXKhWHJKCumbHB5C1izqmvXzKPpCer3x9VCYc6tIjTcvMM6jMywJyktEHmrQ==
X-Received: by 2002:ac8:5b04:0:b0:2dd:2600:2f1 with SMTP id m4-20020ac85b04000000b002dd260002f1mr29366129qtw.364.1646368294018;
        Thu, 03 Mar 2022 20:31:34 -0800 (PST)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id d16-20020ac85ad0000000b002d71c463d9csm2694100qtd.24.2022.03.03.20.31.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Mar 2022 20:31:33 -0800 (PST)
Date:   Thu, 3 Mar 2022 20:31:31 -0800 (PST)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.anvils
To:     Andrew Morton <akpm@linux-foundation.org>
cc:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Sasha Levin <sashal@kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH mmotm] mm: unmap_mapping_range_tree() with i_mmap_rwsem
 shared
Message-ID: <e4a5e356-6c87-47b2-3ce8-c2a95ae84e20@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-18.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Revert 48ec833b7851 ("Revert "mm/memory.c: share the i_mmap_rwsem"")
to reinstate c8475d144abb ("mm/memory.c: share the i_mmap_rwsem"): the
unmap_mapping_range family of functions do the unmapping of user pages
(ultimately via zap_page_range_single) without modifying the interval
tree itself, and unmapping races are necessarily guarded by page table
lock, thus the i_mmap_rwsem should be shared in unmap_mapping_pages()
and unmap_mapping_folio().

Commit 48ec833b7851 was intended as a short-term measure, allowing the
other shared lock changes into 3.19 final, before investigating three
trinity crashes, one of which had been bisected to commit c8475d144ab:

[1] https://lkml.org/lkml/2014/11/14/342
https://lore.kernel.org/lkml/5466142C.60100@oracle.com/
[2] https://lkml.org/lkml/2014/12/22/213
https://lore.kernel.org/lkml/549832E2.8060609@oracle.com/
[3] https://lkml.org/lkml/2014/12/9/741
https://lore.kernel.org/lkml/5487ACC5.1010002@oracle.com/

Two of those were Bad page states: free_pages_prepare() found PG_mlocked
still set - almost certain to have been fixed by 4.4 commit b87537d9e2fe
("mm: rmap use pte lock not mmap_sem to set PageMlocked"). The NULL deref
on rwsem in [2]: unclear, only happened once, not bisected to c8475d144ab.

No change to the i_mmap_lock_write() around __unmap_hugepage_range_final()
in unmap_single_vma(): IIRC that's a special usage, helping to serialize
hugetlbfs page table sharing, not to be dabbled with lightly.  No change
to other uses of i_mmap_lock_write() by hugetlbfs.

I am not aware of any significant gains from the concurrency allowed by
this commit: it is submitted more to resolve an ancient misunderstanding.

Signed-off-by: Hugh Dickins <hughd@google.com>
---

 mm/memory.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

--- a/mm/memory.c
+++ b/mm/memory.c
@@ -3388,11 +3388,11 @@ void unmap_mapping_folio(struct folio *folio)
 	details.even_cows = false;
 	details.single_folio = folio;
 
-	i_mmap_lock_write(mapping);
+	i_mmap_lock_read(mapping);
 	if (unlikely(!RB_EMPTY_ROOT(&mapping->i_mmap.rb_root)))
 		unmap_mapping_range_tree(&mapping->i_mmap, first_index,
 					 last_index, &details);
-	i_mmap_unlock_write(mapping);
+	i_mmap_unlock_read(mapping);
 }
 
 /**
@@ -3418,11 +3418,11 @@ void unmap_mapping_pages(struct address_space *mapping, pgoff_t start,
 	if (last_index < first_index)
 		last_index = ULONG_MAX;
 
-	i_mmap_lock_write(mapping);
+	i_mmap_lock_read(mapping);
 	if (unlikely(!RB_EMPTY_ROOT(&mapping->i_mmap.rb_root)))
 		unmap_mapping_range_tree(&mapping->i_mmap, first_index,
 					 last_index, &details);
-	i_mmap_unlock_write(mapping);
+	i_mmap_unlock_read(mapping);
 }
 EXPORT_SYMBOL_GPL(unmap_mapping_pages);
 
