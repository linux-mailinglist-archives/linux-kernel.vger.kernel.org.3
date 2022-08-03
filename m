Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDAF45893E4
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 23:03:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238797AbiHCVDp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 17:03:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236280AbiHCVDn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 17:03:43 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2071.outbound.protection.outlook.com [40.107.223.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D2925C970
        for <linux-kernel@vger.kernel.org>; Wed,  3 Aug 2022 14:03:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i6yWaiSwZYs/DidEJEGTjkmpNiDEvS3Zsy+fyLO0allxPTBw0ZSi+AmbW+Whjn7hKuJfOTkoFDgH3cS0SEIHavjAd5BapplnJF72FesvSbTQHYIQWYp1yrZGuzUZhyiG48tx+aIkBlBFHSz+p9jl3WrsOX7i4b1g2knlk1YV984QHKuh76L33EWRFt533Yp9CdG2afErjZXxkUzoB40kFCFjiZb8hRUn5vd1qCh9E0KCMv1/FZKSjTbFBHI4C5+8Jk1Je6rEf/BYAwpCqX8pk6j5kB2zkM8UXLKloU9hqnfVlPEFAg4oZ6zwSGB/iC8uTUX8b6RX9nL2KDRD7movOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BqdfyEq1ak1O4RW3eyqDgSxMAz7IaHeijbnLVlh3EFI=;
 b=bdUCLgkOhMJBezLa/A8hDAc7SquchVRJqjwn+y8d0C59x2ijPcG5tGD68APA2sOT91j+zsOLqrcpUuu/Xq0/aMghr6bFaqc/sy4TanqLJFY5O7stpV95INB5t+h1VPUE8EHA7vOEG9JlthCgN2XbXhYx1PgK2Vc3guZS2iLCDmVS4bvCMPo6Q3ZDkqlne63nbGh2obae+ccfkvJOgl3GSd2HDSmnbc+Y0Iq+/ZfgMngXP5c8lj6Vxk0HWpxgQCw4iTU6Fz2puTz+7ERDz0v4ePzodWzVQ6Dofm+RfHhK6qfsgw0gswX7tFz7ljYHhsGTdwpqhkZRqWXWzxAQ6Cs2ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BqdfyEq1ak1O4RW3eyqDgSxMAz7IaHeijbnLVlh3EFI=;
 b=1jZIMwK3uFPScQeEifeJk8quSTvfPe0dD4BmwDfdSjEDyZz8Yk3aFT1U4lVPJfv5ozOwFkaUtsPB6OKJnI+HQxrPh7tREqXNuNsDcer/hpfeFyv3hkDVkkLemNdRkdB4PVbV/+jfs7eWPX1Srliv7dmSR8Ae8aVapP346+qLjm0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5229.namprd12.prod.outlook.com (2603:10b6:5:398::12)
 by SJ0PR12MB6736.namprd12.prod.outlook.com (2603:10b6:a03:47a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.14; Wed, 3 Aug
 2022 21:03:39 +0000
Received: from DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::1dac:1301:78a3:c0d0]) by DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::1dac:1301:78a3:c0d0%4]) with mapi id 15.20.5482.016; Wed, 3 Aug 2022
 21:03:39 +0000
Message-ID: <0eccea46-648d-ff70-dcc6-fdca88ff1234@amd.com>
Date:   Wed, 3 Aug 2022 16:03:35 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v1.1 1/2] x86/sev: Use per-CPU PSC structure in prep for
 unaccepted memory support
Content-Language: en-US
To:     Dave Hansen <dave.hansen@intel.com>, linux-kernel@vger.kernel.org,
        x86@kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Michael Roth <michael.roth@amd.com>,
        Joerg Roedel <jroedel@suse.de>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
References: <1b50311c-448b-96aa-1d96-f4bfed409c1f@amd.com>
 <cover.1659550264.git.thomas.lendacky@amd.com>
 <2a2adc3570ae9c24d03fff877c4fe79ed43605e0.1659550264.git.thomas.lendacky@amd.com>
 <d5902382-70f4-be07-99f6-80d17cdfdcaa@intel.com>
 <9f47ed0f-99cc-a237-f09b-45291feffcd3@amd.com>
 <e52341be-076e-92d1-a649-421dac5a4f5d@intel.com>
From:   Tom Lendacky <thomas.lendacky@amd.com>
In-Reply-To: <e52341be-076e-92d1-a649-421dac5a4f5d@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BL0PR05CA0003.namprd05.prod.outlook.com
 (2603:10b6:208:91::13) To DM4PR12MB5229.namprd12.prod.outlook.com
 (2603:10b6:5:398::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5d04896b-62ca-46c0-a527-08da7593a367
X-MS-TrafficTypeDiagnostic: SJ0PR12MB6736:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nHhS1WWRkxRjTFc1fzK44fpqp37mLO7e+1r92XAmVl0tLQzu+7gOo8JeP/4Yg+HaD4TJc7VFnZb49KA54hYnZaC828aE+yd6ZXJcwjt+ZcdkTcyZtiHXQZrbCKiqoak0cs1fVPGVr5tdAapx33EamZWJ4OEp3ptrgjHt1JUHrMBoctUtJgjdw+vi2tAMKoN1PlOmU4CLsF0nur+xYApPQ2GjV4xvp7Z/NxRbTZPxhiCY5paenTfsAgpbB7EJcb6EhdQaWnLZr2SUMXlLjdDiIQqsn+8VUke3brx2NJsKuAywvUkYiTHf4DSw3oeWGNAUPCxiv0ofX2YbO7gdM5gX1YOd+Fptrc17OJATNLuv3yHmYTsEo9c3ppnEPUfyeCaLj5sqZfmo5Lqn1VN5DzWPgzKSvZJbCP550eMXACbx2/YJNbCorYf84aF02nZAeYxFyb+MCb6JFU5EQ6+Q39ndKUJcBGcjCTaA0ODdl7GsAMhE4nzejC7HQCmlpYyQbFsBJY0OLY7npu34mLkvPRoAscJkVhWlBcrExGaNTJIh+Ms3Ae+m6BhZ+rnP6pdRJ+ps7qRTjEEU754jEUb6lrS0cDNNRA+s1DYz70ziLjmWGvUQSJPxagv3OuFoQkuSEcgTykRCWAGXf8XUjE2ZrJOeKchB5PJLpXsKdUkdiw4AZiXDl8W20RMUlEeZkC2qq8Pjjfrw4pmgO8MIj+4PH8mLC4L18IO9FECofw1Y9YMzgm2kPyGWmqoLrpTCjy91QGe6Z1NqRsnjoZmYMJeqz7ME7LkxpfhtBs3S/Bl8hA2ZYk0jJt+RK3JBJP6Z0RIc1uzqZxWvfz01TAmK58M+J83RLw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5229.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(376002)(366004)(346002)(136003)(39860400002)(6506007)(316002)(8936002)(4744005)(36756003)(31686004)(4326008)(478600001)(8676002)(5660300002)(54906003)(6486002)(66556008)(66476007)(66946007)(7416002)(2616005)(26005)(6666004)(6512007)(186003)(41300700001)(2906002)(53546011)(83380400001)(38100700002)(31696002)(86362001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QkxtNUpLM3d6T3BBU1k4Vm0xMW1ZVlVENTJuMmhkMmRHS3V6c0x2emJmR1NR?=
 =?utf-8?B?UTdOVDYvVGZBb2RhdnRMSjlYRUtCU0lwa040WVBtRUc0UHQzZGQ2UHBad2F4?=
 =?utf-8?B?K3Q5djBHblRic2trd3ljOElwT2JoNFp5Zjc5R01kcTdkR1JNdjUvcHQ0SURH?=
 =?utf-8?B?UTNnN25DT0hwTjdtaThFclhKWUVFSkR2NnNDSjhaVDBqM3pWb1VnNWVncE04?=
 =?utf-8?B?ZFlodEUzOUh4QVhySGpFMnVUSjVxdWV5UlNWd1FUMytBYm9jRGorNHhhMFND?=
 =?utf-8?B?eTRaY0dsRUFDK0dUREY5ZUhqWWRReE1GTjV0blJjeEs0bXIwd2JCYVZyV2sw?=
 =?utf-8?B?dWtER2dDK1dsc1o2cVE3MXV3VzIwQ2xCWlMvSVlXRk03Uk1mUW5COEt5VERC?=
 =?utf-8?B?OWxsZ05sQnhuVG02RmtUSUJNL2RLZ3dHR09VeXAwdGdjMkh5QWp5VmV4V2lE?=
 =?utf-8?B?QmdoZmVQM1dxUVhVcHZ1UlgxSytLNWwzMUFGUldzeDVrdVR3VE5vME4rVmRi?=
 =?utf-8?B?M053MUZsMzBvelM5Tm5UNGk5TW1WNC9VWi9OTG1YUlViVnNXNnlmVitGWmdM?=
 =?utf-8?B?blJiaFN1WDB4cWROdU5LcHl6TnltcnNxVGtJQXczdExlZW4vZFdudEthSWNv?=
 =?utf-8?B?RExDanBsNm13bHlSOTk5VkRMWHE0ejBHeXhzUnhoTEVTd1BnWGI0SkRSYUU2?=
 =?utf-8?B?Wm5sTnE3RE9maXcrU3VuK2duRlBTdlp4c2Z1TDhxUjRzbjk5blhNNlF0bW1S?=
 =?utf-8?B?WUtFcUZhZWxTV0NOYjEvOTJqOVJkWUVKTUpFOGxXSG9keTYrVjlURzYyZm90?=
 =?utf-8?B?b3BnWnIrNWNXUVV0R3BKUDJOQlZjWWRwRjlVdmtYT2QvSFFRank1SWlKWHNu?=
 =?utf-8?B?QnFwV2VGWEJNajBsT0owU2pwVnFrOXZ0eXZKcnRHd2FFS0hnUU5IWUtnWlc5?=
 =?utf-8?B?WlNGWklHT1o3N2M0enRkeWxPdHJQRWx2aGJLeUQ0ZTdVNnhnKzhIRXZQM3Bm?=
 =?utf-8?B?TzFsclZLRXFyaFJid2ovcGVybTVDVXowTExzSE1Ka2FZRlYwYU9iWWNGYXZ0?=
 =?utf-8?B?b2JHQlpocGtxMVRUTWFPTE5SSldxZGgyd0o5SlJudzBoejRxTE1uTzhRU2lO?=
 =?utf-8?B?SnNua0N2WTVmWTJOdHdTZjJJWFNlaFhTdUNHaW9qMGhHOEhYUXdPRG52UlVm?=
 =?utf-8?B?MVJ2a3Ara3BYMVE2allPM2kyNExIcVVOSXdoWGVrdFVNQmRpS0lqTndlOWJu?=
 =?utf-8?B?ZGRyZVNYVFUyNEo4cGQzaXkwSGU2TERMZlMxRDVhNFExTS9tR3l3TVFnOE1K?=
 =?utf-8?B?V2Mybmp0ZlBueVhrL0FuNmg3Q3NOdDdRSkJENW9TNFltbk9sRk5GS09FWDFD?=
 =?utf-8?B?WTNZRkJiNDVaNlc2Z0F6dVlEUUJyRHA3RTFiY09DZXFtYlQ0TkxpL0pGK29S?=
 =?utf-8?B?VFIxbkIyd3FyWFBRWnF4eHZkbHpHVkltdFNFNEF3SFAwNTFCOFlsajJkaHQ4?=
 =?utf-8?B?TjBuV0hxNUZHU0w0OUJ4Ly95MzN0TEUyYjROSFdXcStCQ2UzYVRPU0ZSQ09v?=
 =?utf-8?B?Y0RpSE9JRUJweDhBbmNKSHo3TFQwUEorNjhkWmlFbGRSa2ljM2t3ZjZWZUxy?=
 =?utf-8?B?d3g4VkJKYk93SVl4eVFJOWtZcmZ2Wk9kWWlwdmpMdmNGbUhLekdrQmtCYnRa?=
 =?utf-8?B?R2dxTFdUQmErSHZQZ1ZDMjRKNkRwUnBNNjUwejBKMUdVWUFZQk9hcmgvR3Y3?=
 =?utf-8?B?eXJIT0Z0NWNiMEFNa0xwTkEyNm1wWi9UeStpUCt5cGNMUnBiZC9GaisydzlX?=
 =?utf-8?B?M0dMc0dVUWNYWHYwY2V2VUNPRmc5cCtPUHFKTEp4OTdqWkFCb1phdy9VNUNO?=
 =?utf-8?B?blhZR0t6RWZyNUk5QVFmZzlBcnFKc0tmc3VwdVc3c1EreUIzNHdYVFdFaG1G?=
 =?utf-8?B?NmRmSzZSNTNDSDRxNXdkY1U0a2VNMUord3VFQ01RQjdpTnlObko1NnptOVB4?=
 =?utf-8?B?LzhHRDg4a1FKRUZNbnErSFZjcTNoWUpvUjZQdXNQSEZvaTBzdHNOYUFBMnZK?=
 =?utf-8?B?M1BMSWRwVzZIR1pEUFNqZjl4REg3emh1MndCekhncTA1OVBuMStPUVEwZ01K?=
 =?utf-8?Q?V6AfIsX3zCzWjkzxGXBuH5+XH?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d04896b-62ca-46c0-a527-08da7593a367
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5229.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2022 21:03:39.0342
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CgblsJKJ1NRtjGy4v2T5NhyGbpI+1l12MS6v4SRsnY7RmDk2gltvaW692CAJ2g4XNeIOAUT0H8t4pc6tyHNxQQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6736
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/3/22 13:24, Dave Hansen wrote:
> On 8/3/22 11:21, Tom Lendacky wrote:
>>> Would it be simpler to just do a spin_trylock_irqsave()?  You fall back
>>> to early_set_pages_state() whenever you can't acquire the lock.
>>
>> I was looking at that and can definitely go that route if this approach
>> is preferred.
> 
> I prefer it for sure.
> 
> This whole iteration does look good to me versus the per-cpu version, so
> I say go ahead with doing this for v2 once you wait a bit for any more
> feedback.

I'm still concerned about the whole spinlock and performance. What if I 
reduce the number of entries in the PSC structure to, say, 64, which 
reduces the size of the struct to 520 bytes. Any issue if that is put on 
the stack, instead? It definitely makes things less complicated and feels 
like a good compromise on the size vs the number of PSC VMGEXIT requests.

Thanks,
Tom
