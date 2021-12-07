Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5409846C830
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 00:24:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242553AbhLGX2W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 18:28:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238388AbhLGX2V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 18:28:21 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8423C061746
        for <linux-kernel@vger.kernel.org>; Tue,  7 Dec 2021 15:24:49 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id l25so2000175eda.11
        for <linux-kernel@vger.kernel.org>; Tue, 07 Dec 2021 15:24:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lZHabsPUc23xUEp/km7HooDqnp/1KyBKhA9+Ose3GXw=;
        b=DvnwlWEkpneQi1XlSO3gBPxLD70iikmgjVN61w8yUvn34PBCune25Jj9mW9XNgFL4q
         un4+G4P2SmN1djB/dNEp7ybFulczA6mZmTtM/H80MUvsu1Ga3PzhvFuSc1Dk+D+hQ15/
         db+sVtRBcfzEfAnFuUgbgivW8aOWBdK5sEbbo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lZHabsPUc23xUEp/km7HooDqnp/1KyBKhA9+Ose3GXw=;
        b=x1IzUbaa7mv6WQGr6sGEcuy5r27ZcALoev2mEDKsK6neLwhzCoYbg+YC3kkIVLPUNS
         O7lgLg0aZjHBnJPLi+2ppOXe78oeELn6mVZlivfDokWjryEktVbqugpxqZ0X8Fu6yViw
         eY1IdOKSnOum8Me0T7Sl2ayoHzl1l1WG8ArUk9i2u8W3GHDIAPTIPj3Xai9PBxkc8IhB
         cjqhHrysn0FH2qbLsVLNcZvmlYsn8F6A0Vl1nBtV8Fk7hvr/YAs3oZjY6EddXMchwivH
         eaNz4DktR1sJUvN9jRS03FUKYz4HOypJvdFuOV/v0Mpps2xp8zm1ZV8woxjFvPdAFOeQ
         JbDQ==
X-Gm-Message-State: AOAM531ylGYznYMxxSsikQYM+d4qiDOfMqRBtOjeSY1gsLg1Q4VrECSQ
        YHWKWYa/+z1FXEoVb8uYrAlNQPZ/p/FqPjeGCws=
X-Google-Smtp-Source: ABdhPJzSQs+PHd4YPd9FzZc5EW2wSRsNOwVKDMy71YYG9DkWJm7R2D2lajhK9Eb79S343ErHTxr29g==
X-Received: by 2002:aa7:c14a:: with SMTP id r10mr13556873edp.122.1638919488048;
        Tue, 07 Dec 2021 15:24:48 -0800 (PST)
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com. [209.85.221.48])
        by smtp.gmail.com with ESMTPSA id e8sm851402edz.73.2021.12.07.15.24.47
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Dec 2021 15:24:47 -0800 (PST)
Received: by mail-wr1-f48.google.com with SMTP id o13so828241wrs.12
        for <linux-kernel@vger.kernel.org>; Tue, 07 Dec 2021 15:24:47 -0800 (PST)
X-Received: by 2002:adf:e5c7:: with SMTP id a7mr55762662wrn.318.1638919487065;
 Tue, 07 Dec 2021 15:24:47 -0800 (PST)
MIME-Version: 1.0
References: <20211207095726.169766-1-ebiggers@kernel.org>
In-Reply-To: <20211207095726.169766-1-ebiggers@kernel.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 7 Dec 2021 15:24:30 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjXM77BfA6gZTYzpP_7nWw3Mdjfr8pid_TLAqsk-p0wOQ@mail.gmail.com>
Message-ID: <CAHk-=wjXM77BfA6gZTYzpP_7nWw3Mdjfr8pid_TLAqsk-p0wOQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] aio: fix use-after-free and missing wakeups
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

On Tue, Dec 7, 2021 at 1:59 AM Eric Biggers <ebiggers@kernel.org> wrote:
>
> Careful review is appreciated;

I dunno about "careful", but looks sane to me.

> Note, it looks like io_uring has the same bugs as aio poll.  I haven't
> tried to fix io_uring.

Jens?

                Linus
