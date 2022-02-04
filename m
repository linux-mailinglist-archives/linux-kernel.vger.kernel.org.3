Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23D024AA004
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 20:26:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233606AbiBDT0U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 14:26:20 -0500
Received: from mail-vi1eur05on2113.outbound.protection.outlook.com ([40.107.21.113]:4704
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233259AbiBDT0N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 14:26:13 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TaCycvHoK0csPALkZcthsjj/iD8fxqnQtm4ZlJG8H8vFknOjT8QSueNresu8q339N3U765K3hyyGj+sVYJvPXwWQpP8d9HUI5GT1FATocy4HwpBWitgPyQ7LRLy5kCJIZhaClHpYYQf3eZZ3ziqeo38kkiGZjHK9Ok3bGSRp/AYDb+PONT1DSiX4yX3HDZZJ0j3YcnT4Zezo+UxWkxRZyzUvJrIzR57WIiXiMsfkptFxs/ULD1HrCoYoKqD/tFdkp1ZOOeKSVS4eQ2M1/f+JS5rvtBJfIe9vcPkwzQHaV+QNumqG+fLEg2Ht/kJigxu1p7AuvXxb2WHi4E02IIiJBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EEH7puZP+EKzCMA/DLKC/W77EI9MFy63BIdji2uFLRM=;
 b=oQdubgsMTnP7Wb5yTu58YsNa8n+omz/A2RWOgb7Bp1FXHVt4BHHHOSs2Jx9gLqb+p7Qec9NC0o1ehQQN1KYD9m7ac3ab2pSk+sVpq8cEcx3Jinh4BJidFbwJuyH/YxnOb+KyEJUvDT4t2a3NG2U1iQz8YdihRxAaFOeWrmeURaxsSSQ0VcDB8eT77l3q2r8xwuj/L87hmSsW2rmMmglJUxY3DagkXSjwMl+jOIDhVa3a4FrK25NBLC00A8TJ6OuqePIE5ktlmNcZQh2RLCQq75ECOQBxBPaNVrFIDxXoFn5V217cRv5qCz0+wUh2cJ/Akng944xfBvvjBm6KpCXTPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 193.8.40.94) smtp.rcpttodomain=vger.kernel.org
 smtp.mailfrom=leica-geosystems.com; dmarc=pass (p=quarantine sp=quarantine
 pct=100) action=none header.from=leica-geosystems.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=leica-geosystems.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EEH7puZP+EKzCMA/DLKC/W77EI9MFy63BIdji2uFLRM=;
 b=kniIwSjG9jWoMVqxlu8ykP8IDsMEzZSap7UlG2Q2xuHMZHPMQaFFNb2C3C35NIu30NPyMWGHsEqzU6rX5p86OcSFedWUUgd64JcK7qu/LRliay5eb2bp1ZzJaEiZ3fogLmxnYvzFpXui1M3ujgRXkvsMjJ0oijPDiWDmPCr8ua4=
Received: from AS8PR04CA0024.eurprd04.prod.outlook.com (2603:10a6:20b:310::29)
 by HE1PR0602MB3482.eurprd06.prod.outlook.com (2603:10a6:7:8e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.20; Fri, 4 Feb
 2022 19:26:10 +0000
Received: from VE1EUR02FT043.eop-EUR02.prod.protection.outlook.com
 (2603:10a6:20b:310:cafe::4f) by AS8PR04CA0024.outlook.office365.com
 (2603:10a6:20b:310::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12 via Frontend
 Transport; Fri, 4 Feb 2022 19:26:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 193.8.40.94)
 smtp.mailfrom=leica-geosystems.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=leica-geosystems.com;
Received-SPF: Pass (protection.outlook.com: domain of leica-geosystems.com
 designates 193.8.40.94 as permitted sender) receiver=protection.outlook.com;
 client-ip=193.8.40.94; helo=hexagon.com;
Received: from hexagon.com (193.8.40.94) by
 VE1EUR02FT043.mail.protection.outlook.com (10.152.13.89) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4951.12 via Frontend Transport; Fri, 4 Feb 2022 19:26:10 +0000
Received: from aherlnxbspsrv01.lgs-net.com ([10.60.34.56]) by hexagon.com with Microsoft SMTPSVC(10.0.17763.1697);
         Fri, 4 Feb 2022 20:26:09 +0100
From:   Massimo Toscanelli <massimo.toscanelli@leica-geosystems.com>
To:     linux-kernel@vger.kernel.org
Cc:     bsp-development.geo@leica-geosystems.com,
        Massimo Toscanelli <massimo.toscanelli@leica-geosystems.com>
Subject: [PATCH 2/2] iio: st_magn_core.c: activate always_on attribute
Date:   Fri,  4 Feb 2022 19:25:52 +0000
Message-Id: <20220204192552.428433-3-massimo.toscanelli@leica-geosystems.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220204192552.428433-1-massimo.toscanelli@leica-geosystems.com>
References: <20220204192552.428433-1-massimo.toscanelli@leica-geosystems.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 04 Feb 2022 19:26:09.0876 (UTC) FILETIME=[10538940:01D819FD]
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 429ef23d-fe48-4f6d-bc98-08d9e81432ed
X-MS-TrafficTypeDiagnostic: HE1PR0602MB3482:EE_
X-Microsoft-Antispam-PRVS: <HE1PR0602MB3482B09027F9A58517A8D7E9A0299@HE1PR0602MB3482.eurprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3826;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dNnavePRwRH6m0XYdOj0rvYjcYUtCZuMAqA24BpmoOzrR8i9rxxZyWhB8lWPjv6nbZyi3HNh3w7Kdn0MWOKnwAs6mcsnix/uHuPV1mOUoZMWDjkvKWzq1M83YctMk/daWqJzHNjDphYmTT9kiwkImxhLb1VrefnTtZYAjgu57pVf7MCtNgTKL9IMezjc2mVg1uyOIcvsHyiqYqU+gOm4F8AxW/Mg//HE132p3eojzwr7N/vn/kzN5Zgs+mtCY25RztQeJARyDCkoTBjIYxP1uYHwurren+lU4GbCJH0wwnxEdiaMCgwNT9dA4QtuULTQPzVFk15vfDcRCOFLZVep9TmGDHD12b3co73wgitHmqVRRSjv6qrdC3zDszGBHG/kCsEJBmZi2OS8bIXeV8+BLDoeSbWBMJoykmsgHROrZOQj6rHvAvQPfgQOvRiGDn+utCBLVDkMu418vp9BTqHxUH5xyXRMr4xQxmmUi29FLQicRC6Tmk4YjP+cryCAjef9YVgL/3GZNUefonOwJ1DNzs9KOJPXaOhfWMmujlSGlf2tZTYAehCnti2zlE5oUEfhQqIVR52TZFFVroaf5ZVLxMiPF4XqnKpmjwtKny9NKyQBqIlNU3e+n84UMmGk9uJJTIp4mhxrvMotBpZxGmF6QNGaYzz3fbMHTbx+VOhkpZ+lj57SsoW7nOK1nSYjGc+MZxDi7WS6dhSNrFITsT2vwA==
X-Forefront-Antispam-Report: CIP:193.8.40.94;CTRY:CH;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:hexagon.com;PTR:ahersrvdom50.leica-geosystems.com;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(4326008)(8936002)(186003)(70586007)(83380400001)(70206006)(508600001)(336012)(8676002)(316002)(107886003)(1076003)(2616005)(6916009)(6666004)(86362001)(356005)(44832011)(26005)(36756003)(36860700001)(2906002)(34020700004)(40460700003)(47076005)(81166007)(4744005)(5660300002)(82310400004);DIR:OUT;SFP:1102;
X-OriginatorOrg: leica-geosystems.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2022 19:26:10.0754
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 429ef23d-fe48-4f6d-bc98-08d9e81432ed
X-MS-Exchange-CrossTenant-Id: 1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a;Ip=[193.8.40.94];Helo=[hexagon.com]
X-MS-Exchange-CrossTenant-AuthSource: VE1EUR02FT043.eop-EUR02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0602MB3482
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Activate always_on sysfs attribute to add the always_on feature in
st magnetometers.

Signed-off-by: Massimo Toscanelli <massimo.toscanelli@leica-geosystems.com>
---
 drivers/iio/magnetometer/st_magn_core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/iio/magnetometer/st_magn_core.c b/drivers/iio/magnetometer/st_magn_core.c
index 0806a1e65ce4..2ab4c286d262 100644
--- a/drivers/iio/magnetometer/st_magn_core.c
+++ b/drivers/iio/magnetometer/st_magn_core.c
@@ -563,9 +563,11 @@ static int st_magn_write_raw(struct iio_dev *indio_dev,
 static ST_SENSORS_DEV_ATTR_SAMP_FREQ_AVAIL();
 static ST_SENSORS_DEV_ATTR_SCALE_AVAIL(in_magn_scale_available);
 
+static ST_SENSORS_DEV_ATTR_ALWAYS_ON();
 static struct attribute *st_magn_attributes[] = {
 	&iio_dev_attr_sampling_frequency_available.dev_attr.attr,
 	&iio_dev_attr_in_magn_scale_available.dev_attr.attr,
+	&iio_dev_attr_always_on.dev_attr.attr,
 	NULL,
 };
 
-- 
2.25.1

