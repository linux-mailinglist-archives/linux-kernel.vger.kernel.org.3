Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90198569A9B
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 08:39:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234699AbiGGGix (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 02:38:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230124AbiGGGiw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 02:38:52 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2057.outbound.protection.outlook.com [40.107.21.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16217B1C
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jul 2022 23:38:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BVqooPY1la/VXv31gWYrZTHxT8fwRCF6ukm0HF12mrMRN4beZPj7Qs+X4zmJceUJ7VPFzwVedo6nWUXix6YhLVhNUlDcYoQ7IT2DfU97ekbvzqRCksIGQpCex1pi6xQEgvUbfZg/0K3jdXA4NpxutM8t2HIfc3ZlfDzKuvlLSNhWebacfKdcb+WZvmnxht8U1GUkqmXBHcsVGZdLcyfFuOaoLPvNPIjkVGsh1twXaVYaeGdFkQF8u0/xo7vYfsTtHGHecMdCPXbUFH/an3lenqvP31PTlyNOXKR3QGzPN4L7GrTYpHQuhvU38dDeZBMzuL4XuxCfTKYp2JYLKtt1iA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k8l4Nf8fQ67bEwIAO+a1iTiSd6Jzq1VNu3+xuHiRqxA=;
 b=SIZicQKRhmS7mZw5aZgll9PXqIgDPwdvC8FnfULNzebu5w69jc5ZUR8RGIbGCUAPBTFKODPd69mA7UHm7p5VexzQREKY+aBjBvB0TEmKu0l78igY9h+SfkXgOfZnL+C+emG/1OdxVF7CYtaP+PMQQl3ccjWibvjfUg4dBVCEfzNXzr+9Qfutt8DHZ1zR1xwwAa3l3nlvmedPNQtAQxR4pxm3McPkIO9EE2+UNpSOgj+ySljwEXf4YSRqKEtBllGKbH6qKS2Ub/mdXGUKbME5MJHNMtpf0fBMnCPWCSrSVH7yX5bDEej+2j2gaA4QqFAfzRCCx6HZwy3b0icDuVto3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k8l4Nf8fQ67bEwIAO+a1iTiSd6Jzq1VNu3+xuHiRqxA=;
 b=W+Zw5AEgOicnQomNBnVhdLUTUQlpq9PPbHcSSEnBcVnbxlhXDrU3qhQlcjPdWDoXEXaJ4UQDmjqQdqLX5rlmuBhJt/Q4bWk8xbAfZWOuzMntemgQG/XCrvd1IaBeUhGXoUOUFguXVOEgO4jBFHunb8cJxZ5UJPPt5vUyk6q1sNjBKsapeaMKlY9yqssKc0rWtwAGt93N7Kaq7BDBOoOfUk0zHQxCFGI+kK4m8QVD70xsT8/myn50JkYKR4H70YgYHvbcHqZYLRU/nb2Rmg9H1CzK4266pMy+RT5Fp6hIVwUkfjaL22otAeE+p/NBslaUBhoVX45IDqhUPv680xOFAA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VE1PR04MB6560.eurprd04.prod.outlook.com (2603:10a6:803:122::25)
 by VI1PR04MB5790.eurprd04.prod.outlook.com (2603:10a6:803:e7::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.21; Thu, 7 Jul
 2022 06:38:47 +0000
Received: from VE1PR04MB6560.eurprd04.prod.outlook.com
 ([fe80::60ad:4d78:a28a:7df4]) by VE1PR04MB6560.eurprd04.prod.outlook.com
 ([fe80::60ad:4d78:a28a:7df4%4]) with mapi id 15.20.5417.016; Thu, 7 Jul 2022
 06:38:47 +0000
Message-ID: <bc13c66d-a885-e405-7b53-8cd7afdbecff@suse.com>
Date:   Thu, 7 Jul 2022 08:38:44 +0200
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
 <YsRjX/U1XN8rq+8u@zn.tnic> <b7fa785b-cea3-3e05-c101-d6c7bd101ef3@suse.com>
 <YsW/3/fEuNYAuFwZ@zn.tnic>
From:   Jan Beulich <jbeulich@suse.com>
In-Reply-To: <YsW/3/fEuNYAuFwZ@zn.tnic>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS9PR07CA0009.eurprd07.prod.outlook.com
 (2603:10a6:20b:46c::9) To VE1PR04MB6560.eurprd04.prod.outlook.com
 (2603:10a6:803:122::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7e90a53b-a53e-4780-bd70-08da5fe3589b
X-MS-TrafficTypeDiagnostic: VI1PR04MB5790:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: T0rEg8n6X0RTwHf3cXu5K/IKD/eV5Douibq3m9YtTyjnNtrvugrn2cQ09RbBk8MgQ06txc+nbi98jlYDK+irjZHMD/wQPnjzDoGYqU0ytxg3PlH+2cE8H0fUHGnqEhKp4/0B2pzig93+EQGesqpi8XS3t15+/vk0J7QFs/fOQNzXGhC5DdCRzh/s8Tc1cxQWxz3r8ekT438L3YT1J9hKXkMMMMTgZBUh5KEOr0PccuJYFf57fIk1Tr1hL3XcKZloONQu1wD2lW3ViuVY/B6YboIofSbnH91DEe5I1/CA12CYCNfuGovp78GDmJ2ic9UggWwaosK3TVPUwN6jB3YpHd7RoEPSzh0ceo3RmEshdqaxhqOfXVFXW3QXdI9ZG2bvZQXRMQToYDjgVI7R8YtqOkIacH+ZkxcmpCVz30dnrv0E8dc3y5TxEys+2aisI9ZQqBtLtbyJqPFuDLzyrJIyrCLEIGLDShFFLiGg+8ltnfawZdW7oh3+WEF09bRNOJpN93TaT0ONBvrhyUNKWqyYVL4HVMgQp87OXyO1XuVEfqKS0KvuwFzPUm4cn2YQctzDnmdeMT/6ITAaEl83zUblV/c1mlzmAe8JDMvuzjP2OrJqMo8pGA5lTUB/eX2jPgm1XmxH7TsRYrtcK2jPDRrRVBDKbdYDUiLlzk9gqoGVKu1gZixWAD9fhUXU8vbMxr0Qwc8RuQZL8SipbF1AEc/nW7nNi4m3kAcz9v7OKbU6OQtKrPcVk71sW0HttQeNgFvtaE1WkzPYlbGXk9/lMCTLzSmhjTFOAgfAoebNrGP1Wj7m6bDCaUhJVFJ5K2kqX7ceGacHuoAUafegy7gFJHA8iA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB6560.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(136003)(396003)(366004)(376002)(39860400002)(8936002)(54906003)(86362001)(2906002)(31696002)(26005)(66556008)(8676002)(66946007)(316002)(5660300002)(6512007)(4326008)(6916009)(66476007)(186003)(31686004)(2616005)(478600001)(38100700002)(6486002)(6666004)(53546011)(36756003)(41300700001)(6506007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RzlOMHhZV29sckdlVXBuRmpjaGgzYWtNdUY1M21UOEhxRS9pVnpKTlQ2cGx0?=
 =?utf-8?B?cU51RUlrWUF1NG1kTStrVVFUMXozWHBWUnFhSlhRNTBrMno5a2laZ3o1U0dk?=
 =?utf-8?B?U3pJMkcwbzZkNENrRkVuVTVBZkYwK0ROTDZyU3NNQjN4RU1BbThHQTh2eFl0?=
 =?utf-8?B?N21PdTlYVjNyZEgxa0t5SlNCSUtWSnJxWjlPNW4wTUczWVd6NUp2RzdQcmYy?=
 =?utf-8?B?aTJpeWNIQWpSclJtd0g1UmF3Y3gvSVRZb2MvWkJUeDdqRjUzVVdsdTJ3Uk80?=
 =?utf-8?B?YlAzaHo2VEV1OGYrQi9JcmlIOE5SZFBMRndRaWhtSTRrMVptWEdacVVxbG4x?=
 =?utf-8?B?Q24xYU1xTXV2RWN5OHpCQmNySGtlcWVzMjdqdDFuUnFOOWczcFFuWElUcFVK?=
 =?utf-8?B?alJaUWhaMzlIOGpueGlqYzRWTVhOcmhFVWJQcGprYXhDK2l5NXpUYWE5VXhq?=
 =?utf-8?B?VWpOT3RORWpWTG85dVF2OU9CYW9uY1pkb2dSNmNpWjNZOWhKeElRVG82dTNz?=
 =?utf-8?B?ZGlGTnU0VVJXUENvTm43RkJDZFdBNVdaYU01MkZ1dGpRUW5KOUhxMjNtMUpN?=
 =?utf-8?B?cmlQbStjUGt5SFc5a2NaUWgxT29manJrRy9PYjlhU0hwbGpLYTdUcWlSNlF3?=
 =?utf-8?B?bnJtVS9RamFBTThaSjJiNDdQQkh2dFhsZGpuNjRRZFd3N1lXc3JibWM3bklu?=
 =?utf-8?B?RzNMajBlb2ltdW4yaDRjS2M2a2dsSno4ckVXK2RYazlCTlRnTU0vais1dXY0?=
 =?utf-8?B?aWRTb3Ira1k1OUxYR1pQWlltU2M3R1pPaXc1elBYaDhZc0ZOczNhVkhVNER3?=
 =?utf-8?B?KzhQTysxVDlVU0J0N1dVM0FacktOTlhQWFhCam50S01JZTBRUi8yQ05Jclox?=
 =?utf-8?B?REhsR0QvLzBzckl2MG5uNHQ5OTFCK0FQQlZPTWVwL2d2MmFPRHRWdUN0cTBB?=
 =?utf-8?B?SVk3c2dCSWkzVDNiTXd5UFJLWFdTSDVYaVZ5aktwVElmc1IzWlMveTY4YWkz?=
 =?utf-8?B?YnpiNnhONFI2cWpaTVIzR25FYU9MTnk2VEhzTnBsZFlHVFd5bVQxd3NOL3Fv?=
 =?utf-8?B?YTRsa1NqU3Q2dEdlOWVPVFVUYWpEQzVIVm5uckx3bStXOWF6V0RBSy9wRWcz?=
 =?utf-8?B?VFVqWUVJeXU0bFBHcHJUdytoVzhzL0lDOWVSUm91RFZJVC9kMC9pWi9jSXNN?=
 =?utf-8?B?MXNSU0VQY282Lyt6bmJ6TE5XK2RUTHRTQzV1Qkh2aXBSMGlYWURMUW0zWVNE?=
 =?utf-8?B?OWkxTkNVRkt2b0NNK0NkdDJMVEJDOFQ5cGxXWTFzblVTVXlBbFRWWDIzZ1V0?=
 =?utf-8?B?RmEyTmFKbmhHa3VNbEdiaGhPbk1vaDBlNGtWUDBVMWwydzBaYmk2Z1pwMVVC?=
 =?utf-8?B?SHdzSGtFa2Y2ZUhWcElOOGtEWGN5SWZESFluOTFzRHdzbWhyM0VHK01jUmVQ?=
 =?utf-8?B?TkFuY3ZOREQ2K2lFS0hFVFpEcW1kcHNaamNadFZFaWduNnpxTXVrY2pQcEx3?=
 =?utf-8?B?cXcvUTQwQUlWeTRYSTNvb3E1bkMxM3pHbWVza2JCVEtoejlrRjFuSXJ2dFBl?=
 =?utf-8?B?ckJ4SWpDandWQ3FaMDZVaGE0VDRMRU1OdnVkMzJIUit6aVJmTzVxeTEwcHVJ?=
 =?utf-8?B?TzRFeUNrWlluR2dLQVR1a1I2Znl0dnl0RndVVVF2alRKTGlIOFZSMGZ6OXpO?=
 =?utf-8?B?cHVBSHJqenhDWTRMa2t6RU5NQjgxdDREMWhORFBKNENDa0ZNTE1GRHBnaXZJ?=
 =?utf-8?B?ZjBrR3JLNlkwSHBQZU9yYnJIU1hFOC9lNnVyUERtQnloVFNyVU1ibnZnYk9p?=
 =?utf-8?B?alROU3d0YWJFdlJISGVGaGhobnczbFVoYjdYa2pkOWtTT3hKVXEvWmdsOVdO?=
 =?utf-8?B?UldTQnV4ZHRqcTQ0akZCSWtEMGNvSk4wMjZ5bzZEQW4wcU00UW9YRmV2eDBi?=
 =?utf-8?B?M3BjVDE3OTNkcmw5R3ZyUnBJTFZ2SkY1TXEyckZFZklRSENvU09EYkpzcGZl?=
 =?utf-8?B?emNhOU5ScHBXTTFPU0ZTSGlkWDgxZHNTSjYwWHJsQ0gyaHNFQ2lEQ0RvVGY3?=
 =?utf-8?B?OHVNbVVNQlN0WEh1dUtycHNNTVBreVNxVkpXVnlWR0lUNXo1cGJqNEpCUGpS?=
 =?utf-8?Q?SXro35KzhBwa3Jt01KMVtB+l3?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e90a53b-a53e-4780-bd70-08da5fe3589b
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB6560.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2022 06:38:47.6881
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S40zdMHotd/81B+j4BnNjd8SZ3M6E+2s3AK6Lk8t6YkEA+gTC+VBVq/+Ezlp04osrzDojZEa85RTmwsvtOZpdQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5790
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06.07.2022 19:01, Borislav Petkov wrote:
> On Wed, Jul 06, 2022 at 08:17:41AM +0200, Jan Beulich wrote:
>> Sure, but that alone won't help.
> 
> Well, the MTRR code looks at X86_FEATURE_MTRR. If Xen doesn't expose the
> MTRRs, then that bit should be clear in the CPUID the guest sees.
> 
> So in that case, you could test X86_FEATURE_XENPV at the end of
> mtrr_bp_init() and not disable PAT if running as a PV guest. Would that
> work?
> 
>> There's a beneficial side effect of running through pat_disable():
>> That way pat_init() will bail right away. Without that I'd need to
>> further special case things there (as under Xen/PV PAT must not be
>> written, only read)
> 
> We have wrmsr_safe for that.

Well, right now the pvops hook for Xen swallows #GP anyway (wrongly
so imo, but any of my earlier pointing out of that has been left
unheard, despite even the code comments there saying "It may be worth
changing that"). The point is therefore that after writing PAT, it
would need reading back. In which case it feels (slightly) more clean
to me to avoid the write attempt in the first place, when we know
it's not going to work.

>> Any decent hypervisor will allow overriding CPUID, so in principle
>> I'd expect any to permit disabling MTRR to leave a guest to use
>> the (more modern and less cumbersome) PAT alone.
> 
> So I'm being told that it would be generally beneficial for all kinds of
> virtualization solutions to be able to support PAT only, without MTRRs
> so it would be interesting to see how ugly it would become to decouple
> PAT from MTRRs in Linux...

If I may ask - doesn't this mean this patch, in its current shape, is
already a (small) step in that direction? In any event what you say
doesn't sound to me like a viable (backportable) route to addressing
the regression at hand.

Jan
