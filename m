Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F5A8552189
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 17:49:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242508AbiFTPtR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 11:49:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229814AbiFTPtG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 11:49:06 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16B101BE9F
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 08:49:05 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id n15so751770ljg.8
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 08:49:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=rlaK5EBLGtLc0krm/NL8VjdXnXIvfVQErc2uihOdLNA=;
        b=apvgpzqNUstKOMcGs47PvJ/CJGiFo3SYPo3oiXc1rEQh2ny24O/ZaJoNVHjnfHcBhL
         sE1/1NG3Vs/kIMo8gj3Dk2c1z7sWI1F6EdHVU5RcPgXfz+Rrfks6uLTuEu55gw1yM27b
         nh85POmnWW1OCbeaOgCJ1XfYEXGuLwKCpDlvM5NdDcpG18XiV34MmfpYzn/qxxS3SZdR
         3w/I/cMlbXoVrCAObEEAHpvGvc4hR6QkugR/gTlGww4Geap1+ZxIUXXzj/4cE8cyHnkL
         cIeYuaL8KGwLApG0jMafBYFesH5ABExrJ9c2WvNvoIXzvQwm7mV8bNGgDjR8bq5WUCJ8
         Dg7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=rlaK5EBLGtLc0krm/NL8VjdXnXIvfVQErc2uihOdLNA=;
        b=ZE3Q8HO0fSdJ4PRYwEhH39IAGYkf08YYUyWhrKcIzxXNWe/CmheJTC05w+6gG/JiPE
         rsfyXP3U8Db6QCan5ElujgEf2dNIxDRZDo3KKwGRVlfCKMSmZ9dozm7yTLhXwqvERulA
         kUkxmx7tidKyuhA9T5DaCOxzj/bhT+RxXwMjIYQke777+ClaQS5LRqzXJwdyM/5Aw5EY
         gO7er1HcF4B5Lh5ToEavjw8KoG67HOvowmoNOslrONmfP4YHEp4jkN1hSDJpg2t9xGvo
         QAoxAsmo3ovBPhnshJ8RvD7qGPt9prz0WRSmfvNIcV8mF+8bQK66pgJmC0s8U3z648oc
         WMYA==
X-Gm-Message-State: AJIora8FMfQqw+2OxSr18e8jzFIuYShG7d3p3ku0/ME8nkI20c7Q2nWQ
        drGlCKQ7smEmsiT4jQHMM9I=
X-Google-Smtp-Source: AGRyM1t8jZIIoIQOefBZwbkKIP31jN1TS68e69Tx5q0PTW0PQDRQ78ifLWRGU9zxegOfnvyNtEbWjQ==
X-Received: by 2002:a05:651c:8f:b0:255:8e6e:1980 with SMTP id 15-20020a05651c008f00b002558e6e1980mr11944050ljq.462.1655740143445;
        Mon, 20 Jun 2022 08:49:03 -0700 (PDT)
Received: from otyshchenko.router ([212.22.223.21])
        by smtp.gmail.com with ESMTPSA id m9-20020a2e9349000000b0024f3d1dae94sm1690149ljh.28.2022.06.20.08.49.02
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 20 Jun 2022 08:49:02 -0700 (PDT)
From:   Oleksandr Tyshchenko <olekstysh@gmail.com>
To:     xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org
Cc:     Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Juergen Gross <jgross@suse.com>, Julien Grall <julien@xen.org>
Subject: [PATCH V1 2/2] xen/grant-table: Use unpopulated contiguous pages instead of real RAM ones
Date:   Mon, 20 Jun 2022 18:48:56 +0300
Message-Id: <1655740136-3974-3-git-send-email-olekstysh@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1655740136-3974-1-git-send-email-olekstysh@gmail.com>
References: <1655740136-3974-1-git-send-email-olekstysh@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>

Depends on CONFIG_XEN_UNPOPULATED_ALLOC. If enabled then unpopulated
contiguous pages will be allocated for grant mapping into instead of
ballooning out real RAM pages.

Also fallback to allocate DMAable pages (balloon out real RAM pages)
if we failed to allocate unpopulated contiguous pages. Use recently
introduced is_xen_unpopulated_page() in gnttab_dma_free_pages() to know
what API to use for freeing pages.

Signed-off-by: Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>
---
Please note, I haven't re-checked yet the use-case where the xen-swiotlb
is involved (proposed by Stefano):
https://lore.kernel.org/xen-devel/alpine.DEB.2.22.394.2206031348230.2783803@ubuntu-linux-20-04-desktop/
I will re-check that for next version and add corresponding comment
in the code.

Changes RFC -> V1:
   - update commit subject/description
   - rework to avoid introducing alternative implementation
     of gnttab_dma_alloc(free)_pages(), use IS_ENABLED()
   - implement a fallback to real RAM pages if we failed to allocate
     unpopulated contiguous pages (resolve initial TODO)
   - update according to the API renaming (s/dma/contiguous)
---
 drivers/xen/grant-table.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/drivers/xen/grant-table.c b/drivers/xen/grant-table.c
index 738029d..15e426b 100644
--- a/drivers/xen/grant-table.c
+++ b/drivers/xen/grant-table.c
@@ -1047,6 +1047,23 @@ int gnttab_dma_alloc_pages(struct gnttab_dma_alloc_args *args)
 	size_t size;
 	int i, ret;
 
+	if (IS_ENABLED(CONFIG_XEN_UNPOPULATED_ALLOC)) {
+		ret = xen_alloc_unpopulated_contiguous_pages(args->dev, args->nr_pages,
+				args->pages);
+		if (ret < 0)
+			goto fallback;
+
+		ret = gnttab_pages_set_private(args->nr_pages, args->pages);
+		if (ret < 0)
+			goto fail;
+
+		args->vaddr = page_to_virt(args->pages[0]);
+		args->dev_bus_addr = page_to_phys(args->pages[0]);
+
+		return ret;
+	}
+
+fallback:
 	size = args->nr_pages << PAGE_SHIFT;
 	if (args->coherent)
 		args->vaddr = dma_alloc_coherent(args->dev, size,
@@ -1103,6 +1120,13 @@ int gnttab_dma_free_pages(struct gnttab_dma_alloc_args *args)
 
 	gnttab_pages_clear_private(args->nr_pages, args->pages);
 
+	if (IS_ENABLED(CONFIG_XEN_UNPOPULATED_ALLOC) &&
+			is_xen_unpopulated_page(args->pages[0])) {
+		xen_free_unpopulated_contiguous_pages(args->dev, args->nr_pages,
+				args->pages);
+		return 0;
+	}
+
 	for (i = 0; i < args->nr_pages; i++)
 		args->frames[i] = page_to_xen_pfn(args->pages[i]);
 
-- 
2.7.4

