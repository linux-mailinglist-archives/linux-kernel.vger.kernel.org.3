Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B87A4D7A02
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 06:00:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235890AbiCNFBh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 01:01:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbiCNFBg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 01:01:36 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2077.outbound.protection.outlook.com [40.107.94.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D45E1FCDB
        for <linux-kernel@vger.kernel.org>; Sun, 13 Mar 2022 22:00:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X6uGufQj+EHYVbaFDrf4FNI9ZKDz5i4Oonp0PZgmODMmWb2emvEoYrA5ftU9vVaYT6dGs02YeQetcLAXMMvgGjMXrXmgps1aehAtG08YPy8kQ4ehIxrWh+AwZsGnnFWQq4Ta+kDQlXT3pl93dz5CXY+q/gl5QctVPIzcCr6iHxiWOettrT6AQ57yUQjSWsOvlbMnxUQnAmZSCkkHo0G0vRUzv50sgR/g7wwnenFQbKN4UjQDiH5z2Gmezsd2JxiYFw0jCNDapgPT37WP5K/yf9zuS4xZqFStdt4QqsZQ+RQrb8sznRNuUbMmR8kYUoT1ui0WaTm4G9nymD6TCJYXFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bIoXwnsEdvJQdHBB6HK6+D686ZgUdgyCCx6/2ttgo4M=;
 b=nj6KDGgafI8ZnxM28HH7EhivBy/Ar039O+82HkvRk7xPi1o5RFSLlrjFC57QzwVkgJt6UsjSu4EPVudJSQ2AJY55hSv7x/nL0mkPPGI4qJBp90RHgj+02rb6lhJEja/Ge6EcTq1pNuZTOX2ItnVG49W+p/T4xMXhAFafkQVjQH8/r0FdKmKpjq2QsQAu5TUy0Z4Nzptis26no4CYjsRDhxnFpv5bzcFzi/S09maqIdWfWHsyLg6jj5XedPp31BDA/Rt82ohJ1PrT64jOodl0mwuZ2n0ba84vdVyM260EJJ53ZOx5iPKDMOedMsIlaVEnpsyS0k3aMN0j0ZN5mYlUJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bIoXwnsEdvJQdHBB6HK6+D686ZgUdgyCCx6/2ttgo4M=;
 b=DrNfCI9Jkf+Bcu7pkM7ygTiQT9XbykfmXfarTqd40AIYb145+JMWOPlB0F2Tji+6nGpun9I4ULoJCkuMcfLxhkD7/xPzs+Uu/uyg1Lxd7VHZNHidbSFJXoeNJK1ryFy0wT2t0HaWeRen3BOjKRWZXm57a088V4NG8lRWxO+ixAA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BY5PR12MB4289.namprd12.prod.outlook.com (2603:10b6:a03:204::14)
 by BN6PR12MB1411.namprd12.prod.outlook.com (2603:10b6:404:1f::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.25; Mon, 14 Mar
 2022 05:00:25 +0000
Received: from BY5PR12MB4289.namprd12.prod.outlook.com
 ([fe80::4843:222b:2955:543f]) by BY5PR12MB4289.namprd12.prod.outlook.com
 ([fe80::4843:222b:2955:543f%6]) with mapi id 15.20.5061.028; Mon, 14 Mar 2022
 05:00:25 +0000
Message-ID: <57338b2a-291c-c7e7-57d5-86a8468b619f@amd.com>
Date:   Mon, 14 Mar 2022 10:30:09 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [RFC PATCH v0 0/6] x86/AMD: Userspace address tagging
Content-Language: en-US
To:     Dave Hansen <dave.hansen@intel.com>, linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, x86@kernel.org,
        kirill.shutemov@linux.intel.com, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        catalin.marinas@arm.com, will@kernel.org, shuah@kernel.org,
        oleg@redhat.com, ananth.narayan@amd.com
References: <20220310111545.10852-1-bharata@amd.com>
 <81b6f618-05bc-f7d0-5461-4c3f0ca42d3f@intel.com>
From:   Bharata B Rao <bharata@amd.com>
In-Reply-To: <81b6f618-05bc-f7d0-5461-4c3f0ca42d3f@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BM1PR0101CA0041.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:1a::27) To BY5PR12MB4289.namprd12.prod.outlook.com
 (2603:10b6:a03:204::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 23b5cbf0-6b86-4107-af0f-08da05778cc9
X-MS-TrafficTypeDiagnostic: BN6PR12MB1411:EE_
X-Microsoft-Antispam-PRVS: <BN6PR12MB141165B039F700F5C5ED2A86B00F9@BN6PR12MB1411.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CKI0otsoBx0bE5JXCO1B7Ysd95AQWAJf9gwWf82ZWFphVE8CDsOQ15VJa2A3joMsNzTFKaHQrXixDOcGKKgPFsgHfQQdtD/y//4c9iiMWhjdgx8l8xhDo/7oS133pvF6gDiUzxDemAIaUx27jbCybOzOe5O2km8TJHwHdbLgtBrM5whyiHGEVsU+dqwJaCkgMYifOnmUY7FXbBIXAXAr5wE8inAz2bahAcoyhi6fQtoIzvckkMzNPfz6bzzY7cTpqX10vpU0sk/KL1GKxb190SlTDduCzbOyxQX6kzrDlV5DXSWmwLFHpuLg/hCleWfCsjws6l1y6S7wJr094XHqRjaVq0tKp1yTQ1Au37VdA7uZ9r7PjeEivFwnDSxY0+ZjIp57bFE/DHocLj74ylNASqpuffomMyu3yKrXFAj1FrMBaTSJOcwabZ2WIuREIyUpJJsZbGPe6oXEowBOGTKHcfw7Dld9q31paa3oZ7hQnTRIOU0cVYSx3zNsqbCwNTcZ6jPpiOxsg2U1I2Vy5F7n3b/5Wx2ztCYwIXu2j5f0hk8LlhMAGUwQ1C8uCvXlnkHQuqpNerLGnQ/zgq2gMeca9rlzULUB95roVqQUv/0vNz7LWWMMlSS/vj1pIUVAyn7VrnwmZPALI9ZO95e1K0TsVmImryT+Qs1UnFo1rNwRJwcn129+zfaKJTyIUFBZQQBmC7M5QZfwJnEJxDp7DaXvQ86LNCrIevXT9Gsr2TOCQ8c=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4289.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(7416002)(8936002)(5660300002)(316002)(8676002)(4326008)(6486002)(86362001)(66476007)(66556008)(31696002)(26005)(66946007)(186003)(2616005)(6666004)(6506007)(53546011)(36756003)(2906002)(31686004)(6512007)(83380400001)(38100700002)(508600001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bWsxdVF0MXFzZzdxYTRUVWVvS1lyRGpHbXJjT0JTY1ZYWFF4OWIwRE5YV2pa?=
 =?utf-8?B?RzBsRjVib0RUQlo5c1NVZW15TDFuM1U1cWxoSUJLb21uME90dXorOXRBWDVh?=
 =?utf-8?B?VnhNdWRPZW41VG1KK2JKL3o1cUNBNmYvQkdjeDB4eUhMV20vVnM0VS9uTWdZ?=
 =?utf-8?B?dzdXR3l0RkJZQXJXUkhtdWhZZWJmTkJTTXBLcm1PUVFkdjRYbEgxSFB5a1Zu?=
 =?utf-8?B?QU1Da0ltZVlmeEJOUG9peGtQVGxUNFpMYW1xUVVsTXpzK0Fnc2pFY2R5WXI1?=
 =?utf-8?B?dXdQczB3SDhKNFFubDNhcmVCS1lCS1JDS2dnOGpTaStqOFBOMDFRK01tcDdT?=
 =?utf-8?B?bUp2S00xRndmd2lhVmdwdEg5K0R2MktaZ2NWUVBYL1FuaDNIV3prRFlDV3R4?=
 =?utf-8?B?TkhMODh5Nk9DZ1dwNmplNGdveFhQcTlLOGFPQmNEeVNwMnl2TzBJdVVOelJC?=
 =?utf-8?B?VFY0UTU3bExNNWE4K3pHR2JoSXk5djJTVHNveDkza3VVdEtWZkVKUjd4MEN3?=
 =?utf-8?B?Y05qZ0MzTXNKb0p4Y2U3a2RXV1ZJMWQ5cDVlakZ0aS9ESXpsT25wc2QwQTBv?=
 =?utf-8?B?RUYvQUdKNDFVckFITEhCM1lUSzlNOWNSZGk2bEV4cHhoWkppelFDQnNkS1A5?=
 =?utf-8?B?UXVzaU1vb1BUVGpLOWsrV3pRVnBlSFV2YmR6Q3V4SWN3QmE3eGwrcTVFY0Rn?=
 =?utf-8?B?RHBBcXoyWDdZeWVYVVYvbGFhVzlXM0RJUndVRlF3KzFaeEgvaEowRUxXd3JD?=
 =?utf-8?B?M3hISXcrUUk4T0lTZHdyMWw2WDcwdTFCSkxLZGsyNmxvYXNSME9oVXVQc0VS?=
 =?utf-8?B?UE5vTHNYVHpJNjVnU2lUWHBZL2d1V3g3Rk1wNFdDcEw3MzdiazhjRHBYdEUy?=
 =?utf-8?B?Nk8vYTZzU1FaclVhbmFKaURzZk9ucWxuVm5KVC9JNlZ2akxqS09RelpNT3NO?=
 =?utf-8?B?VXZaQjBjZVV2ejZTMjNBWXNpMTRHSVBnNVNVV3dXVENqYmFVQktWOUhyUzQ0?=
 =?utf-8?B?YldVd1RqN1ZVYlFiQ1FlRG5BYW1hUndoY2c3L0kvNUdtRVYvelU2VFRzRUI2?=
 =?utf-8?B?Qk9vaWNpTVk3bThJblFYcEV1d2QyaGZnOXUzekp1TGNpd055T1RWZ1lMT01m?=
 =?utf-8?B?UGhTRmNubUJGdkZ1QzRoOHlLcjFjNElJeEVlakZ0UmxxbnowTTJjbHkvaFVQ?=
 =?utf-8?B?NjJWQUdIcG4vc0NpcHVlem1UWlNxQUVlaDZYSWdGQXBuL2Q1NG50dWRDemFX?=
 =?utf-8?B?RlY2VlNqWTMrZGhycGY5bWVoODZCVVZtamxsdUY1QU5lTW5HZVlZRHJlbHdG?=
 =?utf-8?B?RVJWelVpUkd6cWxTb1MrMnRwdWZ6MW1OTExkdVdHY0ROaFZoRHAzVC9QZXBN?=
 =?utf-8?B?YWY4THBXR2x6QTBNZms5ekx4blZZZE9BUHlnT2c4VTB2aGVMc3Z4SGhIbUU3?=
 =?utf-8?B?Y3Z0Nm84WkEwMHlUSXZ5SkRmTnhqcTBjSk5nOXpHYmorbUdaRnpPYm9iSktL?=
 =?utf-8?B?S0J3RkhSKzNpazFLcHhaS2NTb0NhRU43Q1pqWTBLdkdWajNycE5udUZDWWRi?=
 =?utf-8?B?THhEZTB2R3hoNFFLSkM2Q0RWbGlJdHhsZmFQTkdDUWFwd2FWQ2JjeHZ3NTRl?=
 =?utf-8?B?T3dpd1NRZTZ6Y0ZLNDhYWXZhMTU0YmZVdU1UdXlSZmlBVGVJMTAvK3hyYXpx?=
 =?utf-8?B?YlZpRUZ5Zkd5bnpMT0R2dXVDbTh3ek4rSk1sQWVnNHppeDFjb1hRTVJQYmRO?=
 =?utf-8?B?T2dpd01HVG1WM0crQk9KNkhlbjA5d1FhQnA1MEJ2eTJqS1RuQmxLcjhPMGZD?=
 =?utf-8?B?VWh2ditmNFBwNXY3UFh0eHJhVVJiYzE5S1ZGZk9YMXlScGY3Zy9Eakdvcmhl?=
 =?utf-8?B?UTUxUFpta0tYUnNMSzNtWGhIbWoza01MWDk1ZWJQdGhXZW1kMWhCaUlWQUxU?=
 =?utf-8?Q?hvOxQB6ta+JrRNWeJVt6LNF5rlDGBqHx?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 23b5cbf0-6b86-4107-af0f-08da05778cc9
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4289.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2022 05:00:25.0902
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mUiy4EJlUbO+mgkqT/RB+9/KQlUhDTSl+xGB6xbykhGKnjglTu7lszJLyqPxipi0P3tvuwVsn5mZho9M2/SiTA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1411
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/10/2022 8:46 PM, Dave Hansen wrote:
> On 3/10/22 03:15, Bharata B Rao wrote:>
>> This patchset builds on that prctl() extension and adds support
>> for AMD UAI. AMD implementation is kept separate as equivalent
>> Intel LAM implementation is likely to be different due to different
>> bit positions and tag width.
> 
> Please don't keep the implementations separate.
> 
> We'll have one x86 implementation of address bit masking.  Both the
> Intel and AMD implementations will feed into a shared implementation.
> Something _like_ the cc_set_mask() interface where both implementations
> do their detection and then call into common code to say how many bits
> are being ignored.

The difference isn't limited to the number of ignored bits, see below...

> 
> A good litmus test for this is how many vendor-specific checks there are
> in common code.  If there are a lot of them, it's not a good sign for
> the design.

That is generally true but considering the below differences, I felt it
was much cleaner to go for separate implementations for enablement and
untagging while still building on the common prctl() extension in the
RFC version.

1. While Intel LAM provides two LAM widths (15 and 6 bits wide), AMD UAI
has a fixed tag width of 7 bits. This results in following differences
in the implementation:
   - Two threadinfo flags (TIF_LAM_57 and TIF_LAM_48) in Intel LAM vs
     single flag TIF_TAGGED_ADDR(like in ARM64) in AMD UAI.
   - Untagging needs to be aware of 2 widths in Intel LAM as against
     a single width in AMD UAI.
   - Requirement of making LAM_U48 and mappings above 47bits mutually
     exclusive is required for Intel LAM only.

2. The enablement bit is part of CR3 in Intel LAM which brings in
additional complexity of updating the CR3 with right LAM mode on every
MM switch and associated tlbstate changes. In AMD UAI, enablement bit
is part of EFER MSR and it is a single time enablement with no MM switch
time changes.

However, let me take a detailed look once again and explore further
code sharing possibilities.

Regards,
Bharata.
