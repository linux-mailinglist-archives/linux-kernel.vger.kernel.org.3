Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7565E4BC3BE
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Feb 2022 01:52:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230323AbiBSAwW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 19:52:22 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:53798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233440AbiBSAwU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 19:52:20 -0500
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE15C277917
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 16:51:59 -0800 (PST)
Received: by mail-yb1-xb2f.google.com with SMTP id v186so22785247ybg.1
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 16:51:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZERxTao1EUuWMzzDi/vYHpo3Twkxo1kAiV8NaUj/Hjg=;
        b=r5YZjxy29l5GyV8+/lg7Tblm7F6aI7BnhzN6YZzVb79MPcrfm9vcxLvQx4zaE5QnRp
         Z1clkJ0Mn7TTKxuWQOY2x0nxuU8jU8GbgDdd/qoupbAmm7+60oUKpvnAFkVlVHgyqQGo
         uEaDNsyeC537T3TQBg76uIVnpAP6L8IUPYBXYuCEqE5N8SrL3hJO2ZCyOhXUXfmIx+D6
         K1mswYo31TsafAmSExGxh/Z1cd8IphItDu56mVo7rKTiJGluah7F7MFTeZfkfyJg/n+m
         K3IVoOQU5Nt88t7SxXaWMl6botVLxImkEdOG9BPQ4JMX1pl8xVhYnN7Da4mDlk99B6rx
         Kgog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZERxTao1EUuWMzzDi/vYHpo3Twkxo1kAiV8NaUj/Hjg=;
        b=inHC5RDt7BinLHGPlqPgP5Al4SWVOenJjMSASRP3kPAfd9BylK4ik8W3SrZpj1LQzd
         4XM9mLYPQ/bm16jhu378UN3EZTtzndu9eQ+ueI9x3QwSs/A+aYcoeBqc+K9iLxgmmDsX
         Iciy/7u+gEEL5kQWL0i179elf7GA+VR5jVy9qe/ZfVkIH9YarzPUe4ov78+akCVI22Gi
         6fY9CFHUbx+u0GIiT+B+zEFZguCyfEu331h7mQanZnl9JhxnYiS3SODtmTGI2hdEw5e7
         EwxXHUntexDQvV0ofb8Ndas9nLSWjiKYJPwTzCKP/lYMYTHrCdFrFb6vPDTPHBzrat1W
         Aa5w==
X-Gm-Message-State: AOAM533Ii0Hpy/6xizFb01vMCIO3WiAethrUwkxFy7j492HeABpaCWU0
        3hGOigFIRDku1W49MZxnPxKna4blL+l5cuRRQv40M3P9ZKc+BA==
X-Google-Smtp-Source: ABdhPJx5dbUyAJKdwCW0sPfFT+zNXctXTnBkdYKjhauaCWRvBT3/pRZOXBeCXlWylmC796XDwPuRQTTHcDBb7uSWY3U=
X-Received: by 2002:a25:bb91:0:b0:5ff:d80:b567 with SMTP id
 y17-20020a25bb91000000b005ff0d80b567mr10100855ybg.514.1645231919125; Fri, 18
 Feb 2022 16:51:59 -0800 (PST)
MIME-Version: 1.0
References: <20220211093904.1112679-1-maz@kernel.org>
In-Reply-To: <20220211093904.1112679-1-maz@kernel.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sat, 19 Feb 2022 01:51:48 +0100
Message-ID: <CACRpkdb0OPqNZRbJH9EtQhVCgcfGD1EuGtEPucOGhxR+tEPr8g@mail.gmail.com>
Subject: Re: [PATCH] gpio: tegra186: Fix chip_data type confusion
To:     Marc Zyngier <maz@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        kernel-team@android.com, Thierry Reding <treding@nvidia.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
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

On Fri, Feb 11, 2022 at 10:39 AM Marc Zyngier <maz@kernel.org> wrote:

> The tegra186 GPIO driver makes the assumption that the pointer
> returned by irq_data_get_irq_chip_data() is a pointer to a
> tegra_gpio structure. Unfortunately, it is actually a pointer
> to the inner gpio_chip structure, as mandated by the gpiolib
> infrastructure. Nice try.
>
> The saving grace is that the gpio_chip is the first member of
> tegra_gpio, so the bug has gone undetected since... forever.
>
> Fix it by performing a container_of() on the pointer. This results
> in no additional code, and makes it possible to understand how
> the whole thing works.
>
> Fixes: 5b2b135a87fc ("gpio: Add Tegra186 support")
> Signed-off-by: Marc Zyngier <maz@kernel.org>
> Cc: Thierry Reding <treding@nvidia.com>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Patch applied for fixes.

Yours,
Linus Walleij
