Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC8054854BD
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 15:38:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240975AbiAEOiQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 09:38:16 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:58352 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236305AbiAEOiM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 09:38:12 -0500
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 205D4QxJ003377;
        Wed, 5 Jan 2022 14:38:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=PdX8/PxY5bx05tF9z2pLmCcml+80GP5513nxDFk7sF8=;
 b=vhrrcfsPHPwnCz26gUUvoI2uJWnvST+xQsZntIofX63NdT/vGG6a2CvZ8jIVeeLhWCCK
 Spw8UHr8J549kr1jt/1AYrfxQC65EvIEE1CxqppGQP2O5G8rpJgQoeH90Ddfwj13F2o/
 0gXNgC0AjO1lOX6hlG2SYj0JbWuTxgEe70Fi1eD+XkOWrvDV8O2jXZFGmdLeyOUQh11z
 4UtdjsQiE+xQNAvgasjiSGxUGCsgOf1WEZTw9KHokotSRcbGI+bLkxqQqQ28Yx/rYmYE
 5Oim86GZdFL9qBYJIuXLjKZe13E+H34ywvzQhaej2f8j0izdWOIyhdSUn6u4Z6JGO88F XQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dc3v4myxv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 05 Jan 2022 14:38:03 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 205EZfYo046598;
        Wed, 5 Jan 2022 14:38:02 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2108.outbound.protection.outlook.com [104.47.55.108])
        by aserp3020.oracle.com with ESMTP id 3daes59xdv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 05 Jan 2022 14:38:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B00dd0bKyId+2qCvY4JOgeDbRpIUeeDuQ91w+Qwc63JdOg0WmjmjvtEE0Rt3EfX5q/FzCex1W9GFOO3KMWGxdc+JG9or5MrqERhzn/7K+jrkhzT2PBRtANvGCHN971E84f5cugNAXAcp2JLaOj25wdsuELWGar3MvYdSgGMM+XAYN4bg9X3pdLrKr5JnvIUHog6UpXywoxqVUTNWCV315rOZzGJJOVt0n5lkht6Vt24y8T968OuZbItwF1q4rRgqhtfRfVhWW48zepK70VahLD0U8OstTCXtmp9jxGJzIKfP+hIvpN1XBJLjyaRNLfl885lyln/zGhZo3ZggplGgRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PdX8/PxY5bx05tF9z2pLmCcml+80GP5513nxDFk7sF8=;
 b=XgaBb0N41E+EFogVUW3Bq+AIuAwMjX0sFx88HCSXWpqkcFp4eEEIM/oS5Hc9XUQ0EqUBbnzgxNiCe5TaytZ59giHJlN1JTvC8QqDO0rThGswlxci/yhDSaPfYkDHSZ2XH4pxAJD1j5IY5GzrswAzMyGM2Txvxc5byuA7fZuKlaHUKDk/kVcpsFgMsspZqMRAnp6qYe/nrkC+nMjQY6cvyJDt0riW3dWzMYGvqcHANOKet2P0o334JpVKD/8mmqab6q/Vsi1HK3M/4TVvzu2CDAdSE5mBnrabmrffywSadgo5DlvLlaSV8JEkKLhIKJNpm+ydeoQtbSV551+bJmK2Rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PdX8/PxY5bx05tF9z2pLmCcml+80GP5513nxDFk7sF8=;
 b=p72mY3z5X3BOIh+9Kl3EoKK66s0v29KHYAKbzvi10i2KLiTm26FsKNG28ed4lLJxbNLcLAIXSayhhud8a7gbOJE6ksi7TRI/XZOisouinwmuy3eiEvAJOX/bnkDPgSCA1ApR4mvG0v8cPYeJxZ5d2xXt5dcgha0Sg5oEln+CaUU=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by CO6PR10MB5460.namprd10.prod.outlook.com
 (2603:10b6:5:35e::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.7; Wed, 5 Jan
 2022 14:38:00 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::b889:5c86:23c0:82b8]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::b889:5c86:23c0:82b8%4]) with mapi id 15.20.4844.016; Wed, 5 Jan 2022
 14:38:00 +0000
Date:   Wed, 5 Jan 2022 17:37:40 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     "F.A.Sulaiman" <asha.16@itfac.mrt.ac.lk>
Cc:     gregkh@linuxfoundation.org, fabioaiuto83@gmail.com,
        marcocesati@gmail.com, hdegoede@redhat.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] rtl8723bs: fix memory leak error
Message-ID: <20220105143740.GE7674@kadam>
References: <20210830193355.11338-1-asha.16@itfac.mrt.ac.lk>
 <20220105123447.24674-1-asha.16@itfac.mrt.ac.lk>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220105123447.24674-1-asha.16@itfac.mrt.ac.lk>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNAP275CA0034.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4d::11)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d25a6da0-5d3b-447f-853b-08d9d058f8d2
X-MS-TrafficTypeDiagnostic: CO6PR10MB5460:EE_
X-Microsoft-Antispam-PRVS: <CO6PR10MB5460944CC029705F68167EB68E4B9@CO6PR10MB5460.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jN8jTCdGtHtrFmgo78l9kkWCnh7TXZ/Ls7ty+H+tqbdIEGumhD1BsudpnEnxuNiFwAMkpiJBRbew435dcaWYRxNJKWYKOKnIEds3KdtAYCoKgDncWDvA4fRV/SywgknqjWv7j+ZOJ7GLJ1U1wyVsZJBHbPCX/6pGj5JD4+VNtHhZ7yZkKs67bI7xJkz+DqxpNoxeIRrwtr+dQWOpYCHIwBtoEDP0w+ZdYIfOrNBdZfthrZRQchiOAYlh24vH2K63iIIEFdSHbDVeu8bkh9FVq0caIIRq48pkf05JdNrxqGc4R1umLg4DYDZc56t6MOEPNuW42m/u1QJZXqFb86l/0+InHJi52edYqwlTp9LK/9OI9hv5SX8QF/V0A7VTspJZDiQxMxvrg9gcgOlaDTeH/nK8it9NE7RU534G5cI32Zy7xGghh51A4KQdWB1+e4Bjeh241fiR2b7B1tXaGRvjAd3Mm3R2V5OQGEkkr0B53Ti05gkXApCSpFqdX52EaGKzAUdg3y3/OCN0aLLtO2cjsPL+toSC+D6jnpOz0uhfVaDgNkrsQ7+nvSLIcVauq/+vWODkBSxJEZwMttEC+UnDWUJ2sw3A/1xarLlSjmDrqlRo3+y5l2gzNjIjv48KfeIDJkzUjkRtw8fFydIjdekqPxTpwLppGPcNHaPUlZtVGV2ONMkjVMnmwgnWotqnx3StO71W28o1NvmzdNWIQcQSBA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(7916004)(366004)(9686003)(86362001)(66556008)(52116002)(38350700002)(38100700002)(83380400001)(66476007)(5660300002)(66946007)(1076003)(2906002)(4326008)(6666004)(19627235002)(33656002)(44832011)(6916009)(186003)(8936002)(26005)(6486002)(33716001)(8676002)(6512007)(6506007)(316002)(508600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?bgsJl7+a7ScxwUCVNGd5ZXbt00BAvgVk3hlI34tPSImvSNeBTMsu+DOBj8U6?=
 =?us-ascii?Q?rGUU4FNAe3SUVNc9Qqi9dXdJt94r6ITgWckuLEP0dTo8Drpy8KZsHz9AJ35v?=
 =?us-ascii?Q?jrUIcoMeOh4pe88h5Z2BdSvaaoGSGwFQQqd1molq98lybmmsdLxigXOhkXYs?=
 =?us-ascii?Q?Ql2ULhU0Pxn6KU9ClIVDMrSn5z35r/BgO+olaLQZFRXPlkcpMGpYEb7FczRJ?=
 =?us-ascii?Q?wMWhxQY1wduLmya+NTYGK7ZeprpUVHWM3PteaWXy8ypiT2fWjAEwDiNRae2W?=
 =?us-ascii?Q?OjZnCtYq5gcN1GWGlG/JqxNOzd1S9ExaKid8t+2oGfh/VuaNJ+LgrWOOTIWd?=
 =?us-ascii?Q?V11RXbs9iaG/Hv06Dxn7zCd3LLWwaSARse9PCHD2p9nqsEeLe1yZOWm2CTr0?=
 =?us-ascii?Q?UAiFB/aJGcW/e9FSId1OKV/uGMjD8HuNpQfefAz3rN/0VOKKLwMuMnIC/d+1?=
 =?us-ascii?Q?rBXpbl5FuCGrBcZcCPm5OXTyw7clWFsu/UpeUpEWrr9l7qQg0hhXkoCnwxMm?=
 =?us-ascii?Q?cRJLvLD13vu1xr/FICgBMpfceUdyGjXHUOgxtBJhRXMacLzwdqlEhofIzs/V?=
 =?us-ascii?Q?wEcxCJkl51MO3lXVu2PXkp8V8LLP3X3DyfjyWbpT984b+G8BxABo3Heodeqa?=
 =?us-ascii?Q?k9eihHRGxzuu2BdM90fK4C0DmLUz76ocxX7Xj9t2rdb9BeRVhqEdGDEmZqa2?=
 =?us-ascii?Q?EIn4+YRC43IHezmNMXFsP1QQquDABL2gNZ98AtULD+OSDucslAt/Dv3xIPQo?=
 =?us-ascii?Q?p09AoSjh/Wk7pnLDb+tYqjEriSdPiVAgJAXfekIwIoTTtBUFfH2GHKtLwtfY?=
 =?us-ascii?Q?SiQv5PZ1OmKzUWXKo71cheue+8mEwYc/7Kp+Y+zpeS6FCpAiCJSFVgWV4Z65?=
 =?us-ascii?Q?pCc2+W1/ikNZi2sCZCdrPkGhB4jym14iarXvrwSWqQS1c3HTqUGU/5ck1Lb7?=
 =?us-ascii?Q?PWqnZTSxTD++ERzAYs5zwL60FEBh5OW1Q+nf+gZez4/gJKeXEBvYHdAn6tkt?=
 =?us-ascii?Q?30laLMt3amzPBDX78tSnczWTjyGMUDoZn2sKnMI27RsfWT8S/ZYdIthXloZc?=
 =?us-ascii?Q?mEQIJ2273mKC8K9tl1tdS/q6DKsb3x95TIPdqeDBdA3uJJapJITzubYRXMKB?=
 =?us-ascii?Q?gRZVCY4qnK+1BmQ613fGYjXSqQGIwqMJlnez28Ma6qpfxUReNAznoczNCte3?=
 =?us-ascii?Q?mz1x1fHRw+5D8CSSdk3lOxAQ7PgxCKBp0Fgn4do1WNOaotx5r80RNK3g549p?=
 =?us-ascii?Q?pA2rEqIBDC52UZVA4UhDYr/LcKk9IvbVltjTwAghZinbFoVCrFMrb/b97ZiB?=
 =?us-ascii?Q?hGsq+OiSA0ohEr8OZ2rmVBJzLFGhGYrgChJHc8xn389Qtyhdpc4hYTOgeGHq?=
 =?us-ascii?Q?PIqkXmcA/g2lNgbwCT+bHcJD35hcRT/lFSKO/nkPb0bwpg6/9w3kUqXXxiEM?=
 =?us-ascii?Q?lcAt+YoQBSkvWC4M3I+rvc1kw11Iu791z88Ydclm7zhy7dF2UZyO+Rcz8muK?=
 =?us-ascii?Q?6csAv+eqWl2nugTpaCt7jt24C5ZXEJdMtdF1wbDb00Wx0OivO5v1YFyG15bp?=
 =?us-ascii?Q?v/+YSJRG3mGz1GAjSDr7+x5AjPjFme+KT/aMt1ryCc5ll5g93OvwY8sJHvoR?=
 =?us-ascii?Q?ox3M+4vdsvItN3vImozTJJlz7j3jHwJfs5vkn+y/nB2qIjnLykndxWA2InDQ?=
 =?us-ascii?Q?ZwC7Xaz5HxkXZrV1ddgyMqNF7k8=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d25a6da0-5d3b-447f-853b-08d9d058f8d2
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2022 14:38:00.1600
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UxY2SO1jYfnzuwTkVkvIVaMAuY2g6AI8qpMi45HfKB+60RaatRjV04LigI9yR+zlFGX57yrA6mcg3XM2onsaqeInLUxGu3R0MrsgGJ8LUrQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR10MB5460
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10217 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0 bulkscore=0
 spamscore=0 adultscore=0 phishscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2201050097
X-Proofpoint-GUID: rFv62dZcmjYRtjm9GQpQlzOTobkBvXD_
X-Proofpoint-ORIG-GUID: rFv62dZcmjYRtjm9GQpQlzOTobkBvXD_
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 05, 2022 at 06:04:47PM +0530, F.A.Sulaiman wrote:
> Smatch reported memory leak bug in rtl8723b_FirmwareDownload function.
> The problem is pFirmware memory is not released in 'release_fw1'.
> Instead of redirecting to 'release_fw1', we can turn it into 'exit'
> and free the memory.
> 
> Signed-off-by: F.A. SULAIMAN <asha.16@itfac.mrt.ac.lk>
> ---

Please say what changed in between v1 and v2 here, below the --- cut
off line.

>  drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c b/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c
> index f1fc077ed29c..5f09b3ef9459 100644
> --- a/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c
> +++ b/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c
> @@ -361,7 +361,7 @@ s32 rtl8723b_FirmwareDownload(struct adapter *padapter, bool  bUsedWoWLANFw)
>  		netdev_emerg(padapter->pnetdev,
>  			     "Firmware size:%u exceed %u\n",
>  			     pFirmware->fw_length, FW_8723B_SIZE);
> -		goto release_fw1;
> +		goto exit;

I replied to the v1 version of this patch to say that this path needs
to call release_firmware().  That's true, although my proposed solution
introduced a double free.  The better way in this case is to call
release_firmware() before the goto.  The pattern is "unwind temporary
things and partial iterations before the goto".

The other stuff that I said in my email is still correct.  Just re-write
the error handling completely.  No point in me reviewing the function
every couple weeks when we could easily just fix it instead.

regards,
dan carpenter

