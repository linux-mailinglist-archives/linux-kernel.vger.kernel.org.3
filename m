Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87B4E4A9FFF
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 20:26:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233273AbiBDT0J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 14:26:09 -0500
Received: from mail-am6eur05on2107.outbound.protection.outlook.com ([40.107.22.107]:19872
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233199AbiBDT0H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 14:26:07 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fxqrau/b/p3Kc86tujzVnewPLAbdWX8+wbZriFw4ND3ZlykD+YkGSUf+32QkyVYGR13r1lIE6byeJafAHpOrFpeYERA3AJiu5cRZeelk24j9sD3UfUo8MV61C1meWuMgHBqDUWEcew/DYNJV8YJfxEK6UgOSOr1cHl1CtZMGvpaYLvXwqUH4LM4CVGNXMI0RdZLHSzvUndt6u/Jps/HjAluwaJOQ1NnGvKQayIZeSK0vnFZWtrixpOjQPQkEw5OQJKCRp1zsJL/E8Tb8fyoYjyTZ+/btLfRzEsq7+x3TTkptv2WDk3YYaLf6vepxsaLyiOcZ59rl15JennANzRQBAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uQ/LIEmWZ1jX4HIeGsAUAe6Elew3lgqnjLmv9KLYlXw=;
 b=mMJaU/JvV59gPP4pyv1Jt7AdIUDBF6QBrJ3gAXzroaizdpVDd3VJ1+uRm/O06hM96gtWF0RksvIULyr1hqM4a2++zWhrboQpw1hhWfJZ6M79AR67gn5uCBc9muBOSsRtaF5cIX7aUd1jUvGWr2hlzBws1H67YVZP8yNMIdZ1bHjYeNeCXFcV7GPngMufY1EFBYuwW+biAIMYt19iP63GrgFtwJ01qso+H1ptouxHaP0eZFT2k9WyrTLbA509vD62fGRwx6cl3BVc0As+m+f1yBGsSsY9L/tOGWuD0Rm4JBdQaxAV44xB/tjJBLvbacRPSYwgY/rVZcMHYNpOB16ojQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 193.8.40.94) smtp.rcpttodomain=vger.kernel.org
 smtp.mailfrom=leica-geosystems.com; dmarc=pass (p=quarantine sp=quarantine
 pct=100) action=none header.from=leica-geosystems.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=leica-geosystems.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uQ/LIEmWZ1jX4HIeGsAUAe6Elew3lgqnjLmv9KLYlXw=;
 b=og53X4yjOCoWiixmQMnp9KDbKRPCz3UYJhRutl4uk9SPP2IPAe2DCI4TvZ+ZTRS2EbLIErGaOaCuIMC/iBplTjbBYc9kedxC5efDbuBzuFMB/a40GK92INLGnqF+Yn0k2aAPNjXp8vx7gfvHMfD/cAtUwIzOeKaix9SZ8xObbjs=
Received: from AM6PR0502CA0060.eurprd05.prod.outlook.com
 (2603:10a6:20b:56::37) by DB7PR06MB5500.eurprd06.prod.outlook.com
 (2603:10a6:10:90::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12; Fri, 4 Feb
 2022 19:26:05 +0000
Received: from VE1EUR02FT021.eop-EUR02.prod.protection.outlook.com
 (2603:10a6:20b:56:cafe::c6) by AM6PR0502CA0060.outlook.office365.com
 (2603:10a6:20b:56::37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.17 via Frontend
 Transport; Fri, 4 Feb 2022 19:26:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 193.8.40.94)
 smtp.mailfrom=leica-geosystems.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=leica-geosystems.com;
Received-SPF: Pass (protection.outlook.com: domain of leica-geosystems.com
 designates 193.8.40.94 as permitted sender) receiver=protection.outlook.com;
 client-ip=193.8.40.94; helo=hexagon.com;
Received: from hexagon.com (193.8.40.94) by
 VE1EUR02FT021.mail.protection.outlook.com (10.152.12.111) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4951.12 via Frontend Transport; Fri, 4 Feb 2022 19:26:04 +0000
Received: from aherlnxbspsrv01.lgs-net.com ([10.60.34.56]) by hexagon.com with Microsoft SMTPSVC(10.0.17763.1697);
         Fri, 4 Feb 2022 20:26:04 +0100
From:   Massimo Toscanelli <massimo.toscanelli@leica-geosystems.com>
To:     linux-kernel@vger.kernel.org
Cc:     bsp-development.geo@leica-geosystems.com
Subject: [PATCH 0/2] Solve data access delay of ST sensors
Date:   Fri,  4 Feb 2022 19:25:50 +0000
Message-Id: <20220204192552.428433-1-massimo.toscanelli@leica-geosystems.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 04 Feb 2022 19:26:04.0626 (UTC) FILETIME=[0D327320:01D819FD]
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 37c0e730-e06e-44c7-aa9f-08d9e8142fd3
X-MS-TrafficTypeDiagnostic: DB7PR06MB5500:EE_
X-Microsoft-Antispam-PRVS: <DB7PR06MB5500AB9DA6448517834740CEA0299@DB7PR06MB5500.eurprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2803;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: H+98ZpeG8muEV0NClOpBV46BYd0cqV2+bs3tfoarrbcm5qorFxENiMG5ouWx63giKM5yUrW91UHblF36z5MC3u/0vLceB7hbfm6SMKQSBcmIL7PQtS7GUTKtxrhIPGrPmdaMUdctF2N+9bUYmzAR+yxFlKJzJmY2tb3vWrvtQjWjzRYZODd2W8vqOrWZ+FIvOpEwczlaSpi28mLzuGhy9zz+XVEXQU11yMFxxyY6sReHgvT1pPHPv2LZNslNVEkFsagdXX3AAepVyJrDwB6iwv9nEhx0j27jq5S2RIUQuBhVVlI9QYMmiLtMIesWNZWxkil6lrCft2MUSwYvsuTIF3PCMisqx64jhpiuBPEoaF1C5XNn5H9qi1TOS928ROoV5eg0ItDpGBbkB6d7+MzDERJcUkc9oEtrdCXN+3I4MO8qn5FY4SXk+SD/eh4iwNTJrKmw5WilmhOVsdUULTIqtvTEJtRgMH+ziQD5tWxqihfs5OpWLR01Lup8esCbWLKK/yNRTjOV/CnwxM03RaIpNWQBb57YnvHUQrL2UYxGKSmYpBs4p8z+H7KKvXyI3lONS3NQRAe6Nlg6hRXmI37PLKdgd+svWUTTSGbaAwmcCqMPZ9TYCzktf83K+shEInTDlPX5F+uKb+0o22il27lZyL1xM0zMDC7w6Xy0CP4C17fzFOH/QhQJWflQ+diZ40P564B/AwbUm/uAu6DgkZcpog==
X-Forefront-Antispam-Report: CIP:193.8.40.94;CTRY:CH;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:hexagon.com;PTR:ahersrvdom50.leica-geosystems.com;CAT:NONE;SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(36860700001)(1076003)(2906002)(40460700003)(6916009)(26005)(186003)(34020700004)(336012)(86362001)(4744005)(44832011)(47076005)(36756003)(5660300002)(83380400001)(70206006)(356005)(4326008)(82310400004)(81166007)(8936002)(8676002)(316002)(6666004)(508600001)(2616005)(107886003)(70586007);DIR:OUT;SFP:1102;
X-OriginatorOrg: leica-geosystems.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2022 19:26:04.8714
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 37c0e730-e06e-44c7-aa9f-08d9e8142fd3
X-MS-Exchange-CrossTenant-Id: 1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a;Ip=[193.8.40.94];Helo=[hexagon.com]
X-MS-Exchange-CrossTenant-AuthSource: VE1EUR02FT021.eop-EUR02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR06MB5500
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reading raw data from ST sensors implies enabling the device and
waiting for its activation.
This leads to significant delays every time the data is fetched,
especially if the operation has to be repeated.

The introduction of the 'always_on' flag as sysfs attribute can
solve this issue, by allowing the user to keep the device enabled
during the entire read session and therefore, to perform a much
faster data access.

This implementation has been already tested on a ST magnetometer.

Massimo Toscanelli (2):
  iio: st_sensors: add always_on flag
  iio: st_magn_core.c: activate always_on attribute

 .../iio/common/st_sensors/st_sensors_core.c   | 85 +++++++++++++++++--
 drivers/iio/magnetometer/st_magn_core.c       |  2 +
 include/linux/iio/common/st_sensors.h         | 14 +++
 3 files changed, 96 insertions(+), 5 deletions(-)


base-commit: dcb85f85fa6f142aae1fe86f399d4503d49f2b60
-- 
2.25.1

