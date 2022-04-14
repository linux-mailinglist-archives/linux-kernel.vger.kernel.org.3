Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAF12500703
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 09:36:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240414AbiDNHim (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 03:38:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234473AbiDNHid (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 03:38:33 -0400
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam08on2041.outbound.protection.outlook.com [40.107.101.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64C891C901;
        Thu, 14 Apr 2022 00:36:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SyAfdyq3Vlk2wBPb33TwA/97TKXdxsK4yJ3Xkj/YAS3tDt5udQ1H7cj5AMkil6qyjegMuRYwcs64RSRkoMpZUVoR7dbdPDXFwUgdXlUOOrsYQ34syK7k4Gsyr4ape8cKF+DoaOaMDxk1oKw7V00AG09shSpEdCUX9JkLw4TVdznlmQwU0oF/3J8JtcKpMM+LE+WWgDp9beoWDcz+DzVLTMXj29SKyJhpLHXCNJo8YZEOOxr85SQ3iJoBQms2ydbwQwWfQLLRq7q66+FO3k4tnmUuj5kkLMfsabBfaNhPfOOPHcSKqIqbcjAh9RE6Ih46Jia+UbdKRCsvKCsqe9qjBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KwZ0VNZeBDNj73I5V1/zYd35a8xfVcJFS1pK0u94IXc=;
 b=HmQZldjthlKXyIL0c6Wh4CCqdtOaXs+IrtW8rhCEb4jPmA9cuVUXLCFuU5R8HZQuwzdRKzB8Y140hkG3ii7FeSQftshRA8ya3y7TFGjZuAlUeO9zzjbHA/9dCarFer2fZLKSXIbklrfUmMRDhYtMKH5OEeUme+RF/jLNl10cJiVba4X/mkWveJzOXPERMExerAoNUph1RDECZh3JvEUW8N+A3+zv2QbTByErWTKdaFA39ya7Bl+0vvkgmY06GmavzYwv4hmFaeIdYTuZQjZdCztXTvLEE/yxMoaC5mTADe+WH7Q8W4V7gQcyG3NQ/etKxlsjy3XIPDAkYVLR3ylLtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.238) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KwZ0VNZeBDNj73I5V1/zYd35a8xfVcJFS1pK0u94IXc=;
 b=tcRXR2nFVn6Xq1k3K5YDam9hp/iKGsnr8fSYBfV3NXCB2nHLjZh18of56JQ2Gfi4JIUAzlGlTMRngeGNenJrWOWk+3fsqIZBywCdQnDH7V+lwLYlKxuP1dm74rtSL71rHyesbgCpD5VSVM0u/YRbWAqSx2bmVe10weDb6sDKTVcMhPqrm2VLY0h0bJddMM7wuAmqHhEfwA8yZFsmPkguwyJMWKQkeCxrqRNET9aICttIDeL7JHaa7dN1M+5z/NVy27/nvlxezw/w73GT7C01BJ5uYZ0xxSivFCjDAVIfgb47d3X0AwuM9tStqKT4J9eDUkZ0f7/aWi4iKl/VYUu4CQ==
Received: from MW4P221CA0010.NAMP221.PROD.OUTLOOK.COM (2603:10b6:303:8b::15)
 by MN0PR12MB5881.namprd12.prod.outlook.com (2603:10b6:208:379::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.18; Thu, 14 Apr
 2022 07:36:04 +0000
Received: from CO1NAM11FT033.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8b:cafe::2c) by MW4P221CA0010.outlook.office365.com
 (2603:10b6:303:8b::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.20 via Frontend
 Transport; Thu, 14 Apr 2022 07:36:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.238)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.238 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.238; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.238) by
 CO1NAM11FT033.mail.protection.outlook.com (10.13.174.247) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5164.19 via Frontend Transport; Thu, 14 Apr 2022 07:36:03 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 DRHQMAIL105.nvidia.com (10.27.9.14) with Microsoft SMTP Server (TLS) id
 15.0.1497.32; Thu, 14 Apr 2022 07:36:01 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Thu, 14 Apr 2022 00:36:01 -0700
Received: from kkartik-desktop.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.986.22 via Frontend
 Transport; Thu, 14 Apr 2022 00:35:58 -0700
From:   Kartik <kkartik@nvidia.com>
To:     <jassisinghbrar@gmail.com>, <robh+dt@kernel.org>,
        <krzk+dt@kernel.org>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <kkartik@nvidia.com>
Subject: [PATCH 0/3] Add 128-bit support mailbox for Tegra234 chips
Date:   Thu, 14 Apr 2022 13:05:54 +0530
Message-ID: <1649921757-16919-1-git-send-email-kkartik@nvidia.com>
X-Mailer: git-send-email 2.7.4
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cd48e6df-b688-4c8a-e0d0-08da1de96dda
X-MS-TrafficTypeDiagnostic: MN0PR12MB5881:EE_
X-Microsoft-Antispam-PRVS: <MN0PR12MB58816768EAD89B340216B046CDEF9@MN0PR12MB5881.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 35E1cwyyJKD3/R6NSd7CKsinHrgYJWGWRJvrVWCejmbzx/Ukk/Eifal/9HWBRFfuE5ZExu8YTpnsN2OanFaULJ3rMFLbYZ375iB54cMyA8YqcWKKeIjGEua+HRmKryscag/wZDhXNUjCQf1XQT5ls7OE+6DdTRxVCm0w9ZRcD4oH6ymGGFdt6hIvJR7/LUZWhXJCuxzSpBzUSg05Ig0C0DtxA5n0A+LuJbPxprT3gryL3gxWBAgHGvKuhFFHN1wtsvKxsZeLc2wzz0zFdJ4UYoVfjOMzXzPY+s5XLyt4ALg2bpgCUhT9UEHTZEcmTrKdB4psDGJGNaYj7WlbQqhR+TJBEET6yK5MlwFN2gz7350wv8C4ya3gw3dBQIpEqBw2wMjUAXWF6VqNZS6uYflfs8AOeft3na7xz47DBveENICIbkvfRRKqNpLuV2B0waA9HwnrWLvOhEhK1JEo0iwZIwzigW4ivWH+QGf3pgD7Uo2yrhDCu1LM3Ngs9jMyGCxO7zxQS9XqDq3oYdgDuh6YFk7NmJxHyUL9ozvo6YWWEsdtROo6reAbDsAHnLseohpcUmKiqjNtQmbcoAMjZGVLckTeDtBYWRIOTJDhs3U/oo1t23k6Cx/VoF/KzOGDIaTWaNspJQA5KXVwGCkJ67J+Fu3d2pLQyPXf+1MwCqUrd7AIXuqvGz+9pnc2ixCD0WGjXMdhWHfmVUDWRdptuJXt5A==
X-Forefront-Antispam-Report: CIP:12.22.5.238;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(81166007)(36756003)(47076005)(82310400005)(6666004)(2616005)(8676002)(70586007)(316002)(70206006)(36860700001)(5660300002)(4744005)(26005)(7049001)(83380400001)(186003)(336012)(8936002)(426003)(86362001)(15650500001)(40460700003)(2906002)(110136005)(508600001)(356005)(7696005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2022 07:36:03.3055
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cd48e6df-b688-4c8a-e0d0-08da1de96dda
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.238];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT033.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5881
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series of patches adds support for 128-bit shared mailbox found
on Tegra234 chips. It also introduce tegra_hsp_sm_ops to abstract
send & receive APIs for 32-bit and 128-bit shared mailboxes.

Kartik (3):
  mailbox: tegra-hsp: Add tegra_hsp_sm_ops
  dt-bindings: tegra186-hsp: add type for shared mailboxes
  mailbox: tegra-hsp: Add 128-bit shared mailbox support

 .../bindings/mailbox/nvidia,tegra186-hsp.yaml |   9 ++
 drivers/mailbox/tegra-hsp.c                   | 149 ++++++++++++++----
 include/dt-bindings/mailbox/tegra186-hsp.h    |   5 +
 3 files changed, 134 insertions(+), 29 deletions(-)

-- 
2.17.1

