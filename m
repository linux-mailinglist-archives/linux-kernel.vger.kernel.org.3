Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B0F254C3F2
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 10:49:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346398AbiFOIst (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 04:48:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346722AbiFOIsk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 04:48:40 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 009FD33373;
        Wed, 15 Jun 2022 01:48:37 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id A97B721C37;
        Wed, 15 Jun 2022 08:48:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1655282916; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=iIBkW7Vwr7SXxDUNu3qaCisr7ig2aybwnHdNAbRTR4E=;
        b=htosqkbsQ1Cd4ZgHAGpw3up4szZoT77TjUmHY/iCSCLPrwGrVG8o905OCfwtFbYrBTkZp5
        Kd9h+RB5YxM+NXcBIe0ztc9PUF6a0CSkOVYW3jpSTMG0/CCRVUpkMiilgaiMNaAbZ86VNo
        NL2/VDfud72k6e7+qCMEUC+swXeC1jE=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 703CF13A35;
        Wed, 15 Jun 2022 08:48:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id vL3yGeScqWJaLQAAMHmgww
        (envelope-from <jgross@suse.com>); Wed, 15 Jun 2022 08:48:36 +0000
From:   Juergen Gross <jgross@suse.com>
To:     xen-devel@lists.xenproject.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Juergen Gross <jgross@suse.com>, Jonathan Corbet <corbet@lwn.net>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>
Subject: [PATCH] xen: don't require virtio with grants for non-PV guests
Date:   Wed, 15 Jun 2022 10:48:35 +0200
Message-Id: <20220615084835.27113-1-jgross@suse.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit fa1f57421e0b ("xen/virtio: Enable restricted memory access using
Xen grant mappings") introduced a new requirement for using virtio
devices: the backend now needs to support the VIRTIO_F_ACCESS_PLATFORM
feature.

This is an undue requirement for non-PV guests, as those can be operated
with existing backends without any problem, as long as those backends
are running in dom0.

Per default allow virtio devices without grant support for non-PV
guests.

The setting can be overridden by using the new "xen_virtio_grant"
command line parameter.

Add a new config item to always force use of grants for virtio.

Fixes: fa1f57421e0b ("xen/virtio: Enable restricted memory access using Xen grant mappings")
Signed-off-by: Juergen Gross <jgross@suse.com>
---
 .../admin-guide/kernel-parameters.txt         |  6 +++++
 drivers/xen/Kconfig                           |  9 ++++++++
 drivers/xen/grant-dma-ops.c                   | 22 +++++++++++++++++++
 include/xen/xen.h                             | 12 +++++-----
 4 files changed, 42 insertions(+), 7 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 8090130b544b..7960480c6fe4 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -6695,6 +6695,12 @@
 			improve timer resolution at the expense of processing
 			more timer interrupts.
 
+	xen_virtio_grant= [XEN]
+			Control whether virtio devices are required to use
+			grants when running as a Xen guest. The default is
+			"yes" for PV guests or when the kernel has been built
+			with CONFIG_XEN_VIRTIO_FORCE_GRANT set.
+
 	xen.balloon_boot_timeout= [XEN]
 			The time (in seconds) to wait before giving up to boot
 			in case initial ballooning fails to free enough memory.
diff --git a/drivers/xen/Kconfig b/drivers/xen/Kconfig
index bfd5f4f706bc..a65bd92121a5 100644
--- a/drivers/xen/Kconfig
+++ b/drivers/xen/Kconfig
@@ -355,4 +355,13 @@ config XEN_VIRTIO
 
 	  If in doubt, say n.
 
+config XEN_VIRTIO_FORCE_GRANT
+	bool "Require Xen virtio support to use grants"
+	depends on XEN_VIRTIO
+	help
+	  Require virtio for Xen guests to use grant mappings.
+	  This will avoid the need to give the backend the right to map all
+	  of the guest memory. This will need support on the backend side
+	  (e.g. qemu or kernel, depending on the virtio device types used).
+
 endmenu
diff --git a/drivers/xen/grant-dma-ops.c b/drivers/xen/grant-dma-ops.c
index fc0142484001..d1fae789dfad 100644
--- a/drivers/xen/grant-dma-ops.c
+++ b/drivers/xen/grant-dma-ops.c
@@ -11,6 +11,7 @@
 #include <linux/dma-map-ops.h>
 #include <linux/of.h>
 #include <linux/pfn.h>
+#include <linux/platform-feature.h>
 #include <linux/xarray.h>
 #include <xen/xen.h>
 #include <xen/xen-ops.h>
@@ -27,6 +28,27 @@ static DEFINE_XARRAY(xen_grant_dma_devices);
 
 #define XEN_GRANT_DMA_ADDR_OFF	(1ULL << 63)
 
+static bool __initdata xen_virtio_grants;
+static bool __initdata xen_virtio_grants_set;
+static __init int parse_use_grants(char *arg)
+{
+	if (!strcmp(arg, "yes"))
+		xen_virtio_grants = true;
+	else if (!strcmp(arg, "no"))
+		xen_virtio_grants = false;
+	xen_virtio_grants_set = true;
+
+	return 0;
+}
+early_param("xen_virtio_grant", parse_use_grants);
+
+void xen_set_restricted_virtio_memory_access(void)
+{
+	if (IS_ENABLED(CONFIG_XEN_VIRTIO_FORCE_GRANT) || xen_virtio_grants ||
+	    (!xen_virtio_grants_set && xen_pv_domain()))
+		platform_set(PLATFORM_VIRTIO_RESTRICTED_MEM_ACCESS);
+}
+
 static inline dma_addr_t grant_to_dma(grant_ref_t grant)
 {
 	return XEN_GRANT_DMA_ADDR_OFF | ((dma_addr_t)grant << PAGE_SHIFT);
diff --git a/include/xen/xen.h b/include/xen/xen.h
index 0780a81e140d..e0b1d534366f 100644
--- a/include/xen/xen.h
+++ b/include/xen/xen.h
@@ -52,13 +52,11 @@ bool xen_biovec_phys_mergeable(const struct bio_vec *vec1,
 extern u64 xen_saved_max_mem_size;
 #endif
 
-#include <linux/platform-feature.h>
-
-static inline void xen_set_restricted_virtio_memory_access(void)
-{
-	if (IS_ENABLED(CONFIG_XEN_VIRTIO) && xen_domain())
-		platform_set(PLATFORM_VIRTIO_RESTRICTED_MEM_ACCESS);
-}
+#ifdef CONFIG_XEN_GRANT_DMA_OPS
+void xen_set_restricted_virtio_memory_access(void);
+#else
+static inline void xen_set_restricted_virtio_memory_access(void) { }
+#endif
 
 #ifdef CONFIG_XEN_UNPOPULATED_ALLOC
 int xen_alloc_unpopulated_pages(unsigned int nr_pages, struct page **pages);
-- 
2.35.3

