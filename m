Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D85D3512C9A
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 09:21:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245126AbiD1HYD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 03:24:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245030AbiD1HXr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 03:23:47 -0400
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F9731D0C0;
        Thu, 28 Apr 2022 00:20:32 -0700 (PDT)
Received: by mail-qk1-f179.google.com with SMTP id 126so2027949qkm.4;
        Thu, 28 Apr 2022 00:20:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nFnxkytxiDV9tiNmv6YagpRIo9s4lkmQusqhamT+HGQ=;
        b=G/CzdR9QHg5mcxFVTP48SfLDMvUhuHqWdJcrlxCV31FQzp36YVZHSqiA0Wifg3PAXU
         kYqTfFzYQ0usySiDyzt0HJw7g9Xb9Jc4J01EKkM+ULGPzB3l+uatuGNudhSNa3Nh66q+
         cJDslCry/zOWu4dlz34STFH1LqOtMwRlf4O6NtLDk7JkIB3lEN1fp/wrtjI/fQi/o3VL
         nDSxjVCdAhw2aAxd7vH44bp5U05Cf2N54d4qxw0nnJvgzhU/jlfU1jtHbEooaIieBc6o
         J5Zwe8HQ1IyCD5A0bo5eo3mZP9ayhYlqfdH0Vh9UdsfeOz7N/pbGkk4C+sp6HTjqaP5H
         zRbA==
X-Gm-Message-State: AOAM533LmKSckYwLX3fBbfHEI30uYJ0r2Sq2wYQlQPl/4tlikuU070pu
        fgKd7Zd/NbSeJQs8e2MBZTLRivIbXZ4uJg==
X-Google-Smtp-Source: ABdhPJyQMz5aOdIq6hdBTX6N03j/WFlNhbmH+3it5hAsQvopFgp8SFr25q8n/fKF3dpOyJcaU51Zxg==
X-Received: by 2002:a05:620a:4625:b0:69f:6a9a:ccd5 with SMTP id br37-20020a05620a462500b0069f6a9accd5mr9472795qkb.626.1651130431552;
        Thu, 28 Apr 2022 00:20:31 -0700 (PDT)
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com. [209.85.219.177])
        by smtp.gmail.com with ESMTPSA id i19-20020a05620a249300b0069f805534d3sm3766066qkn.89.2022.04.28.00.20.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Apr 2022 00:20:31 -0700 (PDT)
Received: by mail-yb1-f177.google.com with SMTP id d12so7439083ybc.4;
        Thu, 28 Apr 2022 00:20:30 -0700 (PDT)
X-Received: by 2002:a25:8087:0:b0:641:dd06:577d with SMTP id
 n7-20020a258087000000b00641dd06577dmr29182800ybk.207.1651130430756; Thu, 28
 Apr 2022 00:20:30 -0700 (PDT)
MIME-Version: 1.0
References: <20220428033319.239341-1-gerg@linux-m68k.org> <20220428033319.239341-5-gerg@linux-m68k.org>
In-Reply-To: <20220428033319.239341-5-gerg@linux-m68k.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 28 Apr 2022 09:20:19 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXtj+ncYOhc3GcNdBuWxMe+0rP1aYCEKMP0yL3aJ_WH3w@mail.gmail.com>
Message-ID: <CAMuHMdXtj+ncYOhc3GcNdBuWxMe+0rP1aYCEKMP0yL3aJ_WH3w@mail.gmail.com>
Subject: Re: [PATCH 4/4] m68knommu: allow elf_fdpic loader to be selected
To:     Greg Ungerer <gerg@linux-m68k.org>
Cc:     "Linux/m68k" <linux-m68k@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rich Felker <dalias@libc.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

On Thu, Apr 28, 2022 at 7:05 AM Greg Ungerer <gerg@linux-m68k.org> wrote:
> The m68k architecture code is capable of supporting the binfmt_elf_fdpic
> loader, so allow it to be configured. It is restricted to nommu
> configurations at this time due to the MMU context structures/code not
> supporting everything elf_fdpic needs when MMU is enabled.
>
> Signed-off-by: Greg Ungerer <gerg@linux-m68k.org>

Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>

> --- a/fs/Kconfig.binfmt
> +++ b/fs/Kconfig.binfmt
> @@ -58,7 +58,7 @@ config ARCH_USE_GNU_PROPERTY
>  config BINFMT_ELF_FDPIC
>         bool "Kernel support for FDPIC ELF binaries"
>         default y if !BINFMT_ELF
> -       depends on (ARM || (SUPERH && !MMU))
> +       depends on (ARM || ((M68K || SUPERH) && !MMU))

While at it, you may want to drop the unneeded outer parentheses,
as they make the expression harder to round, IMHO.

>         select ELFCORE
>         help
>           ELF FDPIC binaries are based on ELF, but allow the individual load

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
