Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E8AC52CD02
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 09:29:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229451AbiESH3a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 03:29:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234693AbiESH3T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 03:29:19 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-eopbgr70073.outbound.protection.outlook.com [40.107.7.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C9318B0A4;
        Thu, 19 May 2022 00:29:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oVekeRWEbXYn3NtR+SrYRoJ/UH5lmaSKRiPX23lH44vL37DGkbeLPc1UkFa799Z42UYGMDeO1wroSU08aJmKucv171fw+U4C1YMDKL2xGiBMMsMtYkHad4+ROtYA4ZythM8Sm4xv7avJ35ai0qZCUbTLH33wuWO9z7swT+5iXWWT9Qb6tbAUhwCJNPEzxWuCtmDaFjgMzFZckm+nG1hi1vfBNFAAz0cmJdnG8sHQ//IiABca0iphuS+5mYfoy30ZG+gw/fURuxSgtHHC9uMzZOD6+sKm18XAJM5sFesSiZ4q6ViiAs4TYvPQlYQFXQjAzcv9RXOGTssNMH8jck2VpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MLKwwddypjZ3TK4G5eD2piVzqQBxuFtkxVn5HAJAB20=;
 b=XT0hMnpKQO4y0iSYIlQ2eIV4FdBrg7+CsqOdpW4Q+E4DX76KxtwF5O1deKiVcOR5EWX+FAyaUZXe9NcqDxDkNRL1AFIq77ul+C/2UJ+xmtf1P9WFLrOHL6/cd7AMJr3Ww4g6vmfEA95h0sXsltF3un78tNt1ZuMlfA5rfXpHdU/0hFpZeMWLAw6YFsjzzTwNyUfbI+GQ8rhIKBTPp++F6YngJKZRXcuZmpX81vriCF95N98F0yYba9N/WHGx0Q+cGAvZc16Vs6mHFd2zCZZGY9Ca++0shYiqeeZHPIaWGJb0Y8omB48NcG07nL7TzhDf5sC9z+DDQmMsfoS+SenM3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MLKwwddypjZ3TK4G5eD2piVzqQBxuFtkxVn5HAJAB20=;
 b=XhHOm5MK94ZbH9uOJAy+dZhkgro685y57ofrZ3pdnb7rArjo7Efpx/1I30LIzCKPBzbLwuTK3d2KAFlJcDi5na6sF3UDWQ2nS95rn76XX7+3JlmeseLSXQrGhs9C3/VS0Nanu8+tU0OLvnSyBsMpwB2OprZkLYjd8EV52t+mD7Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com (2603:10a6:20b:d8::14)
 by DB7PR04MB4314.eurprd04.prod.outlook.com (2603:10a6:5:23::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.16; Thu, 19 May
 2022 07:29:13 +0000
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::bc48:7565:c619:62c3]) by AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::bc48:7565:c619:62c3%7]) with mapi id 15.20.5273.015; Thu, 19 May 2022
 07:29:13 +0000
From:   Ming Qian <ming.qian@nxp.com>
To:     mchehab@kernel.org, hverkuil-cisco@xs4all.nl
Cc:     shawnguo@kernel.org, robh+dt@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH] media: amphion: return error if format is unsupported by vpu
Date:   Thu, 19 May 2022 15:28:44 +0800
Message-Id: <20220519072844.31792-1-ming.qian@nxp.com>
X-Mailer: git-send-email 2.36.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR06CA0004.apcprd06.prod.outlook.com
 (2603:1096:4:186::20) To AM6PR04MB6341.eurprd04.prod.outlook.com
 (2603:10a6:20b:d8::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bdc43f3b-d9b4-4ca1-c186-08da396945f2
X-MS-TrafficTypeDiagnostic: DB7PR04MB4314:EE_
X-Microsoft-Antispam-PRVS: <DB7PR04MB4314A1E1B8B143AEDF1C9269E7D09@DB7PR04MB4314.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: R48OG8s3juVJw1RoOA3LUZHyIb3qS1x4j5qWgedc7nK++kd9oEBV4nOHVYRc87BMXL5d7c1pwrgL3VyFWw4+T+IjRmihdeQIqOwCRvRLSwg1quZ7E0+kGr8b4lkth5Fe1sjyUFbtPQcv6wlxy8s+XtcFKI2LkxCfq5NaPRedgy6FAY15TJqscpvUUmYbC3MqSXEAUuQ6fW2GxypiTZTL+L1Q5Nz4dbFVqyQWMLlMSZWb7iIi9yC6bGH54rfR0+6HVA3GQiqx2vnnIA/estmiN/g+bJ3BZs1Y+DjijR05rxpNjBpXrUvtVUW/rlaD1CCHxby5eKlDYZgxrYWeDPf5z52MkOxOaS8QHIaCn9SAsTODL6fGdSfWl41W0dTDd8sxKmG9QLVI2cpHOVXIoq8JdjW5LwC8n17Wsjgza7K47LefL6M4S7vsFQ0yt/HUX/MJt8MjTnBtItFqfKZyqlKz0N+NrZ0/wj/ob+Mw+wRz2BJCSonx5CYlrREi9mAtNOV00sn4KK6s+Zrj4VgnQCFHDmwxdlZZElZwyBCtMrXpiNU+22i1gO2wZ+rSNb87YhR2GHXdce9bco/GE6nqv5tBILNi656SOmlX/4ctVcO5dYl0oAkaAdd8KeTXzuqE0nr4gtNZ/jJjFWjZi9TwGV262t/cgmeeNebY5Kfkbj+dDIrHLrzwa1+Meu58/8abyh+fdkuO2f7GXsOeu2kx59DWfA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6341.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(5660300002)(7416002)(316002)(6506007)(6512007)(26005)(52116002)(6666004)(66476007)(66556008)(8676002)(38100700002)(4326008)(38350700002)(8936002)(66946007)(86362001)(508600001)(6486002)(2616005)(1076003)(83380400001)(36756003)(186003)(2906002)(44832011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5Fg8+DXUjldYCB7H06sE88S9KT+MFl6KD8Z63pPbq1aES2JMltAJDLNnTRD9?=
 =?us-ascii?Q?QGwE77FgFFoq8BEf10iNmYLIhQlUhhnRT3OP9+DN79sj/dGhcXOiYjmA+mB2?=
 =?us-ascii?Q?/+ftXW0eUdaV83W+ZKtuzvq/KAh7eJmCu6XbRcgI9HUzJQrPS/NuIB/wFzGk?=
 =?us-ascii?Q?8BA0u6EyGqQtqRZaWcPNgn/6Ha6Db0AyJtw9SOEnYklrUrHpP3lACRrtyrl6?=
 =?us-ascii?Q?ZiWJDU2Y/CwwcgE/gfym2GRXLVlY/5Og5ecQFqziK9E8UE4YZyrVtayk9auj?=
 =?us-ascii?Q?fzay4yxB12qZM/DRSpIfPp6SY6SOX0bL1AFK4/n6Gt1MK7bGPG/9og3ju0d3?=
 =?us-ascii?Q?WCtzcRWl7bvTbhGYFXPZGjBi6wsWAR1qtQLDIYlFRh8GwfgQjoZsFP0f5D8q?=
 =?us-ascii?Q?FFbkGYG08IHJdHS0mIcvIeVBOCAC8r9WIeNkCm2V4av89HXQoeoDgBoaVAgI?=
 =?us-ascii?Q?AAYwen9zRl0HufqBF1fQ/lExZOrHdd2aJu0uTYRveTdeiX2LYQyRRvSlmyqB?=
 =?us-ascii?Q?v7NpBU94s2rDJWddN5yq24g+Vec5fNr3oIRR8Dz8zggdPvvo1EaMOxhBKeWx?=
 =?us-ascii?Q?G85Yt7V6q0TuEIftX+KA6JR8fMMqIlZssPn8kPQilfMt4l2CFNY4W/ycLjpl?=
 =?us-ascii?Q?zJpo3XOfKbtjkiql7jj5KNHBYJoKNah911KK9tx2Rb1oDryngSvWigeos0K0?=
 =?us-ascii?Q?Qp9ounUG3N95S+qEgDRI+Ch4bxXjpOK6ANrn1u6E5563AaHsVaTW4R2f4JUJ?=
 =?us-ascii?Q?xxyFSsuc4oiXDu49+PQ19hOpHr9BfmNR6i/Ez9wkRZ3pJ8chGsO1b5kKesWN?=
 =?us-ascii?Q?C9Dau6WZXqrv9UOFMTcgtQerzijnDlDrA/yfPZMZ72k17TCPIbP5Ul8zaReT?=
 =?us-ascii?Q?Vshu226jWJTHA51iHC2lWwduaJLBs2sNaLw4Tz1XfcaONVgtYT7tCKPw3UEV?=
 =?us-ascii?Q?kSsqTUTSrKw2WbaJDJkiDTygQlFTJ03HLGV1gndghnp6VLbI9By5pj+cKOFg?=
 =?us-ascii?Q?wf94xcpvH0am565l0m2kRDAMiCWrtIPr8HBloy/QYMraNYUUxr8FnEwr71HC?=
 =?us-ascii?Q?DwMm23yxT69AEZeCjpOrtCUSyivt0miDLyy5WHzdoA0ZsQFxg6/Vx0twkRFJ?=
 =?us-ascii?Q?l0chFMR4asK1vIkOr2YHWIJQD/q8d+KhlavA0hmxE/sht6VoGjVkryG0C7kq?=
 =?us-ascii?Q?LVJ6DkEgscEL7tjfbW9O4JDYBLNHIetVTHNEMe6049hIp92cA8eE0bOsj+VS?=
 =?us-ascii?Q?CI5JsQXIGr6bquD82xu21Sr5HkbKteoz7JCFEg5kXZaIkZZdWT9QUeyJ0UIQ?=
 =?us-ascii?Q?1MX+jkBFaod7k08dGXgjOKLLSjqMWoq0oV6vQj7d9S6PGU1cZHEcAFTVDsEO?=
 =?us-ascii?Q?VdEsbNjKN4Fvs07K37g21qF1/7ChGvzNUQ01SWy/RaHnWkoP3OnCz/fUx7Bo?=
 =?us-ascii?Q?PeSUStB23D0EGnb8jrxHGsfnirxLLfpyptBDb/YCaTwINSlRgJIBKEIIzBZL?=
 =?us-ascii?Q?kHlSAmS9AD92VGU57yY/0E5enA1C1UimnBCcgW95K8nccJakbt7QD1VtaGEJ?=
 =?us-ascii?Q?BhM0wB02d3oMBRIFU40FOmhdvmTrIakgzbZLEx5wyTT/uGbW0TBDB4j/+Ca/?=
 =?us-ascii?Q?wmKnYPmIYcZAMn6yChKVYtmzDNFEn7lA709uNe0hu0MhT9Rbk61fx+/b2HXw?=
 =?us-ascii?Q?yoyWBu7MxWfmRiZgsvnGi++RO8XjOvrd+D4aln7TL2lk2TyLTNcVuikxQo0o?=
 =?us-ascii?Q?1SfSXJ1WYg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bdc43f3b-d9b4-4ca1-c186-08da396945f2
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6341.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2022 07:29:13.5951
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yEH/cqlymmEtl3kJi0686nvKUm1o8UDvifmonmnqTteVxm1O2eELDFTEt/Qsg0VjaMpM9SFdvyAGHIU1QbHz+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB4314
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

return error if format is unsupported by vpu,
otherwise the vpu will be stalled at decoding

Signed-off-by: Ming Qian <ming.qian@nxp.com>
---
 drivers/media/platform/amphion/vpu_malone.c | 2 ++
 drivers/media/platform/amphion/vpu_v4l2.c   | 4 ++--
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/media/platform/amphion/vpu_malone.c b/drivers/media/platform/amphion/vpu_malone.c
index f29c223eefce..0930b6ba8c42 100644
--- a/drivers/media/platform/amphion/vpu_malone.c
+++ b/drivers/media/platform/amphion/vpu_malone.c
@@ -610,6 +610,8 @@ static int vpu_malone_set_params(struct vpu_shared_addr *shared,
 	enum vpu_malone_format malone_format;
 
 	malone_format = vpu_malone_format_remap(params->codec_format);
+	if (malone_format == MALONE_FMT_NULL)
+		return -EINVAL;
 	iface->udata_buffer[instance].base = params->udata.base;
 	iface->udata_buffer[instance].slot_size = params->udata.size;
 
diff --git a/drivers/media/platform/amphion/vpu_v4l2.c b/drivers/media/platform/amphion/vpu_v4l2.c
index 446f07d09d0b..89b88e063e45 100644
--- a/drivers/media/platform/amphion/vpu_v4l2.c
+++ b/drivers/media/platform/amphion/vpu_v4l2.c
@@ -500,10 +500,10 @@ static int vpu_vb2_start_streaming(struct vb2_queue *q, unsigned int count)
 		  fmt->sizeimage[1], fmt->bytesperline[1],
 		  fmt->sizeimage[2], fmt->bytesperline[2],
 		  q->num_buffers);
-	call_void_vop(inst, start, q->type);
+	ret = call_vop(inst, start, q->type);
 	vb2_clear_last_buffer_dequeued(q);
 
-	return 0;
+	return ret;
 }
 
 static void vpu_vb2_stop_streaming(struct vb2_queue *q)
-- 
2.36.1

