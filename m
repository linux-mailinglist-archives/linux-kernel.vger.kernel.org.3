Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 483504FB4ED
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 09:33:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245479AbiDKHer (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 03:34:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243368AbiDKHeo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 03:34:44 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2053.outbound.protection.outlook.com [40.107.220.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F7733D4B5;
        Mon, 11 Apr 2022 00:32:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NyCIUup4Nbumtu7X0AephfjpAumzJaGqPpd63pMGtYm/HO0VC935YEneTEHCJkukRaack8NzyPYavj6Hbh8ZV4spo9+Cj25aLOdvNBZ8/G241hrLrSM378uGubARluLQz0+hAiZh+3+dFOQ1x27zLYxJ8RmCMx/QUSqH/74d4B7dk6pLDGm7iYiHJVyzJiIBRUJv1S97ZRCO1RW+laffuQLRRXn9WyUHcfBtRRBPYLwTduHZcpGrTDW0xDw50OdSurt36g23POtK01hZJZKfHPVW6vrYrmX0s42IWOERsV7LuOOj4KbK/lFeH9rYG8aKPGGb99QbCbMf2oTfDmd4vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sQY2mDcCoEHbExmTKoMgpvuZKlYuh9PHw1QFWoZ1TR0=;
 b=WGl4zr4kqNGeka5xsNsggY5wkbVgElCVVfS+UlGlaZ7EbmL92gSEPxkmGQU+4DWrhlPQ88J1v9ElIBNui1tK/gM7VjK9H0FX2AmbqoK9o/lR9CAg2hoOLfHT6d4mHdNJOV4+xCIZLlshWAqI9Xj3EoHWitRCeyz23PbwTjGKSUiTsx+B1B1lqxnekn7zldQ5VuWxF8legtF8TreN2CdUxdE+/T60FT6FAoJbMYIkPWr2DIZNSUVjBON4lVHAcjlmQBUjtrh2XvdHLqV/pOm1GgYg1hbZ4w+9LHOcdngFdIqV/tZ03udgdjeaf3LG7+ypKY/DjN1tbnwL4TSRx/Fqvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.238) smtp.rcpttodomain=alsa-project.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sQY2mDcCoEHbExmTKoMgpvuZKlYuh9PHw1QFWoZ1TR0=;
 b=Q7VHdD6/eRtJFhduvorHtaBekyuoa/PGGR0lTMOz2pljAF5ju4QKPHOrCJXfMrzjpEVVGWV0QE640m0NgTwO/yal16f3EDeWIAbCVa3QCYBqpbJy6xUip25keTEQeEcrRTz0QFzk51NJCgT+SFIgjtm0a3qrvlbNEXwWSLr6pHS8eLVC0XFM/GORGmfgR8fK0bKoNW/9Sg+uTOd//bp/EoVGlJXdzsM2V247bJbeWq8hwCjfMdYpqmAm7OOTwbpxzvXLFJvqe3VXfUduO4+JcJ7McILLX67FqTw12ZIoXa2QlG7yHoPsotT62l9oietMQHAGFV8lTrEVR2lnVoeOgg==
Received: from BN9PR03CA0269.namprd03.prod.outlook.com (2603:10b6:408:ff::34)
 by SA0PR12MB4589.namprd12.prod.outlook.com (2603:10b6:806:92::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.29; Mon, 11 Apr
 2022 07:32:29 +0000
Received: from BN8NAM11FT011.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ff:cafe::68) by BN9PR03CA0269.outlook.office365.com
 (2603:10b6:408:ff::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.29 via Frontend
 Transport; Mon, 11 Apr 2022 07:32:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.238)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.238 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.238; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.238) by
 BN8NAM11FT011.mail.protection.outlook.com (10.13.176.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5144.20 via Frontend Transport; Mon, 11 Apr 2022 07:32:28 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by DRHQMAIL105.nvidia.com
 (10.27.9.14) with Microsoft SMTP Server (TLS) id 15.0.1497.32; Mon, 11 Apr
 2022 07:32:27 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Mon, 11 Apr
 2022 00:32:26 -0700
Received: from mkumard.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.986.22 via Frontend
 Transport; Mon, 11 Apr 2022 00:32:24 -0700
From:   Mohan Kumar <mkumard@nvidia.com>
To:     <tiwai@suse.com>, <perex@perex.cz>
CC:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <spujar@nvidia.com>, <alsa-devel@alsa-project.org>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Mohan Kumar <mkumard@nvidia.com>
Subject: [PATCH 1/2] ALSA: hda: Jack detection poll in suspend state
Date:   Mon, 11 Apr 2022 13:02:09 +0530
Message-ID: <20220411073210.23445-2-mkumard@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220411073210.23445-1-mkumard@nvidia.com>
References: <20220411073210.23445-1-mkumard@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ccceeb4f-e7ca-4e9b-8775-08da1b8d6ecb
X-MS-TrafficTypeDiagnostic: SA0PR12MB4589:EE_
X-Microsoft-Antispam-PRVS: <SA0PR12MB458929BEA3733FFE896E2B2AC1EA9@SA0PR12MB4589.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7wJ7GbXbY9MUk7L2fQym7rnpQFO/puKJD/d986WH/WV0HW0s4/6IclFGH5ZLA6wZPgygzcI7YO8BztVa0ayyLquBZJ5OziQ+oc1MKtzeETXY7NoG1HeyEWNcGCpdX4FY2mBZFvPTS0oHZzp7hRYomDLzxb53zPv87ehcxsOGJY27zjMc/BjapY0QPpLhbrUvO2DqE9qM/rg31aOllXLssFGOjVDIOe2iU6EC1Q0pBUCmjUzpkIgsivzMrL5RyRpb+vfrPmqMT+X4tpvzrgYRFKkqN83XG7QUIYTkIDLoyZR+748gHrRkfWnjSp5zSs/bnR3WEOr+16tJFODIdqjiIF7xnV10xBCxt1EWAJGbzsO5XFBmRCt4WHpu8W7bhKecmLDM4C4aM4yvnaQbpzxFNBH/YipZv/Jdwn5pzXjXMmB9Of72CjBCyHTP1rfI6vEYH1CMwbtQl1xwJr4nHcGNEjiO9t0of8szqgPfhzON8EF+Qad2UfgElj2iIOOZNY2+FSXvHrGimZ2UvdtlP/ohj6/DaVwbhBQdTDaq3pdEJzHpgf8OtZUtrT57pv1makFMs8m/oT85fmJhqW5BCZbA4MMj26XiOtDq5fdKeC1sFEf4uicq1zvg+nu0dD/fRrIobdcE7eN8/go+B7Dk+IL8LTTiwrYk8firc35QWg7h3tO05yQ+1PGtM1zIWAP6Au/gN9sDdxJHK3Ji65dermnj4w==
X-Forefront-Antispam-Report: CIP:12.22.5.238;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(15650500001)(316002)(110136005)(7696005)(83380400001)(36860700001)(86362001)(26005)(186003)(336012)(6666004)(36756003)(426003)(47076005)(54906003)(4326008)(8676002)(5660300002)(70206006)(70586007)(40460700003)(2906002)(81166007)(107886003)(356005)(2616005)(82310400005)(8936002)(508600001)(1076003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2022 07:32:28.7798
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ccceeb4f-e7ca-4e9b-8775-08da1b8d6ecb
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.238];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT011.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4589
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

HDA Jack detection logic doesn't work when the HDACODEC
in runtime suspended state as unsol event won't be triggered
during D3 state. As pulseaudio server in userspace rely on the
jack mixer control status to show the audio devices in gui and
any display sink device hotplug event during D3 state will never
updates the jack status which will result in no audio device option
available in userspace settings.

The possible option available to resolve this issue is to run Jack
polling worker thread even after codec suspend state. The choice can
be made based on compromise between power saving or Jack detection in
suspend state.

Signed-off-by: Mohan Kumar <mkumard@nvidia.com>
---
 include/sound/hda_codec.h |  3 +++
 sound/pci/hda/hda_codec.c | 11 ++++++++++-
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/include/sound/hda_codec.h b/include/sound/hda_codec.h
index 77426ff58338..b7be300b6b18 100644
--- a/include/sound/hda_codec.h
+++ b/include/sound/hda_codec.h
@@ -59,6 +59,9 @@ struct hda_bus {
 	unsigned int no_response_fallback:1; /* don't fallback at RIRB error */
 	unsigned int bus_probing :1;	/* during probing process */
 	unsigned int keep_power:1;	/* keep power up for notification */
+	unsigned int jackpoll_in_suspend:1; /* keep jack polling during
+					     * runtime suspend
+					     */
 
 	int primary_dig_out_type;	/* primary digital out PCM type */
 	unsigned int mixer_assigned;	/* codec addr for mixer name */
diff --git a/sound/pci/hda/hda_codec.c b/sound/pci/hda/hda_codec.c
index 5cbac315dbe1..7579a6982f47 100644
--- a/sound/pci/hda/hda_codec.c
+++ b/sound/pci/hda/hda_codec.c
@@ -2935,7 +2935,9 @@ static int hda_codec_runtime_suspend(struct device *dev)
 	if (!codec->card)
 		return 0;
 
-	cancel_delayed_work_sync(&codec->jackpoll_work);
+	if (!codec->bus->jackpoll_in_suspend)
+		cancel_delayed_work_sync(&codec->jackpoll_work);
+
 	state = hda_call_codec_suspend(codec);
 	if (codec->link_down_at_suspend ||
 	    (codec_has_clkstop(codec) && codec_has_epss(codec) &&
@@ -2984,6 +2986,9 @@ static void hda_codec_pm_complete(struct device *dev)
 
 static int hda_codec_pm_suspend(struct device *dev)
 {
+	struct hda_codec *codec = dev_to_hda_codec(dev);
+
+	cancel_delayed_work_sync(&codec->jackpoll_work);
 	dev->power.power_state = PMSG_SUSPEND;
 	return pm_runtime_force_suspend(dev);
 }
@@ -2996,6 +3001,9 @@ static int hda_codec_pm_resume(struct device *dev)
 
 static int hda_codec_pm_freeze(struct device *dev)
 {
+	struct hda_codec *codec = dev_to_hda_codec(dev);
+
+	cancel_delayed_work_sync(&codec->jackpoll_work);
 	dev->power.power_state = PMSG_FREEZE;
 	return pm_runtime_force_suspend(dev);
 }
@@ -3038,6 +3046,7 @@ void snd_hda_codec_shutdown(struct hda_codec *codec)
 	if (!codec->registered)
 		return;
 
+	cancel_delayed_work_sync(&codec->jackpoll_work);
 	list_for_each_entry(cpcm, &codec->pcm_list_head, list)
 		snd_pcm_suspend_all(cpcm->pcm);
 
-- 
2.17.1

