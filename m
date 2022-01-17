Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E92E4900CF
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 05:33:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234265AbiAQEdr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Jan 2022 23:33:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229563AbiAQEdq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jan 2022 23:33:46 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC2CFC06161C
        for <linux-kernel@vger.kernel.org>; Sun, 16 Jan 2022 20:33:45 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id 30so60369512edv.3
        for <linux-kernel@vger.kernel.org>; Sun, 16 Jan 2022 20:33:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7jrKjyT1kUm6YgYqjVjGNp13+22Ic721iKzftS1kH20=;
        b=JHCBzpxZO0qDrU3BMMl1rhqj69ppdwRjuS+PkPO9ZkTDdHFBPcx/CtuYLr3cXB6HYx
         pm0L+DGXBsrNR41zE5UgmfDxVI8wvQo8NUJ4yGog5vvaO5AeuJ9ZKbwTVKVdokvQda0Q
         9ke31ZMGpJy9T9e4TAO8pxV8x5sJTk+wdB15Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7jrKjyT1kUm6YgYqjVjGNp13+22Ic721iKzftS1kH20=;
        b=FF+0hiUu5gT4D0SKkYtizOo85hbwGjWWcYnmKGMPAqYYMZoyEROwL+dGbYsBAGZfKr
         28+fcAG0hzgpBRbGA7yDG13h02UXTRR8pYxDkYH09Q1pvYgdN0RUYfH9tmX7T7OaaYTU
         YL8+rxYcfSLUBTwZGwj9VdK54Md9iQy7YcyWb/SgK04tw1t6bYj3mYajq0ZGg7PybHTV
         p5xMvjPmzMDKyUfzhkz1Qh39zFWNBVEBD8VrUfpIQRh/uULLGKzAk1hVqR+ua8AEZgEk
         sF2mkyzOg0iMVSMn0Mwk4Pv44eSmqv3Sow8DR2aGpwoohyy33HkMq2cgYykIjE65tPVS
         WrTQ==
X-Gm-Message-State: AOAM530FfRcmb2ZaCyc6JdRH8uZJk2WIt167lzdQMMk0rbrrtRPgv3tE
        AYjWhNkiX0ozFemdSvS8cD16MZw9JZUeX2wz
X-Google-Smtp-Source: ABdhPJzYiO/OUV5RQN5msBFHQi45z4fjwAJnO0WasyLu4IT7nZy+j1wPJuD/pua0Z+NtqCj841qTbw==
X-Received: by 2002:a17:907:6d9b:: with SMTP id sb27mr13496682ejc.222.1642394023918;
        Sun, 16 Jan 2022 20:33:43 -0800 (PST)
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com. [209.85.128.41])
        by smtp.gmail.com with ESMTPSA id q19sm1722753ejt.198.2022.01.16.20.33.42
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 16 Jan 2022 20:33:42 -0800 (PST)
Received: by mail-wm1-f41.google.com with SMTP id r82-20020a1c4455000000b0034cd1acd9b5so273453wma.1
        for <linux-kernel@vger.kernel.org>; Sun, 16 Jan 2022 20:33:42 -0800 (PST)
X-Received: by 2002:a05:600c:2253:: with SMTP id a19mr4527780wmm.8.1642394022326;
 Sun, 16 Jan 2022 20:33:42 -0800 (PST)
MIME-Version: 1.0
References: <YeRyfaesC2kxkgZC@ls3530>
In-Reply-To: <YeRyfaesC2kxkgZC@ls3530>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 17 Jan 2022 06:33:26 +0200
X-Gmail-Original-Message-ID: <CAHk-=whE5gmEKLt+rtEn2MV=BN8p+QTU56VaPdSD_kmxkx7smQ@mail.gmail.com>
Message-ID: <CAHk-=whE5gmEKLt+rtEn2MV=BN8p+QTU56VaPdSD_kmxkx7smQ@mail.gmail.com>
Subject: Re: [GIT PULL] fbdev updates for v5.17-rc1
To:     Helge Deller <deller@gmx.de>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 16, 2022 at 9:32 PM Helge Deller <deller@gmx.de> wrote:
>
> This pull request contains only one single initial patch which adds
> myself to the MAINTAINERS file for the FRAMBUFFER LAYER.

I'll pull this (as my test builds for other things complete), but this
is just a note to say that this pull request email was marked as spam
for me, with gmail saying something along the lines of "lots of emails
from gmx.de have been marked as spam"

I see nothing odd in the email itself, and it has proper SPF and DKIM,
but it's possible that you end up sharing a subnet (or an ISP) with
spammers...

Or maybe it was a random one-off. We'll see. I check spam filters
enough that I _usually_ tend to catch these things.

                Linus
