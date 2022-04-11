Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 274FC4FC177
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 17:50:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348280AbiDKPwy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 11:52:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348265AbiDKPws (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 11:52:48 -0400
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0336710F9;
        Mon, 11 Apr 2022 08:50:34 -0700 (PDT)
Received: by mail-qv1-f41.google.com with SMTP id y19so1619363qvk.5;
        Mon, 11 Apr 2022 08:50:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SVb5BcZzBrrdvju5vTaDEqBtUthWOli6gJ+6pTxlf68=;
        b=6+lysK8aYFQ5EFA11b4ujl6WEwBJpiFkL1he+Vv2umhovMiWhCNtobGX/F/YRsh0vQ
         DMceFi8l4kZnjj5MMhQhg8jcHscOIzDjXb283qKzcKjOkpKKqHKtz7iRbXGGAo8PvggT
         GmD/vJgCuD+fVldb5hLGPoVbqL/SpZ1Rx2JbIS9R5mIixUwoMErMXZGV0u5RNsNcaZgr
         iNFBkVgakbeyLwn2wp7K+5mPcPvO8U9uV6xPNKjF5uJLy1pXb6JoUt7qR4SOrdxXeG5R
         di7bR4CVsyY26D25f6YVcH6jspuMDvkpuAn+i8X/zkXXXf1ygJyl+HQWLwEruRjrRa/B
         Q6dQ==
X-Gm-Message-State: AOAM532MdDuxLNwJP+gDZvC1NBPuC68KQxkEcPRgujbkqyZRWGamhyFX
        oI2Siazx6ci6bdTC/qYTrNs4jLc0a21Few==
X-Google-Smtp-Source: ABdhPJx3qbNtUUQ70J/aUkn8WHaTH1x5f1MGWsRMnsMbuPzAkA3Lv7Qu0jzyQzJIuWmm7Ha+lkJM2A==
X-Received: by 2002:ad4:5dc9:0:b0:441:56ad:8d93 with SMTP id m9-20020ad45dc9000000b0044156ad8d93mr26864265qvh.76.1649692233023;
        Mon, 11 Apr 2022 08:50:33 -0700 (PDT)
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com. [209.85.219.171])
        by smtp.gmail.com with ESMTPSA id u187-20020a3792c4000000b0067e679cfe5asm19440807qkd.59.2022.04.11.08.50.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Apr 2022 08:50:32 -0700 (PDT)
Received: by mail-yb1-f171.google.com with SMTP id t67so11434873ybi.2;
        Mon, 11 Apr 2022 08:50:32 -0700 (PDT)
X-Received: by 2002:a05:6902:101:b0:633:ccde:cfca with SMTP id
 o1-20020a056902010100b00633ccdecfcamr22352056ybh.207.1649692232274; Mon, 11
 Apr 2022 08:50:32 -0700 (PDT)
MIME-Version: 1.0
References: <20220406072417.14185-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20220406072417.14185-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 11 Apr 2022 17:50:21 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUNPmhxTADmdWVqw0fox0UsiLpFj_X_s7aBphCLfoK4Qg@mail.gmail.com>
Message-ID: <CAMuHMdUNPmhxTADmdWVqw0fox0UsiLpFj_X_s7aBphCLfoK4Qg@mail.gmail.com>
Subject: Re: [PATCH] clocksource/drivers/renesas-ostm: Add support for RZ/V2L SoC
To:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>
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

On Wed, Apr 6, 2022 at 9:31 AM Lad Prabhakar
<prabhakar.mahadev-lad.rj@bp.renesas.com> wrote:
> The OSTM block is identical on Renesas RZ/G2L and RZ/V2L SoC's, so instead
> of adding dependency for each SoC's add dependency on ARCH_RZG2L. The
> ARCH_RZG2L config option is already selected by ARCH_R9A07G044 and
> ARCH_R9A07G054.
>
> With the above change OSTM will be enabled on RZ/V2L SoC.
>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
