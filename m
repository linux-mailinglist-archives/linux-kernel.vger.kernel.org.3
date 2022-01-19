Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BE0049368C
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 09:49:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352558AbiASItm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 03:49:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351869AbiASItl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 03:49:41 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A3F4C061574
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jan 2022 00:49:41 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id c24so5446106edy.4
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jan 2022 00:49:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=63UMAZJ8UaeleKSQ6Z/+YlL8VwCIenEbrG/mPXwnfMk=;
        b=Gv3+5DO1cfhtUQ5wnH6KkC8emnTvlUJQged0Fdct2Z8i4KfApYAUjV+nODsQMxqUSS
         S5F4sHex4RDFaUA6kBj0Psiv6W2OLJBmj/VBmXKYj+Z/kiL/Mbl5sp+1ljm4ApfBP09p
         TA8XcMUB2fxG8IcTXTyy8GGzQU4qn0ZJn9oyI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=63UMAZJ8UaeleKSQ6Z/+YlL8VwCIenEbrG/mPXwnfMk=;
        b=ThId8vQdLxapz7/GCWrWZ9+5byD3aasUdcn41+uCmtkH5rexXw+6Q1EzAcbjlMkKpK
         nUfuMXpbjtHyTxD6uDG03/AbyGcUJ/n3+TREPSuih6xtTOPV7VJidyx5gMnAP1ZWFMaJ
         bjMeHvt5LXogWE+r3Nh71ufqVpbNPPao6fRWfSDEdNSDkZNFgYm7aDCjXaUSoHan0Rpo
         0tyxoiBirNQEftlZtpzw20jEXusBrZr+fCHpR+AYptMQO3D9svp0wkYBiHdlfoPkaXvw
         3OYQJwno4Mo9lVuRR4li3aJv+p5J58PA/aE1YRJBIHw2i0DzXDu1rfbhAQnXfQcNJwDO
         M5og==
X-Gm-Message-State: AOAM533W+a8r2nItvI54Djx+c9tLrBqqKotuc1SiCPBJrGZmKKH/Eo3j
        +aCHyhooDCv97eZt3HWSKn/7U65DvcrNkHqgmZY=
X-Google-Smtp-Source: ABdhPJy5r9P8c9NtmOCZJ6AmW+YjlfI+s8OVi/2hcEoXSZj8JFOcQ5TY5ylkS7Wp8toCXsuHhHuovQ==
X-Received: by 2002:a05:6402:1d4a:: with SMTP id dz10mr14285263edb.206.1642582180074;
        Wed, 19 Jan 2022 00:49:40 -0800 (PST)
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com. [209.85.128.46])
        by smtp.gmail.com with ESMTPSA id o20sm497123ejb.33.2022.01.19.00.49.39
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Jan 2022 00:49:39 -0800 (PST)
Received: by mail-wm1-f46.google.com with SMTP id q9-20020a7bce89000000b00349e697f2fbso12710889wmj.0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jan 2022 00:49:39 -0800 (PST)
X-Received: by 2002:a05:600c:3482:: with SMTP id a2mr2413478wmq.152.1642582179436;
 Wed, 19 Jan 2022 00:49:39 -0800 (PST)
MIME-Version: 1.0
References: <20220118164906.402468-1-Jason@zx2c4.com>
In-Reply-To: <20220118164906.402468-1-Jason@zx2c4.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 19 Jan 2022 10:49:23 +0200
X-Gmail-Original-Message-ID: <CAHk-=wj-DoruDmbAojOJ=VtpZG6piwbRJXO1N1Uq6uX7Q4UVoA@mail.gmail.com>
Message-ID: <CAHk-=wj-DoruDmbAojOJ=VtpZG6piwbRJXO1N1Uq6uX7Q4UVoA@mail.gmail.com>
Subject: Re: [GIT PULL] random number generator fixes for 5.17-rc1
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 18, 2022 at 6:49 PM Jason A. Donenfeld <Jason@zx2c4.com> wrote:
>
> 1) Some Kconfig changes resulted in BIG_KEYS being unselectable, which Justin
>    sent a patch to fix.

Ugh. I think the old "don't ask" model was the correct one, and
BIG_KEYS is probably broken (ie it should just select whatever crypto
it wants, not depend on people having selected it).

But I've taken this.

On a tangential note - looking at the resulting config file, I do note
that 'CRYPTO_LIB_POLY1305_RSIZE' should probably depend on
CRYPTO_LIB_POLY1305, because right now that sily thing gets set
whether POLY1305 is enabled or not.

That was true before too, of course - not related to this pull except
in the "this caused me to look at the end result" sense.

              Linus
