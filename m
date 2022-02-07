Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1AC44AB755
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 10:12:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242813AbiBGJKL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 04:10:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239097AbiBGJFh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 04:05:37 -0500
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2118.outbound.protection.outlook.com [40.107.22.118])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B8AFC043181;
        Mon,  7 Feb 2022 01:05:35 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S5FwG0COVkgOMNDd+MxGhTkIXIaUjgGQ4DujPUktAj2JoYtsFH6upiCX9OTXepJW7lZ2Neh04MF88cgkVl3rqehaNTUYUkitooaTAvdVK2iZYdplk1xtPjoAF+MvxhocxTVCxnVAIbIy8uf7U1jJTalT/DTHH9drGTxd6HmfGLL829czn1HJ3/Q/X58/tizJgikRQXrmWrrwWExZlzqxuJ/HhnCN+QQrYKFk9qDOYvjm/L6rLB6F/+/AAQLFwzhKDf9wSzcm5hdzwO5Lk3ygFQgs94txBzNpGI74NsjjvcKjc2dByuqnWTbQwFAYs3juWayyqd6hDLlJjFBVAPggDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R4CuhZjcMCmsNI1y9lA+0TIlDOEJRkR+Wn0UL08EPa0=;
 b=QcYYoGxYZjCZLJaUQfFiZhcNtUHG1EAa7BA3ffCQrTsDR97vB7d3t5QQ/CKLhwXRWkgnGik6R3h8b19bvGBpy8uchA5GfZp66hV/55tiS9XDNmyy7cSr8+mb6IXkpKJLITNtpxgz607GRap81nL6cpzefMK6F4yxwe/bmPyVP1H06GD1qYg/eNzBCKNYn97xoasvKefzMdCnnzROkqfr6zesjPDiYHGcum31EHpkgL6P+JNQ7HiDRHj3tYHgnIHgpHPZawBcVWT+6p04PZeA95LY/1p2W4nH+xG027ClwZ7B4ADsKzV8u90trUMEDW6VjbN4NgT0l/DaaSEifb0PEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 193.8.40.94) smtp.rcpttodomain=vger.kernel.org
 smtp.mailfrom=leica-geosystems.com; dmarc=pass (p=quarantine sp=quarantine
 pct=100) action=none header.from=leica-geosystems.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=leica-geosystems.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R4CuhZjcMCmsNI1y9lA+0TIlDOEJRkR+Wn0UL08EPa0=;
 b=I/lp6kSRBJikwiK+hb3BFHMg+YPGMkF5BdMTohNiLEe7er/8mugk2MiFe2u2CrxFFmJt6kjSrFiS7CmxiL7O+gALMz5COyhZ4+3ukIbZwWcbhRmNStcSVVy8tKZEkMUQOaoF90s76IWiRLwQzHnEa7F6uAqG5VZ3ki1iZvusIzg=
Received: from AM6P195CA0094.EURP195.PROD.OUTLOOK.COM (2603:10a6:209:86::35)
 by AM5PR06MB3122.eurprd06.prod.outlook.com (2603:10a6:206:3::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.11; Mon, 7 Feb
 2022 09:05:33 +0000
Received: from VE1EUR02FT058.eop-EUR02.prod.protection.outlook.com
 (2603:10a6:209:86:cafe::16) by AM6P195CA0094.outlook.office365.com
 (2603:10a6:209:86::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.17 via Frontend
 Transport; Mon, 7 Feb 2022 09:05:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 193.8.40.94)
 smtp.mailfrom=leica-geosystems.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=leica-geosystems.com;
Received-SPF: Pass (protection.outlook.com: domain of leica-geosystems.com
 designates 193.8.40.94 as permitted sender) receiver=protection.outlook.com;
 client-ip=193.8.40.94; helo=hexagon.com;
Received: from hexagon.com (193.8.40.94) by
 VE1EUR02FT058.mail.protection.outlook.com (10.152.13.52) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4951.12 via Frontend Transport; Mon, 7 Feb 2022 09:05:33 +0000
Received: from aherlnxbspsrv01.lgs-net.com ([10.60.34.56]) by hexagon.com with Microsoft SMTPSVC(10.0.17763.1697);
         Mon, 7 Feb 2022 10:05:32 +0100
From:   Massimo Toscanelli <massimo.toscanelli@leica-geosystems.com>
To:     linux-kernel@vger.kernel.org
Cc:     jic23@kernel.org, lars@metafoo.de, linus.walleij@linaro.org,
        caihuoqing@baidu.com, aardelean@deviqon.com,
        andy.shevchenko@gmail.com, hdegoede@redhat.com,
        Qing-wu.Li@leica-geosystems.com.cn, stephan@gerhold.net,
        linux-iio@vger.kernel.org,
        bsp-development.geo@leica-geosystems.com,
        Massimo Toscanelli <massimo.toscanelli@leica-geosystems.com>
Subject: [PATCH RESEND 0/2] Solve data access delay of ST sensors
Date:   Mon,  7 Feb 2022 09:04:41 +0000
Message-Id: <20220207090443.3710425-1-massimo.toscanelli@leica-geosystems.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220204192552.428433-1-massimo.toscanelli@leica-geosystems.com>
References: <20220204192552.428433-1-massimo.toscanelli@leica-geosystems.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 07 Feb 2022 09:05:32.0838 (UTC) FILETIME=[DC8FB460:01D81C01]
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: a3f536c8-61b0-4541-f6ac-08d9ea18ff3b
X-MS-TrafficTypeDiagnostic: AM5PR06MB3122:EE_
X-Microsoft-Antispam-PRVS: <AM5PR06MB31223E859EE3088BBF95003BA02C9@AM5PR06MB3122.eurprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2958;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TQhjCTrcbgVqXsKUK6u7D6K5G6jNA8+kUVDk9ChrqJzmYiCb/YJ1FKEN0ujuR61LpIbo8o2EMjWgt1jjgzWTWyJtljrYu9FGR9SFrluzeeRkkBGuDut3lhAGRnBr41fdq6NO4x4uKIR07LDNyW2SRINeN5XbvcKif1dKWB9mw0j1QqpzSnjOFl6G3S2SrRh4kHnUzMWUjz/R08qP6Tth2mkJxVK/KMJs4NiD0rOzwoDLmRMaGyh7VI9LsuRCMHuU7GQqHP/ntUKTBnK4yG/kcvVE4Np+aZ89I5sCjY/VKki+qlxZaSv4yKqEsbPzj8n87Uc+fEn+hS0wauIDcVyJWnYw5Oip+DlJcDjTfFqotxtvkoLsLNbmyoqTwtoxdVW+pbPOLSNQdM+DHIJyEI+E0kvks2dEeCEZ0XNlEmzu1m558RhN3O+Y9n04gMFJbVRh7k45upkO5pczC/kT1hINH8Uk2x/lSK29/9JY/eFLdR8fNE/9n0OCNZ9GvUf5mEpwx5nIbOxJ/IOucpvevKMyODsQUAumD5deyrWO6zcoqmwoRQ3ktFuSWlZ0HIaMvyZQm/64eSAi1WdFoIYYVbugHodzrzgGi99opBAOlywk1pvpnBMjHvXKErCnifQO8t4CGoy2+bYNd2BDINSJOjrCKe9TQhq7zZrzjD3jEXPl69bTMcNlc/OvPy6W7TXileevZkX66UuFUBsi1mML8DDTsQ==
X-Forefront-Antispam-Report: CIP:193.8.40.94;CTRY:CH;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:hexagon.com;PTR:ahersrvdom50.leica-geosystems.com;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(2616005)(107886003)(34020700004)(6666004)(36756003)(83380400001)(1076003)(70586007)(70206006)(450100002)(8936002)(8676002)(47076005)(508600001)(36860700001)(26005)(186003)(336012)(81166007)(2906002)(316002)(82310400004)(6916009)(356005)(5660300002)(40460700003)(4326008)(4744005)(86362001)(44832011);DIR:OUT;SFP:1102;
X-OriginatorOrg: leica-geosystems.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2022 09:05:33.1471
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a3f536c8-61b0-4541-f6ac-08d9ea18ff3b
X-MS-Exchange-CrossTenant-Id: 1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a;Ip=[193.8.40.94];Helo=[hexagon.com]
X-MS-Exchange-CrossTenant-AuthSource: VE1EUR02FT058.eop-EUR02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR06MB3122
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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

I forgot to add maintainers as recepients, so I resend the patches.

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

