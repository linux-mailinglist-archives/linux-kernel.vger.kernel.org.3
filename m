Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B1BF47737B
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 14:47:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234488AbhLPNrg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 08:47:36 -0500
Received: from mail-ua1-f53.google.com ([209.85.222.53]:46714 "EHLO
        mail-ua1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234345AbhLPNrf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 08:47:35 -0500
Received: by mail-ua1-f53.google.com with SMTP id 30so47212200uag.13;
        Thu, 16 Dec 2021 05:47:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+iBZapDL2eyvVMkB+C0NRFzbY4IahVxxfAnthP7sPxY=;
        b=0NIS0CIY+U8mRXQxDHdkR1qmwGmM0r+q5/UgdoQXIJztbtOhw859T7SNFnrTXU7HSq
         8VZ62Rs2fed2diwWZK+Ul05gqdSAP1SiKlhsKNxqC5IVH4zfmh6e9ZkXXBkVx0RpUHVC
         r5iNfJHVFHeUArNY20YtIKt508GtX6IqWVNwtskHvm57cmsbXqgyMn8+YzpfUBGQM86X
         UWKR+Mu+n88rQhygZGrtJC0F0h+f2ocxrzVkfJQ7JTmLFP+199ymxnPiEI4Rn3NKfRc6
         rcO34jsv8a8V/04qNUhM6ML66kJ/dqHzNxTG745xXsQAYoOqDETEpzQIZYq0wNnn+v2u
         BRDg==
X-Gm-Message-State: AOAM531zc12J0s5HCNGK9HJl0iU21q4/GTHnSsSbenxr62kHIh+IoUWP
        KZvwmUspv2HU0KSak65YTs+hNook7f0H5w==
X-Google-Smtp-Source: ABdhPJyG3iN6da2X9tsuGzQtUXqFm4rq8mz5vLhMsvvj6mQebGu5msUULXe1Dinjo5idfR26vRguYw==
X-Received: by 2002:a67:7141:: with SMTP id m62mr5701878vsc.7.1639662453935;
        Thu, 16 Dec 2021 05:47:33 -0800 (PST)
Received: from mail-ua1-f50.google.com (mail-ua1-f50.google.com. [209.85.222.50])
        by smtp.gmail.com with ESMTPSA id v7sm1059832uaj.13.2021.12.16.05.47.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Dec 2021 05:47:33 -0800 (PST)
Received: by mail-ua1-f50.google.com with SMTP id y22so11261938uap.2;
        Thu, 16 Dec 2021 05:47:32 -0800 (PST)
X-Received: by 2002:a67:c106:: with SMTP id d6mr5231958vsj.77.1639662451912;
 Thu, 16 Dec 2021 05:47:31 -0800 (PST)
MIME-Version: 1.0
References: <cover.1639661878.git.geert@linux-m68k.org> <20211208104026.421-1-biju.das.jz@bp.renesas.com>
In-Reply-To: <20211208104026.421-1-biju.das.jz@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 16 Dec 2021 14:47:20 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUambn+yZu0Nnc9G1ErVRR4cfjC7AHfs139GZAW1GBqjw@mail.gmail.com>
Message-ID: <CAMuHMdUambn+yZu0Nnc9G1ErVRR4cfjC7AHfs139GZAW1GBqjw@mail.gmail.com>
Subject: Re: [PATCH v3 0/3] Add Mali-G31 GPU support for RZ/G2L SoC
To:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Sagar Kadam <sagar.kadam@sifive.com>,
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

On Thu, Dec 16, 2021 at 2:41 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
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
