Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E97E46E7B0
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 12:36:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236820AbhLILkB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 06:40:01 -0500
Received: from mail-ua1-f43.google.com ([209.85.222.43]:37697 "EHLO
        mail-ua1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233082AbhLILkA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 06:40:00 -0500
Received: by mail-ua1-f43.google.com with SMTP id o1so10172612uap.4;
        Thu, 09 Dec 2021 03:36:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bCAtLuHkBfdhNiNN7zTcPyUKHpXBqsilvJRiJ7D60To=;
        b=R8Z3MR8hM7pk/JOA52N2phoE2B2n7i+JSZIomhCJnde7XqW+IxB+hvlkL5DDlqbsOI
         aYdaDY7Q/lEzQfuzyd9BXdFhL8X0p67tiKyIXbDRdwGCezKU+SAz4ZF6lhsST6xTsKEu
         XN1BuNh+Qvh5AOOC6dGsHCKfMDZKfAxHNqKOPQXHKy2CpgkjZhO2DaQIKiZcBd0hPFpg
         CpD9HO4kQyq+N+ZpqEGYg5feBzGywAAE4mgOg0mkPTNyuVSFnKYMymG+MSQ38YtnEDNc
         IKwyVRTyCmhc5Xw4xa4BUFPDWPpwOxOQUlsLnjhdwOXsb7NMfX793UXdSOO0F4vO2N5T
         N8AQ==
X-Gm-Message-State: AOAM530qC8mgjoF6bwWjz+zJHGhCSR+akuy8xvjMRJp7rllZTgpiu6bO
        gjTY/TOScvFN1aKzgjwjbk1GLJ3OIEtW9w==
X-Google-Smtp-Source: ABdhPJydCmav7OT9vNc5YKZOC63I3sZZ5BfOqY7tCiH/XQb8IT0exMJaVDJzUcujWqjf4ubt55PD+g==
X-Received: by 2002:a9f:2329:: with SMTP id 38mr18071745uae.124.1639049786061;
        Thu, 09 Dec 2021 03:36:26 -0800 (PST)
Received: from mail-vk1-f182.google.com (mail-vk1-f182.google.com. [209.85.221.182])
        by smtp.gmail.com with ESMTPSA id a128sm3662624vki.11.2021.12.09.03.36.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Dec 2021 03:36:25 -0800 (PST)
Received: by mail-vk1-f182.google.com with SMTP id m16so3478173vkl.13;
        Thu, 09 Dec 2021 03:36:25 -0800 (PST)
X-Received: by 2002:a05:6122:104f:: with SMTP id z15mr8304256vkn.39.1639049785213;
 Thu, 09 Dec 2021 03:36:25 -0800 (PST)
MIME-Version: 1.0
References: <20211209111506.217637-1-arnd@kernel.org>
In-Reply-To: <20211209111506.217637-1-arnd@kernel.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 9 Dec 2021 12:36:13 +0100
X-Gmail-Original-Message-ID: <CAMuHMdW-g8TsBiOK9LKwtpvo933nuCN3HsGkz9sxuLnMgb4kbg@mail.gmail.com>
Message-ID: <CAMuHMdW-g8TsBiOK9LKwtpvo933nuCN3HsGkz9sxuLnMgb4kbg@mail.gmail.com>
Subject: Re: [PATCH] clk: renesas: cpg-mssr: fix R-Car S4-8 link failure
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd,

On Thu, Dec 9, 2021 at 12:15 PM Arnd Bergmann <arnd@kernel.org> wrote:
> From: Arnd Bergmann <arnd@arndb.de>
>
> Without CONFIG_CLK_RCAR_GEN4_CPG, this driver fails to link:
>
> x86_64-linux-ld: drivers/clk/renesas/r8a779a0-cpg-mssr.o:(.init.rodata+0x70): undefined reference to `rcar_gen4_cpg_clk_register'
>
> Fixes: 95d3d41f958f ("clk: renesas: cpg-mssr: Add support for R-Car S4-8")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Thanks, but this is already fixed.
https://git.kernel.org/pub/scm/linux/kernel/git/geert/renesas-drivers.git/commit/?h=renesas-clk-for-v5.17&id=470e3f0d0b1529abf9759c93e23ac8dd678e0e70

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
