Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C094D476E6C
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 10:59:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233625AbhLPJ6p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 04:58:45 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:53020 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230155AbhLPJ6o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 04:58:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639648724;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=2f+bwQ9A8rkOTgyO9IFV+HcP21W3Lh3xDiL5aWysAWI=;
        b=FLSWfqkGyKGMCzOjFseOsRdtktdKQ0Xa5/ydtks15EpyuGyXiFKGa4wQa9AxQItrlpc4Op
        bRNj1lN2T9kAcPR2MRV8c/m6AX2BJvmsr0dQIDGffD7XBkIgYaTF1tQhS0jQ3qiwZ7hMGu
        tBmrBZp6ILhFgXYhevBDjroWmu+k8uY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-327-ZVZMLZbWPui4OMDFzmwJeQ-1; Thu, 16 Dec 2021 04:58:41 -0500
X-MC-Unique: ZVZMLZbWPui4OMDFzmwJeQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D916581CCB8;
        Thu, 16 Dec 2021 09:58:39 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.40.195.160])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5935410A48AD;
        Thu, 16 Dec 2021 09:58:27 +0000 (UTC)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     linux-acpi@vger.kernel.org
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Huacai Chen <chenhuacai@kernel.org>,
        Igor Mammedov <imammedo@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] ACPI: NUMA: Process hotpluggable memblocks when !CONFIG_MEMORY_HOTPLUG
Date:   Thu, 16 Dec 2021 10:58:26 +0100
Message-Id: <20211216095826.297912-1-vkuznets@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some systems (e.g. Hyper-V guests) have all their memory marked as
hotpluggable in SRAT. acpi_numa_memory_affinity_init(), however,
ignores all such regions when !CONFIG_MEMORY_HOTPLUG and this is
unfortunate as memory affinity (NUMA) information gets lost.

'Hot Pluggable' flag in SRAT only means that "system hardware supports
hot-add and hot-remove of this memory region", it doesn't prevent
memory from being cold-plugged there.

Ignore 'Hot Pluggable' bit instead of skipping the whole memory
affinity information when !CONFIG_MEMORY_HOTPLUG.

Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
---
 drivers/acpi/numa/srat.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/numa/srat.c b/drivers/acpi/numa/srat.c
index b8795fc49097..6c884f3e8332 100644
--- a/drivers/acpi/numa/srat.c
+++ b/drivers/acpi/numa/srat.c
@@ -254,9 +254,8 @@ acpi_numa_memory_affinity_init(struct acpi_srat_mem_affinity *ma)
 	}
 	if ((ma->flags & ACPI_SRAT_MEM_ENABLED) == 0)
 		goto out_err;
-	hotpluggable = ma->flags & ACPI_SRAT_MEM_HOT_PLUGGABLE;
-	if (hotpluggable && !IS_ENABLED(CONFIG_MEMORY_HOTPLUG))
-		goto out_err;
+	hotpluggable = IS_ENABLED(CONFIG_MEMORY_HOTPLUG) &&
+		(ma->flags & ACPI_SRAT_MEM_HOT_PLUGGABLE);
 
 	start = ma->base_address;
 	end = start + ma->length;
-- 
2.33.1

