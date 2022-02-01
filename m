Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 568324A688D
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 00:33:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242897AbiBAXdN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 18:33:13 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:22734 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230022AbiBAXdL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 18:33:11 -0500
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 211KT7r1015797;
        Tue, 1 Feb 2022 23:33:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=7C+E91YttALqOLsAFCpQ1MeyQdp10/ptnDzaWkqgfPc=;
 b=VR1yr8tho2jDmJrPSkVpUvJtVO/wzvkDSxh33p330FjRICpE1/6VdVq6rPEPMSxO1Hyz
 FKBFjaCSsuCeyw79lFfwT/5f3szennHb0UkGToM4Xg/QuKeFQQn9zgOHK5SEyMRnMEiU
 YsD4O0B6QDSuMngG5F89av3WmsRjxOZ1HFx7XQcYI2eZ6Khxzy531Tswjp2+Cxy/JRcc
 fQjP0WfPiQtXM2WRZiKKhzI5RN0w27rpXgDSSm9BibwDnFr2jaeod7wrNJ6BhTcxZ6DA
 SGYizbV379IdCRU7lSo9httUofYPOAcx2JRnVlXRlulZquEt+0EY9YAuHemp3I3osXBR +w== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dxj9wcdhj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 01 Feb 2022 23:33:00 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 211NFPqc133645;
        Tue, 1 Feb 2022 23:32:59 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam08lp2177.outbound.protection.outlook.com [104.47.73.177])
        by userp3030.oracle.com with ESMTP id 3dvtq1cg6w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 01 Feb 2022 23:32:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hyhzkmcd3b6u4ubfs8v8RiPucaozYgs4YoASZ3ExgG+zzqbFpEXomwHG+ALP5SIDYkTu+bhvAQQXZI5XE726ywDmV4ABSU8YQfQGymqgT6DhpOBeyOJ7hjEGTTJ9qcnozHj0FKtV2JWMJwnMnj+3tqxXYh0rEhQebvhTDIJKc1MqvWvSKA+Nt7UN/HuGoAxfs7MV/NIJpg0NZIYz94wFlobwXiX+KbPVVDMP7zQkSMHJRKcfc7JulWz6GPgZHfg3linJZh7PiDzyG8zrmIwRFCUrRnun4qwaA4yXNCpf8ydmAfadPpk0USrluqT6lMjY6FwO7crx40oEIrh1Z2lzYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7C+E91YttALqOLsAFCpQ1MeyQdp10/ptnDzaWkqgfPc=;
 b=XC3DM2NJiDihl+yAkCT6U+HoSNXNNkmjGs6KdLkQHVP5ZNJeHIw4LdvKj3ZKcjt2JrwiXiuQtEtnDaOwWn0XzkQS3iW/wA6PgeYkWJqjR25Qi6d+/Ec4mqkjXDivk4xcnmOpsBhUGYDO2PycBpY2emBUcL5fmbP+0/Whdp1Vrd6zYc5sTKs+6ALkby8ag637AtQb/DkZZ7UWAsYfcLhGpYiUFDS2Cvhyl2SUKCFfax/oAnV5kxY5kGeVGKU5W16bI3eCfcQgiYwAl6opXExzSznKq8tRuiL0Mst2XGXmFbUiRWVHC4lI28eiYw8e0FZFlLdKvALcV5hhQ1BO3ktfgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7C+E91YttALqOLsAFCpQ1MeyQdp10/ptnDzaWkqgfPc=;
 b=Ph9QQ3PvI88jJ1jg4mB3QUAPzt9tvYUSri5bCYMh7oO+uRHDRyRM4vjU0zu1BILspGuGnp7mwoMHoQBLuRdCEExELAra3BfADUdlHoNUT8B2K9opKD/vAH4H/jdJVbLOzedXS7g47hYQph0KKoK+9lPl66C2SJ3jNUPoywPAwZY=
Received: from DM6PR10MB4201.namprd10.prod.outlook.com (2603:10b6:5:216::10)
 by SN6PR10MB2592.namprd10.prod.outlook.com (2603:10b6:805:4b::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.17; Tue, 1 Feb
 2022 23:32:57 +0000
Received: from DM6PR10MB4201.namprd10.prod.outlook.com
 ([fe80::1057:d8d1:8372:c8b4]) by DM6PR10MB4201.namprd10.prod.outlook.com
 ([fe80::1057:d8d1:8372:c8b4%8]) with mapi id 15.20.4930.022; Tue, 1 Feb 2022
 23:32:56 +0000
Message-ID: <9fa0211a-aee2-22fb-d076-0464a4d8524c@oracle.com>
Date:   Tue, 1 Feb 2022 15:32:54 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v3 2/5] mm: fix missing cache flush for all tail pages of
 compound page
Content-Language: en-US
To:     Muchun Song <songmuchun@bytedance.com>, akpm@linux-foundation.org,
        zi.yan@cs.rutgers.edu, kirill.shutemov@linux.intel.com,
        rientjes@google.com, lars.persson@axis.com
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        duanxiongchun@bytedance.com, Zi Yan <ziy@nvidia.com>
References: <20220131160254.43211-1-songmuchun@bytedance.com>
 <20220131160254.43211-3-songmuchun@bytedance.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
In-Reply-To: <20220131160254.43211-3-songmuchun@bytedance.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0051.namprd03.prod.outlook.com
 (2603:10b6:303:8e::26) To DM6PR10MB4201.namprd10.prod.outlook.com
 (2603:10b6:5:216::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4ce248dd-696f-47d3-d08f-08d9e5db2d0c
X-MS-TrafficTypeDiagnostic: SN6PR10MB2592:EE_
X-Microsoft-Antispam-PRVS: <SN6PR10MB2592ED6079576CF57DF6AB09E2269@SN6PR10MB2592.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: a0E/9cHFREwF62xIqwWm9wvbSkfsmQE2HiD2lxqb2/raRydEsM6ANuzNKipReG3YLsJp6eehjhaHuy5abkuQhQwJVgOiN9ltAcLzypNmZ4fb4DlNLqPdsF2A8/K2AihIULx/6SKBnlVfSB0BKCnkANs+gEJ5WAutd7xYjRQXBa7BKOpTaTWhdxAdUewOVHOxmpTaytetWepCFUQKR/WMERRZgJgxIsZtvY0LoOdK0cJUjxlwkl3dPVxbrwM8JOu0ufBHmyzpJFjYhfYvhu/45n0HzSzrYoAV9Mt9jVaAk7GhSGAXumzjApF5/WV3FbmUwwloSvaCUyzlGU7TsJu0nyIDnP/ArQefh+mYXJEGwReTb3frAebUurWzjbebc3Y+KM1CjCB41FaDABI4nT5mU+u3kcwnkAOfJQD5sm44/zX2r6OJc2JLzs85/qHfhlUn1/YKL4uaz8RDVWzdWKTJUQffk1mqMnUWJZlckyNqZz4pSNI/ltPLml0phW+M2yeSqJLy7JJT4P57skS+ltLC0fX1kTq64TsvEDC8Ju7HYRYYlFUbwPPj719yBME6e1uJav+t5A4yLr1lYRIKCE3hMZPOrftAQLnx///6tPoqkXPysju4mDOaRHcY6BbUiE5n6Ze7yS7vmELqCSm+IJJ5nxJeMcvAB7foLU7HiZXsnlLERaLKwZxr6mmm+QXibFtyXJswJr2QIasv+eBZWaanVEFkATAflZjOybPqAVE5wvJsx3WrtMjW9aNMZC025wjB
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4201.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(31696002)(38350700002)(186003)(508600001)(26005)(38100700002)(6486002)(2616005)(6506007)(86362001)(5660300002)(52116002)(6512007)(53546011)(83380400001)(316002)(44832011)(66946007)(4326008)(8676002)(8936002)(66476007)(66556008)(2906002)(36756003)(31686004)(7416002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K2dxdVJBNklTZHdTTzB1bmRXM0tjSHVJNmlidlIrNldUTWlGWW9DSEM5b2tC?=
 =?utf-8?B?d2I1QzN5T3FwTUkyQlFxdXBYdTJGYlRHM2dES1NiZEdnL2w5NG5XM1AyVzBJ?=
 =?utf-8?B?dStYVVRNMXlaYUs4Q01vd2V5bGNOaVFGZjRXa3JvUnR4QldBczl2WlBFeE1x?=
 =?utf-8?B?cEJEK2lzckFhanFGNkpzY0cvV1Rnemo4ajVFVWRFWGtpTGtqRWh1cnZDVUxl?=
 =?utf-8?B?UWZoc1hHV2dkZDhuMXh1RnV1ZWd1NFdaQmszVkRESFlkYnR3eGZSckIwU0w0?=
 =?utf-8?B?UCthQ2M3L0ErWWJlVXdPWlh0UTkzczZodTJTUXNNTEM1S3hLbmpyZ01hV0s3?=
 =?utf-8?B?cHdlM0padkR1U1NXQ2ptS041QzJMWGhOZ3B6OFVmc09NdjJBNkZMVjJCN21Q?=
 =?utf-8?B?NTN5ckhEQmRteEFjK2JBUURIOVNiSjZXN2lMU0N2MHZzRXcxdkJNeFZFYzVo?=
 =?utf-8?B?bU9Ca3FoUXZnc1dhbUJiMUdSd3pkMEtNSW1reTE3ekhKMDVKaWZSVjRRQmlF?=
 =?utf-8?B?UTQxZDJnM0hkbURNaUozcG1QbEdHRDBCQ216ZGhUUExuQ2xBekM4NzAvVmpP?=
 =?utf-8?B?V25UeE42dGw5ZXcwSERGTEM0VmRITUN5SFBhdCtZZnJpSU1SNjdpQjhZQUVu?=
 =?utf-8?B?SmdtU1dwbFFhZzF5aTArVFB2TVMvNXR6dWVKR2xuVGhMZ2s5TzhrMTdIY0NB?=
 =?utf-8?B?Wm5QWXNTcHI3Q3VmQS9GaHFaNUxNeFJSZTBpa2xMOXM1NDhKQVBSbGNrc3Fr?=
 =?utf-8?B?SzZKY29DRmZEd210RVVBVEJFNnBQN0hBbXgvUmNLM1AwcU9BNy9zVnc3bXVP?=
 =?utf-8?B?bXRnR3pBVWNJdGdMMlpQOEh4RzJpbFZEbVB4Y2Q0UkxPNytqWE5WS1BCOWg4?=
 =?utf-8?B?a24wdkRoZTRsaUpkaUhjd21nVytEaVhlcHJTeWorcWtWYkE1ZXBhVmlxK3lM?=
 =?utf-8?B?dDFXVVpOdWxEa3JXOHJDNTVVUm9BbHhBSEZRSy9xUkJVYU9zWVhhUmZLNTRh?=
 =?utf-8?B?anRJcG5sWGRVQXEzQ3NGeUsxWXorMlF6VnBFcitCak9GVS9zRTE3amNJTm9a?=
 =?utf-8?B?aWtaR0RUSi9UcDhCdFhDcjlSOHp4d0tVbVN2UllTN1A1MVRRcEpCNUp0Ymdp?=
 =?utf-8?B?OERqcGVNNmg1cXFGc1p0VVNVRXpZZW1BblhBNVVjbGJYRUZzZDlkcUhmdkJn?=
 =?utf-8?B?Q3ErTEt3Wm92bHhWUzlibjUzY0hFa3A1dUYvU0NBbUVTWW5mWmRpOHlWNUNI?=
 =?utf-8?B?cEtCV1ZSSVFvL1dwL3R5cmNSMVo4ejBpc1psL2pUUUF1c0pXNHlyRDRRRWNV?=
 =?utf-8?B?WDdadVA1RGdibzhmWTZ6WlpUM242NXdHM21ZOTgwdHZ3OUppRnQzU01YU2xt?=
 =?utf-8?B?a01wYjFyeG56eWhqUkd0bmkzS25aWlVYbXhXWisyNnBVNkhOVkJDUGtHK2Zl?=
 =?utf-8?B?TzlqSUlpSlFhRWlUOEltUEpXSjZxS1lKQjN3S1d2YkRiVVpYV1ZWNERlemhS?=
 =?utf-8?B?azZXYkg2WmdPaUVvQnUrU3lncW9oc1RiQUFGdUQ1Y3hwT0NUNnhZTUpDU0R2?=
 =?utf-8?B?VGl1MktlcVB2Rms3UlJxZHVGOVVaR0pCazRFL0hEZmNWeitIcWdKZW94Vm5L?=
 =?utf-8?B?YmZhUmtwOU43eFN4aG82UmpJQ0dtcWNMdlRnaXBzTml6WFhPV2dmK1IrMkFz?=
 =?utf-8?B?Y3JqeldoOHUzbllHclErbFZPYXhkR1VPY1NaaDZxVVltaGUzRXdYeFNFRXhK?=
 =?utf-8?B?Z1VnNkRjUUFFYXY5MDA0S0tCaWR2WUxqdVpiRkNSejRWMjNaSyswTFl5eGhC?=
 =?utf-8?B?eElLclRId3hzQU51c0RyVERwdG1sV2lrRjdaZVJwVUVpTGhZUEg2QXd6elBm?=
 =?utf-8?B?TTRuKzBjaVE4cWpOdGcyS3dmcFpnZGRTd241OThvMi9lZWFaYU11bDlSQWdv?=
 =?utf-8?B?OFV3TUx1K2M0WFJaNURPV1JkTFVzSjJvdml2U2M3ZGpIMTJSZDh4eEE5VUxX?=
 =?utf-8?B?ZXdUQXlEdjl0V0hGWmV5RWxaR3RYMVQwR1ZJbkFtVFYya3hhRHA4dEhmbldT?=
 =?utf-8?B?MU82Mi9Jb0dodkllMlRPZXlDMy9oKytQRmdZZW5JcHFLQmx2RDhQQTY4VVA5?=
 =?utf-8?B?bFBybS9Oc3BUb0syV2xaaXkvWWxYSjZTN21aZW0wczMxczBzRHNmQTFzMDlF?=
 =?utf-8?Q?0YzGA6hf5Z9AlAXSPTVu7dI=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ce248dd-696f-47d3-d08f-08d9e5db2d0c
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4201.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Feb 2022 23:32:56.8079
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XqPzjPCCsP0qDyEa/DNYZrwyXLcLy+uObxQRwQP3pw3F4PuMQBkKxe6x8YgzaDQmgEDfarGM9OqPOpkBFrhZcA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR10MB2592
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10245 signatures=673430
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 adultscore=0 malwarescore=0 bulkscore=0 suspectscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202010129
X-Proofpoint-ORIG-GUID: uFwKoUYs4mY2nRZLEehr565Ysx2d98aV
X-Proofpoint-GUID: uFwKoUYs4mY2nRZLEehr565Ysx2d98aV
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/31/22 08:02, Muchun Song wrote:
> The D-cache maintenance inside move_to_new_page() only consider one page,
> there is still D-cache maintenance issue for tail pages of compound page
> (e.g. THP or HugeTLB).  THP migration is only enabled on x86_64, ARM64
> and powerpc, while powerpc and arm64 need to maintain the consistency
> between I-Cache and D-Cache, which depends on flush_dcache_page() to
> maintain the consistency between I-Cache and D-Cache.  In theory, the
> issue can be found on arm64 and powerpc.  HugeTLB migration is enabled
> on arm, arm64, mips, parisc, powerpc, riscv, s390 and sh, while arm
> has handled the compound page cache flush in flush_dcache_page(), but
> most others do not.  In theory, the issue exists on many architectures.
> Fix this by not using flush_dcache_folio() since it is not backportable.
> 
> Fixes: 616b8371539a ("mm: thp: enable thp migration in generic path")
> Fixes: 290408d4a250 ("hugetlb: hugepage migration core")
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> Reviewed-by: Zi Yan <ziy@nvidia.com>
> ---
>  mm/migrate.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/migrate.c b/mm/migrate.c
> index c9296d63878d..c418e8d92b9c 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -933,9 +933,12 @@ static int move_to_new_page(struct page *newpage, struct page *page,
>  		if (!PageMappingFlags(page))
>  			page->mapping = NULL;
>  
> -		if (likely(!is_zone_device_page(newpage)))
> -			flush_dcache_page(newpage);
> +		if (likely(!is_zone_device_page(newpage))) {
> +			int i, nr = compound_nr(newpage);
>  
> +			for (i = 0; i < nr; i++)
> +				flush_dcache_page(newpage + i);
> +		}

As you have already noted elsewhere, the arm64 version of flush_dcache_page
seems to handle this and flush the entire compound_page.  Is this going to
flush the entire compound page compound_nr times?

-- 
Mike Kravetz

>  	}
>  out:
>  	return rc;
