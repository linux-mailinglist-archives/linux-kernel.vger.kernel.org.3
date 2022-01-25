Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7491149AE1A
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 09:36:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348820AbiAYIgG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 03:36:06 -0500
Received: from mail-ua1-f46.google.com ([209.85.222.46]:43557 "EHLO
        mail-ua1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378716AbiAYIbL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 03:31:11 -0500
Received: by mail-ua1-f46.google.com with SMTP id 2so36010766uax.10;
        Tue, 25 Jan 2022 00:31:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pLI0NpGLcGeDoF34x+JYc6mPOV18pDeJSnyNKlPba8Q=;
        b=TMLwVV3hrUCluoGXaXVhrftAQcy+sXzBTmpRQCwigyQkH8S+uHsf6cTAs3/a/1WCOo
         vIl60cYJltLZHUV96I2BxgDFNS7bAGnG6kmPmoHG+jttawGBfaztS2V0rmSYvAIie9B1
         qVn6NY5if9Tp8sBZSlborqZOrkMz68eB3PwrVp5dcNscD2TeOBIM/6OQR2t0jqD06eU7
         /GxeYk0uNmBMhdnU3da0AqSJjg84noKvvdiqBaCgIavVrCRUW+qtFMDqGUfrXxh/12xA
         tweUQ8X+UPumZY77H+vmJ3EKLAD7QNOjsZpG9G+5QAs0K2s4mtleRW0QnLCmNq8CTzWR
         zXhA==
X-Gm-Message-State: AOAM53206UPQ4h0dzez1vtZ0JiXeBL/WiwIjn4UiqH58qBVaTzKrXp4i
        OEcMUz8ZyQEIW0iHR6Isg1PnsZpx2IZBbw==
X-Google-Smtp-Source: ABdhPJxpjdJDribpVcDra03EIq7OWZb34v9lo+Fpl8H3H3jYQcXcl13zKthK6guNb3KUbZMEwF79qQ==
X-Received: by 2002:a67:a642:: with SMTP id r2mr6980301vsh.36.1643099468907;
        Tue, 25 Jan 2022 00:31:08 -0800 (PST)
Received: from mail-ua1-f43.google.com (mail-ua1-f43.google.com. [209.85.222.43])
        by smtp.gmail.com with ESMTPSA id o131sm3283974vkc.42.2022.01.25.00.31.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Jan 2022 00:31:08 -0800 (PST)
Received: by mail-ua1-f43.google.com with SMTP id b16so35995215uaq.4;
        Tue, 25 Jan 2022 00:31:08 -0800 (PST)
X-Received: by 2002:a67:c18e:: with SMTP id h14mr3289857vsj.5.1643099467906;
 Tue, 25 Jan 2022 00:31:07 -0800 (PST)
MIME-Version: 1.0
References: <20220124210319.325512-1-deller@gmx.de>
In-Reply-To: <20220124210319.325512-1-deller@gmx.de>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 25 Jan 2022 09:30:56 +0100
X-Gmail-Original-Message-ID: <CAMuHMdU5m2z1FmYi2-+rwpr4xc8F_V4TivKcddzA6oVReUijOQ@mail.gmail.com>
Message-ID: <CAMuHMdU5m2z1FmYi2-+rwpr4xc8F_V4TivKcddzA6oVReUijOQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] Fix regression introduced by disabling accelerated
 scrolling in fbcon
To:     Helge Deller <deller@gmx.de>
Cc:     DRI Development <dri-devel@lists.freedesktop.org>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Sven Schnelle <svens@stackframe.org>,
        Claudio Suarez <cssk@net-c.es>, Pavel Machek <pavel@ucw.cz>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Ilia Mirkin <imirkin@alum.mit.edu>,
        Sam Ravnborg <sam@ravnborg.org>,
        Daniel Vetter <daniel.vetter@intel.com>,
        regressions@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cc regressions

On Mon, Jan 24, 2022 at 10:04 PM Helge Deller <deller@gmx.de> wrote:
> This series reverts two patches which disabled scrolling acceleration in
> fbcon/fbdev. Those patches introduced a regression for fbdev-supported graphic
> cards because of the performance penalty by doing screen scrolling by software
> instead of using existing 2D hardware acceleration.

In the mean time, a userspace regression has been reported, too:
https://lwn.net/Articles/882054/
https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=988039

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
