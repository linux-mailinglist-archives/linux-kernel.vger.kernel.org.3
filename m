Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B43DF47F50B
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Dec 2021 04:32:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231206AbhLZDcH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Dec 2021 22:32:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230289AbhLZDcG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Dec 2021 22:32:06 -0500
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62F8DC061401
        for <linux-kernel@vger.kernel.org>; Sat, 25 Dec 2021 19:32:06 -0800 (PST)
Received: by mail-oi1-x233.google.com with SMTP id j124so19780014oih.12
        for <linux-kernel@vger.kernel.org>; Sat, 25 Dec 2021 19:32:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cpSRXjM9kG2rU64CnT289qDrVGElfeL1DhdrYlGUgWM=;
        b=OIgHtYo7xHRxiQHgjF8+g+ssHpKYVV3glYf/4biLu+pBoJZVXQRO41a1wulGtCYX23
         40rNim4t7pR4nNL3Ggy9o8x9SN70RiXEPBmpVbDe5XWVl2bVsCenHuPEeBcq9/Msh9Io
         WJ46G15+nWiEWw5blyy+IIqxyJ1LTwjJJYfE3P1d/DmNqreyALmMyMmTJOTbU4FiOfv6
         4ebTDJidXnz9wzK7wzgZR8gFbibfbu1kgO+y9ISVrXhrVlb83OAi7xtTIwzfRBzzg3bV
         Rj9/4ybRYwc07g43h9g6/erSq6yd3IimAhjjWidNZP7Swe9dgrEp3lLdEhEAozYqCVI/
         3tag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cpSRXjM9kG2rU64CnT289qDrVGElfeL1DhdrYlGUgWM=;
        b=Ai6VrIDM/ZcQ3TBY4oGJwEiQ9tflsKh4ouGPFHXpWT1DPkHu9kFgX0LCp9lKwuzmmX
         X7LuLK+V0A/JZCl/wU6xE1K6Xhv8AKHaHRMHAOtm9+bn7gMTxvb7KNRFYFgQ7zzfIbva
         XFkd+0FsUQRxWygRjMrtld4wTs6FlorNw1bIdi5jZQDJciom2wx8GoeKmWZ8ELCd/7j7
         q0OrVog0TPfeq+TDruAiZq+8+jY6NqIC/57C478YKbTtcfwbl7HDiJEWey89CdJfi281
         FUtUvBhoQqQa7e6MduBI6UJx6GFgkpyuMjENlVIZoCQhf631cgSzeFsG0x0qlYvqrWL5
         rNLw==
X-Gm-Message-State: AOAM530oCHvz8pq9v5ZvFEdKI0zJ6650rXvdwor44fBKzVrNKAzh3hPw
        oXjtcI2DPU/zlBcg3yp4aNX7H5PijAjhtTnnxvmF0vbLshg=
X-Google-Smtp-Source: ABdhPJztUoEc1TdEZzCer3ftmiWpd8yh9ma4NkStZRL5zzrUlGrViIzx7eFQAZGqibuH/KPkcT9EBY8sWyRpqa0V6RI=
X-Received: by 2002:aca:120f:: with SMTP id 15mr9083937ois.132.1640489525295;
 Sat, 25 Dec 2021 19:32:05 -0800 (PST)
MIME-Version: 1.0
References: <20211224192545.74528-1-david@ixit.cz>
In-Reply-To: <20211224192545.74528-1-david@ixit.cz>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sun, 26 Dec 2021 04:31:54 +0100
Message-ID: <CACRpkdaVTuzza-gJDgeCV5+cpTQUynM9ja5k5WLF9_L=opsn1A@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: mmc: PL18x stop relying on order of dma-names
To:     David Heidelberg <david@ixit.cz>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Thierry Reding <treding@nvidia.com>,
        ~okias/devicetree@lists.sr.ht, Rob Herring <robh@kernel.org>,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 24, 2021 at 8:25 PM David Heidelberg <david@ixit.cz> wrote:

> We don't care in which order are "rx" and "tx" DMA names supplied.
>
> Fixes: 4df297aaeb9c ("dt-bindings: mmc: Add missing properties used in examples")
>
> Signed-off-by: David Heidelberg <david@ixit.cz>

Good catch!
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
