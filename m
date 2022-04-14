Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D913500910
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 10:59:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241314AbiDNJAP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 05:00:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241320AbiDNJAJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 05:00:09 -0400
Received: from EUR02-HE1-obe.outbound.protection.outlook.com (mail-eopbgr10075.outbound.protection.outlook.com [40.107.1.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A14A76A049;
        Thu, 14 Apr 2022 01:57:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EAKekkIZ9SJWGAnLaEAaZ82bAEgzDpjzIoUGurjz+GazMPV1UNItDYIZJvt5Yjs5w2Vgw2zNMFc9dsx5X6TAKrKdAbht3enZXfSQTkY7fzmRqhqKr+qfUIDDlNQxqbM5YWEiQ2KbBUxPZhqbeFB6Gg+uNR+jCZuMS+vQoZ1I9Y+Phx3khgpKhRKqDZ4dUqFcT5YMMgZXAcD4k13h+b9opNrngfISbSRik3rGHPLuLI7iqcVDBjcJ227jIRVzZ8CuCAowwUjhHttHSeRugg2bVo+/yx/3JC+eq/apC3BtufwzHzb4KRNFSUPJfiOrS0+OWMW1DZOSf8+Mi/jo1lLZ2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xhw8Jsl6Cq3akNhM9czpuGMs2PfZ+hvKY2Wr/srftBE=;
 b=KoCF1uaek0DaMKB5AHZnt3yl9HI0vnWfpSDj3/UZLGOSwdKCzK9eQDCZuuEEygAmyJRi9ee/tv7+rxBeHIpqUcFJeeHUlCUnQvGV8UTOE08nx9PGkuy9wZ1ZDHCQZhekX1t/efaC3moVh/xElQTtMOu50KhNSaQwlCVfXguQ2fXvcg8aMAYoPFGnCfTKLw6yCohku+N2IiskTK4Qcakhqi+dQI6+mI2w/DQQeNelhV87LI0i6FXR6/nga5tBtKgu66Iq92c5IJX5DOyJlswFUE7LaHd4W3EylE61c3+BNKX+t4u8Ou8BFEIhI01mWg6pOGsgR3KP7Tj8J2vQaupV/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xhw8Jsl6Cq3akNhM9czpuGMs2PfZ+hvKY2Wr/srftBE=;
 b=bnkQWE8bb/jYw0LU0kd4nnbWa9yPAktsOSstWVihOjyYh1AxTNwt1fj+Ep3m0v/2Gvwt1rIByztvNQC1qJHFoBJtfeMBPhyeTpUUr2oyryiLNpFPtZMFzPZDPtpu6OnsGGyXOgAI3FuTBUSJ9D4k+o+lEe3ePufcxfd0iBr3LXw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com (2603:10a6:20b:d8::14)
 by VI1PR04MB7101.eurprd04.prod.outlook.com (2603:10a6:800:12e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.20; Thu, 14 Apr
 2022 08:57:40 +0000
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::d8b5:5914:5189:ffa5]) by AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::d8b5:5914:5189:ffa5%6]) with mapi id 15.20.5164.020; Thu, 14 Apr 2022
 08:57:40 +0000
From:   Ming Qian <ming.qian@nxp.com>
To:     mchehab@kernel.org, shawnguo@kernel.org
Cc:     hverkuil-cisco@xs4all.nl, robh+dt@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, aisheng.dong@nxp.com,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v3] media: amphion: fix decoder's interlaced field
Date:   Thu, 14 Apr 2022 16:57:22 +0800
Message-Id: <20220414085722.3919-1-ming.qian@nxp.com>
X-Mailer: git-send-email 2.35.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0007.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::11) To AM6PR04MB6341.eurprd04.prod.outlook.com
 (2603:10a6:20b:d8::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a5a62c05-9084-41e9-eb45-08da1df4d4a8
X-MS-TrafficTypeDiagnostic: VI1PR04MB7101:EE_
X-Microsoft-Antispam-PRVS: <VI1PR04MB7101DF47AA2C419005E42549E7EF9@VI1PR04MB7101.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ujq++/7QePM0WOdHyqw1rUX1SAfmz/AsDVu2ONd5lnm8tZb6vnYaKVqL9Jy29w0X3M0l8bq4g5mHLwAYjam84BseWi3ToV0/L/TXudvaQs7D9YTYRnBp80f1T4n5J0Y90MrcV3TvOa31c5tg8d7UgMOxcCwHhFKRUPuKrIAO6bJAgGH0E5aOPl8Cz4iJo9mxe+wOuXfUHcAT3fhwdLvSSclhHagEmHaHm5dj89YxsQblHY/zLMglPsQZNT97+H+Yo3cLDqmiwfWNjoFP9QNmTLDKLRhaGLusdOw+gHsVUQHhJEv6qQSw/DEuOCqfnHmcQ9RgcfaMcpGOB7TZ8sHCnkP+P6QkdmzJ9b84nBhZYoIyasoMmc4vvt7Bx0p+T1BKapjonbVXueBIMHAUpdhXQWE2XsFwZNlgi9wcYAQrmHF1ixeZIANEnFfzlkmdiL+/scwTnpnXUy1JQ6lXYCO2YRAiVmZi4Nk55aEpXhxcQBXPAqYiOicWV4+yZqdoYcxYoqOHSRBAGLqBCrFY4xGfeGsoycvd0W1R40FHpO+eszZNkbHuFffhYN0b6WhheOyp5ybpqNyJ6sSFBtN51B7JkG4Z+DxrRCXTJ5VkikSGCOOVB3F6bnqOshQxR+RaTCWPJCJWdW+vcld9Ks1PP0zQLtLJhQ2UOvQ9biUtmpY8Q42iELDTPTd2tmUs/mGW26Mp/DpTKNPmTcJmA0f7Do4yqg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6341.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(508600001)(5660300002)(6486002)(2906002)(8676002)(2616005)(6666004)(6506007)(4326008)(52116002)(86362001)(316002)(6512007)(36756003)(38100700002)(38350700002)(26005)(186003)(66556008)(83380400001)(66476007)(1076003)(66946007)(7416002)(8936002)(44832011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?FuXOrDP0ZYXQAQk4B3mIB9Yc45O1SE/P9jNAIB0hwIyFpWji5edbV+3/Idjh?=
 =?us-ascii?Q?sd7Gkq13nZeWCWweV0uWJQvSg2LaDqxd+aeRK+lILsxeJWLdAXPvFtY8emv5?=
 =?us-ascii?Q?LWlSHDm9D+jcOi6vt1i8ax7W0DQecnjaVjamyrgWxm5ZfXRmrdAYOJuQVR5m?=
 =?us-ascii?Q?91vBW2+iREThmYyHHf5mgi/ibIOBLFlA+6IxPH0fUUzfJdLdNHCc6IjR+GgQ?=
 =?us-ascii?Q?UBFcbh55AnfsB53+UWt4wT+oU4EGzVmnX+0XwlYcRzDNchB8Xk/TWRPKuBvP?=
 =?us-ascii?Q?0sXunc2vpadpnk9zZ4KNd+gS2+zUXHh4CmNCFh2KUpJgUL0EV3mezE841SAH?=
 =?us-ascii?Q?GQiwk1UIsZf9ixVs43WhCfTeFXkkqEvi6UHMKbB3v7vhubF/i6hF4sTs9bgD?=
 =?us-ascii?Q?R2eimkCPmc65U55Ec05d1xlzLNQvO1Qv2viphm08kkCFqKtF1eWPpNJcc7Ar?=
 =?us-ascii?Q?ShKjhR0RTunQS5Um4b/PVuFYdEpOYnpn0ZTQfuphBNrCH7Z8w5Mn1FRSsB1L?=
 =?us-ascii?Q?Mq0mVGq4LV/i9LtRpRK8zahMRKHdmop3+WqCQfYAiTrSfgX+yPPUpSuWlAxc?=
 =?us-ascii?Q?srz44zwHdmvsICoixKHq0HRApxycWhAcu68+ECPCvvfMGh+maNTr1Y1b3wJ0?=
 =?us-ascii?Q?4Ah7lCpwyrh2BEBw6hZtuTdfIT5kwMbAtb4WUU6x6VE0YL2weA0w5J73D7h8?=
 =?us-ascii?Q?m4J+ZCrn5P/KJMqEd85HHVBlQlvIKh9k9ZuRJ3MZ8Xrl3TmWnF1W4oDFuYXb?=
 =?us-ascii?Q?/16S6tX/cNxLSEtMKTdrRfo8y/rF2C0yphKoiDRzbqcxGaHIDOF3SzVNyHP7?=
 =?us-ascii?Q?0dcWFgPp8kUjBH/zV1BdJV/3/7UhU0RlhlpcAsKqEnIffsusST6+jy61Tr7h?=
 =?us-ascii?Q?e39HktNj5ou/hj+iVxE4EkHRq1LQW3mOxCjQgouDgHoLMh3I+baMCIy+DAXE?=
 =?us-ascii?Q?HwJ7cYSZuUGyeXLxy36LQyhI6EllPjGbBRrlAXG6bsz4IQn+LpYdTK86WV7T?=
 =?us-ascii?Q?p4ey+7XOmrDpSPx0+A9iSivu0ipIQ6U4mGlT9GFTlsGQnu+IwmYm/BmhVh84?=
 =?us-ascii?Q?xYYxbZmXwfuEJraWJqWO/yEWaeWqy0/beUz74bEPoYEKX5YufXBx/6/Jknns?=
 =?us-ascii?Q?9fwbP3O3QvuF8ea+3vi0kHAg2llRPVH30SBugJRDFksCbHEdv9UtnzphbX+D?=
 =?us-ascii?Q?Phe75NJAcLrKCRh+2y/xf5GdB4iMVe3Gd4KTs04ytXoJOZr6I1yLtcjJqc9q?=
 =?us-ascii?Q?xInRG9mLicfdb/ZbWBwQ7K537g55ddNCoWXGj9qnZEwCREsgK/OFdn9iFRct?=
 =?us-ascii?Q?odvCZTVI1QsdmYt0EW39Z7mTIrLa6IZ+aw2Fc7y8D6lfqx6QhfqKMBEfIy8B?=
 =?us-ascii?Q?dE16+hL7soPThtxYYYwqV0H8PxV1fZS7U9Bpxz3Acowk7pv7OuqJi9SoqPJ7?=
 =?us-ascii?Q?kOfPaCy4zqSYxYrRB93075N7oOV9jrXO6FwrYSuMZhGnVFVUK/uPFJraLABd?=
 =?us-ascii?Q?VpVZyAHgi3Q6qgZV8oYuTlfsF9SXcYppscKgWM7VD0yJ2/iXOMRgBk5INdQW?=
 =?us-ascii?Q?hTMl4mN7TAO60j7OhyW0gSqm6Tj0eYZKDCrIqLnUBvVzzoU9KCeDCiZujwxg?=
 =?us-ascii?Q?mlWHNMNAOqca1ZmGooehuR31805i5mVW3z5/TVspvUKjbSqW209hQrjPO4ID?=
 =?us-ascii?Q?zWo2S2L7zc+axh/IZVjOZcv8oLu1af8fLwYAm9T/zPEj6pWf2CFme4aEFSwV?=
 =?us-ascii?Q?VFJjdW+rog=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a5a62c05-9084-41e9-eb45-08da1df4d4a8
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6341.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2022 08:57:40.6537
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vknaH93W39ygm9oq0ilGhrxJfa3Hh/SDAI46AYQu18CvqFGU93FTHfN+MX4ejuSr+D1BIexvzBgyZpmTVd2yng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB7101
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For interlaced frame, the amphion vpu will store the
two fields sequential into one buffer, top-bottom order
so the field should be set to V4L2_FIELD_SEQ_TB.
fix the previous bug that set it to V4L2_FIELD_SEQ_BT wrongly.

Fixes: 6de8d628df6e ("media: amphion: add v4l2 m2m vpu decoder stateful driver")
Signed-off-by: Ming Qian <ming.qian@nxp.com>
Reviewed-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>
---
 drivers/media/platform/amphion/vdec.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/platform/amphion/vdec.c b/drivers/media/platform/amphion/vdec.c
index 09628dd0c855..0a1976852b0d 100644
--- a/drivers/media/platform/amphion/vdec.c
+++ b/drivers/media/platform/amphion/vdec.c
@@ -804,7 +804,7 @@ static void vdec_init_fmt(struct vpu_inst *inst)
 	if (vdec->codec_info.progressive)
 		inst->cap_format.field = V4L2_FIELD_NONE;
 	else
-		inst->cap_format.field = V4L2_FIELD_SEQ_BT;
+		inst->cap_format.field = V4L2_FIELD_SEQ_TB;
 	if (vdec->codec_info.color_primaries == V4L2_COLORSPACE_DEFAULT)
 		vdec->codec_info.color_primaries = V4L2_COLORSPACE_REC709;
 	if (vdec->codec_info.transfer_chars == V4L2_XFER_FUNC_DEFAULT)
-- 
2.35.1

