Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C05DF480774
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Dec 2021 09:40:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235721AbhL1IkC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Dec 2021 03:40:02 -0500
Received: from mail-ua1-f52.google.com ([209.85.222.52]:40796 "EHLO
        mail-ua1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231670AbhL1IkB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Dec 2021 03:40:01 -0500
Received: by mail-ua1-f52.google.com with SMTP id v12so19027176uar.7
        for <linux-kernel@vger.kernel.org>; Tue, 28 Dec 2021 00:40:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1U54aUmdlVWzoRRCzQXLay8GEZgnNLlNR+vRREgVBq4=;
        b=WusEt1ZcSiF4joxFLf860YS5hKIyD2IFIzjtmRbHLKrqcYQZdwc8vpvOvBi2aG79nl
         6zDsnBPVjqv6CYaVVArxDlWWi0ugCobFFTveGqp7tuedsPz64s3qtVlKyt0vTW/I7CNU
         2Um4tQ0M3AGrutfZ6MoxiteguM+5CQkRg2epiykt9P7BLPjz+fAhFFlxQ5oSmbaT5lBA
         /h0OjbEWhm/Gil1BvXBO+orYYwnasUXpMie3CIBNopCjTgN4V9nO4C/aWrmIQmWoJrmn
         zl8M/Ayc2PWrfNPEhFr2JNh0+iJJsmPrWjsaolKKm4unuuGoS0jIsa9LpvOHhu2qy0J1
         00MQ==
X-Gm-Message-State: AOAM531Tz+/3fiPna4MJw50sDmZ12234SxtBQL/rjF9ESFontC6rfl9Z
        MaNlKN+a9zrX5GLk5DyyizGUo6uJ4ytuBg==
X-Google-Smtp-Source: ABdhPJy79XaPw5IQgAf2vK1NCihK5TPkqWs5hn9wkZkCeyiQF9+tPtURm+pGsUmz4hFtdMeDwVp1Dw==
X-Received: by 2002:a05:6102:c46:: with SMTP id y6mr6104769vss.82.1640680800947;
        Tue, 28 Dec 2021 00:40:00 -0800 (PST)
Received: from mail-vk1-f180.google.com (mail-vk1-f180.google.com. [209.85.221.180])
        by smtp.gmail.com with ESMTPSA id t20sm2038318vsj.11.2021.12.28.00.40.00
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Dec 2021 00:40:00 -0800 (PST)
Received: by mail-vk1-f180.google.com with SMTP id b77so9927162vka.11
        for <linux-kernel@vger.kernel.org>; Tue, 28 Dec 2021 00:40:00 -0800 (PST)
X-Received: by 2002:a1f:4641:: with SMTP id t62mr6304684vka.0.1640680800305;
 Tue, 28 Dec 2021 00:40:00 -0800 (PST)
MIME-Version: 1.0
References: <20211228020611.6582-1-hbh25y@gmail.com>
In-Reply-To: <20211228020611.6582-1-hbh25y@gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 28 Dec 2021 09:39:49 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXYuH6kgWCPjQhmd6Xi2N=oiyCSoE8U4NMg3tOrJ9bwDw@mail.gmail.com>
Message-ID: <CAMuHMdXYuH6kgWCPjQhmd6Xi2N=oiyCSoE8U4NMg3tOrJ9bwDw@mail.gmail.com>
Subject: Re: [PATCH v2] m68k/kernel: array out of bound access in process_uboot_commandline
To:     Hangyu Hua <hbh25y@gmail.com>
Cc:     linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Greg Ungerer <gerg@linux-m68k.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CC greg

On Tue, Dec 28, 2021 at 3:06 AM Hangyu Hua <hbh25y@gmail.com> wrote:
>
> When the size of commandp >= size, array out of bound write occurs because
> len == 0.
>
> Signed-off-by: Hangyu Hua <hbh25y@gmail.com>
> ---
>  arch/m68k/kernel/uboot.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/arch/m68k/kernel/uboot.c b/arch/m68k/kernel/uboot.c
> index 928dbd33fc4a..63eaf3c3ddcd 100644
> --- a/arch/m68k/kernel/uboot.c
> +++ b/arch/m68k/kernel/uboot.c
> @@ -101,5 +101,6 @@ __init void process_uboot_commandline(char *commandp, int size)
>         }
>
>         parse_uboot_commandline(commandp, len);
> -       commandp[len - 1] = 0;
> +       if (len > 0)
> +               commandp[len - 1] = 0;
>  }
> --
> 2.25.1
