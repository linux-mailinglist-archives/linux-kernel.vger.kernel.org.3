Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C08252BEAA
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 17:26:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239165AbiERPFP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 11:05:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239087AbiERPFB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 11:05:01 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2104.outbound.protection.outlook.com [40.107.20.104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD12617704A;
        Wed, 18 May 2022 08:04:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TqBbKOxrQVoX4T42X2YdFPDOLi95Ik98QM5k4xH2e1/XkhmKGpK35cheYOT2Ph8EyKSpqQLG/08nUAeUu16crSEWwtTp0ayeNtjdrCY3QmpladSrEY98EQblWEbbtL10JrJfCXrrY2D2GzLvoKIYnUifXKAqCLGr1WmOBmkpdSaRGI7QT3xHZTMb7KsKYlp667iAMfvaAMx92lYy9Sw0ZLK1NnUNZaJDB/2YaXOZUS9bzEvP5jyKtlu7S/gXPNJm7jgUrZi7qwyvZoaXUaoP5/EKUsCgxS/Q0dfxdK4fe0FYpSkh2/AZE0ak/z1Z+xkKt8WrLU91xZyOnDQAciAJQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MgOWtc0h84OfR0/XgjFODhvBKtLJ+qAcjYntEln1lJc=;
 b=aSs0rArYWlyoYLbdsQ3JEhQnwdya+6ijIRDZZ1tG3ITZa3UOAzKYvIivxRBnQ6R72WMaeynoepJQros8JDAmt7lHRCaRgYmXchqgsV7PcZYjKDFCo/4taCuNPARxDN9/ntRinGtzF4u4DLn7DzFxR1iUWr8q+TC8SGU62UmVTI2eBXtr+KZwi74PmHxjRyoCedDBbQK2ucyubZMwkKQCH6k/MdoYOI3U0dleUXeiYRTM3cXvIzHkieUl+Ek8l2eax8gqM3Uf1jXIOSYXrcj7e/7nxAgXVxNznyr+gTIj2zkPKZ79JF/MMrFv5qmKjmAiXn8brE1tAaYpbCRRQKwbVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 193.8.40.94) smtp.rcpttodomain=kernel.org
 smtp.mailfrom=leica-geosystems.com.cn; dmarc=pass (p=quarantine sp=quarantine
 pct=100) action=none header.from=leica-geosystems.com.cn; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=leica-geosystems.com.cn; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MgOWtc0h84OfR0/XgjFODhvBKtLJ+qAcjYntEln1lJc=;
 b=Bme/Ah7+WLrJHJH/icaNBfUYG5Vd1y8CxzOdObcz6ZpPU2mff2Nxs5Mbf4V6cGVwa2AcCuoZGzAowYzyJlv74yFl8RJiVF+nP9RvAyyf1VTntOsjsNI/RzWIDvy6NfwN/4BCKUjuF8GUCoDCRn2lyul0sZn8zxv6au8H4sza6yo=
Received: from AM6P195CA0015.EURP195.PROD.OUTLOOK.COM (2603:10a6:209:81::28)
 by AM8PR06MB7075.eurprd06.prod.outlook.com (2603:10a6:20b:1d2::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.13; Wed, 18 May
 2022 15:04:57 +0000
Received: from AM5EUR02FT028.eop-EUR02.prod.protection.outlook.com
 (2603:10a6:209:81:cafe::ef) by AM6P195CA0015.outlook.office365.com
 (2603:10a6:209:81::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.14 via Frontend
 Transport; Wed, 18 May 2022 15:04:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 193.8.40.94)
 smtp.mailfrom=leica-geosystems.com.cn; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=leica-geosystems.com.cn;
Received-SPF: Pass (protection.outlook.com: domain of leica-geosystems.com.cn
 designates 193.8.40.94 as permitted sender) receiver=protection.outlook.com;
 client-ip=193.8.40.94; helo=aherlnxbspsrv01.lgs-net.com;
Received: from aherlnxbspsrv01.lgs-net.com (193.8.40.94) by
 AM5EUR02FT028.mail.protection.outlook.com (10.152.8.115) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5250.13 via Frontend Transport; Wed, 18 May 2022 15:04:57 +0000
From:   LI Qingwu <Qing-wu.Li@leica-geosystems.com.cn>
To:     jic23@kernel.org, lars@metafoo.de, mchehab+huawei@kernel.org,
        ardeleanalex@gmail.com, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, Qing-wu.Li@leica-geosystems.com.cn,
        robh+dt@kernel.org, mike.looijmans@topic.nl,
        devicetree@vger.kernel.org, thomas.haemmerle@leica-geosystems.com
Subject: [PATCH V3 6/6] dt-bindings: iio: accel: Add bmi085 and bmi090l bindings
Date:   Wed, 18 May 2022 15:04:25 +0000
Message-Id: <20220518150425.927988-7-Qing-wu.Li@leica-geosystems.com.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220518150425.927988-1-Qing-wu.Li@leica-geosystems.com.cn>
References: <20220518150425.927988-1-Qing-wu.Li@leica-geosystems.com.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 242f40e7-ae68-463b-a0db-08da38dfc5f7
X-MS-TrafficTypeDiagnostic: AM8PR06MB7075:EE_
X-Microsoft-Antispam-PRVS: <AM8PR06MB7075B035C07A5762E695B3A5D7D19@AM8PR06MB7075.eurprd06.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5E6GGuschg/U8KnwFQEHHKHp7KzNr5dwhx2Uz6HvTfP7P04Zep0w1LObea7kqzVlzyPSeOFuL7aTD0V5mD4zfeAWsngzGkcB3+x4YckZ9SzoU/dIqyMeYnoApDdR5ro5yqfo2s8iUSZznNCUdZ4U/Ws2HIUIcVFF7oZhOJ9Z5oWVWcz5Cv1iRihKtVbpg/Uvh8NfXfNrdPBgjSR+W8QaU43zniMDfnZQ3Weu+zCryfOxhVR2gojCUY7lU86eTPoszQQDD/F0SATVWTK1ER4uRC+qis2ZdmTWuBg/LuTP4DZ3QfP9np9UUtgtHHlDiymjRHp3n+I/Z/lwM+iStxgG6cRfWLf+yynXxXkBIHoeswruCwn+3nDhSssFVBjRP3ByIGrJ93L3ZyFLLj5yBy41pHXxHRqY8b/4D1ybGj6ZG3m/0KhqS2G9pKNQW3ZOsMlrWspPYqlpAE7nUPV2eae462HazlyVEtWorLay67HV4yaDPguMMzIMlHztyMUKH+sdGe8BV4Ljd/qGarsSDyzcnRtARd7xQonEad360QE2H1UPVqhUeXRbkE76ZudR/VNY2onpIk74RJ5Tg4hVdby+d5vQbeokKAGnhvfcpS4isBDe2kMUONzP4RbfuDnBTUFdUVHva529+1x5WfY+otAuyqD1BoYU3WcmG8i0QPCVKPpMw6eRWOE3cgOkKvCsgzKD5sTgwjaoRXj4ZqmpnTtOI1FZMSnzWRbAnagTMHs4rsY9U63wv4497BiEHAaLagRNfIScP0mYsgHWiBqKJ++mz7IsDwg2NXxmpU/Ys1+uXJM=
X-Forefront-Antispam-Report: CIP:193.8.40.94;CTRY:CH;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:aherlnxbspsrv01.lgs-net.com;PTR:ahersrvdom50.leica-geosystems.com;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(8936002)(6486002)(966005)(83380400001)(36756003)(6512007)(26005)(36860700001)(82310400005)(2616005)(508600001)(47076005)(186003)(316002)(6666004)(36736006)(5660300002)(336012)(956004)(118246002)(40460700003)(70586007)(70206006)(6506007)(81166007)(1076003)(8676002)(2906002)(86362001)(356005)(921005)(4744005);DIR:OUT;SFP:1102;
X-OriginatorOrg: leica-geosystems.com.cn
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2022 15:04:57.3893
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 242f40e7-ae68-463b-a0db-08da38dfc5f7
X-MS-Exchange-CrossTenant-Id: 1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a;Ip=[193.8.40.94];Helo=[aherlnxbspsrv01.lgs-net.com]
X-MS-Exchange-CrossTenant-AuthSource: AM5EUR02FT028.eop-EUR02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR06MB7075
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adds the device-tree bindings for the Bosch
BMI085 and BMI090L IMU, the accelerometer part.

Datasheet: https://www.bosch-sensortec.com/media/boschsensortec/downloads/datasheets/bst-bmi085-ds001.pdf
Datasheet: https://media.digikey.com/pdf/Data%20Sheets/Bosch/BST-BMI090L-DS000-00.pdf
Signed-off-by: LI Qingwu <Qing-wu.Li@leica-geosystems.com.cn>
---
 Documentation/devicetree/bindings/iio/accel/bosch,bmi088.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/accel/bosch,bmi088.yaml b/Documentation/devicetree/bindings/iio/accel/bosch,bmi088.yaml
index 911a1ae9c83f..272eb48eef5a 100644
--- a/Documentation/devicetree/bindings/iio/accel/bosch,bmi088.yaml
+++ b/Documentation/devicetree/bindings/iio/accel/bosch,bmi088.yaml
@@ -17,7 +17,9 @@ description: |
 properties:
   compatible:
     enum:
+      - bosch,bmi085-accel
       - bosch,bmi088-accel
+      - bosch,bmi090l-accel
 
   reg:
     maxItems: 1
-- 
2.25.1

