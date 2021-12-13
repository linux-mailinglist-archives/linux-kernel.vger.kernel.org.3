Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43694472F56
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 15:31:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239183AbhLMOau (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 09:30:50 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:17100 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230272AbhLMOat (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 09:30:49 -0500
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1BDDLrPj011719;
        Mon, 13 Dec 2021 14:30:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=NvIXy6Vik+V4N1SRDyaW7esGfxxwGmezdqbCvpT3JZM=;
 b=IpUnG+Gy9wvGIXD2QtZNMZXW3/f1wPZOyQjkWK7dWYNK+l2UUPeOHXahOWVGylkeX5EO
 67QhjJYR7k27226jn5tKY7jHn2SEuWKsZ3bQkfQ6IRG+xoWR/HJbnE/U2/hNIU6cbUwR
 F6nUx4P+Fgg9UqHK88twFSdYxvZkzygE2eSxxMp1da4Z8Y5WUuW7cQ/ye0lZMXAxlvfo
 gNPyyG4kwhDHKJpv94c0cBtUGLUh2lCj162vYLiBT3mdjiVU85BS4agE6UsdgtSIUF8F
 hieamfT1hc16vdHdThThcAGFRJFLnG28qt7xkHYCCjZf9CA5+9LNaNKKKTKjmNTTo6ip 1Q== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3cx3uk8mbb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 13 Dec 2021 14:30:18 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1BDEP2YA085955;
        Mon, 13 Dec 2021 14:30:16 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2043.outbound.protection.outlook.com [104.47.66.43])
        by userp3020.oracle.com with ESMTP id 3cvnen56y2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 13 Dec 2021 14:30:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K9XhkahBV5QGT/ljxPXaAAWuZsU3H12CGJVy5lKj1Uz2vBoN2YhtmbUAdvvWvW6E3EbDTtJrkqYZpTl0JMv1ItjxduCdt2AKP4CzHOJP7g63L8BZS2JoFjntEMUo2f/OJxQP31sxl7M7eB9d37UXuOIIfRB4K4WUziDQzDeo1Ro929yvIKsax3qCfQc3ksZjWUOCJnMK1wnUzW2HR6niBh0MLnmDFJTciG/cTadepr8HpClAAW5JArG2hqZzOfi8JiHJhnWnOU7W/I27WdWGCHVbdAeg383rRhq0LRQMvDLIFG+gnNz9fcFm6+RKH8ntY+o6zjaUj9pqbT0umgkh8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NvIXy6Vik+V4N1SRDyaW7esGfxxwGmezdqbCvpT3JZM=;
 b=bwf43bOWzT8s7hY6evVpaq/BtcnrJXiaJvmXIM8JV2OAbC+UN01Q6slH7mg/HgL9GpMfcpQzVxTJ1goD8HHrD50JIT4Ou9E8ze3jMzJzN82e4Cbw7+ixB/p0or9DsHLCX0zZoLNXlzMNsMW1iszjpLCoJ5F6iNR3sMHf8QI1GmwBbwDQSN2vXfu5MQp9RFGOhrCp93fPYsp/8NLZIuyvY8DfrUVr9M9J4j1+Yvy2SKRFQ2BnhgcvRCEr769yqA2wovIHK7Qla+DS7Q/Xw8woWmCLttXsXQjrxBTxe5ZXYHb9cdouhWg4UXt87JQEfjXDIIwpSHov1Kos3yTGmsc29Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NvIXy6Vik+V4N1SRDyaW7esGfxxwGmezdqbCvpT3JZM=;
 b=iMaSBKrCGG3NSdSn2YYqW/E0i9tD0BdGLHChprQtgGLZz82FjDlcXRfp/Op/Xcqk2EMS8Gie9NHcvHoTziQs4xgJllkoATNAXQZxm6o2rQv2LwevSIZFQT/JIlljBS6fd6yGDYUstKYC3egF2WBlPPVDQyPCdW7PQxQiYp/BOE0=
Received: from CO1PR10MB4722.namprd10.prod.outlook.com (2603:10b6:303:9e::12)
 by MW5PR10MB5690.namprd10.prod.outlook.com (2603:10b6:303:19b::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.17; Mon, 13 Dec
 2021 14:30:13 +0000
Received: from CO1PR10MB4722.namprd10.prod.outlook.com
 ([fe80::54ed:be86:184c:7d00]) by CO1PR10MB4722.namprd10.prod.outlook.com
 ([fe80::54ed:be86:184c:7d00%8]) with mapi id 15.20.4778.018; Mon, 13 Dec 2021
 14:30:13 +0000
Message-ID: <4f4bb1c4-eddd-b53c-c4ae-40a8cf321d12@oracle.com>
Date:   Mon, 13 Dec 2021 08:30:06 -0600
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.4.0
Subject: Re: [PATCH v17 05/10] x86: kdump: move reserve_crashkernel[_low]()
 into crash_core.c
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
 <20211210065533.2023-6-thunder.leizhen@huawei.com>
From:   john.p.donnelly@oracle.com
In-Reply-To: <20211210065533.2023-6-thunder.leizhen@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YTOPR0101CA0056.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:14::33) To CO1PR10MB4722.namprd10.prod.outlook.com
 (2603:10b6:303:9e::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5b733ab8-404e-4af6-41ea-08d9be451311
X-MS-TrafficTypeDiagnostic: MW5PR10MB5690:EE_
X-Microsoft-Antispam-PRVS: <MW5PR10MB5690FB21E77091E64F035EB1C7749@MW5PR10MB5690.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fUjrlWJjegilnyCCWlAkdjb1mAgBo3o/OBTEywyWKOIFvDusSJf6oDs0VnsZC+6AmJTDONfp+OTjsjzFjCeSLM0PGIF0Cz/yUvopfB7jqN+KSsoeEEEI/vRh5bcS/Q63+mWDEtfMrFpFlJ7FJbgyfmBzfF5LG/PuhMC4NrPIq0CUd7KrwJyhXFrfKAJYTlGvd4X9qX70Rn80QTlNIqBVjb9ye0IB+BgfA34houfr7I6NGEbHvpH1k15ypZ6YhbPhtuVEOKflBOmgrA+xhknx1/4PrP9utvKP4kZR2xA5CURTrUYTeY+DFajlanrhUKW8Fmr1pfyNouTkwS9VgPx0NDgufg+2v3lVP8QCvbjaMghqelck1lAXOa5tWMeyOVJqQOVOZOayqAjLJvrrCnOfceYSKWJ96u03nS3WSactDMEHnZ/9jUCgdFrHaOykgt60xUKcM1emevyDqdG8z4bsxfHSz0B1oYr/B5V3fe4jTYSVVP9Ff2Na/wm76amqRzkQJDNXeN5An2h2iav2G6hNmM10mwwc/ZiMIpOe2ts5RGdeDXUhJI9Buuh+CYmA9xuT5HbjVmi4HNkbBBFOXxi7HTNhUnHTtF8nrmwZtJdtLrmN3sqjp6L8bYegBLo0vGkhvuDRclx/DdL0p19UepzLo/8jFO/Rvm2fq6zh2/RFRTAioiJHNRkz4OaGUDnLl/1Qu4ZYyBJBHhusu1yu+pZccZWVpeRnXmfaxG3ICQNSaI8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4722.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(6486002)(8676002)(6666004)(186003)(86362001)(5660300002)(53546011)(26005)(30864003)(36756003)(31686004)(2906002)(7416002)(2616005)(316002)(54906003)(110136005)(8936002)(83380400001)(6506007)(66556008)(66946007)(66476007)(508600001)(31696002)(921005)(6512007)(38100700002)(9686003)(4326008)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dXhUajBFcTI3U2FhSXp3c1I3NGZmMGZxNHlMenlNQlhsRlY3cmh6b3U3ZGpO?=
 =?utf-8?B?MytyVmE3cUd3N2RWSjc3NVB1UjBKUzA1aGpINW5xZGdlT3Vla1kxSXkyeVAr?=
 =?utf-8?B?MEtCMmNzcmZxZEZ4LzhHQVRrQ0lxSzNMVThvNXNEcjNhcjNjSWhObmQva0cr?=
 =?utf-8?B?Wld6M3pCc3liQkhocW9raHExck5ybm02MnBqSXJ0RGJZNFcxV2xoZUYwd2ht?=
 =?utf-8?B?d1U0bjZGVW9VOW94MkNRK0pwclptcSttT09sKzhaN2Q2eVl1ZU9ob3JzNEU0?=
 =?utf-8?B?a0ZreWJGdnJaUEEvWnl2ekRiTGdMM0haUGFXeFphYTFtZ203eUh0V1BCSDZM?=
 =?utf-8?B?L0E4bWJGeXlrRG14cng5OUwwcHlVYkNOaEdGR3c1cjBJVy9GZkxGVkNsMjVn?=
 =?utf-8?B?Vkx6aGJzY2RmV3d3L09HUVJTVUdqVjMxTTVHWVNVN1RtMUJRM2I0QU1nc3ln?=
 =?utf-8?B?R2V2SkZrZUJncXl4elhPY0Fwb1RzblU2elM0U3VDdlp4K2l2dGhueVNJYlds?=
 =?utf-8?B?b2ZLbmQ1dWtrWE1uWHFJVXN1a2kzNFNZMW1zVFVJYkhMbmNzVHRNUldzSktK?=
 =?utf-8?B?SUhkNW11OW9wSmxST01oNERZb1d1bDJvKy9JWHl2V2NtMGQvWTZMV09DSVl4?=
 =?utf-8?B?WHVpcmlwVHhxMWFnemYzbXZnTlJkSHdKUk5ubHg4dzZuNjYyNEM1L3NHN0Uv?=
 =?utf-8?B?TWx5aW5QeWlIWjRudUtESVpidTQwd0hzSFdzQk9IUzV0YmtQYm9peXVjVDlT?=
 =?utf-8?B?MkkrNC9HU2ZGN1V2MjkxbDJoN1ZEQldVK3lTZDN2cVV6SzNNMFVTSS9ENHdI?=
 =?utf-8?B?SHI0Snc2MTExNG5EK1FtOXFnWlF6OEJRWDJPdXhIM1ZmYm1CVWVyZEJLaUVJ?=
 =?utf-8?B?aktFcjYxYUN1S2V2ZVc5V3BvVTMzb2wvdmhSZm12T3hNUEVhYW5XUS91RE0z?=
 =?utf-8?B?dCs5bW1ITnU3OWJlcHo5V2hLY3NVYmpDS0tvVWpZSTRralFuWlJkck16QUxU?=
 =?utf-8?B?TytTZ2hrRVRZVEZmaE1JTXVMRkFTUmZ4eU4xbFNhMWhHcktEVG9lbnhXbjhI?=
 =?utf-8?B?OWlRNzFqK2o5MndHbkhSN09NZUdyZ2cvenpublhtV1E2R3VMangzWm5KSi9m?=
 =?utf-8?B?MWxKM1dxdGMrNEsxVFd6aGRVSklySitwTzZHaFZVSys5TTF5QWhTSERTUE1K?=
 =?utf-8?B?NDBtRUxPRG45QUl5YjNvVG4ra29lY0djV3lYQzJnRGhJZWNoWG9Gc2dCcVVT?=
 =?utf-8?B?QndwN3BMaGdUWGRxdWVZZjVVUC9uckhSdHZlZGdUZHpJUVNUQnFQSjBVaURK?=
 =?utf-8?B?RDZ5RXBOQjVpMkMxMHZHdWV3R3lKWXVIRWp1TEVlUG5pdGVhMUpucEllcDZI?=
 =?utf-8?B?a3BuQktxR2pzOWJSeGlTbEVtNFU5T0ZiaDlEdjhOWHhLRGtwR1RLSXlDNlBw?=
 =?utf-8?B?UVY5eUVlenpFK2dHcnB6NmViWWdSMFRoWEVJZ29pZW5YYnI2MkRYK0IzNnR3?=
 =?utf-8?B?UWUrcyt4V0VxMklHbTcvZ3hPOU13V25CMVZkZ1ZIdW9QNDRtbG0wVDNESlZo?=
 =?utf-8?B?WGhUWWhUYnhrQ3NRTUVhQlNqRlI2MGZMMjBQaVdCREorL2Y4ZVZuOE91aDl6?=
 =?utf-8?B?cWY3QkVqK2w4ZEFqMjlQYkZmQk5FRklJeTRrS3BKUWxhemVLZFFuYXlSMFk2?=
 =?utf-8?B?ME9ZWDhpS3JmSlNjVThQL3ovTlpkREhCaHNqbDBOOU5tRWtPL3NscTNnejRi?=
 =?utf-8?B?TExzckRVQUJKMytFR05tNkFBcXpSNExlbjNjZmlYZUlqNzNRZGlUdEdWKzF2?=
 =?utf-8?B?MGdnbFhzNnF5VmY4aTBOSERKQnR2UGROamVzN3RnQkZUZVRuUnZvb3lreXEx?=
 =?utf-8?B?a2xPbytKMW4yQWo2bDIvQzRETlJRdlVkME85cE9WM2lXdWprM1ZNZFhYZ0Zy?=
 =?utf-8?B?c3VQL2JIeTJVNmpSdWZBWW1EakhZYzMySDl1TERjL3M4a1dBUDNFbTRTQVRh?=
 =?utf-8?B?S0FEdUNyb0QreXA1WGtXTUg2c2NVTGRzUnV2djVVWnZGQ1c1Nk02b3NRNHE4?=
 =?utf-8?B?dWx5UXhreUkvcFcyWEpkeEVxbkRYQSttTVFwUVpnN2d4YXFNU0pkRTZBT2M3?=
 =?utf-8?B?S0twT01lR2lEb0hyMzFoWXBIaC9acERENU1xRHUrRmIxUDhFWWttWG1tQi9P?=
 =?utf-8?B?WHk1em14VHF4aHRBVllRY1AwTTdEeFovTlhFSnRnd2RRc3BUZmpEdkVsYXZM?=
 =?utf-8?B?UmR2S0MyYUxHc1kwMU9FVllReEJnPT0=?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b733ab8-404e-4af6-41ea-08d9be451311
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4722.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2021 14:30:13.3584
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zeCkDHbd+bsVu8BgmIzEjl2rxeflpYruDMUH5DvPZmMtggniWiY70jTxxScyplSGxE+EsyJ9rFaAMVPDIFGGLVMQEiHuICvZHkJT3prJPqM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR10MB5690
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10196 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0
 malwarescore=0 bulkscore=0 spamscore=0 mlxlogscore=999 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112130092
X-Proofpoint-GUID: TvIgvOKcnj8GdxRzvUIns4-tIiseJ5d2
X-Proofpoint-ORIG-GUID: TvIgvOKcnj8GdxRzvUIns4-tIiseJ5d2
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/10/21 12:55 AM, Zhen Lei wrote:
> From: Chen Zhou <chenzhou10@huawei.com>
> 
> Make the functions reserve_crashkernel[_low]() as generic. Since
> reserve_crashkernel[_low]() implementations are quite similar on other
> architectures as well, we can have more users of this later.
> 
> So have CONFIG_ARCH_WANT_RESERVE_CRASH_KERNEL in arch/Kconfig and
> select this by X86.
> 
> Signed-off-by: Chen Zhou <chenzhou10@huawei.com>
> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> Tested-by: John Donnelly <John.p.donnelly@oracle.com>
> Tested-by: Dave Kleikamp <dave.kleikamp@oracle.com>

  Acked-by: John Donnelly <john.p.donnelly@oracle.com>
> ---
>   arch/Kconfig                 |   3 +
>   arch/x86/Kconfig             |   2 +
>   arch/x86/include/asm/elf.h   |   3 +
>   arch/x86/include/asm/kexec.h |  28 ++++++-
>   arch/x86/kernel/setup.c      | 143 +-------------------------------
>   include/linux/crash_core.h   |   3 +
>   include/linux/kexec.h        |   2 -
>   kernel/crash_core.c          | 156 +++++++++++++++++++++++++++++++++++
>   kernel/kexec_core.c          |  17 ----
>   9 files changed, 194 insertions(+), 163 deletions(-)
> 
> diff --git a/arch/Kconfig b/arch/Kconfig
> index d3c4ab249e9c275..7bdb32c41985dc5 100644
> --- a/arch/Kconfig
> +++ b/arch/Kconfig
> @@ -24,6 +24,9 @@ config KEXEC_ELF
>   config HAVE_IMA_KEXEC
>   	bool
>   
> +config ARCH_WANT_RESERVE_CRASH_KERNEL
> +	bool
> +
>   config SET_FS
>   	bool
>   
> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index 5c2ccb85f2efb86..bd78ed8193079b9 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -12,6 +12,7 @@ config X86_32
>   	depends on !64BIT
>   	# Options that are inherently 32-bit kernel only:
>   	select ARCH_WANT_IPC_PARSE_VERSION
> +	select ARCH_WANT_RESERVE_CRASH_KERNEL if KEXEC_CORE
>   	select CLKSRC_I8253
>   	select CLONE_BACKWARDS
>   	select GENERIC_VDSO_32
> @@ -28,6 +29,7 @@ config X86_64
>   	select ARCH_HAS_GIGANTIC_PAGE
>   	select ARCH_SUPPORTS_INT128 if CC_HAS_INT128
>   	select ARCH_USE_CMPXCHG_LOCKREF
> +	select ARCH_WANT_RESERVE_CRASH_KERNEL if KEXEC_CORE
>   	select HAVE_ARCH_SOFT_DIRTY
>   	select MODULES_USE_ELF_RELA
>   	select NEED_DMA_MAP_STATE
> diff --git a/arch/x86/include/asm/elf.h b/arch/x86/include/asm/elf.h
> index 29fea180a6658e8..7a6c36cff8331f5 100644
> --- a/arch/x86/include/asm/elf.h
> +++ b/arch/x86/include/asm/elf.h
> @@ -94,6 +94,9 @@ extern unsigned int vdso32_enabled;
>   
>   #define elf_check_arch(x)	elf_check_arch_ia32(x)
>   
> +/* We can also handle crash dumps from 64 bit kernel. */
> +# define vmcore_elf_check_arch_cross(x) ((x)->e_machine == EM_X86_64)
> +
>   /* SVR4/i386 ABI (pages 3-31, 3-32) says that when the program starts %edx
>      contains a pointer to a function which might be registered using `atexit'.
>      This provides a mean for the dynamic linker to call DT_FINI functions for
> diff --git a/arch/x86/include/asm/kexec.h b/arch/x86/include/asm/kexec.h
> index 3a22e65262aa70b..3ff38a1353a2b86 100644
> --- a/arch/x86/include/asm/kexec.h
> +++ b/arch/x86/include/asm/kexec.h
> @@ -21,6 +21,27 @@
>   /* 16M alignment for crash kernel regions */
>   #define CRASH_ALIGN		SZ_16M
>   
> +/*
> + * Keep the crash kernel below this limit.
> + *
> + * Earlier 32-bits kernels would limit the kernel to the low 512 MB range
> + * due to mapping restrictions.
> + *
> + * 64-bit kdump kernels need to be restricted to be under 64 TB, which is
> + * the upper limit of system RAM in 4-level paging mode. Since the kdump
> + * jump could be from 5-level paging to 4-level paging, the jump will fail if
> + * the kernel is put above 64 TB, and during the 1st kernel bootup there's
> + * no good way to detect the paging mode of the target kernel which will be
> + * loaded for dumping.
> + */
> +#ifdef CONFIG_X86_32
> +# define CRASH_ADDR_LOW_MAX	SZ_512M
> +# define CRASH_ADDR_HIGH_MAX	SZ_512M
> +#else
> +# define CRASH_ADDR_LOW_MAX	SZ_4G
> +# define CRASH_ADDR_HIGH_MAX	SZ_64T
> +#endif
> +
>   #ifndef __ASSEMBLY__
>   
>   #include <linux/string.h>
> @@ -51,9 +72,6 @@ struct kimage;
>   
>   /* The native architecture */
>   # define KEXEC_ARCH KEXEC_ARCH_386
> -
> -/* We can also handle crash dumps from 64 bit kernel. */
> -# define vmcore_elf_check_arch_cross(x) ((x)->e_machine == EM_X86_64)
>   #else
>   /* Maximum physical address we can use pages from */
>   # define KEXEC_SOURCE_MEMORY_LIMIT      (MAXMEM-1)
> @@ -195,6 +213,10 @@ typedef void crash_vmclear_fn(void);
>   extern crash_vmclear_fn __rcu *crash_vmclear_loaded_vmcss;
>   extern void kdump_nmi_shootdown_cpus(void);
>   
> +#ifdef CONFIG_KEXEC_CORE
> +extern void __init reserve_crashkernel(void);
> +#endif
> +
>   #endif /* __ASSEMBLY__ */
>   
>   #endif /* _ASM_X86_KEXEC_H */
> diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
> index 7ae00716a208f82..5519baa7f4b964e 100644
> --- a/arch/x86/kernel/setup.c
> +++ b/arch/x86/kernel/setup.c
> @@ -39,6 +39,7 @@
>   #include <asm/io_apic.h>
>   #include <asm/kasan.h>
>   #include <asm/kaslr.h>
> +#include <asm/kexec.h>
>   #include <asm/mce.h>
>   #include <asm/mtrr.h>
>   #include <asm/realmode.h>
> @@ -386,147 +387,7 @@ static void __init memblock_x86_reserve_range_setup_data(void)
>   	}
>   }
>   
> -/*
> - * --------- Crashkernel reservation ------------------------------
> - */
> -
> -#ifdef CONFIG_KEXEC_CORE
> -
> -/*
> - * Keep the crash kernel below this limit.
> - *
> - * Earlier 32-bits kernels would limit the kernel to the low 512 MB range
> - * due to mapping restrictions.
> - *
> - * 64-bit kdump kernels need to be restricted to be under 64 TB, which is
> - * the upper limit of system RAM in 4-level paging mode. Since the kdump
> - * jump could be from 5-level paging to 4-level paging, the jump will fail if
> - * the kernel is put above 64 TB, and during the 1st kernel bootup there's
> - * no good way to detect the paging mode of the target kernel which will be
> - * loaded for dumping.
> - */
> -#ifdef CONFIG_X86_32
> -# define CRASH_ADDR_LOW_MAX	SZ_512M
> -# define CRASH_ADDR_HIGH_MAX	SZ_512M
> -#else
> -# define CRASH_ADDR_LOW_MAX	SZ_4G
> -# define CRASH_ADDR_HIGH_MAX	SZ_64T
> -#endif
> -
> -static int __init reserve_crashkernel_low(void)
> -{
> -#ifdef CONFIG_X86_64
> -	unsigned long long base, low_base = 0, low_size = 0;
> -	unsigned long low_mem_limit;
> -	int ret;
> -
> -	low_mem_limit = min(memblock_phys_mem_size(), CRASH_ADDR_LOW_MAX);
> -
> -	/* crashkernel=Y,low */
> -	ret = parse_crashkernel_low(boot_command_line, low_mem_limit, &low_size, &base);
> -	if (ret) {
> -		/*
> -		 * two parts from kernel/dma/swiotlb.c:
> -		 * -swiotlb size: user-specified with swiotlb= or default.
> -		 *
> -		 * -swiotlb overflow buffer: now hardcoded to 32k. We round it
> -		 * to 8M for other buffers that may need to stay low too. Also
> -		 * make sure we allocate enough extra low memory so that we
> -		 * don't run out of DMA buffers for 32-bit devices.
> -		 */
> -		low_size = max(swiotlb_size_or_default() + (8UL << 20), 256UL << 20);
> -	} else {
> -		/* passed with crashkernel=0,low ? */
> -		if (!low_size)
> -			return 0;
> -	}
> -
> -	low_base = memblock_phys_alloc_range(low_size, CRASH_ALIGN, CRASH_ALIGN,
> -			CRASH_ADDR_LOW_MAX);
> -	if (!low_base) {
> -		pr_err("Cannot reserve %ldMB crashkernel low memory, please try smaller size.\n",
> -		       (unsigned long)(low_size >> 20));
> -		return -ENOMEM;
> -	}
> -
> -	pr_info("Reserving %ldMB of low memory at %ldMB for crashkernel (low RAM limit: %ldMB)\n",
> -		(unsigned long)(low_size >> 20),
> -		(unsigned long)(low_base >> 20),
> -		(unsigned long)(low_mem_limit >> 20));
> -
> -	crashk_low_res.start = low_base;
> -	crashk_low_res.end   = low_base + low_size - 1;
> -#endif
> -	return 0;
> -}
> -
> -static void __init reserve_crashkernel(void)
> -{
> -	unsigned long long crash_size, crash_base, total_mem;
> -	bool high = false;
> -	int ret;
> -
> -	total_mem = memblock_phys_mem_size();
> -
> -	/* crashkernel=XM */
> -	ret = parse_crashkernel(boot_command_line, total_mem, &crash_size, &crash_base);
> -	if (ret != 0 || crash_size <= 0) {
> -		/* crashkernel=X,high */
> -		ret = parse_crashkernel_high(boot_command_line, total_mem,
> -					     &crash_size, &crash_base);
> -		if (ret != 0 || crash_size <= 0)
> -			return;
> -		high = true;
> -	}
> -
> -	/* 0 means: find the address automatically */
> -	if (!crash_base) {
> -		/*
> -		 * Set CRASH_ADDR_LOW_MAX upper bound for crash memory,
> -		 * crashkernel=x,high reserves memory over CRASH_ADDR_LOW_MAX,
> -		 * also allocates 256M extra low memory for DMA buffers
> -		 * and swiotlb.
> -		 * But the extra memory is not required for all machines.
> -		 * So try low memory first and fall back to high memory
> -		 * unless "crashkernel=size[KMG],high" is specified.
> -		 */
> -		if (!high)
> -			crash_base = memblock_phys_alloc_range(crash_size,
> -						CRASH_ALIGN, CRASH_ALIGN,
> -						CRASH_ADDR_LOW_MAX);
> -		if (!crash_base)
> -			crash_base = memblock_phys_alloc_range(crash_size,
> -						CRASH_ALIGN, CRASH_ALIGN,
> -						CRASH_ADDR_HIGH_MAX);
> -		if (!crash_base) {
> -			pr_info("crashkernel reservation failed - No suitable area found.\n");
> -			return;
> -		}
> -	} else {
> -		unsigned long long start;
> -
> -		start = memblock_phys_alloc_range(crash_size, SZ_1M, crash_base,
> -						  crash_base + crash_size);
> -		if (start != crash_base) {
> -			pr_info("crashkernel reservation failed - memory is in use.\n");
> -			return;
> -		}
> -	}
> -
> -	if (crash_base >= CRASH_ADDR_LOW_MAX && reserve_crashkernel_low()) {
> -		memblock_phys_free(crash_base, crash_size);
> -		return;
> -	}
> -
> -	pr_info("Reserving %ldMB of memory at %ldMB for crashkernel (System RAM: %ldMB)\n",
> -		(unsigned long)(crash_size >> 20),
> -		(unsigned long)(crash_base >> 20),
> -		(unsigned long)(total_mem >> 20));
> -
> -	crashk_res.start = crash_base;
> -	crashk_res.end   = crash_base + crash_size - 1;
> -}
> -#else
> +#ifndef CONFIG_KEXEC_CORE
>   static void __init reserve_crashkernel(void)
>   {
>   }
> diff --git a/include/linux/crash_core.h b/include/linux/crash_core.h
> index de62a722431e7db..f6b99da4ed08ecf 100644
> --- a/include/linux/crash_core.h
> +++ b/include/linux/crash_core.h
> @@ -73,6 +73,9 @@ extern unsigned char *vmcoreinfo_data;
>   extern size_t vmcoreinfo_size;
>   extern u32 *vmcoreinfo_note;
>   
> +extern struct resource crashk_res;
> +extern struct resource crashk_low_res;
> +
>   Elf_Word *append_elf_note(Elf_Word *buf, char *name, unsigned int type,
>   			  void *data, size_t data_len);
>   void final_note(Elf_Word *buf);
> diff --git a/include/linux/kexec.h b/include/linux/kexec.h
> index 0c994ae37729e1e..cd744d962f6f417 100644
> --- a/include/linux/kexec.h
> +++ b/include/linux/kexec.h
> @@ -352,8 +352,6 @@ extern int kexec_load_disabled;
>   
>   /* Location of a reserved region to hold the crash kernel.
>    */
> -extern struct resource crashk_res;
> -extern struct resource crashk_low_res;
>   extern note_buf_t __percpu *crash_notes;
>   
>   /* flag to track if kexec reboot is in progress */
> diff --git a/kernel/crash_core.c b/kernel/crash_core.c
> index eb53f5ec62c900f..b23cfc0ca8905fd 100644
> --- a/kernel/crash_core.c
> +++ b/kernel/crash_core.c
> @@ -8,6 +8,12 @@
>   #include <linux/crash_core.h>
>   #include <linux/utsname.h>
>   #include <linux/vmalloc.h>
> +#include <linux/memblock.h>
> +#include <linux/swiotlb.h>
> +
> +#ifdef CONFIG_KEXEC_CORE
> +#include <asm/kexec.h>
> +#endif
>   
>   #include <asm/page.h>
>   #include <asm/sections.h>
> @@ -22,6 +28,22 @@ u32 *vmcoreinfo_note;
>   /* trusted vmcoreinfo, e.g. we can make a copy in the crash memory */
>   static unsigned char *vmcoreinfo_data_safecopy;
>   
> +/* Location of the reserved area for the crash kernel */
> +struct resource crashk_res = {
> +	.name  = "Crash kernel",
> +	.start = 0,
> +	.end   = 0,
> +	.flags = IORESOURCE_BUSY | IORESOURCE_SYSTEM_RAM,
> +	.desc  = IORES_DESC_CRASH_KERNEL
> +};
> +struct resource crashk_low_res = {
> +	.name  = "Crash kernel",
> +	.start = 0,
> +	.end   = 0,
> +	.flags = IORESOURCE_BUSY | IORESOURCE_SYSTEM_RAM,
> +	.desc  = IORES_DESC_CRASH_KERNEL
> +};
> +
>   /*
>    * parsing the "crashkernel" commandline
>    *
> @@ -295,6 +317,140 @@ int __init parse_crashkernel_low(char *cmdline,
>   				"crashkernel=", suffix_tbl[SUFFIX_LOW]);
>   }
>   
> +/*
> + * --------- Crashkernel reservation ------------------------------
> + */
> +
> +#ifdef CONFIG_ARCH_WANT_RESERVE_CRASH_KERNEL
> +static int __init reserve_crashkernel_low(void)
> +{
> +#ifdef CONFIG_64BIT
> +	unsigned long long base, low_base = 0, low_size = 0;
> +	unsigned long low_mem_limit;
> +	int ret;
> +
> +	low_mem_limit = min(memblock_phys_mem_size(), CRASH_ADDR_LOW_MAX);
> +
> +	/* crashkernel=Y,low */
> +	ret = parse_crashkernel_low(boot_command_line, low_mem_limit, &low_size, &base);
> +	if (ret) {
> +		/*
> +		 * two parts from kernel/dma/swiotlb.c:
> +		 * -swiotlb size: user-specified with swiotlb= or default.
> +		 *
> +		 * -swiotlb overflow buffer: now hardcoded to 32k. We round it
> +		 * to 8M for other buffers that may need to stay low too. Also
> +		 * make sure we allocate enough extra low memory so that we
> +		 * don't run out of DMA buffers for 32-bit devices.
> +		 */
> +		low_size = max(swiotlb_size_or_default() + (8UL << 20), 256UL << 20);
> +	} else {
> +		/* passed with crashkernel=0,low ? */
> +		if (!low_size)
> +			return 0;
> +	}
> +
> +	low_base = memblock_phys_alloc_range(low_size, CRASH_ALIGN, CRASH_ALIGN,
> +			CRASH_ADDR_LOW_MAX);
> +	if (!low_base) {
> +		pr_err("Cannot reserve %ldMB crashkernel low memory, please try smaller size.\n",
> +		       (unsigned long)(low_size >> 20));
> +		return -ENOMEM;
> +	}
> +
> +	pr_info("Reserving %ldMB of low memory at %ldMB for crashkernel (low RAM limit: %ldMB)\n",
> +		(unsigned long)(low_size >> 20),
> +		(unsigned long)(low_base >> 20),
> +		(unsigned long)(low_mem_limit >> 20));
> +
> +	crashk_low_res.start = low_base;
> +	crashk_low_res.end   = low_base + low_size - 1;
> +#endif
> +	return 0;
> +}
> +
> +/*
> + * reserve_crashkernel() - reserves memory for crash kernel
> + *
> + * This function reserves memory area given in "crashkernel=" kernel command
> + * line parameter. The memory reserved is used by dump capture kernel when
> + * primary kernel is crashing.
> + */
> +void __init reserve_crashkernel(void)
> +{
> +	unsigned long long crash_size, crash_base, total_mem;
> +	bool high = false;
> +	int ret;
> +
> +	total_mem = memblock_phys_mem_size();
> +
> +	/* crashkernel=XM */
> +	ret = parse_crashkernel(boot_command_line, total_mem, &crash_size, &crash_base);
> +	if (ret != 0 || crash_size <= 0) {
> +		/* crashkernel=X,high */
> +		ret = parse_crashkernel_high(boot_command_line, total_mem,
> +					     &crash_size, &crash_base);
> +		if (ret != 0 || crash_size <= 0)
> +			return;
> +		high = true;
> +	}
> +
> +	/* 0 means: find the address automatically */
> +	if (!crash_base) {
> +		/*
> +		 * Set CRASH_ADDR_LOW_MAX upper bound for crash memory,
> +		 * crashkernel=x,high reserves memory over CRASH_ADDR_LOW_MAX,
> +		 * also allocates 256M extra low memory for DMA buffers
> +		 * and swiotlb.
> +		 * But the extra memory is not required for all machines.
> +		 * So try low memory first and fall back to high memory
> +		 * unless "crashkernel=size[KMG],high" is specified.
> +		 */
> +		if (!high)
> +			crash_base = memblock_phys_alloc_range(crash_size,
> +						CRASH_ALIGN, CRASH_ALIGN,
> +						CRASH_ADDR_LOW_MAX);
> +		if (!crash_base)
> +			crash_base = memblock_phys_alloc_range(crash_size,
> +						CRASH_ALIGN, CRASH_ALIGN,
> +						CRASH_ADDR_HIGH_MAX);
> +		if (!crash_base) {
> +			pr_info("crashkernel reservation failed - No suitable area found.\n");
> +			return;
> +		}
> +	} else {
> +		/* User specifies base address explicitly. */
> +		unsigned long long start;
> +
> +		if (!IS_ALIGNED(crash_base, CRASH_ALIGN)) {
> +			pr_warn("cannot reserve crashkernel: base address is not %ldMB aligned\n",
> +				(unsigned long)CRASH_ALIGN >> 20);
> +			return;
> +		}
> +
> +		start = memblock_phys_alloc_range(crash_size, SZ_1M, crash_base,
> +						  crash_base + crash_size);
> +		if (start != crash_base) {
> +			pr_info("crashkernel reservation failed - memory is in use.\n");
> +			return;
> +		}
> +	}
> +
> +	if (crash_base >= CRASH_ADDR_LOW_MAX && reserve_crashkernel_low()) {
> +		memblock_phys_free(crash_base, crash_size);
> +		return;
> +	}
> +
> +	pr_info("Reserving %ldMB of memory at %ldMB for crashkernel (System RAM: %ldMB)\n",
> +		(unsigned long)(crash_size >> 20),
> +		(unsigned long)(crash_base >> 20),
> +		(unsigned long)(total_mem >> 20));
> +
> +	crashk_res.start = crash_base;
> +	crashk_res.end   = crash_base + crash_size - 1;
> +}
> +#endif /* CONFIG_ARCH_WANT_RESERVE_CRASH_KERNEL */
> +
>   Elf_Word *append_elf_note(Elf_Word *buf, char *name, unsigned int type,
>   			  void *data, size_t data_len)
>   {
> diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
> index 5a5d192a89ac307..1e0d4909bbb6b77 100644
> --- a/kernel/kexec_core.c
> +++ b/kernel/kexec_core.c
> @@ -54,23 +54,6 @@ note_buf_t __percpu *crash_notes;
>   /* Flag to indicate we are going to kexec a new kernel */
>   bool kexec_in_progress = false;
>   
> -
> -/* Location of the reserved area for the crash kernel */
> -struct resource crashk_res = {
> -	.name  = "Crash kernel",
> -	.start = 0,
> -	.end   = 0,
> -	.flags = IORESOURCE_BUSY | IORESOURCE_SYSTEM_RAM,
> -	.desc  = IORES_DESC_CRASH_KERNEL
> -};
> -struct resource crashk_low_res = {
> -	.name  = "Crash kernel",
> -	.start = 0,
> -	.end   = 0,
> -	.flags = IORESOURCE_BUSY | IORESOURCE_SYSTEM_RAM,
> -	.desc  = IORES_DESC_CRASH_KERNEL
> -};
> -
>   int kexec_should_crash(struct task_struct *p)
>   {
>   	/*

