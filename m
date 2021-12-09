Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81C8F46F2B8
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 19:03:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243180AbhLISGs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 13:06:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243057AbhLISGr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 13:06:47 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3208AC061746
        for <linux-kernel@vger.kernel.org>; Thu,  9 Dec 2021 10:03:13 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id t5so21844059edd.0
        for <linux-kernel@vger.kernel.org>; Thu, 09 Dec 2021 10:03:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pqdZ3M76IB1SSykmh04Y3Lo84YOdOWQzNWkBQHhiwL0=;
        b=ZavXgalMvPws6B7jvVOJr9iYXFSQ+Ve+xzB/xQ0PKvdxMfmxrHbi4mOAwmtVap5HzF
         i7Nkk2JG3YWK49A5ao1c9B+9rNDuriLhMaU7X6p9gXoihI9+MzBmoDXPoCAxG7AMsjTc
         uY8XYPep0J+jvwo4NJwVAzrXtoSQ3VliSEvk4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pqdZ3M76IB1SSykmh04Y3Lo84YOdOWQzNWkBQHhiwL0=;
        b=cLkPFi4I3cJtMyZ0bJEsANOJN6kEc/oGtW//v5pIPpYffwBgYKxaqQbjcyCyf8w8+N
         gvbMnFHFQ+XzkFV2TZzTRr1uxxMh2HgJI4tQEwy6JhZtgPpeindoCkkVdjR5adIozqbT
         HH+F/8JMsXlyX3y9xNKj8E8XKVZx2Yjr6jSq3wxQWUHs6oCqKvIgpTkTDXkBP/vdE4Qh
         /tPysZEdalzvMoxDHpHBWz5zKzSFHsVmXoS5dS4m3nQo+PrMI6S9MSt3y4hs+bmVltOS
         lEceY24iL0Fj3DhjmVQjZ9TB65lGHC+c8+FZkoeKLg+imbdoFtrUDbeWlI6Diq6qb1xi
         8F6Q==
X-Gm-Message-State: AOAM530ocs8Q/8d9o//rPtrIyJe8nM//JUSFpAIxFamsrRCPBUA6+bpg
        EoseyCcUbAilUNwpdD78SVhp6/HcMwFJybLSVjA=
X-Google-Smtp-Source: ABdhPJx+IRdTT9pbAV1b3t9Pss8TQAinW3Cr+BHPTc1EuA/oQaQZobFmPJiduRSFeu6VX614wsKeNQ==
X-Received: by 2002:a17:907:9488:: with SMTP id dm8mr17125949ejc.571.1639072868996;
        Thu, 09 Dec 2021 10:01:08 -0800 (PST)
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com. [209.85.128.54])
        by smtp.gmail.com with ESMTPSA id 3sm270882ejr.20.2021.12.09.10.01.07
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Dec 2021 10:01:08 -0800 (PST)
Received: by mail-wm1-f54.google.com with SMTP id j140-20020a1c2392000000b003399ae48f58so7185411wmj.5
        for <linux-kernel@vger.kernel.org>; Thu, 09 Dec 2021 10:01:07 -0800 (PST)
X-Received: by 2002:a1c:800e:: with SMTP id b14mr9304451wmd.155.1639072866516;
 Thu, 09 Dec 2021 10:01:06 -0800 (PST)
MIME-Version: 1.0
References: <20211209010455.42744-1-ebiggers@kernel.org>
In-Reply-To: <20211209010455.42744-1-ebiggers@kernel.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 9 Dec 2021 10:00:50 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjkXez+ugCbF3YpODQQS-g=-4poCwXaisLW4p2ZN_=hxw@mail.gmail.com>
Message-ID: <CAHk-=wjkXez+ugCbF3YpODQQS-g=-4poCwXaisLW4p2ZN_=hxw@mail.gmail.com>
Subject: Re: [PATCH v3 0/5] aio: fix use-after-free and missing wakeups
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Benjamin LaHaise <bcrl@kvack.org>, linux-aio@kvack.org,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ramji Jiyani <ramjiyani@google.com>,
        Christoph Hellwig <hch@lst.de>,
        Oleg Nesterov <oleg@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        Martijn Coenen <maco@android.com>,
        stable <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 8, 2021 at 5:06 PM Eric Biggers <ebiggers@kernel.org> wrote:
>
> Careful review is appreciated; the aio poll code is very hard to work
> with, and it doesn't appear to have many tests.  I've verified that it
> passes the libaio test suite, which provides some coverage of poll.
>
> Note, it looks like io_uring has the same bugs as aio poll.  I haven't
> tried to fix io_uring.

I'm hoping Jens is looking at the io_ring case, but I'm also assuming
that I'll just get a pull request for this at some point.

It looks sane to me - my only internal cursing has been about epoll
and aio in general, not about these patches in particular.

              Linus
