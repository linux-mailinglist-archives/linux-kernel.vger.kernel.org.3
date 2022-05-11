Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31B27523264
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 14:03:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235801AbiEKMC1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 08:02:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233231AbiEKMCU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 08:02:20 -0400
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2189464BF5
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 05:02:19 -0700 (PDT)
Received: by mail-qv1-f48.google.com with SMTP id dv4so1876965qvb.13
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 05:02:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZWFmwKWOlLPl7XEc75NKSaHMr/hgroG2DFqYMNTA9rE=;
        b=hXDZTSzxzE8C9XScrGkgoXWC2ceK2aezYOxzShWLDVNI5bNVe/ZnpLpUQqaQKEveWu
         Ylv+VmTtr/49uXS8tyOqzvo/snznyT7Y2SXeOfkZARnn8+vTp588s56UuYTNYGPPQxA1
         A5vTnAOVxeI9wRD7/Wd6KliL3SSvLCUEWtiieoXhBy7N5YfSIXE5/7NcAiNFdrcnm8Tj
         zwMsHZomalo9QBCRA+Hk3JjLnirvoNxzEYjNFb+acieP+Eak50LDk3vw8WJ2CyCZSxkD
         PLvphtl2RAK3RRcECUzuQqdF9BpQgtiLn4FLOF+WAubhfzXO19ubzOYHZJAI3pl2bCOR
         TmwQ==
X-Gm-Message-State: AOAM533LUpoIPPkrZUppJLPQ6a5i5zSFGmGoR8s5uIFKitpYnyRs9nyo
        VrqnrmJOoPKn3Pb6lRet4cscRGozthabIg==
X-Google-Smtp-Source: ABdhPJwJsBSjm1RTbfzMeNjBygIi6QaLoyCjlRrwtWy9BImm8CRjLCNBMMABTC3KL0uyTNxyEVBYFA==
X-Received: by 2002:a05:6214:27e4:b0:45a:a04d:d835 with SMTP id jt4-20020a05621427e400b0045aa04dd835mr21973699qvb.82.1652270536654;
        Wed, 11 May 2022 05:02:16 -0700 (PDT)
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com. [209.85.219.179])
        by smtp.gmail.com with ESMTPSA id n207-20020a3740d8000000b006a03cbb1323sm1072800qka.65.2022.05.11.05.02.16
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 May 2022 05:02:16 -0700 (PDT)
Received: by mail-yb1-f179.google.com with SMTP id g28so3520375ybj.10
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 05:02:16 -0700 (PDT)
X-Received: by 2002:a25:6157:0:b0:645:8d0e:f782 with SMTP id
 v84-20020a256157000000b006458d0ef782mr24367466ybb.36.1652270534527; Wed, 11
 May 2022 05:02:14 -0700 (PDT)
MIME-Version: 1.0
References: <e0a9cf982a80f14efbf01cdc38e31128a9f41999.1652262437.git.geert@linux-m68k.org>
 <875ymcwek5.fsf@igel.home>
In-Reply-To: <875ymcwek5.fsf@igel.home>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 11 May 2022 14:02:01 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXrd07goR2WffENJnLMAWZxtxoQzaL_7+SG-ZSvaYK1HQ@mail.gmail.com>
Message-ID: <CAMuHMdXrd07goR2WffENJnLMAWZxtxoQzaL_7+SG-ZSvaYK1HQ@mail.gmail.com>
Subject: Re: [PATCH] m68k: math-emu: Fix dependencies of math emulation support
To:     Andreas Schwab <schwab@linux-m68k.org>
Cc:     Greg Ungerer <gerg@uclinux.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andreas,

On Wed, May 11, 2022 at 1:43 PM Andreas Schwab <schwab@linux-m68k.org> wrote:
> On Mai 11 2022, Geert Uytterhoeven wrote:
> > Drop the dependency on MMU, as the code should work fine on 68020 and up
> > without MMU (which are not yet supported by Linux, though).
> > Add dependencies on M68K_CLASSIC (to rule out Coldfire) and FPU (to rule
> > out 68xxx below 68020).
>
> Depending on FPU looks strange, since that is supposed to be an FPU
> emulation, for CPUs that _lack_ an FPU (ie. 680[23]0 without the
> 6888[12], or 68LC0[46]0).

I picked FPU because it is selected by all of M680[2346]0.
Upon closer look, both the hard FPU and soft FPU code are protected
by CONFIG_FPU, so the latter looks like the right symbol.
The FPU emu code also relies on the CPU trapping on the proper
instructions, which I believe you need a 68020+ for, too?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
