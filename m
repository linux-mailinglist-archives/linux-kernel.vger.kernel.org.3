Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 504FF57B9A3
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 17:31:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233790AbiGTPas (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 11:30:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232107AbiGTPao (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 11:30:44 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2066.outbound.protection.outlook.com [40.107.223.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 975011ADBF;
        Wed, 20 Jul 2022 08:30:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RSRVtx2y8ei5m0hbDbyP4KH/9Xc1yumIG3q0hLLup0sPsbjB2d+ZR3Cn4c+7P5aF4kw6u6NMmvnKn3R/6FaSypKqNyBUqlRhAI6RDZ0v6tiiie77+pERAj5huKbnF39JxNGMG8Fkt5krtjt6zeYJakbwqE4aDNxAnmJaoVFrVbCqFND/VVQyvzOCmaMmgMo9IfFYXpVTS4zzjuiHNlQRq9CtmN8/u/0Y4ap4i/YSF8jxGEC58/3QgtKHvRGfMMTk8UL1oXHsi8EkXWm7PtZ4Hvtokq1lJVnOZMDLirLXaPM/WLMlictb7awo9J1MRHUTGN+DJLzanQ4/6De1e77URQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mtW06uQZxmjeK0QiqnP6F++t5e3pWQjfiNtJMev0oQE=;
 b=StqBPefrOtnCWvWBzxmb3TRyW10ruk4qMS0xQ7FoQFi8fXCik7Vz4Qt4vwAw2Al91pyVuFg/QoedMuWtyluOuO8p07ZjxS5IPW4YsTYyDIeIVEWwgit+Vs/Pri8esWS/7mYzWcHBq1f5q8UZLItaGBZ/qN0l9JSS+IIHGaO2vd8trXrG/EX+/249HT5d+FWwk96OgOs0eb3y0RES4ws0YEZkQ3mAWazIDVSko4neX3OxnAiXdu1J7j34bT0UtWTqv4qDkLNGkf4390QkmPEHrqwj/p3u5Dcm0Dif3E1sBnpIxLDzKRr6h4LQbTgBFsWWZKsjMq7z9nkUq2ijh1aopg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mtW06uQZxmjeK0QiqnP6F++t5e3pWQjfiNtJMev0oQE=;
 b=YEtHiX85zR/tTOsPg9IqdvsOBZmvl0ROsQpTO+WK09OCuLHOdHAJ9xGn7AIpJzYAMVkit+ZfNheZuVuVUdwNQNhWxZFuNaHWjbWmbyE1DEm4yGJkSCvh2WnVbHuQlvhh7PGRXEUrMVlP5PMZ4G5fufcN8FYNvwR2oGcl3jS2sfE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by DM5PR12MB2485.namprd12.prod.outlook.com (2603:10b6:4:bb::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.20; Wed, 20 Jul
 2022 15:30:40 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::1143:10a5:987a:7598]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::1143:10a5:987a:7598%6]) with mapi id 15.20.5438.023; Wed, 20 Jul 2022
 15:30:40 +0000
Message-ID: <d4e2678b-d515-f580-3644-e03979390914@amd.com>
Date:   Wed, 20 Jul 2022 10:30:38 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v3 RESEND 0/6] Add support for upcoming chips to k10temp
 and amd_nb
Content-Language: en-US
To:     Guenter Roeck <linux@roeck-us.net>, Borislav Petkov <bp@alien8.de>
Cc:     Clemens Ladisch <clemens@ladisch.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, dave.hansen@linux.intel.com,
        linux-hwmon@vger.kernel.org, babu.moger@amd.com,
        yazen.ghannam@amd.com, linux-kernel@vger.kernel.org, x86@kernel.org
References: <20220719195256.1516-1-mario.limonciello@amd.com>
 <YtgVDEQnZpjnIG0k@zn.tnic>
 <56edd097-df41-b84b-3688-f1bcabda5046@roeck-us.net>
From:   "Limonciello, Mario" <mario.limonciello@amd.com>
In-Reply-To: <56edd097-df41-b84b-3688-f1bcabda5046@roeck-us.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH2PR15CA0014.namprd15.prod.outlook.com
 (2603:10b6:610:51::24) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 01a246dc-a327-4233-c51e-08da6a64cd93
X-MS-TrafficTypeDiagnostic: DM5PR12MB2485:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SXGILnacpo/hqHIumfdh9tEBbjpJQ4oOvxl/NNVsm9dugZxjLejWv9Kr4Hme5CRhSefImVMT+iTzO5UHtRTFcsVuC/gTlT4DrvwnXmM5D/+o0ukZrlsaDKaVEPKElWwF2mIV+8Git2DVkfpnJwgMtNpK2bheFhEVRTAyOlimwAoYHI7cgXmR9axiYsjCByKW/D/K81pbq1JIVD9H0yPDVJMHiUuX4lC63uhienbg7KphR6FYgkYDOTiYjLqJ22KXKxSsRTZQocBrCbe6v3+NbhHwJROM8HH0q2eaSly5uXVjxOVcMT/7TdEYp2qPLE4j1HA7jPCKmZekMXhENXblvSeOLFHFrOXQcPkYyG+MGFXaI2fps0Wds8yO60DkvfZs5nfFfg4SvVz0zAFOc1ANqegfixT3Iz6HeQL4mgD/+7eBvcNwhUie5TqGCEocSxY1vLANh3yW0ITz4PAKKmM4EJk9aUDYaN4q/Bpt7dOC111cOUUTTpi4LuySo966oykPlgJthftIRDBc+bH71kRaiU7zgFZRumm6/C7WTFRxF0qvSBNNIAOAyWaAE78E4OsR7MeCix6rtf4U5JeWTyFavnSeh/VZ0r3nGXBggQrmo8sKoqK4JRV9Ziu3iPVgduNJfWdVj0BjjE24rga9C1O2zUQBfkn07yYOGATTnzx6Wbco+MGUujLRhqgUAWG+JkdZlWhBrOXNlVqXAq/nNEIhnBqa/xDAabIVKvbIcHDSPh6HXzGDzDAtGMNIyG89XwaDitkKys+lB+BcJyBLQNOHnh1WJFkt3lKHLkIesTR8miqiMstbLgNRskhOiNqsN81M319z+B9Bs0vKV/W91iRcsGkbmj0+1bSfT8xnozxIisdy32PFSicc+0TAakJmZb7t
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(136003)(366004)(346002)(39860400002)(376002)(4326008)(66946007)(8936002)(316002)(5660300002)(54906003)(2906002)(66476007)(66556008)(83380400001)(8676002)(36756003)(31686004)(31696002)(6512007)(86362001)(110136005)(41300700001)(6506007)(966005)(53546011)(2616005)(186003)(26005)(45080400002)(478600001)(6486002)(38100700002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TW05RGxGMmZJOThTUjNaZ3BoMGhEWktHdGJZL0Q5ekVXN1FhQTA0OHV0cnZv?=
 =?utf-8?B?VHhxRUlYRHNQdmEzWmp0NWVHeG0rS1JWTk52eFVXRmUvQVFOZ0EvaEJTNk02?=
 =?utf-8?B?ZnVLcSthekFtY21hL0lXU0xuSityK2tVcVhtVndWd1BlSUtUcjZMWmhhTzI5?=
 =?utf-8?B?Z3VuTFZOcUtWbjg5L3pRRmlTMUtSaTN1UXlwbUVXcXcraWlGbGlBa3ZkSTRU?=
 =?utf-8?B?ODZlY3pMVlQyWDE5dHpTMXBXcDRRcDM1U3ZZMDlFemJQcFhBT0cwQkR2WXZT?=
 =?utf-8?B?d1VFMGE1LzE2aEtpTituMVFubllJMElZNXhzdFpYdE02UkRZZzR4WkhUVnpS?=
 =?utf-8?B?MnVXWmJUb21menpSNmdSc1dTTGR6UE84dUF0Y050ajNMVlFybHRGZm1hbGN5?=
 =?utf-8?B?RERaL0FKTGpmL0J0aytRNUs5V1lVZkw3YVZiQUdpVWtFdTlNVUZzMFhCR1ox?=
 =?utf-8?B?ZDJ2dm9KVGdacXlhTXJwc0UzWHg3L0wySlZveDc2RXM3L2txOUpyV0JkUEZv?=
 =?utf-8?B?VWhWVXdZNm9YKzl6aUM0UHY4U1RERzdjSFRES21XblZkK00zSlVVVlpuUGpw?=
 =?utf-8?B?ZlJhclpEWHYxeDAvejBhS0R4ZUtoeWYrR1VFNU0zdndvY1hoYURSa3NydUNs?=
 =?utf-8?B?bnFrK1h3dHAzVUZzOFcwU2ppbm5KenRZbEJKSEc5TFluZDFqMkFuRTdkS2Zs?=
 =?utf-8?B?MzlrYmIrd05naHdSRjNaZHYvSUFyR214ZUdnQWpONERCTjR5UjB5NW1sR2pY?=
 =?utf-8?B?VDZFM28vMUNuOWZ4eGc3amVwYmd6Um5HeUd0Mm9tdWd6TlNUb3NVUGUrYzNH?=
 =?utf-8?B?M0dEZm1pMzlIVzlramlzUG5SNnYxd3dMNGtVblQwNUZlUURSY2M4eEk2TGRH?=
 =?utf-8?B?UWwycC9yZmhzU3hnbTEyZ0ZFcURLZ3JnRG9Fd04vblZjUmpOdE5vMDZRNFF6?=
 =?utf-8?B?ZnNXYURVYjgxSVd0Wkl5a0R1Y2ZUMkwyR2J0dGo0U2J0c0k4RDl1UDU3M1FB?=
 =?utf-8?B?NTJIb2ZzQ3RRVU1SK25UaU1QUzA5SWNwa0tvK3htK3V3OU1MaXZ5UFQvQXFW?=
 =?utf-8?B?dXRENDN3MGpHZHYvKytJeDRDbUJvUHhhaVNpQlVVWDhXb002SjBRUFp5M3Vh?=
 =?utf-8?B?S1hCSWhmc2xpZ0hhdmhhWDF1bFdkVy9nYkEyRUlQRnRROEdwMDBQOVZtc0h1?=
 =?utf-8?B?eTRkSW96RjgxdEh1Q091Vi9XU2VBaXE5cWpNa0RVYVpDRjM0UnFWN2V6VkRn?=
 =?utf-8?B?Z2NGTWpLVVplUlFwWElnbkxYVFAySFVtbzdVQUViakNsY1J3V0pGZTJzWU1p?=
 =?utf-8?B?L0NXNmgwbDE3dTlQRWF6YlNVRjRrZWh2akl4Q2wweERyaElNazkxY1RXK1d0?=
 =?utf-8?B?d3VtMnlxb3lpUU9HZXo4MGdnT1ZIcU9iM0p6MmVaTEwrUGZBYjBnS1ROWHQ4?=
 =?utf-8?B?bkdVTXdVRjdYMkNicXVBekY1V2FNZ3NrS0FaWlZOa2tXVUhQckkxU3JGSGFH?=
 =?utf-8?B?dWRBenorMDE0Y2NzMFBLWWV4WlRuNi9TZmIza2lqZE00V0ZRMGFYdmp0czNs?=
 =?utf-8?B?UERjNjRpZ0lmVlVqTytxbXkxaXQxODMvWWttbFIyQ0VQMmhIN3h4dWVDTS80?=
 =?utf-8?B?VmtySFFnaXdybHFDcDFNZmFXUUZkNVpIWC9sSGZGcFNWa3h0SnJTQy92dUxh?=
 =?utf-8?B?alFTQjVLQm8vQ2c2WnkwdHdLT1BrTTFVTnhBcDc0ZWZKbFhJeXlaTTdicnhz?=
 =?utf-8?B?aFlKRkNpQXQ1Y0o5WjFic3l0bjhjODFqU0NRNUczdkVNZU53bm5uV2RXQlVM?=
 =?utf-8?B?anQ4eDJTSXBwTGhkYk5rZ3pmSnU4SGNBcitGRjMzZDBHTWVza1lhcFc4QlBU?=
 =?utf-8?B?c3QvbW5lTDdYOXlnWWFZVStrMDJLNWFrMHFuQVR6ZHVrd0lPSjVIOVRzcDgz?=
 =?utf-8?B?STZ4QkVyV29oZHp3VS9CdmtRYTl4UVBqcUJ0a2NMTUU3OFo5azRUOTh6aEFB?=
 =?utf-8?B?V3BRYktpN3hQR25JQ2FXVm5UbjdEMWhzKzN2L3ppaDVXTjNQSWlOOFpGUXhj?=
 =?utf-8?B?bkxBZXVyZFR3SGJGTGw4ZmhqTFFZSHE3NE15MWhXR0o3VW1ybkVoZ05jR2Vq?=
 =?utf-8?Q?9KoquKc6Bzor9RNf8LKfHmI7J?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01a246dc-a327-4233-c51e-08da6a64cd93
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2022 15:30:40.5571
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MKWwhb3CmpUOEsxR1+q17a4f8EZddI0bvqa2/rLi577PApk9GZ1StOj4HczpEUhoQ6u2dks6KNiOvsZoyLMivQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2485
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/20/2022 10:22, Guenter Roeck wrote:
> On 7/20/22 07:45, Borislav Petkov wrote:
>> On Tue, Jul 19, 2022 at 02:52:50PM -0500, Mario Limonciello wrote:
>>> This series started as what looked like a correction to previous
>>> commits, but I missed that the previous commits were for a different
>>> family with the same chip models.  So while fixing up the series I also
>>> noticed that a few upcoming chips have new PCIe IDs and CCD offsets not
>>> yet supported, so add them to amd_nb/k10temp.
>>>
>>> v2->v3
>>>   * Pick up tags
>>>   * Group "ROOT" PCI IDs with others in patches 2 and 3.
>>> v1->v2:
>>>   * Correct commit messages
>>>   * Add more missing chips and offsets
>>>   * since so much changed, do not include Bjorn's Ack.
>>>
>>> V3 original submission:
>>> * 
>>> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flore.kernel.org%2Flkml%2F20220613192956.4911-1-mario.limonciello%40amd.com%2F%23t&amp;data=05%7C01%7Cmario.limonciello%40amd.com%7Cccd318a2336a4fff464e08da6a63adf5%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637939273635072576%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=WHsUYbBtu0ka4S2jiji%2BKaFycbTAHz%2B1RoANXo4maf0%3D&amp;reserved=0 
>>>
>>>
>>> Mario Limonciello (6):
>>>    x86/amd_nb: Add AMD Family 17h A0-AF IDs
>>>    x86/amd_nb: Add Family 19h model 70h-7Fh IDs
>>>    x86/amd_nb: Add Family 19h model 60h-6Fh IDs
>>>    hwmon: (k10temp): Add support for family 17h models A0h-AFh
>>>    hwmon: (k10temp): Add support for family 19h models 70h-7Fh
>>>    hwmon: (k10temp): Add support for family 19h models 60h-6Fh
>>
>> Is there any particular reason why those are split into such small
>> pieces?
>>
>> I'd expect one patch adding all PCI IDs and a second patch doing the
>> k10temp changes.
>>
>> If no particular reason, I'll compact them all 6 into 2.
>>
> Ok with me.
> 

It was mostly for review purpose so that other AMD guys could comment if 
I fumbled the DID or offsets for a product or if someone wanted to test 
it independently on a particular product but didn't have the others to test.

At this point that's fine with me too to combine them; thanks.

