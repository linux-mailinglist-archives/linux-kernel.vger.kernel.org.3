Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9ADC5149E1
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 14:49:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359527AbiD2MxL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 08:53:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357892AbiD2MxI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 08:53:08 -0400
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10E68C9B75;
        Fri, 29 Apr 2022 05:49:50 -0700 (PDT)
Received: by mail-qt1-f178.google.com with SMTP id p4so5014054qtq.12;
        Fri, 29 Apr 2022 05:49:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4tqelAYwf2EnKhlkfmEW1Nniwpv4OsNQ/+Rpd0YuVJE=;
        b=QA7qD+Sc/Tn/d3TJwe1Y9P3uS55IzPjQOcT8Fr0DaXmY4HJo81BJ8nXOy4kwVFuBX3
         5GN5rKOGwOe37evzd4inH5bE6IlkyUPe51/axUolyIZrsQrpV29B70KjIulL+dU+Vwgc
         48iUWzVemWqRaa9Ha922A+7+LuJdHVUihYmzWlxXbgAqyOJCSJuOMMf9IUdG62bKJsuT
         ng8DFgKCRBoC7qawat1GD4PYoj7BodFMWeO8pzO/nDOt0osN8j4tqRuqA/40I/bbv2If
         lh17mHtixCY3Vr2qfV1mhPGHFDS+Q3/Oav0P7HqdP+8uR+/d4SoL7Pr9g2gXlXaRmV34
         3YOA==
X-Gm-Message-State: AOAM532w1wWr65QdXejVXS6EihZySKvgy//IpYDUNuLB1lYOVuTMIqeP
        2GB8VazRQiHWMQDZElpyI1QEqP4UWd7NFnmP
X-Google-Smtp-Source: ABdhPJzu1L3CKUQeA5EfpZv7o3ouJ05aOw/9erx+/iJuJw2JRbWwcuXwpozlkTeQoow8/m8lTJ2Htw==
X-Received: by 2002:ac8:5a81:0:b0:2f1:f20d:173a with SMTP id c1-20020ac85a81000000b002f1f20d173amr26622184qtc.686.1651236588942;
        Fri, 29 Apr 2022 05:49:48 -0700 (PDT)
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com. [209.85.128.180])
        by smtp.gmail.com with ESMTPSA id s16-20020ac85cd0000000b002e1ed82f1e5sm1834042qta.75.2022.04.29.05.49.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Apr 2022 05:49:48 -0700 (PDT)
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-2f83983782fso84025897b3.6;
        Fri, 29 Apr 2022 05:49:47 -0700 (PDT)
X-Received: by 2002:a81:e10d:0:b0:2f7:bb2a:6529 with SMTP id
 w13-20020a81e10d000000b002f7bb2a6529mr34597687ywh.62.1651236586925; Fri, 29
 Apr 2022 05:49:46 -0700 (PDT)
MIME-Version: 1.0
References: <20220428093355.16172-1-jiaxin.yu@mediatek.com>
 <CAMuHMdWYJofetMwkAH4d8UzKZH77hxwRhXrMhaECOs1suQV2PA@mail.gmail.com> <b90426905a486ab720b9d67f00ed869285acd768.camel@mediatek.com>
In-Reply-To: <b90426905a486ab720b9d67f00ed869285acd768.camel@mediatek.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 29 Apr 2022 14:49:35 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVA-JJqPB9fiUZSeXZR+fa58V5t2OQjaN1-JvGR+K_H4Q@mail.gmail.com>
Message-ID: <CAMuHMdVA-JJqPB9fiUZSeXZR+fa58V5t2OQjaN1-JvGR+K_H4Q@mail.gmail.com>
Subject: Re: [v4 00/18] ASoC: mediatek: Add support for MT8186 SoC
To:     Jiaxin Yu <jiaxin.yu@mediatek.com>
Cc:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, aaronyu@google.com,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Trevor Wu <trevor.wu@mediatek.com>,
        Tzung-Bi Shih <tzungbi@google.com>,
        Julian Braha <julianbraha@gmail.com>,
        ALSA Development Mailing List <alsa-devel@alsa-project.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-mediatek@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Project_Global_Chrome_Upstream_Group@mediatek.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jiaxin,

On Fri, Apr 29, 2022 at 11:32 AM Jiaxin Yu <jiaxin.yu@mediatek.com> wrote:
> On Fri, 2022-04-29 at 10:47 +0200, Geert Uytterhoeven wrote:
> > Gmail tends to mark your patches as spam.
> > Can you please make sure to use "PATCH" in the subject line, e.g.
> > "[PATCH v4 00/18] ASoC: mediatek: Add support for MT8186 SoC"?

> Sorry for this mistake, I usually use "git format-patch --subject-
> prefix "v4" --cover-letter -x" to generate a series of patches.
> So it automatically removes "PATCH". I will correct the cmd to "git
> format-patch --subject-prefix "PATCH v4" --cover-letter -x".

You can just use e.g. "-v4" instead of the --subject-prefix option.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
