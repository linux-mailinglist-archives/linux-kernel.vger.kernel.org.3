Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE177539F0D
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 10:09:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350554AbiFAIJj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 04:09:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350524AbiFAIJW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 04:09:22 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2100.outbound.protection.outlook.com [40.107.223.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE6FA1A828;
        Wed,  1 Jun 2022 01:09:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d6KyOQsu7ASvtsUHlS/WWNP08FF1f4XPhKV2KHCocy0f7JxoGD3CELl8hGkTfTjKUQnTfF29xFkgr3MGShoo/+aLknWJJINU/OgDrayyqIdTNTnSyrsxJVHgVEquma730SjrSBNzWa68ctNrf1CxGkwB0c+DUVkQAsvTKaHZExUbt8TZxq3ayWKDSgAuABfvdF9W9T5+lncOawER++7J2lXWlQKLbEbClw2YOtJVN3cTkomnC5OqCMO+S548jqMK55zsEfuf+GIXYosJ6VwW+RfkLP5kXvz36N8X79VnuBVeETiG2L4QgBgbGGoX0idSgNx1wB/SKLPggCA8HDsqQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LuyUBKlGGr01trKlDRQez4fapcaoL3nMCIW36ABGkig=;
 b=Dn9JWaBkyPhv/IuAFDd8CRNmnE8a7lZWzC2xCrT+pffleYTKT1xP+Q2iGMCVSmplpP4eaOOfZQAIVd6/ITBjw0uRtYX0rruPEiQvzoU9QfMyMSGQOnMaflEphS+bUe1x608neRvsJ7RrHmWqhsYY26T11xG3XGkI+TeKU5N9NMBs44tu6Mm15b7aRNWsPU66nayA0lq2ZZ9VVYhfqIZBXL2ak+ur6XJFX6Wizs9g5FK7qRq0eC1oAzY/IEjMTDqHywdrR0WW7DkFNLj4KcoQcyIYOH1iSaKNi3FFxz7Z79TeKVrNz9SEoa2iqrMW0qy3eJ/7RLxg3qn4hSkv/an8pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 8.14.198.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=jabil.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=jabil.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jabil.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LuyUBKlGGr01trKlDRQez4fapcaoL3nMCIW36ABGkig=;
 b=a6sSkMfNK3eFxgHm2po3e3FUBhAACw3fGW7aI1HLWDjqugwfeCdroswQ6mVSRJviJio/rf+JjpLkSvJYAJOwFHbWrAMl+QBXH2+BWCmltYRwquz6aMDmlWPp3Ib9l2lYaf6VXIm+MnCzjDlWRSuF+fYzGPsCqvVWHzUIeU7lsusJjHTU4e37TUA7SBC2Lbec/gDevwRWL7mlkAy49eGnpUK5viDfhQYJos9S2Yy8IgSBEwyLmsHCrarfpnxmuayQndgvMoI3iWZ8n0pT724lOczYqY+pD3yNebg5A5tLn5x9hF25M7YZFI38stJ/N0uRfNc39W/d+xV6JMvZ7LOXyg==
Received: from DM5PR20CA0013.namprd20.prod.outlook.com (2603:10b6:3:93::23) by
 BYAPR02MB5077.namprd02.prod.outlook.com (2603:10b6:a03:70::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5293.17; Wed, 1 Jun 2022 08:09:18 +0000
Received: from DM6NAM11FT015.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:93:cafe::9c) by DM5PR20CA0013.outlook.office365.com
 (2603:10b6:3:93::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.13 via Frontend
 Transport; Wed, 1 Jun 2022 08:09:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 8.14.198.161)
 smtp.mailfrom=jabil.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=jabil.com;
Received-SPF: Pass (protection.outlook.com: domain of jabil.com designates
 8.14.198.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=8.14.198.161; helo=jabil.com; pr=C
Received: from jabil.com (8.14.198.161) by
 DM6NAM11FT015.mail.protection.outlook.com (10.13.172.133) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5314.12 via Frontend Transport; Wed, 1 Jun 2022 08:09:18 +0000
Received: from USPLND0HUB81.staging.JABIL.ORG (10.10.80.133) by
 USPLND0HUB02.corp.JABIL.ORG (10.10.47.157) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 1 Jun 2022 03:09:08 -0500
Received: from usplnd0hub02.corp.jabil.org (10.10.47.157) by
 USPLND0HUB81.staging.JABIL.ORG (10.10.80.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 1 Jun 2022 03:09:08 -0500
Received: from JDSBuild.corp.JABIL.ORG (10.10.7.5) by
 usplnd0hub02.corp.jabil.org (10.10.47.157) with Microsoft SMTP Server id
 15.1.2176.2 via Frontend Transport; Wed, 1 Jun 2022 03:09:06 -0500
From:   David Wang <David_Wang6097@jabil.com>
To:     <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <edward_chen@jabil.com>, <ben_pai@jabil.com>,
        David Wang <David_Wang6097@jabil.com>
Subject: [PATCH 3/3] dt-bindings: vendor-prefixes: document jabil vendors for Aspeed BMC boards
Date:   Wed, 1 Jun 2022 16:08:56 +0800
Message-ID: <20220601080856.1548851-3-David_Wang6097@jabil.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220601080856.1548851-1-David_Wang6097@jabil.com>
References: <20220601080856.1548851-1-David_Wang6097@jabil.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 076d8396-50d2-4a24-cdc7-08da43a606e8
X-MS-TrafficTypeDiagnostic: BYAPR02MB5077:EE_
X-Microsoft-Antispam-PRVS: <BYAPR02MB50772A8D886ABE9072B1BF1EEFDF9@BYAPR02MB5077.namprd02.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cLc8tGLitodetmS3+1EyUay68YzQVSeFyzif4rc2WxZiD08lyjKUx5NmycUdKIbzNynVFcDrGn+AUef9jcSg5rnYZRExC8V5XA4AJzeDhGOHB0HeennPEKBg3OzKSEOgOGaXXuodv2XMvCX7uFF62rly0f2RqbXMT0qGa7dj1ojNWXkfG/rMOujwNh39oIP3XyYJyei4ApMmoxx0nIm01pIhnsOa/20VVREc9sTi0enEm63AKoNtgTz8cFZ07Hb4hDBpbW8t+vDun4lKrm6MSTED98tEZzPMKUE8etc167xjPAsLSFDc1sp365mgoJ5XawR+V2pd5+pY7bVWnSewGt0Ql1lotP+3CqVTfWcGLzNGTM7Gii5GYuZicEQpz92mDL/Gdod/UHUGR2Or9gdJnzRoJK9j19Q46Z0YjuVh7EyZoyOIOBSpvAP7xqSZq/FO75/q2nlomqgXYpzWvyFRRUXiG8rT8XCi1+EH1Olp+swub3N7aCS3Ijcn4ywNpwp5aGu9taOXtr3XbYAYY1VWzPQTlU8WbB27nwoCh3yqSYpg3kszW7tf2qxDnA0+g9XZ02+ZZLBkNlD3TbbQ+Z4eMr5f2KiH/DoM/9Sb78VERDZsrPE1a8GOVPhAyCl6aT8vajkDc+ub5GKJ+Dh0zp8rPCgT9tRgP4yRKgaoKyIGnDZgf8FKaAf+c4QjUMiGjWPOzFYfMUCA3wLRH6Win2Vwsg==
X-Forefront-Antispam-Report: CIP:8.14.198.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:jabil.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(2906002)(2616005)(316002)(54906003)(36756003)(1076003)(82310400005)(40460700003)(26005)(110136005)(36860700001)(107886003)(81166007)(186003)(5660300002)(70206006)(86362001)(70586007)(8676002)(82960400001)(4326008)(356005)(47076005)(336012)(83380400001)(6666004)(8936002)(4744005)(508600001)(36900700001);DIR:OUT;SFP:1102;
X-OriginatorOrg: jabil.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2022 08:09:18.5429
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 076d8396-50d2-4a24-cdc7-08da43a606e8
X-MS-Exchange-CrossTenant-Id: bc876b21-f134-4c12-a265-8ed26b7f0f3b
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bc876b21-f134-4c12-a265-8ed26b7f0f3b;Ip=[8.14.198.161];Helo=[jabil.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT015.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB5077
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Depends on Krzysztof Kozlowski's vendor prefix patch

Added Jabil vendor prefix for Aspeed SoC based BMC board manufacturers.

---

v2

- Change the order of items

---

Signed-off-by: David Wang <David_Wang6097@jabil.com>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index 169f11ce4cc5..1bd23060dcf9 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -626,6 +626,8 @@ patternProperties:
     description: ITian Corporation
   "^iwave,.*":
     description: iWave Systems Technologies Pvt. Ltd.
+  "^jabil,.*":
+    description: Jabil Design Service Branch (Sanchong)
   "^jdi,.*":
     description: Japan Display Inc.
   "^jedec,.*":
-- 
2.30.2

