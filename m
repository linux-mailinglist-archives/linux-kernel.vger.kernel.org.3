Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D91454EBD2D
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 11:04:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242502AbiC3JFx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 05:05:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242292AbiC3JFu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 05:05:50 -0400
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam07on2040.outbound.protection.outlook.com [40.107.95.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05C7B168098;
        Wed, 30 Mar 2022 02:04:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PFcXilZQDzE4KDybdJfz/o8cRxNMTHmPtoJ+Bat6IQSyaq5NJvNsqOy2v1TaZXN8fFqPxWdLybt9JbX3wqC0Vmw1Ar516O5Tj4xRb69QIPU8Rq9wta+840wlbq9lzEA7LHhR2izepF1db55aZ8TfHcgKZnh+gcopSspKB7nHsjDNGRkxhnvQo7GoF2y7bgzC5XZdjm4iKYETU1ViDS1StviXAFgiBtgeQsa+lZNSwnAznhPaJYC4UnOWheZ3kPsJ3K3d/fJ61KeQvUFrx1EEzVDUsY9gcIrCebA+t5CdUxMi1YKDODmJVcMg//SkaodZgub1Jtl9FcR8wfXlOQxGVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xg7yxo4RaGLMzxGyMSFm7qV6lYw4iNx9UwQkle7tGpY=;
 b=Ba5PSUC9w4CjeBDcjWDO/lt7EsK+M3wbHdksKEmrsEp/x0GKW1dtFeABj9l0MnWVEhqASsciJhMny0t76au04ovIj3aBxmZxGL69UcrJb4T5/om/QX2Q5xjuMzr+RdbHMlv054eEJ1zAgh9tYHURMt1ym1RqcUkVbzx9jFUxT4sT7Me9Bk38flklQfI3tJmRER0m999/QRk9RFvkJiiEuFnvL1dJ7SIUsySoAStiOwlwRLscT2eNdj7IY38EVvFoSzmke/afBRiRJnTT2olS+nWt2LSaJE+G7Ezohqsb9oAdymn2EC/wIXT3NHWuSX2v16J98w32GUfwJ3Aal0vfBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xg7yxo4RaGLMzxGyMSFm7qV6lYw4iNx9UwQkle7tGpY=;
 b=ttGno4y1pKpdm6haax5kPQ/oA1OiFIwzuSvyy7BL8Y7T1JQaHKHE8JGdVf3u9YzmjlH/1Gd65dgnio/2Y0quxSpIgGSMmDAdUWCMeoAoVxAfgiKUwhJ6ozF1uMZ4wgjX8zhhx3URBYjuuNpn5YvWXdDv9vC/QVt2eQ3lJcmw4dePikLFhQVD7MoIFrKG8IAtekrnAWk3T67mWVh43QB7uDgX14dg1CLQY5Hofdw+4M+cQ1NpC2dbsAlkzrMdP1eLOELCIMO7Sv+HC3Bu+E4HMLCLnXwssfuoFjBfWljxZQYAo/oh7ynECdHCp9IzKWbClvczGS7cYwNzUVcx2E7yBw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA0PR12MB4349.namprd12.prod.outlook.com (2603:10b6:806:98::21)
 by BYAPR12MB3623.namprd12.prod.outlook.com (2603:10b6:a03:a9::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.22; Wed, 30 Mar
 2022 09:04:02 +0000
Received: from SA0PR12MB4349.namprd12.prod.outlook.com
 ([fe80::e15c:41ca:1c76:2ef]) by SA0PR12MB4349.namprd12.prod.outlook.com
 ([fe80::e15c:41ca:1c76:2ef%3]) with mapi id 15.20.5102.023; Wed, 30 Mar 2022
 09:04:01 +0000
Message-ID: <c5341578-e0a6-4ad7-5b6c-95b31b16faad@nvidia.com>
Date:   Wed, 30 Mar 2022 14:33:47 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [Patch v5 2/4] memory: tegra: Add MC error logging on tegra186
 onward
Content-Language: en-US
To:     Dmitry Osipenko <dmitry.osipenko@collabora.com>,
        krzysztof.kozlowski@canonical.com, robh+dt@kernel.org,
        thierry.reding@gmail.com, digetx@gmail.com, jonathanh@nvidia.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org
Cc:     vdumpa@nvidia.com, Snikam@nvidia.com
References: <20220316092525.4554-1-amhetre@nvidia.com>
 <20220316092525.4554-3-amhetre@nvidia.com>
 <04bb5ef2-15c3-d561-3572-76dc803275ef@collabora.com>
From:   Ashish Mhetre <amhetre@nvidia.com>
In-Reply-To: <04bb5ef2-15c3-d561-3572-76dc803275ef@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA1PR0101CA0008.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:21::18) To SA0PR12MB4349.namprd12.prod.outlook.com
 (2603:10b6:806:98::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4cbacd21-9b39-4adb-5179-08da122c3b57
X-MS-TrafficTypeDiagnostic: BYAPR12MB3623:EE_
X-Microsoft-Antispam-PRVS: <BYAPR12MB36230B3B8438DEF91952B0F0CA1F9@BYAPR12MB3623.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PCsO9hRNiYwFM78Ib8nA7j6GYhf8uWUrBoSAW7KdDHzGqp+kv7yuAPd1WZup8NZD5G9o2QhJA/3jg96I5dVs2hPXmv8ffsPfc4jxnahbwNPtyI1Xrp1wrFp0jav/AQcG94URli38YU4DliJnwzKS8jYlI53tpaOF5t1F2ZlPqPheThPV2PCa3gtm9BRIyiXnJnQbNScjLi3IPZg2YUM6xCbYWAA+WjQuBYorsMlQpr4P96ssFXyFq9UoRTLExcIw2F0sGjln62aQkyN0NPZOUxQ3C3WBSnqUIIrqOE6RzMXjZdDCum//Nx1QS0ksci/5bIySSgzZN26UMBhgxEZKQxck70J7BpCV1C9QfuMmOiu+nMpj7+nJe7hyJ2RqSRzfbHjESCN32ZEPfG+UWNrmc/VD8R1B9vQ10gFBQQ1C5aQvVxEO9QW/96D8s/nMqJR3Uvnnj/mdmCgELXxLKbg5Wiz87BpsMrHQ0FPMUFqi8faeAuvk7iw0/SdVf/eoJhIP7yc3JYI9ewhryDqIpKal5Ohq2zJz8OL86yvajJpLZusOr5Jp7rrPBxZz4Kl1oUknEG1Sexl/KpF7qAdYoLS+VoTqzFWT0FqvxOHjDeODA8bFwRsQQhVDpKoJW6btaXNCcWuThssbvwAOTrrEgsa9pzUNFQO98e2CNGkWPLsWkUhbh4ob3BDRMRe5GPUEzyIZunzgk5nOmHOQ2COYc9LVBUshtsIBuIJmHLB4xb2QT/4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR12MB4349.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(83380400001)(31696002)(55236004)(8676002)(86362001)(31686004)(6506007)(4326008)(53546011)(66946007)(66476007)(66556008)(36756003)(2906002)(5660300002)(38100700002)(8936002)(508600001)(6666004)(6512007)(6486002)(316002)(26005)(2616005)(107886003)(186003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dU1UR1BRQnhPRUF2SS9waEV3eE5aTFdwMGtHeGtFWjE1dlZzdTU3MHV5eHla?=
 =?utf-8?B?OFlXSDErd3ZFSmpKU3JCUDNGY1F5YWZRRXFxaEhZVTd5SmFjYzhtblZ6WE92?=
 =?utf-8?B?cjZ1V1dPY1pDeGZrK1Jod25WM1NKenJ3WVgxZzFITWVNZ1VpMmw0d0hIUnN2?=
 =?utf-8?B?OHNKdURITHhLaG1zSkUrY1ZTUDJVQlY2dXdLSVlwRmo4bUFoTkRqMEFCbmF2?=
 =?utf-8?B?eUsrdEdvNzlxY3RZS1ZlMWRpbzFDT0E0OFErYUxVRngzVEZ0S3RpVE1ydE44?=
 =?utf-8?B?ME1tTWlNaVZBeGxhdTk1MVdtZExUb0xMdDVTbmdwdmxVdnZvVHg5MEVjSlJZ?=
 =?utf-8?B?bzNGK1lncmVtMmFxOXp2b0FjcVkwdy9KVFNraVpLSFJEZTZ5MnBVcmdUSHZJ?=
 =?utf-8?B?ZSsrZzhtQkJYTFZGSG5YMEVQYWJnZzBOQ3M1MHQ4NDFRQ2NIcDRLeDUyRDRz?=
 =?utf-8?B?aHo2NW9adVlQdGRMZ0MrOWhreTRsMm8xbjllSXZzd292aytnM2lCTmx5ako1?=
 =?utf-8?B?b2hwZUNnZXBMTDFWdDVueENDdVVOV2pxQkJETFRaU01GWVUyM3N6TmpnT3R0?=
 =?utf-8?B?Z09hR2ZPWVhHQkV4SU1qZlVhMmhqa1haT1E5T2R0engzOGtKUk1qcm8yNW5C?=
 =?utf-8?B?MWs1VzhPbnlMekJ2WHFLL0lVazN0TytZMmNUb0dvVTd0c2FTTVhPREg1M2t0?=
 =?utf-8?B?R3FWdFQvZzMyZ1FjRkRHUnp1aXdQNjhINDZmYnlUYWxpVGhieVpGZU0rb3ps?=
 =?utf-8?B?Q2l1U1oyQ3BwbEV0U3kyTjJ3TE9oTng1VEM5ZmlvM2htSUNRMjNWUzFyRTJO?=
 =?utf-8?B?L2h1bXdTS202aENnckRla3IvSFl5YTlUQnZIbUJ4alJBbE5UcGdxRXR6d3hw?=
 =?utf-8?B?NVdtTWRrNjAzdjUwVEI1RUJ2WlkveEVhNmJyQ2xvUXBkSlQrVUJ0UVJGSEJH?=
 =?utf-8?B?SzYvQjh5MkR2NVRaSXVwc0lGdktvMHJqQXZmTzZHdHdLakF2NGNzbjRtUytS?=
 =?utf-8?B?TzJxRzVUTGk2RlVmMnBLdkVYMFhmWHF6UkNKK2NMUlBkQ044RzgvOW5RRU9Z?=
 =?utf-8?B?TzFmK08wK0QvNnJ1QUNCYS8yanBsK1pzazI2NHBpRFFqTkR2UTcxUnIramJl?=
 =?utf-8?B?QXE2Q1NiNmNuNDd3SGVZM2VxbnpuNXlrTG5udFgxLzVtcDNsSVcyaVhrd1c5?=
 =?utf-8?B?U2xQOUxZOTZ1MElkeTk5SDB6ckQwRU0yd2ZPS2hqU2tsTUpTR08xMjBqY0l3?=
 =?utf-8?B?REM1Y0pnU0RObGNXRzBMbGNjNmQyejJrU3ZnTTRWakhBYUVyVWk0bWxHM3RJ?=
 =?utf-8?B?NmIvOVYrQTI4VVlBbmorQU5URmRXNEtDNERIMC9DMkpZQTBxZ3YxTnRuZ0xV?=
 =?utf-8?B?UlpkaFRZUU4xQmdReC9POVB4MW5kM0oxK0pDNHpLUGpQa0p5Q21uV2JMM3Rn?=
 =?utf-8?B?R3RscGZLY1Vsck9wMUxYRW1yMGttWkN1eitaN1p0K2RGeWh5SFhnQmc3SFpE?=
 =?utf-8?B?SFVQN2hIbEhrVHRtZWx5dEJHT2FtZWtMZlBHaGJLRWVicElzcmMwK09hT0lZ?=
 =?utf-8?B?M3cwekJ4bkNIcnR2aGRUekpvTTZyQ0o5Z1BNOVhrNWNvZ3B4dmI1Vi8xdDky?=
 =?utf-8?B?Q2NvUnN4VXE2bUhpRjYyalpiUjRESzRNQ2p0Wk1xaTYzVHFlTGhoRytMWlBu?=
 =?utf-8?B?T0c1dm0xeVZiaTBKVWFhV0N3QlBITi9Kc01LOG9JQzZJNHVMOFFGeG95VzND?=
 =?utf-8?B?M05ObHpiZFlFK2U2NnBzTEIyVE9rN0lPZEt2WWgwVFVyV1E4SkdTbVlYOUJa?=
 =?utf-8?B?SngyWHk0U1MzRUNpVVp3OXZ5dmJoZnd1eGcxYzBVQW9HU05USVdjSHFnMUZw?=
 =?utf-8?B?NW85dTE0NGN4RGRkNUJ0aHJoMnVCN0ZzWU1SMFRQZzgxQ2lVVElhNTB3SDJZ?=
 =?utf-8?B?MVBVTmlGT045RW01cld6SDJCYk1iQ3lZeGk2Tm11R0pXR0l4S2JZQmhSWXBM?=
 =?utf-8?B?Zmx4RGptWGtabmJraGR2NjhDeENrZy9mdlIyREhhV1RBZjJoNWRlamh6dVpa?=
 =?utf-8?B?bmFueFJET1ZhOW5wOTJkc3JjZzZPcm5wa3NGRmpvSGdLY0lJN0lCZEdLMGs0?=
 =?utf-8?B?RGM5QXhWTDBkZGE0WjJMNGVmUVJTMWRHSlE5emp6dkxNSHBlR2l1WGVFbXN1?=
 =?utf-8?B?alFpR2R5UDlPK2tLL2V2TEJqZlZ0UFE3VTlOb005QitUZjBrZ0JEdHpqL01Y?=
 =?utf-8?B?KzJOVHVMSDZBSTNJOGdSd2p1Tm1qdENHdkM4Ry9Pdm5FUHpLeTYyY2o4MGtj?=
 =?utf-8?B?d1NDK2haV3Bqbjl2bXJGZS9FL0JOMHNSWkZZRWlQMHdpOWhwWjhWdz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4cbacd21-9b39-4adb-5179-08da122c3b57
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB4349.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2022 09:04:01.3379
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gnXZvcjUY287wFC2heUE0k3vQoWpFERIclGDwEHGOg98RyIUiwxYuR3fpIqSXVOHHrCIa0SpAOsUY3Q7QiVJ7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3623
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/30/2022 5:36 AM, Dmitry Osipenko wrote:
> External email: Use caution opening links or attachments
> 
> 
> On 3/16/22 12:25, Ashish Mhetre wrote:
>> Add new function 'get_int_channel' in tegra_mc_soc struture which is
>> implemented by tegra SOCs which support multiple MC channels. This
>> function returns the channel which should be used to get the information
>> of interrupts.
>> Remove static from tegra30_mc_handle_irq and use it as interrupt handler
>> for MC interrupts on tegra186, tegra194 and tegra234 to log the errors.
>> Add error specific MC status and address register bits and use them on
>> tegra186, tegra194 and tegra234.
>> Add error logging for generalized carveout interrupt on tegra186, tegra194
>> and tegra234.
>> Add error logging for route sanity interrupt on tegra194 an tegra234.
>> Add register for higher bits of error address which is available on
>> tegra194 and tegra234.
>> Add a boolean variable 'has_addr_hi_reg' in tegra_mc_soc struture which
>> will be true if soc has register for higher bits of memory controller
>> error address. Set it true for tegra194 and tegra234.
>>
>> Signed-off-by: Ashish Mhetre <amhetre@nvidia.com>
> 
>> Reported-by: kernel test robot <lkp@intel.com>
>> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> 
> Reported what? You should add this tag only if patch addresses reported
> problem. This patch doesn't address anything, hence the tag is
> inappropriate, you should remove it.

Okay, smatch warning was reported on v4 of this patch which is fixed in
v5. Then I understand that we don't need to add Reported-by if we fix
bug in subsequent versions, right?
