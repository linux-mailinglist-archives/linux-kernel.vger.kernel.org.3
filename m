Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04E80496F58
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jan 2022 02:01:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232782AbiAWBBP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Jan 2022 20:01:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231594AbiAWBBP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jan 2022 20:01:15 -0500
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE69AC06173D
        for <linux-kernel@vger.kernel.org>; Sat, 22 Jan 2022 17:01:14 -0800 (PST)
Received: by mail-yb1-xb31.google.com with SMTP id c10so39469516ybb.2
        for <linux-kernel@vger.kernel.org>; Sat, 22 Jan 2022 17:01:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fvjIHzoYjX2wrs+EpzMBjfsTjarifS+awxMyAGX77+c=;
        b=icZbSbAmMydOl2Lfh9/+QWimtCNVaKajeqB22HdXuG20nsP2qvlOHr0ZXqR12bQaRa
         6THaCHTNdTiILsj8W2oMq/Gajn+J+3je19fwojwy376TurxKHscJ66fabnlY7GQPFwu+
         IZdvBgTYHcw/UtGA8KuXyQis0rqVaXd3WWc+o5mkISfA3Gq+XYX98RNhE3H0XZD86FyT
         YhJcecRRdsqF4lc0d+33JV+kjrK0yenicrpHodrZ1DSmZ3JKR+cv5O/DPJHwx/Tp8vJT
         eYSYRuQGocZtmIrJ0kP9s3y+V+atWqx//BqvWTVrK44h0mX1rZtOo+qetBXVR5Kr8mQh
         Ul7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fvjIHzoYjX2wrs+EpzMBjfsTjarifS+awxMyAGX77+c=;
        b=DoVnpQVZdpyv2aQD9fYtyjP8O/mudZIHrHkmIwXPMdW+8IO2BKmsE1IODLUwgEnSju
         LH0tnlLnmjZTSlswzPmuWfimTaSlk/cpur2tldWbjIERFLmDy92KpkzqcWrR0eMPRqpz
         T38rPBqyDdBI86YiGGZ11Irvtf+UVzlWVtaguEi1cZmfXqfbuXVxBvz8XoRSGsETeGe4
         KN7xOcFHGamQm2zsdR/kXgK6eE4RRYFaf8b+YOGJ6LkUpIguXS92vxtoA3qubT9gt97x
         uhNwxnblMVsUZC4u3CwUYGlqhPiDDpKeBffsG8VX7J/CWlYcZVmSMnPSgYKv4wz/wBVc
         GVSg==
X-Gm-Message-State: AOAM532CCk5cLAg4mvmhC4Ja99WfsleYR6V4NZiYS8E1ANkHNU3dBIxh
        Gly7WoXKYh3ukBaEkFn1jiqAKM4h7mTJYk7wPgi3ng==
X-Google-Smtp-Source: ABdhPJzcFq5FLHHPy0k5FGDVTqtTPkpyeCAFkkn4StwSpMeNSwCm9BWFgXu2HHWL0bNrGeGZBGZz0ZkoFoFwPwCYmjA=
X-Received: by 2002:a25:8e89:: with SMTP id q9mr16586053ybl.520.1642899673159;
 Sat, 22 Jan 2022 17:01:13 -0800 (PST)
MIME-Version: 1.0
References: <20220120104654.3467-1-linmq006@gmail.com>
In-Reply-To: <20220120104654.3467-1-linmq006@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sun, 23 Jan 2022 02:01:01 +0100
Message-ID: <CACRpkdbKyg3wAqvbCH0nm4uOByr2P14=iabOcXTAvz85qgdYiw@mail.gmail.com>
Subject: Re: [PATCH] power: gemini-poweroff: Fix IRQ check in gemini_poweroff_probe
To:     Miaoqian Lin <linmq006@gmail.com>
Cc:     Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 20, 2022 at 11:47 AM Miaoqian Lin <linmq006@gmail.com> wrote:

> platform_get_irq() returns negative error number instead 0 on failure.
> And the doc of platform_get_irq() provides a usage example:
>
>     int irq = platform_get_irq(pdev, 0);
>     if (irq < 0)
>         return irq;
>
> Fix the check of return value to catch errors correctly.
>
> Fixes: f7a388d6cd1c ("power: reset: Add a driver for the Gemini poweroff")
> Signed-off-by: Miaoqian Lin <linmq006@gmail.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
