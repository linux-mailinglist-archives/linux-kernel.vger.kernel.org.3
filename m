Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE0FC495DA5
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 11:21:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379976AbiAUKVA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 05:21:00 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:40624 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236933AbiAUKU7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 05:20:59 -0500
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20L7JIhe009038;
        Fri, 21 Jan 2022 10:20:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=L4bosoAbN4/8dj5qUgR0JKntLPzjfIB67PP0HUfQNcY=;
 b=nOG7EbQVpz3w68IsmkrXv0SQq4APxZwm17sklYWJFDHCk5b/yalXMVq9BjXbSiB3ojuR
 XalvOPwosi6sTowpJvjHdgbA1XWXxqaAjpqUmu/DkuwRrjhAAPnl8IGFaucgvEq5SqXJ
 zOMjtU/at15g/azOCJzXfU6Szs3tV/zicTXsCRan3XJUcxJIac+0iYVDV8ZnQT4BmR/K
 2oLkMF2OceOBESEM1aWScV0E5d/PyClYz2d8wszEjg6bMi0VEn1q5htvOVAEBKlGgJrP
 DzNLE0KYDcW9YIGhVhK17QpAR+KZyZ70QLxuApljHa7Y6Or3r5R7pXpyc69vmNXrvOTD YA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dqhykrxa9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 21 Jan 2022 10:20:51 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 20LAH2JK005210;
        Fri, 21 Jan 2022 10:20:50 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2040.outbound.protection.outlook.com [104.47.66.40])
        by aserp3030.oracle.com with ESMTP id 3dqj05um0v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 21 Jan 2022 10:20:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HkjaJN0Oo6voz1PFmoZ+6hfDK2Yvc0xpatxQ6NbQLf0vgCfoMq0HcnZnAdc+bmGbEIT10g669nGZCCMnIX31S6gmdkq59bZSor7RXm2OgWz9lEz4RRlnRT5k+Q3euIEf2i7g8L01cFNItG6vbAEuQW54QjqI93bPr489Exwt5TOlJwjuiOg4TN+7wPN5fdeE7prPmE1oW+wKS/Co2OYX8Bycf0zMtSzpJEkyE83Nj8Un9OFxh9cjzCSaCF5eakkrA0xvltf7tpV9IXK7pAq3SLhVOIQBfg2jj8HaJHRg7xjRuZCW0LmI9eUa6cZA891nekTXW9aAgbiGyNz/dOheLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L4bosoAbN4/8dj5qUgR0JKntLPzjfIB67PP0HUfQNcY=;
 b=QtGpPyIyPukDiLKrScRZQJo4nrt7FK1k81WJDnmcWIa+twJNfJ19kbYCgYQ4g26kQI6NM6xC6GW88FYJhGQ4v0czL3yqFGMPnfhjaMw0BVulp0mQVmyNHI9n5TrqzrSo+n3Ni77cvV7OrRQSJYljLEfoOo7ARJWJ3f267yIuEns8Dh0MSJS2H4QoIbxhOEoQGhmwrNVVm1kDTuLW+EVRmHnYQJY9nNWZUsGiqatAFhCdyCMMsS8TlL4E/0nDb1ztIpLQUTrmB73frbcd9n+PpB3ned/pHactHL52GWFBR/djs8Vo8wN/lXkpt5T/yjELgkb6FDysW+BHYHrPCaSnHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L4bosoAbN4/8dj5qUgR0JKntLPzjfIB67PP0HUfQNcY=;
 b=m0RibBoiU6Zib29nYhDFReA5HYwM/cUXF32zh6bquiCst7EuHYIXLIcrkVYnH6S2GDZDxVpJHgBD7nmNbKvtnUYbP4Gsb55yL7vksly5wdFMZVlQPZRlSLb1B71URPzZMbmgSMLa8DfSiYQbvSYTjOg3KJWONhEWrSr9J/D63Jw=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by SN6PR10MB2495.namprd10.prod.outlook.com
 (2603:10b6:805:40::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.10; Fri, 21 Jan
 2022 10:20:48 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::c13b:5812:a403:6d96]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::c13b:5812:a403:6d96%6]) with mapi id 15.20.4909.012; Fri, 21 Jan 2022
 10:20:48 +0000
Date:   Fri, 21 Jan 2022 13:20:25 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Moses Christopher Bollavarapu <mosescb.dev@gmail.com>
Cc:     gregkh@linuxfoundation.org, laurent.pinchart@ideasonboard.com,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linux-staging@lists.linux.dev, mchehab@kernel.org
Subject: Re: [PATCH v2] drivers: staging: media: omap4iss: Use BIT macro
 instead of left shifting
Message-ID: <20220121102025.GO1951@kadam>
References: <20220121093722.320082-1-mosescb.dev@gmail.com>
 <20220121100837.337094-1-mosescb.dev@gmail.com>
 <20220121100837.337094-2-mosescb.dev@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220121100837.337094-2-mosescb.dev@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JN2P275CA0005.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:3::17)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8a5f15ce-558f-4d32-b852-08d9dcc7b103
X-MS-TrafficTypeDiagnostic: SN6PR10MB2495:EE_
X-Microsoft-Antispam-PRVS: <SN6PR10MB2495D13A8E5EA2EE7317B29F8E5B9@SN6PR10MB2495.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2150;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sUraLkTnsr3FNJHORtpmaQ+2PPy//UR2CRUQ3EKTRKN74ZuXK1BxuZ72sp+m3Vu2mffw34zhJXSjIrFsblKUb7q+1c8IOTSmdiPtV/PIXKS9dk1KCTHM9f9qofcnKXrk4Ca2tWXOyarj9LfWkt/YamOV8ky2pKiR/TFuftFiVmLPWhrKGinR1gy+LsTk89SuXOj2nTej7QSGkVxcqbsvUdm/dcJHmW+mqphyZMupkRrdfsPYArCjFf3XnJ0a4reFtp5BdJ8+m8jcGaVVqiUJ0P+EGAJJju1x6GYg4IydC1pSk6Lqz/q0UzigLRiIlrxJM9NYmYtorT0tvjbwMdLGTYcwq9vpAG1u/WH83ZuCX+auJe1FltY6w4ObN5Go9EctsQLWAcbsGvn4xi8L3YQtPgkAzf9rjNPJ7VfNuShl7eHl+Yg43sBPrgHKlXPwyQCeHkbRScVC78xZL4ZaV9U1jR3bfOdu9tjlRVJ4vZcegCxtt133WJ1GfqNZXRTxq5XZ/U2NoSkf3V7++i1LJ+njpNNPh5icm0N6Nq5Q22jL4Rk+slNlAbc1BlR1BTaTVfdXAC7PznGl1GuGuZJ5vtSEH63OodyqkrZa1SSuAl43G5PxzTrlOphevSx4aESJ71ue9KzOUey/+rF2xjwJFoTm8q6+7bJ4gO/rv/I6kheLyK3e/8JzqhRqBjHyOuhhphjrPJDHm8IzUXc3xgUcVHvEI9At79XgxdhvE20A5byp16U=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(7916004)(366004)(66556008)(66476007)(6506007)(9686003)(6512007)(1076003)(66946007)(2906002)(186003)(44832011)(8936002)(5660300002)(6486002)(508600001)(6666004)(4326008)(4744005)(86362001)(38100700002)(6916009)(33656002)(316002)(8676002)(26005)(52116002)(38350700002)(33716001)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ttBi0q9uu9p8AyNEK7VOY5HtnM7XPxHsuehtAAgKWzRUJ0KX5JGzIi4H9qi4?=
 =?us-ascii?Q?Sp/4bZuUsW2BnNQcKH6KOObT0DFDvzcOLfW2jMWxX0Z9IFcSYB0TmouBAxvw?=
 =?us-ascii?Q?gyckr89yfNGzaBrro6NAwzL5KpDBemScbOmN0qOJ9zYRdlnhZTbsdrlGdASC?=
 =?us-ascii?Q?t5G6/dqOvmqUzzhBMDWwiNtl65LalaesUTVxJdDB4zwGn1b1YSInj4hw7ghw?=
 =?us-ascii?Q?GqphmsBBB/+SlR4da73/820aj5MLrutFOjal5IrUX08Pee9+8iRqmWnCkPnu?=
 =?us-ascii?Q?WfIXJFBIr76wyg8xVS5BX70Q1/uE++69Ws+7/3lJ+KntB9ca27hIFrJfBucP?=
 =?us-ascii?Q?RLLrh6s5pFnmHVi5H3+dGqdL219dN2WDIr2dU2qtkKq3lvyqTMS5BCACMe9R?=
 =?us-ascii?Q?WTH/OfyiZ6ZGo2ilyBtwug5uJxDdEIneHApegheyUYqqU0hoXqB3hNqNf9cB?=
 =?us-ascii?Q?Sjw3UMfG6xoAfzMtCGJc/0F52bR0cxUe8NycZbiLBo74I29daWSq+L3iG5E8?=
 =?us-ascii?Q?TJVaAK48E23fXCqJLhRgOLmL35h6lPSsmfm5d1R32NqheBrvYPkAOpvZFkmP?=
 =?us-ascii?Q?IcYb2+I9/PPcpJzHLuq+S2irufuM91gflZTR2+zK+4Hkbnx+UntaimCXfULO?=
 =?us-ascii?Q?jaxxWZNyJkuFbROgUgvPA4ckG5Nww80OHPgZFZV4emkCdTV7wO5Lxiq8chiJ?=
 =?us-ascii?Q?ipveTD5OOAMuNGaKSfsk1zrvN221Ig+UH3ABbtJvf3cdewYHGGLRIQ3yQAEl?=
 =?us-ascii?Q?Hq3lpqZK1UiPBwDYpCd38Sn8Kl2WHRT/+EehR+Qft0HEsyXeaSFa+bCxAYYl?=
 =?us-ascii?Q?fpZZcts0suiA6Iiz9MnrQPO4oXwBdWttAGCSN1DX6s3FJgYDvPsDi9NlmhpC?=
 =?us-ascii?Q?DrVPGJWXgHi7mFi9RnGQgn72/0ppSeLKScEHtTUjT+fmmewUmF5c1ZN1uSG9?=
 =?us-ascii?Q?qamaBO2t+r9uyaZtI4iF29uJ168mXlisfKS/QVVc6uDPRy/gKw19rfguB0BO?=
 =?us-ascii?Q?8P/wAWPjAQ/vo59g+3r0TCYDrztPEjRQkYpr/kJ64H2nb8otn1XrGWvrmRHx?=
 =?us-ascii?Q?/9J8ooWTpmMAefRz2f/VHyHLsEzr3kqoiMvGJYD8K4TXCgNXR2mkaO547uso?=
 =?us-ascii?Q?rThbP2+iz0lBMC+kzGygWki0dyk76tyB3opOqnl6dnI/b0dWKMwSrfuQkk+i?=
 =?us-ascii?Q?X+3ZCYlfaT9wVUE5Rtx7qGs6B2KpqqBi7QUpNlr5spKS0Ca6CBbCWp7K/L/x?=
 =?us-ascii?Q?61yp4SL2KfBgq5ue51mIbO0E854NlQA8sbkIcwKoQLYpzLzVg/9v7FZVeAWE?=
 =?us-ascii?Q?h1/3lfUEMZlmcv73ueFQYmdpfIjWLcDq2iPlqr5inw0mVo8qj5EXCsbdouct?=
 =?us-ascii?Q?SRLipv6892KC9p2lbjtHK7tWTNalOVykX61+7rRcF3OPjiKXUZShqkzrXx5E?=
 =?us-ascii?Q?M6Uq+HWUU7Dqx9yRBmmr8KNM037DQ5icvmnCJQUs2l/u5nX53GHJigvVdPtP?=
 =?us-ascii?Q?PcczJsYLpqAqXwZW4hLhrvdw1gxMZIMVyJy+eaMFPU3MkHppx6gnUhiqGEsy?=
 =?us-ascii?Q?GZ5sH/9yYk+Uf0zFNTtCO2eiaKBN+BW+4ihxx1KMfSiJC1R7Voz+KVk52Anl?=
 =?us-ascii?Q?rfI3e3Oh8S+ruPDoqreEZcq7G89f+fdNf5WtG3cn38+3Bj7P0263K+HwJ6nr?=
 =?us-ascii?Q?RdmuAaBD0Ht0YUUFWAkLmVcZ6TY=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a5f15ce-558f-4d32-b852-08d9dcc7b103
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2022 10:20:47.9642
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f23GLBw4mwXOGxuSnQV+sgl1MdeGc12EYM/shl1J3fpTd8IjQBGxNuU3Gtybg8WGr2YRMnfYwpk4F0Z46k87ajMdWNlZQbWmkzF2IvKJHks=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR10MB2495
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10233 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 mlxlogscore=999
 malwarescore=0 adultscore=0 suspectscore=0 mlxscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2201210069
X-Proofpoint-ORIG-GUID: xIVDmSaHUhPc5tV5zl7AmuQgsV22FZil
X-Proofpoint-GUID: xIVDmSaHUhPc5tV5zl7AmuQgsV22FZil
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 21, 2022 at 11:08:37AM +0100, Moses Christopher Bollavarapu wrote:
> There is a BIT(nr) macro available in Linux Kernel,
> which does the same thing.
> 
> Example:  1 << 7  is same as BIT(7)
> 
> Signed-off-by: Moses Christopher Bollavarapu <mosescb.dev@gmail.com>

Thanks!

Reviewed-by: Dan Carpenter <dan.carpenter@oracle.com>

regards,
dan carpenter

