Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21E2C5911FD
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 16:14:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239129AbiHLOLg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Aug 2022 10:11:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239116AbiHLOLb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 10:11:31 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2058.outbound.protection.outlook.com [40.107.223.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FD9A10567
        for <linux-kernel@vger.kernel.org>; Fri, 12 Aug 2022 07:11:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fF4X9BFioDUVCg8jFUnKnueABuVvowiBbSbNN6VHaAQyUu/0AD12eR315xXyzflvRtsa139shnq/1G4cV/DGwfPS4loYVs0RYxlK1xxBMrlcQgI8rRqzRpBOEY42rpjbWfx1I+hmOmg8R++2WpZL3ZGvaOCyaS0ds8PjqyTzQfUBBM+nOcATvFiB4rThQFUJrdYSshvwxMK6YYKyPNAHKV5cu6bKcImqhnnHjYBNnF6vSsmi7mu2AzZLOhjhSOwSbAQkjXQIFB+/nxxEbez5Rerb5miBHwVXYNDB3VgTOv0cm6tolP1fokmkmskUt/UHglM/BMR+VoWL6RV/YBpMFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iHH9GXklApjPjR4FJgW/m9V0n8dxiFS8OfC47oREjUw=;
 b=bhz0pKtQvTA1g0PK2jag1ghn6MCnyWltDxN6C6ayKOkSqBDSmk6FiCPklcZ8J5e9U9DkPcb88/rmfoAsE25fQu+gNnFhK/0kbkf+scWpoLbWDYryXLO9ZBY/UjPFyq94wwMXaWVy03F6N6NQdwgFc6XyJ3MiXAz5KQ+fnHvI8RabDtFBCwCk2ipJV1bdJ8dOr2NgrE0dS5Ur1NbpNtJiX3umfLLT5JiZN+ioE4OztS4r/dSkfAdmIPwQJsSkPeK7O+0/4GIPQcXTukkMzKrAb8Wlr3yMpbp4TnuWYfgOehfMFG6S+H3xun1WiIJValEAyqp4wiaXUF/DKNqmeGWVsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iHH9GXklApjPjR4FJgW/m9V0n8dxiFS8OfC47oREjUw=;
 b=V3KhDhlyHuHtTWCRwVt32iyQ0IjTQ0BkgDPQ7xlYtVr97bXFl9hRXng4kjib+wQEt3YShP0PwU+stU5QzT+/9qja5v0MYHeuqZ8KWUqMrBNrJzsrAy2f9MiUusBaD+kwXghz+ZVO+2z4uV+EWIm0o0vCC1HOYY8bsAwlyWb/Lgw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5229.namprd12.prod.outlook.com (2603:10b6:5:398::12)
 by BN8PR12MB3521.namprd12.prod.outlook.com (2603:10b6:408:9f::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.11; Fri, 12 Aug
 2022 14:11:27 +0000
Received: from DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::1dac:1301:78a3:c0d0]) by DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::1dac:1301:78a3:c0d0%6]) with mapi id 15.20.5525.011; Fri, 12 Aug 2022
 14:11:27 +0000
Message-ID: <6d9d433f-779d-7531-02b5-382796acceef@amd.com>
Date:   Fri, 12 Aug 2022 09:11:25 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 1/2] x86/sev: Put PSC struct on the stack in prep for
 unaccepted memory support
Content-Language: en-US
To:     Borislav Petkov <bp@alien8.de>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Michael Roth <michael.roth@amd.com>,
        Joerg Roedel <jroedel@suse.de>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
References: <20220614120231.48165-1-kirill.shutemov@linux.intel.com>
 <cover.1659978985.git.thomas.lendacky@amd.com>
 <21d5d55640ee1c5d66501b9398858b6a6bd6546f.1659978985.git.thomas.lendacky@amd.com>
 <YvZPoEm6PSeoflAz@zn.tnic>
From:   Tom Lendacky <thomas.lendacky@amd.com>
In-Reply-To: <YvZPoEm6PSeoflAz@zn.tnic>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7PR04CA0170.namprd04.prod.outlook.com
 (2603:10b6:806:125::25) To DM4PR12MB5229.namprd12.prod.outlook.com
 (2603:10b6:5:398::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 37b18dee-fb24-4a99-98d7-08da7c6c8c23
X-MS-TrafficTypeDiagnostic: BN8PR12MB3521:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2c1rX8b6Z9qV6KIUC3rhT3hEraou48iqHKlI6qAs3nEaWfARDttyODCGSKpxQifbseas++NWEWD4dPeo5Xo1gM7iwn7ZivF5NCiwiRepwqDpzmUEY8dLPyOIN+Zq8hdwBgeb7iy+AoeInB9bk35jCMUQOAEasUi1BV+id1vhApIwu62J0yImxUMQUCw4e5X6Sgtg3ZeUtZ9Xnxo7hhomkG4O2dRtxV6jdJim1pyBmoYNpJu/uMwLauYRdFHZpQUQAMezKoNLf144Nxd11FZ1GWAs8hzQL8MUj5dYpFM3xiq269Pcuz52jo6v5lu3hL7K+b5goeV8Bkg1jLzubd4EkkxK+rSM1vFQfR+VuiVIEdwrmtULSY2r3UncEvqc8O4IsireVj992dhHoPNCK761gwmjKQXBKMIH4e+M7txe8eWU5e67kWRERE2VJ4V/cTi2lQpYCyPF6hkWrN7MB1dTWh/pBPlHzFqikRANWzLiQWfFRs5OH4dtdzJLVSfv+YTknwHZNsZGy6/w9Y9uKbdMBL7N5XS68ZTYcdnA6bpDVeXLoqduaUKAsE+5ZX2rf/q2XMmifhyS/EGUKYh6DGk7KnQejIgpIgNuNOywVCx+kwDKVelmajEs8NZENb0bmgteS6G8KX9q4fwxejhwlbopbAYu/vzrQLXlkqay6xlyykTW71TlbIGEcNh1uis6Ht2RQkBRx4khaQPSqTSdRNvleOyq6xoIElIbrBwDRYVx0wVoeNAgCMCpF3Q+QjnIbN2NNW0T8NLCAZti1UeDQD6WgRxBYgbPmaeC3QelNWlsjyiDuGN23qZhkhdlqEM/Aq6ndi1c6Gfapk7pyle7BbcyaA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5229.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(39860400002)(346002)(396003)(366004)(376002)(6916009)(316002)(38100700002)(8676002)(66556008)(4326008)(83380400001)(478600001)(36756003)(31686004)(54906003)(6486002)(66946007)(26005)(31696002)(86362001)(2906002)(7416002)(5660300002)(8936002)(6512007)(6506007)(41300700001)(2616005)(66476007)(53546011)(186003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z2JDMmdVMjJQZzlhMEpLbEovaVNCNUZCc2d6RjhHWElXRlM4NjFVZkZHMjVH?=
 =?utf-8?B?SVlmQlFLWHI4dzUvalpzQWRIam92bThWODR3N0VBN1pMNmJRQStsMUh5RjM3?=
 =?utf-8?B?dHNMSjY5T2dqcm85NVNoanozc2JFV0w0SXd5THAzZnUveVdsUHRoVUt1ZmdG?=
 =?utf-8?B?YzFLdTdvV29TNFBvbzFud3NNTE42cFk1RGtyNGo0eVVLL0tvd1ZPM2s1dXpr?=
 =?utf-8?B?VWxtWGtiZHg5K1pscTdud3ZBZHcvdExXNWNFT2VoWXlMdWN2bHdjSzFEb2hx?=
 =?utf-8?B?ek0xTmNoRG9hZHovc0RnZEx4dlIwY2IycW9XVnIzbzhxbzlUcEM0eTN0a2lE?=
 =?utf-8?B?QnlRMnZXR29aWFk5ckgvWFNkby9wY3I0R3BKaUl5aDIzUXlQd0l6TjBVeXJs?=
 =?utf-8?B?QVFkOWNUd0o4WUVCbGErUDZHSDhDSXZzb3F5Q1BnNVlnODBOUW9FTzBVc0lm?=
 =?utf-8?B?UGZjenUzSGFkWFphVmkxUThhV1NvcGxpYlIvc0VlQmhmZGNiVUovWG1uaG9H?=
 =?utf-8?B?Zjh3L0o4S0ZEakp6OGFlSXJBcFZWZG13S1NoL0h5NDZNWE55L29rQWEvNGha?=
 =?utf-8?B?R3IreUxRb3ZUQ2tacmxXQjQ1TjdmT1oxRHZ4SWxRWStkY0dzTHliQ2lYZ2Jz?=
 =?utf-8?B?MEVxdEREWEVETFlFcjd3Mlk4NWpEbjhYMW9DNXdydXRrVS94YlcyY3pUaXhM?=
 =?utf-8?B?VzlsbjNHdi9TVFljN29OR0tBUjMrbjcyNlJuYXgzMlBPRkxKaW9ZajBMdHpy?=
 =?utf-8?B?K2VhQ1dZSytNb085ZXBlakR3MW1oQUVXaG5DSjVGWWxzcFpwOUxJRitIcGxI?=
 =?utf-8?B?YytmSmkyS1Z2NUlJcXl5WjJSZjRhTjgvSTAyL2RoS08zbWUvNW5Qekk2YVpU?=
 =?utf-8?B?LzZXdGFxUGhJNW1YM3dhNDdxT1NRaXNpK2ZEekdXN1lRZVcyTGduQmo2RVRG?=
 =?utf-8?B?MElNamFKYnRrT0RjQnB3dVBtTGkzN2NTWUlRaU5KcEhRdUE1VkU4QzF1QTBF?=
 =?utf-8?B?SXFJUVpZamRwU3VJMGsyNndCYnc1M08vdXYvRnVySWhSN3hvU01kNXRUMTRQ?=
 =?utf-8?B?S1pxWjhGOUJYOUFaVVo3SDg2VGI4OE5aSExpRGIyelZvdWdnL0N3a1hJMGEr?=
 =?utf-8?B?dkRFS2dMYnNGVmk4d0VOQkd6ZnRRM2R5Q0dQcTd6bDMraTdWVXV6K1RnV3hF?=
 =?utf-8?B?czBwR1I4aEdub3dIRmV2YmpKdkFMN2dITGNidGoxSGoyQ0FMemY4YnFWK2pH?=
 =?utf-8?B?ejAwUFV1M3ltc2dGS1FXWG1PV3E4VHA2dzRUMFZUYU5mL1NMdjAwZ3I1Rmdl?=
 =?utf-8?B?TDI3MS94aDBvM1RBU1lJQkdqVGdRSEhPL1lER0wvUFV3WmEwU1B3TlhkK2hM?=
 =?utf-8?B?Nkt1ZTk5ZGhDdUFIcVZSWlF1YWhsYnlwNXVDSlhjSGRLYm1WNHJzbFhKQ1dK?=
 =?utf-8?B?Wkt1Zk9WNXMxNnpCQ3IzVHV4TnppKzIxMFREcGxHR3RaQlBPU2JzNzAvMndK?=
 =?utf-8?B?SnBWQUR5U2JNcVkxUWZ2c0lKbWpGdFFYQVhORTZmNFdIUnJtWFZiT2pUTkpV?=
 =?utf-8?B?K2pZT21iME4rSS9HMTFMcU9mWmthREtvNWIzeHlBamxpYTZwR1d1UThkVXV3?=
 =?utf-8?B?YzdiYjZ1cjZFRHZSNWFmUkdsVkViSWJYTmlVWThaZGNNMm9YM2dmaFJMbm52?=
 =?utf-8?B?V1J1ZXF4dERHRXZVdVMveTI3WTJKNzdUelVtUlRvc3h4MmJFOHBkamE5Q3lW?=
 =?utf-8?B?VGwzd0tYekdscTB0WTA5SkQvQjk1eHZRbnYyRGFFTkNQaURxemlKYTgyZGx3?=
 =?utf-8?B?SFVLQWtDWXdONnMxMWFGRXU3WXkyMlV2WEp3K2Uya0gyRlllZWJRbVdoWHg3?=
 =?utf-8?B?YkUrNm0vaGlMbHh2aURPc05mTzlRdjh2MWc1OGNjVU1VeVpSOXhmQnErNmtU?=
 =?utf-8?B?b2ZZNlpTMDhIa1NCbCtybVJZaHVhMWV1enNHb2N4cUE5aERvSmhYcmZpQ1Jk?=
 =?utf-8?B?ekhyNC9DTysvMFpua0Noa1IzdVlFNU9lcHJzc3J3RTJnNlhmdVFQOFNaRGxs?=
 =?utf-8?B?WWkva1JhVTU1WC9OQ1JubGdXbXM2WVI0SlBnTUF4a1liNFBIdjAyL3cwdHI4?=
 =?utf-8?Q?WbJg/1uj44K/Gm3vj+Sq4lgrJ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37b18dee-fb24-4a99-98d7-08da7c6c8c23
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5229.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2022 14:11:27.7364
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yDSkOdVXqUGq4YPx2gGCVZMfg4w5pp4dD0POLa5U7LjEl3OHspToDxa1Kh/Th4mZYZj+ZSPF+KJXL4pIDyZu3A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3521
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/12/22 08:03, Borislav Petkov wrote:
> On Mon, Aug 08, 2022 at 12:16:24PM -0500, Tom Lendacky wrote:
>> In advance of providing support for unaccepted memory, switch from using
>> kmalloc() for allocating the Page State Change (PSC) structure to using a
>> local variable that lives on the stack. This is needed to avoid a possible
>> recursive call into set_pages_state() if the kmalloc() call requires
>> (more) memory to be accepted, which would result in a hang.
> 
> I don't understand: kmalloc() allocates memory which is unaccepted?

In order to satisfy the kmalloc() some memory has to be accepted. So it 
tries to accept some additional memory, but we're already in the accept 
memory path... deadlock.

> 
>> The current size of the PSC struct is 2,032 bytes. To make the struct more
>> stack friendly, reduce the number of PSC entries from 253 down to 64,
>> resulting in a size of 520 bytes. This is a nice compromise on struct size
>> and total PSC requests.
> 
> Why can't you simply allocate that one PSC page once at boot, accept the
> memory for it and use it throughout? Under locking, ofc, if multiple PSC
> calls need to happen in parallel...
> 
> Instead of limiting the PSC req size.

There was a whole discussion on this and I would prefer to keep the 
ability to parallelize PSC without locking.

> 
>> @@ -1254,6 +1260,8 @@ void setup_ghcb(void)
>>   		if (cc_platform_has(CC_ATTR_GUEST_SEV_SNP))
>>   			snp_register_per_cpu_ghcb();
>>   
>> +		ghcb_percpu_ready = true;
> 
> You know how I can't stand those random boolean vars stating something
> has been initialized?
> 
> Can't you at least use some field in struct ghcb.reserved_1[] or so
> which the spec can provide to OS use so that FW doesn't touch it?

Well when we don't know which GHCB is in use, using that reserved area in 
the GHCB doesn't help. Also, I don't want to update the GHCB specification 
for a single bit that is only required because of the way Linux went about 
establishing the GHCB usage.

Thanks,
Tom

> 
> And then stick a "percpu_ready" bit there.
> 
> Thx.
> 
