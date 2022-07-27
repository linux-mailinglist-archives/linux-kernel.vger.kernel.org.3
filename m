Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CCE8582892
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 16:26:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233857AbiG0O0x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 10:26:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233565AbiG0O0s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 10:26:48 -0400
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2060.outbound.protection.outlook.com [40.107.102.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D61F2BB3E;
        Wed, 27 Jul 2022 07:26:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fEhU951Ofy4O6CrtKA+ajEIGOKzR/nWqzFIWprAkPNkguyzLeziPjkXg6eRpH7m3NFj8Qi5ln81uv5J9erEFEgNajqFYhTO3jU0H5D0WIM7uRoTWbdwR79sq08blanmiPN3f+rg5EcbhliCu9XUM5W4HosPOhFsvnHevIxWTXUHypYUNAF3egT0PRgL567M8kgUvJCugMQUMsAXsuQJrDh2sw5R9pvIvXwo9FtlaeAYTaa7BzWPNcXuvDrZl35o5xbLinsCXqtuMLy+UYTqNKCLkOmkOqBZuNpcAyfQFNVeVVTaE5tKpyH3doniZIQ+C+9vUP7BX4jubxjYXC4PKBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yYll37jJ/5ARnWpURdJ9bZ9HIaGmaIfC4gshWatZxFg=;
 b=Pp9XlgNe+ZlpyIfDgx8jQwFseDiULXTWeR4JfM+VV3I0qKuZs28LTWPTlVBTZkmDCRZ2Ng6TL+tNBCYvtekg4XwDy3+zLf1v+7fLbbyHw6dyWxZPckDYoAFHPuREWjPdXvybyeu4EVgYDF2KRmgO178fnUqd0txvMj8XIRyMgRH4uPm1lLAxcSLKNSrJ9xfwwRJARwhd8rBhNVDaYQSnwjsEu0heUQ5BrQnTx+2jtiTnEm6/wT8Z+zZL/En0N4yy1XGhPcs3OHkxRgpC7rP0GMl4hrZOv9nd6z79YsiPMDKmX/r0lMP8D2to0DQM8cvyZLa4K29xACHNZzqBJYohyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.234) smtp.rcpttodomain=renesas.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yYll37jJ/5ARnWpURdJ9bZ9HIaGmaIfC4gshWatZxFg=;
 b=DoA0WsLj8Fg94PaGtaAq2ANPTVs00cK/Z1xLk2IuJw936YcMW3EqwtNeWWECTZZzTs1kh6fTaJKQXsEdf7BU2AiKfVwAqTIMD/iktxfosy54OrI+6T4TGFwJMs26GFP46u+Nt62UEqbhZ7DmVdnhu++sB/BGaukpmY9Aihe7mjdvlrwHjWnAC0SiD6JhD1NbovPyVA/4xnjg03SPT8Pj7/cXD8ZwLB5slD3FfoHZcZqbLm30tJfeRu60xIo76Fy8tM1fdzVOW7R/AA8gdmUJ/AYBVyyPRVjQBx0OYptmas9y2Bqa+r4T1/R6dDet3M+27ZnnDUUonSKbRE/HPy+qUg==
Received: from MW2PR16CA0062.namprd16.prod.outlook.com (2603:10b6:907:1::39)
 by BN6PR12MB1410.namprd12.prod.outlook.com (2603:10b6:404:18::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.20; Wed, 27 Jul
 2022 14:26:46 +0000
Received: from CO1NAM11FT066.eop-nam11.prod.protection.outlook.com
 (2603:10b6:907:1:cafe::3a) by MW2PR16CA0062.outlook.office365.com
 (2603:10b6:907:1::39) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.19 via Frontend
 Transport; Wed, 27 Jul 2022 14:26:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.234)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.234 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.234; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (12.22.5.234) by
 CO1NAM11FT066.mail.protection.outlook.com (10.13.175.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5482.10 via Frontend Transport; Wed, 27 Jul 2022 14:26:45 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 DRHQMAIL101.nvidia.com (10.27.9.10) with Microsoft SMTP Server (TLS) id
 15.0.1497.32; Wed, 27 Jul 2022 14:26:45 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.26; Wed, 27 Jul 2022 07:26:44 -0700
Received: from audio.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.986.26 via Frontend
 Transport; Wed, 27 Jul 2022 07:26:41 -0700
From:   Sameer Pujar <spujar@nvidia.com>
To:     <broonie@kernel.org>, <lgirdwood@gmail.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <perex@perex.cz>,
        <tiwai@suse.com>, <kuninori.morimoto.gx@renesas.com>
CC:     <alsa-devel@alsa-project.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Sameer Pujar <spujar@nvidia.com>
Subject: [PATCH 2/2] ASoC: simple-card-utils: Fixup DAI sample format
Date:   Wed, 27 Jul 2022 19:56:23 +0530
Message-ID: <1658931983-31647-3-git-send-email-spujar@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1658931983-31647-1-git-send-email-spujar@nvidia.com>
References: <1658931983-31647-1-git-send-email-spujar@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3c01a366-85a3-430b-2457-08da6fdc08b3
X-MS-TrafficTypeDiagnostic: BN6PR12MB1410:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kZlGXnhMfZZ8c+F8jPYmO6uw2HFfmbVnPH4Rd0C0v4vwkwaVtJYFuZISIEyF6ZxSaQgkl2VaQhYZSaoOp7NooGPtX8tYTl596rjq0wY723ELV7/n4E6yHrTG1HkUWPytNlG6n+hth3AOZsYL/qmTybCHATFF1psfK+wdDXRle0MsLszdICWmACFbUlAhjkHBYdY+dPkP332KI7z8qWmiFEqRmq31qNgapXV80jeKhUrClHFvGjlVE7RwMT7XFZmUByxLvHYYs/fe5rZyZQZQuyja9/P4Q7NvZ0UdUbsgaqHJVoQ22n4wor1hEnV9E07EfmYIaPXWudmGO521wOq4By8MGoOsfaDXp2Ll8qiCAYcdXWbm05iCBIYlZ3jvjnw/Wq+efvVm3RB3S1IKTyhKBqZTcUZKclWp6FIk+Z8D1CmGjOrwBqJCo0g04dBqp28e4sCfezH/OvWFZrdPPd4K2VHBwnV4HZa4jAbC3G9kG3/Zm4hHhUDP/21XDdJAOGq1UNWx9Q2QXm0ELiucGokldoTDB4ngbtYRWDb6aj39oV6T0AfUljrqto+OISqv7zmXMbj17QC/KTILAB4zEZuc/3zUVj8iw4vQ4Udp25k7r8JTyQBj/eonuUeyMx8DEr7wBBdiNa/+HX8fIEiN89OTZqG/Jli3juYeuEPig/m8pGJ2HN5VNRZHqPWqxMWmoUkA3GPii33MI+e8be9iUfhJqHAPedPp7ow1vZpDq8NVIkiHYsUkiOHw6iDwnyJsxm6PzRGfQTT3LEWLP89MXm4cgHf1ZbUOJwRs6zPrtFck8wzBPUYwrXighgEi2M8UDCblE7JJLW83fqxBStT3zOzSCg==
X-Forefront-Antispam-Report: CIP:12.22.5.234;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(376002)(136003)(346002)(396003)(46966006)(36840700001)(40470700004)(5660300002)(82740400003)(110136005)(8676002)(8936002)(4326008)(7416002)(316002)(54906003)(7696005)(70206006)(86362001)(26005)(478600001)(40480700001)(41300700001)(47076005)(36756003)(2616005)(356005)(82310400005)(81166007)(426003)(336012)(70586007)(186003)(6666004)(107886003)(40460700003)(36860700001)(2906002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2022 14:26:45.4542
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c01a366-85a3-430b-2457-08da6fdc08b3
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.234];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT066.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1410
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Parse "convert-sample-format" DT binding and fixup the sample format
as applicable. This is similar to the existing "convert-channels" and
"convert-rate" properties for channels and rate fixup respectively.

Signed-off-by: Sameer Pujar <spujar@nvidia.com>
Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 include/sound/simple_card_utils.h     |  1 +
 sound/soc/generic/simple-card-utils.c | 12 ++++++++++++
 2 files changed, 13 insertions(+)

diff --git a/include/sound/simple_card_utils.h b/include/sound/simple_card_utils.h
index ab55f40..39ea57d 100644
--- a/include/sound/simple_card_utils.h
+++ b/include/sound/simple_card_utils.h
@@ -39,6 +39,7 @@ struct asoc_simple_dai {
 struct asoc_simple_data {
 	u32 convert_rate;
 	u32 convert_channels;
+	int convert_sample_format;
 };
 
 struct asoc_simple_jack {
diff --git a/sound/soc/generic/simple-card-utils.c b/sound/soc/generic/simple-card-utils.c
index 4a29e31..6ce5102 100644
--- a/sound/soc/generic/simple-card-utils.c
+++ b/sound/soc/generic/simple-card-utils.c
@@ -22,6 +22,8 @@ void asoc_simple_convert_fixup(struct asoc_simple_data *data,
 						SNDRV_PCM_HW_PARAM_RATE);
 	struct snd_interval *channels = hw_param_interval(params,
 						SNDRV_PCM_HW_PARAM_CHANNELS);
+	struct snd_mask *mask = hw_param_mask(params,
+						SNDRV_PCM_HW_PARAM_FORMAT);
 
 	if (data->convert_rate)
 		rate->min =
@@ -30,6 +32,11 @@ void asoc_simple_convert_fixup(struct asoc_simple_data *data,
 	if (data->convert_channels)
 		channels->min =
 		channels->max = data->convert_channels;
+
+	if (data->convert_sample_format >= 0) {
+		snd_mask_none(mask);
+		snd_mask_set(mask, data->convert_sample_format);
+	}
 }
 EXPORT_SYMBOL_GPL(asoc_simple_convert_fixup);
 
@@ -49,6 +56,11 @@ void asoc_simple_parse_convert(struct device_node *np,
 	/* channels transfer */
 	snprintf(prop, sizeof(prop), "%s%s", prefix, "convert-channels");
 	of_property_read_u32(np, prop, &data->convert_channels);
+
+	/* convert sample format */
+	data->convert_sample_format = -EINVAL;
+	snprintf(prop, sizeof(prop), "%s%s", prefix, "convert-sample-format");
+	of_property_read_u32(np, prop, &data->convert_sample_format);
 }
 EXPORT_SYMBOL_GPL(asoc_simple_parse_convert);
 
-- 
2.7.4

