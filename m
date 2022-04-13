Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E4C34FF25C
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 10:43:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233940AbiDMIoR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 04:44:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233330AbiDMIoP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 04:44:15 -0400
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 108234ECD9;
        Wed, 13 Apr 2022 01:41:55 -0700 (PDT)
Received: by mail-qv1-f53.google.com with SMTP id b17so1052920qvf.12;
        Wed, 13 Apr 2022 01:41:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EvuJzQp96B8cTDCcG+qyKDAB37NSc3zpMTaTjtbLzLE=;
        b=l2/9tgmUxRwiW999l7KguZ00THK6zjctwfXGJMdpOivvF7CUVb0KzwuXDtKkFyhnxe
         Wi06Ty3kuMm2j6y84DsuGrpx93tJjnxVmtQPcFCa5LG36vpLneW295eeHdpZ/atVNLUK
         jyazwzEnv4NujCQvaruON53yYnNt/Rn2Rt87A76mFuYJ4L12kn2D3MSPERjZ/tzkn1vk
         547BWr3QTqigrVIkRbo+KIkcUEu3VFnL1aGJi+pK5Q1iUK0Su7GulitAV/792zmhcLIA
         nYR7J8j0QLWhwbxYQ+wpj4cwOw76K5Bpy2IzZWwyV937m9K/3yFvxx1v9Pz3fSP5djKY
         IVvQ==
X-Gm-Message-State: AOAM5301PTUMH3MS6gBjulws91Yzqw5OQHKINnctLzp8V/N9tBaF1RfZ
        nKl2xr7Fk5+nppiFpJqxVJunkSB5l8yX6w==
X-Google-Smtp-Source: ABdhPJx9ya1mQHKDfyW8AwxGfWcbKOim0OH7ofB6ErYY3UYx3M4I3VKsymiAEM213cBkRqyy2ucmJg==
X-Received: by 2002:a05:6214:2421:b0:444:3fa7:716e with SMTP id gy1-20020a056214242100b004443fa7716emr13446567qvb.43.1649839313998;
        Wed, 13 Apr 2022 01:41:53 -0700 (PDT)
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com. [209.85.128.176])
        by smtp.gmail.com with ESMTPSA id b126-20020a37b284000000b0069a11927e57sm10459028qkf.101.2022.04.13.01.41.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Apr 2022 01:41:53 -0700 (PDT)
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-2eba37104a2so14963417b3.0;
        Wed, 13 Apr 2022 01:41:53 -0700 (PDT)
X-Received: by 2002:a81:413:0:b0:2ec:31d7:7e60 with SMTP id
 19-20020a810413000000b002ec31d77e60mr10993822ywe.62.1649839313333; Wed, 13
 Apr 2022 01:41:53 -0700 (PDT)
MIME-Version: 1.0
References: <1649837953-10984-1-git-send-email-baihaowen@meizu.com>
In-Reply-To: <1649837953-10984-1-git-send-email-baihaowen@meizu.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 13 Apr 2022 10:41:42 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXcNBq5e6K6YUorLCF0hiFsp6VVKrUcy5E4mdAQAbH7Sg@mail.gmail.com>
Message-ID: <CAMuHMdXcNBq5e6K6YUorLCF0hiFsp6VVKrUcy5E4mdAQAbH7Sg@mail.gmail.com>
Subject: Re: [PATCH V2] clk: renesas: Fix memory leak of 'cpg'
To:     Haowen Bai <baihaowen@meizu.com>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
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

Hi Haowen,

On Wed, Apr 13, 2022 at 10:30 AM Haowen Bai <baihaowen@meizu.com> wrote:
> Fix this issue by freeing the cpg when exiting the function in the
> error/normal path.
>
> Signed-off-by: Haowen Bai <baihaowen@meizu.com>

Thanks for your patch!

> --- a/drivers/clk/renesas/clk-r8a73a4.c
> +++ b/drivers/clk/renesas/clk-r8a73a4.c
> @@ -215,7 +215,7 @@ static void __init r8a73a4_cpg_clocks_init(struct device_node *np)
>
>         cpg->reg = of_iomap(np, 0);
>         if (WARN_ON(cpg->reg == NULL))
> -               return;
> +               goto out_free_cpg;

Note that this is a fatal error, i.e. no chance the system will survive this,
so cleaning up is moot.

>
>         for (i = 0; i < num_clks; ++i) {
>                 const char *name;
> @@ -233,6 +233,9 @@ static void __init r8a73a4_cpg_clocks_init(struct device_node *np)
>         }
>
>         of_clk_add_provider(np, of_clk_src_onecell_get, &cpg->data);
> +out_free_cpg:
> +       kfree(cpg);
> +       kfree(clks);

Both cpg and clks are still used after returning from this function,
through the registered clocks and clock provider.

>  }
>  CLK_OF_DECLARE(r8a73a4_cpg_clks, "renesas,r8a73a4-cpg-clocks",
>                r8a73a4_cpg_clocks_init);

NAKed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
