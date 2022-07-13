Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 077B1572DC1
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 07:55:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231603AbiGMFzP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 01:55:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229888AbiGMFzL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 01:55:11 -0400
Received: from EUR02-AM5-obe.outbound.protection.outlook.com (mail-eopbgr00084.outbound.protection.outlook.com [40.107.0.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23C17E083
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 22:55:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WoS+54FbeIPf2qJJrm7LvEpABt+PFJNzxKA8QrbzTWubfcbLosCXxONdP7fEdqRlvSwY95n34t9Mg6xU39oh1KlXYN1sy4XkxLiWoN/yM09FMZ4gQYhuQsfFZ0sBj508Gq4bPMX+WfupQI6AfU3RfEnZtYxVZvEx9+JUKUrn+4UOw3X4OZob/ZXmIDUR5UozKxqWQyPLRjNbt1nI9OBJQB5Fd65EWvVFAlyYXiKBsgTNCmmicymbHRDBfL31mpog+luYU/JOAVWdr3JgknQTb809ot3RruDfCm1Wsm9iJaQDOYk1s3fVCPvxw/juGephJmjUYsbq6BkXE7ZuiyfXyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9GwnI4wc2WVXTeskyFFlqhlCn8IDGfaU7tHz9iiq03Q=;
 b=NHLcxWA6F94/OB8T+PORQza1HWl1YfOgesJAK/tRkKN5CR5kwTFPl7z8WnRKSnr540mbiGCLUHaKYfB4E/pLK1MvcIvs9FJG3EQj3Ll42aWvKJkvHryqzjchx+aNYPxJCjY8/j9jM/+8tAoRW3U0+4o1TV1cHNnz1UjKgl0psqN/7Aq66iYLgMCNcUBXcWNgQOgDokVSSyJ26PEi2fdEMf8+gkcRhUzdwMbW8itjQtZFnEX5dCbm3skYMx9zZBEMP3TwkYHmwidOC9ospC6FcpBkubWGMOUC+dlcXcQOYmsncOsO/AJk7gerfZeqsQzNPqYUjxHSKE8PvrXz6bJXQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9GwnI4wc2WVXTeskyFFlqhlCn8IDGfaU7tHz9iiq03Q=;
 b=hKsD6bQE9xDjwp0nBCXZBl0JgunXyLRc7RJpzgBOKU6fJoxOytLv55D8GQDyCa34iX0dqp5gbz5I/nFFApSqONhr9sujfkobpWh/PXM9OmZhSt52aAjpcNifnwUZSnANtnkzIp5AqVdzXhkYmH+hNoBbxTTGS6ZmI7Gqy9eSE89siWWqJvuSeA3B9bHzTANoWr6JvqD7JX14EFtHv1sBMUiUUhwsNTFLdb3Wbd0GJdXElqS6Mk+TaG32JY0oM0LM37WASrLJQgQUM2bWwUHUL6AdNN/iaG1AVteWQq0lto6f6PYChWsmzea7GOjaVW96wrs6OnczKl2+4MzTeKViCw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VE1PR04MB6560.eurprd04.prod.outlook.com (2603:10a6:803:122::25)
 by DBAPR04MB7400.eurprd04.prod.outlook.com (2603:10a6:10:1b3::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.26; Wed, 13 Jul
 2022 05:55:05 +0000
Received: from VE1PR04MB6560.eurprd04.prod.outlook.com
 ([fe80::60ad:4d78:a28a:7df4]) by VE1PR04MB6560.eurprd04.prod.outlook.com
 ([fe80::60ad:4d78:a28a:7df4%4]) with mapi id 15.20.5417.025; Wed, 13 Jul 2022
 05:55:05 +0000
Message-ID: <09fee965-9cf2-110c-4484-d00bddb6b782@suse.com>
Date:   Wed, 13 Jul 2022 07:55:03 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] x86/PAT: Report PAT on CPUs that support PAT without MTRR
Content-Language: en-US
To:     Chuck Zmudzinski <brchuckz@netscape.net>
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Sean Christopherson <seanjc@google.com>,
        xen-devel@lists.xenproject.org, Juergen Gross <jgross@suse.com>,
        linux-kernel@vger.kernel.org
References: <2885cdcaccffd287ef69c7509056ddf183a38a0e.1657647656.git.brchuckz.ref@aol.com>
 <2885cdcaccffd287ef69c7509056ddf183a38a0e.1657647656.git.brchuckz@aol.com>
 <388a3838-1681-dba4-dabd-a7f27817bf34@suse.com>
 <b24d7fe6-c1aa-5d3a-5c68-98dfb57bdc40@netscape.net>
 <32c86239-c434-369d-b6a7-f6f88cf5430a@netscape.net>
From:   Jan Beulich <jbeulich@suse.com>
In-Reply-To: <32c86239-c434-369d-b6a7-f6f88cf5430a@netscape.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0013.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1d::18) To VE1PR04MB6560.eurprd04.prod.outlook.com
 (2603:10a6:803:122::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8065d7aa-3b7a-43d7-1e99-08da64943c07
X-MS-TrafficTypeDiagnostic: DBAPR04MB7400:EE_
X-LD-Processed: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba,ExtFwd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Cp08Lt8J2tdFYcBkx8QHfJCYxbTWu0QHcFemdGWT9xXQ4BkT9p8+my6vXZZizTMOmyOAGZXk8vJaFqQR0EVbrJVgEkpTq1bjuEdFCXIp0H9jMvrS0A9tO61WL0WesHda9fX1yhwNeJhRkBfdYJKxu7lBkj9IA9B9PNAEe+CwQn+tb+BaTckihgrZ47Aaqk6mMjaAiKOzNmnJ5EMBD+4U3dIQwAZJ5noNToHdvmyhUjaWr54D9tAY4DLEUTYvzzVVYy2fMscvwW4oPJABVIti2XUkLCggz8zjOZ5ZQaLAIqUmh36oxp0q0BmiMXAi5CmXFZ8PbFGuh2rlUwJ5yqrQ6Z944kjwezUhLNF7Gl2G6lu8AhOpoF0wJdQb1qqTyNsCoTTdZ3CG+2xBW4i7ic3H0x2ocjqCnhY5np3Bexp1SamksGuxHHspO357N+jhIEfKr1iyHWYGDwU1c2IKFXr47JctATGPG/QuI3QGr1XBDfD6I+8KHVv9HpxOgHpPBwJBSdH6+J8r96n6poMDkjpFmAHACofnhsHLgok5/VoMfJWTEB4QhvkMV7IrtT0VomKvusHEt4FqkGVOAfXCq8ZdXJReZM0F1rgDWYMS3Oy+szwrDK+gPE67WP4QrUNXZV8v0wXDuhNpXfQD2I/vo1PZHq83vv7NnyNoDQx9QEtht3G4J1/TrPAWAx4Z1IwTF9CJqnNXd4N2dtNqxCkaKNNDiF2KPVQhVJDfUV1EdePOaVeXFqWU3gXdQ4I6M4pe8fott9ojOpsJHWoPyx05lVVQfohDcn82OrM9vUuju1K8gJ1PHejkSYVEQ6tOLmQ+D60WZEks1LRRD+6MyLp+8ItvWJOl+mzvqUMD6PRKKQfIr6w=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB6560.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39860400002)(366004)(396003)(346002)(376002)(136003)(186003)(66556008)(478600001)(2616005)(66476007)(66946007)(38100700002)(316002)(31686004)(54906003)(8936002)(26005)(53546011)(2906002)(6486002)(41300700001)(6512007)(6916009)(4744005)(4326008)(7416002)(6506007)(36756003)(5660300002)(31696002)(86362001)(8676002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NUZhZlZybndiRE1jOFVWaTRPeE5teDRjWmNSeU1NUFZXN1NEcm5rdUZadUla?=
 =?utf-8?B?U1pDN1p0VVFRT2ZwWUZhR3RTak9nT1YxbjN2cmtKT2pMR3o1K1N4eUhtVVJK?=
 =?utf-8?B?SkRLcnRsZU1zRWJBTnBKV0lJOThsK21ZYXNVS1ptMXJibFZsU2FpSzNybDZw?=
 =?utf-8?B?My9tTjlKWDVuMGR6anZ6U04rUTZGK2tXYjZPUklZRnNwUHAvdVI2TnBUaTh0?=
 =?utf-8?B?MWoxTXZuUHdWQmJ5LzFxYUhkTmVmVGZ0THlGRDkycEFtb2pZMFdXQmJPY081?=
 =?utf-8?B?aDJkVVJIMmY2NEl3Uy83SFdvcXdtbktQbVJsQm1QbFFJenV5MlcrdjlnbS9w?=
 =?utf-8?B?V25QeWdVTlZhMzMvV2hQSDJBclJqbHlKTlh3ZVd4TjdwQ1NQRVBLQzNoSmR4?=
 =?utf-8?B?RmFpYXBRdys1SzhmUE1DekRLZ054Wk9KSGEzOEFOV0VKcWZ4RkhyVHdPYmVR?=
 =?utf-8?B?QlNmbE1KckxzdjJyOHRXdE0rRzZOMHNzSXJFOTVpeGJiRHQrTnBuN3E0QnJs?=
 =?utf-8?B?U1JwNHF5Yk53UHYxVlBDaVJ4eVF2V3pFL2VFbW01bUFEY3M5MzVyd3VJb3kw?=
 =?utf-8?B?QTl5M0N1VkFtU0xXMnFNNEs5NlZaN3BHV3VPdDliM01yQkdUYWp0Z0l0WGRx?=
 =?utf-8?B?M213OHNJY09oY0JJRXh1VGprTjN3bS9maTlseTU3Rk0zL2ZmQUNmYURGck05?=
 =?utf-8?B?UE9RWnB5N0xNQW9IeTFtU1lYcEU5eHhwVmRoZittWXQ2ZXVvNTZkWEhEUXNO?=
 =?utf-8?B?MnZKSjlpaWRteUZDemx2MVc1RDJLemhKRTM3UW91L1diTFpoM2hjeU1CZGRx?=
 =?utf-8?B?ZkMyQzVOZ01hN3g4TGs3cWxwZXRBallrdE41QjV5Q0txVHB5WENYeWpnMG42?=
 =?utf-8?B?dW1PUjNZaDRXWndrRnhodmlRYVhieXBXTzJkeUsyNDQwS1FhdXpFRVh0Smla?=
 =?utf-8?B?bmRwRmdTZDJaTk80T0R2ZTNvOVlJaFNESHlZZWxGN1lyNGtpdTl4aVVWQUJw?=
 =?utf-8?B?Sit6THlGWlExTzExQ1dlbHlZU0xLN0g3eG8vQ1Bka0FBbDY1aE42M2phK0g1?=
 =?utf-8?B?MndCbi9OSGVIbXA3ZnBxSlF2S2VNS2tRS3NaQ0hLWFUxbjZTazZMNDFkd2lM?=
 =?utf-8?B?dzhrU3FGRlp5SEltNHNwaGNnSHY3ZjVNb0s0Mm1SRzBIRm1oOHNPMkZTSDAr?=
 =?utf-8?B?NDg4UXJGbEsycVlTR2FBNW5MRHY0bUd0M0NlSlp5aUd2R2tQS2pGamFBUml3?=
 =?utf-8?B?RVJ4UW5ZMTZoMlYxUkhpR0doSzExY01HaEdtNS9FbVNHRnRwK2o1RkJaNDZ4?=
 =?utf-8?B?TlltbS9ZNUVZSGZNS3B4T2RUbzZSOWh4QmFTeXZmLzF3MEFqOVVOM25hNzRm?=
 =?utf-8?B?RVdWUzVyY01FWnFla3RuNmhTbVIxT0pmVm9PczdlZWFwanBpdjkyK3J2a3R2?=
 =?utf-8?B?ZWxxa1JvQ1E3d2FtMGM5TVdHWVcrWkNqSk9MWVd4Smc1bC96ejBKMm5xd3dV?=
 =?utf-8?B?dElzaVl4U0RUVjBMRlBTK2FXaEcySEpRcGRDWUVCYjQxMWJPQ2x6b0FyOGNI?=
 =?utf-8?B?Z0pSUFhXT3RyRGU3V3gyMTNremk2ckZWcVJSd0ZvTlZCWGFFYzIwVjlFS1J3?=
 =?utf-8?B?L1YzNG5pWFNpWW1pNUkycXRFVnVTc2UrWlI4aXl6ay9oek5yc2duSmpZeHFZ?=
 =?utf-8?B?SlBVWTNKTXlDUmk3ZTZoQVRyVWZwSXVBOU0yejB1aXhiSVBQT3BqK3V1MEZB?=
 =?utf-8?B?TE5BZldLNytHL3AxOFlLZTNsdk56N1E3bWw2RVRnV3NreGxJSUVvaUFUcGJY?=
 =?utf-8?B?QWFpZmM1cG51MWhpWG9nN3BHQ3YxSC9kRENQN0NDTFgxcndpa1ljSGJpcjBW?=
 =?utf-8?B?SVpFejFSTHkxd1BjbXpPeUNGNXQwRHBremdnajF1YW1sdW03Q0tSak5JRzEy?=
 =?utf-8?B?YnZHTVNIekRTQ3dLNEJHYmNBR21pSlBtN3Vya0hNaGJXRVhCTGZtMWhwZ1Rm?=
 =?utf-8?B?M2JSdUhWaThsQW5ZdW5rWXYxK0ZEaWxtR0s4dkF6eVBvWVVXU0JaZlVoWUdo?=
 =?utf-8?B?UzI4RVFoNXlVWHo0MFpMSUt4ajFDRDRGUVhnbGdYMXNXcTFJQmNZdWlrVG9a?=
 =?utf-8?Q?DmHU2OWWzOTVjyg6SW3mjMKOB?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8065d7aa-3b7a-43d7-1e99-08da64943c07
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB6560.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2022 05:55:05.3570
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vwj0U9lBPQ0NNCqtj8Vf+PE70k9YrqKqPpJFwHrOEpce17dN1j+iWBRFLGYy3pkdSixEbesVBHetumQ8gPR5sw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7400
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12.07.2022 21:48, Chuck Zmudzinski wrote:
> I will also re-compile and test the new patch before sending
> v2 and unless Jan objects, I should acknowledge Jan as co-author
> of the patch since I will be using parts of his proposed patch
> to fix the "nopat" issue, so I also need to get his sign-off before
> sending v2. Jan, how should I obtain your sign-off?

If you really re-use any meaningful part, I think you could simply
propagate it from the patch I had sent. But I'd expect the pieces
to be too minor to actually warrant that.

Jan
