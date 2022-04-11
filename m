Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26BCC4FBA40
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 12:57:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244486AbiDKK7e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 06:59:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235545AbiDKK71 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 06:59:27 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2130.outbound.protection.outlook.com [40.107.255.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C65EE40E58;
        Mon, 11 Apr 2022 03:57:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WrK91Rcr7HaSpqwvYN14E0My8xk7Jklebi3UMJJqkasKHaKNQMp2TxD8FpP68O56gxuutt7IW0o9cvIlY+X9XqScgw9SlGeisW5Yq9DOJglcIxz05SYyXxXIC+ltOiZLQW7AvAOpD6arVXM9Tp2kRe/cA47H7xJp6fS8rhQRwnT9lYO8mAaTNpQdC52LhpM+Plor0HO8FTI4CSn7jAbY9/bdl0aN1wlv9MVDRXsA3Ffzd/kP+kJPdymBdusqTndVW6efjS00u9mqXV9UBuPCu8QzaxgytgV4dkpq2X8MZQ5j2MxU7MBBQgzaOGfyL3rrRtzvpxkUYb/qHtJOi/G/Ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=trubSA04mwfQ5T/pC46qE9j9HrrWwOgmYHef7nMKAXI=;
 b=mQMefTsvUHn4tmhBZ/n/bgY38H4hwwAugJIeIVFZwehAUaxlYCMkgECPYQB3dKZUjp2FvwIF1V8XXn8yuyQpJOhceg7L3SZJW2/w5IbKuUIJsKOLlewoXF1BejvkmIsfj+eBulYw80J7yWrMB9M4nh4R1m/yHp8x5awtuabFTPOy2ulhL9Bnj4vxs8Jf2hnz1G0iCyrnut6yeOoZfDnChyatvpfe8kA7s2tTWsXiqlXM7JON82TmYpjQbMCmLY2WMzNsNE3T4VrXTXQlcITG+dSpS3QOox/KwS0cwys3Ttz3jQTTxK7zZMcvrMPQl/zX7net9mTZHcrFesQ88Uipjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo0.onmicrosoft.com;
 s=selector2-vivo0-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=trubSA04mwfQ5T/pC46qE9j9HrrWwOgmYHef7nMKAXI=;
 b=oxFcRSGG7I+1YsfS5OR+OMtyP4q8Mj6g4lp2OmnswXKYdFiyYyreb/PfePNdAXrxojRXgz58cSm+KJDKbmucR96uOlbwkDFiRE16x/8M/iI1w/l4G80NbuMK4YlLTWWtSHov78Bt/LrqCgKCZnRCozOq4ocmUvodVj817i8BTcY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SG2PR06MB3367.apcprd06.prod.outlook.com (2603:1096:4:78::19) by
 HK0PR06MB2289.apcprd06.prod.outlook.com (2603:1096:203:4e::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5144.29; Mon, 11 Apr 2022 10:57:11 +0000
Received: from SG2PR06MB3367.apcprd06.prod.outlook.com
 ([fe80::c8f1:10:8ae:e8ca]) by SG2PR06MB3367.apcprd06.prod.outlook.com
 ([fe80::c8f1:10:8ae:e8ca%4]) with mapi id 15.20.5144.029; Mon, 11 Apr 2022
 10:57:10 +0000
From:   Wan Jiabing <wanjiabing@vivo.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Yang Guang <yang.guang5@zte.com.cn>,
        Arnd Bergmann <arnd@arndb.de>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Wan Jiabing <wanjiabing@vivo.com>,
        Colin Ian King <colin.king@intel.com>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] media: saa7134: simplify if-if to if-else
Date:   Mon, 11 Apr 2022 18:56:49 +0800
Message-Id: <20220411105650.723082-1-wanjiabing@vivo.com>
X-Mailer: git-send-email 2.35.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: HK2PR0302CA0007.apcprd03.prod.outlook.com
 (2603:1096:202::17) To SG2PR06MB3367.apcprd06.prod.outlook.com
 (2603:1096:4:78::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 72763a96-cc37-4d0d-7415-08da1baa0660
X-MS-TrafficTypeDiagnostic: HK0PR06MB2289:EE_
X-Microsoft-Antispam-PRVS: <HK0PR06MB2289C547983BCBD5D51678DEABEA9@HK0PR06MB2289.apcprd06.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4qZ8UemkjnlrqZhC/1rcKK9rSbVXtROFeSYASokHO656gqEfon31ty/LYdGfetFS4CCa6W9szgEx3xCDtOcLPKHeK1N2tSgJtpETc5OrinEPJvKZnedx6dxZ1JEnJSBqnFPmQdGwkRWZGJaemJOGTyaoWWE1Im55vTGXNJ6NEyPkzNxGXoWADZI+zMwD7oDLJgbDTgjAIElIpPfplt2ZNmKEKY5iobB5DIxa6uYU/jOIWpdmeyt6d4E+qmW2oazHiTIo1O0+pnQy8AqKNZ85Hyxa9XUOyEEKZRA3ScNVguT7q2Mdqp5x+MQQ5VLPYrSj4yAm+zBoDZEpgvjjg8niPBtoYjr5Uk3LiQ03HH8qL6EhSFSBbnr/OwWHfpwwqaZ+tDiOj4QiNbRGB7fUaFNjGqV3CQ6pZ+0VXyc795eXkQnDyV6rYuvh7VenJtoqdpek1m5tCzUVIzgQ4SORUMnFaylvQvFMoraI7IZWKzVQRrayc34QicnoR1XDm8zYxm3ENVWBGDrwBjnFSoZT/xEbpNz8xN50xavzAqSxRGoTzSwOZVN7H5qOXXZGYE0f2iDRswosO9jHr03std2Sb1xy8YhjETXIywXghdyUZaJbLBtuvqM5mY0K3duVOCOY08RZ1J3F7TCwjap07Zw7dLZ/NKOgzoB+JwQ1TVRekIdTrmtRm1YN/qilJS7P/AfC//ObqwdSb08ihiFw2hDnAEaXCg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR06MB3367.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(2616005)(316002)(6486002)(1076003)(26005)(52116002)(508600001)(36756003)(110136005)(38350700002)(86362001)(186003)(66556008)(4744005)(38100700002)(8936002)(66946007)(66476007)(8676002)(83380400001)(6512007)(6506007)(6666004)(2906002)(5660300002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ChUGFLUW8JAdF3YWgJ14cxT+49DbXiKJUfDrHS3c+j8JUPFWIXHnqTt/NvVj?=
 =?us-ascii?Q?aHFTFVQ95Gzh8hlZOYn7CoM0+KqZ6c5q7JnmBXtseh/6Y7vtRko5WS2bXR8N?=
 =?us-ascii?Q?aOPmYN+eGdH0wyk0vkp6dvdw0Wr7fb9uzXkG7aewlw4wJaYETCXBe3hLqFzL?=
 =?us-ascii?Q?O8AsuTL6jyFkvQZpkUlGE8D5VGanKPwARYzlQu99gsf6NqNuk8DXnSZfysBZ?=
 =?us-ascii?Q?gWJs7S++FyEfPIzaT775Tdktc4ghCDsTVlvpiGirqglDVbMc3hJkZkvu0QXT?=
 =?us-ascii?Q?8TxEqlGpK9ASbUlj55l7MezqpN6cjBiCtCotAoBcBrEmsdyLiRVuFbmaxDa8?=
 =?us-ascii?Q?Mm5Z1tH0Y6N8MZgomXvplCOpU80x1vRbDjuu8j4eqLc8PemBg9eh9ci1oImq?=
 =?us-ascii?Q?qAKACnzz27StmYjugon1EF3uIMSn69lLkY5aZg3ZqAKemaNYip2Uv12yr5aW?=
 =?us-ascii?Q?RdfGY1w2X7H8zS79xPLf9DF1Bvnf8Lm6BaT1el0R+aGHpacz3nye8Vqptoiq?=
 =?us-ascii?Q?TN2MSoqpXz6uvgW+KGnP/u8walVA8xuBsT7qORqoVKLQvnI9W22jW5ihrbCL?=
 =?us-ascii?Q?++4GlDW4H0QWrI+HTvaT9ugVKMGaFi/j4ayFAJDbJENkaDN/gT3uTURCKPPR?=
 =?us-ascii?Q?+alOn1fdDe7vTHSKcBhkydOBCdeA8+vRWcnZq9kGB9tWqhsNBm9hyLXBfd5x?=
 =?us-ascii?Q?EsNYkr1lAnohy41TRKj7NP/vU6tUek2pVVhFPHixsqPQcincSCqkt8/XL/g8?=
 =?us-ascii?Q?GMEdgw4e892nCUzc3JtCeBMPM1QCje7W5fuF78jiaEfexcGYkziZlBX6VfqM?=
 =?us-ascii?Q?pmFWeeiaZ3Guu097n6skJ4pY1Y8+aMGmMHcdQr5AOhy2bv+E/EJkrN1BMWyA?=
 =?us-ascii?Q?7S2t8wAqN7nrVA5cMk9uPRRnN1U3pDzd31Joq/Cvq6nJsz9P+0Oo7mn1hEQg?=
 =?us-ascii?Q?ExSanp7ZY2LETPhSk7fSGG4dOhJ15C8ZWuYxV+PY9WLuFXMv9FBWr8Ogykg+?=
 =?us-ascii?Q?CEsLrCU9m0PxeADyxd7qRPiOCBZzv04APaQhuC/TBcPWm7LJKl0h0LBG3koL?=
 =?us-ascii?Q?y1dcPLAI8dX2ddzHEnJhJ8F+RCodFf2G96pcd86rnn9AtPhkrM0DpJzmnUPw?=
 =?us-ascii?Q?6dNekPkQ55K102CEdkyeKng97zpGmRPnIm8HNi+ZrFfLGne2KjCA3rtOgJ6m?=
 =?us-ascii?Q?mpQdHhDo/HJUZIOgoa26yzMXjoKjgT7G0iPuAf4k5QH0BnK6nycNOSW8+nPf?=
 =?us-ascii?Q?IoPmWZpKxp3mV559EofIjhkcpm9KRnpR/PfcZQ4N79+DO1j0AMlBw4HawGoU?=
 =?us-ascii?Q?4SqFWlXAk0ACSEX4sEojM8ya2nW1OOzxp//Ab2Mzj3UC6bmArp06iLrJbGoP?=
 =?us-ascii?Q?uaR/+MiwxPYWEnCrVpTix93hq10/lfSiIqTMLbCQjvKw/8W8GAR9kRewBeBk?=
 =?us-ascii?Q?d15NgttDUByY1yU0wJ8OXrPgNugmb9IEWJIPFNxGoDxB9qdgPBAF2dQHquA6?=
 =?us-ascii?Q?eBbeQ2TqE1ZUESshyjiJxA/K0SV+IQZxbxzl6XSmlXz+Wzd0itpW8ekI/pvM?=
 =?us-ascii?Q?UJlPZs68TU/gNOetAF01b0+epr6YgTSdV3v2X4tVad8FMTY26QyKVD7cvnpm?=
 =?us-ascii?Q?dzN6vcLAgGxMHkTnGy0RUuAy+0XaDIjy5hkFmWh+9dWtjvNZopRNGowo2vPv?=
 =?us-ascii?Q?S40OqRL08c7LGChpefQdtf/qzj5asCQZswdB80nmkdac40pHE5VDcoEZw/Vo?=
 =?us-ascii?Q?0sxYnWnxVA=3D=3D?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72763a96-cc37-4d0d-7415-08da1baa0660
X-MS-Exchange-CrossTenant-AuthSource: SG2PR06MB3367.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2022 10:57:09.9064
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mOcxZQS6CUPTOWLk5YSl5YWs8PhZTq74j+9Uj6qOC4Sxlm2Cwuok5+jMADzd9CK7iu1zTJvwyLzLzi1b7PvW5Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK0PR06MB2289
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

use if and else instead of if(A) and if (!A).

Signed-off-by: Wan Jiabing <wanjiabing@vivo.com>
---
 drivers/media/pci/saa7134/saa7134-video.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/media/pci/saa7134/saa7134-video.c b/drivers/media/pci/saa7134/saa7134-video.c
index 48543ad3d595..61e678c1c2f6 100644
--- a/drivers/media/pci/saa7134/saa7134-video.c
+++ b/drivers/media/pci/saa7134/saa7134-video.c
@@ -1833,8 +1833,7 @@ static int saa7134_overlay(struct file *file, void *priv, unsigned int on)
 		spin_lock_irqsave(&dev->slock, flags);
 		start_preview(dev);
 		spin_unlock_irqrestore(&dev->slock, flags);
-	}
-	if (!on) {
+	} else {
 		if (priv != dev->overlay_owner)
 			return -EINVAL;
 		spin_lock_irqsave(&dev->slock, flags);
-- 
2.35.1

