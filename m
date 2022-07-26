Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D4CE580F88
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 11:05:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232495AbiGZJFF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 05:05:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232147AbiGZJFB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 05:05:01 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2068.outbound.protection.outlook.com [40.107.20.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E6133055D;
        Tue, 26 Jul 2022 02:05:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XgKWM/t7Oe39u3q/AwcwM82gcvUo9oPRt0YCECPZgRSMTQyUtpB1cdZW9Xrv7SW68RICpbhKYEtgwukaLHktklBcL1V6Pv9WM2xmP2f3Z5hS8GY5WwQvUXKSCSyg5mWLwRYn0SQ5THzTpSGz6H7nd0fie6EYu3QFmKV6vTSCocbQT+AGvwis1X+fcgtvpwwG8rjYKm46g7m1Kopp+OdO4wjNXobfzTbnlai+ruoCVRQWCjQgjaTsQN+Agq3Wt3lGqLVxd3nw2LFrsFK1t/0mVI0mfzHiD42CFvrYjOVpxntr8BD90lmBU5zXvTVtwP1wGDHRoMVJQze4j3Q+/GobmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v2/jm1V/QejqzGDKVWKSIxksy6nivJFeZNZrcaFNZF8=;
 b=QGtoUHD9n+MncQfMM0zT4jXEwKn4sX+/A2KKyvyD0JHnjZb13MHaYCb0HKlzjnNmXcqNpO1gbDZmpfJR4Ge/Y/MOQ58LSgLp2D3IeHKu2AVgjluHvaZ3MkcDybm4DQuivoAm2L58quPOvLIOCwk/VkvUrRhCYCARK8CeJUr1ulmGjcF5QwUwffwlgGhQU/SJOtqPipKkzItyHzi1GTA/uRdLWACQG9idaKn4gW17viC/OMjE/HLSWPdgi9yR0RUWb6eX/kdOcbHvd8IejLeQUELXIaAQWLss+zgCA60NxLlv+OBu2zsHETADC4SYLsWrpU+NL7XkMUNCy6pjgAv7Ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v2/jm1V/QejqzGDKVWKSIxksy6nivJFeZNZrcaFNZF8=;
 b=m6RWaAxqr4hUg/ti5UNsGGNUgElQI1++us5khAP6OZ7WZ4qggxiPEc2UjYxoyKfghfp9yYp1FZP4N0D9O2Jwvdk0m3mXOBYMDPXk2a0BXXaUAP6ccJNnCzDidNzgcnDAXu67ohxGeUJ6RSBqXTNEUrY25FzSQSeu9DESdxrAixo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com (2603:10a6:20b:d8::14)
 by AM6PR04MB4344.eurprd04.prod.outlook.com (2603:10a6:209:3f::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.23; Tue, 26 Jul
 2022 09:04:49 +0000
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::5db6:3f08:2e04:33c]) by AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::5db6:3f08:2e04:33c%4]) with mapi id 15.20.5438.023; Tue, 26 Jul 2022
 09:04:49 +0000
From:   Ming Qian <ming.qian@nxp.com>
To:     mchehab@kernel.org, mirela.rabulea@oss.nxp.com,
        hverkuil-cisco@xs4all.nl
Cc:     shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH] media: imx-jpeg: Don't clear stop state in handling dynamic resolution change
Date:   Tue, 26 Jul 2022 17:04:27 +0800
Message-Id: <20220726090427.28093-1-ming.qian@nxp.com>
X-Mailer: git-send-email 2.36.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0108.apcprd02.prod.outlook.com
 (2603:1096:4:92::24) To AM6PR04MB6341.eurprd04.prod.outlook.com
 (2603:10a6:20b:d8::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1eadfed7-293d-43e0-dbca-08da6ee5e50b
X-MS-TrafficTypeDiagnostic: AM6PR04MB4344:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: M+3XaO7Own0LHB7TMR6F34UZuUi6zqk6vkZDrr4pKbtcnUuP9dYE5l/daSFpuLw/r/9V14kNO0yraU1fajrVQ8XjBSLSSaDzHw2+LQinKb7ej51bR/34qUnxAOjumKO1zU1MRYpgG1cAHciGRtx4QQz1+TNhhl/s9I0pp596d5YponjofJSDQVO0q4AMxtlk1kH/yG1N91TFHg5CYBdNsH2l64rRnSIlLjqY5wAFzuPZd+lzaOH261ePBSdosumDnE+X96/XEeEmxoSTXKhhFDZk6LSylyLwwurkaPMtVOK4X90t2QxzZbAkdtIAF9DAJNNV0yrpDpI+8nneHZTNJRRlc9HvIZpbjIrpGcd5nV2x1r0AXuqeWBPjPWnZvdQn/xjJyoRTWwEZZXYreU5gLeCIx5CFzF0QxQt3VD/B2fFhoz5cGfceX53Q4kJ24Q2bLzRfJ0II8q0qQWFAsnMkZlbZ0V9xIUInQy1+6v7Qc+i3pyvRyGndboRqMM7tHuDc83PDtvHAPPxd12/+hDTuKDx1fdqcBZEFzYxxHabq9cgKEqvmNaMk82pkmN3wDUZqzM9RXcr0hdkTc0RVN+LWw4VBFSZbhPcfQpnGm9YgaZBnInaVSL7ZVpicbrUpMMQs6+DjLek0W2R5OdH1/fNXR7wLd/6/NGFT2n3J/b6uUEupyMKM1vMu7pJTIR6zWa+LOkU+cRLSAKOn5Ic767SrzhxVW+rCyXCilMDKMc8FJ1G2cjOTMYhSW2GsykWxO1moNxQx0+2fgCzqg5hdpx/0/MWPsX8zB4PlRfJLhpzyJ14=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6341.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(39860400002)(396003)(136003)(376002)(366004)(8676002)(6486002)(36756003)(66946007)(5660300002)(66476007)(66556008)(4326008)(44832011)(478600001)(8936002)(316002)(7416002)(26005)(2616005)(186003)(52116002)(6666004)(41300700001)(2906002)(6506007)(38350700002)(83380400001)(86362001)(6512007)(38100700002)(1076003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Vdze6Fe51TDH+SyWzhCJ1qWjRVxbtfQrTsVx5oTBDBpbluNBM9ke3sowWfy8?=
 =?us-ascii?Q?RO+UQjI4Nsx4lotbhtVlsbmyK70qUynZ2/9T2i4X8uDL2QHmiRxeqL6zCE8G?=
 =?us-ascii?Q?azdX//dWyX9mjS9GNW9T2/UImp6v0U4UbWntr7W5M0QO53AuCwAhYGBwORx1?=
 =?us-ascii?Q?eyYl5xGVoKFdekcKgUBvu+DSeOvaijO4jk9xDn3bJcyqgvVdJUqsDpR6vIcw?=
 =?us-ascii?Q?Vdjz8Nk3TveZx3tR9fwSs2FXsdG9XrmXJHfpQjvgCIj7Zn6kTeDg6GOKyff2?=
 =?us-ascii?Q?JeNV5yvXKPz5phuVvdTaPNuLSKSRXISqZsJdNObXjkWvtwdbwt1f3XbxkrsX?=
 =?us-ascii?Q?1e6f8AU1O4vb6MpQRDbyUEGVVD+UhvJdY8nYgq49Nn8FpyMKSwoWBgQJOAIi?=
 =?us-ascii?Q?LHu9X0n6XRVeMb6jJTY7sWIiVBpqE9D+fN2fTO0RmnQzN97S63EgtrTSLpV+?=
 =?us-ascii?Q?XGp9qRXJQPScA63AYhx8arrHwL+fd1UTavgfWspfNAZ5szXZ9fPsBDy6rhuY?=
 =?us-ascii?Q?o0H+L0e1s/A3gW6Rb9Fmth6RLYLVdhaFLfTXP6ZdRGLJbIMXmbxEZgPuPErO?=
 =?us-ascii?Q?gxlOeIWLUI+ieK1TGAOokXNWfhpHvc39vqUo7eTqZOYN14jtU/ZFNjfLYwkt?=
 =?us-ascii?Q?C7I+S8dJy7I9hGgxil+TFITIz2rxI5A2xz2ZDgB5ikd8xJQ00KtxDoCjsLd3?=
 =?us-ascii?Q?utiR1pfjXR8lTCyJnZnVNAnwvVJ+MnzsfkiNcaLaBEgKNcKTw5Jt6Tuhz3FY?=
 =?us-ascii?Q?QQsItCinOjG2RO3gayauOzwB/jt1A7q8NJqdK6Zpihnrjv5pSS6nNp0tTnPb?=
 =?us-ascii?Q?joOfKalbZepfcrW3D157GhJQxiioRow+RiXa/bPYFo5Fd8RmfAZ9iJTWut0w?=
 =?us-ascii?Q?+nbs6I0Ovozc6aM3MGMvOBnlPujpRtjnQU6IZwwjNasiPAGkMRIJdBZTDUXH?=
 =?us-ascii?Q?7uNrV6waQDt0ZS7Bf3PWE4rUufeu8oVYvdJJpPZ1Ti20pnK8lbe/da/JPPER?=
 =?us-ascii?Q?hswfJpqp6/y5pPr8SZrxdVMYOJx1NlKpyFLhTFxNoIidmIh5jdAPXP0CxQkR?=
 =?us-ascii?Q?ig92wA3A/Fv4yos0mntQtgZptZN7EaVzW5vD2luFMvzJ5rEH28s+Dblw22L6?=
 =?us-ascii?Q?Be/iaAg3OkbSXw/V6tHfjU0pbDFBg4wJ1O+uBS/B2NCiqcD+5iOkk/jP1OQV?=
 =?us-ascii?Q?HtB3QLvd1ENvFu0TP4fJPAIxgno9woq9fv2YVSxKwaLqDh6mS8w3HY8tnr5G?=
 =?us-ascii?Q?XRgJz22765JLvVzEDrm1HguyJ6Zf32dLuJhiV+AnYCZ4FLtaaUp0rbwIu3q0?=
 =?us-ascii?Q?6gaA7L06a+cKdHjSAXdF1jv1E9269i3nRLKBSbG0QQ04fxkRrX+ACrMPjyPA?=
 =?us-ascii?Q?a87jqE7dfIll5sfPFpRKLZu7EpLCzPc3xEsg8SvC4jYdze/N5cSXIHAtKctw?=
 =?us-ascii?Q?SY4TAoILcQOe7Pybwf/AUbv2Z4dVhC+Fm8rGAkF4fLxYs2tzIYvIdODbIpLk?=
 =?us-ascii?Q?gtwDCCdi4gvryXNOVy+kEKR6DN7MmNxKz/x5UEyLuZtuNPGa8Hlm5exsfOfx?=
 =?us-ascii?Q?DCE0D/t3nJHEUHNFniW+MQ1WpJ9s4jGSA+XPcq0K?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1eadfed7-293d-43e0-dbca-08da6ee5e50b
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6341.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2022 09:04:49.8328
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: il/m7bneQiHSFy1YUGdghbjk9u4lp7q31KUAJybdhK79IOQjHv+QoV3uqRr4PrXOOrb33uuJ71tzptssyZjMKA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB4344
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In dynamic resolution change, streamoff and streamon on the capture
queue may be called,
the V4L2_DEC_CMD_STOP cmd may be called before driver parsed the
jpeg header.
don't clear the stop state in streamoff of handling the
dynamic resolution change,
otherwise the drain may not complete.

Fixes: 4911c5acf9351 ("media: imx-jpeg: Implement drain using v4l2-mem2mem helpers")
Signed-off-by: Ming Qian <ming.qian@nxp.com>
---
 drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c b/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c
index fd5a65e577f4..ec13394bdddd 100644
--- a/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c
+++ b/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c
@@ -1278,7 +1278,8 @@ static void mxc_jpeg_stop_streaming(struct vb2_queue *q)
 		v4l2_m2m_buf_done(vbuf, VB2_BUF_STATE_ERROR);
 	}
 
-	v4l2_m2m_update_stop_streaming_state(ctx->fh.m2m_ctx, q);
+	if (V4L2_TYPE_IS_OUTPUT(q->type) || !ctx->source_change)
+		v4l2_m2m_update_stop_streaming_state(ctx->fh.m2m_ctx, q);
 	if (V4L2_TYPE_IS_OUTPUT(q->type) &&
 	    v4l2_m2m_has_stopped(ctx->fh.m2m_ctx)) {
 		notify_eos(ctx);
-- 
2.36.1

