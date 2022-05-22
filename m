Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EDAD53064B
	for <lists+linux-kernel@lfdr.de>; Sun, 22 May 2022 23:44:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233698AbiEVVoO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 May 2022 17:44:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbiEVVoM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 May 2022 17:44:12 -0400
Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com [148.163.143.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 079C037BF4;
        Sun, 22 May 2022 14:44:10 -0700 (PDT)
Received: from pps.filterd (m0134423.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24M7rXZB005618;
        Sun, 22 May 2022 21:44:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pps0720;
 bh=aGlcc2GqZT7sFyR5O7EQRE6Or8G/wOVNNNJPdqhnb1g=;
 b=LNx6cnTyNZsU94EnbIJXZX3wMGyeLwkYfgwKEhUrRdhNBlZIYhcMx7RKicKiBdHrzSnU
 Cn2EnENshrNe1HqrEVfdP7wtg2gLbM4jGq9qigdw+PfgWRoxCqbgTLhmT9ggCP+XLjMm
 lNmXZlud0g+xA9m9RYy32O+R1VtEJhBLzJsDIzXaLUGiLzh1mKDly/y/jW4yPEGAuAom
 uFE/WAN8PTpBpcecvMmS8adr87cLaHnkbr8INhvmzzEctFwSLm6YWh4C73/XJfP3pMbP
 Fuuj+S+zNpijbvkkaH15zDM0q9g6ImcAq6g3oYwi8kGl7xilgD04NqGPbksvYKJxktsQ Rg== 
Received: from g2t2354.austin.hpe.com (g2t2354.austin.hpe.com [15.233.44.27])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3g7h6cbtft-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 22 May 2022 21:44:02 +0000
Received: from g2t2360.austin.hpecorp.net (g2t2360.austin.hpecorp.net [16.196.225.135])
        by g2t2354.austin.hpe.com (Postfix) with ESMTP id E049683;
        Sun, 22 May 2022 21:44:01 +0000 (UTC)
Received: from ubuntu-20.04.3 (unknown [16.99.181.233])
        by g2t2360.austin.hpecorp.net (Postfix) with ESMTP id E4E9F42;
        Sun, 22 May 2022 21:43:59 +0000 (UTC)
From:   james.liu@hpe.com
To:     rafael@kernel.org, lenb@kernel.org
Cc:     linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        rwright@hpe.com, david.chang@hpe.com, clayc@hpe.com,
        james.liu@hpe.com
Subject: [PATCH v2] ACPI: OSL: Fix the memory mapping of an ACPI GAS that addresses a data structure
Date:   Mon, 23 May 2022 05:43:02 +0800
Message-Id: <20220522214302.39024-1-james.liu@hpe.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: rXzbSKsVRFGGutJm2lHosWwBjVEqn7jd
X-Proofpoint-GUID: rXzbSKsVRFGGutJm2lHosWwBjVEqn7jd
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-22_11,2022-05-20_02,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 malwarescore=0 mlxlogscore=944 mlxscore=0 spamscore=0 impostorscore=0
 clxscore=1015 phishscore=0 bulkscore=0 suspectscore=0 priorityscore=1501
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2205220137
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: James Liu <james.liu@hpe.com>

    Modify acpi_os_map_generic_address() & acpi_os_unmap_generic_address()
    to correctly handle cases that a GAS table (i.e., Table 5.1, ACPI 6.4)
    is used to address a data structure; in the case, the GAS has the field
    of "Register Bit Width" equal to 0.

    For example, "Injection Instruction Entry" (Table 18.25, ACPI 6.4) has
    a RegisterRegion field that is a GAS that points to a data structure
    SET_ERROR_TYPE_WITH_ADDRESS (Table 18.30), which is required when using
    EINJ (Error Injection module).

    This fix preserves a fairly sufficient memory space (i.e. page size) to
    store the data structure to prevent EINJ module from loading failure if
    platform firmware can correctly support Injection Instruction Entry in
    an EINJ table.

Signed-off-by: James Liu <james.liu@hpe.com>
---
 drivers/acpi/osl.c | 27 +++++++++++++++++++++++----
 1 file changed, 23 insertions(+), 4 deletions(-)

diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
index 45c5c0e45..99f987c8c 100644
--- a/drivers/acpi/osl.c
+++ b/drivers/acpi/osl.c
@@ -452,14 +452,20 @@ EXPORT_SYMBOL_GPL(acpi_os_unmap_memory);
 
 void __iomem *acpi_os_map_generic_address(struct acpi_generic_address *gas)
 {
-	u64 addr;
+	u64 addr = 0;
 
 	if (gas->space_id != ACPI_ADR_SPACE_SYSTEM_MEMORY)
 		return NULL;
 
+	/* Handle a case that GAS is used to address an ACPI data structure */
+	if (!gas->bit_width) {
+		pr_info("An ACPI data structure at 0x%llx is mapped\n", addr);
+		return  acpi_os_map_iomem(addr, PAGE_SIZE);
+	}
+
 	/* Handle possible alignment issues */
 	memcpy(&addr, &gas->address, sizeof(addr));
-	if (!addr || !gas->bit_width)
+	if (!addr)
 		return NULL;
 
 	return acpi_os_map_iomem(addr, gas->bit_width / 8);
@@ -468,15 +474,28 @@ EXPORT_SYMBOL(acpi_os_map_generic_address);
 
 void acpi_os_unmap_generic_address(struct acpi_generic_address *gas)
 {
-	u64 addr;
+	u64 addr = 0;
 	struct acpi_ioremap *map;
 
 	if (gas->space_id != ACPI_ADR_SPACE_SYSTEM_MEMORY)
 		return;
 
+	/* Handle a case that GAS is used to address an ACPI data structure */
+	if (!gas->bit_width) {
+		pr_info("An ACPI data structure at 0x%llx is unmapped\n", addr);
+		mutex_lock(&acpi_ioremap_lock);
+		map = acpi_map_lookup(addr, PAGE_SIZE);
+		if (!map) {
+			mutex_unlock(&acpi_ioremap_lock);
+			return;
+		}
+		acpi_os_drop_map_ref(map);
+		mutex_unlock(&acpi_ioremap_lock);
+	}
+
 	/* Handle possible alignment issues */
 	memcpy(&addr, &gas->address, sizeof(addr));
-	if (!addr || !gas->bit_width)
+	if (!addr)
 		return;
 
 	mutex_lock(&acpi_ioremap_lock);
-- 
2.25.1

