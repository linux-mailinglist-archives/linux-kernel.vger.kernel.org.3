Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FA0F512C8D
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 09:17:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245098AbiD1HUR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 03:20:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245121AbiD1HUF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 03:20:05 -0400
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24AD79A9A6;
        Thu, 28 Apr 2022 00:16:52 -0700 (PDT)
Received: by mail-qv1-f41.google.com with SMTP id r8so2637087qvx.10;
        Thu, 28 Apr 2022 00:16:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iXSujVifP/z3b+O+ilWfsSDwJrRw0iyDOa/QgmjI+PI=;
        b=NQN7QQB3p13bT2AJ2KDhaBE3uFg8paE/oHBttNHZIzkdGndMorUZW0a9T5WzlrlEW8
         BMpu0tE8D8RWnfYw/0J/hwCTxQpNxOvl3/E/BvJYiY6kZzi9+xCh7t4uezVBL+0sY+C+
         tJpGvPDWnDVjggi1lhWdYXiYW6sX4Paf58nqXLHG5gp9ijjJNTFcUsP8R8LaWk+hnCTo
         l9+1KWzMqx+s/FW2KT6JtyTmv/C8hTecHuZAGwtn+t/GxWURSS0MUX6XRP2jdiqsUavj
         uLSl7aqR+/T+NEzHjV7zmZ2XRIYFI1rctEcvVy7vnNVJgzVbIK90i5olLI2e71xpAAae
         6Gag==
X-Gm-Message-State: AOAM531zVh9feuYc07t9zEUHFlAXbsI+mMyNEdebMtJOMUQGE7hNmDYP
        4Z3PcazvC3JQ51lAwSxLMsMShnfJsEcfVA==
X-Google-Smtp-Source: ABdhPJxIHWRaLKpw9aH1yXOAUrvcH7eZsqdTKN61SLT8MRqE+iXIygHqgchY/bZ86VcfSlSEsV5b6Q==
X-Received: by 2002:ad4:5ba1:0:b0:443:cd52:782d with SMTP id 1-20020ad45ba1000000b00443cd52782dmr22701336qvq.25.1651130211184;
        Thu, 28 Apr 2022 00:16:51 -0700 (PDT)
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com. [209.85.128.172])
        by smtp.gmail.com with ESMTPSA id b11-20020ac85bcb000000b002f374e12069sm4873483qtb.18.2022.04.28.00.16.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Apr 2022 00:16:51 -0700 (PDT)
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-2f7d7e3b5bfso43033727b3.5;
        Thu, 28 Apr 2022 00:16:50 -0700 (PDT)
X-Received: by 2002:a81:1cd5:0:b0:2f4:c3fc:2174 with SMTP id
 c204-20020a811cd5000000b002f4c3fc2174mr31954120ywc.512.1651130210567; Thu, 28
 Apr 2022 00:16:50 -0700 (PDT)
MIME-Version: 1.0
References: <20220428033319.239341-1-gerg@linux-m68k.org> <20220428033319.239341-2-gerg@linux-m68k.org>
In-Reply-To: <20220428033319.239341-2-gerg@linux-m68k.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 28 Apr 2022 09:16:39 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVieXvj-BnLiuv=TEw_2ZcyMF+EyzmFOqRM=MzszTmTuQ@mail.gmail.com>
Message-ID: <CAMuHMdVieXvj-BnLiuv=TEw_2ZcyMF+EyzmFOqRM=MzszTmTuQ@mail.gmail.com>
Subject: Re: [PATCH 1/4] m68knommu: use asm-generic/mmu.h for nommu setups
To:     Greg Ungerer <gerg@linux-m68k.org>
Cc:     "Linux/m68k" <linux-m68k@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rich Felker <dalias@libc.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 28, 2022 at 8:24 AM Greg Ungerer <gerg@linux-m68k.org> wrote:
> The nommu case defines its own local mm_context_t structure. There is
> nothing special or different about the m68knommu version of this and it
> can easily use the common asm-generic version.
>
> Remove the local mmu_context struct and include the asm-generic version
> instead. This will also make it easier to support ELF format executables
> in the future (since the asm-generic version has support for this
> already).
>
> Signed-off-by: Greg Ungerer <gerg@linux-m68k.org>

Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
