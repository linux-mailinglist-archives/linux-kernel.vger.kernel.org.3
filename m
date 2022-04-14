Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8FD75009F3
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 11:33:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241833AbiDNJff (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 05:35:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241821AbiDNJfd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 05:35:33 -0400
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A81B70CFE;
        Thu, 14 Apr 2022 02:33:09 -0700 (PDT)
Received: by mail-qv1-f49.google.com with SMTP id x20so3561396qvl.10;
        Thu, 14 Apr 2022 02:33:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wT+WD+e2d8eELH39rVnQiOaRvZ4T5k/ulSuMocFHoO0=;
        b=WCb9CrYNMnvknLjmJwx8d833KEzkGJe4PnAHE7TCjTDSf0aCHRfms6+riyfWTZ9IkR
         W7RjgrAfJb4s0g/8aFg9owovC6epCc5kWjxfMxyP+HXlx6sDS8T+PmNojmA0Y6vlKmxQ
         Q+Oe89ItNITf0JTsUV2eUuWQ1eCmzK6mfzR7KBWOuya072kjp1L9RrBp0Ol0h57YgmwK
         m6HFX8bgOWCHhnBMa9MO6mU/ZIcYMSpGaLe4yc6yOy/UI1mB0idMewg+A5i8DhyeSrmW
         aIvXc7IFfmXEjSDxNn8efhH5PUFf5lHpTlVCMgjyeAWlRsqI9y1gKkQPlJiasL0PXAJh
         YYNA==
X-Gm-Message-State: AOAM533IotIdoaij04ZjaeS+PXsoAJjhc74td0kuQAJbdMPUCQnmJ0kl
        w8YfLu9VFDmyJEkBprqP+42wL1+o13L26g==
X-Google-Smtp-Source: ABdhPJw5tZPsLUiQ2CSgHvWEiXMmwLaJ/6vrs6oVMrssBXG/3CdZRSW6P5v8eqcYZuNQfypJ0J5qLQ==
X-Received: by 2002:a05:6214:20e9:b0:441:527f:dffa with SMTP id 9-20020a05621420e900b00441527fdffamr2507246qvk.34.1649928787542;
        Thu, 14 Apr 2022 02:33:07 -0700 (PDT)
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com. [209.85.128.177])
        by smtp.gmail.com with ESMTPSA id 193-20020a3703ca000000b0069bf950dd20sm740384qkd.43.2022.04.14.02.33.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Apr 2022 02:33:07 -0700 (PDT)
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-2ebebe631ccso49265497b3.4;
        Thu, 14 Apr 2022 02:33:06 -0700 (PDT)
X-Received: by 2002:a81:4782:0:b0:2eb:1cb1:5441 with SMTP id
 u124-20020a814782000000b002eb1cb15441mr1147758ywa.479.1649928786553; Thu, 14
 Apr 2022 02:33:06 -0700 (PDT)
MIME-Version: 1.0
References: <1649837953-10984-1-git-send-email-baihaowen@meizu.com> <2ed01eb3-ff46-425c-75dc-81729a5c30a8@omp.ru>
In-Reply-To: <2ed01eb3-ff46-425c-75dc-81729a5c30a8@omp.ru>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 14 Apr 2022 11:32:55 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVCRRbhYEnk4bjvPugrosw4mNQCcHQqsNrx0RhFL+dJDQ@mail.gmail.com>
Message-ID: <CAMuHMdVCRRbhYEnk4bjvPugrosw4mNQCcHQqsNrx0RhFL+dJDQ@mail.gmail.com>
Subject: Re: [PATCH V2] clk: renesas: Fix memory leak of 'cpg'
To:     Sergey Shtylyov <s.shtylyov@omp.ru>
Cc:     Haowen Bai <baihaowen@meizu.com>,
        Michael Turquette <mturquette@baylibre.com>,
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

Hi Sergei,

On Thu, Apr 14, 2022 at 11:29 AM Sergey Shtylyov <s.shtylyov@omp.ru> wrote:
> On 4/13/22 11:19 AM, Haowen Bai wrote:
> > Fix this issue by freeing the cpg when exiting the function in the
> > error/normal path.
> >
> > Signed-off-by: Haowen Bai <baihaowen@meizu.com>
> > ---
> > V1->V2: free both cpg&clks.
> >
> >  drivers/clk/renesas/clk-r8a73a4.c | 5 ++++-
> >  1 file changed, 4 insertions(+), 1 deletion(-)
>
>    2 patches with the same name won't do -- you always need to include the chip name
> part of the file name in the subject (in this case r8a73a4).

Oh, they were for multiple drivers?
I hadn't even noticed , as Gmail collapsed them all into the same thread...

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
