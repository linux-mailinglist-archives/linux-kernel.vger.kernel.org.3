Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED792497C28
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 10:39:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234352AbiAXJjY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 04:39:24 -0500
Received: from mail-vi1eur05on2108.outbound.protection.outlook.com ([40.107.21.108]:56001
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233740AbiAXJjV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 04:39:21 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GSEFNhqbRfgmXa3Fhghjj4d7lvCU+tZdmR8BLIc+Ce6cbGtXOGd271M+5j2WNavjmYZcp6HMlt000Kb8Oli7Rz3VVJgCKRFUHsW6lRnBgv5nbaa/zji6NMULi6O1pZCYY1GZk9utAoDvARlm3TaXO5jYd003FNAZn2ErF/FR26CKVP/aB7AJCJ5Mezbe3mejQd+nPmK5FMx/ENn04PyfGlNClCOG9rfKtVOhpME93mvr3noX372tCNWNuYOwZYZDQAGII56b2B9sUTezeoy/2fKMVySoe0ygCM7GEYJZ0dGXLizebqdsaHGpK3ovt3Ns5MBI54/e9Isy7cdvtPgaFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aqbdCk0Zx+w91YgRpRupr6n/d9nbGhenhXP051TB33M=;
 b=AB+dVligVjAzhhUqTJDy0qSH0qp6U8vh1iWZEh9iybqpgdfooEEr6AmrtzURw7vsWq0JcjNf6bD9dHNw7/FqVBXuzF6q0wGrCB61jVSCmemz7w3uI+D8usZCxsL4NFOqa2LqsDUfJNJx6QNIWYm5AxXET/R8WDOFCwf3qkCMf6t1YID/iEWEmKvQIl+k47ejoymGpKH61kziB9kUW/KfPhLh4UaBRr5f65wNVHRJ+H04106rAhenhPpP4t1xNxCrmpkmgx0rOvMDN7lLH8DQVQDlvQ1hEV85OwIUAcd2oWPe3lJpqOT6b3xganyTaOuKtB+Hy7z75HmQmiVehLEX9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 193.8.40.112) smtp.rcpttodomain=leica-geosystems.com.cn
 smtp.mailfrom=leica-geosystems.com.cn; dmarc=fail (p=quarantine sp=quarantine
 pct=100) action=quarantine header.from=leica-geosystems.com.cn; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=leica-geosystems.com.cn; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aqbdCk0Zx+w91YgRpRupr6n/d9nbGhenhXP051TB33M=;
 b=Vu1L+nwTmQRpidAQzaSVy63S/xRmUxZsAhFExb05s/ur9bB+OuGp4cKCy8bLWWOQX2/ON9SRvQEpYLGLfQBwE2dkSipBgIWsUTRDpWbS/JgdPO4TtH5jY4qpunxlxZhs/Mtye4+nwPIeo/m3GQIrnf3eLhH4dXxJJ2zpVJJ3Vi4=
Received: from AS9PR06CA0034.eurprd06.prod.outlook.com (2603:10a6:20b:463::18)
 by DB9PR06MB7835.eurprd06.prod.outlook.com (2603:10a6:10:292::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.8; Mon, 24 Jan
 2022 09:39:16 +0000
Received: from VE1EUR02FT049.eop-EUR02.prod.protection.outlook.com
 (2603:10a6:20b:463:cafe::76) by AS9PR06CA0034.outlook.office365.com
 (2603:10a6:20b:463::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.7 via Frontend
 Transport; Mon, 24 Jan 2022 09:39:16 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 193.8.40.112)
 smtp.mailfrom=leica-geosystems.com.cn; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine
 header.from=leica-geosystems.com.cn;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 leica-geosystems.com.cn discourages use of 193.8.40.112 as permitted sender)
Received: from aherlnxbspsrv01.lgs-net.com (193.8.40.112) by
 VE1EUR02FT049.mail.protection.outlook.com (10.152.12.161) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4909.7 via Frontend Transport; Mon, 24 Jan 2022 09:39:15 +0000
From:   LI Qingwu <Qing-wu.Li@leica-geosystems.com.cn>
To:     qing-wu.li@leica-geosystems.com.cn, jic23@kernel.org,
        lars@metafoo.de, robh+dt@kernel.org, tomas.melin@vaisala.com,
        andy.shevchenko@gmail.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     LI Qingwu <Qing-wu.Li@leica-geosystems.com.cn>
Subject: [PATCH V1 0/6] i iio: accel: sca3300: add compitible for scl3300
Date:   Mon, 24 Jan 2022 09:39:06 +0000
Message-Id: <20220124093912.2429190-1-Qing-wu.Li@leica-geosystems.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e05dc22b-e3b9-4e0f-5127-08d9df1d62de
X-MS-TrafficTypeDiagnostic: DB9PR06MB7835:EE_
X-Microsoft-Antispam-PRVS: <DB9PR06MB78357FD6687E4EB5E37B45F7D75E9@DB9PR06MB7835.eurprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jbwRJlcF2/HpO20UsjPogdXttICLcUzyz2cuySaMz/5U0/dMWXnmofxQaQPWT18daxLYCGYSPAkdFK81eiLNrURoAohzSg3B4w1X+4zcVRhMzE24YfoSynQuzF+kKc18zrvZwBsmU0te4pRT1ILHbIgY+Bfimuf7kcegRLTLqW+p8u7KczzMaEH+lSK+OYjq2EWuSLWHOLRY51hotW6lOPlMsvFzAKq589RbZ/7izI62SBoQPVB4mgzCEOEQj2iRNw2gShdSKakBH+aPpXEbkmNowrapFjRopqZcx2c3EoJXDmOMlcnZmStt0mJ83fQ7uB72X4ItHr/j5V7/HBF/tk+uK1vAbfujCtw/ZZknSLBklYBwX6I3eIQ47S4trmud6PZglad02HAehqZCy4p3FyaN+8E/cy3QKlAt4AMDjuOKUfRbnTuGwfoVY3cwPZanxTx48i4nfjMRlVhGsOquykMPYOuUmrtiSVPBM9GrpOMIaxvV7fFw3dbUqZnbAnrb1KMlHBnUhmc6h2uTaJO9nSgxJvCPS1awdU65mSVCeXeOpmcjZZgoj/ZZnhO5wFiHxYmroFagg6H8+OsjHJ70P7mOPjjowjgrWIM47UYIqAgb0Bu2fTW1HOGuOIcsVpzxjrbvYFGIDNHPStxjUdnO/dyNO/16e/gNaWYWLjx0o0pj03fxZMC5yaO+cVANIdCT2DFubt/QhgBpJokvVaTv7f5f+9W0yq6SRaEKBAMjTWs4p3z5Z8WOof/xUM2ftP+EP1OmviXnM3B8qxBG2JWz3A==
X-Forefront-Antispam-Report: CIP:193.8.40.112;CTRY:CH;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:aherlnxbspsrv01.lgs-net.com;PTR:mailhost.polymeca.com;CAT:NONE;SFS:(4636009)(36840700001)(40470700004)(46966006)(70206006)(6666004)(2616005)(36736006)(316002)(8676002)(36756003)(83380400001)(956004)(40460700003)(2906002)(4744005)(36860700001)(6486002)(6512007)(47076005)(70586007)(107886003)(508600001)(356005)(26005)(81166007)(186003)(5660300002)(4326008)(118246002)(336012)(1076003)(82310400004)(8936002)(6506007)(86362001);DIR:OUT;SFP:1102;
X-OriginatorOrg: leica-geosystems.com.cn
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2022 09:39:15.3231
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e05dc22b-e3b9-4e0f-5127-08d9df1d62de
X-MS-Exchange-CrossTenant-Id: 1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a;Ip=[193.8.40.112];Helo=[aherlnxbspsrv01.lgs-net.com]
X-MS-Exchange-CrossTenant-AuthSource: VE1EUR02FT049.eop-EUR02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR06MB7835
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current driver support sca3300 only.
Modifed for support SCL3300.
Verifed with SCL3300 on IMX8MM.
Splited the change for review.

LI Qingwu (6):
  iio: accel: sca3300: add define for temp channel for reuse.
  iio: accel: sca3300: Add interface for operation modes.
  iio: accel: sca3300: modified to support multi chips
  iio: accel: sca3300: Add support for SCL3300
  iio: accel: sca3300: Add inclination channels.
  dt-bindings: iio: accel: sca3300: Document murata,scl3300

 .../bindings/iio/accel/murata,sca3300.yaml    |   1 +
 drivers/iio/accel/sca3300.c                   | 284 +++++++++++++++---
 2 files changed, 238 insertions(+), 47 deletions(-)

-- 
2.25.1

