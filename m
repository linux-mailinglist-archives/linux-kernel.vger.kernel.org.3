Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98CA647A761
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Dec 2021 10:46:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230070AbhLTJqA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 04:46:00 -0500
Received: from mail-ua1-f48.google.com ([209.85.222.48]:38522 "EHLO
        mail-ua1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230053AbhLTJp7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 04:45:59 -0500
Received: by mail-ua1-f48.google.com with SMTP id o63so4317071uao.5
        for <linux-kernel@vger.kernel.org>; Mon, 20 Dec 2021 01:45:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=A95tC6jcivsHHQxGupwpXDqBbjLfwMDd/W7jJ28KIvA=;
        b=bOAikGBo55J6hE5SrmyvF9CGsZ+Ltql3buiuiqvlirA1zAU28PwL98f0sV6QTCSuah
         iRlNU+e1HXcvc18mn1f0JtHMBic2o5k7NsQYe1vlRbZmau/xZlauXTmkhOX0tqv/ab4C
         hgUa1SwVD5ypecq0o5Jl6HjdDlbv4OvsB673Qtl2n6Isn3yTdwaf7af+vmJf9VBn2SWi
         vnBigO5Wad819IrGUcfEnzYDy/93p39jbdQmjIpvO8KyEym/n5MzWVkXxqwSOgtH8vqs
         vEEy7z9jtEd8dKYPAZns+gWozl5mKFdISkiwJYb97cXL5OjfWHhKlZdqRoSO1AaJXZw3
         upqw==
X-Gm-Message-State: AOAM531k+aSu5bHduMFcwJzQe4XGPNti971xLd+1Utg3KhIhTSVDzcTO
        x3U2gflJKuoJoFyxFzvKEBOAqLYG2l4Fhg==
X-Google-Smtp-Source: ABdhPJx6oeyerLSvYfLweMhnB/OrIemfHcdpuTd4yZw7YVS0vnC+mpUZtxGSku3z3t6ywROX1zP80A==
X-Received: by 2002:a67:d60a:: with SMTP id n10mr1170936vsj.27.1639993558439;
        Mon, 20 Dec 2021 01:45:58 -0800 (PST)
Received: from mail-ua1-f46.google.com (mail-ua1-f46.google.com. [209.85.222.46])
        by smtp.gmail.com with ESMTPSA id i62sm2145585vke.33.2021.12.20.01.45.58
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Dec 2021 01:45:58 -0800 (PST)
Received: by mail-ua1-f46.google.com with SMTP id i6so16602543uae.6
        for <linux-kernel@vger.kernel.org>; Mon, 20 Dec 2021 01:45:58 -0800 (PST)
X-Received: by 2002:a05:6102:21dc:: with SMTP id r28mr4417990vsg.57.1639993557814;
 Mon, 20 Dec 2021 01:45:57 -0800 (PST)
MIME-Version: 1.0
References: <20211220084013.242754-1-geert@linux-m68k.org>
In-Reply-To: <20211220084013.242754-1-geert@linux-m68k.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 20 Dec 2021 10:45:46 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXTRYjtfyWTVN86pn4STO2EPR1B5+KHj=wAqguXt=hpHg@mail.gmail.com>
Message-ID: <CAMuHMdXTRYjtfyWTVN86pn4STO2EPR1B5+KHj=wAqguXt=hpHg@mail.gmail.com>
Subject: Re: Build regressions/improvements in v5.16-rc6
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc:     linux-um <linux-um@lists.infradead.org>,
        DRI Development <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 20, 2021 at 10:25 AM Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
> JFYI, when comparing v5.16-rc6[1] to v5.16-rc5[3], the summaries are:
>   - build errors: +1/-5

  + /kisskb/src/drivers/gpu/drm/ttm/ttm_module.c: error: 'struct
cpuinfo_um' has no member named 'x86':  => 71:24

um-x86_64/um-allyesconfig

> [1] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/a7904a538933c525096ca2ccde1e60d0ee62c08e/ (all 90 configs)
> [3] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/2585cf9dfaaddf00b069673f27bb3f8530e2039c/ (all 90 configs)

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
