Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6E04525419
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 19:50:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357103AbiELRul (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 13:50:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343791AbiELRuh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 13:50:37 -0400
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam07on2059.outbound.protection.outlook.com [40.107.95.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03C9F200F71;
        Thu, 12 May 2022 10:50:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FbaGVYOcXJYANYOJQIavbvoHqTjjO6XTA0P/kejE4L3Ml2zgokTELDqWGE90l943Yt0/To4ggt9IdrCRzmvGSmqnMvN1BfbxH6ESLRa/Ka1oU5Vz/73XPSBUVkLp/B7GpHJBt5dm9DQ2bvZZTmbNTqTsOy8HNQpXo6fwJDn050KCrBWNIFQWQBkx27Vs3RcUrNDHEu4HQ/4ZGdXuGLzACEFyB3ge4c/hMPxM7lht3/T33r10h/lpbXuzOunCSFuW5APW87kLp90v9gPwVRQyoUWieuyhaeln0D4LPjrKuqhv1bn8hnt+KVNA/khaBiVmRvgvlrI+EWI1AQKrdxBMXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oxAQRpOmixBXIvokS1soBBBWR++1JhD5wRYAi5ix8ZU=;
 b=k+AYLJ0rEq+QiS3cINv3zVTvgxvapalN1x/J2i4QLzTyqygzDJf/L8u9ye5JFRvCUgWzkXtltMsNVR/fIvBiVqEJNqLPviscH7JGn2MjgCFOHugII0p61v/TEmPRSYmV73LEj+0LkhgTc6+KEokJmEqLknQZvY+alIE8RH8/suYmE5vsLVgSZLoxtU9ODN1WcnuMeYbzebR1A64G+Ja8np3uqaPMnZN7dP7EU2dnpQQ4ZbOua7bZ5t+ArpGsDr2/p+G4mxa+BV/M8o1GBsG1SIzYSH6r6UTgX+2GRH1TsZnVAwG0db5d1dL15AXnFjzmC192fcxogoppTJC0eyUz0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.234) smtp.rcpttodomain=linaro.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oxAQRpOmixBXIvokS1soBBBWR++1JhD5wRYAi5ix8ZU=;
 b=oBxPOKvNBkHRtkECkOtWqb7rPrL4xypbOcqeEima7Ep4z5ioICXk0yEAYYSySVA/RMFvEqhFkwkDYhuDV+nqkFD7X48mqDCOMY/APBZhX3lqYyKGxDyQ2XokWUhuUH4reXk9oqTiDkz6CPGos3GnqbNi0uMqVHOMKlgKjUDO11UWvwYCHtQYFL9ogdRd5WW/8e1DarxEHAPAYkdKHlp6V31XL6qMa01zBnd29hnw4Iw1UdCEq5Ex0MtvrLsCNNDWqYhvuFOyU9RvUbVV8aYvU5IGBpgNRmTbcvK5k4WUGRQtI1KQfTFYsANJNToLo3IJO5a9DCTRRpr0jgfLeoVaYA==
Received: from DS7PR03CA0117.namprd03.prod.outlook.com (2603:10b6:5:3b7::32)
 by DM6PR12MB2939.namprd12.prod.outlook.com (2603:10b6:5:18b::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.23; Thu, 12 May
 2022 17:50:34 +0000
Received: from DM6NAM11FT046.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b7:cafe::6) by DS7PR03CA0117.outlook.office365.com
 (2603:10b6:5:3b7::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.24 via Frontend
 Transport; Thu, 12 May 2022 17:50:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.234)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.234 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.234; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.234) by
 DM6NAM11FT046.mail.protection.outlook.com (10.13.172.121) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5250.13 via Frontend Transport; Thu, 12 May 2022 17:50:34 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 DRHQMAIL101.nvidia.com (10.27.9.10) with Microsoft SMTP Server (TLS) id
 15.0.1497.32; Thu, 12 May 2022 17:50:11 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Thu, 12 May 2022 10:50:10 -0700
Received: from dipenp.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.986.22 via Frontend
 Transport; Thu, 12 May 2022 10:50:10 -0700
From:   Dipen Patel <dipenp@nvidia.com>
To:     <thierry.reding@gmail.com>, <linux-kernel@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linus.walleij@linaro.org>,
        <devicetree@vger.kernel.org>, <robh+dt@kernel.org>
CC:     Dipen Patel <dipenp@nvidia.com>
Subject: [PATCH] dt-bindings: Renamed hte directory to timestamp
Date:   Thu, 12 May 2022 10:50:11 -0700
Message-ID: <20220512175011.28753-1-dipenp@nvidia.com>
X-Mailer: git-send-email 2.17.1
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: afe384b8-ec5f-4a36-b7c8-08da343fea43
X-MS-TrafficTypeDiagnostic: DM6PR12MB2939:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB2939514DDC716801AA459201AECB9@DM6PR12MB2939.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qRyOy78YJ9Iwv5SPdzEWFNefLVgiSBSXT0Sqpp8PUTDHp3C619nLXd5FmReJz1v49qHfjxhSzz8PLFwgfeZLN9WNH3SbNrJEaubR0wyujBTzELQsz8WV14kD8fcBWbDk6/VQmJxDiNNJ3lfH1D7DDDA8u+Lgz7Ilojx9IxCnA0G/DTYTY1IfepxRfKHw+h9Gs7l9QMfjH8qga5wRiGq6OrN5qP72AhNHt9UhrvRSpfq1tRjlSotFL6qsMp1JX6PIlCNO9R/27tarS0A8lODDmZWEUvsfs7C4FbMQbePixz31Abe5yqe7Az+dEK1p57NOWmxDdLUaQOkOHONXe7nTEKM1gVolg3vGm77WgxXnuUMCXV1exCENxahg1ay+BOAeDITD4p2FdFVuksSm7WmYoWxQvcNZNMaQOYIokql4JYXGovxXUGhuZtbSWxxfUDplzfIC7ngThLqePlH+h3lvgzXLacTzBqQK1o0fVBRZZMhuKtToO+E9KkNyN5GONJkDclJGUEeIms5fFw7Bg4Qv+IF0kEx8MRG0oCxu2qV+3mtU9MuVQZpHSGlfi5ovipavZy3/MmdhAsE0q2ykYa3EezMOT+D1hL6kPaiclXT1yPUr1E05P7n2YpumEbECmDwzi0kK7VZl8PqhZT7xUNHx14EQPy82FqrjOlBzn87FBTTRAHXZAswSbnBbtg9vWmYHe6Wz0R/kmczt6CTp/VohgRyihmFxQdgB3tr0y+Gqmx0=
X-Forefront-Antispam-Report: CIP:12.22.5.234;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(83380400001)(36756003)(4326008)(8676002)(2906002)(82310400005)(47076005)(5660300002)(426003)(336012)(2616005)(186003)(26005)(1076003)(107886003)(7696005)(81166007)(508600001)(8936002)(36860700001)(316002)(356005)(70206006)(70586007)(40460700003)(110136005)(86362001)(36900700001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2022 17:50:34.2674
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: afe384b8-ec5f-4a36-b7c8-08da343fea43
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.234];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT046.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2939
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Renamed hte dt binding directory to timestamp according review comment.
Addressed minor comment about having HTE acronym first in the common dt
binding document.

The change reflects above renaming in MAINTAINERS files too.

Signed-off-by: Dipen Patel <dipenp@nvidia.com>
---
This patch is on top of old series (Intro to Hardware timestamping
engine V6) present in linux-next tentatively in preparation for
merge.

 .../{hte => timestamp}/hardware-timestamps-common.yaml      | 6 +++---
 .../bindings/{hte => timestamp}/hte-consumer.yaml           | 0
 .../bindings/{hte => timestamp}/nvidia,tegra194-hte.yaml    | 0
 MAINTAINERS                                                 | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)
 rename Documentation/devicetree/bindings/{hte => timestamp}/hardware-timestamps-common.yaml (71%)
 rename Documentation/devicetree/bindings/{hte => timestamp}/hte-consumer.yaml (100%)
 rename Documentation/devicetree/bindings/{hte => timestamp}/nvidia,tegra194-hte.yaml (100%)

diff --git a/Documentation/devicetree/bindings/hte/hardware-timestamps-common.yaml b/Documentation/devicetree/bindings/timestamp/hardware-timestamps-common.yaml
similarity index 71%
rename from Documentation/devicetree/bindings/hte/hardware-timestamps-common.yaml
rename to Documentation/devicetree/bindings/timestamp/hardware-timestamps-common.yaml
index 3e26de605f08..4c25ba248a72 100644
--- a/Documentation/devicetree/bindings/hte/hardware-timestamps-common.yaml
+++ b/Documentation/devicetree/bindings/timestamp/hardware-timestamps-common.yaml
@@ -10,9 +10,9 @@ maintainers:
   - Dipen Patel <dipenp@nvidia.com>
 
 description:
-  Some devices/SoCs have hardware time stamping engines which can use hardware
-  means to timestamp entity in realtime. The entity could be anything from
-  GPIOs, IRQs, Bus and so on. The hardware timestamp engine (HTE) present
+  Some devices/SoCs have hardware timestamp engines (HTE) which can use
+  hardware means to timestamp entity in realtime. The entity could be anything
+  from GPIOs, IRQs, Bus and so on. The hardware timestamp engine present
   itself as a provider with the bindings described in this document.
 
 properties:
diff --git a/Documentation/devicetree/bindings/hte/hte-consumer.yaml b/Documentation/devicetree/bindings/timestamp/hte-consumer.yaml
similarity index 100%
rename from Documentation/devicetree/bindings/hte/hte-consumer.yaml
rename to Documentation/devicetree/bindings/timestamp/hte-consumer.yaml
diff --git a/Documentation/devicetree/bindings/hte/nvidia,tegra194-hte.yaml b/Documentation/devicetree/bindings/timestamp/nvidia,tegra194-hte.yaml
similarity index 100%
rename from Documentation/devicetree/bindings/hte/nvidia,tegra194-hte.yaml
rename to Documentation/devicetree/bindings/timestamp/nvidia,tegra194-hte.yaml
diff --git a/MAINTAINERS b/MAINTAINERS
index 4e1e6dbb1ad8..74a61ea4beef 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9057,7 +9057,7 @@ F:	drivers/input/touchscreen/htcpen.c
 HTE SUBSYSTEM
 M:	Dipen Patel <dipenp@nvidia.com>
 S:	Maintained
-F:	Documentation/devicetree/bindings/hte/
+F:	Documentation/devicetree/bindings/timestamp/
 F:	Documentation/hte/
 F:	drivers/hte/
 F:	include/linux/hte.h

base-commit: 6107040c99d5dfc920721c198d45ed2d639b113a
-- 
2.17.1

