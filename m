Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C62651B844
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 08:54:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238200AbiEEG5i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 02:57:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240646AbiEEGzw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 02:55:52 -0400
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7171547045;
        Wed,  4 May 2022 23:52:14 -0700 (PDT)
Received: by mail-qt1-f182.google.com with SMTP id x22so2544641qto.2;
        Wed, 04 May 2022 23:52:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QGcj3wvDLBvz1Kbr4GVQBUSS7NWwZ5P79yidz10v/bo=;
        b=ZeO0k5UeQE8maxbeBLKN7hDUdqJ0aKSJIcZdkpkiEi30MPAVz3OWprfbbrQYE6zYoE
         Swf8i9IhODBoOqq0KX6N4VJcsVxwnbzogQw6/7lHKcMTRYhF7G3yNi0TKRpiJgOhMJlp
         C2sw0wL8uDCx8gBkmxlHsh2sGgBXzLxaj7kfLof1kMVvozVt71gkzMkYR6EfEvP5Soaa
         TA/gLHBGX5jKsLbimITI8iEnFjLWwDvpHofcvRs1XgvN6C5KT/P8N12vPSXz0u1mbTDq
         ueYo4mX1kFOq3ffY98vnZBzbHYAu06tohr2IVSmTcagXAzV5m7eueBvIbBEBrGt3CTra
         i3iw==
X-Gm-Message-State: AOAM531I5IN/rnVruuUGxg3gfy3WhITimBAZQikrv3wDF/0meqIH+u6U
        697a5nFKT73rlBoVPQNwbebiMSG5tt47gQ==
X-Google-Smtp-Source: ABdhPJy7oZ7r8vYP284fktErF3MGwUYv4pMQ6rbI7MWzcZJi8n3Fja02FUsZD6gOXUF25JzZbDV05g==
X-Received: by 2002:a05:622a:6205:b0:2f1:e9d9:df34 with SMTP id hj5-20020a05622a620500b002f1e9d9df34mr22337612qtb.86.1651733533183;
        Wed, 04 May 2022 23:52:13 -0700 (PDT)
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com. [209.85.219.175])
        by smtp.gmail.com with ESMTPSA id q21-20020a05620a0c9500b006a0098f029fsm408183qki.13.2022.05.04.23.52.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 May 2022 23:52:12 -0700 (PDT)
Received: by mail-yb1-f175.google.com with SMTP id e12so6074277ybc.11;
        Wed, 04 May 2022 23:52:12 -0700 (PDT)
X-Received: by 2002:a05:6902:120e:b0:634:6f29:6b84 with SMTP id
 s14-20020a056902120e00b006346f296b84mr21041538ybu.604.1651733532336; Wed, 04
 May 2022 23:52:12 -0700 (PDT)
MIME-Version: 1.0
References: <20220504142058.18704-1-wanjiabing@vivo.com>
In-Reply-To: <20220504142058.18704-1-wanjiabing@vivo.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 5 May 2022 08:52:01 +0200
X-Gmail-Original-Message-ID: <CAMuHMdX57C0o65AY=9H=_mge=ee0nwYtiZ6q5JVa3SHB1VnVeg@mail.gmail.com>
Message-ID: <CAMuHMdX57C0o65AY=9H=_mge=ee0nwYtiZ6q5JVa3SHB1VnVeg@mail.gmail.com>
Subject: Re: [PATCH] clk: renesas: rzg2l: Fix duplicate argument in rzg2l-cpg
To:     Wan Jiabing <wanjiabing@vivo.com>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kael_w@yeah.net
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Wan,

On Wed, May 4, 2022 at 4:21 PM Wan Jiabing <wanjiabing@vivo.com> wrote:
> Fix following coccicheck warning:
> ./drivers/clk/renesas/rzg2l-cpg.c:603:39-65: duplicated argument to & or |
>
> The CPG_SIPLL5_CLK1_REFDIV_WEN here is duplicated.
> Here should be CPG_SIPLL5_CLK1_POSTDIV2_WEN.

Thanks, nice catch!

> Fixes: a16ed737e62b ("clk: renesas: rzg2l: Add FOUTPOSTDIV clk support")
> Signed-off-by: Wan Jiabing <wanjiabing@vivo.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
As I haven't sent a pull request yet, I will fix up the original commit in
renesas-clk-for-v5.19.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
