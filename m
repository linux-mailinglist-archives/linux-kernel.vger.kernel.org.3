Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C1E14C511F
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 23:03:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233730AbiBYWDn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 17:03:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230052AbiBYWDl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 17:03:41 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E7CD7806E
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 14:03:07 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id u20so11635643lff.2
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 14:03:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rxfwFQa2cIaEPimDV48OHG3OVcs9lSl31xsyOI5tW50=;
        b=aVUCoJ9KU0pQ+d/GNQhVxrel14FfwwohBbhqO8UrwrwVU/wUbRD6moQ83rfbl8XYfe
         zRTKXjYlYRRATrsI5Z4ZwkIBfGs77UiGu/cdFbf3MNXndzfbcHKe8/3TC7VUmZp1wF1n
         15RAOhPEnntQKqRHwkl0O+Zh8YpqHKLmKlGp0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rxfwFQa2cIaEPimDV48OHG3OVcs9lSl31xsyOI5tW50=;
        b=aK+OMUuFFPm6rDOLAOaYrRorMDpax9JYYNNxnhuvAHOrBAGxK6sZr+mANt3xiNp3Gf
         VwlaUe7UsPcDOKBCZBrcKBVqDe7dlhheY/o+AjcfKyohNFC9IpSJB55t9rhsIMcIH/X0
         PMW4AaTqiX3xChSvq6vGrARV5ow9WGnIagppkSZaIxenYmRdgC52GrKoCYCpSjoG2mm5
         A4p8zKst83MJfwZJ3iw7sMHAuf0HK3eCRQvoD3kY3iKtKl91gDN3Es+T5y9+G+hqQgiX
         xj915fAixuOhWqxZrSJZwccwQKVYwCwma+XkApO/W4DMijim8Vwye77BAVmMj2if1rOx
         p7VA==
X-Gm-Message-State: AOAM5313C6a724ye3hFHRKywCOjgfLCa2ZQvb1N8h+siJTgLgAchjcwE
        INsgo5rpSgEUBbcOk2oZ25eb+vRDzCHr2V/4
X-Google-Smtp-Source: ABdhPJzxf05aHqO1BBpRqkHsgnkeJldEN3ir4pGA2Sh1W9EX3RcsRtxOs8J2TrK0uFqLlXdGD/UqTw==
X-Received: by 2002:a05:6512:2291:b0:442:be5f:d3bb with SMTP id f17-20020a056512229100b00442be5fd3bbmr6127761lfu.301.1645826585247;
        Fri, 25 Feb 2022 14:03:05 -0800 (PST)
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com. [209.85.167.43])
        by smtp.gmail.com with ESMTPSA id u19-20020a2e91d3000000b002461bced9e2sm376029ljg.79.2022.02.25.14.03.04
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Feb 2022 14:03:04 -0800 (PST)
Received: by mail-lf1-f43.google.com with SMTP id b9so11614031lfv.7
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 14:03:04 -0800 (PST)
X-Received: by 2002:a05:6512:3042:b0:437:96f5:e68a with SMTP id
 b2-20020a056512304200b0043796f5e68amr6356774lfb.449.1645826583977; Fri, 25
 Feb 2022 14:03:03 -0800 (PST)
MIME-Version: 1.0
References: <CAHk-=wjtZG_0zjgVt0_0JDZgq=xO4LHYAbH764HTQJsjHTq-oQ@mail.gmail.com>
 <bd43bd47c8eaa4c22c1a1549cee66f7ef960b1fc.camel@med.uni-goettingen.de>
In-Reply-To: <bd43bd47c8eaa4c22c1a1549cee66f7ef960b1fc.camel@med.uni-goettingen.de>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 25 Feb 2022 14:02:46 -0800
X-Gmail-Original-Message-ID: <CAHk-=whFMxks63sfMQ-0_YO1GsTmoLfsO4ciMtoiCHNgaG_+GA@mail.gmail.com>
Message-ID: <CAHk-=whFMxks63sfMQ-0_YO1GsTmoLfsO4ciMtoiCHNgaG_+GA@mail.gmail.com>
Subject: Re: [RFC PATCH 03/13] usb: remove the usage of the list iterator
 after the loop
To:     "Uecker, Martin" <Martin.Uecker@med.uni-goettingen.de>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 25, 2022 at 1:36 PM Uecker, Martin
<Martin.Uecker@med.uni-goettingen.de> wrote:
>
> Implementation-defined only means that it needs to be
> documented (and clang does not even do this), so
> I am not sure what difference this would make.

No, implementation-defined means something *much* more than "undefined".

Yes, it means that the behavior has to be documented.

But that's not actually the big deal from a user standpoint (although
it might be a big annoyance from a compiler writer's standpoint -
compiler writers would probably much prefer "let me do the obvious
sane thing" over "let me do the obvious sane thing and then have to
write documentation about how obviously sane it is").

From a user standpoint, the big thing is that "implementation-defined"
means that the behavior has to have *SOME* well-defined behavior.
Documentation is irrelevant. But RELIABILITY is relevant.

See?

That's a big big deal. The documentation is almost incidental - the
important part is that the code acts the same on the same
architecture, regardless of compiler options, and regardless of the
phase of the moon. When you upgrade your compiler to a new version,
the end result doesn't suddenly change.

In contrast, "undefined" means that the same C code can do two totally
different things with different optimization options, or based on just
any random thing - like some random register allocation issue.

So "undefined" behavior means that changes to code that isn't even
near the code in question can change what the code generation for that
code is. And the compiler may not even report it.

That is a complete disaster. It's a disaster from a security
standpoint, it's a disaster from a maintenance standpoint, it's just
*bad*.

And the C standards committee has traditionally used to think it was a
good thing, because they listened to compiler writers that claimed
that it allowed them to do wild optimizations and improve code
generation.

Example: the completely broken type-based aliasing rules that changed
semantics of C for the worse.

Reality: it doesn't actually improve code generation all that much.
Instead it just results in a lot of problems, and any sane C code base
that cares about security and stability will just turn that off.

Same goes for integer overflow etc.

The only really valid use-case for "undefined" is when you're doing
things like accessing past your own allocations. The compiler can't do
much about things like that.

But the C standards body has actually actively screwed the pooch over
the years, and turned perfectly traditional code into "undefined" code
for no good reason. "-1 << 1" is just one particularly simplistic
example.

> > Hey, some more googling on my part seems to say that somebody saw the
> > light, and it's likely getting fixed in newer C standard version.
>
> I don't think it is changed. But C23 will require
> integers to be repreeted using two's complement,
> so there is a better chance to fix things
> like this in the future.

If integers are guaranteed to be two's complement, then the only
possible explanation for "left shift is undefined" goes away. So
presumably the thing goes hand-in-hand with just making (the de-facto)
negative shifting well-defined.

(Btw, shifting *by* a negative number - or by amounts bigger than the
width of the type - is different. There are at least real reasons to
complain about that, although I think "implementation defined" would
still be hugely preferred over "undefined")

> The right people to complain to are the
> compiler vendors, because they decide what
> UB does in their implementation.

No. The bug was in the spec to begin with. The people to complain
about are the incompetents that literally changed the C standard to be
less well-specified.

As far as I know, no actual compiler has ever made integer left-shift
done anything bad. You'd literally have to do extra work for it, so
there's no reason to do so.

But because the standards committee messed up, the compiler writers
*did* do the extra work to warn about the fact (for the trivial
"negative constant" case - never mind that technically it's undefined
for non-constants: that would have been too much work).

End result: the warning is stupid. The warning only exists for
artificially stupid reasons.

And those reasons are literally "broken C standards committee behavior".

                      Linus
