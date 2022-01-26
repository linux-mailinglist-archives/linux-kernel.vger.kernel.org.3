Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 400C249C8B9
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 12:34:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240760AbiAZLet (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 06:34:49 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:11832 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233650AbiAZLer (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 06:34:47 -0500
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20Q9kQmR007703;
        Wed, 26 Jan 2022 11:34:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=pQMFQc8+0nwaUI2Fkn9lL6sF78bNkqU5J1xdGVfk7VQ=;
 b=m6gGh0+osiovOs0324dNalPXMVYR3TtNymdRo+zY2Jwy0evKmzhXBBYu9ESSUDTzIxoY
 Zq/Y3IRyRQRP4WaBe7SxpbMNCvdKYwwR8z4U+H2t6E7TAp9wffI7JL8bATdJY0yLWji1
 b5LldPC9ZjpeTpHKNsh701M+fJQhh9vwT9mBrCHl8ttpHR6olrGPHVJRyt+mE69r2nNG
 Exbc83L5oCovrjbUYbvFhaFlxq494lDVbljIEZCpqX5L4MbXE9U7lsyCF3trW4zJB9Lw
 H8Sj4yhILhmCBGD8FuSUc90/2H0mkogcaW4OvzCiruOLvH8jVeHfSRNN72RM5naofC8n yw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dsy9s5ttj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 26 Jan 2022 11:34:06 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 20QBVJwg117270;
        Wed, 26 Jan 2022 11:34:05 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
        by aserp3030.oracle.com with ESMTP id 3dr7yhj4ca-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 26 Jan 2022 11:34:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DcFAeozVXHUqC6VkGhekVp/4E2VQ+ANY7knK/rqqChCd58PX+b9P7yy4n7nAS1Owt/BWKLjowQHTL4IocfmHeLTzOH4CgiXu/fLgq5hdAnfXlfp3ARKr0CVnXn/mIHh/MFro05mAXgh/sYZ3fMYWbjHdbaHDIA3sjxKDzdMnt1KqkZIa7AM0HIgxFuxUiGTbAVlt/MXdPG8PXoa/xhlyGHo+u5CgYz/WYI5C9Q5zeURaTrWYKC0x+Iwzx7Um/cPTfEpVpmEpZpyEs3XXNWEwxQ20Ep7jPxGmp4AvO+yfOfQoriJqa0YoVkEkpsFd390yYzTog8sdHfmVTOdY5Kk+oA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pQMFQc8+0nwaUI2Fkn9lL6sF78bNkqU5J1xdGVfk7VQ=;
 b=oDZ+Gn3/8JOd3zvAKMY7TEulbqqPHrUBQ1949NuSuvvAAn3x5MP2BvMIqupGidbAO3WiHD8V4zw56dc6tfP+ngJ3s2kxN0LOPKPFhRX5Nok3TJjbf6pUUOAwZ8xvEEk1FNsttKvrWQ6AorEW2F3dkSeKcdja/oDfklOG+J3B8HLzpmVPt25Wds35KF5HqXD/q+4y2h9onZsKjnMHXvx3BVKlaKQF2pQQGi9X0o9ErHnmdqn31mX2g5kplAZgewWHSWaLoGwgcm2NxWnKnCVzOTU9T38ycHFFMQRevFsqdbVj6tk9GrQY7S8WazyAr1pKGJAHaAdP6EXhhYk/VitWgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pQMFQc8+0nwaUI2Fkn9lL6sF78bNkqU5J1xdGVfk7VQ=;
 b=GCBfYYlsVxx04cRXMoKoQ3kHMhMQOfSp55oZ08lNUItcfB6RvB2DE+PgD7nGgtwOfFxiwLxJ/jnjrU3c1eTRYO/gteqoKNLF1F3J3UF2SHwheFhVPnCtinMO0ZA5uDt9icjKBXhYKF8uoNHihndIxQQRTRAsIHPe7xS3VwxVLWE=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by DM6PR10MB4042.namprd10.prod.outlook.com
 (2603:10b6:5:1fe::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.10; Wed, 26 Jan
 2022 11:34:03 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::c13b:5812:a403:6d96]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::c13b:5812:a403:6d96%6]) with mapi id 15.20.4909.019; Wed, 26 Jan 2022
 11:34:03 +0000
Date:   Wed, 26 Jan 2022 14:33:39 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Colin Ian King <colin.i.king@gmail.com>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H . Peter Anvin" <hpa@zytor.com>,
        linux-perf-users@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] perf/x86/rapl: replace 0 with NULL to initialize
 pointers
Message-ID: <20220126113339.GZ1951@kadam>
References: <20220125201403.670011-1-colin.i.king@gmail.com>
 <YfBsb/3fR7v7tnr4@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YfBsb/3fR7v7tnr4@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JN2P275CA0005.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:3::17)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9658b5d7-f76e-42ad-8c2b-08d9e0bfc0fb
X-MS-TrafficTypeDiagnostic: DM6PR10MB4042:EE_
X-Microsoft-Antispam-PRVS: <DM6PR10MB40422EB8C1B393FA5C8E75B88E209@DM6PR10MB4042.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:590;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RImEWQ+jwl7ohYE3hUq5Ry3J9zzY+CUFYQhNnjn/imOZFpdVQJkiLa3nwa2BPi/5WAGxTXoBDj/N4fIZD9mNXQgGdEoGpOGOqredS8RItbxyikGC3ENMHjGn5cVKyNxmVCtNNEKGSxfddiZR5Pvowey68D2uygdynSYeDW9I+57bugHmnt6TpAtAO1PF3I6FYNbCGqt3y2rMXGgreQ7+IMaB4CyxpoVMBz/FHa16utA/l2IFkm5oqSCmQEXHYrsK+6P/9Iizr6Q7uitkdKMLyCnzGOVTwVeu7zdWXUtzpvQ3kQz1UkUejDO9hl1zuUACJ7G9CnPoyqgWxeWKBfCA2VH+aA1UqUsqrQRpWTjfJOH2IKaB7r/X1UvDcni5tGSrxJA2vpn7n7PT23xblBHAvCyuauZQPehTi6h86APdMq8oV2aHU3eDGEnmvZVEVxDBd80uqv+xRktwHTExbEnMmu0kqF7kMjV+tCBJoHGpAizMaoUx17s6IFbilhFhO2XKQJAg04vtIx+bjh3D57ab6hn8XwdhWXXXh0jqM143UJt9/VyBZag/l1A0cRhUL6DJ6QYB0u7Vv4+dwuD2WROdBsWtzVPbdKi4BnMjfqDFvkZuEyBJVC7bwGIS19cxZQNHn4aEeCUdtJhS0+vej4Zp2PR3msiCGof5IBOtjvQQMH2zTsIcxptqc9WSYq/x04mByPCDH/S3THsUEZmTRdhHjeLzBVDc38+GFNjapY9ozAz3FVYWj6FQ4HjSIuVBjJvTj0tiC1e8RXheYAdPfLAxm2Nc4M+tmZycZruqq1BxJxY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(7916004)(366004)(66946007)(66476007)(66556008)(33716001)(6486002)(6666004)(33656002)(508600001)(7416002)(44832011)(38100700002)(9686003)(6512007)(86362001)(316002)(4326008)(186003)(6916009)(2906002)(26005)(966005)(38350700002)(4744005)(6506007)(52116002)(5660300002)(1076003)(8676002)(54906003)(8936002)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?UfgivKl7FWvovgV6ta1g++pZLjMrDc6DodpC7D7orKO2vobLjSviraXiB5tG?=
 =?us-ascii?Q?ZXcSVk2z95K264XtoETfgP/5WwyVp2Dww4Nq63Ml7Tt24wOt/wrdQJxreeoI?=
 =?us-ascii?Q?T00GElSiOEtEE+WWpaszJGFeliC6Zj1NiWTeG8RvPqgOB4sKlc0/TtDssZ5f?=
 =?us-ascii?Q?yU4BmDEVUp5MlhZ15bZI9e+Pt+kJ16rnJJoXy0A1OpjnAAfJESdoyINNvUS3?=
 =?us-ascii?Q?yeHhiKE5Osmz4npUJQT778m+/4wjaizqcKMeapsM5oIL2MYCBRH+QsuO8jNR?=
 =?us-ascii?Q?C5q6c61zLZhzo+BCsyTXp1afqo14bLajeSn1dOPNc6qyw8IhnGtTfFcL4fp3?=
 =?us-ascii?Q?5YCyckZNpsqanGyCtjHkmneF5yDSvEtE1stzkbGvnH/RK8zBiMQyFUBUdmnS?=
 =?us-ascii?Q?8GP2Tj2QAQfYiBTUfr1GmpTT8ZwLqX3SAIHy35lMq+vGK40Uq81lRn/yXzqh?=
 =?us-ascii?Q?j4WTOgNzYmNf7CwL02BMezs5ehGRhcly9klqst1Rn3pAZltRBFJctpKXFSQh?=
 =?us-ascii?Q?6HX0F7eSQdZ5Hy+g1Yecpyme6nhBgPivazY271LadLKiwgcUp3vYCDII7dF4?=
 =?us-ascii?Q?tGndxasvvT2phz7bxUSHceoFPFHGJO1iFJU0teguvk3CGw8gxAVkgFXLT8si?=
 =?us-ascii?Q?1VR6leoU1tjaLeW3hlORcLtlkUDXEGCn1w+HomDAs3w84DNp7IK2P4Wusruh?=
 =?us-ascii?Q?vJgpu7gMcPGbeyWuNNSjnRe9wIlMsdAm1FCZcOe6z6n9gLkc66cNqp2e+vB6?=
 =?us-ascii?Q?1GVh6ZWa7wWV+JjhxJ+3obqNSn1n5rfVN2rFiS5zzIfpoe6UrIa9qWX5+qBw?=
 =?us-ascii?Q?eOXzCEUU0K78duaBU4S3aceAdOmhuCit8te/HYxClgUk60gSi4BaN7WIeCbg?=
 =?us-ascii?Q?1rh3g2qpyiad8utV1ooLirdT5D96ccpPQXOCR2Te3WZcRyE9++fX8QwnZrkV?=
 =?us-ascii?Q?bQGOX2ZyOEMoDFB8X7qlajdJBavj0aacVvozedGL0Pdv6yLTUdBZ482mFs/A?=
 =?us-ascii?Q?BbBoDddX6Mifk9cvellUwI7BCm9bpayeuKDhUz3B/YKT1sAqNpHNXQPCPk1q?=
 =?us-ascii?Q?hsW+72R00omnWjYNZeX+M0ApSR0R2CiQnkl2AafXJa6aEg3YJU8dMKMFRryo?=
 =?us-ascii?Q?blpas/nOy3e9uX75SE1u2dmJmSVHIM3iS/r1XrfEsmim1bseU3mhgSQ1axHn?=
 =?us-ascii?Q?wLmOeixznxEzivVSkUJxWUQhSzV/tQTP3AvN7ypKDlqbzPdTdNHLah3bTvyV?=
 =?us-ascii?Q?ei69Gr0e9+jmbkhXKfItEECsI7YLaQQ2Hq+ENeTm+zkriU0xi2jYZgW1fdgx?=
 =?us-ascii?Q?xot04syrj2y1CltJDr2HW++5KC9aiPjnvWrmqjinh3GV5YV3pcdBzuhxl4QL?=
 =?us-ascii?Q?0hUixoEbRVfYqxEeDQXLl9KS4lCYXCpe+/NN+IgzuGdOxS0IWP4N+wdI/t0i?=
 =?us-ascii?Q?Go1S8CxSq72DxxYDqRarhFYPaOP1l2WXkLTM15ZC76x1YGRW22fwHbfrxzCl?=
 =?us-ascii?Q?vrmrzDI/VlABUu22zruNzbTCs4a9Kh2ZAnAx840s0YhmhXHDfou1CbAwulsg?=
 =?us-ascii?Q?JYx9hd95f71otvoQc8g6MiHuzbDgs4YpXvO6CuOAGmVgEzfaLZmWM8qe0/+n?=
 =?us-ascii?Q?ePzAAdK20NjKHIavB00FuuS5sAya3hSY+7ZMLimCkSSAmtl6/e3GRUP42b3D?=
 =?us-ascii?Q?yAk0J3DP+NyjmWzDGoDgbgk/nEg=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9658b5d7-f76e-42ad-8c2b-08d9e0bfc0fb
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2022 11:34:03.3065
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ohh60Nt5CCkLH5CndBGA8aEaE/4woaVF9gAZ1Qkl5aAchHO1pvNLxJ6U1CuGXfOLVSLvIOPr75qPLd0gNI4WglLjB4OOSBvyH8+mHSxe0C8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4042
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10238 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 bulkscore=0
 suspectscore=0 malwarescore=0 adultscore=0 mlxlogscore=866 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2201260068
X-Proofpoint-GUID: cSNRTlqv2PLNbPkohOvrkISrS8Al9_b7
X-Proofpoint-ORIG-GUID: cSNRTlqv2PLNbPkohOvrkISrS8Al9_b7
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 25, 2022 at 10:32:31PM +0100, Peter Zijlstra wrote:
> On Tue, Jan 25, 2022 at 08:14:03PM +0000, Colin Ian King wrote:
> > Pointers should be initialized with NULL rather than zero. Fix these.
> 
> Why ? This isn't C++, heck, this isn't even C, this is the kernel, we
> hard rely on NULL being 0.

It's a Sparse warning.

https://www.spinics.net/lists/linux-sparse/msg10066.html

regards,
dan carpenter
