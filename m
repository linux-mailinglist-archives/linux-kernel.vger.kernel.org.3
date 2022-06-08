Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C447C542B5E
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 11:21:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234516AbiFHJV0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 05:21:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235362AbiFHJTV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 05:19:21 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-eopbgr70050.outbound.protection.outlook.com [40.107.7.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC50325BC08;
        Wed,  8 Jun 2022 01:42:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LnUiopSb4MG9xPg+Sf63ez6urxM59jaxjHnyBh7UsyuXUGacFcU9lvbp1W6HQQe+on8l9Ct02W65eDKJ4pqe7q1jCAwOybAsJyGcmqZI1JWfsUZ2pC/T3mIaUmW1BqsJsgZUuh2uCoYBmMEzRPyY6YxvTWrVkxKDEUTM31/ytfTxMAjL8aKulgs3T2EBjarh7NBwva8tSnR89jMLT32HwEAbfzCOTMVFhE9jxSplUEMCXU8h/oRAHhvj7fqkFOunkx0skcLc8j9SEh0dZ5CRGvAImpqyMzubxgvyRqvCssSAX/ndmVfl1dddehk51ZiQPRneUSCB6+afnGV3UDCPwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WnjUaKZ1geFV/gFOxTjAsxUJdZJfCybrS2o+Dffdpzo=;
 b=YaNRhwUIMwfM+H6U2/L/bRtvs1F7D/nzUhdMR9VSw2hFc8xI3xXlXnKWmphuqfn1MiBLUAmkJhxPfEwpv+/sLWBa9R9+2IbmoR+A2CF64ZqV9Pcm8u17KVPEpduJ0kPwf//tT/zU1Ksr2dZXr4+zZyLtUwz3T8+YSXJgfo/V5iIw3KEstGV5d52NlRsut/q5fuMNIi5Jei6HaHjoaEeE0W2904S6fRVRE/DVuUXZpNTAcn8qVr8To9hcyjw8w43r5lXRRBvhkxyXTAEogdWiUWA/Olxb9R0ujRafmDVr2buzL1GwowhYpAErFXwLqrpV56Meb8f15XiIavrjsTks6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WnjUaKZ1geFV/gFOxTjAsxUJdZJfCybrS2o+Dffdpzo=;
 b=S696UaW90x+Q7oWL+uEnnzcdU+wl6ko1cZorx99zahtudjVeC6bD2aSyto/dJrmxbfy9ZIHog/Y5igmDWb308hdo2wJoQFfnZLv9hJYWncTaee0Er7P9KVFwL6nkavTHbQgJkDneNId2DOrc3L/GMsRvHrP8K32hIN3k2IIchK8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com (2603:10a6:20b:d8::14)
 by DB7PR04MB4860.eurprd04.prod.outlook.com (2603:10a6:10:14::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.19; Wed, 8 Jun
 2022 08:42:29 +0000
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::bc48:7565:c619:62c3]) by AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::bc48:7565:c619:62c3%7]) with mapi id 15.20.5314.019; Wed, 8 Jun 2022
 08:42:28 +0000
From:   Ming Qian <ming.qian@nxp.com>
To:     mchehab@kernel.org, hverkuil-cisco@xs4all.nl
Cc:     shawnguo@kernel.org, robh+dt@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v3] media: amphion: return error if format is unsupported by vpu
Date:   Wed,  8 Jun 2022 16:42:11 +0800
Message-Id: <20220608084211.24369-1-ming.qian@nxp.com>
X-Mailer: git-send-email 2.36.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0023.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::17) To AM6PR04MB6341.eurprd04.prod.outlook.com
 (2603:10a6:20b:d8::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 53151127-1514-43ef-ebbb-08da492ad1f5
X-MS-TrafficTypeDiagnostic: DB7PR04MB4860:EE_
X-Microsoft-Antispam-PRVS: <DB7PR04MB48606265F5BB993FB5A57086E7A49@DB7PR04MB4860.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9+NnX6Jzl0XvcEX0am+QXBxWwT4qYdb8J5Z8vwMkkmDw9xyH5Z7Z1pfOGlCHStto7WdwFot8LvDgbjwKjKc9uu+zWfBqD23Vkrvr7wZ7hr5J0UiqQNuP7soDHNrSuu43vyho03ddcvAee3qkDUppPEaB8dYH5Cdp7DtjSPO4QF0X2ZlgHpOPNWMvFktozyjkcrriaWkk5YcW1S4AAnXVNFy6e3XNUVRGOQ0WFBV3blUXGIGHne7yoShg36ISDVElIEZTQeLZdgZY4qXhqyMyZv2Hdl+13rgYGliP3Go4I5haM2ZQ0nvHFAJeTumOyLPxY+ya3ZFLoFhfRnyog6FsozXhGREaUnFmtD5hC+73FXTR2JiwgS8ifQTqU9csUbl0xDqVFqvRhI5jEBxA4onRuER+oXoQXAxYkoQaSFW8cbONh3s9vIdYmPAb0VvX4mxyNW8R8GYgO1svnjj64y+JIVsmfAmPGKCmQ/Sn//lc7Kb0wBLrfkiQD93PvB8wMiaxaiPIDf8PoIy9QPzBjpm0Vw+nIzngQrApEpXna6MDc+xKNgN0liQO7u4ZIZo72btPrm/fXu/JoIs9mKdPb1Vqw5RZmcyq9PfxRPsFz0pH6ghOUbyC0SjhFsyDSBHNExRitcxdeo5M+AxuHr0A4e+SXve6+00pC+AwxBnQte/auSGlLSkXxqgOSYH3CmclAwtHk59oythJLTSvmV+ug2+xEw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6341.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6666004)(66476007)(38350700002)(36756003)(66946007)(2616005)(38100700002)(26005)(5660300002)(6512007)(86362001)(52116002)(8676002)(4326008)(7416002)(66556008)(186003)(6506007)(316002)(44832011)(8936002)(508600001)(83380400001)(6486002)(2906002)(1076003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?kcGTVmjthDxmP/uLfc+cH8VccrQo0+Eh48HKe9xihrCIeqCwCAGYOC+FqyK1?=
 =?us-ascii?Q?ziFG7T5zElu0SYrB8bM5QoSGjQB+N9x8IoQvErPIh70WMgkwY3uNaSL51Mpe?=
 =?us-ascii?Q?ahm8Kp3gNOsoaaFvzAiqv9nqKdWLb9A6VLYKV5kTzK7w0Y8oPwGfGeqgjiRz?=
 =?us-ascii?Q?GmQ4mC8yQCEJmE+L0U9vmdQYfHy9WbdDBV1GRGN0LelCZh4biGX1buKErw73?=
 =?us-ascii?Q?MvVMAKSmQzcl6+Q0a8tkuGBb3idSbMQujySSl4Y6wigFFqvOFwa6pio1a2dk?=
 =?us-ascii?Q?J6YmEpp9e/lfPU4b6mnGKU4XNl8mo2PEs99p6r07kvFdXp/oYFiZYKbiAK+1?=
 =?us-ascii?Q?ER8OpPiIi9YU1qhDmLqv+C4pvfHvNRqmFOMz6z6QrZrCcJs6yleg9CzoxjvG?=
 =?us-ascii?Q?a5qI3Ox6tZMrNPc++oQCsLYNSuQP8qplsUayk413M4xnnpY6Y2jNsSx+Ad0k?=
 =?us-ascii?Q?i9xokOcvJPIRCX9yjc78djMVMcv6U/uX9uXIct7gBKcnDjEAeXALpWrfIi/j?=
 =?us-ascii?Q?zwAsh0OdUn6pXgRd5PGqkdRCI8A07QsRPXeuRwATpg1zi62VmCDOIyovWu57?=
 =?us-ascii?Q?vwXS0/A/gPNPzHw24W75hnkyWUoVEUcmqOhrreEsbugJfC0nd+LSmOTFn+Qd?=
 =?us-ascii?Q?lxtH14TMv7x0HuhbM1YACCXOMhQz36iB3FfEKdQZdgjEsACT+/gcU/8sE530?=
 =?us-ascii?Q?aTkvH6nDonjnVmGyH7hGfotYbDyxlsEFuTjoWvfMfHUtZ3vj4gOjqv+wvm6v?=
 =?us-ascii?Q?oC1FMCrbqkpsVb8jBURSR8oR5affR8OVQgHtx4MDf2J8Q8DpU9XZdVdcnIUL?=
 =?us-ascii?Q?kt6UMivTcNLoE1zNPQXBzKRYMFRfFEtBJxtv23WnPfLbspORxKuJNkChBma7?=
 =?us-ascii?Q?5lcmL0+4Pz4BdjqFR0fxLdQpzWVbuT1kcuueFmbvvD4aY+qvDY6FTTl7JVNf?=
 =?us-ascii?Q?WdHmqRyVJcUtpO2FVGExJTeo4NpF65e/XWQjCqd+f4t9hVNfW9xD5YCWytC0?=
 =?us-ascii?Q?LMdY554yLg69qfte80lY4kMbPGEFr/1SEFhHDVKno+xHwkybgDk6rA6Gq8MW?=
 =?us-ascii?Q?qRLZOqnf3X1mtLtr8d6rbvGl+uZ3SAS6QNjQElvV6ccd9+GFoe4KYNG/jpoD?=
 =?us-ascii?Q?906m3Im1YpKajjMlyjU9JgULWmDytOh72lrzZCydmZLehH4aGbypKB1a56oU?=
 =?us-ascii?Q?WLAi6TzV6TynOTlL27CdR//Fz2rLaKdfmlmW6I/QDh2UjAj2AwP/kr6W7Rq4?=
 =?us-ascii?Q?7V4Fd1sMEseATd13RCbPkNNurX9qFVAiqjyj3dxv1AVnayzQ82QGjCs9geAv?=
 =?us-ascii?Q?bPeUCQVHaycMEPDhUtRJa7VuJ90qm8b09vm0appK+DzlhK4zLvKRQ7N8LQc3?=
 =?us-ascii?Q?2y/+C8sWxQpTONwgeQwNS6KRTBS1XMHt31HJt1WRaUwbtKrg0cx0IX56Z33Z?=
 =?us-ascii?Q?91MrWZy2PlamVfaLpzfzdT6e2WYcs8n9kR5DvOXx9Ytedc7yqKwinxRWbNkT?=
 =?us-ascii?Q?S/JCwgnenptsQYx1n6RwsjQ7hb4b33iJhwXtLl94cez0iVob0RurLzu8xRTo?=
 =?us-ascii?Q?7vMVcvWUSS63pJ6Dor3XSA5f4zVjwWh2rw0Jige4p7MUCC0wLy+3zoacoRj1?=
 =?us-ascii?Q?1uupOvlpK47tIAgk8nKADqiXNnX+qE0iZlNls5VZP+xl0agyLrJxtLt7UlDZ?=
 =?us-ascii?Q?b/U4NlRHTIDwxBFVUDxUhjK9DVWqJD3qfyWi0cwFLcuXNvFCbXnnAzFJmh2u?=
 =?us-ascii?Q?G4+Jr4wz5w=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 53151127-1514-43ef-ebbb-08da492ad1f5
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6341.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2022 08:42:28.9011
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3M/lFXRiWWfHAOwAc+5SWCX6soRLK9YzSWzpnDfBQpp0x0RaELx87/wD6xZlPr7nvgUjt3bLINWjGQsgjsxzDA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB4860
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

Fixes: 3cd084519c6f9 ("media: amphion: add vpu v4l2 m2m support")
Signed-off-by: Ming Qian <ming.qian@nxp.com>
---
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
index 446f07d09d0b..70980cb4e803 100644
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
+		vpu_vb2_buffers_return(inst, q->type, VB2_BUF_STATE_ERROR);
 
-	return 0;
+	return ret;
 }
 
 static void vpu_vb2_stop_streaming(struct vb2_queue *q)
-- 
2.36.1

