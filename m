Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CDFA50AD42
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 03:36:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443110AbiDVBjl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 21:39:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344083AbiDVBji (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 21:39:38 -0400
Received: from EUR02-HE1-obe.outbound.protection.outlook.com (mail-eopbgr10074.outbound.protection.outlook.com [40.107.1.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B6BA49938;
        Thu, 21 Apr 2022 18:36:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Yi+9ysKMFVUnAc77HNs+VT4BRhusRwyPqwi3vBD9RW+1iiNS4ID752FeDU1s+3IrDzA19BIScH/V9H0RnbQnB+E4zAnw7OCX0/CuGdneEToB3EDDE8WN0ehKXHjYqDT9vrIduZVCfxfdZWRFhOmoCIhFdb0BEANAbnfrI7U5Kf08Li6PlcO6aW4kjfZps4uUUUStc6LgArRfUyUsPTvEzswuQvN6DqUo/I0v6Lc5T1CBLjy+1DPxE48+zP1yu7VdEw3voDAnSU/+UqqqxnObFB8J1UgqO9VFqWlCUCivD1uqqAPmgwO7uq0D3Gu4v4s2cg2AC4/cU9etEOD6eFDN0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZFMbElKFe5/Kg6HItWVWFZtWacpk+FcbeGegMGd9EK8=;
 b=YsI+fBvydo7F6/hfkFHw1CzjdyWJsITuqiSH7WqlACdqINXvtWopKy3T9HU5TN0asl5BRJms2PDuQ9HZjdDMI7Z577nVL0JzXBY1u0Z7HeqrL+RhcKX74Y47Z5pZaV4diUvKUQF2L0prG0maY/G2zerjxIdqfEE5MTUOdLzxo3wlfJKQ4Isqc7DyBv03SY5aEDZwDRoVfBxttPr79HKxWDRFtuqp9wQC79cuwgmeQeo1mAIyzKcjAVEEidbAnUNu2kEVGig6+LzAz6gLzpI1whAFn6vnW4+odT2Qi1rCcTxA4EUGpqgl6JjXRkSH5SdmrF0YysKeaqcbPYWm5Xwv2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZFMbElKFe5/Kg6HItWVWFZtWacpk+FcbeGegMGd9EK8=;
 b=DnIiMWJzHESHcQwW3ic3PCtwvM3UQQf7fyRx9XnT1dS4R5XPzTOk7ALVD/JUNlIJ0WDyoPH1XWXtpWhIpICwg6ehZvnAPkOVGVXu2clOWxVnSel1A1uvuALC9dosH7GPCLqNoVIYzv+a8dRhRd91beGqPwO0Na3jKicYDFNEbew=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com (2603:10a6:20b:d8::14)
 by AM9PR04MB8145.eurprd04.prod.outlook.com (2603:10a6:20b:3e1::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.15; Fri, 22 Apr
 2022 01:36:45 +0000
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::d8b5:5914:5189:ffa5]) by AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::d8b5:5914:5189:ffa5%6]) with mapi id 15.20.5186.014; Fri, 22 Apr 2022
 01:36:44 +0000
From:   Ming Qian <ming.qian@nxp.com>
To:     mchehab@kernel.org, shawnguo@kernel.org
Cc:     hverkuil-cisco@xs4all.nl, robh+dt@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, aisheng.dong@nxp.com,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH] media: amphion: free ctrl handler if error is set and return error
Date:   Fri, 22 Apr 2022 09:36:21 +0800
Message-Id: <20220422013621.5308-1-ming.qian@nxp.com>
X-Mailer: git-send-email 2.35.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0016.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::17) To AM6PR04MB6341.eurprd04.prod.outlook.com
 (2603:10a6:20b:d8::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2da1ebd2-0c37-484f-cfeb-08da24008efd
X-MS-TrafficTypeDiagnostic: AM9PR04MB8145:EE_
X-Microsoft-Antispam-PRVS: <AM9PR04MB81456EE11FADC4BB3212B820E7F79@AM9PR04MB8145.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jsOPcvyBT3i2GmwGic0+O2Jm+y9IVIq5iWRVscIKr9CmYo7U6SbKjFEJ/AAiVlrEKvilqtM06CQQSCO4aLjP2D5jp07cbbBxR5PUhDbakoUhBehf7ixsed0GKRmpPt2ltn32WxBLHLAwdOn89irRhelO+lCcsdzVyjVRB+sIF448oYZmTNZPbQ3sMvoE4M69Mq/4p/TND9CUXYBtDUtzAwWSBVdxkTLVw5FbUyEibMoqNoY6VXHW7zjqH9uoNCHpR/TbfkqaULsIWuyO5tIum5qz9ftowbxlHpmQLrvCs40MytffCoSD5W8J5TEA02wXjZulwYDz6MJW4QKFmRRHwWGYeolIWpExFzBw81ThFf5qB/kR6WvBW8M2qkVMyb/cnNqV00gYGbFDvrHw050J1FGdzgjSzcMiV3q1fgvSh52GAGyeOTrrqfQd0hLybAY+oUgVBHEgIPxMOnJLbt20Xjc5TVtrGqD/dRFbSTWUNRB4SPNAbXSkAWgaUNETVBTt23zKzk45WVBdlUQWLNMtdqWfcjcb0CLYn+LC1pGrcSjnMa7juZdsF7+6VnixaXP/C+yxm2uStEFpmSJhfQH4FPn/SY97Vb7+0MkkIO5BX4VD4H4m/SW71Mdp41/re0xEnHVYQnr4XvCOQdodDSGinvG91BVdqltL51gawV5FuT+yXt+4Kj7tw9AKmY8nMepginxGuyaG0WNmDHG5nMYo8g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6341.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(86362001)(8936002)(4326008)(8676002)(66946007)(66556008)(66476007)(316002)(6666004)(52116002)(186003)(36756003)(2616005)(2906002)(1076003)(6506007)(44832011)(508600001)(6486002)(38100700002)(38350700002)(7416002)(6512007)(26005)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?hz2Zp8lpueVLp+Dv8zBtX2ebSBF6kMjZT2xVehvNx4kdV4kR29kcyOws88dk?=
 =?us-ascii?Q?jQJLEMvWv2Ay2RQWw6/F4Dg4+TZ5CE3EciFEgajf9OWvO8FnV1U5R08xBRz3?=
 =?us-ascii?Q?QY3CtI17VGVAgrrdpVV/pkloKAK2LtsXUrWaGtGjLvkxBeqnM4AKRsumAC+0?=
 =?us-ascii?Q?9Nb95gKpu2F4Yb+6z94EV0Gf7/TujzFLTs5ZGgc7wocTT3yGmA+xAYP2BzEn?=
 =?us-ascii?Q?V5QULpz+APwwsVw/Lc0pQnupJnjTLVdrfywJAYDWBQA5uFhOc4UAogjTbfBR?=
 =?us-ascii?Q?6OCIe852sledyWuheROON+d5XDsozf4fpw71A6PtyTJx9V/uep6IAXJzc4ez?=
 =?us-ascii?Q?jrHj/Kts07xqwj6sS4ZeeO2KFN9Mu1z+dHaQowbDVI9/lUTiacMORK3wve//?=
 =?us-ascii?Q?VsrVIhxtYo3U0lEsvxI6QaRbACpVoeRZpJqcka9GrV2dCaN3M+0zm9WJfr4X?=
 =?us-ascii?Q?n6rquwj94v8AM3ewc80gLtj/VD/ADWprp9vtFtb62HPnSITuqtH9Dk0iNyPS?=
 =?us-ascii?Q?E/2iOvaIP5oUqPpLzz/9lAWPByMgKu5AI+SKl+0DqQDqxKDIqMyjL6dVnQyN?=
 =?us-ascii?Q?iVTc2MiFzb1oHJ7T3y0R+fU4FacRDwcVVOKEIQDRaHB0fjjC2j+fQGr3QDYo?=
 =?us-ascii?Q?RfBnk5KNTG7uC3SaOM0z8wAFco4XaqV93HG9foSxBikD6V3OIpRZYitPkAUW?=
 =?us-ascii?Q?V2FqkRCTNTqRz9SiLyXs8NZZtqTH1ULwzmqtlTMNWdGyTOX4MuqvskXJckv2?=
 =?us-ascii?Q?hq+sfRX+EjnYtgJD4nWYfeY3QqrdpinxlcbRcnHSoFK8fbOYx4yQ/EmN1N5a?=
 =?us-ascii?Q?bAybhmmjFtGtWTkJN+p00gtOgiDd8GRK2LdkBGSjHZIBk5GM5fGzgyYwGRM5?=
 =?us-ascii?Q?c/ehUbW3W0dh2zkfVDS8VcJCFsrKvAQXAYKK9yOzMXpqPud74JFKddXDSubF?=
 =?us-ascii?Q?FS1ht2CjcBXlsmFfeWAsczxeOWpHXhgD1q8nq+x3WRCa+Vp6ymXKUmqeT9yz?=
 =?us-ascii?Q?OFKo4iJF+MRPPnyT8tfiBWUAe8ZbUxbQ+QlmvV0Dx6lereU9VjMZxslc+KSj?=
 =?us-ascii?Q?4Dw9I0KJqGjVlHkm5jO63YIjZvsOXKbbEBm790Eutw9WhaNZDQGR2DCwnY9l?=
 =?us-ascii?Q?b7NdnM7q0bEfs0O5L8qFizcIA+l8NcvyV73I5oCryVXg4EVjZmk12JAQLGB7?=
 =?us-ascii?Q?jWBUEE+3i7zDYpZNhQqkWT3B4Jl5ZPvo/lcaVAKV5WP0xUc+b5i7RI94dNV3?=
 =?us-ascii?Q?0Ble0bGlK/2FzzfdUDrInWaLQLtDjQqPhJLWheuL85RlzD2yvy6vN3KWAoAa?=
 =?us-ascii?Q?1holmRHBhxZennG3dzXJWY+TGtdQ5lm1WFruorEMxPCAqwCcXPz/b9+Aq3ak?=
 =?us-ascii?Q?67rsOyJIaxz5+7DRXC4Fn62H//INPkfjSDBNsNvQ2G5AaVLAfvgfe3V8fvAa?=
 =?us-ascii?Q?m/URa9zl5G55sQqDTWxbnidRRCzZEhP0Iaey361b2F+SK8UhBVLr/0NwDtzE?=
 =?us-ascii?Q?QXVVhJqrcjW949lKMjRsE6Qujq4mflfgoLNetow8CRuX11hzx3f8JAOjQy1j?=
 =?us-ascii?Q?7Ogo7OQEgOMjN+08eZxtZZqsA5vuqCPc4U7E6jtNHTHjbfeZEeWFAes5p37G?=
 =?us-ascii?Q?oyZFSoxFeUPONQ+B2klcSODjXRaj5sqaS2AqQkBc9bvriIdQvRgPElm1rh5w?=
 =?us-ascii?Q?/u0JQfi8k8qie8Mp7PeVJ34+YQiX2NOpiyEyj5vrmM/HwaYV0+MzjDLhYjLk?=
 =?us-ascii?Q?M9fdadAtGg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2da1ebd2-0c37-484f-cfeb-08da24008efd
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6341.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2022 01:36:44.5507
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZbkV/b4yjnkdwlFjHtiQvoit1NoTx46rnc31jXxEmFNJzTn/qpYBdUDq6pET2D2kBDGpZkASktHWlIjeZyLskQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8145
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The typical behavior is to add all controls, then at the end check if
hdl->error was set, and if so, v4l2_ctrl_handler_free is called and
the error is returned.

Signed-off-by: Ming Qian <ming.qian@nxp.com>
---
 drivers/media/platform/amphion/vdec.c | 6 ++++++
 drivers/media/platform/amphion/venc.c | 6 ++++++
 2 files changed, 12 insertions(+)

diff --git a/drivers/media/platform/amphion/vdec.c b/drivers/media/platform/amphion/vdec.c
index 414e5215d8d2..3c02aa2a54aa 100644
--- a/drivers/media/platform/amphion/vdec.c
+++ b/drivers/media/platform/amphion/vdec.c
@@ -162,6 +162,12 @@ static int vdec_ctrl_init(struct vpu_inst *inst)
 	if (ctrl)
 		ctrl->flags |= V4L2_CTRL_FLAG_VOLATILE;
 
+	if (inst->ctrl_handler.error) {
+		ret = inst->ctrl_handler.error;
+		v4l2_ctrl_handler_free(&inst->ctrl_handler);
+		return ret;
+	}
+
 	ret = v4l2_ctrl_handler_setup(&inst->ctrl_handler);
 	if (ret) {
 		dev_err(inst->dev, "[%d] setup ctrls fail, ret = %d\n", inst->id, ret);
diff --git a/drivers/media/platform/amphion/venc.c b/drivers/media/platform/amphion/venc.c
index 06c873fd0031..ba9f49cca155 100644
--- a/drivers/media/platform/amphion/venc.c
+++ b/drivers/media/platform/amphion/venc.c
@@ -682,6 +682,12 @@ static int venc_ctrl_init(struct vpu_inst *inst)
 			       ~(1 << V4L2_MPEG_VIDEO_HEADER_MODE_JOINED_WITH_1ST_FRAME),
 			       V4L2_MPEG_VIDEO_HEADER_MODE_JOINED_WITH_1ST_FRAME);
 
+	if (inst->ctrl_handler.error) {
+		ret = inst->ctrl_handler.error;
+		v4l2_ctrl_handler_free(&inst->ctrl_handler);
+		return ret;
+	}
+
 	ret = v4l2_ctrl_handler_setup(&inst->ctrl_handler);
 	if (ret) {
 		dev_err(inst->dev, "[%d] setup ctrls fail, ret = %d\n", inst->id, ret);
-- 
2.35.1

