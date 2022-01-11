Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0EEAC48B23D
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 17:31:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350020AbiAKQb0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 11:31:26 -0500
Received: from mail-ua1-f44.google.com ([209.85.222.44]:35401 "EHLO
        mail-ua1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350003AbiAKQbS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 11:31:18 -0500
Received: by mail-ua1-f44.google.com with SMTP id m90so15579958uam.2
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jan 2022 08:31:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hBzsLucjMFLkRGvL8/pcBHCnf2yMJj7gUBN+DOgV7i4=;
        b=bC8WlnsYQT7QeJxQoSmTvY7Ej/YI3CdyaGVr/kBsHe889fRsARGC6MEby9pXn/8jJ/
         dv5InMoldSpHgPZ4tH00zX6R/AM1nfBU24ehCv++5RY8Ybg+heAruGdcOxZMTSk6V50A
         wN+ExNcRoDhP3vtbB7pKaFC1YSGv0ykHZhNPsxAYkyZp0w2bfo3U1Q4i3uv+ixdmfNzw
         xSse4x6V8QPbgZooLXGJayCWn9putyexa96hbVtE/JrKqm+9MKF3ADnjCoWTSaPOakSX
         FzwMG/O5/FuLU/HHPIBPVdgBIvEJbUyerNH4PWLUjQLnca3WhivXeEB50aeoC7mROfpY
         DodA==
X-Gm-Message-State: AOAM532jCqB+8x1DEz6hEuOD3b4ujjOIu0wW8ICR6Bz6IhPNfRLEvOOE
        NhBvvdYOFfCIffsG4CSph1lwYPV+SJHuUA==
X-Google-Smtp-Source: ABdhPJycBhLRq7RMzxU0yFadXKIfSiZxhNi35oVYdYJF2ItyuH12ggPdIaHEWln6JzkORntVjR6E6w==
X-Received: by 2002:a67:ce0b:: with SMTP id s11mr2641931vsl.38.1641918677427;
        Tue, 11 Jan 2022 08:31:17 -0800 (PST)
Received: from mail-ua1-f49.google.com (mail-ua1-f49.google.com. [209.85.222.49])
        by smtp.gmail.com with ESMTPSA id m8sm5580691uae.8.2022.01.11.08.31.16
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Jan 2022 08:31:17 -0800 (PST)
Received: by mail-ua1-f49.google.com with SMTP id u6so30936213uaq.0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jan 2022 08:31:16 -0800 (PST)
X-Received: by 2002:a9f:3e01:: with SMTP id o1mr2359918uai.89.1641918676624;
 Tue, 11 Jan 2022 08:31:16 -0800 (PST)
MIME-Version: 1.0
References: <20220111030055.2043568-1-shorne@gmail.com>
In-Reply-To: <20220111030055.2043568-1-shorne@gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 11 Jan 2022 17:31:05 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUUShmJfRWUCS+CQ_OUW9cUHuZQS3aTPznt-i+TT0Tgtw@mail.gmail.com>
Message-ID: <CAMuHMdUUShmJfRWUCS+CQ_OUW9cUHuZQS3aTPznt-i+TT0Tgtw@mail.gmail.com>
Subject: Re: [PATCH] openrisc: init: Add support for common clk
To:     Stafford Horne <shorne@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Gabriel Somlo <gsomlo@gmail.com>,
        Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        Randy Dunlap <rdunlap@infradead.org>,
        Openrisc <openrisc@lists.librecores.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stafford,

On Tue, Jan 11, 2022 at 4:01 AM Stafford Horne <shorne@gmail.com> wrote:
> When testing the new litex_mmc driver it was found to not work on
> OpenRISC due to missing support for common clk.  This patch does the
> basic initialization to allow OpenRISC to use the common clk framework.
>
> Signed-off-by: Stafford Horne <shorne@gmail.com>

Thanks for your patch!

This matches what other architectures are doing, and is IMHO the way
forward for sharing FPGA drivers among architectures.
Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
