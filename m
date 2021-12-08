Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A75746DBB6
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 20:00:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239499AbhLHTDb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 14:03:31 -0500
Received: from mail-sn1anam02on2042.outbound.protection.outlook.com ([40.107.96.42]:22151
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230039AbhLHTDa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 14:03:30 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KCmZ9SSNQJm9TcvFQUeDJI+djHuWC9nSmtQcahwcnYJYFHY4a2WCq/3T30C5HVb54Jfd64wBkN+U17w9Yl1Qz4eCXDP8CVzpe1n7tJpuEPdiu4oSRtvH+BONWA+s+j9es6UbtUqw86X5uwj5ydvaE5iZyxiGjHqqP8QYM6pIl3jGYOOV4XM6h6N2cZUZA6w3lLp0lKuoV/PNmv+YIHPCFGw/1G0km5G3YhYBAlrW5IEPn4MXrCUe5ityeubSswYQPcbQpADNlLVe5H17AAY9GqbHxZUPUA4zyuNyDD8CWixSbKhyHBjrCjPrjawaUKv4/JoTLTDzgBVdtTHDOpPoIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XRHG5tIpHuwX7Xn6aQ//wk4HmVPUhWGTl+eY2XhJDpg=;
 b=BsT77dSqkZsonVV6LLx1ex1PQ3eYsiHBKKyvb4jgnUaW9W/RwtKsb4+oQtU6Fh+2z1VDRnKcRmoxuDbIaiC/TX0fg7Az8lgm3k8YdJbkrr0X94fonzG7LVwCTHj1JwkpNl5MfctD3tKnPGsvnZpdHb63NxR9+yz5K7DMXwFqxBHzLcINuKDcrcXNl4fvlpDl3bqimbP49jXfcGOdagREsB0zrk/RAy7lFmebq4b4V9Th4ZEsOL4tLdnnPFOtaD9da9FaOJGBh3ZclDj+W0C1J46ACaY8IuBvLgWuhEYi+SiDXz8hc5PP9hZMz15rGkEccVLKaLha8jSuDtgIiqdKWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XRHG5tIpHuwX7Xn6aQ//wk4HmVPUhWGTl+eY2XhJDpg=;
 b=gaZ3JEklFCQOTPLuo/oXlZnJl275opJzAfbkpfCtZRY6U4g2PK996Z8HNfyapWv0Tb9+WMXwAJVmY81SeYgOz9H0nbxpDdM+cERJKht0a6a9IQfo+788K5D+ST4n67Zr3V2lglPW56FJ16HLwe4FtUktJTKefwe0EVpVRZP3vnk=
Received: from BN0PR03CA0023.namprd03.prod.outlook.com (2603:10b6:408:e6::28)
 by BYAPR12MB3463.namprd12.prod.outlook.com (2603:10b6:a03:ac::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.20; Wed, 8 Dec
 2021 18:59:55 +0000
Received: from BN8NAM11FT040.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e6:cafe::bd) by BN0PR03CA0023.outlook.office365.com
 (2603:10b6:408:e6::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.12 via Frontend
 Transport; Wed, 8 Dec 2021 18:59:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT040.mail.protection.outlook.com (10.13.177.166) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4755.13 via Frontend Transport; Wed, 8 Dec 2021 18:59:55 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Wed, 8 Dec
 2021 12:59:54 -0600
Received: from chrome.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.17 via Frontend
 Transport; Wed, 8 Dec 2021 12:59:51 -0600
From:   Ajit Kumar Pandey <AjitKumar.Pandey@amd.com>
To:     <broonie@kernel.org>, <alsa-devel@alsa-project.org>
CC:     <Vijendar.Mukunda@amd.com>, <Alexander.Deucher@amd.com>,
        <Basavaraj.Hiregoudar@amd.com>, <Sunil-kumar.Dommati@amd.com>,
        "Ajit Kumar Pandey" <AjitKumar.Pandey@amd.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: [PATCH] ASoC: max98357a: Add mixer control to mute/unmute speaker
Date:   Thu, 9 Dec 2021 00:28:49 +0530
Message-ID: <20211208185850.1555996-1-AjitKumar.Pandey@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 59a2f7b1-bdd1-4194-5da2-08d9ba7cec3b
X-MS-TrafficTypeDiagnostic: BYAPR12MB3463:EE_
X-Microsoft-Antispam-PRVS: <BYAPR12MB3463DAC7735DDC472D83B7F4826F9@BYAPR12MB3463.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:551;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kKtGlwd0paRGKuDiucAitHZ7yKLJgN4SMrgJwEUSn+7O29kxGNbgkNp9a/rVxBbkpNaVrCMML7xj9aY2gPTEBkM/eSqL8v5BGqkeG7R/HTccEdCEj2EeDeyIeI79YrdpRAUIYK99EtHKOUFR6hUc8VNBtNh9Z4ceusGS8FrcbKdi5h+qlxeicFOEQymn2eHhOo1wd2BjSFmAbfH9xeriPA5VTfyU3h0eZUJkqVxYP0zpyh6Iy7b+FUFp0ZPky/Wv6EmJN1CMAYSeA65iw9obuQipo5eAhE4YUHfmjxrP6csL+jJSJLXIOl8EtoZPW5p01V6CGLLpl0W+F96HLoniXbHpcwvCbtNTCM2ZwDC6AZLw/3B2pMme6W4Jwut+5cOaZAv1f+exhExZf9idZuz36f9MSo3Sd/s75vnP+wpvD2IneS8ZWjRqhVN9Fk3vSN10BECbiGsDHRTcFrKD6kWhBA+o8VwT+8STRJb+J/puV9mVOMarG0OZyOYcpN2EyaPdnBFDj621L03fkUeZuDJqDJRX+f8719ah3d6iaCcj3VHy32nv+t17TidhNPHk6rVBLjTZpJBcDEYXq8deYqaz9f6JyoO0VQy47YhyE+yVXzYMjh6kfNIg2pmXnLOLZ65NbVea5INl8SiRL1gY6EZVDofWXZJaF0FNFjSZlpjvNYEJ9/WxIWmV2kGtUfhqF2OsmAWkqwiIc8HN50GJohd+e56oGa7TfEM8/niRG+3Mmr6FYQ3XEVfbs9M3xM/tRwrjCYiHEC+du5b840uhlzfPvy1vbnzLLawNLgvUJQq19C0=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(40470700001)(8936002)(8676002)(70586007)(86362001)(4326008)(2616005)(82310400004)(7696005)(54906003)(1076003)(336012)(186003)(47076005)(2906002)(110136005)(70206006)(40460700001)(356005)(426003)(316002)(36860700001)(81166007)(36756003)(26005)(5660300002)(508600001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2021 18:59:55.1191
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 59a2f7b1-bdd1-4194-5da2-08d9ba7cec3b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT040.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3463
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add "Playback Switch" mixer control to mute or unmute speaker
playback from ucm conf depend on use cases.

Signed-off-by: Ajit Kumar Pandey <AjitKumar.Pandey@amd.com>
---
 sound/soc/codecs/max98357a.c | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/sound/soc/codecs/max98357a.c b/sound/soc/codecs/max98357a.c
index 918812763884..9b2f16ab4498 100644
--- a/sound/soc/codecs/max98357a.c
+++ b/sound/soc/codecs/max98357a.c
@@ -73,6 +73,36 @@ static int max98357a_sdmode_event(struct snd_soc_dapm_widget *w,
 	return 0;
 }
 
+static int speaker_mute_get(struct snd_kcontrol *kcontrol,
+			    struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_component *component = snd_soc_kcontrol_component(kcontrol);
+	struct max98357a_priv *max98357a = snd_soc_component_get_drvdata(component);
+
+	ucontrol->value.enumerated.item[0] = max98357a->sdmode_switch;
+
+	return 0;
+}
+
+static int speaker_mute_put(struct snd_kcontrol *kcontrol,
+			    struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_component *component = snd_soc_kcontrol_component(kcontrol);
+	struct max98357a_priv *max98357a = snd_soc_component_get_drvdata(component);
+	int mode = ucontrol->value.enumerated.item[0];
+
+	max98357a->sdmode_switch = mode;
+	gpiod_set_value_cansleep(max98357a->sdmode, mode);
+	dev_dbg(component->dev, "set sdmode to %d", mode);
+
+	return 0;
+}
+
+static const struct snd_kcontrol_new max98357a_snd_controls[] = {
+	SOC_SINGLE_BOOL_EXT("Playback Switch", 0,
+			    speaker_mute_get, speaker_mute_put),
+};
+
 static const struct snd_soc_dapm_widget max98357a_dapm_widgets[] = {
 	SND_SOC_DAPM_OUTPUT("Speaker"),
 	SND_SOC_DAPM_OUT_DRV_E("SD_MODE", SND_SOC_NOPM, 0, 0, NULL, 0,
@@ -86,6 +116,8 @@ static const struct snd_soc_dapm_route max98357a_dapm_routes[] = {
 };
 
 static const struct snd_soc_component_driver max98357a_component_driver = {
+	.controls		= max98357a_snd_controls,
+	.num_controls		= ARRAY_SIZE(max98357a_snd_controls),
 	.dapm_widgets		= max98357a_dapm_widgets,
 	.num_dapm_widgets	= ARRAY_SIZE(max98357a_dapm_widgets),
 	.dapm_routes		= max98357a_dapm_routes,
-- 
2.25.1

