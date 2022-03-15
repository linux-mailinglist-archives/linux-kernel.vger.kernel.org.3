Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFCA04DA274
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 19:36:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350999AbiCOShb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 14:37:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236091AbiCOSh3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 14:37:29 -0400
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam08on2070.outbound.protection.outlook.com [40.107.102.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E76E5483B4;
        Tue, 15 Mar 2022 11:36:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DFmzCo1CH65fD6dJ2gSFb/Ztzl15b8GDv75AvIfDQFlkemkwMhXeR6ASwJwEgHr9fqbtsaNrD0UUTioO2xGC+LLnhKPWtROgKJmTo6Y7lsrFqGNiedaLKrd0G58GJtOM4HjjWESCBzB3sGGhnlItzve6gN+btOhhs2Q8JDwyls5+q1rEkFsWwNjCeQgQvKXUAyjX5ecmVzIPoEvEJgoWXEvoGPMDsDJ1omnwuaeoR2QE0gAW2mj9CCiwMv+LRhHRVfw6oDR5UPP8jNh7jVSzDRbk5yYivTbyHEa2uNUJ5oEi+4XjnjEKnhEjUoI7MABAJVs0nxGQjOAN7rSVYjc0QA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v7u932eFtFTu8Ax5NhJ5Jyslo5hbYj5zmxEjVk4EA8Q=;
 b=TcC/sSEq8tq9MtGPR/sKdd11sKTIdzB5tjgEUbZoga5wgN8GTcHeGjY0jmAO5nm5434b10G5xbb1CaLrxPHE8lRMfxldWYWsUEoVw52ejS/zV1J+dYiuNxrZqkwnUGNx+0KTp+PikEvXtl+OeITmQAW7yB+Wczx7ZzJM+tvVcjAWB09iQGLUOigNeiIVQF4M7xb8biwqFz+O1cbi+48LdU6wCbiLm+MWx1tDBbTfpMU2L7Kc00qU7bmc9GUgbCDQOXqYTUnnpookLOVXqoNOhOPH7rQrsZo0L9e/JoKDnK3jfnEPNI0BQ8SuOzV8Pt9qCrN0wlg+8FyMmhqOUSljpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v7u932eFtFTu8Ax5NhJ5Jyslo5hbYj5zmxEjVk4EA8Q=;
 b=OKq1bBDmsVORI8Ds8zWmilQV7ofXZ0/UhpNXiW+hdi3por8GZyZ4Ipe5Nl6tLO6nQMKivVFg2cpFHEi/YE7e6/WpJ3EmBD4ciwszycKX06wnQxaxlpdjOJfMn/M4rqX6EkV2mxJVuFevPb3vk0B7ZVJA8jmwigSCTvdTOgibsi4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5157.namprd12.prod.outlook.com (2603:10b6:208:308::15)
 by CH0PR12MB5332.namprd12.prod.outlook.com (2603:10b6:610:d7::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.14; Tue, 15 Mar
 2022 18:36:14 +0000
Received: from BL1PR12MB5157.namprd12.prod.outlook.com
 ([fe80::692d:9532:906b:2b08]) by BL1PR12MB5157.namprd12.prod.outlook.com
 ([fe80::692d:9532:906b:2b08%5]) with mapi id 15.20.5081.014; Tue, 15 Mar 2022
 18:36:14 +0000
Message-ID: <7d588dfa-aa57-7be1-9cbb-61897f81bf99@amd.com>
Date:   Tue, 15 Mar 2022 13:36:11 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH 2/2] thunderbolt: Use pre-boot DMA protection on AMD
 systems
Content-Language: en-US
To:     Robin Murphy <robin.murphy@arm.com>,
        Christoph Hellwig <hch@infradead.org>, christian@kellner.me,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     Michael Jamet <michael.jamet@intel.com>,
        "open list:THUNDERBOLT DRIVER" <linux-usb@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        "open list:AMD IOMMU (AMD-VI)" <iommu@lists.linux-foundation.org>,
        Andreas Noever <andreas.noever@gmail.com>,
        Will Deacon <will@kernel.org>
References: <20220315162455.5190-1-mario.limonciello@amd.com>
 <20220315162455.5190-2-mario.limonciello@amd.com>
 <YjDDUUeZ/dvUZoDN@infradead.org>
 <BL1PR12MB5157D7B7734122684D47923AE2109@BL1PR12MB5157.namprd12.prod.outlook.com>
 <21d33a75-8c0e-7734-b3d1-dbe33cfe0ab0@arm.com>
From:   "Limonciello, Mario" <mario.limonciello@amd.com>
In-Reply-To: <21d33a75-8c0e-7734-b3d1-dbe33cfe0ab0@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BL1PR13CA0206.namprd13.prod.outlook.com
 (2603:10b6:208:2be::31) To BL1PR12MB5157.namprd12.prod.outlook.com
 (2603:10b6:208:308::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a8c21d68-1c8b-4110-46c7-08da06b2af19
X-MS-TrafficTypeDiagnostic: CH0PR12MB5332:EE_
X-Microsoft-Antispam-PRVS: <CH0PR12MB5332C0A6F20463B7813C726CE2109@CH0PR12MB5332.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kJ3cWx5ZyN6WCny6GrEe84HutucFTsXcVRbS9s60RsotRjbrbcODZDJ1JlKJFqImmI+7ZOSB1Vo/M4JT3ovWm3bjpCyr1SUfYrgxHjNEMjKhqAc3LMPhrN2NVbjh0FfeM52A9FxdOTS/lKnSeonuCxwP+lvj48cwZdIUGZDABDlzmsar8Mm6yElH+IW0cQDnafBjjrXzy1ZCeK5cbCxE31msKUH9zthLw4u72AtCVZZvUTh7C7pvSn2iOIpLigC+y+1e6lmVVbW9kJOar7331aRuX4uINKih0/5p6Q+EaaW5s3SH/toiNB/vIOJFluiN/4rzqgDSjrJJ9h+NOwz05BH2KMoj8ac5rvU0RtGxja+UfyCHMb3Hof+pFq5u5oAaq00NQCjnO9KWWpCE0h0vXBx9jEWuB0nn6uo3se/CilkdNe1IuXnWT5IrFnvBRDmuAL+lEItnHMs7LXp9LHuj0hzCpsK89J7NiJFKSV4N8zLY+42mBGiFs5sNKEWobx4ojoERGcIVwuWCyR3wnubxg2zloMtPQiL8uj5L/jgvaBUad7iEZYf4C6APTm3ZwXVu5QJvwfVDWNkwJDvGutkJrw/TKxTJpwuEdrUNDwzz8Uuucmx16Wqq/m01LWGfxSvEPTSk9zMB8oPbrzBYvE/fnEPpc68SZh0avOIjs80PreKT8Xo/f5qCpV62Gd9lxYCyQT4orkr4eqIhyXT061bhG2fgvsNeoJKD4wtKOpZl8MTUeKLz3sTNdqnPP7xYIHwSzBktPwKY+voMJIdWUiZQsSqO3TlJULUTbhwKM0++GT5jsxKUX6kA4ySmu6ypUIzqrcgDYegwiEUQMrklvFULmqNCEZPyoDEm+PzQ0D/Kn8o=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5157.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(2906002)(45080400002)(966005)(6486002)(26005)(186003)(5660300002)(8936002)(36756003)(31686004)(6666004)(7416002)(508600001)(2616005)(31696002)(4326008)(53546011)(86362001)(6506007)(54906003)(110136005)(316002)(6512007)(66946007)(66476007)(66556008)(8676002)(83380400001)(38100700002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UUNSamM5SEE3a3hoTW5mWmZQaFB0dnB0YlBhdlFsTGNGSHFmaFBrc0J6cy96?=
 =?utf-8?B?T1JDWmlHZFpCVkZGODNtanFMNVlrTFJZQytFK2NMME1iZm1LREFiSEdGMjRx?=
 =?utf-8?B?WnJZazIvMlRERWdNZEtVV1k5NDdzbkFESDIrOTBPMEFWVUt1bXlKYTUzZ1Fs?=
 =?utf-8?B?Zm9MMUxsVWl2M2M1UzZmKzlEYUc2TDFGeG91dE1Wci9zaUxQS092bWRzMkds?=
 =?utf-8?B?NC9rWkFJaXZhOWVQMnpzdjVycmtyOVVCUElSckdBV0hUSGEwanJnS2g0YWZH?=
 =?utf-8?B?K3hVaVNYakh0N2tTZ054VlNUUHp3RkJUN25wQ2cyQTZzWGpYVDRXQUZlSDIw?=
 =?utf-8?B?ZGFPdDlYWlhMK1JQZHhaL3VJcW1NUUhtMStVc0ZtRklvTEczZFFFNHBVMTQ3?=
 =?utf-8?B?dHVrbjNsaFdKWVAxWWFyK09TZklnSVhoK2NnZWNqMVgrdnJ1MktKL0hhODNz?=
 =?utf-8?B?VDNBSjZ0eGY3NUdXMVRYVWhvTXE4ZmpRRUtqQlZFMUNNMnlySDVEdGVwbFNh?=
 =?utf-8?B?YWJDSXFRbzFwTEx6RFF1RUxRQURodVZpMXprUU1kaS9qVXlsSm9jdjI3TnVO?=
 =?utf-8?B?cUE5bWhkQjNrdXArVUsrT1V1cU5QMmFUTnhmbzNRQzRjUVE5UGR4VWFRMmpD?=
 =?utf-8?B?VDVVbGlTaWYwczNFakYyRWM0YlVIRVhMSExGSzMram8rWUtwZDYvK2lDdHk1?=
 =?utf-8?B?VUFkYWl5MC9uRkJyakRjK005UmVVY3BLMVRRM0xqb1pZb3lTTVNnSk9aTXZT?=
 =?utf-8?B?UndFWEc0ZE91TnBIZVpUT1lTRHFMdG52aTZMOFR3c1hHSzg4OERHTzVKVndj?=
 =?utf-8?B?V0xRQkhqODV0RlNJRHUvL3p3OWVoUVhqNncwQzlOQXFhdCtleElmZkdlUzNk?=
 =?utf-8?B?V2xqb0didFB3TU1NTlVxQ1dzWmhMY2x3cXQxakZweThSa05pSnRFWTk4dTd3?=
 =?utf-8?B?T3k0Z093THVZandrVFIvcFJKMkhkOUtFL2VLeFlpUy9mWGNzc1R5U2dWVksy?=
 =?utf-8?B?UytGcWRoNytwUGZZbE5Dc1orSjUzSXZVdjRDclZ4TXNacm5vcC91am9EeVBU?=
 =?utf-8?B?MkN6eWx6T09jNkpjcUZUSG5wblJaMUxBdUFuVlVKK0o5OE8rYTNkMjBJSTFN?=
 =?utf-8?B?QTJ0amZFbXhQb25MUFJkNjdnYTlBNlpqWlllZkF3OE5qQXRVS0E5ZWEydEdn?=
 =?utf-8?B?NWFla0tETWR0K0JCYmdpWVNNQU5mWUhxcW9URllaNmlRMng3SGc3bXVIVWEr?=
 =?utf-8?B?K2NRdW9YYmcycHlkZkFMMU5wMmNhYkJSWXYvSFl3cmpDcHB3QWZEZjZ5cUdY?=
 =?utf-8?B?S29HNllhWCtHRkdSOGpnOFhDOXQ2WGVsZ3pzT3pHc2Nrd25abEpWSjF3YTdB?=
 =?utf-8?B?NXFQYzQvMmlBTmR3dEt1djNkeG45QmxHL2xOM3MzVW5QUzE3VWxETHNJei9v?=
 =?utf-8?B?c3VIZ3pUVXhmYWUrZnJFcUl2N1N5dEduMTBWUFJqR1pHVEU1TDFTcGNTUmYz?=
 =?utf-8?B?MjJlWVI0TlhibjgrbWdEWXNJNEJyN3NqWVQ0Rlp4WjNZZ05XVWVGRDkxckh6?=
 =?utf-8?B?MllXczkwbUt4R2ZKWjd6Nlg3Z0xOMFJZOCtFM0xxd3lKL3IwWWg5NGl2a3p4?=
 =?utf-8?B?dUZ2SUVhczBiRGdEK1NOdnpoTndjT3BTZ0hNbEdqS3M0YWxqbVY2Sk92MndQ?=
 =?utf-8?B?bkY0aUJOMkprdWg5YUlNL1V3Y3Z5OHNrZVJ6SW5iam5vQjFMWUE0SzhacWRF?=
 =?utf-8?B?TC9oUmpLNHRpRXBZTS9zcE1CU1N6bmJZUmFwaUZjZjJVT1ppYVRIVjVsYU02?=
 =?utf-8?B?MEg4cGxjWkloWjFPR0haQlgvOTlkNnpYWGRMTE1TeUpwVnZvTUFsblI5STVU?=
 =?utf-8?B?TzFWMERzNEpRNmVtMzloNWF1R1BhZXVBVkdaZ20wYVdmYmRCekFUa01uNDZq?=
 =?utf-8?Q?wNiKm3PyebLKutQt9VIEgbqbxcdSsE2p?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a8c21d68-1c8b-4110-46c7-08da06b2af19
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5157.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2022 18:36:14.0460
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hPx5wPzMGfn56y5uEaZXtrzdrGfmmOBbIjtviesH6iiUHrtlKpYRfN2AKpyyu3jTrm+9Mev4IUOO3hK63RIRlQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5332
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+ Christian Kellner (Bolt userspace maintainer)

On 3/15/2022 13:07, Robin Murphy wrote:
> On 2022-03-15 16:54, Limonciello, Mario via iommu wrote:
>> [Public]
>>
>>
>>> On Tue, Mar 15, 2022 at 11:24:55AM -0500, Mario Limonciello wrote:
>>>> -     * handled natively using IOMMU. It is enabled when IOMMU is
>>>> -     * enabled and ACPI DMAR table has DMAR_PLATFORM_OPT_IN set.
>>>> +     * handled natively using IOMMU. It is enabled when the IOMMU is
>>>> +     * enabled and either:
>>>> +     * ACPI DMAR table has DMAR_PLATFORM_OPT_IN set
>>>> +     * or
>>>> +     * ACPI IVRS table has DMA_REMAP bitset
>>>>        */
>>>>       return sprintf(buf, "%d\n",
>>>> -               iommu_present(&pci_bus_type) &&
>>> dmar_platform_optin());
>>>> +               iommu_present(&pci_bus_type) &&
>>>> +               (dmar_platform_optin() || amd_ivrs_remap_support()));
>>>
>>> Yikes.  No, the thunderbot code does not have any business poking into
>>> either dmar_platform_optin or amd_ivrs_remap_support.  This needs
>>> a proper abstration from the IOMMU code.
>>
>> To make sure I follow your ask - it's to make a new generic iommu 
>> function
>> That would check dmar/ivrs, and switch out thunderbolt domain.c to use 
>> the
>> symbol?
>>
>> I'm happy to rework that if that is what you want.
>> Do you have a preferred proposed function name for that?
> 
> But why? Either IOMMU translation is enabled or it isn't, and if it is, 
> what's to gain from guessing at *why* it might have been? And even if 
> the IOMMU's firmware table did tell the IOMMU driver to enable the 
> IOMMU, why should that be Thunderbolt's business?
A lot of this comes from baggage from early Thunderbolt 3 implementation 
on systems with ICM (Intel's FW CM). On those systems there was a 
concept of "Security Levels".  This meant that downstream PCIe devices 
were not automatically authorized when a TBT3 device was plugged in.  In 
those cases there was no guarantee that the IOMMU was in use and so the 
security was passed on to the user to make a decision.

In Linux this was accomplished using the 'authorized' attribute in 
/sys/bus/thunderbolt/devices/$NUM/authorized.  When this was set to 1 
then the TBT3 device and PCIe topology behind it would be enumerated.

Further documentation explaining how this works is available here:
https://www.kernel.org/doc/html/latest/admin-guide/thunderbolt.html#security-levels-and-how-to-use-them

(Intel based) Platforms from 2018+ w/ TBT3 started to use the IOMMU 
consistently at runtime but had this existing implementation of security 
levels to worry about.  Furthermore tunnels could be created pre-boot, 
and so the thunderbolt driver may or may not re-create them based on policy.

So a new attribute was created "iommu_dma_protection" that userspace 
could use as part of a policy decision to automatically authorize 
devices.  Exporting this attribute is very similar to what Microsoft 
does to let the user see the security of the system.

https://docs.microsoft.com/en-us/windows-hardware/design/device-experiences/oem-kernel-dma-protection

In Linux today some userspace software "bolt" has a policy included by
default that will automatically authorize TBT3 and USB4 (w/ PCIe) 
devices when iommu_dma_protection is set to 1.

> 
> Furthermore, looking at patch #1 I can only conclude that this is 
> entirely meaningless anyway. AFAICS it's literally reporting whether the 
> firmware flag was set or not. Not whether it's actually been honoured 
> and the IOMMU is enforcing any kind of DMA protection at all. Even on 
> Intel where the flag does at least have some effect on the IOMMU driver, 
> that can still be overridden.

Take a look at the Microsoft link I shared above.  They also make policy
decisions based on the information in these tables.

> 
> I already have a patch refactoring this to get rid of iommu_present(), 
> but at the time I wasn't looking to closely at what it's trying to *do* 
> with the information. If it's supposed to accurately reflect whether the 
> Thunderbolt device is subject to IOMMU translation and not bypassed, I 
> can fix that too (and unexport dmar_platform_optin() in the process...)
> 
> Robin.

This patch series stems from that history.  To give the best experience 
to end users you want hotplugged devices to be automatically authorized 
when software says it's safe to do so.

To summarize the flow:
* User plugs in device
* USB4 CM will query supported tunnels
* USB4 CM will create devices in /sys/bus/thunderbolt/devices for new 
plugged in TBT3/USB4 device
* "authorized" attribute will default to "0" and PCIe tunnels are not 
created
* Userspace gets a uevent that the device was added
* Userspace (bolt) reacts by reading 
/sys/bus/thunderbolt/devices/domainX/iommu_dma_protection
* If that is set to "1", bolt will write "1" to "authorized"  and USB4 
CM will create PCIe tunnels
* If that is set to "0", bolt will send an event to GUI to show a popup 
asking to authorize the device
* After user acks the authorization then it will write "1" to 
"authorized" and USB4 CM will create PCIe tunnels


Mika,

I wonder if maybe what we really want is to only use that flow for the 
authorized attribute when using TBT3 + ICM (or IOMMU disabled at 
runtime).  If we're using a USB4 host, check IOMMU translation layer 
active like Robin suggested and then automatically authorize from the CM.

Thoughts?



