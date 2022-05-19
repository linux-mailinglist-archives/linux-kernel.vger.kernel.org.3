Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92C9452CC46
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 08:57:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234491AbiESG5Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 02:57:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230196AbiESG5T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 02:57:19 -0400
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF612B82FC;
        Wed, 18 May 2022 23:57:17 -0700 (PDT)
Received: by mail-qv1-f45.google.com with SMTP id p3so3974532qvi.7;
        Wed, 18 May 2022 23:57:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gzrS6T4UAb2qdEQgZu6k0oKZv56WgMPrYtSuPn3Y25Q=;
        b=jFiLap9aXNTvhYXJXo1Hxyh2Bte9gji9M8X6/SkfBjC3JCGBeXhaLDQiiE5rRexg1J
         klNhTMDbsYGC/xwVuFCxWxiq32q2O2BDj2wpb3vEdatQDjor5T7cOY9UWdZ6qXEBF2hb
         97aUgcsQrIVZT+ZNDMCLnkFk5TdK2wBch03Qo59D8l5JNRlef2DENm5AIHGILWlNhQlt
         jv2db7XFz/ArA58Obr8wsYAq2Cv8cgNq0+n3tmE/1rPD55+A8Ll9NGHd5Wsd19sfhTO/
         hAxH3fzcNGbszd52JR12pvpfJAo4Hf3/Vk9w/9r3oXjrQgduGC74k35+CFh28Tj+LZLb
         ltPw==
X-Gm-Message-State: AOAM532kKKPjiT3cAET89VqZ9MqJmwgC14dKMcjUD8CfqR6VkLhCO3p4
        a9ip598QJvUyL/zAALNAhvyHol9ge4U77g==
X-Google-Smtp-Source: ABdhPJw40O7odwSm9eb02Fn6l0eXoIYMGrs5cm4NVMarN4tUGw4k7x9oc4ZnTp+FbX3lcuUiqdOFEA==
X-Received: by 2002:ad4:5dcf:0:b0:461:fef4:c2de with SMTP id m15-20020ad45dcf000000b00461fef4c2demr573656qvh.28.1652943436850;
        Wed, 18 May 2022 23:57:16 -0700 (PDT)
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com. [209.85.219.170])
        by smtp.gmail.com with ESMTPSA id ci19-20020a05622a261300b002f39b99f6aasm866223qtb.68.2022.05.18.23.57.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 May 2022 23:57:16 -0700 (PDT)
Received: by mail-yb1-f170.google.com with SMTP id r1so7429846ybo.7;
        Wed, 18 May 2022 23:57:16 -0700 (PDT)
X-Received: by 2002:a25:e7ce:0:b0:64d:6028:96b9 with SMTP id
 e197-20020a25e7ce000000b0064d602896b9mr2858277ybh.365.1652943435982; Wed, 18
 May 2022 23:57:15 -0700 (PDT)
MIME-Version: 1.0
References: <20220505193143.31826-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20220505193143.31826-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <CAMuHMdX0egGvyu94-=tJdvW0=q6Y==ZNkexCJpnmrNJezuiqDw@mail.gmail.com> <CA+V-a8sxZOZRXG_gsCnQGJdNDw-uVLmuTZ-dOsmUfhS9KL0Esg@mail.gmail.com>
In-Reply-To: <CA+V-a8sxZOZRXG_gsCnQGJdNDw-uVLmuTZ-dOsmUfhS9KL0Esg@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 19 May 2022 08:57:04 +0200
X-Gmail-Original-Message-ID: <CAMuHMdW0hbVnCcbcC5E8J7Jc_UZPVSpHkmtPd3Haio-WnhhbpQ@mail.gmail.com>
Message-ID: <CAMuHMdW0hbVnCcbcC5E8J7Jc_UZPVSpHkmtPd3Haio-WnhhbpQ@mail.gmail.com>
Subject: Re: [RFC PATCH 1/4] dt-bindings: clock: r9a07g043-cpg: Add Renesas
 RZ/Five CPG Clock and Reset Definitions
To:     "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Cc:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Phil Edworthy <phil.edworthy@renesas.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Prabhakar,

On Thu, May 19, 2022 at 7:45 AM Lad, Prabhakar
<prabhakar.csengg@gmail.com> wrote:
> On Tue, May 10, 2022 at 3:02 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > On Thu, May 5, 2022 at 9:32 PM Lad Prabhakar
> > <prabhakar.mahadev-lad.rj@bp.renesas.com> wrote:
> > > Renesas RZ/Five SoC has almost the same clock structure compared to the
> > > Renesas RZ/G2UL SoC, re-use the r9a07g043-cpg.h header file and just
> > > ammend the RZ/Five CPG clock and reset definitions.
> >
> > > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> >
> > > --- a/include/dt-bindings/clock/r9a07g043-cpg.h
> > > +++ b/include/dt-bindings/clock/r9a07g043-cpg.h
> > > @@ -108,6 +108,15 @@
> > >  #define R9A07G043_ADC_ADCLK            76
> > >  #define R9A07G043_ADC_PCLK             77
> > >  #define R9A07G043_TSU_PCLK             78
> > > +#define R9A07G043_NCEPLDM_DM_CLK       79      /* RZ/Five Only */
> >
> > While NCEPLDM_DM_CLK is listed in the clock list spreadsheet, its
> > control bit is not documented.
> >
> > > +#define R9A07G043_NCEPLDM_ACLK         80      /* RZ/Five Only */
> > > +#define R9A07G043_NCEPLDM_TCK          81      /* RZ/Five Only */
> >
> > While NCEPLDM_TCK is listed in the clock list spreadsheet, its
> > control bit is not documented.
> >
> I have got the feedback for the above, NCEPLDM_DM_CLK and NCEPLDM_TCK
> clocks cannot be stopped as a result there are no register bits for it
> in the HW manual (clock spreadsheet will be updated). I will drop this
> and send a v2 including your RB.

The question is not if the clocks can be stopped or not, but if there
is any need to refer to them from a DT node.
What's the nature of the future update to the clock spreadsheet?

Of course, if we don't add these clock definitions now, they can
still be added later. DT binding definitions are append-only.

Thanks!

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
