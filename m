Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C26ED497E7D
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 13:08:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238208AbiAXMId (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 07:08:33 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:64406 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238134AbiAXMIa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 07:08:30 -0500
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20O9gG5e005367;
        Mon, 24 Jan 2022 12:08:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=8XUYaI1DdsNZ5YTx8MpTsVB9a6L+Dz/Cf5gDGXmMuTg=;
 b=LQ9+k3+7BPJGURco302x30cflrMxT8/SqExFsuDpmMrMoYtJ3QJsBljTXC0JGYELxOo0
 NtAySW4fk8VybyOmI98YtxN5uulUr72Kotg2HM4IH2j9mNinTgrHWmMDxtl64n8avj6m
 uTZpDH+vOwHSAbCb4h/7cCD/fHbAzMDu2ikSHY7GKhXPhd5XFKY8EY6rzw9H1Ngidvlc
 zom+TU3tga8y+j7HIiNs4bvEfiTcpLL4q3VhDjdAGId6Gtg9Fxl5pmHAvBGk1c4cSfIB
 F32AhOAUG2y1nFMxedu6LqwIiuziO9FevFvO7hska7bj3IE43jv8gD8fNYvF2BGnxq78 0g== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dr9hskwxf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 24 Jan 2022 12:08:21 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 20OC5C7t059914;
        Mon, 24 Jan 2022 12:08:21 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2169.outbound.protection.outlook.com [104.47.55.169])
        by aserp3030.oracle.com with ESMTP id 3dr7ydmm1b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 24 Jan 2022 12:08:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YBJGizPSyfz3S2a6ApEffJDGw0L1jZDTvEru12r0T0YPSrKt21nWvXRi7dyQLdrgohjY8TcWPg3AIC6P//lwOXuE5ycskcFU/QOEa3AosQbG3ZpOot+hwMcr/kDORkO+PgNlviL6GhL9BLXvfLU8TqljhqwnTIVrGGkeMjH2qwbjsvvifwo/An/yQGz6ng7KMk+7Yonw7dT+N28g5rcgBsYsV2cSbkiQbESuYbS3SDhXaSexyyBwR2qYqv8qu3QqJwwgcf3FigSxWm7IgXBbLQq2JrANhs6h2/+XrU5LFMA7keoBd0D0o/KB9aWIxjnmRoNTLNSPtN+8i6w0X49VIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8XUYaI1DdsNZ5YTx8MpTsVB9a6L+Dz/Cf5gDGXmMuTg=;
 b=QxwCHsNqFQIGHbzdEHZyJ3FTlDvJWm98UNy82oiM3DFKwgPv5khz38AKEczEVC7J50LpPUGgleQ8ekwTuZaO0UgkED8H/SrQSr0kaHuygL4rxY5uqaVAFNIetBH24qUQg5Lmcygzx96yjJQK1Wq9gpoFk+CJ2QCH09chWTG3PlbRgD1hka39eypmBwPKi932bV2E0LeRs6EMTv194wC01fawA/djrpa22UQB+Ye/xL7HuTxAS07WXEgqdT4pIeKgGGrhL2cXxLNxm597Bhlpp310t5qXqnGCWvVXsEus5ewo0g/SSKtfy3Wb7sxMt4r040gPGY9qAUkz9a/84xfFCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8XUYaI1DdsNZ5YTx8MpTsVB9a6L+Dz/Cf5gDGXmMuTg=;
 b=vdEwvGGw8QMQBQhD7FA8GF+phLPypNuz7llxj2YRfNYzdtSpwe2BC2yQ/D7iSPqSu/bZ6YVG+Rp9dxT8u0FQAF7DQnUHwHdWSllnLeTE0MD46U8Y93IBOU88l5NmjZ1GEMD79jbFrZKJAPCuuXA0XyQMUZw4ntsWCdO2W8J9EIk=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by BYAPR10MB3336.namprd10.prod.outlook.com
 (2603:10b6:a03:158::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.17; Mon, 24 Jan
 2022 12:08:19 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::c13b:5812:a403:6d96]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::c13b:5812:a403:6d96%6]) with mapi id 15.20.4909.017; Mon, 24 Jan 2022
 12:08:18 +0000
Date:   Mon, 24 Jan 2022 15:07:58 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kbuild@lists.01.org,
        Allison Henderson <allison.henderson@oracle.com>
Cc:     lkp@intel.com, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Mark Tinguely <tinguely@sgi.com>,
        Dave Chinner <dchinner@redhat.com>
Subject: [kbuild] [allisonhenderson-xfs-work:delayed_attrs_v26_extended
 17/30] fs/xfs/libxfs/xfs_attr.c:666:46: warning: Expression '(X | 0x8) !=
 0x0' is always true. [comparisonError]
Message-ID: <20220124114626.GK1978@kadam>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Message-ID-Hash: NHEAERP7DMIPX6UZYYAUQQ53TVX3WA4T
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNXP275CA0021.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:19::33)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 822e8ee4-4e1b-43e8-6b31-08d9df32353e
X-MS-TrafficTypeDiagnostic: BYAPR10MB3336:EE_
X-Microsoft-Antispam-PRVS: <BYAPR10MB333668F4405B637C18CA53A78E5E9@BYAPR10MB3336.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:256;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3QaXCuFX5NYX6Pi4B9v5WmGurNC22xzhyN5Op9U+bNnJFnTZunxyZgo7a6F0r6+4KrUYdlzOBd4V9Ab4CzOHd1Ynig4SPPK8EYeriI0xasfnX/2hHrcCQJKCGBeU/yQi73drqee83XF2GMF5cEzXv9x6OsYk18a6Lgc7bghBC0+Hpo7tP14CbbMgdw5TKIxGZ21fisPJZn/iCpzL5LpKvw6vo0ZMpYxvZuZFX+Ajc+Iv1lwiwbEOEZR51E1qFZXHaqRt+T6HHkG/ynvQC2Ea/aZVBEK5kC80F/Bq5MsWVRsewHFyG6VvcbGd3pk71tUYTnsa/JBNoClVNTW/ZYUFbrtf4O0l4HKEQmb5OGZFba+t4o9rfVd8P85M4FMpf/wyJwjrk8fab+0xUMdK05k6wpjNuvHc8FNeDn6s2QtfXE3Crm+w8/wugF3POwv8zD4cvrfvwlbaM5tmEhcLSJOECW8+HPT3Qa9SrCdxkAGx+3aSVyGldlDZdKLglKxsQ2W/uQu+3kEe26Ddof+dlOrNrQdaRAubWuAcHqx5KyiaU28hSfr0aW0XbkzQtA2511cBuvRZ2OHl8Gldt2h1qQGAdyiHDDndgUjBpYxUqnLxY7KmmFQywOcqHQyqHLFOw+8tofwhAXXuhn5Vghs+RLgpxbH1UvB7e7LTrhf4Ez3QUteFka5hcFdwAr2+Vly/bSfGMYnoMnGX6/5Xsrss5eXC7I3Bmv6IR1hU2E2D+MZrPT0QWccACJ92ArKK19l6NqxZVxML6plidh61r4Hqk2g0W6fc3SuZn3xLf9dlynssDn0ChPLXrZjd0u6oplPDjXZu0FOsAEvFRFMIgPY2qRF56w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(7916004)(366004)(6506007)(8676002)(5660300002)(1076003)(9686003)(6636002)(6666004)(52116002)(8936002)(54906003)(26005)(38350700002)(44832011)(38100700002)(186003)(6486002)(966005)(508600001)(6512007)(33656002)(86362001)(66556008)(4001150100001)(33716001)(2906002)(4326008)(6862004)(66476007)(66946007)(83380400001)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?lJiTJ9uemyJg/K61fVRJA5gqDfR/1+JcyS8kNerVAJ4tq782tPzPEUD2J3xa?=
 =?us-ascii?Q?lrOPVRmrp7J+U2NUWMe0WkShejMvJO1tPWPT+PYrB1r/GaH6AgQjMhaqDh30?=
 =?us-ascii?Q?y5AWG1n/c1Rrj3sryYy/EKsK6RMiGZVOwLD3DCePd6ra+n5Hzsti4+UlDl6c?=
 =?us-ascii?Q?oa+dZoNTAsbhPDuCpxVg9aKpSrt+4WGm3V9+mAiTWrCm5E+NgqBmeLfsFWLA?=
 =?us-ascii?Q?CZCDMcgb4qv+A6w2tN59Av60a0KTNdCBNXaKmQL9PlyIlIFY5xGAKI0B51Vw?=
 =?us-ascii?Q?9RB99bh+WN2X/9MUSZTggu9PJLnaTL7JVF+o7tF1miTfW8AKwfFTzMJA0XeF?=
 =?us-ascii?Q?vr6mY4aO2+b2yVTfXC9BVEzMiQ1ZhlkPszxfwQwGo7SjL5r1fDAnxgJcuDhV?=
 =?us-ascii?Q?rQkLEQtPv2p5L5ha0urxQzhyrWv1E6OXiKiv4bC3qhjdJY2WgZXoU2LWyKPC?=
 =?us-ascii?Q?AZMygvlzB0dW91j6fr2Y2V7x3aNKO8rzewe6dm+bGz7hfdUySGrw+8bCZgc+?=
 =?us-ascii?Q?EKwFJzqYbId8XKyohfELYS5gdAVc3YaTX4nv3w/9kYTY+c/OovWbyQNTmire?=
 =?us-ascii?Q?s8muMV52+FjHlYp8q3DjJdmaOuJ+eIlHdEwkUc7X2SCaQEthld34xAcnG12r?=
 =?us-ascii?Q?H3fGjEiESx9XyR6RItyp66gPj91Qj2SVeh6OJ1L+BTxhZveeJpXsjXEBdrVb?=
 =?us-ascii?Q?MTHafyl5D2HZzATAfBjstCYsfqmdaOQsfEeI/fh2Xf1hvRge/r1fE7B1RbIe?=
 =?us-ascii?Q?3zrpvhhQZoeugAsv1/3Oa1GxNiwoJLs+SSSU+kHhmmckOz7F02J3Nxq3sDpc?=
 =?us-ascii?Q?k3o4bCDj9FyupCuhSmRIsWdvOtAKlONYSbzq9qmFuyBvtrUy+jgTqWP+y6uK?=
 =?us-ascii?Q?DbDJoJYBT2YrdOci1dkKCJZbqFKSeMi9Qw+IvqmceVmLQ4r9ppx7IpEHfhvC?=
 =?us-ascii?Q?8ZvEZdnKQAiP/a7HMU51Ms+fATYr94y8wejhKZi3gvrWmWFFtAnhSlDDDP4L?=
 =?us-ascii?Q?DeBwPYIqxWSuHih8qHcPMXo6j/e/wY4ORPv9ujyBfmWZ37yMBINoiLA94qxu?=
 =?us-ascii?Q?+FbnLk0HJZp5CRQ/iC3EY0IcAoduHfisixj+WTcLElr7iBvO5gYEXfz6pxMv?=
 =?us-ascii?Q?dELiD0cZ2LR5P8VyDEuO12aipFO6LsQcm7PztSi2lC1DjVTjeGxwqA9YKeGy?=
 =?us-ascii?Q?nLBqLLOrMbYinUlhYl7H4SmwKXoF0j1YOV1B4dVI5a6mJZT9k5bgo1Fg6BxZ?=
 =?us-ascii?Q?P3wG6PmVTHwM1iV69DyGUhvh34SuFGD4OnnA2XhUMuKeNtfA56Yg4GQU1n4x?=
 =?us-ascii?Q?lWXm09Esfoglgrpj5Fi9zlCV3NaSibKdaH9/xfvUUUkpRYRCQE4T5MGGTF/g?=
 =?us-ascii?Q?PlqIKxn+u/IsggZm8vQ+ZI+g7ZJ79qyyJnDgJFF4REWCG/T+mIvYIzPV7Lmj?=
 =?us-ascii?Q?GmcGv/ak6GQ6zzsV4rg1ZuSnciS6p2f+s0SWnnsN2BZFLraUJnmheXGJFZrl?=
 =?us-ascii?Q?wie7vu7TtD5UOzjbRlTcJQeaIJvSl3/h4Q/ByJ5Ur/PO1lZ/63mqYO8V7lUb?=
 =?us-ascii?Q?2g6Q9pI3M9xTBOTXG3x16WJssUm0usV2BpcVi88O9SdGBHKCktGmgI9frNIe?=
 =?us-ascii?Q?m3Bsv/W7zNBUepZApf7NSxUh+TzKI2q/On3d09xmcNJF7Xxyj7dg7/mrWsAK?=
 =?us-ascii?Q?Vb5EBmahK40HbGCx2zkz74uuIKY=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 822e8ee4-4e1b-43e8-6b31-08d9df32353e
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2022 12:08:18.8496
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gGWiKuiQfISl2n0//QqTU4jmQeNU3R8X+9hW1xQgi3enYPinxcBfR1ren65vih6r69eSNfDdL/XWS3/mCA0a9aGK7JnDbfmpB2UG+6QyIds=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3336
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10236 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 bulkscore=0
 suspectscore=0 malwarescore=0 adultscore=0 mlxlogscore=999 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2201240081
X-Proofpoint-GUID: pLXGeAnUivI1FDBvtbFTAywLvMmuTLz8
X-Proofpoint-ORIG-GUID: pLXGeAnUivI1FDBvtbFTAywLvMmuTLz8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/allisonhenderson/xfs_work.git  delayed_attrs_v26_extended
head:   19459f5cfa422b0a6a9cd3898892e43ecb49f8f3
commit: 721a69ffe0e2561371de01822bef355354eee926 [17/30] xfs: add parent pointer support to attribute code
compiler: sparc64-linux-gcc (GCC) 11.2.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


cppcheck possible warnings: (new ones prefixed by >>, may not real problems)

>> fs/xfs/libxfs/xfs_attr.c:666:46: warning: Expression '(X | 0x8) != 0x0' is always true. [comparisonError]
    rsvd = ((args->attr_filter & XFS_ATTR_ROOT) | XFS_ATTR_PARENT) != 0;
                                                ^

vim +666 fs/xfs/libxfs/xfs_attr.c

c5b4ac39a4cb6a fs/xfs/xfs_attr.c        Christoph Hellwig 2014-05-13  653  int
c5b4ac39a4cb6a fs/xfs/xfs_attr.c        Christoph Hellwig 2014-05-13  654  xfs_attr_set(
a25446224353a7 fs/xfs/libxfs/xfs_attr.c Christoph Hellwig 2020-02-26  655  	struct xfs_da_args	*args)
^1da177e4c3f41 fs/xfs/xfs_attr.c        Linus Torvalds    2005-04-16  656  {
a25446224353a7 fs/xfs/libxfs/xfs_attr.c Christoph Hellwig 2020-02-26  657  	struct xfs_inode	*dp = args->dp;
3d3c8b5222b924 fs/xfs/xfs_attr.c        Jie Liu           2013-08-12  658  	struct xfs_mount	*mp = dp->i_mount;
3d3c8b5222b924 fs/xfs/xfs_attr.c        Jie Liu           2013-08-12  659  	struct xfs_trans_res	tres;
721a69ffe0e256 fs/xfs/libxfs/xfs_attr.c Allison Henderson 2021-08-23  660  	bool			rsvd;
4c74a56b9de76b fs/xfs/libxfs/xfs_attr.c Allison Henderson 2018-10-18  661  	int			error, local;
3a19bb147c72d2 fs/xfs/libxfs/xfs_attr.c Chandan Babu R    2021-01-22  662  	int			rmt_blks = 0;
0eb81a5f5c3442 fs/xfs/libxfs/xfs_attr.c Christoph Hellwig 2020-02-26  663  	unsigned int		total;
5fad9cb9d34c53 fs/xfs/libxfs/xfs_attr.c Allison Henderson 2022-01-18  664  	int			delayed = xfs_has_larp(mp);
c5b4ac39a4cb6a fs/xfs/xfs_attr.c        Christoph Hellwig 2014-05-13  665  
721a69ffe0e256 fs/xfs/libxfs/xfs_attr.c Allison Henderson 2021-08-23 @666  	rsvd = ((args->attr_filter & XFS_ATTR_ROOT) | XFS_ATTR_PARENT) != 0;

Anything ORed with XFS_ATTR_PARENT can't be zero.  Parentheses in the
wrong location?

	rsvd = (args->attr_filter & (XFS_ATTR_ROOT | XFS_ATTR_PARENT)) != 0;

721a69ffe0e256 fs/xfs/libxfs/xfs_attr.c Allison Henderson 2021-08-23  667  
75c8c50fa16a23 fs/xfs/libxfs/xfs_attr.c Dave Chinner      2021-08-18  668  	if (xfs_is_shutdown(dp->i_mount))
2451337dd04390 fs/xfs/libxfs/xfs_attr.c Dave Chinner      2014-06-25  669  		return -EIO;
c5b4ac39a4cb6a fs/xfs/xfs_attr.c        Christoph Hellwig 2014-05-13  670  
0eb81a5f5c3442 fs/xfs/libxfs/xfs_attr.c Christoph Hellwig 2020-02-26  671  	error = xfs_qm_dqattach(dp);
0eb81a5f5c3442 fs/xfs/libxfs/xfs_attr.c Christoph Hellwig 2020-02-26  672  	if (error)

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org 
_______________________________________________
kbuild mailing list -- kbuild@lists.01.org
To unsubscribe send an email to kbuild-leave@lists.01.org
