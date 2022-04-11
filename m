Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACB984FB4EB
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 09:33:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245487AbiDKHez (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 03:34:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245492AbiDKHew (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 03:34:52 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2073.outbound.protection.outlook.com [40.107.94.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 708EF3D4B1;
        Mon, 11 Apr 2022 00:32:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bo5GBrHpPIALBzFtzOs+uJaVhL6qExtKShZsqAWCON7C5EriVlfu/IpUPEGstshEopkob2MGUUxIWRfWP3mttoOcoNSjJh1/loV+MY2vmKtspiksN6Oak6ve3HMnW7G+HJ0unEtW36zp6ySUqqOKde8fHXahfiIZRNNfmdmn06yWpsILxVUkht7wYJ5UJADd9xh6lPMq/dlQBvvFgCum4+tmxvNSQoQAv4O5wYSjr3ro/sLmaFkGWERI4sBx0vE6EV7y8wjdCzHA1zryIXrolmtXJi0K4TjGaHfKgrW0SO2y+DXPi3hiLO8Bx76FV7qx8JtZEQWY82D38tp4ncLdCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tXHKqaS6RLDdXU0leddq8ytzwOvyUwOboB+9vJFp2QE=;
 b=SVJ3LySLLY4SXi6xXmxS6HRxP+cwmB31/2NULNXXfRxRSJ+lvUUfo0eGBVz4bEfdEAcipCncGm5Qhe3s8HN9TUikmGiW/x3iTZVfD+lA0VrOKMTMThyTWigy6tHxXK37kmQ8hbsKE5FvOsf9kcl1vWuRPcYHsuy2KYMNhrze2zx/ikA924O0jc5R5bI2iHJryzPvH3/ktlQZvHWiAkEpjlHMOA5h06wIAqb2TxcvccEPCSa0xVnXGkJKC9j87/GhlKiWbqcI124CMk5UmrlwZ3gLlXqs/uBR4Q7VjqU2gIfdR+GfKUgDlRL7sIJI2HcdvrXQVcT8v9e1TRoNS/VYlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.234) smtp.rcpttodomain=alsa-project.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tXHKqaS6RLDdXU0leddq8ytzwOvyUwOboB+9vJFp2QE=;
 b=Wk7NdN62rYmy40f4EibhQLw1mP+tc5FBPl9ik+H/mXf4kUbYHlOgEdOq+xRX1R3iOV88o1OVfJcbz6Jw+7zJeu7deDn3MJI3cAnzsT3NAI1EorRY07fUpWJ1h4YbxxrQDLkDL9pnmVREX+1tP4ctT7xuduAc+HWH6cxNp1Lrn8yQSK+u0x8Y/yV1vgMNCaV7SWQ1Wh1Z95s6Ne1fmnLSde9FNhv4RO70tzqCOCEPb5/x8vM/UO0ZlcQSQqrl8TEmjJ/xWk5tpN4TCAhqiqzAhLluE4zSno6ytOuZ5XfaQ4sKs75nZS+qTH6qJcjbnXG7jDkRs8cuKaufAzmnFd4www==
Received: from MW4PR03CA0004.namprd03.prod.outlook.com (2603:10b6:303:8f::9)
 by CY4PR12MB1207.namprd12.prod.outlook.com (2603:10b6:903:39::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.29; Mon, 11 Apr
 2022 07:32:35 +0000
Received: from CO1NAM11FT031.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8f:cafe::be) by MW4PR03CA0004.outlook.office365.com
 (2603:10b6:303:8f::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.29 via Frontend
 Transport; Mon, 11 Apr 2022 07:32:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.234)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.234 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.234; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.234) by
 CO1NAM11FT031.mail.protection.outlook.com (10.13.174.118) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5144.20 via Frontend Transport; Mon, 11 Apr 2022 07:32:34 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by DRHQMAIL101.nvidia.com
 (10.27.9.10) with Microsoft SMTP Server (TLS) id 15.0.1497.32; Mon, 11 Apr
 2022 07:32:31 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Mon, 11 Apr
 2022 00:32:30 -0700
Received: from mkumard.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.986.22 via Frontend
 Transport; Mon, 11 Apr 2022 00:32:27 -0700
From:   Mohan Kumar <mkumard@nvidia.com>
To:     <tiwai@suse.com>, <perex@perex.cz>
CC:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <spujar@nvidia.com>, <alsa-devel@alsa-project.org>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Mohan Kumar <mkumard@nvidia.com>
Subject: [PATCH 2/2] ALSA: hda/tegra: Enable Jack poll for tegra
Date:   Mon, 11 Apr 2022 13:02:10 +0530
Message-ID: <20220411073210.23445-3-mkumard@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220411073210.23445-1-mkumard@nvidia.com>
References: <20220411073210.23445-1-mkumard@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 99af016b-5988-43af-a422-08da1b8d7201
X-MS-TrafficTypeDiagnostic: CY4PR12MB1207:EE_
X-Microsoft-Antispam-PRVS: <CY4PR12MB1207E4CF2514B6199E1C0B5DC1EA9@CY4PR12MB1207.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Yd0VA34Fsh7j1modln8kM5I+G7sGl39u62qXhvMoqK8pR94KHP50oPkaJWbL65wjpsXKxaJn95QASpoEeOIhDo5RUR8vLqL8IzRtcCpkis897txVu0QDfPadV10fTeMuZYjMltVdACTlDsESlkeKbMZVuwwKPU187Ud6N6qubjBwnAi6c4eiVTCfB27RvTNHejwV1RVDWoMBrTs7qk83F5psUYgsvb8VjlgDDURmfvvEdMbY9iXTw4kjHANd27T64wZ6aEIqZ0xipenwAs2MvIXlQMC8NEyf/3l7ledFoxFnYMndvxSc/DsrDaLF/n4M3FsrHy0TKaZ9dGUlE/wyPXKF0dfZgE+8Dx0Oy5qAja36RGPBCAg9MlSno1708NWJD3D0jhJE1EXbb7APNd6cp2gcFWugsW0iUMemPKJjvEcAvGI+aXr6hIpm7eXXJNjAPtPd7atmVyEH2mgCJizEVoiP9+BPDgpOepDngSCVxAy4YTNuuOFXEq5zjmBfjqVRjuqrDIoO9ZN9fybubTP4JPfBJz/psU7WiuZFuOsqrs4qFV744OBfHoINYXJuu7pQx++xKuXMJIN5bgxjGicQu1jJ+S+49GZ/h2/N9KaXTGnz4hDIiKt3LBtIgcvtD2S5WJ8F75lXq+FuEsnJ7w/NI8AUM8/HuUkSKrzBuKXfUITX/kKlvo+tk8JzJva08r9TKEoqrcTISDoVms6aX2k7PA==
X-Forefront-Antispam-Report: CIP:12.22.5.234;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(7696005)(40460700003)(36756003)(36860700001)(86362001)(26005)(107886003)(70206006)(70586007)(1076003)(336012)(426003)(81166007)(6666004)(356005)(2616005)(8676002)(4326008)(186003)(2906002)(508600001)(5660300002)(54906003)(47076005)(110136005)(82310400005)(8936002)(83380400001)(316002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2022 07:32:34.2301
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 99af016b-5988-43af-a422-08da1b8d7201
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.234];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT031.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1207
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable HDA Jack polling for the tegra platforms as Jack detection
logic doesn't work when the HDACODEC in runtime suspended state as
unsol event won't be triggered during D3 state. This will help the
userspace audio setting controls to correctly show available audio
devices in gui.

Signed-off-by: Mohan Kumar <mkumard@nvidia.com>
---
 sound/pci/hda/hda_tegra.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/pci/hda/hda_tegra.c b/sound/pci/hda/hda_tegra.c
index 2347d0304f93..7debb2c76aa6 100644
--- a/sound/pci/hda/hda_tegra.c
+++ b/sound/pci/hda/hda_tegra.c
@@ -420,6 +420,7 @@ static int hda_tegra_create(struct snd_card *card,
 	chip->driver_caps = driver_caps;
 	chip->driver_type = driver_caps & 0xff;
 	chip->dev_index = 0;
+	chip->jackpoll_interval = msecs_to_jiffies(5000);
 	INIT_LIST_HEAD(&chip->pcm_list);
 
 	chip->codec_probe_mask = -1;
@@ -436,6 +437,7 @@ static int hda_tegra_create(struct snd_card *card,
 	chip->bus.core.sync_write = 0;
 	chip->bus.core.needs_damn_long_delay = 1;
 	chip->bus.core.aligned_mmio = 1;
+	chip->bus.jackpoll_in_suspend = 1;
 
 	err = snd_device_new(card, SNDRV_DEV_LOWLEVEL, chip, &ops);
 	if (err < 0) {
-- 
2.17.1

