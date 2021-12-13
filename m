Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E326472F6D
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 15:34:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239464AbhLMOev (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 09:34:51 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:37510 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234686AbhLMOeq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 09:34:46 -0500
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1BDBl3eK019680;
        Mon, 13 Dec 2021 14:34:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=gTw9KIlYFsRvm4j3s9SRyoutpbsxatehIKdH7mdVUpI=;
 b=rNk+MwCGNE27xf3DPjep905lPneQeiqA8tlVaNCoVUssZkDdP32uXwwRN4rscWTxQ9YY
 cLP7Mx+QacW0IHv7URixVzDztfs8J6lqINEJ1yHVfwfG5bLPXP/E+wiifBHzMmXRFrxZ
 eeS+YTKwGaVI+dsZcoqzeTdpS6SH4sp1+svIQS6icrygeswD4nuDoGTnOt9B7iTdOfgu
 NTAi3YbvtOek7rFruoElMpo+upNaqn4OUyGBuXjR0iTV6QCMMfRErcaRWdb7bECjZ4J7
 mDjHwDk0v7/dyIykZvsZFkzFkl8Hi3BnWdY6JSggPeAEsWdCyItBMFpsst+llB3g3G9W Qw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3cx2nf8tph-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 13 Dec 2021 14:34:15 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1BDEPUbM011175;
        Mon, 13 Dec 2021 14:34:13 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2175.outbound.protection.outlook.com [104.47.56.175])
        by userp3030.oracle.com with ESMTP id 3cvh3vjc0y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 13 Dec 2021 14:34:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kg7mehkaawWC0uHpg2R+63n03Xh+bX8E4Ld/GC+XnQtJfpZbgJXz7hI00u67LYZBdrxDEh2jMIYrOux+rCkTHUBD6/QViRlSH1E3L7kdmc8q9ySTOj6Z2uPeB/uxI0J2eAOy5KohKfjNLw2wyXm68bG/l+SIO75Rsd+nVWWXpo4xrwzubmuyQ0MUgG9yQ/kFVJFJZr2mUlm2rVCJk2I8yZdwmhwvkIx8Y9J/T4Y2rrTUrs+GEGVvDrr3V1lDt30CxfrxKUS/RgBpi3adEWztb5eNtv9+Fttqq2ZcCENxu7f5nrY+NwMRxEFr/6dHzQWj8RUj69GC+zxGxiLAtYkePw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gTw9KIlYFsRvm4j3s9SRyoutpbsxatehIKdH7mdVUpI=;
 b=B+MlaEeyLw9akzII6XemD5Au2Qzk4h1zuHzUoeq9plde8X6yKnZi+c44W33sCTH/NwmX3w2ZMU65QDmDvPJ3gbrK6QA/ceEWxzLLaW+sq9nbwtMG+/GXFskwb5NY76cQQSuTw4kPDQtovxoQm7dG/HqslIvgUn9JPfRsQeXfopHKVuzWgUqZ4/rRdoZ9tfEjikroF87zgVH67wbWblwNmQC+1ol47SBQo2AXka7twuzXPwVdisG+2E2C/DdVeg07swJOcUf1KmneklPIK0D/A3B75JuYyyxxnToktpULK04Yt5aMqYYBYcS9qLyXz+6saFIl7Ex8aJVRE1UlyWRiTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gTw9KIlYFsRvm4j3s9SRyoutpbsxatehIKdH7mdVUpI=;
 b=RmjN3V2jZTms+bqYVnuFfJD7789N2FqZSXHF64FaKyYk84nkFTeZBUgOaCf1uAxTQeNms4Hit7rDnR+OF41Qv3edSKL9DJzAVRROt5M9E39b4mb7qX6ikq0iv43yrS8vArLp3R7eMNltO3pwr2XaZ5w3pq/CS1EvV4dP83SjfwQ=
Received: from CO1PR10MB4722.namprd10.prod.outlook.com (2603:10b6:303:9e::12)
 by MWHPR10MB1629.namprd10.prod.outlook.com (2603:10b6:301:9::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.17; Mon, 13 Dec
 2021 14:34:10 +0000
Received: from CO1PR10MB4722.namprd10.prod.outlook.com
 ([fe80::54ed:be86:184c:7d00]) by CO1PR10MB4722.namprd10.prod.outlook.com
 ([fe80::54ed:be86:184c:7d00%8]) with mapi id 15.20.4778.018; Mon, 13 Dec 2021
 14:34:10 +0000
Message-ID: <c99abca7-8c3f-94da-3f0e-e4b9872d2db0@oracle.com>
Date:   Mon, 13 Dec 2021 08:34:03 -0600
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.4.0
Subject: Re: [PATCH v17 08/10] of: fdt: Aggregate the processing of
 "linux,usable-memory-range"
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
        Chen Zhou <dingguo.cz@antgroup.com>
References: <20211210065533.2023-1-thunder.leizhen@huawei.com>
 <20211210065533.2023-9-thunder.leizhen@huawei.com>
From:   john.p.donnelly@oracle.com
In-Reply-To: <20211210065533.2023-9-thunder.leizhen@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT3PR01CA0100.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:85::33) To CO1PR10MB4722.namprd10.prod.outlook.com
 (2603:10b6:303:9e::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5a79451d-1786-4bb0-23f1-08d9be45a074
X-MS-TrafficTypeDiagnostic: MWHPR10MB1629:EE_
X-Microsoft-Antispam-PRVS: <MWHPR10MB162979D94AD05919C54F2F30C7749@MWHPR10MB1629.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2331;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZiNsrl8rQSpKxfkRUamt7ZzxSgzpzwbPKDPQLH5pT+WeXPheqX/8nfXzoPUIQTFYt6cSKkZYw4f4Ikh5nI6IUuLMVtX34rhsiqcA2/GWdiPS4/a8+sv6mHBcJmS6u3Jw1KSzw3iQPGemgDuen1hqRV4BZBuFwNnZaADW8kgrM98OW9+ZFZUb8CH3qrOymXBti+5Mjhsb4Qa/ymAHAr6VPEr4z3XpW6Wt1zH8NJuT7FkewevqSftMk9Fc0nzSqqokYd2wJp7KnKi+ucBEFFBEL0LoxpNexKTddvZOKJVcma2/SJyQkcdr80vvRh5toip/NCoSdbAGzRRCHq85nQkEg6/DtV4m+jGFmDvNN1too7M67x0XZzKOk34YqnL8BzfLTnAjfm6LA77uWt3zLz2POgZXm0F34RyC928HQ9gjI49WL3+G+/NF0tXs93sI3RdhHoCLO+n+MCliw8kTSiqSa8des2mH4QygZljuDW1zcPmxX9zqXPveujBjPBm1t1ewNLlx766znCjumyrzZYDR6dkikhwyFa6kAkK1UOg9qaRfazDFWni8vHRa4UfW7N1VeSv7NkuXoxwI38d1K1x3WJAkkc72fYK9LwMRTaq7PpAdbw2iUf3yZcidUzMvXr7UAilUTB1fDTBwtvXDDndDkUL5GJycVyYsLb2B3T7KNpcJGgo40VQRbEsUt/4vP6ZALKOWg5iT4jW0G+KuKUN5r4ykn6vxv+7O6JBBYp4PWEU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4722.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(8936002)(8676002)(66556008)(66476007)(66946007)(6506007)(53546011)(31696002)(921005)(5660300002)(4326008)(38100700002)(7416002)(6486002)(9686003)(6512007)(2616005)(31686004)(508600001)(26005)(83380400001)(86362001)(186003)(110136005)(54906003)(36756003)(2906002)(6666004)(316002)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UE1oc1hVRHI0Vm5aK2h6WER1cG5CWGE5NnNJS1UrY3NOOXlFN3ZIZ3NySnNG?=
 =?utf-8?B?L2pSMVZLSk9zTTlrdy9kQ1B1YU1hYysyNVBGQlRqMitTZnNmRlMwS1ErM2E2?=
 =?utf-8?B?VkRQNzNHYkhQWVllUVo3UE1hZVdoZWRZN2Z6Y2VNbytOQUpmdUE5aS9yMUdD?=
 =?utf-8?B?c3EwQ3k1UzZNNU9MZXQxeDNJY095M2JIL1lSRWlVeEQ3RGt5aTFBOTBvSFlk?=
 =?utf-8?B?SU1XQVpNUUdQOFNlMFR6bmxaVlBBb3hSZFF3NGxZQ3p6UnBlN2MrWUl2RmhD?=
 =?utf-8?B?bXVVRzJ1SzVzTEVLUWZBb2FZK2dzRlc5aXZFNzVIMk9iS2tRUGV4MmdLZGg3?=
 =?utf-8?B?N1VlUmNGcDA4amNvL3lDQUVsUUtnSGpHNU9wQ0xTNStKb2l0VjhBQTJuTEpl?=
 =?utf-8?B?a1IzYng1K3NuWkpUTEFiVlNuQ0ZEYS9TWjBhQWV0QThBcllrWlAwNy9Nb2x0?=
 =?utf-8?B?bytKeDd5ZVh3UTY4Z2hzWlFBZDVpUUcxWWlzVUUvWkhPTm9HcXpsWFE4ZU1C?=
 =?utf-8?B?eGJ3N0l0ZHpYcjFVcjE0SUY0OFlDS28zYkRldXdBdVgvZnhacktOQit2NnJn?=
 =?utf-8?B?SS9vQlNSOHBXSUtzYTJ1T0ZBam94eGN6TGJYK1AxczlHUTNBeVU0NHV4ZVRx?=
 =?utf-8?B?NFhNSE8rZGVPUFRXaE1BMm16TUhhemVKaU11dVBzdGQyUVN0Q29aUzEvZUsx?=
 =?utf-8?B?bzVYQzI3RDdDa2FpdGhFWlNPdWpsVHhEUys1eGNiTzV6ZDhRMHlDZzJjZXZO?=
 =?utf-8?B?WWw2YVFsVFdOZWlaZXN5d3RHR2dmZzRjWkIwM3JaOS9MYzBZWXhzLzdKS0Js?=
 =?utf-8?B?bkpHUnVTVTAreFY3OHBxTEtOQ3U0SWxwSG5CcmxjckQ2cjdNYlIwamJCYXZE?=
 =?utf-8?B?T1FOZUpXeGNRbWs1b0dYb1MrdzJwWGR0OXRpc2dyb0VzbzdSaDl2MXZYWHE3?=
 =?utf-8?B?M2xCVjZqeFYzS2hrcEI2WXptSGxQUTdYYTkrWHdNOTNUaHpUWUxLSVBGK05G?=
 =?utf-8?B?Qm5wV0ZSQ3ZvRmdaOXMrNlFwWHk3eFhMTktGbFh2MGdRSXNCeFZuWDVENlJo?=
 =?utf-8?B?K1owdTc0dnVrMDgzRmJjUG5BRTR3bU1GTEdqeEZVNFV1Q1J0UzU5RXJnYW9v?=
 =?utf-8?B?YnNFOGRNRHFyQ2RSYWpoWHlsc0cvcHlFSjg5SjVlVzFNTVc4Rk1xZHBrOXli?=
 =?utf-8?B?bE1OcjgvTlRGMHZIc1VuZExSUS95eWZ2ZGUrS2QzQ0QwMjlVUmFwb3VtWDE3?=
 =?utf-8?B?NlB5N0R0QVpHM3BnRVFmOThYVXJDNWZVQ0FMVExqVDBFdXczbmN0cnM5MWs2?=
 =?utf-8?B?ZWkwVGl6MW5nOGFJcWpxdXhCSyt6MmpxWlRlbURMWFR1azIyWkJWbDE2UUNZ?=
 =?utf-8?B?eGk5MjFVQjVZVlo1YWhKeXZmd1dJSHRmOXI0dVdNU3gzY2EzNlBDUWs1Wm4x?=
 =?utf-8?B?WnViS0x3M3cyQkZPM2Z6ajVUQm9Ic04wVVN3TWFqVzNXai9RMmU5UEJQRTNl?=
 =?utf-8?B?KzVkNjJMWVE5VldzU0FPZUlsQklrdWI1UENSNnBtRUFCZlJlcHpWOSswWlN6?=
 =?utf-8?B?UjU1aWpSOFZlUURRMnA5UVJMSlhWQ3J0RlF6akdWUjh5WFVBVXErK2FLVGNt?=
 =?utf-8?B?MWQ4NkNGdnpMSXNlUGVKYWxXdDlhSjFyL3pkZ3gway92bENEUUE5QUEvTnU1?=
 =?utf-8?B?OWo4MTkzN0EyQ1Y5R29HVUc3VlMvSkU5ZkdSMThnQUg2YzVmdmNEaWd5dmZT?=
 =?utf-8?B?VXRheU54OVZyaDFKT05qTzdWYTVPSWhGMW9keUM4QXFyTEUwMm1uQzRFUHN5?=
 =?utf-8?B?Zm5CbWRzR21Id3QvdnU3dG1KU05pWmdjaHJjbVkrbGtvYVRPaDBLc2ZoWFJE?=
 =?utf-8?B?OG1oU0xvd0FQa29rNm9TK25JMzAxbEhLalArUGRUQmh3KzBDSFNyc25YYWI4?=
 =?utf-8?B?bGNXbFN0OWZCVVpENzJXRzJIUStaVGFISy9pTHIyVEhyOGpoZmY2NDVFamdz?=
 =?utf-8?B?d1lpWkdnbk1qWlN4YXYreGk4YzI3QWdvWmUrcHk2ZmlPM1NaSm43U0oyYzZs?=
 =?utf-8?B?b0NiMU8yeC9LQTN4cjVjYXh4cllZVzg2TW5PN3BMQnlIbU9BcnVhc21vRlJs?=
 =?utf-8?B?M3Z2NGxxQ21DdHZNdVR5cFg5TWtWd0FUbXNseDg2bnMrWm4weXovOGlGRW1k?=
 =?utf-8?B?aURFYkQ5VVowbWlkQkc1dk5qNTc1S3lYbkFGSklrdlgzRnhLZS9GaEJVR29k?=
 =?utf-8?B?SHNlWlgzemQ1U1kvbVg1a2tnQW93PT0=?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a79451d-1786-4bb0-23f1-08d9be45a074
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4722.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2021 14:34:10.6122
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oPUWLw48VmxANDrW6MleWqttB5d2yAS36zPQd7wqrHdQXluLygGxLarbQeaI3iCHRPyQSScsj99BT3+1B9tuxz6cJPF+tdi+vlGVBaj5TG0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1629
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10196 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 suspectscore=0
 malwarescore=0 mlxlogscore=999 bulkscore=0 mlxscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2112130092
X-Proofpoint-ORIG-GUID: ZoEADiMSX3wXTsbe8dEkzjoNLlUVhksL
X-Proofpoint-GUID: ZoEADiMSX3wXTsbe8dEkzjoNLlUVhksL
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/10/21 12:55 AM, Zhen Lei wrote:
> Currently, we parse the "linux,usable-memory-range" property in
> early_init_dt_scan_chosen(), to obtain the specified memory range of the
> crash kernel. We then reserve the required memory after
> early_init_dt_scan_memory() has identified all available physical memory.
> Because the two pieces of code are separated far, the readability and
> maintainability are reduced. So bring them together.
> 
> Suggested-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> Tested-by: Dave Kleikamp <dave.kleikamp@oracle.com>

  Acked-by: John Donnelly <john.p.donnelly@oracle.com>

> ---
>   drivers/of/fdt.c | 15 +++++++++++----
>   1 file changed, 11 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
> index bdca35284cebd56..37b477a51175359 100644
> --- a/drivers/of/fdt.c
> +++ b/drivers/of/fdt.c
> @@ -965,8 +965,7 @@ static void __init early_init_dt_check_for_elfcorehdr(unsigned long node)
>   		 elfcorehdr_addr, elfcorehdr_size);
>   }
>   
> -static phys_addr_t cap_mem_addr;
> -static phys_addr_t cap_mem_size;
> +static unsigned long chosen_node_offset = -FDT_ERR_NOTFOUND;
>   
>   /**
>    * early_init_dt_check_for_usable_mem_range - Decode usable memory range
> @@ -977,6 +976,11 @@ static void __init early_init_dt_check_for_usable_mem_range(unsigned long node)
>   {
>   	const __be32 *prop;
>   	int len;
> +	phys_addr_t cap_mem_addr;
> +	phys_addr_t cap_mem_size;
> +
> +	if ((long)node < 0)
> +		return;
>   
>   	pr_debug("Looking for usable-memory-range property... ");
>   
> @@ -989,6 +993,8 @@ static void __init early_init_dt_check_for_usable_mem_range(unsigned long node)
>   
>   	pr_debug("cap_mem_start=%pa cap_mem_size=%pa\n", &cap_mem_addr,
>   		 &cap_mem_size);
> +
> +	memblock_cap_memory_range(cap_mem_addr, cap_mem_size);
>   }
>   
>   #ifdef CONFIG_SERIAL_EARLYCON
> @@ -1137,9 +1143,10 @@ int __init early_init_dt_scan_chosen(unsigned long node, const char *uname,
>   	    (strcmp(uname, "chosen") != 0 && strcmp(uname, "chosen@0") != 0))
>   		return 0;
>   
> +	chosen_node_offset = node;
> +
>   	early_init_dt_check_for_initrd(node);
>   	early_init_dt_check_for_elfcorehdr(node);
> -	early_init_dt_check_for_usable_mem_range(node);
>   
>   	/* Retrieve command line */
>   	p = of_get_flat_dt_prop(node, "bootargs", &l);
> @@ -1275,7 +1282,7 @@ void __init early_init_dt_scan_nodes(void)
>   	of_scan_flat_dt(early_init_dt_scan_memory, NULL);
>   
>   	/* Handle linux,usable-memory-range property */
> -	memblock_cap_memory_range(cap_mem_addr, cap_mem_size);
> +	early_init_dt_check_for_usable_mem_range(chosen_node_offset);
>   }
>   
>   bool __init early_init_dt_scan(void *params)

