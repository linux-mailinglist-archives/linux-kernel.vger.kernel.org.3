Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C11795A78CF
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 10:19:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231383AbiHaITT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 04:19:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231548AbiHaISj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 04:18:39 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76C42C650F;
        Wed, 31 Aug 2022 01:17:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=emhaj+U3ItD2FsoUb8T2W649Lt0tbuAkv6L/NTTS3lKFcIFe2BwW4J5nl/D6B7bqnw5xC2AX+NZ4BpkZaK0WXsesJSSTvYXFT3RGubXkBGB3rjF4J8gMx8wNYDwFK2sIeZO1Btpin9GqMluySCMs1IdnnRscGbHIjzviIEDKGYfxlxzhiXdc8Mc1ug07WGYlSMFiwRPO/8RPHEiAt28xHfUGMryRCtHVTxcaxQ3MPApTW5lzqBcl5Y4Aii+CVilOQEXoZwe2A/qTMNEaWNCDSnnWTtAAhB6B87yWwlENk/OC82bYZZ+jdiyR3Rrkk9H+0QPns2mOA5fSE7BDik5/mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zM143r0hLso7D2Wup38yeyCHmpqUSbqxvkXNLlj+lqI=;
 b=E1te9WJF8J62wFXCfzSqq7YDpMWVPhbBS6Wow+YvCFrsFLzFDnY1w9LoyTFyMt7eik+EUGJg6SnJFgMG+KwJk3XGRgtmW/z6gWy7n6617UmjF01uxec85woij9DJDyqdk75MfcMbN+QF+9sv8Tbki8cVuovBNQC33sR6u1lyouU7VtTg8NNXMYi8BqS4UVdZRm53H3cifnGeLyCGymB3kb+tIpE3R65sE+lFcItfll4x4NR2IPCCZLYJd5swZEnrvxmpWWpdvxVA8tL+Ad8KAMBykg7KfDC9N90AmHM6y9HeI0Dr4Iub2xLHC6oAuMyt+eDpd+BRJ6SpNoiC0P6sXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zM143r0hLso7D2Wup38yeyCHmpqUSbqxvkXNLlj+lqI=;
 b=FDnckVyO4eB9Rvd4MJczFJJYbIcLtP6RB6MRDZouO1AdHD6waLesG6l6uktZKs1wohwQy4Bpi9+sCvFblA1rMdTFfrgDCLHXOY1Eht7ilkc+Fq8lo3pHOBLZQMfJk0o+0kyL4V5KnpPmG3Cl8JNJybNvyMTt5I8a13UafLAxFYs=
Received: from MW4PR03CA0079.namprd03.prod.outlook.com (2603:10b6:303:b6::24)
 by SJ0PR12MB5406.namprd12.prod.outlook.com (2603:10b6:a03:3ae::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.10; Wed, 31 Aug
 2022 08:17:37 +0000
Received: from CO1NAM11FT027.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b6:cafe::d9) by MW4PR03CA0079.outlook.office365.com
 (2603:10b6:303:b6::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.10 via Frontend
 Transport; Wed, 31 Aug 2022 08:17:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT027.mail.protection.outlook.com (10.13.174.224) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5588.10 via Frontend Transport; Wed, 31 Aug 2022 08:17:37 +0000
Received: from rric.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 31 Aug
 2022 03:17:16 -0500
From:   Robert Richter <rrichter@amd.com>
To:     Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>
CC:     <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>, Robert Richter <rrichter@amd.com>
Subject: [PATCH 15/15] cxl/acpi: Specify module load order dependency for the cxl_acpi module
Date:   Wed, 31 Aug 2022 10:16:03 +0200
Message-ID: <20220831081603.3415-16-rrichter@amd.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220831081603.3415-1-rrichter@amd.com>
References: <20220831081603.3415-1-rrichter@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8f78cded-e3fe-4e4e-6b37-08da8b2943d8
X-MS-TrafficTypeDiagnostic: SJ0PR12MB5406:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3BpeFaP8B3aW8FbY8Wz7Dvggn7654vE4hnJPSTnm/rC1UtF8YLF/q79vnH9m9ICOcKIxM/DA4cvcVrcCOI00HkruG/L/+pKOCw3nyQAo2faAKpHZez39Hdxo6AnHQBG2lU6zmoi+OL8gK4e3pDdRV60784qWKWibKdscYP/gVa5wEn607GOz05e5ShIlmXNCNOv+VNR8eutwqTQ5SIGSV2BESusn+7wQm+2Z5JOMGFhEDz3vljICord1YjK6RwdqWM63xfO4ck3iQIu4UKicWmiPIbFELpxzZejE0YUupAcbFpPftRXWXOCvgz83XlqhBZqeVsfp9ZbXDC2WR8VTWfP0EJaE++tiRmZ3uLVzm3GywIKCzqNZWrHGTETS7YT1x1er7BVtrg/Jq920sFRVy/DB85mGSdkfajKEX00xRRYnh6Q6WAd1ZKHvpLZoCOBpxFohE5OSSEzwwNatb6BiyqdAEuF8PElUE+Z893g/LRvVB/9uvjgodIb0hfgQslg4EU/AA07BO4jZlgMrqkQnggBLXJ8Nj8weMmSjO0Zuh4WL2YSgg602d/c8zEw/Qg7nPiiIQkl7acdwE6iNDNSGkDKRwGtk23UZU6PM99okMbKvnDcWNV3O1FnPbewN5szcoohAP4RGw78rMpStBiagEEO3C6jLz0pz/WaTEMalRiw4r45koeZZNYusiq5ZWDGSvn2vlJfkF2SHPbhq3ZN/pYp6qJjwMVFRq9GLCyVzoGySi5oasUxvywXK56mHC4kI/iSyjBWNMKA8UQyspo5YMmcPYpEIJRn+MDndYOdt7d6Hm5fFVdGteqfEUn+Q/njy
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(376002)(346002)(136003)(396003)(46966006)(40470700004)(36840700001)(83380400001)(316002)(426003)(336012)(16526019)(47076005)(186003)(1076003)(54906003)(110136005)(2616005)(8936002)(36756003)(2906002)(26005)(356005)(40460700003)(36860700001)(82310400005)(40480700001)(478600001)(70586007)(70206006)(8676002)(4326008)(41300700001)(5660300002)(7416002)(6666004)(82740400003)(81166007)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2022 08:17:37.2648
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f78cded-e3fe-4e4e-6b37-08da8b2943d8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT027.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5406
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In RCD mode the CXL mem dev may be detected on the PCI bus before a
CXL host is brought up. This may cause a CXL mem initialization
failure as it expects the CXL host already detected. Address this by
specifying the module dependencies using MODULE_SOFTDEP().

The following additional dependencies exist:

 * cxl_mem depends on cxl_acpi: The CXL hosts must be discovered
   before the CXL device is initialized.

 * cxl_acpi depends on cxl_port: The acpi driver adds ports to the cxl
   bus, the port driver should be loaded before. This might also work
   if modules are loaded in different order, but a) it aligns with the
   existing cxl_mem/cxl_port softdep and b) it always guarantees a fix
   module load order.

Signed-off-by: Robert Richter <rrichter@amd.com>
---
 drivers/cxl/acpi.c | 1 +
 drivers/cxl/mem.c  | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
index 56b2d222afcc..63a1cb295c07 100644
--- a/drivers/cxl/acpi.c
+++ b/drivers/cxl/acpi.c
@@ -834,3 +834,4 @@ module_exit(cxl_host_exit);
 MODULE_LICENSE("GPL v2");
 MODULE_IMPORT_NS(CXL);
 MODULE_IMPORT_NS(ACPI);
+MODULE_SOFTDEP("pre: cxl_port");
diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
index 64ccf053d32c..ae13ec7d9894 100644
--- a/drivers/cxl/mem.c
+++ b/drivers/cxl/mem.c
@@ -128,3 +128,4 @@ MODULE_ALIAS_CXL(CXL_DEVICE_MEMORY_EXPANDER);
  * endpoint registration.
  */
 MODULE_SOFTDEP("pre: cxl_port");
+MODULE_SOFTDEP("pre: cxl_acpi");
-- 
2.30.2

