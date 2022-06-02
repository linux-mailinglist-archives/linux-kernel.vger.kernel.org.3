Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECDA853BEBF
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 21:25:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238591AbiFBTYf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 15:24:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238539AbiFBTYX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 15:24:23 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54501CE4
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jun 2022 12:24:22 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id s12so4610515ejx.3
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jun 2022 12:24:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=vx2kLvIZS2juZNk5FVfsvDVXqGt8DgrAljecfWnEYWc=;
        b=dJJZFFwM4qaW1Hz4dYQgCfKswqdA9aOKawg49H4QWfa1bpfs3bSdZPuAxn/Xlr/1S0
         udjnMGecRU2bFne+nBMM8u5UDXRnNfywbI2TyTkY8otdiVk2aQjOq4BQmwbkJSJ3L7S1
         jwaMwvMxLCxk8leL7XwK0V5JvtOeksJ0PrbA3kniJymeTZP0TBCUJHLEOGpfIh4ex5Zb
         znL91zrw0l+8zPhwEWoiplmzqptkYlU8bd4N/Kot4q9ALGcez+a6AsMGXTf/vNe2P9Ip
         nFE1N1MwvX1kJfSwjfnr1NTJJ7xhp9xOVpXwjExSAy9XIGsJdoe4MxqN5eEv9PvhmaB7
         gKMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=vx2kLvIZS2juZNk5FVfsvDVXqGt8DgrAljecfWnEYWc=;
        b=ecR9rXNVIUTOP0MNLttWlvov2732s1O6DIAudf6xMwpfQb5q44stqNN8tOjIClxaAx
         5qk9ngjYaPyjjtp5UC2TmwcLYG0UXbDzAVjcksh9CCs/y51pUxEy6UVP1e30mtKGIwnv
         qT4hx6g4OhTQGo9dxOeKl1YkBsLXbAOgco8aX7JT+ZFcasYHa44/K0w8aVtNyMh7s17V
         T7WiOrTm55MZT8iNoCLmyY6VSH9CiGxOXTrwp6iKjaeOO1CihI8cOXPeGdmO/Q919itj
         C2idPNf173x7D33SlG2TnHDSrfCohJEUoYmWkdKd2vE0fPm2c95RuOaVjsznw+ObH+MK
         HT+A==
X-Gm-Message-State: AOAM532UDRKYIv1pWhgbAmxj4jnKmVhmxkW3sQGuk03vwUfEh9MIEw1l
        CTrGJzNP6ADvAPgTWkPjeWM=
X-Google-Smtp-Source: ABdhPJyBS8TsE8u/9Wi3VTZm5zZNB5OZHRxuUlBCbPVvVOS3nqruK/+dbbz+8v2AJMH8brXw7F7JaA==
X-Received: by 2002:a17:907:1b24:b0:6ff:235c:2ffd with SMTP id mp36-20020a1709071b2400b006ff235c2ffdmr5887568ejc.116.1654197860794;
        Thu, 02 Jun 2022 12:24:20 -0700 (PDT)
Received: from otyshchenko.router ([212.22.223.21])
        by smtp.gmail.com with ESMTPSA id eg13-20020a056402288d00b0042dce73168csm2938301edb.13.2022.06.02.12.24.19
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 Jun 2022 12:24:20 -0700 (PDT)
From:   Oleksandr Tyshchenko <olekstysh@gmail.com>
To:     xen-devel@lists.xenproject.org, x86@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Juergen Gross <jgross@suse.com>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Julien Grall <julien@xen.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Christoph Hellwig <hch@infradead.org>
Subject: [PATCH V4 4/8] xen/virtio: Enable restricted memory access using Xen grant mappings
Date:   Thu,  2 Jun 2022 22:23:49 +0300
Message-Id: <1654197833-25362-5-git-send-email-olekstysh@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1654197833-25362-1-git-send-email-olekstysh@gmail.com>
References: <1654197833-25362-1-git-send-email-olekstysh@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Juergen Gross <jgross@suse.com>

In order to support virtio in Xen guests add a config option XEN_VIRTIO
enabling the user to specify whether in all Xen guests virtio should
be able to access memory via Xen grant mappings only on the host side.

Also set PLATFORM_VIRTIO_RESTRICTED_MEM_ACCESS feature from the guest
initialization code on Arm and x86 if CONFIG_XEN_VIRTIO is enabled.

Signed-off-by: Juergen Gross <jgross@suse.com>
Signed-off-by: Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>
Reviewed-by: Stefano Stabellini <sstabellini@kernel.org>
Reviewed-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>
---
Changes V1 -> V2:
   - new patch, split required changes from commit:
    "[PATCH V1 3/6] xen/virtio: Add option to restrict memory access under Xen"
   - rework according to new platform_has() infrastructure

Changes V2 -> V3:
   - add Stefano's R-b

Changes V3 -> V4:
   - add Boris' R-b
---
 arch/arm/xen/enlighten.c     |  2 ++
 arch/x86/xen/enlighten_hvm.c |  2 ++
 arch/x86/xen/enlighten_pv.c  |  2 ++
 drivers/xen/Kconfig          | 11 +++++++++++
 include/xen/xen.h            |  8 ++++++++
 5 files changed, 25 insertions(+)

diff --git a/arch/arm/xen/enlighten.c b/arch/arm/xen/enlighten.c
index 07eb69f..1f9c3ba 100644
--- a/arch/arm/xen/enlighten.c
+++ b/arch/arm/xen/enlighten.c
@@ -443,6 +443,8 @@ static int __init xen_guest_init(void)
 	if (!xen_domain())
 		return 0;
 
+	xen_set_restricted_virtio_memory_access();
+
 	if (!acpi_disabled)
 		xen_acpi_guest_init();
 	else
diff --git a/arch/x86/xen/enlighten_hvm.c b/arch/x86/xen/enlighten_hvm.c
index 517a9d8..8b71b1d 100644
--- a/arch/x86/xen/enlighten_hvm.c
+++ b/arch/x86/xen/enlighten_hvm.c
@@ -195,6 +195,8 @@ static void __init xen_hvm_guest_init(void)
 	if (xen_pv_domain())
 		return;
 
+	xen_set_restricted_virtio_memory_access();
+
 	init_hvm_pv_info();
 
 	reserve_shared_info();
diff --git a/arch/x86/xen/enlighten_pv.c b/arch/x86/xen/enlighten_pv.c
index ca85d14..30d24fe 100644
--- a/arch/x86/xen/enlighten_pv.c
+++ b/arch/x86/xen/enlighten_pv.c
@@ -108,6 +108,8 @@ static DEFINE_PER_CPU(struct tls_descs, shadow_tls_desc);
 
 static void __init xen_pv_init_platform(void)
 {
+	xen_set_restricted_virtio_memory_access();
+
 	populate_extra_pte(fix_to_virt(FIX_PARAVIRT_BOOTMAP));
 
 	set_fixmap(FIX_PARAVIRT_BOOTMAP, xen_start_info->shared_info);
diff --git a/drivers/xen/Kconfig b/drivers/xen/Kconfig
index 313a9127..a7bd8ce 100644
--- a/drivers/xen/Kconfig
+++ b/drivers/xen/Kconfig
@@ -339,4 +339,15 @@ config XEN_GRANT_DMA_OPS
 	bool
 	select DMA_OPS
 
+config XEN_VIRTIO
+	bool "Xen virtio support"
+	depends on VIRTIO
+	select XEN_GRANT_DMA_OPS
+	help
+	  Enable virtio support for running as Xen guest. Depending on the
+	  guest type this will require special support on the backend side
+	  (qemu or kernel, depending on the virtio device types used).
+
+	  If in doubt, say n.
+
 endmenu
diff --git a/include/xen/xen.h b/include/xen/xen.h
index a99bab8..0780a81 100644
--- a/include/xen/xen.h
+++ b/include/xen/xen.h
@@ -52,6 +52,14 @@ bool xen_biovec_phys_mergeable(const struct bio_vec *vec1,
 extern u64 xen_saved_max_mem_size;
 #endif
 
+#include <linux/platform-feature.h>
+
+static inline void xen_set_restricted_virtio_memory_access(void)
+{
+	if (IS_ENABLED(CONFIG_XEN_VIRTIO) && xen_domain())
+		platform_set(PLATFORM_VIRTIO_RESTRICTED_MEM_ACCESS);
+}
+
 #ifdef CONFIG_XEN_UNPOPULATED_ALLOC
 int xen_alloc_unpopulated_pages(unsigned int nr_pages, struct page **pages);
 void xen_free_unpopulated_pages(unsigned int nr_pages, struct page **pages);
-- 
2.7.4

