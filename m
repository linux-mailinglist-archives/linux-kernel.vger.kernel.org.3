Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87ACF4D3C9C
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 23:08:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235954AbiCIWJL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 17:09:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233630AbiCIWJJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 17:09:09 -0500
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9F58120185
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 14:08:09 -0800 (PST)
Received: by mail-lj1-x233.google.com with SMTP id r22so5193069ljd.4
        for <linux-kernel@vger.kernel.org>; Wed, 09 Mar 2022 14:08:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vrzRO7DmEsu3cOettTYwW7UCWoPESsH1sMNrUtKi/nA=;
        b=D6wVcBiWwb900bMY/FETws43aV7d/ko8szzVk+WS/1DR8zDMaY02pV3MC0tbljgnh0
         WzWCdAtyOwpv/1w8DCR8AZ6HTvBBoLgi0tmfvoHNHVgaE0PG1ZMJdGiaE0dVMTR2N5Iq
         kSr/dWbefbXW+jTenAzDyNmg7qSGnPTV6OdpU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vrzRO7DmEsu3cOettTYwW7UCWoPESsH1sMNrUtKi/nA=;
        b=CKHAFMU0NHm6tHD7wVcNKaT6AQwAcLMJf5fySZ4wm6W6jm4aLMY4nPSUSxxDtj+dSC
         WV0h+eaVsC2VXNVNMGc9qh/iR9Q696F6viPjoBW9zHgstUpoLTdV2ibid2gEb+pbx/Du
         k9evWFuu8Npa6k7bYLTrTJjpBWguTKw59PlgIBT4YeGabAi+4hRS/zX0FYd1u3daqjcp
         mVvATwzfQogJgOVcpwNkahN5Hr0ZeO/7YgNgXd04CMpnkgQv8jv7NqumWiadebGvU4Fy
         PsrRJMRzzQb+ymDL6Hqi3KUBbvKMZcnhL1mfy3IVlQ6EMeXOl6yl29znpnpzaacFG7Q5
         g6Gg==
X-Gm-Message-State: AOAM532BFv0Ou+XTUSx0bvzLRIvzMv472MUchBDIfDqrFf4WR4Q9B1tW
        NJPVICwpFlCwVCfa2oypkOBpI5KDeOWw94SVva8=
X-Google-Smtp-Source: ABdhPJxDY2sf+prQYT9d54b822bb0lo3B90gRvMIK6iP4lIO/7rrEsFE3k2YK/nan1MRhGRW6gGutQ==
X-Received: by 2002:a2e:b88d:0:b0:246:8b8c:a90d with SMTP id r13-20020a2eb88d000000b002468b8ca90dmr1037719ljp.265.1646863687797;
        Wed, 09 Mar 2022 14:08:07 -0800 (PST)
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com. [209.85.208.175])
        by smtp.gmail.com with ESMTPSA id h6-20020ac25d66000000b0044315401373sm608997lft.29.2022.03.09.14.08.07
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Mar 2022 14:08:07 -0800 (PST)
Received: by mail-lj1-f175.google.com with SMTP id o6so5205114ljp.3
        for <linux-kernel@vger.kernel.org>; Wed, 09 Mar 2022 14:08:07 -0800 (PST)
X-Received: by 2002:a05:651c:1213:b0:247:e2d9:cdda with SMTP id
 i19-20020a05651c121300b00247e2d9cddamr1025987lja.443.1646863686763; Wed, 09
 Mar 2022 14:08:06 -0800 (PST)
MIME-Version: 1.0
References: <YikTHqjv4S6ZQ3Fv@casper.infradead.org>
In-Reply-To: <YikTHqjv4S6ZQ3Fv@casper.infradead.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 9 Mar 2022 14:07:50 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiKSXZyKu+LhZjXp+UnDa7kcOyPPG+C8n3K-3AQ3KgMhA@mail.gmail.com>
Message-ID: <CAHk-=wiKSXZyKu+LhZjXp+UnDa7kcOyPPG+C8n3K-3AQ3KgMhA@mail.gmail.com>
Subject: Re: [RFC] Free up a page flag
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
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

On Wed, Mar 9, 2022 at 12:50 PM Matthew Wilcox <willy@infradead.org> wrote:
>
> We're always running out of page flags.  Here's an attempt to free one
> up for the next time somebody wants one.

Ugh. This is too ugly for words.

I wouldn't mind something along the conceptual lines of "these bits
are only used for this type", but I think it would need to be much
more organized and explicit, not this kind of randomness.

For example, quite a few of the page bits really only make sense for
the "page cache and anonymous pages" kind.

I think this includes some really fundamental bits like the lock bit
(and the associated waiters bit), along with a lot of the "owner" aka
"this can be used by the filesystem" bits.

I think it _also_ includes all the LRU and workingset bits etc.

So if we consider that kind of case the "normal" case, the not-normal
case is likely (a) slab, (b) reserved pages and (c) zspages.,

Which is pretty close to your "xyzzy" bit (I think you came to the
same list of "slab or reserved" conclusion because of the fundamental
issues above), but my point is that I think this approach is
acceptable if we make it much less random, and make it a lot more
explicit and thought through.

And we'd probably need to actually *verify* that we don't do things
like lock (or LRU) those non-normal pages.

We already have some page flag bits that are only used for those kinds
of odd pages: the page_flags field is used only for zspages, but other
pages can (misuse) that field for PG_buddy/offline/etc. That whole
thing is particularly ugly in how it tries to make sure there are is
no mapcount use of it.

So I do think something like your "xyzzy" bit can work, but I'd really
want it to be a lot more explicit and a lot less random than "let's
encode two special bits this way".

                   Linus
