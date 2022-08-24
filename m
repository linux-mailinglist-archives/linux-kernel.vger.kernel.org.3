Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 427675A038A
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 23:59:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240573AbiHXV7e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 17:59:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237655AbiHXV7b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 17:59:31 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2051.outbound.protection.outlook.com [40.107.100.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82F6276763;
        Wed, 24 Aug 2022 14:59:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JJmMCaIAxV3+tHVkotc0iXcBMm4qLq94yagN4IY9e+yh8XLJul8CwFNKHdtxP6mIwIYXzsR8SOd5KTiFJOKcaaEiimIb1aewesbKhGg/7f9dbFxn3piKKrjjinlPt9P53TemLxh7VoFvTN/3leVtdTtIzN52xjv7ilvbWY86W9xUIraxfazks5H2nLc6ntSZYOZ7C2wHQcLVLs0rw/Vw2006Eb77CqPZl2QO2X/nlgo+CxHjY4Olah/lJsLeHldaE1KY/w6rbu0HKUBMR5HyExDF+HV4sywfgROtpxictSrrd/LV6N34VQsDe/92r0+6xLKM0h0zc7Xd6mw2DE516Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WtRgwr//724AGR28U6k3UdiY6o46PlgQzN3ZTB2Gq64=;
 b=F8dNbkfOZlvVxXC8uXrKysHSu8ZS/b+K43L9XYg9XVsVznOoixMzDYN89HiiBHr2+f8VfvWrPsZakHXNMdgKaaKQIolHiZq5FdcdpY1vBTwgiZtZZ5jh8peckp3GUzdLVziNuGr/k7FRpr2i+s/JgUxI1bW9Q01kPyvWsNFFt08sBa7I4adLtvo+m4aAt6Qmryc1dwy35cIokF/Ubn315SpFfrlLW6y4pzWbuIj2JL6OvtahlSFJkIwsP/VI/PhTOVe3vBugpiYVO/hfIF42sNRf/0st0VXupHKR/ikdyjikESZAWfu4rvsrRBmqehtcRXsgLI8Y5HQvWZLEmWxBvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WtRgwr//724AGR28U6k3UdiY6o46PlgQzN3ZTB2Gq64=;
 b=sHbAgk5fVXXhRqEMIkKAVIRygWxXMrznqTAH5UAxEWrB7psm8cEWPpbhdsojmVY+ZHytG+RWPIbo8F3s9+yBXH6+qUJobkgltLfYxVH9MtZAHkDH5taKzRoIrr5FtgD3dO1A8pfoYE/F2KZ9O5DWf+siK+EGBk448TmTpI1u8eWUy/tLzXZCFjqnn5yE1ftNY83asPWmGGzGxEO0d7IvjDSLAbALtpy2Qn3mrEI/DvgVrwLpCiwqcDebwViswm2RJ1TPhC5yO3L1IpMPrCdnn3AuEhvj5zhBrdtBukJRxNIkP+g8P17XvjfKxiK14pFoWG/Gd2W4G4TQY2CasWthsQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB4130.namprd12.prod.outlook.com (2603:10b6:a03:20b::16)
 by BYAPR12MB3590.namprd12.prod.outlook.com (2603:10b6:a03:ae::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.19; Wed, 24 Aug
 2022 21:59:28 +0000
Received: from BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::508d:221c:9c9e:e1a5]) by BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::508d:221c:9c9e:e1a5%8]) with mapi id 15.20.5566.014; Wed, 24 Aug 2022
 21:59:27 +0000
Message-ID: <0db131cf-013e-6f0e-c90b-5c1e840d869c@nvidia.com>
Date:   Wed, 24 Aug 2022 14:59:25 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH RFC 1/2] coding-style.rst: document BUG() and WARN() rules
 ("do not crash the kernel")
Content-Language: en-US
To:     David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, linux-doc@vger.kernel.org,
        kexec@lists.infradead.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        David Laight <David.Laight@ACULAB.COM>,
        Jonathan Corbet <corbet@lwn.net>,
        Andy Whitcroft <apw@canonical.com>,
        Joe Perches <joe@perches.com>,
        Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Baoquan He <bhe@redhat.com>, Vivek Goyal <vgoyal@redhat.com>,
        Dave Young <dyoung@redhat.com>
References: <20220824163100.224449-1-david@redhat.com>
 <20220824163100.224449-2-david@redhat.com>
From:   John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <20220824163100.224449-2-david@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0142.namprd13.prod.outlook.com
 (2603:10b6:a03:2c6::27) To BY5PR12MB4130.namprd12.prod.outlook.com
 (2603:10b6:a03:20b::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c84b96ef-6d36-4b79-5912-08da861bea1d
X-MS-TrafficTypeDiagnostic: BYAPR12MB3590:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hzmIg0jqfbg5m3lOl6N7isTfas1o0J5Im6mEd9gcKy15QmqfJRSLdsvTbAHybEgXTmz1ZOFO8UsX0ved94Q7gU5kvbxBRoe5H1VUOOmxKl1m+yV0w4ZHmx/v3E0Wmrimhpk8/865F+PjP6fXj0j+6j03fl2G2XNlvVi+fyFKUBFYc9y6KwiTeSUISPHE6NBg3hR1VmCFl8lSYP6iAIOgzg13366n+5jFdsDbQQSsvwVyI7jYo93GN+dOz632Pf0C6tWRqmHFXczdOUwYba/e8cJvntFchOaCpMa0++ioSwBdM5ajLilxEUCkVY16PeH0xcqFGEjc/K7sI6ZnezSfXguW2fL5DlZrANkPqQdHynJ42/WXbq961UBM5bce/r9eZF4gDyeEyikaGd7dwXKaa2wBlDPIBpnB4gYVuNJIu0jNvV9pAJ5ioYK1fAHbX+4bHC8xBKBD6coGN14Q3/y/H4+TPRT6Dv/OVVkm3/kLHAXFQAP06pg9cQFxhDeeZMc559aTSl20zUbcmZrf5HXrWRe4Te71+FCYpRWOfLhwqgYmEPXsOJNeKoNZ76pDtuyb8DHqbcoN2WpEcQFD0Qa/2YpmACP0vj/5fs8uS3bt9K8/KZSmAteXj776N2RXJGNzm3FlmcUfuk3bhVxdwLwo/Dm0xXI6jbuG8zB7mDqt8PpNo23GXo+bQ+dwPcUK+yDl9iyvJnlYu1YPNHVM9uh5Cn9v16RkcGTUT6TdQgI/AYTy90kH3uHHC/Uxz4DQkVT+dNdGNTWIkYQWHSfM/ZFE74yWR6h704BR1cc60j/aI1s=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4130.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(376002)(366004)(396003)(136003)(39860400002)(346002)(26005)(31696002)(86362001)(38100700002)(8936002)(54906003)(36756003)(316002)(7416002)(6486002)(66946007)(31686004)(478600001)(6506007)(8676002)(66476007)(66556008)(2616005)(4326008)(186003)(5660300002)(53546011)(83380400001)(2906002)(41300700001)(6512007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a1hBNm9OaVdGZlFsaUR5djNSQ1o2SnNKWnVidUFTd1ZTYmJUQTlCZzlPWjVx?=
 =?utf-8?B?NEtSbmxZYjFQeElFYkhMaVF3bWN4NFBJN1M1ekswekRKaXVBZjJEamZwTW5n?=
 =?utf-8?B?OG5zQ3NORWl1blFCRmtoc1FBUGtCa2RvQ1pqRURMOEtsS2kxTmVwQVc2czli?=
 =?utf-8?B?czF5dnI3YnhyQTh0Ulh2U2h1bUZRQkZUMWVKZzVSWFZBcGM5OHNWb1RNbXl2?=
 =?utf-8?B?aG5FQUsyTHN1Q3dVU1dZSzBmVkQ0eFRZUGNQaURTeCttNklnQzAxYVhrZjRl?=
 =?utf-8?B?MVRXZjU3M2RFL2xtL0ZOMGtDZ29jSG1wTW9CT0VBYmluc005K1JVTW1IK3Fx?=
 =?utf-8?B?Y2dTbGhEU0JzWHBTbm1nakpPcGdsVW9vZmFqRmRXY0FnV2t5cnlpVXdLK3Yx?=
 =?utf-8?B?a3VvZjRzWXRDVWlkcEM0VDc1Y2hXZHJYR1cvU25WdFczNVN0Q2pvQm10MTRQ?=
 =?utf-8?B?UEZTYVRKRmNGYXFlNUpBR1BNL1ozZkg3b21UTGVyUnBrckwybkswWlRweFEz?=
 =?utf-8?B?djhRVUx2Q0Fjb3ladnBsM01rRlR2ZHo0TklmOVFtS0FzN29WWU5FQUF0Y0FL?=
 =?utf-8?B?dmpJVzVLYWJSeXNNSUF1OGoxMVBzUFl5Qk1PVVFPQnZPcVRMWVBZYldhR1Jn?=
 =?utf-8?B?Nk5ZbmQwMjlacVkvRTg1MnZpT0JnWVpZNDhHbnpUclQ0ZmpuSVZsK2dqSSti?=
 =?utf-8?B?T1JwdGdMazhjbkRDR2Fzem5PcThoMS80c2lFWUVmLzRkM2Z6OFExcDIyemR6?=
 =?utf-8?B?RzhWQUF4TDZ0QkdkcGUxOFpRWk1LR3BFalJZVDdybnpZTkRpbVNsb1o0ZFoz?=
 =?utf-8?B?cWVFVS9iVmo3R1JjdG9LdmExbmNnYzZzOTA0bHg0UHl5WUptYWxNMGVDZnFJ?=
 =?utf-8?B?bm42MTZYcHBidFlEVUN2Vzk1RWFWUzQzTTd0ZDlPbXVXTld4QUxQaFU2OWlm?=
 =?utf-8?B?aHNSYUM4UmNQV3RJNm5JVUpRWndzcmFMWkx1dHQ4clc0NERpM0R0RHZ1WjVR?=
 =?utf-8?B?S1p3U01LZ0U4cjNKaGI2Z3k4N0NqNHI3Wk5DcmhvTkhoeEM2TlF1SHBZOWJV?=
 =?utf-8?B?N2FtMnFFZS85TEhYc3EwZDVwUWpHQlZBSklNMmFaT2FYRVd2WTRCbW5RRWo1?=
 =?utf-8?B?Vkd1NlBNQldMQnFVeGFqZktlQzZCa0Q3YzdwUXVwcHlFdklPQzFDb2x0Ky9H?=
 =?utf-8?B?ZVB2SE55eWUrM3JUY0Z5YmFQc01rYjdpZTNqZlRQQ1Jjdnd1MXlEODF1TW1H?=
 =?utf-8?B?cUtqQ2RibEJZM2ZlalA1TFJDMFlvajNqdEt3NVA0SExFSm5McmtmUXg2bk9w?=
 =?utf-8?B?Q2NoNUl1dk5TR2hIWFVJNGIzcHVZV3Z3Z0drM3VtQUsrLzZsa0J2VXllMkdB?=
 =?utf-8?B?ZU1vVS9JTHRCNjJWMTM3UUlvd1F1SjJJb2hMU3hHYVJaTkhvQTNDK09POTNw?=
 =?utf-8?B?U1J5NzFaQWtLNXBVanB1aDF1RzlSUExVeENqMi9CZjhEM3pZd21rVHRaM3NI?=
 =?utf-8?B?TnlMY09wengxUm5aazljTUxSUy9Mam5nWXZDd25yaXlhQW5mS1NsdU5QZU1B?=
 =?utf-8?B?N1ZMdFhmVEt6ZXdveGcrd05VdW9jWFU0eGY1bHVMQmlZNDAyN2xtbkxqblJu?=
 =?utf-8?B?Wm9jci9xMldGRlZNWTVBM1Rrc2Vrck9PaVoxUW5UVzNKQ2NNblpEWTdpVkVF?=
 =?utf-8?B?Q2ZYZ05QN05LcjNrd0xnU0wxZm02QkxMMkFIdTU4R0FSNTNTcWFHUUt4UWpo?=
 =?utf-8?B?U1dmRkl3ZGhJZmEwUjhQcW9EbkZPSXBYR29TeUhHR3VzM2VhMWlGck5oUFdB?=
 =?utf-8?B?Yll2dnVGaWJDWXlFZHJHMngxZjN1MWpBOUxoK1ZjcXVRVC93TU1td0Z1UTJC?=
 =?utf-8?B?dDI4WHJNWjcxSTlLaGd3alI2Mi9EUG5nREtxdlIvM05MT1ZMRHBTWWZTSFVO?=
 =?utf-8?B?SHV5SnFUMmxwTllsRXRiY3hCRHp3bnhEYUNlbkpKZU9GdUZnanYyVzlZbSt1?=
 =?utf-8?B?bVkwNnMxZVFnZ0RTY3RuZThtS0Z5N2p0U0FhQjM5UXBCU3Z6NS9HZGRidTJI?=
 =?utf-8?B?NHpLbGlOdFJsZDM3VWhzZnl3dU5kTDgzZmVwc1BRd0R1K2NYcTY2Z28yNGVM?=
 =?utf-8?Q?0I0eL0InS/RRilKyGH++SVqvE?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c84b96ef-6d36-4b79-5912-08da861bea1d
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4130.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2022 21:59:27.8252
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 59q+8kcAnee4WpOp5lb4eHbnUBNQmiSlUCI1x/t6+nUP3rfKEJKfxoelTJsN8btWXvSyNKajIxDl0dh0Y35fGQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3590
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/24/22 09:30, David Hildenbrand wrote:
> diff --git a/Documentation/process/coding-style.rst b/Documentation/process/coding-style.rst
> index 03eb53fd029a..a6d81ff578fe 100644
> --- a/Documentation/process/coding-style.rst
> +++ b/Documentation/process/coding-style.rst
> @@ -1186,6 +1186,33 @@ expression used.  For instance:
>  	#endif /* CONFIG_SOMETHING */
>  

I like the idea of adding this documentation, and this is the right
place. Naturally, if one likes something, one must immediately change
it. :) Therefore, here is an alternative writeup that I think captures
what you and the email threads were saying.

How's this sound?

diff --git a/Documentation/process/coding-style.rst b/Documentation/process/coding-style.rst
index 03eb53fd029a..32df0d503388 100644
--- a/Documentation/process/coding-style.rst
+++ b/Documentation/process/coding-style.rst
@@ -1185,6 +1185,53 @@ expression used.  For instance:
        ...
        #endif /* CONFIG_SOMETHING */
 
+22) Do not crash the kernel
+---------------------------
+
+Use WARN() rather than BUG()
+****************************
+
+Do not add new code that uses any of the BUG() variants, such as BUG(),
+BUG_ON(), or VM_BUG_ON(). Instead, use a WARN*() variant, preferably
+WARN_ON_ONCE(), and possibly with recovery code. Recovery code is not required
+if there is no reasonable way to at least partially recover.
+
+Use WARN_ON_ONCE() rather than WARN() or WARN_ON()
+**************************************************
+
+WARN_ON_ONCE() is generally preferred over WARN() or WARN_ON(), because it is
+common for a given warning condition, if it occurs at all, to occur multiple
+times. (For example, once per file, or once per struct page.) This can fill up
+and wrap the kernel log, and can even slow the system enough that the excessive
+logging turns into its own, additional problem.
+
+Do not WARN lightly
+*******************
+
+WARN*() is intended for unexpected, this-should-never-happen situations. WARN*()
+macros are not to be used for anything that is expected to happen during normal
+operation. These are not pre- or post-condition asserts, for example. Again:
+WARN*() must not be used for a condition that is expected to trigger easily, for
+example, by user space actions. pr_warn_once() is a possible alternative, if you
+need to notify the user of a problem.
+
+Do not worry about panic_on_warn users
+**************************************
+
+A few more words about panic_on_warn: Remember that ``panic_on_warn`` is an
+available kernel option, and that many users set this option. This is why there
+is a "Do not WARN lightly" writeup, above. However, the existence of
+panic_on_warn users is not a valid reason to avoid the judicious use WARN*().
+That is because, whoever enables panic_on_warn has explicitly asked the kernel
+to crash if a WARN*() fires, and such users must be prepared to deal with the
+consequences of a system that is somewhat more likely to crash.
+
+Use BUILD_BUG_ON() for compile-time assertions
+**********************************************
+
+The use of BUILD_BUG_ON() is acceptable and encouraged, because it is a
+compile-time assertion that has no effect at runtime.


thanks,

-- 
John Hubbard
NVIDIA
