Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 576A149CDCA
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 16:18:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235939AbiAZPSk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 10:18:40 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:51478 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242678AbiAZPSg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 10:18:36 -0500
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20QEM18m020073;
        Wed, 26 Jan 2022 15:17:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=Fs1Qo/w8ALkAWSfUj1zHgUqoF78G4zJpMXSkY5h3+Ks=;
 b=kPDqvZEXRWcvLHbfHZmI5sam5r4nUaVZ+hf/X/tYec2icLdUNdg52aPHcqMVBFsLUPUh
 gLMDqzI+93tiss2yRbCvEKyPiAhRvk+RNfYfQzjfmX7ZdRJGVVb7RGVfQWP+tPNz4nvm
 KPxwPq5zZe4JHX+evWWyJW6Jxq+vbop6uyYmav1smDQwc9OVM7Ck2kqxhDfKO3M6JvfN
 b8+GWvm1pgG4II92fKnYx4eqduTKevBInl3myJ8eXUaSyRpGleup07ypRjebpl9Z4gxW
 wZ14dtH91DlbzLP12E8lw/CBAVFrfJr8e3TQQ/JmH2YEUFTMcuw48xb8k6PihQ8SLhqV yg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dsy7axfms-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 26 Jan 2022 15:17:57 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 20QFGobD169845;
        Wed, 26 Jan 2022 15:17:56 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam08lp2177.outbound.protection.outlook.com [104.47.73.177])
        by aserp3020.oracle.com with ESMTP id 3dtax8k6a6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 26 Jan 2022 15:17:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iW/IiVu1EtXF2/fcYahDNg5y68qUH0CX3s/nkN6PyTSp7KkyHN8lGQb4la2faIrnw6WpOtXgurhD1W5ARuqjka2pmbeTKyISQEiFYdrwZ3W6U24yfbKmjZ1OlfXVRb16TKWbvSoGtXRtmIsNsLFXaFzLhA15XgzaVKX0U9evyNB6QdW2t1AxnEtRsv5Cxa78ojYtDlTz0G9jwoj35kJGrGArXgQKYu4ZlQLRHpGYd+uaZSzaUst2ztMYs6pUYOT0rYo8ABjfbt+WE7q7EC5H6NvgyBoI8c6Iok4L3vIcOYSG862NWYvu5KoTlxf5RzhYugO8idBp46RzS5/+yV6Z8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fs1Qo/w8ALkAWSfUj1zHgUqoF78G4zJpMXSkY5h3+Ks=;
 b=CDdp/wfhjoHs8MQmLLDU3ZYx6doOF5O3+TKwZAWMdn7F7Q/c/5tE/aEz7UGjVSSjv7gtcttnJN3lfp0ognpi6emjhVsSnlaHFGND1mRLG7R0fBeZReKWAKLAio6XrsLJ637UrJ1eAQHMiIcqE1bAos1Y/aplEwsHvsb3u3Qh737qqrXWYitXaV24esImlaEHtkF+UHR8EKt+5Xc9VsQAOywsCWXhMS4qiMK4NDuaP3w+0ssJW/e6ieqnDpF068cgPNWc2ICBFNAPXQMW+WEXnR0NKuGD/ft5dXKM7Nmvqox9uDtH1Ri5mwO4OgAB30jc8lqlW7VI6sVDP6jh9SyUcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fs1Qo/w8ALkAWSfUj1zHgUqoF78G4zJpMXSkY5h3+Ks=;
 b=nZcIXlXiOTmFLP19jyvUMY8PojYu2Dsbr/O9Z6N3HkbNgAOpg66p5uzSOpCPEDLZBQL+ARX6XQl323ruGuXdpyPvLPvWZnwz81+er60/KcsfObkgPC7LNTEiHxIh//ZpRtggghcf4pSz/ESuWmAEWWP5jH02sCX1heh4XuMgKEg=
Received: from CO1PR10MB4722.namprd10.prod.outlook.com (2603:10b6:303:9e::12)
 by SJ0PR10MB4542.namprd10.prod.outlook.com (2603:10b6:a03:2da::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.8; Wed, 26 Jan
 2022 15:17:53 +0000
Received: from CO1PR10MB4722.namprd10.prod.outlook.com
 ([fe80::30b4:4c4c:82df:29f6]) by CO1PR10MB4722.namprd10.prod.outlook.com
 ([fe80::30b4:4c4c:82df:29f6%6]) with mapi id 15.20.4930.017; Wed, 26 Jan 2022
 15:17:53 +0000
Message-ID: <35d28434-25d7-5aca-e810-2b4639dd5810@oracle.com>
Date:   Wed, 26 Jan 2022 09:17:37 -0600
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.4.0
Subject: Re: [PATCH v20 2/5] arm64: kdump: introduce some macros for crash
 kernel reservation
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
        Dave Kleikamp <dave.kleikamp@oracle.com>
References: <20220124084708.683-1-thunder.leizhen@huawei.com>
 <20220124084708.683-3-thunder.leizhen@huawei.com>
From:   john.p.donnelly@oracle.com
In-Reply-To: <20220124084708.683-3-thunder.leizhen@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P123CA0014.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:a6::26) To CO1PR10MB4722.namprd10.prod.outlook.com
 (2603:10b6:303:9e::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 415f0e91-790d-4554-a1a4-08d9e0df05e7
X-MS-TrafficTypeDiagnostic: SJ0PR10MB4542:EE_
X-Microsoft-Antispam-PRVS: <SJ0PR10MB4542908BEFF13C95715A7BC9C7209@SJ0PR10MB4542.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:510;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 82ArjUVpOpPTRB+i5QZ4rIX0pxbd8fRURt4s4BRSvShRmD39gzI6qt1F5cV4t/bPSVJQeNkGNuPh+arQ6UzHvL/HMKMY7ovYYez+HTWakZJV69th+41D0xXDsivWNotx2tpawHE7tYBMB5ihmnSsUlfI+/1NrQOc2K/I3dUb94TLIaqV/ascIKYv5tDebf7ZMNHXxrhD6FbrQ0BrESNJn0o/h4OwEXW68RBTkn6Tav0xMnimyPOIDFngQsV6Hm0C9lb0gPZvwo3bOhIu2eYa0aiMcxe2DCXRmVG1jygRUu3/iMaaDG5xrweUlp0cVeUJ1QMzZ3o1jkQ5WBuXquFe9upQFgALlOAqHNeN300MiPBSkJfO1yMxvyOKI29IEXsHwMPcR4ValBkgX2tsGbt69y11v+zZSCC72nPgbZTw+rwFIzzqGjeiu1H5sITxDLPOkTzCUAu5SAaBhsFFpDHYrDaazy0UeOetGyk3QSEupod4krTsOVAQZ0NOKLUwLufLZscxiyioLv64oX2JKGVWsOY5xy3kd5a1uhy/6rV1cgPyAWkl6QqnZAApZ5oI7ugCcD9oR2mcEUuOBIUKrgHEDfcH/+GkthE4fQ+E7bVT51YLDekgFnv2NnBClZD0slB4x1qzhWpW9Aq3PqohFtW+d595dbTQ1wXmsjh3uql+1JCEo8ekXtUEjaRGNqRVD6vEcZbp8Ev9RohAwNxotaa4heaMWRSpahtkf9p+OE5/UJM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4722.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(7416002)(107886003)(26005)(8936002)(8676002)(86362001)(36756003)(31696002)(316002)(38100700002)(31686004)(83380400001)(921005)(6486002)(6666004)(2906002)(508600001)(186003)(5660300002)(6506007)(54906003)(110136005)(2616005)(9686003)(53546011)(66556008)(66476007)(6512007)(4326008)(66946007)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TSthTFUzaVI1Y0M2M0dnUHBOL1U4dkpHTDVQNFp6Sk90ZnN0aG56OVFZdjF3?=
 =?utf-8?B?MlJGeU9oRHBDbVFqRXJ3SzRjZE1QaDVGRHk0S0xhSTNNMFozejZYK0FvSHFv?=
 =?utf-8?B?U1U0bmUvcG1BaFBWMGFhaWszQlVuM0ErbDU2cXlrcmxTenFLN3QrVm5JWk9y?=
 =?utf-8?B?bldyNUhvdDYzbnhzK1U0UG5wVDhYcWVVK0FKQVAwM1J2ZXF3WkdJZDJrU1Vy?=
 =?utf-8?B?ZkJRb0labXoyN3NKQkZPRVhiOW5CNmswWnZLcDFzQkRCMWdmdVlkMjIxaTZj?=
 =?utf-8?B?UnZyd0ZUNHZBSVlDMDlPbjJ4Q2dSaW1zdk03UFZuQ3NkUmthcDcyeUhpbVFh?=
 =?utf-8?B?VVdUNjlHbzliVjk4VXkwNW5tVVdhdW14ZzlURUxPdVBnOXFWd3poeVludW5U?=
 =?utf-8?B?VUFYN2lFUmRSRmx1b204UHdSZzkwUllraFpPb09aOHUxRldjUzdIZld5V1Uy?=
 =?utf-8?B?MkI3TU50RWJ4UFNPaEVLU0NwajZ0ZzM2SDdJZFpwazdLK3pRK1RIWmZENk5V?=
 =?utf-8?B?blNtUXo0RjRla2VCeS9KRmxQa2c0dUl5bFF5Nm04VDZXVFRIQnducVRxTlAx?=
 =?utf-8?B?S2VrY09vdkovQ3BNdVlBVWF2KzkvRlBvVDZXSmxpRjFkZTdnK2tLSU1tblBI?=
 =?utf-8?B?TlUxUGJtREJxbUVFQ2pCT0YzemFPYS9tKzdZRHVqQjVNeFlXcjFOUkZHNkVV?=
 =?utf-8?B?SDY4YzBWUEJCRUdzNjVnUndRY0FTb1FmZ2ZaZGltMUlibDRPSUgvWksvSm10?=
 =?utf-8?B?Yks0eUl1T1ZSbkpxVDJURUNTQ21FcVY0ZnA0Q24rbVY3c2NoakNvUVRmMTU1?=
 =?utf-8?B?UHVDSjRqbmdjU2dqQ2xKRG53bEMrZjZHK282M24vT2VpaXRRZXlucjA5bm5o?=
 =?utf-8?B?cWFDc20zWm1OMHVURUNIWjlPWnFFZFJhN1laSDhaK3hKTVhPRlJOcHN4RTdN?=
 =?utf-8?B?OThneWg2K2xSZUlPcUwybjFjSGFWckFzczJlUEh3NXRoZWIvMFNxREs1R1Ja?=
 =?utf-8?B?bE41NE96VVBLeVFpUHY0RDJUbE9KdEg2OCsrS015KzV2ZG9LdTlPVWFIVHI5?=
 =?utf-8?B?V0RSL1NRMGErTjF2dlJEVU8zYUF1QmJoMFNES3Ezam1JQ1BEMlJtb2NDK0c5?=
 =?utf-8?B?RUhDREFweWVYdDF3aG56MGpzYlJkTmJVUXU3U015MTBNMEZ6ZkxyODhPL3dS?=
 =?utf-8?B?NmExMlBTcjNobzNQN1FMbHJ6ZHR0VnBOSGR4MFk5Z0ZqQUtHUTM0ZmtxSEwv?=
 =?utf-8?B?T0tBdFhNbkZsQXQvcUtQMVplQmJMY0RmOFZUREh2LzNHbVdJb1R2a21haTlQ?=
 =?utf-8?B?TFZRdnZtREtrcTF0NXJaWXFMSURlRGxQQWhzb3lXT1VKeEhPSkZEWG1ibW1P?=
 =?utf-8?B?VE1SclprZzQyY1pKTjhnakNhNDJ1dmFndGt1ZDdlSWJWS2xvSjR4bDQyYjVT?=
 =?utf-8?B?YWkrd0Z3cTJhUC9DL0hEVzdjQkVoTW1hS2U3UzM5UVRKUjUxclRQeTdJRHFX?=
 =?utf-8?B?c3FKYVRYQ284RVRmYXNzUVYxMGVwcXErbkhoYlRHUzZjZktPNi9JT2VOKy81?=
 =?utf-8?B?b1ZYQTdMamdwcHpKeUFwYWdheWFHVzNjNFhwc0lwTERneTdMNHV1OGYwVS9Q?=
 =?utf-8?B?TlNSV3h2T3dFNnhBaS9DY21tVkJ0OW1VemRiRjRmcDdtcFJJOUg4NzdNTjk5?=
 =?utf-8?B?Y0xJV1VpN1lsV1FhMEpzSHAzTjFvSDJLQms3Q0tMa29aeG96VHlyZ1hlT05S?=
 =?utf-8?B?U0Y3OEZ6VldkYVkvUTBidVNmV2ZBMU9hNmg3ZDh6WkNCNVpEUTM0QVFMajBI?=
 =?utf-8?B?QW04RWpuY1FlT2VLZ1BkTHBwd0dyeElVUW1vT0p2bDJOUkMyNFFjVHlTRnF3?=
 =?utf-8?B?cVBxQkI5WUd1OWhSTFRrdmVTanJlY0tpcDdDdEwrM2tqL2dFY1VNM2JSQ3FY?=
 =?utf-8?B?N0lkdTN5RXZPS1dDVXoyYThnd21idGloclhpLys1bmFIU0NUZHZycG4vUGRx?=
 =?utf-8?B?ZklmZW9nbzQyYWFJZ3QrSGxjRkZ0MTNzaWFtOVBudjZBcE11NTFqYUdad09Y?=
 =?utf-8?B?UHo4RjFjMllQV0RZSFNuYm9ZL2pkeUU3eXg4aVpPa1h1aUwzZFUvcmVERlFy?=
 =?utf-8?B?UWdEVzBsTGZnamRocTYvUzV4OUFDcjg3WlllVks1UTZwRTJ3c3R6elQwNnln?=
 =?utf-8?B?VmcwRy9GOWFydHUxTU9RODBBeWdTdm5ZQmNuUmFDNEQwY2ZmYlhBc04ySGFo?=
 =?utf-8?B?OHhleFRUcTRYam1LaGplSzIxQ0l3PT0=?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 415f0e91-790d-4554-a1a4-08d9e0df05e7
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4722.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2022 15:17:53.5560
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BYTraKeiSG8YxHRVBnK94ph7WA3hk4ixoXpOQwAWd2KuJr6RjubEk/Ewe+FupKcD2sMigfhp4EiqrsYw4NhYqNHbR12LBD2aRhOMoGFmi8U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4542
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10238 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0 mlxscore=0
 phishscore=0 suspectscore=0 spamscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2201260095
X-Proofpoint-GUID: WtW0GGIIQkCXbWySo6w9HdAa16jL3ZyL
X-Proofpoint-ORIG-GUID: WtW0GGIIQkCXbWySo6w9HdAa16jL3ZyL
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/24/22 2:47 AM, Zhen Lei wrote:
> From: Chen Zhou <chenzhou10@huawei.com>
> 
> Introduce macro CRASH_ALIGN for alignment, macro CRASH_ADDR_LOW_MAX
> for upper bound of low crash memory, macro CRASH_ADDR_HIGH_MAX for
> upper bound of high crash memory, use macros instead.
> 
> Signed-off-by: Chen Zhou <chenzhou10@huawei.com>
> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> Tested-by: John Donnelly <John.p.donnelly@oracle.com>
> Tested-by: Dave Kleikamp <dave.kleikamp@oracle.com>


Acked-by: John Donnelly  <john.p.donnelly@oracle.com>

> ---
>   arch/arm64/mm/init.c | 11 ++++++++---
>   1 file changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
> index 90f276d46b93bc6..6c653a2c7cff052 100644
> --- a/arch/arm64/mm/init.c
> +++ b/arch/arm64/mm/init.c
> @@ -65,6 +65,12 @@ EXPORT_SYMBOL(memstart_addr);
>   phys_addr_t arm64_dma_phys_limit __ro_after_init;
>   
>   #ifdef CONFIG_KEXEC_CORE
> +/* Current arm64 boot protocol requires 2MB alignment */
> +#define CRASH_ALIGN		SZ_2M
> +
> +#define CRASH_ADDR_LOW_MAX	arm64_dma_phys_limit
> +#define CRASH_ADDR_HIGH_MAX	MEMBLOCK_ALLOC_ACCESSIBLE
> +
>   /*
>    * reserve_crashkernel() - reserves memory for crash kernel
>    *
> @@ -75,7 +81,7 @@ phys_addr_t arm64_dma_phys_limit __ro_after_init;
>   static void __init reserve_crashkernel(void)
>   {
>   	unsigned long long crash_base, crash_size;
> -	unsigned long long crash_max = arm64_dma_phys_limit;
> +	unsigned long long crash_max = CRASH_ADDR_LOW_MAX;
>   	int ret;
>   
>   	ret = parse_crashkernel(boot_command_line, memblock_phys_mem_size(),
> @@ -90,8 +96,7 @@ static void __init reserve_crashkernel(void)
>   	if (crash_base)
>   		crash_max = crash_base + crash_size;
>   
> -	/* Current arm64 boot protocol requires 2MB alignment */
> -	crash_base = memblock_phys_alloc_range(crash_size, SZ_2M,
> +	crash_base = memblock_phys_alloc_range(crash_size, CRASH_ALIGN,
>   					       crash_base, crash_max);
>   	if (!crash_base) {
>   		pr_warn("cannot allocate crashkernel (size:0x%llx)\n",

