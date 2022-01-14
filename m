Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 732B048E800
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 11:01:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237537AbiANKBc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jan 2022 05:01:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230329AbiANKBa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jan 2022 05:01:30 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0FD0C06161C
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jan 2022 02:01:29 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id l12-20020a7bc34c000000b003467c58cbdfso6988524wmj.2
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jan 2022 02:01:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DcACr8Bd+mNZvnu1O74OohObZ0GddAZiXwcQTYhmUQY=;
        b=p8xafJDL5i8uvPfKnstNQWZ9evJZVA7UxSY4oqdA6G4x/Evelpj/oHt+NLas34INpx
         XNXJJghAC3Vl1rb1MOO1xHFMklmAD76kv8xB3JLIQ01DyzbUSuyOg5x90oagYmdO+RPw
         uGbhqCfr/xmk99FjGbLezVxStHqEvNUKdFz8qLPTaoEIGjtb6s2Wedvb/R/8zH/HwTuS
         c+iwgqBFr6jngXx3CFlT1Ppkn7TV8asB6XXywFA6pGr0O2LgydiTjBvGG8GjHfdlLB7Y
         vXJPbRmVJt3PQxTw9sE0wjBvgIowondxtBER7pqsT0TfpRRneCv4LdRoPJganioaGSZs
         6Fyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DcACr8Bd+mNZvnu1O74OohObZ0GddAZiXwcQTYhmUQY=;
        b=n3eYEn429OmDRQNgzAd7tg01xhtu2hF66Pob/E7J0lcYHwzUQFP3pvLiv2/KiZA8f/
         2JUJjqBfoWEhCwIzvrdhbIXWBLKVAPvoTmHN5SVoFpOcLwkKwqJcl8jyjuIe/K2IiF9O
         QZl++yAX0kljhJWogAj5X8leYZ0A6GOret3X41LnKHYDTTCOwep4uH/5GX45sImJftwM
         9RmOMHp4ujxUtqZS9e9ROStjjsq0GtZT+gpfICzyJ7+8zHpgG+0GFlQbMSRhOb19q/Oq
         loC+A1qv3q+GjQZ+/PvXLu7JBERACxEXoXrDFdi8/xok4RVfkcNyjk/06ZcT25ToPzUH
         vRSQ==
X-Gm-Message-State: AOAM533tsam3DHx9k2Ic6QwDuXPEHAnKSnhRU+bsZ/BTkrpPHH7aCmny
        otJbjD4yzYrlXoFu4v2DwV8DYPxBDYmIAXkVJiMSyw==
X-Google-Smtp-Source: ABdhPJwe5ihRS+8JPaUHiM2gWpjslK40TLTyJ5Wm2IxkKjXyp5F5glRNDdvkaM6MX+lKXVyxeolziQq6bwiytBCmeLk=
X-Received: by 2002:a05:600c:4f49:: with SMTP id m9mr14636872wmq.8.1642154488280;
 Fri, 14 Jan 2022 02:01:28 -0800 (PST)
MIME-Version: 1.0
References: <0e30e1f1bde74bc95085093fb0289007d510a68c.1640529121.git.christophe.jaillet@wanadoo.fr>
 <CAFA6WYOZtMW7bq98JXm8AqgajaYmythiDQ53k-zgew6zE63YCg@mail.gmail.com>
In-Reply-To: <CAFA6WYOZtMW7bq98JXm8AqgajaYmythiDQ53k-zgew6zE63YCg@mail.gmail.com>
From:   Jens Wiklander <jens.wiklander@linaro.org>
Date:   Fri, 14 Jan 2022 11:01:17 +0100
Message-ID: <CAHUa44Ghzbtj_YUQxAjq7cKmmJW8hRrYvq+9UwZn9CHkHO8_PQ@mail.gmail.com>
Subject: Re: [PATCH] optee: Use bitmap_free() to free bitmap
To:     Sumit Garg <sumit.garg@linaro.org>
Cc:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 27, 2021 at 6:36 AM Sumit Garg <sumit.garg@linaro.org> wrote:
>
> On Sun, 26 Dec 2021 at 20:02, Christophe JAILLET
> <christophe.jaillet@wanadoo.fr> wrote:
> >
> > kfree() and bitmap_free() are the same. But using the latter is more
> > consistent when freeing memory allocated with bitmap_zalloc().
> >
> > Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> > ---
> >  drivers/tee/optee/notif.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
>
> Looks reasonable to me.
>
> Reviewed-by: Sumit Garg <sumit.garg@linaro.org>
>

Looks good, picking up this.

Thanks,
Jens
