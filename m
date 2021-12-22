Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1D2747D011
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 11:35:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244191AbhLVKfW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 05:35:22 -0500
Received: from mail-ua1-f45.google.com ([209.85.222.45]:44644 "EHLO
        mail-ua1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235010AbhLVKfU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 05:35:20 -0500
Received: by mail-ua1-f45.google.com with SMTP id p2so3310148uad.11;
        Wed, 22 Dec 2021 02:35:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=tJHsO1CPR86g4ZVABNb9iD5HZmxEZzUjMpHV/X84Gu4=;
        b=XVFmQQpVmGmCfVsn3N+HEw2HVqhUMh6AODPs10xWRjTpktt8som7dsa3zGyxwBYNJo
         fnDSoHIjrqC7dV+6lybq9o2oRugA/GIzS6AIekupuJgzEs51QCQHykdSR9YdkNBgPZUL
         GpmrE5Tmb08iV8i/Z0hmQ0lRhUeM0bptFR6muzHC2S+xhtXYJVZtqwvVsdb9tGLRUVYT
         DnMsWV112mVZckodAd8h79ATSyY6MTL1MEm7GEpGPSY0hVkM55YuepYRKUjPSQcOrg3Y
         X7T2Ox4Kt9/JdjBT7YyerT/1+r/oVLaz+CXcMAHKjMRsCH/TUWq7IAR3+hz6h48BlOyV
         29/Q==
X-Gm-Message-State: AOAM530rE0S+DAUNDmC3Uue3Je9wSTqrhtem+CWxf+SnklY2cM+2QxG3
        3S+hXArN145Z6Tkp2J5mFr26cBdi31Qyug==
X-Google-Smtp-Source: ABdhPJyUwtfzU713iGgkSfrVVb5TQNjGDS7ve23BeKmhwwz4hJY/4ROqLO1UooQe+g6t1ewg6wFURw==
X-Received: by 2002:a05:6102:559e:: with SMTP id dc30mr380679vsb.37.1640169319799;
        Wed, 22 Dec 2021 02:35:19 -0800 (PST)
Received: from mail-ua1-f44.google.com (mail-ua1-f44.google.com. [209.85.222.44])
        by smtp.gmail.com with ESMTPSA id q5sm295488vsl.10.2021.12.22.02.35.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Dec 2021 02:35:19 -0800 (PST)
Received: by mail-ua1-f44.google.com with SMTP id i6so3349295uae.6;
        Wed, 22 Dec 2021 02:35:19 -0800 (PST)
X-Received: by 2002:a05:6102:2329:: with SMTP id b9mr705647vsa.5.1640169319253;
 Wed, 22 Dec 2021 02:35:19 -0800 (PST)
MIME-Version: 1.0
References: <20211219132442.4080-1-wsa+renesas@sang-engineering.com>
 <20211219132442.4080-2-wsa+renesas@sang-engineering.com> <CAMuHMdVh60ocfzkJKz8zR1hODr8SWp=sbyHrR3KGx2ntLmuFGQ@mail.gmail.com>
 <YcL7p5nzZs8vnojl@shikoro>
In-Reply-To: <YcL7p5nzZs8vnojl@shikoro>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 22 Dec 2021 11:35:08 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXn-cmK1HewukjOnjC1JEgfFfH7FW23YvPTKHcNCiet2w@mail.gmail.com>
Message-ID: <CAMuHMdXn-cmK1HewukjOnjC1JEgfFfH7FW23YvPTKHcNCiet2w@mail.gmail.com>
Subject: Re: [PATCH v6 1/1] gpio: add sloppy logic analyzer using polling
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Wolfram,

On Wed, Dec 22, 2021 at 11:19 AM Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:
> > Anyone with a clue? Thanks!
>
> Yes, the search engines helped[1]. I run a minimal system, so when I
> mount cpusets, it will actually mount cgroups with a default mount
> option of "noprefix". But you likely run a rootfs with cgroups already,
> so it gets mounted directly without "noprefix". Then, when the logic
> analyzer tries to mount again, the implied default "noprefix" is
> discarded.

Yeah, systemd on Debian has it mounted.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
