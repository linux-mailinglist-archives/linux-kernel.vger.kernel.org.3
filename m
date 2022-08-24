Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC95259F342
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 07:58:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234686AbiHXF4q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 01:56:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbiHXF4n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 01:56:43 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23B0C89CCA
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 22:56:42 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id 2so12642104edx.2
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 22:56:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=IqQH8glAVc4Uz1KdvwFFC42e+CS3+BpGZdq1n3kfHOA=;
        b=CDer5OdErg8Gx/O21HaRV2uFcEIz/Tyr7apVmI7Tw5XhFJkDgkbRFgZnRFNJsiAeWi
         AYUe3M7LzpP46p8VczdGCayqXYEm1VR3I1DrazocSwDdC0LSmEJagG1fElE7pCjBueUH
         ZT3yxy62CiBxdNmWWEtTiG7otVCcClaBPtDss=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=IqQH8glAVc4Uz1KdvwFFC42e+CS3+BpGZdq1n3kfHOA=;
        b=N2XturfkraKjvXjcGdGlpCWnixf8LjHNTt+DsURqBRzQ5Lc8omnVQpNA4LAJBMh2s4
         Wgw+B32zhIBb6DQP5FnHgyz/f4me8aCIeZLaUXSVN9BVKjZmH1hh0fpcAgPemHq+ZqyZ
         7xkB7CsIGcTcyqFA6bTbSSy4QPnpHkReAvJPKlXNgaKDKpxu6J4zPiryiM273o0i0TBQ
         WyyDEZvICZhrb+XLLtJOU95E1p3XIhrL6RrtNlxeWZvIXmSEB50i6uNmjlswFVi4+VdC
         vh2pVCUNILi98L6l5rj3xuEicvxTh2I5+gntzb2F8LgDjR0KT8OrJ/3/19vZN2tH1XPA
         9/fA==
X-Gm-Message-State: ACgBeo1EeA+f7AI9fjltYM6xwJVdLp6RXAolsO5fRl1XPgCze/fc5neA
        XOpE5Opxvy1AwC66KBn/PVRgdxBKi5f9sPMR
X-Google-Smtp-Source: AA6agR5d7mypuqQu0rV1k1Ma2ki5cuvj4oxIpfvfOSHfSGKOpBm97UY6/gmBJsF3ih36mO3LwXbgzw==
X-Received: by 2002:a05:6402:2381:b0:446:7a73:e704 with SMTP id j1-20020a056402238100b004467a73e704mr6304455eda.244.1661320600394;
        Tue, 23 Aug 2022 22:56:40 -0700 (PDT)
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com. [209.85.221.48])
        by smtp.gmail.com with ESMTPSA id q4-20020a170906770400b007389c5a45f0sm682585ejm.148.2022.08.23.22.56.38
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Aug 2022 22:56:39 -0700 (PDT)
Received: by mail-wr1-f48.google.com with SMTP id h24so19416668wrb.8
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 22:56:38 -0700 (PDT)
X-Received: by 2002:a05:6000:1888:b0:222:ca41:dc26 with SMTP id
 a8-20020a056000188800b00222ca41dc26mr14194866wri.442.1661320598478; Tue, 23
 Aug 2022 22:56:38 -0700 (PDT)
MIME-Version: 1.0
References: <20220821000737.328590235@goodmis.org> <20220821000844.510643400@goodmis.org>
 <CAHk-=wjsxu782N0P+oMu35N7rJAOeh3buQFWJaZHZTNmVSB=3Q@mail.gmail.com>
 <5700ac75-f6a9-877e-4011-9b314f12b5ab@acm.org> <CAHk-=wjqkWEr0MRO5hWuBoTDgNUj4qQK8V_Y36et=61mdPztJw@mail.gmail.com>
 <02daa3d6-2847-d7e0-e23e-411076c6d4db@rasmusvillemoes.dk> <0163b361-14bf-7b4c-751a-14f1a004b1a9@acm.org>
 <CAHk-=wjMLb30d0WT_RyKBCX+JBkg3QQU6pCYkrV8f58Ya4Rgzw@mail.gmail.com>
 <CAHk-=wiwr2Ff_1SKzRkjSbNLFYfk4KurvZhLuwVuTT-m9w5_6A@mail.gmail.com>
 <YwWIQ/3BDQHOiTek@ZenIV> <YwWWoQXmVc8uasBh@ZenIV>
In-Reply-To: <YwWWoQXmVc8uasBh@ZenIV>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 23 Aug 2022 22:56:21 -0700
X-Gmail-Original-Message-ID: <CAHk-=whmx4Pqw70NDmujGMQY1BrVi54pLnB5b7qpPThjiHatOw@mail.gmail.com>
Message-ID: <CAHk-=whmx4Pqw70NDmujGMQY1BrVi54pLnB5b7qpPThjiHatOw@mail.gmail.com>
Subject: Re: [for-linus][PATCH 01/10] tracing: Suppress sparse warnings
 triggered by is_signed_type()
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Bart Van Assche <bvanassche@acm.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Jens Axboe <axboe@kernel.dk>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 23, 2022 at 8:10 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> Any operations like ordered comparisons would trigger unrestrict() on
> these suckers, which would warn and convert to underlying type.
>
> Your addition of "ordered comparison with 0 or -1" evades unrestrict().

No. Look. Try this modification to that test, and use
'./test-linearize' to see what sparse turns it into without my patch
to keep the signedness.

    static long test(void)
    {
        return (le32) 0xffffffff;
    }

yes, yes, it warns (twice, actually), but it also then generates

        ret.64      $-1

for that return.

Why? Because it thinks that 'le32' is a signed 32-bit thing due to the
clearing of the MOD_UNSIGNED bit, so when it casts it to 'long' it
will sign-extend it.

So the sign confusion exists and is visible regardless of the added
ordered comparison.

Now, we normally don't *notice* any of this, because we obviously
don't rely on sparse generating any code. And we _do_ cast those
bitwise things in many places, although we use "__force" to show that
it's intentional. Including, very much, those kinds of widening casts
where the signedness matters.

See for example very much the csum code:

    __wsum csum_partial(const void *buff, int len, __wsum wsum)
    {
        unsigned int sum = (__force unsigned int)wsum;

which is *exactly* that kind of code where it's fundamentally
important that 'wsum' is an unsigned type, and casting it to 'unsigned
int' does not sign-extend it.

So no. This has absolutely nothing to do with the new ordered comparisons.

Those bitwise types have always been integers, just with special rules
for warning about mis-using them.

And the sign handling has always been wrong.

It just so happens that me using 'test-linearize' to double-check what
sparse does for that signedness check *uncovered* that pre-existing
bug.

It was not introduced by the new code, and the ordered comparisons are
not AT ALL different from the equality comparisons, except for the
fact that they actually care about the signedness being right.

           Linus
