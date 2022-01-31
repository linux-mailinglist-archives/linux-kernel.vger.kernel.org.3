Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7FCA4A4D8D
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jan 2022 18:53:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347446AbiAaRxA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 12:53:00 -0500
Received: from mail-pl1-f170.google.com ([209.85.214.170]:45694 "EHLO
        mail-pl1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355341AbiAaRwy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 12:52:54 -0500
Received: by mail-pl1-f170.google.com with SMTP id s6so7547576plg.12
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 09:52:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CcsYkeFWzOuHVmFeeXrDJz8XxU7vHUFunNdU3i9ZZtY=;
        b=7CY7auaAW9FUsmHwEiyU8QoWPO/EwCit2Ivz5rf0zNmwpPUnqjd5NhSKe6RmBsIp/6
         E7NIkjx162avqSWgVmcrcR5D5zvIhg1XPOdALGX1SZgn53wfNyb5zpqD8sWondXuy1+/
         EkrGCpyzvjwd65JiH4teQ+DO/eoNTUwDaSDlRR3Bff+pDqhD1Gzm9QqZpMYlSPaU72B6
         x/Kfcdr9lmOffx/pNee1UwkccgqU4xCfkxGSVtgDTC1wEXXNRexczVRXpv3ndPxX6N1L
         dSKFHCai4i11VNv1+4sNEZ6f+G9OJ78t/VFgZO2Wads88DYSerP8usaSLz+sE717Nr5W
         vSpg==
X-Gm-Message-State: AOAM532HScfjNBKtsdZV0d4fTUndXdAMkplmG0yraEazD+I/hmIex/tz
        mthcgYC7JW9AA78euBjkkpU9jL/JbbiiAs8SnDCwx0lWZIU=
X-Google-Smtp-Source: ABdhPJyZa4u3xNi1E7JmnZsDxyCzljnF3V/8bfIsbQsrsz6gDNkzIkrSzqUGacJJgYr0qaim4+d8jz0OjLS4yc7gW3E=
X-Received: by 2002:a17:902:7b95:: with SMTP id w21mr21774260pll.48.1643651574378;
 Mon, 31 Jan 2022 09:52:54 -0800 (PST)
MIME-Version: 1.0
References: <cover.1643635156.git.geert@linux-m68k.org>
In-Reply-To: <cover.1643635156.git.geert@linux-m68k.org>
From:   Emil Renner Berthing <kernel@esmil.dk>
Date:   Mon, 31 Jan 2022 18:52:43 +0100
Message-ID: <CANBLGcyZ+wcBiZOyd8jC2-cUx_m+Zu6XZB6gyDOL_omQzEesPw@mail.gmail.com>
Subject: Re: [PATCH 0/3] RISC-V: Fix cpumask rework falloout
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Anup Patel <anup@brainfault.org>,
        Atish Patra <atishp@rivosinc.com>,
        Jessica Clarke <jrtc27@jrtc27.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 31 Jan 2022 at 14:26, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
>         Hi all,
>
> This patch series intends to fix the fall-out from commit
> 26fb751ca37846c9 ("RISC-V: Do not use cpumask data structure for hartid
> bitmap"), cfr. the discussion in thread[1].
>
> Thanks for your comments!
>
> [1] "[PATCH v3 6/6] RISC-V: Do not use cpumask data structure for hartid
>      bitmap"
>     https://lore.kernel.org/r/20220120090918.2646626-7-atishp@rivosinc.com/
>
> Geert Uytterhoeven (3):
>   RISC-V: Fix hartid mask handling for hartid 31 and up
>   RISC-V: Fix handling of empty cpu masks
>   RISC-V: Fix IPI/RFENCE hmask on non-monotonic hartid ordering
>
>  arch/riscv/kernel/sbi.c | 72 +++++++++++++++++++++++++++--------------
>  1 file changed, 47 insertions(+), 25 deletions(-)

I built this and rebooted my Starlight board a number of times without
seeing any of the errors that usually shows up when [1] is not
reverted.

Tested-by: Emil Renner Berthing <kernel@esmil.dk>

[1]: 26fb751ca37846c9 ("RISC-V: Do not use cpumask data structure for
hartid bitmap")
