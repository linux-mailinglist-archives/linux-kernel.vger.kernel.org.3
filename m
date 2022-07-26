Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA2AD5809BB
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 05:02:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237374AbiGZDCv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 23:02:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231151AbiGZDCs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 23:02:48 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2055.outbound.protection.outlook.com [40.107.20.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AC74237EF;
        Mon, 25 Jul 2022 20:02:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XM+J7fn2ts0z8oHf9qXlnhOgwCi76TZ2QAE1IbO7es/in/la+zwCT8VFxLuyKw3CWqIazfITwrppLrPmyXDmqR1ba15NoPgGhApl3/qrfuxeJJyA6VXX4CbpKZZDOczK32G55d0rxLBoReoSMlGPyEB96t4vaKAYiaywpWs69V4uE85LZDS5Bc/Cx2UeC0WdQCAL48kpNxrp6MQK4U42Kcc+VKiKJyK5o3B3POcp+dvcpvfnFO+zuZTxQXt+GLOhYr9Yms5sfw+W9KVPKHQzYQyu53pTNQ1wdJU2IIXmF9ViKWIu+4dbKx1tUODONb1Z8s8QPS1v024M/8NpFNpvZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GuqCN+bO9wqFCnqBStPQZKMFVBt9uNDeRqK1qGw0Yw8=;
 b=NUjP2EKIsBP7t7JJlviIM4RwpG8AdORSEdhx9ZSme0NyOoraU0neGTwj7ohoX6yRntwcX2svl8gI7f+iYjaqMFLK9RuKF8vHbniX1CzZtCfOsibEe3ceCCE4ddMuIwJF0ogGnkxDfxoZZMtGbO2o0i2vurk1APlzFuQlK1q/98rPtrQ8A7qfqY4keJsQxMaKM53AzRM6lAHMpailVTODRz1DV7j+Rgm80S4Byn2WMjZHPzccNARSUt+uxPqlsSTOT7l1o4wpx2oMGnuEN3mGtuf1/lv4rk2MW9FKu1WrE5hbbShXwcGbtyORwW/ceFRLrRQLpvDdeX2lkdueKQzyEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GuqCN+bO9wqFCnqBStPQZKMFVBt9uNDeRqK1qGw0Yw8=;
 b=bNLACiN8O4mhICaA7DXJGkwsf/oCp+DwTAM0r0VGxCMi79musXKlG+tWuQSwBrT48c9wP/bcEjIjPxjvxX+c2JpkUiuWYUY/XVj6i3Ik6iMwt7FmlMEw1QI/HI18UfUX2WG2E8piox3n0V71DXhcU6ovs0s1WTCzGrwRWDFDmKA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com (2603:10a6:20b:d8::14)
 by DU0PR04MB9370.eurprd04.prod.outlook.com (2603:10a6:10:359::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.24; Tue, 26 Jul
 2022 03:02:45 +0000
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::5db6:3f08:2e04:33c]) by AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::5db6:3f08:2e04:33c%4]) with mapi id 15.20.5438.023; Tue, 26 Jul 2022
 03:02:45 +0000
From:   Ming Qian <ming.qian@nxp.com>
To:     mchehab@kernel.org, hverkuil-cisco@xs4all.nl
Cc:     shawnguo@kernel.org, robh+dt@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH] media: amphion: don't change the colorspace reported by decoder.
Date:   Tue, 26 Jul 2022 11:02:29 +0800
Message-Id: <20220726030229.31419-1-ming.qian@nxp.com>
X-Mailer: git-send-email 2.36.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0039.apcprd02.prod.outlook.com
 (2603:1096:4:196::9) To AM6PR04MB6341.eurprd04.prod.outlook.com
 (2603:10a6:20b:d8::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c7395e43-a515-4d15-16c0-08da6eb3500c
X-MS-TrafficTypeDiagnostic: DU0PR04MB9370:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pDS252xQnColTKLg4MBkgnmupG8wZe2vOn/hivPr+rTxBQ+m3XzOyDYFaXgAwSUmAUCuesg3NWrDINxqu6VguwlUJdQSUE60lcqgMNwvJyxDOA4wWv4gu6wvaBigNKP9WQarj8nFnKCU3wrJY8yuQE8Mdu4Wk4UQjKVuGQFg63L7m7LfuVY8VVVkLzHiuyaNNekHbtQ6e00V1t42xVK2wBJi4YJgR7ZtHQpzgQKFhlXlacA/1OU0zLxus7KZwGm6HAPBkRTPhjRQpIa3iCbIVS75vTE4g1NU2SdeCCzY3Y8ZANQnHwFHS8S9yetBHkkDMHZ25j7WI1iWkhwa7ntZJVPXi6bzOW/zB01FOgUxUTADT9kRpR5u637TXUur1t/lq7tbfytPABM9XA++J7dKmhpAA8zAYtdnG18eL8/axbQ48gMiS0wOUDi0KFGVVRyeGCagUtV57DHHuR/6YBjfdOhSZmWGZ/GOwP8NjzWUawLsxmQpJKs39ilFAP6iuV/LT4dxb69EPq6/+hj3oLDVYzmoxhOJizjqFyhYifkU2qzkVxvoWLDzB7Yk3dIAK/yxRRRBzCWkeYwhIRmChWDk8pi0+cJDesw/KceADrMOIBVbf8TQHG7Vu8jhToxQjq9GeuUmUuJ1vRsD4Lc5ZoB7SC8JLal26oJDpWBMUOBL1DqbRgb7eTgXCeH3wuK6IV5dI3gbVyHbAJl6tcd7HGsI5mzgNm4DBBEi6uRvj7BvfQNPLp4+jb/io4RHV138myS2YJuYYHrTUXpbu86kOUlbjvfHzWwlgZH2c2/At0XM4oo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6341.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(396003)(376002)(366004)(346002)(136003)(38100700002)(478600001)(1076003)(38350700002)(186003)(66946007)(4326008)(8676002)(316002)(66556008)(36756003)(66476007)(6486002)(6506007)(2906002)(41300700001)(7416002)(6666004)(86362001)(6512007)(26005)(44832011)(8936002)(2616005)(5660300002)(83380400001)(52116002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?pq3UNeMzJbR6OJKTuLPAodOcZevMix1/sw6qF7yTis+tFImenfN5EOR2cm0U?=
 =?us-ascii?Q?9gKrcyweCe4AC9dkf7lKFxDAa1KST6SNBQkEJM1a6392TorUlf/a2yF9rlDO?=
 =?us-ascii?Q?yLLF4gYiJB7iFJdlpGgT0C/rD+PHwnsLt9SHtm3UC+ctknTtT0ZE8X5g749X?=
 =?us-ascii?Q?EfxhcnI3GaGHG8/iUJDlR9JmNvBjsri8aqiKL7w/nz9EwLZD8IgeaGJDK8OE?=
 =?us-ascii?Q?OXRhm5QoFa0P6m+p3yAJ2dyQQR0S9VdrqWPLX74F1S5/k1gPDcK1psvK6OtM?=
 =?us-ascii?Q?0KcHQC4SDDyGaYpfHscbfOs+zvkAZsMLKHwuhXtVg+zVfGJpdTjdpzquz/o3?=
 =?us-ascii?Q?KCV5+Shb5UbqwQdolK35Vjxlh/G0BEqmBzHBg6k+Ixs1zsNXtAncKUKmdFOg?=
 =?us-ascii?Q?wDzOeMUtWUB9kB59UmPmTu88DbRzkfitBuOxTUu9WbOSL9qh2zUZPon2nXow?=
 =?us-ascii?Q?dtweD//BHnIMVxuDaD69lXGELuHdX6zhnrnY0Yn0zqJBgTlpax9aMlWlQRpT?=
 =?us-ascii?Q?ZuaeidNhwQWLrTVYmzLXZZH0qG/Pcm8QtDbLAgIvpfIeljhJt6GFCU/3pW8P?=
 =?us-ascii?Q?SYMVggyL1kHb9djx3p1ChCfqPbY0w4/hSc6ixECsS04/Z7NmlAYQ0xWAiFOT?=
 =?us-ascii?Q?2TQNsg/446Yp2BD0rrh15ejzj3SosdoIgxqxMrH8uYZg0HoagVtXoFsavfO2?=
 =?us-ascii?Q?01SKo0Ma7/bM3N0XPFLtCfbbVVW7IODltlRzIUhvCtjKlB3ruhy0ParM12IY?=
 =?us-ascii?Q?y5yIGELbqaQoBfVW/Kr/F9pZveNkfjx85CAnkLeZthkF/GY+IzHDLfz0TT/1?=
 =?us-ascii?Q?Io0QL8dWE2uJb+ZcwsbzOMQUBcx0LB4F2E/eIT+BV9yfd7f9NCEZeeI2ETxv?=
 =?us-ascii?Q?bJn3ZpMwHQgymd5AUQTi7yGY5briflgb2/JQNxOaGh1D8JtGUT94V6PkwwxY?=
 =?us-ascii?Q?bhBk0Z9T73Uqqf2cWsSPypchrIX5Y8rYx1ZODpSmRAvOcfqdopS2LJ8efSA4?=
 =?us-ascii?Q?YttuFb4BAUepVECe22sr7Vh4X5XGpPDyqoyq3P8utXVfhtB9khOO86/9HD+x?=
 =?us-ascii?Q?iK1ElAQVNyRqW+nVvseT7QwTCkhpOrbJmFfQt2I1EU0MxE2fswObpJqmmIqM?=
 =?us-ascii?Q?uyqyY1cQxJHrp5iex9ICy/SNxssl/s8jekshAFTPbspymp4yAqe8KKINqe7d?=
 =?us-ascii?Q?RB2PsQGxYQL/2pSe0ietG5cb31XQSKtJWvUFqMrps8Tb3cCukCLf/qo/EZvV?=
 =?us-ascii?Q?dkH/tO4SUyQ8LuL+wdC4dl5aLnpRUIeNL5d1w6gY3l0qsfxUDTjNYy4sGzID?=
 =?us-ascii?Q?uxAPPbKPaMw4gMVBPWDzpDWcW5VXeKYQ5aMYZASjykCtdehF0L2geG4b5nEK?=
 =?us-ascii?Q?iLBpt/fSwjmjtJSg/Kd8uWOzE3k18Ul08l1AG5BynaIuGGVIyQm1kpao728A?=
 =?us-ascii?Q?2+Pp0hKSDAX8g3kbY3D5ShFO5s9NFymHIu3Xc1YG4pUa3CMoMRg/NZnJgNJ6?=
 =?us-ascii?Q?YNiIbPHcXv0wx2htMo+wNgkzyB8OjhSg80U3KG7dqxnxt0Y22rduSBtnuFca?=
 =?us-ascii?Q?CoOI02DASOV2epGFQ2LeP9yydKVRYJBPyu/VJa4z?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7395e43-a515-4d15-16c0-08da6eb3500c
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6341.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2022 03:02:45.0329
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iLavOTnkwDJMIbjJJ3EMC0wQXYGFHWt+DhWJPM+H0GVSGsqqXJ/3eDCQ6jbHCKVBK88YXcTGKJiLbeCxvNZdaQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9370
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

decoder will report the colorspace information
which is parsed from the sequence header,
if they are unspecified, just let application to determine it,
don't change it in driver.

Fixes: 6de8d628df6ef ("media: amphion: add v4l2 m2m vpu decoder stateful driver")
Signed-off-by: Ming Qian <ming.qian@nxp.com>
---
 drivers/media/platform/amphion/vdec.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/media/platform/amphion/vdec.c b/drivers/media/platform/amphion/vdec.c
index 9e64041cc1c1..feb75dc204de 100644
--- a/drivers/media/platform/amphion/vdec.c
+++ b/drivers/media/platform/amphion/vdec.c
@@ -808,14 +808,6 @@ static void vdec_init_fmt(struct vpu_inst *inst)
 		inst->cap_format.field = V4L2_FIELD_NONE;
 	else
 		inst->cap_format.field = V4L2_FIELD_SEQ_TB;
-	if (vdec->codec_info.color_primaries == V4L2_COLORSPACE_DEFAULT)
-		vdec->codec_info.color_primaries = V4L2_COLORSPACE_REC709;
-	if (vdec->codec_info.transfer_chars == V4L2_XFER_FUNC_DEFAULT)
-		vdec->codec_info.transfer_chars = V4L2_XFER_FUNC_709;
-	if (vdec->codec_info.matrix_coeffs == V4L2_YCBCR_ENC_DEFAULT)
-		vdec->codec_info.matrix_coeffs = V4L2_YCBCR_ENC_709;
-	if (vdec->codec_info.full_range == V4L2_QUANTIZATION_DEFAULT)
-		vdec->codec_info.full_range = V4L2_QUANTIZATION_LIM_RANGE;
 }
 
 static void vdec_init_crop(struct vpu_inst *inst)
@@ -1555,6 +1547,14 @@ static int vdec_get_debug_info(struct vpu_inst *inst, char *str, u32 size, u32 i
 				vdec->codec_info.frame_rate.numerator,
 				vdec->codec_info.frame_rate.denominator);
 		break;
+	case 9:
+		num = scnprintf(str, size, "colorspace: %d, %d, %d, %d (%d)\n",
+				vdec->codec_info.color_primaries,
+				vdec->codec_info.transfer_chars,
+				vdec->codec_info.matrix_coeffs,
+				vdec->codec_info.full_range,
+				vdec->codec_info.vui_present);
+		break;
 	default:
 		break;
 	}
-- 
2.36.1

