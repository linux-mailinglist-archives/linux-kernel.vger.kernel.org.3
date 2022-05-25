Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82188533785
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 09:39:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243911AbiEYHjK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 03:39:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231130AbiEYHjH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 03:39:07 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC7AB72210
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 00:39:04 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id u23so34663235lfc.1
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 00:39:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OhxVZ2LgCynbOv8tKdPmgIQ5QMN9FYlxj9ofmtk1cEQ=;
        b=BusphhT/woejAOYPCsjC+kFvsur8tfYlVNmICYZFvWjI2nRwkSo8dt8ksra7q0NOd2
         F2XoPdCK71Sh63oMTdXJbgH0vex0srZ8GZooJbuL4QE6F6H686ITPspK63oA7f41An96
         aJNXt5laS0Q3uVRyflNR3xDFnkazok0tLDnIuXiPdemGsB9ZgFi2AQ60awsp910pXJKa
         cG5zDUXTf0gS3fCH1iO7nQb9tyTJTiwWUcWT16xS8L9KFEq6eiQ0xYe50/QVxQKKEvpD
         jgrzabue50suQigiUrKmOJIKGi3kqjLTR0kQb8biOfhSE895j9dFOwB6vwqNoUxgOPN2
         +3IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OhxVZ2LgCynbOv8tKdPmgIQ5QMN9FYlxj9ofmtk1cEQ=;
        b=LzXlx+P89L1uljCODOjA9wK/5SanzUtvx0Z7GBDuFtGGJNe+4DuNFAdjZw77RdPDNN
         a30kvF7EpmfTWbOgX8Kl+s6N/DtokX3D2S/l6pLdNbJo4sxd0E0k11cAXJpG1PWEhapZ
         VoAD7LjrSCLVFPfZE4Jfxhw+DPMyUiSWBZgoDX2IZ9xYzRv4ObaMRvh66jFxyDgZSec0
         mHJ9k99Qst9uANcsGnDUZMoiClDV1/gn+RG7PpMeGHBS/bWXvQlFiwfJEohGihhOxCBC
         Gr5T+HlRlA7hzf7S3yzvqxW5bc1The1Hex2QLi88sDlt53/25U98zyre07dg1bCh+6pW
         lpLw==
X-Gm-Message-State: AOAM530nTIMqsFiYNIiBdETbNME7Uj0h2UmlRG5KLn30YmCnitEN2LFq
        4B1cfCmyVDXmUPUdoY8vyOtyCnjXbrgwrIuot3Wd6A==
X-Google-Smtp-Source: ABdhPJz23Uln5bDGjeo+lBSYUJgYAKBLIPMwtjZvY1/UtzgpzGOOdu8QqyJN2S4UocIDBPV/zlcKmA5xIoUCnqJsaUo=
X-Received: by 2002:a05:6512:16aa:b0:443:bf59:5a4d with SMTP id
 bu42-20020a05651216aa00b00443bf595a4dmr22852562lfb.622.1653464343312; Wed, 25
 May 2022 00:39:03 -0700 (PDT)
MIME-Version: 1.0
References: <20220524142206.18833-1-marcan@marcan.st>
In-Reply-To: <20220524142206.18833-1-marcan@marcan.st>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 25 May 2022 09:38:51 +0200
Message-ID: <CACRpkdZX19VaEy64-64UNWafM-wF_=h9w8Qiq4xFFhsa6sahaQ@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: apple: Use a raw spinlock for the regmap
To:     Hector Martin <marcan@marcan.st>
Cc:     Sven Peter <sven@svenpeter.dev>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Marc Zyngier <maz@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, asahi@lists.linux.dev
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

On Tue, May 24, 2022 at 4:22 PM Hector Martin <marcan@marcan.st> wrote:

> The irqchip ops are called with a raw spinlock held, so the subsequent
> regmap usage cannot use a plain spinlock.
>
> spi-hid-apple-of spi0.0: spihid_apple_of_probe:74
>
> =============================
> [ BUG: Invalid wait context ]
> 5.18.0-asahi-00176-g0fa3ab03bdea #1337 Not tainted
> -----------------------------
> kworker/u20:3/86 is trying to lock:
> ffff8000166b5018 (pinctrl_apple_gpio:462:(&regmap_config)->lock){....}-{3:3}, at: regmap_lock_spinlock+0x18/0x30
> other info that might help us debug this:
> context-{5:5}
> 7 locks held by kworker/u20:3/86:
>  #0: ffff800017725d48 ((wq_completion)events_unbound){+.+.}-{0:0}, at: process_one_work+0x1c8/0x670
>  #1: ffff80001e33bdd0 (deferred_probe_work){+.+.}-{0:0}, at: process_one_work+0x1c8/0x670
>  #2: ffff800017d629a0 (&dev->mutex){....}-{4:4}, at: __device_attach+0x30/0x17c
>  #3: ffff80002414e618 (&ctlr->add_lock){+.+.}-{4:4}, at: spi_add_device+0x40/0x80
>  #4: ffff800024116990 (&dev->mutex){....}-{4:4}, at: __device_attach+0x30/0x17c
>  #5: ffff800022d4be58 (request_class){+.+.}-{4:4}, at: __setup_irq+0xa8/0x720
>  #6: ffff800022d4bcc8 (lock_class){....}-{2:2}, at: __setup_irq+0xcc/0x720
>
> Fixes: a0f160ffcb83 ("pinctrl: add pinctrl/GPIO driver for Apple SoCs")
> Signed-off-by: Hector Martin <marcan@marcan.st>

Patch applied!

Yours,
Linus Walleij
