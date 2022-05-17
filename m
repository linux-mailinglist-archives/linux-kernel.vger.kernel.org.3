Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9E0852A9FB
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 20:07:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236820AbiEQSFu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 14:05:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351931AbiEQSF1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 14:05:27 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8B8E5158D
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 11:04:33 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id p5-20020a1c2905000000b003970dd5404dso1694989wmp.0
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 11:04:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=xUxnvY0wWYvQFwVkkKnZ0hYzB77/1hWqL1wilzE489c=;
        b=kb8ddVNGcr5cVeafnyHPeYNXQERd/qF31HFkfUdq2R0uWdYsIrV5qJc5rqOLz8AJ2R
         LeqlzPakVREbISyj+rzFqGHtWdSCexiQvfb3BzQZY4Gb6WIGH1gnWvSpBsaSAoOAgJPw
         Y2gQVbghkdgpguWD5R6ZUeT1mykXPwp1lsXvUamDbQaFqmfp7ZJs19gwZMPPJzKo2yI5
         qsxQdCIXfE44XW+Ui9ZV8j0XprUOYnEv+bHcF2+ibhH3I9NCtjxHxMwKRYDXdrArzigQ
         AkB6D1SgJLfFBjy+aEuoy/qrUgNvZwQus2tAbvnVgDGakrkC9Xvt3cWzsnYci380bHt5
         MjFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=xUxnvY0wWYvQFwVkkKnZ0hYzB77/1hWqL1wilzE489c=;
        b=rJ3sRgpdWQjRsPrMVGIVDDw9mAyP62EFJA32M0pAF+iewIGG6150dKGjar9oerkoju
         DhDYxAq40E2gi+c3eKytSpPR+/7AimuK9YClA+M7mTsKTKodEu90mFf9KzyLVDiyBc8X
         PvnBJkW3BXiR/G2yueRzWCSeb2DJF1S7+V8oOs5aO8WY0JoQSHx6AVNDHlPvMsnM0DSa
         rvx7lhdMtEwquvJMM5awP6lF6G5bQ1M05NW+MSqphvv58MD6KMw3qeCy0BNS0FaYp+m4
         lZq63t5ej8c5VlYOun/iqhaJ3PEzSBHLpwvRlYB5Im2+5+Of14Pp2oRGUwYKwEJ3aWQq
         p3sQ==
X-Gm-Message-State: AOAM5334ui9/7PAXtpZU/icfmRfXVwG45gYFXhxGgEfI/K9POYSAWkSt
        eXK+dDxQtX25fg3VJUiANQE=
X-Google-Smtp-Source: ABdhPJzy8So6LUCbbqsaVyGqZpkGWh1nIJifHTvsH6tXSl1Cxhg/tQhSmkYmww8KULDXmX3Xv/O7fQ==
X-Received: by 2002:a05:600c:1989:b0:394:8dc0:b57f with SMTP id t9-20020a05600c198900b003948dc0b57fmr33101152wmq.110.1652810672320;
        Tue, 17 May 2022 11:04:32 -0700 (PDT)
Received: from otyshchenko.router ([212.22.223.21])
        by smtp.gmail.com with ESMTPSA id c3-20020adfc6c3000000b0020c5253d8dasm12978625wrh.38.2022.05.17.11.04.31
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 17 May 2022 11:04:31 -0700 (PDT)
From:   Oleksandr Tyshchenko <olekstysh@gmail.com>
To:     xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org
Cc:     Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>, Julien Grall <julien@xen.org>
Subject: [RFC PATCH 2/2] xen/grant-table: Use unpopulated DMAable pages instead of real RAM ones
Date:   Tue, 17 May 2022 21:04:18 +0300
Message-Id: <1652810658-27810-3-git-send-email-olekstysh@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1652810658-27810-1-git-send-email-olekstysh@gmail.com>
References: <1652810658-27810-1-git-send-email-olekstysh@gmail.com>
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
DMAable (contiguous) pages will be allocated for grant mapping into
instead of ballooning out real RAM pages.

TODO: Fallback to real RAM pages if xen_alloc_unpopulated_dma_pages()
fails.

Signed-off-by: Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>
---
 drivers/xen/grant-table.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/drivers/xen/grant-table.c b/drivers/xen/grant-table.c
index 8ccccac..2bb4392 100644
--- a/drivers/xen/grant-table.c
+++ b/drivers/xen/grant-table.c
@@ -864,6 +864,25 @@ EXPORT_SYMBOL_GPL(gnttab_free_pages);
  */
 int gnttab_dma_alloc_pages(struct gnttab_dma_alloc_args *args)
 {
+#ifdef CONFIG_XEN_UNPOPULATED_ALLOC
+	int ret;
+
+	ret = xen_alloc_unpopulated_dma_pages(args->dev, args->nr_pages,
+			args->pages);
+	if (ret < 0)
+		return ret;
+
+	ret = gnttab_pages_set_private(args->nr_pages, args->pages);
+	if (ret < 0) {
+		gnttab_dma_free_pages(args);
+		return ret;
+	}
+
+	args->vaddr = page_to_virt(args->pages[0]);
+	args->dev_bus_addr = page_to_phys(args->pages[0]);
+
+	return ret;
+#else
 	unsigned long pfn, start_pfn;
 	size_t size;
 	int i, ret;
@@ -910,6 +929,7 @@ int gnttab_dma_alloc_pages(struct gnttab_dma_alloc_args *args)
 fail:
 	gnttab_dma_free_pages(args);
 	return ret;
+#endif
 }
 EXPORT_SYMBOL_GPL(gnttab_dma_alloc_pages);
 
@@ -919,6 +939,12 @@ EXPORT_SYMBOL_GPL(gnttab_dma_alloc_pages);
  */
 int gnttab_dma_free_pages(struct gnttab_dma_alloc_args *args)
 {
+#ifdef CONFIG_XEN_UNPOPULATED_ALLOC
+	gnttab_pages_clear_private(args->nr_pages, args->pages);
+	xen_free_unpopulated_dma_pages(args->dev, args->nr_pages, args->pages);
+
+	return 0;
+#else
 	size_t size;
 	int i, ret;
 
@@ -946,6 +972,7 @@ int gnttab_dma_free_pages(struct gnttab_dma_alloc_args *args)
 		dma_free_wc(args->dev, size,
 			    args->vaddr, args->dev_bus_addr);
 	return ret;
+#endif
 }
 EXPORT_SYMBOL_GPL(gnttab_dma_free_pages);
 #endif
-- 
2.7.4

