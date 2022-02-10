Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 182754B0E29
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 14:12:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242018AbiBJNLZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 08:11:25 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:45572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238484AbiBJNLT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 08:11:19 -0500
Received: from mail-ua1-f48.google.com (mail-ua1-f48.google.com [209.85.222.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 415D710C8;
        Thu, 10 Feb 2022 05:11:20 -0800 (PST)
Received: by mail-ua1-f48.google.com with SMTP id f13so2959560uab.10;
        Thu, 10 Feb 2022 05:11:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VyfL/XR3k1yiplw7IJLRPirPvVisKMbHbKr+Yiu87oY=;
        b=TIa8vkc7c18R0sEPrKqzRjcsms8qgc9M9VM1+9uaHWklEUjzgpMdf/4PrS8KA1lFZ0
         A28RUL6X7iAJO530SjbiHSk4DdVxDcSy3KEVl7qOCIc1SqGl0GB8NsI4Yb12MGFCeh1O
         Y67BSUVvGQqLJWKZ8ZUjRZTXOsoGB+ovau3k8wJ8xGX+i5VsNk+nh8gzw4kuT8pmaxO8
         QDJCgYpaSUlYcCqwqU8fabmqtWcvbwqpXLoTjNIa13YWP5NyPBKqCFtqgCFFoE76rwoe
         KMQIbi0dOkRSSX7fkZkw3vXFSbVXtzhNBTZZIaZHthPBGzZxvmiXsJbThU+g+nGIQweF
         V3JQ==
X-Gm-Message-State: AOAM531j7ZLestYJCb1/NMmoAbe1rWWon0FlrYFquE9e6pYuRoMZudQy
        ngjNZlOt8CPqxbV1/baLWVWsDYQsXMAM6w==
X-Google-Smtp-Source: ABdhPJy7Fu5D4Ol/VaNPnTMyRH1ygjc8dZU38N1m+55rF0MwbouiH/LrOyN/g0VEbHObZzAxgbXkyQ==
X-Received: by 2002:ab0:6156:: with SMTP id w22mr2303172uan.61.1644498679204;
        Thu, 10 Feb 2022 05:11:19 -0800 (PST)
Received: from mail-vs1-f49.google.com (mail-vs1-f49.google.com. [209.85.217.49])
        by smtp.gmail.com with ESMTPSA id 3sm1077055vkf.16.2022.02.10.05.11.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Feb 2022 05:11:18 -0800 (PST)
Received: by mail-vs1-f49.google.com with SMTP id t22so6316536vsa.4;
        Thu, 10 Feb 2022 05:11:18 -0800 (PST)
X-Received: by 2002:a67:c198:: with SMTP id h24mr2420776vsj.5.1644498677998;
 Thu, 10 Feb 2022 05:11:17 -0800 (PST)
MIME-Version: 1.0
References: <20220130143333.552646-1-laurent@vivier.eu> <20220130143333.552646-4-laurent@vivier.eu>
In-Reply-To: <20220130143333.552646-4-laurent@vivier.eu>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 10 Feb 2022 14:11:07 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUorQNkEfYfnkme8MzA2pMP1gogQSTMhAywSPFiZUSCuA@mail.gmail.com>
Message-ID: <CAMuHMdUorQNkEfYfnkme8MzA2pMP1gogQSTMhAywSPFiZUSCuA@mail.gmail.com>
Subject: Re: [PATCH v14 3/5] rtc: goldfish: use gf_ioread32()/gf_iowrite32()
To:     Laurent Vivier <laurent@vivier.eu>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-rtc@vger.kernel.org,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Stephen Boyd <sboyd@kernel.org>,
        John Stultz <john.stultz@linaro.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>
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

On Sun, Jan 30, 2022 at 3:33 PM Laurent Vivier <laurent@vivier.eu> wrote:
> replace readl()/writel() by gf_ioread32()/gf_iowrite32()
> as done for goldfish-tty.
>
> Signed-off-by: Laurent Vivier <laurent@vivier.eu>

Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
