Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB873493BB7
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 15:10:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355073AbiASOIj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 09:08:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355049AbiASOIa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 09:08:30 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77AD8C061574
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jan 2022 06:08:29 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id br17so9846693lfb.6
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jan 2022 06:08:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9nBImq/nQkQnpOEWVoZQh94HXj35ecrQ4IXZo3Dyzmw=;
        b=KSHMHMEeC0dv+WHm/tTZDcjCTpmGgJ+2O/Bcj5nqx14TU6rVFm0TYJQNimzbkDNAZn
         R8D5a4s470rm4/0YtqDbW1Uye6IoKCIq7W9dhj78xwaHPlVVV6WmGawx0MQMZTuxkVFU
         HmV0aG6V3m/+6aXvoG0EXnalfyW8QG4N8bJgA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9nBImq/nQkQnpOEWVoZQh94HXj35ecrQ4IXZo3Dyzmw=;
        b=EJYkV4h3Z24DGgULIiXNFcQjk1rmssrull7bsaBQ4AGJ1/OHrDJ9mwzhn091p/N7Ni
         MiZpMNBVpzl72ZlwIjFkzVShFaXDOI3Sa+eMzI1I/NLDbd0NlXEKGmllaOOI2plj1uBs
         vrKZwzujL8ZW/buEm6akWl1zEhq2juluuFvLThI48nvgUtBRpVsoEcnah0ht3UxiK/lM
         uE09yVwYLhLuqNTYQMbk13V97+tfyieWgkiQMWJAk6pm81P2SolkZ06zQmq0b6EMSwQa
         nD6tD/Vp7LDWBLaAdsDv6RVicb9We344lTZjhthQW/8R/OQCUvtaK5J+t7gCh3a4J9SV
         ruTA==
X-Gm-Message-State: AOAM53118k8jLhmon23dI8Trswh4TXsJXfmPlX4H/euPKIhHK0CZNw0p
        WWlIX1+uzXxKKadmFGRZQ1TAp176vDJ/yK3jTZo=
X-Google-Smtp-Source: ABdhPJwx8nPiyiKQOPIiZVKkhKUqNPKix1WQ79mO68rgk0BcojEiidYMOzLT3ft/sqeXZ4ygdnGicw==
X-Received: by 2002:a05:6512:3407:: with SMTP id i7mr6804551lfr.346.1642601307619;
        Wed, 19 Jan 2022 06:08:27 -0800 (PST)
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com. [209.85.167.47])
        by smtp.gmail.com with ESMTPSA id bp40sm2028003lfb.136.2022.01.19.06.08.27
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Jan 2022 06:08:27 -0800 (PST)
Received: by mail-lf1-f47.google.com with SMTP id p27so9947175lfa.1
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jan 2022 06:08:27 -0800 (PST)
X-Received: by 2002:adf:c74e:: with SMTP id b14mr29011574wrh.97.1642600880273;
 Wed, 19 Jan 2022 06:01:20 -0800 (PST)
MIME-Version: 1.0
References: <20220119110839.33187-1-deller@gmx.de> <20220119110839.33187-3-deller@gmx.de>
 <Yef0j8+DBbwC7Kjv@kroah.com> <Yef15k2GtC40aJEu@kroah.com> <CAMuHMdVWFJEDwjf-htZ_D1484efmuPnz_L-qhcTeUE-GVpvZXA@mail.gmail.com>
 <4d8950c7-5f51-ca2b-4c93-741c7805a214@gmx.de>
In-Reply-To: <4d8950c7-5f51-ca2b-4c93-741c7805a214@gmx.de>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 19 Jan 2022 16:01:01 +0200
X-Gmail-Original-Message-ID: <CAHk-=wikFKjwdUBWCLCu=iL3rFq4BDDF0aBGdXC6ay74yJb+5Q@mail.gmail.com>
Message-ID: <CAHk-=wikFKjwdUBWCLCu=iL3rFq4BDDF0aBGdXC6ay74yJb+5Q@mail.gmail.com>
Subject: Re: [PATCH 2/2] Revert "fbcon: Disable accelerated scrolling"
To:     Helge Deller <deller@gmx.de>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
        Sven Schnelle <svens@stackframe.org>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Ilia Mirkin <imirkin@alum.mit.edu>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Pavel Machek <pavel@ucw.cz>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Sam Ravnborg <sam@ravnborg.org>, Claudio Suarez <cssk@net-c.es>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 19, 2022 at 2:29 PM Helge Deller <deller@gmx.de> wrote:
>
> >>
> >> Ah, no, that was just the soft scrollback code I was thinking of, which
>
> Right.
> That was commit 973c096f6a85 and it was about vgacon, not fbcon.

No, fbcon had some bug too, although I've paged out the details. See
commit 50145474f6ef ("fbcon: remove soft scrollback code").

If I remember correctly (and it's entirely possible that I don't), the
whole "softback_lines" logic had serious problems with resizing the
console (or maybe changing the font size).

There may have been some other bad interaction with
foreground/background consoles too, I forget.

       Linus
