Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CD1747DEEC
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Dec 2021 07:10:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346544AbhLWGKH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Dec 2021 01:10:07 -0500
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:28034 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233648AbhLWGKG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Dec 2021 01:10:06 -0500
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 1BN3qOP8005437;
        Wed, 22 Dec 2021 22:09:57 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=proofpoint;
 bh=LxhFqcql4Dg9Uel4uwEVR1Th6ctjD9b+FSHFKo8jkCk=;
 b=VhkE5cBR8g2ewws8KSQMZAG1xkXg+n47TKu8dJ0OD2DUOXy/NIYqZoh7r1jAr0I9cFTo
 xqKIkwqiG21WaMwWfpI6MsDxAFihz7atDBKnd6mfCTcVujVHIajrMwg5MWiGuGA1g3U7
 cQE0+3TT8YLJV5+a8W/ImTUtoeEUhTvk3kjOciOqROvBpKQvLMwjVdLfe5syLmehtIz9
 FqA12+kM38FU7/BTK5o8sSfP9dY+qpUuy3t/7OoCDwgYKs0k7RRdXCxj4RuvnhnPx5lv
 GiUn7EV6AjGILC+4wHqgqdb3lwUx7SPd3MuE32OIfMGCRbjZ6s4LlTdJoTSjwiLQKr+I 7A== 
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
        by mx0a-0014ca01.pphosted.com (PPS) with ESMTPS id 3d3rwxvk7a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 22 Dec 2021 22:09:56 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rjxijnf5mR+za2hvL2wI+vG3RqO1BYRBmwTHnd8ijDYEvhheeaiFF0cMaY+Drjwt+bLfrq6l5j0z16RJ8XaWpt66v2aLoqfb77ypnDrIpLWNXD0G9/rwc30ZF4dWzAnjVC33Fxn8LRLrFf7RpsqSvcXyRFfrmjEii5jaw6LztOR+ezc4iTN6LDjMMsvq9nRgBahkyXej73FP3Jes/gpKVwlAdv2PcsiS1yuoOIO4fjG5PzlJpqHIMOJVhBijaNSXnKSZ+fiUNvOukOaZuZRphq7Kab2JT7p/9Kj7gYfzCZgKTxRTBsv2RsHWIbjH1nF4iTjMncZLCU5nmR6+W0+DaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LxhFqcql4Dg9Uel4uwEVR1Th6ctjD9b+FSHFKo8jkCk=;
 b=lVuvpB0y9RC07ctsxr7dmkXG9Rhi+xzgNlIui1XzkDPAd59UrsI874zeh3HyTNw2lMi0/lgW9ArUGuC/q/GB6kdYKldF+LlaEfsoD9eb/RAmRMVacRqExXH/sd8GddvG5iMawPxvQttVSAtnoVnrXltlrxlRLeUx9reAj/0RHNQxuS/KFhN+uokS3azLDCO52ean4LZSOw+ub9REKCR5JGLfqSK4HnuTORi9irUIongvt74fcHcqEYTaAqjlk6Vyen8ZjoKBdK0sBXcgCL+UZ6kAFdt2/3/1UVeBRW9xw9HWwOIdVYsOkFzIwN+A1wMrFs8cHLmWddAR6rtyP4SirQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 158.140.1.148) smtp.rcpttodomain=kernel.org smtp.mailfrom=cadence.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=cadence.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LxhFqcql4Dg9Uel4uwEVR1Th6ctjD9b+FSHFKo8jkCk=;
 b=dkPLIGcdLh7InZDwVsmQh/J/V62hXod/AoAGQTi0uSQPZxPe4/ycegIrXfnTXN2u/UtWTjRlGJMNixpAySLupoWkwuruXjsquMnzdoscIIeDh+9YygCVJvNhrNSp9+9Tq4h/21POjkp4B9etnzz1hNV8iV3JsE9QzmWj2Kk2YAU=
Received: from BN6PR13CA0021.namprd13.prod.outlook.com (2603:10b6:404:10a::31)
 by CH2PR07MB6597.namprd07.prod.outlook.com (2603:10b6:610:2c::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.17; Thu, 23 Dec
 2021 06:09:51 +0000
Received: from BN8NAM12FT010.eop-nam12.prod.protection.outlook.com
 (2603:10b6:404:10a:cafe::c9) by BN6PR13CA0021.outlook.office365.com
 (2603:10b6:404:10a::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4823.18 via Frontend
 Transport; Thu, 23 Dec 2021 06:09:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 158.140.1.148)
 smtp.mailfrom=cadence.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=cadence.com;
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 158.140.1.148 as permitted sender) receiver=protection.outlook.com;
 client-ip=158.140.1.148; helo=sjmaillnx2.cadence.com;
Received: from sjmaillnx2.cadence.com (158.140.1.148) by
 BN8NAM12FT010.mail.protection.outlook.com (10.13.182.62) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4844.7 via Frontend Transport; Thu, 23 Dec 2021 06:09:51 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by sjmaillnx2.cadence.com (8.14.4/8.14.4) with ESMTP id 1BN69o4j021863
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 22 Dec 2021 22:09:51 -0800
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu4.global.cadence.com (10.160.110.201) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 23 Dec 2021 07:09:25 +0100
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu4.global.cadence.com (10.160.110.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Thu, 23 Dec 2021 07:09:25 +0100
Received: from vleu-orange.cadence.com (10.160.88.83) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1497.2 via Frontend Transport; Thu, 23 Dec 2021 07:09:25 +0100
Received: from vleu-orange.cadence.com (localhost.localdomain [127.0.0.1])
        by vleu-orange.cadence.com (8.14.4/8.14.4) with ESMTP id 1BN67n1e016075;
        Thu, 23 Dec 2021 07:08:21 +0100
Received: (from sjakhade@localhost)
        by vleu-orange.cadence.com (8.14.4/8.14.4/Submit) id 1BN67n4S016074;
        Thu, 23 Dec 2021 07:07:49 +0100
From:   Swapnil Jakhade <sjakhade@cadence.com>
To:     <vkoul@kernel.org>, <kishon@ti.com>, <robh+dt@kernel.org>,
        <p.zabel@pengutronix.de>, <linux-phy@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
CC:     <mparab@cadence.com>, <sjakhade@cadence.com>, <a-govindraju@ti.com>
Subject: [PATCH v4 04/15] dt-bindings: phy: cadence-sierra: Add binding to specify SSC mode
Date:   Thu, 23 Dec 2021 07:01:26 +0100
Message-ID: <20211223060137.9252-5-sjakhade@cadence.com>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20211223060137.9252-1-sjakhade@cadence.com>
References: <20211223060137.9252-1-sjakhade@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d0c5753a-ec23-4a30-8de8-08d9c5dad4e9
X-MS-TrafficTypeDiagnostic: CH2PR07MB6597:EE_
X-Microsoft-Antispam-PRVS: <CH2PR07MB65977F88367BC232D39F43C7C57E9@CH2PR07MB6597.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1peBVXcCpGI9h3yyKV793qtTAu/B/NHOPfCJcnzn2Ga/6Alj7PKHQEoZ4XLzwOuGKROZriaHf5RD37aVOCtMcTHoCjZPjTo0j3fDegT845zphnYUBePulwu8xwJy+Gek2Itol2WBVngHWM0dh5+PRmzvmgM7IaMlB7wRG6+yyGRPKqteL3aIJLaaGaF3eP99WtXheTRm6BXVh+Zp8/fn3byRsrwfcMOw5qN51S+00n3ytiJM5h6UdGi3OGjI1857RqdLtjnVPbsvDxICK0KOTO/fkqDs5LOwNkCieUgmThf2y36lavDdJUsJyXq3uvGAMUeyIB+UXkNy2YngNLF6cCVABdtcPqqvfbdslIUPM4jBYdRbJkDpTzKDoC5wIC6fq02COG2fzdwj+dqMgftoqqotS8/+KQP9qzSJS6B06w6YXnvirsN+JjSnT/QgJ6eUEvWNlVyXGIBbgiLYq2mZAPsNZOJtIYk7GLqCQE9rUA2D4+uo/MbPmjchITtjWBlzGnpw3FTgCtR0mcJJfPnrKT4Wrm8kBmQsnt8/cFImtcg/9ov+A3sq97iUPVObvxQ5QYudDZ0HvzO3ZpUIkcGjFdXg0OU2Lgjp6CivYUwvcN2+FXxecjMrTJqPwdPJ9a93/B8On1GEQF3bouKo2eXGvBARjnSrw2oaza/sqnrCK92uJQTaFF58AUtfb9K24x9RuSlNvR++ueS6AwtOdwoH5bhpldZvF1DtiC/0aoEhdJZHFuDQqoH82s+F/eZ+q6baJ3a6DUpcErlya3zeLahLMNEyN3auE1r9+fqMGas5k1Y=
X-Forefront-Antispam-Report: CIP:158.140.1.148;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:sjmaillnx2.cadence.com;PTR:unknown.Cadence.COM;CAT:NONE;SFS:(4636009)(36092001)(40470700002)(36840700001)(46966006)(36860700001)(36756003)(5660300002)(186003)(1076003)(70586007)(4744005)(40460700001)(83380400001)(26005)(7636003)(2906002)(356005)(336012)(86362001)(4326008)(508600001)(6666004)(42186006)(47076005)(8936002)(316002)(426003)(8676002)(70206006)(110136005)(54906003)(82310400004)(2616005);DIR:OUT;SFP:1101;
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Dec 2021 06:09:51.3848
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d0c5753a-ec23-4a30-8de8-08d9c5dad4e9
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[158.140.1.148];Helo=[sjmaillnx2.cadence.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM12FT010.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR07MB6597
X-Proofpoint-ORIG-GUID: vzzDXM635vdlbk8IqQtwF_sdB8M44a8f
X-Proofpoint-GUID: vzzDXM635vdlbk8IqQtwF_sdB8M44a8f
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-23_01,2021-12-22_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0
 lowpriorityscore=0 mlxlogscore=999 spamscore=0 priorityscore=1501
 adultscore=0 bulkscore=0 mlxscore=0 phishscore=0 suspectscore=0
 clxscore=1015 impostorscore=0 malwarescore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2112230034
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add binding to specify Spread Spectrum Clocking mode used.

Signed-off-by: Swapnil Jakhade <sjakhade@cadence.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/phy/phy-cadence-sierra.yaml      | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/Documentation/devicetree/bindings/phy/phy-cadence-sierra.yaml b/Documentation/devicetree/bindings/phy/phy-cadence-sierra.yaml
index e71b32c9c0d1..a9e227d8b076 100644
--- a/Documentation/devicetree/bindings/phy/phy-cadence-sierra.yaml
+++ b/Documentation/devicetree/bindings/phy/phy-cadence-sierra.yaml
@@ -113,6 +113,15 @@ patternProperties:
         minimum: 1
         maximum: 16
 
+      cdns,ssc-mode:
+        description:
+          Specifies the Spread Spectrum Clocking mode used. It can be NO_SSC,
+          EXTERNAL_SSC or INTERNAL_SSC.
+          Refer include/dt-bindings/phy/phy-cadence.h for the constants to be used.
+        $ref: /schemas/types.yaml#/definitions/uint32
+        enum: [0, 1, 2]
+        default: 1
+
     required:
       - reg
       - resets
-- 
2.26.1

