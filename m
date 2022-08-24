Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED1EA5A02DB
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 22:36:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240380AbiHXUgQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 16:36:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230351AbiHXUgO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 16:36:14 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 640377199D
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 13:36:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TNspW9POyDm3VVv6z8tegwrNarS+dM5+mKKNx5NlxLKooce5qg+zC2p9vVnFP+xP8haostQuVkqkhqTjF/ABSCKoEA9lCcoIm7EDpbQ6COtikXQ3OennZMAaVVAwKXex/gucdqsnX7QTJZ/xngu80np8HlcPQagls/Bt/Z89us0CduQyGozUxASvGivDhWurejlnY/yGI9NJBplEUwBQQAgLcblnSq56RROBbnFPgqVjxN+uDUTfeT6y3W+sPni7yQDNip+j/SXye+SUgYDczXHDIX7b6f8B8kvT31GkqQlfgQP1xox/xaVBnV6ASE5G0fwEfGe6oOspjGiKKVfHww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/owNmNCKkVKy++j2LCbimRLVCUPzDrIHzzF1FxDnmmw=;
 b=TbY+IQgezl1LVj6+b2knBNBScF3uKfGiRiH3d+I3Kkt6XfDep9XFrm9StTLutxWO5Gj1y2nUGeA17jDZhCWtPC3cmzWvcEKbK9xqhvz0SlewPMviIVc/l+n0h4CdVeN9hwZuZL262KtKnv8SVBjuKtEnLqxDDeLbNiCbNRDY4fUAlKCcQ8gbae3xISUWgjQ2H4r4AqCV16C5LBJ/bJxu+b5eGJ68AhT3uIOSXvRJAzT4cdRziLt2kwmEyILJZRGY5sx34YT+rxE+x0Trc0I23u8v5Y1DkbXZ06iUpGNI2PhDKxwnlTvKIuRLerf3lSszmtUR62Opi7dhsqU+YZfpYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/owNmNCKkVKy++j2LCbimRLVCUPzDrIHzzF1FxDnmmw=;
 b=2lr8e3p7erHec9i0SD9LZ2GWuF3+ORH/nxjFK5n1LZbhafDTxhvfu6c41cq2qroOo/S/tmsy+4xXpPqxQp2mB+NcpKuN0SC0DRzoUOZOk9ogvaQw5C7TVQshs62o1IDwyjSUNcZsDvWe18yrU0ch0QMeLLy4uOVybh7rxjrpsgs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by DM4PR12MB6302.namprd12.prod.outlook.com (2603:10b6:8:a4::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15; Wed, 24 Aug
 2022 20:36:10 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::406d:afb5:d2d7:8115]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::406d:afb5:d2d7:8115%6]) with mapi id 15.20.5546.022; Wed, 24 Aug 2022
 20:36:10 +0000
Message-ID: <6f0e6f03-4b9d-db84-6465-e810ea849731@amd.com>
Date:   Wed, 24 Aug 2022 16:36:08 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: Selecting CPUs for queuing work on
Content-Language: en-US
To:     Hillf Danton <hdanton@sina.com>
Cc:     Tejun Heo <tj@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Dave Airlie <airlied@gmail.com>
References: <20220824113315.2375-1-hdanton@sina.com>
From:   Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <20220824113315.2375-1-hdanton@sina.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BL1P222CA0009.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:208:2c7::14) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 720d37fe-00cc-4991-29ba-08da8610472d
X-MS-TrafficTypeDiagnostic: DM4PR12MB6302:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 32E9QXRLlk2zzIaW8y4yhzRTj8eAgY1Twam46s3PVhuEuj21CQahJdW9NpJq7ioZ3nJ+4Bp4a7ehso6n8S9wZofH4SFR98REAi3rMumdVzeUEBlhyGcAVMfabo+MF6Q106sdsLDXNJNtxwGdlGYxlKbni8S3xVB0J/nxxXCmGwltorDSHDGx5VDc98OITSz0zWc+LXWKP7xQ6uVv0HEZQAll8El0kL/oV+twt7wBJylSZTgGhC2ud86CttcSAQ/2yr6p0+37HxTfHgzVFlXmdh0qZc0ZYs8awYDedw1IbldOKmF+H0HicUnkFeXCShRix2LijELDta8mwcWMPA/dP6rSqbxjZM7g+XsEiZORG1OwVyHrFoxy9w64VG3VozAUCP1LOtuDhPc6B/HgAClZBzrKTZR1cSW+BjmaQJi3dOD3Lyzb03bEjwhFCces1ouy2uhlRLuG1Uny3OCU8lqWKoVuripTvPC80vJcCLHulBgxVm+bO4EWe6J0VsMhNsm4x/IfybM+WE2dbZKufqFmmrCaBxLRUsY8czaQ3J9CANnv2A6+Dk/34QUmk5te/W+6nTlVI7h13d4FgIQaMT/jlga51S+pdvQWFNRzRMkvzYm9CQ/wQq5dwbK0gS0WACxkHSNJgo/Fm5Ec9Xoa2/GNkOXoVxTuFtFjdAHLyQwJZyeOzEFbGCu+bmv5BNIbhiplEc9YqglBt2IVM1iHfA4Yg5+tpeofe7mS+x0ldQNZa+NmVsMDwisRZRh9bnFVizeZ7O3e6eIMuMdLYYMMEcaGmAmc1sZ/t7bfPDrudBrvID7jQBmVbxbuoT67jlyGgwATWs9mEubZ2Oq09V0WVWhU1Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR12MB5115.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(346002)(136003)(366004)(376002)(39860400002)(36916002)(44832011)(83380400001)(478600001)(41300700001)(53546011)(6512007)(26005)(6506007)(2906002)(6486002)(966005)(186003)(2616005)(8936002)(86362001)(31696002)(5660300002)(38100700002)(66556008)(6916009)(316002)(54906003)(36756003)(8676002)(66476007)(4326008)(31686004)(66946007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UDRZcjlsYjNoejhQNU9SL0FkdjhMSlVjckExVCs3U05yVVhlamhPWkxkeDlQ?=
 =?utf-8?B?b0tNS1dULzhqbTlPN1lYT3BtS0ovUEFxdElvMCtCcS9UYUxXZk9EMDU5MTBP?=
 =?utf-8?B?ZlNqdi8zNERCc0c4cjBzOEhpZnd3SXhlblZkT2VSSFZxd25lTzZhTWhrS3hq?=
 =?utf-8?B?STNmYlJ5VGJISjJFQkgySUFjYVFHNDNZWFAzMVpDOVZhZlFlaFVMdVRTWEpQ?=
 =?utf-8?B?OVhKWlo0UXZqc1BSM0c0ditLOGtIZVpBNlVCNGsrWGhxY2QrekNmb1MyUGJY?=
 =?utf-8?B?MFVKbjh6MkVlQmJ2RmdJMGFVNEl3WmlOWHNoeisvdk5OYi9Ud0VUN0ljUG9y?=
 =?utf-8?B?YXRtbXdWSEcrWWxsc2k4YUJyVEEwcEphZUJuWERNdU1hWU9aT085ekhPLzFD?=
 =?utf-8?B?US8wdEpsRFgwa2RkN2wxa3ZmSnc4dDllRjdvQkJNUnlCOTJ4dG81L2JLVVpV?=
 =?utf-8?B?SkhiUVUraVFhcURMNzZ2ckozZXhveHlIRytFcUd1YXFrRDczVkE0SWp3K3Yz?=
 =?utf-8?B?NVNCTERydmM3RVRLVDNiK3M3Q04rUGhUNFpGZTh0VFV0VlJwTVFKckd5Si9m?=
 =?utf-8?B?OW43c0VqWnJQNERkU2l3UWhhUGNtM3EzdGwyRXV2YzVXN045dTNnSkx5bTM1?=
 =?utf-8?B?SmZSUTlVeGgzWHJ6a1ZpSlVLMTdiSGR5ZGhqaTRLMTlvRXQ0S1BZbmJTZStZ?=
 =?utf-8?B?aW04RTUrYXFieVFRbHZBcE42WWltQkN4aGU4TWJHdC9rTWxNTkI1YVEzUjJB?=
 =?utf-8?B?eldoR1RVQitsQURqYmpwVndtRGh3SDJBSFo0QjBBRkh6bWlUblh2VmpxS2x4?=
 =?utf-8?B?UGlKWE1LVVNXY2g0L05MU3BLU2poN0V5clZhZ09BaWQzc21xQk0rNGtQdVRq?=
 =?utf-8?B?ZS9RWXNVcjMzeG0yTEtlTUFsTDJ5VVlveEo4Y1RBN2o1TFkvRWE0RjdZWEpn?=
 =?utf-8?B?MXo0TVV6SmdSQlo5SFJUMGRPeGNlTDQ2UEVUSjVITE5CTmtFUXU0d0VHcFli?=
 =?utf-8?B?RlJ3Q1YzN1FSU1pMZHpRMjJEQ0JaZ05PTUJlblZzT1NzMGFNUGloMjduUzVF?=
 =?utf-8?B?L2FycVQ3UG9TdW1FdXF3d05qUldLeHM5c0lzelNEMk1QTDZOdXRBL3I3QkFi?=
 =?utf-8?B?c2V5dkw0c0xYcmRIS2FQVDY0Vk5MeVllbm9wWWVlNldHUUVyZUJpNklEWjNi?=
 =?utf-8?B?UVZuZy9sdzJON0dVWGxGd2F1MHFhdnpnZmRxZFE2bmRScENpeGFFUTJ1S2J3?=
 =?utf-8?B?VUxJMUcwQXN0dWsrWUM3ZDBWUjRCdURDZzIweCt1ZHd0OTFQb2NnK3llTW56?=
 =?utf-8?B?NlZ6Y1ZYbGVqd014Vmo4ZDlCNUl1ejZnRUEza2FLSEtvY0ZZWkgraEQ5MjlM?=
 =?utf-8?B?bjJwWGtLRUZ6L3FoWEY0RGx3UXlRZHFrQWp3UkNBOWNaNVMzRUl1eGc5c01m?=
 =?utf-8?B?U2E4NXBKaWV3SGJBN1h5SnJsYVFJUGxqV3FSTDYyOUgzak9GUGp6akcxZThp?=
 =?utf-8?B?ODU1V3cwaUVoc3FvUURvYmF4OHZRN05ab3phbUl6Qy9xMzkwOGFpT29BV2lS?=
 =?utf-8?B?UnBMUmUwcWZ3WHdkdGMvOE9tMGVOOGtpU3EzUE1TOXl5YnpHcmxIUXJTTE9s?=
 =?utf-8?B?NmZjZzh1c3EvSnorRFJHNmp6N0RKbUlwcXcxQTNacExpZVk4TW9oZG5Kb1Nh?=
 =?utf-8?B?MHZiUEMxd1FES2ZUOW1qQUw3Z0hUZzY5SUp2VXlvYUhvUFc5TzM2OWg2Szh4?=
 =?utf-8?B?MFAxTFZxL0ViU1c4UEkvK3hIdlFiRHRuTm5wbVdTeE1uMXBTMW04djBTT3dI?=
 =?utf-8?B?b1g2THFoTW4rYTVZNjE0WU5WTkJNdHl2cEc4RzVNS3Z6NTZwdk0zSUZqTkN5?=
 =?utf-8?B?ZXBnbEJVUEdyTFNwODRsVDBwRHZGdDR3WFMrNm9WUXlabmJiRzN6RUVYajRJ?=
 =?utf-8?B?WGU1WERoYUFLRzJVNTdjNGFXcDBtMis1KzBLeFdwM1BNWjVmbkJDS1Uwd0Jo?=
 =?utf-8?B?TjdMNUtCOFovbE5MK0dpUU5OUnptT2dEWmlOSHNUTmV6clU2Uk9IbFFLK1p0?=
 =?utf-8?B?cFJndHNRbEZHaGNRYllJeTNoYWp0S2Fod0FrSEtoRm1CNDR5c3ZOeGpMZDg5?=
 =?utf-8?Q?imjP0OVSQSUn9O7NK78I738m6?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 720d37fe-00cc-4991-29ba-08da8610472d
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2022 20:36:09.9649
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zKKUdx9g7/iXRUBaLkTCuRs/6nFMjUz1yTxPig/94PXxbcaRW2hPPI3Q0wOuUI9Sgnfmd+MmTPurMfvFuKxJKg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6302
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-08-24 07:33, Hillf Danton wrote:
> On Fri, 12 Aug 2022 16:54:04 -0400 Felix Kuehling wrote:
>> On 2022-08-12 16:30, Tejun Heo wrote:
>>> On Fri, Aug 12, 2022 at 04:26:47PM -0400, Felix Kuehling wrote:
>>>> Hi workqueue maintainers,
>>>>
>>>> In the KFD (amdgpu) driver we found a need to schedule bottom half interrupt
>>>> handlers on CPU cores different from the one where the top-half interrupt
>>>> handler runs to avoid the interrupt handler stalling the bottom half in
>>>> extreme scenarios. See my latest patch that tries to use a different
>>>> hyperthread on the same CPU core, or falls back to a different core in the
>>>> same NUMA node if that fails:
>>>> https://lore.kernel.org/all/20220811190433.1213179-1-Felix.Kuehling@amd.com/
>>>>
>>>> Dave pointed out that the driver may not be the best place to implement such
>>>> logic and suggested that we should have an abstraction, maybe in the
>>>> workqueue code. Do you feel this is something that could or should be
>>>> provided by the core workqueue code? Or maybe some other place?
>>> I'm not necessarily against it. I guess it can be a flag on an unbound wq.
>>> Do the interrupts move across different CPUs tho? ie. why does this need to
>>> be a dynamic decision?
>> In principle, I think IRQ routing to CPUs can change dynamically with
>> irqbalance.
>>
>> If this were a flag, would there be a way to ensure all work queued to
>> the same workqueue from the same CPU, or maybe all work associated with
>> a work_struct always goes to the same CPU? One of the reasons for my
>> latest patch was to get more predictable scheduling of the work to cores
>> that are specifically reserved for interrupt handling by the system
>> admin. This minimizes CPU scheduling noise that can compound to cause
>> real performance issues in large scale distributed applications.
>>
>> What we need is kind of the opposite of WQ_UNBOUND. As I understand it,
>> WQ_UNBOUND can schedule anywhere to maximize concurrency. What we need
>> is to schedule to very specific, predictable CPUs. We only have one work
>> item per GPU that processes all the interrupts in order, so we don't
>> need the concurrency of WQ_UNBOUND.
> Given irq dynamically routed to CPUs, any test results showing that unbound
> WQ is a bad option?

If we're using an unbound WQ, we'd need some control over which CPUs 
will execute the bottom half. The customer wants to minimize noise, so 
they want all the interrupt processing on dedicated CPU cores that are 
not used for application threads. I read a little more about interrupt 
scheduling. I see that there is a CPU mask for housekeeping tasks. I 
haven't found where that is configured yet. But maybe an unbound WQ 
using a housekeeping_cpumask would do the trick.

The problem is that it's very hard to get test results. It takes very 
large application runs to see the impact of scheduling bottom halves on 
different cores. And the customer like to reboot their cluster with 
1000s of nodes. For now they may have found another cause for the noise, 
and addressing that may be good enough. If our current solution for 
scheduling the bottom half turns out to be good enough, they will have 
even less interest in investigating this further.

I should know in a week or two, whether I'll pursue this further, or 
drop it.

Regards,
   Felix


