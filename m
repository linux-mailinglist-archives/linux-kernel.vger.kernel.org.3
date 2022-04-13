Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A2454FF5A5
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 13:24:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235078AbiDML0b convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 13 Apr 2022 07:26:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbiDML02 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 07:26:28 -0400
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 527A3433A3;
        Wed, 13 Apr 2022 04:24:07 -0700 (PDT)
Received: by mail-qv1-f52.google.com with SMTP id n11so1378426qvl.0;
        Wed, 13 Apr 2022 04:24:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=7S4lgK2QrO8fzXxW9jJpjJIpoGOl0SicN1VsO2+FA3g=;
        b=NB5Vh5qypxdnz8rUJben7tiWr7Fdk8NKoc24kuiC47s79Pd5y/MDXdYejcX/Hi22Vc
         pvodS9+S3F8Cb9qywm6IHkEMn5K+T2vKtbEH6zsWblcjgebNmNr3jBroFhL2DEFY5khK
         OvdH8nudEa7bgV+/ZvoKlcoSFVEW5ijS9KXMETgGTZeVQQIV/acH3xwjINkLcYcNtfLb
         LPyglBZK3Uia3dafAKVZg1QEecklZSJ88o0/7SkHBkEq7z8RYl6KnWESUGZoV+hGp761
         g8yOI0rhrDHTJbKmmiKlUfqwrpHIkVoosvTbRFQJdWqJAJk1v1v/tq+mc2AqtpbSKsPU
         rhDw==
X-Gm-Message-State: AOAM5319AJgnOi9OSDRFQgcl/1F4UHfvxoA8WCuFlR8XVw6Ehw94E/Yx
        6AYDdpCy+CM6Uud57AcRVEPwj5Jdu9Jk8A==
X-Google-Smtp-Source: ABdhPJwtYLWiUMzC+O2absxiP07jcQrLBSSDocYeIG88C36l1YN3LV+nIAkszOohiwKJ7NRrvkI6dA==
X-Received: by 2002:a05:6214:1c85:b0:443:8347:d7a5 with SMTP id ib5-20020a0562141c8500b004438347d7a5mr7835672qvb.11.1649849046180;
        Wed, 13 Apr 2022 04:24:06 -0700 (PDT)
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com. [209.85.128.180])
        by smtp.gmail.com with ESMTPSA id d15-20020a05622a15cf00b002ef31d86837sm5401917qty.55.2022.04.13.04.24.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Apr 2022 04:24:05 -0700 (PDT)
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-2ef5380669cso1457727b3.9;
        Wed, 13 Apr 2022 04:24:05 -0700 (PDT)
X-Received: by 2002:a81:618b:0:b0:2db:d952:8a39 with SMTP id
 v133-20020a81618b000000b002dbd9528a39mr34095306ywb.132.1649849045399; Wed, 13
 Apr 2022 04:24:05 -0700 (PDT)
MIME-Version: 1.0
References: <8dvhtgydaq7tflf8q4rq4fpu.1649846600874@email.android.com>
In-Reply-To: <8dvhtgydaq7tflf8q4rq4fpu.1649846600874@email.android.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 13 Apr 2022 13:23:54 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXkUKD_+A2B6-x0C5SSva6fr2Ht0N73t9gboOBp5z13xw@mail.gmail.com>
Message-ID: <CAMuHMdXkUKD_+A2B6-x0C5SSva6fr2Ht0N73t9gboOBp5z13xw@mail.gmail.com>
Subject: Re: [PATCH V2] clk: renesas: Fix memory leak of 'cpg'
To:     =?UTF-8?B?55m95rWp5paH?= <baihaowen@meizu.com>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Haowen,

On Wed, Apr 13, 2022 at 12:44 PM 白浩文 <baihaowen@meizu.com> wrote:
> But this function __init r8a73a4_cpg_clocks_init will auto free by system after boot

The memory containing the code for the function
r8a73a4_cpg_clocks_init() will indeed be freed.  But the data
structures allocated and prepared by the function will continue to
exist afterwards.

> On Wed, Apr 13, 2022 at 11:24 AM baihaowen <baihaowen@meizu.com> wrote:
> > 在 4/13/22 4:41 PM, Geert Uytterhoeven 写道:
> > > On Wed, Apr 13, 2022 at 10:30 AM Haowen Bai <baihaowen@meizu.com> wrote:
> > >> Fix this issue by freeing the cpg when exiting the function in the
> > >> error/normal path.
> > >>
> > >> Signed-off-by: Haowen Bai <baihaowen@meizu.com>

> > >> --- a/drivers/clk/renesas/clk-r8a73a4.c
> > >> +++ b/drivers/clk/renesas/clk-r8a73a4.c
> > >> @@ -215,7 +215,7 @@ static void __init r8a73a4_cpg_clocks_init(struct device_node *np)
> > >>
> > >>         cpg->reg = of_iomap(np, 0);
> > >>         if (WARN_ON(cpg->reg == NULL))
> > >> -               return;
> > >> +               goto out_free_cpg;
> > > Note that this is a fatal error, i.e. no chance the system will survive this,
> > > so cleaning up is moot.
> > >
> > >>         for (i = 0; i < num_clks; ++i) {
> > >>                 const char *name;
> > >> @@ -233,6 +233,9 @@ static void __init r8a73a4_cpg_clocks_init(struct device_node *np)
> > >>         }
> > >>
> > >>         of_clk_add_provider(np, of_clk_src_onecell_get, &cpg->data);
> > >> +out_free_cpg:
> > >> +       kfree(cpg);
> > >> +       kfree(clks);
> > > Both cpg and clks are still used after returning from this function,
> > > through the registered clocks and clock provider.
> > >
> > >>  }
> > >>  CLK_OF_DECLARE(r8a73a4_cpg_clks, "renesas,r8a73a4-cpg-clocks",
> > >>                r8a73a4_cpg_clocks_init);
> > > NAKed-by: Geert Uytterhoeven <geert+renesas@glider.be>
>
> > Could you show me how and when cpg & clks free ?
>
> They are never freed, as they stay in-use for the lifetime of the system.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
