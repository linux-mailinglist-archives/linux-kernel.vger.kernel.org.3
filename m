Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32DF04EF907
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 19:37:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350180AbiDARjO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Apr 2022 13:39:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233152AbiDARjL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 13:39:11 -0400
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED82F20A3B6;
        Fri,  1 Apr 2022 10:37:17 -0700 (PDT)
Received: from pps.filterd (m0150242.ppops.net [127.0.0.1])
        by mx0a-002e3701.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 231G9jLc018254;
        Fri, 1 Apr 2022 17:29:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pps0720;
 bh=IWEKHRJ+fTq1DXKGcxx15f9MF6DQXhL75wZkQHTjY3E=;
 b=R/kzY6m+2ynGFjiCcHxmA9rRLU980gxYvsThUIVNS2Bu6krl1dBR1oZjzO8kea97fnzR
 ibbTe6q2iQ1drncqNb7EcR+niApcWMhFj9SS1zpaPotxbUr4TDraz5SeKaIqikrucG1h
 XRR+awR53mlBgDbNCenSQdB6wUwtbzagG3fQCm5NgGfp2uIMcZV16Y/CYLNMBH72WLSA
 oZq4v59AW2AnopdC8Bpo9mUStiVFkEIf1fs0TSFjZK2qhRuC52C5/9EUmG1YMXiXnADd
 4VGP4LJjgGLw2KChTb9GXH0FVT7aWdoRCoEW6zNxmmpVHa5Pi1b4b3S2v1wY68StwZQR jA== 
Received: from g4t3427.houston.hpe.com (g4t3427.houston.hpe.com [15.241.140.73])
        by mx0a-002e3701.pphosted.com (PPS) with ESMTPS id 3f60uptts7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 01 Apr 2022 17:29:08 +0000
Received: from g4t3433.houston.hpecorp.net (g4t3433.houston.hpecorp.net [16.208.49.245])
        by g4t3427.houston.hpe.com (Postfix) with ESMTP id 8898357;
        Fri,  1 Apr 2022 17:29:07 +0000 (UTC)
Received: from ubuntu-20.04.3 (unknown [16.116.198.225])
        by g4t3433.houston.hpecorp.net (Postfix) with ESMTP id 47D994B;
        Fri,  1 Apr 2022 17:29:05 +0000 (UTC)
From:   james.liu@hpe.com
To:     rafael@kernel.org, lenb@kernel.org
Cc:     linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        rwright@hpe.com, david.chang@hpe.co, clayc@hpe.com,
        james.liu@hpe.com
Subject: [PATCH]     ACPI: OSL: Fix the memory mapping of an ACPI GAS that addresses a data structure
Date:   Fri,  1 Apr 2022 17:28:40 +0000
Message-Id: <20220401172840.1252-1-james.liu@hpe.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 8n1cIHgXF3AJkwOoNdF5kd7vptPv2_rX
X-Proofpoint-ORIG-GUID: 8n1cIHgXF3AJkwOoNdF5kd7vptPv2_rX
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.850,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-04-01_05,2022-03-31_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 suspectscore=0
 adultscore=0 priorityscore=1501 mlxlogscore=955 mlxscore=0 spamscore=0
 bulkscore=0 phishscore=0 impostorscore=0 malwarescore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2204010083
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: James Liu <james.liu@hpe.com>

    Modify acpi_os_map_generic_address and acpi_os_unmap_generic_address
    to handle a case that a GAS table (i.e., Table 5.1 in ACPI 6.4) is used
    to address a data structure; in this case, the GAS has the field of
    "Register Bit Width" equal to 0.

    For example, "Injection Instruction Entry" (Table 18.25 in ACPI 6.4)
    has a RegisterRegion field that is a GAS that points to a data
    structure SET_ERROR_TYPE_WITH_ADDRESS (Table 18.30), which is required
    when using EINJ (Error Injection module).

    This fix preserves a fairly sufficient memory space (i.e., page size)
    to store the data structure so as to prevent EINJ module from loading
    failure if platform firmware can support Injection Instruction Entry in
    an EINJ table.

Signed-off-by: James Liu <james.liu@hpe.com>
---
 drivers/acpi/osl.c | 23 +++++++++++++++++++++--
 1 file changed, 21 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
index 45c5c0e45..ab2f584b1 100644
--- a/drivers/acpi/osl.c
+++ b/drivers/acpi/osl.c
@@ -457,9 +457,15 @@ void __iomem *acpi_os_map_generic_address(struct acpi_generic_address *gas)
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
@@ -474,9 +480,22 @@ void acpi_os_unmap_generic_address(struct acpi_generic_address *gas)
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

