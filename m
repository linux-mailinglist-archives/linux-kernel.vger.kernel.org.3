Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 858D25AAE37
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 14:19:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235728AbiIBMTN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 08:19:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235631AbiIBMTJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 08:19:09 -0400
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2087.outbound.protection.outlook.com [40.107.101.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78578D2B15;
        Fri,  2 Sep 2022 05:19:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zo0NfazEJO+MEtgUfTQSeVlaM3eJ8L8PYQ7LhZIB4ibR6AvAF0UJvqGLLX3VXgENqW1p/neHQoVhVoRNzMjJRE1PtjUQf1pVb/AiE60OyCcqBs2depwqMZRpEpj/LIagNhbAw2oTroWX8Xr9OymKrM3IiNnKhGYhoEGg5cKAOUoj5xNk1owZkn9GU8DoS3xHrTY0m6BswwCEOV49VsZ6MovuUCdo8QmD2ZYsnodxhjh1CH/dyRHIeujkuQ79hPQTkL83EqvBw0ZDkxIJZg4RnYK9yXUCUePPBwOyp00xtm2Q9GCacbncDP3bHmUux9mw/3PrLwc3Ht9mxaGuVkGotA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5NK0d2rboTF2AybVHnZfuP9zZCUd7TCcnDd7ycaqCbk=;
 b=MeNxJJRkCUmHz4HR0myuQficyrMZ9ZzJRIQQh3Ruw6bc9ucB+ahTs9CtZ8byoq/a6G2cMTUv44OUHZH/mrL6l+1o2gQsD9g53iRM3lQX2+AgT6xKI6kXU+wTiJp7vOQglbwMNGUfJ4ggXkbbDNApFPtBD10n1Zp3Ujy23AIZqiRRbxTgdYW843JzjAohFIhU+Kl7KeRkWOztg42xpOsiEFzgqXFzSpedZVQSXby49Mas19LbKi8NGOEi2o5lSwejPDk/dpkdsJ17qEiE1j6NaCoq70KKe9UPxPgwr7+RT04OweXDzor/F2R280SqkSDHkZdD2417VOaJMPwHT2oaqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5NK0d2rboTF2AybVHnZfuP9zZCUd7TCcnDd7ycaqCbk=;
 b=AQgl/QYxOES3SwdB87Le41a5XwNSemIV/SeXuk9f+Y+KSkNN3XHtI3r3uUNSN+GSW6KFv9G2Ziu3E0KQkMA7zEoXMYGO01WTZ0P83mHqTqLZyJTOckENRsAc9VenrGWjJLmb+0a3Amg2MLMWKnhpFTe+SRM7fpG9hQwF7N9MwRE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by MW3PR12MB4473.namprd12.prod.outlook.com (2603:10b6:303:56::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.10; Fri, 2 Sep
 2022 12:19:06 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::e00a:1f8c:dcd1:afc3]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::e00a:1f8c:dcd1:afc3%5]) with mapi id 15.20.5588.012; Fri, 2 Sep 2022
 12:19:06 +0000
Message-ID: <168cb996-513e-77a8-b895-ef0fdd0c1793@amd.com>
Date:   Fri, 2 Sep 2022 07:19:03 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v2] platform/x86: wmi: Allow duplicate GUIDs for drivers
 that use struct wmi_driver
Content-Language: en-US
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Mark Gross <markgross@kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
References: <20220829201500.6341-1-mario.limonciello@amd.com>
 <CAHp75Vc3v4a6=ZJnOYYFGHEomExxopuUy8axDL=M2tbxHqtXqQ@mail.gmail.com>
 <MN0PR12MB6101441AA29CE815DCAD26AEE27B9@MN0PR12MB6101.namprd12.prod.outlook.com>
 <3df6405a-924a-b0e6-c879-05b9151011e3@redhat.com>
From:   Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <3df6405a-924a-b0e6-c879-05b9151011e3@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN4PR0501CA0124.namprd05.prod.outlook.com
 (2603:10b6:803:42::41) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d1873f18-4380-4831-030d-08da8cdd54c1
X-MS-TrafficTypeDiagnostic: MW3PR12MB4473:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: h8SzomZFuAPU7V0XIymviIFec4vOH9HuYh6RQ1XUIYn5vUU4K8EN2zHIWhN9w8Ns310Rf+Yr1awJtMzGpWLKKN9LkvMVT5oN8hmTWMgx4QfwR1vw5QGqwLFrQm2eq4NXOMKnviKUwT1KsnWVuO3zz/9BMIPJ9fh9ejVnjo1KvN0h1Qg4J+dflrwr0+I6vVzWZe8WcrTEnvzkRfr1SavNGgsnlr+gCbxnRmfmA313+fXDdywtRjyD1kNDat7iJRzkTlDekrzDIysQMKx05VqNxOP8GNbP8GlqdAkDmi7Fb63jgpSkdQc3h6Gz80OSz/9BHiUfsJat4hAPfROb8L4EEzOBP9w2VzOkN+BVP0gXb/t4KzZ4W9rEPb8+zC4QSVs1eF444pcKOsvu7EmqDtZZVVZnVDpIdP1iZNYZIZQ6HW0oUj5KWygZo+FZlH+JayAdF0NIgzDyR09JOU+Qoeso6r9ytL4eaWnyw08uwErvkGRAOt178Fum8bTMaGiicF4+NhcIH7FxP+Slq10mZID3A7fy9TrjkmbaNmsvznHeKDEskqRgMfSdleNxCAKAhGW+KA5BvUgqj9SYgwmX5aMVa5CGp6b5ZME39CHdeqvIgv8+xU4H72EsYgPJtQZuRu8kU9YFFWDHIo1p7+TCgZprDAz4S8Vj9GyTEM9AbZYF/cNZJ7VuMdmBPhvsVTnjGhSd457WOH9L2aIxoMJrtdwsOLuTcB+4+LMmZv6Jbxg8F+jBHsgZPa0CoDs7t57WTfJ14oqP4ZSIa8FeNrf+1V4va+BpXQmsEjN+8c0Jxd6V184=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(396003)(346002)(366004)(376002)(39860400002)(6666004)(6916009)(53546011)(86362001)(31686004)(31696002)(44832011)(186003)(6506007)(41300700001)(8936002)(316002)(36756003)(54906003)(8676002)(6512007)(5660300002)(478600001)(38100700002)(83380400001)(2616005)(2906002)(66946007)(66556008)(6486002)(66476007)(4326008)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VjBra2liRWs1aWUzcmVUQ2pjaFdYUWs2bDAzY04vYVZTS3JRVVBCWFI5dnpR?=
 =?utf-8?B?cFJXUEptL1I2YXVZK1I1T0hNZmxETXVKTTFOeEIrTE5OUnEyQlB2cGhmSG05?=
 =?utf-8?B?ejlzQWs0YkVINzBwSGlOTlN5ckRYUUNqUFU1R1JjL0xOWm0vd3lXYWZOMlBu?=
 =?utf-8?B?dmlnSzVWQU8vUm05T0s5aEdQWm80bHdaVWJLYXZ0WWlSSjBzOVNvd1JwVGw5?=
 =?utf-8?B?T3BUMjU2RjRHaDl5MlJSWE1GRW40VHRMVlpGMHR2MVk0b2o3Q0NnTkhvUFRw?=
 =?utf-8?B?UnZ4SjZhOExhdmZ0bnpzOU93T0E2VG1NanUzQWhwd3lMWjYvb2RBZXNDaE04?=
 =?utf-8?B?NWxxUmJKeFNtWGlHZjkzbmZnZ3ZJZDFRNHh1Nlg0M1ZPRkx3ZlpnVnd1M1dp?=
 =?utf-8?B?T1NDcEpwclM0UDhUY1Q4bGJwYXhldXpWNmIwZklKNHlYNHhoOWxBOEpVTDNv?=
 =?utf-8?B?MHFpMEtWWTVjTUpFZHlRS2VvR1pMT0FSdXFiUS82clUyZC95eUVJRURic0sv?=
 =?utf-8?B?L0ZyN2pZdm5UbjJSWGhSQjBvNkxwWGpKaFVqRWl4QXZNWFBzUE5GMGo5QmtE?=
 =?utf-8?B?WWZWVVV6WVg0T3NqNVlZNFRma3dOMlRUODVCVkZobTdFT0Q1dlNTdEtLbnJq?=
 =?utf-8?B?dDd6VXVrcVRkZVplRGdnRzZxcFFaZDNtSTJ0NlFBdVU3RzBrZ2U4cUJXR285?=
 =?utf-8?B?SExReEM1QWs1aE1yRE9GczdCMmtkNXBqRmZUL0djRU4rVWhMaFlXbnphUG5m?=
 =?utf-8?B?Z3diY1cvRnFWZEU1d3FPUTlWVFpvYnM4cmoyZWRjSkRCNHFLR1NyU1Y3WndQ?=
 =?utf-8?B?L1VOK0pUblhvMk8zUGtuQS9WUjd0WHZoL09SYk12bHhka2J6QTZFeTJmcHAz?=
 =?utf-8?B?YmthVm5nYW94dWtDS2ttQ1R4Q2I1ZktnTitBcnZqa1EwM2k3ZEZ1bmlqMjgx?=
 =?utf-8?B?c3ZjZ1hTd0tPVVR4c0hkRVlkRTdkMnRsOHBCYkVBUGJnNDVSWjlIQ215TFB0?=
 =?utf-8?B?Ym9rUEYyOUhpRlU5ZGxBbU5UdUlsTTVCS0RHNWNIWktyeWtOTmJGdUU4UjNQ?=
 =?utf-8?B?c1A3bzdWRnU1dWNMdWdXWXV4NWFJN0VUWkpVWnpjQzl6WEZrQ0xVOUQxRFlj?=
 =?utf-8?B?ZkVDWjV3YWFSUnl1OGQyc3hXenFOR1RBd0RnNmp4RmtDb0E1aGNzcVoxUFlV?=
 =?utf-8?B?dHVXbERMOGlocGNNYS8rK25Za01RRU42bWFvTTRTbFFac3lxVStuaW44b2xL?=
 =?utf-8?B?aENNY2dDdDFiZ3lUTytCMm5rOGxXVk8wMGd4V2xuVkxsblRqbHpTQS90Zjlh?=
 =?utf-8?B?UnB3Q1JSTmJSSDU3WVRIMVFoZVhMY2ZTazduK0RSYnZLVlVaUm1wODBSUDRu?=
 =?utf-8?B?RFVmSWZqaTA1VG5DL0Rtb01SVnFXUFVUKzdWTng1M0IvTFk0NUMxSHRyQTdO?=
 =?utf-8?B?WklqbjFOYjhlK3NDd2Y1ZEFtUWJLYW9ZeS9Yc2MrVnhMM1VzdXJ4L2FHSkc0?=
 =?utf-8?B?YlNRUE1DVm5HUkNmdGEzenBydzJVYjJ5cC9TeUlhVnVISFJ6QXg3djJGbm5h?=
 =?utf-8?B?ZlFEQmYrd2RMT2dJdzRXWDVHeWVoZEIvVlFhdWlNL3N2Smp6T1RHV0MraE1G?=
 =?utf-8?B?VVBrcUtSWStyRHFPaTdqSTM5ajRqOGd4NGxuQlJMb0NaY0RQZjNXM1kyN2VR?=
 =?utf-8?B?WW5NbmdFVEtKWFltVEJmTGZTYVRtaXZmcityYk9pb1RNOXgzQWZCSmZKckVG?=
 =?utf-8?B?dHRRdmkrSjJGbUsvWWZoTWpEODArWTFvT2kybFErWkpFV0h1THVjaytVWHNw?=
 =?utf-8?B?R2pJdWNZdlU4MzZjMFJnaHZ5VEgxc0lqeW9kMWp2RVZqKzEyYmlsNXhNcC82?=
 =?utf-8?B?VHo0TnlyUXl6L09rWUtMV1JrOGlLTWpOdGdFU3A3TjdiMkNSc253TzRFN3lk?=
 =?utf-8?B?ckQ1ellBY3cxUzNPNEVnVUhrdml5NStGRXpqeTBHM1pDYmY5MnNJcC9lLytP?=
 =?utf-8?B?ZElSQnlZbHlHc215cmVUYnlsYWp2RVR5Z3NaVlUwUnFrN0JWRFBuUXRaOGtQ?=
 =?utf-8?B?L2JFWDR3YWl1SFgrc0RFVml0dWlBU0hwdWkrVDVUc2wxdUNxZjg0ajhtN3NN?=
 =?utf-8?B?NDZFOHY2eENnMHFtNjFZUXdTOFkwaHJpUm54MkxVMy9Xa1I3alJQSE9VRUNN?=
 =?utf-8?Q?Ozk/CKbAZ+G3XQOAUjC7Zp4iVbHBdwRWv1J2fI4sc1Ca?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1873f18-4380-4831-030d-08da8cdd54c1
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2022 12:19:06.6911
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mEoazACMz1Rjik0LcoRZKuHJt900DIS9oJfYtAp5AwX4b2AhiNby/Ns1cFnUcYKwmHXqWC39ICJibfPpNxD/KA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4473
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/2/22 03:07, Hans de Goede wrote:
> Hi,
> 
> On 9/1/22 23:39, Limonciello, Mario wrote:
>> [Public]
>>
>>
>>
>>> -----Original Message-----
>>> From: Andy Shevchenko <andy.shevchenko@gmail.com>
>>> Sent: Thursday, September 1, 2022 12:17
>>> To: Limonciello, Mario <Mario.Limonciello@amd.com>
>>> Cc: Hans de Goede <hdegoede@redhat.com>; Mark Gross
>>> <markgross@kernel.org>; Platform Driver <platform-driver-
>>> x86@vger.kernel.org>; Linux Kernel Mailing List <linux-
>>> kernel@vger.kernel.org>
>>> Subject: Re: [PATCH v2] platform/x86: wmi: Allow duplicate GUIDs for drivers
>>> that use struct wmi_driver
>>>
>>> On Mon, Aug 29, 2022 at 11:20 PM Mario Limonciello
>>> <mario.limonciello@amd.com> wrote:
>>>>
>>>> The WMI subsystem in the kernel currently tracks WMI devices by
>>>> a GUID string not by ACPI device.  The GUID used by the `wmi-bmof`
>>>> module however is available from many devices on nearly every machine.
>>>>
>>>> This originally was though to be a bug, but as it happens on most
>>>
>>> thought
>>>
>>>> machines it is a design mistake.  It has been fixed by tying an ACPI
>>>> device to the driver with struct wmi_driver. So drivers that have
>>>> moved over to struct wmi_driver can actually support multiple
>>>> instantiations of a GUID without any problem.
>>>>
>>>> Add an allow list into wmi.c for GUIDs that the drivers that are known
>>>> to use struct wmi_driver.  The list is populated with `wmi-bmof` right
>>>> now. The additional instances of that in sysfs with be suffixed with -%d
>>>
>>> ...
>>>
>>>> +/* allow duplicate GUIDs as these device drivers use struct wmi_driver */
>>>> +static const char * const allow_duplicates[] = {
>>>> +       "05901221-D566-11D1-B2F0-00A0C9062910", /* wmi-bmof */
>>>> +       NULL,
>>>
>>> No comma for the terminator.
>>>
>>>> +};
>>>
>>> ...
>>>
>>>> +static int guid_count(const guid_t *guid)
>>>> +{
>>>> +       struct wmi_block *wblock;
>>>> +       int count = 0;
>>>> +
>>>> +       list_for_each_entry(wblock, &wmi_block_list, list) {
>>>> +               if (guid_equal(&wblock->gblock.guid, guid))
>>>> +                       count++;
>>>> +       }
>>>> +
>>>> +       return count;
>>>> +}
>>>
>>> I haven't deeply checked the code, but this kind of approach is
>>> fragile and proven to be error prone as shown in practice. The
>>> scenario is (again, not sure if it's possible, need a comment in the
>>> code if it's not possible) removing an entry from the list in the
>>> middle and trying to add it again. you will see the duplicate count
>>> values. That's why in the general case we use IDA or similar
>>> approaches.
>>
>> It shouldn't be possible to add/remove from the list, they're fixed
>> lists that were parsed from _WDG.
>>
>> Hans - since you already took this into your review queue, can you
>> land fixes for the 3 things Andy pointed out before it goes to -next
>> or do you want me to do a manual follow up for them?
> 
> I can do a local fix and squash it into the original commit.
> 
>> 1) Spelling error in commit message
>> 2) Remove comma on terminator
> 
> Ack, will fix.
> 
>> 3) Add a comment why guid_count is safe (if you agree with me it is)
> 
> I agree it is safe.
> 
> Can you suggest some wording for the comment please ?
> 
> Regards,
> 
> Hans
> 

Maybe something like "_WDG is a static list that is only parsed at 
startup, it's safe to count entries without extra protection".
