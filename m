Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A420446F497
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 21:05:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231635AbhLIUJ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 15:09:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231553AbhLIUJW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 15:09:22 -0500
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0086FC0617A1
        for <linux-kernel@vger.kernel.org>; Thu,  9 Dec 2021 12:05:48 -0800 (PST)
Received: by mail-lj1-x22e.google.com with SMTP id v15so10766876ljc.0
        for <linux-kernel@vger.kernel.org>; Thu, 09 Dec 2021 12:05:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=R0fiIRx1tdommq9IGRl8CoXFpUaCu+zHn93/yFjWte8=;
        b=n2HuGtve4aJvc3nlYM9Dz7ywy3oqNGSu7nskjkeAeor14V/8fpk08jcPSZ721Iao3+
         hHMOlkXylq2GcKZg3j54/qELfoGkt4IfF7Qo67vwRASA0+tSnyQdbhQec0oO094ceoOm
         blC4EkWj08hh9wwV9eu1k0VwdU1YRxQotoEp8vFy3tBbAkM/m6nDspgP8lajWCCPDP9K
         Zs13Y+c8Q6Y45uH5mu1eQ9/7pLVa79Nq73lCQilGu9mxZ35DjtLRdGHH+Ds1TKs2eRZD
         ucoPlVDPHqDj9AbJ58Dnzo818RFf8QdDUDOHSwUBVLZXFXKiK9vJbqHFHGI07odQ0p19
         A/iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=R0fiIRx1tdommq9IGRl8CoXFpUaCu+zHn93/yFjWte8=;
        b=QPyYquVm7gL6zKtQFZ5+qp2n5ZQUFG95qTwLf7HSNIAocIG10wcLWtEsWrTcWl7B9A
         IXye8OCJ6lYV94kd8koZeVyaDQld3LSObR7VDUC35CKGpspgBmMgbcvirr671sqzTdDX
         mYPJbzR5omUN4pEMoEgDzemDws7d7pIZEMoaXZmIKMHW0wFaOXWSDup9tjrkbwnajyvg
         esMMHDPYHnXWVxK3ii5EXPlgfRXzNj/W0rRL55/PEbYmlBVwKbls4VIYbgkePCbHZ20h
         qyQaH1yXEYegzGv2ldM83k6DYmvMNCWn+KMbk+//z2n6e0HG7grOk0WYzMD2/zI7v6Ut
         gIig==
X-Gm-Message-State: AOAM5314vSHqV7fnIhCSp3saFlAm8v/v+3kf1UqspaUXpKhzQEDTwhgR
        Z1DUA/ees6SCqV7qVOndgaw=
X-Google-Smtp-Source: ABdhPJzHrcB9daArwNq3p6osXn8jy3zvVeJEP9xDadJPm3zUWm6zBrzFxOmGFuC7tp0ecBwfSVUZ8g==
X-Received: by 2002:a05:651c:621:: with SMTP id k33mr8233705lje.359.1639080346196;
        Thu, 09 Dec 2021 12:05:46 -0800 (PST)
Received: from otyshchenko.router ([212.22.223.21])
        by smtp.gmail.com with ESMTPSA id o12sm87371lft.134.2021.12.09.12.05.45
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 Dec 2021 12:05:45 -0800 (PST)
From:   Oleksandr Tyshchenko <olekstysh@gmail.com>
To:     xen-devel@lists.xenproject.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Julien Grall <julien@xen.org>
Subject: [PATCH V4 5/6] arm/xen: Read extended regions from DT and init Xen resource
Date:   Thu,  9 Dec 2021 22:05:35 +0200
Message-Id: <1639080336-26573-6-git-send-email-olekstysh@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1639080336-26573-1-git-send-email-olekstysh@gmail.com>
References: <1639080336-26573-1-git-send-email-olekstysh@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>

This patch implements arch_xen_unpopulated_init() on Arm where
the extended regions (if any) are gathered from DT and inserted
into specific Xen resource to be used as unused address space
for Xen scratch pages by unpopulated-alloc code.

The extended region (safe range) is a region of guest physical
address space which is unused and could be safely used to create
grant/foreign mappings instead of wasting real RAM pages from
the domain memory for establishing these mappings.

The extended regions are chosen by the hypervisor at the domain
creation time and advertised to it via "reg" property under
hypervisor node in the guest device-tree. As region 0 is reserved
for grant table space (always present), the indexes for extended
regions are 1...N.

If arch_xen_unpopulated_init() fails for some reason the default
behaviour will be restored (allocate xenballooned pages).

This patch also removes XEN_UNPOPULATED_ALLOC dependency on x86.

Signed-off-by: Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>
Reviewed-by: Stefano Stabellini <sstabellini@kernel.org>
---
Changes RFC -> V2:
   - new patch, instead of
    "[RFC PATCH 2/2] xen/unpopulated-alloc: Query hypervisor to provide unallocated space"

Changes V2 -> V3:
   - update comments in code
   - drop the checks that a region is within the hotpluggable range,
     now the common code takes care of
   - update arch_xen_unpopulated_init() according to interface change,
     move xen_resource here, etc
   - use %pR specifier in error message
   - bait out in arch_xen_unpopulated_init() if !acpi_disabled
   - update checks in second loop in arch_xen_unpopulated_init()
     for the sake of clarity

Changes V3 -> V4:
   - add Stefano's R-b
---
 arch/arm/xen/enlighten.c | 106 +++++++++++++++++++++++++++++++++++++++++++++++
 drivers/xen/Kconfig      |   2 +-
 2 files changed, 107 insertions(+), 1 deletion(-)

diff --git a/arch/arm/xen/enlighten.c b/arch/arm/xen/enlighten.c
index 49bb675..ec5b082 100644
--- a/arch/arm/xen/enlighten.c
+++ b/arch/arm/xen/enlighten.c
@@ -62,6 +62,7 @@ static __read_mostly unsigned int xen_events_irq;
 static __read_mostly phys_addr_t xen_grant_frames;
 
 #define GRANT_TABLE_INDEX   0
+#define EXT_REGION_INDEX    1
 
 uint32_t xen_start_flags;
 EXPORT_SYMBOL(xen_start_flags);
@@ -303,6 +304,111 @@ static void __init xen_acpi_guest_init(void)
 #endif
 }
 
+#ifdef CONFIG_XEN_UNPOPULATED_ALLOC
+/*
+ * A type-less specific Xen resource which contains extended regions
+ * (unused regions of guest physical address space provided by the hypervisor).
+ */
+static struct resource xen_resource = {
+	.name = "Xen unused space",
+};
+
+int __init arch_xen_unpopulated_init(struct resource **res)
+{
+	struct device_node *np;
+	struct resource *regs, *tmp_res;
+	uint64_t min_gpaddr = -1, max_gpaddr = 0;
+	unsigned int i, nr_reg = 0;
+	int rc;
+
+	if (!xen_domain())
+		return -ENODEV;
+
+	if (!acpi_disabled)
+		return -ENODEV;
+
+	np = of_find_compatible_node(NULL, NULL, "xen,xen");
+	if (WARN_ON(!np))
+		return -ENODEV;
+
+	/* Skip region 0 which is reserved for grant table space */
+	while (of_get_address(np, nr_reg + EXT_REGION_INDEX, NULL, NULL))
+		nr_reg++;
+
+	if (!nr_reg) {
+		pr_err("No extended regions are found\n");
+		return -EINVAL;
+	}
+
+	regs = kcalloc(nr_reg, sizeof(*regs), GFP_KERNEL);
+	if (!regs)
+		return -ENOMEM;
+
+	/*
+	 * Create resource from extended regions provided by the hypervisor to be
+	 * used as unused address space for Xen scratch pages.
+	 */
+	for (i = 0; i < nr_reg; i++) {
+		rc = of_address_to_resource(np, i + EXT_REGION_INDEX, &regs[i]);
+		if (rc)
+			goto err;
+
+		if (max_gpaddr < regs[i].end)
+			max_gpaddr = regs[i].end;
+		if (min_gpaddr > regs[i].start)
+			min_gpaddr = regs[i].start;
+	}
+
+	xen_resource.start = min_gpaddr;
+	xen_resource.end = max_gpaddr;
+
+	/*
+	 * Mark holes between extended regions as unavailable. The rest of that
+	 * address space will be available for the allocation.
+	 */
+	for (i = 1; i < nr_reg; i++) {
+		resource_size_t start, end;
+
+		/* There is an overlap between regions */
+		if (regs[i - 1].end + 1 > regs[i].start) {
+			rc = -EINVAL;
+			goto err;
+		}
+
+		/* There is no hole between regions */
+		if (regs[i - 1].end + 1 == regs[i].start)
+			continue;
+
+		start = regs[i - 1].end + 1;
+		end = regs[i].start - 1;
+
+		tmp_res = kzalloc(sizeof(*tmp_res), GFP_KERNEL);
+		if (!tmp_res) {
+			rc = -ENOMEM;
+			goto err;
+		}
+
+		tmp_res->name = "Unavailable space";
+		tmp_res->start = start;
+		tmp_res->end = end;
+
+		rc = insert_resource(&xen_resource, tmp_res);
+		if (rc) {
+			pr_err("Cannot insert resource %pR (%d)\n", tmp_res, rc);
+			kfree(tmp_res);
+			goto err;
+		}
+	}
+
+	*res = &xen_resource;
+
+err:
+	kfree(regs);
+
+	return rc;
+}
+#endif
+
 static void __init xen_dt_guest_init(void)
 {
 	struct device_node *xen_node;
diff --git a/drivers/xen/Kconfig b/drivers/xen/Kconfig
index 33e941e..120d32f 100644
--- a/drivers/xen/Kconfig
+++ b/drivers/xen/Kconfig
@@ -327,7 +327,7 @@ config XEN_FRONT_PGDIR_SHBUF
 
 config XEN_UNPOPULATED_ALLOC
 	bool "Use unpopulated memory ranges for guest mappings"
-	depends on X86 && ZONE_DEVICE
+	depends on ZONE_DEVICE
 	default XEN_BACKEND || XEN_GNTDEV || XEN_DOM0
 	help
 	  Use unpopulated memory ranges in order to create mappings for guest
-- 
2.7.4

