Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CB4A4FF4FC
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 12:41:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234982AbiDMKm3 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 13 Apr 2022 06:42:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229866AbiDMKm0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 06:42:26 -0400
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5935F532F0;
        Wed, 13 Apr 2022 03:40:05 -0700 (PDT)
Received: by mail-qt1-f182.google.com with SMTP id ay4so1013122qtb.11;
        Wed, 13 Apr 2022 03:40:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ylLDxaJE5bKp2Ipxy025DYGxQ1jbgF00xKv8pZHsTdY=;
        b=oz3fr6RZJToVCHHEOSV+FDoSpSVpzuTIeEprD6AL3ex7sZNTzpgBV3+KN7pn88Vm+I
         MmtKFaup9QRd+Ywh/9Ik8TxVnZ5MiXHKxt2AluI9GCGZh0A5c+vMqatvCqOrAstZjM33
         04aHApUOwZ6JIwEyFDotYjrYLuZkn8ut9UtnYfcsMhbkCs68CtCCJwVQYFyecw3qgko4
         ImNPqZNJcbF8TjoZZlX+Z4XB0o4IR4rZN0znVTBfTzgXCNS6ehbbd5pNXjMOzrcOFvlK
         Rs4PnvH7zj/LxZnR9k65WATjvtdBgAJdBipek1FIUZfzl/HtQSkP0PNRwCtkBMEkPXS2
         MXvw==
X-Gm-Message-State: AOAM530Y5xrMPiXVVK2J0ev9ezhBgz8iMPN2gY7BogP7Co6gZbcoFi/6
        ym0HoI0RLvXM7IZS0Ycf0oj1p+iP3XbQng==
X-Google-Smtp-Source: ABdhPJxlBHQoxHZD+N1yJYgP31YtHLyWImF4n3aA4oaKWznUkwgku3IFHnm0aXxg9rHYifEaMkL/qA==
X-Received: by 2002:a05:622a:1447:b0:2e1:c405:b05b with SMTP id v7-20020a05622a144700b002e1c405b05bmr6688814qtx.626.1649846404071;
        Wed, 13 Apr 2022 03:40:04 -0700 (PDT)
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com. [209.85.219.181])
        by smtp.gmail.com with ESMTPSA id i137-20020a379f8f000000b0069befb1e28fsm8559784qke.97.2022.04.13.03.40.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Apr 2022 03:40:03 -0700 (PDT)
Received: by mail-yb1-f181.google.com with SMTP id f38so2952916ybi.3;
        Wed, 13 Apr 2022 03:40:03 -0700 (PDT)
X-Received: by 2002:a5b:24e:0:b0:63d:cba0:3d55 with SMTP id
 g14-20020a5b024e000000b0063dcba03d55mr28271889ybp.613.1649846403436; Wed, 13
 Apr 2022 03:40:03 -0700 (PDT)
MIME-Version: 1.0
References: <1649837953-10984-1-git-send-email-baihaowen@meizu.com>
 <CAMuHMdXcNBq5e6K6YUorLCF0hiFsp6VVKrUcy5E4mdAQAbH7Sg@mail.gmail.com> <05f14aa0-4001-d08d-610e-12749437ec9a@meizu.com>
In-Reply-To: <05f14aa0-4001-d08d-610e-12749437ec9a@meizu.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 13 Apr 2022 12:39:52 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWa6fhG3Bmfeqo+FLbapqXAb+kYsXrM9wq5OAfBTrkbGg@mail.gmail.com>
Message-ID: <CAMuHMdWa6fhG3Bmfeqo+FLbapqXAb+kYsXrM9wq5OAfBTrkbGg@mail.gmail.com>
Subject: Re: [PATCH V2] clk: renesas: Fix memory leak of 'cpg'
To:     baihaowen <baihaowen@meizu.com>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
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

Hi Haowen,

On Wed, Apr 13, 2022 at 11:24 AM baihaowen <baihaowen@meizu.com> wrote:
> 在 4/13/22 4:41 PM, Geert Uytterhoeven 写道:
> > On Wed, Apr 13, 2022 at 10:30 AM Haowen Bai <baihaowen@meizu.com> wrote:
> >> Fix this issue by freeing the cpg when exiting the function in the
> >> error/normal path.
> >>
> >> Signed-off-by: Haowen Bai <baihaowen@meizu.com>
> > Thanks for your patch!
> >
> >> --- a/drivers/clk/renesas/clk-r8a73a4.c
> >> +++ b/drivers/clk/renesas/clk-r8a73a4.c
> >> @@ -215,7 +215,7 @@ static void __init r8a73a4_cpg_clocks_init(struct device_node *np)
> >>
> >>         cpg->reg = of_iomap(np, 0);
> >>         if (WARN_ON(cpg->reg == NULL))
> >> -               return;
> >> +               goto out_free_cpg;
> > Note that this is a fatal error, i.e. no chance the system will survive this,
> > so cleaning up is moot.
> >
> >>         for (i = 0; i < num_clks; ++i) {
> >>                 const char *name;
> >> @@ -233,6 +233,9 @@ static void __init r8a73a4_cpg_clocks_init(struct device_node *np)
> >>         }
> >>
> >>         of_clk_add_provider(np, of_clk_src_onecell_get, &cpg->data);
> >> +out_free_cpg:
> >> +       kfree(cpg);
> >> +       kfree(clks);
> > Both cpg and clks are still used after returning from this function,
> > through the registered clocks and clock provider.
> >
> >>  }
> >>  CLK_OF_DECLARE(r8a73a4_cpg_clks, "renesas,r8a73a4-cpg-clocks",
> >>                r8a73a4_cpg_clocks_init);
> > NAKed-by: Geert Uytterhoeven <geert+renesas@glider.be>

> Could you show me how and when cpg & clks free ?

They are never freed, as they stay in-use for the lifetime of the system.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
