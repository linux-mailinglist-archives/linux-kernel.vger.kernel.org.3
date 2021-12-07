Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F12946B1A8
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 04:54:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234467AbhLGD5k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 22:57:40 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:46590 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231678AbhLGD5i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 22:57:38 -0500
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1B6M5oNb004252;
        Tue, 7 Dec 2021 03:53:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=JIWQ78oJO0ui+0+Ao4I7TcCz+YuTET+M0/O89n3CXv4=;
 b=XYlpSo4TS0qpsamVRPsoDml1Xcd2fuRK4M8/ThxhcSOm5Y+EZ6AXCWgRvJfpac8RP/Qg
 jb6N362Htc0L+ZxluGZHg+Iwo5WFrXKgeOoP4IZu2dAi9QmRwcy5+Pi3qcEoSfzdIltx
 fV/vOkNK3hmTMLQoGj+snDE5JtUZI+RXFqaP49dDRIz0mHDwKgxjPd4Zd2LNIsQrVqXR
 BK2u3qjqQup2VDo8WMDCcx4cWNS/lJ/cDoZJbaUOk9zCLbyk/NIcYKcFMh+GPhQ16gku
 dy4F8lMwwxok+FHvSQByRrnOt9CkussRK/eHJ4Vv3XpCgv8eICabcvWzCAjOreX41O1d rg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3cscwccacw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Dec 2021 03:53:38 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1B73oefD125276;
        Tue, 7 Dec 2021 03:53:37 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam08lp2171.outbound.protection.outlook.com [104.47.73.171])
        by userp3020.oracle.com with ESMTP id 3cr1sn8ed6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Dec 2021 03:53:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V5UKXH3cK1QwWsCAscrtGgsYU4NA3lJgO+xGmvyTCMxhHw1Xf1VN7k7ydVAZjplTgbi7Ogegx9R7609icWemzGI+twSLw90F+v/3h4WRy0KfAtpFkDijWBvpDEfO8/BxYu7nB3lBF/EAfUIInk/0ZNtgQZPK/RY+dFsTEnhsWz1fwHa/DCpv9yzxMAHQ1I5OSb5EIXSpUPNo0/bPmZBgABJdMB+MnXPeTf2wAhf3V6mpgdeGQNJgXf3Lu5HGFxYtFW/GmY/JDyCHAjLckii345yEsItkB7mEap9aUQt2SV7xF77xVRmxd5Y07/Z41uvRNmsyYVAw/oG6cSEcAKFYow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JIWQ78oJO0ui+0+Ao4I7TcCz+YuTET+M0/O89n3CXv4=;
 b=VfAK8T3xet7k7L3a8oWoIFPeCgOPangfLAkjhsyu54PksIKsKp/Qkg2zMAmHF6LMxWREoY/jX/8wmIxN2fb+7eUIG/4s665Gca/+mNBQfQmsdwHq48e5cAZ+Wr8+f6n5ixawebmoJ0wpZqdr0OAO1MmQAMAvk7tam+ceEAIeuq0tGgrbEJO+uMzpTiK19GtQrSnJL3RyFZarKZwhWaodLP3UUfOF2ew1dfghjEIMZ/LXttpvdhyJg+0CLuvECovz+EFOGaWkTCLd7qByt18pCGxCe1j6l1o0m+C96fh0LeO7mXszzw+ixFV5/8rkPaMgRK8cXQqxPax83HQZg/c5+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JIWQ78oJO0ui+0+Ao4I7TcCz+YuTET+M0/O89n3CXv4=;
 b=JcRuB5wJHPGbCsL8qXRlB/oJwI+XMhV2jigyYz5SyG/2k77f6U7J0799W/r+vEMCZR20FvhIi6PIR5eQJyzfVNvSh6NHi09EY+FhZJcCS4MZyqczrAGkp9lqQfO+zRgTNBu1L7Xbv+93eaKn/yP3kXZdHop4JluJshyoJHfBIvc=
Received: from CO1PR10MB4722.namprd10.prod.outlook.com (2603:10b6:303:9e::12)
 by CO1PR10MB4514.namprd10.prod.outlook.com (2603:10b6:303:9d::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.11; Tue, 7 Dec
 2021 03:53:35 +0000
Received: from CO1PR10MB4722.namprd10.prod.outlook.com
 ([fe80::54ed:be86:184c:7d00]) by CO1PR10MB4722.namprd10.prod.outlook.com
 ([fe80::54ed:be86:184c:7d00%6]) with mapi id 15.20.4755.022; Tue, 7 Dec 2021
 03:53:35 +0000
Message-ID: <1193986c-f55a-2fcf-c6ed-83350937ce91@oracle.com>
Date:   Mon, 6 Dec 2021 21:53:30 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH RESEND v2 2/5] dma-pool: allow user to disable atomic pool
Content-Language: en-US
To:     Baoquan He <bhe@redhat.com>, linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, akpm@linux-foundation.org, hch@lst.de,
        robin.murphy@arm.com, cl@linux.com, penberg@kernel.org,
        rientjes@google.com, iamjoonsoo.kim@lge.com, vbabka@suse.cz,
        m.szyprowski@samsung.com, kexec@lists.infradead.org
References: <20211207030750.30824-1-bhe@redhat.com>
 <20211207030750.30824-3-bhe@redhat.com>
From:   John Donnelly <John.p.donnelly@oracle.com>
In-Reply-To: <20211207030750.30824-3-bhe@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YTOPR0101CA0026.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:15::39) To CO1PR10MB4722.namprd10.prod.outlook.com
 (2603:10b6:303:9e::12)
MIME-Version: 1.0
Received: from [192.168.1.126] (47.220.27.44) by YTOPR0101CA0026.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:15::39) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.14 via Frontend Transport; Tue, 7 Dec 2021 03:53:32 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7b182ee7-313f-440c-7259-08d9b93524be
X-MS-TrafficTypeDiagnostic: CO1PR10MB4514:EE_
X-Microsoft-Antispam-PRVS: <CO1PR10MB451407A7463016488BFD49B9C76E9@CO1PR10MB4514.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HLpC33E0FfbRQ89VTbcML6MMIcRBsx+5Bd7HZU3WDnVw46uMJde0ikrTiL+sF3SANt6ZiKDgY/BPwcFEpUI3RzuJ8uBDY6Jfq7eC6n+9nh85j+FA+awY24Nx9rWM6Ji8ZVEopFqB+PxoRnHvbdPnC6f4Gp2ueAB8CNgXughFEWAwR6RnlBj9jgTDfxQnlv7tt0V4rzoQHmKIjBGjyYE/ZpER0xXJQQ7cOVY7NMH7amPt9kNNaqnwbeTopI8O2QilWPhJadvqcEimXTg3JDAXkkx+rGjYNaI3hA/vz7Bw88PKIJYX9dWA4AvgTPBlN7r3LaNbkCRIB2Z/e4PlnLRvKV/TDtRfhUqSRZ6l5V3XhNIYWdII/yJOdFrMc7YozFUApNT3s+apt8pu8A7MBbJHn+8/0IzaLOONMaeICCnLwU9TBwN5A2Gkunr0S5k/FWBegVInzW61nvE3Pbi4HDCauw9iQFlX+MmcW7dWqzuDUpiRyda7NV9UJb5RCPNZbHOP6jENN14CO+uGwUs3R2dJQvPOHwhOnfLe9nmZ4q+ViRxbZxbe9aTN4M+ahsIuxl5J9IWbsaK1Xgg8S1besz77wZmqExbND78A1zaJ7V018ZldffaFbzVmclijAS+TsxksYBE96yXnk25Zy/utjsyEFovaqpTRRWpGirpAlyv/XJTUVw71wJrxuv/akUkhnkF62ONS8dqoIm2es5ichFkTAr9eLvtKirIj5Y4vl+x3Z6Rp1KDYUrelfEPRpGp3Pp6o
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4722.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(508600001)(8676002)(6486002)(53546011)(5660300002)(8936002)(956004)(2616005)(38100700002)(2906002)(26005)(66556008)(86362001)(7416002)(83380400001)(31696002)(16576012)(36756003)(186003)(4326008)(66476007)(66946007)(31686004)(316002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QnN0STYxWWhjS3lQbjZnWFl0YWtrZzBmTjZCeUhRM3QybWdQZkppUVI1Ukdn?=
 =?utf-8?B?YjN0MWltMUdnczdBbUJlV0QzajA2YWxaMmJhVmphb1ZPTWpMOWRYRGdZVGs3?=
 =?utf-8?B?bFV6d3VtK2JSQml3OENocEZTcEs4aTlOZDVWeU5tUEhWbFk1T1d1UlBLVndj?=
 =?utf-8?B?R2JvUjU5R080VElpM3pUTnpXdndESjhQZE9Dc1NoclZYMFpURHUzcjdlakhp?=
 =?utf-8?B?cXRYM0FQR3BOV0RPQ2FzZkdSbitGdHArQUF1Zmhrck5tZkZwZ3lEV1Erd2dV?=
 =?utf-8?B?T2sxNUtmaDRoWGJOcVlVUU9uTXVIRG1oOTk3WjgydXo1cFBuZTVTVVl5cXc2?=
 =?utf-8?B?R0owUW13TnB5Qmtmb1RBUm53bmNIUDRqNTBib0s5Nk5PRHBsb1BLL2N0SGRD?=
 =?utf-8?B?aEVPTzY1Z0ptSUwrVmZzWmJiRDVoUVlSYmhKVEFqcnBtdkNSSER6TGNQOHgr?=
 =?utf-8?B?V3FoUUNiQWV5VW81Y0pNUUJGd1VVL2JYOWdNL25Wb1NaUTRqcWhxTUpVS2x5?=
 =?utf-8?B?bkp6T1JyRGlPTXZ3ang0YkxMVHFObVduVVQzYU14dnF6Z0FXN0djdHBSVDky?=
 =?utf-8?B?M2o5Ymk0NVhXd0d2ajh0VmMyMGpVYS9va3lCNis4ZVBUUVNWY0tsSTBsNDBD?=
 =?utf-8?B?ZTB5aGdoZHBZY1JFQWtDdW1Td0xSQnlkNWJmcXlRZTB3aXZDT0g3OXlncnk5?=
 =?utf-8?B?MkJSQXVQV2U4UWRpb3hkeTBLRitEZGJTTFVGV1ZRM04vVVJFTlE1U0dJalVY?=
 =?utf-8?B?RmtsSzZOMkI1c0gxY21FdkVRQjRLUVVBb3NuR2VuS2hIVGR3QVJmUU9rVkMr?=
 =?utf-8?B?TFFOdGJlRGJxSFFCYUJpU28xbTgraHhxTXlkeVR0V0JpMkRLWWtxRkFqQVFy?=
 =?utf-8?B?VFpsVmMyaTZ6WFBoeTYvcEtzVmlFZmtIaG1wVlNQcXoyN3lDdnE1aTl2UEVi?=
 =?utf-8?B?V0Q5K3lGSjR6RjdFSEt3UU45UThrUzZQczR1NDZaNTdJWlB2aHlsc2xuTUtn?=
 =?utf-8?B?NWNEdkY5TkhXWTF2Q05SOC9jRzYrdklLZ3AzR0VwRlE2MHlhd0tEejZaQWcz?=
 =?utf-8?B?aHAydktUbU1nYlhoNWE1Kytwd1NHb0pPVXUyMFI2S3JJUXV2NDJsNDFuU0Fv?=
 =?utf-8?B?Nmk4TzVSYXJtTEpZRHExeGcyNlA1Q01FTW1JbmRQdzhaYkJFWlQ1RUZsNitH?=
 =?utf-8?B?OVd3Njg3SllFWFlvUEFxb0VBeFR3YjdNc3RlVHpwNlFvUWtoZVkvZTVqR0R2?=
 =?utf-8?B?Y0pGNXhNWGszQXppRUd5cHNTZ2xXOEUydkgwRGRFRUZETmtRSFNNa08wamZ2?=
 =?utf-8?B?dEYzY1NobzhUUFNGSm4zU2VvTUhyVUNIRk5IS2g0S0c4WUtwbVdGL2dIcE1E?=
 =?utf-8?B?WktSOTNtUm00Z2pWTjF2bFhFdVVmWlRuZ0MzOUNLR25kbStkUWx2MHdOVUJ3?=
 =?utf-8?B?QlBHaURZSHIxcWM3MXRyeGNkZnRmZE1Hb3NFNm1KNWFGR0pEQUVSM3Z4YlRY?=
 =?utf-8?B?NjhLSkdKR2loTEV0bDhMQzhKdk1nUVdHemhqdCtBaFRLM1J4R1FIVW94eURk?=
 =?utf-8?B?STRtUlAzZTlRdTZzUkp3QTd4UGFlSTBoQVQwVkJmM0pueTVWdDRYMnVlNEJB?=
 =?utf-8?B?cnNoMUxEOWFERFVPQUs1WEtWOElFVnJsdHpuZGRaejdjYll6RGdjRGduSnJq?=
 =?utf-8?B?aXZsMXlVZW12Mk81YXlGQ1pJMGFOMnl0S0ZRZTRBcWU2eldVREowS1hRSGRK?=
 =?utf-8?B?dWN3TWNjL0lZWk14OWJOcjYyZVJYM3BxblNsZG1xV1U4bjk3UjhZTVIyMDdC?=
 =?utf-8?B?UmN0cVYrMFptUXQ1YWhZRjFPWGVBQXlpb2FRZ0xacTMxb010bmU2dllxcFB5?=
 =?utf-8?B?SnhueEpJdlNGNjgrZFJzRUVtbjBobmFLM1VaaWdyNnJsWkFEdDJJM1FMWGxm?=
 =?utf-8?B?SzFkNjdlelY1N2lPUndLZC9ZS1lHY2NuRGIxU3NPV1BYYUg5RUdObG5vOUhG?=
 =?utf-8?B?SVFzeXI0WmZOOGxRWTN4SHRBYm1sM3FncVRFUjRVSDBWK0hUOU5uNlVBVk9p?=
 =?utf-8?B?YS95L1lJOW1xb1hBaE5rUzhSblhHejZzcXdtN3RJcitNeEY3ci9rdVhZeXdu?=
 =?utf-8?B?blZYbVJGM1gxV29PdDUvZWtyNlM0bmpkWlpCVk1zcTNKVFBwT3UvY3lUdUJ2?=
 =?utf-8?B?UDVMUGR5bHU1aVpucXVJYVIveUlYa3FJcy9YVFc0V1BMRnJETzdUVHVpVXYy?=
 =?utf-8?Q?B3NdanMb5rLH9a+3sd+2Lje7yZdrxLaIPn5oqfVGrw=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b182ee7-313f-440c-7259-08d9b93524be
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4722.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2021 03:53:35.1907
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RlYaGuDbO08nSJXLHjmCHVfiZVRxqdLiLmC/q7OTzxBbYuQcztxDh/VA2P9jNGOxwNvlueRB0+SWU0aY5bDT5b/RvmGc0Bhcmplxu4Xo5SU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4514
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10190 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0 spamscore=0
 phishscore=0 bulkscore=0 suspectscore=0 malwarescore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2112070022
X-Proofpoint-ORIG-GUID: lNqQI5jzWdBqr0ZXGOsQTQSquvcfObB_
X-Proofpoint-GUID: lNqQI5jzWdBqr0ZXGOsQTQSquvcfObB_
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/6/21 9:07 PM, Baoquan He wrote:
> In the current code, three atomic memory pools are always created,
> atomic_pool_kernel|dma|dma32, even though 'coherent_pool=0' is
> specified in kernel command line. In fact, atomic pool is only
> necessary when CONFIG_DMA_DIRECT_REMAP=y or mem_encrypt_active=y
> which are needed on few ARCHes.
> 
> So change code to allow user to disable atomic pool by specifying
> 'coherent_pool=0'.
> 
> Meanwhile, update the relevant document in kernel-parameter.txt.
> 
> Signed-off-by: Baoquan He <bhe@redhat.com>

  Reviewed-by: John Donnelly <john.p.donnelly@oracle.com>
  Tested-by:  John Donnelly <john.p.donnelly@oracle.com>
> ---
>   Documentation/admin-guide/kernel-parameters.txt | 3 ++-
>   kernel/dma/pool.c                               | 7 +++++--
>   2 files changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index ec4d25e854a8..d7015309614b 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -664,7 +664,8 @@
>   
>   	coherent_pool=nn[KMG]	[ARM,KNL]
>   			Sets the size of memory pool for coherent, atomic dma
> -			allocations. Otherwise the default size will be scaled
> +			allocations. A value of 0 disables the three atomic
> +			memory pool. Otherwise the default size will be scaled
>   			with memory capacity, while clamped between 128K and
>   			1 << (PAGE_SHIFT + MAX_ORDER-1).
>   
> diff --git a/kernel/dma/pool.c b/kernel/dma/pool.c
> index 5f84e6cdb78e..5a85804b5beb 100644
> --- a/kernel/dma/pool.c
> +++ b/kernel/dma/pool.c
> @@ -21,7 +21,7 @@ static struct gen_pool *atomic_pool_kernel __ro_after_init;
>   static unsigned long pool_size_kernel;
>   
>   /* Size can be defined by the coherent_pool command line */
> -static size_t atomic_pool_size;
> +static unsigned long atomic_pool_size = -1;
>   
>   /* Dynamic background expansion when the atomic pool is near capacity */
>   static struct work_struct atomic_pool_work;
> @@ -188,11 +188,14 @@ static int __init dma_atomic_pool_init(void)
>   {
>   	int ret = 0;
>   
> +	if (!atomic_pool_size)
> +		return 0;
> +
>   	/*
>   	 * If coherent_pool was not used on the command line, default the pool
>   	 * sizes to 128KB per 1GB of memory, min 128KB, max MAX_ORDER-1.
>   	 */
> -	if (!atomic_pool_size) {
> +	if (atomic_pool_size == -1) {
>   		unsigned long pages = totalram_pages() / (SZ_1G / SZ_128K);
>   		pages = min_t(unsigned long, pages, MAX_ORDER_NR_PAGES);
>   		atomic_pool_size = max_t(size_t, pages << PAGE_SHIFT, SZ_128K);
> 

