Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A7254D7A5B
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 06:30:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236168AbiCNFbU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 01:31:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232296AbiCNFbM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 01:31:12 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-eopbgr80054.outbound.protection.outlook.com [40.107.8.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CBCD3CA7A;
        Sun, 13 Mar 2022 22:30:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HsGONzacw2IIFX2ynopuCDswzaLRzLzpypbwi6OmGCNwxOBTwx0PVNPLGKNlVk7EMSXJ6KxVW9IoPIqJsSR58x8JLPKmy8uBxTdEBsksEz+3/58KZ9hz3hb0w8Wq4ENfzxX2elJtf1oXgOoX6lRXet2mP0vxV9RQ/HK2pZ7BIZSTLmO+QO+8z14GVoFBmka4xpJGjBMm3Eos4f4iSOW60kdzo6wJjy5N9rfjSe+RLXzpyeOTZTam3PD4GrhyTUi2K96gLUFPLadocxAHEJ1DbKQBaO4xWTQIGPFcxJhvJs28iWuieKfpI2B5QSrFv/qrEv6mMwM61A16xDqPAVW1mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZdtroXWUqf3bzT5ix0fYDXsb+M1nk54xCO66+F8e7nM=;
 b=L3X+5BwR5mJhHApzOOVdve8wObfUut/f9hyJtfPN+nLJGrbNTHIfWoYuY3fTfDUTC1FcmivcQuAmw3NwA9x6vLrGNtt2wVJlT71zGAa8jWxuN4DS8hMRNAD52xYEzeqBZPDhTPSux0pJkb8JxA1z+jEDAYQ1LBO7N6gw3KyAC/dBJaDvrrgEbPRGNOxp/Jsxv86s0ghEfyfOq009aZFYMqBQl3YLf5ya7JweCObtTAYe8oE4Y/ERvq1CGEiIyx2iLhHM2SPV7ZxfWnaFoHQVkuRepR/F9wGeknRbKoXnM3ZuYC3h/QlyMtR6IqOpS/vktkMKnGAh303scBV+YBu3YQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZdtroXWUqf3bzT5ix0fYDXsb+M1nk54xCO66+F8e7nM=;
 b=iHCHbH9Pxfymmd0GLTP7DatTVpXXiWJjxAESQYW8Pwx3hueyBoMV84NrrxzB4pyjGobGmh36PRrFrZ0GZpgwe3+BzW0agldOLDTNJ+zI+Fd/vEMc15dMdB6H7zvOOseYHC7eN4CpJ15tWMyUz/kEEPKMbJTTAxzC+f3e7OKkz4s=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com (2603:10a6:20b:d8::14)
 by AM0PR04MB4483.eurprd04.prod.outlook.com (2603:10a6:208:77::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.26; Mon, 14 Mar
 2022 05:30:00 +0000
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::c39:69cf:c4ea:967]) by AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::c39:69cf:c4ea:967%5]) with mapi id 15.20.5061.026; Mon, 14 Mar 2022
 05:30:00 +0000
From:   Ming Qian <ming.qian@nxp.com>
To:     mchehab@kernel.org, shawnguo@kernel.org
Cc:     hverkuil-cisco@xs4all.nl, robh+dt@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, aisheng.dong@nxp.com,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH] media: amphion: cleanup media device if register it fail
Date:   Mon, 14 Mar 2022 13:28:55 +0800
Message-Id: <20220314052855.11852-1-ming.qian@nxp.com>
X-Mailer: git-send-email 2.33.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR06CA0017.apcprd06.prod.outlook.com
 (2603:1096:4:186::15) To AM6PR04MB6341.eurprd04.prod.outlook.com
 (2603:10a6:20b:d8::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e56de816-6705-43bc-57a9-08da057baf41
X-MS-TrafficTypeDiagnostic: AM0PR04MB4483:EE_
X-Microsoft-Antispam-PRVS: <AM0PR04MB44839606212DA1CCD33754B6E70F9@AM0PR04MB4483.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CCClwwV8DnoTfyNrNg8eVD5UjCSNqQnGSH1mkZVrXzDN1dLMyAZoeFTnhl8LxAyz2CRZypg3Lr5TBQd+i+YhO3W9pRuNZvVTZ5mQbIydPjmVzIdXxc1thoIUpIuf2fvzTNU/s1xfA99FoQpYxbfUE3RLsx8GcKOUddHgGVo7NL11T9Ocnla258kwzqBS24jJyv60EdjGnk5KZQkTooRSdzrgPskqCtsp3GkjJXn6NQL4xmd30Zam447JFPTM7JFUsa+69eaxO3i3xqEYmgCkHNEWQFT2ZugB3wh1ouUayp4K9ZLCN/lyeOjwx/Esv5Rd995L6rcVDu3bGsIRhKWcdeAHlXheuLlAcx86Cgps6MdDQLbCOp49CnGDGkqJ+l33TbEbpLuY2F1dy9fQe+kO/CsLlagshll4VDk2AhQKr2alwKLbyCPNXTtthUJ7DQmu7XdZNF3DxIms5NFmElGpspU0MldU6RM8XwSGSkjKAKJ51oo4HCduI1ecjTK1/22LLdVh93aAgbBjxrvceZmJ7NXugFSGar8RN0DThY2LWhnvXL2oxDZ9icQH1HEAnGIFIIkND9qPGGnIiqLvAOuW0kTzBVRt3R9FetNCD4i0ndA5R+4t2b83BXomHkr3tCj13Q2KsD5wBaB9XK+eS32uLEigoil0pIpk/kta4lfi6SV2j+GijSJNRleQlIfnQ99p+/8Mfy6ZwAbEtRdKDPPQ2w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6341.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6512007)(52116002)(6506007)(36756003)(2616005)(2906002)(26005)(44832011)(1076003)(186003)(508600001)(86362001)(5660300002)(66946007)(4326008)(66556008)(66476007)(6666004)(6486002)(38100700002)(7416002)(38350700002)(83380400001)(316002)(8936002)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Xr5mObY6ysydO7EaX8WCFggX7K8naJOkIaxDJXUowV4LVO1br3NEYdXZibbh?=
 =?us-ascii?Q?yOcuPsgJDrzjZ5N7DUl90pzEChp4LTi7pxkceIZIgCNJ0DicG8sVduBZcvXM?=
 =?us-ascii?Q?CDEt5YG7g8y2mOm3pd16WnFYEErTnUwjAElxUIxg9xRO9GvQ7kx2WMl4PyPA?=
 =?us-ascii?Q?UoJXGXx6842ng7ta4d6YPqbzR9AKKsXuMJi1/Ug74wCvbLTx3BlJOPeI1/V8?=
 =?us-ascii?Q?YKtV7/oW70aWvF2zAXDsRm6XJglC5RfsBq4Qh/DDQfYeAGD/zoAZd5aiaZtz?=
 =?us-ascii?Q?sSudZs/YdvKIOzrOVOxkDfCljtxuUXMsbn3emZlgs/B3mNc+9wzG0NpXRTz8?=
 =?us-ascii?Q?2VC7iU7rq6s3BAdQAd6H8UZ6dgWILJ8yHeb3VVGtcc1gh1LTP/poUPOz5HKN?=
 =?us-ascii?Q?Yf5MUQOMNo9I0Jg12EQaD4CxSjx0+mpXFNtpcxZ+D44QQ0y+zRSW8xiazeE7?=
 =?us-ascii?Q?4KEHVqcvwphdx+n7H2Co7p22eGN0bEMS/xnfZy2/Qg1djSfmcgrec7AZ2ode?=
 =?us-ascii?Q?1fi590fwifap2n062fGLoJldXrJPTRFDkyUhpzg3t7TWyw0RL71Vzq6lyWsF?=
 =?us-ascii?Q?awB6IfPNHeCOCS1K7AVl/IiT4tNn+4jQ3DPXnhkRwjA8ho00T0K4Lp06zIQX?=
 =?us-ascii?Q?4W4oiZfChMMoPghdQK4mkFHKm72k0XoFJOvTyoggqDs/HbFgqXNIgiO0uvtX?=
 =?us-ascii?Q?wLz/2cu4POckvIRq3Jn3d5WC54/80TfLBX45sE2eIPigZ9DwkOUyKEIo65fq?=
 =?us-ascii?Q?e16T/UyLkz7HxtDm+7heJYBX8buJ8L+2DyEhXN8YHEKuDKVcb4hvOXFdrwX4?=
 =?us-ascii?Q?i8eeMe+0GVEUiYtJQHtFaBe1lSlqerNx5fDxc7IcJ9yyxFY1Gk4tfZuBX6T1?=
 =?us-ascii?Q?GPpWpeOoW+LFpxuAilIH9H9DBuZjQyiV1I5Y//wVvnd/2ZPONkhakNZah7MY?=
 =?us-ascii?Q?szel+g6rEHFmq/qJW9xKtjctPhJ3n0YEPYBtrjPVKLKzC1rbk+ZlMhL+hgtV?=
 =?us-ascii?Q?W5ccp8dkMgQFokStTBCYCXJIjAngME6U/G2A1tTv5G6tGVKWYagn0zFMbTbg?=
 =?us-ascii?Q?udH1BGNvtOAym34I5to9gSrflswXBK0texZegaQeqOdtjUbs4EMmTTrlz6k9?=
 =?us-ascii?Q?1lMbNZhysGmV/B2wHPBFoZ3XF8Gyez9MH7mYWEe0mw7xwrBlxfDNXT12yFm3?=
 =?us-ascii?Q?Pbqv4Ua25WnbvOZ55W80QEaeQJ1C8P+aX3Z4jo0tlpSQ/y5XguCfcD8V6PeA?=
 =?us-ascii?Q?dvBtjIGKpJLhodDb/2PQSrql3fCm7HMg9AjsR4CiAGLLYi1TTWVLX/c/E98x?=
 =?us-ascii?Q?iV1Ank+PK7VEz3qFnSVfNNiAKRl5hWkFFK58dYwlZs7QZyP95X5UeWBsas2t?=
 =?us-ascii?Q?JEmLkMACRK1gJNYWsKhOYTYyubMjtJJ8gXeWS82Fs2OJ2Tq3QDOFJHk7d91E?=
 =?us-ascii?Q?JB3wVUQQc0K8/SmF6iIGkCt7Qf9QJTCf?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e56de816-6705-43bc-57a9-08da057baf41
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6341.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2022 05:30:00.7632
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1oEMCp6fmJgFUIfRGHHx9kWLx7k6F7qFYnI/Eb4AGA3wg790YeWmccI4wO9GKq1Q9ZxmTVJpFQZ5h9EmgRMqZw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4483
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

there is issue that driver forget to
call media_device_cleanup if media_device_register fail,
it will led to memory leak.
Also driver should check the return value of vpu_add_func.

Signed-off-by: Ming Qian <ming.qian@nxp.com>
---
 drivers/media/platform/amphion/vpu_drv.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/media/platform/amphion/vpu_drv.c b/drivers/media/platform/amphion/vpu_drv.c
index f19f823d4b8c..9d5a5075343d 100644
--- a/drivers/media/platform/amphion/vpu_drv.c
+++ b/drivers/media/platform/amphion/vpu_drv.c
@@ -128,8 +128,12 @@ static int vpu_probe(struct platform_device *pdev)
 	vpu->encoder.function = MEDIA_ENT_F_PROC_VIDEO_ENCODER;
 	vpu->decoder.type = VPU_CORE_TYPE_DEC;
 	vpu->decoder.function = MEDIA_ENT_F_PROC_VIDEO_DECODER;
-	vpu_add_func(vpu, &vpu->decoder);
-	vpu_add_func(vpu, &vpu->encoder);
+	ret = vpu_add_func(vpu, &vpu->decoder);
+	if (ret)
+		goto err_add_decoder;
+	ret = vpu_add_func(vpu, &vpu->encoder);
+	if (ret)
+		goto err_add_encoder;
 	ret = media_device_register(&vpu->mdev);
 	if (ret)
 		goto err_vpu_media;
@@ -141,7 +145,10 @@ static int vpu_probe(struct platform_device *pdev)
 
 err_vpu_media:
 	vpu_remove_func(&vpu->encoder);
+err_add_encoder:
 	vpu_remove_func(&vpu->decoder);
+err_add_decoder:
+	media_device_cleanup(&vpu->mdev);
 	v4l2_device_unregister(&vpu->v4l2_dev);
 err_vpu_deinit:
 	pm_runtime_set_suspended(dev);
-- 
2.33.0

