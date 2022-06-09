Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9166F544769
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 11:28:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233917AbiFIJ2a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 05:28:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbiFIJ21 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 05:28:27 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-eopbgr70040.outbound.protection.outlook.com [40.107.7.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC7581F2F01;
        Thu,  9 Jun 2022 02:28:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F5bZmDT6Ntns8ERuC2g1EP0WjDIdGgBXnnvD1lmPog6/eRHIUahk3HVko2AiVgULSQwq9/RhaaKMt8kv3iKccWluaoVXy1liVZ0FxJMCjAB8jD3QbT8EaUtvYfabfxQyPf/BK9MAf3NoTm6veWS7XNAvz7Z/l8VuZ84R0vrLvbxMa2kycWeVYeGv6OeGPTDoCWbWjIbZwHLRrJgfFN12P/nO9SnRK8uZeRCoQiBhe03ksilcXpzOkWVmCz1D9qOJyJ0eO2vC3QJghlIigsMgsDeQStbBKPzE1M/mdzd75V6Cfq1WIjeWZv4SiUKnRWXnWVBSxUV2CrUVukjlc3MZGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nkLnOR+lAfgLxck9O51tp8TaOaLSXCyvts1tWn7y1Ws=;
 b=CT824xfVl1v1doLVRbveU52+XgjUbEFXUVwDiof3FMd4WgVf8rWw8jDFHN8+QglztalDvm2DLTQQYvuEbc9J1J+DIWhkhyn9FI5GlEc4M2JIOvgMIq4DxyYIWRD4Bkr9XWW2KKOgXwDPNIy934jA+MANisyr3fI4GO+w7z79iTaZ14iorl2N2gC+JNXDDzX9y46ywmvzA/mXNGHmLNEPG3kJ/1dpfr00sr4WQA/w/xpNdU2ngKutucDevq2IPXXVqBoUkDkdNMv6uBNbSf7Gt6N7P5QnQ/0SCpF8CIxyw3U7TW2P1vk8+64JcKj+ATFfyzXAvz5HgcJvi3Og2n7UEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nkLnOR+lAfgLxck9O51tp8TaOaLSXCyvts1tWn7y1Ws=;
 b=fBdt0bVL2jG5UsEy1DTy7Geqh2UIIX0N+Nk5otNdw+emZ2ug+pVkzqkdxxiM/hADH/NlIDgpXNa500wunlbEibTfS8J04ethnLig+JfqyVybt72TMdF+BUJiIMgNaZJZyykpNmwfKweIzjd/jGf4RNLOaKf0M1agRar/uCFksnU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com (2603:10a6:20b:d8::14)
 by DB7PR04MB4955.eurprd04.prod.outlook.com (2603:10a6:10:19::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.13; Thu, 9 Jun
 2022 09:28:20 +0000
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::bc48:7565:c619:62c3]) by AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::bc48:7565:c619:62c3%7]) with mapi id 15.20.5314.019; Thu, 9 Jun 2022
 09:28:20 +0000
From:   Ming Qian <ming.qian@nxp.com>
To:     mchehab@kernel.org, hverkuil-cisco@xs4all.nl
Cc:     shawnguo@kernel.org, robh+dt@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v4] media: amphion: return error if format is unsupported by vpu
Date:   Thu,  9 Jun 2022 17:27:59 +0800
Message-Id: <20220609092759.997-1-ming.qian@nxp.com>
X-Mailer: git-send-email 2.36.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0028.apcprd02.prod.outlook.com
 (2603:1096:4:195::8) To AM6PR04MB6341.eurprd04.prod.outlook.com
 (2603:10a6:20b:d8::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ab691977-6771-4907-c4b7-08da49fa649d
X-MS-TrafficTypeDiagnostic: DB7PR04MB4955:EE_
X-Microsoft-Antispam-PRVS: <DB7PR04MB4955327AC53451F8BC1142C4E7A79@DB7PR04MB4955.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: De0oGDlNIVFm1+zeenx+n/D22IR9st+phdhBk/nx/eE2JD6jrR+ymZVmucQPbNy0iX8lIHT8Ns0K7GkYAr9Dfy+ShPWnKXGvV+ZMiEhlVof+Qpe2N5ILNp9xlFFt4ib6jxGI0yDMI/a5VeKvIKsdEZAqfMvncrl5VYrXrPlz+tz94y940PXLjKGsGIAByW1TBvfo/SRdqisbVcvZ0jnNwgyrUJfGCsFXmbK+wuK9q9bhqcVQawTzxSMEdz/Mq7jNj3Mvd0Bxn/dgkIDxxdEY833c19BkpGKdOQvgSv7IruwXNNsmNxF+ZXxRgSnrpRNWiJ78Fhl/jRzKE/gzpCj6c1CQefl/nfOnbaxo/C518SOFU2DsrKVUXmfmdyNgC4UXQ7ILELtyxP3mNGu3MAE19Fyl4SxcaVoEwA4FpNS1oUNaA2gBm1W2Dh1O+iL2AmdXwzREteCGjUAw2zXWEYiDBIj1sVBQGVyQqALU96aQowaNI4WkDNrfKJdPFGK70ORQeN4OEkjMjf/bC4qdHBrFceGwLf84NsTdpJm4jg7S4a2QMlYT1PPMb7NBJQJbAMT8MIogPpv0C7Zck6s07khogwvq8gGIwLYLLuds6cpnHqANWrXmK9o70ujbEiYgydUXh0g6NcMWdqST0pEkuaJCxGxK/kRrQtzboo+Qr0WaTIud0M9v+iBBIG5FKgAOJn00UKQUJ/2lKq+Lt/LjqVrDXQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6341.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(316002)(38350700002)(66556008)(66946007)(36756003)(66476007)(8676002)(4326008)(83380400001)(2616005)(2906002)(1076003)(6486002)(86362001)(6506007)(5660300002)(52116002)(508600001)(186003)(6666004)(38100700002)(26005)(6512007)(8936002)(7416002)(44832011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?88WTXu9fswB/89PcYoWH9ne5h1NbW6yFaNZ2HQDvmKcwO3XretFVVvpJxSJj?=
 =?us-ascii?Q?IoXiBB+gA0QE0G64YOIv7jMBjurGDT7MAVmm84btnwaXRf22t85VSdyqRkUr?=
 =?us-ascii?Q?9laLxvH9KMt/8Zy06YLx4cVUIz12uPMAVtRxvbV+11THPJdTezz7Wyb55PEf?=
 =?us-ascii?Q?a7df6ZiIAO3oSbuDbkj1yChhJ0QVW/D11PSiEZxUN660lP3RMEJv6oWplqS9?=
 =?us-ascii?Q?42/JkrJccUqajsk43GViAExfX0E+VlixwvsjiotTNhgoi0uJnRvLpfgEsO/l?=
 =?us-ascii?Q?QCnjXMAM7gcC4hB7ZyQPwHSt6iz0bQoHCzejW/hJPCFkx7ilHJ4vnsIqjVvt?=
 =?us-ascii?Q?k1EQT5O5/wlkgGD8HqY8CKqdUay/l25Z1sS+ydpM8l440ifbjmkaFhPwRwnY?=
 =?us-ascii?Q?3Q2+M0FL0+SfL0iwtiOKX9OZ6w9XqnGVnyDYgqoh69QOqj0lNtEDY0lTCHez?=
 =?us-ascii?Q?OOAos8VCWicxBEEEtbZMlaAilw7A0TIwgle5PYl1s890e6uzr8YjFFhBcFvh?=
 =?us-ascii?Q?2Y6VAY1LVDnErxXh11ewp0vwtw3a3+kvs5of6GWXjv4jjR/V/uXz2X4ThKEG?=
 =?us-ascii?Q?x34YRl3A4YhY7K2Jzqj5Hv1ZvJcgL9yacfNnOteIIS7bYA8lyO1BLx05Ns0t?=
 =?us-ascii?Q?ZaCYF0lBSpetMtz5MByjzKQJga2WONtVB3OvNjnMvHnl2uWoTDn+OZLl/nw9?=
 =?us-ascii?Q?FmvA8ewo/NgtW0d9lVqCSRyjydybQ3BaK8lS3EvpSN/FX8FZITbpsAyvgvL7?=
 =?us-ascii?Q?DJAs0OxPxTgVDe/GrzAt2AWHMG0x8KRwNcRf2QExZEbPIEJ9+Bq6ekjrsgHv?=
 =?us-ascii?Q?plJb54Loj8xnwb8ohSQKIe39qKRzTNzi6DBJnlz2GsJ9W5AhfRzJ7EE99JiJ?=
 =?us-ascii?Q?BsEV4bF491K4BE6tDprQiH3sXQjpABoW9AyUiEU4t4yEbcpCbiXH+rtG0lDg?=
 =?us-ascii?Q?CNC27xxeUmnWMeX/tTEkGPUibQHDlCw3YK/3W3x9ZeY13/gFoBIR/sC20NVo?=
 =?us-ascii?Q?jFERbPKuyRlH+FbvbySkip11bd+5v66xFxoFUvEsA8TLcfUwhoAZXkSwKWLZ?=
 =?us-ascii?Q?jh5GJMzJtfp8dm2faC8ITrkrBhpHk0Y0OciH3CoiXyErxrPY5XaxT2aMo7J2?=
 =?us-ascii?Q?Iza7al9/cUbWh72GfC7HZBLeRYSbIUyD0wt/UFNiC+CtpgdhgTrIOraJpDPa?=
 =?us-ascii?Q?oQzt6nm9wTKWstGRm+vUOdahMM5HvnRowD9bM6iuWShw5j0ELGsK9fLSLTX7?=
 =?us-ascii?Q?6fggFq+8nfkIz6Lk2f+3l62hNkKFSCtaIKAlevKZrhY4KMGTftrAK297TkJB?=
 =?us-ascii?Q?jJUhM8voLwKOVAp92vHMWZe2dNpOPQIYJQjXgsfVuUfoS4lkLwVh4K4jdpmk?=
 =?us-ascii?Q?PFLvOMoBTqhTSiupjZv6fL0Ie8b8GszEvQ4HDZ0wZY9k7/l+DTM3eyeYzFWh?=
 =?us-ascii?Q?UBdc14kcearwozX/7rIv66MEk4tj1Kod2H+rfUPtlu1fH6Zj9UGkVX+h8g/c?=
 =?us-ascii?Q?cUY0LCGAsAKLEdcK3gA3lMdE3FNK2K1DP6Ii4b6FH5E5l9MzNhxydKYD6yz1?=
 =?us-ascii?Q?yVF/fONKPgFah/eb4sYZ5aaL0w1JUcEX73mVlO8/Q8jvN5MkvjmE6i01cB5a?=
 =?us-ascii?Q?XNCBRSg+TXa23ePXXNVkzQzO+Q/wbncKI/kn2Pd2wbasgwju2sIZE7BYBhSu?=
 =?us-ascii?Q?JRC9EwC/eHM6RgKnU+r7FEya7CfQ6lhw/axVeGVEh2AzcfO/z03aViPvT/Pa?=
 =?us-ascii?Q?J3kkgaoArg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab691977-6771-4907-c4b7-08da49fa649d
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6341.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2022 09:28:20.7090
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HwFQflxkw4w4c2JC/jkCIQdlGqPMqjs9ETdJLRSGfqcH2Jd9v+1wAztGAYWGfuOeX7eGKQ9YXNnRAY95Lpo7Nw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB4955
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

return error if format is unsupported by vpu,
otherwise the vpu will be stalled at decoding

Fixes: 3cd084519c6f9 ("media: amphion: add vpu v4l2 m2m support")
Signed-off-by: Ming Qian <ming.qian@nxp.com>
---
v4
- call vb2_buffer_done(vb, VB2_BUF_STATE_QUEUED) in start_streaming()
v3
- return buffers if start fail
v2
- warn on failed to remap pixel format to malone foramt
 drivers/media/platform/amphion/vpu_malone.c | 2 ++
 drivers/media/platform/amphion/vpu_v4l2.c   | 6 ++++--
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/media/platform/amphion/vpu_malone.c b/drivers/media/platform/amphion/vpu_malone.c
index f29c223eefce..40267c73b1f9 100644
--- a/drivers/media/platform/amphion/vpu_malone.c
+++ b/drivers/media/platform/amphion/vpu_malone.c
@@ -610,6 +610,8 @@ static int vpu_malone_set_params(struct vpu_shared_addr *shared,
 	enum vpu_malone_format malone_format;
 
 	malone_format = vpu_malone_format_remap(params->codec_format);
+	if (WARN_ON(malone_format == MALONE_FMT_NULL))
+		return -EINVAL;
 	iface->udata_buffer[instance].base = params->udata.base;
 	iface->udata_buffer[instance].slot_size = params->udata.size;
 
diff --git a/drivers/media/platform/amphion/vpu_v4l2.c b/drivers/media/platform/amphion/vpu_v4l2.c
index 446f07d09d0b..da455e5ab337 100644
--- a/drivers/media/platform/amphion/vpu_v4l2.c
+++ b/drivers/media/platform/amphion/vpu_v4l2.c
@@ -500,10 +500,12 @@ static int vpu_vb2_start_streaming(struct vb2_queue *q, unsigned int count)
 		  fmt->sizeimage[1], fmt->bytesperline[1],
 		  fmt->sizeimage[2], fmt->bytesperline[2],
 		  q->num_buffers);
-	call_void_vop(inst, start, q->type);
+	ret = call_vop(inst, start, q->type);
 	vb2_clear_last_buffer_dequeued(q);
+	if (ret)
+		vpu_vb2_buffers_return(inst, q->type, VB2_BUF_STATE_QUEUED);
 
-	return 0;
+	return ret;
 }
 
 static void vpu_vb2_stop_streaming(struct vb2_queue *q)
-- 
2.36.1

