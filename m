Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E757949CC4F
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 15:28:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242117AbiAZO2f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 09:28:35 -0500
Received: from mail-ua1-f52.google.com ([209.85.222.52]:36761 "EHLO
        mail-ua1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235227AbiAZO2d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 09:28:33 -0500
Received: by mail-ua1-f52.google.com with SMTP id u76so997889uau.3;
        Wed, 26 Jan 2022 06:28:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fHOCyGn2OpYXHR2TSZ46or0oGciq1pUeUpvpqS2jqZ4=;
        b=UYHpym5bUkuaL5ajYIN4b8oqcDtSlIiCZON6fyH/cFdovh45eLS6+97IL5An9SIi70
         cJ7dZBoaN4QxryNm195m5cB+GIxWbYr/1Oi5fUaq4mYSzIt4LfM4BezLslhFmPE9arSk
         O0CVZFKHka1R2iTgXdN8llQ/7ZKEIdWVeodIFoUfaJ1qOhhEDrvTm6yP39IEtKlH+V05
         hHHEQEx40pAvLcXBnxRzwsSDi3RLkDJse66u9n7YRgZfHLp0lCfOnDd9cN+t14Og37w4
         5nTDdVgzfe+YHpr1SVMjikj1DzpvfuVWjYlh1kB3Ueyk6toli4h39qAZxtjDw6Dxw2Df
         OyZg==
X-Gm-Message-State: AOAM531rNpAJA6DsxeeBaVi6nZYuUltj9Ty0Uf+T+E6+RASSJ7f8Dbpv
        d+68Z7r5Bo4NmL5i3jPfwgI7K/5FmSII3jla
X-Google-Smtp-Source: ABdhPJyH+wwZTJYgXdyeQ8sNOGfFahsRS1Qi8pJVSdepkUTEGLhbpsqkuFVwp376gj7HyGFsUkthNw==
X-Received: by 2002:a9f:21ef:: with SMTP id 102mr9066965uac.53.1643207312631;
        Wed, 26 Jan 2022 06:28:32 -0800 (PST)
Received: from mail-ua1-f41.google.com (mail-ua1-f41.google.com. [209.85.222.41])
        by smtp.gmail.com with ESMTPSA id x18sm2514886vsj.20.2022.01.26.06.28.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Jan 2022 06:28:32 -0800 (PST)
Received: by mail-ua1-f41.google.com with SMTP id m90so43277206uam.2;
        Wed, 26 Jan 2022 06:28:32 -0800 (PST)
X-Received: by 2002:a05:6102:34e:: with SMTP id e14mr2620287vsa.68.1643207311974;
 Wed, 26 Jan 2022 06:28:31 -0800 (PST)
MIME-Version: 1.0
References: <cover.1643110442.git.linux@leemhuis.info> <f97738d6250050bc982bf2947587f1c73f37446f.1643110442.git.linux@leemhuis.info>
In-Reply-To: <f97738d6250050bc982bf2947587f1c73f37446f.1643110442.git.linux@leemhuis.info>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 26 Jan 2022 15:28:20 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXRoVt_zRBNvugJjYhJnyYbABeCWv9fFRM0r_=s7FYvJQ@mail.gmail.com>
Message-ID: <CAMuHMdXRoVt_zRBNvugJjYhJnyYbABeCWv9fFRM0r_=s7FYvJQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] docs: add a document about regression handling
To:     Thorsten Leemhuis <linux@leemhuis.info>
Cc:     "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        workflows@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Randy Dunlap <rdunlap@infradead.org>,
        regressions@lists.linux.dev,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thorsten,

On Tue, Jan 25, 2022 at 5:45 PM Thorsten Leemhuis <linux@leemhuis.info> wrote:
> +How to create a configuration similar to the one of an older kernel?
> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> +
> +Start a known-good kernel and configure the newer Linux version with ``make
> +olddefconfig``. This makes the kernel's build scripts pick up the configuration
> +file (the `.config` file) from the running kernel as base for the new one you
> +are about to compile; afterwards they set all new configuration options to their
> +default value, which should disable new features that might cause regressions.

Doing so may actually cause mutations to appear in your .config
when going back and forth (i.e. when bisecting), interfering with
the bisection process.

To avoid that, I usually start bisecting with
"cp .config <src>/arch/<arch>/configs/bisect_defconfig", and use
"make bisect_defconfig" in every bisection step. That way all steps
are reproducible, and unaffected by config mutations.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
