Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 839E44F2171
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Apr 2022 06:09:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230208AbiDED2c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 23:28:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbiDED2Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 23:28:25 -0400
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam08on2071.outbound.protection.outlook.com [40.107.102.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7472C4BFF0;
        Mon,  4 Apr 2022 20:26:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mSPNfDMvPJAoo57gT5/yL5dp8aOXNvbl2kVY/n+RsXS8FiUjCRvgFx1eKvdFlUspvMN3VCgHPN1Y0GLDxfHpf9XUg0V2mQwr0OoF1BaXRQSDvcMGN8rfaiKE6+rMsdcWyZz+hnn/Cy0K+M//U6Ocph6uOmeGQysF2zdNqnG6Zo4tN6nkvE93bLC5xA4BX24PfclHE+97NdNZ+pcLvxDXpMUEl8uZQsNNxcqqrWsRoZVt+14iVhOMyQZSjhBU4n8dcuc9+/9r8J/h7F8uwfLQxE+5pGM6TJtJT2nM2jZGyEKr9D+AjfjZyxHBV1OkSuezI51Ir3yZkPJmO7n1i+3Pzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IA7zynkRaV1KdeaxxxQFfYP6tw2qcfFRprDw22m5CQI=;
 b=MsEtX8I14MnZsUZe/xgTkmcxUWM1sBD4g6gMwWL8AIIiNMwxy6EU34MkcS0AS7pv/yqwDiMjtP8vtsGRl9SaweVBeIzu9tuao2Je/TdRSGsQRbrB3iFpyFqf47UJo1SrzfNA4+tYsgNrKtiVKRjOeM400KzH3I23V3HRPG+1nBl9B+kBn1VcNwuiqXQk7ah7ReBW71SNPQvTLq5WdNl09I8/wocG5M631INMNzWjYTja7DHSp0xchXtr7hcRn/AVIsGaKKnNGJrVuduwjyfc1YwpERc4ysPAtQFKrBt2Z/+/n6U+uxkWAoyM57alxLePuL2HImECjV3VSJSyoHKp+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.234) smtp.rcpttodomain=alsa-project.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IA7zynkRaV1KdeaxxxQFfYP6tw2qcfFRprDw22m5CQI=;
 b=DGniTY8djwnW2hhMdgh6CHbtn+juIzx5VdTqIxoXYdIadODTNNhklotODtisrV4m6iMDSrNo8vNsQo0+G24HrYQT/liySjVZ5vOw7dUKjHxpT98mck0ktywh30I/EXWtbFTF+YGkJh318DzqaBaPD2d3uJFL5jCy4LqC2dDnj6E1BD+9I7hVhpfIyv3W5TOQghpEg27TbDUSHxlT7kmL0TJU6kqX7k9tC5wEPT7U3YkjjOCGT2JeTZ0veSzJjEW1zeiDztHopGKtQoDCqXbRDHT3gNQanE/HXF3xBEPDU4EWtWArnLMSip4hmOZ2Cfk10Ujyiq6FwNjmVkYvIq+mow==
Received: from BN9PR03CA0092.namprd03.prod.outlook.com (2603:10b6:408:fd::7)
 by BL1PR12MB5096.namprd12.prod.outlook.com (2603:10b6:208:316::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31; Tue, 5 Apr
 2022 03:26:25 +0000
Received: from BN8NAM11FT064.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:fd:cafe::10) by BN9PR03CA0092.outlook.office365.com
 (2603:10b6:408:fd::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31 via Frontend
 Transport; Tue, 5 Apr 2022 03:26:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.234)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.234 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.234; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.234) by
 BN8NAM11FT064.mail.protection.outlook.com (10.13.176.160) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5123.19 via Frontend Transport; Tue, 5 Apr 2022 03:26:24 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by DRHQMAIL101.nvidia.com
 (10.27.9.10) with Microsoft SMTP Server (TLS) id 15.0.1497.32; Tue, 5 Apr
 2022 03:26:23 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Mon, 4 Apr 2022
 20:26:22 -0700
Received: from mkumard.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server id 15.2.986.22 via Frontend
 Transport; Mon, 4 Apr 2022 20:26:20 -0700
From:   Mohan Kumar <mkumard@nvidia.com>
To:     <tiwai@suse.com>, <perex@perex.cz>
CC:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <spujar@nvidia.com>, <alsa-devel@alsa-project.org>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Mohan Kumar <mkumard@nvidia.com>
Subject: [PATCH] ALSA: hda/tegra: Fix hda Jack detection
Date:   Tue, 5 Apr 2022 08:56:07 +0530
Message-ID: <20220405032607.8489-1-mkumard@nvidia.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2e898d14-5941-470c-f5c7-08da16b41024
X-MS-TrafficTypeDiagnostic: BL1PR12MB5096:EE_
X-Microsoft-Antispam-PRVS: <BL1PR12MB5096CFC70B546B4E325A1048C1E49@BL1PR12MB5096.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9Z+1McxsWpLxrI2Uy4pcDfR1eK2UEJ3Z2EzUwLSDoK4Ry4FWlm48Cn2e/asnwOZC39asSou1TRg+ymsmZzsxoPte2UvSbn4Z5SqcIrt3T3+vUogdWdU/kLFp8SekX8j6sKVE1/mPqfHf/SaCkxRQ4szV9meglelNWV3G22aXfHzqO2rcULQMW6f6Y+wb6QS267MP+KUlaTs5dpNfq84bTn9epojJTkOlfF6raKwDs29hFrzDdLToFoBnzXbDGKhtu3CwpX7KZ0m7tP6TMogDkfeWHFy/zhgjDT7CHbSyh8PXJ3nOO8vLzC8J8jSprB4MAb8ajD8XNkwFNjxhHa5SuO/x5chRqHdwjGP0PKXf5gwMQ5UhiSNtpse9ad4Mo0MRGc3v20XgmMXMs4nCiOVURlGCoi1f3hVNNwclnNzVJ72SP+Uyu9gt+wLNf7rXGP4gWs8rE54+nO0oYWExcDjRW3E0/7UPyf1dGIKvbNXLBwZiYx3sez8L+1/FDLQAWYtiJOwSn817ZIS/oGMhtUu2dXdc+1+5C1aVWoMxmJpF1w3uiXkC4DriEUrBh9cE/DtTKsfAb+Y72p+8GZqjmf1wUYUN+BH7Kvg7JOkT2sLRFUkLvBOozyBJLXss14aZEvlDtWGMMBhTkxZA6NMWFvcp6NPtzrz0rj3Vexek0kg0lx2VVG5fbKGpy9B0z1EPh7JjeVg8M1TqIQuxmSAlUlWVJA==
X-Forefront-Antispam-Report: CIP:12.22.5.234;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(508600001)(81166007)(6666004)(82310400005)(86362001)(36756003)(54906003)(107886003)(83380400001)(2616005)(7696005)(316002)(186003)(110136005)(26005)(356005)(1076003)(426003)(336012)(2906002)(40460700003)(8676002)(5660300002)(4326008)(8936002)(70586007)(47076005)(36860700001)(70206006)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Apr 2022 03:26:24.4941
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e898d14-5941-470c-f5c7-08da16b41024
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.234];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT064.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5096
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tegra HDA Jack detection logic doesn't work when the HDACODEC
in runtime suspended state as unsol event won't be triggered
during D3 state. As pulseaudio server in userspace rely on the
jack mixer control status to show the audio devices in gui and
any display sink device hotplug event during D3 state will never
updates the jack status which will result in no audio device option
available in userspace settings.

The possible option available to resolve this issue for multiple
tegra platforms is to use Jack polling method for every 5 seconds.
Also to make Jack detection work seamlessly the Jack worker thread
needs to run continuously after HDA sound card registered
irrespective of whether HDMI sink device connected or not, but the
Jack state update call happens only when Codec is not powered on.

Signed-off-by: Mohan Kumar <mkumard@nvidia.com>
---
 sound/pci/hda/hda_tegra.c | 43 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/sound/pci/hda/hda_tegra.c b/sound/pci/hda/hda_tegra.c
index 2347d0304f93..c92938a47b65 100644
--- a/sound/pci/hda/hda_tegra.c
+++ b/sound/pci/hda/hda_tegra.c
@@ -28,6 +28,7 @@
 
 #include <sound/hda_codec.h>
 #include "hda_controller.h"
+#include "hda_jack.h"
 
 /* Defines for Nvidia Tegra HDA support */
 #define HDA_BAR0           0x8000
@@ -67,6 +68,7 @@
  * is used to update the GCAP register to workaround the issue.
  */
 #define TEGRA194_NUM_SDO_LINES	  4
+#define JACKPOLL_INTERVAL	msecs_to_jiffies(5000)
 
 struct hda_tegra_soc {
 	bool has_hda2codec_2x_reset;
@@ -82,6 +84,7 @@ struct hda_tegra {
 	unsigned int nclocks;
 	void __iomem *regs;
 	struct work_struct probe_work;
+	struct delayed_work jack_work;
 	const struct hda_tegra_soc *soc;
 };
 
@@ -127,8 +130,11 @@ static void hda_tegra_init(struct hda_tegra *hda)
 static int __maybe_unused hda_tegra_suspend(struct device *dev)
 {
 	struct snd_card *card = dev_get_drvdata(dev);
+	struct azx *chip = card->private_data;
+	struct hda_tegra *hda = container_of(chip, struct hda_tegra, chip);
 	int rc;
 
+	cancel_delayed_work_sync(&hda->jack_work);
 	rc = pm_runtime_force_suspend(dev);
 	if (rc < 0)
 		return rc;
@@ -140,6 +146,8 @@ static int __maybe_unused hda_tegra_suspend(struct device *dev)
 static int __maybe_unused hda_tegra_resume(struct device *dev)
 {
 	struct snd_card *card = dev_get_drvdata(dev);
+	struct azx *chip = card->private_data;
+	struct hda_tegra *hda = container_of(chip, struct hda_tegra, chip);
 	int rc;
 
 	rc = pm_runtime_force_resume(dev);
@@ -147,6 +155,8 @@ static int __maybe_unused hda_tegra_resume(struct device *dev)
 		return rc;
 	snd_power_change_state(card, SNDRV_CTL_POWER_D0);
 
+	schedule_delayed_work(&hda->jack_work, JACKPOLL_INTERVAL);
+
 	return 0;
 }
 
@@ -209,6 +219,29 @@ static const struct dev_pm_ops hda_tegra_pm = {
 			   NULL)
 };
 
+static void  hda_tegra_jack_work(struct work_struct *work)
+{
+	struct hda_tegra *hda =
+			container_of(work, struct hda_tegra, jack_work.work);
+	struct azx *chip = &hda->chip;
+	struct hda_codec *codec;
+
+	if (!chip->running)
+		return;
+
+	list_for_each_codec(codec, &chip->bus) {
+		if (snd_hdac_is_power_on(&codec->core))
+			continue;
+
+		snd_hda_power_up_pm(codec);
+		snd_hda_jack_set_dirty_all(codec);
+		snd_hda_jack_poll_all(codec);
+		snd_hda_power_down_pm(codec);
+	}
+
+	schedule_delayed_work(&hda->jack_work, JACKPOLL_INTERVAL);
+}
+
 static int hda_tegra_dev_disconnect(struct snd_device *device)
 {
 	struct azx *chip = device->device_data;
@@ -226,6 +259,7 @@ static int hda_tegra_dev_free(struct snd_device *device)
 	struct hda_tegra *hda = container_of(chip, struct hda_tegra, chip);
 
 	cancel_work_sync(&hda->probe_work);
+	cancel_delayed_work_sync(&hda->jack_work);
 	if (azx_bus(chip)->chip_init) {
 		azx_stop_all_streams(chip);
 		azx_stop_chip(chip);
@@ -428,6 +462,7 @@ static int hda_tegra_create(struct snd_card *card,
 	chip->snoop = true;
 
 	INIT_WORK(&hda->probe_work, hda_tegra_probe_work);
+	INIT_DELAYED_WORK(&hda->jack_work, hda_tegra_jack_work);
 
 	err = azx_bus_init(chip, NULL);
 	if (err < 0)
@@ -574,13 +609,18 @@ static void hda_tegra_probe_work(struct work_struct *work)
 
  out_free:
 	pm_runtime_put(hda->dev);
+	schedule_delayed_work(&hda->jack_work, JACKPOLL_INTERVAL);
 	return; /* no error return from async probe */
 }
 
 static int hda_tegra_remove(struct platform_device *pdev)
 {
+	struct snd_card *card = dev_get_drvdata(&pdev->dev);
+	struct azx *chip = card->private_data;
+	struct hda_tegra *hda = container_of(chip, struct hda_tegra, chip);
 	int ret;
 
+	cancel_delayed_work_sync(&hda->jack_work);
 	ret = snd_card_free(dev_get_drvdata(&pdev->dev));
 	pm_runtime_disable(&pdev->dev);
 
@@ -591,10 +631,13 @@ static void hda_tegra_shutdown(struct platform_device *pdev)
 {
 	struct snd_card *card = dev_get_drvdata(&pdev->dev);
 	struct azx *chip;
+	struct hda_tegra *hda;
 
 	if (!card)
 		return;
 	chip = card->private_data;
+	hda = container_of(chip, struct hda_tegra, chip);
+	cancel_delayed_work_sync(&hda->jack_work);
 	if (chip && chip->running)
 		azx_stop_chip(chip);
 }
-- 
2.17.1

