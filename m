Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 471874D57DB
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 03:02:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345557AbiCKCDW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 21:03:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345546AbiCKCDT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 21:03:19 -0500
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCCAC1A58FE
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 18:02:16 -0800 (PST)
Received: by mail-lj1-x236.google.com with SMTP id r22so10266276ljd.4
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 18:02:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=m4VELpaJVZ7zmg2TZ70q5O+Rno13UESIQGHxeXAGp64=;
        b=WLAuxj1pTLUK2IUM9/49VgJsyFJ+BVvd8PfwABqRcVHrUhzhm071B103vOrs5aFLMV
         AVrX9VppzDQJj1qEO8HqJbPmB/7Yi+trOg0N8bUu94pE9IYsKM0XxTautEpRfkkKJqDy
         4QKglPy+IZo50iVFFs9OPKqMPkvixBAhyIA/s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=m4VELpaJVZ7zmg2TZ70q5O+Rno13UESIQGHxeXAGp64=;
        b=fy8f2nX+cqPV9UFN1/HC9JZLE1LtBr/vtdVcEuz4+CLeVvh9ZX68F7YlTxasHW1eSM
         wKi76PWHHc8M8saf3JoXLga3EAAXPg3R9encEBpWrKcOQNL9OFjs50Uyluh/iPlTffb0
         MUtmTvDRHU2owQav1ONcz2SFSnG2OrE1hY8gNT9Snl4jwPHFXPIQF5SUyiP8CVEUBDES
         QLEEtg4CuKTwUX5WUzcXErjmIJ6zSaycpoq/rx/hTJvwWXb+Drwcq+Bu3CbzTOOWKtYc
         O9/WNED2AnVO3/aY6yPMt325HJ4ikURgnGTM4jRkGB1G3mzCM152p9e1qEn6kxaKGnP0
         hf2g==
X-Gm-Message-State: AOAM532+yz3/lWHJHu7lebRwA1IVciTk8cmiUTQfxupPOgjwWZR1xRGK
        BHcJFakvcYdHR6jRyI1CEzqYM9y0Jl7wFMT/A9E=
X-Google-Smtp-Source: ABdhPJxs9uiaUeg58r0Vigv2iDVMmKLuo4Q0ZdE5hY0Xa1BkJM6uwYZkqHB+lvH9XsjgwUOkknTGOA==
X-Received: by 2002:a2e:7809:0:b0:246:853:5594 with SMTP id t9-20020a2e7809000000b0024608535594mr4748840ljc.41.1646964134832;
        Thu, 10 Mar 2022 18:02:14 -0800 (PST)
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com. [209.85.167.45])
        by smtp.gmail.com with ESMTPSA id o11-20020ac2434b000000b004481eafa257sm1299260lfl.285.2022.03.10.18.02.12
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Mar 2022 18:02:13 -0800 (PST)
Received: by mail-lf1-f45.google.com with SMTP id bu29so12735345lfb.0
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 18:02:12 -0800 (PST)
X-Received: by 2002:a05:6512:3a83:b0:447:da72:43f1 with SMTP id
 q3-20020a0565123a8300b00447da7243f1mr4767287lfu.542.1646964132748; Thu, 10
 Mar 2022 18:02:12 -0800 (PST)
MIME-Version: 1.0
References: <20220311013238.3387227-1-pobrn@protonmail.com>
 <20220311013238.3387227-2-pobrn@protonmail.com> <CAHk-=wjkqz42CNjDgWA9U3uNWa9GriqaCqqKciqm0sZUYjfLQg@mail.gmail.com>
In-Reply-To: <CAHk-=wjkqz42CNjDgWA9U3uNWa9GriqaCqqKciqm0sZUYjfLQg@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 10 Mar 2022 18:01:56 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjF4d_v5t=ht_vCOHxNDoPvsBuK-2jiEBus-__oPZuPFQ@mail.gmail.com>
Message-ID: <CAHk-=wjF4d_v5t=ht_vCOHxNDoPvsBuK-2jiEBus-__oPZuPFQ@mail.gmail.com>
Subject: Re: [RFC PATCH v1 1/2] list: add type-safer list_head wrapper
To:     =?UTF-8?B?QmFybmFiw6FzIFDFkWN6ZQ==?= <pobrn@protonmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Xiaomeng Tong <xiam0nd.tong@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Jakob Koschel <jakobkoschel@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>
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

On Thu, Mar 10, 2022 at 5:42 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> That one didn't do the automatic offset thing, but see
>
>    https://lore.kernel.org/all/CAADWXX-Pr-D3wSr5wsqTEOBSJzB9k7bSH+7hnCAj0AeL0=U4mg@mail.gmail.com/
>
> on the problems that has.

Note: I think the problems are serious enough that it almost certainly
isn't worth doing - it makes the code uglier for very little upside.

So I tried to explain how it _could_ be done, but that doesn't mean
that it _should_ be done.

Having the member name as part of the list traversal macro isn't
actually generally a real problem.

I added it to the list_traversal_head() macro in that original patch
because I think we can easily use the member head name to _verify_
that the declaration and the use match.

Yes, squirrelling  off the offset and not needing the member head name
at all at when traversing the list is obviously simpler syntax, but
that part has never been the real problem with list traversal. And
verifying that the member name that is passed in is the same as in the
list_traversal_head() would be trivial.

To verify it, we could simply change that type name from:

     type *name##_traversal_type;

to be

     type *name##_traversal_type_##member;

instead, and suddenly the member name in 'list_traverse()' has to
match that thing that list_traversal_head() created.

So yes, you'd have that third argument in list_traverse(), but it
would be trivially checked at compile-time.

And you'd avoid all the ugly complexities (described above) with lists
that are embedded inside data structures that refer to each other)

                  Linus
