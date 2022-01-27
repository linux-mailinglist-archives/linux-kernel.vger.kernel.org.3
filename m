Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8335049E4A8
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 15:32:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242393AbiA0OcG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 09:32:06 -0500
Received: from mx0b-0014ca01.pphosted.com ([208.86.201.193]:51934 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S242326AbiA0OcF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 09:32:05 -0500
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 20R93Bh4025426;
        Thu, 27 Jan 2022 06:31:43 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=proofpoint;
 bh=QQTgeHHj15E+sa6ZI8G2oZA4pgyatYPT04r5cHpj0tA=;
 b=eFo7+5tBophhJADHWVEwmq+FaXldPZ04QRXRfDqGYiyqxQjUQY337NIiT3rYcGUV5eD0
 J0FweCA3PBROYbB5aGl17baNduWhtN7Dy/5zRQ/5fcQZb8c5I8t44kRTFxZMGQc8UBCL
 zw60pKk3CKKR3HSrdq98rtLYvF++pHcvyNe2MWxGrGd3jMrCiSDYnDbdNHedmMoKGbze
 3dtd2+LKjnId9luVjkeuXRVOVd7odB8uk2ThEWUAjETj3eT/CH5pWiI+HjTNTiT634T/
 NfxwXlzWne/GNYkuKOiGICVtRkMk13bsUe5DM4LS1hNiTjDD+PwRs4Z0XbExJmDQXjI6 DA== 
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2169.outbound.protection.outlook.com [104.47.59.169])
        by mx0b-0014ca01.pphosted.com (PPS) with ESMTPS id 3dujtnsq7c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 27 Jan 2022 06:31:43 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JMtVlD8i2NZ5Z6BZkvVNQ6B9Lq8O9AoyPbiaN+D0Lc5C5iikLrFNlgZwZk48jx5nIxbchSgh2QJsesUzThZIO2OEbvvb38KJ9Gk6DOTGoqyPpqka5viDbeu8j0ysKB0iYZozMHdyjaVqlpq71q4PePUrxfYuo3xUdkkH6ODt3qHmdeiRMXePKVnKKsduss0CFCybF+EyUIx4BFqdWzZfaJ1ixhHHZ1uwxaMuiMVKkNfnlT7w6QLnsEPt6t+OkCzl3H4sPiQKGQ+wP6g518RUV8DgrL7AdwcQx3gkyR5WRcPN+5gg+W/mMLkJAcRs+ht/sgEgndvpPCgziKZowPfzuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QQTgeHHj15E+sa6ZI8G2oZA4pgyatYPT04r5cHpj0tA=;
 b=Zyz0ZjO7TCGqVCFSyGVVtOAr0pyCU+ztviOZWflnffeGoKJ4SBMvpQEgXZFyzm2YD38mA3n/ZnDgoQ7p9Ye7kvx3HtO2cD0C/JK0Xc39iAlf2IIqU0nGbxlX6oQ69J7GCSWqd4rQhFztKDLEV4uM8+cFwFkbabl04x4SGTDwleBFtwyteKPXHnEK9yTdVKui4M2HDUCwtbiPAZxDOXUWKT3/7T2hPdbBqBIadN5BfdzGYQqrPdOOHQmUDDpWlTwNU2YhDDlHPgeznqiM1c5i+licVssMp/x9UXh2YC9VghjCTl97pBwqPxLH2/fwQrCyeOt37FMNzd9/Yl2yJ0H64w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 64.207.220.244) smtp.rcpttodomain=lists.infradead.org
 smtp.mailfrom=cadence.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=cadence.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QQTgeHHj15E+sa6ZI8G2oZA4pgyatYPT04r5cHpj0tA=;
 b=Nhk/V2lnuFp/HZ/BCMSi/c1fZ63aOFGIvrpal83/EV+4+hGZi1jgSlmdO39NcAToJ77Rng/Jf2XQDhcbIlrUhobZsgibsygZWuROd0urt8q5HnKACeVRCXYI26ockzic6rklcyl7sbSXaQ/NwxSATvs56d5UgbWeFgJR+w1kHxQ=
Received: from BN7PR06CA0067.namprd06.prod.outlook.com (2603:10b6:408:34::44)
 by BYAPR07MB5992.namprd07.prod.outlook.com (2603:10b6:a03:130::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.10; Thu, 27 Jan
 2022 14:31:38 +0000
Received: from BN8NAM12FT017.eop-nam12.prod.protection.outlook.com
 (2603:10b6:408:34:cafe::a4) by BN7PR06CA0067.outlook.office365.com
 (2603:10b6:408:34::44) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.15 via Frontend
 Transport; Thu, 27 Jan 2022 14:31:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 64.207.220.244)
 smtp.mailfrom=cadence.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=cadence.com;
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 64.207.220.244 as permitted sender) receiver=protection.outlook.com;
 client-ip=64.207.220.244; helo=wcmailrelayl01.cadence.com;
Received: from wcmailrelayl01.cadence.com (64.207.220.244) by
 BN8NAM12FT017.mail.protection.outlook.com (10.13.182.170) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4951.5 via Frontend Transport; Thu, 27 Jan 2022 14:31:36 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by wcmailrelayl01.cadence.com (8.14.7/8.14.4) with ESMTP id 20REVXgT179338
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=OK);
        Thu, 27 Jan 2022 06:31:34 -0800
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu4.global.cadence.com (10.160.110.201) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 27 Jan 2022 15:31:21 +0100
Received: from vleu-orange.cadence.com (10.160.88.83) by
 maileu4.global.cadence.com (10.160.110.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2
 via Frontend Transport; Thu, 27 Jan 2022 15:31:21 +0100
Received: from vleu-orange.cadence.com (localhost.localdomain [127.0.0.1])
        by vleu-orange.cadence.com (8.14.4/8.14.4) with ESMTP id 20REU0ff023522;
        Thu, 27 Jan 2022 15:30:32 +0100
Received: (from sjakhade@localhost)
        by vleu-orange.cadence.com (8.14.4/8.14.4/Submit) id 20RETwcT023505;
        Thu, 27 Jan 2022 15:29:58 +0100
From:   Swapnil Jakhade <sjakhade@cadence.com>
To:     <vkoul@kernel.org>, <kishon@ti.com>,
        <linux-phy@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC:     <mparab@cadence.com>, <sjakhade@cadence.com>,
        <a-govindraju@ti.com>, <r-ravikumar@ti.com>
Subject: [PATCH 0/4] PHY: Add multilink DP support in Cadence Torrent PHY driver
Date:   Thu, 27 Jan 2022 15:29:54 +0100
Message-ID: <20220127142958.23465-1-sjakhade@cadence.com>
X-Mailer: git-send-email 2.15.0
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 957faa58-edbe-419f-005d-08d9e1a1b932
X-MS-TrafficTypeDiagnostic: BYAPR07MB5992:EE_
X-Microsoft-Antispam-PRVS: <BYAPR07MB59929BB54609C1FBBAD1DAC7C5219@BYAPR07MB5992.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vZtdmpfziIkuvpLC71UbklzNJsMrzKCa0uqPxj6WsS8yRDWl83JES/SHn1MFp7PsjbWQuFfpOwZOG5k92jeZieLWKXZVW3H1eOmo6RXoNfaPXjUCaJUtZhzTn2+84MXlNwt/CPx0P4j1JlVpt3HRe+v+3rIGPm3Kx2dw3Z2+A2tgeMw03XSDecNeU/xKEQnvTMoTEnUUTlgA/jpTFUPzsS7OADUjvBLhegTYjIJDajF5hZbF1Qlto3LnCCFNw92MlkJR/vGQezysQFXE2Tra20w9Ud56E39jbfTBd1VopJiw8bt94yV1gEmoavEkNxq/EmrQ9HFIgpEuYNMKMOdKdHWnJn4oxEi9sglU75hi5bDm7oE9O5DCnJIBoppFHue43fJg/JHTIwkLrLYbT/pKCseOQ9NoWb8CmJw4C4j3hTPztcIYCzWXWNCjOYIChtdl6q04/URf2tGcZiujmvIXSxWVAgvAhqgybH4FsxI7djHD7ikmNSELr9wXjBrHMFg/wXOEwut3LCB7pid0gqjuXE8Clms59dkkl51t2CA1aANY8XJzW7L7N6VMepHwex5VuDAJ68vo1gNsCfniwt16xyy9dXHVwaXTxug8ldeLuNkjmBz8VoTFbCl5UbsAZSIOG6hpJwAHppazSZQdVe6Sj7g0x+hWpUy0ZX4kcJVcKXeHIy0yC0NF7LQsdkeVA0FitgmrANqLzmJQmBiEYBwqmuw0yWmVpf6bKjW7p1FM11D57ignUZ61sMDgCVm8c/xAu6Uq5hSshqLq73x9MRg7XPNI96LZLpX3PGo8L/jqadu9+BgeYrGlOUfuGurbWx8aP+pkRMlGU7F+E2IzaGMvWA==
X-Forefront-Antispam-Report: CIP:64.207.220.244;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:wcmailrelayl01.cadence.com;PTR:ErrorRetry;CAT:NONE;SFS:(4636009)(36092001)(46966006)(36840700001)(40470700004)(8936002)(508600001)(8676002)(42186006)(81166007)(1076003)(54906003)(356005)(336012)(316002)(2616005)(40460700003)(6666004)(36756003)(86362001)(36860700001)(4326008)(47076005)(2906002)(5660300002)(4744005)(83380400001)(110136005)(26005)(70206006)(186003)(426003)(70586007)(82310400004)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2022 14:31:36.1119
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 957faa58-edbe-419f-005d-08d9e1a1b932
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[64.207.220.244];Helo=[wcmailrelayl01.cadence.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM12FT017.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR07MB5992
X-Proofpoint-GUID: RK1IqgnoXJMLABR3hc4GyaBkEVS54hvY
X-Proofpoint-ORIG-GUID: RK1IqgnoXJMLABR3hc4GyaBkEVS54hvY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-27_03,2022-01-27_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 mlxscore=0
 suspectscore=0 lowpriorityscore=0 priorityscore=1501 phishscore=0
 impostorscore=0 mlxlogscore=680 bulkscore=0 adultscore=0 clxscore=1011
 spamscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2201270088
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series adds support for multilink multiprotocol DisplayPort
configurations in Cadence Torrent PHY driver. Following configurations
are supported:
(1) PCIe + DP
(2) USB + DP

The changes have been validated on TI J721S2 platform.

Swapnil Jakhade (4):
  phy: cadence-torrent: Add function to get PLL to be configured for DP
  phy: cadence-torrent: Prepare driver for multilink DP support
  phy: cadence-torrent: Add PCIe + DP multilink configuration for 100MHz
    refclk
  phy: cadence-torrent: Add USB + DP multilink configuration

 drivers/phy/cadence/phy-cadence-torrent.c | 727 ++++++++++++++++------
 1 file changed, 532 insertions(+), 195 deletions(-)

-- 
2.34.1

