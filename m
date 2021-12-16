Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E45EB477380
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 14:47:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234549AbhLPNrw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 08:47:52 -0500
Received: from mail-vk1-f170.google.com ([209.85.221.170]:38486 "EHLO
        mail-vk1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229917AbhLPNrv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 08:47:51 -0500
Received: by mail-vk1-f170.google.com with SMTP id m185so1855009vkm.5;
        Thu, 16 Dec 2021 05:47:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4uF+gM1G86VM+Kpj4DovgZM1B/9K1RNtYVUSewjskIc=;
        b=QYi/6Q0A+gM1HMIOvvTna4FBLmOWXKjBwoxZMS30eYbO0S7bWquNGuKm4CcSWMegeD
         i9znRxDD/unYY2C0qno6EWaiIyJ3NHocspfF8VoXJS9SMxlja+KMB2YxFxATpEAi6Dy1
         d1uv7zluCGIBB5+PR0HAzKUEkBu3dMKo7p119FtYw7WSsu1EF1n704MAw/paGvfxHL0j
         F5e0D8eUQdl7boA+5N//rsNF/9Bh9GjfCB2foX2IExNvYQj3/3C2K8r9P8MsyaQWdub8
         SohYjdrtmRvx6FmgWDvY+sOgW9izhHvySFOTeclI0islDPbb96YM82NYk0Ha6kDrfuB2
         DwQg==
X-Gm-Message-State: AOAM532mIEZiimfoYpdvtvWyrOh79qOTA7kq5VB4Jc9FprqflbVOgHUo
        SqxqO7DouOuuIRfuyg8HOUWiSwcPQ3+OPg==
X-Google-Smtp-Source: ABdhPJx1ZE/TdFDfkQZWwh9QCR5wLHwfMqfEsKxFJ8pVZ1Ihl3KK+8xsDog68Nx/FKsg1300ArWn0w==
X-Received: by 2002:a1f:2bc7:: with SMTP id r190mr95399vkr.16.1639662470271;
        Thu, 16 Dec 2021 05:47:50 -0800 (PST)
Received: from mail-ua1-f53.google.com (mail-ua1-f53.google.com. [209.85.222.53])
        by smtp.gmail.com with ESMTPSA id i24sm1107322vkk.5.2021.12.16.05.47.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Dec 2021 05:47:49 -0800 (PST)
Received: by mail-ua1-f53.google.com with SMTP id y23so5499801uay.7;
        Thu, 16 Dec 2021 05:47:48 -0800 (PST)
X-Received: by 2002:a05:6102:e10:: with SMTP id o16mr5543879vst.5.1639662468579;
 Thu, 16 Dec 2021 05:47:48 -0800 (PST)
MIME-Version: 1.0
References: <cover.1639662093.git.geert@linux-m68k.org> <20211208104026.421-1-biju.das.jz@bp.renesas.com>
In-Reply-To: <20211208104026.421-1-biju.das.jz@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 16 Dec 2021 14:47:37 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVL=dSku5MU5PjRz4owdb5ZOiWb3rymZxZ_TLVNhSwLkg@mail.gmail.com>
Message-ID: <CAMuHMdVL=dSku5MU5PjRz4owdb5ZOiWb3rymZxZ_TLVNhSwLkg@mail.gmail.com>
Subject: Re: [PATCH v3 0/3] Add Mali-G31 GPU support for RZ/G2L SoC
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Anup Patel <anup.patel@wdc.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>,
        Steven Price <steven.price@arm.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 16, 2021 at 2:44 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> From: Biju Das <biju.das.jz@bp.renesas.com>
>
> RZ/G2L SoC embeds Mali-G31 bifrost GPU.
> This patch series aims to add support for the same

Oops, please ignore this email. Sorry for the noise.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
