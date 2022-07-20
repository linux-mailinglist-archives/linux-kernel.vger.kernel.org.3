Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA37757B0A6
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 08:00:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237609AbiGTGA3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 02:00:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbiGTGA0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 02:00:26 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2059.outbound.protection.outlook.com [40.107.223.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0E272A708;
        Tue, 19 Jul 2022 23:00:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UzCwiEshDkLcve+T8M0fJnN+9dKfWk/KJohONuP93ArnXKEZa8KWyVGkDN640brQ3Puu3JjV2jU64IvrOydzN9pYjkcJHqpOQnujf16OqQQmtYidYb2DHu9/kt63CTYM1VkpP2tslU+UhIcpZhqIgw5OgBH1N5JqWedzt0VERT8i43ZXp14RgG4eaTS8YOrnhG4SZAbnd7NC5hCTJoijVgkveD9ycx3oistKdP8jv1g/1zwqaaHEMToIomux9Nv3nemBf1yZxdq0SQ8U5cuuynSmVe0p6ckIGDubpJqstTiYR2KyAh87jjrjoaUJyCFLPXE0EqKYc4CXeS5iTcmlng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oJDYBqQ/E1wayYHcDCqjTLK/z2JYmellBNJm7eiF4Q8=;
 b=YndPhWZwddA1d4lSH9i/AiXdL6GE8gUfqmvcZMq8VOfTK65y1YRs6sZfxcv51k+at+44gmwdWPwnyV4WX7KaJXaUZ1ZCd2oH4TpcUQcv93uiYMA2ahpMKyvIkN1MMUa/VzQJTw9h7r0BnkW/pEmDIO6eCFxOE7zVfqUPs81ioH0i5z+VuKZGYDq6ohHyT9dmhw7QhEPFsnDF2r4T82dB11+j33PM+CpfJoGBJBzOieXST2CCfg7IlhTA5YH8hXT8fV7lUN7ciLq1fJyGjniG5KEPO6qNBC64kq24A+EDw0S3ueZF5xhV5Ie33dmMlqdq8b+p61xA8rQO4DIKvJbKbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oJDYBqQ/E1wayYHcDCqjTLK/z2JYmellBNJm7eiF4Q8=;
 b=LfPeZTKU6EPF17pcnmtGdSm9yjY5B9pK5ZidTRRYfInHs6IUQDOLJaA2u2bNOXKuxvdZiCnHYN4ijckgvyZoeHNbEzxEM9X6XAfZG1xqayT4ECCoPppj63BNodT+4ZXHOeePH2zJycIOxqjE1eYB/qIsyAXC7ZGUGNnOzRyU6HA=
Received: from BN6PR17CA0043.namprd17.prod.outlook.com (2603:10b6:405:75::32)
 by DM6PR12MB3932.namprd12.prod.outlook.com (2603:10b6:5:1c1::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.20; Wed, 20 Jul
 2022 06:00:21 +0000
Received: from BN8NAM11FT036.eop-nam11.prod.protection.outlook.com
 (2603:10b6:405:75:cafe::c9) by BN6PR17CA0043.outlook.office365.com
 (2603:10b6:405:75::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.20 via Frontend
 Transport; Wed, 20 Jul 2022 06:00:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT036.mail.protection.outlook.com (10.13.177.168) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5458.17 via Frontend Transport; Wed, 20 Jul 2022 06:00:21 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 20 Jul
 2022 01:00:19 -0500
From:   Appana Durga Kedareswara rao 
        <appana.durga.kedareswara.rao@amd.com>
To:     <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <michal.simek@xilinx.com>, <derek.kiernan@xilinx.com>,
        <dragan.cvetic@xilinx.com>, <arnd@arndb.de>,
        <gregkh@linuxfoundation.org>
CC:     <appanad@amd.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <git@amd.com>,
        <git@xilinx.com>
Subject: [PATCH v2 0/4] drivers: misc: Add support for TMR Manager and Inject IPs
Date:   Wed, 20 Jul 2022 11:30:12 +0530
Message-ID: <20220720060016.1646317-1-appana.durga.kedareswara.rao@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 383889f9-41c3-4e42-db7c-08da6a15214b
X-MS-TrafficTypeDiagnostic: DM6PR12MB3932:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3ICOtTMrIJTuXjk+C0inyisJIsiXWnYg921ckrGT5bz/h/8D3+p+cGsyVIGlo0g93lg2OwiYFNbaL14XKeK8KrRnjTNA6uZEcjLLzfleWOETjsmgDwQrqj3YKbEa2rWYRTQuKISMU09+V2RVG7d2JwWGx9hc2Pacr9llpe/Xbscr5ovaHTz8U2gD2KcKgE2+shJHY6HpdYHUD2w3ozUjM0EVofr+R6831uNyT+1uVcrfhxfAXJdMaqHdyRhlaTEDmUABqPMPfWBow6LVWPHdzl1rAwl87pEipW/2M1VP6P5H7MtrzCPrSmbvqUJhyhAr6vGlkZ5DQIaA+mRZuMxVbbjhvNJAhhzBFz9nubnU0qXR0+8XUTpkuzouF9r57/njQzmajydXKtKNEEu0S5BHRyruVw0nA6C/blcDVtsFzRH35iTdO0MRLHjdkGmtA0tdEy4hiaY5vXGIYPyaykVxBU2XUY0DZqRC61UyrbD24R5b6V/YRYLfy2c278ORz652Yfd+YZUGtZtGh0RYl03TMkZ7mAzIjRo+Pek/jIeBZQ7pFbq+Xl7TtJG2yCtApkAcNMdiedfIEEn26zvj58o8+J8mwmTA2qY7Grpygw9gqx/uyAWGoOOmb4r0ZFWEl9IEVVlt10VH92jEPBJfbcRnWDhEgcYptJtp3UMETcTcKNl7LTMwj8axdktVvqxqoeblUFyIJL0B/Rx9Y2MTxCVxdAsgCRIfLgBKsplOORF7ecPYssXLtysJAMmAHQHi5emv2kImWkKnQng7+LGBrbuyGIcf0DcXBadxK4D3U8LuSiHJC09N+SELKkEkkwb3rf0XT7KFEm41tNtXfQqkdAzyvsSpE/SUK9FHdasFAeWcdPYZwOLsMN6gAKc03u9fsPGdKdf6aCJHp/a3aUYa7PPLnXFQScIwtNZgmKP53t4ufVU=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(346002)(376002)(396003)(136003)(36840700001)(40470700004)(46966006)(6666004)(86362001)(356005)(103116003)(36756003)(82740400003)(110136005)(26005)(186003)(426003)(2616005)(1076003)(47076005)(16526019)(41300700001)(478600001)(966005)(336012)(70206006)(5660300002)(316002)(107886003)(82310400005)(4326008)(54906003)(8936002)(40460700003)(8676002)(40480700001)(2906002)(81166007)(83380400001)(70586007)(36860700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2022 06:00:21.1042
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 383889f9-41c3-4e42-db7c-08da6a15214b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT036.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3932
X-Spam-Status: No, score=0.9 required=5.0 tests=AC_FROM_MANY_DOTS,BAYES_00,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
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

This patch series has a dependency on the patch series
https://www.spinics.net/lists/arm-kernel/msg991887.html

Appana Durga Kedareswara rao (4):
  dt-bindings: misc: tmr-manager: Add device-tree binding for TMR
    Manager
  drivers: misc: Add Support for TMR Manager
  dt-bindings: misc: tmr-inject: Add device-tree binding for TMR Inject
  drivers: misc: Add Support for TMR Inject IP

 .../testing/sysfs-driver-xilinx-tmr-inject    |  16 ++
 .../testing/sysfs-driver-xilinx-tmr-manager   |  27 ++
 .../bindings/misc/xlnx,tmr-inject.yaml        |  47 ++++
 .../bindings/misc/xlnx,tmr-manager.yaml       |  47 ++++
 MAINTAINERS                                   |  14 +
 drivers/misc/Kconfig                          |  20 ++
 drivers/misc/Makefile                         |   2 +
 drivers/misc/xilinx_tmr_inject.c              | 186 +++++++++++++
 drivers/misc/xilinx_tmr_manager.c             | 253 ++++++++++++++++++
 9 files changed, 612 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-driver-xilinx-tmr-inject
 create mode 100644 Documentation/ABI/testing/sysfs-driver-xilinx-tmr-manager
 create mode 100644 Documentation/devicetree/bindings/misc/xlnx,tmr-inject.yaml
 create mode 100644 Documentation/devicetree/bindings/misc/xlnx,tmr-manager.yaml
 create mode 100644 drivers/misc/xilinx_tmr_inject.c
 create mode 100644 drivers/misc/xilinx_tmr_manager.c

-- 
2.25.1

