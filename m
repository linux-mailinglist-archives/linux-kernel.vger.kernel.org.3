Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89254464793
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 08:05:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347088AbhLAHIx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 02:08:53 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:58720 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239960AbhLAHIu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 02:08:50 -0500
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1B16IB69002539;
        Wed, 1 Dec 2021 07:05:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=QX7ZIOhaakDFbw2lcscBXm4RdlCc/tgvmoK6+pmgrkY=;
 b=C/oP6V2rAZxfeY3DxhzB1vxk8MjDagVV2JjwIMvUQf+eIpJtJfkdPrOQRcYe2Ht8Z/T5
 H0e7jyQfVIZlho+TrQrdggydxBBd1u5Tus6HyY+cVs58qEVzDiuU9zWjB8VvcyqiSCxr
 6TdLgiwSU2KddvG989iGxyuO2j3tEAQQWkiFQOrP36cQXC2CpIULH5ykRvo0vRSklESL
 w9z8sY1eXA69+PIe0jHxaOzL1nAIEbLwyNp1tQ4yM69mzin/VvJfRuMH1S04WI9VGrRI
 TWuRpDFuBJOd9J5XlRRXoKcn0VWjVKof1SY4rKa2UUDfgB0NvmEaqQgv5Muex/AjlPhg fQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3cmvmwynce-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 01 Dec 2021 07:05:21 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1B170LPB163438;
        Wed, 1 Dec 2021 07:05:20 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2102.outbound.protection.outlook.com [104.47.70.102])
        by userp3020.oracle.com with ESMTP id 3cke4r7yks-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 01 Dec 2021 07:05:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kFndhiUIzR63TLiQiaC8WrKLN3xy8hweYTqmacED9vmaEjYgP/41GyoqPOMZ2m8v3qajse6Du8S2EAtrBk8myoZWY33IvOLedyf6EMoD4z7tZBeDTiIiKNTGoktLRxRAHIqjVYi5THLpGcUNjtOtgWpRyBf375qc+4j9qTh+85GuWP5wxkWuzxWY26SO5K3Kkmo2hGnGH138rnPYZ4eCUOF3nw+Y+00MSBsW/gVY3XtJ6XaOzqvyd1kQhCMylkjLSPJ7+bke2ozmhZfp3Bj9QNSrV9mwDK+oEmjWETMxVwab03sdDRQO15N9FhjhoJZo5Vev82Bs7wXQffJWv0Q7uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QX7ZIOhaakDFbw2lcscBXm4RdlCc/tgvmoK6+pmgrkY=;
 b=FUoEMV+4XKmnBjfOVtG3rEK92OvR+Xb4un9ekGGiL53IIx6cYt/ipetDFXeSKbeqZrqtrPZQdqf+BFvxJ2G3OClAmKbPzZlTfKt3BImyfumiBNSbTACq8dcegq8Gv1lp+nOYkPfjKjQ17692oqvKEe8B3Mkegk1WLfCzCaidJQukE7qWmqb5dgT3umt7LmJB6ckzwPEih6uVKiRbRbU2U0TL7jzH+a/kfAlyC34YQYIHgy7JcgH7Nom3TRzk316Tbn/6m5uvzinPki88ItMGunocA4sxkDiUJR0QQGjPrMptr+IFY3f1turGnVUB/GKaom7r+IyTI4BOnmNTuUdbbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QX7ZIOhaakDFbw2lcscBXm4RdlCc/tgvmoK6+pmgrkY=;
 b=jPGdo7AWG/qi3soN9949EONcsxjhbz7XxTcRUkwLj/I6PQh8xmW83YSDddL2f3Uxrf8tZQqd/mfHQeV+anm/6dXuh2fcN2tJ2zzMqZglFhikhhavs9/gZXsHAO18d3G1uOhNHwmNoTBkNxsRioji36BALmoIYv9J3GNEwQTAp0E=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by CO1PR10MB4641.namprd10.prod.outlook.com
 (2603:10b6:303:6d::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.11; Wed, 1 Dec
 2021 07:05:18 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::7194:c377:36cc:d9f0]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::7194:c377:36cc:d9f0%6]) with mapi id 15.20.4734.027; Wed, 1 Dec 2021
 07:05:18 +0000
Date:   Wed, 1 Dec 2021 10:04:57 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Yang Yingliang <yangyingliang@huawei.com>
Cc:     linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev,
        gregkh@linuxfoundation.org, paskripkin@gmail.com
Subject: Re: [PATCH -next v2] staging: rtl8192e: rtllib_module: fix missing
 free_netdev() on error in alloc_rtllib()
Message-ID: <20211201070457.GD9522@kadam>
References: <20211201062908.1656422-1-yangyingliang@huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211201062908.1656422-1-yangyingliang@huawei.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNXP275CA0023.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:19::35)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
Received: from kadam (102.222.70.114) by JNXP275CA0023.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:19::35) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.22 via Frontend Transport; Wed, 1 Dec 2021 07:05:14 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b54e8db6-4b62-42bd-3faa-08d9b498eed0
X-MS-TrafficTypeDiagnostic: CO1PR10MB4641:
X-Microsoft-Antispam-PRVS: <CO1PR10MB46418F492BE7C15A9200A0D58E689@CO1PR10MB4641.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8FoYcNP0MY6Sp3DF3OK5m6J2D65ObygIqHiSpcs+dRH0zlPwj5FSP+zGUKvAfVic06g5tpmTXu2JguDLFjsqlMaPbpJHQfkg28w3i40aRiEfqPZ4eA91Ic6Q9GClIB9yxQiuSpt7nnIQBmRDQwXQWwI95sauG06d0WOblvRmH3Cz5g5XpS763xvtsoT/3OY5HzDQoF5q04aqSXF/3KuaNnZjnK5ouY5zesNJBE2SErzaMRoUKC6ieJLMaFRjVb9iGDQpxZnwnnonthLyjp2HeaPSE5KPE1V6wqNtKH+ZwtNYjKhinA5P+de6lfff3po9QMnnklqwZhw3FMlJHxbqTYH3h1Mc5t4uO3xK6Vvs6MubN8r75S7CZi76x35b1GVJ9d1E6h+vN/sOq4LiqRHXhxdrbQTeDw0ygy/qXo/gpQGbgnmwYEhnEqMJ4L4VHWd3yAFSRlnV4FzDoQAi/KlCF+YnWf7ZtgLPQMp/zWLpoRxsfoEIT2X2ikpFmNVrJnMNAUpEq4tDibXb0XBs4Ao2v24MW1q6ULx96WjtYbQb2pGnL9FxINAq+YX6J8nBc4bOCyjujI9uIrtQVgEiRkSzfJXQb/G0sHVjCRGZD94JHu/5s0DCDVQ3xdjbPyEusSbNuLzXDeiyWEUNzoIIIic0/VFjJHIhhRuUsqw17XixI6DLEHRKnUOk7OWcQHQvCdo2o+Wqy8U88vwGVfWXAhkm3g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(52116002)(186003)(4326008)(86362001)(508600001)(1076003)(55016003)(5660300002)(6496006)(6916009)(9576002)(33716001)(38100700002)(38350700002)(8936002)(316002)(9686003)(66556008)(33656002)(6666004)(956004)(26005)(66476007)(66946007)(83380400001)(8676002)(2906002)(44832011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?QjqT7BpKAPFseQiqSj3ZRsz0hM1m6Cu2gKVBqqGEaBx4rP3p6IyrKVAHpu7t?=
 =?us-ascii?Q?Mo9XifNsj5a8wIt59OX4rZzymh8ca4IzEUH4IMe1onudZKcR0I/or/VJxg2E?=
 =?us-ascii?Q?+urE8ISK2baWnI29ntd2uGto5oOEc8/uNgaYcpoUEh9FgBm20Wfcprl07omB?=
 =?us-ascii?Q?gV8xpoUmVAIerg2eaO7DDyzrDRCmp2gU3w4b8Z+Asn+h+da+n8K3Ea50tIKE?=
 =?us-ascii?Q?ZSAINPeQPSi4IXXVoAq7Ej0srLT/eTq/R+un5SlyPzuB4DVS4bLQuUWlQL9M?=
 =?us-ascii?Q?Hly1u+aQYPsaELyB4cZs2R9OHfF8j3HwtoExh6s3OQ5iznYpELJFjiR+UBxq?=
 =?us-ascii?Q?cS73tvrk+MbRLuPMFBkeaAN61y2dVN4fYC5CaCsfLrWCAO9LNZdAblfslWNQ?=
 =?us-ascii?Q?sqMiii+PDSbJlCTGscBZQIdspKZ7XbAdf6vEDr5OsFhnwFO7q6vG3SfaKwFv?=
 =?us-ascii?Q?3boUo5vKWd+bPpwl8ORI5m7USPooHn1+QkqGj7wuMh+O3Fee5AOnbSmJQPJ1?=
 =?us-ascii?Q?TpbwxAjguS8QN/p35+0Q0Hz0unUp2akU/M+3kxncwcxjMrdYD11F7pigr58Q?=
 =?us-ascii?Q?NqW5Kpk6aLK34AvswdQOnd9q2lZUqsLEhY4TRXIsrDks+oAeLDQ0c/5hc9oY?=
 =?us-ascii?Q?jmD0/JiEFEsGiRsURSsn0FILZkGP7KjIzGGbX34tRkrhe0wnyiqJ6nmrlPn2?=
 =?us-ascii?Q?Mr0hHe3aeAcZ0/3Pp7/xdHKD+ztVkzC2mcmHpR9EWwsJV5+i79dtIOqBhGSf?=
 =?us-ascii?Q?jb9oiflhmZVFCVRemMJujjG9m4XWqXoTk8lyzcmURx7p0e6AAvOYzOa75Gnl?=
 =?us-ascii?Q?b5MlHZn8U2yoO5Ot4ti7/QHR7PDMZh8JVlW2zlG04QJ/3zgSul8cbln5Tkcn?=
 =?us-ascii?Q?7eeLAcJuD3o1ux/0FV19WEsp+KUE+T+gN0/cV1w2+Nz21FGtJKBfkq1J9XO9?=
 =?us-ascii?Q?CJBr7kKqlDnplKx8ooV6facj1P3LJ2qT/AcJXto3g8w12+QNsPpndQ/pYnOB?=
 =?us-ascii?Q?BtvnShF9PTbsxy0rUtXN35M0mZloaktPxCXce3jeMQnYEo1ampHwTvUZRmtW?=
 =?us-ascii?Q?lDkUAen9Q0Vkmn6XX23BNMNvKUaFuzkc9N5PjNlovjaWgs2Wy4nOhroqUf7Q?=
 =?us-ascii?Q?qOTiRvuP7pSJzV3QMJ65lTXVyvzTA3N6FrOW7odxac5nNetC+94yXINrZZVE?=
 =?us-ascii?Q?nRzp5aZ50J4k813TyFGNfhHeh4Z5T1/sJy7NzOQyXGvo05oh4bd+GPaVrLZ3?=
 =?us-ascii?Q?ZVLIfmg0z/Va3XUASkIzq/hPnwW2AOht146nfHehc7ZfPQ9+8bTg0TmJII05?=
 =?us-ascii?Q?IyFQtF0gV8Hw7quiiD497DeioPXTl3bpe3cpLLgvTpCSh1WpQVZgncEckkX/?=
 =?us-ascii?Q?Dudlc92TSK2kbb0k+tKDadU5wmhC4/r8u8zm5ZFIwoggZOTW2eatQfUxPGKd?=
 =?us-ascii?Q?baQU1cFbOhdx3H5Yqiv9zVbvpk5ROe1HDxfO/8tUU5u9u9wU5AsOmBXCZ9RT?=
 =?us-ascii?Q?Yi/+GtXZ2qW4wWZ9GGOabORa8S20L7WwyEOYj+7x9i31xx8QbTtB7MuNSgqR?=
 =?us-ascii?Q?uybqLqVMJh5kTePix2LO1KSSzrVIKAmZ+KBfrGaxvk2ogEM4T9JHtxrXbZHA?=
 =?us-ascii?Q?uXt9mLQBkxsVOmY3us6L9pJCx6axm159qeqKesSggZ+Upj+ihXpNWIUwRwxe?=
 =?us-ascii?Q?ouxdRnXspRCGn7hsLLRAEkAHBIE=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b54e8db6-4b62-42bd-3faa-08d9b498eed0
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2021 07:05:18.6038
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rjx3zedo6rtyO6DjKjIC3JTxokgh1H3kxMAsAefF07nskxSH95W0bfemjPUGu4pqAffO2Z/GQjsmTSQVpRdn4Z+deide18JrwMTglcha3/A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4641
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10184 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 phishscore=0 suspectscore=0 spamscore=0 adultscore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112010040
X-Proofpoint-ORIG-GUID: qv41j19w2nbHc2mmjSAqzXYgtfeNgQ2e
X-Proofpoint-GUID: qv41j19w2nbHc2mmjSAqzXYgtfeNgQ2e
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I just sent an reply to the v1 patch with more explanations.

On Wed, Dec 01, 2021 at 02:29:08PM +0800, Yang Yingliang wrote:
> diff --git a/drivers/staging/rtl8192e/rtllib_module.c b/drivers/staging/rtl8192e/rtllib_module.c
> index 64d9feee1f39..105c58e749d6 100644
> --- a/drivers/staging/rtl8192e/rtllib_module.c
> +++ b/drivers/staging/rtl8192e/rtllib_module.c
> @@ -121,11 +121,12 @@ struct net_device *alloc_rtllib(int sizeof_priv)
>  	ieee->hwsec_active = 0;
>  
>  	memset(ieee->swcamtable, 0, sizeof(struct sw_cam_table) * 32);
> -	rtllib_softmac_init(ieee);
> +	if (rtllib_softmac_init(ieee))
> +		goto failed;

Please write this like so:

	err = rtllib_softmac_init(ieee);
	if (err)
		goto failed;

Otherwise it suggests that rtllib_softmac_init() returns boolean or
something.  I suggest changing rtllib_softmac_init() in a separate
patch 2/2.

> @@ -2962,8 +2962,10 @@ void rtllib_softmac_init(struct rtllib_device *ieee)
>  	for (i = 0; i < 5; i++)
>  		ieee->seq_ctrl[i] = 0;
>  	ieee->dot11d_info = kzalloc(sizeof(struct rt_dot11d_info), GFP_ATOMIC);
> -	if (!ieee->dot11d_info)
> +	if (!ieee->dot11d_info) {
>  		netdev_err(ieee->dev, "Can't alloc memory for DOT11D\n");

This error message should be deleted.  The kzalloc() function already
has a more useful message.

> +		return -ENOMEM;
> +	}
>  	ieee->LinkDetectInfo.SlotIndex = 0;
>  	ieee->LinkDetectInfo.SlotNum = 2;
>  	ieee->LinkDetectInfo.NumRecvBcnInPeriod = 0;

regards,
dan carpenter
