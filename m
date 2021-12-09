Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7336146F493
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 21:05:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231529AbhLIUJV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 15:09:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231514AbhLIUJT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 15:09:19 -0500
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 985D0C061746
        for <linux-kernel@vger.kernel.org>; Thu,  9 Dec 2021 12:05:45 -0800 (PST)
Received: by mail-lj1-x22a.google.com with SMTP id v15so10766757ljc.0
        for <linux-kernel@vger.kernel.org>; Thu, 09 Dec 2021 12:05:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=XoEU3DaXUqalCs6jzwcHq5Z2kR7REX3RsrqKMfGCo2w=;
        b=GlM2t+eQRjThRQMjBZpSdxLnDWzEbjJWVwRDusOaEx3MeX4FketF3biTqFzeEnAVU0
         VhfKGEcuQp52HiEpPpvacBbuQwd87JvMTehJYvdAXf7KeOioUXb3WO3fCLID1qKZ7UBZ
         UTgdjk7vrs0SFE8l7HuLKFHyLrmDTcAD9cNMgKBWyA2U3xnLfBw1azVxQh+7gf79/OoO
         1dQ4RbzOz6pbkTfeB0WK3PC7JrQpMMkPLByBqimCV2s9g1epLNijcmYesEuTP320tf69
         StZYm2luPMAgllAQQSpglOUobSo4Wx1O+YEknSkfIltx1nSkiZfvAJ+J+cQWzBjsQ1vZ
         FzVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=XoEU3DaXUqalCs6jzwcHq5Z2kR7REX3RsrqKMfGCo2w=;
        b=ZJYXVaaYUTuYaK58mEAkIiaIuZLlNCm33ea3fP3xWcgQQpmGfwZTH7x3LQ1xyq130A
         jC9nyGlV1XZglN+O1Mdn7vXeZlqcsWJEhwA0VnS86fTAaPaoL/E4t13Zg+Hnv74F05Ny
         F6sg+yWRK1qRsz4nfNnwvOHBIgnVLIHMtf2fEcFpLBuWDs5HlC9St2OrCxRkvv/8uEt8
         vs7BnPVtfmNzKdXxlGtHtFqU13ZO7ur+ixoRThF2gxxkWois4lzZrvL9M1W2JSp2A4+S
         jhura64D1VeV4WRP7tBGTRxdmMiRBQDj9DvtFBJ9RArqfP634Dfj7hbOP7VRZncADM0G
         Es9A==
X-Gm-Message-State: AOAM533h3eyOzcCg3aglkspgac9wIj8eWFwW3NPfemyhn2aqmc9TRgDW
        jtAj+eyLztva27gCFJ+YWQg=
X-Google-Smtp-Source: ABdhPJwRwGnN2HYDLn4/ya4vANtMy2LFN1OiYbe33DChi+j/uEDELzNOeHtrWCUSzf5Mr+Zxr7NNrA==
X-Received: by 2002:a2e:8ec7:: with SMTP id e7mr8517097ljl.430.1639080343851;
        Thu, 09 Dec 2021 12:05:43 -0800 (PST)
Received: from otyshchenko.router ([212.22.223.21])
        by smtp.gmail.com with ESMTPSA id o12sm87371lft.134.2021.12.09.12.05.42
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 Dec 2021 12:05:42 -0800 (PST)
From:   Oleksandr Tyshchenko <olekstysh@gmail.com>
To:     xen-devel@lists.xenproject.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Julien Grall <julien@xen.org>
Subject: [PATCH V4 2/6] arm/xen: Switch to use gnttab_setup_auto_xlat_frames() for DT
Date:   Thu,  9 Dec 2021 22:05:32 +0200
Message-Id: <1639080336-26573-3-git-send-email-olekstysh@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1639080336-26573-1-git-send-email-olekstysh@gmail.com>
References: <1639080336-26573-1-git-send-email-olekstysh@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>

Read the start address of the grant table space from DT
(region 0).

This patch mostly restores behaviour before commit 3cf4095d7446
("arm/xen: Use xen_xlate_map_ballooned_pages to setup grant table")
but trying not to break the ACPI support added after that commit.
So the patch touches DT part only and leaves the ACPI part with
xen_xlate_map_ballooned_pages(). Also in order to make a code more
resilient use a fallback to xen_xlate_map_ballooned_pages() if grant
table region wasn't found.

This is a preparation for using Xen extended region feature
where unused regions of guest physical address space (provided
by the hypervisor) will be used to create grant/foreign/whatever
mappings instead of wasting real RAM pages from the domain memory
for establishing these mappings.

The immediate benefit of this change:
- Avoid superpage shattering in Xen P2M when establishing
  stage-2 mapping (GFN <-> MFN) for the grant table space
- Avoid wasting real RAM pages (reducing the amount of memory
  usuable) for mapping grant table space
- The grant table space is always mapped at the exact
  same place (region 0 is reserved for the grant table)

Signed-off-by: Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>
Reviewed-by: Stefano Stabellini <sstabellini@kernel.org>
---
Changes RFC -> V2:
   - new patch

Changes V2 -> V3:
   - add __read_mostly specifier to xen_grant_frames
   - retain a fallback to xen_xlate_map_ballooned_pages() if
     xen_grant_frames is invalid
   - process xen_events_irq before xen_grant_frames in
     xen_dt_guest_init()
   - update patch description

Changes V3 -> V4:
   - add Stefano's R-b
   - remove first condition in "if (!acpi_disabled || !xen_grant_frames)"
---
 arch/arm/xen/enlighten.c | 26 ++++++++++++++++++++------
 1 file changed, 20 insertions(+), 6 deletions(-)

diff --git a/arch/arm/xen/enlighten.c b/arch/arm/xen/enlighten.c
index 7619fbf..49bb675 100644
--- a/arch/arm/xen/enlighten.c
+++ b/arch/arm/xen/enlighten.c
@@ -59,6 +59,9 @@ unsigned long xen_released_pages;
 struct xen_memory_region xen_extra_mem[XEN_EXTRA_MEM_MAX_REGIONS] __initdata;
 
 static __read_mostly unsigned int xen_events_irq;
+static __read_mostly phys_addr_t xen_grant_frames;
+
+#define GRANT_TABLE_INDEX   0
 
 uint32_t xen_start_flags;
 EXPORT_SYMBOL(xen_start_flags);
@@ -303,6 +306,7 @@ static void __init xen_acpi_guest_init(void)
 static void __init xen_dt_guest_init(void)
 {
 	struct device_node *xen_node;
+	struct resource res;
 
 	xen_node = of_find_compatible_node(NULL, NULL, "xen,xen");
 	if (!xen_node) {
@@ -311,13 +315,19 @@ static void __init xen_dt_guest_init(void)
 	}
 
 	xen_events_irq = irq_of_parse_and_map(xen_node, 0);
+
+	if (of_address_to_resource(xen_node, GRANT_TABLE_INDEX, &res)) {
+		pr_err("Xen grant table region is not found\n");
+		return;
+	}
+	xen_grant_frames = res.start;
 }
 
 static int __init xen_guest_init(void)
 {
 	struct xen_add_to_physmap xatp;
 	struct shared_info *shared_info_page = NULL;
-	int cpu;
+	int rc, cpu;
 
 	if (!xen_domain())
 		return 0;
@@ -370,12 +380,16 @@ static int __init xen_guest_init(void)
 	for_each_possible_cpu(cpu)
 		per_cpu(xen_vcpu_id, cpu) = cpu;
 
-	xen_auto_xlat_grant_frames.count = gnttab_max_grant_frames();
-	if (xen_xlate_map_ballooned_pages(&xen_auto_xlat_grant_frames.pfn,
-					  &xen_auto_xlat_grant_frames.vaddr,
-					  xen_auto_xlat_grant_frames.count)) {
+	if (!xen_grant_frames) {
+		xen_auto_xlat_grant_frames.count = gnttab_max_grant_frames();
+		rc = xen_xlate_map_ballooned_pages(&xen_auto_xlat_grant_frames.pfn,
+										   &xen_auto_xlat_grant_frames.vaddr,
+										   xen_auto_xlat_grant_frames.count);
+	} else
+		rc = gnttab_setup_auto_xlat_frames(xen_grant_frames);
+	if (rc) {
 		free_percpu(xen_vcpu_info);
-		return -ENOMEM;
+		return rc;
 	}
 	gnttab_init();
 
-- 
2.7.4

