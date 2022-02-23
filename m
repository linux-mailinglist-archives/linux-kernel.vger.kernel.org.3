Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E4744C1D2F
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 21:34:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241300AbiBWUfJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 15:35:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240361AbiBWUfH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 15:35:07 -0500
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87706457B5
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 12:34:39 -0800 (PST)
Received: by mail-lj1-x233.google.com with SMTP id t14so26401459ljh.8
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 12:34:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qFhEoMfG9JnrMiuxRlHG2UuQZfxYUHHdzjSkeWsOcD8=;
        b=Sch0qA/uMUHSX7lm1Z26E01aFQIda35gcyPmVMGmgg/B0iK1poWZ5N+Iv8pmlRuBJ/
         hmD9WSqMPQCsXSmydxbzVzOjygUon9SlqLsP2d/yUlh2jZBB1LkXkBDyjE9WCuOkIIhk
         VJJ5eZOA1/ScB6KVCbfKtnEVHGsuTIFbkykeM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qFhEoMfG9JnrMiuxRlHG2UuQZfxYUHHdzjSkeWsOcD8=;
        b=sg8owF0moWHEIuNaA2VqE3+atGy/JS0Zh6PosnjXuAItGJVEqLJr/DOlnNJtAld2WQ
         D5g+zf0nobvChnK4zVim5f3jkOxY+WTCAm5fI95IZAIa8RIpmdh6jObxOQS61wSIW+Am
         s/5ug7kHOwyaYtbt8K2soZ9IwyTpFSn7/CmIB1wwUgxAoXgA1nJ+tuqKgAkM7UEPNqiY
         Z7Y6tBD1+OQKyO1DAkNtjmgWOhqvRHWRACSlsE+IB/b3tMKnuo4R03mEQdTkKBR+oXD5
         hzq21dVYwnqwsVUPuLyoj3Zkj1DsDYwDmkGf7G/AYAIBRvLTZbaPkI+26GzxQU6K25SP
         WwnQ==
X-Gm-Message-State: AOAM531KYB0Q2DhRFWdJFFYs1pP3CB3ww/7wpoxfgSkKDc76MM5xxemc
        VM7urttyKuuAwgIx2jphTGFKwdeXg3i+RQI466M=
X-Google-Smtp-Source: ABdhPJzZEpB74aDiIBlFtY2XEulNbfx2rQ+r0BSLvR7mYtSbTVkBonsnyCplglIrsnkaCorlimpaSw==
X-Received: by 2002:a05:651c:160c:b0:244:c704:8315 with SMTP id f12-20020a05651c160c00b00244c7048315mr788812ljq.170.1645648477605;
        Wed, 23 Feb 2022 12:34:37 -0800 (PST)
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com. [209.85.167.51])
        by smtp.gmail.com with ESMTPSA id j11sm46334lfm.40.2022.02.23.12.34.34
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Feb 2022 12:34:35 -0800 (PST)
Received: by mail-lf1-f51.google.com with SMTP id u20so347387lff.2
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 12:34:34 -0800 (PST)
X-Received: by 2002:ac2:5313:0:b0:443:99c1:7e89 with SMTP id
 c19-20020ac25313000000b0044399c17e89mr825261lfh.531.1645648474572; Wed, 23
 Feb 2022 12:34:34 -0800 (PST)
MIME-Version: 1.0
References: <20220217184829.1991035-1-jakobkoschel@gmail.com>
 <20220217184829.1991035-5-jakobkoschel@gmail.com> <20220218151216.GE1037534@ziepe.ca>
 <6BA40980-554F-45E2-914D-5E4CD02FF21C@gmail.com> <CAHk-=wir=xabJ73Upk1dsuoMKWTTjTfeLFJ=p2S0yRYYaxW4fA@mail.gmail.com>
 <20220223191222.GC10361@ziepe.ca> <CAHk-=widDQUjQS2tpaw3j_+Yz8rAY3P0qdqpz+nTNu4-3LaU3w@mail.gmail.com>
 <5a476b24-0f34-91d4-84a4-699e8c374abe@rasmusvillemoes.dk>
In-Reply-To: <5a476b24-0f34-91d4-84a4-699e8c374abe@rasmusvillemoes.dk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 23 Feb 2022 12:34:18 -0800
X-Gmail-Original-Message-ID: <CAHk-=whpK93+mF8CPJZo0KxDeHrV2GL05=HT7=y+GnhcNbNyUA@mail.gmail.com>
Message-ID: <CAHk-=whpK93+mF8CPJZo0KxDeHrV2GL05=HT7=y+GnhcNbNyUA@mail.gmail.com>
Subject: Re: [RFC PATCH 04/13] vfio/mdev: remove the usage of the list
 iterator after the loop
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>, Jakob <jakobkoschel@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Arnd Bergman <arnd@arndb.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Mike Rapoport <rppt@kernel.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Brian Johannesmeyer <bjohannesmeyer@gmail.com>,
        Cristiano Giuffrida <c.giuffrida@vu.nl>,
        "Bos, H.J." <h.j.bos@vu.nl>
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

On Wed, Feb 23, 2022 at 12:19 PM Rasmus Villemoes
<linux@rasmusvillemoes.dk> wrote:
>
> I have often wished that the iterator macros would consistently set the
> loop variable to NULL upon reaching the end.

I really think the rule should be that to a 99% approximation, we
should strive only ever use the iterated-upon value *inside* the loop.

No, that's now how we do it now. But I think the "break out and do the
work outside the loop" case is kind of broken anyway. It makes you
test the condition twice - and while a compiler might be smart enough
to optimize the second test away, it's still just plain ugly.

             Linus
