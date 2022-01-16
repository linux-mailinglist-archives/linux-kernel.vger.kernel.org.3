Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1E3148FC84
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jan 2022 13:08:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235038AbiAPMI0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Jan 2022 07:08:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235031AbiAPMIY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jan 2022 07:08:24 -0500
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 966D2C061574
        for <linux-kernel@vger.kernel.org>; Sun, 16 Jan 2022 04:08:24 -0800 (PST)
Received: by mail-ot1-x32c.google.com with SMTP id a12-20020a0568301dcc00b005919e149b4cso16184553otj.8
        for <linux-kernel@vger.kernel.org>; Sun, 16 Jan 2022 04:08:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=g0ejI+v9kTjOBRp5hp1TQV/Duaiql3D8eEQKfIRKX3k=;
        b=QzyM8HM/9pPFc3Jt/terXNWjGC/FCIiDoRyGCgZ9GxVJg+GtqL92dk7aEkM8l9DXmj
         O7knAUpO43nsRvNbjHRMiWczHCO4hP45URmNFSr1Evx1eMMe5egqoicrg0h4MxgcmR2Z
         ShHMNPDfNdCzanCeSqOrdiUJDMB8O9XtTL145OHU07BC81yP0tZ8wfRdq0T58AVUaNmn
         +oOIeEJPqC+lKHX2VyHZ8sDv8AODtH9Y8T3YBvlfM9wq7ZY1LRhpHg1Dll11p3Fe9rqm
         2O2jeSaTv9Qqn3MFz7h+e6ezTc9lq0PO5C+zSCj4NJCPQqw0Q+q4NWhZtD79kR7LjXDC
         DFQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=g0ejI+v9kTjOBRp5hp1TQV/Duaiql3D8eEQKfIRKX3k=;
        b=OKfLd3fzSmluRX+PwrYGnltRm4WBEXzrvsVxpjWsUPzsy7sXKPRSx9C5G9V7t9B/ZY
         nxnqCs9QpJ86VECHxCR7IGAl8O+LDq7tWqUZGXDRf4ObUkW0ROkWgL3Da5Zru5mdPrSI
         tMEwzvFiETXehpeEJxW0WKkSzuaCp6I33TcmZJG85BlD9Hk8qV2bAXiO3jplkoSeEkmz
         vBEXO8BYEIK7O6j6er/kHZFiVMYZMNgIetkSw4FZQxZOUnnYurl7kfk2O7M9r7iusJ4J
         q7d+0JM2OWYEVf8p2t+AitvhxGMIEE+QAmbvRn6MOp7l2z901XDa1Olv7zxm+RFsAQg8
         dN0A==
X-Gm-Message-State: AOAM532yzKa2EJENY28DDFZOmT0CLLrH0bJ0pw++nleoK3OWSG6q/e7G
        hKDAglpjVE9waydJnwKjMH/dWZnwRCkvx8n8IdqOlA==
X-Google-Smtp-Source: ABdhPJwE/JKUz/NIWWHXVnP7rvIIEYNpbeOV4FcshRq4dIqaDpKIHgt5IKI8YmjRhvSXtZUwmYtUOlUeCeECPt4rnDQ=
X-Received: by 2002:a9d:465:: with SMTP id 92mr12893701otc.35.1642334903987;
 Sun, 16 Jan 2022 04:08:23 -0800 (PST)
MIME-Version: 1.0
References: <20220114065949.24126-1-linmq006@gmail.com>
In-Reply-To: <20220114065949.24126-1-linmq006@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sun, 16 Jan 2022 13:08:12 +0100
Message-ID: <CACRpkdYrRv2aSL=7DbS5uMUKPq=wE354vs4Hky2iGvaMgo7_9g@mail.gmail.com>
Subject: Re: [PATCH] mfd: ipaq-micro: Fix IRQ check in micro_probe
To:     Miaoqian Lin <linmq006@gmail.com>
Cc:     Lee Jones <lee.jones@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alessandro Gardich <gremlin@gremlin.it>,
        Dmitry Artamonow <mad_soft@inbox.ru>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 14, 2022 at 7:59 AM Miaoqian Lin <linmq006@gmail.com> wrote:

> platform_get_irq() returns negative error number instead 0 on failure.
> And the doc of platform_get_irq() provides a usage example:
>
>     int irq = platform_get_irq(pdev, 0);
>     if (irq < 0)
>         return irq;
>
> Fix the check of return value to catch errors correctly.
>
> Fixes: dcc21cc09e3c ("mfd: Add driver for Atmel Microcontroller on iPaq h3xxx")
> Signed-off-by: Miaoqian Lin <linmq006@gmail.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
