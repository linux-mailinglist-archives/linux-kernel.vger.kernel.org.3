Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 710FF588F48
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 17:22:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238063AbiHCPWC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 11:22:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237975AbiHCPV7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 11:21:59 -0400
Received: from smtp-fw-2101.amazon.com (smtp-fw-2101.amazon.com [72.21.196.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B8E915FD1
        for <linux-kernel@vger.kernel.org>; Wed,  3 Aug 2022 08:21:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.es; i=@amazon.es; q=dns/txt; s=amazon201209;
  t=1659540119; x=1691076119;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=0w6Aj53uYQICj9JmJPMn2zyturgexKq0X4gR7kE9k/o=;
  b=icS5C/xJn4H87XmHL6D36yuq22TVC3MDeFK+RGQgu2Ku+6LhwVRE3VOE
   gr8xGioG9DPY+dyCl+xOtdc71W+lERkmOdPwirZfVnhNfis+yA+m4MJU5
   44+GyBrZcMuC4Jdt3RnGM0lfsFMt2NH+vVPL9e010MaNWP9t5pXVHLkzk
   k=;
X-IronPort-AV: E=Sophos;i="5.93,214,1654560000"; 
   d="scan'208";a="225451174"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-pdx-2b-2520d768.us-west-2.amazon.com) ([10.43.8.6])
  by smtp-border-fw-2101.iad2.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2022 15:21:47 +0000
Received: from EX13D37EUA003.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan3.pdx.amazon.com [10.236.137.198])
        by email-inbound-relay-pdx-2b-2520d768.us-west-2.amazon.com (Postfix) with ESMTPS id 38B43449FF;
        Wed,  3 Aug 2022 15:21:46 +0000 (UTC)
Received: from f4d4887fdcfb.ant.amazon.com (10.43.162.134) by
 EX13D37EUA003.ant.amazon.com (10.43.165.7) with Microsoft SMTP Server (TLS)
 id 15.0.1497.36; Wed, 3 Aug 2022 15:21:41 +0000
From:   <bchalios@amazon.es>
To:     <linux-kernel@vger.kernel.org>
CC:     <bchalios@amazon.es>, <tytso@mit.edu>, <Jason@zx2c4.com>,
        <dwmw@amazon.co.uk>, <graf@amazon.de>, <xmarcalx@amazon.co.uk>,
        <gregkh@linuxfoundation.org>
Subject: [PATCH 1/2] virt: vmgenid: add helper function to parse ADDR
Date:   Wed, 3 Aug 2022 17:21:26 +0200
Message-ID: <20220803152127.48281-2-bchalios@amazon.es>
X-Mailer: git-send-email 2.32.1 (Apple Git-133)
In-Reply-To: <20220803152127.48281-1-bchalios@amazon.es>
References: <20220803152127.48281-1-bchalios@amazon.es>
MIME-Version: 1.0
X-Originating-IP: [10.43.162.134]
X-ClientProxiedBy: EX13D07UWB003.ant.amazon.com (10.43.161.66) To
 EX13D37EUA003.ant.amazon.com (10.43.165.7)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Babis Chalios <bchalios@amazon.es>

Add a helper function to parse the objects of the vmgenid device and use
it to parse the "ADDR" object and return the physical address of vmgenid
data. This prepares the code for adding support for an extra object
including the address of a vmgenid generation counter.

Signed-off-by: Babis Chalios <bchalios@amazon.es>
---
 drivers/virt/vmgenid.c | 50 ++++++++++++++++++++++++++----------------
 1 file changed, 31 insertions(+), 19 deletions(-)

diff --git a/drivers/virt/vmgenid.c b/drivers/virt/vmgenid.c
index a1c467a0e..0cc2fe0f4 100644
--- a/drivers/virt/vmgenid.c
+++ b/drivers/virt/vmgenid.c
@@ -21,24 +21,20 @@ struct vmgenid_state {
 	u8 this_id[VMGENID_SIZE];
 };
 
-static int vmgenid_add(struct acpi_device *device)
+static int parse_vmgenid_address(struct acpi_device *device, acpi_string object_name,
+		phys_addr_t *phys_addr)
 {
 	struct acpi_buffer parsed = { ACPI_ALLOCATE_BUFFER };
-	struct vmgenid_state *state;
-	union acpi_object *obj;
-	phys_addr_t phys_addr;
 	acpi_status status;
+	union acpi_object *obj;
 	int ret = 0;
 
-	state = devm_kmalloc(&device->dev, sizeof(*state), GFP_KERNEL);
-	if (!state)
-		return -ENOMEM;
-
-	status = acpi_evaluate_object(device->handle, "ADDR", NULL, &parsed);
+	status = acpi_evaluate_object(device->handle, object_name, NULL, &parsed);
 	if (ACPI_FAILURE(status)) {
-		ACPI_EXCEPTION((AE_INFO, status, "Evaluating ADDR"));
+		ACPI_EXCEPTION((AE_INFO, status, "Evaluating vmgenid object"));
 		return -ENODEV;
 	}
+
 	obj = parsed.pointer;
 	if (!obj || obj->type != ACPI_TYPE_PACKAGE || obj->package.count != 2 ||
 	    obj->package.elements[0].type != ACPI_TYPE_INTEGER ||
@@ -47,22 +43,38 @@ static int vmgenid_add(struct acpi_device *device)
 		goto out;
 	}
 
-	phys_addr = (obj->package.elements[0].integer.value << 0) |
-		    (obj->package.elements[1].integer.value << 32);
+	*phys_addr = (obj->package.elements[0].integer.value << 0) |
+		     (obj->package.elements[1].integer.value << 32);
+
+out:
+	ACPI_FREE(parsed.pointer);
+	return ret;
+}
+
+static int vmgenid_add(struct acpi_device *device)
+{
+	struct vmgenid_state *state;
+	phys_addr_t phys_addr;
+	int ret;
+
+	state = devm_kmalloc(&device->dev, sizeof(*state), GFP_KERNEL);
+	if (!state)
+		return -ENOMEM;
+
+	ret = parse_vmgenid_address(device, "ADDR", &phys_addr);
+	if (ret)
+		return ret;
+
 	state->next_id = devm_memremap(&device->dev, phys_addr, VMGENID_SIZE, MEMREMAP_WB);
-	if (IS_ERR(state->next_id)) {
-		ret = PTR_ERR(state->next_id);
-		goto out;
-	}
+	if (IS_ERR(state->next_id))
+		return PTR_ERR(state->next_id);
 
 	memcpy(state->this_id, state->next_id, sizeof(state->this_id));
 	add_device_randomness(state->this_id, sizeof(state->this_id));
 
 	device->driver_data = state;
 
-out:
-	ACPI_FREE(parsed.pointer);
-	return ret;
+	return 0;
 }
 
 static void vmgenid_notify(struct acpi_device *device, u32 event)
-- 
2.32.1 (Apple Git-133)

Amazon Spain Services sociedad limitada unipersonal, Calle Ramirez de Prado 5, 28045 Madrid. Registro Mercantil de Madrid . Tomo 22458 . Folio 102 . Hoja M-401234 . CIF B84570936

