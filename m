Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 141EB5469D2
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 17:51:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347752AbiFJPvI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 11:51:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344090AbiFJPvG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 11:51:06 -0400
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E846B49D;
        Fri, 10 Jun 2022 08:51:03 -0700 (PDT)
Received: by mail-qk1-f178.google.com with SMTP id 15so14971293qki.6;
        Fri, 10 Jun 2022 08:51:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=pWs4ss5mKp4GC86T6reEfw/x1pDguv6pIi7weRK02oM=;
        b=XIwn89P38zB+O8Uqadr+FSHnUKoGYSnZWmjT1lovdAtucdebfOjaE/tatJ+nqk7VkB
         4t0eLsjHc9EzUq+BgWSt0b8FhDIudR+YLPZMB+Z6/B5Ruv5xvPeaclLpTooBBJY8lmom
         GxKpabGmDoXBVVUvB5yxEK8YzBdEfYZ7lp55aXM/QxkF+7GBsME1tP22d+bnbrLFsl5m
         S4AJSVo/uAkaK8Marwa6LfiNihSl5HTeAjF2Zg6+QC6DqESAAhGW3mDAymw6ivS5E00U
         bNpCdZfX3hEArKfojfJEr88/9/8N269e/Xe50hFJGz78k16WiSvWM6R1wKGWmfsUkBft
         7h7w==
X-Gm-Message-State: AOAM5308LcUWu7z2CItdu8mFjrs3ajbdxi93Q9uqmclJx2FxtPelFisN
        UFSW2Clz4fjCBwgLzegoAeQM4rYGoLyUSA==
X-Google-Smtp-Source: ABdhPJwOHUt9VoIxC/igKBGKmkp+XHhZBnQYORU06dCCKsQPlyI90AIRucRqBLikFcysNV0b/pj04w==
X-Received: by 2002:a05:620a:2606:b0:6a7:1dd:1904 with SMTP id z6-20020a05620a260600b006a701dd1904mr9758897qko.106.1654876262399;
        Fri, 10 Jun 2022 08:51:02 -0700 (PDT)
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com. [209.85.219.182])
        by smtp.gmail.com with ESMTPSA id q6-20020a05620a0d8600b006a693e46d5csm20011769qkl.11.2022.06.10.08.51.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Jun 2022 08:51:01 -0700 (PDT)
Received: by mail-yb1-f182.google.com with SMTP id w2so47662953ybi.7;
        Fri, 10 Jun 2022 08:51:01 -0700 (PDT)
X-Received: by 2002:a25:d748:0:b0:65c:6b00:55af with SMTP id
 o69-20020a25d748000000b0065c6b0055afmr44087669ybg.365.1654876261202; Fri, 10
 Jun 2022 08:51:01 -0700 (PDT)
MIME-Version: 1.0
References: <20220609200709.4455-1-wsa+renesas@sang-engineering.com>
 <YqNAXofRPsDasXi4@oden.dyn.berto.se> <YqNBye5avNNQqQPm@shikoro>
In-Reply-To: <YqNBye5avNNQqQPm@shikoro>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 10 Jun 2022 17:50:49 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWfq5wpy0bj_yrdm_kNwS7K=X=7BTiE0GNrte4E_-niQw@mail.gmail.com>
Message-ID: <CAMuHMdWfq5wpy0bj_yrdm_kNwS7K=X=7BTiE0GNrte4E_-niQw@mail.gmail.com>
Subject: Re: [PATCH v2] thermal: rcar_gen3_thermal: improve logging during probe
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        =?UTF-8?Q?Niklas_S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Linux PM list <linux-pm@vger.kernel.org>,
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

Hi Wolfram,

On Fri, Jun 10, 2022 at 3:13 PM Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:
> > Bikeshedding, I'm not keen on this style as it makes it harder IMHO to
> > grep for log strings in the code. But I don't dislike it enough to ask
> > you to change it ;-) So if you and Geert are happy with this style,
>
> Seems reasonable to me, Geert what do you think?

I plead guilty, too, as my OCD cannot stand those plural/singular
mismatches ;-)

But Niklas does have a valid point...

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
