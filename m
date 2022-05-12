Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31BAE525687
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 22:49:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358430AbiELUto (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 16:49:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231206AbiELUtn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 16:49:43 -0400
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62F5A2655E2
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 13:49:42 -0700 (PDT)
Received: by mail-yb1-xb29.google.com with SMTP id w187so11985062ybe.2
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 13:49:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SuMNv1ARZasd7ZdjEVC+rFFOys4tai2c2Cjy+vmZ+Rg=;
        b=Wc+ZaUyrF7+Lum9b/zrSBDjtU8WwSRjvp7fS7DRW9uDdn7o6S9vkJdrv/VCwf6LFyb
         ZqVyz/kvTgfAXi2rUv+dktCrrkhmRAa4w7vMPm7qf8ubfiYsMMserhWw1HWaiXPHBCjf
         cD0IoFusw/289jeZI8EBJzzG5fEo4P8I/J/tmUKu4mDRL9Hvpf1w0DAkuvVWIcJcQ7LD
         +e9gas6K1G3mQFmf9kzsjzogzqhXBryHoDT9mP8HqGbZKg9NmOX47fd5l9aN0NdK6F2+
         +MEbV9H1knHUyoogYU/f1n669aOnrYHlwamz8lUjNcFi/Zf5fI2HZjwWxE67lvrXf6zp
         ijXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SuMNv1ARZasd7ZdjEVC+rFFOys4tai2c2Cjy+vmZ+Rg=;
        b=AOXtG0x6XqzUDedqXTfesxDu/WtVmcsvzgdM2z9AvTbvYv8ApzODMdve5SX28S0VYu
         wa0bWB324A1vF88e2FH8IAeQSHNQDYB7mWzt4K/QzDRt66qpvAVAOhZ7mfNZLTArv139
         iDqr27SNG4roN40VwLJNGC6thUKx7u+ypRvzPcy4oyGhUrqeYlPTn2TWQBGoPJ+6Ixel
         QM/dvYLn25k2dZObSWHLAOHXD/IG4lCc4w1MXA036m0s/AfwLdJex8nZ/DJh1TBaXoIO
         1jQ8adaMb9gq0tjJsyBzxfMv+RgXb+0cf2UuuwrRC1ZLI5Y1D++HVpz9BZx4nmrXvM3g
         bIxQ==
X-Gm-Message-State: AOAM533eNesruok3+SBdN9fzfC3HLXFj4dvGGP5UCK1aTg0le+bSoVHd
        a9BCf+36uv3LCgP7ltsvw/JEtAe1R1x/aM7X23KzphJTJvXk7Q==
X-Google-Smtp-Source: ABdhPJzbJHrpl2ZjZyfdf9tv0Ul/Hdcqw61DhVZaNWxXI5E+3FgGj/H/IcgMvO6msrXJyErlJRaAXgVdQAwABrv+xFw=
X-Received: by 2002:a25:aa94:0:b0:648:62f2:ef4e with SMTP id
 t20-20020a25aa94000000b0064862f2ef4emr1592662ybi.626.1652388581682; Thu, 12
 May 2022 13:49:41 -0700 (PDT)
MIME-Version: 1.0
References: <20220506022845.26750-1-puyou.lu@gmail.com>
In-Reply-To: <20220506022845.26750-1-puyou.lu@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 12 May 2022 22:49:30 +0200
Message-ID: <CACRpkdbVP4HL3UO9mfbRWCxfJ5e1v8PBm5sqfpCNXwcbaq=O5w@mail.gmail.com>
Subject: Re: [PATCH] lib/string_helpers: add allocated strarray to device resource.
To:     Puyou Lu <puyou.lu@gmail.com>, Tejun Heo <tj@kernel.org>
Cc:     Andy Shevchenko <andy@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Petr Mladek <pmladek@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Chris Down <chris@chrisdown.name>, linux-kernel@vger.kernel.org
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

On Fri, May 6, 2022 at 4:28 AM Puyou Lu <puyou.lu@gmail.com> wrote:

> This is a must to automatically release strarray when the device
> disappears.
>
> Signed-off-by: Puyou Lu <puyou.lu@gmail.com>

Looks correct to me.
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

(But really Tejun is the one who knows how devres is supposed
to be used, added on To: line)

Yours,
Linus Walleij
