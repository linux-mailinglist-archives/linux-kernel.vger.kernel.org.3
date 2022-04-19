Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBB94507C42
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 23:58:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358118AbiDSWAx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 18:00:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232898AbiDSWAv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 18:00:51 -0400
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com [IPv6:2607:f8b0:4864:20::112d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D040B40A35
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 14:58:07 -0700 (PDT)
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-2eba37104a2so188313157b3.0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 14:58:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=b0FdhFvoto3cfbTufYpeHPpDSicSfoYk0f7qMia8Bdg=;
        b=zBnm4d3bVKW2b5jnvekPM/eQx3z9hsp5xqRTJPjXSKoWx8tWLqOEJh6KYbJG2wb69H
         p4hmQrXPrxhENGRIm+ntF1+pxpZ4NKRG2Fixd6R6prRK2orJSD+9XNUKjFrlgtrRdebx
         MgnhSvb97qdcRwKYnD3JSdQDYXIPNWyT3PuMkmXZq2eSGoECCqUdBAzywbMwK6WD7kpD
         2iUevzz1mkSflSKQ7deupPU/mMDZ5MvOVa40AFsNnnUc0TznAVIg593TmguN3uGP2GMa
         zzkIEa7e/ZwnUMSQDi0i8hNBkDxnDI1MWnBumLEwD3hQC9a8H7pRkM2HnrkA5lHgsn/n
         9HIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=b0FdhFvoto3cfbTufYpeHPpDSicSfoYk0f7qMia8Bdg=;
        b=CwQaFeNEO2hIhKfI0HPLbE9OSfFN79HubycjS0S0wu6yQKLocdI70QRQc4ZnNtbwu/
         8CnKDwbgRQ9HEHO4+0Z+R5jsxwHS/echBCu4gakYHPB/W4+Y3HMeNeAIK3JmNGG4nIZT
         9W6cu7RVoWhRHCD/h24E2erbY4yWHz1TDT2MQ4lxYC9TE3IQkaIzjjesaiB7/qr2QCcM
         R9CiKo/KXl9yEQ2gASpvRdBjS8CcLOZ71uul6sVuVYce34SJaS/Fe+3wvjWR2tdP/kYp
         cJEcoS2WH8casRo206dE16PTB02k/y9ur2L6tfAd/yCJBya/Qvwc1myHydapK2WjShI0
         EWDg==
X-Gm-Message-State: AOAM533fW2anNPDb6ESg9+zdDm9PQJRDQT6pn3BymP2ixf3W7RdLyY4O
        lbvUhtuArFiUtjP+3P0dQWjUfhkZIUqUFYqGTJE8hg==
X-Google-Smtp-Source: ABdhPJysZSO4rZI8aihXTH5ybXBow3i3c21+5d2zQBcxSPKt0OOZz8Icvk1xE0IDvZ4kpBqlx5RLDjaI/WPO9BTm0xU=
X-Received: by 2002:a0d:ea46:0:b0:2ed:62f4:e23c with SMTP id
 t67-20020a0dea46000000b002ed62f4e23cmr17960656ywe.437.1650405487130; Tue, 19
 Apr 2022 14:58:07 -0700 (PDT)
MIME-Version: 1.0
References: <CAMRc=Meo4TbdxQzynb7paDgC7J19Tc6hhKU7du4mZvgP0mynTQ@mail.gmail.com>
 <20220419012810.88417-1-schspa@gmail.com>
In-Reply-To: <20220419012810.88417-1-schspa@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 19 Apr 2022 23:57:56 +0200
Message-ID: <CACRpkdYcCZ7zZkuVLMGnoqO69mJ5a-hEg2DV8PmzfwgBFzgVKQ@mail.gmail.com>
Subject: Re: [PATCH v3] gpio: use raw spinlock for gpio chip shadowed data
To:     Schspa Shi <schspa@gmail.com>
Cc:     brgl@bgdev.pl, andy.shevchenko@gmail.com, f.fainelli@gmail.com,
        fancer.lancer@gmail.com, hoan@os.amperecomputing.com,
        linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, opendmb@gmail.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 19, 2022 at 3:28 AM Schspa Shi <schspa@gmail.com> wrote:

> In case of PREEMPT_RT, there is a raw_spinlock -> spinlock dependency
> as the lockdep report shows.
>
> __irq_set_handler
>   irq_get_desc_buslock
>     __irq_get_desc_lock
>       raw_spin_lock_irqsave(&desc->lock, *flags);  // raw spinlock get here
>   __irq_do_set_handler
>     mask_ack_irq
>       dwapb_irq_ack
>         spin_lock_irqsave(&gc->bgpio_lock, flags); // sleep able spinlock
>   irq_put_desc_busunlock
>
> Replace with a raw lock to avoid BUGs. This lock is only used to access
> registers, and It's safe to replace with the raw lock without bad
> influence.
>
> [   15.090359][    T1] =============================
> [   15.090365][    T1] [ BUG: Invalid wait context ]
> [   15.090373][    T1] 5.10.59-rt52-00983-g186a6841c682-dirty #3 Not tainted
> [   15.090386][    T1] -----------------------------
> [   15.090392][    T1] swapper/0/1 is trying to lock:
> [   15.090402][    T1] 70ff00018507c188 (&gc->bgpio_lock){....}-{3:3}, at: _raw_spin_lock_irqsave+0x1c/0x28
> [   15.090470][    T1] other info that might help us debug this:
> [   15.090477][    T1] context-{5:5}
> [   15.090485][    T1] 3 locks held by swapper/0/1:
> [   15.090497][    T1]  #0: c2ff0001816de1a0 (&dev->mutex){....}-{4:4}, at: __device_driver_lock+0x98/0x104
> [   15.090553][    T1]  #1: ffff90001485b4b8 (irq_domain_mutex){+.+.}-{4:4}, at: irq_domain_associate+0xbc/0x6d4
> [   15.090606][    T1]  #2: 4bff000185d7a8e0 (lock_class){....}-{2:2}, at: _raw_spin_lock_irqsave+0x1c/0x28
> [   15.090654][    T1] stack backtrace:
> [   15.090661][    T1] CPU: 4 PID: 1 Comm: swapper/0 Not tainted 5.10.59-rt52-00983-g186a6841c682-dirty #3
> [   15.090682][    T1] Hardware name: Horizon Robotics Journey 5 DVB (DT)
> [   15.090692][    T1] Call trace:
> ......
> [   15.090811][    T1]  _raw_spin_lock_irqsave+0x1c/0x28
> [   15.090828][    T1]  dwapb_irq_ack+0xb4/0x300
> [   15.090846][    T1]  __irq_do_set_handler+0x494/0xb2c
> [   15.090864][    T1]  __irq_set_handler+0x74/0x114
> [   15.090881][    T1]  irq_set_chip_and_handler_name+0x44/0x58
> [   15.090900][    T1]  gpiochip_irq_map+0x210/0x644
>
> Signed-off-by: Schspa Shi <schspa@gmail.com>

LGTM
Acked-by: Linus Walleij <linus.walleij@linaro.org>

Mostly hits drivers/gpio so this seems like something Bartosz
should merge.

Yours,
Linus Walleij
