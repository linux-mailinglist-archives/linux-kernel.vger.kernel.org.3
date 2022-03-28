Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 442214E90E5
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 11:15:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239720AbiC1JQW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 05:16:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239727AbiC1JQT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 05:16:19 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2046.outbound.protection.outlook.com [40.107.244.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 076EF53E20
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 02:14:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RQgxzWINDnxWlmU4qIdKkX57K3HDl/WTdX17ez8eI/VnvAczcl9C6S2+VM8Fe5T4N5TITdU4WPy452/Hf5wqMhb/TDTXco/EwmZKyTa+sR2pN3vHZ3D09RBHK43gU4HPul6DkqbqIMCkyW2gtHgj0NwqAZPCa9jE71vLztXjwtClYV5eUGUKg3862VzC5nT4he9ir7mtck3oUYTkCPs3YbWRmgIjToN4nPqkHY5rowO5jlsVisjCa1EPOI0fZar9Vb2vo7afVPN6SZLjfbuzTZYFcnj87x6F2fwefn5uVcD4Q9usZgpvo503s17nIfBEFpNwolL/pztEXltXFoz10g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gqyVFeBryygau27deLyH09wMMk7DpEUcHSU6swfAt14=;
 b=MOTff++MwzKSd8QU190nl7vlwBG+MHg3nTz00aU8s9vYY/NAXVpEtufvLzFmm6kPSQjpfJqX0XX+kYH8uVxMHZ9cErSFmWlPptD3Bai9NFcIpCkGSDt+Fo0+z1Fddw66wbrC1FEWPP4oASCLaoxddX505OsiA3CdH94+O4C9O+FYSoCELJ8Gr/Goozw4UcNeGyzmx2L7oUGdx/0yUKllRIAjl+dNvb0rfpSQySYe9xy2g2eCQvWGt7e2AI9g8HLtOCvjHKUVcXXWIyTA2ejbdOy+TI/Tf3rs6BImd8E7X5zo+UdroBGlIHJZBOIghdudrrZ/V6GHTbXAGdMVBrU3+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.238) smtp.rcpttodomain=alsa-project.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gqyVFeBryygau27deLyH09wMMk7DpEUcHSU6swfAt14=;
 b=VErSVmIZuz5wFRxp6GDZ1UcQhLftrJr3C7GqSBWVW0nwg7qvxGT8CqZguoH1mHpHVUJuOma2WWZZj4MyMelAybEwq2CzZAS9TIvAXhppVj43+2YWNsaE4ZE8iApmBW/oriQoFj6ZiejKYDLUHOnVZQIlrjUvJrnSf3JixO+BfG1DDTcD+057ERQiAVBEvk0ALc3DdDRvdZOofEZPuJo3D0ar84MoVgH/v093RPHX+XNi4HEogDYfSs6fdVAYQyyqpVvNZmNwXw0Z/0wcXx+WZ+hMiTdL3xJPr8Yc3Gb6xUS8LfVQx21dtEQf1uO7tMV2NRJpK4OBaMlxYptgWOx5Dw==
Received: from BN6PR17CA0056.namprd17.prod.outlook.com (2603:10b6:405:75::45)
 by BL1PR12MB5349.namprd12.prod.outlook.com (2603:10b6:208:31f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.17; Mon, 28 Mar
 2022 09:14:37 +0000
Received: from BN8NAM11FT006.eop-nam11.prod.protection.outlook.com
 (2603:10b6:405:75:cafe::d0) by BN6PR17CA0056.outlook.office365.com
 (2603:10b6:405:75::45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.18 via Frontend
 Transport; Mon, 28 Mar 2022 09:14:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.238)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.238 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.238; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.238) by
 BN8NAM11FT006.mail.protection.outlook.com (10.13.177.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5102.17 via Frontend Transport; Mon, 28 Mar 2022 09:14:36 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by DRHQMAIL105.nvidia.com
 (10.27.9.14) with Microsoft SMTP Server (TLS) id 15.0.1497.32; Mon, 28 Mar
 2022 09:14:35 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Mon, 28 Mar
 2022 02:14:34 -0700
Received: from mkumard.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server id 15.2.986.22 via Frontend
 Transport; Mon, 28 Mar 2022 02:14:32 -0700
From:   Mohan Kumar <mkumard@nvidia.com>
To:     <tiwai@suse.com>, <kai.vehmanen@linux.intel.com>, <perex@perex.cz>,
        <ville.syrjala@linux.intel.com>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        Mohan Kumar <mkumard@nvidia.com>
Subject: [PATCH] ALSA: hda: Avoid unsol event during RPM suspending
Date:   Mon, 28 Mar 2022 14:44:11 +0530
Message-ID: <20220328091411.31488-1-mkumard@nvidia.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c841ff70-fc0b-47b6-f088-08da109b612a
X-MS-TrafficTypeDiagnostic: BL1PR12MB5349:EE_
X-Microsoft-Antispam-PRVS: <BL1PR12MB5349392354AE65A195B6BC8EC11D9@BL1PR12MB5349.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kQZkQkZuOfLc+6jpWUtPZMJCm2MYFgn36AgbjbXOUpYH8RENb7mFBOvbZNJk1KXoFQw6PiBASBTfjw8hZQTC72t8BH9Q6HgkkNG6kdjAFk3hABv/RcCb7+jVUWGnO8R9Y77bXyBuKpNSjIdcYvBV+cYeMDgzT6ADeqVpDrfFmYQQzA4T2CC7ZkfjpPSFZ6hh0M6C2bSyaAVHRcumMvb7+xO8N0Ov2PHq+C8GIDwhhMR4M5Mo7or2HhOuTJE4MJpLSKSr6Q1SkLCx7JiXILadpYOD1X1EIqMSdMzHaWsQhqx4dYE12HyZWNIecyLH19yjyCCDBtgZKsvvJpT/Qh0MHwh9WoB9ugDkpMD8MTQdHfIbxENM2XP+mWV6dxZRDMyfxsIoknAGM3tGmHtbleEGBkay1KeKB1JusLsP6fVoz/B+GwWSVhGE6yLPzsJJQxLxB7cn2wjUfGj8LjeotcgP8GWfBG1lE1Ab2NvqBFV/gtGRMQH5Uuj4+yCJqYJ7R1WEF+w1cT1TqKzFTIpv5DK970HjjpV/T27+9DjOhgI7kXxQ0JxKIeCoOaPE/yeo58OyEbsApB39pxfWP4l7/50NfDJV/aveEPBFUj2JMpNlrezAfBQe1LrcfTpIv1ehrTxr6MGyzN8HH0Lhk5zfzXcD0VTAAZVr5oi1g/s31qK9w2Ud1tBiiM6V1w2aV/amtijvq8hR3j9S+POb0NEDVosOQw==
X-Forefront-Antispam-Report: CIP:12.22.5.238;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(81166007)(356005)(15650500001)(83380400001)(70206006)(47076005)(36860700001)(426003)(70586007)(107886003)(36756003)(4326008)(8676002)(2906002)(110136005)(54906003)(6666004)(5660300002)(86362001)(7696005)(316002)(2616005)(1076003)(8936002)(26005)(508600001)(186003)(40460700003)(336012)(82310400004)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2022 09:14:36.0807
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c841ff70-fc0b-47b6-f088-08da109b612a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.238];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT006.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5349
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a corner case with unsol event handling during codec runtime
suspending state. When the codec runtime suspend call initiated, the
codec->in_pm atomic variable would be 0, currently the codec runtime
suspend function calls snd_hdac_enter_pm() which will just increments
the codec->in_pm atomic variable. Consider unsol event happened just
after this step and before snd_hdac_leave_pm() in the codec runtime
suspend function. The snd_hdac_power_up_pm() in the unsol event
flow in hdmi_present_sense_via_verbs() function would just increment
the codec->in_pm atomic variable without calling pm_runtime_get_sync
function.

As codec runtime suspend flow is already in progress and in parallel
unsol event is also accessing the codec verbs, as soon as codec
suspend flow completes and clocks are  switched off before completing
the unsol event handling as both functions doesn't wait for each other.
This will result in below errors

[  589.428020] tegra-hda 3510000.hda: azx_get_response timeout, switching
to polling mode: last cmd=0x505f2f57
[  589.428344] tegra-hda 3510000.hda: spurious response 0x80000074:0x5,
last cmd=0x505f2f57
[  589.428547] tegra-hda 3510000.hda: spurious response 0x80000065:0x5,
last cmd=0x505f2f57

To avoid this, the unsol event flow should not perform any codec verb
related operations during RPM_SUSPENDING state.

Signed-off-by: Mohan Kumar <mkumard@nvidia.com>
---
 sound/pci/hda/patch_hdmi.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/sound/pci/hda/patch_hdmi.c b/sound/pci/hda/patch_hdmi.c
index c85ed7bc121e..67870c8d84a5 100644
--- a/sound/pci/hda/patch_hdmi.c
+++ b/sound/pci/hda/patch_hdmi.c
@@ -1625,6 +1625,7 @@ static void hdmi_present_sense_via_verbs(struct hdmi_spec_per_pin *per_pin,
 	struct hda_codec *codec = per_pin->codec;
 	struct hdmi_spec *spec = codec->spec;
 	struct hdmi_eld *eld = &spec->temp_eld;
+	struct device *dev = hda_codec_dev(codec);
 	hda_nid_t pin_nid = per_pin->pin_nid;
 	int dev_id = per_pin->dev_id;
 	/*
@@ -1639,7 +1640,8 @@ static void hdmi_present_sense_via_verbs(struct hdmi_spec_per_pin *per_pin,
 	int ret;
 
 	ret = snd_hda_power_up_pm(codec);
-	if (ret < 0 && pm_runtime_suspended(hda_codec_dev(codec)))
+	if ((ret < 0 && pm_runtime_suspended(dev)) ||
+		(dev->power.runtime_status == RPM_SUSPENDING))
 		goto out;
 
 	present = snd_hda_jack_pin_sense(codec, pin_nid, dev_id);
-- 
2.17.1

