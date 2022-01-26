Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1DDB49CDC7
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 16:18:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242668AbiAZPSc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 10:18:32 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:41976 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242654AbiAZPSb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 10:18:31 -0500
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20QEo4NA010031;
        Wed, 26 Jan 2022 15:17:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=y9U0jVykbYrKcARMGWfLWEVy6y7Wj6bvIaXFsTjOx+w=;
 b=f7j6jes4KScRXi7wU+JXwqP0jf2C5QofWkWmnhCicTMVzwhbknYlR9Z9/Hab3f49aeYD
 td408R2jKgsv9sEPP7BFqCSjb3UhVc2hzO8ZbFxZHPUUeAz/ZYAe7qFRon+5/nDd9AlD
 FWaEc+1My8r/U3RnZT2zESG+kaokKO+cG83Nh3d6KZb/AWClFIGxxmpfcHaVC5i1CfB/
 OjobaVYsu0G+s7gqtVFshjo0N2nRq1AgK+jggmCRlaiu/cGytmm5H+4JtxsVd1FNNwYy
 7XAWRy/v54jRH8/oWo+anufYaXC4c3B2wjYz34YDNIuGXwHy9aas90wmTXtQ1QLDGmZQ nA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dsxvfp5h4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 26 Jan 2022 15:17:05 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 20QFGToN140713;
        Wed, 26 Jan 2022 15:17:02 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1anam02lp2042.outbound.protection.outlook.com [104.47.57.42])
        by userp3020.oracle.com with ESMTP id 3drbcra918-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 26 Jan 2022 15:17:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hs+/037WiPYBu/UZEzpgPVnRQpnMCLj8TQKWN0z08vVTi9y6jc8C+IlYIPBltsWj9e/lHdDWTH9VuQtSV50A89sNZO5S1ysZhMeERgHRNgIx2QiD8SdvF0QQydgS6M6KFqrVcOsENvwMU/gIauiUT8osk6amFGXbLK7ZnyoOwSVNwk1nI94HCzhMG9DF4zN5o6k0fSrwV9btaZe+I/nSW0r6sI1PkJkzgRw5+QDFyVUG9bQewX+FchGMdOlDphdnErhHEOh3spvuD1XymcMocJjHMva52BNWSXcecgpUo2LFykXCw0TeExFNbZB/gc/E+RE5vfaL82l2ODmQLC8sXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y9U0jVykbYrKcARMGWfLWEVy6y7Wj6bvIaXFsTjOx+w=;
 b=aHIwmEGxqXnhX0fhR6y69CzKrUhZnIFQT64jWwPuISXVgRW43yIDwwRapBof4oKVgPqLfdY+x+ig/a/hzPCDzFZDOKheX8eZxsfdLWaoyjOTzcww5sES5YbjHJUqOr7rrn3uSs1I7WG0rgPsaSPzvN48bi9W2qaFs/xr9QuUUgbJtkkXgD/s5IoLF2mTfPGhz9bNdOyxYLwdecQ5RcffiTiSiwCNNkx4/iMdZiXJc4HJNbNEMJBfMYmPQqulV6gquytdkVSqVCenPgsrcgHLuGq2eEtHaxufceEmKP6TcE/sxOK9FZ0zUP4jelU54OainoimSRUxYGEvwki2hTK+AA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y9U0jVykbYrKcARMGWfLWEVy6y7Wj6bvIaXFsTjOx+w=;
 b=fKpFtw0JwkbCYctFcNQQ6TvYc8/ZZoWNHJCQk4A9l7JO4/XiI5jv54OUKEvh0vzyn1sWSQXF5Yv95t1ge8VqiOe6TBzJDyS3XXejMGVVRBONaHwiLXONQHKYcn7W8JUyxPuTqUtlUUMHng8mwKlrUGcthINQcMnAtl7TrhVzpxo=
Received: from CO1PR10MB4722.namprd10.prod.outlook.com (2603:10b6:303:9e::12)
 by MN2PR10MB4221.namprd10.prod.outlook.com (2603:10b6:208:1d7::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.15; Wed, 26 Jan
 2022 15:16:59 +0000
Received: from CO1PR10MB4722.namprd10.prod.outlook.com
 ([fe80::30b4:4c4c:82df:29f6]) by CO1PR10MB4722.namprd10.prod.outlook.com
 ([fe80::30b4:4c4c:82df:29f6%6]) with mapi id 15.20.4930.017; Wed, 26 Jan 2022
 15:16:59 +0000
Message-ID: <171196ee-8c61-2ebd-b74d-87c0a15ae4ea@oracle.com>
Date:   Wed, 26 Jan 2022 09:16:38 -0600
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.4.0
Subject: Re: [PATCH v20 1/5] arm64: Use insert_resource() to simplify code
Content-Language: en-US
To:     Zhen Lei <thunder.leizhen@huawei.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H . Peter Anvin" <hpa@zytor.com>,
        linux-kernel@vger.kernel.org, Dave Young <dyoung@redhat.com>,
        Baoquan He <bhe@redhat.com>, Vivek Goyal <vgoyal@redhat.com>,
        Eric Biederman <ebiederm@xmission.com>,
        kexec@lists.infradead.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        devicetree@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        linux-doc@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Feng Zhou <zhoufeng.zf@bytedance.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Chen Zhou <dingguo.cz@antgroup.com>,
        Dave Kleikamp <dave.kleikamp@oracle.com>,
        John Donnelly <john.p.donnelly@oracle.com>
References: <20220124084708.683-1-thunder.leizhen@huawei.com>
 <20220124084708.683-2-thunder.leizhen@huawei.com>
From:   john.p.donnelly@oracle.com
In-Reply-To: <20220124084708.683-2-thunder.leizhen@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P123CA0010.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:a6::22) To CO1PR10MB4722.namprd10.prod.outlook.com
 (2603:10b6:303:9e::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 74cb09fd-f792-431c-0536-08d9e0dee5ca
X-MS-TrafficTypeDiagnostic: MN2PR10MB4221:EE_
X-Microsoft-Antispam-PRVS: <MN2PR10MB42218B49A352F6AAFC5C1870C7209@MN2PR10MB4221.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4125;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hoMa6hs74GGUFBeR9e8fCP/gijtkjFZ7AjmaKoikdyzRkEElE+CjpuBBj5DLekrOkYoSkbiq1e/0S0FThC7b2nf7bmDV2KZtziuxmljcdgNUe2yuVOLT1BRcf8RqlWal4scQEiGJWITTQ6FDoDgzgmO0HXGCvZFWpbLQ0mvWGblNswMv311H4vBACKO6cgBERWjZqchIwfZ3ujtB940WTAOb/Y9/7rTUFOQ/8XTU23IvQJYCq5f/psn1fl5KfTem5/FkKnpCHc+lkynUzbScyjxPL+cjIem8UQTDu8gNNzV2j9lgUa6ZRQ9EkwLsvxEPv3Rs/CuHRAAukecl5SKN2GX84yZu2xftrPjo4DXfBFMaigftAjm2IwyXiQerDN3/NiIyvB2gneGxgUJWqYuWi85nXfU0xl8hkBAASDeXoOPq2zBj0bYURCe+JWPZIqa1vag54E97ZW+9rUPhXi/AdTnlnrKbl1pHsQT40XQe5LQbPPojv53n9LIuqqA6INp/4NidXnEr7mq1+NEuurniP/3lyzHoFxCXRZvL5cnd9KsWHcgC7exlHPu0tHCFE99MTrKUdZQ8BApXYKFDmH/G4YTcVBkw2BFn/chAujVAxairlV3dWhR7KURJLZura8FP9ZoF3UW1r1plUn7YwDZ+kqGl8jtutnNX8yGb+5eI/59X2xOEyi2YPhAxiI7ShhslwevOqCUsh2aC7JcK6THh1pK0ZzxFbJdMM9es3/tJ3z4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4722.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(9686003)(6512007)(83380400001)(53546011)(6486002)(31696002)(86362001)(508600001)(26005)(186003)(2906002)(2616005)(107886003)(316002)(38100700002)(6666004)(8936002)(36756003)(4326008)(5660300002)(7416002)(921005)(8676002)(110136005)(31686004)(6506007)(66946007)(66556008)(66476007)(54906003)(43740500002)(20210929001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QjhwMmduRlRtZ1FIcnFLZnJnc2lXMU9NYW5ER1Fsc01ZTHFGSTNXYUFxL3F5?=
 =?utf-8?B?bFhpMTZXb0FlNUFKVlA1YUh1S3IweGVrWHBjcHFDOHdSY3dQVW8wV3crSUNQ?=
 =?utf-8?B?Q3VHSTR3aGxHblFaRktTRWcwTVUybUtOdlIzdGdnd3BtRGs2aUQ1Yno1M0Nx?=
 =?utf-8?B?NG14N2ZvS0xBZEtKZVR2SXlJM3E5K0dHYjV2blg2RGcwTlBiRmZ4Mi9Ib3pi?=
 =?utf-8?B?ZytUc3h4WlhsaFRQdFZlZmd5L3JDWWRMV2NjQXEwV1FlS0oxcHFmWUo0eDJB?=
 =?utf-8?B?aVFpMG5Ed2t3c04zU0hKSC9Iekx0TTRLVXhtSVV2ODQ5ajRmOFhEUExYWERL?=
 =?utf-8?B?MzdpaWdGZllFS0RHblZ5Yldqbkt3Y1cxWHFva1A4SkRneWtKQ29majR2cjcy?=
 =?utf-8?B?eVBsNDI1dWh2YlFXamltRGJDTWJSLzZjdDVqc0k1cU1FaEFLdFBnTDlYc3gy?=
 =?utf-8?B?QlliTTFQUFc5QkRIZ2x3dUpmUW12MlNaVjdmcXQrY0MvdW9MN0craXpsTTdt?=
 =?utf-8?B?RzE3bWhPRWRPc016K0RORlpnWmJUWGFrOGtpSVhCZTA1L1UxNHZFa0NYWlVm?=
 =?utf-8?B?YnY2NG1aUTg3ZVNwcDNud0czQ01BRnhBaHljWW4rNGhML2o0NTh3aE5hT0hi?=
 =?utf-8?B?TEQ2OTk0WU9WU05oclFGT0lFY0laUy9pWTZGMFYyR0pGWFlXM01PWTBsdzJo?=
 =?utf-8?B?ZFMveURGblp5bXF6UTdDcCtJa0c2VDVCQjdvSmZuT1VINnErNzVBbUo3ZHVV?=
 =?utf-8?B?TUxZVm1TWG9kQmk3SmVlK0hSUTBjcXJYOExRR0dLVFRGOHJSN1JKeWJyNDJE?=
 =?utf-8?B?QnhRZ1lUY1pKcGdJTS9hU3NiQjVGZHpsYkdzNW96cEIvSDZDbkFQZUtRK2FO?=
 =?utf-8?B?YzNYNkhGS2dnNFdFazNGdnJFcU5Ma3gzRzlncjZKZms5akVGWnlvRGdjTy8r?=
 =?utf-8?B?bTg0T1AwS09DME1vNG5CMlpQYlhIMHVLSmFDQ0Mza1QvbWhCWUFDSVdiSmlJ?=
 =?utf-8?B?c3drSGtCVnRaZ3JtWFZBT08yN1N1Sk1nV21PcU02NzNmY3YxM1NFcGhUbDdS?=
 =?utf-8?B?a3hMOGRubGNreGpUVTQ5NGtXakZ3amxuckZSWGRZMDFKRHh3ZThBbUJDcVQ3?=
 =?utf-8?B?UGRJUmZ6citFVlZZVE1pcEJIWnF1NXlHcE5XYytHS0h4NTd3NVZvdzFLSHF0?=
 =?utf-8?B?bHRaNVM4cU43MjlPTURvUlNQWjZZZjRMUTZHT1VSOTlkb2ptMkFqYy9KRmdI?=
 =?utf-8?B?MDMwNkp4dG8rcGpqU3kzQ2ZoNkV3eE9neGtBYmFabjlyUnp4a3JpeFhFSXQz?=
 =?utf-8?B?bXNXTTNWWkVzVWxtOFlhbXo2bjBjTHlNZ3RkQTI5bzRBdXJna0g1Q29GSENW?=
 =?utf-8?B?TkJSc2hoZ3BzOEhxVzRhMUhDU1ptV21FbDllN3FDalQ5T1ZCWmFTOFZrQW5x?=
 =?utf-8?B?ampUenJ2aVVLWXpTRXhwcVBoeC9SdGZ6NlF2dkFUS2d6TTQzZ3J5czJ5YWpV?=
 =?utf-8?B?Y3U1Q0FtUzVPWG9NQXkzTFkyL3IzWTRkRG9wa1hqemtBeU56RlYyUk5MUHI2?=
 =?utf-8?B?WW94ZVJETW5MRjlLYWZUeVl4SCthVWUrdFcvb0l2VEpYSHJQQkZVT0lDK01G?=
 =?utf-8?B?Z1BDQVdtWDNpemtKeEZvZWdsZUtVSE45WGVaS0V6NHA3bXY5T1I5UXVWSit3?=
 =?utf-8?B?OFQ3SXl5cG5oS2szWkVrbGxobmlhM2xXYU9RL29YVVNhek1PNW9xZ3lDYUpE?=
 =?utf-8?B?WllRcnhTNFZwOUpqbTE2am50TWxsOC9zUFRLQzI3dEQ4dUw2R3laQ3IzV1Jx?=
 =?utf-8?B?dUhYVlNoclNaVTFveDcwSGIzMWlnSTg1RzZPeWt3a0J0VE9DSE1YMUdjZlpE?=
 =?utf-8?B?a3U3RkNiT0hRUnV6Um82NHlLR3pjR2x6djVPdUlCQlJJbnp1RVdkVG01RDNo?=
 =?utf-8?B?S2cxWGtaMUNtd21nN25BMzRoUzZaUUVzdGRmVk5NRXo3MXVoT01BWE03L25F?=
 =?utf-8?B?OXV5cnBmMTFhRkJ0MjhiaDFqWXVIdG1wQldnUWxrVkk0WFM2bXZsSmEzRmNt?=
 =?utf-8?B?aXp6b0RBYXBJYlM1eW5OaHlrakk0Y1VpWWd4cVNwalp3eTE4d3o0Z3RiU0NW?=
 =?utf-8?B?bGdLbGpYc1hTQUMzZU00NXhUelpyNzdJUWl6akY0TTE1TmF4cjJEMWI0VXVx?=
 =?utf-8?B?eGNrbTZ1WEsxRExJUzJrWFlHZ01HL2hCSEtjQzZ5NzRpbmNNMlg2NldOUjNK?=
 =?utf-8?B?QXd5bHdLdUJNY2lKMktjM2h6L3FBPT0=?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 74cb09fd-f792-431c-0536-08d9e0dee5ca
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4722.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2022 15:16:59.6437
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SP1KuXTZrSSnA+JlEpJnv4K1zy3MYmanlNTh/eMZYYvoVMc9zwbEIN0dO81tKb/ck2YM9AR6hWA7QDboFQCIJDKuC3GfPmcqefFXtjqXZdM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4221
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10238 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 malwarescore=0
 spamscore=0 phishscore=0 suspectscore=0 adultscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2201260095
X-Proofpoint-GUID: oWULXmoXyUb_7dcxbETYjkZvp4vJVNVH
X-Proofpoint-ORIG-GUID: oWULXmoXyUb_7dcxbETYjkZvp4vJVNVH
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/24/22 2:47 AM, Zhen Lei wrote:
> insert_resource() traverses the subtree layer by layer from the root node
> until a proper location is found. Compared with request_resource(), the
> parent node does not need to be determined in advance.
> 
> In addition, move the insertion of node 'crashk_res' into function
> reserve_crashkernel() to make the associated code close together.
> 
> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>


Acked-by: John Donnelly  <john.p.donnelly@oracle.com>

> ---
>   arch/arm64/kernel/setup.c | 17 +++--------------
>   arch/arm64/mm/init.c      |  1 +
>   2 files changed, 4 insertions(+), 14 deletions(-)
> 
> diff --git a/arch/arm64/kernel/setup.c b/arch/arm64/kernel/setup.c
> index f70573928f1bff0..a81efcc359e4e78 100644
> --- a/arch/arm64/kernel/setup.c
> +++ b/arch/arm64/kernel/setup.c
> @@ -225,6 +225,8 @@ static void __init request_standard_resources(void)
>   	kernel_code.end     = __pa_symbol(__init_begin - 1);
>   	kernel_data.start   = __pa_symbol(_sdata);
>   	kernel_data.end     = __pa_symbol(_end - 1);
> +	insert_resource(&iomem_resource, &kernel_code);
> +	insert_resource(&iomem_resource, &kernel_data);
>   
>   	num_standard_resources = memblock.memory.cnt;
>   	res_size = num_standard_resources * sizeof(*standard_resources);
> @@ -246,20 +248,7 @@ static void __init request_standard_resources(void)
>   			res->end = __pfn_to_phys(memblock_region_memory_end_pfn(region)) - 1;
>   		}
>   
> -		request_resource(&iomem_resource, res);
> -
> -		if (kernel_code.start >= res->start &&
> -		    kernel_code.end <= res->end)
> -			request_resource(res, &kernel_code);
> -		if (kernel_data.start >= res->start &&
> -		    kernel_data.end <= res->end)
> -			request_resource(res, &kernel_data);
> -#ifdef CONFIG_KEXEC_CORE
> -		/* Userspace will find "Crash kernel" region in /proc/iomem. */
> -		if (crashk_res.end && crashk_res.start >= res->start &&
> -		    crashk_res.end <= res->end)
> -			request_resource(res, &crashk_res);
> -#endif
> +		insert_resource(&iomem_resource, res);
>   	}
>   }
>   
> diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
> index db63cc885771a52..90f276d46b93bc6 100644
> --- a/arch/arm64/mm/init.c
> +++ b/arch/arm64/mm/init.c
> @@ -109,6 +109,7 @@ static void __init reserve_crashkernel(void)
>   	kmemleak_ignore_phys(crash_base);
>   	crashk_res.start = crash_base;
>   	crashk_res.end = crash_base + crash_size - 1;
> +	insert_resource(&iomem_resource, &crashk_res);
>   }
>   #else
>   static void __init reserve_crashkernel(void)

