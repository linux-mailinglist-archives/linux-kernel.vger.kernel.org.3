Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23EFB4CB48D
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 02:57:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231442AbiCCBoX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 20:44:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231419AbiCCBoV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 20:44:21 -0500
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A48A4B1CA
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 17:43:37 -0800 (PST)
Received: by mail-qt1-x829.google.com with SMTP id bt3so3450691qtb.0
        for <linux-kernel@vger.kernel.org>; Wed, 02 Mar 2022 17:43:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mime-version;
        bh=iPfHEmOKdhMIfmj5DivY/bN1HDyWSYEFJHhO7/nuhns=;
        b=V7iwAeTLsXaQIKV2Op9OyY2XBqa01szKvdFcutupQlrJPMLJYdZuO3pNb7e/bI2d04
         gsBg/TrRAZ2Jqd2WnvNmkBEUPLYA56rvBPyQVY0O3zKpvk9U43ZsXZvAbb2Qqw/Jm0SR
         nJSViRcjwsvY1DOTB/RoteIWi4uYK5YItQn6F1Fn9lhxP+5uKaMbh4kqxT0BktjjWkDD
         edMVE9gnNJMfgmRFuQUDBb3bHq7Xa0fSMT8pN/aKfzd1ZGJcRvkE8kFdJhLE6hjIu+7X
         Ns44trhbwsOWUmeuekK67Kc8jHfeXoNH5YQgBeJY1GVhIzwJmYy2zKYCRs9GRxgF0S4t
         1H1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version;
        bh=iPfHEmOKdhMIfmj5DivY/bN1HDyWSYEFJHhO7/nuhns=;
        b=nV5pbB3cRdJiPtH10S0q6m3/7fe0q1V7TikJ4aIy6mWyPkXTtLjDPwdH4rdNzPfAgG
         1uJzKYIlinR7L3l05iX66G5I9ahw1rcaH/GBc9dpHib1OIUfgq2EloaSjmtHHbS7dprT
         G121Ne567qpfWaKO15qwE1NrP8Smd2MR3fAxK2P+7J1KpShpe1FgLWiNxSkMk9VhzcXx
         WQbKi8cK+nUEotjlmNVOAUrkWv65v4Xdv2sY9xVRYmNbnwLPLBuoxCs0VkNpatlpA+hU
         la0T9PUXGeGmyqOKQzMGHo/+y4h/yYuFegikUDDzOGKCkM5deOsqaFebFTGXQylG9Ga6
         IodQ==
X-Gm-Message-State: AOAM530En7KkkttjnRgKqKl9PC5xYPcz5jHK5fJmJad0wLHeAuRVn0DV
        xSExov5Uv10B58pWhAJ9vz7WpQbbk6nlXA==
X-Google-Smtp-Source: ABdhPJzFHfUq3MiN2IigtOEeO0VwfWCXHQ2A9X5459o4XXiiE/KChwr0tPIPow5WzYUzTPUiz5qX1A==
X-Received: by 2002:a05:622a:1055:b0:2de:3ea:f2ad with SMTP id f21-20020a05622a105500b002de03eaf2admr26149270qte.327.1646271816542;
        Wed, 02 Mar 2022 17:43:36 -0800 (PST)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id x12-20020a05620a14ac00b0060deaee7a21sm403207qkj.51.2022.03.02.17.43.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Mar 2022 17:43:35 -0800 (PST)
Date:   Wed, 2 Mar 2022 17:43:34 -0800 (PST)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.anvils
To:     Andrew Morton <akpm@linux-foundation.org>
cc:     Ralph Campbell <rcampbell@nvidia.com>,
        Yang Shi <shy828301@gmail.com>, Zi Yan <ziy@nvidia.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH mmotm] mm/thp: refix __split_huge_pmd_locked() for migration
 PMD
Message-ID: <84792468-f512-e48f-378c-e34c3641e97@google.com>
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

Migration entries do not contribute to a page's reference count: move
__split_huge_pmd_locked()'s page_ref_add() into pmd_migration's else
block (along with the page_count() check - a page is quite likely to
to have reference count frozen to 0 when a migration entry is found).

This will fix a very rare anonymous memory leak, after a split_huge_pmd()
raced with an anon split_huge_page() or an anon THP migrate_pages(): since
the wrongly raised refcount stopped the page (perhaps small, perhaps huge,
depending on when the race hit) from ever being freed.  At first I thought
there were worse risks, from prematurely unfreezing a frozen page: but now
think that would only affect page cache pages, which do not come this way
(except for anonymous pages in swap cache, perhaps).

Fixes: ec0abae6dcdf ("mm/thp: fix __split_huge_pmd_locked() for migration PMD")
Signed-off-by: Hugh Dickins <hughd@google.com>
---
That's an unfair "Fixes": it did not introduce the problem, but it
missed this aspect of the problem; and will be a good guide to where this
refix should go if stable backports are asked for.

 mm/huge_memory.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -2039,9 +2039,9 @@ static void __split_huge_pmd_locked(struct vm_area_struct *vma, pmd_t *pmd,
 		young = pmd_young(old_pmd);
 		soft_dirty = pmd_soft_dirty(old_pmd);
 		uffd_wp = pmd_uffd_wp(old_pmd);
+		VM_BUG_ON_PAGE(!page_count(page), page);
+		page_ref_add(page, HPAGE_PMD_NR - 1);
 	}
-	VM_BUG_ON_PAGE(!page_count(page), page);
-	page_ref_add(page, HPAGE_PMD_NR - 1);
 
 	/*
 	 * Withdraw the table only after we mark the pmd entry invalid.
