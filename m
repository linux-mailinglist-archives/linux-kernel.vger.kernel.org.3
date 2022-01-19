Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54730493416
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 05:44:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351530AbiASEob (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 23:44:31 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:49762 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1344785AbiASEoa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 23:44:30 -0500
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20INxWH6011247;
        Wed, 19 Jan 2022 04:44:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=n6FOChzqf6qXRuWNlqDQCoD8pK91ipmkcdZRvx9yTao=;
 b=uvIEauct0BFyxJ0giJI4XAAOyGMOcceZKEmyb5Ujn8DpNwzzcEu7SzPxUGoGGsbcJ4bB
 c0oaVa8vUdNjE65uYLQhZ1/S+LCte9hITwmyKPHdnhYdBseRoTqS0dcsZykK3dBgE766
 OmHNJI4UUtNGS2t9LTZy6evTEWjAuUL8eFWNMtv4REqdnTguAjSbC7JYvFWCjEtw+JT6
 zLUEN5jWeQipQBSLNayBzXAp+AL54xhgoe3zmekrW5C8CRN9qPN1d9k0BmqKQuUK466W
 1wurHY3+j712pr9XlIz6+xYd0epoQqrnAF9RN+uZIkouTY1siT+zXmbLQQEbnR35FE6w DQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dnbrnuvps-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 19 Jan 2022 04:44:25 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 20J4ajd3107362;
        Wed, 19 Jan 2022 04:44:24 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam08lp2049.outbound.protection.outlook.com [104.47.74.49])
        by userp3030.oracle.com with ESMTP id 3dkkcyjtqp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 19 Jan 2022 04:44:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JLFMUx8UUvLBdOEPLkH7yJBuJVn6YXiR/rBtYKLYzt06+zoQgSpEHb98PweiPfngAF+v4/4rvCkIaxd/6r4mdqARSODIaVote+NGmNszwYUOcbGiaFEecrZIWBbfiCKfVcQk/Rgper9WJZn9VAi1faNVwkJUz7qW9usJZ6qHnKAKkyNq47t9V2/FyFTrH+B+ve8dUyJYGHtj0xCbYyXsv9tJZJk30Ep+/OKiSi/DcqW03C5hjqnwwp44j4krHhD2/clAysmQC+Ca/wK8G/Pw4q9FVz7Hkvwr108DLqEhyjPuH9WNly+fhsUWIEBRDwmiKBqBOppXnSu/IZ6Wr6M7tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n6FOChzqf6qXRuWNlqDQCoD8pK91ipmkcdZRvx9yTao=;
 b=LDlU9tZ6wlCMGNRbf4ghvm0rADn3jOOd//rmsG78kG5c1jRgK/M8espueDIJEOsNcp9Jrs2Jnq7I+Xw5OfLijHPZfsKx635rc3FiSk45cxCSz7ZvkZoYpImaGS4dEQXQjneR8BFH67usPh/DnU0aaS9gOiX4q+FZ+kLefnwHFHOMj6nkvO0nq3YnthAyZXs46Y5qKzf5IRD8laI0uPb9qMkaL8XOUVPedtSF4ZliBhrwoUlSUVNrL/aS9zKTIDDt5tca14pTnfz6J2yYo/uCS1xYWz6E4q/zwGZeDHJSzB8Ta/mclqcmXGriZH+JzqQQxMGdwIr/kZuskzfK5/JqsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n6FOChzqf6qXRuWNlqDQCoD8pK91ipmkcdZRvx9yTao=;
 b=C7l52547NM4Kw7nz6f5BOGGWMi3u0SAoSn0CgBwrbuqoCX4yXNqeFupY0YtFUsmgICSXwnuAoLp1h7Nvr64MdfQG/C6HJAlsWey0+Jz0aLWvvWwaD2N32ejtbkYjFDt+8EryfjrUvdbW1hix8PtzN5qhQu7E66YMLvWTgLYvjmE=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by DS7PR10MB5343.namprd10.prod.outlook.com
 (2603:10b6:5:3b0::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.8; Wed, 19 Jan
 2022 04:44:22 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::c13b:5812:a403:6d96]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::c13b:5812:a403:6d96%5]) with mapi id 15.20.4888.014; Wed, 19 Jan 2022
 04:44:22 +0000
Date:   Wed, 19 Jan 2022 07:44:03 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kbuild@lists.01.org, Xie Yongji <xieyongji@bytedance.com>
Cc:     lkp@intel.com, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>
Subject: drivers/vdpa/vdpa_user/iova_domain.c:305 vduse_domain_alloc_iova()
 warn: should 'iova_pfn << shift' be a 64 bit type?
Message-ID: <202201171409.rqbXNHlz-lkp@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNXP275CA0047.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:18::35)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0a74b2d7-2b2b-439f-6edc-08d9db065cae
X-MS-TrafficTypeDiagnostic: DS7PR10MB5343:EE_
X-Microsoft-Antispam-PRVS: <DS7PR10MB53435ADA78A9C9AD6DD890F98E599@DS7PR10MB5343.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:565;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ozTeVECQWCsaav7PrNwrYhk3kjWYL/8VfOKowSg7iajhFMP7nMbUck4NPy3ihTGf7ugdOuPr0tM2O6s8v+3WgnStHJ5YOzS53+SFfDE729pz3LSgWs7oc2ll65QLdOlsqlqml1k/xszcgqZ22hjx4z8Et2V8bKYVMbdOQfcGa2eUbXbFhoMiWvBgYLR/BwY7Eye1d1U/RknrU/FByxzRiQFSlnxW1MPLIDvkt1gHsPT7fQeudWXcwB5btQonUUYcWzcZdteMIi9zqYTVXDNGq3BfStp7tQxTb/XdzUmfOuOOhr6ieB+YqeBYRcfFo+tF3FXaaom9qvRNqf2LBNZqSumHf7a/c2ZoX5TWyFPn1UXmajMDa+tn6mPj9spquMzU4NkXSF8v1k7v5PYAc3Ne7AhnjKVrMBBbSNI1OnVLrIVCwigBDKI4x8ZmAyzarxK2AJkwwd6tRAmP2A2GpS7ip7FyrQhIQa9skwvRvxzJgoRPrIQaqQcdrjkFnYYzLtx/Vr52+pizsoAZ4lkbssZdIt1qEQFa7+RZv4L29o+pN22GggZql1Cbwt8QQgHdO8N93dg5rzYslSWCjsWEQRvZNq6lnbs4bNhShr8pK69R9N7sAmRGgupdOsYQd9Y1DEXjm6uhErExOiRz80ZD8vmNODToTVkgvC3F+37CBqeNGjE3JfJLDYAUHvW+A70Or1C0pq4p+4smoRCG6vSrEOiaP6WFJbA9bKw4/06jkBSGRBmHg1c4pDFZFxCukUn0A8S+pIx80GNE6CBr9tyNReBFzdnnOFmTCkFBbm/nPTStA02EyeK2TSufsChkuInpS3jy/7hLt9XdFCpe2iuJdHbYqQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(83380400001)(1076003)(4326008)(36756003)(316002)(966005)(186003)(9686003)(6512007)(6666004)(508600001)(66476007)(66556008)(26005)(66946007)(5660300002)(2906002)(8676002)(38100700002)(38350700002)(52116002)(44832011)(6486002)(6506007)(6916009)(86362001)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Enn7p83/q5WVTwqR54l63/zrn48UixBFyHm4xJ7tUHl2R/dA7CFlYJIKP2yV?=
 =?us-ascii?Q?/HNc78hpsG2rvFi/rQUjiddCH6GPbuAPyzODTROGLOTzSmOw4k1DxzlvS4e5?=
 =?us-ascii?Q?XNNDfhhDpbc0CcIOIbRvdrpSCLf6V9JDYIEnwLVABVirvMDA42mYSrn/PBir?=
 =?us-ascii?Q?2MvFTOgsMkGnBys+UAgRTH/PmlEp/CaTGhc9Ccfm1vmu/e/VURMsjniFa5KU?=
 =?us-ascii?Q?uUAt9Ytph7+iTcUFuWbhGNg247il4YKMd8c+GT3sF4YaDEjxc9y3LuDvATvx?=
 =?us-ascii?Q?TfS/JbeCj+l+gp75Jr8EHkC40Jb/0JdFJl4vQkcDfOGF4JArUU9Zg00K5ORD?=
 =?us-ascii?Q?xkls7FvI3dzdNE/MfMFQ6qh1RqqYxLXHwZJI+SBl3gnxoxGC/f62OG1HA8/V?=
 =?us-ascii?Q?YIk2zN4YI9XbYHvSqfpNkmarEuuLpT9bc3zhrBIgYc/+1zhvqHbq5YQeihsx?=
 =?us-ascii?Q?PC9YrJuSjtR352tLWSQq3VWYgvemrHpv7BJG63aeyDD9mnzpmbfyyou2X7tk?=
 =?us-ascii?Q?dKF4l2pnk1YVoeWlmpVMH/YoeJvtXdfgJrYBR6gH5qlN6jk5plSeeq9miVQf?=
 =?us-ascii?Q?0Vi6b48HvhwxXFDKKvAw8cWGbULXDfwnnmGtB3BTOsYhFeR9AIW08Obfgifi?=
 =?us-ascii?Q?EckLYaKSGXKd9HPCcY9dieoKI+z9EiM8QcAtXRM/bzXad2ES4xhnFctwT7Oy?=
 =?us-ascii?Q?nlIANuI+GsG6j1mvrkex7rZKHedX3wKSI7KsGiMXavLdWo/ikMq03PbLfjau?=
 =?us-ascii?Q?bzLNn3xmjA3nYihVhtKrUzULdNRB/L7TnfUCuiwpyUK+I0Uhrc5nRYy99wE/?=
 =?us-ascii?Q?sWVpNGavz02Kad7JRpp11uF5J7i8kpPXYuVi2h3gsoz9FGz4qu4csSk7cWiQ?=
 =?us-ascii?Q?KSpD8g2Lu95j77DCov8OAALpAp6Sc3UoDjn3tHXQzVjidQFpjuKXl21P/IL6?=
 =?us-ascii?Q?WzejOkSkbsbFpHfj7ITZQo+UgJ8WUNbOETq2QvoE/iAQ+rVvDTbmOVtXsh7x?=
 =?us-ascii?Q?03ITSR3d2SVzLPU0ADOZ9cDE05gLzLkcDq/fpX/nwQX5ouGBpsNdf8qU9w9C?=
 =?us-ascii?Q?H07I2BwSRen5Q4a8exSmMjR1pWtn174Qpe1OsXzF0jfBzsLTIuupxfW3EfU2?=
 =?us-ascii?Q?QbjCw715tj+Dy8yuqbGFZSWJGJpj9YfjLOZHw3I18iCSLm4xHZrKV+K9uXsi?=
 =?us-ascii?Q?RpSSa6xmuW/HY9jFUzI4+Tm1zkEAt3+GtYoBT74IDdJnOCcfEN7oEg9sCzCm?=
 =?us-ascii?Q?wuGv1oAjUfNpMhcv99Ki7uw9BdsJBJhgBh1wgnZkdeHjW92tU8iagdm6LiCx?=
 =?us-ascii?Q?MhdVm2BN4YSad+lj8v1+8MoQN0oqtyW/eenAsq9R548idpl/ZdJS+px8E3YJ?=
 =?us-ascii?Q?zifZtJRnA+5+QvDwCXJcnc44Ozd25+nxhrg2cesZFS2HDyrqkRiLomeG2cLJ?=
 =?us-ascii?Q?cs+1yN3C/PHrf+MfPVivFBI5k9APYht036L2Wy7vb37D7hYHU1mp8IXfaXgt?=
 =?us-ascii?Q?hzlg3UBp7cO2QPz3N38V5kmpCGEvzB3e4szBrD21vlgipGHfHMkXLd+IcDkE?=
 =?us-ascii?Q?ZnS07XeMmxeuCTGxUmu+suGR7U9/kCpRGA3ttbuLZUqmiyNAuHaxjZr84RNp?=
 =?us-ascii?Q?7GfnzgVAc2qmB19u+GX2g6afHHjCW3vVnxtmJz7ct2jR6deVPDOttASR4WAN?=
 =?us-ascii?Q?MYklAtS/2awuq7HfmIdcisCsB7c=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a74b2d7-2b2b-439f-6edc-08d9db065cae
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2022 04:44:22.3045
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TGQ7FkS7DURQC9cLwxlEo58RfBHs8TdMcqXMkJ1+hLYpj/e0ENx1y9FE0LXrJYcXSpMwpNzMkYXqurbHMurlJ1uW6PvS+S7+tt+75S7UDIo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5343
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10231 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 bulkscore=0
 malwarescore=0 adultscore=0 phishscore=0 mlxscore=0 spamscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2201190022
X-Proofpoint-GUID: GxNk2Efy1M5nDcXeJsEglgvTng5CUUTV
X-Proofpoint-ORIG-GUID: GxNk2Efy1M5nDcXeJsEglgvTng5CUUTV
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Xie,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   79e06c4c4950be2abd8ca5d2428a8c915aa62c24
commit: c8a6153b6c59d95c0e091f053f6f180952ade91e vduse: Introduce VDUSE - vDPA Device in Userspace
config: arm-randconfig-m031-20220116 (https://download.01.org/0day-ci/archive/20220117/202201171409.rqbXNHlz-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 11.2.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

smatch warnings:
drivers/vdpa/vdpa_user/iova_domain.c:305 vduse_domain_alloc_iova() warn: should 'iova_pfn << shift' be a 64 bit type?

vim +305 drivers/vdpa/vdpa_user/iova_domain.c

8c773d53fb7b64 Xie Yongji 2021-08-31  287  static dma_addr_t
8c773d53fb7b64 Xie Yongji 2021-08-31  288  vduse_domain_alloc_iova(struct iova_domain *iovad,
8c773d53fb7b64 Xie Yongji 2021-08-31  289  			unsigned long size, unsigned long limit)
8c773d53fb7b64 Xie Yongji 2021-08-31  290  {
8c773d53fb7b64 Xie Yongji 2021-08-31  291  	unsigned long shift = iova_shift(iovad);
8c773d53fb7b64 Xie Yongji 2021-08-31  292  	unsigned long iova_len = iova_align(iovad, size) >> shift;
8c773d53fb7b64 Xie Yongji 2021-08-31  293  	unsigned long iova_pfn;
8c773d53fb7b64 Xie Yongji 2021-08-31  294  
8c773d53fb7b64 Xie Yongji 2021-08-31  295  	/*
8c773d53fb7b64 Xie Yongji 2021-08-31  296  	 * Freeing non-power-of-two-sized allocations back into the IOVA caches
8c773d53fb7b64 Xie Yongji 2021-08-31  297  	 * will come back to bite us badly, so we have to waste a bit of space
8c773d53fb7b64 Xie Yongji 2021-08-31  298  	 * rounding up anything cacheable to make sure that can't happen. The
8c773d53fb7b64 Xie Yongji 2021-08-31  299  	 * order of the unadjusted size will still match upon freeing.
8c773d53fb7b64 Xie Yongji 2021-08-31  300  	 */
8c773d53fb7b64 Xie Yongji 2021-08-31  301  	if (iova_len < (1 << (IOVA_RANGE_CACHE_MAX_SIZE - 1)))
8c773d53fb7b64 Xie Yongji 2021-08-31  302  		iova_len = roundup_pow_of_two(iova_len);
8c773d53fb7b64 Xie Yongji 2021-08-31  303  	iova_pfn = alloc_iova_fast(iovad, iova_len, limit >> shift, true);
8c773d53fb7b64 Xie Yongji 2021-08-31  304  
8c773d53fb7b64 Xie Yongji 2021-08-31 @305  	return iova_pfn << shift;

I feel like iova_pfn should probably be declared as dma_addr_t?

8c773d53fb7b64 Xie Yongji 2021-08-31  306  }

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

