Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61D16476E7E
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 11:05:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233628AbhLPKFe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 05:05:34 -0500
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:51126
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233509AbhLPKFa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 05:05:30 -0500
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com [209.85.208.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 923D13F1F6
        for <linux-kernel@vger.kernel.org>; Thu, 16 Dec 2021 10:05:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1639649129;
        bh=iEjFNSHMwi4aeXpe7cQghYno80kPHKULcTC4SGtg0Js=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=nwHvRMuRraIbskS8YaDIW1RjDuNlMdsvKpV7Aa/0en9awLxx31ImhnZrDXn6D2tNo
         jk9NGEeH22SzMnxaqeXVLCWlWWwk4+m6N/Vw2+NMP5MMAUNpUtUE78UILvnxXunbuC
         lAL+cTQ8x5serNaTA+Et7Srx64YQZjUXAnG0r5oYxoMrLpnm8qFhM05/2zCaarGyMo
         7GzxaIw6dHchTLh70rHv8ruDIhwKZO1/E+c3kc0GZNS4CrxOi7G9+r4IXQ9l7c8R2t
         DWjLIT5oX5kIBvEa0FCN5v4w9zkFsISXm1SHlFD35K0UsQb/FgpD3V5HyTRWEELJ4x
         DetXQOY0pQwrg==
Received: by mail-ed1-f69.google.com with SMTP id r26-20020aa7cfda000000b003f7fbbd9b5dso1712295edy.19
        for <linux-kernel@vger.kernel.org>; Thu, 16 Dec 2021 02:05:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iEjFNSHMwi4aeXpe7cQghYno80kPHKULcTC4SGtg0Js=;
        b=4gD3HPgMvgdu0fQJ6T7uYAG198y2FnQgTiNPdRA8jRDgH5jy6RFPr3BU3qvMEhcGsF
         hgwiRAQUbvHNNyzTV02Agilh6CvMYAWtfoVZNIwuV1U39/EvqYwMKBbunHBldVixYZ6G
         AF+YRWASDPX6veGoTopyWYLi6XmSQ3Y2vyXnd5hSkABGYow70SNtPSWkMPeuH2ApQFDZ
         Um+L17JjI9xeIAyTYwesD5pB0uswIYyXAVAIkYe/XX+Yea1pI1rQ7aGCAB9jY6wumqDZ
         lut2LCRR8FAZsmsPjfUQc3Lnw1g7zKuoF0QonS5W0R7nEj99mY7opkD07sEONR8qoH60
         rK0g==
X-Gm-Message-State: AOAM532BXeU1FAV7nQUnkeECsPi2Ib+ml06LRZJnKQep4QkCppKkAbY+
        6BIUkQTalu5iIvJC2uPCaEVS3+utlUyVglZHpMeClRw78vbUN1mMG9TyzLCatDz4h1BlOjZDKhG
        UXlYRzarR7n3HLakzADU5B43RP1Vghqohsj+OWAPymx1ieF4yoYlTfba5Hg==
X-Received: by 2002:a17:906:48d:: with SMTP id f13mr1328921eja.178.1639649129063;
        Thu, 16 Dec 2021 02:05:29 -0800 (PST)
X-Google-Smtp-Source: ABdhPJw4csYse2ts0CIc+GNT8hFD4S36DkgIwbzgfyBzIjr+nwEiJtuY5m75c6D7//m27d8UIPSjBoFZUfOIoRMOvGc=
X-Received: by 2002:a17:906:48d:: with SMTP id f13mr1328883eja.178.1639649128845;
 Thu, 16 Dec 2021 02:05:28 -0800 (PST)
MIME-Version: 1.0
References: <20211105154334.1841927-1-alexandre.ghiti@canonical.com>
 <CAK8P3a2AnLJgGNBFvjUQqXd-Az9vjgE7yJQXGDwCav5E0btSsg@mail.gmail.com>
 <CA+zEjCtajRJhs8zSdR_oFBOO3P5FWWZJ3L6N-GK+JnUjdymTiA@mail.gmail.com> <CAK8P3a3aJJYcONV9JMcn47=mW4P4kvYFdwnTdyZfRqeo+eGndQ@mail.gmail.com>
In-Reply-To: <CAK8P3a3aJJYcONV9JMcn47=mW4P4kvYFdwnTdyZfRqeo+eGndQ@mail.gmail.com>
From:   Alexandre Ghiti <alexandre.ghiti@canonical.com>
Date:   Thu, 16 Dec 2021 11:05:18 +0100
Message-ID: <CA+zEjCu9KmTMpvXkFqgHX0C1jNZKquZU4owZKaJ_-o4+M_7ACg@mail.gmail.com>
Subject: Re: [PATCH 0/7] Cleanup after removal of configs
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Steve French <sfrench@samba.org>, Jonathan Corbet <corbet@lwn.net>,
        David Howells <dhowells@redhat.com>,
        Russell King <linux@armlinux.org.uk>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Lee Jones <lee.jones@linaro.org>,
        Jeff Layton <jlayton@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ronnie Sahlberg <lsahlber@redhat.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kalle Valo <kvalo@codeaurora.org>, linux-cifs@vger.kernel.org,
        samba-technical@lists.samba.org,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-cachefs@redhat.com,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:BROADCOM NVRAM DRIVER" <linux-mips@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Linux-sh list <linux-sh@vger.kernel.org>,
        linux-power@fi.rohmeurope.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 15, 2021 at 10:49 PM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Fri, Dec 10, 2021 at 9:38 PM Alexandre Ghiti
> <alexandre.ghiti@canonical.com> wrote:
> >
> > On Fri, Nov 5, 2021 at 4:56 PM Arnd Bergmann <arnd@arndb.de> wrote:
> > >
> > > On Fri, Nov 5, 2021 at 4:43 PM Alexandre Ghiti
> > > <alexandre.ghiti@canonical.com> wrote:
> > > >
> > > > While bumping from 5.13 to 5.15, I found that a few deleted configs had
> > > > left some pieces here and there: this patchset cleans that.
> > > >
> > > > Alexandre Ghiti (7):
> > > >   Documentation, arch: Remove leftovers from fscache/cachefiles
> > > >     histograms
> > > >   Documentation, arch: Remove leftovers from raw device
> > > >   Documentation, arch: Remove leftovers from CIFS_WEAK_PW_HASH
> > > >   arch: Remove leftovers from mandatory file locking
> > > >   Documentation, arch, fs: Remove leftovers from fscache object list
> > > >   include: mfd: Remove leftovers from bd70528 watchdog
> > > >   arch: Remove leftovers from prism54 wireless driver
> > >
> > > Looks all good to me, thanks a lot for the cleanup!
> > >
> > > For arch/arm/configs:
> > >
> > > Acked-by: Arnd Bergmann <arnd@arndb.de>
> > >
> > > assuming this goes through someone else's tree. Let me know if you need me
> > > to pick up the patches in the asm-generic tree for cross-architecture work.
> >
> > Arnd, do you mind taking the whole series except patch 6 ("include:
> > mfd: Remove leftovers from bd70528 watchdog") as this will be handled
> > separately. I can ask Jonathan for the doc patches if needed.
>
> I tried to apply them, but only three of the patches applied cleanly. Can you
> resend them based on v5.16-rc1?

Sure, I have just sent the v2.

Thanks,

Alex

>
>         Arnd
