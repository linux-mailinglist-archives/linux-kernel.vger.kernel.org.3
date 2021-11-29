Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D41E84611DC
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 11:09:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240316AbhK2KMv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 05:12:51 -0500
Received: from mail-vk1-f178.google.com ([209.85.221.178]:37424 "EHLO
        mail-vk1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235211AbhK2KKt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 05:10:49 -0500
Received: by mail-vk1-f178.google.com with SMTP id e27so10644722vkd.4;
        Mon, 29 Nov 2021 02:07:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GVFNfQPdN79DFaiM4xA6K3MbJdiYsXlejmisa39lhE8=;
        b=S6oiH7X98dVKi8s5kIpwqPdJbMCKmfVJxaQvMDfvLoVQd6FcIcPIvZyoiqSyCvuCiS
         TOBK/SoRBJcvWmh8jSdS6fPTBy0hgwFw0xGMbxgiPFuxq6NCj/OXFJnIufv80kJmqYlV
         I9l2BjIowWOO9zxH7oDtozdd3Yw33o2wm7RryHrgSc0cV7mGI5vGOU41PAoYIPsgbcAj
         o4zqji2mnOIE+yZTcjsYT3ytxMO02yhj8WQGD8jJaGwQNcUbSZzpZ3vTfyot1Y8bO2UQ
         kDyWCpxamMY2TxfvfzIczp+9o6DEgm3T4YwRpWm94IG7NSjuRXjz3XNpMxdbkZshuBgn
         gBbw==
X-Gm-Message-State: AOAM532f7ZyZvwWLqbswCtVQgNmMKc/C+gQrhcw/6dGfklKmkN6YKxiP
        7ew4swyJqgBpQp2iM8mN2vPaHJMBUFyWCw==
X-Google-Smtp-Source: ABdhPJyc5DbU0mwKU1p5d0R7kGhcirmBYnp9nMAjzrQM6zfmY01j3gQitKilFIaLWAxRHTeaP7+Z0g==
X-Received: by 2002:a1f:9049:: with SMTP id s70mr34115371vkd.19.1638180451546;
        Mon, 29 Nov 2021 02:07:31 -0800 (PST)
Received: from mail-ua1-f53.google.com (mail-ua1-f53.google.com. [209.85.222.53])
        by smtp.gmail.com with ESMTPSA id g28sm7629070vkl.16.2021.11.29.02.07.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Nov 2021 02:07:31 -0800 (PST)
Received: by mail-ua1-f53.google.com with SMTP id o1so32791915uap.4;
        Mon, 29 Nov 2021 02:07:31 -0800 (PST)
X-Received: by 2002:a67:c106:: with SMTP id d6mr31358268vsj.77.1638180450870;
 Mon, 29 Nov 2021 02:07:30 -0800 (PST)
MIME-Version: 1.0
References: <8170fe1d1c62426d82275d36ba409ecc18754292.1637274578.git.fthain@linux-m68k.org>
In-Reply-To: <8170fe1d1c62426d82275d36ba409ecc18754292.1637274578.git.fthain@linux-m68k.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 29 Nov 2021 11:07:19 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUFZkFkDaxHx-hbXhZAk2B-J_sprtEz=S8AYf9wJgH1pg@mail.gmail.com>
Message-ID: <CAMuHMdUFZkFkDaxHx-hbXhZAk2B-J_sprtEz=S8AYf9wJgH1pg@mail.gmail.com>
Subject: Re: [PATCH v3] m68k: Enable memtest functionality
To:     Finn Thain <fthain@linux-m68k.org>
Cc:     Mike Rapoport <rppt@kernel.org>, Sam Creasey <sammy@sammy.net>,
        Jonathan Corbet <corbet@lwn.net>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 18, 2021 at 11:32 PM Finn Thain <fthain@linux-m68k.org> wrote:
> Enable the memtest functionality and rearrange some code to prevent it
> from clobbering the initrd.
>
> The code to implement CONFIG_BLK_DEV_INITRD was conditional on
> !defined(CONFIG_SUN3). For simplicity, remove that test on the basis
> that m68k_ramdisk.size == 0 on Sun 3. The SLIME source code at
> http://sammy.net/sun3/ftp/pub/m68k/sun3/slime/slime-2.0.tar.gz
> indicates that no BI_RAMDISK entry is ever passed to the kernel due
> to #ifdef 0 around the relevant code.
>
> Cc: Mike Rapoport <rppt@kernel.org>
> Cc: Sam Creasey <sammy@sammy.net>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Signed-off-by: Finn Thain <fthain@linux-m68k.org>

Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>
i.e. will queue in the m68k for-v5.17 branch.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
