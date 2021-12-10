Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C4EE46FC2D
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 08:57:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237845AbhLJIBO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 03:01:14 -0500
Received: from mail-ua1-f49.google.com ([209.85.222.49]:34453 "EHLO
        mail-ua1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237817AbhLJIBM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 03:01:12 -0500
Received: by mail-ua1-f49.google.com with SMTP id n6so15401555uak.1;
        Thu, 09 Dec 2021 23:57:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NWmsp/wWrkw75p4LneNI30Xfu81IoIeGvv8jDUQHlYs=;
        b=OfWJ+E5ZcYwmoodXekWQ0EBp76v2Nf6HVgjdLnw9g6SryN+B/MyD8/Urbf8091tMxv
         OE1TGfeuTKd3nNHxpln+EiPdXFxuJXasJ/lTaPxuuU7lREexK+PejA8d7PaClbvH1uH7
         4wPfPfmUugIrQTdBOoR5tUkzSariTIWZINJMzgHh4IU4/5oC3inBmUzBJpzOeCD+2jDM
         HFyA7LP0Trer7xQlP8UnGWi7ZdMkAo6e6jySdaCFbO2F1p+hUqpijZrcn4AJN+2VjO6Q
         MhzDshg9IeHTMqa0dU/1BwZJuYR6F3aEx/9dOpINT14/kxvmJtfBAjTkCcteRdQ5OYpm
         9xrA==
X-Gm-Message-State: AOAM531lHXus3MIHmvw5qNRIrMw2aOR7HvfkilYk1+jbinANW0uUzFI5
        UhEXrVPRnHaBmBJ9dPQeHUOhkQCFz4Njxg==
X-Google-Smtp-Source: ABdhPJxRWzRoOOObBXGH8p5RTpDlZ37rVZTVeQZOr/E9UiCGQAgDnCVk8LV+mP57MT8pWs/dweDeMQ==
X-Received: by 2002:a05:6102:cd0:: with SMTP id g16mr14690718vst.8.1639123057532;
        Thu, 09 Dec 2021 23:57:37 -0800 (PST)
Received: from mail-ua1-f48.google.com (mail-ua1-f48.google.com. [209.85.222.48])
        by smtp.gmail.com with ESMTPSA id p130sm1493774vke.56.2021.12.09.23.57.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Dec 2021 23:57:37 -0800 (PST)
Received: by mail-ua1-f48.google.com with SMTP id a14so15459440uak.0;
        Thu, 09 Dec 2021 23:57:37 -0800 (PST)
X-Received: by 2002:a05:6102:3232:: with SMTP id x18mr14687649vsf.38.1639123057040;
 Thu, 09 Dec 2021 23:57:37 -0800 (PST)
MIME-Version: 1.0
References: <20211210014237.2130300-1-sboyd@kernel.org>
In-Reply-To: <20211210014237.2130300-1-sboyd@kernel.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 10 Dec 2021 08:57:25 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVf+EsN8n9iON186xCZETafGscOOB4AXOZpaH0Aui-2=A@mail.gmail.com>
Message-ID: <CAMuHMdVf+EsN8n9iON186xCZETafGscOOB4AXOZpaH0Aui-2=A@mail.gmail.com>
Subject: Re: [PATCH] clk: Emit a stern warning with writable debugfs enabled
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen,

On Fri, Dec 10, 2021 at 2:42 AM Stephen Boyd <sboyd@kernel.org> wrote:
> We don't want vendors to be enabling this part of the clk code and
> shipping it to customers. Exposing the ability to change clk frequencies
> and parents via debugfs is potentially damaging to the system if folks
> don't know what they're doing. Emit a strong warning so that the message
> is clear: don't enable this outside of development systems.
>
> Fixes: 37215da5553e ("clk: Add support for setting clk_rate via debugfs")
> Cc: Geert Uytterhoeven <geert+renesas@glider.be>
> Signed-off-by: Stephen Boyd <sboyd@kernel.org>

Thanks for your patch!

> --- a/drivers/clk/clk.c
> +++ b/drivers/clk/clk.c
> @@ -3383,6 +3383,24 @@ static int __init clk_debug_init(void)
>  {
>         struct clk_core *core;
>
> +#ifdef CLOCK_ALLOW_WRITE_DEBUGFS
> +       pr_warn("\n");
> +       pr_warn("********************************************************************\n");
> +       pr_warn("**     NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE           **\n");
> +       pr_warn("**                                                                **\n");
> +       pr_warn("**  WRITEABLE clk DebugFS SUPPORT HAS BEEN ENABLED IN THIS KERNEL **\n");
> +       pr_warn("**                                                                **\n");
> +       pr_warn("** This means that this kernel is built to expose clk operations  **\n");
> +       pr_warn("** such as parent or rate setting, enabling, disabling, etc.      **\n");
> +       pr_warn("** to userspace, which may compromise security on your system.    **\n");
> +       pr_warn("**                                                                **\n");
> +       pr_warn("** If you see this message and you are not debugging the          **\n");
> +       pr_warn("** kernel, report this immediately to your vendor!                **\n");
> +       pr_warn("**                                                                **\n");
> +       pr_warn("**     NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE           **\n");
> +       pr_warn("********************************************************************\n");

So how many variants of such blocks do we have now in the kernel?

> +#endif
> +
>         rootdir = debugfs_create_dir("clk", NULL);
>
>         debugfs_create_file("clk_summary", 0444, rootdir, &all_lists,
>
> base-commit: fa55b7dcdc43c1aa1ba12bca9d2dd4318c2a0dbf
> prerequisite-patch-id: e0d3f8e3fa43b55e55d7c4cee7c4902ae06ea4e0
> --
> https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git/
> https://git.kernel.org/pub/scm/linux/kernel/git/sboyd/spmi.git

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
