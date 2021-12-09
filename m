Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A89746F496
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 21:05:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231637AbhLIUJ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 15:09:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231542AbhLIUJV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 15:09:21 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36DD5C0617A2
        for <linux-kernel@vger.kernel.org>; Thu,  9 Dec 2021 12:05:47 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id u3so14214909lfl.2
        for <linux-kernel@vger.kernel.org>; Thu, 09 Dec 2021 12:05:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=wUGrgrAhSp00M+b8z9JNtCABbdhrenjEQ9qiU7Kp+fE=;
        b=jWc9wxTYHdqYtFuA3EuCo7h3BpGS363+/BKxA5rQ3cK7v9JSmq+KDfWhMZ5nxffD78
         O+IAzxYsXqzcb4CpKQY3zvXEk3wabMycLoHM9HUVF0hv4sKedWBrOhTj4sxrjCk6OJLh
         2+5G4UMZ/DjD3K/ziMUEaEqkRprnYXh3SXr2zvFaOq/i6MZFzIWUFiC1if1dSuQsK3cB
         CsXMX7/5EaA5BLRTg+uda1C7EO5EitsbsN0mrbjVq2jH/IFyO6W/DXUNmA4Onw0OfyXl
         apoUCgdr6WTP+ko9G865vRawOTkNbQD4tDoeuqB+jjE5fERhUWBrFAtoGThXNyt0eDR1
         UUTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=wUGrgrAhSp00M+b8z9JNtCABbdhrenjEQ9qiU7Kp+fE=;
        b=MxlCwd5mtJQRDojET/ih9TlpGviwTQp0VFQS9+vhw99JHBuK4cLDYSb83LRyNaK/C/
         xPc8suUub7WljXhCkEJMWQ4n7RYixRKTBhR3K6KxSGvyu/SjC2wdkEWFKKcE0c6KOV9c
         vvwmFCqgCJzv7CaN7wx0xjc0w8QvOYMZNZu7KNc46KfDj+M0N24bW/hH1jzIBixQP9+q
         4xQcBl0zQ7qOakqPMDecgeOFjPDFQnc1F8WA7bXRt/xAU6dULRYcdC2DFwC2uhpefUPt
         +BP1oe2Hr4nf7oyUo4m/9g9nKWVzxxh8sno3eB+M1Cy1h8QotOREjwNh1PbVjr5FQeCX
         zTFQ==
X-Gm-Message-State: AOAM530hE5Gwu0+6+8v/6gPtug51E75wKRBhQLhbynA8Vzz9mGlbAms/
        FRQtGf5ra5vCvOcUU9LXtXc=
X-Google-Smtp-Source: ABdhPJwxNCCMm538u0QAdLmoN2XRwAivi00DvNgNn4UUQkZeWmYpD/N/YdNzX3nmLM69YRGUxPGnEw==
X-Received: by 2002:a05:6512:3d16:: with SMTP id d22mr7845851lfv.523.1639080345433;
        Thu, 09 Dec 2021 12:05:45 -0800 (PST)
Received: from otyshchenko.router ([212.22.223.21])
        by smtp.gmail.com with ESMTPSA id o12sm87371lft.134.2021.12.09.12.05.44
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 Dec 2021 12:05:45 -0800 (PST)
From:   Oleksandr Tyshchenko <olekstysh@gmail.com>
To:     xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org
Cc:     Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Julien Grall <julien@xen.org>
Subject: [PATCH V4 4/6] xen/unpopulated-alloc: Add mechanism to use Xen resource
Date:   Thu,  9 Dec 2021 22:05:34 +0200
Message-Id: <1639080336-26573-5-git-send-email-olekstysh@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1639080336-26573-1-git-send-email-olekstysh@gmail.com>
References: <1639080336-26573-1-git-send-email-olekstysh@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>

The main reason of this change is that unpopulated-alloc
code cannot be used in its current form on Arm, but there
is a desire to reuse it to avoid wasting real RAM pages
for the grant/foreign mappings.

The problem is that system "iomem_resource" is used for
the address space allocation, but the really unallocated
space can't be figured out precisely by the domain on Arm
without hypervisor involvement. For example, not all device
I/O regions are known by the time domain starts creating
grant/foreign mappings. And following the advise from
"iomem_resource" we might end up reusing these regions by
a mistake. So, the hypervisor which maintains the P2M for
the domain is in the best position to provide unused regions
of guest physical address space which could be safely used
to create grant/foreign mappings.

Introduce new helper arch_xen_unpopulated_init() which purpose
is to create specific Xen resource based on the memory regions
provided by the hypervisor to be used as unused space for Xen
scratch pages. If arch doesn't define arch_xen_unpopulated_init()
the default "iomem_resource" will be used.

Update the arguments list of allocate_resource() in fill_list()
to always allocate a region from the hotpluggable range
(maximum possible addressable physical memory range for which
the linear mapping could be created). If arch doesn't define
arch_get_mappable_range() the default range (0,-1) will be used.

The behaviour on x86 won't be changed by current patch as both
arch_xen_unpopulated_init() and arch_get_mappable_range()
are not implemented for it.

Also fallback to allocate xenballooned pages (balloon out RAM
pages) if we do not have any suitable resource to work with
(target_resource is invalid) and as the result we won't be able
to provide unpopulated pages on a request.

Signed-off-by: Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>
Reviewed-by: Stefano Stabellini <sstabellini@kernel.org>
---
Changes RFC -> V2:
   - new patch, instead of
    "[RFC PATCH 2/2] xen/unpopulated-alloc: Query hypervisor to provide unallocated space"

Changes V2 -> V3:
   - update patch description and comments in code
   - modify arch_xen_unpopulated_init() to pass target_resource as an argument
     and update default helper to assign iomem_resource to it, also drop
     xen_resource as it will be located in arch code in the future
   - allocate region from hotpluggable range instead of hardcoded range (0,-1)
     in fill_list()
   - use %pR specifier in error message
   - do not call unpopulated_init() at runtime from xen_alloc_unpopulated_pages(),
     drop an extra helper and call arch_xen_unpopulated_init() directly from __init()
   - include linux/ioport.h instead of forward declaration of struct resource
   - replace insert_resource() with request_resource() in fill_list()
   - add __init specifier to arch_xen_unpopulated_init()

Changes V3 -> V4:
   - add Stefano's R-b
   - fix copy-paste error in fill_list(), must be "if (!tmp_res)" instead of
     "if (!res)" in string 66
   - add unpopulated_init() with early initcall level specifically to call
     arch_xen_unpopulated_init()
---
 drivers/xen/unpopulated-alloc.c | 86 +++++++++++++++++++++++++++++++++++++++--
 include/xen/xen.h               |  2 +
 2 files changed, 84 insertions(+), 4 deletions(-)

diff --git a/drivers/xen/unpopulated-alloc.c b/drivers/xen/unpopulated-alloc.c
index a03dc5b..a8b4105 100644
--- a/drivers/xen/unpopulated-alloc.c
+++ b/drivers/xen/unpopulated-alloc.c
@@ -8,6 +8,7 @@
 
 #include <asm/page.h>
 
+#include <xen/balloon.h>
 #include <xen/page.h>
 #include <xen/xen.h>
 
@@ -15,13 +16,29 @@ static DEFINE_MUTEX(list_lock);
 static struct page *page_list;
 static unsigned int list_count;
 
+static struct resource *target_resource;
+
+/*
+ * If arch is not happy with system "iomem_resource" being used for
+ * the region allocation it can provide it's own view by creating specific
+ * Xen resource with unused regions of guest physical address space provided
+ * by the hypervisor.
+ */
+int __weak __init arch_xen_unpopulated_init(struct resource **res)
+{
+	*res = &iomem_resource;
+
+	return 0;
+}
+
 static int fill_list(unsigned int nr_pages)
 {
 	struct dev_pagemap *pgmap;
-	struct resource *res;
+	struct resource *res, *tmp_res = NULL;
 	void *vaddr;
 	unsigned int i, alloc_pages = round_up(nr_pages, PAGES_PER_SECTION);
-	int ret = -ENOMEM;
+	struct range mhp_range;
+	int ret;
 
 	res = kzalloc(sizeof(*res), GFP_KERNEL);
 	if (!res)
@@ -30,14 +47,40 @@ static int fill_list(unsigned int nr_pages)
 	res->name = "Xen scratch";
 	res->flags = IORESOURCE_MEM | IORESOURCE_BUSY;
 
-	ret = allocate_resource(&iomem_resource, res,
-				alloc_pages * PAGE_SIZE, 0, -1,
+	mhp_range = mhp_get_pluggable_range(true);
+
+	ret = allocate_resource(target_resource, res,
+				alloc_pages * PAGE_SIZE, mhp_range.start, mhp_range.end,
 				PAGES_PER_SECTION * PAGE_SIZE, NULL, NULL);
 	if (ret < 0) {
 		pr_err("Cannot allocate new IOMEM resource\n");
 		goto err_resource;
 	}
 
+	/*
+	 * Reserve the region previously allocated from Xen resource to avoid
+	 * re-using it by someone else.
+	 */
+	if (target_resource != &iomem_resource) {
+		tmp_res = kzalloc(sizeof(*tmp_res), GFP_KERNEL);
+		if (!tmp_res) {
+			ret = -ENOMEM;
+			goto err_insert;
+		}
+
+		tmp_res->name = res->name;
+		tmp_res->start = res->start;
+		tmp_res->end = res->end;
+		tmp_res->flags = res->flags;
+
+		ret = request_resource(&iomem_resource, tmp_res);
+		if (ret < 0) {
+			pr_err("Cannot request resource %pR (%d)\n", tmp_res, ret);
+			kfree(tmp_res);
+			goto err_insert;
+		}
+	}
+
 	pgmap = kzalloc(sizeof(*pgmap), GFP_KERNEL);
 	if (!pgmap) {
 		ret = -ENOMEM;
@@ -95,6 +138,11 @@ static int fill_list(unsigned int nr_pages)
 err_memremap:
 	kfree(pgmap);
 err_pgmap:
+	if (tmp_res) {
+		release_resource(tmp_res);
+		kfree(tmp_res);
+	}
+err_insert:
 	release_resource(res);
 err_resource:
 	kfree(res);
@@ -112,6 +160,14 @@ int xen_alloc_unpopulated_pages(unsigned int nr_pages, struct page **pages)
 	unsigned int i;
 	int ret = 0;
 
+	/*
+	 * Fallback to default behavior if we do not have any suitable resource
+	 * to allocate required region from and as the result we won't be able to
+	 * construct pages.
+	 */
+	if (!target_resource)
+		return xen_alloc_ballooned_pages(nr_pages, pages);
+
 	mutex_lock(&list_lock);
 	if (list_count < nr_pages) {
 		ret = fill_list(nr_pages - list_count);
@@ -159,6 +215,11 @@ void xen_free_unpopulated_pages(unsigned int nr_pages, struct page **pages)
 {
 	unsigned int i;
 
+	if (!target_resource) {
+		xen_free_ballooned_pages(nr_pages, pages);
+		return;
+	}
+
 	mutex_lock(&list_lock);
 	for (i = 0; i < nr_pages; i++) {
 		pages[i]->zone_device_data = page_list;
@@ -201,3 +262,20 @@ static int __init init(void)
 }
 subsys_initcall(init);
 #endif
+
+static int __init unpopulated_init(void)
+{
+	int ret;
+
+	if (!xen_domain())
+		return -ENODEV;
+
+	ret = arch_xen_unpopulated_init(&target_resource);
+	if (ret) {
+		pr_err("xen:unpopulated: Cannot initialize target resource\n");
+		target_resource = NULL;
+	}
+
+	return ret;
+}
+early_initcall(unpopulated_init);
diff --git a/include/xen/xen.h b/include/xen/xen.h
index 86c5b37..a99bab8 100644
--- a/include/xen/xen.h
+++ b/include/xen/xen.h
@@ -55,6 +55,8 @@ extern u64 xen_saved_max_mem_size;
 #ifdef CONFIG_XEN_UNPOPULATED_ALLOC
 int xen_alloc_unpopulated_pages(unsigned int nr_pages, struct page **pages);
 void xen_free_unpopulated_pages(unsigned int nr_pages, struct page **pages);
+#include <linux/ioport.h>
+int arch_xen_unpopulated_init(struct resource **res);
 #else
 #include <xen/balloon.h>
 static inline int xen_alloc_unpopulated_pages(unsigned int nr_pages,
-- 
2.7.4

