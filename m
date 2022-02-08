Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2C284AE165
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 19:49:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385439AbiBHSr4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 13:47:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1385423AbiBHSrv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 13:47:51 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2839BC0612C0
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 10:47:49 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id cn6so279017edb.5
        for <linux-kernel@vger.kernel.org>; Tue, 08 Feb 2022 10:47:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6mUKs8mr76hd0MFknp8EWX6G4mUT2iT6oVgdRjhWDVQ=;
        b=AW0ZMG08jE40Og2RDKzb836NI3DmQ5Nu2DfyA7c1/xy506HgYpHJVANCQ/2zAYYrYb
         5xvgX0ZI55zcLmwGg+ahNT13LuSAFFh8qo/mDDMm4qR8AggnjS+lDT2shOluS0uXzumN
         hezE1macEKIORPLttPi6sYf8/psKfsFsO+QFk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6mUKs8mr76hd0MFknp8EWX6G4mUT2iT6oVgdRjhWDVQ=;
        b=TDc+i5XG7itg9edQXj0NfPRA44BL+WxJNOhdbOWceZnhGC0NidM3yconlJ+Y1rO18E
         vMTWaX556G0Py7QnemLpA42YLAOg8AfwIkyLz5nB36XYIdqt4zojgLzKDUPvFjMpXiE4
         LNCUKNXbgiLN+dpvvYt9R5L9k9M6fBezIgM3yt1Mfd0B/ktoCIFRobLJBe1sY1fao5gc
         OuDy/cyhsQLR8zxFd/k3hgl/PqowECSj0xq97gha5qJBLm4ifiSnXLwOa1lnVsEdnZVJ
         ptgtjHbU/ETsZ+DzyRBg/RNg0rxYVvHAwOStL2V+BCh+e7olcGxP0DAafQ57RKghhPbq
         Zoxg==
X-Gm-Message-State: AOAM533KavJQhlg22YHpNggGs7/Yl9IA3NEgCGBldf4iJFLGqvdgsO83
        9O2yw3Z3pIa/17kdFjfgdI9/gQMF8+9JGgAa
X-Google-Smtp-Source: ABdhPJz9lsO8lrif2mHMAqCKB22bmc9FthRdcECpz30/tZVspoGvxIEH8RK+ZR6zkWVVOkyNBG40uA==
X-Received: by 2002:a05:6402:26ce:: with SMTP id x14mr5875613edd.211.1644346067574;
        Tue, 08 Feb 2022 10:47:47 -0800 (PST)
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com. [209.85.221.49])
        by smtp.gmail.com with ESMTPSA id z2sm3391827ejr.68.2022.02.08.10.47.46
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Feb 2022 10:47:46 -0800 (PST)
Received: by mail-wr1-f49.google.com with SMTP id q7so4269220wrc.13
        for <linux-kernel@vger.kernel.org>; Tue, 08 Feb 2022 10:47:46 -0800 (PST)
X-Received: by 2002:adf:f90c:: with SMTP id b12mr4520200wrr.97.1644346066360;
 Tue, 08 Feb 2022 10:47:46 -0800 (PST)
MIME-Version: 1.0
References: <20220208150625.374191-1-Jason@zx2c4.com>
In-Reply-To: <20220208150625.374191-1-Jason@zx2c4.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 8 Feb 2022 10:47:29 -0800
X-Gmail-Original-Message-ID: <CAHk-=wi3fRiQXynJrLvaD5DDqF0MzgX1xSGFSJS_2frwXT1E5Q@mail.gmail.com>
Message-ID: <CAHk-=wi3fRiQXynJrLvaD5DDqF0MzgX1xSGFSJS_2frwXT1E5Q@mail.gmail.com>
Subject: Re: [GIT PULL] random number generator fixes for 5.17-rc4
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     linux-kernel@vger.kernel.org
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

On Tue, Feb 8, 2022 at 7:07 AM Jason A. Donenfeld <Jason@zx2c4.com> wrote:
>
> Given that these fixes are for a security issue (albeit a probably relatively
> low grade one), sending this mid-cycle feels like the "responsible" thing to
> do, and 5.17 will resultantly have a more secure RNG. However, I also would
> understand that, diffstat not withstanding, you think this is a bit much and
> want to reject this pull until 5.18. Either way works for me, though I
> naturally lean heavily toward the former, hence making this pull request in
> the first place.

I think the changes look fine, but this definitely conceptually is a
"new feature" to me, rather than some security fix.

Using a hash instead of an LFSR sounds like the modern and sane thing
to do, and simplifies the code a lot. But I also don't think the old
LFSR model is broken in practice.

I don't think the pool leaking has been a real or realistic attack,
and when the issue is lack of any actual real entropy (which _has_
been an issue), I don't think it really changes anything in practice.

So I think this is improving the code, but I don't think the old
approach was so broken that there's much argument for a mid-rc update
like this (and if it was, we'd have to mark this cc:stable all the way
back).

In contrast, as a 5.18 merge window pull request, this makes complete sense.

           Linus
