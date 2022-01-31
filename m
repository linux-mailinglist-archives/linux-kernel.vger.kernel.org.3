Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13D9B4A447E
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jan 2022 12:33:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379424AbiAaLaS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 06:30:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378705AbiAaLUh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 06:20:37 -0500
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E9BAC0604FF
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 03:13:30 -0800 (PST)
Received: by mail-yb1-xb34.google.com with SMTP id v186so39370124ybg.1
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 03:13:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=U0Pw1BfqGZvVWUtyLjOHuhJwlMA1Use2yqcwgUkQnwE=;
        b=F/ECo8ebBP3ogDbxQiY4hhui7DC5U/UMWgo9Zxz2mCrE3YKYlRwsn8i6WMbi1ujwL+
         F6RWtT6HBlFzfySG6LZv1PSv0vwGis3HZwYSpSS9Hc29Ez3WcAtHPDp0M0EniYkeFuQP
         vMA+VOZ1Ign8qZkpcj+5tqUlZrYNyhl+lbsyQ3EgkkMF+kIkkfA4B52aHxnb2frXX0a7
         Hf5Jj2Ip5PmM4TVjHH23jDBAmknumfzIEPYA2ny7XV1pVboUBrBGG0Zl6M1/y8c1kbyM
         NyLWqgGFxGTvLnD6/N2khaA9Rqn+cJcUH8dVK5IIzrye3eEHB5fbTpdShnNmFP/AZ8Ef
         Xb5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=U0Pw1BfqGZvVWUtyLjOHuhJwlMA1Use2yqcwgUkQnwE=;
        b=ZB/ULGJzj1c1JDC5/ZuSTh1bM9xRldl6TZ1z3bdAN6ceCQdrMeLKTr+tCfzlbeUaVc
         C0TL4Ds/j0eZrxWCtck2vuxdL8BmSNjJW/tR8L5xutdnRPJ+8AiIWMTi8B6fIKiZbcCb
         no3Rr2QT82yXfKuwicU23+NYJvZ7+XE5PyY2Vl2joeCMDe8Tt9ZO0vrOL75Y7fBEaMv6
         Sggme1Ewds352vRvNnCpUGBILYRLMnfOXWpqcXpIh4wh10WiyNOzDd2DfzEVURqS6DHO
         QCAvJVsqirw5jkdAHNIFOiJhvctg0xxyjk8F4o7Up3ckf/x6GW3VYXzEMRnusxYUS5fh
         VT9w==
X-Gm-Message-State: AOAM532J5Udlrhet/JsuzFTQa6F0rJOC2o8EpbE2jnwj5UGJNpgpnnaI
        chcnlXPydCnBu/zSaEYBktGBtlrqy6EgSaQi7kfAUg==
X-Google-Smtp-Source: ABdhPJwnjcbKcmXqxkDyE6M/D5slJFtoF8e/5OEa0RJfRa4THHqn7fj5ZGK9wLiBaPNsXouP0qEB6ly0WbzNmpDFVXY=
X-Received: by 2002:a25:5143:: with SMTP id f64mr30614251ybb.520.1643627609604;
 Mon, 31 Jan 2022 03:13:29 -0800 (PST)
MIME-Version: 1.0
References: <20220130145116.88406-1-nbd@nbd.name> <20220130145116.88406-13-nbd@nbd.name>
In-Reply-To: <20220130145116.88406-13-nbd@nbd.name>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 31 Jan 2022 12:13:18 +0100
Message-ID: <CACRpkdY38VWT_95jz25NTNtsqzkkVsSONNLswQ35JApT0HUXXQ@mail.gmail.com>
Subject: Re: [PATCH v9 12/13] gpio: Add support for Airoha EN7523 GPIO controller
To:     Felix Fietkau <nbd@nbd.name>, Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     soc@kernel.org, linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, john@phrozen.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 30, 2022 at 3:54 PM Felix Fietkau <nbd@nbd.name> wrote:

> From: John Crispin <john@phrozen.org>
>
> Airoha's GPIO controller on their ARM EN7523 SoCs consists of two banks of 32
> GPIOs. Each instance in DT is for a single bank.
>
> Acked-by: Bartosz Golaszewski <brgl@bgdev.pl>
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> Signed-off-by: John Crispin <john@phrozen.org>
> Signed-off-by: Felix Fietkau <nbd@nbd.name>

This one and patch 11 with the bindings does not seem to have any
build dependencies on the rest of the patches at all.

What about Bartosz just apply these two to the GPIO tree so we
have less stuff to iterate?

Yours,
Linus Walleij
