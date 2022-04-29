Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A732D51409D
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 04:44:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234480AbiD2Cja (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 22:39:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231529AbiD2Cj3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 22:39:29 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2086.outbound.protection.outlook.com [40.107.220.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36ADADF04;
        Thu, 28 Apr 2022 19:36:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B8jGyAFOMt383I0pinZ3UbSpBlZJZ9nV6jf7DfBbX8wU3NNf3aymVDznfywxIfLIn0YYafoyv76gfNu7rw6lmmk39y2rKcJXeSEzRJqVsMR78gBGGMr8xN5kJnR5C++7EkGJTdVxuVL9jqq73o57owzuZMBiiJX0w+VvC1+0f9e1Tr5A91o2AR31BfYopru6U4E8lAq3VkG+jKyar9eWphiNdtigkbiL55BpgoKnqLBYBdJLXLCEpbymgTXttwltkEiBh5SA7N0tw4UQAlfuS5Sjn2vrkOTkfBcLipAsAoVXGXNKehn1W4j4/dZ/bRM9k2HR/4/L14qGf6+AHruF5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LhygHHoMfAHU7AgHyDLjILO4uHiRCLRbOhQ9SjL8irI=;
 b=U+kjSrFUyi3JV6w57FLyuKcAvwrS3vKlKUyGmaOxRgJTEvbzY4ncIauR1nivaHlXBvQx34nbnze6Q19Jcb9tPzB/X/PvOvqQQ/F6mwN7wt5gmR2mD/LJq96FoohV92wB4SXjMpx09Nvk6sW8s4f5CGQymV7c32R3JsD103XeNgRZNVigLQvfhn+D96fEvN6Wj//L0x8QnLrT/mgTS/5UNm9v4HBPnNUCDpxi7swoIrn6exzPATDp/KCTCNNzlMAPLoQt4R9S2UdzKktIjwfJy5pKsxEupIgcrZiPNxhe/zzxpkzNiPILN9N4qYv4JubM6C/W9MDXd+0sxjeY+u72ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LhygHHoMfAHU7AgHyDLjILO4uHiRCLRbOhQ9SjL8irI=;
 b=gYSKUgQcOLX8gC2UAdOnSeeqgwoo+treFwM5O/X9G9wx+Fj5gBbNzGsu+OLV1Mc423ogCh8449O8TpXdoWwJvIoQBHYgsRN4IiaWI9/Qo4pFkRk345j8maJFr+Msm6qCsKxPEEk/eqzw61vD1eeDH+uExpmS++ZUYhnbUtrFw4c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB4720.namprd12.prod.outlook.com (2603:10b6:805:e6::31)
 by MW2PR12MB2345.namprd12.prod.outlook.com (2603:10b6:907:2::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.20; Fri, 29 Apr
 2022 02:36:09 +0000
Received: from SN6PR12MB4720.namprd12.prod.outlook.com
 ([fe80::c575:d06d:b1ba:c877]) by SN6PR12MB4720.namprd12.prod.outlook.com
 ([fe80::c575:d06d:b1ba:c877%7]) with mapi id 15.20.5186.023; Fri, 29 Apr 2022
 02:36:09 +0000
Message-ID: <d5db8a44-06ac-08ca-c9dd-cfb837e1d9da@amd.com>
Date:   Thu, 28 Apr 2022 21:36:06 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v3 4/6] cpufreq: amd-pstate: Allow replacing acpi-cpufreq
 when loaded
Content-Language: en-US
To:     Huang Rui <ray.huang@amd.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     "Limonciello, Mario" <Mario.Limonciello@amd.com>,
        "Fontenot, Nathan" <Nathan.Fontenot@amd.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        "open list:AMD PSTATE DRIVER" <linux-pm@vger.kernel.org>,
        "Yuan, Perry" <Perry.Yuan@amd.com>,
        open list <linux-kernel@vger.kernel.org>
References: <20220414164801.1051-1-mario.limonciello@amd.com>
 <20220414164801.1051-5-mario.limonciello@amd.com>
 <64d7f4f7-3c05-7f37-d9eb-72d9d079f8f8@amd.com>
 <BL1PR12MB5157CC5E942986945F5EF088E2EF9@BL1PR12MB5157.namprd12.prod.outlook.com>
 <CAJZ5v0hFstH6goScEhUmZwBQ4gEnt5-tcp=UKgrW8Xb5zdZ_zg@mail.gmail.com>
 <Ymo/I5AQd1V0S+Qu@amd.com>
From:   Nathan Fontenot <nafonten@amd.com>
In-Reply-To: <Ymo/I5AQd1V0S+Qu@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BLAPR03CA0081.namprd03.prod.outlook.com
 (2603:10b6:208:329::26) To SN6PR12MB4720.namprd12.prod.outlook.com
 (2603:10b6:805:e6::31)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1911c207-2285-41d5-cb97-08da298904bf
X-MS-TrafficTypeDiagnostic: MW2PR12MB2345:EE_
X-Microsoft-Antispam-PRVS: <MW2PR12MB2345A2576F631D34307E657FECFC9@MW2PR12MB2345.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HVyClyS24Z5PU7hPtdXAy9zamO4ev8GcDRHZ6ljU3I6lsh6DdD3rPsU1CDz62DOUd27qtzoYTv2hy1WXbd2Saodi3SQ6uxxXM9DT+atF1VasFyFUXMbrbnG8MKQf/jApiNSXdwSDVwdIeNlsPj+I39tNMna3dHK0H0W/TNqCVtp+iq9xMWudQ+nPjxw/woAuvmkps+/A8iMWWOm3eCZz8wrcriPcvNe4ZQikYoUiFCAdYkBtgqsNLVrqJbJkV/d1jQIH+xl++JygniSxcOopo3yhyOVMBhihnyK4luptCeKOdpogbtHkfZY6526kMkmqqbounejdHQq5vqwwidgWvr3jU+TFbIPR9gJavbt2ZZZvGyt08sdORazt3ED9hw/dusubCyIqL7dX4NJvhoFdBr6nHVxKUMf62ox7uSxc3UE9kqSkUv0AYtp7eiqxGNUoImou6f450uqwZ5ct91qi+LOEcZi6Shbw+8w18XH7RpQcX4XWmgKJ5b1WSYXrZBcQ1pNDJqSdPA8pwfyfYQbOZJ62biAS+MJ6mv3cTFkNE5QDYO6o8c8VUFPwI+dy7mmORs5gkKF5O9vkN7SdiurrpFBXsla4NvmeDdslbm4XvhsEK8zoYr/6NLwYPYpMmuwBOdTlCFE/T3zJZthjqxxJf5Bgz1OX1N86HADnHpZA6BnGEuLZxyXFvDOl/zkzgYR+8Y91tVPyP06UpMgDffPuuUzaFvg/CT88NXL0kOrcPRk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB4720.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(54906003)(31696002)(66476007)(8676002)(83380400001)(66556008)(66946007)(2616005)(2906002)(53546011)(38100700002)(316002)(186003)(4326008)(8936002)(110136005)(6666004)(6506007)(31686004)(36756003)(508600001)(6486002)(6512007)(5660300002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dkpPei9qZWRsTUhEV0JnaUg1eXA4QTRHN3N1a0VYZ3BNTDdGMlhIWTNaUXpE?=
 =?utf-8?B?bUlVSDJ3QWJ0Vi9uV1J4ZjV0SVpVTkFOQzBpYzJhVmVYaGh1V3ZrUDkzK09s?=
 =?utf-8?B?d0xFVndPZkRCdGIvWTdIWFlhZlVXVlh2ME42SWt0K0hOVmxWVDduUWtMR0V2?=
 =?utf-8?B?TkU5bDhHV2k3RnpFT0RkZFA5VTdUOWJPSFlzamYzQnE5ajRFREhZSFBkK0dW?=
 =?utf-8?B?bnRKbkNLa2ZuM3p1dUFENWRkSFpMREpFVEFUN3hjbGVhWEM3aE81SWpBbFJw?=
 =?utf-8?B?VXpHemVEQnh1c2cxWnRmZStGRzczanF5MjZYdnNyYm14b21HN2lQREYvS2pw?=
 =?utf-8?B?d1Q2bFUvYjBNSzhzNUdoVFFSajNkSG5Fc2t6RVRnSTJzRmV3Y0pSZ1RPaTY1?=
 =?utf-8?B?SjdKY1NjUjFoYjFUOUdYNmlmVjhicFRqWHpFMmYybGR3SDNQL2NiWDN4d1pi?=
 =?utf-8?B?bXYxbG15UFFtbG9lYkZjU2Z0NTZXL1hCZUp6UzN4cU12V0s4R3JBOWllVTdD?=
 =?utf-8?B?WWN0TExadXM4U2w1T2tiMFk2MzNwTXFKRkt0cWNiZXk5bDFNL2NiUDdkRjlU?=
 =?utf-8?B?Yk42eTV0aWR0M3RVTE1jZ2dKSVJEWUVBazJWWXpRQUljRmR2cmlza21keVg5?=
 =?utf-8?B?ZWZGSVU3WkU4RFJkVVlOZU0yb0dXSjdmZ2tSVThUVmMxUWtRRElndWF2ZmFB?=
 =?utf-8?B?QjJ4UkJydTNBYkdKWFNBUHUvdWhhUm43cVZaamdPSEx6SmUwNTZFYVNSTmFi?=
 =?utf-8?B?SktqeHZCRmtJd1RiSENoUVFLRXFYK0tzYWdaNUFhL2l3RkJPS0VQdndhWnZY?=
 =?utf-8?B?cUFNZmEyQ2R1RWEyWmNwWWNVNjJWL215TEY2NTdZcGNuNWo4NXE3d3BwT3pE?=
 =?utf-8?B?Q0ZZSGV0ZjQ4N1VqaVlOQjQ1cW1nL2RwdzZNS3poeXljbG50L2kzY2U1ck9L?=
 =?utf-8?B?VzhMaHE3U3V5VE5xM2hFaGIyTVZ2NnEvQU5kckRzVlZmQXJvZDBZLzBEWVRo?=
 =?utf-8?B?aDZ0SUxiQlgvdmtkbUFjNFc0RXIyTzZ5am54UXRwVElqdGFiT3NGbko1Rmh6?=
 =?utf-8?B?a0Nid2dtMkw2VTd4RjNxNVZqSVppeWRKaTBRUEFqMWJsRWUydUtzVCtKS1N2?=
 =?utf-8?B?R1VpYVpmY3ZMenNkRXVOWVYrMXpHR2REckV0c1hOMWYrL3RwTFNkRTVNbkV3?=
 =?utf-8?B?djRuRFBsTFlWR1dsdTNvN09acDJXcmdDMXFCU3JNODVMSy9URmtNUk5OSGY1?=
 =?utf-8?B?WWFjekY1TjVIZEdqZVdFRDZsSDIvM05ETGtodGZld0htOG9nK05EYjBQdi9l?=
 =?utf-8?B?SENVTnJhOU04YnhhNlBiT2dEUXBZdzU1OVk3TC9Nb0JpM0cwcmJTSE9adjFQ?=
 =?utf-8?B?T3VOTW1yZkYzMmpFTTBkc2FzMXdxQ3MybjlxK1RRQklhT1F6K1p6NzIyWlBz?=
 =?utf-8?B?Wml6SlE2M3FKQWdib3AvQXZCUXAvTjVzRll3Zk9mZjlHWEphUmJUcWRWaFFN?=
 =?utf-8?B?US9MMUJkd0JBMWlBUDhNaWxVdkFmNDRSSFlISGhOV3lndmNFT2tIWFJFWE10?=
 =?utf-8?B?OVJHaWdSWDZzOVlEMit2L3R4MVllcTNBQmhjOHhINjhyMldTalJkMWVPWklq?=
 =?utf-8?B?WnpVWHJoNEZjRFJ0SFhmWkozaWo1YTVoeUNxS285YzdXcUl3Zm5EN3hiOExB?=
 =?utf-8?B?a2wwcnhhTlZpNlJyZjhRNVJqN2dBSWpwUnN2bS9hY3c5NFcwSEk0dUx5L1NU?=
 =?utf-8?B?d09pNzUxNzFwN0ZmNE9KekFRaGxOb2lhbFZkU1hUSUIzeXQycWQ4ODQ4eEhE?=
 =?utf-8?B?cE5NRDQwK00vRkZ1Y2lTT1lTU1ZIM25HSXc1aHQreFgxY0QycURPRVNWY3dS?=
 =?utf-8?B?WGJRS25iVjdCYlA5bmxqNHA3V20vNy8xS3QrSDRvRjRiZUtBUU15eW1qWUhJ?=
 =?utf-8?B?THZ1Q0RSOUNuU2hsWTkwdi9UQnRqRXo3K1pEekUyUG5SVDBCaUJVWENkUy9v?=
 =?utf-8?B?NGwvZE1sUEZIRStjSmpxRHVaRFZ6Q0c2ZmVQREpRYVdxQlVycWo3V0phR0dp?=
 =?utf-8?B?TitiekJuMGdvcFpYWnd1Q0VxRW5OS3krN05ucXBpWGJXRE1raDhSaUNDMksw?=
 =?utf-8?B?cUd5MU5uaWcrMGpCTWd6SEF6WW1OclNuQmRoVUhFSGhzekVGOFBVNytGNjlV?=
 =?utf-8?B?eUJJM3UwQ0k0Q05Ja3g2L3FMczlQN1N1Y0tySDd3ZmREbWxDaHFBZFlDVCth?=
 =?utf-8?B?dW5sNEJqa1lBVE85NUREY1BwaTFudlRaQkVZZHdQL1NrZk1SKyt5OVlDaXpJ?=
 =?utf-8?B?VWZJRnlNQWFrUjJraUZZMkxqaU1QWWNlSFpPdm5mVDh5YllmMGsxY1VXVTRt?=
 =?utf-8?Q?xBg+3c/tpYEfNr9CdiLvceROMJv4V3yLDYi6mlQ6tHRIu?=
X-MS-Exchange-AntiSpam-MessageData-1: z7KkEYqJ/Slbpw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1911c207-2285-41d5-cb97-08da298904bf
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB4720.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2022 02:36:09.4689
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dsZmgRfCjV+qt+fNHT/iaKOKd3H5gegTyqB2lvVmO0+3auAX2B+fZwSsD2wBKIGVS7s7LB8QOUVVzvIpTaYB5Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2345
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/28/22 02:15, Huang Rui wrote:
> On Fri, Apr 22, 2022 at 02:38:32AM +0800, Rafael J. Wysocki wrote:
>> On Thu, Apr 14, 2022 at 7:58 PM Limonciello, Mario
>> <Mario.Limonciello@amd.com> wrote:
>>>
>>> [Public]
>>>
>>>
>>>
>>>> -----Original Message-----
>>>> From: Fontenot, Nathan <Nathan.Fontenot@amd.com>
>>>> Sent: Thursday, April 14, 2022 12:33
>>>> To: Limonciello, Mario <Mario.Limonciello@amd.com>; Huang, Ray
>>>> <Ray.Huang@amd.com>; Rafael J . Wysocki <rafael@kernel.org>; Viresh
>>>> Kumar <viresh.kumar@linaro.org>
>>>> Cc: open list:AMD PSTATE DRIVER <linux-pm@vger.kernel.org>; Yuan, Perry
>>>> <Perry.Yuan@amd.com>; open list <linux-kernel@vger.kernel.org>
>>>> Subject: Re: [PATCH v3 4/6] cpufreq: amd-pstate: Allow replacing acpi-
>>>> cpufreq when loaded
>>>>
>>>> On 4/14/22 11:47, Mario Limonciello wrote:
>>>>> `amd-pstate` can be compiled as a module.  This however can be a
>>>>> deficiency because `acpi-cpufreq` will be loaded earlier when compiled
>>>>> into the kernel meaning `amd-pstate` doesn't get a chance.
>>>>> `acpi-cpufreq` is also unable to be unloaded in this circumstance.
>>>>>
>>>>> To better improve the usability of `amd-pstate` when compiled as a
>>>> module,
>>>>> add an optional module parameter that will force it to replace other
>>>>> cpufreq drivers at startup.
>>>>>
>>>>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>>>>> ---
>>>>> v2->v3:
>>>>>  * Rebase on earlier patches
>>>>>  * Use IS_REACHABLE
>>>>>  * Only add replace parameter if acpu-cpufreq is enabled
>>>>>  * Only show info message once
>>>>> v1->v2:
>>>>>  * Update to changes from v1.
>>>>>  * Verify the driver being matched is acpi-cpufreq.
>>>>>  * Show a message letting users know they can use amd-pstate.
>>>>>
>>>>>  drivers/cpufreq/amd-pstate.c | 22 ++++++++++++++++++++--
>>>>>  1 file changed, 20 insertions(+), 2 deletions(-)
>>>>>
>>>>> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
>>>>> index d323f3e3888c..8ae65a2072d6 100644
>>>>> --- a/drivers/cpufreq/amd-pstate.c
>>>>> +++ b/drivers/cpufreq/amd-pstate.c
>>>>> @@ -63,6 +63,13 @@ module_param(shared_mem, bool, 0444);
>>>>>  MODULE_PARM_DESC(shared_mem,
>>>>>              "enable amd-pstate on processors with shared memory
>>>> solution (false = disabled (default), true = enabled)");
>>>>>
>>>>> +#if defined(CONFIG_X86_ACPI_CPUFREQ) ||
>>>> defined(CONFIG_X86_ACPI_CPUFREQ_MODULE)
>>>>> +static bool replace = false;
>>>>> +module_param(replace, bool, 0444);
>>>>> +MODULE_PARM_DESC(replace,
>>>>> +             "replace acpi-cpufreq driver upon init if necessary");
>>>>> +#endif
>>>>> +
>>>>>  static struct cpufreq_driver amd_pstate_driver;
>>>>>
>>>>>  /**
>>>>> @@ -643,6 +650,7 @@ static struct cpufreq_driver amd_pstate_driver = {
>>>>>
>>>>>  static int __init amd_pstate_init(void)
>>>>>  {
>>>>> +   const char *current_driver;
>>>>>     int ret;
>>>>>
>>>>>     if (boot_cpu_data.x86_vendor != X86_VENDOR_AMD)
>>>>> @@ -666,9 +674,19 @@ static int __init amd_pstate_init(void)
>>>>>             return -ENODEV;
>>>>>     }
>>>>>
>>>>> -   /* don't keep reloading if cpufreq_driver exists */
>>>>> -   if (cpufreq_get_current_driver())
>>>>> +   current_driver = cpufreq_get_current_driver();
>>>>> +   if (current_driver) {
>>>>> +#if IS_REACHABLE(CONFIG_X86_ACPI_CPUFREQ)
>>>>> +           if (replace && strcmp(current_driver, "acpi-cpufreq") == 0) {
>>>>> +                   acpi_cpufreq_exit();
>>>>> +           } else {
>>>>> +                   pr_info_once("A processor on this system supports
>>>> amd-pstate, you can enable it with amd_pstate.replace=1\n");
>>>>> +                   return -EEXIST;
>>>>> +           }
>>>>> +#else
>>>>>             return -EEXIST;
>>>>> +#endif
>>>>> +   }
>>>>
>>>> A couple of thoughts. First, should this also provide a path to restore the
>>>> acpi_cpufreq driver
>>>> if the amd-pstate driver fails during init some time after calling
>>>> acpi_cpufreq_exit()?
>>>
>>> I think that's a reasonable idea; it would involve exporting acpi_cpufreq_init
>>> as well.
>>>
>>>>
>>>> Which leads me to wonder, should there be a more generic
>>>> cpufreq_replace_driver() routine that
>>>> could handle this?
>>>
>>> If changing the API for this, my proposal would be that there is a flag used
>>> in cpufreq_driver->flags to indicate that this driver should replace existing
>>> drivers when calling cpufreq_register_driver rather than a new routine.
>>> Then if it fails to register for any reason then the old driver can be restored.
>>>
>>> Rafael, what are your thoughts on this?
>>
>> IMV there need to be two things to make this really work.
>>
>> First, the currently running driver needs to provide a way to tell it
>> to go away.  For example, intel_pstate has the "off" mode (in which it
>> doesn't do anything) for that and similar interfaces can be added to
>> other drivers as needed.
>>
>> The reason why is because, for example, intel_pstate cannot go into
>> the "off" mode when HWP is enabled, because it cannot be disabled and
>> running acpi_cpufreq in that configuration wouldn't work.  So in
>> general you need to know that it is OK to unregister the current
>> driver.
>>
>> Second, there needs to be a mechanism for registering a driver
>> "weakly" for future use, so if it cannot be used right away, it will
>> be added to a list and wait until there's room for it to run.
> 
> The amd-pstate is a new module, we need to add "amd-pstate" on
> /etc/modules-load.d/modules.conf for most of the Linux distro to tell the
> module to load at boot time. However, there are some issues that we
> unregister acpi-cpufreq at runtime while the acpi-cpufreq is in-build.
> 
> As inspired by your suggestion, I am thinking whether we can add "off" mode
> in acpi-cpufreq driver, if user would like to use the amd-pstate driver on
> shared memory processors, they can set acpi-cpufreq "off" and set
> "shared_mem" on amd-pstate to enable the amd-pstate driver. I can add the
> RST documentation to describe the steps.
> 
> Or I can introduce a processor list (family id/model id) that can let user
> know clear which type of processors they are running. Then they can choose
> which driver that they want to use manually as well.
> 

This sounds like a move towards an infrastructure similar to governors where
all supported drivers register and users can choose from a list of available
drivers.

Ray, this seems like a lot of work to be able to dynamically switch to the
amd-pstate driver after boot. Given that this behavior does not currently work
how crucial is it to have this ability?

-Nathan
