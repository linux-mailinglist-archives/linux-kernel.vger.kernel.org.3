Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97C28472F36
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 15:28:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239266AbhLMO2I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 09:28:08 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:14012 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239065AbhLMO2H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 09:28:07 -0500
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1BDBRLEs029386;
        Mon, 13 Dec 2021 14:27:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=vPaQzcI8duEaeNXXIkzWeWZQzquAt9auFWM1m/GXkGc=;
 b=ni65BJVyfk72yn37KT8INNeu/H4f4u+A5wdqY4a5hdEf0PmKTIUsl3asCkJqLZh2gT0b
 SMqv9fmZPp1u2crRcv82gRWE77BlmZgna90pLTd79LFuIRp6IHS3Q6mspbRcSyfgJuCT
 aMXN89Jpr7ACuOl5+cagTewEutK64nGq9lwQ94l0tmu9S3zQ7rOrmHnXXHose4r6YzU7
 TfdJ8ELfvy/KqnfMUXbb4gWk7aDmiEILLP5ObP6bpOImsKwB10VDqW7OgcoZjENW315m
 hF/blIqxprJ4KxcOm9Ndo1bVwwycoX+TL0GAqxgAw7BZi8YLIBP9NGIVTEfbO43auEsh Lg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3cx5ak8cg9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 13 Dec 2021 14:27:40 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1BDEPXBX011358;
        Mon, 13 Dec 2021 14:27:39 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2175.outbound.protection.outlook.com [104.47.59.175])
        by userp3030.oracle.com with ESMTP id 3cvh3vj3aq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 13 Dec 2021 14:27:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CqB+3EcsBhnl+Dsr+O3DPDHJCyG3rFhMqlnaFm5J2WP54fC8bCokinGbNYUgCj15c05KZtAEb8KgSedAxWArobgfQXgLHWIuCGJdCYPnPA9zo+EeFk5hG02y/BOYry/n5Ivy92nPosRCmQrnnUcxxgWTM8/sAcH+INOD+wnzoc8zlj5Nhpgb6YBCrwJAX93pe3DsLBhY/rmZWvYCDv3jYNPJB7bDj3c+91vyIwEK/nws1X0RLJI2tHz0oyOW6xpCPYlS6brmrADU0LBja/l5Ric9QCFg3OEz0AIc5qm7hRbx6SSJGnCQA+3e68tSZtddwmD6kJtEakBeXCUpVQrHJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vPaQzcI8duEaeNXXIkzWeWZQzquAt9auFWM1m/GXkGc=;
 b=G3uDbRGmCIFKMo/rJtQGxpzUmnM/OwOcDSY5YA07QFvy+EPcH/WSdPddF59qeDLOlMNVBgWNa33i/L8Y/11Q3UOGT4PoGYSAb0zhV5gXfS+aQGPO57zUsUEtztD9iL7SRbo1BnDVGus/Vc6GyviQDLLIX8gD/y2R63brv1tYUq2TSyqS8sv0rFUx97BYgsQ/xMhEMz0DbCKuLzsLty/M00i8gWhicvlRn46KVWlvM4pVv2FCYJ+bbvV6Skw17JMF6UUtDF+XRKxIrQmzAvlGR9p0iy1rjQ6des3YIUo01wZAbnEHemytvsuhbo9JBwcsaUnAO2sDBNM+0SEaVmXZeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vPaQzcI8duEaeNXXIkzWeWZQzquAt9auFWM1m/GXkGc=;
 b=hnNHT9sYIdN6pJOCkPPgMLjYNN0u34MhS2lqw3RdgpJpFAh/eTtZJh81W42N6t/6oBKiYQCjLsQssLsRyh88AwTfBfveIMKLX2FrrA+L7X4RpzSKVsbe87aQ0+jeQLo0I13N1Zi2135viUKwp+Llb+J/lLdrjQx3+QIoUpKxwAQ=
Received: from CO1PR10MB4722.namprd10.prod.outlook.com (2603:10b6:303:9e::12)
 by MWHPR10MB2047.namprd10.prod.outlook.com (2603:10b6:300:10b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.12; Mon, 13 Dec
 2021 14:27:34 +0000
Received: from CO1PR10MB4722.namprd10.prod.outlook.com
 ([fe80::54ed:be86:184c:7d00]) by CO1PR10MB4722.namprd10.prod.outlook.com
 ([fe80::54ed:be86:184c:7d00%8]) with mapi id 15.20.4778.018; Mon, 13 Dec 2021
 14:27:34 +0000
Message-ID: <7ffcc677-a557-5453-c866-9ee17d2e760f@oracle.com>
Date:   Mon, 13 Dec 2021 08:27:20 -0600
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.4.0
Subject: Re: [PATCH v17 02/10] x86: kdump: make the lower bound of crash
 kernel reservation consistent
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
 <20211210065533.2023-3-thunder.leizhen@huawei.com>
From:   john.p.donnelly@oracle.com
In-Reply-To: <20211210065533.2023-3-thunder.leizhen@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DB6PR07CA0194.eurprd07.prod.outlook.com
 (2603:10a6:6:42::24) To CO1PR10MB4722.namprd10.prod.outlook.com
 (2603:10b6:303:9e::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 54953cfd-764c-4cf2-d385-08d9be44b460
X-MS-TrafficTypeDiagnostic: MWHPR10MB2047:EE_
X-Microsoft-Antispam-PRVS: <MWHPR10MB204779982DD63E300539E5A2C7749@MWHPR10MB2047.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:403;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2UTmZsOZqYcFDnAuZ6dacvykPXEbPbao/67w8K6564zhYeb5kmmrKhtIpUJVL89hf+QBBR9UVPJtx71Fkcuz7+tGL+m937brpTKZYWZqJeThXz/UbhHGJpgJ5LEHX8IKu0d1DT3Op1e+8Y/HLSLZ39Nm+DFe3qDh/VOkOV/0mLL75Peq/Wu+NggdnGKGvA2Ac1AAxUXKvdzRjkVFTPsMdeOSvQScJe65wpHmloml26dv6zG6ROzcZDhZjBxloBWHI8kwGVYFutNJEso9/eH731kCIuLtm+04Fkc+j1H+ssZUalMM4l6ynwLrZKzTVw8g6qs4zsTtpq5tLYqlipcczIB4EJgNGWfMuepm/WltaJBxj2YYUMUwPp//qirXkWBmK9g7YQzJII6URAofj+ZGVGknH5N9+aCs9Xvq5cQ+lHqzM2LaoCN8ihKDW5LAD2ivuumm3dp0lHjjtYkNhDKmbFSqxRf3IBzoX5QApcfGmm7FdmxUfw8PfvUn+F30wGRRyMf9i+MeSS5sPUBP+sSl8Fh1/mD/Z8j6OM70KvL9jF7XLf2IX/eYDFm2KEwKIjU3mvuOqBIwAIbcG/sqxkTBSG0DYh0xbampxRnuznE6L8WRcecypNdpNDmuhEQCJRyx2Fc5W2SOAkyXTX6UwPgUmZAEwd8GTuO3d2qwKTNtyWzVFRqhgs/wd+WCet6GTj24oxN5JGlvu+z/iIMos0WHvBYppGV6Y6xTvZcgyfLTuuA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4722.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(31696002)(36756003)(8676002)(4326008)(38100700002)(7416002)(508600001)(8936002)(9686003)(6512007)(5660300002)(921005)(83380400001)(26005)(31686004)(6666004)(186003)(6486002)(66946007)(66556008)(66476007)(2906002)(110136005)(54906003)(86362001)(2616005)(6506007)(53546011)(316002)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a2V4bE82QXRoZWhKZU4yUHdEVWROeGlsS0pJc3VwK0x1VVhWNkpnSUtNK1VP?=
 =?utf-8?B?UTJKQWNoa3RiUjg2RWtjejZXYm51cFNBaVVqdjJGVjVnMmNFUXpCa3ZNN01m?=
 =?utf-8?B?SURhRjloRFFrVjhVMngrdUlQQ2xyNitTZzR0OHNoMDRUb1hhRXVacTFRMmZM?=
 =?utf-8?B?bUM3aE0wMkh3cW54UFZxZ0xzRlVzeUJJclFzelZIdnliQVovWVJHTWgwS2Mr?=
 =?utf-8?B?V2Y3T0QxeUo1SGU4cjd4dllqWFRad1R4bW8xb3ZMVnRZblV4VTMzUmx5aG15?=
 =?utf-8?B?QWMwdUtnZnhqYkx0ZWZVV3ZVWGtLUnJvTlI1SHgyN2RDTG9rZTIwb2RFd3M2?=
 =?utf-8?B?V1N4bnV0WDd4dWtTTE1DNmtSak9IZGJSUE1iWFBxMXlHaEYxbWpaWitFYkFS?=
 =?utf-8?B?TENaTXc5TmNISllPUm1YTHF0VzR1NFdpMk1HTE9mTlZhVFV4TmVKZmJtclVN?=
 =?utf-8?B?Tm1GOXRJRnNpU2ozT3QvcWdqOTZZcm5LWktrYW40dE9Gby9WYllINnhURnBk?=
 =?utf-8?B?S3g1RjArbjRyUWpKc091dWRjNU81amYxc3FZYjlYVGJveGd2VmU5dTUyN2dO?=
 =?utf-8?B?WEVNK1RicTYrLzhwYjY3NjllajB3S2hLZlY0T2xscFdkZ0w1L1I4U1dsSDJn?=
 =?utf-8?B?RVRSeEdGNjRmcjlQU2QvMW9IWWFvL1lkaFowbzlkRzZDYlY2UUFLYjRDa3JN?=
 =?utf-8?B?QzM0ZEYyaWUvTjNxNlJMVnYxU2s2b09BNjZVRGI0ZzJRNHRuUG1QTTFtRUVr?=
 =?utf-8?B?YjYydVc1bTFuMkZDZitRd2M1ZXpueWU0V00ybDRXTkNpZlVSMXN2c0RiUWJl?=
 =?utf-8?B?cmZ1TG9NTmhLeFN0UHBTcGlxNGdhMXl6eW90QVlGMmlDZFAvVzdSWS9rREZL?=
 =?utf-8?B?V2dzUENzY0gyUDZ0NTJldWxyaFVLY1FTd2NwMEZwRUh3ZzgzemlGTkJJL3lY?=
 =?utf-8?B?ZVorS3hicmtZMWN3Z21YV3pNNDN1T3NNeUdLZlhhRTNxRFZUdlJITExYdHdh?=
 =?utf-8?B?ajg1WjlOSStoMlAyWkNsMUM2aElVcTVVZTViNTRIL2Q1N2lydWwwZXNlSXFs?=
 =?utf-8?B?Z2Q4U2lnM3dpZlppeGIyZ3B3cFFqQUNBbWxHb3FrRHVHdkJOdXJLeHJMOGJo?=
 =?utf-8?B?UE1NZ0NudlUxRUhSekpNTmRkekJpZ0xGNlcwK0pOQ0xWWnpqWkV4cFpuSmMw?=
 =?utf-8?B?aGZtNDJoQWlLWkRXVmZ0SWVRN0thWGNqS1BtRnRaT1MzbWNwckEzSm8wNlk2?=
 =?utf-8?B?NmdvWFA5K00vemxUVURDNHVFRjlsbVJhWjdya1RJRzhsU1M0ekg0c3M4WlIr?=
 =?utf-8?B?clQ1TnZLcjBFS2JaV2tNTXI0M0d2clp2WjJFQ0l5L3R5Q2hnb0I2N0wvbDFj?=
 =?utf-8?B?VURXVWJRMm1QQXU1dEJ1RlREVWowL000WkczdlZwWmphcE1aVFRrZ3dxVmFh?=
 =?utf-8?B?a1Jtbkw1WnU0RHJiRGxJMER0Y2VzQlZmSy8zbGlVUFlvNDZEY0srZUdiNUJ6?=
 =?utf-8?B?eWR2N0FpYUdVeXNlVFQ2Wm12ZXQ0NmkwbGZJdDZhd0lBMGJ1eVFiQzZiSk1T?=
 =?utf-8?B?MXRxTkdjN3B0U3lwZTFxZDViSkNhYXZvRHJXcmZMem1SSlNJYnoydHV5NWw3?=
 =?utf-8?B?QTh6UDg2KzdsYyt0dnpSVEdDaTdGUWU4Q3pNbThOd3lSb3FmOGlIY0NsYmox?=
 =?utf-8?B?QTQvSlVPNThOYVdSVkFqS2J4dlErVzBjK3FnL0o2NmtVR1cyaWRLSGZ0VUN2?=
 =?utf-8?B?V3pxSVlPL3ZPWnBqSzlsQVc0Q1NIdXJtNUlkSmpVc1ordXFEVFRXcVk0UVk0?=
 =?utf-8?B?dk0rZlQzOFYvWlAySDNlejZVVVpOTit4SXV1SHREZFBManFnRU9DY2JkdTRK?=
 =?utf-8?B?ZDRiNS9CbHZ1Y3N4RzB2bUFsWEprdC9PSUtRMGo0MkR5M2ZtYndYaWVWZ0ZM?=
 =?utf-8?B?Q29ndGszaVBxTlVXL0Eyb2xvbDR2N2ozbDJIdDRxN05RRVY4MlE0cTNoMDdi?=
 =?utf-8?B?TnUvY2ZXL3VVL0lvNUFmQ3ZmejFzS2dyOU0rWlorMFk1NVlnMm94SEtiSTgr?=
 =?utf-8?B?TC9XM25TaXNwTXFQUWZsbmZWZ0tMbStZMnNadUtYUUJLYXpMNWVpaFFReTZ3?=
 =?utf-8?B?V3U0dithSXhwZnpQa3JLdmRaa0dYcklBRm9WS2gvUkFscWg4QzZDTlZaSk9U?=
 =?utf-8?B?UmU2MTFrN1dJODRHTTRqdzU1eEdtTFZXWHpOeHM2Vm1kVG5zZUgxKzhNbmtx?=
 =?utf-8?Q?gMwZnyGa8uXccJEtJy7YMmPCeHbdk0UvveIJUk2vGE=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54953cfd-764c-4cf2-d385-08d9be44b460
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4722.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2021 14:27:34.6214
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wwloc+WIR6FfQpBdb7SXXJQlVlm7i9NT2IjF5lX3TPaR+27LRxIFyxHvi7n4kYz21UxCINwwDccvlTEZgcNmOnSKh59NzRRuNcwgf7qLlQ4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB2047
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10196 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 suspectscore=0
 malwarescore=0 mlxlogscore=999 bulkscore=0 mlxscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2112130092
X-Proofpoint-GUID: QeT3LsmSFOBBlqoFze81x3Jv-fGJScxv
X-Proofpoint-ORIG-GUID: QeT3LsmSFOBBlqoFze81x3Jv-fGJScxv
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/10/21 12:55 AM, Zhen Lei wrote:
> From: Chen Zhou <chenzhou10@huawei.com>
> 
> The lower bounds of crash kernel reservation and crash kernel low
> reservation are different, use the consistent value CRASH_ALIGN.
> 
> Suggested-by: Dave Young <dyoung@redhat.com>
> Signed-off-by: Chen Zhou <chenzhou10@huawei.com>
> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> Tested-by: John Donnelly <John.p.donnelly@oracle.com>
> Tested-by: Dave Kleikamp <dave.kleikamp@oracle.com>

  Acked-by: John Donnelly <john.p.donnelly@oracle.com>

> ---
>   arch/x86/kernel/setup.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
> index 5cc60996eac56d6..6424ee4f23da2cf 100644
> --- a/arch/x86/kernel/setup.c
> +++ b/arch/x86/kernel/setup.c
> @@ -441,7 +441,8 @@ static int __init reserve_crashkernel_low(void)
>   			return 0;
>   	}
>   
> -	low_base = memblock_phys_alloc_range(low_size, CRASH_ALIGN, 0, CRASH_ADDR_LOW_MAX);
> +	low_base = memblock_phys_alloc_range(low_size, CRASH_ALIGN, CRASH_ALIGN,
> +			CRASH_ADDR_LOW_MAX);
>   	if (!low_base) {
>   		pr_err("Cannot reserve %ldMB crashkernel low memory, please try smaller size.\n",
>   		       (unsigned long)(low_size >> 20));

