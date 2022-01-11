Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 184AC48A5E5
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 03:53:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232433AbiAKCxQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 21:53:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231590AbiAKCxP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 21:53:15 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E805DC06173F
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jan 2022 18:53:14 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id c71so49981421edf.6
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jan 2022 18:53:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RFZY2ueA8dih/Ph6oPag2dxgotRBXhtzjSAvUudHnIY=;
        b=P+MPAoIyBtw16udETh31u1xox98U7/zK5e4+H2Jkqdxs9duw1GWf2p3AnpbOpS/Tnh
         sF6JmmyzaL2YD7cj+PCmFJzKzbGSPfSk3L9DnCwSWQAP5TJB7inJcR0alc7Yl/w8XxON
         GZBxtAvK/V7/1ZnzI7GXFn0V8Lmp9TtPrspMg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RFZY2ueA8dih/Ph6oPag2dxgotRBXhtzjSAvUudHnIY=;
        b=dfz6mN/Man72o6aGeTynryapoZrAPGoQiYGbNqCurIgMEt+MOpWSuf9f9teHefZ1eX
         fVSdmeVjAZ8e8vTGwAhpBteo/FMN12PRTGFdpcdV354fpWctJOm5HB8bxtZMka+s8lHc
         bBxXC6OkQSmR9236xRZUnumTfF3RKa0UglFAAbKCG+L7i6RvvcErN7F0hpWTd9bQiJ2S
         FTiyIpkUJMzFx2u4Kh8YFOk8f8JXRAUbS6ttSwcXGnzyKO/DNjUwWt3W2z48jTDJPmGT
         CxO1oDSBfr82tyA2VQVokttiF1gGJuJRvkSLwFUxSJMFO6t4QhRGmRDI62Z07B3TTBjx
         bU9Q==
X-Gm-Message-State: AOAM5303jgLk5Y08811i+LcIa1f9LPW0cqtooLkreYGwRbpUuHG4xMXv
        OoCesHWFpB5ul5tqkz6BDZTvdG77ZduTQF1yxcY=
X-Google-Smtp-Source: ABdhPJwiOb7jg/+gN7Yp3oGojrXq7SytJYa8PK75YV2lUksmEAjqMHOhv85NwKhk/1ziJt8tExCgJg==
X-Received: by 2002:a17:906:7146:: with SMTP id z6mr1994656ejj.767.1641869593407;
        Mon, 10 Jan 2022 18:53:13 -0800 (PST)
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com. [209.85.221.54])
        by smtp.gmail.com with ESMTPSA id ku25sm2197230ejc.108.2022.01.10.18.53.11
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Jan 2022 18:53:12 -0800 (PST)
Received: by mail-wr1-f54.google.com with SMTP id q8so30248766wra.12
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jan 2022 18:53:11 -0800 (PST)
X-Received: by 2002:adf:e3c9:: with SMTP id k9mr1899247wrm.193.1641869591441;
 Mon, 10 Jan 2022 18:53:11 -0800 (PST)
MIME-Version: 1.0
References: <CAPM=9tz=_hRpQV1V3M-=KmVVEbr1K166qeb-ne64PHk9Sn-ozg@mail.gmail.com>
 <CAHk-=wg9hDde_L3bK9tAfdJ4N=TJJ+SjO3ZDONqH5=bVoy_Mzg@mail.gmail.com>
 <CAKMK7uEag=v-g6ygHPcT-uQJJx+5KOh2ZRzC2QtM-MCjjW67TA@mail.gmail.com>
 <CADnq5_P9n39RQ5+Nm8O=YKXXvXh1CEzwC2fOEzEJuS2zQLUWEw@mail.gmail.com>
 <CAHk-=wgDGcaRxUwRCR6p-rxDVO78Yj4YyM6ZsPRGiT2JOCoQ6A@mail.gmail.com>
 <CADnq5_OYO7kq+9DBnDvbSfpouFvdLB0LPSL6+f1ZPRBsV=qEqA@mail.gmail.com>
 <CAHk-=wiCCRG9Lwzr+Cur=K1V2GJ9ab_ket7EnG4RZhJ8jJM7xQ@mail.gmail.com>
 <CAHk-=wi8b-YKHeNfwyYHMcgR2vJh4xpSZ0qjkv8E8Y9V8Sv2Tg@mail.gmail.com> <CAHk-=whnWnB9yjVaqWNKjavSJxDOEbTAPwef=O7qjL8nKZgV6A@mail.gmail.com>
In-Reply-To: <CAHk-=whnWnB9yjVaqWNKjavSJxDOEbTAPwef=O7qjL8nKZgV6A@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 10 Jan 2022 18:52:55 -0800
X-Gmail-Original-Message-ID: <CAHk-=whSAYiO_TkKut6XckdQigFj39ft1Kcs2qJe5niHWPGdwg@mail.gmail.com>
Message-ID: <CAHk-=whSAYiO_TkKut6XckdQigFj39ft1Kcs2qJe5niHWPGdwg@mail.gmail.com>
Subject: Re: [git pull] drm for 5.17-rc1 (pre-merge window pull)
To:     Alex Deucher <alexdeucher@gmail.com>, Jun Lei <Jun.Lei@amd.com>,
        Mustapha Ghaddar <mustapha.ghaddar@amd.com>,
        Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>,
        meenakshikumar somasundaram <meenakshikumar.somasundaram@amd.com>,
        Daniel Wheeler <daniel.wheeler@amd.com>
Cc:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        "Wentland, Harry" <harry.wentland@amd.com>,
        Dave Airlie <airlied@gmail.com>,
        "Koenig, Christian" <christian.koenig@amd.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 10, 2022 at 6:44 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> I'll double-check to see if a revert fixes it at the top of my tree.

Yup. It reverts cleanly, and the end result builds and works fine, and
doesn't show the horrendous flickering.

I have done that revert, and will continue the merge window work.
Somebody else gets to figure out what the actual bug is, but that
commit was horribly broken on my machine (Sapphire Pulse RX 580 8GB,
fwiw).

                   Linus
