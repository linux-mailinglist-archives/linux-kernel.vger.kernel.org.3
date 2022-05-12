Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17EA95251DA
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 18:04:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356177AbiELQD1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 12:03:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356154AbiELQDU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 12:03:20 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2139.outbound.protection.outlook.com [40.107.21.139])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A075B62233;
        Thu, 12 May 2022 09:03:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XaWJbqE8KC/jPnV8GEmTG+/icVx0drvSoMdx9ofxqmbFoAFkYm4qVxpC3x+EjHjOIgZ2ULCAqWGTnmPDXSXkDygW78JKI68TUoVv1Vsn2spOU73Nd/ttGqQoNeMjIcz2WYVy4cwYs6D2aosH8AEpjRln8iYMvHMk0CGdK84SCC2YhqzqtQUkZI0Jc5yyjwnYS2AMGQjWqQ9fGjko8U0d3houGst4dU0Ac74heV8bLNEykMtS29PcGG2yZePZfUOKpAl0mMCyK40apnUOn+ijjrXqJ0GYdEBJ5y38BOjcW/CMfM0AXAPZaJNy/jz1kDsNB4abB30GPTDGSW5YWtKx8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TWyboIrdYD+ljLTP4HrSw7NQIrQARonA1zfvP7cD5ZA=;
 b=L+pCajcbpC7mP9Wdcjmtkgk8lKVDEagb3hI8vEmhZ7sHIOWJJzH3bYutzdPwdeV8qkmaaH35NAOFxrLuPCq8zsg9Cf0aayE333nNoVovfuWkpcJNk3xn1D/QPy+lAHlbviS+sH9lPujM0Fr5vTckePYikw9Ueckkm7tboWi91/RQQErKWmd+5XJcW59T+DSDG0tKW8ATgW0TLI77QxfIWO1SAQweCX5ZoGUQZ+Tjy0qJ6eUDjybUJtsG74dCRmhNTc9wq1tIJE62cpmpK9yHNpkpYf53hNH59+zkWpgOyHEUuGtuqsEqvXYCNTh10xeGQYql/SlZ1UvLUy3WwF/dbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 193.8.40.94) smtp.rcpttodomain=kernel.org
 smtp.mailfrom=leica-geosystems.com.cn; dmarc=pass (p=quarantine sp=quarantine
 pct=100) action=none header.from=leica-geosystems.com.cn; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=leica-geosystems.com.cn; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TWyboIrdYD+ljLTP4HrSw7NQIrQARonA1zfvP7cD5ZA=;
 b=0g4EQLqbYZKZCLKmB8h+5GVdCedoV5w1fao0+0c3QI8Fu+M/Xv+ytjrUgfMpPg0ItR+Z2AYc2ObNoYRSQ19lACSMZ4mrQcX7lHqngYSelHy2MLJCPvL1PD6Z3wszNJ4MG9LIV4ONx2BHBSUjdkrWAYitmyjgYk1cBCqDixBTkxc=
Received: from OL1P279CA0038.NORP279.PROD.OUTLOOK.COM (2603:10a6:e10:14::7) by
 DB7PR06MB4361.eurprd06.prod.outlook.com (2603:10a6:5:2c::29) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5227.22; Thu, 12 May 2022 16:03:16 +0000
Received: from HE1EUR02FT005.eop-EUR02.prod.protection.outlook.com
 (2603:10a6:e10:14:cafe::c0) by OL1P279CA0038.outlook.office365.com
 (2603:10a6:e10:14::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.14 via Frontend
 Transport; Thu, 12 May 2022 16:03:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 193.8.40.94)
 smtp.mailfrom=leica-geosystems.com.cn; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=leica-geosystems.com.cn;
Received-SPF: Pass (protection.outlook.com: domain of leica-geosystems.com.cn
 designates 193.8.40.94 as permitted sender) receiver=protection.outlook.com;
 client-ip=193.8.40.94; helo=aherlnxbspsrv01.lgs-net.com;
Received: from aherlnxbspsrv01.lgs-net.com (193.8.40.94) by
 HE1EUR02FT005.mail.protection.outlook.com (10.152.10.99) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5250.13 via Frontend Transport; Thu, 12 May 2022 16:03:14 +0000
From:   LI Qingwu <Qing-wu.Li@leica-geosystems.com.cn>
To:     jic23@kernel.org, lars@metafoo.de, robh+dt@kernel.org,
        tomas.melin@vaisala.com, andy.shevchenko@gmail.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Qing-wu.Li@leica-geosystems.com.cn
Cc:     linux-iio@vger.kernel.org
Subject: [PATCH V5 0/5] iio: accel: sca3300: add compatible for scl3300
Date:   Thu, 12 May 2022 16:03:07 +0000
Message-Id: <20220512160312.3880433-1-Qing-wu.Li@leica-geosystems.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 647fd6d6-8cd7-4f12-8a45-08da3430ec34
X-MS-TrafficTypeDiagnostic: DB7PR06MB4361:EE_
X-Microsoft-Antispam-PRVS: <DB7PR06MB4361D1811CAB80BF387E9D08D7CB9@DB7PR06MB4361.eurprd06.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zeHnwAaifKR6jKg/2qqFZoBBhsEPCbHYu4lC6xX9rmlqYWqehLwXupUIXHTltDR+vAHsj2iZpJaVpTKizMDa/9k5rg74X5hvmK1I1dD3p2w0ggMtf+zNAaVUddm/UpM44v1YGecyW+ppejOh0WRXwQp6fDIZFJoK+ZQ+HHXXPw1czF/HyYKv9bCNumPCXqv3PB3cMSHEgsNM0Xba1xyiToc2Zjz2F13YPAAR3ihWdwaKia9XfhLTS+hLpEdgqzpaJCvG/qXyBR0YtoJOmQK7ylAla6ODCJ0+jFgFOig83t1ofShnWzlYYoJZCKb9g1ArZKJKmgdNTmuh8I7VB4Rj0Whviur0VQgFcGxTazBQQVER4Hw/R17j9THzzaxTT1ffsTIx4Ukf6y3bAWMJqHrCgeJ5oIm9MObP+7fIo2kVWNS+LDAblKcujald94RpVA6iuWj5kT8yYBfckvKjnAy3HEi53wAZ4kNi7IJ4y20nFBsdR2/DcopfRPICTISQTigP8citE6COxjp3zW2vOWgc9nnLwQHNKFJtFTV5M8qWng5zc2Y5dPl1s0qPY7RM1lBv1n+25wu/gXkhutKcuL10xL++KyeVLgq0gP0NkNIA0VYAjmf1ulAkJ3m8sXwanb+jdVG+CZCINQJcWtRWY7TkLuo47fwCabhuNYYvguo1+cKMhEPKERC3WFK0Py7UpNll
X-Forefront-Antispam-Report: CIP:193.8.40.94;CTRY:CH;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:aherlnxbspsrv01.lgs-net.com;PTR:ahersrvdom50.leica-geosystems.com;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(36736006)(2906002)(6486002)(86362001)(70206006)(70586007)(26005)(508600001)(4744005)(8936002)(5660300002)(36756003)(1076003)(956004)(4326008)(8676002)(6512007)(2616005)(356005)(81166007)(82310400005)(83380400001)(336012)(118246002)(47076005)(186003)(40460700003)(316002)(6506007)(36860700001)(6666004);DIR:OUT;SFP:1102;
X-OriginatorOrg: leica-geosystems.com.cn
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2022 16:03:14.7443
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 647fd6d6-8cd7-4f12-8a45-08da3430ec34
X-MS-Exchange-CrossTenant-Id: 1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a;Ip=[193.8.40.94];Helo=[aherlnxbspsrv01.lgs-net.com]
X-MS-Exchange-CrossTenant-AuthSource: HE1EUR02FT005.eop-EUR02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR06MB4361
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current driver support sca3300 only, modified to support SCL3300.
Verified with SCL3300 on IMX8MM.

SCL3300 is a three-axis accelerometer sensor with angle output, 
the change adds the support of scl3300 and inclination data output.
 
Change in V5:
Fix review findings in V5, reorder variables in the struct
sca3300_chip_info declaration and assignment.
Return errors first in the "for" loop code.


LI Qingwu (5):
  dt-bindings: iio: accel: sca3300: Document murata,scl3300
  iio: accel: sca3300: add define for temp channel for reuse.
  iio: accel: sca3300: modified to support multi chips
  iio: accel: sca3300: Add support for SCL3300
  iio: accel: sca3300: Add inclination channels

 .../bindings/iio/accel/murata,sca3300.yaml    |   1 +
 drivers/iio/accel/sca3300.c                   | 312 +++++++++++++++---
 2 files changed, 260 insertions(+), 53 deletions(-)

-- 
2.25.1

