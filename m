Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EE7C5B21F6
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 17:23:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231785AbiIHPWa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 11:22:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232258AbiIHPWW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 11:22:22 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2067.outbound.protection.outlook.com [40.107.244.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5C8BA032F;
        Thu,  8 Sep 2022 08:22:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bTpVA47AenNW7l1ROGz28Bu8IsTfoKWGbSGwrP0yiom56M8t7r5T/LV0tJYTCyb9d8H8xSwR2j0NbT3gP2da/hN90dYjq2jtf8eAOMDBKdDlu0rokze0p9FZoQ8bCODi/wmIdm05dMeGe2iTFUxtPuxxLsPLPNbFWXrNkjeAXn0wzsK/sJwAE3CQpZRQKCyRzKDaDae3+umSq6c2gorh529Xg5SesQm3EAkdy7ivmeNwVkfBJ1v7SDj7sropqmZWGZQ+GzZz4wv28n5TG8B+3/+VY4CSK9XvXqxjot1BrdzUPXPjIzOH+uvZSwQXzXKtRXlhqlczQbLUiGG0Y2IHTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Euf6Ud+EJOGPJfFlnWTP0fKnNz+2wAad6gcQkGQUsCA=;
 b=fmlYiDELr+n6KfO/aZYLVU3k9VeahY03AR6vHjbfSt7HU3sJu3VE87hl7ntHTmhPBdZhBNAxh95n0cWyjBn1JnlhEJNX7OXCOk5dJ+oxbk7Rh1P2JEP2VMLpU39Gi13aSWR3n4KQ+59BdTcWYkUOMRhUWsH5JWTv23Pi2x3jaMw6iWrdEa13f0HrP+TSuV1yZ4NEaQm3i7CqNOQaIAMuTV5U/2q1zKfVICViae+Rg5TrCtmSdr6Y+O9Nvugc/gCTld9yIqyUBTSVRfbyewM0TMl6pBQzJ0cs1NrFguk0E6D9Uf/c7f621vjRDte2vyXaDG1sHdDqmFW/0R7ZVZW5XQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Euf6Ud+EJOGPJfFlnWTP0fKnNz+2wAad6gcQkGQUsCA=;
 b=N/CE24+Sjn6wdynZ61Z4guqb6arnD1YaveLDm2lbqFuSvjKVi2KjwkNe0x5sO8FUWPqKtH9hxphIEyj8IHt5SFppa0CfGE1pdrj5q15vVI+SNffCW/qYYHxj2aSvNgFG0rrt5T9bYz6zLaXFCFLIBlV9QaBLWnZlaxVZGMAaxKs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by DM6PR12MB4283.namprd12.prod.outlook.com (2603:10b6:5:211::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.18; Thu, 8 Sep
 2022 15:22:17 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::8ba:6e9:9e9c:da5]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::8ba:6e9:9e9c:da5%6]) with mapi id 15.20.5612.014; Thu, 8 Sep 2022
 15:22:17 +0000
Message-ID: <312d7781-671c-3765-a7d9-690d032650ec@amd.com>
Date:   Thu, 8 Sep 2022 10:22:15 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH] thunderbolt: Resume PCIe bridges after switch is found on
 AMD USB4 controller
Content-Language: en-US
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc:     "mika.westerberg@linux.intel.com" <mika.westerberg@linux.intel.com>,
        "andreas.noever@gmail.com" <andreas.noever@gmail.com>,
        "michael.jamet@intel.com" <michael.jamet@intel.com>,
        "YehezkelShB@gmail.com" <YehezkelShB@gmail.com>,
        "Mehta, Sanju" <Sanju.Mehta@amd.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Tsao, Anson" <anson.tsao@amd.com>,
        Greg KH <gregkh@linuxfoundation.org>
References: <20220905065622.1573811-1-kai.heng.feng@canonical.com>
 <YxWlc1n4HRxawa/K@kroah.com>
 <DS7PR12MB60959AACEDB0AEFEE78A5B2EE2419@DS7PR12MB6095.namprd12.prod.outlook.com>
 <CAAd53p5cz0VWUH9Rdvk70pcpY-PLc9SV8UCvMEc0+TBGES5W5w@mail.gmail.com>
From:   "Limonciello, Mario" <mario.limonciello@amd.com>
In-Reply-To: <CAAd53p5cz0VWUH9Rdvk70pcpY-PLc9SV8UCvMEc0+TBGES5W5w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL1PR13CA0097.namprd13.prod.outlook.com
 (2603:10b6:208:2b9::12) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|DM6PR12MB4283:EE_
X-MS-Office365-Filtering-Correlation-Id: 29c1627d-8518-4142-ae9c-08da91adea8c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LT7nkcg3dI5gGA4NB9RX0VL4E7bpLRClzuNJ/df4DS2sqweiByWxQsyClrINkE1TgeNQY9kdTcXFsDEhs7IKkQQYFSay8QIjqim/rVYEcsSIbBKkhu0lP1msWerR9o35ladHxLvkHrJTq1ZF2P0SBjwPEtqmRp+PWD18r89pCh5pC3dk0oW69/1vfnfTvV0U7qx0/uVPFafgPkw0UqJkOTJB/gRYE7CMNrIQwddpQAHP37+YWqDFKHRU8C59CcwvVJd45K3WAWrd6UYpwJVgBao8XU1UBru4kcZ25n3gDyzMlDv2Y7k+9f6wScdjJmT4SOh9Knb90hJNKiBKQZan+OsuxYrx5nDATKA6x/Al+SM/Zzeua6RjJHS+SHXQN2clh8BovqeENd7U8l1spcdi16s2WLkkB/k+/xIB+TZMzujIe86ACt9/2Od4W0y13LkOHFooHCpHnObBvoKVTWEvDBNvNX8j4vhEc1YkcU0Dm+2tW4EfMRsADZ0zERYuIXLoOjV856ePwGt8jZVxNdeqFSUWL4ywLhTu6C6Re8O3zzGg2++qmJ6Ir5Zt1q+ESJWznrwsBAho9ON487oNxSgEOFayeMKKplHrviBaJ38M/dOIEzl2KrxoLyHOyI5+45da4zWHy4cwiTXr5Q1DIZropoJm6wvCZZrZKi0GwxXD4/XCvKB89w7uA27eNJfGbzSTEZ2uzDbqJS508u7tU1bmsv638dtI0/mE4mCDBIRKmlv7iX2dnO+kbuK1w3D981Quo5pNlBWo2HvQ1G7yhNUT6snyYGOFVcd2nIEj6cJg4KzlpdgkXurfWzLgg0OPgee5
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(396003)(39860400002)(376002)(346002)(136003)(83380400001)(8676002)(66556008)(4326008)(66476007)(66946007)(41300700001)(45080400002)(54906003)(316002)(31696002)(2616005)(186003)(36756003)(86362001)(31686004)(6916009)(6512007)(26005)(5660300002)(2906002)(53546011)(38100700002)(6486002)(6506007)(478600001)(8936002)(966005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q2JJWFAxSjZETUVyZTUyZm9NRUtFSGpncjlOL2R6T1JWUEhnZmp2QVBpV2t5?=
 =?utf-8?B?Z3hkeUlQclpQMC9OYTVtOU9VYjJEMEplNG5GMjJGT1ZXaW91R0V1LzNzZ3VJ?=
 =?utf-8?B?amNCV2kwVUdFZGRVclBJNHhZUmpkN3g1RWxzSis1TXpueS9HNEZiTVJuZm5i?=
 =?utf-8?B?TnRwcUNRaHVpODVuZUtFc0I3V0RJV2ExSVB5N2J1YmNjY09JNkluTkFiU2dq?=
 =?utf-8?B?eXU4ajlXNmlyeXhxSm1uY2VodU9Fdng0c0g1ZDNaOGpyWFZGSEg3VXdHZEFW?=
 =?utf-8?B?NHpzMHdJaTBjQm9lTDRMRDNHTW0wa2h2Q1VLTHM4N3NuRytNTmVySk1iRWc5?=
 =?utf-8?B?dHZHTk5vblRzdTZKL2ZyVzB1SzVYWURVZnhERzR4NEpmWjh3bHBLK2JDdXM3?=
 =?utf-8?B?Z3RQTVZwUGc0L1ZQVExDZHpieFdlanFvUmtOb2FuQUExOENpNlhGUDgxS1NC?=
 =?utf-8?B?QWpqdHg2bHV6bnVjYkhIbzlJMnVTODdpN1diaGRMU1FCOWFQY3d0cFZHTE8v?=
 =?utf-8?B?RlhiRjhDNHl6Y0JlWDkxOUlwNEtLdGVLbFpWZWJOb2d3ZmlRbUxQZlM0WWoy?=
 =?utf-8?B?TVRNV0Z3MkZoNThPdjkvcTFyQkdlUFdMTVcxdDRLUWplMU9xaFpScTR2L1JD?=
 =?utf-8?B?OEdEaFh6SXQzS003ZklYQlQ5VWJha1ZoUFR4a0ZmY2diQUxzK3pNR3RFbUJW?=
 =?utf-8?B?NzlhVFRlM1dYcXhYcFNnUVpJdndWVmFtSWVzVHBQVVdBNFEyU09YYUJMazE0?=
 =?utf-8?B?ZUxwYlNVc3hFRUpLaEI0TWh4aDMrdHFkQUc0czYxdXFZNVplNjV4R0t3ZG1K?=
 =?utf-8?B?dU00N3lEOFc4T2NuS0gwVkNRMzBhQ1ZVdi9iR3hoaGxNSDhHOWRUbTl4bE5h?=
 =?utf-8?B?SlYxTnhNQVRIVDErSGptQ2tJVkY1YVZGQzVGbVZSTkIza1AxNGt6N2toOGxl?=
 =?utf-8?B?VzZXWU5haUd1bG9weStkNVdwSTFoamFlM0dQZFRpOEh2eFVHaFhuanhmbzhX?=
 =?utf-8?B?aHdlQnVva1pxSUY2Um9QYmJ3Z0c0OWtjY1Y4MGsybVI0b3VLTEtqVCs5aGk1?=
 =?utf-8?B?Z0x6VER5K1lNYXFheUJMRS9LSFJBajE4L29JSUgwblRpaHhUcjNPTXR1NWE2?=
 =?utf-8?B?bjlpUy9kcXFxSlh0RWl2NUNYd3lHNDg0K1JXUytSUEF5WXZxdFhBT2UxVGFP?=
 =?utf-8?B?c2JWWk9Xd3JQM2w4M255QVVWblpjeUZkTUZOcVZCWjh3WllGejhUOGRCTm5G?=
 =?utf-8?B?b1lXUlZWZlZpMHlsdTMxS2lZMzVJa25PYlM1QVNPUHg2Q3lJSHFndVpsZFFY?=
 =?utf-8?B?cTN0Y2FXL1hkT0hQdnEramxINWtydzNab3N5Tnl2QUVYWUYydlU2L1FhODhB?=
 =?utf-8?B?RUhVYzM5TFM2TlRBaVlLczZ5eUg3ZG1tNTRicnQzbnEzQVhXdG0xbnNDNnpW?=
 =?utf-8?B?TU5ZTFFUSGRva0llN1NvaUp4R040enM5eDVoaWZpRW1lZ1p0Qzd0R1hWWGNx?=
 =?utf-8?B?bit4eDdoK3EvTWRKNmdZSUxkUG1ORmlzQ0JqOU01aXdDbEM2MEw3aHJwMnhL?=
 =?utf-8?B?RlZ2dEg4MUh5Zm5VbU9DMUJZM0FrSWZVbWRmNnJYcGJLM1AwVnFrYnhzckE4?=
 =?utf-8?B?bm50SzA4UU1ITktGT0cvbTNRWmZNcFhxWm9JVStTbGc4US8vaG52Rmk5WWtz?=
 =?utf-8?B?QmVKOERUbnk5WWxrMzVlNElJUlgzWDd2SUpEeXZSaW5sOVFOTjhQazRsVk51?=
 =?utf-8?B?aFFQTEo0UHFiYmVCeDNYamtBN2VhdzJEY2xSc1R3SnIyY2hUT0kxMHBvV0ZP?=
 =?utf-8?B?ZzJPaCs4MUpQRlJLbDR4VTFKY1JUMC8waXlLMitsQ2J2c202a05VeDNLWFY5?=
 =?utf-8?B?NHl2bCt2SnJiaGpoN091OFV4M2VPWDB2bW9HVFliRFZURitldGpaME9vbVNQ?=
 =?utf-8?B?enFoMkl3VEZLZVU2Y3JmS2JKREx2OTEzY2U3WVRaRnFzenBQcWpkMTNFU2Z1?=
 =?utf-8?B?UndHRVhzc21DRTNSZmpHazB6Y3VRTDhMdEJncXpzRWJjN3cweFdWSVZhU0Nj?=
 =?utf-8?B?QUx5VHhKbHpZWlBhb0dLYkhUcTdoRmRCRVNwOG9YclNkaDc2dFZJaWRKbVFx?=
 =?utf-8?Q?kUI7qdqoaLhxGgeWnuOMz5I7j?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 29c1627d-8518-4142-ae9c-08da91adea8c
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2022 15:22:17.7898
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dCLB3tskMumg20EGUwSsYqJU3IHeZRYpb3V3KHQ23TmHwxhpcj8IQRXA8cdOQLFG8vbwrTECXXjgqKiMNAkP8Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4283
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/8/2022 09:02, Kai-Heng Feng wrote:
> "
> 
> On Thu, Sep 8, 2022 at 12:30 AM Limonciello, Mario
> <Mario.Limonciello@amd.com> wrote:
>>
>> [Public]
>>
>> Hi,
>>
>>> -----Original Message-----
>>> From: Greg KH <gregkh@linuxfoundation.org>
>>> Sent: Monday, September 5, 2022 02:30
>>> To: Kai-Heng Feng <kai.heng.feng@canonical.com>
>>> Cc: mika.westerberg@linux.intel.com; andreas.noever@gmail.com;
>>> michael.jamet@intel.com; YehezkelShB@gmail.com; Mehta, Sanju
>>> <Sanju.Mehta@amd.com>; Limonciello, Mario
>>> <Mario.Limonciello@amd.com>; linux-usb@vger.kernel.org; linux-
>>> kernel@vger.kernel.org
>>> Subject: Re: [PATCH] thunderbolt: Resume PCIe bridges after switch is found
>>> on AMD USB4 controller
>>>
>>> On Mon, Sep 05, 2022 at 02:56:22PM +0800, Kai-Heng Feng wrote:
>>>> AMD USB4 can not detect external PCIe devices like external NVMe when
>>>> it's hotplugged, because card/link are not up:
>>>>
>>>> pcieport 0000:00:04.1: pciehp: pciehp_check_link_active: lnk_status = 1101
>>>
>>> That sounds like a hardware bug, how does this work in other operating
>>> systems for this hardware?
>>
>> We happen to have this HP system in our lab.  My colleague Anson (now on CC) flashed
>> the same BIOS to it (01.02.01) using dediprog and loaded a 6.0-rc3 mainline kernel built
>> from the Canonical mainline kernel PPA.
>>
>> He then tried to hotplug a TBT3 SSD a number of times but couldn't hit this issue.
>> I attached his log to the kernel Bugzilla.
> 
> Nice to hear. Hopefully this can be fixed at firmware/hardware side.

I guess you and Anson might want to sync up offline and compare whether 
you have the same hardware stepping.

> 
>>
>>>
>>>> Use `lspci` to resume pciehp bridges can find external devices.
>>>
>>> That's not good :(
>>>
>>>> A long delay before checking card/link presence doesn't help, either.
>>>> The only way to make the hotplug work is to enable pciehp interrupt and
>>>> check card presence after the TB switch is added.
>>>>
>>>> Since the topology of USB4 and its PCIe bridges are siblings, hardcode
>>>> the bridge ID so TBT driver can wake them up to check presence.
>>>
>>> As I mention below, this is not an acceptable solution.
>>>
>>> AMD developers, any ideas on how to get this fixed in the TB controller
>>> firware instead?
>>
>> Anson also double checked on the AMD reference hardware that the HP system is built
>> against and couldn't reproduce it there either.
>>
>> KH, I've got a few questions/comments to try to better explain why we're here.
>>
>> 1) How did you flash the 01.02.01 firmware?  In Anson's check, he used dediprog.
>> Is it possible there was some stateful stuff used by HP's BIOS still on the SPI from the
>> upgrade that didn't get set/cleared properly from an earlier pre-release BIOS?
> 
> We used UEFI capsule to update the firmware, via fwupd.

So that's a difference from how Anson did it.  Could you perhaps dump 
the BIOS SPI image?  Anson can flash the exact same dump via dediprog 
and see if he can repro.

It would let us confirm if it was caused by your upgrade path.

> 
>>
>> 2) Did you change any BIOS settings?  Particularly anything to do with Pre-OS CM?
> 
> No, nothing in BIOS was changed. >
>>
>> 3) If you explicitly reset to HP's "default BIOS settings" does it resolve?
> 
> Doesn't help. I put the device to ACPI G3 and it doesn't help, either.

OK.

> 
>>
>> 4) Can you double check ADP_CS_5 bit 31?  I attached is a patch to kernel Bugzilla to
>> add dyndbg output for it.  If it was for some reason set by Pre-OS CM in your BIOS/settings
>> combination, we might need to undo it by the Linux CM.
> 
> All ports say "Hotplug disabled: 0".
> 
> dmesg attached to the bugzilla.

OK, that at least rules out DHP from Pre-OS CM.

> 
>>
>> 5) Are you changing any of the default runtime PM policies for any of the USB4 routers or
>> root ports used for tunneling using software like TLP?
> 
> No. And they should be suspended by default.
> 

Thinking about this being possibly a firmware upgrade path problem, can 
you please check:

# grep SMC /sys/kernel/debug/dri/0/amdgpu_firmware_info

Anson's system was 0x04453200 (program 4, version 69.50.0).

> Kai-Heng
> 
>>
>>>
>>>>
>>>> Bugzilla:
>>> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fbugz
>>> illa.kernel.org%2Fshow_bug.cgi%3Fid%3D216448&amp;data=05%7C01%7Cm
>>> ario.limonciello%40amd.com%7C1e27b1d6f69e42796c7b08da8f107121%7C3d
>>> d8961fe4884e608e11a82d994e183d%7C0%7C0%7C637979598042186185%7CU
>>> nknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI
>>> 6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=0lhcaKfUyoK
>>> 0FXT9uDZ8a%2Fpxs9tHd8aoQcyPFdB%2F0eY%3D&amp;reserved=0
>>>> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
>>>> ---
>>>>   drivers/thunderbolt/nhi.c    | 29 +++++++++++++++++++++++++++++
>>>>   drivers/thunderbolt/switch.c |  6 ++++++
>>>>   drivers/thunderbolt/tb.c     |  1 +
>>>>   drivers/thunderbolt/tb.h     |  5 +++++
>>>>   include/linux/thunderbolt.h  |  1 +
>>>>   5 files changed, 42 insertions(+)
>>>>
>>>> diff --git a/drivers/thunderbolt/nhi.c b/drivers/thunderbolt/nhi.c
>>>> index cb8c9c4ae93a2..75f5ce5e22978 100644
>>>> --- a/drivers/thunderbolt/nhi.c
>>>> +++ b/drivers/thunderbolt/nhi.c
>>>> @@ -1225,6 +1225,8 @@ static int nhi_probe(struct pci_dev *pdev, const
>>> struct pci_device_id *id)
>>>>   {
>>>>      struct tb_nhi *nhi;
>>>>      struct tb *tb;
>>>> +   struct pci_dev *p = NULL;
>>>> +   struct tb_pci_bridge *pci_bridge, *n;
>>>>      int res;
>>>>
>>>>      if (!nhi_imr_valid(pdev)) {
>>>> @@ -1306,6 +1308,19 @@ static int nhi_probe(struct pci_dev *pdev, const
>>> struct pci_device_id *id)
>>>>              nhi_shutdown(nhi);
>>>>              return res;
>>>>      }
>>>> +
>>>> +   if (pdev->vendor == PCI_VENDOR_ID_AMD) {
>>>> +           while ((p = pci_get_device(PCI_VENDOR_ID_AMD, 0x14cd,
>>> p))) {
>>>> +                   pci_bridge = kmalloc(sizeof(struct tb_pci_bridge),
>>> GFP_KERNEL);
>>>> +                   if (!pci_bridge)
>>>> +                           goto cleanup;
>>>> +
>>>> +                   pci_bridge->bridge = p;
>>>> +                   INIT_LIST_HEAD(&pci_bridge->list);
>>>> +                   list_add(&pci_bridge->list, &tb->bridge_list);
>>>> +           }
>>>> +   }
>>>
>>> You can't walk the device tree and create a "shadow" list of devices
>>> like this and expect any lifetime rules to work properly with them at
>>> all.
>>>
>>> Please do not do this.
>>>
>>> greg k-h

