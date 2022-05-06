Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D93DB51D664
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 13:14:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382644AbiEFLRQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 07:17:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1391243AbiEFLQq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 07:16:46 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam07on2088.outbound.protection.outlook.com [40.107.212.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1128857163;
        Fri,  6 May 2022 04:13:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aOeKIXU73Wk20vZb3P73wNObMBH8Cb1nz5oHiKpNVuOvTWBwPOOGRExM857cm/qHyrCLY7u8Bm3BrKDcEaPc19EH8PqkK1gbELe7A3GfIE58D+MICywlKQDadHa0ihTTE4SpJyOwpguXR2qQ8Er+NoGZDbeDcj1Rgy1PLnAZlNeRKhojhcyqa1Wm0USjbf4XDxSKcXtPabK3wh6jZ7skG6WMAxlflcZnodDacXUp8reEcYqrwCs1dJ3MKUunEMqnF7OmsDKPNGRSpmkKRFf4xMYNG4azBG93PEsRBOJa2l2hec+XvOID60luyNV9FvhzxMn6qqETDdkOzSHb3IiLjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zAwJwAK226raxGh5NoBwO9QVUpnql59xp5WX7VgSuHc=;
 b=icciz8OrlYst/xcrhqWTHRcBuVipafo8FzcskZTY6U6jzPwOVujuX3bP4qxzJ9FypQMcVa5YSQrlHGC/vRm8f89OgXF71z/yGQ+yWQ4LbyiDE7PaFqGXTzzMG2F8E1CZ6loZMVY7RGSaWyXQ+zrS1uorlBICyCUFjJgZ35j1mhhaqQgDr8COnpXZEwigFqxKRmPtl6idC2UcsKyrhkk4icMdW9BnFz3VJ9wujknsflQvsZBJ1XR4iSlgxVQhIqYAT+ktpZ8jifso9lGc5wNeXHHTsBzPwo9WvQiDYSPrFnyeGCoNohkuY5uA+q/tNQvxNQ5c5WcHCH+l1nXCkGiy2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.238) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=nvidia.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zAwJwAK226raxGh5NoBwO9QVUpnql59xp5WX7VgSuHc=;
 b=Eyipn8tq1tC5lOBtkbKihEj2uJg6XCyGjCR1mH0LSWZ6XUr4T43fqFF9K86wJzoj4gEY+cy5z0uy9J5xTeDcCrBfT4CXigykcZqm57iyndlcY8jAleREOlEHmUSsPt3vfjP1y924VACS3TaTWufOIx8NN3a165zDuBuVLwQGGItIrvdD0uDSbYSVTq9NT1f+Mh1xi3dnUxuyd4uo4RkQx7AWinTxATrMP1BBJyODLwQ6XTVIuNPospOS1VOx8ivVAza8FBXUiUKlpWmohqGHK13nOpW1SbtRyEXbp4fEW6XRzn4Jf/4y3WFczZT0llcU6iCrlKhwlbL4BjJ3OC4wSQ==
Received: from MWH0EPF00056D13.namprd21.prod.outlook.com
 (2603:10b6:30f:fff2:0:1:0:16) by SJ1PR12MB6217.namprd12.prod.outlook.com
 (2603:10b6:a03:458::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.13; Fri, 6 May
 2022 11:12:59 +0000
Received: from CO1NAM11FT027.eop-nam11.prod.protection.outlook.com
 (2a01:111:f400:7eab::205) by MWH0EPF00056D13.outlook.office365.com
 (2603:1036:d20::b) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.8 via Frontend
 Transport; Fri, 6 May 2022 11:12:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.238)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.238 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.238; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.238) by
 CO1NAM11FT027.mail.protection.outlook.com (10.13.174.224) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5227.15 via Frontend Transport; Fri, 6 May 2022 11:12:59 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 DRHQMAIL105.nvidia.com (10.27.9.14) with Microsoft SMTP Server (TLS) id
 15.0.1497.32; Fri, 6 May 2022 11:12:59 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Fri, 6 May 2022 04:12:53 -0700
Received: from sumitg-l4t.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.986.22 via Frontend
 Transport; Fri, 6 May 2022 04:12:50 -0700
From:   Sumit Gupta <sumitg@nvidia.com>
To:     <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <robh+dt@kernel.org>,
        <kbuild-all@lists.01.org>
CC:     <sumitg@nvidia.com>, <bbasu@nvidia.com>, <vsethi@nvidia.com>,
        <jsequeira@nvidia.com>
Subject: [Patch v5 6/9] dt-bindings: arm: tegra: Add NVIDIA Tegra234 CBB2.0 binding
Date:   Fri, 6 May 2022 16:42:14 +0530
Message-ID: <20220506111217.8833-7-sumitg@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220506111217.8833-1-sumitg@nvidia.com>
References: <20220506111217.8833-1-sumitg@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 54617f0d-1b50-420c-e8ee-08da2f51613e
X-MS-TrafficTypeDiagnostic: SJ1PR12MB6217:EE_
X-Microsoft-Antispam-PRVS: <SJ1PR12MB62176F64609F0038F3A033E6B9C59@SJ1PR12MB6217.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +e90ywMDaZ0V4YWy+aucUK8Etm65uVVix78trB29F3iUi7OvjNeig8gFt0w0gvZJ8pUP9vPuVpDlm1W0FyIgXBVevXJTI6D4NSsy95nE0X+QwkBUWiOZs94hppNN6YqmjPJXCfQ7jIB/N79slDJI3JC+j0mCNTAHolRmc81ulIANfaXicCrHD2GxaLRW6EB5spk3dN3IGFz34WTervUMvQLRjjumKmgV3P/9msmM9OcUwUUdrSgM82hZjVDGgS0cvcf/igaqZCrkYZHnre8Bpo7Snkc3zrpEKRjIvNUgn4HZRwdT4Z27Nw+SU5LMQkF++MQmxwfXs5Bn2wfoPMbu3vrC5Z4SsLpohzB4UHuyXEHnGgm4l+WPyrec763rMYwdRgsGRX+1JSzDcaUofOCbjE+ApN365IsuQ1jSs2ZKrFFlaWq6Jp8IWvngSeD0urARZxph9oiuJ56Tsveyg6c6WXpFz0K9UGwBRf+UeMlBvK0nA4ljhyK19ImRKRA6ux70h2m/5NCKeI1iaWXAb/egkrDbx+Nkgd5Gnfa6lsc0dIgVQ+S6F8yQC456LbYlm/2Hbttz5OCdgrGvLM+QLPXVVlHAonDaZ5vi5e4O/Xmti2sJ23utbFnUfqS/ctyTZOEIBy2fp6eLtZiP+lwOX/P6It8YV9iJZlj4MRbdPoWHq7JkOisoZ+EFESD6lIZ+d9Dw5h4mGQD4M4xpHcEHIQFygAn1cR5jmQQw8pe25amzJMyYOSobnFwierHKSoknej8RC4FYfcwZ321kZ2Xs0Ww0zlRBcM68Tee6aR9Ftw0a2s613+i6ISAEFqRd9Ibprcf+tmUsUM4+jmUkVpHKclRRtg==
X-Forefront-Antispam-Report: CIP:12.22.5.238;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(5660300002)(316002)(110136005)(8936002)(36756003)(107886003)(6666004)(81166007)(54906003)(356005)(26005)(1076003)(70206006)(36860700001)(83380400001)(8676002)(40460700003)(70586007)(4326008)(186003)(508600001)(336012)(47076005)(426003)(86362001)(7696005)(82310400005)(2616005)(2906002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2022 11:12:59.5465
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 54617f0d-1b50-420c-e8ee-08da2f51613e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.238];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT027.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6217
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add device-tree binding documentation to represent CBB2.0 (Control
Backbone) error handling driver. The driver prints debug information
about failed transaction on receiving interrupt from CBB2.0.

Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
---
 .../arm/tegra/nvidia,tegra234-cbb.yaml        | 70 +++++++++++++++++++
 1 file changed, 70 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/tegra/nvidia,tegra234-cbb.yaml

diff --git a/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra234-cbb.yaml b/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra234-cbb.yaml
new file mode 100644
index 000000000000..fa4383be19d8
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra234-cbb.yaml
@@ -0,0 +1,70 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: "http://devicetree.org/schemas/arm/tegra/nvidia,tegra234-cbb.yaml#"
+$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+
+title: NVIDIA Tegra CBB 2.0 Error handling driver device tree bindings
+
+maintainers:
+  - Sumit Gupta <sumitg@nvidia.com>
+
+description: |+
+  The Control Backbone (CBB) is comprised of the physical path from an initiator to a target's
+  register configuration space. CBB 2.0 consists of multiple sub-blocks connected to each other
+  to create a topology. The Tegra234 SoC has different fabrics based on CBB2.0 architecture which
+  include cluster fabrics BPMP, AON, PSC, SCE, RCE, DCE, FSI and "CBB central fabric".
+
+  In CBB 2.0, each initiator which can issue transactions connects to a Root Master Node (MN)
+  before it connects to any other element of the fabric. Each Root MN contains a Error Monitor
+  (EM) which detects and logs error. Interrupts from various EM blocks are collated by Error
+  Notifier (EN) which is per fabric and presents a single interrupt from fabric to the SoC
+  interrupt controller.
+
+  The driver handles errors from CBB due to illegal register accesses and prints debug information
+  about failed transaction on receiving the interrupt from EN. Debug information includes Error
+  Code, Error Description, MasterID, Fabric, SlaveID, Address, Cache, Protection, Security Group
+  etc on receiving error notification.
+
+  If the Error Response Disable (ERD) is set/enabled for an initiator, then SError or Data abort
+  exception error response is masked and an interrupt is used for reporting errors due to illegal
+  accesses from that initiator. The value returned on read failures is '0xFFFFFFFF' for
+  compatibility with PCIE.
+
+properties:
+  $nodename:
+    pattern: "^[a-z]+-fabric@[0-9a-f]+$"
+
+  compatible:
+    enum:
+      - nvidia,tegra234-aon-fabric
+      - nvidia,tegra234-bpmp-fabric
+      - nvidia,tegra234-cbb-fabric
+      - nvidia,tegra234-dce-fabric
+      - nvidia,tegra234-rce-fabric
+      - nvidia,tegra234-sce-fabric
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    items:
+      - description: secure interrupt from error notifier
+
+additionalProperties: true
+
+required:
+  - compatible
+  - reg
+  - interrupts
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    cbb-fabric@1300000 {
+      compatible = "nvidia,tegra234-cbb-fabric";
+      reg = <0x13a00000 0x400000>;
+      interrupts = <GIC_SPI 231 IRQ_TYPE_LEVEL_HIGH>;
+      status = "okay";
+    };
-- 
2.17.1

