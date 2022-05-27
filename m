Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2D83535E23
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 12:25:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350929AbiE0KZL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 May 2022 06:25:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234079AbiE0KZH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 May 2022 06:25:07 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2070.outbound.protection.outlook.com [40.107.22.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CCED61295;
        Fri, 27 May 2022 03:25:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VMX4sCEBcxpJNVhcjJweBV1fhZGRn5HJVQVl9bhWLt7bqphaiYaQ/BKZHcIIX6ONcQDrSgIrzw1NyQ+DgyUKwKcRjwn8JjAS/FqPZXfHGB/MHNaRa3N34jRyJytNMitC6iQPxb7rlpVFbQAZkQBBK7506jLX0fqRRvdGjzJmmVpIG9G0cS+P43vUG9bPN55E7FSA9OINSSuVWUs3KOADlgyREVPcA7KEMMJDovW0V7yuYpUTx5J3wpLkzooGgB9O+mVTOcMNxNG8DMOYbnpnkHJtAZWPj/bnfl0vWM3CvVZwRNJ+3Ib8Gg2PosOzhEwSrJYOPMRopt2PDkaXaILqyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KoCzVMO2TSbL/kzMGVx0A/9AHGeZIpTfvLyq7cJkP3o=;
 b=oPBXyMkm2nP2xxXFEVNezBa+GWO1eAGPt3HkZp8HmX8SuI7oFMWgBr82iMypnubKDn9Wn8CmBgBWes3JrmEAXwhF9sFJCP+yyQkXc7vk8jk75UMB+M8nWno7xt3G1ozECs8yMRiNmA1uGQcX4QuM88hjUp2ZUtuggFs9qHQ6yryBQ+ka4KhrwP04ApA3x+WWPfFg066DExmGtbBOS4DZKmoNCayFL11mbPghjD20oD31cxHchjY5dYm33CgSOcyUEmXCKDLAdMOpLap+tVkwlP71IG4HokD1G9fRfrTuIN1yrY2i2zS964Qyu7VLCR8170GNsdDoAcili9moyyrmyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KoCzVMO2TSbL/kzMGVx0A/9AHGeZIpTfvLyq7cJkP3o=;
 b=AhPuv42TGGBMZA2j/asaoYJ2e5mpCP8hGyzDKCTS9x7K76UIPjbGyWpQAPO3Sw9l4P5kXRR7pX82XOASUxXgKh9TIdwU7nNsULLGJ2gwLKLyt8JwjBsAswcaAUP2xZhcO3GKHsU2GbRGeMtkI/6aa/7ZHkufL4sO5olbskWAq+0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com (2603:10a6:20b:d8::14)
 by DU2PR04MB8597.eurprd04.prod.outlook.com (2603:10a6:10:2d8::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.13; Fri, 27 May
 2022 10:25:03 +0000
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::bc48:7565:c619:62c3]) by AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::bc48:7565:c619:62c3%7]) with mapi id 15.20.5293.015; Fri, 27 May 2022
 10:25:03 +0000
From:   Ming Qian <ming.qian@nxp.com>
To:     mchehab@kernel.org, mirela.rabulea@oss.nxp.com,
        hverkuil-cisco@xs4all.nl
Cc:     shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2] media: imx-jpeg: Leave a blank space before the configuration data
Date:   Fri, 27 May 2022 18:24:44 +0800
Message-Id: <20220527102444.19683-1-ming.qian@nxp.com>
X-Mailer: git-send-email 2.36.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0018.APCP153.PROD.OUTLOOK.COM (2603:1096:4:140::9)
 To AM6PR04MB6341.eurprd04.prod.outlook.com (2603:10a6:20b:d8::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6c35468c-9025-4974-b6ce-08da3fcb2960
X-MS-TrafficTypeDiagnostic: DU2PR04MB8597:EE_
X-Microsoft-Antispam-PRVS: <DU2PR04MB85972B4C04FD4DE806175774E7D89@DU2PR04MB8597.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5lQEfClQWETEwxwYM7t8+uDNX4wum4y3ok00Ow1UrdZVtzFq4FvtsKxNu0b/9R77hAb2OJCWndcYTqAglTh3/vJLDJZytZqyPsR5nX61rpH8t9jR/Tru+fo8v++Xv+Nn7+Ckv/KqlGjI6RiA0bkNmDFMwvhRO0RToeJWVjPPdRm0GFI/iBJr+/2tzJZ7WEZKDhJJtlZULn2Ui/m9WmodeURxnA4MIqEcNMJ2jO0nis+kXcGg0XR/K7OKVMuV2SfFdqkEX4/sfewUQxy6t+oqSPA5tpBRrvi5iHpxEtuyNP9hJhRx1DwcM/QFn67Cd5AVchRnlEdcEZeYXdg6l8bSWQY6NPseG3pRqcF6giDBQxcSMjU2HCezQS/lBZ0FmTVADbTxRj9Y6avcUNSBYmQqjJfe3TznnSM7ujP4/weBoBHbesOasvrYi9wDAFv1rj9edFGMLJimYXvtyJm95jbr9+efLTFUwzAXCry74cp2g6Ss434U7la7yY/Llu/UyT1zJLjImgbgbkj1yfrprUA73sCNIGXuRFACISP3VUweq7wuaKqdUdM4wf1mzmmYZNjCpChJaSxYpUFdCWArJujhmposKogPY9wkSayeVbBvYynawiBeWeFAoE+GSOvZdPKooiAxbBWWr8fez2MmFMcdyMFy13gwezFs8KeA8gR8DA6Ys1uea0OqzSYZBsa8PC6vMLLqU9t9XrogieWjHSLsVg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6341.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6512007)(2616005)(6666004)(52116002)(26005)(6506007)(316002)(66556008)(66946007)(508600001)(8676002)(4326008)(66476007)(38350700002)(6486002)(86362001)(38100700002)(1076003)(186003)(83380400001)(5660300002)(7416002)(2906002)(44832011)(8936002)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ViC5bTyi3HYrFhbLbf9xFMq6S9erzWXVBnHCdbwtnWa+s7VSvEaVvkZhyyiq?=
 =?us-ascii?Q?Gn6HNxb5ZOW+e7QuIqp5H2yQpND3LUau0lPuq83wMxHaVymTUmT75uxYuVzQ?=
 =?us-ascii?Q?mlWvL8k3C+41O0fJtegvgq3oVi5TrpXTJeT+5dAtsreNMXB38UKa7t7nqJVt?=
 =?us-ascii?Q?l7wY8wLrsvLnKGqfW9ecnJljoroPssOuUIyxFD+cPbVtHWxksbWLRJNguO9s?=
 =?us-ascii?Q?teZAqkyAdZyrzqO3MCNalcYRBR70gbB+CFqajUqLTzE6RjeCyUPjOfKFcqij?=
 =?us-ascii?Q?bMrFvTbGw27VOgqmTcZu9SRrjJgKZ1TfpQGIBX5j2yCr2PeACvdtoEnhy81l?=
 =?us-ascii?Q?8mBZRhu/Hn3Kiub79VgL7WXavQEhCuDW7KQEMzkTNzK9va9VOXuBKvm4UuIC?=
 =?us-ascii?Q?tx6dQaNEzyT0cfY5+axbMriaJouAKjqmV79qG+DXWt07zxb0n8DZbuNdZGNK?=
 =?us-ascii?Q?ucf35S2qotP95FfU2OBNBJ/mPZdITVGUWVXcP/C0eHl7qEUMy2kpUa9SzY2G?=
 =?us-ascii?Q?C+L6cxE15UB8bnTYjFL/rAgnz5UGOYGhAVjBRALpa7mk8fBI9Z3QUlIACHb3?=
 =?us-ascii?Q?tONGbgfk8LCvGcqibHWZuQktPfHCaSLqerIGDAAxQwoxnlH/tws3lY7bKnyj?=
 =?us-ascii?Q?Uig16Wd4lvZg7qBOJBhsmhsp+aFz19gwZrwsCC3IyLyf5U9izg1Vz4bmgTgT?=
 =?us-ascii?Q?aXBsyQMr/12ND/FJdslY34r42X+8KXQxas6/dP8uR2rBuhDbcEBMUXtnbkGE?=
 =?us-ascii?Q?jVI9DQRYmEzMvNNN5oyu0m8MpKVQyQiIbrs+i4tSr+z9aYmTcQpYFlIL/dI2?=
 =?us-ascii?Q?zn+xfKFirHNBrnJq5VBnM696qRB0hZNI3bffhHp4fdOsZA5w+8sgLuT6s0vg?=
 =?us-ascii?Q?lz8NJCH+XsWgEQq4bOF3L6fCq79r66Ws70HC+mXpo+y0KPlnpnoK8+GWOZ/V?=
 =?us-ascii?Q?tbWKLE7mUHp69hEmJF450UzuqG+UewGXDCxUqRZ3h4BvxoN9hRy0S624gMnE?=
 =?us-ascii?Q?JozNtLGbskfMrP3wZGBZAp8mxF1zb5hHWF9qVzyT0Dk0wDjzHsZoHWTnjQOr?=
 =?us-ascii?Q?FAwbhTf2LPxZA4X86ChBBtRhzaOeN8O2TlAxzN58dCMuq9NT+zBvuYAD2zlQ?=
 =?us-ascii?Q?0h4rVs/aMXmlXt2MhyLR555CT5ujb74sdx7y0jOQM5bIJrABmho0B6uoRpcN?=
 =?us-ascii?Q?/FA4j/3qlKyj9GUtxfA2qBEF7HqrmjTiqGKUnBwkTGyjX5myMnRYv9FBA/qP?=
 =?us-ascii?Q?YuLT+SaYeIRFLkPMbF2Z64rlffICVR/YgOIeV9MNiixTKcL3UbLFkwLPKRbX?=
 =?us-ascii?Q?V5rLgnDrvozgLCRSKjxDOuzWyM8MI/huWIFCDthqEPp/Yw1f8zm3RDxfTUqA?=
 =?us-ascii?Q?5vNUi8Fcf8TGyZ06TILsw8qVCl75AR/4zYIb975OQQaRrRjLVXE/baYwENnG?=
 =?us-ascii?Q?0uPZKEsibdjak3BwdIUrXJo9tjLRsd8mNRxCUIjgnSEykEMCSm8yQYNe8Eok?=
 =?us-ascii?Q?NpZcW41xL4xn9Kf9XGulScAgI0mnmsoUgxQVJx79ywQLMb9mJrHVIHSW8hoG?=
 =?us-ascii?Q?l/nDvrqw3USad+HFKvdrnNBkTB731DmctEV5nEF8QYujl/TbCl5U630Z3pFG?=
 =?us-ascii?Q?RLu1fXXNlydp30DHAmJKsEuvtWfdrvkDerLevXoZTa4CsKoYhGVWGcOFw4DP?=
 =?us-ascii?Q?HXhgG+MHFtcwS/J9VmYp7jNZiEVkfNW1/LmJp/WZVctr6lcy/E6en/IWlsIG?=
 =?us-ascii?Q?gecmLkeSbQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c35468c-9025-4974-b6ce-08da3fcb2960
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6341.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2022 10:25:03.3180
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kuJTc1WDeOarT+i3zZtxRDKmQc69e92dKTIRB/hO/K9CRF8OFGIMIjFWEMZ8kMg8fGk3O1iNP8RXyXwO/VYOIQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8597
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a hardware bug that it will load
the first 128 bytes of configuration data twice,
it will led to some configure error.
so shift the configuration data 128 bytes,
and make the first 128 bytes all zero,
then hardware will load the 128 zero twice,
and ignore them as garbage.
then the configuration data can be loaded correctly

Signed-off-by: Ming Qian <ming.qian@nxp.com>
Reviewed-by: Mirela Rabulea <mirela.rabulea@nxp.com>
Reviewed-by: Tommaso Merciai <tommaso.merciai@amarulasolutions.com>
---
v2
- add some comments about why the 0x80 offset is needed
 drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c b/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c
index 734e1b65fbc7..c0fd030d0f19 100644
--- a/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c
+++ b/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c
@@ -519,6 +519,7 @@ static bool mxc_jpeg_alloc_slot_data(struct mxc_jpeg_dev *jpeg,
 				     GFP_ATOMIC);
 	if (!cfg_stm)
 		goto err;
+	memset(cfg_stm, 0, MXC_JPEG_MAX_CFG_STREAM);
 	jpeg->slot_data[slot].cfg_stream_vaddr = cfg_stm;
 
 skip_alloc:
@@ -755,7 +756,13 @@ static unsigned int mxc_jpeg_setup_cfg_stream(void *cfg_stream_vaddr,
 					      u32 fourcc,
 					      u16 w, u16 h)
 {
-	unsigned int offset = 0;
+	/*
+	 * There is a hardware issue that first 128 bytes of configuration data
+	 * can't be loaded correctly.
+	 * To avoid this issue, we need to write the configuration from
+	 * an offset which should be no less than 0x80 (128 bytes).
+	 */
+	unsigned int offset = 0x80;
 	u8 *cfg = (u8 *)cfg_stream_vaddr;
 	struct mxc_jpeg_sof *sof;
 	struct mxc_jpeg_sos *sos;
-- 
2.36.1

