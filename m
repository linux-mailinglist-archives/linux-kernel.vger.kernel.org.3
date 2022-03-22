Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 434344E3A91
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 09:29:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231131AbiCVIau (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 04:30:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229706AbiCVIar (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 04:30:47 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2057.outbound.protection.outlook.com [40.107.20.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3C4912AFC;
        Tue, 22 Mar 2022 01:29:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F9z+fNwYgo8/cUT/SPh4kYtfPLefwSpVQvyqfsBNUdMQu3jz3Qnh2BytDRGA5iihOce9CC5h3yqAA673E88BH5lfKNTsptJoTnf1AnoxvL//2OQawMPXTQdgVsCIzc7ZVX84lSeeQ+E6lsjw3VapDS4Ip2aC8c386SnlOtPhd3bWcVG7ymXhujVEVA8wN9CV1pM2weGqzu9cpEu7yYzHKC7WB90Rn/6g47yd1Gmzw5qLYuOWdgvXtR+2Eq+4iGkIPBfxjj1t0KFMQmFsxbU5R3LFXqAeSmHt2Tg7Nfiv74aASbdJpJe1dZ12kGsVshSrPsBLX85ZgPoa369zrHf1RQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QLC6WA3DImuiSPO9+a6qjj4UKWIrSvWqS3Yz+gn9WP8=;
 b=K5WF+eYFWIJy2gzZeqzl/26R84RJ7WYm9tfPLSyQTs9L5TgIfB+n8JLE536A8GDX/daTbwKbkr04vvZdLyH9DCd0cH+b7R0bHzoY7gz+gB7eQLRUZHjW4wfsnYarf8VPDMcgNkkBIFdbTYgNw7IKWrLq5a9t36m+62K+KUtT1F9iaWR3mKWex4czGjzyTu2a0/ziosK9C/U6b0j8HFJIqpq1jKvYf8iSmPm/mLQ+0D3wPRxNVWcL4AKrZsUFi2zXTmfclEBH7YlMeDJmrUIpq7L3NlRgowgQsM11zoDjnamsubmLdFACBjtDIdqRf+ZNualfkArwNWJBKAMPyuilGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QLC6WA3DImuiSPO9+a6qjj4UKWIrSvWqS3Yz+gn9WP8=;
 b=OWQ6Th2ZdmOhb0qR0tx5VX1XYnKykGNPGFqUnrJ7e88QBreGyusOMB/XYw9ZJhryusI3VTUFK5jUBMxnVqHj4Tnd0LGaNTq0PEIAWDO8xzOPcfWzX67lx+v+seGyX9hgDt8HgHOtK9OW1Ej3bXC8AyzmGto+U3+qVdKSYuIxpuc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com (2603:10a6:20b:d8::14)
 by AM6PR0402MB3639.eurprd04.prod.outlook.com (2603:10a6:209:19::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.22; Tue, 22 Mar
 2022 08:29:16 +0000
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::c39:69cf:c4ea:967]) by AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::c39:69cf:c4ea:967%5]) with mapi id 15.20.5081.023; Tue, 22 Mar 2022
 08:29:16 +0000
From:   Ming Qian <ming.qian@nxp.com>
To:     mchehab@kernel.org, shawnguo@kernel.org
Cc:     hverkuil-cisco@xs4all.nl, robh+dt@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, aisheng.dong@nxp.com,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH] media: amphion: ensure the buffer count is not less than min_buffer
Date:   Tue, 22 Mar 2022 16:28:59 +0800
Message-Id: <20220322082859.9834-1-ming.qian@nxp.com>
X-Mailer: git-send-email 2.33.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0039.apcprd02.prod.outlook.com
 (2603:1096:4:196::9) To AM6PR04MB6341.eurprd04.prod.outlook.com
 (2603:10a6:20b:d8::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: faee8183-0aab-458b-8379-08da0bde0d7c
X-MS-TrafficTypeDiagnostic: AM6PR0402MB3639:EE_
X-Microsoft-Antispam-PRVS: <AM6PR0402MB36393B29CCBFDCB8ADFEC8F4E7179@AM6PR0402MB3639.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UPIKnYxAjExUWICTMInxAFPxYxwF2OO2Nq9JA4x66c7q+8/78IdliAePF8sAa1DxJ2q2/wOtZAt1pZ+XSbo1tX4TcHZrLk9adAoj5UKE6qCSTw/ihWrkDqeI+qinNJJNGmwn5acUkDnuz8h/rfiDOHpmZOAgdVLPVKvHtmBEyH6qTgsdk1AIhiAtv8Lho52C4Rv6E/80/tCAikxKxOd5HaLB2ZeIdpq3rKVb9Oz5yHKqLl0LMmePFy0xInOGB8dvm2nw7xPUiPvJk6G5Q8zozXfg2mKafEdUKZAfv4w+8EYpd3/rBpHAJRkXj9ooUMrbjOGlX/feW9iSO8m8VJu9ONYeYk0MB+pFGgt59t7iQdbMWe48AYg5ivVF9imbig+KobDK7qXdzf7sdtspZm8xhpdxb+xHcSd1kxE1ra565tccLjTUk8BYjP2DJCUZAo7l3UBy8M75jwGufbdfuedodvmLuN0rqo1EOy0prDxwC4CMtXa3OBP3hSs3yR3IAWYSRao4De7n64tcP8B/KSpkQuHTZ/hUP3qIL+DxJBfxv+mIQ7BdAkHGJkTCHZJ1WFnaRyH2LqZJyAapnyf58CGJ4cX31PZBFLPelRJEHYLVLPXk1mv+fkQmCs32U+VpUBg2m62hvw7vlyHm3GK9vOV0kx3r2dH36ke0TpRMW+f7aRnJRHy0Q65K2VRUSJsOVqRKzTUgN+tBaXcb9R6NFGtlXg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6341.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(8676002)(5660300002)(7416002)(2616005)(6666004)(508600001)(86362001)(8936002)(6486002)(4326008)(66556008)(66946007)(66476007)(186003)(26005)(38100700002)(38350700002)(2906002)(6512007)(52116002)(6506007)(44832011)(4744005)(36756003)(1076003)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?wKWXPfYOM/UxF8ycWekbziks3bCfAu8TRF9aPHdrjJ/a+tjzptt4YLckVDRG?=
 =?us-ascii?Q?T8+JQIrrPHDoMSefIfpbxJbS4w48kDIhKlcKvAqySUD11mbOSQLVpFR9mqGo?=
 =?us-ascii?Q?9z23Gc4HG4GTulgAKbXAqCfv2c1cMp7NHM8PudNXTkeL3Z0fJO1to/4ZYCx3?=
 =?us-ascii?Q?Uj/xEbrdPJWSxWD4Y87oohciLtZgp5MyXDY65wyCf5zD3RdvI+f177N5CTxZ?=
 =?us-ascii?Q?Jd7Fq7K7hb78IQieqMQTpphJwdZBrbMji33jAxL3QafIeFqXbWv3unZWyF3H?=
 =?us-ascii?Q?krDiQn+/CBvurBEb/aQim9XV/tST9FiMtyUF9cZl7V+UiXBgIsHroXhrl6LW?=
 =?us-ascii?Q?uzBqiLU2R7OiUlm/eb+mgKOEPupC6Kwc4VA/DtItJmxZudbBeAyJ3rc/iv6C?=
 =?us-ascii?Q?3EjkCzkysNKvXkn2xupLZxbWgHr7k3DsCiDUWteQDYxZD3CgOdQzS6DcNYXQ?=
 =?us-ascii?Q?mGCvuUD7Hk+Mzz9T+YAi4nEi1GP4N9PE9xr2+jLREsFNN/bxivaubeYicnA+?=
 =?us-ascii?Q?DBu4C2mvex0OTk9zxGBGX0iY76t+LyS1eTuIhkebM3NHtgvo/MPgTzIpk85n?=
 =?us-ascii?Q?S70RuRzBAc0jXcjqqk44GB3NWOpJuxw6W+Ylge/uN4O7qbR1r41Su6fOsDry?=
 =?us-ascii?Q?ZgXBM/HHyMBJRwUp2864GISLION91FuB5oqqnQ3/TDpS1+agtkX8ZFIrkpz+?=
 =?us-ascii?Q?yB2skKGkKVs4gjYc9SuyRWGMtTAd27QXU3rwm6wT8IdqFQiU00jWATwkVKUP?=
 =?us-ascii?Q?4Tqv+uSjZH9fnO+uuG1curAz6oU9IuejqaBEAmEBw7n6ojf1iTXg/2rcgMHG?=
 =?us-ascii?Q?4aFatdGzwGTDK4JDWwha9pCHN9AAcmFFLZHJVlzFwsgRTlpdKhpZuM+fmcus?=
 =?us-ascii?Q?B29IoZc0No1IHGOBg+FhfcmfIlVnHGn7KuJpzUx8cOp0kKsXD5uEbV//cKPD?=
 =?us-ascii?Q?VoDQ11aIQ3QSShp0e1Ll7L/B7CW9+JTBB+7p99nbM14Vxan+h01MSS7JO+EV?=
 =?us-ascii?Q?EjnKihTyZczj2CjMslHvYTQbsI6gkbAQTrURCWIfhGXpKOWVCxg0Sx9hmzW1?=
 =?us-ascii?Q?T5ttrxNzxPZCrueujwlTEt0XopySPI8Vvfzf+mbG+oPIlM3s/IPChfE3Bw/B?=
 =?us-ascii?Q?K2qQUL/wbKlru5O7pk45s2eTVNPlqGor28GgdY+AXPB5SpkQJkUMSS+hpauO?=
 =?us-ascii?Q?jGmIcFpvDIfG90EKQLfSlDBnc+ec2Ao0yq5Bia6kOHXfjj5DF2OD2oRE+al4?=
 =?us-ascii?Q?ZznxO0G7urYD0nzMEyESa8ugQiwOCJqnQXNIVFyncOjv54UKHgkrLnrqABaQ?=
 =?us-ascii?Q?WERORks6qGdp7wFEb2wLc3io/+uTWgh0K804tTA7UQfgbf4zlhweg7cIcCyV?=
 =?us-ascii?Q?IFTQZvgQU0b8t1+TQXp0s8jlnNVebLRyIrU6RE8s8Y35KFuQu6mWosuFG3Bn?=
 =?us-ascii?Q?FJFu8tpa+T8LLvm4zkn0wt5J09cABFn/?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: faee8183-0aab-458b-8379-08da0bde0d7c
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6341.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Mar 2022 08:29:16.6224
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MIEH4rKEG4aJYYkEaY/SQ0YJPhjjwz81aFwrsrmMw57PP1179TvNMMtH1aPiXW7fLcpdFjqlf6MgfJ5sZdO53A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR0402MB3639
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

the output buffer count should >= min_buffer_out
the capture buffer count should >= min_buffer_cap

Signed-off-by: Ming Qian <ming.qian@nxp.com>
---
 drivers/media/platform/amphion/vpu_v4l2.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/media/platform/amphion/vpu_v4l2.c b/drivers/media/platform/amphion/vpu_v4l2.c
index cbf3315605a9..72a0544f4da3 100644
--- a/drivers/media/platform/amphion/vpu_v4l2.c
+++ b/drivers/media/platform/amphion/vpu_v4l2.c
@@ -355,6 +355,10 @@ static int vpu_vb2_queue_setup(struct vb2_queue *vq,
 		return 0;
 	}
 
+	if (V4L2_TYPE_IS_OUTPUT(vq->type))
+		*buf_count = max_t(unsigned int, *buf_count, inst->min_buffer_out);
+	else
+		*buf_count = max_t(unsigned int, *buf_count, inst->min_buffer_cap);
 	*plane_count = cur_fmt->num_planes;
 	for (i = 0; i < cur_fmt->num_planes; i++)
 		psize[i] = cur_fmt->sizeimage[i];
-- 
2.33.0

