Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6B475B138E
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 06:25:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230070AbiIHEY4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 00:24:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbiIHEYx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 00:24:53 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2067.outbound.protection.outlook.com [40.107.220.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F3C421802;
        Wed,  7 Sep 2022 21:24:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eJ6C1/NTwxD1NRlSG8c5GHQjt6681kctNiN9zE92+jHGvUQIyS1v9yqtCIXBHRwfhon3uY8T4y+PP9U1L7xf5GnE5FxjXlb/JLydL9lUa4ZX0IaR/YWMPWwzqIxZu2xjKNqZMG2fGzupA/kJiM9/OhVCIGflhG3FxEwGW2hDRSLpDXhmViZLUlntQZmaTesvZ7jSF/ZZcUZ6BVJYufzaDHIjBnfSVn7rZ6OHgU5Coo/BYgU7vtL+Hs7K3qrijS+vHFvKS6jgJDC1g1pwKAeIfd20cxRurOjqIdfmPvFe44MegAkMRo3xLE9lrZCAi7N0XOYKbCaK3amlOoLIyjyv2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=830zZhuWYwq57FfMJZ5KVJ7BCOXgEFpyVpIPxzCY4uw=;
 b=Tit72BCYkLdAUwRFcoo2JpKIYPbWv3K6ZkX/Z+RASmyvR/eu7XjbFCRTbFxC5MouRZdFZS7z7Gw0e1RQyNcCg4ea+vWjK57ueshyPCjRc59LBlXmBu+O3P8ey3DLC03c9enEHcVz0PndvIz1xzm1MkhU54OJVqkG8LQNRNq5oNP9CUUrZ8BWzQ8LtWsWI32qM6ao9hp/qwbmKfuPoq+Uqna/h/7nWsppT6n/0uHvuSQLgLpg99I/OLG5PIKHcFApj9I6L0VmlCi9V5nwS4SaqFO8NMx/vLMGs5MNSCPzsU6hDCkYI+JeWPvWzNp8jfiGp+KF/wvVm5IKoNwpRpA1bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=830zZhuWYwq57FfMJZ5KVJ7BCOXgEFpyVpIPxzCY4uw=;
 b=uMfZmqqsPYIryJ3o5eHXn/5v7icsL+J8ZNhibfJXvBh4QwQFDrVoy1HRx2jyTiNkc2WMQldyyuUdPXzyMbfOzo3eL5RDyr7g2xvE1BW4eDatnFIBzDDHyW5Bo5PGurf85prf9AoegTbVI3bKdSqSS7mMSwx/+3rA9XG8YHv5Wcs=
Received: from DM5PR06CA0090.namprd06.prod.outlook.com (2603:10b6:3:4::28) by
 DM6PR12MB4563.namprd12.prod.outlook.com (2603:10b6:5:28e::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5588.10; Thu, 8 Sep 2022 04:24:49 +0000
Received: from DM6NAM11FT035.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:4:cafe::47) by DM5PR06CA0090.outlook.office365.com
 (2603:10b6:3:4::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.12 via Frontend
 Transport; Thu, 8 Sep 2022 04:24:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT035.mail.protection.outlook.com (10.13.172.100) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5612.13 via Frontend Transport; Thu, 8 Sep 2022 04:24:49 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 7 Sep
 2022 23:24:47 -0500
From:   Appana Durga Kedareswara rao 
        <appana.durga.kedareswara.rao@amd.com>
To:     <appanad@amd.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <michal.simek@xilinx.com>,
        <derek.kiernan@xilinx.com>, <dragan.cvetic@xilinx.com>,
        <arnd@arndb.de>, <gregkh@linuxfoundation.org>
CC:     <linux-arm-kernel@lists.infradead.org>, <git@amd.com>
Subject: [PATCH v3 0/4] drivers: misc: Add support for TMR Manager and Inject IPs
Date:   Thu, 8 Sep 2022 09:54:40 +0530
Message-ID: <20220908042444.2866731-1-appana.durga.kedareswara.rao@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT035:EE_|DM6PR12MB4563:EE_
X-MS-Office365-Filtering-Correlation-Id: ad382f09-5a78-4a27-6b5c-08da91521183
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QblyKjSOCcFwwK0R5PWC9GLxCntMlrAl8w6E8qi8+JSifUnzS67G6Ui7EiFu+wufiqDdTi6sgncMmgNNoN1bwLI+uR3c+Jx3HOmAYWsxBcdpidihki14smhPNvdDCEQZczQUQ+jvGesBh3AnzcakfFPeZHGuDlQqRiKHE2Xyb6WHHljmVq3lNFRu8DHf+CYgowkLoTjYr9jX/V6KsZzuvq5JAFlZRBqqSr3dRRB01EsgM4hOJCMaXVNa74o2wW1L0cCSgMMra011NViF8EZcimz22Gs0qZRqSZy/lpm9sHp6itJ+LtBfARdOnd3ghjrFHuFD72iE0mATRZWowId3a45odah7LycbLNcXka09Kp7MUD149tfSB4ubwe4ETAMU/bur83k+TiEzaJZsl+lngyE5w1wBp5suvoPs31f9c2uyk1D89v1yzXBtLG26WjMozNgkKiQE2AqkxVT49iYLhftvrd94dOlKcWhcLZ5xaZ7hqjIc+KEPlY84IdMIYiuPQ8HW4D3JfSvf5Qo+CNihpSqKuyR9+1wBsxf11XDGEYa9VAkBfMVdn2OKjUnIPTmgzL11Z16dxc4AxxcqR3yaon7kxB7sqw61ODa0/1eFmQBkumCnQkJdkR5srGRy/mbDS+BicPV0tmikZuJGC1GC9S0dl3MvqgCGv2LrmlH/UhSnWBELzrC4sWm320sPILpwIsOycavB4XaFqdnMezz78nd+4t0Z9JRCZ+HC2cv8P/gYzCSayKq9UsbTEfO4ZohzQeqkjv/zyEkjP8gVB2kM3sW69ncvSiH+xes1GcHyCMNAA5nvHzLmJCA8vFnHLQAR71llIBSGF5GMz7QARB2b9jjzvVxuGVYX05XAVQHcysU=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(396003)(39860400002)(136003)(346002)(376002)(36840700001)(40470700004)(46966006)(336012)(4326008)(70206006)(5660300002)(40460700003)(8676002)(70586007)(81166007)(82740400003)(921005)(356005)(316002)(36860700001)(6666004)(41300700001)(478600001)(103116003)(966005)(83380400001)(82310400005)(86362001)(36756003)(40480700001)(26005)(186003)(54906003)(110136005)(2616005)(47076005)(1076003)(16526019)(426003)(2906002)(8936002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2022 04:24:49.2580
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ad382f09-5a78-4a27-6b5c-08da91521183
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT035.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4563
X-Spam-Status: No, score=0.9 required=5.0 tests=AC_FROM_MANY_DOTS,BAYES_00,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series adds support for TMR Manager and TMR Inject IPs.
The TMR Manager is responsible for handling the TMR subsystem state,
including fault detection and error recovery. The core is triplicated
in each of the sub-blocks in the TMR subsystem, and provides majority
voting of its internal state.
The TMR Inject core provides functional fault injection by changing
selected MicroBlaze instructions, which provides the possibility to
verify that the TMR subsystem error detection and fault recovery logic
is working properly.

For more details about TMR Manager and Inject IPs please refer PG268[1].

[1]: https://docs.xilinx.com/r/en-US/pg268-tmr/Triple-Modular-Redundancy-TMR-v1.0-LogiCORE-IP-Product-Guide-PG268

Appana Durga Kedareswara rao (4):
  dt-bindings: misc: tmr-manager: Add device-tree binding for TMR
    Manager
  drivers: misc: Add Support for TMR Manager
  dt-bindings: misc: tmr-inject: Add device-tree binding for TMR Inject
  drivers: misc: Add Support for TMR Inject IP

 .../testing/sysfs-driver-xilinx-tmr-manager   |  16 ++
 .../bindings/misc/xlnx,tmr-inject.yaml        |  47 ++++
 .../bindings/misc/xlnx,tmr-manager.yaml       |  47 ++++
 MAINTAINERS                                   |  13 +
 drivers/misc/Kconfig                          |  20 ++
 drivers/misc/Makefile                         |   4 +-
 drivers/misc/xilinx_tmr_inject.c              | 181 ++++++++++++++
 drivers/misc/xilinx_tmr_manager.c             | 222 ++++++++++++++++++
 8 files changed, 549 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/ABI/testing/sysfs-driver-xilinx-tmr-manager
 create mode 100644 Documentation/devicetree/bindings/misc/xlnx,tmr-inject.yaml
 create mode 100644 Documentation/devicetree/bindings/misc/xlnx,tmr-manager.yaml
 create mode 100644 drivers/misc/xilinx_tmr_inject.c
 create mode 100644 drivers/misc/xilinx_tmr_manager.c

-- 
2.25.1

