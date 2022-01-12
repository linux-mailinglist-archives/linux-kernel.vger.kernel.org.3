Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00C8448BE6E
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 06:50:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350950AbiALFt6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 00:49:58 -0500
Received: from mail-mw2nam10on2083.outbound.protection.outlook.com ([40.107.94.83]:37312
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1350927AbiALFt4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 00:49:56 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bJrFc2aD7jmYf9I9BXyIEtE74MmEAx0fhxtn71ZBitxW3MUlxWcxPKXcGvUqeNEK04B0fXa0O4PUpptk60tbs8xzMcqrEPxmL/Wi5QLvaLjSutJywA0DOB7fuVxHNgaV+14sBv6Webe9CiBDspjbhFBboHbe6yxNZVUxdv6Pd22C9bzo0qr3G1qshISyXfRAsU+HpatZThDhmtWF68fn/F33oIL4YQMwuzlJ02+uUSEjO51t9jfWQCdHzWMNx5me9Rk+te9bZfY45qx4yzzmVE40rqmB47jL8IcN5IvyFHApJK58SVAEd9xwWdOEcdHqmfBB6N/jeD9Qjs9BTPq41Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rjMlsPNiokLHy/UYX4AZZX07zNm7uYDuP3P3xW6aehs=;
 b=fycGm8cbuwpwRvF5tXHzmlWBLXLv8eHuT4im40444XR4mHPAtc57WtkTUxqFDpytrvp7HSHL57zX6OATKVEnL0HgiWKDXHxcd/crZMg+K6Bx0y5MK8B7+AsMgm4byZwzG0bRlgFg1Vd7r6rYyqv2E9/WjMiYcaloSK0hyS6soSkHpdpQa9OXJoz6ZJlcFYTucc9ASzPpg2hmdnjNSEQaFiOmohem00PG3IqRhvNYenA04rhmjSY7xmjmt6exJfcB68olLKWqMH/ESNs2IvLhaxFOFKEr9Vga5td4jG0xKnR2RN7zlM22tz2hO75STgT6nWAJ+T62F3rM/4jWOCbcTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.235) smtp.rcpttodomain=linuxfoundation.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rjMlsPNiokLHy/UYX4AZZX07zNm7uYDuP3P3xW6aehs=;
 b=YKDVhd9AB1jzJMVTkueFWSOEJtsImZG/qO+ShlLRYQNxxOXXjHdMhaaDylxBXJaSXm+O+ppAeY2awOwfq1NY7CZyhQWxutHYLepbakHaSWrvktgFyc+iNRZxQZ1LFJrf4O24MvKuBsZed3aJjY1C9o7KpDZTpujsDC6BU5ob5tmRDWDZJNtxyIa1OCNcNm7nc3UiscmLUWrjJV56mv/oj+fZRb3WzmDMg7jF7a5MmkCRQpd7GYht96oTbv435Oya3lAfxqFKUM0Vc66v8IPSgJSr9lcezA9FCc5PWU+gP52Gp4odX30ELp0YJ0ICZ9TFPXv/5ceZUCiOh/EXShOCOA==
Received: from BN0PR04CA0140.namprd04.prod.outlook.com (2603:10b6:408:ed::25)
 by SN1PR12MB2431.namprd12.prod.outlook.com (2603:10b6:802:27::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.10; Wed, 12 Jan
 2022 05:49:54 +0000
Received: from BN8NAM11FT033.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ed:cafe::90) by BN0PR04CA0140.outlook.office365.com
 (2603:10b6:408:ed::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.9 via Frontend
 Transport; Wed, 12 Jan 2022 05:49:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.235)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.235 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.235; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.235) by
 BN8NAM11FT033.mail.protection.outlook.com (10.13.177.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4867.9 via Frontend Transport; Wed, 12 Jan 2022 05:49:53 +0000
Received: from HQMAIL107.nvidia.com (172.20.187.13) by DRHQMAIL107.nvidia.com
 (10.27.9.16) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Wed, 12 Jan
 2022 05:49:53 +0000
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Wed, 12 Jan
 2022 05:49:53 +0000
Received: from waynec-Precision-5760.nvidia.com (10.127.8.13) by
 mail.nvidia.com (172.20.187.10) with Microsoft SMTP Server id 15.0.1497.18
 via Frontend Transport; Wed, 12 Jan 2022 05:49:51 +0000
From:   Wayne Chang <waynec@nvidia.com>
To:     <heikki.krogerus@linux.intel.com>, <gregkh@linuxfoundation.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <singhanc@nvidia.com>, <waynec@nvidia.com>
Subject: [PATCH v4 1/1] ucsi_ccg: Check DEV_INT bit only when starting CCG4
Date:   Wed, 12 Jan 2022 13:49:50 +0800
Message-ID: <20220112054950.615341-1-waynec@nvidia.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 484a72ab-df75-48cc-1b52-08d9d58f5b6c
X-MS-TrafficTypeDiagnostic: SN1PR12MB2431:EE_
X-Microsoft-Antispam-PRVS: <SN1PR12MB24318139D5846D475608C6B3AF529@SN1PR12MB2431.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gy7SS6yiA2hOSGz9Hh9mS4g9Cfx6LQhT+phO3kbnr2ScY5/TqjHn8zaUe5qni9uTyoEwaZW3J4diwyRmKkC7EC7T95UGO5gu+Y5ugKm/E8Bx06uXdGbC/N4dE3r47/Lu9UHVUvP+NlC16ptGv5+JEJ4P60E7QXYywbYZ0pfC68CvxSGtJD3sfc8G+M6sjw1mfqR935x+/eRuT6MuxM5jPRNArPx3uVa/n2qEPvxcR0+GJakb8Dn/82CDBhxw/DcViuGxtz2nMc4kgDxbLJnrK7RgAC/s5Lr0qUgMqXFhZ71MTG3OhyIj9lTkQSUjPQcRezitl+4lGZ3mxnsgGKAFkm8QeEU9JnJ/PcdJVNsQb+UsxBZtoNbFadgnnOidRyRUN8JginHfXpnJH3u09M69qAALxl8gK9sNbrjr1P5O8qJajZoxH/tPZpyYPILCEhOcfW2rouLgw6Bfoenw9+Dx+Xf3OjQARJ0nZ6+5HxDoSjDGL/7hipPr/37XrgKERrtyzbnprbd0nzwEWwZ9YFqicLZjVmAL+sA45D+GN65q09QNZm3N0mt8NUmeEIzxRham4Fs9CUf23gs+ONRPmu2Q54BMx06wpBUxEtZjKYjrbecsLjxamHKNbjjeZuUPZyWKr882dietfr2xRDhifCK9K8FUq86L7kPKCfZOliQ11BFyXIPjZVbsQvcis/VgBQCPJMvjpZsg5mOgyZlyWM96TZoBy1B0QuqUwlc7aJ/FEltd59IMRzsOSc5cNb4FxNsnibG4CVuxQwfqIJS7FjgNH5mMDdY5hPhqjBhSNz9k+50=
X-Forefront-Antispam-Report: CIP:12.22.5.235;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(4636009)(36840700001)(40470700002)(46966006)(40460700001)(2906002)(356005)(8676002)(426003)(83380400001)(7696005)(1076003)(70586007)(107886003)(70206006)(336012)(54906003)(110136005)(4326008)(8936002)(86362001)(36756003)(316002)(81166007)(47076005)(36860700001)(2616005)(26005)(186003)(82310400004)(5660300002)(508600001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2022 05:49:53.8768
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 484a72ab-df75-48cc-1b52-08d9d58f5b6c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.235];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT033.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2431
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sing-Han Chen <singhanc@nvidia.com>

after driver sending the UCSI_START cmd, CCGx would
clear Bit 0:Device Interrupt in the INTR_REG if CCGX
reset successfully.

however, there might be a chance that other bits in
INTR_REG are not cleared due to internal data queued
in PPM and cause the driver thinks CCGx reset failed.

the commit checks bit 0 in INTR_REG and ignore other
bits. ucsi driver would reset PPM later.

Fixes: 247c554a14aa ("usb: typec: ucsi: add support for Cypress CCGx")
Signed-off-by: Sing-Han Chen <singhanc@nvidia.com>
Signed-off-by: Wayne Chang <waynec@nvidia.com>
---
 drivers/usb/typec/ucsi/ucsi_ccg.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/typec/ucsi/ucsi_ccg.c b/drivers/usb/typec/ucsi/ucsi_ccg.c
index bff96d64dddf..6db7c8ddd51c 100644
--- a/drivers/usb/typec/ucsi/ucsi_ccg.c
+++ b/drivers/usb/typec/ucsi/ucsi_ccg.c
@@ -325,7 +325,7 @@ static int ucsi_ccg_init(struct ucsi_ccg *uc)
 		if (status < 0)
 			return status;
 
-		if (!data)
+		if (!(data & DEV_INT))
 			return 0;
 
 		status = ccg_write(uc, CCGX_RAB_INTR_REG, &data, sizeof(data));
-- 
2.25.1

