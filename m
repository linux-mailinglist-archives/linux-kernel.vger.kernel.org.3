Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4C0C489BCC
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 16:06:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235894AbiAJPGo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 10:06:44 -0500
Received: from mail-vk1-f172.google.com ([209.85.221.172]:40897 "EHLO
        mail-vk1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231803AbiAJPGn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 10:06:43 -0500
Received: by mail-vk1-f172.google.com with SMTP id 78so8300248vkz.7;
        Mon, 10 Jan 2022 07:06:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=V+BiFjhsdJsmZj3IB08JxzjBxA3eHZEDoGBJZsUKmVc=;
        b=6NV+2GdEyer3B2rBsJFyYcTNt8chCWafbKK11crKSTwJsNe3nUkng3zd98+dwbANNV
         6hR46V1XLdbEzFhJyLbZ4IpSvFd+yFWscr2Px1ayNvweUE8x8wlr1NVUrY93ki/w1ETE
         l1MsZhWX4lt0ecZ/WOpv88TDNk/zy3VCltKLNVljk5jchFdA/aqBkD3X6/vWvsTFlgkq
         4NdMmEgvUFh90q5CeuO9eurAv+U2Ob45O+wqoQNbxuR9H4QBG1KJXCJiQThOxAy7KO+O
         XQP4ABbt0ZNSKPFDIq7JFkgBYfgg738+RmMF8y/uJFx3snbDF/xqk0MDCVf4mbtsYq/z
         nC4Q==
X-Gm-Message-State: AOAM530B3xp7KUBD7IrT2iDVLyo5L6c6+pD01jTeOdOGZmTT0gUwNkFK
        lbn5tfvZJnTbrv/S09FI5bFhOQUZfulMlQ==
X-Google-Smtp-Source: ABdhPJxgdJ74v5mez/T8LFjrLizbS7ikPsCkSj9YKesyJd07L/N5eeKBdmj0sFhCtKty2MuGYTKxhg==
X-Received: by 2002:a05:6122:d9b:: with SMTP id bc27mr121830vkb.14.1641827202206;
        Mon, 10 Jan 2022 07:06:42 -0800 (PST)
Received: from mail-ua1-f48.google.com (mail-ua1-f48.google.com. [209.85.222.48])
        by smtp.gmail.com with ESMTPSA id d198sm1789655vke.44.2022.01.10.07.06.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Jan 2022 07:06:41 -0800 (PST)
Received: by mail-ua1-f48.google.com with SMTP id x33so22600571uad.12;
        Mon, 10 Jan 2022 07:06:41 -0800 (PST)
X-Received: by 2002:a67:c81c:: with SMTP id u28mr58550vsk.38.1641827201048;
 Mon, 10 Jan 2022 07:06:41 -0800 (PST)
MIME-Version: 1.0
References: <20211225193957.2195012-1-nikita.yoush@cogentembedded.com> <e0a56147-e800-914b-1df3-51ca7003a69d@gmail.com>
In-Reply-To: <e0a56147-e800-914b-1df3-51ca7003a69d@gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 10 Jan 2022 16:06:30 +0100
X-Gmail-Original-Message-ID: <CAMuHMdW-S_SPgQmY6kxweNy4sYYKBorxnytk9c8101q7K2KB-w@mail.gmail.com>
Message-ID: <CAMuHMdW-S_SPgQmY6kxweNy4sYYKBorxnytk9c8101q7K2KB-w@mail.gmail.com>
Subject: Re: [PATCH] clk: renesas: r8a7799[05]: Add MLP clocks
To:     Sergei Shtylyov <sergei.shtylyov@gmail.com>
Cc:     Nikita Yushchenko <nikita.yoush@cogentembedded.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 26, 2021 at 6:46 PM Sergei Shtylyov
<sergei.shtylyov@gmail.com> wrote:
> On 25.12.2021 22:39, Nikita Yushchenko wrote:
> > Add clocks for MLP modules on Renesas R-Car E3 and D3 SoCs.
> >
> > Similar to other R-Car Gen3 SoC, exact information on parent for MLP
> > clock on E3 and D3 is not available. However, since parent for this
> > clocl is not anyhow software-controllable, the only harm from this
>
>     s/clocl/clock/. :-)
>
> > is inexact information exported via debugfs. So just keep the parent
> > set in the same way as with other Gen3 SoCs.
> >
> > Signed-off-by: Nikita Yushchenko <nikita.yoush@cogentembedded.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
i.e. will queue in renesas-clk-for-v5.18, with the typos fixed.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
