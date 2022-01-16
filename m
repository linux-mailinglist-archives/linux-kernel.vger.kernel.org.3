Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53DC948FC7E
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jan 2022 13:07:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235013AbiAPMHK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Jan 2022 07:07:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232954AbiAPMHJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jan 2022 07:07:09 -0500
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DAECC06161C
        for <linux-kernel@vger.kernel.org>; Sun, 16 Jan 2022 04:07:08 -0800 (PST)
Received: by mail-ot1-x331.google.com with SMTP id t4-20020a05683022e400b00591aaf48277so16163106otc.13
        for <linux-kernel@vger.kernel.org>; Sun, 16 Jan 2022 04:07:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7o2yHBJnbdgBA14paBxnQ07Miq57N45X/orHzH3UYOU=;
        b=LO+72frJu+DNTvMhQZVhuGanlYhZPe4ZG9J8lwuaPGnb79xbpLy/Fvdo2kesOn2Rin
         81WFCPtwZYnCHbTZ10vA+fp0fAnIOnKvjqHTM1RIwCnAYgPrWt115M8kwke52A+BXuYV
         uMTdvQEQN6pZwYYZm868xk/PtYzlm1Xx2Rp0wmtwoqhDIkt55Ajp9GMn0zNQzzHYfGlc
         uw9mWbRYRj3rk1by15iR97Mf+OIdaDL8uj0P+igWbFmgei7VgSzWLKFmL9gGtEwkcKRa
         jZftuMKhTo8GqhPWPr8C/t/bUIXmOH8plS1PFfhuJERBOgEnUzpX8dAWVweJUg5iILN+
         gVDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7o2yHBJnbdgBA14paBxnQ07Miq57N45X/orHzH3UYOU=;
        b=GkqqLRQWzM8IaRcQDx4pjBqDnAydDAdGuxtG9K9sXp97ysVDPeHLNJE4Lfac04+RSh
         vlqCnBRkuQFF2or8UMe7870LS7bdRns4RDcgKZDYrBNRHSBf0/RLwWCoENYDwim5sxxk
         ZbOG2l5fJudFf/W8oDynWRa8PC/RRBIxxAGHGa+gAEitj8vhhmAtyd1hG7jBzTNxn6Kz
         DCEk+uDCVrXXmi6TafkMNcUNFJ+j+nWVNAaUQCDMnJoIQcCey37o9uLdi3IK0nutAty6
         F4uMZBfoN9MEFIBuAGSJoj2Ufq0tU8TEEgpQJwvkIHYJVmPptt+4WszU3i2eXZGgXoe1
         G8Xw==
X-Gm-Message-State: AOAM532+jxjXesHCShMfgSC+qCEIdLb+icWKO4QS9xT2nzJWGsJ4n0X6
        BUDkMRuGjbsI+7G9EHVSGzg1ydPceKX8K7RxQNtyfw==
X-Google-Smtp-Source: ABdhPJzC7R5kASQ5N7DSNlI11orcz/x4ZKwts91l8N+wYwPvWdzadkjEJzbCp6IPTu6rcJ59GjTIw6RyJwvdn/ooapY=
X-Received: by 2002:a9d:465:: with SMTP id 92mr12890735otc.35.1642334827966;
 Sun, 16 Jan 2022 04:07:07 -0800 (PST)
MIME-Version: 1.0
References: <20220114064821.20200-1-linmq006@gmail.com>
In-Reply-To: <20220114064821.20200-1-linmq006@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sun, 16 Jan 2022 13:06:56 +0100
Message-ID: <CACRpkdaKYwse8NhKVgKi5y7xykEtB+UrL-cGo70mV9Q23K372A@mail.gmail.com>
Subject: Re: [PATCH] gpio: mpc8xxx: Fix IRQ check in mpc8xxx_probe
To:     Miaoqian Lin <linmq006@gmail.com>
Cc:     Bartosz Golaszewski <brgl@bgdev.pl>, Ran Wang <ran.wang_1@nxp.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 14, 2022 at 7:48 AM Miaoqian Lin <linmq006@gmail.com> wrote:

> platform_get_irq() returns negative error number instead 0 on failure.
> And the doc of platform_get_irq() provides a usage example:
>
>     int irq = platform_get_irq(pdev, 0);
>     if (irq < 0)
>         return irq;
>
> Fix the check of return value to catch errors correctly.
>
> Fixes: 76c47d1449fc ("gpio: mpc8xxx: Add ACPI support")
> Signed-off-by: Miaoqian Lin <linmq006@gmail.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
