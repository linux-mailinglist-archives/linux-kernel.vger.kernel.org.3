Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40D5F523114
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 12:59:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238171AbiEKK7W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 06:59:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231222AbiEKK7T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 06:59:19 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBE9B16C5EA
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 03:59:17 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id m23so2141755ljc.0
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 03:59:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=vEImwAt+hQscgP/wRyfuHbE14MDXXeZYgodcfZ9QQ08=;
        b=f/G2nhb/TigMYF4+t+iiwPFSHTmuzT1r3R4TfSbvMZDiC2MHQ7Kq/E+NMTloS0RxN7
         afcffjTDe8hoNb5eC6Us0Rd6qMDpd3O6BwuMgeSS48slcojiPOaZ1uAiPs+QF2mhdlEN
         OF85P1xmLCIuuHfNPWrm07DxTXujLldNF7pS4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=vEImwAt+hQscgP/wRyfuHbE14MDXXeZYgodcfZ9QQ08=;
        b=VzeNxk0C7L1tdaIxCFutpwJZWkKwfDiGJG9qZOaTj9Ig4gv2vtvkYUUB9L6XqnOMLq
         5ts5GRNlxs3I4mUkDan+zSnuJ/X3ZwpgHFu3kF1dpqTUetl8Ng6XBGtsGZ0KMXOMyn7Y
         AgCNTGcd15ic+W0yBukbpYNuyDl6CzQ6k1zbwn2zxpSjHL5zQPT55qcoak7c5MIrl0+j
         xd8vsterFk2fXHsmOmotPrNj3MMUzqKCL7CBonJvVrrlMMxgi9DP9bWo1ndB/LxuNVwD
         oy+F3sMCHEApFpjl5+f4j+kLLp0tE6gEOLFkAgwc/v9Y7s+1li+eg7g7fMeF4slwYZ9C
         gykQ==
X-Gm-Message-State: AOAM531hDkCtLfDV2AlRTZUON0t9uGAKmZdgbgJqex/vIgc/NkvactCQ
        tLJjQxyTvPIP1E5Y2mfNEjrP8w==
X-Google-Smtp-Source: ABdhPJww7as86B4tUSK0D325ZdW4iuBHY6nS83dzEcw9NR/6qi//VLal9WNQPaFi315AUAx0bj4hQQ==
X-Received: by 2002:a2e:5305:0:b0:250:9bd1:af51 with SMTP id h5-20020a2e5305000000b002509bd1af51mr16885842ljb.383.1652266756022;
        Wed, 11 May 2022 03:59:16 -0700 (PDT)
Received: from [172.16.11.74] ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id m22-20020a05651202f600b0047255d211c0sm223017lfq.239.2022.05.11.03.59.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 May 2022 03:59:15 -0700 (PDT)
Message-ID: <9682c6f3-bc48-9ad1-4011-dfe1532e7491@rasmusvillemoes.dk>
Date:   Wed, 11 May 2022 12:59:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 08/22] bitops: introduce MANY_BITS() macro
Content-Language: en-US
To:     Yury Norov <yury.norov@gmail.com>,
        David Laight <David.Laight@aculab.com>
Cc:     'Alexei Starovoitov' <alexei.starovoitov@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Joe Perches <joe@perches.com>,
        Julia Lawall <Julia.Lawall@inria.fr>,
        =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
        Nicholas Piggin <npiggin@gmail.com>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        Peter Zijlstra <peterz@infradead.org>,
        Matti Vaittinen <Matti.Vaittinen@fi.rohmeurope.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Chris Zankel <chris@zankel.net>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Max Filippov <jcmvbkbc@gmail.com>,
        =?UTF-8?Q?Toke_H=c3=b8iland-J=c3=b8rgensen?= <toke@redhat.com>,
        "linux-xtensa@linux-xtensa.org" <linux-xtensa@linux-xtensa.org>
References: <20220510154750.212913-1-yury.norov@gmail.com>
 <20220510154750.212913-9-yury.norov@gmail.com>
 <CAADnVQKcX2xEWCHu-DX0Cy_mvCL6E0aE_BF1Wo+U-vy_Bi2-3w@mail.gmail.com>
 <3be064fe804845e4aeaca8b1d45ddf0a@AcuMS.aculab.com>
 <Ynq43wlPezrRzur8@yury-laptop>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
In-Reply-To: <Ynq43wlPezrRzur8@yury-laptop>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/05/2022 21.11, Yury Norov wrote:

> Another thing is that despite __attribute__(const), gcc sometimes doesn't
> recognize it as constant expression, 

An ICE, Integer Constant Expression, is a C language thing.
__attribute__(const) has nothing to do with that, and no use of that
attribute is ever gonna convince gcc to treat an expression containing a
function call as an ICE [C++ is of course a whole different story].

The __attribute__(const) on a static inline function is utterly
pointless, the compiler can certainly see for itself that the function
has no side effects and that the expression can be CSE'ed.

All that aside, please drop that MANY_BITS thing. It will not make any
code any easier to read (MANY, is that four or five? or is it "more than
half the bit width"?). The n&(n-1) pattern is a well-known idiom, I
expect anybody hacking on an OS kernel to recognize

Rasmus
