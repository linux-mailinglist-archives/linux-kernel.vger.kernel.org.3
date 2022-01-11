Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A036248A83C
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 08:17:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348455AbiAKHRU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 02:17:20 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:13020 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233066AbiAKHRP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 02:17:15 -0500
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20B3TK8A022685;
        Tue, 11 Jan 2022 07:17:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=naIY9LPUkd1oDJ3Hy40NkHKoHQt2zJuSS1dD2ZhAAmI=;
 b=QU8G/A3DtHzd+icGWhXABX5a4BEWfjLXrIw2BcU9nHtL/l73cbjembAQ2wOGh1HKZNJe
 WSQ9nXzpOVedWeUb8+fpMWEMEhf4EKEtTgn6dion8WAe9bzC/4bNnjMOC9/L55dP+E5O
 OsMK66beqsHW4fkw/hRh9M9T98uzZqqN3rcDFS1D4hK4MkjjhA0P9S+aw16jJDWPDoWR
 IyJSNj3Ur2t3Vcjn6xEhtdGU2HGNpCYM2kR3HAEaQeohLhwljbt5jjWN4UK2WTTc96F9
 x52yAlKAgd9HeYOa5LCtqDxQ9rNdPUbAXlzn3pVIcatQL3JylA9Mx+nHBUAgzLsqaz15 nA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dgjdbtme7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 11 Jan 2022 07:17:06 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 20B7FwSk028030;
        Tue, 11 Jan 2022 07:17:05 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2046.outbound.protection.outlook.com [104.47.66.46])
        by aserp3020.oracle.com with ESMTP id 3df2e4d9u4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 11 Jan 2022 07:17:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J+nPvIm5mwgwMT6ZWyGarYFnFAJ8qgikFnnLXQeMrArw6aMyQv9L0848oP7jXmEIoqJEGo37LYvSq9x64TvGZ8fzdxCyT/vrtBvFiDdGNTcht+AXSCA1IIsd98mKf+hS9UQx2t1bZcX4fIAKOyDWNKDQbeEka3Ze0PxfwRSTgscSF56+vNCM7m66DZko34R8E0lJ/QMYNEUsdNuoHf/3/J/1R7Ea0VH8IHHngKi1rgxoyY/AbAzrN2pk7c3Wk8KjTGeNKFoyoCTl8+6wvonLXMKmII2KMI0L4DaWZ7xKtv6fOHbLQjWHV1DoA+UKCFoHUaquSm5ie7bCuFyuiaDSLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=naIY9LPUkd1oDJ3Hy40NkHKoHQt2zJuSS1dD2ZhAAmI=;
 b=aeY2QotmQpgZxUC2VAzyr/11VACoTIiRTsNWDDhpjI1Ij2cAVtGLYvxogrnjid0YtDcwtTXOJ1EK0GgrV5Nr7ZcpPtAQU7jT7tHdHtR3y24GQsZe0qjMLDKKCYfQk1OZs4Mqd3pJ3dx9xZvVM6IUGJwVRg/C9dZFtDsYYB3epGa4itSc8C0Wi66eEeIOQDeeRu5/tnhlhdLphpmzFnYMHoc1Hs5V8InXr2bR1U7s8WsWUqfz/AxhWoPMR96RQkGX0nzkV3Dsjjx03KJSWBDTzcFItpVukftU0f4Qvju77HOicdItgxMQAA8RWSngHWoaL3KY8zGwBoq/aZk5k27e+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=naIY9LPUkd1oDJ3Hy40NkHKoHQt2zJuSS1dD2ZhAAmI=;
 b=bhJMBz3SbFHMjov2X0UPf5OJq17XV4N8rasedK0tqOZrTGHj5Tb42dhHvknR73hkmC258cls582HbcUTUvtl4bX5KbZYL8kRTNoD00XiY4KkveoH9XMjelDninhVBv7jPoqPDRVBZzGdLhAnfu6N0BypygHGJMOF3gb3dpm+tBM=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by MWHPR10MB1421.namprd10.prod.outlook.com
 (2603:10b6:300:24::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.9; Tue, 11 Jan
 2022 07:17:03 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::b889:5c86:23c0:82b8]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::b889:5c86:23c0:82b8%4]) with mapi id 15.20.4867.012; Tue, 11 Jan 2022
 07:17:03 +0000
Date:   Tue, 11 Jan 2022 10:16:51 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Oded Gabbay <ogabbay@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ofir Bitton <obitton@habana.ai>,
        Yuri Nudelman <ynudelman@habana.ai>,
        farah kassabri <fkassabri@habana.ai>,
        Alon Mizrahi <amizrahi@habana.ai>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] habanalabs: silence an uninitialized variable warning
Message-ID: <20220111071651.GB11243@kili>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: ZR0P278CA0095.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:23::10) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 319cf46d-e9a6-4528-4a59-08d9d4d25dc1
X-MS-TrafficTypeDiagnostic: MWHPR10MB1421:EE_
X-Microsoft-Antispam-PRVS: <MWHPR10MB14214BB3809A2674BCFABC228E519@MWHPR10MB1421.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3173;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WvIbTBLKdtiLHfu2g6oj06D2/FbCznmPteravhE2MQMR14h+oLIbJ5xmOQSagoWvVQqeC+kW8199KxuKrphPmzRDoX1QCZfSDG4zSZE9jlaJvfDDruygQVdMNTOdtfMDTA4v19wUk0/r/ls7SRL8sgUrlcjIlvV0e1SCq0GZnMbJHITjoBhFl2Z1iLBS7RrY9wnEjiG/8ffSXk/BNs/Xq2dMYwOTUDnYtjYxnBSk18BsV4pW7NwEETAkkpaAK3JizFbk1PNfm/aCbPB6sHnkBJVSJZiDc9F5zMyvykRYNPznsSBZTs3742UVKFr9tNJrBEqHDvELpWReX1cK2bMqx5pTdBIO1atg2JfXORJUPOJ8uUZWYcuCHw/EavWC1xNDsIbtGjyx39yLwcqpZViMKqmwyN4I97GamHM5vwwzaK//eejBBAAoZCPr4H1+HjZsxsOPtSHASrNLCOSlSFWSL27LwGnQk+mXBdhYi0t5IfSzdJOsIgpwxPfBAahJYQg1wOkHYxZ4XNS+Lac/uAhZXiXGoqUAsWzZF9xVf1+8HnyPFwKbh3z/Ko+t71oYf4J5ot29t0lutM2EOXVcAjP4u7F9fujUc/Gx8ejuLHUiDLNDe6daTJpL8HMyRot2QJaNWle/pII+fZCE26nzDWLcLPTEKabz0Z210Fyfod2jmDTyMQfirdlL4mheu4WMlu8cO4p/VXI8cLVwQaIHLYu9Jw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(7916004)(366004)(33716001)(508600001)(4744005)(44832011)(4326008)(52116002)(86362001)(2906002)(186003)(8936002)(54906003)(6916009)(8676002)(6506007)(66946007)(66556008)(316002)(6486002)(26005)(66476007)(6666004)(9686003)(1076003)(6512007)(38350700002)(5660300002)(33656002)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?TXkZ8/nCtxLzQskzv6OMpwZbwl+UqEL4TVBDTWo1xTNKrvCasHONs0VpEAYt?=
 =?us-ascii?Q?cEcCpAAs4d/0J1+owMyuIubbTvYvK931t+k5xlJhCFJMfnVxj014uP8p4Cms?=
 =?us-ascii?Q?zEk4W2cwv0c6XujknFwlgV8d1tUWtaka7Ep1VBo+yj8l7QjjCah+HmywXUT5?=
 =?us-ascii?Q?VbIVTCbrnQnBNp1Qtmk4ztiQUyVhhI89MTKrFttkcVtl0k4jOoRw7rQKM1Ry?=
 =?us-ascii?Q?powRp2ts2x03xx0tSbq8BR0+KcJ2NtAz2kj2DMd2Bvd537lGD4ChgG2kl1Wu?=
 =?us-ascii?Q?V3OdoBMr72D0Mb/3zUinli0GCYByqgeevJ8jKdpxUkwuu+JePEwKBo4VWq/g?=
 =?us-ascii?Q?F/v+foymYGdgc/wjSkWJS/F8vvb8oVLjk7W3ub04jkRMGW+qNs9DOYqci7pK?=
 =?us-ascii?Q?r+zcD/8eg54jtJ501t9ihnq5UJDDHBVc/CKFortwQFentPle8kSUPM2J6iF8?=
 =?us-ascii?Q?TqEcLDzhiuNrWFzNxZIOIIhcgkZISiJ7U03mtkEr83GydAyfbeRQF1Nk6mfq?=
 =?us-ascii?Q?xEZ5e534VUxwx9BbUpLt27MHogkV/eUfJ1uzbrXmme3zZCADL6IISaK0i/VT?=
 =?us-ascii?Q?QSk8CkiwGeseioZcuxoB9uKkAgHBTwAXiXQOVY9GKzxrnb4AF/r28w9/NO7L?=
 =?us-ascii?Q?90MaRZg9b7uk19AEiIgaxCsF3VXb+YHW/EfkZF7KQp+96Adcy4JY0dMbWwki?=
 =?us-ascii?Q?pon9/bu6OPH4yNucU7LMR1e6hN/u+2dTdEGYSz7rhK1ujYN+X1MLJmU6Xery?=
 =?us-ascii?Q?RW4P5aMmGLdOtSOl1F6hlsSeuCHhKk06I0St244f7phBjU8mP0zxXnclG4l2?=
 =?us-ascii?Q?vdH03tLM7yHXl7eOKO1N2gP+ryaYS2M8sOGbEsmyG9BD58wA3NmNxQ+m946x?=
 =?us-ascii?Q?z0J3bbLa7jS4DzdIgRWhnnbw13vFMu5uA9+z52Q6edv0NbA8XUaT1m2Elgwx?=
 =?us-ascii?Q?ESxIG4VDqn+BMQ8IYhiMelYSkkodHS2Gg4ke8v8uLjQQEhQ+y3B8ojQ9wuKQ?=
 =?us-ascii?Q?3vFKx6XaBj9uUmyXIJFeTlijZGz0ZO9i7dylcmY83L2wpfLzyHntlQ6Hr9SN?=
 =?us-ascii?Q?X6aKDwPCvgQseXuGw6NXKvt8VpfDRhi67RfRaIAz7rQdtgU7E1Wi/GV8uvFT?=
 =?us-ascii?Q?t49BsMKjgvCDM0AmOpEvmBJALj6I30auCIVGlnGwcbW4yZwzp7tmEg8OP1d1?=
 =?us-ascii?Q?XrgSb3P8VuyAacK+j602Pq7I88kpOF6f2u7IC/x4broJUbZWhYzsu5RqCwSv?=
 =?us-ascii?Q?DYOBuJZmXDhgPZ1TZ+dzDrGTIRYZu4hx1wwSZZn/4ZRVPRpX63C0UzHGtTNA?=
 =?us-ascii?Q?v2J7NakgmNvHNYR1T8FL1UBBISfMHleQ01J9yZlZQ0314+UBrNTW2yv2jgqQ?=
 =?us-ascii?Q?JqJLYGnFY6wyvR7tb4iJPp/a+tdYAnvVc2XJNC8T12uTsY+A72zWEk/l452X?=
 =?us-ascii?Q?7RU8z8Iiaman5ohqTZghHRPr4wfcGfX3dIfyYSO8CepuWHX1d1UHNYkkKpPD?=
 =?us-ascii?Q?Qi6otCzRqPSepwcBNSCQqLRKCAM6KNaHERM1sCwc/cHVIOKfIMME2PTKp5oN?=
 =?us-ascii?Q?gU31CGgAdi3Fj3XJNgsBWVquk0rxNbrbAf7dGhBN27ChrMmJ90mRjkEILZrY?=
 =?us-ascii?Q?Zl9UDh70RTQVVmEH58/KchQCAZdqxttcaXy6fJTh/NmLfW1xFBMtMVuaZHlj?=
 =?us-ascii?Q?u22fjqu1x+TwfBG8CLZqJFxzFHI=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 319cf46d-e9a6-4528-4a59-08d9d4d25dc1
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2022 07:17:03.3617
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +JommEwSFIzygyo2DTszjiUcVQUjrRapLlg78R1TsBSJGhXGqDTBX6LitbAtR/884LVaOdVEgsHKhK72GsMeEsYXPrY9poIgqTwwgrvJ1Is=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1421
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10223 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 adultscore=0
 suspectscore=0 mlxlogscore=999 bulkscore=0 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2201110039
X-Proofpoint-GUID: SRSOSse7jhzX0ohFqksJAzaNVLmTNYje
X-Proofpoint-ORIG-GUID: SRSOSse7jhzX0ohFqksJAzaNVLmTNYje
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Smatch warns that:

    drivers/misc/habanalabs/common/command_buffer.c:471 hl_cb_ioctl()
    error: uninitialized symbol 'device_va'.

Which is true, but harmless.  Anyway, it's easy to silence this by
adding a error check.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 drivers/misc/habanalabs/common/command_buffer.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/misc/habanalabs/common/command_buffer.c b/drivers/misc/habanalabs/common/command_buffer.c
index 3c0ae07a2d80..b9483a3cee91 100644
--- a/drivers/misc/habanalabs/common/command_buffer.c
+++ b/drivers/misc/habanalabs/common/command_buffer.c
@@ -464,6 +464,8 @@ int hl_cb_ioctl(struct hl_fpriv *hpriv, void *data)
 				args->in.flags,
 				&usage_cnt,
 				&device_va);
+		if (rc)
+			break;
 
 		memset(&args->out, 0, sizeof(args->out));
 
-- 
2.20.1

