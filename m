Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E71E8462DD9
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 08:46:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239142AbhK3HuN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 02:50:13 -0500
Received: from mail-vk1-f173.google.com ([209.85.221.173]:47004 "EHLO
        mail-vk1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234539AbhK3HuL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 02:50:11 -0500
Received: by mail-vk1-f173.google.com with SMTP id m16so11991888vkl.13;
        Mon, 29 Nov 2021 23:46:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qH1mbhNXMXuJmqx9G5IiqTw6JnJwuBozKZoTCU8LW78=;
        b=HzwLR6ksBcb92rf7Wsbs7g5gNXyh0UukK/UXjv58jVOaxPvj8evuCktYLFc159uMXd
         Y91kNuxXSIVrzjHIzU9kXWTGe6u9wLJSdet/0d6GtWDhDNhIHxDzQHyQ6GIYtuFNzqKh
         PXy4xe2QyoSVRyqxfj00YdkCYv8PS65q1mYkmkhUw4mSNZj/yq1+GjfaRw8cx3dSayJF
         3naEoUWuFRZnbM33oBvztO2iBaZHhPPwYeD7383+4L3i2Ec7hILAGQyroBt/1868gaZG
         l+JXH1ehbYy4STb63EqUmFZ9/BW3xe/IQ2hWkpPl8zzG8Z3tSSQX77I/nFrM94QMKQAk
         Mizg==
X-Gm-Message-State: AOAM533MoX12iXlOD68T6n0fK+/cSN3ktiv64t/g95AQt7NOxUG3t4cN
        N+zT9sYjnO6LRfcVZCQMQMv3W5VnpDtm8w==
X-Google-Smtp-Source: ABdhPJzE6vNC0CPq7tnv+JEVRzKv/QpkZi8kODnyF1xsqJhl35cPrlu2udvgXe2LXwBH01aLZI+oiA==
X-Received: by 2002:a1f:9049:: with SMTP id s70mr42411250vkd.19.1638258412358;
        Mon, 29 Nov 2021 23:46:52 -0800 (PST)
Received: from mail-vk1-f176.google.com (mail-vk1-f176.google.com. [209.85.221.176])
        by smtp.gmail.com with ESMTPSA id 17sm10465203uaq.10.2021.11.29.23.46.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Nov 2021 23:46:52 -0800 (PST)
Received: by mail-vk1-f176.google.com with SMTP id m16so11991875vkl.13;
        Mon, 29 Nov 2021 23:46:52 -0800 (PST)
X-Received: by 2002:a05:6122:104f:: with SMTP id z15mr38804710vkn.39.1638258411890;
 Mon, 29 Nov 2021 23:46:51 -0800 (PST)
MIME-Version: 1.0
References: <20211129122706.2719625-1-geert@linux-m68k.org>
In-Reply-To: <20211129122706.2719625-1-geert@linux-m68k.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 30 Nov 2021 08:46:40 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUSw=MdqMRJAf6W64YTKuu42iDYHKnv=T1x4h+SNUS1xQ@mail.gmail.com>
Message-ID: <CAMuHMdUSw=MdqMRJAf6W64YTKuu42iDYHKnv=T1x4h+SNUS1xQ@mail.gmail.com>
Subject: Re: Build regressions/improvements in v5.16-rc3
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc:     sparclinux <sparclinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 29, 2021 at 1:27 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> JFYI, when comparing v5.16-rc3[1] to v5.16-rc2[3], the summaries are:
>   - build errors: +4/-8

  + error: arch/sparc/kernel/head_32.o: relocation truncated to fit:
R_SPARC_WDISP22 against `.init.text':  => (.head.text+0x5100),
(.head.text+0x5040)
  + error: arch/sparc/kernel/head_32.o: relocation truncated to fit:
R_SPARC_WDISP22 against symbol `leon_smp_cpu_startup' defined in .text
section in arch/sparc/kernel/trampoline_32.o:  => (.init.text+0xa4)
  + error: arch/sparc/kernel/process_32.o: relocation truncated to
fit: R_SPARC_WDISP22 against `.text':  => (.fixup+0xc), (.fixup+0x4)
  + error: arch/sparc/kernel/signal_32.o: relocation truncated to fit:
R_SPARC_WDISP22 against `.text':  => (.fixup+0x4), (.fixup+0x10),
(.fixup+0x34), (.fixup+0x1c), (.fixup+0x28)

sparc64/sparc-allmodconfig

> [1] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/d58071a8a76d779eedab38033ae4c821c30295a5/ (all 90 configs)
> [3] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/136057256686de39cc3a07c2e39ef6bc43003ff6/ (all 90 configs)

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
