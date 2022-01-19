Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3D874933D8
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 04:55:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351447AbiASDzF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 22:55:05 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:8984 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1351422AbiASDzB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 22:55:01 -0500
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20INxWBp011247;
        Wed, 19 Jan 2022 03:54:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2021-07-09;
 bh=aJ5mQZaD3YVId4hhMk/O3PAXpOltJQZ958EujWjXQp4=;
 b=pUVDaC23o4OOuSzF0UU4lryE7x1UWEKJ+z0oRdwnHhjJ7zX4NmRS5A5jom0QjGAjjg/Q
 aGGLOUBVPQOK1xENWGA1BJct6sJ67X90YzSRGFWEJOYJqfm3O5ou+xN8SoD48Nt3FBbb
 0W+61Fj5G9G1S3zkr5M7HPRyms8SDa+v2auhYCuaVaoyycEplzEcCuv1zVsE7r7hHGkG
 x7Qp8KdBR2Q8+POYunHs1LwyRbQfmPd1BLAl6tx8/ZEgGaGo9cSZJrICMGpg7E743EFA
 tq+0NjsbDQa1+dzNL5jvyk2vOoFeOvjCmE2XoiWyRV+HFvwCb6pFISIRvVRN2Cvbar/u lQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dnbrnuu0p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 19 Jan 2022 03:54:57 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 20J3l0Vo078819;
        Wed, 19 Jan 2022 03:54:57 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam08lp2042.outbound.protection.outlook.com [104.47.73.42])
        by aserp3030.oracle.com with ESMTP id 3dkmad0wad-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 19 Jan 2022 03:54:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ck+zoRL2c4fsOHKY84jn39WQy36qLAGXoj8+txW9Kb+FrOf82CzgrxfEhy5ibNV8Ic3sKO/co/bX59YICrqQfIQ4DTFu67ZYDecMSNQfBjdXpyQ1jpTa/QU2vUD2PMjJNxMyyBg22WlkxM18r65ONZETZT77MUVwlZvKmd5K0QkHyCIWte907Me314LLB243yMIhVJDP2OOUuPYjiYNz++eO8A5HhVaGT8Rdjt9vcNgV6PSBYnLkSiKpnah9MUAfmEu5UMcHxnf04+yLZsckX9KRr5/MUTiJTQhKqkAyx8IDy6PoVaZH5I9QQplNb0gcGG2WHsampYBBUREjx8r9dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aJ5mQZaD3YVId4hhMk/O3PAXpOltJQZ958EujWjXQp4=;
 b=KQVYfnaDupjhXwSOZ7NguHL2Yikl95cYUqTPETx+itf5DDe66w6vyHWmTfjrejmXkUJxKKcvjBMxTzqBjxtktO+ls/ThmA+BlEr0ZNw0wnqquIKxp4L61UU7HAqXSIXFyncOy4QpvEzZVwa+RaZBnINbp1Xur9RO77RxydKgvZ7IItaYf7AqHNCC0Jd0HwV9uRUSxL1cS9RRuMovQ0q+pVbn/V0ISCwFd2wBbPKXl9wK1D7cFjq2/eJ/6qUVtxtbTNeTOjh0FjfnQVQiBfkXKSjRA3mTgk9c4LfDKLs8I1D+a9tJX75bDCEL5BFK3U1cG2rPYVzAo7VTEFEueqA4EQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aJ5mQZaD3YVId4hhMk/O3PAXpOltJQZ958EujWjXQp4=;
 b=in6Iin9xQLmV2kg83tMCIlUdH+rV9Z2lQM/BLXh7m2FuVyDxaGavshfsR7mEdxv57gYwcsH7aix6bU4CVZWsh+l6zR1hF8teoKXTCHTqUw51jN3YQ1gUOLY2qFSokKF1TDZVXImxZYO8Ys57iAyI1DJsklUyCBp2YD6TuzfXJVQ=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by DM6PR10MB3979.namprd10.prod.outlook.com (2603:10b6:5:1f7::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.9; Wed, 19 Jan
 2022 03:54:51 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::1053:7ae3:932b:f166]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::1053:7ae3:932b:f166%7]) with mapi id 15.20.4888.014; Wed, 19 Jan 2022
 03:54:51 +0000
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Anil Gurumurthy <anil.gurumurthy@qlogic.com>,
        Sudarsana Kalluru <sudarsana.kalluru@qlogic.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-scsi@vger.kernel.org
Subject: Re: [PATCH] scsi: bfa: Remove useless DMA-32 fallback configuration
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq18rvcl6rh.fsf@ca-mkp.ca.oracle.com>
References: <5663cef9b54004fa56cca7ce65f51eadfc3ecddb.1642238127.git.christophe.jaillet@wanadoo.fr>
Date:   Tue, 18 Jan 2022 22:54:48 -0500
In-Reply-To: <5663cef9b54004fa56cca7ce65f51eadfc3ecddb.1642238127.git.christophe.jaillet@wanadoo.fr>
        (Christophe JAILLET's message of "Sat, 15 Jan 2022 10:15:41 +0100")
Content-Type: text/plain
X-ClientProxiedBy: BYAPR02CA0040.namprd02.prod.outlook.com
 (2603:10b6:a03:54::17) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d5391aad-d6a6-4bc1-8b43-08d9daff71ae
X-MS-TrafficTypeDiagnostic: DM6PR10MB3979:EE_
X-Microsoft-Antispam-PRVS: <DM6PR10MB397965DFBAF7A00CAED0153F8E599@DM6PR10MB3979.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iKLLpEa93AJPIBw4r6kYCxMFpsrMUXB2WObVfWq0XPmBhDy2HlEYLPlBo/YEdFf88PLu4Y+Q7Y3et57Te91zHXP+T9ppsLfmdWQoHJkiQV1CzpUqnT67Yv7LcyYlL9qn3LoWyjlQZb1eAPWl8d10SOW58uoG4jLu3rC2vvVJfbEG3vB6nOP4Uy1QNb0/18gb11UIGC6s3oWC17XbyIDS4Kyg062gnU/v7/LJIz8EkCzzL3Q3tugFt623vka23aIqUBpHZw1NojYHUyFvEBZFBiej8XWjqOwxYfBiWNJnJTXreDhABiUApZMfG0zOD+VZwWohnn6p85GU0WwCUFwbGrFFoRKS26dMnzniumXUEuYdwlvyLlwZR+mvQmDgDfLYaT9ld5OrO6bqqQ/hq7L79sapeb7W/zSrElFTq8Yc1PTucn6TS2yx3rKSqv4Vqqdhh2/cVcjKFucrZ3yd4dXZyIS9n1cmhLK72xALap5fIr4yCIPXF5Go4LrwScvf0355zEXCkF9cKhJiMPH1dmFFEo3RSTVpfqPRnJwiSjQedKXjsmj0BatFUveDEp6Uo70IAgBSSc+UaTNI8+gQoCPrfmf2qD84luMV5e5ECR6BgmQVKIHabP+ODZ2cc+lFEuD5UE0Y1It6gd/YKB4J1Jl5GURL7zC9BT5IJKOKZ7VN8ylnaedNctHw7cnk93qrFo+vlFFK697/b+1e8r73kG2R7A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(5660300002)(186003)(86362001)(6512007)(6506007)(508600001)(558084003)(4326008)(8936002)(6666004)(316002)(54906003)(66556008)(6486002)(2906002)(6916009)(8676002)(26005)(36916002)(52116002)(38350700002)(66946007)(66476007)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5E4aicEykos8eyrMDHD9/jf3dwhknYWWZEgRXLuQlNC6TXL9LaKdBAbBtGyv?=
 =?us-ascii?Q?bkJ7vYkAc7RpwlWL+oUqlHsS6KzYuO1hGnLA6a+VQeQcQgR5OUXbkB8IwDgL?=
 =?us-ascii?Q?7/hRwCrJfj8js5hO+YYRBljQ0gwLMCPX41YvnLPkYXs2DpY1axd09asU8Ilh?=
 =?us-ascii?Q?tEqqFmg+gY3oMT1nwGQO2rFbeVYlyKgiRvZ70etSsvRXaPx1YnjDRTCapbPc?=
 =?us-ascii?Q?TeMR6URSJz6RvQc6ju6yiOIJPvzBdQu3Jkt2KHBVetU6Io9TraddRlzzKeH9?=
 =?us-ascii?Q?gJgP9Hd+ToipyTn9mPP2MGaqirEh3BPk+etD8wGy4DuLtlBWLe7ivXKSLWHU?=
 =?us-ascii?Q?9GhZvyaUh9v/Xqtz0rOjfbjaQ5ZYLcG4/mVlkrTscFgbq4hCX9xEcLGhMxcX?=
 =?us-ascii?Q?pZZ8+8sb33fKH37P4qTa8iXSuMSYxcCeNVaInG8WmXYyWfoB1xRZzAehekWP?=
 =?us-ascii?Q?q70nua0c3ZqyGfaDMiYM5Deu3uoM/2FDjZ4Kr9A25+L1jp9upVEXQM0JG7aT?=
 =?us-ascii?Q?ltBPAdueAoIwO8NKQJDAq+YAeG2YiQjqQ73ir8IntbTfNW5IQBx6L0Sqwf8O?=
 =?us-ascii?Q?OwleulNKe5X1it3psmjheiq4NpzCvTCJthOkjHijGeiXLgsJUfjRrzUqOw0X?=
 =?us-ascii?Q?EVnw3yJTwcb4/81LH50gVEbPbvPPOIUGYA1t9GeMXoZ8TnGlwfyqQlZrs4gH?=
 =?us-ascii?Q?G4i3X3o1ZdahqeTrb3hEoB9vwWn+HDmPfLGpd54Ch7nWvSH82Au/Jctilu7N?=
 =?us-ascii?Q?xKr87NDvIpFsfNX5GK3fy3ZDvmqSHYt2zjvmuicpZdkZ+jRQtm5ElgTajfDl?=
 =?us-ascii?Q?rULMiYr1wpI5mdcF2vIAK0d8sURwq1lU5Y70923SjJQriizR8GTZbU4hsrG8?=
 =?us-ascii?Q?9El9QxBQVvkLZwaCUmLZ3m0+d1OcnxOTz5jOiDSkx5CYmCsO/93nUWfQk0i5?=
 =?us-ascii?Q?YCfyTR4DeifeAva4PQ9nJkQK+4ihSWlBwcfHUM28tPk8p6SxGu6A1n9Fw/Rd?=
 =?us-ascii?Q?mqM2ImY2epGeA2bIG8hSYti21sJwN2Bx1SSDH+cEq/UNwgfdyHRcRKkUBjsg?=
 =?us-ascii?Q?6M+POVb3/E6NnzJ5WGp89VIJdG5qKJdXgVdmGzhWmMjW6LcY7vyQP6KKYqqO?=
 =?us-ascii?Q?vxDb7eV/ndCW50Z7b1hrbu+E14IhJ2VDKWsT51GSRUknKkbGbporJZoxg5n5?=
 =?us-ascii?Q?lhTEvNeReLkqYafFff72YJXlAs15JYKP4fbgyobUngcjNgpRGX6mAMbvkqFA?=
 =?us-ascii?Q?wxkkTn9MnZdM0lziQWd42YXWnMwzXpwL6lFAqPM1CBtJC7yE7kSV57a8p8fN?=
 =?us-ascii?Q?lnPNiNBgi2bDoSgIJNcf1uEVMyMQwGVghKc0MQ+NtcjqKxFnOu9/2KkoTAbN?=
 =?us-ascii?Q?Z1SCHB/K6ma8pVSjgRHR2tDUenTpS6tVzhNl/Y2bagCIp58bjcFhIU3fuX9r?=
 =?us-ascii?Q?kQsOIy33HZS7LsHY/oF5Sg7mMOEKlkY/laTG0KCuU7gaxSfi76ew5F2SoajG?=
 =?us-ascii?Q?zbAJ6Fp9gtfWFGBnY2nnT9DIh8QsdI9TtEcyvvWR3NEwg2Lv6RkmG9ju3ruz?=
 =?us-ascii?Q?A4izw9WHYSVjvc0W2ezTTi76xexqFmfyMkafy2lUCyISX5S7avimGqm3Mjty?=
 =?us-ascii?Q?++X7nqztQHNYPNMWeSbClfAir2l2M07W6+kvcuBKLqPrODqkoVsv6NKsnaaY?=
 =?us-ascii?Q?jc8Pvg=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5391aad-d6a6-4bc1-8b43-08d9daff71ae
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2022 03:54:50.9665
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7Sp5JoF3BwLMWHoqUhVXp++hWuokLis/7lCNcNWRsveexW+nwKVuCgTob389rhSOdWtdogeOmXt54zIlzITzV3SYah3aatZwLytRkwEsTaQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB3979
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10231 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 suspectscore=0
 phishscore=0 malwarescore=0 mlxlogscore=999 spamscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2201190017
X-Proofpoint-GUID: HvzF7Tq8IYHy3UcjAi2lraD-DXoROXfS
X-Proofpoint-ORIG-GUID: HvzF7Tq8IYHy3UcjAi2lraD-DXoROXfS
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Christophe,

> As stated in [1], dma_set_mask() with a 64-bit mask never fails if
> dev->dma_mask is non-NULL.  So, if it fails, the 32 bits case will
> also fail for the same reason.

Applied to 5.17/scsi-staging, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
