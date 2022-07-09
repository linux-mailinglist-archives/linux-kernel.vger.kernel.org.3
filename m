Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46A2B56CBCE
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Jul 2022 00:41:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229523AbiGIWlg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Jul 2022 18:41:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbiGIWlf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jul 2022 18:41:35 -0400
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88DEC11C10
        for <linux-kernel@vger.kernel.org>; Sat,  9 Jul 2022 15:41:34 -0700 (PDT)
Received: from [IPV6:2601:646:8600:40c0:425:cd56:6750:e1bf] ([IPv6:2601:646:8600:40c0:425:cd56:6750:e1bf])
        (authenticated bits=0)
        by mail.zytor.com (8.17.1/8.15.2) with ESMTPSA id 269MfOe32280396
        (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
        Sat, 9 Jul 2022 15:41:24 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 269MfOe32280396
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2022070501; t=1657406485;
        bh=Cy1CTu6T1Wo/2voSB7RyY/22HAamlHwFuPGZxrlfY6w=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Ej8T3xB4lpT0ypyEGH1BUzWbaFC8rvjj3PHNZOEYSxuEmqnhjiWyMpSM0/sODDwgX
         G42B3a6cE+zl+GQXNTqZxfR3hmLFBiq0SJBCw2juT0JDnUL99U6sQJXVot67ZLMSQM
         dWrLC8iriDIxbtx6RAWe3KpuUZpTLrCi0F8CLkKBQxbGNaAQv52zSwH26M5wzMwIUo
         a71XcN9twuiZoRdasvtgKHA8C2OWQ/6fDjN24yl3pdHvqJpiD5B97cHeFAS3y/YhqZ
         +1N1VzDyPG03K8IjvC2Vy15AMILUQp6f/NbY9Z2XoPbNue6ObxwANcu/JJzzIZmJpr
         uHLAqtWXXZOlg==
Message-ID: <8e5eb2db-ce31-3dc8-8f75-3959036686f8@zytor.com>
Date:   Sat, 9 Jul 2022 15:41:19 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH tip v8] x86/setup: Use rng seeds from setup_data
Content-Language: en-US
To:     Borislav Petkov <bp@alien8.de>
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>
References: <20220707000852.523788-1-Jason@zx2c4.com>
 <20220708113907.891319-1-Jason@zx2c4.com>
 <ddba81dd-cc92-699c-5274-785396a17fb5@zytor.com> <YslPKbrmwF0uSm7p@zn.tnic>
 <191d8f96-7573-bd0e-9ca4-3fc22c5c9a49@zytor.com> <Ysn5uvBKBpcZ4j6m@zn.tnic>
From:   "H. Peter Anvin" <hpa@zytor.com>
In-Reply-To: <Ysn5uvBKBpcZ4j6m@zn.tnic>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/9/22 14:57, Borislav Petkov wrote:
> On Sat, Jul 09, 2022 at 02:45:24PM -0700, H. Peter Anvin wrote:
>> On 7/9/22 02:49, Borislav Petkov wrote:
>>> On Fri, Jul 08, 2022 at 06:51:16PM -0700, H. Peter Anvin wrote:
>>>> #define SETUP_ENUM_MAX	SETUP_RNG_SEED
>>>> #define SETUP_INDIRECT	(1<<31)
>>>> #define SETUP_TYPE_MAX	(SETUP_ENUM_MAX | SETUP_INDIRECT)
>>>
>>> Wait, if we get to add a new number, SETUP_ENUM_MAX and thus
>>> SETUP_TYPE_MAX will change. And they're uapi too...
>>
>> Talking API here rather than ABI, i.e. the semantics of those symbols.
> 
> Sure but do we worry about some userspace including those headers and
> relying on the SETUP_ENUM_MAX number?
> 
> Or is userspace required to be recompiled against newer uapi headers?
> 

In ABI/API terms, that symbol has the semantic of connecting the API 
version to the underlying ABI version; a piece of code that sees an 
enumeration type > SETUP_ENUM_MAX must by definition treat it as an 
opaque blob. In the future, should it become warranted, we may add flags 
that indicate how unaware code should handle them, but I don't think we 
can engineer that right now.

	-hpa
