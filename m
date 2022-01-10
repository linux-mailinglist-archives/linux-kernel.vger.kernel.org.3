Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6196948A18D
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 22:10:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241121AbiAJVKo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 16:10:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240545AbiAJVKn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 16:10:43 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC613C06173F
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jan 2022 13:10:42 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id o6so58914559edc.4
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jan 2022 13:10:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CzOkmxOBSV9Ezr9QPrNTkWoWCCkUbqzV84f/9/7plj0=;
        b=HeusBfk0oTBDWgN3Pioj3BEB2suB3d5lKrRk/Ukp7jPRk/AxG1lrmE9nQ7kYEV8933
         Q5JqEBNN8aiGOkfspYZ61c6tdx2GgWSRszMJCSfzh5RmSWk5l3lewXQqwcuPK92M87dN
         DMElE/fUtk/3I51/41iqEN4Yw9EJtZ7e1i2Zs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CzOkmxOBSV9Ezr9QPrNTkWoWCCkUbqzV84f/9/7plj0=;
        b=sUZabK9y7rO2Z1CjQ4t2IYayOXbkONlHCwrmQskgxmSodSdSZ6y+IOxqoY4rmsqtEE
         DYoo85P5UNEI18VjHiNdA77/zeIh1rEDfon0VPj42aMZAS2/uvlVZMc+s0SKQZaZjfjI
         6IYY/oU0HEoivuASVci+DU8ZRr8M+Hb2vbLnVMO7nN0NSrffTj32Ca3SxN1pthuTc1uj
         9AhBce0e3mpOiD1D2rfKNYikznGiso9zwgzr9zL0rOfvO0MzsFdUjTprqi8G3iJBy3VQ
         1VW+YogptUb528N5jXU+gi5r5oIyKP8h/E9B/chLVc71Z3h0sUnWIo4QUB4nWB+b97r2
         WZtQ==
X-Gm-Message-State: AOAM530a3qnnFULNLRZItcR0Owh/v6Y9DOetcYekI3tP6pW/XBsu6Xad
        a6P2SZQB6GLWvAiq72/8N30MdDIy0fpyKqY9HlQ=
X-Google-Smtp-Source: ABdhPJwmuHD3FNJYuRoOGoeg1BJT+e/Lb/XMoX80EwDqfsQ6EcC7iohAfRSzJV9BClOIciemThyjDw==
X-Received: by 2002:a17:906:1f51:: with SMTP id d17mr1144541ejk.759.1641849041136;
        Mon, 10 Jan 2022 13:10:41 -0800 (PST)
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com. [209.85.128.42])
        by smtp.gmail.com with ESMTPSA id e4sm2927131ejs.13.2022.01.10.13.10.40
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Jan 2022 13:10:40 -0800 (PST)
Received: by mail-wm1-f42.google.com with SMTP id n19-20020a7bc5d3000000b003466ef16375so239377wmk.1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jan 2022 13:10:40 -0800 (PST)
X-Received: by 2002:a05:600c:4f49:: with SMTP id m9mr23532863wmq.8.1641849040053;
 Mon, 10 Jan 2022 13:10:40 -0800 (PST)
MIME-Version: 1.0
References: <CAPM=9tz=_hRpQV1V3M-=KmVVEbr1K166qeb-ne64PHk9Sn-ozg@mail.gmail.com>
In-Reply-To: <CAPM=9tz=_hRpQV1V3M-=KmVVEbr1K166qeb-ne64PHk9Sn-ozg@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 10 Jan 2022 13:10:24 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjpsnsZwxNZoRRSocuKFJegvxYmz1+7X7WMAw=qN4ywRQ@mail.gmail.com>
Message-ID: <CAHk-=wjpsnsZwxNZoRRSocuKFJegvxYmz1+7X7WMAw=qN4ywRQ@mail.gmail.com>
Subject: Re: [git pull] drm for 5.17-rc1 (pre-merge window pull)
To:     Dave Airlie <airlied@gmail.com>
Cc:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        "Koenig, Christian" <Christian.Koenig@amd.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 6, 2022 at 10:12 PM Dave Airlie <airlied@gmail.com> wrote:
>
> nouveau_fence.c is the only conflict I've seen and I've taken the result from
> our rerere cache in the merge above. It's non trivial, would be good to have
> Christian confirm it as well.

Thanks, that conflict really ended up being one that I would have done
very differently without having had that pointer to your reference
merge. And I would almost certainly have messed it up in the process.

So what I did was to look at your merge resolution (or possibly
Christian's? I don't know how you guys share your trees and the origin
of that rerere), and tried to understand it, and basically recreate
it.

It's not exactly the same (different whitespace and variable
lifetimes), but I think I got the gist of it.

Thanks for the pointer, and hopefully I didn't mess it up _despite_
your merge showing me what I should aim for ;)

               Linus
