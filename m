Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A80695638DD
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 20:08:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230370AbiGASA3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 14:00:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbiGASA1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 14:00:27 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2063.outbound.protection.outlook.com [40.107.220.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3A4A3ED32;
        Fri,  1 Jul 2022 11:00:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EZmlVZueHyWkQL079+1OtFnVw6HlnaG1QHSwm9SanmfxThSr8kPYUj/8MOWRRPXRVWKAj2dcHWy/6c8GWSDfJaO+BcyCA2toG+Tklvy9XrhrTUYmL+Ab2X7F4zhkxBBoqy+REBUadgGIRFsbaT+T/Rre7zLLQr4SvxK2bBFF6epybxF1ZlPTSpt7Bz55ISPkQADNIeHG1ckzScWxrBK5b9POMONpl+i2OcQjtLihZtuOj7LRE2sru0hu2qYcCSpGxR6CAYmTSPuLUB3zi89g2PDDTLWlygCjPeTjyFc22Lx94AE1dt8jqXmCQpg2o3q85stJQxGRXQfpG7ThKlq2uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dC2CbDhZ6A3B5jojum4C6uT5b9QvCpANhueXHzIT6Jk=;
 b=Z7LnIu93OBbqXbCL3LwhLR9/MIXB674lZGnkvVC5ArJ1yOOdLbGesSx87e5BHjKRkz/VVxmldJYRUrLEKSTmI0JG2Rbzpa3POCIr2VFqPM/5pibKqFNnvsa1zCPhyzn9L1DohYqheOjAqDjr1WPsYv0W5nPLp+uTVQRg3eavASaF6iCLL87huWDgFgTrQfQOWN9qR2sWZeofMGzIQXEGUJl378tY4fMWuVFr7Ckv04IaWopQXRIT3H/F2lUo/OdKrP1uSkdYJcamOAaAy8NxgmFXFfW0k3tdfpD7jBJ/B/NIHc0oEjkWmTc0kjZO9ymaPXlc7bINns9czEvGovFRyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dC2CbDhZ6A3B5jojum4C6uT5b9QvCpANhueXHzIT6Jk=;
 b=qthTxLvOQuKtpjZgc2+QfabTJe6dGoSl7abDz/lz3O9R2Pcr+9reyyUbgD46QpaHKjegJns7AS7xJ3Pk5QEf3ZtRUD5wzIf/SxkjTholT/UzNWphhqvjpSI8CqSe1qmFIITsqhdG0HX17ARU7W0+TEQ+Luu3PRzRTJ290/FQKxA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by BYAPR12MB2728.namprd12.prod.outlook.com (2603:10b6:a03:61::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.17; Fri, 1 Jul
 2022 18:00:19 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::1143:10a5:987a:7598]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::1143:10a5:987a:7598%5]) with mapi id 15.20.5395.015; Fri, 1 Jul 2022
 18:00:19 +0000
Message-ID: <d444c3e5-79b1-f6a6-10e9-e597b3227434@amd.com>
Date:   Fri, 1 Jul 2022 13:00:17 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v3 10/10] HID: usbhid: Set USB mice as s2idle wakeup
 resources
Content-Language: en-US
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-pm@vger.kernel.org, Richard Gong <richard.gong@amd.com>,
        linux-usb@vger.kernel.org, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220701023328.2783-1-mario.limonciello@amd.com>
 <20220701023328.2783-10-mario.limonciello@amd.com>
 <Yr6bELakZTVhpknY@kroah.com>
From:   Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <Yr6bELakZTVhpknY@kroah.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN4PR0201CA0034.namprd02.prod.outlook.com
 (2603:10b6:803:2e::20) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 952b2c9a-65d9-48f8-dbc5-08da5b8b8f93
X-MS-TrafficTypeDiagnostic: BYAPR12MB2728:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aY2j7A/TOCxBhyAl3NsZExX+vFkUBv6tigRz7+MzoGUXetEoxpZworqV4N3CFfv9lm8MLULbpx2X2w/67rYnFZOOlUQEDvfR9pLMkeDEq05irvrkN7LmuMIWB12d3CZ8QXebptqmEvWz/y0ZE1gZQFzJ84xuxwvjlxDJ9Jc8+1q4vzbSE7FMAJ9pgq5JXOlF9L63x6BRohMRVQRCdjPAvaydGA5MFWnGZsCoNfdr39YWTnz2qGfQwwKFL0ld8LVAc0er/Xm2K+Kr0hF1gRNla8HjNrj51tR2qhRp96GiU8PPpkIHQNDv8K+FhRIp707VoITGxudHdz6Nzvz+OXB0xG4qlhBV9bzu5RivwPhOm6K2Hhb2YGEorIE3mZlR7VcBd/6v4UR3k1+xtwdJ+dhzxhW+bZ6dTZVu4wJ0O5TsLy62JBkOTS2mzbt3h3TsDulP6iT0vCMX4HIfsF70uf8QO+MnDDBv9zE+I4Y14jb63n+S6h37ByQngTOy0rFBVVPcH2iYxGBgDgZ4jlGi030/7rh+0G/sBJ+jhTbrCvr5eJBwcS8t/BK0Qdn2Tbb95MFeGsqhF92hVqZnMA8ixQ8WqqAqbE/Yz1sSmN6I32pscKpFtkf78QkL9eNe9asX4hANSOV/J08nSvWAlIL9sHqIBidWYEWj4jB33eW3VBC2D8YsikXNcP+3Vd7ZmC14IEnCIkiE26lB9vNAOqx3QVWclRwildUyJySm1BT/LphsTLVaG6m5yME99xDacrwHnx4E79GO4LQBCJKiztinxY9lb2s8AUy4FQmevtAmFp6IJg7waDgW6UrsUfk/DRBakL4GlDcdD82aNvRlxzpLd+Q/QSEpVDg92Fv4RECHCmXrimgHcvOAqXWBRDaQsbSbEf21
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(376002)(346002)(396003)(39860400002)(366004)(136003)(36756003)(4326008)(8936002)(31686004)(478600001)(86362001)(6486002)(31696002)(45080400002)(53546011)(6512007)(44832011)(5660300002)(8676002)(66946007)(66476007)(66556008)(83380400001)(186003)(2616005)(54906003)(6916009)(316002)(38100700002)(41300700001)(966005)(2906002)(6506007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UDVnNHdYcy9jdjZSWVp3UVB5Nm54QVRpcmMzNjFNVytGMEF2aFQ3YnVTcVZw?=
 =?utf-8?B?WjdiNDJuTHNxbW84L1FxSE5YT1RGcmU5cGdrdzNScEQwaE9OSmZVbGhSczQ3?=
 =?utf-8?B?N2Y0UlRvVFVGb081cjlOUVpMSjRiUGQ5TGJmUHhoYjFvcDBkTmJRSzlMR2ti?=
 =?utf-8?B?SEE0ZmRQbDBEbm9CR0xHR3VsSFRnNDhHNW1ZUXBUZE5yaEdjUHU4R3cvNTRx?=
 =?utf-8?B?dTJTUE9FbWFnYlQ1akdUcHFLU2g5cWwxNEZBV3lRWXM0bjZkd3BZeVBEaXZJ?=
 =?utf-8?B?aG5WbjNkYTM4TG1oQzExRmp2bmE4NjBPbFFvbFJ5djQrajlWR0ttSEpKL2dZ?=
 =?utf-8?B?dlJwaWFveENxTm55cU41ZEhWN2FmU3BzZ3AzU3R4UlU0b1hES2FVaWVQcVNt?=
 =?utf-8?B?bGR6VVJkc2hDd09pTHU1U2w1c0cxdzZCbHhGZGlVQzFheklVZzZFdVZodTJ1?=
 =?utf-8?B?Z2pXVEtkSThtQ2ZCcFBZb0pxTlFYM0s0U0RHRXA0U2xLNkJTU1gyOUpNZGFl?=
 =?utf-8?B?cnhyd1JxSlhBVmQ4Ykh4TTA2RDZINEFPQ3JtblVMSXpTdUNqQmluVjZ5eHNJ?=
 =?utf-8?B?bC9Tb243eVJFeXpKS1EreTNkcW83RFNna0NobUhtUmxtMGxFSldjcVI2L3p2?=
 =?utf-8?B?SHgwZmFCTkplVHJPaWdsV3loWk51ZndBQVVEem5LbEpFMysvc0Q1K0IyL216?=
 =?utf-8?B?MTdZRnU4SEZUellLQ0dTU21PMW9Db2dHOUlpWjgzMFd2RVZScjNBalI0ekNj?=
 =?utf-8?B?QVVaM2hZUFJocC8zaElQYmxQMCtNcjZ2bDRvM2IvWU5xd3VsYU80aWJ6bHdV?=
 =?utf-8?B?K0RuZzlKYkVwUjlDUktvSlg4RGpuaE5iRENxWFYyeEM2Q3p0T1h4dWNManh5?=
 =?utf-8?B?azV2RHdmMXFBUi9nYjkrWTJ6RGJlZ05LRndyMkZveWtObTEyUUJURHhFUmxn?=
 =?utf-8?B?dTNrZXZaME0rc3RBVE1PdzBZY3gySmhGUTRxVXE4eFNuYnoya1ZzZUlUS01U?=
 =?utf-8?B?Zk9nOUk3VEZQUlhFNVhiR09XYXU2Q2FXMkwxcTMwWExUckpXeDkwKy9XekRC?=
 =?utf-8?B?NGhlTXpZaHRjVXJWYU1pbzBiaW9KNXNZb3ZUOTdTaURoR0g1WTVYU1NSVTBB?=
 =?utf-8?B?V25kUVFBTk9uNFhScFJNTWI0bFRoa1ZJb2lCdDZuWVd1Z2F5aHVxY1V0VUNi?=
 =?utf-8?B?WWxIWXZLVlVRR2JPUHJsZ1BkTng2eEg5UldYWVRkRHhCUGlhWXFVU0JRNWUz?=
 =?utf-8?B?UWRPS1B4N2hIUVhiWkVMTE4vYVVaOTQ1K3lUZFVjZWIvcXRMMk4rRURocmV2?=
 =?utf-8?B?NDFTbVk0NTYrOXIvaVBESC9rNGdQcklBc1ZrbFEvTXFIcjl1UGRFMVJTanJs?=
 =?utf-8?B?SngwaEVCT2hMaU05SFc2THo4SHR1VGpTZi82Tnd2UkUxTVVIZ3BSSjlqZ3Js?=
 =?utf-8?B?T2l4ajdTM0pBSWZONmlnUUZsV2xSS0NnVHJtZ0hYRnFnbmhQdzR6VlJidGFk?=
 =?utf-8?B?QUVBeFdiOVlTSzlhUCtySGdKdCtDK1llMXhwOEQzZDJJby85VGFweHZzNGE2?=
 =?utf-8?B?WDBCK2NnTkREbm15RmxRSnpGR3JSWEM1R0tFTEs5SFhRQXhSSVpMblJBWWlI?=
 =?utf-8?B?aGExUmZiYmd6SDNjL0hLdXJhVGg5ZnczaXJjTzAxd3JEc3VQdm02czBJSkF0?=
 =?utf-8?B?WWoyVEhGNFB3WHF4T3NTTzNJaC96bHVwSzRuUnlqbWsvcmlBTVNlTU5DdVNV?=
 =?utf-8?B?VENNakdVOVBNdzh3aEJhdmh0VitKMVBDSys5SlBSTnNtQy9yakswV2ZERk9w?=
 =?utf-8?B?UEpWdGdkTXNXcXZIWCtuMmF0UXB2L2NESys5M0VVLzViTFFDZ0JEOXQ0TzZ1?=
 =?utf-8?B?V2Rtc0xUSENJakNUWHBVM29tSmxRSldOdE8rZHM4amwwMDJUcUF5N3FIVUhj?=
 =?utf-8?B?RDZuS0Uyd2kyNWFDNVNXZUpBSVZPRDVrOWJiWmpNVDkxZ0JtMXhIaUEzczhZ?=
 =?utf-8?B?Y1I1WGpwOTNkRXZJczdXem9wV1o3U2d2K1RNVlJ0clViRXQwS2srNWdBZ2Qw?=
 =?utf-8?B?SjFDNy9TSG5raWNtWmF0TytMRHkrbm8vMjZnTDUwM0lxd29hWURsY2Jjazln?=
 =?utf-8?B?aWlHQjFxT0xtcFVzckt6ZjI2a0tEbFQ2QWhyN0NwREZ6VlhBQXkwejg3SWQ1?=
 =?utf-8?Q?gKVi4/uysjxEqbjcu1VIsBOdntNBo+yusQh1bokTbAEH?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 952b2c9a-65d9-48f8-dbc5-08da5b8b8f93
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2022 18:00:19.5166
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2OwCmdx8idgf87ORrkNGjZNRQiANnIAnO8+cLtD/a9LnWGMYzdgN2wf+3wWzK+SC+oH8t0ZKvR7c+8n6IMJvEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2728
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

(FYI - combined both of Greg's responses in this message rather than 
responding to them separately)

 > Note, this is very different than older versions of Windows.  Any idea
when this behavior and prescription changed?

Older versions of Windows also didn't support Modern Standby, so I would 
hypothesize it's either Windows 8 or Windows 10 that changed it.

 > Where are patches 1-9 of this series?

Patch 1 was based on your comment in v2 that there was no helper (it 
introduces a helper).

Patches 2-9 are just changes across the kernel to use this helper.

The entire series was submitted to LKML, but individual patches only to 
the relevant maintainers for the subsystem.  If there is a v4 patch I'll 
CC everyone on everything.

Here is a lore link to the whole series:
https://lore.kernel.org/lkml/20220701023328.2783-1-mario.limonciello@amd.com/

On 7/1/22 01:58, Greg KH wrote:
> On Thu, Jun 30, 2022 at 09:33:28PM -0500, Mario Limonciello wrote:
>> The USB HID transport layer doesn't configure mice for wakeup by default.
>> Thus users can not wake system from s2idle via USB mouse. However, users
>> can wake the same system from Modern Standby on Windows with the same USB
>> mouse.
>>
>> Microsoft documentation indicates that all USB mice and touchpads should
>> be waking the system from Modern Standby.
> 
> As I said before, their documentation indicates that all _EXTERNAL_ mice
> and touchpads.  You forgot about internally connected mice and touchpads
> here, you wouldn't want them to wake up a device asleep, right?
> 

Is this actually a thing?  I've been in the PC industry a while but 
never seen a design that supported Modern Standby/s2idle that opted to 
use USB to connect an "internal" touchpad/mouse.  Microsoft's own 
documentation in the same link advises against it at least too.

"We recommend using HIDI2C for input peripherals whenever possible for 
better power efficiency, but this is not a requirement".

But in any case - wakeup from this type of device is a grey area.  They 
require that internal touchpads connected to I2C be a wake source and 
also USB touchpads.
There is nothing on that page prescribing the behavior for an "internal" 
USB touchpad.

Reading between the lines given the intent, I would argue if such a 
design is created or exists internal USB mice and touchpads should also 
be a wake up.
