Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCF374925C0
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 13:34:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234111AbiARMe1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 07:34:27 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:18894 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229604AbiARMeZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 07:34:25 -0500
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20I8L5M8007900;
        Tue, 18 Jan 2022 12:33:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : in-reply-to : mime-version;
 s=corp-2021-07-09; bh=VOeXEPmwdX0pq0fpPNW1zWbva7JyjpxpTZyAYPXMRWM=;
 b=lSzYvAU7n0BEzHmKXmTec/wK3bD1toYYWDryxKVUL/jW10Bxwdc9ze7XBsH/hVP8wkhE
 wu7AIBufWf/fE/MMAFb31JyTUCIc6fEd90rmlKZw/Gkn1RH8cVaKU5u1Gu2+tsb4u3na
 L3Y1vXgPEJqeRLeGugR+iCyAyaCYGH5LzJZ4IZAVcTE+Rwngj5vjGe2pHhknYwiACfiU
 aCXRofd59Bj055/nQj4mXsBnqecF1OkyKS5cwldRG7c2gv1v//xu2aYEY/oi8rIB9J4l
 wiAtLpQwReOgRnQ7A0UgayL3ws5SxgY2Lqq5x+sz59P3vTUepkLsJ3ACpyg7pgpEwjDP dw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dnbrnssqq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 18 Jan 2022 12:33:55 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 20ICGM2s044407;
        Tue, 18 Jan 2022 12:33:54 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2174.outbound.protection.outlook.com [104.47.57.174])
        by aserp3020.oracle.com with ESMTP id 3dkp344ttg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 18 Jan 2022 12:33:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JB0aQ0+RUldceoyAprqJDfgeakatSaWAFPnAddTjo3tJdMA1k2JhFC7X4YzVR0LsSSVzMXuNJQT8vtc1ZzcOuUEI1e9Q+Hcu0dFmAG6UTh3Lb0L1t3KIwgUXLZC9DILLwTILyAEL8y9ZaVaZc8vNs27bsfvDv5pMWu1nysJIXQ2G4X8M3nmbOYrzyVgWL83B0C1SGN8SDOsYrmRFR3hY8714Icz5W/G98xUaY7OvHHZAvNlCnXfkkoTSP+VLleU2iULv/2HLx4RFY+ycsOUd8rAfsikQWZ/27lAYIS4Xq5Zfa/HOMEUhpb02Me2w1v3NdmTXShTH3EJ4vCFXMf2h0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VOeXEPmwdX0pq0fpPNW1zWbva7JyjpxpTZyAYPXMRWM=;
 b=X/wqBVh0ubgnfCenB+I+eTK0w1/dT+FmzQ49nSodl9ssn+dOwedV13gnEvb7PXBioGJwAx19rTVgApqjZqUlv2Rkw2Sjg2ek0A3nceYGliqle28mILtJyI/oSTWuulWVkrr9kNa/NE3nHw6GjrSElTjAFr8qoYWCZuCAGWG1mpGy4pcQ33enmObRJHzh0z9qIaD48Z9LIJn25P+X91KENCwJt6MOeMA2smBQsQ0d0UWp5CGEUTNqA6xykGE3a0wUHAGjYjzkdVbDoyVMH/dt0wUIt+bNrTSegeKq2/IBpdatgsVDOZXnpzGXePW+5Mi1j3hv8DMJf1WBk212GACxmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VOeXEPmwdX0pq0fpPNW1zWbva7JyjpxpTZyAYPXMRWM=;
 b=bCv8uYX+CqpD6GwgEUAz5GCqpn/TaU9vwmmb1C/MBOusYJzcOGccoKdfJd8QWdt2iG0RYkh32jTqgjm7UgdzL7ZcwhvJnKhRCkjWZQdEt+KWsGdCT7NyPUTGrb+kyLPiUBDNFxsc+cqPvFUglr/05su/G3CV8xTgfGlz+sH6c1Q=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by SJ0PR10MB4799.namprd10.prod.outlook.com
 (2603:10b6:a03:2ac::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.10; Tue, 18 Jan
 2022 12:33:52 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::c13b:5812:a403:6d96]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::c13b:5812:a403:6d96%5]) with mapi id 15.20.4888.014; Tue, 18 Jan 2022
 12:33:52 +0000
Date:   Tue, 18 Jan 2022 15:33:26 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kbuild@lists.01.org, Jiasheng Jiang <jiasheng@iscas.ac.cn>,
        keescook@chromium.org, arnd@arndb.de, gregkh@linuxfoundation.org
Cc:     lkp@intel.com, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Jiasheng Jiang <jiasheng@iscas.ac.cn>
Subject: Re: [PATCH] lkdtm/bugs: Check for the NULL pointer after calling
 kmalloc
Message-ID: <202201150641.NvpCoUdU-lkp@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220114082119.1270966-1-jiasheng@iscas.ac.cn>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNXP275CA0029.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:18::17)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 82fdacf5-75c1-4dec-256d-08d9da7ec8c6
X-MS-TrafficTypeDiagnostic: SJ0PR10MB4799:EE_
X-Microsoft-Antispam-PRVS: <SJ0PR10MB4799F8C6F13060190D3AB9658E589@SJ0PR10MB4799.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1tYX3NmBhAziAEEXo53dgCwIAOe4fgtfB8KHxesLbIIDSJd1MOu1swQH+IrP05/fyqL+wvsgn/IXz80gehy7eiGAW00ptjEI5KIo9CPqMjYyTL1Rsp4ghkuFr4xFjoR8n8VaFh8UiPJDojdmGtMWxo/eWkLJ283NpySFBVcduMsS8pdlBHferlN/B6qN06/QoDh3sNZeIgY4LKKf0WF6GqVkjXUwnM7mI3JEqbI/kb1vnievGLrvFyL4povsMdkguRGXhr7pnoImRd4uHZfXoXB9ZjlCaw3GTUE87mvH9iE7Jqh5FZd+TGmbMv8+WVvArLGNG1kHCTlbH4LZSI1je2e2p2uQPFFPOKOcQu0CxCbDilJHX1nBEQR8mh0zqVHTVyh/F7pIXWNl5aL/Ba5cvTdhVgVlWSWL5QiNKAtB0Sv70C98CXRMv3kl0K1c02QHE9/LvZf3n/hT3Ya50ZdQs5pTpy2OUMPaMIYjWtbBPZG+NywXbbtSKfd62ZGB8nawaHrnL6/ZrBOMMcb0sCcVKdpZmu/YyH6laT97tZsH/jAKvz6CxsuHGercCoPRQ5Skex9EGpDlBdSCSLMfmgZ+TJmPho8D4298tKP6jBQACzu+/qcnNVodIsfCn8xQaVn81fSO4pvnTQMYQ0iuAzkEJsiNxX6YAm0uGNN1QPV6nV2LHZoN0pU7JvuNXiGTlZcqqfjjMr4NAYLPMsGXahS+1EQDc1u59P320FCQ4HMTPR5fduPX1S2RqGaICmgcWIhas8gNQlThuav7fvCGv2g6jWgT2M1TGJebc/4nYR0n24UYpvTgjw7ymD2mtfGsVZmrkiKOdvhLSk5mixZi1p4j+A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(86362001)(508600001)(9686003)(26005)(4326008)(52116002)(36756003)(6486002)(6512007)(186003)(66946007)(38350700002)(66556008)(8936002)(316002)(66476007)(44832011)(5660300002)(83380400001)(2906002)(8676002)(966005)(38100700002)(1076003)(6666004)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?QFAiX11DFslTOr6IxmVWDPpZtj9FnD9LX8t1PApW81NSVsrB80mX7nY4c0Me?=
 =?us-ascii?Q?yPWJOMNVvKWrGWj2x7AgeCMVk8tDD+9FZmKlaFHy3wiT0dJIehXHSIUfZSEw?=
 =?us-ascii?Q?caaQF6yTo3ASFpENLaMqlnn/vVE0c1861Kr9d8WDHnr30WxV8JmJBLkY8SiC?=
 =?us-ascii?Q?coaNnHokOURZK1FkwN5hXJHGQLN3FFOaBWrdEVdT+Ad7P8rI88tRHzZ4EvA0?=
 =?us-ascii?Q?w0Mf5aHOA4VNmZ0jk2YSoB7m2Vj7v8ep/xYIzapFExjLntf9+vahayiul0O8?=
 =?us-ascii?Q?XNbH5cgcKXFPVAR/81j4NpKKEnUvD69JNObmjvy9YnlG316qttJ1xhiGMTzl?=
 =?us-ascii?Q?N7XQkc5zhdWP3d8QwlqY0AVjjyM8DheAuHRLvAfLuHP3Xxi2mr8LS4MatplD?=
 =?us-ascii?Q?BtsNTfsz+r4ARn+WNUedzdVsHtoI2HyMGNvXfuMSVCBAyg76Gqyg5jK/h4Or?=
 =?us-ascii?Q?+/xpNNQW6/xxA9L7xSu43E+WbgoZVDwsAIW4j5IEYxNOM/3NAFbOhit3isbd?=
 =?us-ascii?Q?acZad7x0rjaZclhv6a7n4MRpxWnVwlvtX5fsfRp2a1ZRAQY8kdZRwuP3PTFq?=
 =?us-ascii?Q?qrdO7umKCA0BwD8eu8H8ZQHwCGIJ84zphKjoMt/aWkIGr2HG6HfRBzCJmPfK?=
 =?us-ascii?Q?GYqBuOWzHbvwMOngIIsiPg6J8C1vdY2A7BwhXKA/9vFkADEa5OMRoKAR+ZCA?=
 =?us-ascii?Q?xx4UgIgSTI1vw2LJj3glMThG3s/QZxHvr9yM5TJYV9qB8UmzjYqB7ZYHuIDX?=
 =?us-ascii?Q?qyYkou/DF8nPG29YHPj1mWzxeGRcEEOa+6YCVbPRPHTcpF+uWIaULcie2DHB?=
 =?us-ascii?Q?M1KkqelMyKmpim8/L7dMIGGl37EGYvQEdJS1bkVRshW3WRboXoHL46oCuBYi?=
 =?us-ascii?Q?VbG7Rh1FeiQfZtmlt0wd6JDxOorV19JtgfSQuUqm/HOHApL9npbD9VHt+N7N?=
 =?us-ascii?Q?JpY6eEAth/j0Ivm3J16mM8PzXl8uPDSVxjR3i7b4ahTeI6Q5XE0ogmXzPaMw?=
 =?us-ascii?Q?xNY8nimUoxdDZzdlLn2IcRxjuen4K5WGi/Gr5CMPaJ6Y0OMuSYDqKkLjYcD6?=
 =?us-ascii?Q?9M/+L+0EHKmgGZmCYXgQhnhI8BqecRtqDkB1PxJTF1Dmfuz7unmavJo89RH6?=
 =?us-ascii?Q?sGWpoCD/6TKxuy94I7sOD2lgc/BqTxKvpBSQKIJc3l7Or++OQnPEvnU8Uyqm?=
 =?us-ascii?Q?ilNjNEM79VilE/I8vJFPKnWT90EpRLu1oth832uQtV7WtiaQbeJJN/LROw/O?=
 =?us-ascii?Q?FxsV1LJIvkzgNeJpoD88SQBXJ/tPP23nh/ffrTwIsaO8tLFHm8WrEf/V9HwL?=
 =?us-ascii?Q?PXu/cPR5vESDXSv+EwId0IG+Lj6BjXWQnXhfjEQZCXbIHHLZbqgoZtMjwRY6?=
 =?us-ascii?Q?PcTW59oXS5rWob5XF/yAzjCrtiE4PvcEHHH2eIuYvHDqz4Rlc77hlivSqt6o?=
 =?us-ascii?Q?gqLxC7IZ9jGncQers1OvOEkHOB3xn3EJ3ZWGL60ZxQYvmfBTEWnJ+MKhwE4W?=
 =?us-ascii?Q?YaRQDoyjWd7an7LGAVuNTPf9jP+p5oc3/oaFq7ISVe9ZHt07t1Qbw7NkPN/o?=
 =?us-ascii?Q?j9+i6+Ch2U4FIMPZLJ26d6Ydh+6Dbljju1vaXlAjRqmPQ3zIuNY50FGl2QJE?=
 =?us-ascii?Q?PwAo75gOMh71WzEhiqesdguHK4CkGTLNIchku5+XZTgiSdhdelxyxYNy4tXR?=
 =?us-ascii?Q?mUCbkg=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 82fdacf5-75c1-4dec-256d-08d9da7ec8c6
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2022 12:33:52.2236
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VzT1iZnfZPewdAlIS75FhybNJDAfbz9vJ4Q2h8Zch26xBP/wgh8V7U907/u4ykXMJC/Go3U1zx8sMmvD8tegDWy3alQ/fYjRp9Vxn5m9nBg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4799
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10230 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0
 mlxlogscore=999 adultscore=0 suspectscore=0 malwarescore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2201180076
X-Proofpoint-GUID: YDykSDtvQeM3iWMYB1ptXm7xzppUvVvQ
X-Proofpoint-ORIG-GUID: YDykSDtvQeM3iWMYB1ptXm7xzppUvVvQ
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jiasheng,

url:    https://github.com/0day-ci/linux/commits/Jiasheng-Jiang/lkdtm-bugs-Check-for-the-NULL-pointer-after-calling-kmalloc/20220114-162452
base:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git d47c7407b4c88cf66098eba8893bc38279f301fc
config: arm-randconfig-m031-20220113 (https://download.01.org/0day-ci/archive/20220115/202201150641.NvpCoUdU-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 11.2.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

New smatch warnings:
drivers/misc/lkdtm/bugs.c:331 lkdtm_ARRAY_BOUNDS() warn: possible memory leak of 'checked'
drivers/misc/lkdtm/bugs.c:331 lkdtm_ARRAY_BOUNDS() warn: possible memory leak of 'not_checked'

Old smatch warnings:
drivers/misc/lkdtm/bugs.c:346 lkdtm_ARRAY_BOUNDS() error: buffer overflow 'checked->data' 8 <= 8

vim +/checked +331 drivers/misc/lkdtm/bugs.c

ae2e1aad3e48e4 Kees Cook      2020-04-06  322  void lkdtm_ARRAY_BOUNDS(void)
ae2e1aad3e48e4 Kees Cook      2020-04-06  323  {
ae2e1aad3e48e4 Kees Cook      2020-04-06  324  	struct array_bounds_flex_array *not_checked;
ae2e1aad3e48e4 Kees Cook      2020-04-06  325  	struct array_bounds *checked;
ae2e1aad3e48e4 Kees Cook      2020-04-06  326  	volatile int i;
ae2e1aad3e48e4 Kees Cook      2020-04-06  327  
ae2e1aad3e48e4 Kees Cook      2020-04-06  328  	not_checked = kmalloc(sizeof(*not_checked) * 2, GFP_KERNEL);
ae2e1aad3e48e4 Kees Cook      2020-04-06  329  	checked = kmalloc(sizeof(*checked) * 2, GFP_KERNEL);
6ac33daa73b3fe Jiasheng Jiang 2022-01-14  330  	if (!not_checked || !checked)
6ac33daa73b3fe Jiasheng Jiang 2022-01-14 @331  		return;

We've just changed one static checker warning for another.  Plus these
functions are *supposed* to be buggy.

ae2e1aad3e48e4 Kees Cook      2020-04-06  332  
ae2e1aad3e48e4 Kees Cook      2020-04-06  333  	pr_info("Array access within bounds ...\n");
ae2e1aad3e48e4 Kees Cook      2020-04-06  334  	/* For both, touch all bytes in the actual member size. */
ae2e1aad3e48e4 Kees Cook      2020-04-06  335  	for (i = 0; i < sizeof(checked->data); i++)
ae2e1aad3e48e4 Kees Cook      2020-04-06  336  		checked->data[i] = 'A';
ae2e1aad3e48e4 Kees Cook      2020-04-06  337  	/*
ae2e1aad3e48e4 Kees Cook      2020-04-06  338  	 * For the uninstrumented flex array member, also touch 1 byte
ae2e1aad3e48e4 Kees Cook      2020-04-06  339  	 * beyond to verify it is correctly uninstrumented.
ae2e1aad3e48e4 Kees Cook      2020-04-06  340  	 */
ae2e1aad3e48e4 Kees Cook      2020-04-06  341  	for (i = 0; i < sizeof(not_checked->data) + 1; i++)
ae2e1aad3e48e4 Kees Cook      2020-04-06  342  		not_checked->data[i] = 'A';
ae2e1aad3e48e4 Kees Cook      2020-04-06  343  
ae2e1aad3e48e4 Kees Cook      2020-04-06  344  	pr_info("Array access beyond bounds ...\n");
ae2e1aad3e48e4 Kees Cook      2020-04-06  345  	for (i = 0; i < sizeof(checked->data) + 1; i++)
ae2e1aad3e48e4 Kees Cook      2020-04-06  346  		checked->data[i] = 'B';
ae2e1aad3e48e4 Kees Cook      2020-04-06  347  
ae2e1aad3e48e4 Kees Cook      2020-04-06  348  	kfree(not_checked);
ae2e1aad3e48e4 Kees Cook      2020-04-06  349  	kfree(checked);
464e86b4abadfc Kees Cook      2020-06-25  350  	pr_err("FAIL: survived array bounds overflow!\n");
c75be56e35b2ee Kees Cook      2021-08-18  351  	pr_expected_config(CONFIG_UBSAN_BOUNDS);
ae2e1aad3e48e4 Kees Cook      2020-04-06  352  }

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

