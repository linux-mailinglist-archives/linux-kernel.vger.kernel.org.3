Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3B564B1539
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 19:28:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245711AbiBJS2N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 13:28:13 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:55240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234327AbiBJS2M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 13:28:12 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C39F8D4E;
        Thu, 10 Feb 2022 10:28:12 -0800 (PST)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21AGOpcm008856;
        Thu, 10 Feb 2022 18:27:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=p1iqCrWz3crsJ9DfClg1T1nz73ESbUB8xZ6rLSdEj0Q=;
 b=WzcVrUrlBg21DSg4sNg3ymF7C1aE+lCILiH5krokaDt3Kfzz2xk47foijJdOYX4AaXiZ
 JOoeagJ9c+dEUAUuaDmC+0WwKRbdXPv6yvcAiD30XMQHwNuBZSLv7DOR7YhsLGzQSAhG
 1V8i0CK15cepYEndJr3huHoE3DkTr1AmBmyDXPviLpSu8ZdZXgayTw7zIZGy/BJdp23X
 knTOqrJxzDsYk0Qt0Gz1stO6afyXiYyxHFSN7lEMbOskH8yFBkE74lRVqGGCrM/OvSjM
 jDIPLdhzg0ALSSdtHr9qS1tddwS613rc1n8nhx4YKkSqVPvvvkdmEgyRPT86Xvh2/YRk cg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3e3fpgs500-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 10 Feb 2022 18:27:57 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 21AICCaF053430;
        Thu, 10 Feb 2022 18:27:56 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
        by aserp3030.oracle.com with ESMTP id 3e51rtt2mn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 10 Feb 2022 18:27:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WMT+L92VJe/6oPlRCUH+dqGfRmnVe9PiDQs2ETvRyLtaGGqoKGJ/rl267bBuiN7tmXGJNoStNJS2+48AANmyPlUw9wbJbVHeBBkfwj+XAJ5+XcJZ7aRzcByCU0Ge/phO5z4boAqv69dRxlsaaei5i3Gaz0HKJxbOVe86l7izJqxccPpxgF9Fx2631sCBlArqcc5X7Zg3cs/bqxunEjC1jFfaU4n7vsOC0yEPPPBuJe2Z8Idb0gASv7apdQAUyot2MKDPS/Eu8qPduVxcm0crkYtZGlwdNotLSyJpM9hFI8AHC5Z/p4WTwo2w2U9tHCpmeVJqlgf/iYQz3rpgK/kMgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p1iqCrWz3crsJ9DfClg1T1nz73ESbUB8xZ6rLSdEj0Q=;
 b=JVj0R5ztMDb+vs46jCndMRZkqiEQugNrz3QWCtn5NNTfq/EZzCZgAfQ5Xodm84MYrDAHQ2J2MJAnuVzHjaQocHYUKD3Hz8v3B+1SrjYgpi5Pdkf/x2k6QxrCC5AHkpbEG2bIDCwH8qvsfeYpLyA7ll01jbKmtp9k2d0tupU/ZvgZly3CMx7eZcrXz5tgaSLETtCwz5Lu35UFedPhHUsVyzpcPJRGqOHbHFNRnMcKVhEisvDf5WAxCDtpbavsJZWQcWIZQdzaW+GPWAZPZkaKYlEIuXoCOlCIbGP9aNUWZBy+nca7m1U5PhRvCI0gc7h4xM8f4tAR7IvB9nkdhyjNgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p1iqCrWz3crsJ9DfClg1T1nz73ESbUB8xZ6rLSdEj0Q=;
 b=Ml2N/KgfQZ3VrArbogprzSc914nWnwHvuoo9wltJ3P8ex8G3P2etyUkpnejFmP+ZE10AYaBGkj6Vc/1BGEqM9UApOcjAjAjIXmFlDgCSkpqoB0El53B936fI4CmmGus6CDUo9ZEPH98u7ziWh0ucBsrT4OAqW3/KHFzva+OKbIY=
Received: from SJ0PR10MB4477.namprd10.prod.outlook.com (2603:10b6:a03:2df::10)
 by DS7PR10MB5103.namprd10.prod.outlook.com (2603:10b6:5:3a8::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.11; Thu, 10 Feb
 2022 18:27:54 +0000
Received: from SJ0PR10MB4477.namprd10.prod.outlook.com
 ([fe80::c8d3:908b:a395:3753]) by SJ0PR10MB4477.namprd10.prod.outlook.com
 ([fe80::c8d3:908b:a395:3753%6]) with mapi id 15.20.4975.014; Thu, 10 Feb 2022
 18:27:54 +0000
Message-ID: <85bbc0e8-7709-71bc-41ba-9c2f0b2e717d@oracle.com>
Date:   Thu, 10 Feb 2022 10:27:47 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] ACPI/IORT: Fix GCC 12 warning
Content-Language: en-US
To:     Robin Murphy <robin.murphy@arm.com>, lorenzo.pieralisi@arm.com
Cc:     guohanjun@huawei.com, sudeep.holla@arm.com, rafael@kernel.org,
        lenb@kernel.org, linux-acpi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        trivial@kernel.org
References: <1644453141-1181-1-git-send-email-victor.erminpour@oracle.com>
 <fcb52c7b-a222-126e-fb3c-d57011506cf8@arm.com>
From:   Victor Erminpour <victor.erminpour@oracle.com>
In-Reply-To: <fcb52c7b-a222-126e-fb3c-d57011506cf8@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR03CA0272.namprd03.prod.outlook.com
 (2603:10b6:a03:39e::7) To SJ0PR10MB4477.namprd10.prod.outlook.com
 (2603:10b6:a03:2df::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 54394853-2178-4581-d015-08d9ecc30d5c
X-MS-TrafficTypeDiagnostic: DS7PR10MB5103:EE_
X-Microsoft-Antispam-PRVS: <DS7PR10MB5103D1DC6C78FF46AB6DD0B3FD2F9@DS7PR10MB5103.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2t3bPiIbOJitYXCG05cODyNliwDFQi9UGKl3FDqde5bNkz6K88UEZe8O/6eb9qKqkZa717xJWpCcE+FE0F7lZuyOgQ14uwdi8loypb5D592QGYHyj6OHJzSPAOOT4g4XbE1WXAln0y1wMtwAGIrxhUuQ/RJL8N25J/MIxMe3GAEQ10MNisMoBai1aTu8122WWlCl3p5rctEbLBBeaC1GBzBM/mh6l6oFjW8aPZF7/0kFcnykv6X+AyAIACX4TuzSF24VUJ49W9WqWRro+ok00vjfkdgLtF0xoPj52FjlGyHq4jHBBmZBVlGyU/yT6rWpfN//jixr7YFuAM83d+sdIxAMKFTHNV1zn7T9OYr6U2i9X+NdfGkI5Umr5+QLf6UMqkBL/nBwlQJOEEckQOcARuJaxwegPGwlSijZkPGkwKXpk5Vob34DMahtAQruWVHPinJBY9/wh4nnEd40DiliuEtFjeXMc+8g793CweqrWr7tJmDro7NnM+r6OETDZT42fdCkd7s0GKERFbLMdmR4FqweEqpneEGQgyldXwvHKl6MxHdw7QEN4DqYg/MVYuY9GzliEGB3PZqaAfiGyXILH8VqiB12XdgcKHGH+ZVddCeErsPXgyvdnNJYy3mzXOtfwdVWvHoD8KIOvkiiWa0FXBl7wC4n6SB5UY47D5mGo4DIxC4i7hNZuOqY5iQh1EpjMApT5cOnO1S5qjoNvxijZ/V4KT1MCgJqtmD0CrtAP977gKrOK2/8bjSAq9GO/bgmQ+0gmhpHZDEc8tAEL1ia6nUBdaxuaM7q2W9VYcryf9H4TF8LbhFbZ48TNedZ6nd+AU0UlstGGbYMgxr90L26mw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4477.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(83380400001)(86362001)(31696002)(66476007)(66556008)(8676002)(66946007)(36756003)(4326008)(31686004)(38100700002)(6486002)(966005)(316002)(508600001)(5660300002)(6666004)(7416002)(6512007)(44832011)(8936002)(186003)(2906002)(6506007)(2616005)(53546011)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MER3b2VqQzV6a2Jxc2JnOUFNWHl3Q1Q0UEc1M254eEM0SnZOMC8wUmNXOEJq?=
 =?utf-8?B?TFYzK3c0bjJmUlJZbzM4WHFiUUN1MzZaTXhQc2ErR0E4cUhvYmkySTJHcjdK?=
 =?utf-8?B?NjhHdzB3QUl1R0ZQL28yVU5oWTdVbGEydVNKOUwwM1FiN2NON1NZQ05Kemh1?=
 =?utf-8?B?V0RjMGlZTFRTM1pXTUxYK3B6MWVaaTFTbWp3bGNLZitLbk1BNkZuSDRKcDdx?=
 =?utf-8?B?REIvMmcrdnFrU3NjUmQzYVdFVDV5QWdYUmhTLzRtN2NCUDJxbDBaUWNxdU1v?=
 =?utf-8?B?VWRES01nSnY4VzA5dEk5WXM4Wi9uZkNiVkFxY043YXNuSGhJVmZ1alVrOXRm?=
 =?utf-8?B?MWppTUV6TlBCbE9PSlJ5T3lEQXNEWXpaVWtOVEFyT01wUjJPcUZlOEoySHI0?=
 =?utf-8?B?S2J1MWcxck8vY2hzZEplYWk3eFpXZlR5QXIxeDdINU5NNTB2azcwN2FCOUd3?=
 =?utf-8?B?MXRyc0x3a29vZGNrZ2RjL3ZheE9Vd05NcVFqYjY4a2FMYzF4RWYxSThnTzd4?=
 =?utf-8?B?OVl4SFd3RjRsdzB4Tkh1M3g5VHRpVjBUSnk5eGtCZ1NPNHRoTVEyejJPQ0Js?=
 =?utf-8?B?M0ZES3ljV2FkeUNKOUVrdkxYSGt4UXpLSjArbktNWDY1VVZadVh3eDk1MFp5?=
 =?utf-8?B?bFVEVGVUZzVHNjZVV2hmcXQrWHJWcVZoV3hSWitRWFJxN2RlVyt2cGpwczRW?=
 =?utf-8?B?NTJ4ZCtGTnZlYWVGRzdBVGMrT2xraGlBUTlWMERKbFd1UDVGUC81ZHVhcW5Z?=
 =?utf-8?B?dDR5S0hpeG42TUE0ZWF0RlZkYUZxZk5xNXRmL0NMYm9nOTlLbXJUU1RYZDR5?=
 =?utf-8?B?d1JXaDlXS3hQNnJ3VG9qNTY0a2UvekQ5UTgrQ05WcmVOTDB4bHFZQzVJZFpo?=
 =?utf-8?B?R3ZwWWJ3TkNFNDNXOUw0dFVQRm9OR2VVdXJkdVBQalZEd2V3UXJnWDRXQ3Ji?=
 =?utf-8?B?UnlGVW5KYTFCQ3RHS25zVnBqQXd5ejJ0bk12dXlCdVpsNTRuMXdXWXV0RXZy?=
 =?utf-8?B?TG9GNVFMckh2T3hBR1NBQmlxOXY1VTdNODV3NittL2VUQ3JLL3pTZTg4cWJW?=
 =?utf-8?B?WG5Ba0RwUXFyb3laajNCTnJ3cDE5UmlrS3JrTldUMDhBd3VvQ2hUeXBkUkhk?=
 =?utf-8?B?Mlp4TFJtT240ZFhsSVFsWlN2dUZPR1NrZFFyaXV5YXM3bjJtYkYvQ0E5bWs4?=
 =?utf-8?B?Um91MVMxaHE4MHdyV3hMY1RmNVhWVHZlM3hpY1ZUZ3pWS3c4OXY3SWNJTllY?=
 =?utf-8?B?WUFISm5MUUNzL2o3RzZyM2wweVNFRzJ3UXk3RkVubVJ5SWpTVUcyUnB4TEgy?=
 =?utf-8?B?ZmlMM3ZzY2poMk41WU0rZXB3dDcxVUZSNVlvVWlrNldRdWdxM21xU0hEcWJm?=
 =?utf-8?B?OVloZTA5UElnMzJDaDkzeWVEM1IzU1ViS0ljOXc4OHUyRitMczFwRHhOcTZW?=
 =?utf-8?B?bkZrUXI4ZmxFeE9zZmdVc1N2WGZOM1lkY0xENkpWR3IvYzB2T0I5T1VwUk5N?=
 =?utf-8?B?V0pjQ29TUWY2TEtDM3VCTy9EeE5wdzV0aUxkV0NXSW9mM3pqVGZqOFhPV0tB?=
 =?utf-8?B?OTI2bHNjRStIcngvUWI2Z3czN3hURmZoMG54OXVPTlhLNjVIeDRLQ0xmQy82?=
 =?utf-8?B?c3hHMUljS1l3RXRjcWs4K1hMWmlEcFFqaFVVSjhpTmFyRVJxbEk1cnhOSDlp?=
 =?utf-8?B?aFFoRDVnZlJDeVpHUE45cGREUjhEeUQ4dW5JM0xoYWJmOEowRFRHWEloaEkw?=
 =?utf-8?B?NjlnL1hEVnNLOCtsNE9hWmJPakt1ZmIrU1d1QTdFcG5BZHAwU3o1cktock1o?=
 =?utf-8?B?aGlXT2FQd0JESGtyazdzQmxBNG9yejM3a3ZtWG1SOWtENjk3MUtRK2FnMWFh?=
 =?utf-8?B?T2dVVGZlSlUxSUR0YW1NdjB6OU1vaU0rck8vSGNac0doUkhYMjNSREhTOHJN?=
 =?utf-8?B?NXZmcG1WU3RwMGx4RFNjbk10V1RGMEdubWJjZzVRTDg5K216a29VWUo5c0lB?=
 =?utf-8?B?TXlLRTdvbUdkbkFTK0V4WG92SmVCbkZzZ0lmbjUyS2FJNTA4RFhTR0JYV3RV?=
 =?utf-8?B?ZUV4aTJ6TmwwTll0NlUraWxCMThESXRST2ZiL3B1a01Eb3ZvdG9aOU44SGZi?=
 =?utf-8?B?KzBHNzFCVFQvZEk0U0tRekdnUWdTZXlwd1NvbnNJMlFPaUYzK2dnTndwaWpU?=
 =?utf-8?B?S0FLN1pEWURwaE1sRkRhSTBSUVZVaWlhYmZYSE9CMENCcmZQK201Y2F3OXZI?=
 =?utf-8?B?MmZkTW1BUWhjcXI0RnB1c29GUFVZYmZOazlyZEpYZVNVdmNOc0lZcEpTSnNU?=
 =?utf-8?Q?mQ9O1xUSBqbQPKndY6?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54394853-2178-4581-d015-08d9ecc30d5c
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4477.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2022 18:27:54.0505
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7WKT697W1tan8zkh8jXiBD9E6Rj3bwZF0JYTLc141pSGg3cJgtzSxbupkGhMpfY44+Wt4eOTht05MuxiTjuJ9zgLCYr14f9x5+98tRKf2U8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5103
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10254 signatures=673431
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 suspectscore=0 adultscore=0 malwarescore=0 bulkscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202100096
X-Proofpoint-GUID: BdJfUZcKSkWByMD2rjgjOu4WsoYADQUY
X-Proofpoint-ORIG-GUID: BdJfUZcKSkWByMD2rjgjOu4WsoYADQUY
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2/10/22 10:06 AM, Robin Murphy wrote:
> On 2022-02-10 00:32, Victor Erminpour wrote:
>> When building with automatic stack variable initialization, GCC 12
>> complains about variables defined outside of switch case statements.
>> Move the variable into the case that uses it, which silences the 
>> warning:
>>
>> ./drivers/acpi/arm64/iort.c:1670:59: error: statement will never be 
>> executed [-Werror=switch-unreachable]
>>    1670 |                         struct acpi_iort_named_component 
>> *ncomp;
>> | ^~~~~
>
> Notwithstanding the fact that that warning is nonsensical, this patch 
> changes valid C code into invalid C code that doesn't even compile:
>
> drivers/acpi/arm64/iort.c: In function 
> ‘acpi_iort_dma_get_max_cpu_address’:
> drivers/acpi/arm64/iort.c:1669:4: error: a label can only be part of a 
> statement and a declaration is not a statement
>  1669 |    struct acpi_iort_named_component *ncomp;
>       |    ^~~~~~
> drivers/acpi/arm64/iort.c:1676:4: error: a label can only be part of a 
> statement and a declaration is not a statement
>  1676 |    struct acpi_iort_root_complex *rc;
>       |    ^~~~~~
>
> Robin.
>

Hi Robin,

Thank you for your constructive criticism.
Could the solution be enclosing the case statement in curly braces?

I know this isn't a big issue for you, but this is a legitimate error 
for people
building the kernel with GCC 12 and CONFIG_INIT_STACK_ALL_ZERO enabled.

Regards,
--Victor



>> Signed-off-by: Victor Erminpour <victor.erminpour@oracle.com>
>> ---
>>   drivers/acpi/arm64/iort.c | 8 +++-----
>>   1 file changed, 3 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
>> index 3b23fb775ac4..5c5d2e56d756 100644
>> --- a/drivers/acpi/arm64/iort.c
>> +++ b/drivers/acpi/arm64/iort.c
>> @@ -1645,7 +1645,7 @@ void __init acpi_iort_init(void)
>>    */
>>   phys_addr_t __init acpi_iort_dma_get_max_cpu_address(void)
>>   {
>> -    phys_addr_t limit = PHYS_ADDR_MAX;
>> +    phys_addr_t local_limit, limit = PHYS_ADDR_MAX;
>>       struct acpi_iort_node *node, *end;
>>       struct acpi_table_iort *iort;
>>       acpi_status status;
>> @@ -1667,17 +1667,15 @@ phys_addr_t __init 
>> acpi_iort_dma_get_max_cpu_address(void)
>>               break;
>>             switch (node->type) {
>> -            struct acpi_iort_named_component *ncomp;
>> -            struct acpi_iort_root_complex *rc;
>> -            phys_addr_t local_limit;
>> -
>>           case ACPI_IORT_NODE_NAMED_COMPONENT:
>> +            struct acpi_iort_named_component *ncomp;
>>               ncomp = (struct acpi_iort_named_component 
>> *)node->node_data;
>>               local_limit = DMA_BIT_MASK(ncomp->memory_address_limit);
>>               limit = min_not_zero(limit, local_limit);
>>               break;
>>             case ACPI_IORT_NODE_PCI_ROOT_COMPLEX:
>> +            struct acpi_iort_root_complex *rc;
>>               if (node->revision < 1)
>>                   break;
>>
>> _______________________________________________
>> linux-arm-kernel mailing list
>> linux-arm-kernel@lists.infradead.org
>> https://urldefense.com/v3/__http://lists.infradead.org/mailman/listinfo/linux-arm-kernel__;!!ACWV5N9M2RV99hQ!ZcNRWTaQIb1uVqcZAusSzXd2kBnWuqAuICpxkOm6bOWBouQoFygbcIMJVUNp34LqhNrc$ 
>
