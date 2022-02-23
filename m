Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15C914C0D82
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 08:45:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238660AbiBWHpa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 02:45:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230154AbiBWHp2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 02:45:28 -0500
Received: from mail-vs1-f43.google.com (mail-vs1-f43.google.com [209.85.217.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0B4E3B3C1;
        Tue, 22 Feb 2022 23:45:00 -0800 (PST)
Received: by mail-vs1-f43.google.com with SMTP id j3so2211614vsi.7;
        Tue, 22 Feb 2022 23:45:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=C/cH9gtm/EgKMGw1picw/GL+xptyIrrQueUFFxgTrv0=;
        b=uv5vEcb8pj6necklh2wMSc5HN+7iG5YQ9j0ZJvYOUdZ3qo00PZYyJQq0Q05M1OvInG
         45c/K31LmBhbpLHHnw8KMd8R3nztqSB1ivYlaaWNW2EBFRRN8aWfpLOUzFU9jbPufZzZ
         tvF1bqiYvh2AO3CzPihFlO1vH7I2rtlV1h9GX4zjCJXT+Gdshw2Vmm08zHhq5te26ZCR
         /iP7aJyEAx9iEHQtyhrb9tXgiBsRkM37FzSNcnQTDB9ZgJycbIh74mg89tUb0itqHyCe
         duqJP8gkpAxDnD/ny2HtqHUNVC6HB8C6seMmyahjOEwOm3KEuw6fAA85sYDiTE9qt9hy
         9CGA==
X-Gm-Message-State: AOAM533+gXXdRnh+vhNObaka6jzxSVkwaUqCVWlTjr99a2gbCLzQ08EU
        qZyaaDhnGbY4crapbx1s1HoWzynq2DK2+Q==
X-Google-Smtp-Source: ABdhPJxjuOme72bHaZGAif45cxC6WMI7nYRWNvJ6lO5PhT5nPo9aQB6gYholneGl9/aUNRS59G+0pQ==
X-Received: by 2002:a67:e0cf:0:b0:31a:6079:cabf with SMTP id m15-20020a67e0cf000000b0031a6079cabfmr11130799vsl.39.1645602299581;
        Tue, 22 Feb 2022 23:44:59 -0800 (PST)
Received: from mail-vk1-f177.google.com (mail-vk1-f177.google.com. [209.85.221.177])
        by smtp.gmail.com with ESMTPSA id g13sm605051vsj.5.2022.02.22.23.44.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Feb 2022 23:44:59 -0800 (PST)
Received: by mail-vk1-f177.google.com with SMTP id l10so11801564vki.9;
        Tue, 22 Feb 2022 23:44:58 -0800 (PST)
X-Received: by 2002:a05:6122:130c:b0:330:e674:ec91 with SMTP id
 e12-20020a056122130c00b00330e674ec91mr11363499vkp.33.1645602298671; Tue, 22
 Feb 2022 23:44:58 -0800 (PST)
MIME-Version: 1.0
References: <1644890386-65119-1-git-send-email-wangqing@vivo.com>
In-Reply-To: <1644890386-65119-1-git-send-email-wangqing@vivo.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 23 Feb 2022 08:44:47 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUjyUmdDxqeyh=XnFhyKg1pm_y3DHsWXEb-vKQa-CNrRg@mail.gmail.com>
Message-ID: <CAMuHMdUjyUmdDxqeyh=XnFhyKg1pm_y3DHsWXEb-vKQa-CNrRg@mail.gmail.com>
Subject: Re: [PATCH] spi: add missing pci_dev_put() before return
To:     Qing Wang <wangqing@vivo.com>
Cc:     Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Mark Brown <broonie@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-spi <linux-spi@vger.kernel.org>,
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

Hi Qing,

On Tue, Feb 15, 2022 at 3:08 AM Qing Wang <wangqing@vivo.com> wrote:
> From: Wang Qing <wangqing@vivo.com>
>
> pci_get_slot() increases its reference count, the caller must
> decrement the reference count by calling pci_dev_put()
>
> Signed-off-by: Wang Qing <wangqing@vivo.com>

Thanks for your patch!

Please use "spi: spi-topcliff-pch:" instead of just "spi:" in the patch
summary, as this is specific to the spi-topcliff-pch driver, not to the SPI
core.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
