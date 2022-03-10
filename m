Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31DF74D46AC
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 13:18:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241929AbiCJMSE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 07:18:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241990AbiCJMSB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 07:18:01 -0500
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 009C2136EE0;
        Thu, 10 Mar 2022 04:17:00 -0800 (PST)
Received: by mail-qv1-f51.google.com with SMTP id eq14so4344169qvb.3;
        Thu, 10 Mar 2022 04:17:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xfvrxYj0IL4efWC8i+iJcHTNZuPckG62QyK4wQ8esU8=;
        b=H+GAejYNYnbRR4VfGoNJwXQ9i637j6f2jUqWa5KaWm8FGvCbvy8H0qBMnIhLGGtHtM
         a4hk0lk1PxKIOt1HIMYpAMLhNFHJE8cStFaaFhKZ50Limsq3jkepqIIEbiX6L8X6aKSD
         Vpn1FgLFdUmPlJID8GtHetZvTcZ2ZIuY3lMYR89DpCjzHNm2EgqTP1GsY1KKvWencigb
         9PujE13Nt9ZC2Q+nqOLt23msLUOgrfhCkEwpN06d01m92Ruali6wfMjJrG4nIyvgNcx5
         eGwetsUJDUXRJM04NpzAAG/1R+EN1Ro3pNBkB7F/KzhX9N+IdVsbRSzTr7W7ZN/7O+5H
         q9+Q==
X-Gm-Message-State: AOAM530yIRuaFadPiedUwWhbLVOVGp9ME4IU6NG66vXB475t4kfrZluJ
        A0arJ6+EzSIWOq54CTtEjH6pkqfePVWVJA==
X-Google-Smtp-Source: ABdhPJwqtnMqXfh5YIg7IanvOzObmHeGJKI9VrMd4EKQojVrSQ9EBM/TOSKMdgJsov+/O0ErOD8A4A==
X-Received: by 2002:a05:6214:23c6:b0:433:8a2:c244 with SMTP id hr6-20020a05621423c600b0043308a2c244mr3488124qvb.88.1646914619686;
        Thu, 10 Mar 2022 04:16:59 -0800 (PST)
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com. [209.85.128.171])
        by smtp.gmail.com with ESMTPSA id v9-20020a05622a144900b002dfedb4dccasm3099803qtx.66.2022.03.10.04.16.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Mar 2022 04:16:57 -0800 (PST)
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-2dc0364d2ceso55429527b3.7;
        Thu, 10 Mar 2022 04:16:57 -0800 (PST)
X-Received: by 2002:a81:6dd1:0:b0:2dc:56d1:1dae with SMTP id
 i200-20020a816dd1000000b002dc56d11daemr3528698ywc.479.1646914617228; Thu, 10
 Mar 2022 04:16:57 -0800 (PST)
MIME-Version: 1.0
References: <20220310090048.1933020-1-laurent@vivier.eu> <20220310090048.1933020-4-laurent@vivier.eu>
In-Reply-To: <20220310090048.1933020-4-laurent@vivier.eu>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 10 Mar 2022 13:16:45 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWLt4Q_TtGhOreW1kMjo0uLL3H5UKjaK8SXGo5dQUO+Tw@mail.gmail.com>
Message-ID: <CAMuHMdWLt4Q_TtGhOreW1kMjo0uLL3H5UKjaK8SXGo5dQUO+Tw@mail.gmail.com>
Subject: Re: [PATCH v15 3/5] rtc: goldfish: use gf_ioread32()/gf_iowrite32()
To:     Laurent Vivier <laurent@vivier.eu>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-rtc@vger.kernel.org, Stephen Boyd <sboyd@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        John Stultz <john.stultz@linaro.org>
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

On Thu, Mar 10, 2022 at 10:01 AM Laurent Vivier <laurent@vivier.eu> wrote:
> replace readl()/writel() by gf_ioread32()/gf_iowrite32()
> as done for goldfish-tty.
>
> Signed-off-by: Laurent Vivier <laurent@vivier.eu>

Please include tags given on previous versions:
Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>
Acked-by: Alexandre Belloni <alexandre.belloni@bootlin.com>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
