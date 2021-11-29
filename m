Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47498462409
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 23:12:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229956AbhK2WPp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 17:15:45 -0500
Received: from mail-eopbgr70059.outbound.protection.outlook.com ([40.107.7.59]:11747
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231650AbhK2WNo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 17:13:44 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eJKUTrTGT9CZmiM/gXVP3OBVYm0Rgigcb/JpFRHHkc7wAw0kYG9KPgynv8kltYsUyfirHUyKtKDKhMJd4Qi3JIElMaqFF4yj6L6eOZevXSa8dwd4ApEMjviWC220rQ5TvdatjVduVqdT/v8GdBLEvlJBba2l5ZNCIHACPYDq+qLK/mqP2TbRIHiu73a0zFJg+7dpoVgF/RAuvo/EUcP3ldHCx+BM3ZFx1oOMS1F7JrubXQUKsSijfDnImqtoBCpq4YimZFfu2S5kTO6JK7IAwMNm2JVYSMZflwcMFkhExjY+T83348N3MNZcCCItMk9DJjFdlc+J4za58CPbVn6Suw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rLiX9e16Q1RMMUuWOU+EoyTuQIuz7luxgtSxvSFAKvw=;
 b=eDqE9qXqE7uO2urmEb0sdtxVhsrFilAbcGLhUZSaN2NbVDHIpxqJvZzxcFOrZng2eejdt1x8V1vcsEQoTQCQMc09PwgCJRd0RfHbuaEWcUY1Wxc+OZvL7wX+ArjjaQmsWTx5lbiYvTov55SWAnIGMj7EsobP/1R1WNUa0/S4ZfVGeGWLln8Wpt4qWsPcvwZHXwSKowuMIcGhbYDuW2w7qIKJJCqxu5hdZ/rhwRuSFRWJC2dypwk28gTdIqBSAae1HxmJ91Gj++NBk7obBYO2+Q77dydb91gtrAlmmN1K//Sw8WxRLDClRh1020LC80Mwjk2Fl9VGkqBuQ+YkKHpbFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 193.240.239.45) smtp.rcpttodomain=gmail.com smtp.mailfrom=diasemi.com;
 dmarc=none action=none header.from=diasemi.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dialogsemiconductor.onmicrosoft.com;
 s=selector1-dialogsemiconductor-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rLiX9e16Q1RMMUuWOU+EoyTuQIuz7luxgtSxvSFAKvw=;
 b=oAkIzL2CkVyBwM0KUX2bEeBWTtVVNEsQnnHlOr145gCF3B1GER3c84a6DFJ6gjvfWh7kbfjeFIp7TXv+/qsdE3yMvEwWoMCBOypT71gCkJYB9o2zdcKXZyRPZQNkaNThuvjxyysVIv4KotBvgOmMstBCeOB1QODr8g8oVdBbaHI=
Received: from SV0P279CA0059.NORP279.PROD.OUTLOOK.COM (2603:10a6:f10:14::10)
 by AM6PR10MB2808.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:ae::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.23; Mon, 29 Nov
 2021 22:10:23 +0000
Received: from HE1EUR02FT031.eop-EUR02.prod.protection.outlook.com
 (2603:10a6:f10:14:cafe::d9) by SV0P279CA0059.outlook.office365.com
 (2603:10a6:f10:14::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.20 via Frontend
 Transport; Mon, 29 Nov 2021 22:10:23 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 193.240.239.45) smtp.mailfrom=diasemi.com; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=diasemi.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 diasemi.com discourages use of 193.240.239.45 as permitted sender)
Received: from mailrelay1.diasemi.com (193.240.239.45) by
 HE1EUR02FT031.mail.protection.outlook.com (10.152.10.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4734.21 via Frontend Transport; Mon, 29 Nov 2021 22:10:23 +0000
Received: from nbsrvex-01v.diasemi.com (10.1.17.243) by
 nbsrvex-01v.diasemi.com (10.1.17.243) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 29 Nov 2021 23:10:10 +0100
Received: from slsrvapps-01.diasemi.com (10.24.28.40) by
 nbsrvex-01v.diasemi.com (10.1.17.243) with Microsoft SMTP Server id
 15.1.2176.2 via Frontend Transport; Mon, 29 Nov 2021 23:10:10 +0100
Received: by slsrvapps-01.diasemi.com (Postfix, from userid 23378)
        id 7C88D80007F; Mon, 29 Nov 2021 22:10:10 +0000 (UTC)
Message-ID: <530a626cee6bc12ff5b4ab16319ac7a1fac6e306.1638223185.git.Adam.Ward.opensource@diasemi.com>
In-Reply-To: <cover.1638223185.git.Adam.Ward.opensource@diasemi.com>
References: <cover.1638223185.git.Adam.Ward.opensource@diasemi.com>
From:   Adam Ward <Adam.Ward.opensource@diasemi.com>
Date:   Mon, 29 Nov 2021 22:10:10 +0000
Subject: [PATCH V4 1/4] dt-bindings: da9121: Remove erroneous compatible from
 binding
To:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>
CC:     Liam Girdwood <lgirdwood@gmail.com>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Support Opensource <support.opensource@diasemi.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d9b790bc-61b7-4481-9547-08d9b3850a51
X-MS-TrafficTypeDiagnostic: AM6PR10MB2808:
X-Microsoft-Antispam-PRVS: <AM6PR10MB28080A7D162E433C9C2A9A5BCB669@AM6PR10MB2808.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:2733;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: G7aEmocWp2zCIXUwZ7DeIy8iREbggaanG1UZDBFLofCjIJdQLxVowqr+7UQlmO7JaXS6XpgogLgaMK5O8/CjABXmwv3LmlvGWThmhBeERmHNftLNqSoa8VJD5ftSI1G04uMmlZc0TbL7DQsTjM3kW8+hh1jrQUQGaZ63VdA/9pEqDKQhpp1Q31HJmwLWgsqxfCpQv5BZbo7/tkSStXUyGp1xetxjqlEAizCns4/VeKJDqrCELmcjeitnThDaU+RWYU0bEJtjKGgax3189jRk3qt+ObltmKMt+qGp1uEzZSkQ7M48JeOMx5rYdKXpDoQKVmZxzsIFnbARO49QAsoF8+XKFeWPEFyt+biKm4qVK8ecs8YqBp7gBffwK+yb5wGnmfoaRUdgfkJGq2Mg2V15+nlhGPAzHinFCKPLuZYjpGn0ROoVx3/wsGBGzbHwx9onSQtAxA7GDlJeTKqXYT6BdEfv5N0/1zumT92vOP7A75Bi0IiE6Haqn1blL5ZT+jGhcRO/djPyU0Y6JYcKm5mf2eyw+q7pmcuPb58m+YBSSLCR0BzKoEDWHd+m7bLKCsKNIbDduVs3obm/RmNF5LHXtCFtYEFj+Y27mW88YqQxX2pKI+q/DQcovXP/fQyVdHcBF9j/fsWMcemmogR1q5C541z5HWVw5zLfTI3cxb3u8QIrZPS+w8c3dnG/w35IjiaEjXxFTyNPRkqDZaiIVQqGPjyxAiGmvjWmAi0ctwrSpwo=
X-Forefront-Antispam-Report: CIP:193.240.239.45;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mailrelay1.diasemi.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(316002)(4326008)(186003)(42186006)(26005)(2616005)(36860700001)(82310400004)(83380400001)(6266002)(110136005)(86362001)(47076005)(336012)(8936002)(81166007)(426003)(508600001)(5660300002)(8676002)(2906002)(70206006)(107886003)(356005)(36756003)(54906003)(70586007)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: diasemi.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Nov 2021 22:10:23.3903
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d9b790bc-61b7-4481-9547-08d9b3850a51
X-MS-Exchange-CrossTenant-Id: 511e3c0e-ee96-486e-a2ec-e272ffa37b7c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=511e3c0e-ee96-486e-a2ec-e272ffa37b7c;Ip=[193.240.239.45];Helo=[mailrelay1.diasemi.com]
X-MS-Exchange-CrossTenant-AuthSource: HE1EUR02FT031.eop-EUR02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR10MB2808
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clean away information from a test that was included accidentally

Signed-off-by: Adam Ward <Adam.Ward.opensource@diasemi.com>
Acked-by: Rob Herring <robh@kernel.org>
---
 .../bindings/regulator/dlg,da9121.yaml        | 25 +++++++++----------
 1 file changed, 12 insertions(+), 13 deletions(-)

diff --git a/Documentation/devicetree/bindings/regulator/dlg,da9121.yaml b/Documentation/devicetree/bindings/regulator/dlg,da9121.yaml
index 228018c87bea..0aee5fcd6093 100644
--- a/Documentation/devicetree/bindings/regulator/dlg,da9121.yaml
+++ b/Documentation/devicetree/bindings/regulator/dlg,da9121.yaml
@@ -25,19 +25,19 @@ description: |
   the rated current, this translates across the device range to per
   channel figures as so...
 
-                               | DA9121    DA9122     DA9220    DA9217   DA9140
+                               | DA9121    DA9122     DA9220    DA9217
                                | /DA9130   /DA9131    /DA9132
-    -----------------------------------------------------------------------------
-    Output current / channel   | 10000000   5000000   3000000   6000000  40000000
-    Output current / phase     |  5000000   5000000   3000000   3000000   9500000
-    -----------------------------------------------------------------------------
-    Min regulator-min-microvolt|   300000    300000    300000    300000    500000
-    Max regulator-max-microvolt|  1900000   1900000   1900000   1900000   1000000
-    Device hardware default    |  1000000   1000000   1000000   1000000   1000000
-    -----------------------------------------------------------------------------
-    Min regulator-min-microamp |  7000000   3500000   3500000   7000000  26000000
-    Max regulator-max-microamp | 20000000  10000000   6000000  12000000  78000000
-    Device hardware default    | 15000000   7500000   5500000  11000000  58000000
+    -------------------------------------------------------------------
+    Output current / channel   | 10000000   5000000   3000000   6000000
+    Output current / phase     |  5000000   5000000   3000000   3000000
+    -------------------------------------------------------------------
+    Min regulator-min-microvolt|   300000    300000    300000    300000
+    Max regulator-max-microvolt|  1900000   1900000   1900000   1900000
+    Device hardware default    |  1000000   1000000   1000000   1000000
+    -------------------------------------------------------------------
+    Min regulator-min-microamp |  7000000   3500000   3500000   7000000
+    Max regulator-max-microamp | 20000000  10000000   6000000  12000000
+    Device hardware default    | 15000000   7500000   5500000  11000000
 
 properties:
   $nodename:
@@ -51,7 +51,6 @@ properties:
       - dlg,da9130
       - dlg,da9131
       - dlg,da9132
-      - dlg,da9140
 
   reg:
     maxItems: 1
-- 
2.25.1

