Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 101BF549F91
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 22:39:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241053AbiFMUjO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 16:39:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235600AbiFMUiW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 16:38:22 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2076.outbound.protection.outlook.com [40.107.236.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 001175B3E9;
        Mon, 13 Jun 2022 12:30:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YKQsKKIeP92CXaCSWgcWU1DY7Oyc7aApjk34nZ5yolxQVooG/Y0TDelV7dylRGJPVHN1LWPznHgo+w9clAT+XlEHYbHAlRPCs8g7pwp1GNhX8VYuG2N7XFnSTy6TmFPUkdZd77VrXwkleMDTWw7PelwYHGzSq7iJYM9d1dSAuukUYsCycdUqgOLHjqI431MLshVVemS6M9Mz4k4ON2JsgZAzJCfN71nHU+Ibz3J1P6tvnGM/mTIoD/7eJZ7K/nSu03+9s5TnGX0vmebKU+0jv6r6Cj+KdttvkWX55miM8H8jF2P66+Tl0r3Dox+SjUZfDfbnlm4JiXHUAvTClVOPMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6Yf26bWvXv0u8+c8MDqlJII9rZ5GCpxcDTeGE88n69U=;
 b=BkcbbTE0AEfmBjkELVxQNFlcon79tLIuJrpUMelhvP/FqdkuYhzHS0F7kimqHUVrZbZGBkCIOnGIrwoiHTX+1A3hYfi6nn0NkQR7xp7mWt4tHHc+Q6ICPMlsxluEXZ72EJpypZ1HOn8+se+mXGppqb+zL8L19mTyFYQm4+stJ6qx65qJnehq0otxjL2QGGfJjuKdSybuOgJlEeRqwnq7H4aT2dFdOpzQl8Uq73UDkEjZ3gw126Vc21CqjnbywiTVXxufn0Z54PZ7dEKx5PZFr3nmQBcpI8zptJsbQnpf8uvNlsaX2e+JQJ/H0XvNz+77SGaq0HttD7gMpALYFOtGMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=ladisch.de smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6Yf26bWvXv0u8+c8MDqlJII9rZ5GCpxcDTeGE88n69U=;
 b=MUJVx6QqvnjmyYPSz3N0qD7SA0b/0ZaMpp8SpLk2sRA9C8U2KmnHzYDIrsLurMuVtJh8LnGUmsRYHJY+pMkp33Ec2/4g8xY6ogIVyJgJkRur5A6RUobucq/RS75urq53N9RQPBYBpFVcjmTgf9HbOaBhMcOkWMxVEhACuuFu7fY=
Received: from MWHPR01CA0031.prod.exchangelabs.com (2603:10b6:300:101::17) by
 BY5PR12MB5510.namprd12.prod.outlook.com (2603:10b6:a03:1d2::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.12; Mon, 13 Jun
 2022 19:30:09 +0000
Received: from CO1NAM11FT010.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:101:cafe::97) by MWHPR01CA0031.outlook.office365.com
 (2603:10b6:300:101::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.14 via Frontend
 Transport; Mon, 13 Jun 2022 19:30:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT010.mail.protection.outlook.com (10.13.175.88) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5332.12 via Frontend Transport; Mon, 13 Jun 2022 19:30:08 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Mon, 13 Jun
 2022 14:30:06 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     Clemens Ladisch <clemens@ladisch.de>
CC:     <linux-hwmon@vger.kernel.org>, Guenter Roeck <linux@roeck-us.net>,
        <babu.moger@amd.com>, <yazen.ghannam@amd.com>,
        <linux-kernel@vger.kernel.org>, <x86@kernel.org>,
        Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH v3 0/6] Add support for upcoming chips to k10temp and amd_nb
Date:   Mon, 13 Jun 2022 14:29:50 -0500
Message-ID: <20220613192956.4911-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3dd587ea-3f72-4169-93d6-08da4d732060
X-MS-TrafficTypeDiagnostic: BY5PR12MB5510:EE_
X-Microsoft-Antispam-PRVS: <BY5PR12MB5510A24532EBC2CFAACECB8BE2AB9@BY5PR12MB5510.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lN4UaMI3mYTNE+ySPgoVtmgV8SjN3vYgUl0g/XJGwrSM86tBT9HRp3aBWdUkJhuToL3UipcyQ0qpsMu/fU9l6wCHA0S9Oo4kxnX/7mtjv5/oeRtngeZ3yI1OhPbzz1GbzNTHIp0ctbQCyZRNOXwxy/UPjUC7nRu9k+/a5pGERGKqGXeibBzcp4CnY7sMQ9RXsMOWbabLSj2/G5ulhunZF1Zyyz7iOQMgBRUYSRVON5KdNmgme1m4Hlfro7kxesmpJr/qPinismuOTb7im4sBRsggjTqj2sAZKcqWTCptFbXPZ3XpweNukrJO5sBpsbOuLr67SWHxXOFk7UcE5dsDZhossQDAaA57mg0YTCiJ5BaRGbuTo1I/DaOe1F6SI9hv5hcaWrkH+l8Q2z7/AcNaYwmQNEB8Tat8hiVciH0xm/EEjcCdGIiAsGmvVmsj8dlODj3mvdPEjc5ZAjSyqaj2U86ecueg92AeZnBEE3rVFCuqIuu1DswAizz5lTFPpalm7X5QkvJKw7EoA8xEVvRptYyi6YRVOb9gIUcrT1OHKystPJjcWtD3wf1CFgSkfT9vLVZDN06Fp7HhpGaVQP+S2fCu16vor1oKXXCHANkdwU2JHw/DW+JRjZQcqwnInp8gzE2EqzE3pOiekuDw9kLIz6aTzq4cWt49BuwMrceDpVraK6121x2mt89pooTV4gdwxJ+WDXH3w6h1OUNc/Zoe9w==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(46966006)(36840700001)(40470700004)(8936002)(44832011)(2906002)(5660300002)(70586007)(36860700001)(70206006)(4326008)(356005)(83380400001)(8676002)(316002)(6916009)(54906003)(336012)(47076005)(16526019)(186003)(40460700003)(6666004)(7696005)(508600001)(1076003)(2616005)(82310400005)(86362001)(36756003)(26005)(81166007)(426003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2022 19:30:08.4249
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3dd587ea-3f72-4169-93d6-08da4d732060
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT010.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB5510
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series started as what looked like a correction to previous
commits, but I missed that the previous commits were for a different
family with the same chip models.  So while fixing up the series I also
noticed that a few upcoming chips have new PCIe IDs and CCD offsets not
yet supported, so add them to amd_nb/k10temp.

v2->v3
 * Pick up tags
 * Group "ROOT" PCI IDs with others in patches 2 and 3.
v1->v2:
 * Correct commit messages
 * Add more missing chips and offsets
 * since so much changed, do not include Bjorn's Ack.

Mario Limonciello (6):
  x86/amd_nb: Add AMD Family 17h A0-AF IDs
  x86/amd_nb: Add Family 19h model 70h-7Fh IDs
  x86/amd_nb: Add Family 19h model 60h-6Fh IDs
  hwmon: (k10temp): Add support for family 17h models A0h-AFh
  hwmon: (k10temp): Add support for family 19h models 70h-7Fh
  hwmon: (k10temp): Add support for family 19h models 60h-6Fh

 arch/x86/kernel/amd_nb.c | 13 +++++++++++++
 drivers/hwmon/k10temp.c  | 12 ++++++++++++
 include/linux/pci_ids.h  |  3 +++
 3 files changed, 28 insertions(+)

-- 
2.25.1

