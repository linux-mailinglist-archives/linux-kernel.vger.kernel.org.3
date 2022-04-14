Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71EC65006FD
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 09:36:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240395AbiDNHif (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 03:38:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240383AbiDNHid (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 03:38:33 -0400
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam08on2047.outbound.protection.outlook.com [40.107.102.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 135F822BED;
        Thu, 14 Apr 2022 00:36:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U6PmQCifBhURIlxQiGOhdxLZc3957+lmmKxXV4JeRNYwKWHEi22qyZ1/8zfOKPuVMDgTHJho2mhcukVspOcmIWK1V3LhrAEI8SnTaDC9rYlJUWS2JpqEOhx9s/xYav9QvidUMQ+dLkpVANnwVDKcKkUYeVpx3VsAM4lhWhy/zjtQErVTPN8/yQwI+QFw/T1BmogDFga5cGP/zlSuLloTOLNIjy670DpQ+HGOOxXOJp9tb8A565c3XRBKY+corGp3meyMdqu7iZIum/zpjyGMkBh/Y6CMhxD6QWX9Q844H4v9Pr9CNPZsfdLkIOYj5wmQ4CVPubLOzmPXtRiln0ruxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Kej6rR25/9Qp4uFJFnN1mO65OSLq/EllJIYt3ViztGE=;
 b=jdUrXjnpeTSDpL7WDu6FQz7cXiKdKnyunL3aL+s6s2TW9hABTkeeA0Yw7qRXBQsOh7HLliOwVIAwVf6tp6IViVahswpnE7Cy89HBD7wXDtLW684CFmJafr0W6G2VMjLePmDCVw9qxqQxVS7BaZFa8E3bPYQFrIQfRPZyVQ+gplVW7rKlFqgDs7DlUvElumKafjjPKVS3I2Bif1QtOikSy5PhfPN4AFVQ0LkytTaPHFXQOEVUHI1wTEnzNdby67hxzhZWmxYfdqxN3MEA4rR64jH386mQSHNmENqCM3niM0Rq/vKp/5ZsQTBpnUZaOWDJQkqAmYznAQbRvRS3xj9RFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.235) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kej6rR25/9Qp4uFJFnN1mO65OSLq/EllJIYt3ViztGE=;
 b=CS3CoYfrefCoLhUwkH80Dlp5xa6Z9PAmHnKKYQnzw9naQI/8SRigylUrlrLu+Rghas5ZPvOCMANsF/lEJ4HkMp6DwUBrKDb5i5vc4xCjYOp+uMzMMFdMC1e3+LuybU64V1nmktCxHI6edVKpmOtWI3XZpe/Z0WYVxChCWf1e01Zg3SKSWuMTDSFJAbFoUeit07TMaH6HdLZAwxIFjrNzNMZi+i4yJW5kjNPX1d4OHK7TueFPQHtyLbLVzSjjB6SGWHEdUzN0ofgK146XE4RrR86qLmrOxjH0QXf/mAmHvAko3PmjBzFsiC7wl7mpFqQn1jOzgdIrXbr8Zr8UiEVpXQ==
Received: from MW4PR04CA0234.namprd04.prod.outlook.com (2603:10b6:303:87::29)
 by MN2PR12MB3616.namprd12.prod.outlook.com (2603:10b6:208:cc::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.29; Thu, 14 Apr
 2022 07:36:08 +0000
Received: from CO1NAM11FT042.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:87:cafe::67) by MW4PR04CA0234.outlook.office365.com
 (2603:10b6:303:87::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.18 via Frontend
 Transport; Thu, 14 Apr 2022 07:36:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.235)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.235 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.235; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.235) by
 CO1NAM11FT042.mail.protection.outlook.com (10.13.174.250) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5164.19 via Frontend Transport; Thu, 14 Apr 2022 07:36:07 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 DRHQMAIL107.nvidia.com (10.27.9.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.32; Thu, 14 Apr 2022 07:36:07 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Thu, 14 Apr 2022 00:36:06 -0700
Received: from kkartik-desktop.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.986.22 via Frontend
 Transport; Thu, 14 Apr 2022 00:36:04 -0700
From:   Kartik <kkartik@nvidia.com>
To:     <jassisinghbrar@gmail.com>, <robh+dt@kernel.org>,
        <krzk+dt@kernel.org>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <kkartik@nvidia.com>
Subject: [PATCH 2/3] dt-bindings: tegra186-hsp: add type for shared mailboxes
Date:   Thu, 14 Apr 2022 13:05:56 +0530
Message-ID: <1649921757-16919-3-git-send-email-kkartik@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1649921757-16919-1-git-send-email-kkartik@nvidia.com>
References: <1649921757-16919-1-git-send-email-kkartik@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3cbbeb57-269c-410e-13ed-08da1de97076
X-MS-TrafficTypeDiagnostic: MN2PR12MB3616:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB3616E4E7358D23CD2BC51DA7CDEF9@MN2PR12MB3616.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: X06IYXbm1v9v8XmGS2bDZq2MX3gGjh8N7B7lTFaY4JsWNjMwROBb5FgY3yNyvu7q35+S0Mmiv7BLFxgOHfHs6plINMP36fZI4rwD7uzYzeLGq/i+AADGyLo0VyO5OH+L8njGUqGaQtWn1vc8iu27EtokHkrcUKA7iqVuBVupDffJJOAWkDhjOW3jxTVk0YyObolg2EXM3gzVjsHPLlF6oqsNTM0V/rbvaYktJJGy7LfgQtAQAh6ZnoHYwKTEEBkdJ9Nou5M0+uzUj3YUtExkPj30rOMSfi2hq02eD2bG1ulnn6kiMKAzmO5WFptw/Cqk5QiEgbgM2BRfyNQUNDVJoqpXX60kcgjdftucKjmwyO9H37mjyvTKUvcnT7TtY7bT9dNmUlTbLl54DCA4Y6xPPtnnZK2QwcfN+VtuXK90i4OXBrqHeM10CSu4Llg21TuxFtP5llWtMCeh30rL18JkVn8L3rjtBe7ULYjrm3F7Cbm2Wtq5UoPJfSc8dKLqGGGZ5MSbMEM8PMHFE7jwg4MPIOcCbtc84C7xdxdfV1kowQhP/ldD/SYwxAFVIRxOwS8TQcDN/iPP7MQCB/0mJZ0fEvRwKLjRpvGpURbSOc1L5mrz+ksP5WDhzQdUE8v5Dh2TgYaSbUp4bJR9dvvD+tuSXBkJ5CBQflnMaJnm5VS+F8sY3ZbMoXWekdNLkjIPVbT0vV2R2KfiIN19GHMu9Ttdgg==
X-Forefront-Antispam-Report: CIP:12.22.5.235;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(316002)(508600001)(2616005)(47076005)(110136005)(70586007)(86362001)(7696005)(6666004)(36756003)(336012)(426003)(26005)(8936002)(36860700001)(186003)(8676002)(70206006)(82310400005)(40460700003)(83380400001)(15650500001)(5660300002)(81166007)(2906002)(7049001)(356005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2022 07:36:07.6624
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3cbbeb57-269c-410e-13ed-08da1de97076
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.235];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT042.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3616
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tegra234 supports sending/receiving 32-bit and 128-bit data over
a shared mailbox. Based on the data size to be used, clients need
to specify the type of shared mailbox in the device tree.

Add a macro for 128-bit shared mailbox. Mailbox clients can use this
macro as a flag in device tree to enable 128-bit data support for a
shared mailbox.

Signed-off-by: Kartik <kkartik@nvidia.com>
---
 .../devicetree/bindings/mailbox/nvidia,tegra186-hsp.yaml | 9 +++++++++
 include/dt-bindings/mailbox/tegra186-hsp.h               | 5 +++++
 2 files changed, 14 insertions(+)

diff --git a/Documentation/devicetree/bindings/mailbox/nvidia,tegra186-hsp.yaml b/Documentation/devicetree/bindings/mailbox/nvidia,tegra186-hsp.yaml
index 9f7a7296b57f..a3e87516d637 100644
--- a/Documentation/devicetree/bindings/mailbox/nvidia,tegra186-hsp.yaml
+++ b/Documentation/devicetree/bindings/mailbox/nvidia,tegra186-hsp.yaml
@@ -26,6 +26,15 @@ description: |
   second cell is used to identify the mailbox that the client is going
   to use.
 
+  For shared mailboxes, the first cell composed of two fields:
+    - bits 15..8:
+        A bit mask of flags that further specifies the type of shared
+        mailbox to be used (based on the data size). If no flag is
+        specified then, 32-bit shared mailbox is used.
+    - bits 7..0:
+        Defines the type of the mailbox to be used. This field should be
+        TEGRA_HSP_MBOX_TYPE_SM for shared mailboxes.
+
   For doorbells, the second cell specifies the index of the doorbell to
   use.
 
diff --git a/include/dt-bindings/mailbox/tegra186-hsp.h b/include/dt-bindings/mailbox/tegra186-hsp.h
index 3bdec7a84d35..b9ccae2aa9e2 100644
--- a/include/dt-bindings/mailbox/tegra186-hsp.h
+++ b/include/dt-bindings/mailbox/tegra186-hsp.h
@@ -15,6 +15,11 @@
 #define TEGRA_HSP_MBOX_TYPE_SS 0x2
 #define TEGRA_HSP_MBOX_TYPE_AS 0x3
 
+/*
+ * These define the types of shared mailbox supported based on data size.
+ */
+#define TEGRA_HSP_MBOX_TYPE_SM_128BIT (1 << 8)
+
 /*
  * These defines represent the bit associated with the given master ID in the
  * doorbell registers.
-- 
2.17.1

