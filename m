Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD187493AA0
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 13:47:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349746AbiASMqK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 07:46:10 -0500
Received: from mail-ua1-f47.google.com ([209.85.222.47]:40756 "EHLO
        mail-ua1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245463AbiASMqH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 07:46:07 -0500
Received: by mail-ua1-f47.google.com with SMTP id w21so4222273uan.7;
        Wed, 19 Jan 2022 04:46:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jSJaWLFbSmKDo2PDFLJ/OlDDjxv/sePlYig27gKKORM=;
        b=3u7mBhgt4YNpY8+GLAA3HgafJhumKwn/Ezbwe1mi2JXqzneBntTFm2v4wsKncJyrBg
         JXhxSaCN8J1Imv/b2zjhELBY6dw5XxArAK5hdm1JERlR4JOUpCzu76AEdfKVMXGJNom5
         ADZD3jB4IDLh9cQM2ONdzosGrcjRkXzS1ILZFKxW/eiGdqciOI93/sM3F2MEcGvSBn83
         UW+OgwXP7n2OxAkTugcub1pmE6HECaEDroSHpSui3f+g2W80X1AgANRv06N+Nhi3i/6c
         +kW/q5Ux/RoG0w3liBbV4dvVlWsVn76Z43TIwtrkM/JU+0lvS00h1WL0VRrGsdIx2sfJ
         /swQ==
X-Gm-Message-State: AOAM530+k0Wk1vPcmpJz22UslLn4Idt56zDUD4gvokW+E7S74AV1nOOa
        kW/FlIl7OlAr0kIMZ2qVc9dDH+mFw0bTig==
X-Google-Smtp-Source: ABdhPJxgr0MrFCoZkDTidnW4zpKhPY5nlGmAJKRr85MEKl8yXKrsd4U82JVD9D0ezLjK2BOLByjuBg==
X-Received: by 2002:a67:d315:: with SMTP id a21mr11100069vsj.51.1642596366888;
        Wed, 19 Jan 2022 04:46:06 -0800 (PST)
Received: from mail-ua1-f46.google.com (mail-ua1-f46.google.com. [209.85.222.46])
        by smtp.gmail.com with ESMTPSA id k5sm2243920vsc.14.2022.01.19.04.46.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Jan 2022 04:46:05 -0800 (PST)
Received: by mail-ua1-f46.google.com with SMTP id m90so4279777uam.2;
        Wed, 19 Jan 2022 04:46:04 -0800 (PST)
X-Received: by 2002:a9f:3e01:: with SMTP id o1mr11968203uai.89.1642596364458;
 Wed, 19 Jan 2022 04:46:04 -0800 (PST)
MIME-Version: 1.0
References: <20220119110839.33187-1-deller@gmx.de>
In-Reply-To: <20220119110839.33187-1-deller@gmx.de>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 19 Jan 2022 13:45:53 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXj2WsQ2htP63vXD_PRuhrqry3GgD8U1tJQ99BkQPQL=w@mail.gmail.com>
Message-ID: <CAMuHMdXj2WsQ2htP63vXD_PRuhrqry3GgD8U1tJQ99BkQPQL=w@mail.gmail.com>
Subject: Re: [PATCH 0/2] Fix regression introduced by disabling accelerated
 scrolling in fbcon
To:     Helge Deller <deller@gmx.de>
Cc:     Thomas Zimmermann <tzimmermann@suse.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
        Sven Schnelle <svens@stackframe.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
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

Hi Helge,

On Wed, Jan 19, 2022 at 12:10 PM Helge Deller <deller@gmx.de> wrote:
> This series reverts two patches which disabled scrolling acceleration in
> fbcon/fbdev. Those patches introduced a regression for fbdev-supported graphic
> cards because of the performance penalty by doing screen scrolling by software
> instead of using hardware acceleration.
>
> Console scrolling acceleration was disabled by dropping code which checked at
> runtime the driver hardware possibilities for the BINFO_HWACCEL_COPYAREA or
> FBINFO_HWACCEL_FILLRECT flags and if set, it enabled scrollmode SCROLL_MOVE
> which uses hardware acceleration to move screen contents.  After dropping those
> checks scrollmode was hard-wired to SCROLL_REDRAW instead, which forces all
> graphic cards to redraw every character at the new screen position when
> scrolling.
>
> This change effectively disabled all hardware-based scrolling acceleration for
> ALL drivers, because now all kind of 2D hardware acceleration (bitblt,
> fillrect) in the drivers isn't used any longer.
>
> The original commit message mentions that only 3 DRM drivers (nouveau, omapdrm
> and gma500) used hardware acceleration in the past and thus code for checking
> and using scrolling acceleration is obsolete.
>
> This statement is NOT TRUE, because beside the DRM drivers there are around 35
> other fbdev drivers which depend on fbdev/fbcon and still provide hardware
> acceleration for fbdev/fbcon.
>
> The original commit message also states that syzbot found lots of bugs in fbcon
> and thus it's "often the solution to just delete code and remove features".
> This is true, and the bugs - which actually affected all users of fbcon,
> including DRM - were fixed, or code was dropped like e.g. the support for
> software scrollback in vgacon (commit 973c096f6a85).
>
> So to further analyze which bugs were found by syzbot, I've looked through all
> patches in drivers/video which were tagged with syzbot or syzkaller back to
> year 2005. The vast majority fixed the reported issues on a higher level, e.g.
> when screen is to be resized, or when font size is to be changed. The few ones
> which touched driver code fixed a real driver bug, e.g. by adding a check.
>
> But NONE of those patches touched code of either the SCROLL_MOVE or the
> SCROLL_REDRAW case.
>
> That means, there was no real reason why SCROLL_MOVE had to be ripped-out and
> just SCROLL_REDRAW had to be used instead. The only reason I can imagine so far
> was that SCROLL_MOVE wasn't used by DRM and as such it was assumed that it
> could go away. That argument completely missed the fact that SCROLL_MOVE is
> still heavily used by fbdev (non-DRM) drivers.
>
> Some people mention that using memcpy() instead of the hardware acceleration is
> pretty much the same speed. But that's not true, at least not for older graphic
> cards and machines where we see speed decreases by factor 10 and more and thus
> this change leads to console responsiveness way worse than before.
>
> That's why I propose to revert those patches, re-introduce hardware-based
> scrolling acceleration and fix the performance-regression for fbdev drivers.
> There isn't any impact on DRM when reverting those patches.
>
> Helge Deller (2):
>   Revert "fbdev: Garbage collect fbdev scrolling acceleration, part 1
>     (from TODO list)"
>   Revert "fbcon: Disable accelerated scrolling"

Thank you for this series, and the prior analysis!

Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
