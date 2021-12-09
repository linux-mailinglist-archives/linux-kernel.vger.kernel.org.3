Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FD2146EBFB
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 16:41:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236756AbhLIPoj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 10:44:39 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:11092 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236584AbhLIPoi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 10:44:38 -0500
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1B9DuCxu006476;
        Thu, 9 Dec 2021 15:40:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=9Pj52wkD1asNyjQ7xh0sUeVHI23fZog7G+j9Hq5CH4o=;
 b=OVw/tdukbCnu07I3XWrHQHYriqLZKOZBIvTiiPOZJttiXPrOLkzPfiG7jsUrP35W/64C
 RZoZafaDFAtuuKC8tRjnDF3wH0yYlsqplk7VxWFxeqn1Gs+hA+w+QY7pLk4ZhCyy0ua8
 K5YNMISKULnPGcwRw46oZx4z6OM+5Et5Gdzl68cwG5zSyy1lg85AzYkLhcGZi/y2sCrX
 Zyze0c6/z3qSSjSO3P+N+GarqlMx5GH3cWi1XF+duoTtrr7yBpUYC2q3F5A1MUYbUMsW
 8dz66jxy9uyW+zYTy849y0oxBuH2da2AqXPH1Wnabz9VeGEVJ/2UX+EktRROolKosb3T eQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ctua7katt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 09 Dec 2021 15:40:27 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1B9FUClo084879;
        Thu, 9 Dec 2021 15:40:26 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2176.outbound.protection.outlook.com [104.47.56.176])
        by aserp3020.oracle.com with ESMTP id 3cr057yhn7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 09 Dec 2021 15:40:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gxdBrIsAfK40hg9V08lIVyZ292pelHUn+J4eg2UFxeBH0FR+1M2PaTIdh+XoTUKpa8ePLp1bD70h4GcYsJ6ppnjr5WT3+jbL2iR7Ts/N7YHvgQjnayqJvnOp3d3kfk+eNZvCopRknB8hm40TLbjMgEA4rCpL5LWKS6h+TkQUazWVD57Q78keGqPn15rtB08Tht7eQXnK7O1RlOf2mVp501kYFNEJZzE88SaiQ+xGzrQFN634Fb04lDs9rJ9lsCcC7ZtrLEF8y8Qx14ZlJkU0lJv1i0FuGhtZ13AxNdaWhg5c92GFZdiRm0mx3+S7/yPt2nDasbF2uLbhZVcDI1BNeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9Pj52wkD1asNyjQ7xh0sUeVHI23fZog7G+j9Hq5CH4o=;
 b=l8KmEFQCe2FO2BwcGhWbT3Ynl1iws1uoFFtwIrC8sOapSa6zYlmMyQfFEL5W60k+3uHvuugnuphcVVvSyNfStvGUl/FFPJuDbJS7Fhimv5aD7lcpUXdJb+2sU47wTM2fVFlzFLWu9sduI9YTLTjpUMCnEGPX5tkVnt6RDv0ZNy7CM80z867gbt2NicFCGNoYdUMPJvtDOH7jv9ywIoy+1F0HMAvjGwKvCmHuVq3YJjqwQgH4GL4NeLdWgAnE1/iNxBQ9ewi/OgkLaFaQ5zQnEd2F+wxEjBs9agw3S02UbajEhGmMrIDt+eOq8dDcEzbYiUieLjf+IxldrL7RzCZiVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9Pj52wkD1asNyjQ7xh0sUeVHI23fZog7G+j9Hq5CH4o=;
 b=frtTpWunJ9Y7qv2fQJ1fJES47dnbHtOjlUrS2Vj7b88hUyzlZfPA1Pf6ElKav3B5wtVSrRy8Iskg7E5Lh3d9N83UNhDiHOu59RTHmO1lPTk3yXU9pV6rgMsOWDWJ+HlLy4vT3oMxzqWlMj5eJFJBYzyJYYMKiQogvpD9Lhij2+8=
Received: from CO1PR10MB4531.namprd10.prod.outlook.com (2603:10b6:303:6c::22)
 by MWHPR10MB1967.namprd10.prod.outlook.com (2603:10b6:300:10b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.21; Thu, 9 Dec
 2021 15:40:24 +0000
Received: from CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::143c:ea64:7017:19f]) by CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::143c:ea64:7017:19f%4]) with mapi id 15.20.4755.022; Thu, 9 Dec 2021
 15:40:24 +0000
Message-ID: <5e468446-264d-ed8c-33f8-13f717bc6f9d@oracle.com>
Date:   Thu, 9 Dec 2021 09:40:18 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [RFC v2 4/6] crash hp: generic crash hotplug support
 infrastructure
Content-Language: en-US
To:     David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org,
        x86@kernel.org, kexec@lists.infradead.org, ebiederm@xmission.com,
        dyoung@redhat.com, bhe@redhat.com, vgoyal@redhat.com
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com,
        nramas@linux.microsoft.com, thomas.lendacky@amd.com,
        robh@kernel.org, efault@gmx.de, rppt@kernel.org,
        konrad.wilk@oracle.com, boris.ostrovsky@oracle.com
References: <20211207195204.1582-1-eric.devolder@oracle.com>
 <20211207195204.1582-5-eric.devolder@oracle.com>
 <9230f9cc-1001-e3ce-aa74-10b766c8cdb0@redhat.com>
From:   Eric DeVolder <eric.devolder@oracle.com>
In-Reply-To: <9230f9cc-1001-e3ce-aa74-10b766c8cdb0@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7PR04CA0220.namprd04.prod.outlook.com
 (2603:10b6:806:127::15) To CO1PR10MB4531.namprd10.prod.outlook.com
 (2603:10b6:303:6c::22)
MIME-Version: 1.0
Received: from [IPV6:2606:b400:414:8061:221:28ff:fea5:27c8] (2606:b400:8024:1010::112a) by SN7PR04CA0220.namprd04.prod.outlook.com (2603:10b6:806:127::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.19 via Frontend Transport; Thu, 9 Dec 2021 15:40:21 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4b83c430-062a-4555-41f3-08d9bb2a3736
X-MS-TrafficTypeDiagnostic: MWHPR10MB1967:EE_
X-Microsoft-Antispam-PRVS: <MWHPR10MB196783ECD442EE3B504E6C8397709@MWHPR10MB1967.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qsUYJITZlqyndWYfbpFWb8Z3eJqCWwYsLJ8nsgCj2oQh4cCmX06l4tfqqMi61OPV3k6krndMH9SHh0UFdObsE8ZkFOBgNCI52R46rNhY2g+dlg48RJcY2aaUl2gtOUx9IzptTtXV9weVcLt7fF+aeDtQ2t8TBabmiSOxgyseYnHP0YOPSsoP7R0dmNycN4oCgZQipZqKb6kLgNjoPbdeeprtHY+1b4I5GcZCic+P0KIKnGjosvk21A/nxBl8IltwHIaLuPPX88n6X6zCT//Y4IvFjGt4K437Ny+OjWFvbjcBkG3BnbtxxTm3sjsKHXOF5SGDPtfrZ35uyOcGqiMnTaQDnxNXjoDLxWuvVELja/+1mJUJToVvrJc6lSW8ZxoU5HhlYAINm8PR0lDQpyszzJFJBiBTRPFxofeNzx+0eJDbY1BFZ0GlnY7FfpROekiwl0L/KZbKLj+wRCLDDm9rmKIM/j9TAFlhQyBvgt0xS991yl1UcaN9J5PzvQ6xgvTIW2YEHonmBoBk9wTgwX/Dc4zxNAqBTO5lKNX+3TYQrz1DVD/Xi8tNVsjHmVePZDnVcfClbkw2DKKZX/0i9Cl4ZrFCP2lrXWRxos25td3+Yxs48O7bVJMDqaEY+haPenMK1OHJoY+jKdkOhgfBKH19mdMYBU0T9rlOyJ3CSbYuFJERihvKYwmX5G2NXcrapuZloqK0cGSdPX+XTzNGPQjzgaH5WEZFwTU7ZGOhUm3QbO3gtwzuiIrNn+DmL8T3oQ5/n/fISM24vQSyFMgDFsRYCg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4531.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(8936002)(8676002)(2906002)(31696002)(83380400001)(38100700002)(53546011)(36756003)(508600001)(6666004)(7416002)(186003)(86362001)(2616005)(6486002)(66476007)(107886003)(66946007)(5660300002)(316002)(31686004)(4326008)(66556008)(4744005)(41533002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MHNmT0RqU0lBYmxBUHg0MW5qVm5RNG1nVGxmUlpSQVlBOGpNeGt0UjI5Ui9z?=
 =?utf-8?B?eEU2eS8zTnlnYUdmc2dxUEpjTjU0UDQvYkJGN3JYMW1LUE5mem9yQ1ZjN1Zq?=
 =?utf-8?B?aWc5cTQ5SHJhZUwzYUhzLzVIY24xT0RZQy9FZng0cmUyMGhLa0kxMjVjWWgr?=
 =?utf-8?B?L1BQc3BPckhnZmQ2WlBoQVBzNkp2YzVxcmhRMm14OVY5Tkk2UzVML3J3aE5y?=
 =?utf-8?B?eU5rQjBzS0RCbmxmV1E1U2ZvUnhPQTNZV09ub2UxVmNkUGdqYVd0TmdnUlpR?=
 =?utf-8?B?dXpWbVBDR2tMaFl6OWt5Z0ZOcnFrV2NsWmVCNnovbklsdEJoVVQ0WC9jeWx3?=
 =?utf-8?B?M0RDN1JTd0tWWmlmaFdhN0l0UkMrRTVpQWxmQm9xYlZWZTZabVY5OEhXdGFW?=
 =?utf-8?B?SjlzU1FDdmV1K1RuNXY1bkJOV1VzWlJsQTlKVVAxOFE5UmhVL0NNNDhVUjly?=
 =?utf-8?B?L1lDaXVoVUpPNk9zc3g1ZnFVRmhlSE1sRnFDOGN6ZlgzY1l0VmdkL3R4SEhw?=
 =?utf-8?B?Z3VGYzk5MTdnaGYzSWxvOFduYTFIUkxDY0N4bE42QzROQUNqTGNkWjh1cXl5?=
 =?utf-8?B?M0NjdkR3NlhpRUpaK2F0TUt3blBrcGFkYWw5SHNXbHM3bWYyZVBMZDh0MmFl?=
 =?utf-8?B?clUxWksrcHBUMnQwdXl1Z291elYwRkhSM0t4aUFHNDlUclRHMVB4THQwSnhq?=
 =?utf-8?B?b1hHRkc4d1VaL1cvcHE3RzJvK3ptRE5LaWJpakF3NW1YZW1ocm84dFdmVlY1?=
 =?utf-8?B?NVhGVXFNamM4b0lkZWhUNjRjQm45TEMzSkswSUdJNUZtYVVLdGwva0hZT2R3?=
 =?utf-8?B?R3VzZ0NtZ29BdWZCNWxGS2t2RU5ZY2dySlJJNzJvVmVKRlhLWDFkSTZXaGcr?=
 =?utf-8?B?NjIraUJDdE5SSlJDUEM4UnVDRTd5Yk8zbFA0clZNUiszS0xHSzFaUUFwWk1Y?=
 =?utf-8?B?REd5YWcxVHRVZTU3NzlON0IwekEraUFXVGxNM2NHK1NKRmkwY2pNWEZoUkpG?=
 =?utf-8?B?TEV4Ri9oRGNLM2YySUNDc2RQd1hkclRqL295dzIvTDdqOGhCWXFIeGJrT0t3?=
 =?utf-8?B?OVZ3MVNvL0ZVVHFZZDZsYXpvUjdab25PRHIzOXlQS1JaVElIMEwzRG1NUUo5?=
 =?utf-8?B?TUZFdGFPMHBJK0I0UHFtSm1iWTN6SDJiYXpUUlhjZ0NRNnQvOVAzY05tcyth?=
 =?utf-8?B?NVpobFkycS9FOUVaeEYvRnhuMmNxRW93bFJMRHc4QmZZaTlnN1ZLYUFuamt4?=
 =?utf-8?B?V2NZVEdZcU9oQzRQK2loYzFMa0gwM2IreHdGTHp5TDJQcG1hb3N4dDdjM0dL?=
 =?utf-8?B?QnV3UmdRQ1lEMnQ0dnlXeHFnYTZQTnhidjNSN2VTdGdNdjlHQnlWVDhBK3ZL?=
 =?utf-8?B?aGtvUHZpKzVLMWliVnMybGEzZVdXQVBaYTh2M0hqYjJDT2M1bE94blJ3VFFV?=
 =?utf-8?B?VjZlVjJ0a3FNQkowSDdvb3Y3Yk9ocWlWL05FamxFWWFuTG5PV2NmT2tzaWY2?=
 =?utf-8?B?ei9oV3RtWmxFU1ZPTjVRQkVScFFsM1ZKK0NydDZONS9VT3BTWWRub0VsU2hm?=
 =?utf-8?B?SVBacmx3UkI3bFF1U3FmTUN2STRtaklhelJTWWFpR2s3bHljRkx3RW9XZlVv?=
 =?utf-8?B?ZzJUZi9oZUIycjhaSGovNkFva0VRMkE2N2FLZ1hZM1dkTHNrWUFNVjllb2tp?=
 =?utf-8?B?WlpMSGppUUlCSmhBUU9rc1poVHlqSTAwcHl1MHdyN3laVmpESm1BYXcwUkZt?=
 =?utf-8?B?cktEb1V3alJxSENUYzlqbVg0QW8rWWNyOGJzbUZNTlhUWWdpWVlnUlBsRm94?=
 =?utf-8?B?ZDJFTGJON0JNa0ZRQUI4c1BxaUIxd0hiYzZ4Skx6cG9Fb1BlRjgwNUFaaVFE?=
 =?utf-8?B?N2xjUTRHQnZDaDVoWm9nSTFjOWtKOXRtSXJwNE14MkxVc1dVWDNRL01jQkxj?=
 =?utf-8?B?UjVONktDRkxEL3JLMEdMQWVxRmhVdVl6TkRWeHZuaDl1eTNvbkVGVmp5TGpa?=
 =?utf-8?B?VEpIeDFIM3VHbGhxMEpKZ0FBc3NnNEE3RXlRRXdUdzJoYnMxLzdILzdDTUtN?=
 =?utf-8?B?SElTWHBwakhNZFZVTStyVk1JL3d0QlRBeWoySDRxbEYzcjd0cjVMR1RNUmJJ?=
 =?utf-8?B?QXJFQUxoamRQQ3puVkM3VDEwOWN2NGk3cnlKWC9CbWE2TTVpYjVVMVE2WlB4?=
 =?utf-8?B?empHU0hmaTlVbUJuN3ZOOVRFb29WZHFMWXVEWmJTdTNKNkc5ekRtaW9tSkR5?=
 =?utf-8?B?dkVJNlpTZ3JlOEpIWWZQa0RmN012dW1meUg2ZEkyMllCUjBwSTViekZIMVUw?=
 =?utf-8?Q?Ns4ZH0wtnHakcVdikd?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b83c430-062a-4555-41f3-08d9bb2a3736
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4531.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2021 15:40:24.1614
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V9MjQEJqYn61Vw8MR3HaHZva9zmXFmLFw9HMQ8KMH9zygO9kdv9HO0qcA9QF2VXAaywbZsD/wVYcp6ZDme9m9ZVf7HiTYcEYP+sHf05HBEo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1967
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10192 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0 phishscore=0
 malwarescore=0 spamscore=0 mlxlogscore=932 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2112090084
X-Proofpoint-ORIG-GUID: TkvAmEKhe_OQNz1y-0EcKlqP3oRLWiVO
X-Proofpoint-GUID: TkvAmEKhe_OQNz1y-0EcKlqP3oRLWiVO
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/8/21 07:38, David Hildenbrand wrote:
>> +#if defined(CONFIG_MEMORY_HOTPLUG)
>> +static int crash_memhp_notifier(struct notifier_block *nb,
>> +	unsigned long val, void *v)
>> +{
>> +	struct memory_notify *mhp = v;
>> +	unsigned long start, end;
>> +
>> +	start = mhp->start_pfn << PAGE_SHIFT;
>> +	end = ((mhp->start_pfn + mhp->nr_pages) << PAGE_SHIFT) - 1;
>> +
>> +	switch (val) {
>> +	case MEM_GOING_ONLINE:
>> +		crash_hotplug_handler(KEXEC_CRASH_HP_ADD_MEMORY,
>> +			start, end-start);
>> +		break;
>> +
>> +	case MEM_OFFLINE:
>> +	case MEM_CANCEL_ONLINE:
>> +		crash_hotplug_handler(KEXEC_CRASH_HP_REMOVE_MEMORY,
>> +			start, end-start);
> 
> Any reason you don't handle this after the effects completely, meaning
> MEM_ONLINE and MEM_OFFLINE?
> 

No, no reason. Great catch! I've changed it to use MEM_ONLINE/OFFLINE only.
Thanks!
eric
