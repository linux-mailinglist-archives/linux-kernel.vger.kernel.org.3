Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D4134A97C3
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 11:30:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353231AbiBDKaE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 05:30:04 -0500
Received: from mail-bn8nam12on2089.outbound.protection.outlook.com ([40.107.237.89]:42944
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229851AbiBDKaC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 05:30:02 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F1ZCHgwhA3szNajDPEHDqNdpNDPCBO5x8HNdqSxVEeGcy5ZA24WiA8HzByHV3yG0zc2l2/SnQxH0oqsOT33Z3ejsN5ZJZf3N0T6lS2qAO9nIp++aBkkG4+zEuVVxWri4c5l0jhO5M5mCyNEef8oCNyUJdXHpmrXmta9B44CMtrkk+bM5uMrbe20o/27oRAssaQ4S1YzK+85grVt5lTXtZZ1xJPuSVTTk4mdxMI1m3UrqsqD8kQ+KasTaIiOi2ttVe0DzibbqNPDlFuR/7LfXI9C6atzL2oQI5p8g68n9r/3NYjcBR2bGXRa77KbYHcC0kyrz7XchFt7tuFY3YOYUKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2sWgBZ5DuDnl4xixt2e5bzVuQ4XzbIBC9bpMRUqDb6c=;
 b=IW8k43t1evvG7DIz8sO5yg7mErQVo+Okn4OEss/ZGsgBcQRv9o1RLQQNsqXIv0BhNyra04HNwy1QNwV9zIop+GUfFaJ5jRj17JfSIiA09exYXNVQ06i3MWhpZyvzicUEmYTDD4WI/vM/LAFcaBb0C6SyIFZTWxKs3GyWgx4BkcjNeFksTOdR8tP3xH8pOZZ19CQcen9ypD50MilgNkBz40xljPF4Hv+Icc3nlFGFjYKp/yrfdpLQUvqPPaVUd99qPKMTcwdHDx3KnmIfE46R6WUr63Y3lkZZti+bFjOOd4FfBoCwK5pUSVqj7NAJCof5B+xWlGOKkvQ2cbKX2eAG9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.236) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2sWgBZ5DuDnl4xixt2e5bzVuQ4XzbIBC9bpMRUqDb6c=;
 b=lEVTB19/wl+OwHh9SEJVcwjXitrZL6dklpQBMl3cngQ8z0rkl3H23mtYkuuabFu5cx23JJtUAZ0snYzQtjTSPny+I4ZBKBodQ8+pj7P5W0Mj5/y5w6gor13qLiEdXgLhqDyph/Iq/L+rU6revuO1UHiGW5L087wvTBlnP866fj253yhGV9foJtxg3Im8GOhss3p2tYov3vNVjIgxlU4mCCIQJIOqmg5kL+ZSAv79iQC+PvFejeGF59YaTNsd0Z6Jc/c5esVyLH8mWOPdXhD7IvlCrnDaUugKeo6d9B9Yjefrr9hAHoqgAX311q5b9iH62icOxk3V8SV2ARX3n53KGQ==
Received: from BN1PR14CA0025.namprd14.prod.outlook.com (2603:10b6:408:e3::30)
 by MN2PR12MB3087.namprd12.prod.outlook.com (2603:10b6:208:d2::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.19; Fri, 4 Feb
 2022 10:30:00 +0000
Received: from BN8NAM11FT034.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e3:cafe::c3) by BN1PR14CA0025.outlook.office365.com
 (2603:10b6:408:e3::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12 via Frontend
 Transport; Fri, 4 Feb 2022 10:30:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.236)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.236 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.236; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.236) by
 BN8NAM11FT034.mail.protection.outlook.com (10.13.176.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4951.12 via Frontend Transport; Fri, 4 Feb 2022 10:30:00 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by DRHQMAIL109.nvidia.com
 (10.27.9.19) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Fri, 4 Feb
 2022 10:29:55 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.9; Fri, 4 Feb 2022
 02:29:54 -0800
Received: from kyarlagadda-linux.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server id 15.2.986.9 via Frontend
 Transport; Fri, 4 Feb 2022 02:29:51 -0800
From:   Krishna Yarlagadda <kyarlagadda@nvidia.com>
To:     <broonie@kernel.org>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <linux-spi@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>
CC:     <skomatineni@nvidia.com>, <ldewangan@nvidia.com>,
        <robh+dt@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <p.zabel@pengutronix.de>,
        Krishna Yarlagadda <kyarlagadda@nvidia.com>
Subject: [PATCH 0/6] Tegra QUAD SPI combined sequence mode
Date:   Fri, 4 Feb 2022 15:59:30 +0530
Message-ID: <1643970576-31503-1-git-send-email-kyarlagadda@nvidia.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b3072d96-665c-4758-d294-08d9e7c94c27
X-MS-TrafficTypeDiagnostic: MN2PR12MB3087:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB30877F7F356A482E7BC94C1BC3299@MN2PR12MB3087.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3173;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Li9ECOM5Ow7MAK8m1e+5i3QTzXMZIo0RkzGZ0gyZpy8iH2fu84yeff1Hv7u8ltgW7BV7kCMEJ9TtAF7IMWXD0113uvyM0iaagSWHhMrP/KKueFPgNUE90AosFvIkokNmJHEuna3L9wDzfKv8kiGtH5r7gYOKF3AlYLyy1R4XZIXSC+fzH1NbSgeyivA4Cmi0nRYLIA3qRfjrt553o1pzkr2vJDRComfRNHoahRm8aEALFfkAjLjquLXu2fSQGvgjaU2WrfIlltruwt/HqV3wtBvuqxZSoY73qeN2h5LpyAfEcbekejHq5a/iPQ4pPRihNS587dBt0FwREolknszSwPmuUh6AG4qfYFTK4fJQ0dgfQ1PvsN4b0kQyiRfN6f8HyiDFzgYTMlH/ZBZGfSV4CRGL+LXvtfEIdY5+haAFMxoHmVWC3KBftoQQXybSpu/0dMPVWATZgsbi9HtOE35VW9OHbW7vraZLaiJacIECbmlLPHXrQJ3cN1e6U6cKRjjtS/XsEWjhDfk7ES6x+EF0LAdvav8BkK9WzIvjUB+84mf5rdfF5/LJFcjo+3rNaJ28XKCgLVW7aVGi9BsANcJBdQBZGv+8VvBq9Z56X+VePBEhVggR5xrZHUPoWD0GKhLqnCNk9a9KK+MyGK2wVslv1UPWBgyi2PqLD1mIgSiJ+lZYStlg2//Bf42ShEvRHHTzHU37lSkl5Hw08HgBtH+YKQ==
X-Forefront-Antispam-Report: CIP:12.22.5.236;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(82310400004)(8936002)(86362001)(336012)(426003)(6666004)(70206006)(70586007)(4326008)(8676002)(316002)(81166007)(356005)(4744005)(7696005)(186003)(40460700003)(2906002)(2616005)(107886003)(5660300002)(36860700001)(47076005)(508600001)(110136005)(54906003)(36756003)(83380400001)(26005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2022 10:30:00.0038
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b3072d96-665c-4758-d294-08d9e7c94c27
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.236];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT034.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3087
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add ACPI support for Tegra210 QUAD SPI driver and support
new Tegra194 feature, combined sequence mode.

Krishna Yarlagadda (6):
  spi: tegra210-quad: use device_reset method
  dt-bindings: spi: Tegra234 QUAD SPI compatible
  spi: tegra210-quad: add new chips to compatible
  spi: tegra210-quad: add acpi support
  dt-bindings: spi: Tegra QUAD SPI combined sequence
  spi: tegra210-quad: combined sequence mode

 .../bindings/spi/nvidia,tegra210-quad.yaml         |   9 +
 drivers/spi/spi-tegra210-quad.c                    | 313 +++++++++++++++++++--
 2 files changed, 291 insertions(+), 31 deletions(-)

-- 
2.7.4

