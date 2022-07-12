Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDE615712C7
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 09:05:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232289AbiGLHFH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 03:05:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231968AbiGLHFF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 03:05:05 -0400
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20EF91D0EA;
        Tue, 12 Jul 2022 00:05:04 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id l2so5244847qtp.11;
        Tue, 12 Jul 2022 00:05:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=D7LWQnfNk6keltPhuzK4RA+8ZwNJY7TvltfTLzLyfmA=;
        b=N0vNPoLFN38DuBtFJfGVNJglEiQ8ApSQ0HX31CbwSoCvVA0niVlDNSgmtHJGHM1plT
         vOWTN9vAJv+VjwVeBrD6oHLgxOcRlkqrEUScwnb3MHgBTc3m0UlkD7jSTkw7lbGCJeFJ
         X9BlcWiEauuQLl8DCfDdNt/vKFwxX2iAZrqNe3bLFnoppDtzXDw3k4b2GsZipHpvC0Au
         2OL4+uMN3IPFk7oP4bwsSsZufmYry9gJU8lrgLH1VuwN1nkPPJMNKuWc09LxwgkT5gNa
         /5aPqWWP5MIJeFU6lx7JkX9Bd0Mk/jYszVpSiOCZnF5j6ewBxMaYJ9yjbpx17oZ7sJVJ
         +53g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=D7LWQnfNk6keltPhuzK4RA+8ZwNJY7TvltfTLzLyfmA=;
        b=HMwJSLHOejyPnC93+WUoS+zsmDwKdUBL+z9f3pxSFwssgUNRAp2klRcqQfC8GaV7Ma
         3EJq+4urdHLczhd3DU+BPm7HGtV7s9/sq69BmYlZSguk1H4uHaLw+poxNSEiyLHBVq/L
         ta6dPzi/ozKCtqb9GyeijmF8/4cMFU4ib8EoZMIL6gBVr1AQNbsqmS9gULre4qtTOpdH
         lGoFw6miChuMyRi35Qc0/dBBaWsHJZDDnItwit2hbCMXbvAbUIgbdlXloIFYVgsoVsGQ
         i/O8/st6OfWa8mNaLMpWaROiYU3NPwTx+nms7KJ7fQ+HhRDQ7ExAEtfFVv5+mVW7VmbE
         3Ncg==
X-Gm-Message-State: AJIora/K0+h3Y5is4NL5siJ3t8yDtNMgyErOeLPkRO1IHHmiZQtLV15v
        DtxXnyEcv5jhF58IyJrE4HeKYuSvcYXXad+bDhbhO/n9QQHq8g==
X-Google-Smtp-Source: AGRyM1vPbZI8RMjdd0URsWOpqecC2HKJ7e5obZLK/80/fXMbeuV+mRQjvreSQIXukpmzULdsXPTPaehBgMe0gvRFwZk=
X-Received: by 2002:a05:622a:110e:b0:31e:b568:b5a5 with SMTP id
 e14-20020a05622a110e00b0031eb568b5a5mr6676673qty.54.1657609503173; Tue, 12
 Jul 2022 00:05:03 -0700 (PDT)
MIME-Version: 1.0
References: <20220711153301.2388-1-ubizjak@gmail.com> <Ys0C72unFFlsWomq@infradead.org>
In-Reply-To: <Ys0C72unFFlsWomq@infradead.org>
From:   Uros Bizjak <ubizjak@gmail.com>
Date:   Tue, 12 Jul 2022 09:04:52 +0200
Message-ID: <CAFULd4bqmbundK=YE9A1scW6za3z4B7B_XjY=sS1R+3H40fF0Q@mail.gmail.com>
Subject: Re: [PATCH] block: Use try_cmpxchg some more
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-block@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 12, 2022 at 7:13 AM Christoph Hellwig <hch@infradead.org> wrote:
>
> On Mon, Jul 11, 2022 at 05:33:01PM +0200, Uros Bizjak wrote:
> > Use try_cmpxchg family of functions instead of cmpxchg (*ptr, old, new) == old.
> > x86 CMPXCHG instruction returns success in ZF flag, so this change saves a
> > compare after cmpxchg (and related move instruction in front of cmpxchg).
> >
> > Also, try_cmpxchg implicitly assigns old *ptr value to "old" when
> > cmpxchg fails, enabling further code simplifications.
> >
> > No functional change intended.
>
> You might want to split this into a patch per caller as it might
> attact different reviewers.

No problem for me. get_maintainer.pl returned Jens as the sole
maintainer for all these parts, so I put everything together in order
to ease the maintainer's job.

> > +     do {
> > +     } while (old && !atomic_try_cmpxchg(&blkg->use_delay, &old, old - 1));
>
> It might just be me, but for loops with an empty body this do { } while
> construct looks odd.  Why not:
>
>         while (old && !atomic_try_cmpxchg(&blkg->use_delay, &old, old - 1))
>                 ;

The form was taken from e6790e4b5d5e97dc287f3496dd2cf2dbabdfdb35 [1].
Using try_cmpxhchg, almost every use fits in

do {
    // the body of the loop
} while (try_cmpxchg ...)

and when the body of the loop is empty, it is clear that this was
indeed intended. Using

while (try_cmpxchg ...);

looks to me like a semicolon was left there in error, like "if (...);".

> The the use of the atomic on ->use_delay looks really whacky to start
> with.  To me it sounds like it really wants to use a proper lock
> instead of all this magic.

I took a lot of care not to change the functionality of the
surrounding code, and any functional change should be outside of the
scope of the patch.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=e6790e4b5d5e97dc287f3496dd2cf2dbabdfdb35

Uros.
