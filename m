Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A4AD4F9781
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 16:01:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236657AbiDHOBv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 10:01:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234068AbiDHOBt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 10:01:49 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2128.outbound.protection.outlook.com [40.107.255.128])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77537C6814
        for <linux-kernel@vger.kernel.org>; Fri,  8 Apr 2022 06:59:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i5qjp5owbIQ+tN+TTsjMeYBYVfD29YTaMYGxWzjKcFNXS0qGH/9Y8vu/jRX9dGJiocJR/BS9ILBdCljytG8HDjSjUFdZGP6FiovrbQKF6tnw/RbqdVC6gmbMT6diBp54mHXPZOU4rRWvzFC0v0U8S2MraoLqJOHtw4We4++monI8Vyitin1PJ/GAJ+S3fGNM+G9Y1mrxi2FFVOiVObmoQrAwti8uC6nIFDhjip5CQe6mwsb3grYPJFDkALSUEWguPX8Iyhv+DFi237yaSPyiSyNYsX3iVywAoMa1Eh4GzGByGE3Ve8QHVDRFOL4f55+7dmwq02qp58XxBvE5dpvuHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IY7X1C3q0ClIJJ3NfLwm5qMalASrXILzR7EZxaf1LXM=;
 b=Gyrd2aj3Cdsms/85RYyuhE9ytT51Il7dykeBIaLZ0smUzL6/QS6GTPH2zWaNb1MVWVWgwVcDIgfd9kvjAIf545CRjGs1KAtmaKrQsbiUVOCJ4YKuBtG+cRllk47oBV1ME+R751uKmwAf7fSUPdKn54lGtFifK0S5dMlOuAvaR6VyGdydqqstEo76OaZqtuUkV4lVms0YdVPPz4RA76xv80aFkxByMc8n/qzh510b7/dRBjxRs7aBZjVzkD8/gqnYsCASAZsXAr+wgK9EsCmldEl4MoirsvIF4f23i/eyQBfBj38Mwl89XZs4L0/Gz/Is5daPeRoALRYAqHFCuqgrjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo0.onmicrosoft.com;
 s=selector2-vivo0-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IY7X1C3q0ClIJJ3NfLwm5qMalASrXILzR7EZxaf1LXM=;
 b=QZiMquYGDUDIOHBFWLjhaQNU0LWgVguA8tJ74rUwBa8XjCVLZpgKFcbgC2lVns6oqLpFPSybYK9OqvtYzMpWL6DYdyGgOekLKfotZAshrgBdHGoMjnM75mQRAlT8RSdJHVsr1fJ4DMzmiWVofid1X1SwqA5GFpnKYtvwqL0A42I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from TYZPR06MB4173.apcprd06.prod.outlook.com (2603:1096:400:26::14)
 by KL1PR0601MB4514.apcprd06.prod.outlook.com (2603:1096:820:72::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.26; Fri, 8 Apr
 2022 13:59:42 +0000
Received: from TYZPR06MB4173.apcprd06.prod.outlook.com
 ([fe80::2813:af2f:32d0:7be]) by TYZPR06MB4173.apcprd06.prod.outlook.com
 ([fe80::2813:af2f:32d0:7be%9]) with mapi id 15.20.5144.022; Fri, 8 Apr 2022
 13:59:42 +0000
From:   Yihao Han <hanyihao@vivo.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Fabio Aiuto <fabioaiuto83@gmail.com>,
        Yihao Han <hanyihao@vivo.com>,
        Lee Jones <lee.jones@linaro.org>,
        Xiangyang Zhang <xyz.sun.ok@gmail.com>,
        "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Bryan Brattlof <hello@bryanbrattlof.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Cc:     kernel@vivo.com
Subject: [PATCH v2] staging: rtl8723bs: remove unnecessary `if`
Date:   Fri,  8 Apr 2022 06:59:11 -0700
Message-Id: <20220408135921.16534-1-hanyihao@vivo.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220408085158.GS3293@kadam>
References: <20220408085158.GS3293@kadam>
Content-Type: text/plain
X-ClientProxiedBy: HK2PR04CA0043.apcprd04.prod.outlook.com
 (2603:1096:202:14::11) To TYZPR06MB4173.apcprd06.prod.outlook.com
 (2603:1096:400:26::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b2365314-1fe0-4548-cbc3-08da1968076d
X-MS-TrafficTypeDiagnostic: KL1PR0601MB4514:EE_
X-Microsoft-Antispam-PRVS: <KL1PR0601MB4514775915006F9C76929B31A2E99@KL1PR0601MB4514.apcprd06.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: X/6ZoT4f8JEvR8yeQ5YCWF/h/iCXLgmaOGaUZdhSf5btUJXGb8ZeQyc9zaYoZdkV5gQZXZkBw+OkxQhd4jkJHPvqo9Z43wnwWK5YjgrFlud6p9mLKktHtyTrsiV5mNgjiuA7MDp4or5GHEVmxgI4jSSm35BhyJvKvqQ2ZSbc1MCkBJ//R9eu6hIXx7LjDq2i8Pi+hWpTYzcsvKyFpYB6H+cpLqe5LK4ZSgd1Dvgc2e8BwucrvN1jGtn+SijJWJyPfm07LPk9xAMWfs+RYzo9ps4MyFrtov0iXiQpCor/2y3/I4EIbmYF3xnf4ma9Tn6nosjoGb+oUpNs9Bok46KVRGMEA0S/7stKjkHGpylQQBomqXqaz/3xp7x1chmVLasTpvzOyvK+hbFcsSwjh6uDSWXH5jK8Z9plOk8o7Td6QP1eVl3zI/t43WEsh2JJeUOaMZXI41RnQlBfkq+BEDcLZBQOMTASCCGouOAWc1DoeIg654U6taO7To0VSv/tacln1x4v0DIS30N0URlyC7Gz/ODjyL2tB29LLHdibLDx23zwj22KMiGXctWovmbd7sIyv+S3qPA04A36FN/mVYv5SUessPdSGJzjOvPBbpIoGTTnUEkoYWUxkEm84U7oX8lovgC7kmPbnFwSF09g8q3tG90N+hCH5jT/qtnXb26Mk6Uy0DXX3j+LEM4WH5gwMJJzkKSAapyPseJbtckl1szsJQIMZsEz8yufpZf5QkiURiw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR06MB4173.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(110136005)(316002)(5660300002)(4326008)(86362001)(8936002)(38350700002)(38100700002)(66946007)(66476007)(66556008)(8676002)(52116002)(6666004)(6506007)(6512007)(107886003)(1076003)(2616005)(186003)(83380400001)(26005)(6486002)(508600001)(2906002)(36756003)(81973001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+hhHoG1Hblf7iNzEVuDfce35n5MJHOpgkrSBAUPgDqzqsL+Wr3Zu/Aa/mAQi?=
 =?us-ascii?Q?FZKBwiKHhK+7kYBYDLAk/8qMfRe2JYbsKz3Fg9VVeo27GWtGzKmPtHUV4DE/?=
 =?us-ascii?Q?P9eAq2lj/3Bsq9Fx9ENwZ/T4I30Nu3vBMZhthBE+UZMqmszzXeLxN5VLCGw1?=
 =?us-ascii?Q?z3IRe635jT8xd5n37hmIJYx4jChOfoWmFtuoSq8pAys29j54wmzRDpWWvAxe?=
 =?us-ascii?Q?wRO9K7pPPl8ee4N/WGqjQf+IM34pPjGKfYAbNHGULMgWu3s370AsrpUQp1Um?=
 =?us-ascii?Q?kp/PNhxX8Ki+CuXTcQo6c/2Qeu7OkPhSOjEYvs/9XEJYPUIQVNoeaPP+CTcK?=
 =?us-ascii?Q?l5RKHriZOMAlpzKBW19fqCSdiPkJa6hVBczBlyuXnfEahlNcONVIAfnQcQEa?=
 =?us-ascii?Q?h48T3iCi0KYcl9Zz3xf1YbcpiM3JZpVfCCWpCfnsz7FbnZ78heon9BLJNxE+?=
 =?us-ascii?Q?18chTbgpjdQ5knZXXkcieV8fEBmRKKaAaWyyQj2yRShKF/E6nwA7FClFtmeR?=
 =?us-ascii?Q?EThDWZsvZ6t5rxO8llaDCJQIT6r6OdEEIi0+3uwkzMljJ9kN92D4CB0VwX8R?=
 =?us-ascii?Q?Uh8VebNgZ1bU+OIh1D4CigNMLT7uNDqZxUS577hrXw0SeXIgCG0lAxBW8H5V?=
 =?us-ascii?Q?fI/dcZOszgZm5blB+eX7X5kOj11RV6KZCfpZkpqvCdkJQf5t/fcZZ1QNgTdp?=
 =?us-ascii?Q?3efhWb14yyN5bGtQeSKf1qeyLMwnmL+xablYpgvyZmfBsQ4VzGgxvN8sc0eX?=
 =?us-ascii?Q?kJX2pooOJXBTM4gx3s6L//y7bD0bLSFhESVBu1AW0LQhDPKJqdSxMqaAvzt/?=
 =?us-ascii?Q?1LT9cEl4ScAPoEIe4LSaxKcFUeLZA1IB/nhazq7KFHMInq86jnm7vlqF5TKC?=
 =?us-ascii?Q?TR69l4kX7UFwOl1wZLouNIUBi3Ob9MShl/wYn/ObtsXux4VXIM1lpT900bFB?=
 =?us-ascii?Q?umXe6Bmkvt8IaIVriOnuToFgK7zaeKhx5YYt7ZKYhb0nPfWB2D+tQyE0lE2M?=
 =?us-ascii?Q?lqyJDeTCqG5Baz+EI136agCQ0ofncCkA6yLSYweLsKkee0p03Ct4QGd/yJy0?=
 =?us-ascii?Q?mPILSkDZ6cIAT5xfAuLqzJrq58MrWcXPimrmnHNBebh8FbYKu0k0CG0gS/YF?=
 =?us-ascii?Q?8ToD4axQkY8rLi6e2PeGqtpzlI7z/6NgbL3NBRk62lVK4ADEi/W+i5ICX+oA?=
 =?us-ascii?Q?evcwGsQqqbdwfkHXDptMOsSYy6dhKrBhMqQ720mFr3acaaZTLM9GfBdx2qea?=
 =?us-ascii?Q?2MaWZy9yPAQwerWS3AAfIj7HjSMuT6wY/T1EMEyc3pNujJXfzWNubJsekkZG?=
 =?us-ascii?Q?Mkfb7pcx+qkBQ4eIiOpWlNwz/zsPbn/NbHHaMgtKJimR7w42SKdIHXzbHq93?=
 =?us-ascii?Q?PNyPSZASTewOOG3xjLv6xk2OZXXRv/ED3y0+e0Acdn+3f3B0q3snVZqtiUi9?=
 =?us-ascii?Q?1ytkT1ztpiuOP8paBVIovQFSr4zmJtwVpPwrGaQucQizwA2pDByuzCVQgwcw?=
 =?us-ascii?Q?K/xDPGnxHtERkyxJ66KHnnBdg21CY3iGkWeEwy0l+IFlCBSySr9Tasw1CRy2?=
 =?us-ascii?Q?vdOzN/QHVIqhiThNsxaaMUFp3/6/wdi80pho/++rOjOXNaxo69OCsSjhpHCa?=
 =?us-ascii?Q?XTq8baQJHO3LntbtF15QwOXxgz6szyvOha3knRiT0Yh9TV5mbk7kTj22HxaX?=
 =?us-ascii?Q?UveGdaslsyKJzlecfdC1fnsaVFdFiS1pRV8hzJfaLzdZmBSUkQ+F6fUkuq9a?=
 =?us-ascii?Q?iUPmE64AIw=3D=3D?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2365314-1fe0-4548-cbc3-08da1968076d
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB4173.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2022 13:59:41.9994
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yfaODZlB8U7sn6qIYRB48/RnRRLJlDwTXpvqcBjak/PbokUoaye+HukwVACg+wZ6f8ct4NZfXzUi2PSRlIgSqQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR0601MB4514
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

remove a unnecesarry if in `sd_recv_rxfifo`

Suggested-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Yihao Han <hanyihao@vivo.com>
---
 drivers/staging/rtl8723bs/hal/sdio_ops.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/drivers/staging/rtl8723bs/hal/sdio_ops.c b/drivers/staging/rtl8723bs/hal/sdio_ops.c
index a545832a468e..107f427ee4aa 100755
--- a/drivers/staging/rtl8723bs/hal/sdio_ops.c
+++ b/drivers/staging/rtl8723bs/hal/sdio_ops.c
@@ -811,17 +811,14 @@ static struct recv_buf *sd_recv_rxfifo(struct adapter *adapter, u32 size)
 		SIZE_PTR alignment = 0;
 
 		recvbuf->pskb = rtw_skb_alloc(MAX_RECVBUF_SZ + RECVBUFF_ALIGN_SZ);
-
-		if (recvbuf->pskb) {
-			recvbuf->pskb->dev = adapter->pnetdev;
-
-			tmpaddr = (SIZE_PTR)recvbuf->pskb->data;
-			alignment = tmpaddr & (RECVBUFF_ALIGN_SZ - 1);
-			skb_reserve(recvbuf->pskb, (RECVBUFF_ALIGN_SZ - alignment));
-		}
-
 		if (!recvbuf->pskb)
 			return NULL;
+
+		recvbuf->pskb->dev = adapter->pnetdev;
+
+		tmpaddr = (SIZE_PTR)recvbuf->pskb->data;
+		alignment = tmpaddr & (RECVBUFF_ALIGN_SZ - 1);
+		skb_reserve(recvbuf->pskb, (RECVBUFF_ALIGN_SZ - alignment));
 	}
 
 	/* 3 3. read data from rxfifo */
-- 
2.17.1

