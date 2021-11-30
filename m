Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6893E46355A
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 14:24:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240162AbhK3N1R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 08:27:17 -0500
Received: from mail-dm6nam11on2080.outbound.protection.outlook.com ([40.107.223.80]:29761
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S239822AbhK3N1P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 08:27:15 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Dkos9g/bxzBwFoBZuZ5Lva4oZRS8qvc4NGSO9fL3VNjyQf8QPzMiasuSEl98Om9AA5JNwt5m9u+ei0eGbYAGdUAbzHwFxFcCZCOX6t2ct2ZuuJnriIFE4WUU3uoNbmYBDYyMU8Yw8V23jgZN3mS6q4vw2m2q2e6v1m3p7NzHcC3w5FOXaJel6NqUmbYQqvP405FEN1jCcxW/K9GqOFCjCcHKLNbjcqW0W09xWWd4VdxWpK8yKSkyhYsaI3FsUs9UxjPCMT0H2dpeAOs5A5jPgo5GlsA/eGWguyXzzVkVoYpjRLgRWJNk513oD5Kwea04y5/zuiHjUVhRkbw0trsU6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3A3J/kGpdFYtwODkZ5cIeaynZWfni2c8cyLBVJsR9Tw=;
 b=aX2wUmRJWfowsYH+fbG+TJBypeqvtovUbuzn49HqCrbDgGkYYYQqKL7cBb6YKtwrqPNzoQrY5qmqbobKlY1QEMeFDyOGkqVGN3mZSaLe3kuGNwHg7EjgDQTj5Jc9kJXF2U1Rwf4Yj1i0Ka8jEgz2O19yxt+NhodCle1PjRU9CXGWTkJvTmD2Uwql6U3cWn/Qb3e5UylctJN9WgT59l4NnTWZHRGpevRXLFOmM9/pI8a+oqwM2q7kGw88ta2ubK3xKc03Qh0NEgIJHOmRu37tzkKcX2IOaiMGGLS+VYhgke4R890twpjwRQ23hJma7Qhg5E/cc4Ylp3EuBC9n3MGvUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=alsa-project.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3A3J/kGpdFYtwODkZ5cIeaynZWfni2c8cyLBVJsR9Tw=;
 b=HBaV3El9jkk7lG7lA4+9qwPBZtE5VPjbWGXwNSPHj1iQTEwNhQoevkOaa9emM4w0pBCtwnhmH8jEAI5BtpnJKxMAB5siQ9o0mj8RMAem19MQRTiKHGcmaPGasnNeBWnSYr+aYSNHp+xiK3QY2adzJRp7W+MRrQlcYmuYfQRx3WiHrZuSzPdOSZlkU1yLJr8BBPk5YG2+2wQxV+u+gA9rSAur+Az95seI0xZX214QDCbPUbAA1lGWu1b3prE897+ixh8XGWK7hC44ngBD99jVQDQVHmXXCmHx60KYXEXhBWXvxn+oCNR/VhEgaVrVLgZryFBYhdQpxyn2GkFrooax+Q==
Received: from MWHPR08CA0038.namprd08.prod.outlook.com (2603:10b6:300:c0::12)
 by DM5PR12MB1306.namprd12.prod.outlook.com (2603:10b6:3:6c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.23; Tue, 30 Nov
 2021 13:23:54 +0000
Received: from CO1NAM11FT050.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:c0:cafe::51) by MWHPR08CA0038.outlook.office365.com
 (2603:10b6:300:c0::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.23 via Frontend
 Transport; Tue, 30 Nov 2021 13:23:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 CO1NAM11FT050.mail.protection.outlook.com (10.13.174.79) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4734.22 via Frontend Transport; Tue, 30 Nov 2021 13:23:53 +0000
Received: from HQMAIL105.nvidia.com (172.20.187.12) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Tue, 30 Nov
 2021 13:23:53 +0000
Received: from audio.nvidia.com (172.20.187.5) by mail.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server id 15.0.1497.18 via Frontend
 Transport; Tue, 30 Nov 2021 13:23:50 +0000
From:   Sameer Pujar <spujar@nvidia.com>
To:     <broonie@kernel.org>, <lgirdwood@gmail.com>, <perex@perex.cz>,
        <tiwai@suse.com>
CC:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <alsa-devel@alsa-project.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Sameer Pujar <spujar@nvidia.com>
Subject: [PATCH v2] ASoC: tegra: Add master volume/mute control support
Date:   Tue, 30 Nov 2021 18:53:25 +0530
Message-ID: <1638278605-28225-1-git-send-email-spujar@nvidia.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2d8cde61-6487-4377-9d1b-08d9b404a7e0
X-MS-TrafficTypeDiagnostic: DM5PR12MB1306:
X-Microsoft-Antispam-PRVS: <DM5PR12MB1306B30FB55D50D5EE24C895A7679@DM5PR12MB1306.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7hznnfY/l8Bp6OfXP/6wrJcvQbMpqOVG1AR1/0cxY9WGOAroQ0u9WBdw1tgSVcBYh43qfNxx4IEoJoJZvwPUrEVFTr5FmImWGdRpC07/t1bcw+dd/6aIiERMYNYA7ln66G4Q2Omeo//Vy5F0lNWJfoczFUFYArxODC2QStB2ZIMn+wkMBpJeBy1t0jKft3LSqGRP9Pp1hJ//VXmw2mktd2LkrH80Bsmw62rBVJmZZFgG8WtWqiQrCzV8N9av18BFODe8UNeQ5zkAGfxPq7kLNVOMqtIOVLe7i4zPNkHwsp3PX3VPGJJYAx6Xd92oADe+00v6HkN3p1gMDBoIz/pCGHtamwogfXDT9Hvrb6b/YNjbegjDcFGhh3+SrLYGYuixGJ29GbdfNxWbg476GA12N0k1HejsDn4IH9VeaePkuCG7mMwN4OVJDivQytQ38s8RKVuvAkJ9NHtxlhI7Jvg0QOybZQAzNBT4j/z1nCF/0Sxi9vxb1W7DFQyoKn8DuzRPjZOqVlPSWTBQKLAXpgN24CTtbk6kpfLzqx0rWuKYbIdg5bBsGN+8kEGShizgMEWCw6xGo2akTuilXq37kjnQ8c/UR0hTlH0pRep6gA6cXIlHFZAnf2e5PqdHjFMK7oaTIRCqtfMdBr1S9VIZ3FUPv+ri7OLKvp6XbOQVc01DC5X+xMq2eByLXobNXEBsLTFpfgN8tJnFnqo1erIMeoKiBL2b2HMXkNInFK363QWD41dJeWFA1HnDlxuUAF8EwYBaE7hwsmqIWQFR3hMUn8ifMYpPusSg0gamUQOto6jG0P4XgJbvltflEc0cIXkEn+G2BhhtJY28t5RCddiASRwa3cEA3SRMZjKE9GvqNUzq2W0=
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(40470700001)(4326008)(5660300002)(7636003)(110136005)(2616005)(426003)(40460700001)(30864003)(316002)(107886003)(82310400004)(8936002)(54906003)(86362001)(70206006)(70586007)(336012)(83380400001)(6666004)(7696005)(186003)(8676002)(966005)(2906002)(36860700001)(508600001)(47076005)(26005)(36756003)(356005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2021 13:23:53.7612
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d8cde61-6487-4377-9d1b-08d9b404a7e0
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT050.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1306
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The MVC module has a per channel control bit, based on which it decides
to apply channel specific volume/mute settings. When per channel control
bit is enabled (which is the default HW configuration), all MVC channel
volume/mute can be independently controlled. If the control is disabled,
channel-0 volume/mute setting is applied by HW to all remaining channels.
Thus add support to leverage this HW feature by exposing master controls
for volume/mute.

With this, now there are per channel and master volume/mute controls.
Users need to just use controls which are suitable for their applications.
The per channel control enable/disable is mananged in driver and hidden
from users, so that they need to just worry about respective volume/mute
controls.

Signed-off-by: Sameer Pujar <spujar@nvidia.com>
---
 changes in v2:
   * Kcontrol put() related comments, received during v1, are addressed
     in another series [0].
   * Thus v2 is rebased on top of recent changes.
   * In doing so, this patch also addresses optimization comment received
     on [0] which suggested usage of regmap_update_bits_check() in the MVC
     driver.

   [0] https://lkml.org/lkml/2021/11/18/930

 sound/soc/tegra/tegra210_mvc.c | 209 ++++++++++++++++++++++++++++++++---------
 sound/soc/tegra/tegra210_mvc.h |   5 +
 2 files changed, 169 insertions(+), 45 deletions(-)

diff --git a/sound/soc/tegra/tegra210_mvc.c b/sound/soc/tegra/tegra210_mvc.c
index 93cbeb6..2d79138 100644
--- a/sound/soc/tegra/tegra210_mvc.c
+++ b/sound/soc/tegra/tegra210_mvc.c
@@ -108,67 +108,152 @@ static void tegra210_mvc_conv_vol(struct tegra210_mvc *mvc, u8 chan, s32 val)
 	}
 }
 
-static int tegra210_mvc_get_mute(struct snd_kcontrol *kcontrol,
-				 struct snd_ctl_elem_value *ucontrol)
+static u32 tegra210_mvc_get_ctrl_reg(struct snd_kcontrol *kcontrol)
 {
 	struct snd_soc_component *cmpnt = snd_soc_kcontrol_component(kcontrol);
 	struct tegra210_mvc *mvc = snd_soc_component_get_drvdata(cmpnt);
-	u8 mute_mask;
 	u32 val;
 
 	pm_runtime_get_sync(cmpnt->dev);
 	regmap_read(mvc->regmap, TEGRA210_MVC_CTRL, &val);
 	pm_runtime_put(cmpnt->dev);
 
-	mute_mask = (val >>  TEGRA210_MVC_MUTE_SHIFT) &
-		TEGRA210_MUTE_MASK_EN;
+	return val;
+}
+
+static int tegra210_mvc_get_mute(struct snd_kcontrol *kcontrol,
+				 struct snd_ctl_elem_value *ucontrol)
+{
+	u32 val = tegra210_mvc_get_ctrl_reg(kcontrol);
+	u8 mute_mask = TEGRA210_GET_MUTE_VAL(val);
 
-	ucontrol->value.integer.value[0] = mute_mask;
+	/*
+	 * If per channel control is enabled, then return
+	 * exact mute/unmute setting of all channels.
+	 *
+	 * Else report setting based on CH0 bit to reflect
+	 * the correct HW state.
+	 */
+	if (val & TEGRA210_MVC_PER_CHAN_CTRL_EN) {
+		ucontrol->value.integer.value[0] = mute_mask;
+	} else {
+		if (mute_mask & TEGRA210_MVC_CH0_MUTE_EN)
+			ucontrol->value.integer.value[0] =
+				TEGRA210_MUTE_MASK_EN;
+		else
+			ucontrol->value.integer.value[0] = 0;
+	}
 
 	return 0;
 }
 
-static int tegra210_mvc_put_mute(struct snd_kcontrol *kcontrol,
-				 struct snd_ctl_elem_value *ucontrol)
+static int tegra210_mvc_get_master_mute(struct snd_kcontrol *kcontrol,
+					struct snd_ctl_elem_value *ucontrol)
+{
+	u32 val = tegra210_mvc_get_ctrl_reg(kcontrol);
+	u8 mute_mask = TEGRA210_GET_MUTE_VAL(val);
+
+	/*
+	 * If per channel control is disabled, then return
+	 * master mute/unmute setting based on CH0 bit.
+	 *
+	 * Else report settings based on state of all
+	 * channels.
+	 */
+	if (!(val & TEGRA210_MVC_PER_CHAN_CTRL_EN)) {
+		ucontrol->value.integer.value[0] =
+			mute_mask & TEGRA210_MVC_CH0_MUTE_EN;
+	} else {
+		if (mute_mask == TEGRA210_MUTE_MASK_EN)
+			ucontrol->value.integer.value[0] =
+				TEGRA210_MVC_CH0_MUTE_EN;
+		else
+			ucontrol->value.integer.value[0] = 0;
+	}
+
+	return 0;
+}
+
+static int tegra210_mvc_volume_switch_timeout(struct snd_soc_component *cmpnt)
 {
-	struct soc_mixer_control *mc =
-		(struct soc_mixer_control *)kcontrol->private_value;
-	struct snd_soc_component *cmpnt = snd_soc_kcontrol_component(kcontrol);
 	struct tegra210_mvc *mvc = snd_soc_component_get_drvdata(cmpnt);
-	unsigned int value;
-	u8 new_mask, old_mask;
+	u32 value;
 	int err;
 
-	pm_runtime_get_sync(cmpnt->dev);
-
-	/* Check if VOLUME_SWITCH is triggered */
 	err = regmap_read_poll_timeout(mvc->regmap, TEGRA210_MVC_SWITCH,
 			value, !(value & TEGRA210_MVC_VOLUME_SWITCH_MASK),
 			10, 10000);
 	if (err < 0)
-		goto end;
+		dev_err(cmpnt->dev,
+			"Volume switch trigger is still active, err = %d\n",
+			err);
 
-	regmap_read(mvc->regmap, TEGRA210_MVC_CTRL, &value);
+	return err;
+}
 
-	old_mask = (value >> TEGRA210_MVC_MUTE_SHIFT) & TEGRA210_MUTE_MASK_EN;
-	new_mask = ucontrol->value.integer.value[0];
+static int tegra210_mvc_update_mute(struct snd_kcontrol *kcontrol,
+				    struct snd_ctl_elem_value *ucontrol,
+				    bool per_chan_ctrl)
+{
+	struct snd_soc_component *cmpnt = snd_soc_kcontrol_component(kcontrol);
+	struct tegra210_mvc *mvc = snd_soc_component_get_drvdata(cmpnt);
+	u32 mute_val = ucontrol->value.integer.value[0];
+	u32 per_ch_ctrl_val;
+	bool change = false;
+	int err;
 
-	if (new_mask == old_mask) {
-		err = 0;
+	pm_runtime_get_sync(cmpnt->dev);
+
+	err = tegra210_mvc_volume_switch_timeout(cmpnt);
+	if (err < 0)
 		goto end;
+
+	if (per_chan_ctrl) {
+		per_ch_ctrl_val = TEGRA210_MVC_PER_CHAN_CTRL_EN;
+	} else {
+		per_ch_ctrl_val = 0;
+
+		if (mute_val)
+			mute_val = TEGRA210_MUTE_MASK_EN;
 	}
 
-	err = regmap_update_bits(mvc->regmap, mc->reg,
+	regmap_update_bits_check(mvc->regmap, TEGRA210_MVC_CTRL,
 				 TEGRA210_MVC_MUTE_MASK,
-				 new_mask << TEGRA210_MVC_MUTE_SHIFT);
-	if (err < 0)
-		goto end;
+				 mute_val << TEGRA210_MVC_MUTE_SHIFT,
+				 &change);
 
-	err = 1;
+	if (change) {
+		regmap_update_bits(mvc->regmap, TEGRA210_MVC_CTRL,
+				   TEGRA210_MVC_PER_CHAN_CTRL_EN_MASK,
+				   per_ch_ctrl_val);
+
+		regmap_update_bits(mvc->regmap, TEGRA210_MVC_SWITCH,
+				   TEGRA210_MVC_VOLUME_SWITCH_MASK,
+				   TEGRA210_MVC_VOLUME_SWITCH_TRIGGER);
+	}
 
 end:
 	pm_runtime_put(cmpnt->dev);
-	return err;
+
+	if (err < 0)
+		return err;
+
+	if (change)
+		return 1;
+
+	return 0;
+}
+
+static int tegra210_mvc_put_mute(struct snd_kcontrol *kcontrol,
+				 struct snd_ctl_elem_value *ucontrol)
+{
+	return tegra210_mvc_update_mute(kcontrol, ucontrol, true);
+}
+
+static int tegra210_mvc_put_master_mute(struct snd_kcontrol *kcontrol,
+					struct snd_ctl_elem_value *ucontrol)
+{
+	return tegra210_mvc_update_mute(kcontrol, ucontrol, false);
 }
 
 static int tegra210_mvc_get_vol(struct snd_kcontrol *kcontrol,
@@ -178,7 +263,7 @@ static int tegra210_mvc_get_vol(struct snd_kcontrol *kcontrol,
 		(struct soc_mixer_control *)kcontrol->private_value;
 	struct snd_soc_component *cmpnt = snd_soc_kcontrol_component(kcontrol);
 	struct tegra210_mvc *mvc = snd_soc_component_get_drvdata(cmpnt);
-	u8 chan = (mc->reg - TEGRA210_MVC_TARGET_VOL) / REG_SIZE;
+	u8 chan = TEGRA210_MVC_GET_CHAN(mc->reg, TEGRA210_MVC_TARGET_VOL);
 	s32 val = mvc->volume[chan];
 
 	if (mvc->curve_type == CURVE_POLY) {
@@ -193,44 +278,55 @@ static int tegra210_mvc_get_vol(struct snd_kcontrol *kcontrol,
 	return 0;
 }
 
-static int tegra210_mvc_put_vol(struct snd_kcontrol *kcontrol,
-				struct snd_ctl_elem_value *ucontrol)
+static int tegra210_mvc_get_master_vol(struct snd_kcontrol *kcontrol,
+				       struct snd_ctl_elem_value *ucontrol)
+{
+	return tegra210_mvc_get_vol(kcontrol, ucontrol);
+}
+
+static int tegra210_mvc_update_vol(struct snd_kcontrol *kcontrol,
+				   struct snd_ctl_elem_value *ucontrol,
+				   bool per_ch_enable)
 {
 	struct soc_mixer_control *mc =
 		(struct soc_mixer_control *)kcontrol->private_value;
 	struct snd_soc_component *cmpnt = snd_soc_kcontrol_component(kcontrol);
 	struct tegra210_mvc *mvc = snd_soc_component_get_drvdata(cmpnt);
-	unsigned int reg = mc->reg;
-	unsigned int value;
-	u8 chan;
-	int err, old_volume;
+	u8 chan = TEGRA210_MVC_GET_CHAN(mc->reg, TEGRA210_MVC_TARGET_VOL);
+	int old_volume = mvc->volume[chan];
+	int err, i;
 
 	pm_runtime_get_sync(cmpnt->dev);
 
-	/* Check if VOLUME_SWITCH is triggered */
-	err = regmap_read_poll_timeout(mvc->regmap, TEGRA210_MVC_SWITCH,
-			value, !(value & TEGRA210_MVC_VOLUME_SWITCH_MASK),
-			10, 10000);
+	err = tegra210_mvc_volume_switch_timeout(cmpnt);
 	if (err < 0)
 		goto end;
 
-	chan = (reg - TEGRA210_MVC_TARGET_VOL) / REG_SIZE;
-	old_volume = mvc->volume[chan];
-
-	tegra210_mvc_conv_vol(mvc, chan,
-			      ucontrol->value.integer.value[0]);
+	tegra210_mvc_conv_vol(mvc, chan, ucontrol->value.integer.value[0]);
 
 	if (mvc->volume[chan] == old_volume) {
 		err = 0;
 		goto end;
 	}
 
+	if (per_ch_enable) {
+		regmap_update_bits(mvc->regmap, TEGRA210_MVC_CTRL,
+				   TEGRA210_MVC_PER_CHAN_CTRL_EN_MASK,
+				   TEGRA210_MVC_PER_CHAN_CTRL_EN);
+	} else {
+		regmap_update_bits(mvc->regmap, TEGRA210_MVC_CTRL,
+				   TEGRA210_MVC_PER_CHAN_CTRL_EN_MASK, 0);
+
+		for (i = 1; i < TEGRA210_MVC_MAX_CHAN_COUNT; i++)
+			mvc->volume[i] = mvc->volume[chan];
+	}
+
 	/* Configure init volume same as target volume */
 	regmap_write(mvc->regmap,
 		TEGRA210_MVC_REG_OFFSET(TEGRA210_MVC_INIT_VOL, chan),
 		mvc->volume[chan]);
 
-	regmap_write(mvc->regmap, reg, mvc->volume[chan]);
+	regmap_write(mvc->regmap, mc->reg, mvc->volume[chan]);
 
 	regmap_update_bits(mvc->regmap, TEGRA210_MVC_SWITCH,
 			   TEGRA210_MVC_VOLUME_SWITCH_MASK,
@@ -240,9 +336,22 @@ static int tegra210_mvc_put_vol(struct snd_kcontrol *kcontrol,
 
 end:
 	pm_runtime_put(cmpnt->dev);
+
 	return err;
 }
 
+static int tegra210_mvc_put_vol(struct snd_kcontrol *kcontrol,
+				struct snd_ctl_elem_value *ucontrol)
+{
+	return tegra210_mvc_update_vol(kcontrol, ucontrol, true);
+}
+
+static int tegra210_mvc_put_master_vol(struct snd_kcontrol *kcontrol,
+				       struct snd_ctl_elem_value *ucontrol)
+{
+	return tegra210_mvc_update_vol(kcontrol, ucontrol, false);
+}
+
 static void tegra210_mvc_reset_vol_settings(struct tegra210_mvc *mvc,
 					    struct device *dev)
 {
@@ -438,6 +547,16 @@ static const struct snd_kcontrol_new tegra210_mvc_vol_ctrl[] = {
 		       TEGRA210_MVC_CTRL, 0, TEGRA210_MUTE_MASK_EN, 0,
 		       tegra210_mvc_get_mute, tegra210_mvc_put_mute),
 
+	/* Master volume */
+	SOC_SINGLE_EXT("Volume", TEGRA210_MVC_TARGET_VOL, 0, 16000, 0,
+		       tegra210_mvc_get_master_vol,
+		       tegra210_mvc_put_master_vol),
+
+	/* Master mute */
+	SOC_SINGLE_EXT("Mute", TEGRA210_MVC_CTRL, 0, 1, 0,
+		       tegra210_mvc_get_master_mute,
+		       tegra210_mvc_put_master_mute),
+
 	SOC_ENUM_EXT("Curve Type", tegra210_mvc_curve_type_ctrl,
 		     tegra210_mvc_get_curve_type, tegra210_mvc_put_curve_type),
 };
diff --git a/sound/soc/tegra/tegra210_mvc.h b/sound/soc/tegra/tegra210_mvc.h
index def29c4..d775335 100644
--- a/sound/soc/tegra/tegra210_mvc.h
+++ b/sound/soc/tegra/tegra210_mvc.h
@@ -59,6 +59,7 @@
 #define TEGRA210_MUTE_MASK_EN			0xff
 #define TEGRA210_MVC_MUTE_MASK			(TEGRA210_MUTE_MASK_EN << TEGRA210_MVC_MUTE_SHIFT)
 #define TEGRA210_MVC_MUTE_EN			(TEGRA210_MUTE_MASK_EN << TEGRA210_MVC_MUTE_SHIFT)
+#define TEGRA210_MVC_CH0_MUTE_EN		1
 
 #define TEGRA210_MVC_PER_CHAN_CTRL_EN_SHIFT	30
 #define TEGRA210_MVC_PER_CHAN_CTRL_EN_MASK	(1 << TEGRA210_MVC_PER_CHAN_CTRL_EN_SHIFT)
@@ -92,6 +93,10 @@
 #define TEGRA210_MVC_MAX_CHAN_COUNT 8
 #define TEGRA210_MVC_REG_OFFSET(reg, i) (reg + (REG_SIZE * i))
 
+#define TEGRA210_MVC_GET_CHAN(reg, base) (((reg) - (base)) / REG_SIZE)
+
+#define TEGRA210_GET_MUTE_VAL(val) (((val) >> TEGRA210_MVC_MUTE_SHIFT) & TEGRA210_MUTE_MASK_EN)
+
 #define NUM_GAIN_POLY_COEFFS 9
 
 enum {
-- 
2.7.4

