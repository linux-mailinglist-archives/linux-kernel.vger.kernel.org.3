Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A147155EB28
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 19:41:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231652AbiF1Rld (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 13:41:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230381AbiF1Rl2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 13:41:28 -0400
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6788333E15
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 10:41:26 -0700 (PDT)
Received: by mail-qv1-xf2b.google.com with SMTP id n15so21055936qvh.12
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 10:41:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=kP/OwZqnk0JXGhJiGnpZjLiC4QMReOG8HYOwD3UL2mg=;
        b=BgsW/0m1RpRJJrnPpK+d60h/X0zU7xSJPEBhGcAhUGfZiGh7ugnrbBeMpUGWmMR7dk
         9vGKyG7sl8/ex44WYEmI6yDqWBRdqzuRMwX8NPAGEOJb9fAWmq0V9eEzThYxvDuhdyYH
         BQD60xiYbYUahgqrOwuzfRTRGM7WkSopM7D5DHhZ9ONsjpQIKSDyuowUDVU8ucj//hfS
         KaLlmayQNFRq2zgd4IdzHtIksY/JoHH/ZdqCFcZ3F3pJPAfHs6efrWR9NbAEL9b0uXas
         NUV7a5UsPwJayyREAohJDaxpXmhCOtg1QhnrGaqHN/AJ3+9X9brR3EeW/SIE8DFZH3nr
         GREw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=kP/OwZqnk0JXGhJiGnpZjLiC4QMReOG8HYOwD3UL2mg=;
        b=AwGMGzpHLIEJWWUk7mEGtIu04AMqHSOojhrWNn80vkQ9Vs8phdpipda30fc6sBUDEI
         G9pGekEAY6em/fIbL0ipq7uvJCuHmGvMdrYNN3z7DgwlTmZtbCahMoRxh8cJviVggOHX
         mhsyP5ezaFjUtIldOCjmn6YonstUF67l0IjbaIcU7zUM1syWYFFLG9L5rHvSvqJuCeJL
         Bk9CtbfXfNXpYzq6PH3RHF+mU/umkTxNcjeJW/PawzlrYOjcKtR9uwkQsrJYZhk3wqwU
         tmfNymy5wojCJw78UT3uGEv1+gv0uk2lT28HyNdTKrUZIm2AV0oQRjxXZ9V2r3Stt1DD
         DOvg==
X-Gm-Message-State: AJIora/pbs1e+43Js0MYhn0JBcBnaK77zMZIj209s4VvpYG6OB1a1Gxe
        Eajlvfqv8dT88MRyqLjgJQ==
X-Google-Smtp-Source: AGRyM1tatTZzmrlDBic2Tw7qNExxtJjuNHTdU0dnJZLNvBgAUD92Q8kyR3GotbT1Tsttv79WrHt96Q==
X-Received: by 2002:ac8:5c07:0:b0:315:73be:a206 with SMTP id i7-20020ac85c07000000b0031573bea206mr14754415qti.63.1656438085505;
        Tue, 28 Jun 2022 10:41:25 -0700 (PDT)
Received: from localhost (c-73-219-103-14.hsd1.vt.comcast.net. [73.219.103.14])
        by smtp.gmail.com with ESMTPSA id z3-20020a05622a124300b00316a384447fsm9486553qtx.16.2022.06.28.10.41.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jun 2022 10:41:24 -0700 (PDT)
Date:   Tue, 28 Jun 2022 13:41:24 -0400
From:   Kent Overstreet <kent.overstreet@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Petr Mladek <pmladek@suse.com>
Subject: Re: [PATCH v5whatever, now with typechecking] vsprintf: %pf(%p)
Message-ID: <20220628174124.uyuyi4wytowwfjdl@moria.home.lan>
References: <20220628032439.3314451-1-kent.overstreet@gmail.com>
 <CAHk-=wiGMNvKaVuSDD7y2JeK+NsNyXtqZEusOLmEw9uE+0ZySg@mail.gmail.com>
 <20220628172321.gbgfif7zgz5ny3mo@moria.home.lan>
 <CAHk-=whTGmf5=f1JdzK22Jw88veKxB2YHbxL0Sgy9EQzMs_MBA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=whTGmf5=f1JdzK22Jw88veKxB2YHbxL0Sgy9EQzMs_MBA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 28, 2022 at 10:29:05AM -0700, Linus Torvalds wrote:
> On Tue, Jun 28, 2022 at 10:23 AM Kent Overstreet
> <kent.overstreet@gmail.com> wrote:
> >
> >  - We need to be able to specify the pretty-printer function, and not just have
> >    one per type
> 
> I even showed you how toi do that, you just deleted it.
> 
> Anyway, I'm done with this discussion. I think this is all pointless.
> I think you are making things worse, you are making things more
> complex, and I don't think this is a direction we want to take things
> in.

Linus, I'm ok with this not working out. Really. Trying to do something
difficult and new _often_ ends up in the result being too complicated and ugly
to live.

But that doesn't mean I'm not going to try, and if it's an idea I think has
potential I'll keep trying because it often takes a couple attempts and a couple
rewrites.

Anyways, I've been listening to your feedback (and honestly pretty appreciative
of it, it beats the hell out of what I was getting on the list). I'm sorry if
you feel like I wasn't listening or taking into account _everything_ you had to
say, this is a problem I've been thinking about for quite some time and I've got
a number of constraints I'm trying to fit.

And I apologize, it looks like I did miss something - I went back and reread and
saw you also had pretty_fn() in your example. So sorry for skipping past that,
my bad.
