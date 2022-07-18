Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F27DC578114
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 13:39:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234538AbiGRLjm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 07:39:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233775AbiGRLjl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 07:39:41 -0400
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-eopbgr130075.outbound.protection.outlook.com [40.107.13.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD28C264B
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 04:39:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P2Rcdv2sUyJSqoi9KLsP5BcVqPmYw3lhAwAPbaAg0EYTBkCnHdcmlAGn++OswKZ6O0Z+v2yfjT10S5ZyWR56mNHjjnrqTC2WhPWYiMAWMZql3sWvQmGlUSyYNmOfr/bWlUDAEWImoOIXEoxPUaCN4BBEmUYmClTxdHJlXyNBuLSQ4ogBJLtzM8s1vA6M7mAo0xX0s/vFrxUJvCv3lZpbjPVUpnpme77JIhrFNkjLpd8ZPItZ1nnq01YsB+TTik4kwTATkUdSLYIvr0CzFG5YHuBk8grFWPneYqAPi7syZ1Lm8iFF4lJTufm9lxiqH6TgXsMsjMtDAAdK4mCTPjjJsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SHu9F9LVCzeVwwGQ7uOZHTPSOPP/0lcAVReQrh/jTKg=;
 b=lyckba1Nn9yFWkQIlipWZUbGX/LEveLsbEIOfH+zdX7AgjTIj38qev7vkH65IAt4YeWT+VbD/OAkQR9qenY1fwZ0dusiHMcAHjwL4wPNsKL/4k4YHtF8r7nKVFir+xfY8mvylQTrr5T9NXqip30RH6r0+dQpd9pP41ovJgyU6w/5MEGdz/vJAdS0D657q+T6SHCbulV1D6bDsi/cfLB9F9ipe4XUYHKCci9hnPnyN+Zho9nSooxCLe2lJ76ZzTDADxa2RmyyTPkMlK1UjtcWpVNIKfa0cbxFyP/BuBlHTtHF6ge2xQwZi1u5AAJWHws6EzEI4JxTjx7PSlT+TWrqNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SHu9F9LVCzeVwwGQ7uOZHTPSOPP/0lcAVReQrh/jTKg=;
 b=QRZ3WSDAPLZ+aqV8oA37LuATfpv1ljxwKRiCbjs/VOZncU3kIZhAepFvA84sV8ZtoPsMk8hSi1GWGDvJr/4K5gL3uVO8ggqacIuml3MjNJs1oFtFXdRRHqlRUDiqhYMnLdNxAbwCPLS3w5p9owUhtZmcvVL/3+zkNNYWGhAm2yIDiLo+NBoiRuGgN7Eejh7oGBjnu5GVX6xo/5TEdBKKDbRLhg3OgdJsNxFw0/FY6/cmG6kDgGf+zpDHEn8Zi46m71+l0IbjO3No/4ZP8nD0FMXy6njSELKsu93XNRYFZjXMOrJuhukF7mT9vmp1Yz5Lv/t8awFpZwZ3zqTL/osEKw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AM6PR04MB6551.eurprd04.prod.outlook.com (2603:10a6:20b:fa::20)
 by AM6PR0402MB3528.eurprd04.prod.outlook.com (2603:10a6:209:7::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.23; Mon, 18 Jul
 2022 11:39:34 +0000
Received: from AM6PR04MB6551.eurprd04.prod.outlook.com
 ([fe80::dd30:2cbc:361d:2d1e]) by AM6PR04MB6551.eurprd04.prod.outlook.com
 ([fe80::dd30:2cbc:361d:2d1e%6]) with mapi id 15.20.5438.023; Mon, 18 Jul 2022
 11:39:33 +0000
Message-ID: <80b413d1-287a-61a3-656d-9ea680f00a90@suse.com>
Date:   Mon, 18 Jul 2022 13:39:31 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2] Subject: x86/PAT: Report PAT on CPUs that support PAT
 without MTRR
Content-Language: en-US
To:     Chuck Zmudzinski <brchuckz@netscape.net>
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Juergen Gross <jgross@suse.com>,
        xen-devel@lists.xenproject.org,
        Thorsten Leemhuis <regressions@leemhuis.info>,
        linux-kernel@vger.kernel.org, Borislav Petkov <bp@alien8.de>
References: <9d5070ae4f3e956a95d3f50e24f1a93488b9ff52.1657671676.git.brchuckz.ref@aol.com>
 <9d5070ae4f3e956a95d3f50e24f1a93488b9ff52.1657671676.git.brchuckz@aol.com>
 <5ea45b0d-32b5-1a13-de86-9988144c0dbe@leemhuis.info>
 <56a6ab5f-06fb-fa11-5966-cb23cb276fa6@netscape.net>
 <d3555a74-d0cb-ca73-eb2e-082f882b5c81@suse.com>
 <1309c3f5-86c7-e4f8-9f35-e0d430951d49@netscape.net>
 <764ea65f-269a-6f32-c780-cbdd7cf09120@suse.com>
 <8eb62e12-17cf-cce6-666a-8ebb7915f461@netscape.net>
From:   Jan Beulich <jbeulich@suse.com>
In-Reply-To: <8eb62e12-17cf-cce6-666a-8ebb7915f461@netscape.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0143.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:96::17) To AM6PR04MB6551.eurprd04.prod.outlook.com
 (2603:10a6:20b:fa::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3566ad0c-d80d-4cf1-bbfe-08da68b22f73
X-MS-TrafficTypeDiagnostic: AM6PR0402MB3528:EE_
X-LD-Processed: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba,ExtFwd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bdDNRPWnEoUucytWPPyH5mfDdJGYkZV2okavMtXxrSmX6V4VVVWffBkc24s6mNS9afXl5413jCz1xsmh88mVbwmAihB2EIVbxYZtHqsk2Tq/i9YxSy6pB3ekh3XOEcbBEMvIIs+MH6YDPSjTfaleSyZDUc034QrYYS89un806jsgInkj85qFTcZ2RizqUtY5uJipLcrnSXSjzitMBwKHCeKyESgKDFLWSfx899D5CL+x1qBkIhqTBnK+mE+b4fR5VgcSyNC89tjC49DR6yZozmgs+v7A4zFHSpatFsaJqpHjZFRtaa0RhbrWPx0kd4xtPERs7PGY7poBNzhZ54sIaLGbhn81lZwCDBWbJ15Ws+u23ubk10/sTezEaMaMhbNpwlqjkc01ZVPlGD9qb/sTqVSIuYk/BZrfo60sLbwjQq3S49q1T2aEtmD8R3PF3OZcFd4qgCaUzfKKGcCcPFyjFL0ndjiuIDfqjW7Ljw3cS9Uli0xT//EXznr/XhIIko3vg4e8wQfWT+Pv8anyD7CoSSgsVVW4/EWq1nEXkO8OfQ+YQvkoyZpAV30nhxZgdp4HJFBfTyLnw7eiiibaDOzK+pRqITpfyiRcrXdnlfTibU9+ffWMRx5ggSKvSxYUtH06N3TPeCAhNy7nTo5vYhfQ4PC2loXdjHEjIjj/xNH4XSdxZQ09bp5m6o9p9bT04lSZCwIrzVMO3iOX7p/cW1Ll+VqPyCxRBJe3So4UwsrRiS4aGPmncyJhofX/+S+6LxEgQpgFm9GT96wllOido53waW7go8IEY0rC3I8QJAu8Lg5o5dhQIf3t25b3OE0xESy9R7VB2a4MI6DLiBaRn68sXo2JL9WmdflApfYjY7NwzxpOfG5QKWRrn8u8ZBm51t0/
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6551.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(376002)(396003)(366004)(136003)(346002)(39860400002)(6486002)(966005)(478600001)(41300700001)(6506007)(31696002)(86362001)(6916009)(316002)(31686004)(26005)(83380400001)(2616005)(186003)(53546011)(54906003)(6512007)(4326008)(66946007)(5660300002)(8936002)(7416002)(8676002)(66476007)(66556008)(36756003)(38100700002)(2906002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cnJFVTVNTHVHWTUyOCtPL2JvdkNCdGhNRHJDR25nbTNSOUdVZURkOVozM1Ji?=
 =?utf-8?B?NUlGNEphRkFRRFB6SG9FeHBIMW5iVmpRM20zRFNob01ONDFiSHpsY3BRRDJC?=
 =?utf-8?B?di9DY3Z0NVp2U0x5TUhoVWdqMHNFaWRLeWJKU2dEZmx0QXBxVks3MHlRRnJ0?=
 =?utf-8?B?TTJyTmVDa1NhbTFaME93a3BINjQ1aUdYMEtDcUx4TzQ0Q1E3RWRMN1FNSEk4?=
 =?utf-8?B?eVgrbWZiVlF5MjdqQzlWamFTRE41MWlOWDZpekhCKy9KdGltLzVXMFMxNisw?=
 =?utf-8?B?ZDJ3bkxQaW5lWE9RSGJaaE1wdTh1ZVR5UVQ0UEdyb2txNEdwOTlHcTc0Q0lK?=
 =?utf-8?B?eTVCVjZld2N6SlZqdmh6RGJNRUV1N29GcWdTQzR6VlZNUktQNjRaUmVuZklG?=
 =?utf-8?B?dHkzWlNEYVVQNk9jOUFEeDZYOVNOcFBSVjVqNk1MZDEyL3VoTHNRMWRuK0NK?=
 =?utf-8?B?WjBKNm41RlRFck5pUlJ5T05HNHR6WG5tUy81MytRaWxqbVBuNFRPMFFWY3pQ?=
 =?utf-8?B?Rm5YNit1RVFtbTRjSk5aRy9QRzRoSXllVEtmOW1aSGlKbFZSdGlpK29TUkR0?=
 =?utf-8?B?VjhBT0lLb1JJMVQzS0JxUmhyNjRpblJyVE9ZV0NPRVpXY0hiYlNQb2FSK2lW?=
 =?utf-8?B?a1IxV0FER0VKa0RIL3ptcGFlWDJKRHpYWHdkYmtlR3U2UVpZU2Jia1hrZVRW?=
 =?utf-8?B?UXFvM0hTcTVzUmgrUDhlU1NGSzJjWlgvWXltMGxRTERFS3pPZXpjVHQxWUFU?=
 =?utf-8?B?SHpNN0g4Y3JNL0NuQ3pIZFVQM3dKVnZ2emt3d2lLVmZvVmZ3OWFBQzZVWWU1?=
 =?utf-8?B?b3FFZTZ3MGhDMFg1WmgxQnlwV2gvdWx6eGtzQzBjZ3FuSDE1ZXYvQVI2V2hU?=
 =?utf-8?B?TzUrQTF2ZDVRdjBDM0kyQjBQU2dXaS9zTzJWaHR1Zm9TRVBhYUNIT3Z4Rmlx?=
 =?utf-8?B?SlJ1S09vSEF4V0xsQ2tEczB2MGJKZHVSZmtKSThwR1IxakRWTWdSTUdicVlC?=
 =?utf-8?B?OW8xek10bVVaNGE1ZDJ3Yk5iSWFBL1VPUEtpYWVKT25hMnpCR3lROEwyeHlw?=
 =?utf-8?B?cGVYWlJFb2xVZEdmcGZaeVlJcW85NGJKWXBNaTAzTEVJWHRSVXZxWGxOeHls?=
 =?utf-8?B?ZVVodEdmRk0yL2dDbHFTZGJSNTE5bVVqN25obllLTnBQOTZ6M2VnbmJlNVVp?=
 =?utf-8?B?VnEzUnRURTlnOSs4ckpzbnoyNzk5UkhZcHFQbElZNW5vcURCT2F3eFZiQk10?=
 =?utf-8?B?RWxJYytub2lZdmQ4RVlIMFcrY3NIZllzUmlJZ3IwZXZiZlJ4RTd4YVZZbWo3?=
 =?utf-8?B?K1pDL2RpRW84QU9JR0xqa3RpWnp0VEdIM2YwOTJBU085V0VKZ1Y3YjFqN0g5?=
 =?utf-8?B?Wk9EV2p1SUpLUnN1ZzJQVWphTDFjTDltMkZqK2FnekpNYkFDSzlUK2R6ZkVY?=
 =?utf-8?B?MWpDVWpoRHMvalJDUWVHYVlycmlDV3BhK0Q5bXptdlFHUTh4OHRaVXJQaXR3?=
 =?utf-8?B?YU9FUVd3ZFdScXhvWW9GZnlmRVM2bnptTXd2UHU3a2tOT3d3bW9FWTJqOFVv?=
 =?utf-8?B?Q1dva1ROQ1pPSzlNRFdFYXZVTjUxQm5KTklDMlZSOEFiL1JHaGY1RDNFSTVD?=
 =?utf-8?B?d3QyaGowRDJBWGpjcUxqa0ZpQUlyQy95VHdVaE5ldG5mK3VYOVRCbVpLZFlq?=
 =?utf-8?B?MVhENHJTWmZNcGVocG0wZGZMNDFhNnpEbFN5U2tpbmk5Tm9sbFM0QVUyYzdZ?=
 =?utf-8?B?dWVTelB6ZnpxTnFPSWd4eXh0TDRhbklyYkVkYTVEbWQ4YXJISXNlNkxpOGRs?=
 =?utf-8?B?SXpYVlE4OUFUc2l4M2ZDMGZSZmhRVHFpVTR3SmxlcFBNV1g5aFhlNytucDcv?=
 =?utf-8?B?ZE9pa25HNld2UFdkMGJRbDBQaHV4Q0JJM2dSUDd0N0htWGpHeVJoTWE0alB1?=
 =?utf-8?B?SDU4d0pLY3Q1L1hHYzNXUXZRT2tROENNbmJTWDNVWDJ2TDdEMC9QZCthZmM1?=
 =?utf-8?B?MjFLMFQwM0pKUDFxVVlmL1ZoZUtZTVhOYmNiRzJiK25FMmgyTzVMbm01RzJl?=
 =?utf-8?B?MkMwTERtR3grd2dtWi9EeDEvaWpPWUxyeXIySHBsekRPc3NwQXZYV1VRaTM2?=
 =?utf-8?Q?AyDM4F5P6V5WJgICtMYz3ag1s?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3566ad0c-d80d-4cf1-bbfe-08da68b22f73
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6551.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2022 11:39:33.7177
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tDbxqZ0XJwBlMRvNfqi87k5mzOpTYjZsV6nqX6ZUypy+SGxxBMp1W+6wx6KBP+JJdIRCR2u8+Jo3aOmN5eCalw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR0402MB3528
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18.07.2022 13:31, Chuck Zmudzinski wrote:
> On 7/18/2022 2:07 AM, Jan Beulich wrote:
>> On 15.07.2022 21:53, Chuck Zmudzinski wrote:
>>> Two things I see here in my efforts to get a patch to fix this regression:
>>>
>>> 1. Does Xen have plans to give Linux running in Dom0 write-access to the
>>> PAT MSR?
>>
>> No, as this is not technically feasible (all physical CPUs should run
>> with the same value in the MSR, or else other issues arise).
>>
>>> 2. Does Xen have plans to expose MTRRs to Linux running in Dom0?
>>
>> Yen does expose MTRRs to PV Dom0, but via a hypercall mechanism. I
>> don't think there are plans on the Xen side to support the MSR
>> interface (and hence to expose the CPUID bit), and iirc there are
>> no plans on the Linux side to use the MTRR interface. This also
>> wouldn't really make sense anymore now that it has become quite
>> clear that Linux wants to have PAT working without depending on
>> MTRR.
> 
> I am not so sure about that, given what Borislav Petkov
> said when commenting on your patch here:
> 
> https://lore.kernel.org/lkml/YsRjX%2FU1XN8rq+8u@zn.tnic/
> 
> Specifically, Borislav Petkov wrote on Tue, 5 Jul 2022 18:14:23 +0200:
> 
> Actually, the current goal is to adjust Xen dom0 because:
> 
> 1. it uses the PAT code
> 
> 2. but then it does something special and hides the MTRRs
> 
> which is not something real hardware does.
> 
> So this one-off thing should be prominent, visible and not get in the
> way.
> 
> --------------end of Borislav Petkov quote-----------

And then, a day later, he said

"So I'm being told that it would be generally beneficial for all kinds of
 virtualization solutions to be able to support PAT only, without MTRRs
 so it would be interesting to see how ugly it would become to decouple
 PAT from MTRRs in Linux..."

> Jan, can you explain this comment by Borislav Petkov about
> Xen being a "one-off thing" that hides MTRRs and needs
> to be "adjusted" so it does "not get in the way"?

I'm afraid this isn't the first time that you ask people to explain
what somebody else said. I don't follow why you think I could better
explain what Boris said and why than he could do himself.

Jan
