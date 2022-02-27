Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 975FF4C58FA
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Feb 2022 03:28:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229684AbiB0CZy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Feb 2022 21:25:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbiB0CZx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Feb 2022 21:25:53 -0500
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FA086FA1D
        for <linux-kernel@vger.kernel.org>; Sat, 26 Feb 2022 18:25:18 -0800 (PST)
Received: by mail-qv1-xf2b.google.com with SMTP id x3so9797036qvd.8
        for <linux-kernel@vger.kernel.org>; Sat, 26 Feb 2022 18:25:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mime-version;
        bh=ZT/+q9dNBSLcgjlN3SJ5+1Yj8vgLHAugbOdQcBKIfxY=;
        b=F4SnOsdsUpqy9Dh3XAGAdr4uySWlOmbJijjyaU/uVVo/tp0yVZFdz3tCn9oLpW4k5f
         MQ3/Scu+VouIVui2NTyNvRlUu8Idq07xX0X2Fz8EgRA+bV+LiDHmvCW/iLH42AgjvvJF
         8HhnID1Eq5lToU2rv9OaVlQ3dJVbgNXpLfrkfT6aGsLT+HUfxMIgZxn02FP9F1XzroBU
         rWjOOqoTWByA6i/YltHquGR7l7tYgyDGeGAhQ5siUfRd2pCTEt1yoXpTgSX9GURmR+5C
         pDjSo/DTcr1LHpXakUqQJpdGCOLVql52A0RT9jC0lvbTROVwpMGV7rocQtowIWljvjPB
         htWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version;
        bh=ZT/+q9dNBSLcgjlN3SJ5+1Yj8vgLHAugbOdQcBKIfxY=;
        b=Tx6JSO9pQoUWzDbtJObxp7+EnYLbXK2gWqCMDQQu45+0vkt6Vmj4DSU9chKBoR+kux
         KetMlGnPrQ3B7NhKUAZXMmDNaqMkfzyZEbXB1RuJwgkFtLo0vp4aCNzLaXhrypAjF8hR
         IfIgaPjns0rkemNzvhvIZKf6Up9yeL1XWGPbRhLaqiooh1pJKY5sUOiIcDO01CQaYGVl
         bmpZ8klvEcZfUznHx8FePxf17elWJkOLKucKOD++nQOtHUpFQfLtLvpOUEohvwcIkXIA
         kcAoJDtk4KOc/CCyRl0tJGcBaFuQ6Mz6vxUc0nv2qM3ckbBy55zl14H82ed9Uvh0BS//
         p2rg==
X-Gm-Message-State: AOAM532nnGG58kLq3xzxyE3iWxP86+t+sjrc8mOZS71Ra7S/YvAhoNa5
        A1Ctnt3HHX+/1S+JHfZeiFGjlA==
X-Google-Smtp-Source: ABdhPJxfrEuPobOVaV23MJwxDp8JklmIfshf0IhpzBrIeactCe6Iqz89FhRU41LIRU5L/0nZB2MA0A==
X-Received: by 2002:a05:6214:1947:b0:432:bb20:4b38 with SMTP id q7-20020a056214194700b00432bb204b38mr8513388qvk.96.1645928717019;
        Sat, 26 Feb 2022 18:25:17 -0800 (PST)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id k125-20020a378883000000b006491db6dbb1sm3215102qkd.84.2022.02.26.18.25.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Feb 2022 18:25:16 -0800 (PST)
Date:   Sat, 26 Feb 2022 18:25:15 -0800 (PST)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.anvils
To:     Matthew Wilcox <willy@infradead.org>
cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH next] mm/migrate: fix remove_migration_pte() of hugetlb
 entry
Message-ID: <bd28ebcf-4d42-7184-8189-ffed6fe7d4dc@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-16.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,FROM_FMBLA_NEWDOM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The foliation of remove_migration_pte() is currently wrong on hugetlb
anon entries, causing LTP move_pages12 to crash on BUG_ON(!PageLocked)
in hugepage_add_anon_rmap().

Fixes: b4010e88f071 ("mm/migrate: Convert remove_migration_ptes() to folios")
Signed-off-by: Hugh Dickins <hughd@google.com>
---
Please just fold in if you agree.

 mm/migrate.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- mmotm/mm/migrate.c
+++ linux/mm/migrate.c
@@ -182,7 +182,8 @@ static bool remove_migration_pte(struct
 		struct page *new;
 		unsigned long idx = 0;
 
-		if (!folio_test_ksm(folio))
+		/* Skip call in common case, plus .pgoff is invalid for KSM */
+		if (pvmw.nr_pages != 1 && !folio_test_hugetlb(folio))
 			idx = linear_page_index(vma, pvmw.address) - pvmw.pgoff;
 		new = folio_page(folio, idx);
 
