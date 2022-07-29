Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D7E75852C8
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 17:36:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236674AbiG2PgF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jul 2022 11:36:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236178AbiG2PgD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jul 2022 11:36:03 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2065.outbound.protection.outlook.com [40.107.244.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 489E485FB6;
        Fri, 29 Jul 2022 08:36:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kK//y3WA6Jzro5gofUuMXCHxHIJc0HOiN2fT1dQ1RGwtVTWLr/vp3AWcBhGTeB9JU/cAVP7kfU3SZ5AP+T0+v+DIZzDYxUj+ChOLKbArUxHNRC11O+IQekWpMHe9EIroQeVZVVHQmVqpY7+qLUoMOHjBi0HwEJbBPWox10RfhppmHrU8MaFTYr43+kXfSqHuFg6RVsFUGHsOnaD2pnuv81iUfuBFEZkVM3FmKEM/mApiFfWE5jvEuUMEKRm7EeitQgg0+OHqH0kjpcRrv7EKRhl+lW3oEyGGYvnQNQstEy1Pt7hX6JI0/tuqC4Yd75Om63rFLkacfY2EgUi34js7Gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BdSiz0vnoedrlBBS501gRTLjfZPIDucUKdJzsNNofRY=;
 b=Jdk7WSzIl09lwuPtJq8l8OhLvLBJPYGBuuuRK7WMFE7iv+qrEHDUgZzrAzYmfuSPSH9WdcUyFQDszXZLcTMIoW55EflQqy/ln4KId5QQrsehv2aPiP8YIlCICFW042SOw7kM4TDKkCvyg/Kj5xPGJjjl8/JTPS4Vgrwsgv/Qav5JWsEBROMWBaSiFXyzyY+6gpDkGiStZHtCLtjUtXy5sw8pJY+gNj2x0rdhsIRaPZ5EHyEzxn1tTvXMYMuyoI9jzzaUHUTM0BPcyH9eE4Vzn3NHfCk9w1jMO6TXKiJefevP8VIN5VxAb6FVxFA1jgE9ARcUpDty86EY4y3rh8iOeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BdSiz0vnoedrlBBS501gRTLjfZPIDucUKdJzsNNofRY=;
 b=IbmNBRAjYf2uGOBBEX0tyvc2HhwTbq0scH15SYW0WlzBuNpVrPG+HYuDU0Lp2PtIrWrWBItorRdzmXuCEtenr5dA+SYiQ0HhkHtvlyuHyXPGlwRfkiyX/yCXawkDrS90MuN8vvDEyLxgq/pYfzOJdAQkaMDHuL2rlCATyVJx/kg=
Received: from DM6PR01CA0029.prod.exchangelabs.com (2603:10b6:5:296::34) by
 MN0PR12MB5859.namprd12.prod.outlook.com (2603:10b6:208:37a::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.12; Fri, 29 Jul
 2022 15:35:58 +0000
Received: from DM6NAM11FT037.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:296:cafe::96) by DM6PR01CA0029.outlook.office365.com
 (2603:10b6:5:296::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.23 via Frontend
 Transport; Fri, 29 Jul 2022 15:35:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT037.mail.protection.outlook.com (10.13.172.122) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5482.10 via Frontend Transport; Fri, 29 Jul 2022 15:35:57 +0000
Received: from ethanolx5619host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 29 Jul
 2022 10:35:56 -0500
From:   Jay Lu <jaylu102@amd.com>
To:     <jaylu102@amd.com>, <linux-kernel@vger.kernel.org>,
        <rafael@kernel.org>, <lenb@kernel.org>, <james.morse@arm.com>,
        <tony.luck@intel.com>, <bp@alien8.de>,
        <dave.hansen@linux.intel.com>, <jarkko@kernel.org>,
        <xueshuai@linux.alibaba.com>
CC:     <terry.bowman@amd.com>, <yazen.ghannam@amd.com>,
        <smita.koralahallichannabasappa@amd.com>, <robert.richter@amd.com>,
        <linux-acpi@vger.kernel.org>, <jayakumar.govindankalivu@amd.com>
Subject: [PATCH 0/3] ACPI, APEI, EINJ: Add new CXL Error Types
Date:   Fri, 29 Jul 2022 10:35:47 -0500
Message-ID: <20220729153550.181209-1-jaylu102@amd.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e17ad784-efdd-451e-79c7-08da71780875
X-MS-TrafficTypeDiagnostic: MN0PR12MB5859:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YrQAuJ7JavIAWv5rMehLIxS3t24IeqKAVL3rjXAFrMMhPDU7gqSzWDoBcGXS9VejTrSqzWZ2tLRxtoX9UGpL8iLMJkVpiUhMUQGNdeHB+KSLcbqDcBrQKEIjAzl9qaSHtDCExYtSuae+l+dhDEBhXi1MUpzUdZoBAhR47MvHHivSTJmnaxXpUNlMobgQ5gshwTQh/m5SQ8YWS44PQMwdoen2fgvBmFxPCcJoQ3GqOJQ7CB7Mg5pF7StcQmjgOQcCZIYZO3zra8UY2pGx0SAwNP7eP5cpKIzi7E8Gq4F9A/zY62/PlL5JWVta+hvev5hKwJdaVqFU2ZNXrEWNkcA9Qq75ybL06SU69IhglqcbIRORVKpDnWIjh8rS0Mv4M17LLzVLrJQZlp5Hh9+l09wKKgw99BR1WfxJwTOUPSpGIctYUdw2ovhN9nxe+/ijWiHZYvEkO2fsDwRDxwMZHVrtv5pA+XoS85n7DaCPhPa99es7qvWwBDWUdkQeeV/X/W7akmhisQPDCw8FRDCUkQrkdwVwy9ZQQBdubnipjKxl3YufppbLSmCr4EYQAXCpdYhxxSu37Ly2SGIDiWMsLSkS54Izj3kV9UQfxrrJa/W4Mg6N1sYDP0byzFy6IR+qHomCyHBKItTXbqLllx8R7CwN1A3WNrmruFAB5Cdc6+QD6FVrxUl7xRF25bgCiyTOUQ5ja+HQepxA461hcqkxq3eOodZ/HMRq7+KQ354EiDdAnVKCclI6+zMx1iHcPtViqSGYT5FbNG3x0I9g5P6p8GmKlyhtFfYE1TFwXa+PwFMyEfOqCGY0aDF3DjIRZ4t7GefSbYovWgEwfm4+6nKCVAq5C/J+FdWhve6AjZbBgfxSchc=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(346002)(396003)(376002)(136003)(39860400002)(36840700001)(40470700004)(46966006)(426003)(36756003)(54906003)(47076005)(336012)(110136005)(5660300002)(7696005)(921005)(356005)(40460700003)(4744005)(36860700001)(16526019)(186003)(316002)(1076003)(82310400005)(2616005)(26005)(8676002)(6666004)(70206006)(70586007)(4326008)(81166007)(8936002)(7416002)(40480700001)(2906002)(41300700001)(82740400003)(83380400001)(478600001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2022 15:35:57.7183
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e17ad784-efdd-451e-79c7-08da71780875
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT037.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5859
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix formatting errors alerted by checkpatch.pl, including missing 
lines and indentations to clean up for following patches.
 
Create an array to store error type descriptions for maintainability.

Add new CXL error types so that they are advertised.

Jay Lu (3):
  ACPI, APEI, EINJ: Fix Formatting Errors
  ACPI, APEI, EINJ: Refactor available_error_type_show
  ACPI, APEI, EINJ: Add support for new CXL error types

 drivers/acpi/apei/einj.c | 62 ++++++++++++++++++++--------------------
 1 file changed, 31 insertions(+), 31 deletions(-)

-- 
2.27.0

