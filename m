Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8AB6448FF11
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jan 2022 22:20:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236200AbiAPVUZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Jan 2022 16:20:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233648AbiAPVUY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jan 2022 16:20:24 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9024CC061574;
        Sun, 16 Jan 2022 13:20:24 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id b13so57573366edn.0;
        Sun, 16 Jan 2022 13:20:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DRiJJW5J1NAHIamIgu45FBXj6yPaLLqVuF4cJ61TNAI=;
        b=Iedm3IE1Xq5ZDUyUX7qADQ4nHWY4NwtL2cldv7BzSLGDghdD1x4Ee037Ta0DX8ty3J
         bxxHUHb0uRAiyvOERw/p9aUjqJEjguSyo0m90aGMiyUzmfmkqjREUDZ7wKThpr5ubjoR
         Xn07a1LhDtCnBzJrO16COdzXna3AkvrKN8VLVivK3YbNRVxsw6VILuEVWn/gGVm/BlRx
         sUAPOrhEeVFgDd0hZyxmcjzeX8vrf0IJ9b3LZ6uqCVs21lVRY7LX2ppWs5Q/VickN85b
         3Hp4JKcV/7pjO0ci8hc7jPFoqdJMtA/4wCAa6HUnSKH0jGEDLBI1j3eHEKmxT8axhbUk
         Puow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DRiJJW5J1NAHIamIgu45FBXj6yPaLLqVuF4cJ61TNAI=;
        b=L8FMM0t0+7wxbtz+Oazm/0TtEuqLYA/M0VYNlNT9w6OZg6vQRJhVvVSgFTdA4NlnCQ
         00uwIGUJ4ul11PgBjqV/PcF0t1Jrj+89YbnR7o7IQBRbILM38n8niSrjLLfujCskbgs9
         8Gk7afDSE0ELIW/ho0b2/81R98tCndknUCPsxc+aH/uKTXaXLs1Xf0YoqN1+2+lKgDEy
         9bDsXNvq1fiwukJGI6oJUxtZCtAdt7sX3wZcG91DoGopi9Tcn9eWb32qJ/IwVqafMm3K
         Ax8TCGiuG0go1vkR0oLtAFTUie+GCUq2yC97r2aRu6oaAxYxOPztgC6pV18Xm7g9jrmF
         3+Sg==
X-Gm-Message-State: AOAM531AqYuppQW6jJpa+kym0Adm/WvFJZTLvvYVeQ7qMR+wt8cQ+P5q
        5lskEJ9wRqBNVyBQbLY0xcZrBxnf0AQWIBwlff0=
X-Google-Smtp-Source: ABdhPJxjjxuL45i3Yxcp4FQsg6mq5M7qMc/oOWMRXma7+utQwuIJMj3UDrjifgfN/7B1gCugvc7YHSMbI/XFeN+rty0=
X-Received: by 2002:a05:6402:34cb:: with SMTP id w11mr17507571edc.158.1642368023095;
 Sun, 16 Jan 2022 13:20:23 -0800 (PST)
MIME-Version: 1.0
References: <tencent_949564FE01410898F3734D38FA284CC2E909@qq.com>
In-Reply-To: <tencent_949564FE01410898F3734D38FA284CC2E909@qq.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sun, 16 Jan 2022 23:19:46 +0200
Message-ID: <CAHp75VfxsBN4E3aeME8HKWtjuOPC2meuJ4hweOcXf-te5kotYg@mail.gmail.com>
Subject: Re: [PATCH] gpio: merrifield: check the return value of devm_kstrdup()
To:     xkernel.wang@foxmail.com
Cc:     Andy Shevchenko <andy@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 16, 2022 at 10:21 AM <xkernel.wang@foxmail.com> wrote:
>
> From: Xiaoke Wang <xkernel.wang@foxmail.com>
>
> devm_kstrdup() returns pointer to allocated string on success,
> NULL on failure. So it is better to check the return value of it.

Before if devm_kstrdup() fails, the GPIO driver will be registered
without pin control, now it will fail the registration.

It's not that I'm against the patch (the above is quite unlikely and
brings a not fully working system on most of the known platforms with
this SoC), but you need to do better your analysis. That said, please
rethink a bit the commit message you put there and send an updated
version.


-- 
With Best Regards,
Andy Shevchenko
