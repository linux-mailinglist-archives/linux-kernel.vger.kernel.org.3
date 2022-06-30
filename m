Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C52A9560F94
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 05:29:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231243AbiF3DSW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 23:18:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbiF3DSS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 23:18:18 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2058.outbound.protection.outlook.com [40.107.100.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8750613DDC
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 20:18:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ASHV2L2pGU+IOTxMkvyWlH7hX+YzI1Mds7b+CFQ7sXHeuzPz8vts86QOpb4CEfA5whqLwfGEAbUjJGWfQdelRAEHspB6Ml2oj3B2xStZwZ5Fis/c4e5F3l0mCi1aTrHhHDELtM6Hgo7Enalr5eJeplDv5Ksf4gVOj2OPRiSABfHlDgcgVeCkG3d4xBHMZfLyW62FWgzJNSEIAmSlr0BUip1D1SI+TPGmtPdtL870QdHqARPL/yVpFoeP2Orq2FVcMnpEsC1tkZEFp6IdvVRRryc4Y/D78s3mIJgU845NcRiqCRl497kc+2+giAdaxl659HKOsBqba13REeFUuuCtug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yDWay7Sj9Pa2Pe+w6/x8ULZbYx0ciSj9DA01e1E9MnM=;
 b=b5rk3bSJvZYfY8824xgDz1WPrtAxExs3E+EOlNhg3tV/lTmSTbZqDcQXJxHoCOqmJsFB2aWYGKwmxuDgcISzmYVJKiAt7+YWJ9NeR6mQ/D3lL53NlqvBdrIpI/vw6eVJosvKPbeWQ0C7rOxMn1ANnKrnaIga6rrvc6lCB9jYPC8iaPfxY24P9+ADbvumUOMZnf1aSOxTbc633Ag6fXka19sC1RoDgmkmXi20RXEYPsy5zIVx7vR+AQwYmHu4Dqi4UEazCntP/AWkmKqmctC2XgWKTxk7h+WKeNUpCI6masrubCmM/bcH1/zvTLwvk7Y+bga3OgR5WP6ESsmgpdr8gQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yDWay7Sj9Pa2Pe+w6/x8ULZbYx0ciSj9DA01e1E9MnM=;
 b=N1Qw/3at8JEN7wDxhoftWyePcEEIp9kzy0utVLTHQDc5t01thg3+QhvzGAnwCl9cblQcv4KhqVvyQSKpxd0OyLcnrrIMvfYzJ/YksmL56QGnyz5aW6gIBHFDWqz3+D3tnv4OMmmD4svij52leFUyTUYy21ui8BW2P1A03qQMyh4=
Received: from DS7PR03CA0357.namprd03.prod.outlook.com (2603:10b6:8:55::10) by
 BL0PR12MB2820.namprd12.prod.outlook.com (2603:10b6:208:80::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5373.18; Thu, 30 Jun 2022 03:18:12 +0000
Received: from DM6NAM11FT028.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:55:cafe::d) by DS7PR03CA0357.outlook.office365.com
 (2603:10b6:8:55::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.14 via Frontend
 Transport; Thu, 30 Jun 2022 03:18:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT028.mail.protection.outlook.com (10.13.173.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5373.15 via Frontend Transport; Thu, 30 Jun 2022 03:18:12 +0000
Received: from SATLEXMB07.amd.com (10.181.41.45) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 29 Jun
 2022 22:18:11 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB07.amd.com
 (10.181.41.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 29 Jun
 2022 20:18:11 -0700
Received: from vijendar-X570-GAMING-X.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.28
 via Frontend Transport; Wed, 29 Jun 2022 22:18:01 -0500
From:   Vijendar Mukunda <Vijendar.Mukunda@amd.com>
To:     <broonie@kernel.org>, <alsa-devel@alsa-project.org>,
        <dri-devel@lists.freedesktop.org>, <amd-gfx@lists.freedesktop.org>
CC:     <Alexander.Deucher@amd.com>, <Basavaraj.Hiregoudar@amd.com>,
        <Sunil-kumar.Dommati@amd.com>, <zhuning@everest-semi.com>,
        Vijendar Mukunda <Vijendar.Mukunda@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/5] drm/amdgpu: add dmi check for jadeite platform
Date:   Thu, 30 Jun 2022 08:47:51 +0530
Message-ID: <20220630031755.1055413-2-Vijendar.Mukunda@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220630031755.1055413-1-Vijendar.Mukunda@amd.com>
References: <20220630031755.1055413-1-Vijendar.Mukunda@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3905070b-4cad-403c-7e34-08da5a472a24
X-MS-TrafficTypeDiagnostic: BL0PR12MB2820:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dDBNfS5C+B4d2wPbGEUFpv4DugqfSEK8BBKmpRuGYDPugJopau8cZOVHITLOP7uEdnSZam8wUydwMBJ9dXgjj7KyBVqkttEe9FaVps6X3wGggVA6AtGIhniPQAeHaN58Kzon5EcnZJ1iuHWsI2mMBfJEvkEgK+ehUeQ9+1zIdFw6UtTBvb0VCHtE+kSmKJQmA1fModX5cMe6kFuSBG1ADnoewwKAvOiMI40iBGcABMASAH3W3CYNVbRS5RVhhmglBpQNxb/ngo2cS17O37x8QDAeZn4w4lW/RazGuTELGcDsTYwt3OmgpaZAgn8lf5tqxWKHQe40NGA1Ey7Zumrg20dNPliepBKARrdpiG9pJTkWoaTe7xklcRI0QG0niHaRDMaGYNBe/owfjhkcUNKTncjqLtlyNO6nzoG+HBlRsJsOCl9m2b56wiP9s+xPMwbBdxHAhaoPfZ63eaypAM0ITJ42mkoeaUEknRXokCHAnOGbfTFvBS3OcHH0niy2kTnCFGNglyLgNQp8EgOCFpYnRusjv0FvR8TMg8/yJskSsVbGdJit1S4DndD5Mh0sJQA1CQFs4PedD3zJPGhQINqrR6QHPc58xuBEHm/x1Wn/oauVqyL9fyZ30d4mbCWvr9og4RbNY3YiIp3iNUJ10uBrZ3HZik0pkdSh4Pz9kOGqMyZoYa1Q6LNvSjjoNtXYGxcFi9BuyHz9KHPIAOvHQ2sPYjx8XoEUBOtBpvv2FikE5YWWzAl/ecMkyNT6GyslgJSvDF4EothDf3FvJ+7yvn3EDORO/pCI5IXGUBDVuVfKDMYS5FOl0QIyp6kQkfN/YUQPtKbHrDjOZ04QJT5fiLkM9NKltW+2a6i7uesVneNt/QE=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(346002)(396003)(136003)(376002)(39860400002)(40470700004)(36840700001)(46966006)(5660300002)(36756003)(41300700001)(2616005)(8936002)(86362001)(54906003)(1076003)(83380400001)(316002)(40480700001)(40460700003)(36860700001)(356005)(478600001)(82740400003)(47076005)(426003)(6666004)(186003)(7696005)(336012)(2906002)(8676002)(70206006)(110136005)(4326008)(70586007)(81166007)(26005)(82310400005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2022 03:18:12.1621
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3905070b-4cad-403c-7e34-08da5a472a24
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT028.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2820
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DMI check is required to distinguish Jadeite platform from
Stoney base variant.
Add DMI check logic for Jadeite platform.

Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
Acked-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_acp.c | 36 +++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_acp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_acp.c
index ba1605ff521f..af7b42056a89 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_acp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_acp.c
@@ -29,6 +29,8 @@
 #include <linux/platform_device.h>
 #include <sound/designware_i2s.h>
 #include <sound/pcm.h>
+#include <linux/acpi.h>
+#include <linux/dmi.h>
 
 #include "amdgpu.h"
 #include "atom.h"
@@ -36,6 +38,7 @@
 
 #include "acp_gfx_if.h"
 
+#define ST_JADEITE 1
 #define ACP_TILE_ON_MASK			0x03
 #define ACP_TILE_OFF_MASK			0x02
 #define ACP_TILE_ON_RETAIN_REG_MASK		0x1f
@@ -85,6 +88,8 @@
 #define ACP_DEVS				4
 #define ACP_SRC_ID				162
 
+static unsigned long acp_machine_id;
+
 enum {
 	ACP_TILE_P1 = 0,
 	ACP_TILE_P2,
@@ -184,6 +189,37 @@ static int acp_genpd_remove_device(struct device *dev, void *data)
 	return 0;
 }
 
+static int acp_quirk_cb(const struct dmi_system_id *id)
+{
+	acp_machine_id = ST_JADEITE;
+	return 1;
+}
+
+static const struct dmi_system_id acp_quirk_table[] = {
+	{
+		.callback = acp_quirk_cb,
+		.matches = {
+			DMI_EXACT_MATCH(DMI_BOARD_VENDOR, "AMD"),
+			DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "Jadeite"),
+		}
+	},
+	{
+		.callback = acp_quirk_cb,
+		.matches = {
+			DMI_EXACT_MATCH(DMI_BOARD_VENDOR, "IP3 Technology CO.,Ltd."),
+			DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "ASN1D"),
+		},
+	},
+	{
+		.callback = acp_quirk_cb,
+		.matches = {
+			DMI_EXACT_MATCH(DMI_BOARD_VENDOR, "Standard"),
+			DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "ASN10"),
+		},
+	},
+	{}
+};
+
 /**
  * acp_hw_init - start and test ACP block
  *
-- 
2.25.1

