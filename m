Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29A1D46F492
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 21:05:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231519AbhLIUJT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 15:09:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231483AbhLIUJS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 15:09:18 -0500
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 143EFC061746
        for <linux-kernel@vger.kernel.org>; Thu,  9 Dec 2021 12:05:44 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id l22so14131529lfg.7
        for <linux-kernel@vger.kernel.org>; Thu, 09 Dec 2021 12:05:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=CS9aK8CojMqdb/AcA3jHRSI+mrWqH9RveIgOpizvY9U=;
        b=nJ6YIRKoVQppvpal4aj4p6po8BZEoe2W0v2EiJOt2lz9DD/MZQz4YOGAFga6byn+PS
         bpoNN7jJzU6n+1ymG3q5nkDMcZyj6qh8VLD5qe9Y82B5S10kXdLAgf8PzlZT01cHKuhA
         JXaYSWqP6JLSTiUSi3EyD3xZ+LiV/d/6rJhFyPL5A2n9Qlamzj6EkCbfiO7uXKvO0fDC
         dDKM/bTNoo7nV/iChOSyPjaEfVz8kw6VsAW++5dxIl2Ed/EHaOmZKJK0QgUPBpIFINJw
         0i+XdqKk7zJC+3HWynXOo7JID118X95q9twABJWbrjnKOuX9i34ZaQ8aTIjd0bmhB/4Y
         F9XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=CS9aK8CojMqdb/AcA3jHRSI+mrWqH9RveIgOpizvY9U=;
        b=V/iHUGBDnguAUmtrgYMhOMViXuQM+EZPqAypJEqCrUUNozvQYJrmJI5ty1GwGu+2ae
         v/gLQdbVf3VwAqlWcoD+e+Jl2eh3YwrYMgPu5UahCAFMyX2zV/nof5GNpl85dlhws77K
         ARqCmVqM81t9k1O6A4Q2jA23NvrI59fIq0SIK2Yp4s9ifl2Q47qLbuOnyfhshz0/pPB7
         8MlGmeHCdKgbIUqbbTnKhH/NF966uYT2n15V3CBGyVy0T7E31BYYLQhTnSkbPmdI6939
         k3YEZavmoACZ4FrE5/OCGnrl5+ldbnEaEo9Tv1l0w4IR5urmWERhHjGTGZ1bQg8hF+4S
         JGQg==
X-Gm-Message-State: AOAM531CBwNJsVkmXsX1Fa8aO07ZFQL+mFePfY9yczpuGAGbBwP8l+Rp
        UY4KTVgBWKkOlZQkWWw3/+8=
X-Google-Smtp-Source: ABdhPJxerwr28Tg8c06W+QUK8C5H1O0rKZUkku9U1Odi1NykdsC2f8brvhJBN6XBJ2EuJVFZAjwx2Q==
X-Received: by 2002:a05:6512:2312:: with SMTP id o18mr8160079lfu.333.1639080342265;
        Thu, 09 Dec 2021 12:05:42 -0800 (PST)
Received: from otyshchenko.router ([212.22.223.21])
        by smtp.gmail.com with ESMTPSA id o12sm87371lft.134.2021.12.09.12.05.41
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 Dec 2021 12:05:41 -0800 (PST)
From:   Oleksandr Tyshchenko <olekstysh@gmail.com>
To:     xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org
Cc:     Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Julien Grall <julien@xen.org>
Subject: [PATCH V4 1/6] xen/unpopulated-alloc: Drop check for virt_addr_valid() in fill_list()
Date:   Thu,  9 Dec 2021 22:05:31 +0200
Message-Id: <1639080336-26573-2-git-send-email-olekstysh@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1639080336-26573-1-git-send-email-olekstysh@gmail.com>
References: <1639080336-26573-1-git-send-email-olekstysh@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>

If memremap_pages() succeeds the range is guaranteed to have proper page
table, there is no need for an additional virt_addr_valid() check.

Signed-off-by: Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>
Reviewed-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>
---
Changes RFC -> V2:
   - new patch, instead of
     "[RFC PATCH 1/2] arm64: mm: Make virt_addr_valid to check for pfn_valid again"

Changes V2 -> V3:
   - add Boris' R-b

Changes V3 -> V4:
   - no changes
---
 drivers/xen/unpopulated-alloc.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/xen/unpopulated-alloc.c b/drivers/xen/unpopulated-alloc.c
index 87e6b7d..a03dc5b 100644
--- a/drivers/xen/unpopulated-alloc.c
+++ b/drivers/xen/unpopulated-alloc.c
@@ -85,7 +85,6 @@ static int fill_list(unsigned int nr_pages)
 	for (i = 0; i < alloc_pages; i++) {
 		struct page *pg = virt_to_page(vaddr + PAGE_SIZE * i);
 
-		BUG_ON(!virt_addr_valid(vaddr + PAGE_SIZE * i));
 		pg->zone_device_data = page_list;
 		page_list = pg;
 		list_count++;
-- 
2.7.4

