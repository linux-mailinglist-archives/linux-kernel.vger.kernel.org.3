Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A93F74D66DC
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 17:53:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347508AbiCKQy3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 11:54:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349706AbiCKQyY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 11:54:24 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2059.outbound.protection.outlook.com [40.107.223.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59BA33ED1A;
        Fri, 11 Mar 2022 08:53:17 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iWIJOuGbfUomklQ7HsfmNF7HmwML03l8QVNcfs3bfLhX50fT3m8m2ZwCNCF1d9btTJT/Ou6f72zzbcmMsiQK75Bqo0iPdJwNbzrpyaYrBxmWa5dhGcMDUTQIjGXQCWX3EoY+aow/PNJqHygyvepKMDXkxwr0BzaxLLmd3Zq7NbEbHjWlzckGCgciHrODBk6MYJjyhEJvQwWrf+ay+OwNm3lc13vrqNODp4v3ogadsgk4BvwI14GDx3+SnhRt736L1iR/avnlgBD2udEHKrm/QWvZMKl/g04K/2vbTY5xMaxpIMgvxyCqmaEkX8Px18giBO/yQ43vgpnbQkxft+H7+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1llhpnji2qZBxGkLVyKQGenNeXDgubiBl+Vzz/hJWbc=;
 b=mweH5So9JbnvMnkNz18lUTLRGKhwtS/sg52U07sSfcLb316/+ph4F4VxAkeeQq71m1SFGpRVEZ8AyoL6rGYss3NHMTwLQXGS8+U8xezcWBxwAqe6wO5PFwBQWyXKp2KfaRujHAGvk0U65R0FNdj3vC1MtJ/55Zp6NW8fpKztr77ezDb6qLzG9N2ICuCMMu8NCbEgfDal3G748U1WvM/J8tPOo48HB6E/B0vYwoocfmbzWdJb3Vsbs8OFGDHpn2Gs5GBcl+SQOn7OZHwqrqIcb7I8gjoV5pcDUOz9zRJup5Fna4B/Tadtx2hFVgLFDpZfj1v/G6rGVTVBlz8h9LKahQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.234) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1llhpnji2qZBxGkLVyKQGenNeXDgubiBl+Vzz/hJWbc=;
 b=rmhdbsJHKmoqgZQX6Pyp4QMjyIQ6V4HSnHD2EccZwHShJ99HSoAKzKB7NqsXl2hOyfPhxG3gsdyYX8ovh1v0QoVnOv0xDL6kuA2tGh7Ckfe86jlsFJqNYNGLcVytx91Y3q9vW6iFnt0ZC3V7720i9Xx0MkGPSK7iHvpjhUBtEkRgJ2YLv8p6KbU9coFKfoQz8yHKJKaxAvfzUNMEjGIpDXAVoiR10wvxdyc+EGOisKWlEaoLlm3BoKt1uV9eejstdvO3UHbGc+6T6ISJ4ScpDXJIZzX3caYem2gTphPspZE0/EdQeH1wzZbbUk8V4MaWPDqunxPgYAOfwDbAKOPNfQ==
Received: from DM6PR03CA0020.namprd03.prod.outlook.com (2603:10b6:5:40::33) by
 BN6PR1201MB0116.namprd12.prod.outlook.com (2603:10b6:405:56::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.17; Fri, 11 Mar
 2022 16:53:15 +0000
Received: from DM6NAM11FT063.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:40:cafe::9f) by DM6PR03CA0020.outlook.office365.com
 (2603:10b6:5:40::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.22 via Frontend
 Transport; Fri, 11 Mar 2022 16:53:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.234)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.234 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.234; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.234) by
 DM6NAM11FT063.mail.protection.outlook.com (10.13.172.219) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5061.22 via Frontend Transport; Fri, 11 Mar 2022 16:53:15 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by DRHQMAIL101.nvidia.com
 (10.27.9.10) with Microsoft SMTP Server (TLS) id 15.0.1497.32; Fri, 11 Mar
 2022 16:53:14 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Fri, 11 Mar
 2022 08:53:13 -0800
Received: from moonraker.nvidia.com (10.127.8.12) by mail.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server id 15.2.986.22 via Frontend
 Transport; Fri, 11 Mar 2022 08:53:12 -0800
From:   Jon Hunter <jonathanh@nvidia.com>
To:     "Rafael J . Wysocki" <rafael@kernel.org>
CC:     <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Jeff Brasen <jbrasen@nvidia.com>,
        Jon Hunter <jonathanh@nvidia.com>
Subject: [PATCH] ACPI: SPCR: Add support for NVIDIA 16550-compatible port subtype
Date:   Fri, 11 Mar 2022 16:53:10 +0000
Message-ID: <20220311165310.60418-1-jonathanh@nvidia.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1033bdce-aaab-4395-3f97-08da037fa2e9
X-MS-TrafficTypeDiagnostic: BN6PR1201MB0116:EE_
X-Microsoft-Antispam-PRVS: <BN6PR1201MB01166B7B3D3C3D69AD6216F6D90C9@BN6PR1201MB0116.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wTjygQemLKNAYB/tTn+ark7/cY57d+qvjtJkjUCk9GESiW79E7MlQbXIPTcSwbyueK3cbiK6nWMt7+/kuD9zR8GlgR9ZuJKwpjZNFkAS5W6fGUylWOBk6jue7VV0UPPkPGyjP68QusX/bUKhsyHbrDXrC7NqlB4zeB2IdPto+cvTkH/OZUw+gyGW+eiFRLIkD5c4pcYQ981QztV/TmFvm5InKKIcuF1JV/fVaiHYbYYzPNyZqUEjYXcYvkdesVk+xbrcRluyiKpwGWfGBjimF/nH6gikgPzcY4itlSKnF/Bvun8I9y2VRyPBYaR0NVlPq7wesBq3K48icZZFi2gNc/YU3wUKDLTL+pq/f8SaHj3pkbkxMI4TPIyQqgq8YUiWdLtYmurhb/d4k78w/3m4jghq/2Dh3gBnX/pkd78gPpeW9v+t6tn50ZTcu80/7SjYjyG+PU6appMLeMk0f/l+gm6BvtP+bSofxDbkk1dLI4PcaCiTu1EqgePxwUk/DdqnhO23Ru6ATidpbsqAfkVoPMcWDGkRQDzEVCzLO539KFzMX5gUBtVfmXT2423V1Ox463M92c/taQZhWmvSA2Ry+tK9M2s7VXr7xClu+gKKcfl/mmfmwv4VRIAoIPTankFhjkBgDRXLbfTpkaE02sG9aPXDU3vYh3EFcKfZ+CGwEsdWHsKbMIUxNPb5usO4p+ickAzfbHnTpxNVYSgi2kP6Og==
X-Forefront-Antispam-Report: CIP:12.22.5.234;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(107886003)(5660300002)(86362001)(4326008)(8676002)(47076005)(36756003)(82310400004)(1076003)(2616005)(4744005)(508600001)(8936002)(40460700003)(316002)(70206006)(186003)(7696005)(36860700001)(26005)(70586007)(81166007)(2906002)(6916009)(54906003)(426003)(356005)(336012)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2022 16:53:15.4021
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1033bdce-aaab-4395-3f97-08da037fa2e9
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.234];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT063.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1201MB0116
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jeff Brasen <jbrasen@nvidia.com>

Add support for the NVIDIA specific 16550 subtype to SPCR table parsing
routine.

Signed-off-by: Jeff Brasen <jbrasen@nvidia.com>
Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
---
 drivers/acpi/spcr.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/acpi/spcr.c b/drivers/acpi/spcr.c
index d589543875b8..1eabfcd122ee 100644
--- a/drivers/acpi/spcr.c
+++ b/drivers/acpi/spcr.c
@@ -142,6 +142,7 @@ int __init acpi_parse_spcr(bool enable_earlycon, bool enable_console)
 	case ACPI_DBG2_16550_COMPATIBLE:
 	case ACPI_DBG2_16550_SUBSET:
 	case ACPI_DBG2_16550_WITH_GAS:
+	case ACPI_DBG2_16550_NVIDIA:
 		uart = "uart";
 		break;
 	default:
-- 
2.25.1

