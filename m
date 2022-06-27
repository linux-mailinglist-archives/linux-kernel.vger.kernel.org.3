Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 139C755E1DE
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:34:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234547AbiF0M4I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 08:56:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234185AbiF0Mzx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 08:55:53 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3FD19D129
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 05:55:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656334549;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=OVZ/LcnMWPN7fhBcYyaEBqrNmBX9SmIqzRP+nADepog=;
        b=NBX7rF2okUC7SF4c8gUNEAp5jFyDvn3vM7QgjaPWG53mCWozb/lTzLhAMQcs/h48+qzgCb
        MuQqy/+FjfM/Pl+LA4Ahr29u8MIzpdoL5wvYxVorzukarEX2iD++a98dGpVZ2HVH/9DV4a
        32WWTy0MNEIo3meNDgCcumUdS4Gvt/M=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-346-iOyWrtXrNTa1LhoQCw5lWQ-1; Mon, 27 Jun 2022 08:55:47 -0400
X-MC-Unique: iOyWrtXrNTa1LhoQCw5lWQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 61B6E2806AAF;
        Mon, 27 Jun 2022 12:55:47 +0000 (UTC)
Received: from laptop.redhat.com (unknown [10.39.193.10])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7DBDA18EAA;
        Mon, 27 Jun 2022 12:55:45 +0000 (UTC)
From:   Eric Auger <eric.auger@redhat.com>
To:     eric.auger.pro@gmail.com, eric.auger@redhat.com,
        jean-philippe@linaro.org, jroedel@suse.de,
        linux-acpi@vger.kernel.org, iommu@lists.linux-foundation.org,
        rafael@kernel.org, lenb@kernel.org
Cc:     linux-kernel@vger.kernel.org, iommu@lists.linux.dev
Subject: [PATCH] ACPI: VIOT: Fix ACS setup
Date:   Mon, 27 Jun 2022 14:55:34 +0200
Message-Id: <20220627125534.1035912-1-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently acpi_viot_init() gets called after the pci
device has been scanned and pci_enable_acs() has been called.
So pci_request_acs() fails to be taken into account leading
to wrong single iommu group topologies when dealing with
multi-function root ports for instance.

We cannot simply move the acpi_viot_init() earlier, similarly
as the IORT init because the VIOT parsing relies on the pci
scan. However we can detect VIOT is present earlier and in
such a case, request ACS. Introduce a new acpi_viot_early_init()
routine that allows to call pci_request_acs() before the scan.

Fixes: 3cf485540e7b ("ACPI: Add driver for the VIOT table")
Signed-off-by: Eric Auger <eric.auger@redhat.com>
Reported-by: Jin Liu <jinl@redhat.com>
---
 drivers/acpi/bus.c        |  1 +
 drivers/acpi/viot.c       | 23 +++++++++++++++++------
 include/linux/acpi_viot.h |  2 ++
 3 files changed, 20 insertions(+), 6 deletions(-)

diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
index 86fa61a21826..906ad8153fd9 100644
--- a/drivers/acpi/bus.c
+++ b/drivers/acpi/bus.c
@@ -1400,6 +1400,7 @@ static int __init acpi_init(void)
 
 	pci_mmcfg_late_init();
 	acpi_iort_init();
+	acpi_viot_early_init();
 	acpi_hest_init();
 	acpi_ghes_init();
 	acpi_scan_init();
diff --git a/drivers/acpi/viot.c b/drivers/acpi/viot.c
index d2256326c73a..3c1be123e4d6 100644
--- a/drivers/acpi/viot.c
+++ b/drivers/acpi/viot.c
@@ -248,6 +248,23 @@ static int __init viot_parse_node(const struct acpi_viot_header *hdr)
 	return ret;
 }
 
+/**
+ * acpi_viot_early_init - Test the presence of VIOT and enable ACS
+ *
+ * If the VIOT does exist, ACS must be enabled. This cannot be
+ * done in acpi_viot_init() which is called after the bus scan
+ */
+void __init acpi_viot_early_init(void)
+{
+	acpi_status status;
+	struct acpi_table_header *hdr;
+
+	status = acpi_get_table(ACPI_SIG_VIOT, 0, &hdr);
+	if (!ACPI_FAILURE(status))
+		pci_request_acs();
+	acpi_put_table(hdr);
+}
+
 /**
  * acpi_viot_init - Parse the VIOT table
  *
@@ -319,12 +336,6 @@ static int viot_pci_dev_iommu_init(struct pci_dev *pdev, u16 dev_id, void *data)
 			epid = ((domain_nr - ep->segment_start) << 16) +
 				dev_id - ep->bdf_start + ep->endpoint_id;
 
-			/*
-			 * If we found a PCI range managed by the viommu, we're
-			 * the one that has to request ACS.
-			 */
-			pci_request_acs();
-
 			return viot_dev_iommu_init(&pdev->dev, ep->viommu,
 						   epid);
 		}
diff --git a/include/linux/acpi_viot.h b/include/linux/acpi_viot.h
index 1eb8ee5b0e5f..e58d60f8ff2e 100644
--- a/include/linux/acpi_viot.h
+++ b/include/linux/acpi_viot.h
@@ -6,10 +6,12 @@
 #include <linux/acpi.h>
 
 #ifdef CONFIG_ACPI_VIOT
+void __init acpi_viot_early_init(void);
 void __init acpi_viot_init(void);
 int viot_iommu_configure(struct device *dev);
 #else
 static inline void acpi_viot_init(void) {}
+static inline void acpi_viot_early_init(void) {}
 static inline int viot_iommu_configure(struct device *dev)
 {
 	return -ENODEV;
-- 
2.35.3

