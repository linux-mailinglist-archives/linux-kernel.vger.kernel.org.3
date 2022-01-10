Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D1AE489E94
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 18:44:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238509AbiAJRol (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 12:44:41 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:24714 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238224AbiAJRok (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 12:44:40 -0500
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20AFv3Rs001308;
        Mon, 10 Jan 2022 17:44:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : from : to :
 cc : references : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=2n1/GUg5ZjpZAPWpiS5ylAvHcZWS42Pgundz4z5lmcs=;
 b=JLHEvbIRfHFzdnKs6xIbjHx850HdM+M0uKOgsjy7U2zNgUJS5Sg/RfI1bihSlbQTjZl+
 CM3sbYUx5nXsl/F68IA8hg5lxRtZN1BpcrBP95fCYPYOrObpuSEsGL9sEkwMm3S1PCVO
 H2CxjlbBub+cn1/wg5+ObVMxPAcu9L8JfCdQNgQHtU7X55WiBwMHeuvq+6Vx5ksqiPey
 MNxdWzsbhkwtM/NW2nHam2aISgVznCmmBoVTSj9qCnTDoDavcThdD4mqRS9cuwAeBWt+
 BlN7n6HvC7FueB+Ycssjm9o3x5TP/gtNXCzMzG1AEvgIMkxGAT2qloLpNOf9zCnbcQ+b Vg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dgn748spd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 10 Jan 2022 17:44:05 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 20AHaOpt026598;
        Mon, 10 Jan 2022 17:44:03 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2175.outbound.protection.outlook.com [104.47.57.175])
        by aserp3030.oracle.com with ESMTP id 3df0ncvnuj-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 10 Jan 2022 17:44:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HlKp9Aniw0ugFT3ECBzcz1bEYdRnBxaVLaJEALMnRNZ6iyER1z/YVt3raGRQNvFcoAXQhye2YtlU5GGcsYie2/iefCC57vHWICSUeA9zlix1lVRs41fhX+73HAe41Z2JJFAHxlDppoh/f2Sb/JT30RHPKxSKT2A1tJ4ppQnFU0qYxhTaDXzbAH2rBZQ8O1UT9qRa8cUQcmJ0KtkNWuW8sWj5blSDF+GqzA1AH36dodXxSl7jvo9lw5U3gys+upQ2U7Uf8VlzIx5Vz7R7gt1xXcaP5Xa0hlzVJqFIMtveeHoS3aVpylwE/TO9HUplDrkheQbiujlIUBgPzLiJ2yGIZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2n1/GUg5ZjpZAPWpiS5ylAvHcZWS42Pgundz4z5lmcs=;
 b=lUGKGsY+f4ExAczX8pnC9ZI3WI9iX+yetCorXebErh7M2+MN1ZT5YcmnPzxYgLpu4y10muLXjcrC0TvgTEW8ISFHEl79ZmZDp2F0bYhAhaW0VzQ4JnUMOXiTqSfxG+nEyYWOl3tYtlnbSuwQYjqiy25Zc3lkGplrcBF2mqVI8E3zz9ojjWqORLHyUTmyFc1Ml47GmI0rrsrC0nSTBB3qKMssoI5RB3Fvv6OqPHsD3P1wLzG1cTmCSlKDK1L7R2A4rle/zC9c2xQQQ7TYjQ1hsLxSBro+efZu3jwPqPPw/tI3gCBZJP4K34oplzqw8z3xLPHc3uEQnjs08j4/rEn+GA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2n1/GUg5ZjpZAPWpiS5ylAvHcZWS42Pgundz4z5lmcs=;
 b=QS8reDiQhJOXhaAoRfWU0Y0c+nDoV/7It4CQkc3090XrKhpHL/d0zghEJzw47W0G8FrVA6UG42yT+8fnqdWnsTKndPvz0iRMDJtNKd4zRDafgS427coI664P96mA+qmzKfebcXNXhw4zB5Qd1UN6w+dl+hB5csHI+EO/eb3gUjk=
Received: from BYAPR10MB2663.namprd10.prod.outlook.com (2603:10b6:a02:a9::20)
 by BY5PR10MB3873.namprd10.prod.outlook.com (2603:10b6:a03:1b0::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.7; Mon, 10 Jan
 2022 17:44:01 +0000
Received: from BYAPR10MB2663.namprd10.prod.outlook.com
 ([fe80::91ce:8d4f:e5d1:c67b]) by BYAPR10MB2663.namprd10.prod.outlook.com
 ([fe80::91ce:8d4f:e5d1:c67b%7]) with mapi id 15.20.4867.012; Mon, 10 Jan 2022
 17:44:01 +0000
Subject: Re: [PATCH RESEND 1/1] x86/smpboot: check cpu_initialized_mask first
 after returning from schedule()
From:   Dongli Zhang <dongli.zhang@oracle.com>
To:     x86@kernel.org
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, peterz@infradead.org,
        rafael.j.wysocki@intel.com, vkuznets@redhat.com,
        alison.schofield@intel.com, tim.c.chen@linux.intel.com,
        boris.ostrovsky@oracle.com, joe.jin@oracle.com,
        longpeng2@huawei.com, bigeasy@linutronix.de,
        linux-kernel@vger.kernel.org
References: <20211223210343.1116-1-dongli.zhang@oracle.com>
Message-ID: <6d46d5b1-a5e8-da72-6a7a-fdf013512875@oracle.com>
Date:   Mon, 10 Jan 2022 09:43:59 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
In-Reply-To: <20211223210343.1116-1-dongli.zhang@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0160.namprd03.prod.outlook.com
 (2603:10b6:a03:338::15) To BYAPR10MB2663.namprd10.prod.outlook.com
 (2603:10b6:a02:a9::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1873cd55-bc2e-4aa8-0ec4-08d9d460c9c0
X-MS-TrafficTypeDiagnostic: BY5PR10MB3873:EE_
X-Microsoft-Antispam-PRVS: <BY5PR10MB3873A49FBDAA01FBBF3CD3ACF0509@BY5PR10MB3873.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: e+XPf3NCdCwn4EDzsmZRPo0JUm5Y3csSCp2XYPiOHu24PB7NFLLuba8StQmnDSd/NkLSMZRNvFGDIIN8rSYkP1U5J0I3BvfJMI4xnqlmUm46+u6wZ7jr8ToKfF7Heiwwp/sZ8Dd6NJq2uVIt4/q+WEdZUvblqrB0Fv0EXPyWQFzPoYptmgdf2kbigP6+lMy1nfs30HA3C1Zcw4BaYzAK7uSfeXYIopru4BjFLtQ9CZ4vqMhsa5DffLQ/E4fLlBENkCxBxj6sbB17g1mzVk+nmGv+rDWkTaB9rZPP10dKjoyvMU1ukfvU3Wuvc4NvfX+5sy98wcmx9HR1HgE6ZhbGCCbcmCFKa1zu31TnB2Z8hVPtcx5aqqGw5o4RR+lmRYFC7sooEUl8L920SysVJKpocqPcJ07nCvDeD+hT70qJEIHN40bDSWQYJpFkdF2hDFvzVSP5AiMpSHNIkOe3o2fza+weREVdpzOOh31YFbPf/H98IYhLxO5d3qtcS2MVri4k+46FsImjzWdIN2VyKQGygZbvKiRB2XTTlwW9YTpn14x6UBrtyu4Jg7c0Aoxlm9NuYmHIAk/dpXbKtm6f51mQeGJfDpwUrOcYzt+DnbKIwUPL/RPxjFMnpQ6s1txPMbcyZUPQs98dOFF627eto6O0tvD2z7PM6ngv4ICTBARv1H/Gsq5NfFDMIkGoCHc3GFAR4cRMf8v44twEh0c8qupx0rLjuVtZAwvkG1U/YueVOMfP6iXOx4sQdis53p7K4KzENVbWxfpFsOexnLkymt5nJydUSdnjVb0g6YDlP8TpAlo6ys3NB9XFnubOVgbnT7A/VXEtSwN+FUWno81kCSPQbC+vCH12aOM762LaJ6FNorQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB2663.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(6506007)(66476007)(66556008)(966005)(53546011)(38100700002)(31686004)(6486002)(2616005)(2906002)(66946007)(5660300002)(44832011)(186003)(31696002)(36756003)(83380400001)(316002)(86362001)(4326008)(6512007)(7416002)(6916009)(8676002)(508600001)(8936002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eFZvWjFEOHpLSis2RTdaU3h4TVdPSHFtQjZJU0xvWUJOTUpqbXZBUUpFdjcv?=
 =?utf-8?B?Q1dMZmhzZkVLT1hkWGdaQzBLay9tZk9rUVoyL0lLdDZUR0NLTG5JZGh0djZt?=
 =?utf-8?B?aGhTSUdSTVh5K1RHWHJXNkRqMVhRbm4zcTNnZWRTRzBJR3B2WEJOY09UVGR4?=
 =?utf-8?B?emdSdUJsTmY2MVd0VEpQSmpldVRqWjVUSEZYcDRXLzgxSXAvN2J6Mk85TVNH?=
 =?utf-8?B?WEVObFJSblN6Tm9GbWR1bnpDNGgxZHpTYWtxYlFaQlVnNTdCV2IyaFhWOEt4?=
 =?utf-8?B?a0RJQVJaQUtDaWJ1a25GZUZkeGxDYkZ6aUt1YTNkSW9ReklJU3Nxd1VWVUxU?=
 =?utf-8?B?eUJxSHlWbGkxcFhSRXQyQlAyVHJhZzRjKy9SQnhSdFpOSHpmZ2drV01IdHJB?=
 =?utf-8?B?RUhFendlWE43UHdUNStIT0dhMStSVm0raDQvL2hoQ0NVQlhUZzl2cnNpS29m?=
 =?utf-8?B?STJFTWN3UXlGcG5iNHZySkw0b045Uzdyb2ZTaWZtYXN2SjBoOG1tNkJjYWdp?=
 =?utf-8?B?VmtJdUN1M3c2eVlOVHFBT09PTS9pS3hFWEFqZ0Y5b3NDYjFKbzM4c0kxakdk?=
 =?utf-8?B?UE0vemdzeVQzaS9YZk1JNlNQNU1OOWJnYjRFbkViektSNU01akNGTVZLbkxo?=
 =?utf-8?B?OHF5T0NQSTN5bXRJdG9nZGVSOCtrUkZUMnBKKzlpRy9lRHA1eTdsR1FhQ0gv?=
 =?utf-8?B?QjQ1ZUdsL3NMeW9lNHorK212L2haZTBhSDVxNS8xcE5uRmVzSjg2c0xjTkNo?=
 =?utf-8?B?Vlg5L0tsUWtsc1hiMVNBOXE5NmZoMTZOcnRFQUMrYndxS3RWbmVuSXR0VlF2?=
 =?utf-8?B?b1p3dWR0dE0xTkhGNUxqREJ5dHV3ZDBIZHNUdFd5RVpERG1UazZEWm02Nm55?=
 =?utf-8?B?bjBtM0wyeldLRTc4aGcvU2xudFY4ZklHQ3BoY3dSbzBVQ3hTdjY1cXMwbURJ?=
 =?utf-8?B?eHBRYWd0ZENmM0lUOW9LM1hORHpoQVVtUTNoSW1aUitCVlFwQUJzWk9FdFk5?=
 =?utf-8?B?YkFjZnNnQ2ZuZStXOVd0YUdNWm9pNEh2YUlWTzBvY1dhb2pueFIzekh3UCtl?=
 =?utf-8?B?UlN3WldreUVVUHAwbGpaUytsZit3VmxFR3BEVVI5RE9icDJFeTRZdTNRNXZs?=
 =?utf-8?B?Vkx2ZDRXWlV2dVRoQmJnZzlGNGViSEFxSlJ4blJBeVk5cEl5TzJhU0FPV05M?=
 =?utf-8?B?TGxONHJoZllMWGU0RGM3VVphbDBxQ1BpL2tIc3VqSitiaEdNQnZMQWdlbHp1?=
 =?utf-8?B?UXpHNmJBMnM1dVJZR3YwUHZadzhoZFp1Vk1RbmJNN3RkUnErRUROcXpTbURu?=
 =?utf-8?B?YS9UV29xbUJraWJGMXJOTXpXaVlIbE15VDFLVVdRekZVWG9XRDJVTjhOT28z?=
 =?utf-8?B?RFh2Y1g5K1h0a0VrZGtyWTBQUSswTG01UzY5bkNVREkyTm1yd011SGNyYXli?=
 =?utf-8?B?cnVWTXRrbUhyVHFQOTJFZXJIS1AvVzVyL09QUVgvdzZicUxIQ0hqT3hOOExh?=
 =?utf-8?B?bkZqK2gyUEs3WC9iRElOQS9zMVdaUGNDeUVJTkVHb0lGenVTZndXdTZLa0Z1?=
 =?utf-8?B?VmZYcjV5ZGswdndIRUcvdDZhTXQzS2ZVRnUzMnFtYXRVSUJGekRaMVQ3K3ll?=
 =?utf-8?B?b3VhTFQ5MzY0Z1pkN2d2L3dXZE0veVpzOCsyTVNmeFZJUFcvUExEaitnTU9C?=
 =?utf-8?B?SXVxVkpPQmI5c05MODFpd1BnQ29WeGNta2lHdkZCS1d4NDJlQnMxdTBCam9r?=
 =?utf-8?B?dVUxQXRxTUk3RksvOXNuUFBxY1RiVDdGWjVUVGpKbGREbW55WFAyemc5anhs?=
 =?utf-8?B?cWNRbFNZc0VRcVl0dkhyUDYvN2lVVkJsa09WWjJyc0hKY2wyNlFZS29zVkRw?=
 =?utf-8?B?QXJ3cW5oVkJTamx4NHpkWkh5c0lJbEtuNEhGb2FJK25YSkNaem54L2E2ZjBM?=
 =?utf-8?B?Y25SQjBXWXFWakxoUnFMUmRac2NNV2dWR3dWNWRtajNDUmc0d0ovZ0RWejds?=
 =?utf-8?B?WEZEc3lYRGhZbjJFNkloY21DMjdDVWdaYjJXWGxQaVVFaG1VdUtpRnV6YWl0?=
 =?utf-8?B?bXBBejNTUVpFWHlkMW5MemsrSkJJcTlyMVkyWEdacW5waExsQUFma2t2MUxS?=
 =?utf-8?B?Z2xMWllIUVMzNE94QW44elA5TlhDdm03WDhwZlZJa3V6aDkwblFFbks0OVhR?=
 =?utf-8?Q?m09Aayz/j9UxuLAqGiW9mvh7AmlVnSg63yp6z2SZF5Kc?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1873cd55-bc2e-4aa8-0ec4-08d9d460c9c0
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB2663.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2022 17:44:01.8266
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: obP7XX1AG972W16ispTzumh4Qo1le2mqd/HtK+1XSyKlyTWnhZueQj7hbmabdQzZJC4iBwF0qEekpUWOpPARGQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB3873
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10223 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0 spamscore=0
 phishscore=0 adultscore=0 suspectscore=0 mlxscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2201100120
X-Proofpoint-ORIG-GUID: RYkRCaKQijpwqQDaUBmi2y7jve3_G55V
X-Proofpoint-GUID: RYkRCaKQijpwqQDaUBmi2y7jve3_G55V
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

May I have feedback for this patch? This may mitigate a CPU hotplug issue which
is only recoverable across OS reboot, unless the below patch is available.

https://lore.kernel.org/all/20211206152034.2150770-1-bigeasy@linutronix.de/

I see there is a patchset that may rework this part. That patch set does not
change the logic here.

https://lore.kernel.org/all/20211215145633.5238-1-dwmw2@infradead.org/

Thank you very much!

Dongli Zhang

On 12/23/21 1:03 PM, Dongli Zhang wrote:
> To online a new CPU, the master CPU signals the secondary and waits for at
> most 10 seconds until cpu_initialized_mask is set by the secondary CPU.
> There is a case that the master CPU fails the online when it takes 10+
> seconds for schedule() to return (although the cpu_initialized_mask is
> already set by the secondary CPU).
> 
> 1. The master CPU signals the secondary CPU in do_boot_cpu().
> 
> 2. As the cpu_initialized_mask is still not set, the master CPU reschedules
> via schedule().
> 
> 3. Suppose it takes 10+ seconds until schedule() returns due to performance
> issue. The secondary CPU sets the cpu_initialized_mask during those 10+
> seconds.
> 
> 4. Once the schedule() at the master CPU returns, although the
> cpu_initialized_mask is set, the time_before(jiffies, timeout) fails. As a
> result, the master CPU regards this as failure.
> 
> [   51.983296] smpboot: do_boot_cpu failed(-1) to wakeup CPU#4
> 
> 5. Since the secondary CPU is stuck at state CPU_UP_PREPARE, any further
> online operation will fail by cpu_check_up_prepare(), unless the below
> patch set is applied.
> 
> https://lore.kernel.org/all/20211206152034.2150770-1-bigeasy@linutronix.de/
> 
> This issue is resolved by always first checking whether the secondary CPU
> has set cpu_initialized_mask.
> 
> Cc: Longpeng(Mike) <longpeng2@huawei.com>
> Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> Cc: Joe Jin <joe.jin@oracle.com>
> Signed-off-by: Dongli Zhang <dongli.zhang@oracle.com>
> ---
> To resend by Cc linux-kernel@vger.kernel.org as well.
> 
>  arch/x86/kernel/smpboot.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
> index 617012f4619f..faad4fcf67eb 100644
> --- a/arch/x86/kernel/smpboot.c
> +++ b/arch/x86/kernel/smpboot.c
> @@ -1145,7 +1145,7 @@ static int do_boot_cpu(int apicid, int cpu, struct task_struct *idle,
>  		 */
>  		boot_error = -1;
>  		timeout = jiffies + 10*HZ;
> -		while (time_before(jiffies, timeout)) {
> +		while (true) {
>  			if (cpumask_test_cpu(cpu, cpu_initialized_mask)) {
>  				/*
>  				 * Tell AP to proceed with initialization
> @@ -1154,6 +1154,10 @@ static int do_boot_cpu(int apicid, int cpu, struct task_struct *idle,
>  				boot_error = 0;
>  				break;
>  			}
> +
> +			if (time_after_eq(jiffies, timeout))
> +				break;
> +
>  			schedule();
>  		}
>  	}
> 
