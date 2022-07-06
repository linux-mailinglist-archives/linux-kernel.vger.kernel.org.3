Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48D0E567E43
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 08:18:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229941AbiGFGRt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 02:17:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229628AbiGFGRr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 02:17:47 -0400
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2051.outbound.protection.outlook.com [40.107.104.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E98C13DEB
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jul 2022 23:17:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fck9NlABHzM6lT7nv/wTqRHrOmJKV1J19XQ6ugs1EEA62cf6pIt2Rxw0UkeO17IXDbLGM6grZjh9snAxoWnELxXQasLBUad2umj0JFG7EMRknz1fEyAKg+fkuL6q4qdgz8bWvvbUDeKS8uhGVAAtOjS+JzwwgTEv9uboGn1+usrMyNDMGH6HPpxURRvu+AMXM1VY4IR7xqypFl2yLl/eitdrL4w9XrSo8i5P+3q5NlsX5yqvxul39iWmsOYUpwC58NQZcDj7GL0PsF1nH6N3/sv5qKHLpqCVICpLNvb+rDNmv4u8APZNTMyq2aG0OpQIzjtnaaYnZXvEk8EuO6nI7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4/FaPivtjBKo/5QIQwt/UgWd4q1clpHngbxHENytT/I=;
 b=nv0LtVCwTEVUg2+YlWUsKy4pC88jdBd+9LsbVe2XRF4hwJ8/3y4jqvCX3A5wyqLZvJQ1HmDY4uiAatVPwD/Hw5El/+n4g5ldvABZ2mS5OKkNSsz7wiNGNdKyDChwvZvt94prfb7ycFPKdWBEde4RU753eDDeV1L0VwzsFn6laSeB4gTLUwqx4Fy/xQeedEVPHjTVjhrOnsYR5d7UVhpSP9zh4wGX3/aRIe3mx9KC1B20+hBT0TvbtQVcDXSxGA5MqOnP/Osgrvn2lnnqfSqHwk08/K3fnZcqIQTVQg29qElJxqRJ2iLz1dJgrZTUQp3uQCshSG4J6UXmL97hjtqeig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4/FaPivtjBKo/5QIQwt/UgWd4q1clpHngbxHENytT/I=;
 b=2U5pKMOKRNxVP5EVh0vWGjoQO81jT09OHEh9zutfn5Z1I0H0psSo8LWwSfiUhDvm5CrS1WLHY3qGwHy91REbGj2GLeEfA04QKSlGLPqq7mnEyjidXUxAcu1/1StSSwxrmMYf3kShdCa4WLqFbcKBW8aCQFHx7uBcr7mU0aEHpmhubWti6WAkXg9SfuCdPIxt+muP1hAbsHUfCIwI15iRQXfvrzgMJAkw2c7Jf7MlFWaPx76ngdVk48nc7HMQJ+YcwuWVXzlX0UWcAjQGTkVwEh7rD5XZRFPce6xa+L9YIdtrbFG8YZaHWHuR42mAuM9hZxta2aPuktB8Ygzs3ppbjw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AM6PR04MB6551.eurprd04.prod.outlook.com (2603:10a6:20b:fa::20)
 by DB3PR0402MB3787.eurprd04.prod.outlook.com (2603:10a6:8:12::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.20; Wed, 6 Jul
 2022 06:17:43 +0000
Received: from AM6PR04MB6551.eurprd04.prod.outlook.com
 ([fe80::dd30:2cbc:361d:2d1e]) by AM6PR04MB6551.eurprd04.prod.outlook.com
 ([fe80::dd30:2cbc:361d:2d1e%6]) with mapi id 15.20.5395.020; Wed, 6 Jul 2022
 06:17:43 +0000
Message-ID: <b7fa785b-cea3-3e05-c101-d6c7bd101ef3@suse.com>
Date:   Wed, 6 Jul 2022 08:17:41 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] x86/PAT: have pat_enabled() properly reflect state when
 running on e.g. Xen
Content-Language: en-US
To:     Borislav Petkov <bp@alien8.de>
Cc:     Andrew Lutomirski <luto@kernel.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        lkml <linux-kernel@vger.kernel.org>,
        "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>
References: <9385fa60-fa5d-f559-a137-6608408f88b0@suse.com>
 <YsRTAGI2PhfZ5V7M@zn.tnic> <016d281b-7e40-f1bd-66ee-c19c3cc56efe@suse.com>
 <YsRjX/U1XN8rq+8u@zn.tnic>
From:   Jan Beulich <jbeulich@suse.com>
In-Reply-To: <YsRjX/U1XN8rq+8u@zn.tnic>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0079.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1e::19) To AM6PR04MB6551.eurprd04.prod.outlook.com
 (2603:10a6:20b:fa::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1a15c52d-1ced-4263-0bc7-08da5f173c96
X-MS-TrafficTypeDiagnostic: DB3PR0402MB3787:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +dki65Glg8n1gvzCGzEehTgm4YIyP8Noz4wPdpGwPtOXtkk1rKEJ22b9EdPr7bKv/QZQ4K2E0aO5hk+FP84Exnpt1QNjpGsPZ5WxxNb9yLSZgo0wlnvgHdBZiARdlQgTS320oYndJfCwRuby2Z7ZwuMvsxIxOXBQy4ZtwrLdnrYwWxvYZLDZb96ST6yOrlczGWhCtx/lppU6jnCfR7JZQLShKkr/tOJvY7k8ZeKIsHkFtGSdpKNn346wqc16ZIUGV5aN7eaE4ACvxRqpJ1GjRBDnraASQsBx0Tvt7yvGyuENmNcNyVJhXNmDbnEPrxZRlhVFqaBOlLp1EHvqtvo/94cVzDs8aFteELbCp6FUxfc3cyUzopEpnMqCXVMLatRRQzqCT7msrcSl1LXOMWyqZi8UDRXG9e4wCnqXkciO1LP3jRwz7IV+kEee7zaxfXNsThDzv7q9dLpyeOLCxSpEI/V1i3fNKnB+cUK+ltuZIrtYVaAY/m0elV393/K5HaXJ+ZYaW2uC2gKgQE9WdOPFVffzphhpXXPtBSas0YDaw3ganD3SMlBmSOhG5Rlp7Hu33hywxyi76NKbb5wgylQXUPrbdJp9/VWlQPOqjqSkLZ3wAlCb7hJ+1Pn7d8DOE0V8xhRPo84POo0gwe4KmwpG6s1NiG8/axbMGkLjXon9mpNSV7xLFIkH7jStKCM9HGBeB08hgnYycgFu1DFZezg/9z5sXeTHGCgeuxSuudfWrlDZhd3kjQW0GrlPMoglr8w+Rrg99QdaXTgJ6R+18L1pvIVC96u+dX65arzs2lIDYB39mcjsIFb8NP6+80UhLe2YrT9Qi9ao1MFVM/o5gKl9SfXaTxLYsXQCQyoTCi8koF0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6551.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(39860400002)(366004)(396003)(376002)(136003)(6512007)(54906003)(6506007)(5660300002)(26005)(53546011)(6486002)(8936002)(66556008)(86362001)(66476007)(4326008)(66946007)(8676002)(6916009)(316002)(478600001)(41300700001)(186003)(31696002)(31686004)(36756003)(2906002)(2616005)(38100700002)(83380400001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UHFrVkVkUkd0SFZJR3AvMHZyb0t4NU5pQ2EwQ0hoU28vckIwakpvNVpXMzBj?=
 =?utf-8?B?Q0J5cVZLTWZWelhXS25XZnBEZ1JWZTk4Z2VOR0RwdmVNSzNITGdUS0xLQW9q?=
 =?utf-8?B?eForSTdic0xpbi93TGdVTG1rWDhpWkJ1TncvY0dsRDhHbVo3VHlQaXN2dG5k?=
 =?utf-8?B?MWtVeG1VcFhwanFJaDE4aGE3TlpKUlJrcUprRCsrR1IxbEQ2cDVGQVZ6c3dv?=
 =?utf-8?B?TWtFb2R3aVArQ2k0MnF1MCtUc1NXOUZKekc3WWNJQXplcGtjMEZieTBlQ0FU?=
 =?utf-8?B?QVdzY0REUlBkMFhkL1I1eXFZemg0bzlOSlFXZFMrVzY3NVdubzUvNmk4VlJ1?=
 =?utf-8?B?TTVRM05qT1IzUGNYRkE3ZlZwWm55MXoxTTJaR3VWL0hZVzdtVDdZaThrMllz?=
 =?utf-8?B?Vmk3cjFyRlhUeXkwd1M4TVBCR3JVNSsrUHZRY1RwOVhqTUxYM0hkcHdDZGJp?=
 =?utf-8?B?UHZxYzV1aXAyZTdzVkNIdjVnSHE3MFJ6blQwYXhTRkxYZENaWEt0d3RvSXYx?=
 =?utf-8?B?Nk9vU0NaTzJnVkpkcjdQdnVuL2dCdmNVL2t4M0VjR3pNR2lGRXo2S3ZGVThP?=
 =?utf-8?B?OWMyNVpEK05xUUZTWktTUWd5WDdxUm94TXljYmlsR1hxUG9vVXM1SDRlVHJz?=
 =?utf-8?B?Witqbi9aanUrM3Q1aU5QMWQ4cXlnTHFxM2NOSmFNSm5WNG56aEpuN2hjMWFH?=
 =?utf-8?B?RjljU2ZuQlZQTWFIOGtJbnJ2UkhpOHlZVVlCMStZUWlFOXFCR2tqNGgvOTcr?=
 =?utf-8?B?ZXdGMFZDRXBxWHVjaXpkcENXeHl5ZU9KcSt5WU10RElNZ25ZOTBraU9KaHcw?=
 =?utf-8?B?ekR3SWhZekJMUkt2Um5JSFV3UStVdkgvdmttOE5hMTF3aXR4aWE3clZGTlBo?=
 =?utf-8?B?d3pCS092M2IxQUtmS243QzJSeHE5NTNkTFd3Zm9EUTdkaXlCRnpHUFFKbDV2?=
 =?utf-8?B?bVpmQ2w0Zzcza1JTNUplcUFVVlZ3dXUrMmg4dkhPRVJud2VydmFGT0xNZnJq?=
 =?utf-8?B?NDlueldmSmFkSTBVazJ2RjZVRlVKTVFPMGJjek5XM1crcWJMZDdOS0hnVUNQ?=
 =?utf-8?B?OVlpa2ltV1lZbjR0WUE3NGtJd1ZENWJqWWcrOVhnSGl5YldiYWFwVzNNSDE1?=
 =?utf-8?B?SmhXS1ZTTXdmclFrcFFJd1dDVWo0V0MzK29vSnZaaVBEWmFnVjFJcXlMeEFB?=
 =?utf-8?B?T21hbHFNQjhiRHdJWjJHSjhhajBXb1A3UUh0NFBVRU1iUmlFR1hkZGtoSjJs?=
 =?utf-8?B?NGtmSlFiRW84cnVyWnA0a0FWQUQzRVgreU5pNndDeXlRcEtFME55eXErVnVH?=
 =?utf-8?B?Q0toV01QWDJJNE5OMVJHcG4zR1JQRzBtL1k1SDlTL3JXc1ZmUHFmcVZPU01w?=
 =?utf-8?B?cU8yalBRYldERm5kTkx6bTAvMmRoVnFVSW91Y1dNWVpqR1BFSzJsUDdJc0pG?=
 =?utf-8?B?TnA0b1BaN0JGSjVQZUhQWXBrYWFIdjgzeTlNbXpPOHNJTTd0eGpTMUhsUGZY?=
 =?utf-8?B?QkEwekZCMWR1SkF0SmIyc3k2ZGd3a0pubmMwSFZsNnpIZFE3RWdUL1lUUllu?=
 =?utf-8?B?Ulg0ZE9UeHIxQURDTXU5a0dzYU45akRtOFNFUnFRdnhOYVFZRWJYYjZ4ZEdw?=
 =?utf-8?B?RjRpTFMwNXcyMDVxcXhoaS9MSWx3UmFqWDBoempzbForRk9hSnNMcUEzdlJz?=
 =?utf-8?B?eG56cFFRaGxYTVRJQlJSWFd5RDFLSnVvd3habzcwR29IcHVCcnVNS0dlQXcv?=
 =?utf-8?B?Lyt2SXl1cmtXdWVtWHl1U2hCVE9nTXBmcFNNQWdLTXBHR0Y5czF4UCt1TWlX?=
 =?utf-8?B?R0UyMEJOc2xzVVdLYkFjbFJ6eDByaUxsV1d3NUtzT2s3N0Yrbk9MRUdhcXRU?=
 =?utf-8?B?QXYra2NGeGRPM1RQbEJUNU9valV4Mm95VVhhcTBxS1A4UGdNV3MvU1N6RFJY?=
 =?utf-8?B?RDJ3SlVnZHlFdUJvRUc4eVFIZGcyL2tmQVJ1QS9jV2VWWkljVk1JUkVkbjhZ?=
 =?utf-8?B?VGpjS05ONmJKQ214ejdFbWFDM21MM0NRMnByM21XYXpGTVBzSVM1czNIQVdM?=
 =?utf-8?B?RjVXY29BOTJScGZqazN5S2RCNFFEWDFOcU8vRSs1OWFGZEZ1UE5xY2FHNm9m?=
 =?utf-8?Q?lmrr6Xqsc9douVJkvE4aMfkfB?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a15c52d-1ced-4263-0bc7-08da5f173c96
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6551.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2022 06:17:43.3105
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I0afLh/yH6v1DmY6Z8RlKepQkH80TrWasyUwR57tFxxhD+TyRk9ChdNnnWC9ZI12bWbgJ1TRMhFwfDpWo96nKg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3787
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05.07.2022 18:14, Borislav Petkov wrote:
> On Tue, Jul 05, 2022 at 05:56:36PM +0200, Jan Beulich wrote:
>> Re-using pat_disabled like you do in your suggestion below won't
>> work, because mtrr_bp_init() calls pat_disable() when MTRRs
>> appear to be disabled (from the kernel's view). The goal is to
>> honor "nopat" without honoring any other calls to pat_disable().
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
> As to mtrr_bp_init(), can you use X86_FEATURE_XENPV there to detect this
> special case when the kernel is running as dom0 and set stuff there
> accordingly so that it doesn't disable PAT?

Sure, but that alone won't help. There's a beneficial side effect
of running through pat_disable(): That way pat_init() will bail
right away. Without that I'd need to further special case things
there (as under Xen/PV PAT must not be written, only read) and I'd
also need to set pat_bp_enabled and pat_bp_initialized somewhere.
I could of course check X86_FEATURE_XENPV in all the necessary
places, but I was quite certain _that_ wouldn't be liked (nor
would I be convinced this is the right thing to do - see bottom).

> Then you don't have to touch pat_disabled() either but intergrate the
> Xen variant properly...
> 
>> I can probably fiddle with pat_enabled() instead of with
>> init_cache_modes(), but when making the change I had the feeling
>> this might be less liked (as looking more hacky, at least to me).
> 
> Why would that be more hacky?

My view on it, as said. I did actually make several attempts, until
reaching what I then submitted. All earlier ones were quite a bit
more intrusive (see above for an outline).

> I'd much rather check upfront what the kernel is running on and act
> accordingly instead of hooking into random functions and then years
> later wonder why was it done in the first place.

Thank you for putting it that kindly. It was a pretty conscious
decision where to make the changes, after - as said - quite a bit
of trying other variants. History with Xen-specific changes has
taught me to try to keep them as uninvasive and generic as possible.
The more things smelled like Xen-only, the less they were liked.

>> But besides the "where" the other question is: Do you really want
>> me to limit this to Xen/PV, rather than - as I have it now -
>> extending it to any hypervisor, which may behave in similar ways?
> 
> Well, do you know of some other HV which hides MTRRs from the guest?
> 
> I haven't heard of any...

Any decent hypervisor will allow overriding CPUID, so in principle
I'd expect any to permit disabling MTRR to leave a guest to use
the (more modern and less cumbersome) PAT alone.

Jan
