Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 678724D5CB9
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 08:52:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347139AbiCKHxh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 02:53:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346780AbiCKHxc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 02:53:32 -0500
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2087.outbound.protection.outlook.com [40.107.22.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA2BC13DD4;
        Thu, 10 Mar 2022 23:52:26 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O50dgFTW0pUvVPOpWr1N7PjjnR2TFmkYu0NEIlU9qmDwCS6I/GYrYRyLiOFDif++jDPd2lUiHsF1T7KSc3vo0YRvs6Olu3btef6taHpMIeVSdh0rhX23FPrShUYYvEepKsxAgcs0ocn8PRRDW4SLl6pZIeqSxPJOpDxf5YqSgAAO5drFGQNjK8LGXtkScCkhH9tcKUgptr4PD52bcJCB+zAIXf6vItXoltKeQbrZYRU40cu7jWxVxiv02G/esG33Lr3lXSbfhJiMft0FfHtwUhPdpek4RBRgL1HK47w9Jw4GqurvXkqVQnnXSFgafOgdm7vbmwumJR9Jj7laIGJRRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/lawJqNZ6hdwDYs9c7BvLscNDPHGUczrKIhcGXLn5cI=;
 b=JHVIaZevdrE9XBSRcYtYOm0WudtocTxBH6QG6kqqddG/VSfyeXPCJ55MXCbEIEPS4vGv+nYSBqAcrc5njlNgYth5vD9eST1l3dpC+9ES3Do/33bZwx7qKVRR2m4l9i9He5nZQORF2zHFeJYgPJsU5s5sv8m8ygml2VEBHAGEx4gStyHs2ZmdGwLHTR8zLjncrysroDLvyjGYc3QuTaWevUku8sXOqpcC0fJGh5cAWaopwNRf3KEimcz1piq2Zw2kDnclAulrMmScNw8zN1mEcyOSUHzbG4dJEPx0kJlhhvVN3cKcleNm4uv1CvqQ/R/SeI1bcZwPUzWSc09kaY8z2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/lawJqNZ6hdwDYs9c7BvLscNDPHGUczrKIhcGXLn5cI=;
 b=mQ/I+N3mt8vfiF2uLF0KS8eKgnuHQxbrVLg4PXZ9PLF4tVUi7y/ktE9mIcX91gId62mMyEhGVyBUxb1/EE2/6lmD1ZIGrDO2CdoHFfjeFoAMjmLmEwI00bHrpS+G5RfdGwMrAA6ERohBSG+Pgcqr3/XvA0Yrgezw8TrCBhbngvY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com (2603:10a6:20b:d8::14)
 by DB7PR04MB4443.eurprd04.prod.outlook.com (2603:10a6:5:32::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Fri, 11 Mar
 2022 07:52:24 +0000
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::c39:69cf:c4ea:967]) by AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::c39:69cf:c4ea:967%5]) with mapi id 15.20.5061.022; Fri, 11 Mar 2022
 07:52:24 +0000
From:   Ming Qian <ming.qian@nxp.com>
To:     mchehab@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        mirela.rabulea@oss.nxp.com
Cc:     hverkuil-cisco@xs4all.nl, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 0/5] imx-jpeg: Support dynamic resolution change
Date:   Fri, 11 Mar 2022 15:51:42 +0800
Message-Id: <cover.1646983646.git.ming.qian@nxp.com>
X-Mailer: git-send-email 2.33.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SGXP274CA0015.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::27)
 To AM6PR04MB6341.eurprd04.prod.outlook.com (2603:10a6:20b:d8::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e67075cb-7ab7-429a-a68a-08da0334140b
X-MS-TrafficTypeDiagnostic: DB7PR04MB4443:EE_
X-Microsoft-Antispam-PRVS: <DB7PR04MB4443DDDBD6DC5D913775B304E70C9@DB7PR04MB4443.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: he3yYK0gWvH0s0acYHtvM+vSrDI7U4HM//i48SGUx7eAIracn7INaMXMI2xyZ7JIgw8eLJuh+nvg0daPL5XVe0iMViipIKQsGohtZ/+X8uRCYbnxBm2/FC88kUMVlUl1JMzP2/tHzqqmQex7r75eH73IY973VrK4Atxr89xmj++kFcCg04NwvnbZlRVy5MKxwAeovxOFE6qeEpPPZ65aDf1pLRZs8sk+Ky6fFjpZ+leedp95W+VHvMR6yKOAMXyGddvq53EYvxvPl51IdriMHNEAcZ2IW0z1vtjI6PJlwLYwEGvJ8UIuJ6aqfL3ZAS92RBHIbL5xdIcdpsdAaX9XkHMIyrjx89Hrl08I/QaQ+LAs8jFe/Q3myabOakzhFbMhJJ7YMirjnTeg0OigotPiRNHt6GnbLtZnpjHxjHbi33KrMvDxClRrEerX6dGcYdYGrkZ/oD35gnadxPo3UtB5c4yvljPK0k98Wjaf4GM1l8yui2LEPB5dnUqRjoW7A2hhv3RQitYNDaKTlwASq7idjnFJHFOJQHOi6UYOv4zq63gHgA44HHoMbg2dJnLSwm0caDrl8NcQVSCQ9EOKC3VY8UoTFLlIpmRxxLR4T8uaawIx98ubQM3YE7s85qvoGIBQDnjBhlilDMSJ7kd4kqlcib4IudzXJWweq+hsc0abXVAPSgwVLu3POWlTGJY+SH/f+FMtDlYB3vuio2f3qaMUIA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6341.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(4744005)(7416002)(8936002)(26005)(52116002)(44832011)(2906002)(8676002)(6486002)(2616005)(508600001)(86362001)(4326008)(186003)(66946007)(6512007)(6506007)(5660300002)(66556008)(38350700002)(6666004)(38100700002)(66476007)(316002)(83380400001)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4lf1vtrFPs4sYzmUyZR9YGC2IIY2G9N5Zal3pu0orXBd3XA8kZT13DeyOVJd?=
 =?us-ascii?Q?WhQOpf5TJGvM3weXXmSoSGlRMcpOs9gYrEIR6jYM3dqNCqQODa6frgr6OPTe?=
 =?us-ascii?Q?JQ6CXfNE7eGYJA2belLMCoTAmQgSV2WC2I1SgCadZGJCMndpWKHrRvI7SImX?=
 =?us-ascii?Q?uS67Yixw5Srvx1KO7EOy8Ufmw4L20+zNCR+zY8nFy7KkACra+1K0mq1+eS3Y?=
 =?us-ascii?Q?404o+b9q74NfX/uuNh+ccKlfCDtq8+zMbee3DuZWLSO4x+h8Uc62lzr1xmk2?=
 =?us-ascii?Q?nhxtKMhiCmLVX6tX8blKTBcQuakm84Sr9f0LkRO0zsGwhqU4gq9H3XfusEys?=
 =?us-ascii?Q?nXy3aBBSURDumJiqfGV8BdfxxyWt6jSBa8S2tVg41xSBITlxAN1kxCmzK+y2?=
 =?us-ascii?Q?2jZgtdVrQr9dGk7V9K8SLUPpPHJPW87Y/ZMKwQQfqcRigxRJ6benenXQawS5?=
 =?us-ascii?Q?tyvEufMSeERLuv4WpOwX4bDXo+x5c1PpchT8Zy/AnI68F/0bgGECwb2XjBik?=
 =?us-ascii?Q?UCIE3z/ZUCHmlfrZuLFCPaCRemZ3eTiWyUmM4iPAwn+EoZ4y2dPrOB2uK1/7?=
 =?us-ascii?Q?qb7b0GkpUdZL8Y62TQKqtQB4hcUcPdoRYu7M5OL1AEn7EA8Suct5Y19jA3Ef?=
 =?us-ascii?Q?h+9PazdTWeYSMUgH8ftzGZMxFZ/1sHSBN4GXyit2yS0cCEkWexx77VVaU86t?=
 =?us-ascii?Q?rcDRBHlgswLK+75oRM+jM4LTFbbSzseDPWp24HFx8BoQISI7ciLZItC9Gew8?=
 =?us-ascii?Q?b46mqkE0FP/OrLgjyA3ZQjmP/l9Zbe2C+qLSCLaBfvL5RMMv4zaE5SQLNG8l?=
 =?us-ascii?Q?uJYw7RFFgmCOdG2QwTjJO8PuBXex0CsQqA/EDSLTRah5VD5d8S+e/FzX822x?=
 =?us-ascii?Q?yQb+YxflAzBu1RPXyUKb4N1gRJC0+LYCA+2RdUxvn/uJ0eDOX2ZwiztjVX7O?=
 =?us-ascii?Q?rVRTtweVw8xJBqW7cInNFFDC7lv2fTDiRynz8ovo/hGhqCqo9tQZ+rSxOc6O?=
 =?us-ascii?Q?nhr+Br8rrc/+lRI1ZDy9rfOVOko2+KyY6jvmMlaTI5jsob6lXSxHwOpdksD7?=
 =?us-ascii?Q?b0Wcy11Neg8FQYEShHbStmu7rFINEPbnUxTD2ygTS5EEZUi+rthvTgXPpEF+?=
 =?us-ascii?Q?DmcaLykUOFaAiSNN1HdzKEdGifQu/fAAbgBoD+ZxHzPJnpV/RK/ySMBxwFxy?=
 =?us-ascii?Q?yR++pi/XVtXEXjJkvoHShBWRAjfHugt2zcrApybqWRaN8+6Zma4iZmZq0UXe?=
 =?us-ascii?Q?YIcGeedsk3JMfOAysH5aZqaisJOypVUAQEm8NmNYto4CJyhfwFMicIHoL9c1?=
 =?us-ascii?Q?PyO+7gRiiUc6CfvCraf1i5xpnz/mY7No26pFUooP3+IyYVIe6D2doMXSOLl0?=
 =?us-ascii?Q?13ca4lNpzdEm+GNReb0mub+7mdglb3zN81pcfm9KeABNMRVF+5B3MQUVSfR8?=
 =?us-ascii?Q?7MJ4xaYw3gsHXqrUAUNP0WEKavVbOBmIP7V8sAw7chfiSoVUon/f8LhD59JD?=
 =?us-ascii?Q?4acqKRw+X3fMj7NBq5kLP+EK+rMPPwy/LUI+wwD7usdpKdOfC+Mv3L9a7caz?=
 =?us-ascii?Q?ZiOd/CazZLvdovYF9c28Gu4ywqQVrKxxC5SX1W03JuzcZx82yTLKEwYgQHoG?=
 =?us-ascii?Q?YPdWsbQ6e/TwxOw0nHLYV6g=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e67075cb-7ab7-429a-a68a-08da0334140b
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6341.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2022 07:52:23.9274
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N+P4xKCspROiGpe691KXciLIDx+b5MnVcHJlkirCGCc1LkB44WVQbbCkncCxqyZzDiBZeRTjT1Zcs9BBMFHNYw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB4443
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These patchset are to support dynamic resolution change.
Avoid decoding error or even kernel panic.
Otherwise, the Gstreamer v4l2videodec will fail to decode jpeg
who is not decoded to yuyv.

Ming Qian (5):
  media: imx-jpeg: Refactor function mxc_jpeg_parse
  media: imx-jpeg: Identify and handle precision correctly
  media: imx-jpeg: Propagate the output frame size to the capture side
  media: imx-jpeg: Handle source change in a function
  media: imx-jpeg: Support dynamic resolution change

 drivers/media/platform/imx-jpeg/mxc-jpeg.c | 244 ++++++++++++++-------
 drivers/media/platform/imx-jpeg/mxc-jpeg.h |   3 +
 2 files changed, 169 insertions(+), 78 deletions(-)

-- 
2.33.0

