Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6229455DCD7
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:26:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244930AbiF1FWI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 01:22:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244911AbiF1FVY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 01:21:24 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2076.outbound.protection.outlook.com [40.107.22.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2CE227FD5;
        Mon, 27 Jun 2022 22:20:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i7CwC09/wS0zQnkcWHwc8WVM/y4TmzEWYdPbZkVR5ENdaIwd9txZE6jI2aBXLPLkZe/iIx5/R9a2xBPQm0dF6u5GYpPk/9uXysJNPoFPO4sx7PfpbJVsJ9qZUiOQlFbfU7K4Rk1/WRs4/t8jGOLefqGdGKMPapKEU8rt/aOqSmUwGeSU7Mws+YWG8/2SF5yED2hN07H8SPc2blxGt5+Yq7TEv3rXU0GZAI4b03SFoAOUNBFci6wlabM+/Q8Mexn40mADTEKSc1+RqBVzn0TTSWW9BkizKeAKbaUADX3OtrsOlstg5D5OU39smQ2AM7oMNfA/UValWrSFgJAEZHVIMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3bhtSvYnInp+ngcisae82Zgi+5H/C5Cft+WwbuhzBcQ=;
 b=Tjv3w8M5QMr5mVQWSeZRa/YEzrf7aGeyRH1sGkUQCltaTSi6UUy+4NHB3Z0qpoN6iiZfYcvFoQptR207HyJkxHEUIjaFJjyXlMkGUdLuQK/HnIKoI2XT4z8biVmikj6xe/eeerqbQ1rWEvevRIoNbl1b7hTswwgh433FpQgEC7TtZzURXg+0o71dL3ihdj64xlaJXnJ+SpPBav3q9+QZEJag6iet/rtYcPys4thPg7XrmiJb2F6PJ2d/rDdM+cbYbfHjvB6meMljJzLbYydKW9bYRXhTxuI37GEx4EcIQZtisdBXojrRLDchYJo81QkpeXEsacKRvuSvceW3eB3H8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3bhtSvYnInp+ngcisae82Zgi+5H/C5Cft+WwbuhzBcQ=;
 b=a+VHQ2XrED32y4Byli9t+UV2pgiycRhcwMA+0oOb25xuMxM++j/PzbxN8eiBSqRo3IbYHUiODL3OeSojJFRmKan3Vwp7pK8LyOth52l+FdE+cBzJ3ZMMuNo7a2u5rbtXPdwNu5KgDTaOA6D/UI94ScAv+7AskLqQKNj0KiAENzg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com (2603:10a6:20b:d8::14)
 by VI1PR04MB5168.eurprd04.prod.outlook.com (2603:10a6:803:56::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.18; Tue, 28 Jun
 2022 05:20:08 +0000
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::3582:eb2f:9652:d98b]) by AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::3582:eb2f:9652:d98b%5]) with mapi id 15.20.5373.018; Tue, 28 Jun 2022
 05:20:08 +0000
From:   Ming Qian <ming.qian@nxp.com>
To:     mchehab@kernel.org, hverkuil-cisco@xs4all.nl
Cc:     shawnguo@kernel.org, robh+dt@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH] media: amphion: release core lock before reset vpu core
Date:   Tue, 28 Jun 2022 13:19:52 +0800
Message-Id: <20220628051952.26952-1-ming.qian@nxp.com>
X-Mailer: git-send-email 2.36.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR03CA0102.apcprd03.prod.outlook.com
 (2603:1096:4:7c::30) To AM6PR04MB6341.eurprd04.prod.outlook.com
 (2603:10a6:20b:d8::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9abe7dc9-c75f-4bd8-862f-08da58c5ddc4
X-MS-TrafficTypeDiagnostic: VI1PR04MB5168:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zDgTbEtrqzkrtPjmPl5KwhfkSY16yGhhb5+FFHzkyoHOGv8rDElZQyVD+oxaj6A8sVagLMtWhk79nIUs945LC+OWFloQuYgtfaPx47vWMYRRgb20y7jvp9kvFbt9zJS5MBn+pjwqt2YH5+kkencM8x5alIAyzW/tjLYfEReUFaFN+lgLckTwkZrczwwdHpCHUXLK+wFUrcv+7zQno05x2D+ypEMRZ+son+MTTVJo2jmIZIWA5OTFCXNGZA59f2lTAAxYNcxX9FPrcmvzkUWLLE99akeOwUWA0mrZ/ZfWmknsk461t0ym3K4Dp+zRBoeWIfky+QQLNS8J+rSsQY7tddk9JNs9LoG+Sz1zOEUClx0V3vUQmL1GJlNKj0BpVQ9Qku97MwBezNh3HYrTABNjBWN1JAI5kRe68yK/3dP0dtYX5HwJpLsRJwJn2QpAhoesNo2NxyRofL6FDc04VD1FRZ5NedNJCTtwAKj4hteqIWH/E2hSnwoIhFVKvndgt38DjRE0lJONLbYhDt86/7cbOJAzGuJeqp4aQm6LllKyzZOeRzKexkyS5f4RVMiG6LZ05SDR+bDtw23bWxRjFrIEj6o+BDG9tL02bqrRD9qSJ9Qk0BUABftB3t8RhHrsQ/Ofu4KluGwobLiEtdFYYgimePq+o0YXV85N/xqj/pfauzisgOT0Sqfq9Rc//gmu1uIJSwqKEKeUIokbsFWuRNke0EfDB2YhW90MKdh58nIwGG6MAbQvxrPp6g7leHfksUqrjV2kZ8FEVUm0H+AS1Z096OtqG/PHlYJkug3/zmdra4o=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6341.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(136003)(346002)(39860400002)(366004)(376002)(6512007)(36756003)(26005)(83380400001)(8676002)(66476007)(66556008)(4326008)(66946007)(1076003)(2616005)(38100700002)(52116002)(316002)(86362001)(6506007)(478600001)(7416002)(38350700002)(5660300002)(6666004)(186003)(6486002)(44832011)(8936002)(41300700001)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?gvnT/OV7KJb4Kn3gvCqVJIXs5CeRYdl/kTW2kx3sgIOTpMnQ7WwehSvJZbeq?=
 =?us-ascii?Q?7RJQh+bJh0VKa/JDs40GbY83OjnhPxKbqrtRe8Rxm2vRLa7lTe6AF/bHs6+c?=
 =?us-ascii?Q?h5OilpfDmH4ggfvsi+fNyAyst3y65Mw6y85op6BdEN3g9rQAThy61MQ9jiqc?=
 =?us-ascii?Q?wRF1vz7G+HiWtlPEAfbzBxhn1N5AZ+hn5JgbdnRkzLD8uUA6I86MdmP9+hPh?=
 =?us-ascii?Q?83pqCOq2HlfkzjsMlDrxp1KSjfoiPfv+mxk6dOdl+hRMNdOoB3qTzo42+a/b?=
 =?us-ascii?Q?riORD0rd4tWICTjkGcLbwF5vb5/qhlb/LNgubFJsVZB26WWLo5SbOSEwWhz6?=
 =?us-ascii?Q?8yr+UWYESck0/NwSUHdMevao+TmV7C62un8u0jv1foqwxHRf6lPovrC2XdzA?=
 =?us-ascii?Q?UUWOJoI1HcdvXbGj3rfYuuy2co8hhl3Sy+KvSqaw8XbH64dioQpGNa8jT2N4?=
 =?us-ascii?Q?Jgw3oaFvWc0I1So1qJBjU+yg9R8YzWTKNbhsTTf50NCsqASM8K9zMxfAsJkd?=
 =?us-ascii?Q?DVSVTBdSbO80kto6MYlKdQ7zrnL4atsFo/fVB3hsU7lPMVyEzmtG4+lXs0AY?=
 =?us-ascii?Q?2rvfwq+9JitS6/lRyXYndkCtWuwgDt3psD9LvjieWw+G3r7yogrZsQ8iApFp?=
 =?us-ascii?Q?GhWgNVkZ6dHxO18Al5xgJpuOqT5MagnVJLnV13WfbsonUizFgLST1a7Lu7S2?=
 =?us-ascii?Q?Iv0RnqHX05omomYHdZj/7NjwV1suCxs01W58MElhCSefJ5jtthN4gwiQ+2ox?=
 =?us-ascii?Q?zcSrjuuWw7uH++TYwc04mPAwAzkNkKAoueRbWBco+VtJojl21BUHmEAxFRJE?=
 =?us-ascii?Q?jRNJX1ctxvmaNWLl3fetoWv5Jmke8q3GkTEKw3PA7EvEtArKgEMwpEBQkp56?=
 =?us-ascii?Q?wAIOiz8bbI4IN2OlfT60Ckag3qrgSpCrC2++2IhglHCBXX3qjv5+o5LBy3rB?=
 =?us-ascii?Q?OD2bWKM8/E/8sEvXZiZS65Tnh52E5Hjz7QWozJHhVrZX1xoR16q26xckFlEb?=
 =?us-ascii?Q?ZB0cegnxTX/dz3uTm6EuS503j6qDEaJeSuxBeHM2ueYiSI3ISUX9K7eJoDOd?=
 =?us-ascii?Q?2lOHkreGQabLODTkRW4naAtXRKC+2gWGcmZgIeShFscFyD+yOwIk87Ip5oUK?=
 =?us-ascii?Q?itQozGeQdjIzuw7fHKWSVwWmNwAMUbjEsp04MmSdyIs2Xy7OnllokMEgW9NS?=
 =?us-ascii?Q?o2wm7abD+els5S7GvMrvd5JmE8T/yVIVimx6nnJvflybpyIC+gQaAu8Atkx5?=
 =?us-ascii?Q?lsyW05JyhKbitJh+RWN/511FxR+oj1q1KUGFfS69UNV9LdCVlcNo2ws0lU0c?=
 =?us-ascii?Q?0YEYAFDx7IR5OCZIPD/0yF66sCNJJ+FFggumxgflliiVSA7QQuCDdKp/LQ+l?=
 =?us-ascii?Q?fEmXEpWMUaSvl/mqzgobzZJlsmxOsCzmhf8FUjO/ZFwSd3eJV1P0EDs91uYD?=
 =?us-ascii?Q?Vbe5Ssq+msJCEpXkqsSmgLCPH5uFUN84W4lpi7ChX8ueRZ2ajl3InJL9yNMl?=
 =?us-ascii?Q?eaHbOfRi5wcHNDUDz2FI71awX5jtrfus6cJsxTLGDOnB596jb7YvFt2RYPlF?=
 =?us-ascii?Q?umtTkMwiC1BK+Wu5VVJFnTss/3Hhswg/Ayp9ClcH?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9abe7dc9-c75f-4bd8-862f-08da58c5ddc4
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6341.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2022 05:20:08.1760
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xcZaa8GlFlUOru+QV8r4biM5TDOVy8FpqatTg1tFRoub6y9+QVCfjzu3Fb6/W2ow5X7usV/iQP2g5uiNr5riOQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5168
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In reset vpu core, driver will wait for a response event,
but if there are still some events unhandled,
they will be handled first, driver may acquire core lock for that.
So if we do reset in core lock, it may led to reset timeout.

Fixes: 9f599f351e86a ("media: amphion: add vpu core driver")
Signed-off-by: Ming Qian <ming.qian@nxp.com>
---
 drivers/media/platform/amphion/vpu_core.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/media/platform/amphion/vpu_core.c b/drivers/media/platform/amphion/vpu_core.c
index 3cca7ae2355d..73faa50d2865 100644
--- a/drivers/media/platform/amphion/vpu_core.c
+++ b/drivers/media/platform/amphion/vpu_core.c
@@ -452,8 +452,13 @@ int vpu_inst_unregister(struct vpu_inst *inst)
 	}
 	vpu_core_check_hang(core);
 	if (core->state == VPU_CORE_HANG && !core->instance_mask) {
+		int err;
+
 		dev_info(core->dev, "reset hang core\n");
-		if (!vpu_core_sw_reset(core)) {
+		mutex_unlock(&core->lock);
+		err = vpu_core_sw_reset(core);
+		mutex_lock(&core->lock);
+		if (!err) {
 			core->state = VPU_CORE_ACTIVE;
 			core->hang_mask = 0;
 		}
-- 
2.36.1

