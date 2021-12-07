Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D13D46AF59
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 01:46:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378774AbhLGAuY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 19:50:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378760AbhLGAuX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 19:50:23 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BC65C061746
        for <linux-kernel@vger.kernel.org>; Mon,  6 Dec 2021 16:46:54 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id y12so49826594eda.12
        for <linux-kernel@vger.kernel.org>; Mon, 06 Dec 2021 16:46:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ghJHWYSCcNcRbUDIWR/w8CYgi8aCIw7xmUlHWMHylB8=;
        b=Ksm5N2TLcrb0SnNLGmOkVK9GpV44Fz1hZS0ozyA93fTibec6ce0+k1rxecvDGBApDw
         hzban1yEVA2Qor7uu6pNRdp4giVaJlaKXII6Tv3wSQDT71ApwB3/4Z3FxfsF7eA0bt4c
         BhzgKPUZYo+8TY3H9pVOfmSsyrLoxEl6bQrrw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ghJHWYSCcNcRbUDIWR/w8CYgi8aCIw7xmUlHWMHylB8=;
        b=roMDOvY6pMi8Um5V7Z7PpXNYxU0iI9qYk5aNYedXkFIxk3dIVJ1sPkRa0+RinROdyK
         //ZmZJ8oqJ7DJi4dbPv8OJo+KmAF8TRSKTL+i50tnZQKwCrqjrgbgnr/mC+tGM74/7Gv
         nVvmrMp1BL1O+h4V7+4pW12FbLyrJLlC1vgKf7hjH+x6lA+R/uvARBTVW5vhME9qSdpx
         0y7IVxsey7qTbMe7K/MMJdNlyFmh+MNNM+0zt5f66/PPAHaLPr7Z592qaFum0nVY7jme
         zks/tR0j0d6Nw/QxM/fblugME2cfvvA970xBkkIdPFK9sZIT2hJ8TK0UIkmnp/tp66cs
         dWcg==
X-Gm-Message-State: AOAM531XiYh/3TYllGXPldzA9faAn8v1aa078z5QuT38rME2TMNA+L74
        ib/0RA1JzKsotlFmjMcEw/Xti4B8QxOp+DLp
X-Google-Smtp-Source: ABdhPJxSw/KJ0zsWFY0GynGTN36tClK3wBjjE1aZaiF4oqdScx6sRF6v9oRDlRT/A0UEwWIL0mfGhQ==
X-Received: by 2002:a17:906:9b8f:: with SMTP id dd15mr47450216ejc.480.1638838012385;
        Mon, 06 Dec 2021 16:46:52 -0800 (PST)
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com. [209.85.128.54])
        by smtp.gmail.com with ESMTPSA id d3sm8952313edx.79.2021.12.06.16.46.51
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Dec 2021 16:46:51 -0800 (PST)
Received: by mail-wm1-f54.google.com with SMTP id o19-20020a1c7513000000b0033a93202467so1044721wmc.2
        for <linux-kernel@vger.kernel.org>; Mon, 06 Dec 2021 16:46:51 -0800 (PST)
X-Received: by 2002:a05:600c:1914:: with SMTP id j20mr2641508wmq.26.1638838011435;
 Mon, 06 Dec 2021 16:46:51 -0800 (PST)
MIME-Version: 1.0
References: <YatpectAYsWnmPy2@eldamar.lan> <CAHk-=whTTWUyL5j5_-UeRT6k9VcJM_VOfjiKuU2NBJkxhbnXpw@mail.gmail.com>
 <CAK7LNAR-VXwHFEJqCcrFDZj+_4+Xd6oynbj_0eS8N504_ydmyw@mail.gmail.com>
 <202112061128.6B670358@keescook> <Ya6IXWBGkN1iZI1b@eldamar.lan>
In-Reply-To: <Ya6IXWBGkN1iZI1b@eldamar.lan>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 6 Dec 2021 16:46:35 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjBp3qpx=wehDZijejFBPixV=yVQVrPqK8saSEwGVrfAQ@mail.gmail.com>
Message-ID: <CAHk-=wjBp3qpx=wehDZijejFBPixV=yVQVrPqK8saSEwGVrfAQ@mail.gmail.com>
Subject: Re: Makefile: CC_IMPLICIT_FALLTHROUGH passed quoted as argument to gcc
To:     Salvatore Bonaccorso <carnil@debian.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 6, 2021 at 2:02 PM Salvatore Bonaccorso <carnil@debian.org> wrote:
>
> Does the following look correct, as well from formal style/commit
> description? I have not yet done many contributions directly.

Thanks, looks good, applied.

Hopefully we'll get this cleaned up at a Kconfig level at some point,
but at least this avoids the external build environment issue for now.

             Linus
