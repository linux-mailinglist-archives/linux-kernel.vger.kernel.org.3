Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B44D05003E0
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 03:56:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239569AbiDNB5u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 21:57:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239559AbiDNB5q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 21:57:46 -0400
Received: from mx0a-000eb902.pphosted.com (mx0a-000eb902.pphosted.com [205.220.165.212])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA7DC30577;
        Wed, 13 Apr 2022 18:55:20 -0700 (PDT)
Received: from pps.filterd (m0220296.ppops.net [127.0.0.1])
        by mx0a-000eb902.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 23E1nLvg019595;
        Wed, 13 Apr 2022 20:55:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garmin.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=pps1;
 bh=KFzosNNl5L0GrINdb6073OilQ/q5YHIkvwFf1huv/m8=;
 b=aa8mJVvdG1meRqqxv67WXAs9rfikD/McM0yOOMriumyloSKxOwDdoGQ/v7T3M7yB0ut0
 oyoFSniWBWo6lPEZK6bQ791y/8SNBS6aLsa6+O4Z4QH5ArQUmFtzG9gscUcWUPsTsaq0
 ahh4H0LxvmsXxWQ8cFBwAjzRhmPUI/md7WMh197WmPDPofi9KGVQYd1c8t8P09Va0NKw
 laUVkC0EeX8+33vifmTDBPBN045vc+5WksL2jQoQR1CyBOVjYA9EmvMcMJcK2ThOD587
 zkIKFd7gemO66AJKLzntFn9YMB1qDnQKilyk5Fhq/QTk78yDlHpLQdOtHf+OAskRDiZv /A== 
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1anam02lp2042.outbound.protection.outlook.com [104.47.57.42])
        by mx0a-000eb902.pphosted.com (PPS) with ESMTPS id 3fb7h2g64w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 13 Apr 2022 20:55:17 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JvyYS4V+0GyEnIdBPvqaalcVZ+STeYnL48MjEZs0iBNgOInXWUqKpk3pHhIcDPqYZ9weGKY7ytf5xed2laUZkoWQhtst4JDZWq6OKP1AbMUAg7HsIb6ZBlt95YvuNrH9QhN3LnMUif/R8d1nvknUKWVcax+V5X/HRCmsLWGwcAcziDRVCbQoSEuws3xzZ3Qowjp3yuAa8h4qQTIMxldWpax5Orj7YG6PYse9vKRv4yyNxBHylqaTqYpMlsdMkEplHgXH24FRe8LO2FJl4zSk1dLSmMYSGn3E6U7Q/7WA66jwC32XasroG0746McVyBO7en6FTH1itvcCm+9rsgKisg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KFzosNNl5L0GrINdb6073OilQ/q5YHIkvwFf1huv/m8=;
 b=A/npP0tyg7aNIuVL9+hzfgiYpWHXcrhzk9KaLuwRPh71IwNiSgoZl46rvAmGKkPlfH5VBz0cZhGEpsFexA+Wsn6UWWgitUv9WHbwlQ6u5aGoFw9Em+VG2c5oNpdnxm7cCYOuQME3Bcosn92UC7tZdS1T9pZQyCwt35Cung9BweWJwGaY4yNqLv2wpXtINLRJgzjN0uQo+4p/CGdZN3bFDw2JjgEsMo+r4cwLIYA2iTQe90aVPB1NPojFRMQMTWjOQmYcrRfcRBMfOzGjCkCzjTH+4m7lGJLf5yYT+XuFNRpi4giLVoQJ/hjpGjHUG+2Kmx64WQqMhdIYwk7U319qgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 204.77.163.244) smtp.rcpttodomain=gmail.com smtp.mailfrom=garmin.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=garmin.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garmin.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KFzosNNl5L0GrINdb6073OilQ/q5YHIkvwFf1huv/m8=;
 b=KaUnxgd+uuhOFL66vqmv1rcpF+EvOQWnPjDOmjgJZZ19pf4em/nx2UOydrXttT+bx4xYsfF+nNC71QRKEuwtL8ExhpFC5iB1IAZz+Bj9+Ummefl0HS7bbumXGIW0xwhpbbJgGAvp1KzUloLUkMhGh23eVG5BP4WzE/rpTsZ3bPClfQyZtB3jlhTEWHi71PMtRuBhVFnH8rfpRgKyABAzRNoN6bEJrpFrWjZS3yonAwqCrU59X1ynRfi0kQTVdiuwP3v7cZXb5QmrHdvoObWYqgntqrWtJGbvU+NN3fYa8qu3eJblIMujzUDTby+zHUr1eEc52mx5CnVzGn22EHC4IA==
Received: from DS7PR03CA0114.namprd03.prod.outlook.com (2603:10b6:5:3b7::29)
 by BY5PR04MB6804.namprd04.prod.outlook.com (2603:10b6:a03:229::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.30; Thu, 14 Apr
 2022 01:55:15 +0000
Received: from DM6NAM10FT037.eop-nam10.prod.protection.outlook.com
 (2603:10b6:5:3b7:cafe::13) by DS7PR03CA0114.outlook.office365.com
 (2603:10b6:5:3b7::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.26 via Frontend
 Transport; Thu, 14 Apr 2022 01:55:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 204.77.163.244)
 smtp.mailfrom=garmin.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=garmin.com;
Received-SPF: Pass (protection.outlook.com: domain of garmin.com designates
 204.77.163.244 as permitted sender) receiver=protection.outlook.com;
 client-ip=204.77.163.244; helo=edgetransport.garmin.com;
Received: from edgetransport.garmin.com (204.77.163.244) by
 DM6NAM10FT037.mail.protection.outlook.com (10.13.153.29) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5164.19 via Frontend Transport; Thu, 14 Apr 2022 01:55:14 +0000
Received: from OLAWPA-EXMB1.ad.garmin.com (10.5.144.23) by
 olawpa-edge5.garmin.com (10.60.4.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Wed, 13 Apr 2022 20:55:08 -0500
Received: from cv1wpa-exmb2.ad.garmin.com (10.5.144.72) by
 olawpa-exmb1.ad.garmin.com (10.5.144.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 13 Apr 2022 20:55:13 -0500
Received: from OLA-DKH2RP2.ad.garmin.com (10.5.209.17) by smtp.garmin.com
 (10.5.144.72) with Microsoft SMTP Server id 15.1.2375.24 via Frontend
 Transport; Wed, 13 Apr 2022 20:55:13 -0500
From:   Shelby Heffron <Shelby.Heffron@garmin.com>
To:     <dmitry.torokhov@gmail.com>
CC:     <linux-input@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Shelby Heffron" <Shelby.Heffron@garmin.com>
Subject: [PATCH] [V3] input: Add Marine Navigation Keycodes
Date:   Wed, 13 Apr 2022 20:53:56 -0500
Message-ID: <20220414015356.1619310-1-Shelby.Heffron@garmin.com>
X-Mailer: git-send-email 2.35.2
In-Reply-To: <20220126211224.28590-1-Shelby.Heffron@garmin.com>
References: <20220126211224.28590-1-Shelby.Heffron@garmin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 46fe9a40-3d95-4366-ad36-08da1db9d19f
X-MS-TrafficTypeDiagnostic: BY5PR04MB6804:EE_
X-Microsoft-Antispam-PRVS: <BY5PR04MB6804FD142812C6BFD6D76180F2EF9@BY5PR04MB6804.namprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6dKEFO2LmVbwRszM/arVOv5LY4Er8BzzXYSZzHD7qmmNBvBsPVTvhN19Z80s+3jl6xGIZRhzGSMVtSL79FKmYD1HDztE3RZPyw+N/qS37z9qpws0fmeuDS8tk01W6mpmgMLiajLsmQCHJoiVhhZ2ZZlpKjWP9/WSoQ9klyJVXMxSSg43vl1Q3dhuUX6uKQ9tQraOOMoNL+maUmuamFMQvsO+svacQCKgDNlSwOb6CzNYcdZcrx8BmwjpnVxjfkHgDaxjl8VF+NGAUWwNwM4OBTN3nNTM9S2wMAANqkVXzGFXSObzNoLMQGeyajcLVLQ2qDs+axl7zDn0rQx6SSEnLgcqEDedPugEnXLqN4t3YCyNbP9HtOgjFvIIqKwh8LdqVSkz4ro8+qiKWLH8me0f3+u+K+ibfVonLJlsILAakSFDKuBNN8r5rhhvUD5CNpWbuwPGTCwWS8K53v4EHvnQsaOpgQdw5DzdPXDIvglwqyMSiJQ97XvlbUtLFU0Iuutp/g/pUpWei41C96Opse38HYRsk/RI9OCM5xz4KjrpHSiqkuMg5GjYpA0IEK2g4CNrfZo2/R3v9YtGrr/iz32OJ6dSZu++d+356JRNAXTBO2QkEhpqYMNSlfzb4MhErmILtZ0nyjqe/eRX0pZ5sDK2056QK432HFP2afwAFozhZouBSxK1nLUsan1+qOXptyEiZ16wpQYEoxhlvlCRIKeNig==
X-Forefront-Antispam-Report: CIP:204.77.163.244;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:edgetransport.garmin.com;PTR:extedge.garmin.com;CAT:NONE;SFS:(13230001)(40470700004)(46966006)(36840700001)(66574015)(186003)(7636003)(70206006)(6666004)(34020700004)(26005)(2906002)(86362001)(356005)(54906003)(6916009)(8936002)(4326008)(47076005)(336012)(426003)(36756003)(316002)(1076003)(70586007)(7696005)(5660300002)(8676002)(83380400001)(82310400005)(508600001)(107886003)(36860700001)(40460700003)(2616005);DIR:OUT;SFP:1102;
X-OriginatorOrg: garmin.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2022 01:55:14.8467
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 46fe9a40-3d95-4366-ad36-08da1db9d19f
X-MS-Exchange-CrossTenant-Id: 38d0d425-ba52-4c0a-a03e-2a65c8e82e2d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=38d0d425-ba52-4c0a-a03e-2a65c8e82e2d;Ip=[204.77.163.244];Helo=[edgetransport.garmin.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM10FT037.eop-nam10.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR04MB6804
X-Proofpoint-ORIG-GUID: AJBsRuR8DiPrJMZuACHewdzMNqnXr6wK
X-Proofpoint-GUID: AJBsRuR8DiPrJMZuACHewdzMNqnXr6wK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-04-13_04,2022-04-13_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 impostorscore=0
 mlxlogscore=938 suspectscore=0 malwarescore=0 clxscore=1011 spamscore=0
 mlxscore=0 phishscore=0 priorityscore=1501 bulkscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2204140008
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add keycodes that are used by marine navigation devices

Signed-off-by: Shelby Heffron <Shelby.Heffron@garmin.com>
---
 include/uapi/linux/input-event-codes.h | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/include/uapi/linux/input-event-codes.h b/include/uapi/linux/in=
put-event-codes.h
index 7989d9483ea7..ec1daa459fd4 100644
--- a/include/uapi/linux/input-event-codes.h
+++ b/include/uapi/linux/input-event-codes.h
@@ -662,6 +662,27 @@
 /* Select an area of screen to be copied */
 #define KEY_SELECTIVE_SCREENSHOT       0x27a

+/* Move the focus to the next or previous user controllable element within=
 a UI container */
+#define KEY_NEXT_ELEMENT               0x27b
+#define KEY_PREVIOUS_ELEMENT           0x27c
+
+/* Toggle Autopilot engagement */
+#define KEY_AUTOPILOT_ENGAGE_TOGGLE    0x27d
+
+/* Shortcut Keys */
+#define KEY_MARK_WAYPOINT              0x27e
+#define KEY_SOS                                0x27f
+#define KEY_NAV_CHART                  0x280
+#define KEY_FISHING_CHART              0x281
+#define KEY_SINGLE_RANGE_RADAR         0x282
+#define KEY_DUAL_RANGE_RADAR           0x283
+#define KEY_RADAR_OVERLAY              0x284
+#define KEY_TRADITIONAL_SONAR          0x285
+#define KEY_CLEARVU_SONAR              0x286
+#define KEY_SIDEVU_SONAR               0x287
+#define KEY_NAV_INFO                   0x288
+#define KEY_BRIGHTNESS_MENU            0x289
+
 /*
  * Some keyboards have keys which do not have a defined meaning, these key=
s
  * are intended to be programmed / bound to macros by the user. For most
--
2.35.2


________________________________

CONFIDENTIALITY NOTICE: This email and any attachments are for the sole use=
 of the intended recipient(s) and contain information that may be Garmin co=
nfidential and/or Garmin legally privileged. If you have received this emai=
l in error, please notify the sender by reply email and delete the message.=
 Any disclosure, copying, distribution or use of this communication (includ=
ing attachments) by someone other than the intended recipient is prohibited=
. Thank you.
