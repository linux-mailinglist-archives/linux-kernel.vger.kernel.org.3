Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3292B48EC07
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 15:52:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242064AbiANOwo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jan 2022 09:52:44 -0500
Received: from mail-vk1-f178.google.com ([209.85.221.178]:35803 "EHLO
        mail-vk1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237563AbiANOwm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jan 2022 09:52:42 -0500
Received: by mail-vk1-f178.google.com with SMTP id 19so5978315vkl.2
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jan 2022 06:52:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3QRaBnJTvGqh7hLfXU44RUcKijdj4LoBD709NrcoVmE=;
        b=MC8VBMVCwFQubYVSl/thYybVTS0vJzT/vZla03lOFn9M1IjogBSwn81jUBTwuKrFjA
         QAN5Hkr4mDozw67iBTK8/o08qyhtecK4xsMGs1ayDSElUjE+4IcYscTs2PhNtOZnxcTn
         8WNMxj5RqvoBulZEE1VD4rp7lBGClfhtuaRMbF4MlOgmmnx1x499hPV4WYM2qmm5oH4I
         P/aoaSuRZXz+d7nwhsobhAU3SC8wd4xSEqbApri9zK1HcboUL779wc7Xdg8/Ou9EWyFZ
         Q1S8jdXrK5osh8i+pCgsi8Hiu2Z7mW/4cI20jfxm9ukLxd/dSzYFlqo4U+baOpG3Ku1A
         4Amg==
X-Gm-Message-State: AOAM530dKJ34uemIE0coLqAn+AorJnykTkGUJyVto9zdbvQEyIAkzKnG
        oEBz7OTnWpFkKJZcAb/TXDW3f9Ez/zwfE26e
X-Google-Smtp-Source: ABdhPJyESelLZoscq737/y1Zj/oLS/YyDxrVAuya3Z6dUs5nmY0OLK/Ehlm0CRd21Y3JJTQmKfez7Q==
X-Received: by 2002:a05:6122:2027:: with SMTP id l39mr3036972vkd.32.1642171962108;
        Fri, 14 Jan 2022 06:52:42 -0800 (PST)
Received: from mail-ua1-f48.google.com (mail-ua1-f48.google.com. [209.85.222.48])
        by smtp.gmail.com with ESMTPSA id b14sm2063173vkk.22.2022.01.14.06.52.41
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Jan 2022 06:52:41 -0800 (PST)
Received: by mail-ua1-f48.google.com with SMTP id p1so17303867uap.9
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jan 2022 06:52:41 -0800 (PST)
X-Received: by 2002:a05:6102:3581:: with SMTP id h1mr4118256vsu.5.1642171960897;
 Fri, 14 Jan 2022 06:52:40 -0800 (PST)
MIME-Version: 1.0
References: <20220113160115.5375-1-bp@alien8.de> <YeBzxuO0wLn/B2Ew@mit.edu> <YeCuNapJLK4M5sat@zn.tnic>
In-Reply-To: <YeCuNapJLK4M5sat@zn.tnic>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 14 Jan 2022 15:52:29 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUbTNNr16YY1TFe=-uRLjg6yGzgw_RqtAFpyhnOMM5Pvw@mail.gmail.com>
Message-ID: <CAMuHMdUbTNNr16YY1TFe=-uRLjg6yGzgw_RqtAFpyhnOMM5Pvw@mail.gmail.com>
Subject: Re: [PATCH] x86: Remove a.out support
To:     Borislav Petkov <bp@alien8.de>
Cc:     "Theodore Ts'o" <tytso@mit.edu>, X86 ML <x86@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Eric Biederman <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Boris,

On Fri, Jan 14, 2022 at 3:36 PM Borislav Petkov <bp@alien8.de> wrote:
> Btw, pls do note that this is removing only the x86 a.out support -
> other arches (m68k and alpha) still select HAVE_AOUT and thus the
> respective glue in fs/binfmt_aout.c

Quoting myself (do I need a canned response for this? ;-):
   "I think it's safe to assume no one still runs a.out binaries on m68k."

https://lore.kernel.org/r/CAMuHMdVGT1QN8WUqNcU8ihPLncUGfrjV49wb-8nHUgHhOzLeNw@mail.gmail.com/
https://lore.kernel.org/r/CAMuHMdW+m0Q+j3rsQdMXnrEPm+XB5Y2AQrxW5sD1mZAKgmEqoA@mail.gmail.com

Of course, m68k is not encumbered by a.out Netscape binaries, unlike
ia32 and alpha ;-)

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
